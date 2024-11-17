Return-Path: <linux-iio+bounces-12358-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3369D051F
	for <lists+linux-iio@lfdr.de>; Sun, 17 Nov 2024 19:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D183B22AFC
	for <lists+linux-iio@lfdr.de>; Sun, 17 Nov 2024 18:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2DA1DDC38;
	Sun, 17 Nov 2024 18:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSUvfpdy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766EE1DDC3B;
	Sun, 17 Nov 2024 18:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731868115; cv=none; b=NcHuX+dAjUQOF4SraoSD+2d1Bt0oRwcs/lwNgScuaZNEoJC72xij2r6knqisw1MB+g6pfHlanQZ46QXFT6ND9M/Asirh1jBvLSLj0o5BFWqntuyPdJUjaGihblwJmcIKh6KwyNHdkuxBHqG+yW80TDPuR9G5+87mFhRM1zNzZk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731868115; c=relaxed/simple;
	bh=Gjs9Jn5a2HaBikdNqoDNQRf3a6i6txlmu3uxs5utFNw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EMwAcRiWu02YxuFCPc0fqiou0dFQwi9nRo6WgL5d0llneyYXTbG/Tbxs7lDe18UVh6p+4cRgB7V0LKZt0R18VZk6mQuR3ZUKbrY2xALfTmDHfTlm0E4Tbjrr6xZJpHNyX3Dul0hJNLtRcwHLxjnRyv5aAdGX99DmaE2Rt/oi4gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QSUvfpdy; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4315b0bd4ddso3683935e9.3;
        Sun, 17 Nov 2024 10:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731868112; x=1732472912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T72WGs96X/hPhNiSqEgMrEGXOhYafIkOIpYDkBun90U=;
        b=QSUvfpdyBJp2KD1beMSDJgPshTYXtv5Zptehc1x6SM91hUWXgnBvQMJM4thO5PPMB7
         2zsTMZGS2BImipUBQ/DHvpoUTS/SN28BnZ3cM+uKoSfT5WlVZwSj9FDTRZXpYLZMUH+K
         b/vw3oxZcWbcQajRwTwPaIWxwz7+pp59hYIZbaQ14Md79sm4Tk4/IWwV7Qu3lavMA3Mk
         Tpth4MoEl8X8xKz8qjwctUFgCkIRNRnLOMOvUMGTOfEnk9xTD2XjsO/Ud2dNd8zpHRof
         YdSNdPtjF90+e0EzbQkGPTOcr/OrAfW0g8NeKd/l0nIUeGgaX1kPeInVBymPGX+lIyf9
         ViDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731868112; x=1732472912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T72WGs96X/hPhNiSqEgMrEGXOhYafIkOIpYDkBun90U=;
        b=VCpoKVc3Na650iu2GnljLcAs2oNF/UlaOpdhmhn/mnDBsgayknrHq9YX0gG31JeCII
         ftjiUw7N6pZX5i1hnVPGgNAiqDHCwKdZL6iNRJj9+JqP3ok6APGQO55UIgEn6yuH0LJH
         4brRHs3XuH3cJFj0hwFz0KW63QBm+Pc1DPmN5Grwu0YRzGlI3yQbBoPXsh9tT2WUxHyP
         K4UDGgX+Xo8cUZi3WpuuvguweFk4Dz4xJIWhv9JRrk+LV3ZfD48Bh1SkbC6XQhunWx5j
         z2+Y3O2b/P0eDPwa92kDLCFTN2yrLJQu92SbVc1yyzML/6GagJ2IgHNFn0q2I5QGA4n5
         ZzGw==
X-Forwarded-Encrypted: i=1; AJvYcCV0hxFoNXcyCzn5mhXlzmuxPETFeJFXyt/JWhna6uXGD1jghAd+u1Tyw2/tWqgkziMQ2T5mR+UiW9VOmPM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3wBiCqJDT2SIiRWBOLXyA7rVl7q7zWr87qbSrvqAMyIOghQx/
	x9G0EJ8fAPybQ/FdwB6Gv3dxWx2LTw89u4EllP/PJypiT1v+aVMz
X-Google-Smtp-Source: AGHT+IEaW8pRvxt6IR0x878eounjn7Q2WmS9uK8UZtire9MBxFfWVONVUhTCXRwj030CU/7vEE9SRQ==
X-Received: by 2002:a05:600c:1c83:b0:42c:b63d:df3 with SMTP id 5b1f17b1804b1-432df680b0bmr35313155e9.0.1731868111439;
        Sun, 17 Nov 2024 10:28:31 -0800 (PST)
