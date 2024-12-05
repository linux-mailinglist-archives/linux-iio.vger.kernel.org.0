Return-Path: <linux-iio+bounces-13121-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0753F9E5CB1
	for <lists+linux-iio@lfdr.de>; Thu,  5 Dec 2024 18:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3040F18840FF
	for <lists+linux-iio@lfdr.de>; Thu,  5 Dec 2024 17:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D4F229B18;
	Thu,  5 Dec 2024 17:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHMZ3s7K"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24607227B9A;
	Thu,  5 Dec 2024 17:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733418840; cv=none; b=L3dIIEgHsKYMKCJ0XlqAq3NzrEzobavAjJy8kY1siPC6tvl/SmwS5N4dAULzRjqJg4tNynADPqzMTTpwu7MvJ2p3DcEVjLnl3P6k+ch/cdl25OeP4tR+nCoY82xgl8zxJ9gjSjM7GcrOtlLsTfX8sTh2uVaXLbw3Xsybz/2x+Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733418840; c=relaxed/simple;
	bh=xlamxEB29KLW/kB5qDjRmFtRz+0Olyx4qFv/pVdhRQ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XjgxxdbuknRLNIXL2047563BlV3WOT5/1jmUBZfXgKTDv/R8BXgPKvKvmRs+8WoO1dZ7zYkinOtLDwVwDSIyAkWCZ4UfcmvF2Y5i5wFQ1gb22yRb5Qek+XIp8GA/X+UR5m+Dr4hwZlPfaFFgq6n/nB7E+Tsc5vl5ws9+nTq7FMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IHMZ3s7K; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d0ac3be718so161853a12.1;
        Thu, 05 Dec 2024 09:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733418837; x=1734023637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Fd+RIYfyJGlnD0kUkio9w5hOzwFeUW/miLAqJR8L8E=;
        b=IHMZ3s7KsaDi8KFje/8dWd/BexIiAeK6SJum36UvwClxQoxXfQ6w39XQoBBXZurFEg
         X9pabtFeNozJZDI8wGGNYVWO0RAfR+NARpA60lD16ZJO6GEA7nUMsqkVxk1+i+zclII1
         dArcY1PYpvyLcy8+g63r/bligltnTryjl/NjbyESaysLH0qyw58XYT9FcL59BBgF3L+r
         H7ltYRMTtEryGqL/jKVSMyje3XQCRGZKicRNlNYuaEVrDUEgHrJNScXPwwvMm4Ky4UEc
         VYGaC5UF0UwHsC0ItRyZFipJPcmYW/wQPSgDsBjFzyjBy85h3dEd9UGcKn5PcBcQ9zpJ
         Zv5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733418837; x=1734023637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Fd+RIYfyJGlnD0kUkio9w5hOzwFeUW/miLAqJR8L8E=;
        b=aRdanDsQknY70QCO6gO9ZYwcpIVBgGQmdbyhW9Pp/ZSPfwi584bNRpevtFi8vacrSR
         /yVRCtXjWPWSbW95f2sCc+6UixODplrRifieaFFvxEsVuWp4ffbc9i97oNJeNrofyGLo
         6OsEnznMlXurYHCdCgQbC4rhGhNJZ85fRlLZYZaaPC29ENrDCs5ep1TZH4E8GjjneKPb
         7nITJIJX7SkBTtl1IL08TFruGVwT+Q+l12SxsDoImvAKUcW+pURNUKYkynKJF5uK/uXn
         fLNb4+IFnjvg2fC15Oqhmn0Or6Qkj/JISVQ0ijG3Jik4ka2BJVJXWdi8grPDESEeGBNN
         WFqw==
X-Forwarded-Encrypted: i=1; AJvYcCUOzkgtRMcn+Eki8bSP3ySot9AG6nEqPppo5lFz0zjUJOf2XSAaQ+onvaBg8MX1VWQ5QhEXtV3FxG8=@vger.kernel.org, AJvYcCW+pJh0mt81HkAdXldDBudrtIM/0b+QV44zwOmyV1BrivJLLUYKlziZ8H/J1q13H4o56e3inOiOr4lpGLbC@vger.kernel.org
X-Gm-Message-State: AOJu0YzJrf42H4vc+9+wsNV9psCj2NvKHKw8oWoy6gTIabpQqq6hw2eh
	lQikROHO3CDQGFrAoDblO7ZpbXAH2inK0gnjoTnvavxf0hEkhGLhxhS6PQ==
