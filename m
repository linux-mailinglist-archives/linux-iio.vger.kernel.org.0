Return-Path: <linux-iio+bounces-26477-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3D3C87ED6
	for <lists+linux-iio@lfdr.de>; Wed, 26 Nov 2025 04:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2E4DC4EA585
	for <lists+linux-iio@lfdr.de>; Wed, 26 Nov 2025 03:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9494230DECE;
	Wed, 26 Nov 2025 03:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B15tnNse"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849E130DD1D
	for <linux-iio@vger.kernel.org>; Wed, 26 Nov 2025 03:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764127111; cv=none; b=VrFRS43BYI2v16BU6h+47rudgcgfTc9ewYX7YBN2xQIXlbBp6LEiPl0v3aqBhCtBbftIeDjwCQozHNLkpEo0MDQDDYzp8E0WehNgedsdkm026HYuw2nhH5Ze8frPMcLhSxYdfT8sl0D2X78oD3yuF6uLTx7k8i6iQFBW1O872Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764127111; c=relaxed/simple;
	bh=O/FdDoWsTtB3kG7n8rW5pom32dgJ0HYrp8tN2uownXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BFuk2GEE2QJ7/y9supSnJkWsii+Gl2Ws0qJOVxPQu8cnC7HUA8yilaqBEWXohN23mVG/SZ5VhPZ/9Al+aF0CnM8m1gsiFvV6UTH3yi/zsMK7IFt+dxsZSObpFCF1fCuIyMuZ/YFfJ1PGuCl9RQdEp7SNjyfqcyxebGGVNRiViI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B15tnNse; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-343684a06b2so6223066a91.1
        for <linux-iio@vger.kernel.org>; Tue, 25 Nov 2025 19:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764127109; x=1764731909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d6Xe64oeFN/hgEeTq3mr06ewYNBk1gsJ/h1SLYUnJnM=;
        b=B15tnNse8/SP7HJBWKr55X3EE8Q7di6V7spKV3oBEFS/mSKrX9uDI+45EAYmuHnpy/
         MfSTmYRF29aaLsyXkpsCmKhKwF8yjKyMKMosr6aBTpjo8HTdcOiGzv9ICdE8yffMFXp9
         BhH2sthYtGkuJbTqO4cJPQsaSFua1SBxJTsg06zXQPCYb+6d3iGC4QWN2DdW7Sh5FLPx
         igOm0rXhSzrndmvxPxZI+/PMEz6DEpSn2MiZK8LOSSevr/oRmJli8s+ds//I4kMN0Bsz
         2H6Vrzs8p3kpqf/Em3cGlIJJCTTIHJbn1MyUEWRBHj10/9RwAbIX7SG+Mf+d0W2IA6h7
         /SBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764127109; x=1764731909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d6Xe64oeFN/hgEeTq3mr06ewYNBk1gsJ/h1SLYUnJnM=;
        b=BIb+J6hm78kcPDOow0sXBe87Y0DOV7FeU84DLipNZQDaymRQAFKfkVfPlvrdCr1J3B
         l9NgpGC6JNkn7cM8Vx5/2UGc87XJxSZK1o/7WkoHWnIh4WVLTjCI2wN3e6IwKxlsrorN
         B9IIauZr16Ai8lzgR89ZMOhVLEEBxLtGoxfF+29Zdv/cggMFublesELyAzeSKRu1bCXR
         j5PRmoU3og1+xuaxnFoJtIr0IFhKF1Kt865WW152MYHxBH9SyEYw1sr/TfqHSSYrRY/c
         oy3bgZP/L3DIxQQBhXxW74I32S9NJKG8WfVQ9UxVSwSb0RMcfeT6FuxDuS8eNh8SIJF9
         FPWA==
X-Forwarded-Encrypted: i=1; AJvYcCXY7u95uTRkbcatxInhKeAOUVymZkwoSg0gsU5aQhBavPxLy/8xITFx0apKmJUeNfexyrXeSLGxqas=@vger.kernel.org
X-Gm-Message-State: AOJu0YydQTgHHyYgRvYOcLha+t4q8vnEvvd+8t68/lN53Jk/M1ZfT/LJ
	FaFQgFjcqeirOeznvvd3dmhSb/yn0w0hMCcf4Kymb5gPpEnq8k0TXDat
