Return-Path: <linux-iio+bounces-10135-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 239FD990707
	for <lists+linux-iio@lfdr.de>; Fri,  4 Oct 2024 17:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43ABB1C20BAD
	for <lists+linux-iio@lfdr.de>; Fri,  4 Oct 2024 15:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6F41C75E4;
	Fri,  4 Oct 2024 15:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TA64ujtq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2231C3053;
	Fri,  4 Oct 2024 15:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728054159; cv=none; b=uv4OjgHszFHWAhS87WLCIMXlBTBIhtvh39E2P85hz5IHhAFmBLgCRlwdWRPiHrcX5hqqE9nEwBxUNhkTzx8WrAoIScW0DCtqiRNsYV4PqAgOkGiyNCaQAx/7/J9Qd1PzCpWqwYEYf1SWyrvikcsIGcR2qRfz7KkrTxKYsO7bKKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728054159; c=relaxed/simple;
	bh=1QPDLs3MAqbXspdBmK3r2AssVDmePiOsOZc33gczOvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DyGyolC6OfKD+zJygWaEskT2NcU91Oq1TF/JuSDaYltcodFj2DH+xvVYgI96ULhpSJe0nzxZbL510nil0z+gb71EqRhAuEUsbiy6jLGmDF6K2g7xB6gGvE+vfNSnadNtOae59pq9cHnypsYBcLzW7a4YtyAxtclrKz8HLF1WnYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TA64ujtq; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7178df70f28so1981875b3a.2;
        Fri, 04 Oct 2024 08:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728054157; x=1728658957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=juxTMhYI61rMzzi75wKN/Dv12hzV7/kE6Qe6wu1IjGM=;
        b=TA64ujtqr0EKm1CFeMnnLIDLofbhveqdVhArtuUW6MCCiebzpg+Ux89NbJ7zZ9ow9W
         5thnDy3LhKiEo4wd+dtOKsnaxdx7vXf1Fe+QPeflSI1IKJrlIw+L3Y+9rA3uGPAJ6L6G
         z6zL8mildW6ez3VmPIU8mkhgaN9el5f4+oYDcAVg3Gr9OElnLpMG1/tACe90qEiN6Iw9
         57HmUNoV0aVPo/EawEZ+PPTvA9Q7Y6FTjjZqQgZIqp0MPhQOzNb3aZOmyAKFF7LDcVKj
         zCqr/6OtL3Rt/OIGkqvfpK/O1WRS5ieV+rDYEAfrmt2uN4rNdjSg8ZFRN309tChDj9Sl
         L+Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728054157; x=1728658957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=juxTMhYI61rMzzi75wKN/Dv12hzV7/kE6Qe6wu1IjGM=;
        b=pSfyolDqjmxOQNHR1O1EmSjj3xM/sxZUQKsSF+nhKOM0rLj7b4J703nBVMfzLhyXFB
         yIPZephyll2ga43zahu15jlhbofACUXRTeVIBsdl9DWzSKqRTBOTl67F7dxJnYNLZoQJ
         nTWghpFUiF30xQ1NugwoKhyrnEwI6qNjX4TtW8BLAxCX7tFU7OKRav5egkxZ++w7ahH1
         CaRlND8mxBCAJgxn41tqbilXyPY2YXkNc9iQiUlGoIBW4Pnjw3qI1OOskWUlEERQtDd+
         KOdt+rA6atu2i195kn0H3iCsI0nKPFAyKYAd6ZjBjSmVYWtDGmlMj7jk0qam1Jk0oSAq
         znrA==
X-Forwarded-Encrypted: i=1; AJvYcCXdN6Roobbt03/KTrFPkZ/bbUWd/z6vkW8B99ggA/mz/Jxu096q41TM1as+sx/CNRLvBWeoxRQHPdyfh1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWZCHh7d9E2AtN0hH5nZTdOEKO/2LZeDNMcFCRBIBkXAxNQDpU
	Ploy9r4bzg0Z0ERn2dHM0gFsYOjf2WBlTz8oVnxDBg7FoGgKrXJK46DMojMXNtI=
X-Google-Smtp-Source: AGHT+IHIbhwida7fs1g89tC4oLSfuYKdy15rti6QzwxlcjO3KsxZofa15kj7Gl3wLKtapAsw9OtHCA==
X-Received: by 2002:a05:6a00:4fd3:b0:714:3de8:a616 with SMTP id d2e1a72fcca58-71de2449f43mr4365380b3a.19.1728054156668;
        Fri, 04 Oct 2024 08:02:36 -0700 (PDT)
Received: from abhash-IdeaPad-L340-15IRH-Gaming.. ([136.233.9.100])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-7e9f6c34127sm19979a12.67.2024.10.04.08.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 08:02:36 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH 2/3] iio: light: vl6180: Added Interrupt support for single shot access
Date: Fri,  4 Oct 2024 20:31:47 +0530
Message-ID: <20241004150148.14033-3-abhashkumarjha123@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004150148.14033-1-abhashkumarjha123@gmail.com>
References: <20241004150148.14033-1-abhashkumarjha123@gmail.com>
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
index 52a837644..4c2b486e2 100644
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
+		time_left = wait_for_completion_timeout(&data->completion, HZ/10);
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
@@ -479,6 +492,15 @@ static int vl6180_write_raw(struct iio_dev *indio_dev,
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
@@ -514,6 +536,11 @@ static int vl6180_init(struct vl6180_data *data)
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
@@ -580,6 +607,19 @@ static int vl6180_probe(struct i2c_client *client)
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


