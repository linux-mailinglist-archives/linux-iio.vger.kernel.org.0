Return-Path: <linux-iio+bounces-12352-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9218E9D0513
	for <lists+linux-iio@lfdr.de>; Sun, 17 Nov 2024 19:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51A902822E9
	for <lists+linux-iio@lfdr.de>; Sun, 17 Nov 2024 18:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F6E1DD87D;
	Sun, 17 Nov 2024 18:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhLDPoEP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7CB1DD53A;
	Sun, 17 Nov 2024 18:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731868108; cv=none; b=VdMCK4ROow/0JMXkbQ6+aOcOL37AVqsNNtkFoNdZdZZX8D6fbgRVkYvNEEWGZlKz0oJKTIIJWBzCBFFC2UGoPxFzra3yMWeQAVy4A1NQedD5RY5FrpBwCjG5qX/HrXhFZADodH6G/BWSVGNrilbJ3t/vbyBiN27AhcFTg4qGM3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731868108; c=relaxed/simple;
	bh=aImB8JXuYGC75dQm5kamc9HRrsDYI8Xb9YEvJJAGpDc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PjdSlib1aMgPp2aD3f+srPZ5Tu/UX6hzJHgqzzL+ZWn7U79hhGA6rbXa4XkFwJpD3AAy6jY+CErevcUVw4Q7LqH+CXCicNzHpMQlOH2DLEwg1kiFVzN1EL+h1vZpfg/qu8NfeWC+EPa8HPoKP7/+ci8HIQy7UhPWdeLeaVnRxQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fhLDPoEP; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3823ef92bd0so73308f8f.2;
        Sun, 17 Nov 2024 10:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731868104; x=1732472904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5J2EkGurj9OleNaa6X1u3iol/6vzB1gcd9dALyM71LU=;
        b=fhLDPoEP+PBr6X4Gio9/EQrzS1a04FvwFPCPej96n+MhRrCwt0FwYrOCWCUVVZVQu3
         g0Zn6tPixKrsBj05Y8Yxr/bSVN859p36F8ipwqsN3SlfsQeyXjnigjldesI8WDQdjMTB
         jCbnLxw+WZTFgTodhCfauZwyk87MB0cpR7b59KkqWq7RgvrQWNBVaDcJHkvqSGMHnAVH
         NeRX0dkwW2XZ+O3qyftWdCbL4Nu8WsPcZK1gTR0HpGGLbUnmjCNY45gV6BkuY0REen5Z
         j9U2olztXXBZw8BMKhRcFl+uFs6VmNUYmQeNbCuGNK0FxRy5jXIKhy4qi7MK7tI6Fo/X
         8MAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731868104; x=1732472904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5J2EkGurj9OleNaa6X1u3iol/6vzB1gcd9dALyM71LU=;
        b=u3wugT4i+A6aTZKChx5DMs4LZNtw4k02pr1vNYjd1OLdt9n6w0+0jlnd361SwWKFS+
         kOGKcQB+/fEwdExJT6/78R4EtxJA9ly73LKs1jF/UUc5EXVnnUTRZVoO/mxmjqdU79L6
         knMyoenM+AfmcoVlBGh9uqlFphsmfY88m0oRy6O5zFBIqEu9BHA6UkUanyqifhBQuGNJ
         r1g6kvoh86NSmKubKlsmfuwIth+xUY7KsaXLajBb5o9l7zNJfGmoagPW/j9uKG+4y51T
         wdpVnSsDeFfvTjWX8EQlG1IKTeipTmfoRYd21ZCittwSnIweGgPneHSr6ViMm+uEJjTm
         b/2g==
X-Forwarded-Encrypted: i=1; AJvYcCUjjDTfA7XSHOSwNCoP5Vrhl0ffJzUK6pLkVHuC4tZyW9Mfovd1BvuoRwQXtjLiA11P3KQ+BBYlIzLSLO0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl1Yo5lu6rr9nOQR9RwMAgjyr9h+oVwvohcvmfpfolNx8Pka+Q
	HAYBHmXtiVyLQ7gvQC0Oy+dg6hHFYWvDPqcOw9p/RjSeg2YqMxj9JhBLmtXp
