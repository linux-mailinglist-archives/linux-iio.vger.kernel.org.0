Return-Path: <linux-iio+bounces-12359-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8303A9D0521
	for <lists+linux-iio@lfdr.de>; Sun, 17 Nov 2024 19:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A901281A12
	for <lists+linux-iio@lfdr.de>; Sun, 17 Nov 2024 18:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058FE1DE3A2;
	Sun, 17 Nov 2024 18:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fAUOmzB1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9271DE2AD;
	Sun, 17 Nov 2024 18:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731868115; cv=none; b=m+IKgCxOPdzI/RLAuVHcvEi/JnMe9RqG5dmGQJZVD3+ZhaFT61jeh8q3TYZ3o3uxutF4QreK/UxMf/pkpTswbzieGeHwAzWpQAZNqFlAMhCAKde0ZMPomuFZNXIw9Lse/Z7a9OHg1SBrHtXCDAerJPzrgkh+OPniM3t4tSo0niM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731868115; c=relaxed/simple;
	bh=JZlG/xTON17p7l7Hp4Bnp0v9rZe7LzAWNREv7JADzcY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iZuw4Z410Y//Ha7+mvvkTNRB/qqZfl6qwLaWMy0UQkPpR77o5fbnbeseZEeDnuEKP8L+4HadsMjjunzL2eLN5qaDvIfUyDwNXEkGLU3bXkdHWhDO8PZAr8da+udEs6UFJVP4aBqzWlmCLvgLCm7UiDxsftaUPd6QdsjUYs4xmlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fAUOmzB1; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43159469053so1867545e9.2;
        Sun, 17 Nov 2024 10:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731868112; x=1732472912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WoJVYCc5Cph8evW04XEu0kI6t79l5EXNpiq8bQtMDqQ=;
        b=fAUOmzB1un0cvF3P8zOZKJQ1V4kS3w9ENO6VDCf3JC+VoTmEGpjmltm0jJ2RwFaTfm
         Ipqv3+TTcODZ7P1RaZ7Z1Z8zjzEvf1mk4x+lB8nn/x7ijq+x0754X8YQd+6LdFQI22JN
         sq+1HoERUsiCun0/8tLBzmQs8cyyHMrmvwU0NqRrKe7MuhOsibQELYBdJcQHBPbtSp48
         iLBL2vlP8zXBjslLE8Q8u9GPFbiKyVxdlasjfH+sP5j3kuzKM6e2w5oMyrDp3ZT7ZUCg
         AD75KgRnWsYoQ7Bw6MI5jXrxWc6yEfnIN1/TH79nyFt7fsLrXH1rlYFuwOdYLPvb2Oo0
         vkaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731868112; x=1732472912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WoJVYCc5Cph8evW04XEu0kI6t79l5EXNpiq8bQtMDqQ=;
        b=EyDrZQUxIEMHUO9leJobGDB/tcLjDx3skoTI70hc1eNlyh+PdCJQP+wpVjatN/TawQ
         0t18agCpuDREDRa13rxKosVoFVCv4cse/ODdmRctj15Pgu5pe1q+gd4aHhfYQrXL4ic1
         gFSOWT8gOMMHfOlyJTmy23pvfC5td1aPvre8RUfsVD98NeOpFNm7IiYnDJCYkI72Vyhd
         xyGbvVMP4UDPxAj9OUHDXgUiRA4zZraZ8tAfW2n+MZycF1Ezitb70ODoitBOjv1qQg1H
         cwokhaQwuaPx7KRcyzxEY6yBF4Wj4b6e1lyY+9mWWtg8q6wh6F7ME07XGAQv3saMY4zC
         N9Ow==
X-Forwarded-Encrypted: i=1; AJvYcCURSV5MJDzni7JL2Gw/vB/yO2HwyulKau3nQlEIIgR8yarCl/rGKMntMRXpg/K89V1hoIe/KEHgnKdGGyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHE8X/ET54uECk868ueTULaAyR/lRgoJxbETFR+Xr0ewrYK1IG
	g7xccEr1b5oDpoFqcJ5uBUtBjn7UBEsomrcpXxW8LOh25YKQpE9c
X-Google-Smtp-Source: AGHT+IEplyZrpL4JNBljp9Ae/vlJ8c5dvNSg8cfqnPer89vxT0vzgBthgijy7kM0bQCgyh61pUuy5g==
X-Received: by 2002:a05:6000:4808:b0:382:38e6:1eb4 with SMTP id ffacd0b85a97d-38238e6228emr1597165f8f.1.1731868112348;
        Sun, 17 Nov 2024 10:28:32 -0800 (PST)
Received: from 5dfbf0f66296.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3823f72441bsm3028137f8f.101.2024.11.17.10.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 10:28:32 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v2 16/22] iio: accel: adxl345: register trigger ops
Date: Sun, 17 Nov 2024 18:26:45 +0000
Message-Id: <20241117182651.115056-17-l.rubusch@gmail.com>
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

Add trigger options to the sensor driver. Reacting to the sensor events
communicated by IRQ, the FIFO handling and the trigger will be core
events for further feature implementation.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 34 ++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 82bd5c2b78..d58e1994ff 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -15,6 +15,9 @@
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/events.h>
+#include <linux/iio/kfifo_buf.h>
 #include <linux/iio/trigger.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
@@ -140,11 +143,13 @@ struct adxl34x_state {
 	const struct adxl345_chip_info *info;
 	struct regmap *regmap;
 	struct adxl34x_platform_data data;  /* watermark, fifo_mode, etc */
+	struct iio_trigger *trig_dready;
 
 	__le16 fifo_buf[3 * ADXL34x_FIFO_SIZE] __aligned(IIO_DMA_MINALIGN);
 	u8 int_map;
 	bool fifo_delay; /* delay: delay is needed for SPI */
 	u8 intio;
+	bool watermark_en;
 };
 
 #define ADXL34x_CHANNEL(index, reg, axis) {				\
@@ -432,6 +437,35 @@ static int adxl345_get_status(struct adxl34x_state *st, u8 *int_stat)
 	return 0;
 }
 
+/* data ready trigger */
+
+static int adxl345_trig_dready(struct iio_trigger *trig, bool state)
+{
+	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
+	struct adxl34x_state *st = iio_priv(indio_dev);
+
+	st->int_map = 0x00;
+	if (state) {
+		/* Setting also ADXL345_INT_DATA_READY results in just a single
+		 * generated interrupt, and no continuously re-generation. NB that the
+		 * INT_DATA_READY as well as the INT_OVERRUN are managed automatically,
+		 * setting their bits here is not needed.
+		 */
+		if (st->watermark_en)
+			st->int_map |= ADXL345_INT_WATERMARK;
+
+		pr_debug("%s(): preparing st->int_map 0x%02X\n",
+			 __func__, st->int_map);
+	}
+
+	return 0;
+}
+
+static const struct iio_trigger_ops adxl34x_trig_dready_ops = {
+	.validate_device = &iio_trigger_validate_own_device,
+	.set_trigger_state = adxl345_trig_dready,
+};
+
 /**
  * irqreturn_t adxl345_trigger_handler() - Interrupt handler used for several
  *                                         features of the ADXL345.
-- 
2.39.5


