Return-Path: <linux-iio+bounces-22665-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04755B24A9A
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 15:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C7561BC5BE0
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 13:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCF52E9ECB;
	Wed, 13 Aug 2025 13:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUQOG3+x"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC8E7261D;
	Wed, 13 Aug 2025 13:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755091829; cv=none; b=s5/53qiDMyxi/vzNWFoN1R+QKGaLvPSPGNeyycW4IUuFarmdv3h3aVweggXt8G3PI/fKDUEM0J7H8UdAMkjOk0fvI2ibmMbo9dweAWgV8d2BrJy/LaPSl3nO82N+pxaVF4ua/MWfjHU4QyGPUZjyDlO6Jdw/WXwthm5Pm3nvDBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755091829; c=relaxed/simple;
	bh=cdC1kU050XZYG6yYqPd0nKe35lD8lzMHtJqtN2qN8VI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fga1T9GuNjzLDpL+NQFSnTklV4IHDvZNvciyODCkX8NMrZe7CM/pAv1JlLKsR9tHckxnS1gAQwG4Rx2B1Zn3K9mX/te726+Fp/F29/GWuF505c8MhFL4h0M76Y7kRpdHaOLUV6WpRTc/OlEB82ZQlNQ5J6BQ+CJcJTnYaKWINP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MUQOG3+x; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b47083da7baso515931a12.1;
        Wed, 13 Aug 2025 06:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755091827; x=1755696627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NnnCQkJJgePWl09KuitQpQyTSvHR1c9B+DMmCu5TKeo=;
        b=MUQOG3+xVtjmTM6+ZOBRxzTRFmf2drEOxhCXfL3NEbAEmM0C228GxdZZinWJsRFBdO
         axCxD5vbAeKq4Or30hApOfl+7nfyPDI90y87gBA7XWkOw8m+7FGV0A8BcfUy0hztzGxG
         mqZPpGs7RQdTkXh8T4xs0mQ09BDyAs67a2owi9+cRBszWeacc4JtdKXTOynpQXIz+Jsa
         PA2C/AM9po3FliMfdEkcFf+L6T4etRXpnrUILJO/gmZQptth6zc4Uk7xCZNzndDwx+7i
         nAa7wR88mvYnir1vlFm80tLb8sYGyrEzU0kHD7TDAgFq/WZKYifuyjP5wRgUv8eZfwRT
         Q3eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755091827; x=1755696627;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NnnCQkJJgePWl09KuitQpQyTSvHR1c9B+DMmCu5TKeo=;
        b=etRMFlHadNctxWsQxKe9K+e6DKDnODCtLkifrU7RHGxm+9U4E7ULKxJSRGQhdVmUc2
         TtAxRLykiRYBZO0h92buCnxQf08KrHe+uM5zfuppITaowBCDZqUVVwaof3BiNm0rLoXR
         wbMJJ9oYM0O1DPEWuXZSbP4PhPDaCyXoNAKxQ8jxVD7lOJBTtzRpKgrwEKr3w0Ek3fJA
         ZXx6Y7/aqkxxIPubVvrRwYzmYNyg00W8xctm4ZGNgj6mSfRYUvri5FCd5e+tdwU6xRfY
         iXngKK70ZCt9E+5RfHThYTkwDuBRSLBI6YhNu6ybCJIHdBkitvO+VoOUSpv7PDGVMWSe
         dm5A==
X-Forwarded-Encrypted: i=1; AJvYcCXM/6JztYxVGQm4x43u/L84BaxdBNfMAGPR3gUYxcJGOq7flh/GENNqaG6iKQlul+Pqa4lLe7XMK1yhHCQg@vger.kernel.org, AJvYcCXp8AHw12e0oEH+h4cgF2fYRLndcTFh565eEsTveu7Lz7/3xT//XXurbOCuTJ+icTVxJyDpZSoZHF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAnDhmG77m0BwPWqGVi7it/MtzKTQ7bmXpCTYc3kZz1JT+RGtS
	Px5WN2Pm5LxRiW2RtDusO+yaRDpz/K+PzUDKG87pJKZE6WzSDPHHI9fr
X-Gm-Gg: ASbGncvL+smJF+EmwPIJ/rB8SfrFWH5H4Kv+02srfY5awjE/02KShsUTxqDD0FCA9Fj
	Ow+rcVpr9wzj26ua8dFvfujUZvgcbXayI07NjQOTWESWTEfxp991HwDvPSpuGv+kBfMbHaqoKK+
	4t5jcq5v/u9kizd3adR3tsRtEMquWRGiXf+zQldQ8gXYtPpa42rGCZPOSDkjy6aMbO8s3ofmous
	ZIUiW26wxrqRK8GN9UQpAWgTRUzNWMR5vRjKzGsgAmTwXq3yo1hcxXMT+EHesAagEpO1XKBBpG8
	69PBvlVtRLVavwlE2Yy7IupbCIFJdJJanI38vAsh6aiMPdq9R9Xu3rcUdgADPjI43AqDu8e/Roq
	gyne7XIkRuCeyFAjfTTDTOJsGmLIp03dPyg==
