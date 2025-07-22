Return-Path: <linux-iio+bounces-21887-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F842B0E666
	for <lists+linux-iio@lfdr.de>; Wed, 23 Jul 2025 00:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13F1B1C823D1
	for <lists+linux-iio@lfdr.de>; Tue, 22 Jul 2025 22:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C712882D2;
	Tue, 22 Jul 2025 22:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="A7aguzbv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945E527D781
	for <linux-iio@vger.kernel.org>; Tue, 22 Jul 2025 22:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753223212; cv=none; b=LGM+Uv/8I5ko0MFnEkEs/gYNdGwJBlCmaax6uETGUPhSt3jFHLXELsNCAzipqaK7jxderqbwS18okqJup7J/ZwOmJtIyF2u4sD5XftdHg5SU8EgExvzDuf6WyegCJ07R2Dj0YJayirwy8SHCFld6P9CZC0VGmNKSfhWWjAXY8g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753223212; c=relaxed/simple;
	bh=3JxSszfdgBizgbGSj7j2367+f+CT0wMP5JvnTtrM+80=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IEjU8iRwDQvEbv/J9orlurseaL43o++frQKPAmV2rWgBecdG599sfKTgf54JhHon70wTXmdJqZhja8BtzUa29DBqr/9FfILEpXvbkDHoFwB/JDX8LJOVltr1WQskQ2HVvNvlVI3rJVTPKxgtC0QxUhoVxschVaxsKyo8ATBhijI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=A7aguzbv; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2ffb85aed35so4466757fac.0
        for <linux-iio@vger.kernel.org>; Tue, 22 Jul 2025 15:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753223208; x=1753828008; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wl9uCiEPYb0dk6dwx2DBRmP+ooFR/EVgBh5TsoekfCw=;
        b=A7aguzbvk3qkEau3guklx8kz3Z0G7uJTHbuDhr3SIw2aB7NVK2iGxKyD2DNhOHsWdZ
         bpsy+j91RyBIsH2gDSlqNLVF8sgmZZ0JIBtLj/PZWVHOU3ZPPq7boh5AfTkoQrY0bn+f
         +Ir+qzeRyGAfvngeUib1EuGJ+iUozuIIzcmBdEx7Lp5LqWC9h2bBBPJSFMca4sES4wl+
         lyjUfHSuSdX5lb2v8y2VybQGIjIDL2wIeiJ2Kec8ELIPUjtJGwWHPZ9itCfJUyYQucFF
         s51knsbX+pCdVLqyNMmVufmnAyE5wjLzizF4B5+cu9DVzvC8c519U1rHz7WJ3xwhlAzv
         gk6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753223208; x=1753828008;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wl9uCiEPYb0dk6dwx2DBRmP+ooFR/EVgBh5TsoekfCw=;
        b=hCuiYffVxmLS3ypbEIq4vA1w/HVgCnZzwSlcr2xuI4mf1ByqYz90MKH1p7DfXz130B
         CwM97zNqGCNjJrD/DmJWOCxrKm/lefynvCxYCtxFETrphCpUg/K/dFRJR8pbYOglx1aT
         7IwiHmiPf4BOUroSKaKnah6igicKAaPUpNZRWF7PlGORyV02JqN0xLaYOKgcoxkSRPki
         oavyMR7Jsztj/HtHjmsZwXxOgHEE1X4bLvFB8wj+QWgQFbLh8VmYtzode98QgaLRuL5a
         au3Z+xcSLzsWSEuZSFftFoF+CGYGaRk1sTG7yeaTU6nc+9w+AZvP6ow742SxHVIlQ6En
         pSLw==
X-Gm-Message-State: AOJu0YzQLXMPXLZaecViNw9agRGw98FS++xsK7ohOKEcmalU3T9ErIbs
	1vRzEE6/4UgM/NxdG0lVVcCJo86Me0rXdWpCqUb0QjPUoZ18jCMetARYcWyqMW13P4E=
X-Gm-Gg: ASbGncu9cPduCWWSx91QbA2vO+hakqmSoegqLwPyFgw+ei/lJIOZxm8iq5WnD6nX170
	p8glaIydEK4sxwNUyqhXy2ZcvyZ2o5PrwS4LfoaYx9ZEfAHB1xgZEExTn6sJxv/6vYyll92FV90
	gunGgvaf2sfJosoc9/u+2S+9RLcuT658QNhYYQf5SoUoXN4nxUa9QyjL46Xtk/VcYnKQKx52vTJ
	O8BLi2FQTvOEN/DRkFF7aNbk1a513HbEyC2+rQ684QgOck13LpIPSJMQQmqQcRjEyhjgkpMO4dw
	n0biIgi7EteBlu7rcfc6oVUb63WA7Y3YnzE9Il+3O8X9CBvORKoe3JTtdeXVff9gCC/X4fJRVm2
	aoZeBr10hfRI20Lj6wH47CXGLZt+Qp00TEqgstg==
