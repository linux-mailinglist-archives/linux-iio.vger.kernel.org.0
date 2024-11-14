Return-Path: <linux-iio+bounces-12284-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B80E9C95EF
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2024 00:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75319B2403C
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 23:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3011C1F37;
	Thu, 14 Nov 2024 23:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7rRuZTn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167381C174A;
	Thu, 14 Nov 2024 23:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731625836; cv=none; b=LbFH+12op33JMyKdMVHyARTWdJ2QUheRuTZcC0l9XVYA44lssZp8uJlRaQUD0NNON1haYm+KvUsVisXC4I9nAYMk9BtHC0URdZwcvHUi+vP07mmvb7i4aAhWnx1F5fqda4zDtTk975oMdHi2Z4XUuQEIiQPBwIZlM74q2C33JdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731625836; c=relaxed/simple;
	bh=sY+Ab9dVCHVOyUUyEkNDMvcTT+/rCji8j1U9wYtsSQ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NFXNfSJei45JTIythYPaFh8rO87l9tFGSWknvG+BpCgKURdjmbZ7yTaArja9N0URNHyHIaaN1a4u9unKmrMWmDfQNOctdfFzg2LKfNbiTelWWa8/XJwFYV7wwJItm646XObWHTbvOddsYZYOPCj/ToLYPFRfP3SFWarDnfrEla0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P7rRuZTn; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43158124a54so1398135e9.3;
        Thu, 14 Nov 2024 15:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731625833; x=1732230633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gkksSsuxTUaRkIx07ILVW/vn6ACzPEWeMmqegAUVg0o=;
        b=P7rRuZTnCjTiysiU4uIDg7FhFOqgxMYwCxJFs92r+oVk8c0RvPs4YPJVTXV3StDN5E
         UIh3LVJcIWadcM1jc2rL37jCp5krmPlo3pOVL1uMJaAKV0m465hl8KSLlFVJxkGC1ZvY
         lK37MTavk2E+RrISOO7gkAv2qhMrEo+xhQLayTQGhsERRyErU/zSXNqbd4muwhjFny8z
         1X4cZKm9nVkJI/ANihzR9uUkYnWP119EXOf0S6M8GB6RdiTb13S15/T1eIw6wMmBGfej
         uEG8dddf26tqduxzXoGdwESZRh0++ubl5gnjhH4W94v2/Zar5/M+gmVxXdL8Xh5qG9LQ
         jmwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731625833; x=1732230633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gkksSsuxTUaRkIx07ILVW/vn6ACzPEWeMmqegAUVg0o=;
        b=sMcrIz3i7cjDMYE4I978iTuACDmZ3bQC5FJw0R4vMnOkFyurQK8V4uP0U5BguDW2yT
         6eHJYLXJoX/GoTw/Bd3V/zJiEOq2ApLLTZMgM3rfjCK5JgYWAv4D/+ntkbV3N4UOhH4N
         JeBH3OjCw0ybJr2m540UnyUCiyJPSeG8z+UG0MckZ70P/0Cm+jCXxYe+3p/AZLG3pg9f
         wnPC50IPVCdvbIQaukDRufWnfLGjnsspTYsONN0hqfCwxImwHCMRYf4Hh+s4M0tOlt0i
         MIlRkE1ExTCCwDNmbNxBHmZ41sZArA+8oV8O3zImaQ1mUD9wkbvmgLCpXQSWhOX2fSQK
         IyyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUR086+vhQriGUK23Vhl76BUKbrfhdXKmTryisigtfI04GFF0Loj2RymFEDcO29jzgN6zVFVguA7s=@vger.kernel.org, AJvYcCWrFzAzCYWN/qkCTFIiWBbCaE4PlJwlXqKptjaLPgZxArVzZqE3DbiNht7hwYDjkdPDvgv4lVxW7Vi7e5dk@vger.kernel.org
X-Gm-Message-State: AOJu0YwT5O2oB53khQs8kGG6vk8NOT/oSiYBukEbHuYrF3aqcm7QcJ2P
	H4z2i+vshaUHDuuBcHOgeWWrl6hKJP1GXciuTYaFHeg5b1/hqdHq
X-Google-Smtp-Source: AGHT+IEQizjoipF34T8Ul4oja7Vl7resZ4y7LdIl9j723eTo5dacvImb9Yj/esnYvSHKJf8+MWTasQ==
X-Received: by 2002:a05:600c:19cb:b0:42c:aeee:e603 with SMTP id 5b1f17b1804b1-432df78fd8dmr1619135e9.7.1731625833460;
        Thu, 14 Nov 2024 15:10:33 -0800 (PST)
Received: from 5dfbf0f66296.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab789fasm36464265e9.18.2024.11.14.15.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 15:10:32 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: l.rubusch@gmx.ch,
	Lothar Rubusch <l.rubusch@gmail.com>
Subject: [PATCH 16/22] iio: accel: adxl345: register trigger ops
Date: Thu, 14 Nov 2024 23:09:56 +0000
Message-Id: <20241114231002.98595-17-l.rubusch@gmail.com>
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

Add trigger options to the sensor driver. Reacting to the sensor events
communicated by IRQ, the FIFO handling and the trigger will be core
events for further feature implementation.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 34 ++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index ece28825fb..b917b02245 100644
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
@@ -415,6 +420,35 @@ static int adxl345_get_status(struct adxl34x_state *st, u8 *int_stat)
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
  * Interrupt handler used for several features of the ADXL345.
  * - DATA_READY / FIFO watermark
-- 
2.39.2


