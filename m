Return-Path: <linux-iio+bounces-13373-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A48559EDAEB
	for <lists+linux-iio@lfdr.de>; Thu, 12 Dec 2024 00:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB3AD28323C
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2024 23:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4156D1F37AC;
	Wed, 11 Dec 2024 23:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hAl0jbsD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF161F239D;
	Wed, 11 Dec 2024 23:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733958425; cv=none; b=gEaAhe328819d3lnlA1NvGsgQ1xdNVPzyPdO8zBcdVzRN/hxZZSxHlqczKk2Vud3w+iaMrWX2Hzqw6PuUUTr/KSopIayeZkI3aiXM+DoB4GBHyp3+sxUv4SXrBPOYf/oHplsm7ubpWgdO5EdIOvo+FATZMebxQ6x3I+LuWNyTo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733958425; c=relaxed/simple;
	bh=fMMAUA8MptsJ3tdTNT6UnSlPGNtDXVuoCwGlqdh+Xtw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E9mc/P6+M86/E58rarWGqXtg5yZzqV4CX/FeY40pqU6h0QCLuiJNRTuYtxghoesb+7TZRjOTMbaGflWoNAusm2Z3F0KntkZZfMlEIvYIaU23WJOvmePcLP7NbXy110o9pkPKlZX1p9xSUzD9/z5qJNM+MYeWcJ5w2ML3qabjtwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hAl0jbsD; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa67bc91f88so79732066b.0;
        Wed, 11 Dec 2024 15:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733958421; x=1734563221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XODishcc6/xg5cdHfCN0TyWgzzavYyLFRNEsZR4w8DY=;
        b=hAl0jbsD1ZO/r2sgTNStC8DhX18yYJhJrSLz463V/fPet6g6xVqy/UHiFnEZ1ADAsS
         Is/QMf6M2PPqNZrwzT+0NbrgNuHTB9xJPbew7GFzytvU+NfewlnH4vpYWeQ1G4N+xiXs
         XzLufLLzFCtYgeXEf41YjtnKd2G9n1NuD0rzOGcnvHDJHkTpcQ+AkjgkiOwSfrr/zaP+
         j6vFwe7OJaUUonPBVikqNqoGRjd5QIGkcVDF97TzIEIjUDdYexkPxauZk1ll/h5n9/md
         t/bJOAW5V3KHlX5enNvlCHuxwudbyx/7EGLuOJOzshkG+e4T2MQNGDCJKvMCEthjATYA
         usIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733958421; x=1734563221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XODishcc6/xg5cdHfCN0TyWgzzavYyLFRNEsZR4w8DY=;
        b=gB5SGdmTc66DqKNvrtcrB5VCIVVH4qK3Zu/nSUhYAqXSZLK2T9i99kSyvsOagkjxze
         +8muJ8nIqx4G+WUi9tsNTRPOs6YsxaZHWCXWKWp3fxGTkjEmri8qSHR/W3ownctWkx9b
         Gvr1B+fhMJOIdKSCC9abHVlYSjI6GPh0LOC06IUVa3WkNoQjVGJtNozdsbU83Z701ac5
         MqFqvOf+7mMIcbO3YzDqtoyWY9qVV/VR8puQpDkwfsk8k+OS7yEYrv0Xw/XD3dfq7iLX
         z/V87t1mLtlcHZAbVnHVxQVf5DGAtUdEE82d0LZqq3K8gs5oV5Hg/AmHkAz84qd45Kw1
         k/CA==
X-Forwarded-Encrypted: i=1; AJvYcCUZPrk8OnTe3UZT9LM+7XKmvxXXzFtjK+SLYSlhnP5oz4/zLRNBU6jDwFuaXdiLTbbJ3Gdn+kBtqi8=@vger.kernel.org, AJvYcCUu0Igf1pZNJ+n2WKKG7j+JPbJTpUhayh1gFcQ506tVMM7ch0xdMS9OY4SEVPIjbSxOv1TMEuH1GmC2ezKb@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+C/GMwhBQT3zUSJigdGBC9h9HsUgBx9KJKc4NyjSkuJYrMv06
	1SgQ/jIKqivetk6x2Ex3RTNN6Auha9fp/TzCQTX585Op3js+8hbN