X-Gm-Gg: ASbGncs1i4Elm/J9R5KmAPajwhOLs/CQmpGPp690Qk49GfNbA6L0Ovp0BHCD2rAvrda
	39V+zgOmvOSTcN6jXIYxcfe9qD8x2J8/CowQmPNOLohrUtGDFDtFtFsYUUaQQsCqqoHpATtTNV7
	lqjpAD0AYfPo9U5AIqS+Qvd4Vl1awBti3RZrtsb4GjOR/uKTz0Xiae+S17er4p545IvJKk4NRoA
	/qSJhsDv1sBNtmOF84B2wkFfACZRGmTY7axSC+62jd5+1hkOWF6EiwJbMtWCE7+GvqcXsYhf0Ff
	q8WOGtsaHNUURwKqM25tCLbCEgyROKPp8E6ileX50+s8/bWfwsHZZ+ClZ5oYb8UttcNzRiQekka
	ChR0r3kgQeuv6ZKxgr0JP/aZW/n0nPpGyRmsUg7hpMJIpyUERLn3mFXDSo7KZou4W2thUsKwpO2
	ifkDtVgwfd4fMYTA==
X-Google-Smtp-Source: AGHT+IGWuTk86MmM+T3rvGIwhVEhOF0JgQ3Zm8cM9stPPaPkBMDZPrWJaO5FrThxprXCHLKadXm4uA==
X-Received: by 2002:a17:90b:4ccd:b0:340:a961:80c5 with SMTP id 98e67ed59e1d1-34733f4d978mr15820722a91.32.1764127108815;
        Tue, 25 Nov 2025 19:18:28 -0800 (PST)
Received: from Ubuntu24.. ([103.187.64.30])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bd760ac62ecsm17935713a12.26.2025.11.25.19.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 19:18:28 -0800 (PST)
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
Subject: [PATCH 3/3] iio: proximity: rfd77402: Add interrupt handling support
Date: Wed, 26 Nov 2025 08:44:40 +0530
Message-ID: <20251126031440.30065-4-raskar.shree97@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251126031440.30065-1-raskar.shree97@gmail.com>
References: <20251126031440.30065-1-raskar.shree97@gmail.com>
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
 drivers/iio/proximity/rfd77402.c | 127 ++++++++++++++++++++++++++-----
 1 file changed, 107 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/proximity/rfd77402.c b/drivers/iio/proximity/rfd77402.c
index 3262af6f6882..0e4763b34267 100644
--- a/drivers/iio/proximity/rfd77402.c
+++ b/drivers/iio/proximity/rfd77402.c
@@ -6,19 +6,22 @@
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
+#include <linux/of.h>
 #include <linux/iio/iio.h>
 
 #define RFD77402_DRV_NAME "rfd77402"
 
 #define RFD77402_ICSR		0x00 /* Interrupt Control Status Register */
+#define RFD77402_ICSR_CLR_CFG   BIT(0)
+#define RFD77402_ICSR_CLR_TYPE  BIT(1)
 #define RFD77402_ICSR_INT_MODE	BIT(2)
 #define RFD77402_ICSR_INT_POL	BIT(3)
 #define RFD77402_ICSR_RESULT	BIT(4)
@@ -26,6 +29,12 @@
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
@@ -80,6 +89,10 @@ struct rfd77402_data {
 	struct i2c_client *client;
 	/* Serialize reads from the sensor */
 	struct mutex lock;
+	/* Completion for interrupt-driven measurements */
+	struct completion completion;
+	/* Flag to indicate if interrupt is available */
+	bool irq_en;
 };
 
 static const struct iio_chan_spec rfd77402_channels[] = {
@@ -110,8 +123,24 @@ static int rfd77402_set_state(struct i2c_client *client, u8 state, u16 check)
 	return 0;
 }
 
