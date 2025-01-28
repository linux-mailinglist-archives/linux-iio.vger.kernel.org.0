Return-Path: <linux-iio+bounces-14663-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8E7A20A14
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jan 2025 13:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6524F7A4906
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jan 2025 12:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA931A23BB;
	Tue, 28 Jan 2025 12:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JyR1UtDf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6867F19D8AC;
	Tue, 28 Jan 2025 12:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738065696; cv=none; b=VmgCnkrdUDNOPHDKqaEYhe4ekzPxBAK9OLXqiV5Fu1iHFdxMTZlc8F0mUZyhu4MmCgLqUmY8Ix4GPLGvKeOf+nR+/pTtVM7+BgW1v02UCotoHtFRU/vZyoQsj6R6Pio/6Ht+hPWEV4ICGJbzU2ZiLy7BjodVNKMVWjsm+h6julM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738065696; c=relaxed/simple;
	bh=A6D/dIr0/roT1Guo5HT4UUonoFll5nlYZUMj5aI4+Qs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uuDMADKx3EvSVf0hjTp2RbRvOKIqb7NV1iu0QBqXhOZ3IP6f/3lZzGZ10M4Np5gTcWuLbLL5o1c/CeGWPcpiFsJ/jjzSaIV9hERTs1obzYbBc7Xp16mF2lTfRN3uzsDHuoOWV1JMsUkf3fllmrWpXyOZlT1E5yOSdpktZUYWrQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JyR1UtDf; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5db67d1bf0bso1487293a12.0;
        Tue, 28 Jan 2025 04:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738065693; x=1738670493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gfLycUoqALpenZs1PCwcqht3zj/rDndi4N2W7Tr/X5g=;
        b=JyR1UtDf4LKradl403ZoNur3BYRVD1sPhn43uOU9DmhNWIIRLqTRiGgN/d4+tF0M9R
         FL/KvyYDlaYPnRh0xpXqDSvu3bzDAeyhjWJ8I3uVvop0uDFZ0klvd2Dfj7axey5sXakP
         fcw9HJCCr9af6UEgdUBWWqRImJP4F6sYfpvogxfyH1uQKhGUc5Nz2SaLvejhl78mMF0+
         17N7t6ULboQlGfXGJGq/av5j1NLxLqIxaanpcnx6vqe0mR2N5orSdNEPCaer9J0dFCH7
         iw84t7LAS3rScQYdWQ/LNXL8vSx2ExUnpLkX7X04MWbNUpH5g0/g6vI8UeRiaVNYTCEU
         qSFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738065693; x=1738670493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gfLycUoqALpenZs1PCwcqht3zj/rDndi4N2W7Tr/X5g=;
        b=PhjPcwXcqXfxf3AdYJv/8IA8yvMWdvUsNDCg3Q5g0tSoG5ZamAmCvo1cGbH7MsbS1r
         d2MFhp1GXF1r1DqyumF/0odGUb15gNDd1vIAFUhJRfTAJ7fYiloUKQ82tKrxLeKxsNHt
         dVHI2kIzJG5QTz0dCxdGAnwFiuWAi7SYEMJvpJW0QctxAMBANd8IBvUFjzjMuwgWmp3f
         E8vecqbeH3In1aABxHYJJJrt4uvA1uX6fSakDctyUqJSiblayHCQwyU8b1aaEqNGKcjy
         NN2cicqQlnRbyE5grxwe+j/4pBkXKBhxQK7A1y9VPKuDhyck8gTE32CUEDCAKOXAQPFT
         sYEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDgZPiD3yEuS6+cwr86Et52Ipq3OVQaehUU+DnMFE5dU9ff0nJUDnD0er7fGB5YxLtk457rgRMzdC2/qw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCEkNf5bKbxwuqQgJIItkBgItzTY7hZJguPszhFVjBbRy/nfxc
	VZTuQmTTDBVUwa4Te/30qA87QNHfk1VtJ0G3h+Rqg9aLLCOrDO4F