X-Gm-Gg: ASbGncukgadk421F4Hi/iZ3wpEPs1WOxv8uc/LKUAisOnP+X2JQ0UwQ+jGp38P6QAPI
	mBLu6ThhT4R+ey+8LLO5DtzAKPjhkaQuxxB26v0vEaowz/5KVOmdg3aWzKhxJdEjfHWCn18VK4y
	KfA14HqpRy806Gs7UE70aYPrIkYIxymRQdhnMTMkkA6R+WwI53A5Ckkp3LTDAKUlsv0khOpYyTE
	+da5ZAzvrMndCG4Yl6d1hudN1WKHM8HMv9B72EDHk5cWGyIDBq5YeCUOR+UUHGyvsiUvvk652Y1
	+OjkQl05T7v4qHm2iN7FAeyCcp/QcCb1
X-Google-Smtp-Source: AGHT+IGdPNzBKAWaLyNaRDXPezhm7V0aYVDnHkJLhFb2R3YtseqUmcXQBFVK2JtQ0PVTcGfx3BBe9Q==
X-Received: by 2002:a17:907:2d8d:b0:aa5:3e81:5aa2 with SMTP id a640c23a62f3a-aa6b1180512mr177755566b.4.1733958421446;
        Wed, 11 Dec 2024 15:07:01 -0800 (PST)
Received: from 34fd2088d136.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa655653d96sm747350366b.185.2024.12.11.15.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 15:07:01 -0800 (PST)
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
Subject: [PATCH v6 2/7] iio: accel: adxl345: complete the list of defines
Date: Wed, 11 Dec 2024 23:06:43 +0000
Message-Id: <20241211230648.205806-3-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241211230648.205806-1-l.rubusch@gmail.com>
References: <20241211230648.205806-1-l.rubusch@gmail.com>
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
 drivers/iio/accel/adxl345.h | 92 +++++++++++++++++++++++++++++++------
 1 file changed, 79 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
index 3d5c8719d..9c73474c6 100644
--- a/drivers/iio/accel/adxl345.h
+++ b/drivers/iio/accel/adxl345.h
@@ -9,37 +9,103 @@
 #define _ADXL345_H_
 
 #define ADXL345_REG_DEVID		0x00
+#define ADXL345_REG_THRESH_TAP	0x1D
 #define ADXL345_REG_OFSX		0x1E
 #define ADXL345_REG_OFSY		0x1F
 #define ADXL345_REG_OFSZ		0x20
 #define ADXL345_REG_OFS_AXIS(index)	(ADXL345_REG_OFSX + (index))
+
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
 
+#define ADXL345_FIFO_CTL_SAMPLES(x)	FIELD_PREP(GENMASK(4, 0), x)
+/* 0: INT1, 1: INT2 */
+#define ADXL345_FIFO_CTL_TRIGGER(x)	FIELD_PREP(BIT(5), x)
+#define ADXL345_FIFO_CTL_MODE(x)	FIELD_PREP(GENMASK(7, 6), x)
+
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
 
-#define ADXL345_DATA_FORMAT_RANGE	GENMASK(1, 0)	/* Set the g range */
-#define ADXL345_DATA_FORMAT_JUSTIFY	BIT(2)	/* Left-justified (MSB) mode */
-#define ADXL345_DATA_FORMAT_FULL_RES	BIT(3)	/* Up to 13-bits resolution */
-#define ADXL345_DATA_FORMAT_SPI_3WIRE	BIT(6)	/* 3-wire SPI mode */
-#define ADXL345_DATA_FORMAT_SELF_TEST	BIT(7)	/* Enable a self test */
-
+/* Set the g range */
+#define ADXL345_DATA_FORMAT_RANGE	GENMASK(1, 0)
+/* Data is left justified */
+#define ADXL345_DATA_FORMAT_JUSTIFY	BIT(2)
+/* Up to 13-bits resolution */
+#define ADXL345_DATA_FORMAT_FULL_RES	BIT(3)
+#define ADXL345_DATA_FORMAT_SPI_3WIRE	BIT(6)
+#define ADXL345_DATA_FORMAT_SELF_TEST	BIT(7)
 #define ADXL345_DATA_FORMAT_2G		0
 #define ADXL345_DATA_FORMAT_4G		1
 #define ADXL345_DATA_FORMAT_8G		2
 #define ADXL345_DATA_FORMAT_16G		3
 
-#define ADXL345_DEVID			0xE5
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
2.39.5


