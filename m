Return-Path: <linux-iio+bounces-10286-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 584BD993106
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 17:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68E461C22B83
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 15:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D251D9340;
	Mon,  7 Oct 2024 15:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXedQg/T"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E861D88CD;
	Mon,  7 Oct 2024 15:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728314563; cv=none; b=dHP/hLF5fdZDI6TsAqOnDKEQUaVt6SPc3TpIn3wOkMf2QIvbNzS4TsIAHDcEaIU8H0rPaRzcPECIoXcegcj3qOkJh6h/djxbFPJTDYuDYzucGw9vq2ABTV6t6jKz6onpgQOTGv2fGgl2P7XzQTb4G0takXRVflkn3ythBtGf49I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728314563; c=relaxed/simple;
	bh=y8fpYG9T60OwQP0aXJxzsXaodmkYPpmnD99lrwUmUdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VSXdgaAHmyF++qN1Ua0zQH+54zDiSAGxBXN7C9ojnm186HxTMgwww1bw76ZkYp2v51/TSa4VomBpxfrXwSFHS4UHQhfbfQm2vlmwclgBh7nQiCVsFYJ86BdUpTdxDERrSQTIOIJB5OjvR0ctNentnvmmgudjhKLKMzRU/jm7CCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NXedQg/T; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7e9f998e1e4so1645462a12.1;
        Mon, 07 Oct 2024 08:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728314560; x=1728919360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i6Q3pN7n5lzASa1iAB1h9SmIQ5Uey3Y3s1sa+1tGPWk=;
        b=NXedQg/TYx0tqyphiJbvyDoI0td2qT8voesamABCJvag1/+MvgIEVw/CLik9v7h/Xx
         Y5bA+xRIG9KYQk8cArE766gM3iUz7fK2gbukGvahYGYOYhXTh1U/Lm/TqhrMxdNwoTQJ
         bzSttaqe1/rzWJWBj7ptC947OwjS2YCx0x9HfOLgcsot8dadLt/6+AdHiIVOcEACB8j+
         e8Seq7y/q646CeJ0tj7gSLgBggbnxnByKm0QXk97zhEQfYdFLAfFYZkfVDRGHC4hmW44
         DWUTajz21UK4nEmKXSRmgha1SwDcydW+FEqaU5fQZnAmfCHxD2AYW7c1MN0hnh4HhU+A
         dvAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728314560; x=1728919360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i6Q3pN7n5lzASa1iAB1h9SmIQ5Uey3Y3s1sa+1tGPWk=;
        b=SlTmERBKtkk3qsMylGb1fs4TxawoeZdFZM5DI0qRO8sZNRcimIWhIz48mB11PBcixp
         9iiStsDH4GRrS26g3mCZNfN2oCHHCceyIjFlFHqDSYC/h1TkfOJXLDOxpDBuFBPce+qT
         u72pRfSyslt1uicrtmzrMROZqYvs3Hizvo+FqTVvk2NSAxmnWtEOCmUJ0FZ/cMaR6hnF
         iGn0CmrQwis8WfwsYYof34OSEblA2uY1nXWsJfiV44xaA9CcEeMWhoCtUj4cghj4TmNh
         G3Dg5T4wiINTppKrps8Idd9IsZfY2fIrDwY5NIR78wbqkeDS5CtvORfesoVv1E6yK5Fq
         IIxA==
X-Forwarded-Encrypted: i=1; AJvYcCWR6S4hwHhslwdzG9zx3B4XpujcUoBOFQjZHyps+/WKY7z2kmtSMvM11NOPilBx3VfwKXC3fjeQMWrFG1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwopVmx6dtisseCGv1uuSY2khNcTKqCacw1kwQTfPsHllPLnfJt
	7qjL/qpxvYwRX83vXIPOrM7w6PG90AavyXfQ22Uqzv/qTOSAkix37tCYeHWu/6s=
X-Google-Smtp-Source: AGHT+IGYgT9NDueQQjaefzAb7BVfyVAY1NDMIe8j7rhjYWE2AZ0lC9DdA3RTQrhsBA+X3+xTghmFjQ==
X-Received: by 2002:a17:90b:118c:b0:2d8:8d34:5b8 with SMTP id 98e67ed59e1d1-2e1e621da2dmr15358543a91.10.1728314560313;
        Mon, 07 Oct 2024 08:22:40 -0700 (PDT)
Received: from abhash-IdeaPad-L340-15IRH-Gaming.. ([136.233.9.100])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2e20ae7169esm5573934a91.10.2024.10.07.08.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 08:22:39 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH v3 2/3] iio: light: vl6180: Added Interrupt support for single shot access
Date: Mon,  7 Oct 2024 20:52:22 +0530
Message-ID: <20241007152223.59008-3-abhashkumarjha123@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241007152223.59008-1-abhashkumarjha123@gmail.com>
References: <20241007152223.59008-1-abhashkumarjha123@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The interrupts are serviced in the `vl6180_measure` function when the
irq_handler signals that the reading is complete. We now can read
asynchronously if `client->irq` is set.

Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>
---
 drivers/iio/light/vl6180.c | 54 +++++++++++++++++++++++++++++---------
 1 file changed, 42 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/light/vl6180.c b/drivers/iio/light/vl6180.c
index 67aa2f101..a747501b0 100644
--- a/drivers/iio/light/vl6180.c
+++ b/drivers/iio/light/vl6180.c
@@ -86,6 +86,7 @@
 struct vl6180_data {
 	struct i2c_client *client;
 	struct mutex lock;
+	struct completion completion;
 	unsigned int als_gain_milli;
 	unsigned int als_it_ms;
 	unsigned int als_meas_rate;
@@ -211,29 +212,38 @@ static int vl6180_write_word(struct i2c_client *client, u16 cmd, u16 val)
 static int vl6180_measure(struct vl6180_data *data, int addr)
 {
 	struct i2c_client *client = data->client;
+	unsigned long time_left;
 	int tries = 20, ret;
 	u16 value;
 
 	mutex_lock(&data->lock);
+	reinit_completion(&data->completion);
+
 	/* Start single shot measurement */
 	ret = vl6180_write_byte(client,
 		vl6180_chan_regs_table[addr].start_reg, VL6180_STARTSTOP);
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
@@ -484,6 +494,15 @@ static int vl6180_write_raw(struct iio_dev *indio_dev,
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
@@ -583,6 +602,17 @@ static int vl6180_probe(struct i2c_client *client)
 	if (ret < 0)
 		return ret;
 
+	if (client->irq) {
+		ret = devm_request_threaded_irq(&client->dev, client->irq,
+						NULL, vl6180_threaded_irq,
+						IRQF_ONESHOT,
+						indio_dev->name, indio_dev);
+		if (ret)
+			return dev_err_probe(&client->dev, ret, "devm_request_irq error \n");
+
+		init_completion(&data->completion);
+	}
+
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
-- 
2.43.0


