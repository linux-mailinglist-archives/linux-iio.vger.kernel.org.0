Return-Path: <linux-iio+bounces-10174-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC309917FA
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 17:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C33D1F22B18
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 15:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D66157A7C;
	Sat,  5 Oct 2024 15:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwtymgmc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC63156F54;
	Sat,  5 Oct 2024 15:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728143586; cv=none; b=FsC4xv8iz4Rjtxrgo21Ufs65tZF/zbi6HXChpe7NSGgGXFpiRF5Lp93wwMu24mqyAlee2uEDVnxJWMQWh9UTD++0am8BCl7B7uvW5rg9fQqnA8tUEQMkL97HzZL6UQbS9xB6ktyFV+hzEeyXqNU70ESPHJbS2GyZRF3ccpC6mNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728143586; c=relaxed/simple;
	bh=JBqlXJK+sYEsYqPlK4tM6IeWeNFc+TGZbPwndM1P41g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rUrYfMGwBLt2LncaYeDkAmHBorUvOL+rPivhMhYmxhtXdIo2+8mQVUIlyVVOAf47I90nX2D3MSI143WILl6hr3tJpp0wbZBvZkjBD0gpifBuQV9pff9KxF6tLVRM6z2YUfc89VlGafoyEq/kJ3doBxaqOTcSpX8vZ0N/U+JG+gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lwtymgmc; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7e9e38dd5f1so1932800a12.0;
        Sat, 05 Oct 2024 08:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728143584; x=1728748384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7SqI97S0ywB/WLJhr+9ChW9idec52eD6V6moNdqzpdU=;
        b=lwtymgmcj637X9wbix2jq8j1Nscgb2RFuvmGlQwUaVnS9kbyp9NGhBp9jRXokFHfqT
         gredEaDli7Rw8+GC7sewW2viQzIopa38ujWeAKXEKgZ8/5hfAXZHU40kr/jSgL/5yWfp
         U7WqcptVtB1HGESPcSBzpvVL5TRGhU9aUorUgixoUauv6Hfmh43kGp2xne1pOjKJuXpI
         HfYnGALcdyav4M5W4esFlXTwkiRgNvqcAtDVF47J4hlfdKUA3Y2N8dd4I5HJ5djQCV88
         ZPK6pCtC0YhzSGNvGyfH4VF5zIjzGRVnfTP5CJksXETRxDoC+CeLO8DrUPDzLwSIc4zh
         3gLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728143584; x=1728748384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7SqI97S0ywB/WLJhr+9ChW9idec52eD6V6moNdqzpdU=;
        b=MDhGFoAylPUkMvXv1wGrnaWNhsqVom+V1HaKRuW+aNR3ZUF1cAHBz5ikjx1E0HP3xu
         s1ZI+fPdUVUyzTKY72wv3/X3rREVOBSA2aCmGkFEVknJPmGo+dUm4s2Dzh3RgREpgHEG
         koVmXCvqSAsnpDAJHJk5RVmd5xtp4RCobURU4QCYDpaUvpo5JDYli9rIG/KxylLZWHDu
         PnimSlcfZub5+4y/WCmtb96CYbY+aT3jQuzUBbnWBlRFuIIclO4bog1P/URJyG8/VcV7
         2+S++7rFSl8xULVWp8LV4v45OvfMNXw8h2kM1/NdzHMM/5NZBLQbxE1rZrEAxhACjQLE
         bGQA==
X-Forwarded-Encrypted: i=1; AJvYcCU3/HcxWJP2gAAU+cNf/pEXgF+gxJGGOlC8vjtpWf/NLXu9lwj/jnZvX9qYAgLCVK9UoXUKgrJPwg1NoSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaVet8ehaMtY7XGbOmyHgluXkg2+d2YtTKssbYy6nH0S/kAK1p
	zqEiMRmr2NpbH88ZCcnp4q8PsAvp2jD0tLissYNyhtPXC4FV0B3yXSgA2duHlj4=
X-Google-Smtp-Source: AGHT+IGmX/Y5Nn/D+9Dgd1fi5rbYMn6bnYjPv+H8S9zdxrz4eeR4wEDPd9VTtVytIy0D9wSIAHXZSw==
X-Received: by 2002:a17:90b:4b50:b0:2e0:d693:7884 with SMTP id 98e67ed59e1d1-2e1e620ea80mr9793642a91.5.1728143583780;
        Sat, 05 Oct 2024 08:53:03 -0700 (PDT)
