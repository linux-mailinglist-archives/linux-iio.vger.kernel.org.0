Return-Path: <linux-iio+bounces-16754-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A25EA5E94C
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 02:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63CC217B734
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 01:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290F815747D;
	Thu, 13 Mar 2025 01:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NUnd6KRE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308E91487D1
	for <linux-iio@vger.kernel.org>; Thu, 13 Mar 2025 01:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741828582; cv=none; b=UdMcihx0y+lYwoTNOXRkIJZYB5ANk1k4JkLMpCeFD3HNnmHDEBnKX7T7h8cvufeRmzhr4Wkv+iQqJti73PkxeBgeBNh9kpDxly6qQ0SfO04qlYKI7NNc5nsIq1aZUKRVQnbj+bNWDoCZZqbDvbN6qLIhEFAmfqnjvBZEion8Prw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741828582; c=relaxed/simple;
	bh=qKZSuCxtl9tcxt4Po5/CTXwnjx7p7qGopCKUQxtAESY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kmnWQK5urvry7WEHO6cd6rnF22A/hlnAKe3sSEtxqOBk6fWHC1diO1WJgrzm07m9/7y6EkzlREHfeHe2T20HA6RjWmGuxwWV4kCK+YF8Mlg65p43NDylW1UZGkGBc9haGpZqC96biIu1lcQkvwOxN263xUO5SRrBPMZmGIsBC8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NUnd6KRE; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6003d977ab7so227765eaf.2
        for <linux-iio@vger.kernel.org>; Wed, 12 Mar 2025 18:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741828580; x=1742433380; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ub2dM3/RGcj9mA3V9E27MSFaOISaFpTMgcXwRQUXdos=;
        b=NUnd6KRE+9LTLjD8SBWE88QRucwaR91oclHuPilTjDeAPebOQ+LuhzWbemq7yc5DB3
         qWOHai8Hpg7fXzShlozL8ddW9F+f+Btn98yT4pBPu0MfForXqaeP9wzGeVRB4RuMopIN
         DeESgcwTBEX46EEH0fJkLAvZ65qYytExLTzQ+YLDPlc8ffs/RpTFHQJ0NH2+i6VKA47P
         7xQ4aNzwhJPtGRmFQ6OwXVuY7xrGzFVTOjaQRk0e5GYurUpfbo+f+U7sBCpSz+DWr27U
         R3mqro0cN3wELT7dRTqBxxwon7ogg5MsJfJoEuv/2JrD/+UXu9xy7A6YwP2p84TdZEMn
         0bmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741828580; x=1742433380;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ub2dM3/RGcj9mA3V9E27MSFaOISaFpTMgcXwRQUXdos=;
        b=SbPfhwov4rGDeje3POMI9iWvQA+SqB6Jnw9Pto60nb5lW30b+qlNp9AZS/imEYdSf0
         3nt4M1uWZpHNcTbdKCTLQl9cI+QrldzlROEAS5kYwGqOPBGy8C8e5x+tnOjLHzkuvavG
         7MnliwcmGS68KRLupP/MQpA03DiwI3/gesNELpLxWGg2proQq2PhB3NO4gs/tG7EmMIK
         kY//vpfcbfSJSZ2ZzHaTRsfyDviNNDu487nKtd8Om7Pz+wxao0bKYadbE8BUxFgL5rs5
         OsFDhleOrVx9UznfABm0ZNtQ0DJc8Yc3TiX0kxTAnaUC8y6DvOzKbw2xe4MQNpdHu7IT
         MeKg==
X-Forwarded-Encrypted: i=1; AJvYcCUIwMpJ1YGWOJIWy0v7FhIYAPPZ+kxlADbGE3pJLqJqtoeh12Pw32GoFVE+jJvTtmeha2x3xbggHHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAnugsLJ7oORU/ZsP2Q6hYbhBXMexnCmSwknnv3xIKkOvSlcT0
	6NpSpRlnzNSktPj1jFicFGrrlANBqWX7YpXZ0/ShymksQv8JDvUlaYsCr8ewNoMY0skG0vTEyjA
	q3wQ=
