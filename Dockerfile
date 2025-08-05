# Don't Remove Credit @VJ_Botz
# Subscribe YouTube Channel For Amazing Bot @Tech_VJ
# Ask Doubt on telegram @KingVJ01

FROM python:3.10.8-slim-buster

# ওয়ার্কিং ডিরেক্টরি সেট করা হচ্ছে
WORKDIR /FileToLink

# Debian Buster-এর মেয়াদোত্তীর্ণ রিপোজিটরি সমস্যার সমাধান এবং প্রয়োজনীয় প্যাকেজ ইনস্টল করা
# apt কমান্ডগুলোকে একসাথে রাখলে ইমেজের লেয়ার কমে এবং বিল্ড দ্রুত হয়
RUN sed -i 's|deb.debian.org|archive.debian.org|g' /etc/apt/sources.list && \
    sed -i 's|security.debian.org|archive.debian.org|g' /etc/apt/sources.list && \
    sed -i '/buster-updates/d' /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends git && \
    apt-get upgrade -y && \
    rm -rf /var/lib/apt/lists/*

# requirements.txt ফাইলটি প্রথমে কপি করা হচ্ছে যাতে ডকার ক্যাশিং সুবিধা ব্যবহার করা যায়
COPY requirements.txt .

# পাইথন প্যাকেজ ইনস্টল করা হচ্ছে
RUN pip3 install -U pip && \
    pip3 install -U -r requirements.txt

# বাকি অ্যাপ্লিকেশন কোড কপি করা হচ্ছে
COPY . .

# অ্যাপ্লিকেশন চালু করার জন্য কমান্ড
CMD ["python", "bot.py"]