Received: from abhash-IdeaPad-L340-15IRH-Gaming.. ([136.233.9.100])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2e20aebc40csm2008370a91.23.2024.10.05.08.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 08:53:03 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH v2 2/3] iio: light: vl6180: Added Interrupt support for single shot access
Date: Sat,  5 Oct 2024 21:22:24 +0530
Message-ID: <20241005155225.9239-3-abhashkumarjha123@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241005155225.9239-1-abhashkumarjha123@gmail.com>
References: <20241005155225.9239-1-abhashkumarjha123@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Configured the GPIO1 pin to provide output interrupts. And then the
interrupts are serviced in the `vl6180_measure` function when the
irq_handler signals that the reading is complete.

Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>
---
 drivers/iio/light/vl6180.c | 64 +++++++++++++++++++++++++++++++-------
 1 file changed, 52 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/light/vl6180.c b/drivers/iio/light/vl6180.c
index 401f13411..7630a7503 100644
--- a/drivers/iio/light/vl6180.c
+++ b/drivers/iio/light/vl6180.c
@@ -33,6 +33,7 @@
 #define VL6180_MODEL_ID_VAL 0xb4
 
 /* Configuration registers */
+#define VL6180_MODE_GPIO1 0x011
 #define VL6180_INTR_CONFIG 0x014
 #define VL6180_INTR_CLEAR 0x015
 #define VL6180_OUT_OF_RESET 0x016
@@ -70,6 +71,9 @@
 /* bits of the HOLD register */
 #define VL6180_HOLD_ON BIT(0)
 
+/* bit for enabling GPIO1 Interrupt Output */
+#define VL6180_GPIO1_INTR_OUT BIT(4)
+
 /* default value for the ALS_IT register */
 #define VL6180_ALS_IT_100 0x63 /* 100 ms */
 
@@ -86,6 +90,7 @@
 struct vl6180_data {
 	struct i2c_client *client;
 	struct mutex lock;
+	struct completion completion;
 	unsigned int als_gain_milli;
 	unsigned int als_it_ms;
 	unsigned int als_meas_rate;
@@ -211,6 +216,7 @@ static int vl6180_write_word(struct i2c_client *client, u16 cmd, u16 val)
 static int vl6180_measure(struct vl6180_data *data, int addr)
 {
 	struct i2c_client *client = data->client;
+	unsigned long time_left;
 	int tries = 20, ret;
 	u16 value;
 
@@ -221,19 +227,26 @@ static int vl6180_measure(struct vl6180_data *data, int addr)
 	if (ret < 0)
 		goto fail;
 
-	while (tries--) {
-		ret = vl6180_read_byte(client, VL6180_INTR_STATUS);
-		if (ret < 0)
-			goto fail;
-
-		if (ret & vl6180_chan_regs_table[addr].drdy_mask)
-			break;
-		msleep(20);
-	}
+	if (client->irq) {
+		reinit_completion(&data->completion);
+		time_left = wait_for_completion_timeout(&data->completion, HZ / 10);
+		if (time_left == 0)
+			return -ETIMEDOUT;
+	} else {
+		while (tries--) {
+			ret = vl6180_read_byte(client, VL6180_INTR_STATUS);
+			if (ret < 0)
+				goto fail;
+
+			if (ret & vl6180_chan_regs_table[addr].drdy_mask)
+				break;
+			msleep(20);
+		}
 
-	if (tries < 0) {
-		ret = -EIO;
-		goto fail;
+		if (tries < 0) {
+			ret = -EIO;
+			goto fail;
+		}
 	}
 
 	/* Read result value from appropriate registers */
@@ -478,6 +491,15 @@ static int vl6180_write_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static irqreturn_t vl6180_threaded_irq(int irq, void *priv)
+{
+	struct iio_dev *indio_dev = priv;
+	struct vl6180_data *data = iio_priv(indio_dev);
+
+	complete(&data->completion);
+	return IRQ_HANDLED;
+}
+
 static const struct iio_info vl6180_info = {
 	.read_raw = vl6180_read_raw,
 	.write_raw = vl6180_write_raw,
@@ -513,6 +535,11 @@ static int vl6180_init(struct vl6180_data *data)
 	if (ret != 0x01)
 		dev_info(&client->dev, "device is not fresh out of reset\n");
 
+	ret = vl6180_write_byte(client, VL6180_MODE_GPIO1,
+				VL6180_GPIO1_INTR_OUT);
+	if (ret < 0)
+		return ret;
+
 	/* Enable ALS and Range ready interrupts */
 	ret = vl6180_write_byte(client, VL6180_INTR_CONFIG,
 				VL6180_ALS_READY | VL6180_RANGE_READY);
@@ -579,6 +606,19 @@ static int vl6180_probe(struct i2c_client *client)
 	if (ret < 0)
 		return ret;
 
+	if (client->irq) {
+		ret = devm_request_threaded_irq(&client->dev, client->irq,
+						NULL, vl6180_threaded_irq,
+						IRQF_ONESHOT,
+						indio_dev->name, indio_dev);
+		if (ret) {
+			dev_err(&client->dev, "devm_request_irq error: %d\n", ret);
+			return ret;
+		}
+
+		init_completion(&data->completion);
+	}
+
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
-- 
2.43.0


