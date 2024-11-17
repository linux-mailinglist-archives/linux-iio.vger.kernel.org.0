Return-Path: <linux-iio+bounces-12354-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA489D0517
	for <lists+linux-iio@lfdr.de>; Sun, 17 Nov 2024 19:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB32E1F20FE0
	for <lists+linux-iio@lfdr.de>; Sun, 17 Nov 2024 18:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C20C1DDA3D;
	Sun, 17 Nov 2024 18:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmO5bc1V"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFF11DD9D1;
	Sun, 17 Nov 2024 18:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731868110; cv=none; b=sMb3GIUXeDY4reE8vjzpX/zXnvzJOqdBp2aUkH8vHmcJNEAvVotFFCt3x4whNln3EcwLOkonDJAUwS4xqNlxhaXKx0WE2r0n9L4hW1I+ehWaz2GidrzEE33qISyqgMe0vM19wB4nplZXC+R40B911CuYcAQO3gzRRSu3kq3Ddm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731868110; c=relaxed/simple;
	bh=p48hX7DozsNTbQ0ynKBuWkKZ0T+mYNhWVNO4AfsJdOI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LPFjvRy1RgX2Mm0anQDpCGBc/Gh4nlg3s/cm4qoTye8Q8wGN5pvDZD1vBkLnuS7fCp5PBG0l2MgG7r4NBvt3OnLYJpHd0x4cgPrJVjaxuzTEnTLAZpA4rPUFyhJJavItPF0Elpe8WlgvXyuqPid0ZB6SXtBjQhAhw9laa1KFQwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fmO5bc1V; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4315dfa3e0bso2241185e9.0;
        Sun, 17 Nov 2024 10:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731868107; x=1732472907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2/uskBaS7mbhCAG/rFrauB7qEmDpyzXnB8FlpPp8d/I=;
        b=fmO5bc1ViL/oWFxG9pUJebzpTB+8m0HA1+FEDzkAsbB5nMVXkm055WwYnk+lCxojeU
         noYacI1MmOSJ4jezF7HRGakYoB4Jt17o3wiLTV3kbFBNkpoUsoyLV2FtB//PNRaYoPYM
         pT91YQp8rteo/8LAffSolNyl1kZr5Jca09n4ESgnAdzoCvxUWFbX+kdRHyvry3JyQYH9
         VAivN57WFEm1d4Dn5xkq1Q+fJL8rLgVQYzReFrT+ZWPyxCtZCPKcrYc81MpCXUhhxRTq
         Xm274BOfaofbnwzWgHPuvYfbyuhF9PKM7v7WEPsYKDsJEqBHXcP7g7CfstgKVoKXA5am
         3H2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731868107; x=1732472907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2/uskBaS7mbhCAG/rFrauB7qEmDpyzXnB8FlpPp8d/I=;
        b=W7q1jZq69S1ILolHzCrTHIH8rAlei0/fQyYlXHaZMc2GGAiBcbetdroW86hZj/YG+h
         gpGw+NfOQLwXLKsPH44YiNWaFR2xsGLpoprvs2x3/Q0FU2ZriJPTRCBkLdaMl97jcXoP
         BhFZzARHpstgkHnvAj3hXgY3xm41jlvHtfO7FVuBXISkAAhAF5WtWmXDSz+7mSR1XRGT
         DsZED5kypBHdqbRozhgGsM2vn1NclTK9uQ914RZNQuxzfjdsu+dFn23IlOwES7bo9Lnl
         xl7Ft7X5sXZRIdftXgYQPqPywdbpqVFGXcoG5zi5OKNezRlCQxN96rGP3i1qFV7M6mcM
         MKVA==
X-Forwarded-Encrypted: i=1; AJvYcCV9s+kFH4tLg+yr5nSDE+EmoBM3DpQPsvAwiducVEwTeSOba2CYRbs+tICpYlffiOMh7wTJL2FWQZinS1g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvdl27m+vXOcqJqBx0nJnxt9NJNdHc8MlVvatxnbiKwQPc0fBB
	0nAD7fDJTTvRoTUmq5SUMHlillyxBXUfWg2rkV9lsyDd78pfzkFz
X-Google-Smtp-Source: AGHT+IFP21JkfuJkf7urhHqBZy12c2BFZ34UbDOKW/5jBUZ5QBVW9RmtlY1hWYlphbFphH0qjePlrw==
X-Received: by 2002:a5d:64e5:0:b0:37d:4aa2:5cfe with SMTP id ffacd0b85a97d-38225a04721mr3479958f8f.6.1731868107311;
        Sun, 17 Nov 2024 10:28:27 -0800 (PST)
Received: from 5dfbf0f66296.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3823f72441bsm3028137f8f.101.2024.11.17.10.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 10:28:26 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v2 11/22] iio: accel: adxl345: import adxl345 general data
Date: Sun, 17 Nov 2024 18:26:40 +0000
Message-Id: <20241117182651.115056-12-l.rubusch@gmail.com>
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

Use struct adxl34x_platform_data from the included public header of the
input driver for ADXL34x with the following argumentation for this
approach:

- The iio driver for the ADXL34x covers features also implemented in
  the older input driver. The iio driver will implement the same
  features but can also benefit from including the common header and
  struct adxl34x_platform_data. Once complete, the input driver could
  be faded out.

- The fields in the input driver are identical to the fields the IIO
  implementation will need. Including the header over reimplementing,
  avoids a duplication of almost identical headers in IIO and iio.

- The header for the input driver is public. It provides a public
  interface for adxl34x related implementation and is not private to
  the input system.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 32163cfe6f..b16887ec1c 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -16,6 +16,8 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 
+#include <linux/input/adxl34x.h>
+
 #include "adxl345.h"
 
 /* ADXL345 register map */
@@ -126,10 +128,15 @@
  */
 #define ADXL34x_FIFO_SIZE  33
 
+static const struct adxl34x_platform_data adxl345_default_init = {
+	.tap_axis_control = ADXL_TAP_X_EN | ADXL_TAP_Y_EN | ADXL_TAP_Z_EN,
+};
+
 struct adxl34x_state {
 	int irq;
 	const struct adxl345_chip_info *info;
 	struct regmap *regmap;
+	struct adxl34x_platform_data data;  /* watermark, fifo_mode, etc */
 	bool fifo_delay; /* delay: delay is needed for SPI */
 	u8 intio;
 };
@@ -331,6 +338,7 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 	unsigned int data_format_mask = (ADXL345_DATA_FORMAT_RANGE |
 					 ADXL345_DATA_FORMAT_FULL_RES |
 					 ADXL345_DATA_FORMAT_SELF_TEST);
+	const struct adxl34x_platform_data *data;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
@@ -346,6 +354,16 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 		return -ENODEV;
 
 	st->fifo_delay = fifo_delay_default;
+	data = dev_get_platdata(dev);
+	if (!data) {
+		dev_dbg(dev, "No platform data: Using default initialization\n");
+		data = &adxl345_default_init;
+	}
+	st->data = *data;
+
+	/* some reasonable pre-initialization */
+	st->data.act_axis_control = 0xFF;
+
 	st->intio = ADXL345_INT1;
 
 	indio_dev->name = st->info->name;
-- 
2.39.5


