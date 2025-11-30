Return-Path: <linux-iio+bounces-26571-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2C0C951BE
	for <lists+linux-iio@lfdr.de>; Sun, 30 Nov 2025 16:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EE8083430A1
	for <lists+linux-iio@lfdr.de>; Sun, 30 Nov 2025 15:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CED28466C;
	Sun, 30 Nov 2025 15:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhEV1ZLq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2198D283FE3
	for <linux-iio@vger.kernel.org>; Sun, 30 Nov 2025 15:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764517091; cv=none; b=cWPQlEa11Mf5qXzbZYRJdqzJwG10rx0y59l96LYpLEOAo2iLu2qzMcUtj2pRXqCE8i0KF1Di5rp98xv7pMWEQdhmGtgLyuiqBcSJGPyFQaftl0MPyi2dHdZR7ijuTWh5xGsvGAnIGa1XXqHXddWUBo9vYyiZiCA26Tp3o4eWQM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764517091; c=relaxed/simple;
	bh=dmVZuhWFNXiJnoForG9aM64k/Rkd4w/YPpHBpHuDhPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uq56Ptij1snXhrRL4yrvr/z2Igrr9J/AEZAs0fuxMi3/A4Y0NthUlNXCosINDOWVJ6K1O3ScD702BJf1g3hIefr66eRW8IlXUewC5KA+OFKYpWHU0VikcLvfj+6jiCKOwyIXABfQFE3wHcAJj0nKtn0xKGx1kEUDpQPcEqD7+Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lhEV1ZLq; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-343ea89896eso3352935a91.2
        for <linux-iio@vger.kernel.org>; Sun, 30 Nov 2025 07:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764517089; x=1765121889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M7zBNbXRFjiiQJDko6TrwgMM3whDrySsUYoLNxeiUXY=;
        b=lhEV1ZLqB9vjPFU5iM2zZSowI8xp0ig7dpgB3yW//q1rx74xhcsBvN0yBMuaBUlFk6
         BLQA2ChmEAYTFmbn4HD7ryUWxRRpWfEiStOpi0Eodi9DiDJghvu27soeUnpW6ssD6h2S
         eRwgQFx4GuCjyJn/690sEO+4Coa9a/HJUGj5mvbjtEcgRgoD02JhyqRlpbycRZaZlSHg
         bJtejcZLE7HupKauljqg2bqaw/HHXaa0ZOLGyDrY60W4G7nif4+yBY0nF5SYSzLrzUu8
         u5uEM9tV24Wgh9Lt1uuu2bC6FOfEoZHIIckRMKRRsv+LZA820tCO135UYKQrKS7yFfxJ
         CcJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764517089; x=1765121889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M7zBNbXRFjiiQJDko6TrwgMM3whDrySsUYoLNxeiUXY=;
        b=UAvH15cfPyNq6rDM6s64IZsd0Xjga0sMi+o+ou/96B/YJ36a1YP1YSjTYij7jEnUJE
         ikd7v8znBGsAUt1Co2x2qk5sPcgifOSky/lS4nnK2PJn4kkvgBdwCBVan6Zph1pWpy2g
         ZS3UZB9GkcRY+XXuRee7vkoTS32R4zfZOvGI1ltoBO329rtC6qKf3iNM/62wguATIOE2
         frdMiQnrAemfOMHijxnJjdQ7i98/fccUWSKnGdDFrNpDgQDahWcTX3aZ1lO6Xrg7ciPa
         u+7N0UNifmhBwh+qT4lA6Ztpv+XRNvphomY9PtkSFlLdS5tOarISlzo625ITuAdmrzr3
         gelQ==
X-Forwarded-Encrypted: i=1; AJvYcCXT9nTRFdZYOtW3pH0OlT/1euTLN6c4xEF+CHs0xOFUrtqXzSib0kM1fc9jc24u6a0TmE7JquKbbB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaBDulV8Wu6/H2FfKRzVniUf8g3/N7jfuZuszwQU9PNfJV3Rg2
	lu13yoC4ru03xhmX1QJcK6HhgIuLtPBl/+axzI7yrWQ18Y4iSq1LlCox