X-Gm-Gg: ASbGncvmY0oNYZ3F/OXXX/xcznIEKzwoTzEu5u0z4l33KA2UDU86yq4j8Z7/ivyoeLf
	4UATMLGyFuqRxI8kD18IBxQkrwS112otVYHsu9NZJyCcxkanimXKEyNT4+C7GjHf4jwgnYbjYf9
	f6N6/chQ12KV32e+t4i4CijnXfSh8NS6XAwtY0sHHepmRoPBcCxy5jH5eMkze+WFtYYvmpuqX/D
	zXab4bfjNQ5URIritBicHtmBLP4554pBhdohn1WHIraDFNAEj7SzlcZcIT3iBHJGF6AVIBaOzjx
	AsEXGhlGxq9uuV72Rpzg6acN70U5
X-Google-Smtp-Source: AGHT+IGdLsh4PSghJudU9ZZLVuBCTp8arYUAPabSuLm1hM3iwmJeVvWz1ywPAiEvs87ecPxRDIQOag==
X-Received: by 2002:a05:600c:4fcf:b0:42c:ba83:3f08 with SMTP id 5b1f17b1804b1-432df71af58mr35938235e9.2.1731868104124;
        Sun, 17 Nov 2024 10:28:24 -0800 (PST)
Received: from 5dfbf0f66296.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3823f72441bsm3028137f8f.101.2024.11.17.10.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 10:28:23 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v2 09/22] iio: accel: adxl345: unexpose private defines
Date: Sun, 17 Nov 2024 18:26:38 +0000
Message-Id: <20241117182651.115056-10-l.rubusch@gmail.com>
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

For the implementation of features like FIFO-usage, watermark, single
tap, double tap, freefall, etc. most of the constants do not need to be
exposed in the header file, but are rather of private nature. Reduce
namespace pollution by moving them to the core source file.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345.h      |  33 +---------
 drivers/iio/accel/adxl345_core.c | 108 +++++++++++++++++++++++++++++++
 2 files changed, 110 insertions(+), 31 deletions(-)

diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
index 4ba493f636..c9d2a82fa6 100644
--- a/drivers/iio/accel/adxl345.h
+++ b/drivers/iio/accel/adxl345.h
@@ -8,38 +8,9 @@
 #ifndef _ADXL345_H_
 #define _ADXL345_H_
 
-#define ADXL345_REG_DEVID		0x00
-#define ADXL345_REG_OFSX		0x1E
-#define ADXL345_REG_OFSY		0x1F
-#define ADXL345_REG_OFSZ		0x20
-#define ADXL345_REG_OFS_AXIS(index)	(ADXL345_REG_OFSX + (index))
-#define ADXL345_REG_BW_RATE		0x2C
-#define ADXL345_REG_POWER_CTL		0x2D
-#define ADXL345_REG_DATA_FORMAT		0x31
-#define ADXL345_REG_DATAX0		0x32
-#define ADXL345_REG_DATAY0		0x34
-#define ADXL345_REG_DATAZ0		0x36
-#define ADXL345_REG_DATA_AXIS(index)	\
-	(ADXL345_REG_DATAX0 + (index) * sizeof(__le16))
-
-#define ADXL345_BW_RATE			GENMASK(3, 0)
-#define ADXL345_BASE_RATE_NANO_HZ	97656250LL
-
-#define ADXL345_POWER_CTL_MEASURE	BIT(3)
-#define ADXL345_POWER_CTL_STANDBY	0x00
-
-#define ADXL345_DATA_FORMAT_RANGE	GENMASK(1, 0)	/* Set the g range */
-#define ADXL345_DATA_FORMAT_JUSTIFY	BIT(2)	/* Left-justified (MSB) mode */
-#define ADXL345_DATA_FORMAT_FULL_RES	BIT(3)	/* Up to 13-bits resolution */
+/* Regs and bits needed to be declared globally */
+#define ADXL345_REG_DATA_FORMAT		0x31 /* r/w  Data format control */
 #define ADXL345_DATA_FORMAT_SPI_3WIRE	BIT(6)	/* 3-wire SPI mode */
