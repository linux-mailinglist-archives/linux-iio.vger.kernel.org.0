Return-Path: <linux-iio+bounces-12274-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 288649C95DA
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2024 00:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC7FE2816D6
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 23:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E8F1B6CEC;
	Thu, 14 Nov 2024 23:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lTK8mM01"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3568D1B4F08;
	Thu, 14 Nov 2024 23:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731625824; cv=none; b=F/MWeTHnYgNXCwqTcN9ExUqN0UaPkxZhQrYk/0nJmXn6VESrGlhiTnepWm/Lhm4DeVoYo+vAtnJOv9niodcjeR1AMCvxKiS66ufRY4sdlSBXyD+x26ep8ZBGlG/SsCPXWhR4mkXGRT3reDRMbzxgcOyQBJkIuRSWFTX7u/A1ooA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731625824; c=relaxed/simple;
	bh=gHYu12Rw5/dkV3YGL2sO3N01Roy+URU34yCpf9G7WpU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eKKJnc1LSM4sDzSeVo1P7jv39cTR5mcJCdG/l3m7wkXJPjXpE8eSw1kFJtwvKm24tCYF83OFnZvx5xHQmjL+oOlNfeTueGWySp/qt/HxsDdzkSmmSDxHl2k2avjSCJT5MuV4/s2yitLiVpX+BeryJzStjmSmcBS8LunN/2wIvgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lTK8mM01; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-432d796a57eso1407575e9.1;
        Thu, 14 Nov 2024 15:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731625820; x=1732230620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O5DVuhpbt65Tb2WFhtaXDExhTn0sEn63wQnWqfaY7lM=;
        b=lTK8mM01kc1cYTwGpDNtfsMB1D5Vio/Qn/URQmchASlXafybKrdYUNs6Pds67MUmsO
         iTTNe7Br2HUTGxHMGLVVirYM6u3wNNkOwfYa2m6I4FpASO3cTcVY5WbVaQt2JihaDrdm
         KQgi1CHmB8HyZKcXMh1sv6xgR+CYuj0HRZtkCufCZTO++hqf7WESm5N+oUxgxHBlaPYT
         jjU7juN+y0HmU0v9Y6YGSi27q1IdBUqQ+4V1JO6rnfeJp+IbhUw0rBXXaZp/NJUk+K54
         DTxUPC8P9H6D66vIPW+d3B7/6ygl6SXZY6N/x9PW8D3QuD6n/JMjmoM0hGVI0pv+4kBN
         HYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731625820; x=1732230620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O5DVuhpbt65Tb2WFhtaXDExhTn0sEn63wQnWqfaY7lM=;
        b=U8aYR/cVy7oD5pJ37I8y2Kehy/pPyOmgZ2tUvKJYFgKHoBft5C2Lg8bWO1VcJqxJGS
         qC5922AvfkAL3n7nvazTGupOh5/7t5qhc9ieUYI8/P+1XeCsg26XhOdLOvaamJFD+WE6
         jLwqPerVvECeB0jY5I1mvs/psJCR7E5xq/BFTKYADoS7gzoNOGuOVfaMtzZsgSoUjXHP
         LlSIOZ/QWlv6buxdUo5YhS0w5QjJTm3mcNhqF9o7mTy4LXY4ki38iGcLOOZoltrDoAM+
         BK2bjGzMNV4T6X9NUQikoUnKirtqgJPRFm2Re818ovu2PN3k/jyHT3HrOJDmMAe65aWc
         WnHw==
X-Forwarded-Encrypted: i=1; AJvYcCUfsNLduakWt4V9aPmzpknjFihFXEubuMbkBU0HRL/ZZSVzvf8JjdkpOTX8DFDMtt39oSik15obQjlS4NKn@vger.kernel.org, AJvYcCXhFBmvTkkXp+V/Vjpb0meRMKu+8ubZdW0/28+/auRAB1fuZ+DXVoQuuNP//4OVyoOA481gNBbDE78=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye+UM7XGbHYXwMTr0W8NagOMhZV7uZpm4XpZUPag90iKhSTmop
	7bru9MqvWXo68ELXW3LHagc/H3b4WXPn4KTgQ+tz/xfIt3yNLVBPswZBSg2J