X-Gm-Gg: ASbGncsRgDQ2UA+e3iHr9yRm8+lImYV5jXL4EUmJAV1gcPi85RKdkY0cXf4n4NA655D
	Panb24/p2lPTG22UzXwvMVQZJI/ikoxp1QaanPSEZ6TfAf5Fg05g0h1psmCzFab78y55m6MM5h4
	RCD9tXh/hj/fvmZWl7GvE03Ih5ERtVjQ2W0WLnEtMXgyYOBR0YwK2UqwZQquBXYCCkr66+k0D4e
	Ghe5NM5bDxQAWDP8OZkEgZ39HDR1EF3dyTkhLCrW7LcsnMgRrTz6b9TT7M4pJGjkzplYhXvp0Xj
	9C52PIo2BUDRI4mOlAA42vTuPgZeLQ2AyQXld1H6nENKj7J0NISl02F3OvMxfHYYAZQd50Zxcs3
	mrHgS/ekumkIrPTJxMfq/t2s+8HBiDpfpe0vuZE8BYS4Nd70hk1RJhtdRUV29GeOWYk/84REll0
	KzoaWkKvAW7n7XWg==
X-Google-Smtp-Source: AGHT+IF08SUqGtj+JrWhUfy4lL7zxAKhL0SBFWLpJc7hXUSn0VZ3P+CxbjrW5ROkN6ByOvlPrjkaFA==
X-Received: by 2002:a17:90b:2587:b0:33b:b078:d6d3 with SMTP id 98e67ed59e1d1-34733ef7092mr31567964a91.23.1764517089407;
        Sun, 30 Nov 2025 07:38:09 -0800 (PST)