X-Gm-Gg: ASbGncseridOQ+RdcwpnEbV/01QtzLJxxgLq9atEHU2gx2vtnApSIspPagU/2CnsKEN
	IupNboz/n8wFl5aLjgVhepyXCc27HntgzqCriKgIF0SyxUCvF9pG+XbAz02F0RGHqGij52qwuRN
	UATCAJiJsLw6k8oGpq3il6bDBZg23vdk+jA9kSaTIEkJHnDrJmqNppiYMYMBY0W710jxHWxFE5S
	tzPJYvaHT8KJ2mLwePy2Wlc27Sl9oJu8N6VZWq8WoPTNhuHsfBvtmUx/+m7UWGNHXoUDk59aT0K
	W3n2WKl5RWXZKoU5Z4clze+h3mMw
X-Google-Smtp-Source: AGHT+IEIZpV3kkLWrQBzqU54SQXuuO0R56GVBUwq91zwGdpJF+UX39JNePuZtaL1CPgj8pYkE0UNJQ==
X-Received: by 2002:a05:6402:26c7:b0:5d0:bd3b:b9a9 with SMTP id 4fb4d7f45d1cf-5d10cb99b97mr4068335a12.8.1733418837277;
        Thu, 05 Dec 2024 09:13:57 -0800 (PST)
Received: from 7b58d44c4ff6.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d149a48a38sm1026078a12.23.2024.12.05.09.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 09:13:57 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v5 05/10] iio: accel: adxl345: complete list of defines
Date: Thu,  5 Dec 2024 17:13:38 +0000
Message-Id: <20241205171343.308963-6-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241205171343.308963-1-l.rubusch@gmail.com>
References: <20241205171343.308963-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the list of constants. Keep them the header file for readability.
The defines allow the implementation of events like watermark, single
tap, double tap, freefall, etc.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345.h | 89 ++++++++++++++++++++++++++++++++-----
 1 file changed, 77 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
index 3d5c8719db3..ed81d5cf445 100644
--- a/drivers/iio/accel/adxl345.h
+++ b/drivers/iio/accel/adxl345.h
@@ -9,37 +9,102 @@
 #define _ADXL345_H_
 
 #define ADXL345_REG_DEVID		0x00
+#define ADXL345_REG_THRESH_TAP	0x1D
 #define ADXL345_REG_OFSX		0x1E
 #define ADXL345_REG_OFSY		0x1F
 #define ADXL345_REG_OFSZ		0x20
-#define ADXL345_REG_OFS_AXIS(index)	(ADXL345_REG_OFSX + (index))
+/* Tap duration */
+#define ADXL345_REG_DUR		0x21
+/* Tap latency */
+#define ADXL345_REG_LATENT		0x22
+/* Tap window */
+#define ADXL345_REG_WINDOW		0x23
+/* Activity threshold */
+#define ADXL345_REG_THRESH_ACT		0x24
+/* Inactivity threshold */
+#define ADXL345_REG_THRESH_INACT	0x25
+/* Inactivity time */
+#define ADXL345_REG_TIME_INACT	0x26
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
 #define ADXL345_REG_BW_RATE		0x2C
 #define ADXL345_REG_POWER_CTL		0x2D
+#define ADXL345_REG_INT_ENABLE		0x2E
+#define ADXL345_REG_INT_MAP		0x2F
+#define ADXL345_REG_INT_SOURCE		0x30
 #define ADXL345_REG_DATA_FORMAT		0x31