X-Google-Smtp-Source: AGHT+IGnLpyW7H9Y1VJWXggAltSHjuIV49gVf56bMpwC75H0RQx3h7POr/4wUCoo2fWL/AswOiZ8hA==
X-Received: by 2002:a05:600c:5250:b0:42c:c0d8:bf34 with SMTP id 5b1f17b1804b1-432df679bfdmr1778515e9.0.1731625820340;
        Thu, 14 Nov 2024 15:10:20 -0800 (PST)
Received: from 5dfbf0f66296.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab789fasm36464265e9.18.2024.11.14.15.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 15:10:20 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: l.rubusch@gmx.ch,
	Lothar Rubusch <l.rubusch@gmail.com>
Subject: [PATCH 06/22] iio: accel: adxl345: add function to switch measuring
Date: Thu, 14 Nov 2024 23:09:46 +0000
Message-Id: <20241114231002.98595-7-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241114231002.98595-1-l.rubusch@gmail.com>
References: <20241114231002.98595-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the powerup / powerdown functions by a generic function to put
the sensor in STANDBY, or MEASURE mode. This is needed for several
features of the accelerometer. It allows to change e.g. FIFO settings.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 51 ++++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 926e397678..bcec3a8e05 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -138,6 +138,37 @@ static int adxl345_write_raw_get_fmt(struct iio_dev *indio_dev,
 	}
 }
 
+/**
+ * For lowest power operation, standby mode can be used. In standby mode,
+ * current consumption is supposed to be reduced to 0.1uA (typical). In this
+ * mode no measurements are made. Placing the device into standby mode
+ * preserves the contents of FIFO.
+ *
+ * Unloading the driver puts the device in standby mode (measuring off).
+ *
+ * @st: The device data.
+ * @en: Enable measurements, else standby mode.
+ */
+static int adxl345_set_measure_en(struct adxl34x_state *st, bool en)
+{
+	unsigned int val = 0;
+	int ret;
+
+	val = (en) ? ADXL345_POWER_CTL_MEASURE : ADXL345_POWER_CTL_STANDBY;
+	ret = regmap_write(st->regmap, ADXL345_REG_POWER_CTL, val);
+	if (ret)
+		return -EINVAL;
+
+	return 0;
+}
+
+static void adxl345_powerdown(void *ptr)
+{
+	struct adxl34x_state *st = ptr;
+
+	adxl345_set_measure_en(st, false);
+}
+
 static IIO_CONST_ATTR_SAMP_FREQ_AVAIL(
 "0.09765625 0.1953125 0.390625 0.78125 1.5625 3.125 6.25 12.5 25 50 100 200 400 800 1600 3200"
 );
@@ -158,16 +189,6 @@ static const struct iio_info adxl345_info = {
 	.write_raw_get_fmt	= adxl345_write_raw_get_fmt,
 };
 
-static int adxl345_powerup(void *regmap)
-{
-	return regmap_write(regmap, ADXL345_REG_POWER_CTL, ADXL345_POWER_CTL_MEASURE);
-}
-
-static void adxl345_powerdown(void *regmap)
-{
-	regmap_write(regmap, ADXL345_REG_POWER_CTL, ADXL345_POWER_CTL_STANDBY);
-}
-
 /**
  * adxl345_core_probe() - probe and setup for the adxl345 accelerometer,
  *                        also covers the adxl375 and adxl346 accelerometer
@@ -242,14 +263,12 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 		return dev_err_probe(dev, -ENODEV, "Invalid device ID: %x, expected %x\n",
 				     regval, ADXL345_DEVID);
 
-	/* Enable measurement mode */
-	ret = adxl345_powerup(st->regmap);
+	ret = devm_add_action_or_reset(dev, adxl345_powerdown, st);
 	if (ret < 0)
-		return dev_err_probe(dev, ret, "Failed to enable measurement mode\n");
+		return dev_err_probe(dev, ret, "Failed to add action or reset\n");
 
-	ret = devm_add_action_or_reset(dev, adxl345_powerdown, st->regmap);
-	if (ret < 0)
-		return ret;
+	/* Enable measurement mode */
+	adxl345_set_measure_en(st, true);
 
 	return devm_iio_device_register(dev, indio_dev);
 }
-- 
2.39.2


