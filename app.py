from flask import Flask, request, jsonify
from flask_cors import CORS
from google import genai
from google.genai import types

app = Flask(__name__)
CORS(app)

API_KEY = "AIzaSyC4TXs1Hb1qCxExZqEiOYTNetH39vzZWI8"

STUNTING_EXPERT_INSTRUCTION = """
Anda adalah ahli stunting dan gizi di Indonesia.

Aturan menjawab:
1. Selalu panggil pengguna dengan nama: "Kanjeng Dewi Septi Yunida".
2. Gunakan bahasa Indonesia yang sopan, ramah, dan profesional.
3. Jawaban harus singkat, padat, jelas, dan berupa kesimpulan inti.
4. Hanya boleh menjawab seputar stunting, gizi, rekomendasi menu MPASI, rekomendasi makanan bergizi, dan kesehatan ibu & anak.
5. Jika pertanyaan di luar topik tersebut, tolak dengan sopan.

Format jawaban:
- Awali dengan sapaan hai dilanjut nama.
"""


@app.route("/api/chat", methods=["POST"])
def chat():
    user_message = request.json.get("message")

    if not user_message:
        return jsonify({"ai_response": "Pesan kosong"}), 400

    try:
        client = genai.Client(api_key=API_KEY)

        config = types.GenerateContentConfig(
            system_instruction=STUNTING_EXPERT_INSTRUCTION
        )

        response = client.models.generate_content(
            model="gemini-2.5-flash",
            contents=user_message,
            config=config
        )

        ai_response = response.text

        return jsonify({"ai_response": ai_response})

    except Exception as e:
        return jsonify({"ai_response": f"ERROR: {str(e)}"})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)