X-Gm-Gg: ASbGncsffVa7HTlwr14pWc+TYz3+ay+Y6VEpO6MFErqXZOcCP8cqb6mmyzQpfuCcFFz
	THA0jHS36Kmgp133L8rU3ZOJxK8zBQaCZrZmd5k7PE/f7tilk5TGXEZ0YranuEuhGu9MV80tC+w
	Vja48S1mPGiHhYwKjIVxsayNjb+inqKQWcDs9T2xFKXQCYxnkX3QGNZYzYYaHkb6TgPFpgK9juR
	kc4lsPeE32NRFLHXxQkeE/J+kyEW8S9w6WbAFO/PA5oys5UCJpB2m3ng9IQJ0srLXSBo4n/iASD
	bdIUZnaKgGRvjYM9k2yBs+9HeJTu+5+4Wr7uTVPdXZJAACYTGxuq5DfB/92OxyFkiDp+y2vNHgk
	x
X-Google-Smtp-Source: AGHT+IHDd7tqJOjGEcZgrq1YXhswYd1QsJBlWzqCWhPa2Kg7pTKfG0tSIHEabd4fj4R6v/meEWMubA==
X-Received: by 2002:a05:6820:8c6:b0:5fc:b7f4:c013 with SMTP id 006d021491bc7-6004ab16543mr9939642eaf.5.1741828580173;
        Wed, 12 Mar 2025 18:16:20 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-601db659ad8sm39865eaf.8.2025.03.12.18.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 18:16:19 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 12 Mar 2025 20:15:42 -0500
Subject: [PATCH 04/11] iio: adc: ad7606: add missing max sample rates
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-iio-adc-ad7606-improvements-v1-4-d1ec04847aea@baylibre.com>
References: <20250312-iio-adc-ad7606-improvements-v1-0-d1ec04847aea@baylibre.com>
In-Reply-To: <20250312-iio-adc-ad7606-improvements-v1-0-d1ec04847aea@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Angelo Dureghello <adureghello@baylibre.com>, 
 Alexandru Ardelean <aardelean@baylibre.com>, 
 Beniamin Bia <beniamin.bia@analog.com>, 
 Stefan Popa <stefan.popa@analog.com>, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3398; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=qKZSuCxtl9tcxt4Po5/CTXwnjx7p7qGopCKUQxtAESY=;
 b=owEBgwJ8/ZANAwAKAR+K+IyC93wDAcsmYgBn0jHazYHJnK5YXUo98qA+IVLMwIcGE6xWiHGYY
 VJHFvQv3eOJAkkEAAEKADMWIQSKc9gqah9QmQfzc4gfiviMgvd8AwUCZ9Ix2hUcZGF2aWRAbGVj
 aG5vbG9neS5jb20ACgkQH4r4jIL3fAMMIQ/+NuXu3Jy7/vklUjpso0z/7/z9RaSOHwBnj/hBkhZ
 qP/3dO/VUEguGsxUYlQIG+8b0ojamy1+NdXN42XrV8tKrPln3LfduqUKxPCo1yCb/JgGtI/vWhf
 S/KQFAQ4fNf9dy1s9CIU9i734cl9DvKItDbLeK+PtX7uWnGL0lqOtLbGTbZ66vGVVmb9jFZnzcK
 aYpuJCCvn8LB+FqORXaradJwPltRzdaHTN4PzVeUC+qOO5e1KC3EsOCxaHls23oX29gvQE33L2M
 9KjDYlmZXN2CtBcPkYxvP1Lnd42l7gTtCRZavVqB22wL/bmpE51VrEZ1xZNys1Ucdo5Mao+fb1G
 WGHnLMzFVJp7Iq8VwiFxEOw1DdV7XUfXYEDeRQHLex7QvB85KkBHX8NOy+A9ouUJ7dmjoAxcYGC
 ndV8os3vh9hCfBAq4iNrl4DcIDQqXbIciIxcrem2Bgvq8Pc4gjNqAALgjWCGFmxduKe6jO2kY+8
 0V6yeqb57gqsXL5AQZC0+qKjH0XdXZe5hBLD2xnlSxRhtRF2cTaUVetKtRBPeMz6REzTN26sR+4
 32i3FhNVY+N04fX00q2F0Du7c4998fhZYhhtgGp1j36Oc3OaWK/waEPEh57LBB7lUR+DzbCleMB
 r7S1UJb6ixLR4t4vYY3tfSs0ERg+KnqWQXjzerpMBJ8I=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add max sample rates for all of the chips. Previously, only one chip had