X-Google-Smtp-Source: AGHT+IFGdUqx8cTCmj4iXcmfgd+dJQv2w/d5ukWS/nm7aK8I4rFgNMoGw18voX05CaLCpy+vw+Xllw==
X-Received: by 2002:a17:903:3bac:b0:234:8a4a:ad89 with SMTP id d9443c01a7336-2430e8a9ff0mr36705575ad.1.1755091826629;
        Wed, 13 Aug 2025 06:30:26 -0700 (PDT)
Received: from akshayaj-lenovo.. ([223.233.77.228])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f0fb4asm324124375ad.60.2025.08.13.06.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 06:30:26 -0700 (PDT)
From: Akshay Jindal <akshayaj.lkd@gmail.com>
To: anshulusr@gmail.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: Akshay Jindal <akshayaj.lkd@gmail.com>,
	shuah@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] iio: light: ltr390: Add device powerdown functionality via devm api
Date: Wed, 13 Aug 2025 19:00:14 +0530
Message-ID: <20250813133017.72476-1-akshayaj.lkd@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use devm_add_action_or_reset() to do cleanup when the device is removed.
Set client data with i2c_set_clientdata().

Signed-off-by: Akshay Jindal <akshayaj.lkd@gmail.com>
---

Changes Since v2:
-----------------
- Replace i2c_client with ltr390_data as action parameter of devm_add_action_or_reset().
- Place i2c_set_clientdata above data population line.
- Modify changelog accordingly.

Changes Since v1:
-----------------
- Switch from remove callback to devm_* API for powerdown.
- Modify changelog and summary accordingly.

Testing details:
----------------
-> Tested on Raspberrypi 4B. Following tests were performed.

1. Sensor and interrupts should be disabled after module unload.
-> Before unload
akshayaj@raspberrypi:~ $ echo 1 | sudo tee /sys/bus/iio/devices/iio\:device0/events/in_illuminance_thresh_either_en
1
akshayaj@raspberrypi:~ $ cat /sys/bus/iio/devices/iio\:device0/events/in_illuminance_thresh_either_en
1
akshayaj@raspberrypi:~ $ i2cget -f -y 1 0x53 0x19
0x14
akshayaj@raspberrypi:~ $ i2cget -f -y 1 0x53 0x0
0x02

-> After unload
akshayaj@raspberrypi:~ $ sudo rmmod ltr390
akshayaj@raspberrypi:~ $ i2cget -f -y 1 0x53 0x0
0x00
akshayaj@raspberrypi:~ $ i2cget -f -y 1 0x53 0x19
0x10

 drivers/iio/light/ltr390.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
index 7733830dca67..07b8dd27dd9a 100644
--- a/drivers/iio/light/ltr390.c
+++ b/drivers/iio/light/ltr390.c
@@ -680,6 +680,22 @@ static irqreturn_t ltr390_interrupt_handler(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
+static void ltr390_powerdown(void *priv)
+{
+	struct ltr390_data *data = priv;
+
+	guard(mutex)(&data->lock);
+
+	/* Ensure that power off and interrupts are disabled */
+	if (regmap_clear_bits(data->regmap, LTR390_INT_CFG,
+				LTR390_LS_INT_EN) < 0)
+		dev_err(&data->client->dev, "failed to disable interrupts\n");
+
+	if (regmap_clear_bits(data->regmap, LTR390_MAIN_CTRL,
+			LTR390_SENSOR_ENABLE) < 0)
+		dev_err(&data->client->dev, "failed to disable sensor\n");
+}
+
 static int ltr390_probe(struct i2c_client *client)
 {
 	struct ltr390_data *data;
@@ -692,8 +708,9 @@ static int ltr390_probe(struct i2c_client *client)
 	if (!indio_dev)
 		return -ENOMEM;
 
-	data = iio_priv(indio_dev);
+	i2c_set_clientdata(client, indio_dev);
 
+	data = iio_priv(indio_dev);
 	data->regmap = devm_regmap_init_i2c(client, &ltr390_regmap_config);
 	if (IS_ERR(data->regmap))
 		return dev_err_probe(dev, PTR_ERR(data->regmap),
@@ -733,6 +750,10 @@ static int ltr390_probe(struct i2c_client *client)
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to enable the sensor\n");
 
+	ret = devm_add_action_or_reset(dev, ltr390_powerdown, data);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to add action or reset\n");
+
 	if (client->irq) {
 		ret = devm_request_threaded_irq(dev, client->irq,
 						NULL, ltr390_interrupt_handler,
-- 
2.43.0