X-Google-Smtp-Source: AGHT+IFchWVonXIx1xEma5zfKeuw2x5O6/Vxo+agU6ytSi5QAZEFaV+9qvqXPcQg/RWnitbEDdS68Q==
X-Received: by 2002:a05:6870:4192:b0:2d5:2955:aa5c with SMTP id 586e51a60fabf-306c6b08c62mr608193fac.0.1753223208584;
        Tue, 22 Jul 2025 15:26:48 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:11dd:c0f5:968d:e96])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3010220f3b5sm4770013fac.19.2025.07.22.15.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 15:26:48 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 22 Jul 2025 17:26:39 -0500
Subject: [PATCH] iio: proximity: vl53l0x-i2c: use stack allocated scan
 struct
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250722-iio-proximity-vl53l0x-i2c-use-stack-allocated-scan-struct-v1-1-42f127a6834f@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAB4QgGgC/x2NQQrCMBAAv1L27EKMFKlfEQ/bzUYXY1KStERK/
 27wOHOY2aFIVilwG3bIsmnRFDucTwPwi+JTUF1nsMaO5motqiZccmr60frFLYyXYBqqZVyLYKn
 Eb6QQElMVh4UpdplXruh5YvI8s58c9P6SxWv7v++P4/gBv4DlyYsAAAA=
X-Change-ID: 20250722-iio-proximity-vl53l0x-i2c-use-stack-allocated-scan-struct-fc9cafcbcf9d
To: Song Qiang <songqiang1304521@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1946; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=3JxSszfdgBizgbGSj7j2367+f+CT0wMP5JvnTtrM+80=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBogBAgMkgumqzvYJuleiShEiGkSTDto+s21oLhH
 eVhQmXCEqmJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaIAQIAAKCRDCzCAB/wGP
 wFUqB/9ZyJ2rwvh+Z5wUP49GEG3em4UbXkBKKlr4ZqJkCKmnoDyMIi0OoFSxOExverXb3FigmP1
 w06VCOewHH8XqqgfoZ0Yo0o6ZLf3ig2ryirr3PQ3w7V4fbV1dVXCPG/ZIDE08H8IUbhRpPM2bPO
 iUDaXNNOyE9Z+2aXuJnF5SphrjNQjujPxuHbbavK362IjoLltNMOcUUwAOlE5B0pKgY7eIMoEMD
 E0m8EntuWowJtPFY3t2uOgCXPYd2mNfPiLXgSuWP5riWM7yopJfoBQH0InILtTPLGsLIznP64hh
 8Y2ugCPhlGBVENfTAg5vLvGGWm0cl1WHB2FlTkyxVRsVRm1r
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use a stack allocated struct for the scan data instead of using the
driver state to store the struct. The scan data is not used outside of
the interrupt handler function so the struct does not need to exist
outside of that scope.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/proximity/vl53l0x-i2c.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/vl53l0x-i2c.c
index ef4aa7b2835e3c9e177f3e03b24a141ac45c3825..b4d82f24be296c37e9243167b463bf96368e8ec4 100644
--- a/drivers/iio/proximity/vl53l0x-i2c.c
+++ b/drivers/iio/proximity/vl53l0x-i2c.c
@@ -57,11 +57,6 @@ struct vl53l0x_data {
 	struct regulator *vdd_supply;
 	struct gpio_desc *reset_gpio;
 	struct iio_trigger *trig;
-
-	struct {
-		u16 chan;
-		aligned_s64 timestamp;
-	} scan;
 };
 
 static int vl53l0x_clear_irq(struct vl53l0x_data *data)
@@ -84,6 +79,10 @@ static irqreturn_t vl53l0x_trigger_handler(int irq, void *priv)
 	struct vl53l0x_data *data = iio_priv(indio_dev);
 	u8 buffer[12];
 	int ret;
+	struct {
+		u16 chan;
+		aligned_s64 timestamp;
+	} scan = { };
 
 	ret = i2c_smbus_read_i2c_block_data(data->client,
 					VL_REG_RESULT_RANGE_STATUS,
@@ -93,8 +92,8 @@ static irqreturn_t vl53l0x_trigger_handler(int irq, void *priv)
 	else if (ret != 12)
 		return -EREMOTEIO;
 
-	data->scan.chan = get_unaligned_be16(&buffer[10]);
-	iio_push_to_buffers_with_ts(indio_dev, &data->scan, sizeof(data->scan),
+	scan.chan = get_unaligned_be16(&buffer[10]);
+	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
 				    iio_get_time_ns(indio_dev));
 
 	iio_trigger_notify_done(indio_dev->trig);

---
base-commit: cd2731444ee4e35db76f4fb587f12d327eec5446
change-id: 20250722-iio-proximity-vl53l0x-i2c-use-stack-allocated-scan-struct-fc9cafcbcf9d

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