this field populated.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 79929bd24fa40bccfcdd88673107da4bf56e032b..440e1e5a9b18570dc6441bff91afbc51d20cbc47 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -196,6 +196,7 @@ static int ad7616_sw_mode_setup(struct iio_dev *indio_dev);
 static int ad7606b_sw_mode_setup(struct iio_dev *indio_dev);
 
 const struct ad7606_chip_info ad7605_4_info = {
+	.max_samplerate = 300 * KILO,
 	.channels = ad7605_channels,
 	.name = "ad7605-4",
 	.num_adc_channels = 4,
@@ -205,6 +206,7 @@ const struct ad7606_chip_info ad7605_4_info = {
 EXPORT_SYMBOL_NS_GPL(ad7605_4_info, "IIO_AD7606");
 
 const struct ad7606_chip_info ad7606_8_info = {
+	.max_samplerate = 200 * KILO,
 	.channels = ad7606_channels_16bit,
 	.name = "ad7606-8",
 	.num_adc_channels = 8,
@@ -216,6 +218,7 @@ const struct ad7606_chip_info ad7606_8_info = {
 EXPORT_SYMBOL_NS_GPL(ad7606_8_info, "IIO_AD7606");
 
 const struct ad7606_chip_info ad7606_6_info = {
+	.max_samplerate = 200 * KILO,
 	.channels = ad7606_channels_16bit,
 	.name = "ad7606-6",
 	.num_adc_channels = 6,
@@ -227,6 +230,7 @@ const struct ad7606_chip_info ad7606_6_info = {
 EXPORT_SYMBOL_NS_GPL(ad7606_6_info, "IIO_AD7606");
 
 const struct ad7606_chip_info ad7606_4_info = {
+	.max_samplerate = 200 * KILO,
 	.channels = ad7606_channels_16bit,
 	.name = "ad7606-4",
 	.num_adc_channels = 4,
@@ -251,6 +255,7 @@ const struct ad7606_chip_info ad7606b_info = {
 EXPORT_SYMBOL_NS_GPL(ad7606b_info, "IIO_AD7606");
 
 const struct ad7606_chip_info ad7606c_16_info = {
+	.max_samplerate = 1 * MEGA,
 	.channels = ad7606_channels_16bit,
 	.name = "ad7606c16",
 	.num_adc_channels = 8,
@@ -263,6 +268,7 @@ const struct ad7606_chip_info ad7606c_16_info = {
 EXPORT_SYMBOL_NS_GPL(ad7606c_16_info, "IIO_AD7606");
 
 const struct ad7606_chip_info ad7607_info = {
+	.max_samplerate = 200 * KILO,
 	.channels = ad7607_channels,
 	.name = "ad7607",
 	.num_adc_channels = 8,
@@ -274,6 +280,7 @@ const struct ad7606_chip_info ad7607_info = {
 EXPORT_SYMBOL_NS_GPL(ad7607_info, "IIO_AD7606");
 
 const struct ad7606_chip_info ad7608_info = {
+	.max_samplerate = 200 * KILO,
 	.channels = ad7608_channels,
 	.name = "ad7608",
 	.num_adc_channels = 8,
@@ -285,6 +292,7 @@ const struct ad7606_chip_info ad7608_info = {
 EXPORT_SYMBOL_NS_GPL(ad7608_info, "IIO_AD7606");
 
 const struct ad7606_chip_info ad7609_info = {
+	.max_samplerate = 200 * KILO,
 	.channels = ad7608_channels,
 	.name = "ad7609",
 	.num_adc_channels = 8,
@@ -296,6 +304,7 @@ const struct ad7606_chip_info ad7609_info = {
 EXPORT_SYMBOL_NS_GPL(ad7609_info, "IIO_AD7606");
 
 const struct ad7606_chip_info ad7606c_18_info = {
+	.max_samplerate = 1 * MEGA,
 	.channels = ad7606_channels_18bit,
 	.name = "ad7606c18",
 	.num_adc_channels = 8,
@@ -308,6 +317,7 @@ const struct ad7606_chip_info ad7606c_18_info = {
 EXPORT_SYMBOL_NS_GPL(ad7606c_18_info, "IIO_AD7606");
 
 const struct ad7606_chip_info ad7616_info = {
+	.max_samplerate = 1 * MEGA,
 	.channels = ad7616_channels,
 	.init_delay_ms = 15,
 	.name = "ad7616",

-- 
2.43.0