Received: from 5dfbf0f66296.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3823f72441bsm3028137f8f.101.2024.11.17.10.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 10:28:31 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v2 15/22] iio: accel: adxl345: reset the FIFO on error
Date: Sun, 17 Nov 2024 18:26:44 +0000
Message-Id: <20241117182651.115056-16-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241117182651.115056-1-l.rubusch@gmail.com>
References: <20241117182651.115056-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a function to empty the FIFO and reset the INT_SOURCE register.
Reading out is used to reset the fifo again. For cleanup also a read
on the INT_SOURCE register is needed to allow the adxl345 to issue
interrupts again. Without clearing the fields no further interrupts
will happen.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 75 ++++++++++++++++++++++++++++----
 1 file changed, 67 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 40e78dbdb0..82bd5c2b78 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -356,6 +356,61 @@ static int adxl345_get_fifo_entries(struct adxl34x_state *st, int *fifo_entries)
 	return 0;
 }
 
+/**
+ * adxl345_read_fifo_elements() - Read fifo_entries number of elements.
+ * @st: The instance of the state object of this sensor.
+ * @fifo_entries: The number of lines in the FIFO referred to as fifo_entry,
+ * a fifo_entry has 3 elements for X, Y and Z direction of 2 bytes each.
+ *
+ * The FIFO of the sensor is read linewise. The read measurement values are
+ * queued in the corresponding data structure in *st.
+ *
+ * It is recommended that a multiple-byte read of all registers be performed to
+ * prevent a change in data between reads of sequential registers. That is to
+ * read out the data registers X0, X1, Y0, Y1, Z0, Z1 at once.
+ *
+ * Return: 0 or error value.
+ */
+static int adxl345_read_fifo_elements(struct adxl34x_state *st, int fifo_entries)
+{
+	size_t count, ndirs = 3;
+	int i, ret;
+
+	count = 2 * ndirs; /* 2 byte per direction */
+	for (i = 0; i < fifo_entries; i++) {
+		ret = regmap_noinc_read(st->regmap, ADXL345_REG_XYZ_BASE,
+				st->fifo_buf + (i * count / 2), count);
+		if (ret) {
+			pr_warn("%s(): regmap_noinc_read() failed\n", __func__);
+			return -EFAULT;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * adxl345_empty_fifo() - Empty the FIFO.
+ * @st: The instance to the state object of the sensor.
+ *
+ * Reading all elements of the FIFO linewise empties the FIFO. Reading th
+ * interrupt source register resets the sensor. This is needed also in case of
+ * overflow or error handling to reenable the sensor to issue interrupts.
+ */
+static void adxl345_empty_fifo(struct adxl34x_state *st)
+{
+	int regval;
+	int fifo_entries;
+
+	/* In case the HW is not "clean" just read out remaining elements */
+	adxl345_get_fifo_entries(st, &fifo_entries);
+	if (fifo_entries > 0)
+		adxl345_read_fifo_elements(st, fifo_entries);
+
+	/* Reset the INT_SOURCE register by reading the register */
+	regmap_read(st->regmap, ADXL345_REG_INT_SOURCE, &regval);
+}
+
 static const struct iio_buffer_setup_ops adxl345_buffer_ops = {
 };
 
@@ -401,30 +456,34 @@ static irqreturn_t adxl345_trigger_handler(int irq, void *p)
 
 	ret = adxl345_get_status(st, &int_stat);
 	if (ret < 0)
-		goto done;
+		goto err;
 
 	/* Ignore already read event by reissued too fast */
 	if (int_stat == 0x0)
-		goto done;
+		goto err;
 
 	/* evaluation */
 
 	if (int_stat & ADXL345_INT_OVERRUN) {
 		pr_debug("%s(): OVERRUN event detected\n", __func__);
-		goto done;
+		goto err;
 	}
 
 	if (int_stat & (ADXL345_INT_DATA_READY | ADXL345_INT_WATERMARK)) {
 		pr_debug("%s(): WATERMARK or DATA_READY event detected\n", __func__);
 		if (adxl345_get_fifo_entries(st, &fifo_entries) < 0)
-			goto done;
-	}
-	goto done;
-done:
+			goto err;
 
-	if (indio_dev)
 		iio_trigger_notify_done(indio_dev->trig);
+	}
 
+	goto done;
+err:
+	iio_trigger_notify_done(indio_dev->trig);
+	adxl345_empty_fifo(st);
+	return IRQ_NONE;
+
+done:
 	return IRQ_HANDLED;
 }
 
-- 
2.39.5