-static int rfd77402_measure(struct i2c_client *client)
+static irqreturn_t rfd77402_interrupt_handler(int irq, void *dev_id)
+{
+	struct rfd77402_data *data = dev_id;
+	int ret;
+
+	/* Check if the interrupt is from our device */
+	ret = i2c_smbus_read_byte_data(data->client, RFD77402_ICSR);
+	if (ret < 0 || !(ret & RFD77402_ICSR_RESULT))
+		return IRQ_NONE;
+
+	/* Signal completion of measurement */
+	complete(&data->completion);
+	return IRQ_HANDLED;
+}
+
+static int rfd77402_measure(struct rfd77402_data *data)
 {
+	struct i2c_client *client = data->client;
 	int ret;
 	int tries = 10;
 
@@ -120,24 +149,39 @@ static int rfd77402_measure(struct i2c_client *client)
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
 
-	while (tries-- > 0) {
-		ret = i2c_smbus_read_byte_data(client, RFD77402_ICSR);
-		if (ret < 0)
+	if (data->irq_en) {
+		/* Wait for interrupt-driven completion */
+		ret = wait_for_completion_timeout(&data->completion,
+						  msecs_to_jiffies(200));
+		if (ret == 0) {
+			ret = -ETIMEDOUT;
 			goto err;
-		if (ret & RFD77402_ICSR_RESULT)
-			break;
-		msleep(20);
-	}
-
-	if (tries < 0) {
-		ret = -ETIMEDOUT;
-		goto err;
+		}
+	} else {
+		/* Fallback to polling mode */
+		while (tries-- > 0) {
+			ret = i2c_smbus_read_byte_data(client, RFD77402_ICSR);
+			if (ret < 0)
+				goto err;
+			if (ret & RFD77402_ICSR_RESULT)
+				break;
+			msleep(20);
+		}
+
+		if (tries < 0) {
+			ret = -ETIMEDOUT;
+			goto err;
+		}
 	}
 
 	ret = i2c_smbus_read_word_data(client, RFD77402_RESULT_R);
@@ -168,7 +212,7 @@ static int rfd77402_read_raw(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		mutex_lock(&data->lock);
-		ret = rfd77402_measure(data->client);
+		ret = rfd77402_measure(data);
 		mutex_unlock(&data->lock);
 		if (ret < 0)
 			return ret;
@@ -190,6 +234,8 @@ static const struct iio_info rfd77402_info = {
 
 static int rfd77402_init(struct i2c_client *client)
 {
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct rfd77402_data *data = iio_priv(indio_dev);
 	int ret, i;
 
 	ret = rfd77402_set_state(client, RFD77402_CMD_STANDBY,
@@ -197,11 +243,29 @@ static int rfd77402_init(struct i2c_client *client)
 	if (ret < 0)
 		return ret;
 
-	/* configure INT pad as push-pull, active low */
-	ret = i2c_smbus_write_byte_data(client, RFD77402_ICSR,
-					RFD77402_ICSR_INT_MODE);
-	if (ret < 0)
-		return ret;
+	if (data->irq_en) {
+		/* Configure ICSR: auto-clear on read, push-pull, falling edge */
+		ret = i2c_smbus_write_byte_data(client, RFD77402_ICSR,
+						RFD77402_ICSR_CLR_CFG |
+						RFD77402_ICSR_INT_MODE);
+		if (ret < 0)
+			return ret;
+
+		/* Enable 'new data available' interrupt in IER */
+		ret = i2c_smbus_write_byte_data(client, RFD77402_IER,
+						RFD77402_IER_RESULT);
+		if (ret < 0)
+			return ret;
+	} else {
+		/* Disable interrupts */
+		ret = i2c_smbus_write_byte_data(client, RFD77402_ICSR, 0);
+		if (ret < 0)
+			return ret;
+
+		ret = i2c_smbus_write_byte_data(client, RFD77402_IER, 0);
+		if (ret < 0)
+			return ret;
+	}
 
 	/* I2C configuration */
 	ret = i2c_smbus_write_word_data(client, RFD77402_I2C_INIT_CFG,
@@ -277,6 +341,29 @@ static int rfd77402_probe(struct i2c_client *client)
 	data->client = client;
 	mutex_init(&data->lock);
 
+	init_completion(&data->completion);
+
+	i2c_set_clientdata(client, indio_dev);
+
+	/* Check if interrupt is mentioned in device tree */
+	data->irq_en = false;
+	if (client->irq > 0) {
+		ret = devm_request_threaded_irq(&client->dev, client->irq,
+						NULL, rfd77402_interrupt_handler,
+						IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+						"rfd77402", data);
+		if (ret == 0) {
+			data->irq_en = true;
+			dev_info(&client->dev, "Using interrupt mode\n");
+		} else {
+			dev_warn(&client->dev,
+				 "Failed to request IRQ %d, using polling mode: %d\n",
+				 client->irq, ret);
+		}
+	} else {
+		dev_info(&client->dev, "No interrupt specified, using polling mode\n");
+	}
+
 	indio_dev->info = &rfd77402_info;
 	indio_dev->channels = rfd77402_channels;
 	indio_dev->num_channels = ARRAY_SIZE(rfd77402_channels);
-- 
2.43.0


