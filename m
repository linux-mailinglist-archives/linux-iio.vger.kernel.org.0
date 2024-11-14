Return-Path: <linux-iio+bounces-12282-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAF09C95EB
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2024 00:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C7E22816FC
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 23:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D391C07E6;
	Thu, 14 Nov 2024 23:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3oHEvhC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D731BF7E8;
	Thu, 14 Nov 2024 23:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731625833; cv=none; b=nJr3tohlCjQW5jBRXol/hqVzuRDtegEQEfG97HofWbFG3EDoA2gqcbEAEJgQyDXzATmwPjTNqOt0t2C5pM2LLTTM34jUVFEr33qTzqvOtsL5ffw4W9exyXY2LAugQxu71RGGDr/AVpLkEsZuaDEsG7EGiA9GpDbg7byZA0Px4u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731625833; c=relaxed/simple;
	bh=VTjudC1dZDTt9qTyghk+MnqF7fLa2Slp9EpRSzCv/Ec=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UTAdTRXaE8lTK9XFh0lTWUELGLGUHQFofYZg2mt3GhsGqm2qxJeIr+ozwJ2G/HMk1Z3F9KqZEo939nPaj53po40WhBqtR+mvhJ0RGUpentZS9xO1qIO64vEtDz6KfhVVc2Zou0NBxphRZMoZz6i3muJZjyWOntG+9h59EGIGCNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3oHEvhC; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d5045987dso63269f8f.1;
        Thu, 14 Nov 2024 15:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731625830; x=1732230630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mrVTxUcme1sdmvG64RbMNErOdNfzvL7ULZB0bFVTdEM=;
        b=G3oHEvhCiusyqOjSLnYJjDG3DmFOCVjHRvSy8kivjEvPA6dFiGgxbj3vmsNVcbCLvH
         5jnXIjhx7+nko3eyjyOGBUCSU1aLxqtXaRUFl6KdszmDUbYsRNvoaRnjj64p8y/iIexH
         TUWqK765AwN2TgG4kILMAwvLzvLk4vDNhAVb3e691sl2cQ+4QW3fsgYV2sdHVz8QLtZp
         2PUbmmRmiK7Rgo6lCLliuLHlLXrJEFNVQDwOm+sHvIoEG7HEwwRQMZNmcStIpwSpLkH9
         qUbr/us0ueV5bsR0rpfN3v2wo3E3Zjd/K8C4eTNuhkjDSy0Ynl8tOsgR9rGSIVGx0xCo
         4ZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731625830; x=1732230630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mrVTxUcme1sdmvG64RbMNErOdNfzvL7ULZB0bFVTdEM=;
        b=pyct0Rl9OxECjfmdzpBGU4XOqRTdFs4Ip3XwqbG8dw5rHjgkTnobD+3HLzknX8VOBk
         yghyK2xzANPVb037Jt5Ix+vizqZnkjwZikLvsoOJOBZRqsZZisuVPl/qEVVm76/frK61
         pOFinY423WLLPGAnswc+SgcWJLbkjVBrCs95OtKibOr6BXF1ZbeTmBwG4I1EdQYZ+Ggc
         PvoPRkjopH34A7kBMUaBWwL8iiLAJcmPCHvCUzTrMMumJ3FvI3lLtrCleGxUOjcLLmMA
         4H+FfuutUx/HJYDSp9VxwEUwUjZX+7T0pL0Uga0bFggX6/RuajN/N214UMclGUvxUZm6
         TlfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVS83T3oKopJsTaQPiXo2V/gE9eM2MqpqbjDQqapCKXEW9k9sKkedYeCYDNUN9SVDgOAp4lxy8kXEQU7Czj@vger.kernel.org, AJvYcCVU7YcT139IxiY9O72ewFZbXDAhAw31uj/s5SQzSFZwLvPKp81vwy+pO00xiVMArA2PA5Aizq76fZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYrVPPrXbhot8aq4fxlvRfKzDOKsCw6xYQz5LEiEwAGA3Vb1/c
	bZEAXNuJ/Te+sfgZZjJ0+ZB+iKVN+hWWZ48cv+mQrivXD/u7u3F7
