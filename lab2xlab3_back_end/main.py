import os
from flask import Flask, request, jsonify
import firebase_admin
from firebase_admin import credentials, messaging
from datetime import datetime, timedelta
from apscheduler.schedulers.background import BackgroundScheduler
import pytz

base_dir = os.path.dirname(os.path.abspath(__file__))
cred_path = os.path.join(base_dir, "service-account-key.json")
cred = credentials.Certificate(cred_path)
firebase_admin.initialize_app(cred)

app = Flask(__name__)
scheduler = BackgroundScheduler(daemon=True)

timezone = pytz.timezone('Europe/Skopje')

@app.route('/schedule-notification', methods=['POST'])
def schedule_notification():
    try:
        data = request.json
        token = data.get('token')
        title = data.get('title')
        body = data.get('body')
        time_str = data.get('time')

        if not token or not title or not body or not time_str:
            return jsonify({"error": "Missing token, title, body or time"}), 400
        
        now = datetime.now(timezone)
        user_time = datetime.strptime(time_str, '%H:%M')  # Parse without timezone
        user_time = timezone.localize(
            user_time.replace(year=now.year, month=now.month, day=now.day)
        )

        print("Current time:", now)
        print("Parsed user time:", user_time)

        if user_time < now:
            user_time += timedelta(days=1)

        print("Scheduled time after adjustment:", user_time)

        scheduler.add_job(
            send_notification, 
            'date', 
            run_date=user_time,
            args=[token, title, body]
        )

        return jsonify({"success": True, "scheduled_time": user_time.strftime('%Y-%m-%d %H:%M:%S')}), 200

    except Exception as e:
        return jsonify({"error": str(e)}), 500


def send_notification(token, title, body):
    """Send push notification via Firebase."""
    try:
        message = messaging.Message(
            notification=messaging.Notification(
                title=title,
                body=body,
            ),
            token=token,
        )

        response = messaging.send(message)
        print(f"Notification sent successfully: {response}")

    except Exception as e:
        print(f"Failed to send notification: {e}")


if __name__ == '__main__':
    scheduler.start()
    
    app.run(host='0.0.0.0', port=5000, debug=True)