X-Gm-Gg: ASbGncv1vNjlvMDmWuGWRI1gpKv2YJqKKFM0/bvAPs+AeDtDLNxVI2yIvDR8+cU22Nf
	qQL6kN2qmWi3coo0LCipUQA/mI6Sff7FNiM+wb/2uoniXEcxU7T8U8nTxyKxHAV/6EsEnSrchSE
	o5fIhNUBemQ8L8GI5CNPsSQhEc/rP41AD36E7wrqRYqbhB09NgQr/5QRGVOb2oXgVPz4BEMRVHa
	UqlZlw8jLe7tru4QsUr13DqXRIgcGLvnpECdy9b+NQZ8X1NgRr1XkDctSe9pMm/46HAImjpYyoY
	pg+gClvIz2qWKUAezOuPxssW2P/hidXCZXxrb+qjd6WRFEGj4DYN62ecuPohTx6ux58Ayg==
X-Google-Smtp-Source: AGHT+IEPSEyamTIjx/62Tk90uhAgRgiRetjPvgDhLOHVt+lqH5u7gpw5a3DIeL3Cl1F3SURJgos46w==
X-Received: by 2002:a17:907:948a:b0:aa6:6792:8bce with SMTP id a640c23a62f3a-ab38b1b6f43mr1423097966b.3.1738065692393;
        Tue, 28 Jan 2025 04:01:32 -0800 (PST)
Received: from d9dabf0abd47.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab69f8555b7sm418865966b.71.2025.01.28.04.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 04:01:31 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v1 01/12] iio: accel: adxl345: migrate constants to core
Date: Tue, 28 Jan 2025 12:00:49 +0000
Message-Id: <20250128120100.205523-2-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250128120100.205523-1-l.rubusch@gmail.com>
References: <20250128120100.205523-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The set of constants does not need to be exposed. Move constants to core
to reduce namespace polution.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345.h      | 86 ------------------------------
 drivers/iio/accel/adxl345_core.c | 91 +++++++++++++++++++++++++++++++-
 2 files changed, 89 insertions(+), 88 deletions(-)

diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
index 517e494ba555..b5257dafb742 100644
--- a/drivers/iio/accel/adxl345.h
+++ b/drivers/iio/accel/adxl345.h
@@ -8,94 +8,8 @@
 #ifndef _ADXL345_H_
 #define _ADXL345_H_
 
-#define ADXL345_REG_DEVID		0x00
-#define ADXL345_REG_THRESH_TAP		0x1D
-#define ADXL345_REG_OFSX		0x1E
-#define ADXL345_REG_OFSY		0x1F
-#define ADXL345_REG_OFSZ		0x20
-#define ADXL345_REG_OFS_AXIS(index)	(ADXL345_REG_OFSX + (index))
-
-/* Tap duration */
-#define ADXL345_REG_DUR		0x21
-/* Tap latency */
-#define ADXL345_REG_LATENT		0x22
-/* Tap window */
-#define ADXL345_REG_WINDOW		0x23
-/* Activity threshold */
-#define ADXL345_REG_THRESH_ACT		0x24
-/* Inactivity threshold */
-#define ADXL345_REG_THRESH_INACT	0x25
-/* Inactivity time */
-#define ADXL345_REG_TIME_INACT		0x26
-/* Axis enable control for activity and inactivity detection */
-#define ADXL345_REG_ACT_INACT_CTRL	0x27
-/* Free-fall threshold */
-#define ADXL345_REG_THRESH_FF		0x28
-/* Free-fall time */
-#define ADXL345_REG_TIME_FF		0x29
-/* Axis control for single tap or double tap */
-#define ADXL345_REG_TAP_AXIS		0x2A
-/* Source of single tap or double tap */
-#define ADXL345_REG_ACT_TAP_STATUS	0x2B
-/* Data rate and power mode control */
-#define ADXL345_REG_BW_RATE		0x2C
-#define ADXL345_REG_POWER_CTL		0x2D
-#define ADXL345_REG_INT_ENABLE		0x2E
-#define ADXL345_REG_INT_MAP		0x2F
-#define ADXL345_REG_INT_SOURCE		0x30
-#define ADXL345_REG_INT_SOURCE_MSK	0xFF
 #define ADXL345_REG_DATA_FORMAT		0x31
