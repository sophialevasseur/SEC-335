import asyncio
from aiosmtpd.controller import Controller
from email import message_from_bytes
import os

SAVE_DIR = "/home/champuser/Desktop/smtp_exfil/"
os.makedirs(SAVE_DIR, exist_ok=True)

class AttachmentHandler:
    async def handle_DATA(self, server, session, envelope):
        msg = message_from_bytes(envelope.content)
        for part in msg.walk():
            if part.get_content_disposition() == 'attachment':
                filename = part.get_filename()
                data = part.get_payload(decode=True)
                filepath = os.path.join(SAVE_DIR, filename)
                with open(filepath, 'wb') as f:
                    f.write(data)
                print(f"Saved: {filepath} ({len(data)} bytes)")
        return '250 OK'

controller = Controller(AttachmentHandler(), hostname='0.0.0.0', port=25)
controller.start()
print(f"SMTP server running, saving to {SAVE_DIR}")
input("Press Enter to stop...\n")
controller.stop()