-#define ADXL345_REG_DATAX0		0x32
-#define ADXL345_REG_DATAY0		0x34
-#define ADXL345_REG_DATAZ0		0x36
-#define ADXL345_REG_DATA_AXIS(index)	\
-	(ADXL345_REG_DATAX0 + (index) * sizeof(__le16))
+#define ADXL345_REG_XYZ_BASE		0x32
+#define ADXL345_REG_DATA_AXIS(index)				\
+	(ADXL345_REG_XYZ_BASE + (index) * sizeof(__le16))
+
+#define ADXL345_REG_FIFO_CTL		0x38
+#define ADXL345_REG_FIFO_STATUS		0x39
+
+#define ADXL345_DEVID			0xE5
+
+#define ADXL345_FIFO_CTL_SAMLPES(x)	(0x1f & (x))
+#define ADXL345_FIFO_CTL_TRIGGER(x)	(0x20 & ((x) << 5)) /* 0: INT1, 1: INT2 */
+#define ADXL345_FIFO_CTL_MODE(x)	(0xc0 & ((x) << 6))
 
+#define ADXL345_INT_DATA_READY		BIT(7)
+#define ADXL345_INT_SINGLE_TAP		BIT(6)
+#define ADXL345_INT_DOUBLE_TAP		BIT(5)
+#define ADXL345_INT_ACTIVITY		BIT(4)
+#define ADXL345_INT_INACTIVITY		BIT(3)
+#define ADXL345_INT_FREE_FALL		BIT(2)
+#define ADXL345_INT_WATERMARK		BIT(1)
+#define ADXL345_INT_OVERRUN		BIT(0)
+
+#define ADXL345_S_TAP_MSK	ADXL345_INT_SINGLE_TAP
+#define ADXL345_D_TAP_MSK	ADXL345_INT_DOUBLE_TAP
+
+#define ADXL345_INT1			0
+#define ADXL345_INT2			1
+
+/*
+ * BW_RATE bits - Bandwidth and output data rate. The default value is
+ * 0x0A, which translates to a 100 Hz output data rate
+ */
 #define ADXL345_BW_RATE			GENMASK(3, 0)
+#define ADXL345_BW_LOW_POWER	BIT(4)
 #define ADXL345_BASE_RATE_NANO_HZ	97656250LL
 
-#define ADXL345_POWER_CTL_MEASURE	BIT(3)
 #define ADXL345_POWER_CTL_STANDBY	0x00
+#define ADXL345_POWER_CTL_WAKEUP	GENMASK(1, 0)
+#define ADXL345_POWER_CTL_SLEEP	BIT(2)
+#define ADXL345_POWER_CTL_MEASURE	BIT(3)
+#define ADXL345_POWER_CTL_AUTO_SLEEP	BIT(4)
+#define ADXL345_POWER_CTL_LINK	BIT(5)
 
 #define ADXL345_DATA_FORMAT_RANGE	GENMASK(1, 0)	/* Set the g range */
-#define ADXL345_DATA_FORMAT_JUSTIFY	BIT(2)	/* Left-justified (MSB) mode */
+#define ADXL345_DATA_FORMAT_IS_LEFT_JUSTIFIED	BIT(2)
 #define ADXL345_DATA_FORMAT_FULL_RES	BIT(3)	/* Up to 13-bits resolution */
-#define ADXL345_DATA_FORMAT_SPI_3WIRE	BIT(6)	/* 3-wire SPI mode */
-#define ADXL345_DATA_FORMAT_SELF_TEST	BIT(7)	/* Enable a self test */
-
+#define ADXL345_DATA_FORMAT_SPI_3WIRE	BIT(6)
+#define ADXL345_DATA_FORMAT_SELF_TEST	BIT(7)
 #define ADXL345_DATA_FORMAT_2G		0
 #define ADXL345_DATA_FORMAT_4G		1
 #define ADXL345_DATA_FORMAT_8G		2
 #define ADXL345_DATA_FORMAT_16G		3
 
-#define ADXL345_DEVID			0xE5
+#define ADXL345_REG_OFS_AXIS(index)	(ADXL345_REG_OFSX + (index))
+
+/*
+ * FIFO stores a maximum of 32 entries, which equates to a maximum of 33 entries
+ * available at any given time because an additional entry is available at the
+ * output filter of the device.
+ *
+ * (see datasheet FIFO_STATUS description on "Entries Bits")
+ */
+#define ADXL345_FIFO_SIZE  33
 
 /*
  * In full-resolution mode, scale factor is maintained at ~4 mg/LSB
-- 
2.39.2