-#define ADXL345_REG_XYZ_BASE		0x32
-#define ADXL345_REG_DATA_AXIS(index)				\
-	(ADXL345_REG_XYZ_BASE + (index) * sizeof(__le16))
-
-#define ADXL345_REG_FIFO_CTL		0x38
-#define ADXL345_FIFO_CTL_SAMPLES_MSK	GENMASK(4, 0)
-/* 0: INT1, 1: INT2 */
-#define ADXL345_FIFO_CTL_TRIGGER_MSK	BIT(5)
-#define ADXL345_FIFO_CTL_MODE_MSK	GENMASK(7, 6)
-#define ADXL345_REG_FIFO_STATUS	0x39
-#define ADXL345_REG_FIFO_STATUS_MSK	0x3F
-
-#define ADXL345_INT_OVERRUN		BIT(0)
-#define ADXL345_INT_WATERMARK		BIT(1)
-#define ADXL345_INT_FREE_FALL		BIT(2)
-#define ADXL345_INT_INACTIVITY		BIT(3)
-#define ADXL345_INT_ACTIVITY		BIT(4)
-#define ADXL345_INT_DOUBLE_TAP		BIT(5)
-#define ADXL345_INT_SINGLE_TAP		BIT(6)
-#define ADXL345_INT_DATA_READY		BIT(7)
-
-/*
- * BW_RATE bits - Bandwidth and output data rate. The default value is
- * 0x0A, which translates to a 100 Hz output data rate
- */
-#define ADXL345_BW_RATE			GENMASK(3, 0)
-#define ADXL345_BW_LOW_POWER		BIT(4)
-#define ADXL345_BASE_RATE_NANO_HZ	97656250LL
-
-#define ADXL345_POWER_CTL_STANDBY	0x00
-#define ADXL345_POWER_CTL_WAKEUP	GENMASK(1, 0)
-#define ADXL345_POWER_CTL_SLEEP	BIT(2)
-#define ADXL345_POWER_CTL_MEASURE	BIT(3)
-#define ADXL345_POWER_CTL_AUTO_SLEEP	BIT(4)
-#define ADXL345_POWER_CTL_LINK		BIT(5)
-
-/* Set the g range */
-#define ADXL345_DATA_FORMAT_RANGE	GENMASK(1, 0)
-/* Data is left justified */
-#define ADXL345_DATA_FORMAT_JUSTIFY	BIT(2)
-/* Up to 13-bits resolution */
-#define ADXL345_DATA_FORMAT_FULL_RES	BIT(3)
 #define ADXL345_DATA_FORMAT_SPI_3WIRE	BIT(6)