Received: from Ubuntu24.. ([103.187.64.30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3475e952efbsm6903483a91.1.2025.11.30.07.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Nov 2025 07:38:09 -0800 (PST)
From: Shrikant Raskar <raskar.shree97@gmail.com>
To: jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	heiko@sntech.de,
	neil.armstrong@linaro.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shrikant Raskar <raskar.shree97@gmail.com>
Subject: [PATCH v2 4/4] iio: proximity: rfd77402: Add interrupt handling support
Date: Sun, 30 Nov 2025 21:07:12 +0530
Message-ID: <20251130153712.6792-5-raskar.shree97@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251130153712.6792-1-raskar.shree97@gmail.com>
References: <20251130153712.6792-1-raskar.shree97@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add interrupt handling support to enable event-driven data acquisition
instead of continuous polling. This improves responsiveness, reduces
CPU overhead, and supports low-power operation by allowing the system
to remain idle until an interrupt occurs.

Signed-off-by: Shrikant Raskar <raskar.shree97@gmail.com>
---
Changelog:
Changes since v1:
- Remove 'of.h' header
- Split the condition in 2 parts in interrupt handler
- Add helper rfd77402_wait_for_irq()
- Add helper rfd77402_config_irq()
- Code refactoring
- Return failure if request IRQ failed

Link to v1:https://lore.kernel.org/all/20251126031440.30065-4-raskar.shree97@gmail.com/

Test Logs:
1. Interrupt Mode :
pi@raspberrypi:~$ sudo i2cdetect -y 1
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- -- -- -- -- -- -- -- -- 
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
40: -- -- -- -- -- -- -- -- -- -- -- -- UU -- -- -- 
50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
70: -- -- -- -- -- -- -- --                         
pi@raspberrypi:~$ cat /sys/bus/iio/devices/iio:device0/in_distance_raw
35
pi@raspberrypi:~$ cat /sys/bus/iio/devices/iio:device0/in_distance_raw
39
pi@raspberrypi:~$ cat /proc/interrupts | grep rfd
127:          2          0          0          0 pinctrl-bcm2835   4 Edge      rfd77402
pi@raspberrypi:~$ dmesg | grep rfd
[    7.464789] rfd77402 1-004c: Using interrupt mode

2. Polling Mode :
pi@raspberrypi:~$ sudo i2cdetect -y 1
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- -- -- -- -- -- -- -- -- 
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
40: -- -- -- -- -- -- -- -- -- -- -- -- UU -- -- -- 
50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
70: -- -- -- -- -- -- -- --                         
pi@raspberrypi:~$ dmesg | grep rfd
[   26.908031] rfd77402 1-004c: No interrupt specified, using polling mode
pi@raspberrypi:~$ cat /sys/bus/iio/devices/iio:device0/in_distance_raw
36
pi@raspberrypi:~$ cat /sys/bus/iio/devices/iio:device0/in_distance_raw
45
---
 drivers/iio/proximity/rfd77402.c | 126 +++++++++++++++++++++++++++++--
 1 file changed, 118 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/proximity/rfd77402.c b/drivers/iio/proximity/rfd77402.c
index 2152509816ca..8441a7bcabec 100644
--- a/drivers/iio/proximity/rfd77402.c
+++ b/drivers/iio/proximity/rfd77402.c
@@ -6,19 +6,21 @@
  *
  * 7-bit I2C slave address 0x4c
  *
- * TODO: interrupt
  * https://media.digikey.com/pdf/Data%20Sheets/RF%20Digital%20PDFs/RFD77402.pdf
  */
 
 #include <linux/module.h>
 #include <linux/i2c.h>
 #include <linux/delay.h>
-
+#include <linux/interrupt.h>
+#include <linux/completion.h>
 #include <linux/iio/iio.h>
 
 #define RFD77402_DRV_NAME "rfd77402"
 
 #define RFD77402_ICSR		0x00 /* Interrupt Control Status Register */
+#define RFD77402_ICSR_CLR_CFG   BIT(0)
+#define RFD77402_ICSR_CLR_TYPE  BIT(1)
 #define RFD77402_ICSR_INT_MODE	BIT(2)
 #define RFD77402_ICSR_INT_POL	BIT(3)
 #define RFD77402_ICSR_RESULT	BIT(4)
@@ -26,6 +28,12 @@
 #define RFD77402_ICSR_H2M_MSG	BIT(6)
 #define RFD77402_ICSR_RESET	BIT(7)
 
+#define RFD77402_IER		0x02
+#define RFD77402_IER_RESULT	BIT(0)
+#define RFD77402_IER_M2H_MSG	BIT(1)
+#define RFD77402_IER_H2M_MSG	BIT(2)
+#define RFD77402_IER_RESET	BIT(3)
+
 #define RFD77402_CMD_R		0x04
 #define RFD77402_CMD_SINGLE	0x01
 #define RFD77402_CMD_STANDBY	0x10
@@ -80,6 +88,10 @@ struct rfd77402_data {
 	struct i2c_client *client;
 	/* Serialize reads from the sensor */
 	struct mutex lock;
+	/* Completion for interrupt-driven measurements */
+	struct completion completion;
+	/* Flag to indicate if interrupt is available */
+	bool irq_en;
 };
 
 static const struct iio_chan_spec rfd77402_channels[] = {
@@ -110,6 +122,36 @@ static int rfd77402_set_state(struct i2c_client *client, u8 state, u16 check)
 	return 0;
 }
 
+static irqreturn_t rfd77402_interrupt_handler(int irq, void *dev_id)
+{
+	struct rfd77402_data *data = dev_id;
+	int ret;
+
+	ret = i2c_smbus_read_byte_data(data->client, RFD77402_ICSR);
+	if (ret < 0)
+		return IRQ_NONE;
+
+	/* Check if the interrupt is from our device */
+	if (!(ret & RFD77402_ICSR_RESULT))
+		return IRQ_NONE;
+
+	/* Signal completion of measurement */
+	complete(&data->completion);
+	return IRQ_HANDLED;
+}
+
+static int rfd77402_wait_for_irq(struct rfd77402_data *data)
+{
+	int ret;
+
+	ret = wait_for_completion_timeout(&data->completion,
+					  msecs_to_jiffies(200));
+	if (ret == 0)
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
 static int rfd77402_result_polling(struct i2c_client *client)
 {
 	int ret;
@@ -129,21 +171,31 @@ static int rfd77402_result_polling(struct i2c_client *client)
 	return -ETIMEDOUT;
 }
 
-static int rfd77402_measure(struct i2c_client *client)
+static int rfd77402_measure(struct rfd77402_data *data)
 {
+	struct i2c_client *client = data->client;
 	int ret;
+
 	ret = rfd77402_set_state(client, RFD77402_CMD_MCPU_ON,
 				 RFD77402_STATUS_MCPU_ON);
 	if (ret < 0)
 		return ret;
 
+	/* Initialize completion for interrupt mode */
+	if (data->irq_en)
+		reinit_completion(&data->completion);
+
 	ret = i2c_smbus_write_byte_data(client, RFD77402_CMD_R,
 					RFD77402_CMD_SINGLE |
 					RFD77402_CMD_VALID);
 	if (ret < 0)
 		goto err;
 		
-	ret = rfd77402_result_polling(client);
+	if (data->irq_en)
+		ret = rfd77402_wait_for_irq(data);
+	else
+		ret = rfd77402_result_polling(data->client);
+
 	if (ret < 0)
 		goto err;
 
@@ -175,7 +227,7 @@ static int rfd77402_read_raw(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		mutex_lock(&data->lock);
-		ret = rfd77402_measure(data->client);
+		ret = rfd77402_measure(data);
 		mutex_unlock(&data->lock);
 		if (ret < 0)
 			return ret;
@@ -195,8 +247,25 @@ static const struct iio_info rfd77402_info = {
 	.read_raw = rfd77402_read_raw,
 };
 
+static int rfd77402_config_irq(struct i2c_client *client, u8 csr, u8 ier)
+{
+	int ret;
+
+	ret = i2c_smbus_write_byte_data(client, RFD77402_ICSR, csr);
+	if (ret < 0)
+		return ret;
+
+	ret = i2c_smbus_write_byte_data(client, RFD77402_IER, ier);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 static int rfd77402_init(struct i2c_client *client)
 {
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct rfd77402_data *data = iio_priv(indio_dev);
 	int ret, i;
 
 	ret = rfd77402_set_state(client, RFD77402_CMD_STANDBY,
@@ -204,9 +273,25 @@ static int rfd77402_init(struct i2c_client *client)
 	if (ret < 0)
 		return ret;
 
-	/* configure INT pad as push-pull, active low */
-	ret = i2c_smbus_write_byte_data(client, RFD77402_ICSR,
-					RFD77402_ICSR_INT_MODE);
+	if (data->irq_en) {
+	/*
+	 * Enable interrupt mode:
+	 * - Configure ICSR for auto-clear on read, push-pull output and falling edge
+	 * - Enable "result ready" interrupt in IER
+	 */
+		ret = rfd77402_config_irq(client,
+					  RFD77402_ICSR_CLR_CFG |
+					  RFD77402_ICSR_INT_MODE,
+					  RFD77402_IER_RESULT);
+	} else {
+	/*
+	 * Disable all interrupts:
+	 * - Clear ICSR configuration
+	 * - Disable all interrupt in IER
+	 */
+		ret = rfd77402_config_irq(client, 0, 0);
+	}
+
 	if (ret < 0)
 		return ret;
 
@@ -283,6 +368,31 @@ static int rfd77402_probe(struct i2c_client *client)
 	data = iio_priv(indio_dev);
 	data->client = client;
 	mutex_init(&data->lock);
+	init_completion(&data->completion);
+
+	i2c_set_clientdata(client, indio_dev);
+
+	data->irq_en = false;
+	if (client->irq > 0) {
+		/* interrupt mode */
+		ret = devm_request_threaded_irq(&client->dev, client->irq,
+						NULL, rfd77402_interrupt_handler,
+						IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+						"rfd77402", data);
+		if (ret < 0) {
+			dev_err(&client->dev,
+				"Failed to request IRQ %d: %d\n",
+				client->irq, ret);
+			return ret;
+		}
+
+		data->irq_en = true;
+		dev_info(&client->dev, "Using interrupt mode\n");
+
+	} else {
+		/* polling mode */
+		dev_info(&client->dev, "No interrupt specified, using polling mode\n");
+	}
 
 	indio_dev->info = &rfd77402_info;
 	indio_dev->channels = rfd77402_channels;
-- 
2.43.0