X-Google-Smtp-Source: AGHT+IF6YX+xiD5e+PPFvGXH2KT7Dtg5yeTeDA+Q0+Hj0s45GLBOA0yx6RhApfclfpOr74kwaoS3bg==
X-Received: by 2002:a05:600c:4710:b0:42c:ba6c:d9a7 with SMTP id 5b1f17b1804b1-432df7878bcmr1570885e9.4.1731625829559;
        Thu, 14 Nov 2024 15:10:29 -0800 (PST)
Received: from 5dfbf0f66296.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab789fasm36464265e9.18.2024.11.14.15.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 15:10:28 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: l.rubusch@gmx.ch,
	Lothar Rubusch <l.rubusch@gmail.com>
Subject: [PATCH 14/22] iio: accel: adxl345: read FIFO entries
Date: Thu, 14 Nov 2024 23:09:54 +0000
Message-Id: <20241114231002.98595-15-l.rubusch@gmail.com>
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

Add a function to read the elements of the adxl345 FIFO. This will
flush the FIFO, and brings it into a ready state. The read out
is used to read the elemnts and to reset the fifo again. The cleanup
equally needs a read on the INT_SOURCE register.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index dbd07308a7..57bca112ea 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -140,6 +140,8 @@ struct adxl34x_state {
 	const struct adxl345_chip_info *info;
 	struct regmap *regmap;
 	struct adxl34x_platform_data data;  /* watermark, fifo_mode, etc */
+
+	__le16 fifo_buf[3 * ADXL34x_FIFO_SIZE] __aligned(IIO_DMA_MINALIGN);
 	u8 int_map;
 	bool fifo_delay; /* delay: delay is needed for SPI */
 	u8 intio;
@@ -321,6 +323,27 @@ static const struct attribute_group adxl345_attrs_group = {
 	.attrs = adxl345_attrs,
 };
 
+/**
+ * Read number of FIFO entries into *fifo_entries
+ */
+static int adxl345_get_fifo_entries(struct adxl34x_state *st, int *fifo_entries)
+{
+	unsigned int regval = 0;
+	int ret;
+
+	ret = regmap_read(st->regmap, ADXL345_REG_FIFO_STATUS, &regval);
+	if (ret) {
+		pr_warn("%s(): Failed to read FIFO_STATUS register\n", __func__);
+		*fifo_entries = 0;
+		return ret;
+	}
+
+	*fifo_entries = 0x3f & regval;
+	pr_debug("%s(): fifo_entries %d\n", __func__, *fifo_entries);
+
+	return 0;
+}
+
 static const struct iio_buffer_setup_ops adxl345_buffer_ops = {
 };
 
@@ -362,6 +385,7 @@ static irqreturn_t adxl345_trigger_handler(int irq, void *p)
 	struct iio_dev *indio_dev = ((struct iio_poll_func *) p)->indio_dev;
 	struct adxl34x_state *st = iio_priv(indio_dev);
 	u8 int_stat;
+	int fifo_entries;
 	int ret;
 
 	ret = adxl345_get_status(st, &int_stat);
@@ -379,9 +403,11 @@ static irqreturn_t adxl345_trigger_handler(int irq, void *p)
 		goto done;
 	}
 
-	if (int_stat & (ADXL345_INT_DATA_READY | ADXL345_INT_WATERMARK))
+	if (int_stat & (ADXL345_INT_DATA_READY | ADXL345_INT_WATERMARK)) {
 		pr_debug("%s(): WATERMARK or DATA_READY event detected\n", __func__);
-
+		if (adxl345_get_fifo_entries(st, &fifo_entries) < 0)
+			goto done;
+	}
 	goto done;
 done:
 
-- 
2.39.2