-#define ADXL345_DATA_FORMAT_SELF_TEST	BIT(7)
-#define ADXL345_DATA_FORMAT_2G		0
-#define ADXL345_DATA_FORMAT_4G		1
-#define ADXL345_DATA_FORMAT_8G		2
-#define ADXL345_DATA_FORMAT_16G		3
-
-#define ADXL345_DEVID			0xE5
-#define ADXL345_FIFO_SIZE		32
 
 /*
  * In full-resolution mode, scale factor is maintained at ~4 mg/LSB
diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index ed0291bea0f5..ffdb03ed7a25 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -14,13 +14,100 @@
 #include <linux/regmap.h>
 #include <linux/units.h>
 
-#include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
 #include <linux/iio/buffer.h>
+#include <linux/iio/iio.h>
 #include <linux/iio/kfifo_buf.h>
+#include <linux/iio/sysfs.h>
 
 #include "adxl345.h"
 
+#define ADXL345_REG_DEVID		0x00
+#define ADXL345_REG_THRESH_TAP		0x1D
+#define ADXL345_REG_OFSX		0x1E
+#define ADXL345_REG_OFSY		0x1F
+#define ADXL345_REG_OFSZ		0x20
+#define ADXL345_REG_OFS_AXIS(index)	(ADXL345_REG_OFSX + (index))
+
+/* Tap duration */
+#define ADXL345_REG_DUR			0x21
+/* Tap latency */
+#define ADXL345_REG_LATENT		0x22
+/* Tap window */
+#define ADXL345_REG_WINDOW		0x23
+/* Activity threshold */
+#define ADXL345_REG_THRESH_ACT		0x24
+/* Inactivity threshold */
+#define ADXL345_REG_THRESH_INACT	0x25
+/* Inactivity time */
+#define ADXL345_REG_TIME_INACT		0x26
+/* Axis enable control for activity and inactivity detection */
+#define ADXL345_REG_ACT_INACT_CTRL	0x27
+/* Free-fall threshold */
+#define ADXL345_REG_THRESH_FF		0x28
+/* Free-fall time */
+#define ADXL345_REG_TIME_FF		0x29
+/* Axis control for single tap or double tap */
+#define ADXL345_REG_TAP_AXIS		0x2A
+/* Source of single tap or double tap */
+#define ADXL345_REG_ACT_TAP_STATUS	0x2B
+/* Data rate and power mode control */
+#define ADXL345_REG_BW_RATE		0x2C
+#define ADXL345_REG_POWER_CTL		0x2D
+#define ADXL345_REG_INT_ENABLE		0x2E
+#define ADXL345_REG_INT_MAP		0x2F
+#define ADXL345_REG_INT_SOURCE		0x30
+#define ADXL345_REG_INT_SOURCE_MSK	0xFF
+#define ADXL345_REG_XYZ_BASE		0x32
+#define ADXL345_REG_DATA_AXIS(index)				\
+	(ADXL345_REG_XYZ_BASE + (index) * sizeof(__le16))
+
+#define ADXL345_REG_FIFO_CTL		0x38
+#define ADXL345_FIFO_CTL_SAMPLES_MSK	GENMASK(4, 0)
+/* 0: INT1, 1: INT2 */
+#define ADXL345_FIFO_CTL_TRIGGER_MSK	BIT(5)
+#define ADXL345_FIFO_CTL_MODE_MSK	GENMASK(7, 6)
+#define ADXL345_REG_FIFO_STATUS	0x39
+#define ADXL345_REG_FIFO_STATUS_MSK	0x3F
+
+#define ADXL345_INT_OVERRUN		BIT(0)
+#define ADXL345_INT_WATERMARK		BIT(1)
+#define ADXL345_INT_FREE_FALL		BIT(2)
+#define ADXL345_INT_INACTIVITY		BIT(3)
+#define ADXL345_INT_ACTIVITY		BIT(4)
+#define ADXL345_INT_DOUBLE_TAP		BIT(5)
+#define ADXL345_INT_SINGLE_TAP		BIT(6)
+#define ADXL345_INT_DATA_READY		BIT(7)
+
+/*
+ * BW_RATE bits - Bandwidth and output data rate. The default value is
+ * 0x0A, which translates to a 100 Hz output data rate
+ */
+#define ADXL345_BW_RATE			GENMASK(3, 0)
+#define ADXL345_BW_LOW_POWER		BIT(4)
+#define ADXL345_BASE_RATE_NANO_HZ	97656250LL
+
+#define ADXL345_POWER_CTL_STANDBY	0x00
+#define ADXL345_POWER_CTL_WAKEUP	GENMASK(1, 0)
+#define ADXL345_POWER_CTL_SLEEP	BIT(2)
+#define ADXL345_POWER_CTL_MEASURE	BIT(3)
+#define ADXL345_POWER_CTL_AUTO_SLEEP	BIT(4)
+#define ADXL345_POWER_CTL_LINK		BIT(5)
+
+/* Set the g range */
+#define ADXL345_DATA_FORMAT_RANGE	GENMASK(1, 0)
+/* Data is left justified */
+#define ADXL345_DATA_FORMAT_JUSTIFY	BIT(2)
+/* Up to 13-bits resolution */
+#define ADXL345_DATA_FORMAT_FULL_RES	BIT(3)
+#define ADXL345_DATA_FORMAT_SELF_TEST	BIT(7)
+#define ADXL345_DATA_FORMAT_2G		0
+#define ADXL345_DATA_FORMAT_4G		1
+#define ADXL345_DATA_FORMAT_8G		2
+#define ADXL345_DATA_FORMAT_16G		3
+
+#define ADXL345_DEVID			0xE5
+#define ADXL345_FIFO_SIZE		32
+
 #define ADXL345_FIFO_BYPASS	0
 #define ADXL345_FIFO_FIFO	1
 #define ADXL345_FIFO_STREAM	2
-- 
2.39.5