-#define ADXL345_DATA_FORMAT_SELF_TEST	BIT(7)	/* Enable a self test */
-
-#define ADXL345_DATA_FORMAT_2G		0
-#define ADXL345_DATA_FORMAT_4G		1
-#define ADXL345_DATA_FORMAT_8G		2
-#define ADXL345_DATA_FORMAT_16G		3
-
-#define ADXL345_DEVID			0xE5
 
 /*
  * In full-resolution mode, scale factor is maintained at ~4 mg/LSB
diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 51b229cc44..c8d9e1f9e0 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -18,6 +18,114 @@
 
 #include "adxl345.h"
 
+/* ADXL345 register map */
+#define ADXL345_REG_DEVID		0x00 /* r    Device ID */
+#define ADXL345_REG_THRESH_TAP	0x1D /* r/w  Tap Threshold */
+#define ADXL345_REG_OFSX		0x1E /* r/w  X-axis offset */
+#define ADXL345_REG_OFSY		0x1F /* r/w  Y-axis offset */
+#define ADXL345_REG_OFSZ		0x20 /* r/w  Z-axis offset */
+#define ADXL345_REG_DUR		0x21 /* r/w  Tap duration */
+#define ADXL345_REG_LATENT		0x22 /* r/w  Tap latency */
+#define ADXL345_REG_WINDOW		0x23 /* r/w  Tap window */
+#define ADXL345_REG_THRESH_ACT		0x24 /* r/w  Activity threshold */
+#define ADXL345_REG_THRESH_INACT	0x25 /* r/w  Inactivity threshold */
+#define ADXL345_REG_TIME_INACT	0x26 /* r/w  Inactivity time */
+#define ADXL345_REG_ACT_INACT_CTRL	0x27 /* r/w  Axis enable control for */
+					     /*      activity and inactivity */
+					     /*      detection */
+#define ADXL345_REG_THRESH_FF		0x28 /* r/w  Free-fall threshold */
+#define ADXL345_REG_TIME_FF		0x29 /* r/w  Free-fall time */
+#define ADXL345_REG_TAP_AXIS		0x2A /* r/w  Axis control for */
+					     /*      single tap or double tap */
+#define ADXL345_REG_ACT_TAP_STATUS	0x2B /* r    Source of single tap or */
+					     /*      double tap */
+#define ADXL345_REG_BW_RATE		0x2C /* r/w  Data rate and power */
+					     /*        mode control */
+#define ADXL345_REG_POWER_CTL		0x2D /* r/w  Power-saving features */
+#define ADXL345_REG_INT_ENABLE		0x2E /* r/w  Interrupt enable control */
+#define ADXL345_REG_INT_MAP		0x2F /* r/w  Interrupt mapping */
+					     /*      control */
+#define ADXL345_REG_INT_SOURCE		0x30 /* r    Source of interrupts */
+/* NB: ADXL345_REG_DATA_FORMAT		0x31  r/w  Data format control,
+ *   (defined in header)
+ */
+
+#define ADXL345_REG_XYZ_BASE		0x32 /* r    Base address to read out */
+					     /*      X-, Y- and Z-axis data 0 */
+					     /*      and 1 */
+#define ADXL345_REG_DATA_AXIS(index)				\
+	(ADXL345_REG_XYZ_BASE + (index) * sizeof(__le16))
+/* NB: having DATAX0 and DATAX1 makes 2x sizeof(__le16) */
+
+#define ADXL345_REG_FIFO_CTL		0x38 /* r/w  FIFO control */
+#define ADXL345_REG_FIFO_STATUS		0x39 /* r    FIFO status */
+
+/* DEVID(s) */
+#define ADXL345_DEVID			0xE5
+
+/* FIFO */
+#define ADXL345_FIFO_CTL_SAMLPES(x)	(0x1f & (x))
+#define ADXL345_FIFO_CTL_TRIGGER(x)	(0x20 & ((x) << 5)) /* set 1: INT2, 0: INT1 */
+#define ADXL345_FIFO_CTL_MODE(x)	(0xc0 & ((x) << 6))
+
+/* INT_ENABLE, INT_MAP, INT_SOURCE bits */
+#define ADXL345_INT_DATA_READY		BIT(7)
+#define ADXL345_INT_SINGLE_TAP		BIT(6)
+#define ADXL345_INT_DOUBLE_TAP		BIT(5)
+#define ADXL345_INT_ACTIVITY		BIT(4)
+#define ADXL345_INT_INACTIVITY		BIT(3)
+#define ADXL345_INT_FREE_FALL		BIT(2)
+#define ADXL345_INT_WATERMARK		BIT(1)
+#define ADXL345_INT_OVERRUN		BIT(0)
+
+#define ADXL34X_S_TAP_MSK	ADXL345_INT_SINGLE_TAP
+#define ADXL34X_D_TAP_MSK	ADXL345_INT_DOUBLE_TAP
+
+/* INT1 or INT2 */
+#define ADXL345_INT1			0
+#define ADXL345_INT2			1
+
+/* BW_RATE bits - Bandwidth and output data rate. The default value is
+ * 0x0A, which translates to a 100 Hz output data rate
+ */
+#define ADXL345_BW_RATE			GENMASK(3, 0)
+#define ADXL345_BW_LOW_POWER	BIT(4)
+#define ADXL345_BASE_RATE_NANO_HZ	97656250LL
+
+/* POWER_CTL bits */
+#define ADXL345_POWER_CTL_STANDBY	0x00
+
+/* NB:
+ * BIT(0), BIT(1) for explicit wakeup (not implemented)
+ * BIT(2) for explicit sleep (not implemented)
+ */
+#define ADXL345_POWER_CTL_MEASURE	BIT(3)
+#define ADXL345_POWER_CTL_AUTO_SLEEP	BIT(4)
+#define ADXL345_POWER_CTL_LINK	BIT(5)
+
+/* DATA_FORMAT bits */
+#define ADXL345_DATA_FORMAT_RANGE	GENMASK(1, 0)	/* Set the g range */
+#define ADXL345_DATA_FORMAT_JUSTIFY	BIT(2)	/* 1: left-justified (MSB) mode, 0: right-just'd */
+#define ADXL345_DATA_FORMAT_FULL_RES	BIT(3)	/* Up to 13-bits resolution */
+/* NB: BIT(6): 3-wire SPI mode (defined in header) */
+
+#define ADXL345_DATA_FORMAT_SELF_TEST	BIT(7)	/* Enable a self test */
+#define ADXL345_DATA_FORMAT_2G		0
+#define ADXL345_DATA_FORMAT_4G		1
+#define ADXL345_DATA_FORMAT_8G		2
+#define ADXL345_DATA_FORMAT_16G		3
+
+#define ADXL345_REG_OFS_AXIS(index)	(ADXL345_REG_OFSX + (index))
+
+/* The ADXL345 include a 32 sample FIFO
+ *
+ * FIFO stores a maximum of 32 entries, which equates to a maximum of 33
+ * entries available at any given time because an additional entry is available
+ * at the output filter of the device.
+ * (see datasheet FIFO_STATUS description on "Entries Bits")
+ */
+#define ADXL34x_FIFO_SIZE  33
+
 struct adxl34x_state {
 	int irq;
 	const struct adxl345_chip_info *info;
-- 
2.39.5


