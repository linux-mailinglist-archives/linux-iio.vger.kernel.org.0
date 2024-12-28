Return-Path: <linux-iio+bounces-13852-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED989FDCA6
	for <lists+linux-iio@lfdr.de>; Sun, 29 Dec 2024 00:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FEB7161A3D
	for <lists+linux-iio@lfdr.de>; Sat, 28 Dec 2024 23:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5FB19884B;
	Sat, 28 Dec 2024 23:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fu6izA8R"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06D81990AD;
	Sat, 28 Dec 2024 23:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735428609; cv=none; b=ltzUcJ9jybpIX1lK35auw+RS0U9C5V7HKdYxAy0t02ZWUe5PfkTuMrHd/ReOLX+6+QIVPcZ00wQ8tnm4tRrlMrz3LGz/JVtZjJfB6AQ5BcDVLBtGC0jLjLYWicB0JIa6KYRXJDDpuJlrbPxGDsGbuk1O/eK8gFJA6y011+McRwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735428609; c=relaxed/simple;
	bh=CfplJt0+OxZeTRDrXzz0lVePhxY2jiVvgUde/cWTK3U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hXamAFm9F7oTtVxU/0dmm9/QIwTGN4U1ZOMRQvTsIdzGI47x/fbnq8njQvqGXAxdjtOWErKXwOPG2/cuunMDsHTs4QxfP0PXMCbsvjDnlZRqT5tCERFQQSqnn+sRTHdKbyVrXBkSXMS3TJTt1azHpdhOpoiWKzRajU8FkEu09O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fu6izA8R; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa6a38e64e4so158396166b.0;
        Sat, 28 Dec 2024 15:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735428606; x=1736033406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TFoNmbflTAqqYOJoxDopogFwoyWjl30csHfnN0Py5so=;
        b=fu6izA8RTCc6FuicuQ5meecfKM0AccZ/fJMhMzusuPpPXxmlz+lRegLWfduJuix11W
         xfD64V95IG0WYzPd7UB/OnCSafsBOG4VcuLkZ+kqpM9xX0Oy8YaMIlvXSzSzN8aWNLd9
         SoPz3E0uYHG9Z43+D1YB1jo9/MNJ22FhhwnRf9tC/TtUxsQ9DkFToidhqMeBFWpku9rV
         hIHv9Cp51r/gxa9bB+7VEXpUWiiaByivXlAX8dBGq1gq+kVbu2bBhJV53Ak16acBbeQA
         0KxKq+BZIl+NIcQOdPFMZKb2s2WO8NfeKR6P/a2wrXoqRLp6F7sAbSgFepxvqw9e0tzZ
         zUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735428606; x=1736033406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TFoNmbflTAqqYOJoxDopogFwoyWjl30csHfnN0Py5so=;
        b=OQ661cVaogdIWJqEe7kX7rveP4V/9Q1n5uZhNiOOc2khkZUU+Ci6Z29gfxyGIJ3dhs
         COd8fax6twnkKxJpRbQU/xf8dFv7BDkSfD5EjXBmM7X3rVrL0BgbxrT00EXBrXUFb8we
         sGxezXTG3+FXGhIf+zJrPueLowuSuY3bgUJevOhQNH+kfWyfsk7ZJzcpSheqgxc9soR0
         KOqoLwVQkfssxA9exb2PlE40crZi+yl+Hgr2oKi6SSuXM3PSQxzwuCy4cGBBGP+wCgzD
         tIYBTqiKC0+c7GVtTFtzYNGhPZ2j7wiKmrZyQA5EI5MrHrI8Ttvur+oNAds4iGZzp3NN
         mI6Q==
X-Forwarded-Encrypted: i=1; AJvYcCV+4atu4GwIpB5HHNO3hIW2VjiA1UoSqgV97pBmn+lBrou9UGUvASI56qRD3Qt4q1XQwAqIhsVGNkUeICM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3gMCeQVIK6MmMl1RYBitOtzs84ebLdd256B9UrmdWVhcx4wRJ
	zgPa5GeutF3PVRUFgvJ/rV4ZE+DWU6hgFtAgxJNMoEOKad8ZgxJF
X-Gm-Gg: ASbGncvLDO/oeAkJzUHGJAFX+8641KZ531DSwvTu1HAxFbX6azRYEEQOIjXGzs/PUud
	5o5U7ESXm2oM9ILD788+KvZPxs+lK/PFaABo2DIYwZ3FXF4HgrDn4hdce/Fpuj632n+V7ZmXIKU
	uoFXhkBfqU3uhh2M7+gk1IqpmnR9cUjvLZuEE5eYKyNV091nsk5C5LoB+NLmxRyu5zX05iqf0i1
	xah103I7O+LAxxVDsu3VlN+VVUOevQ60mDiUFW9w3KciSX1w8CPZFrkwC5iBWqtuITKNUkVZKNu
	XYh3fHBmXsQbvc09GPj14SNE2M9TTEtLUgI=
X-Google-Smtp-Source: AGHT+IFc5GyBo5lcQnG6YlNAnO+gMva5VyahMKwm2nid983yAi+rgn2fHNx05frjCe5CnYzs0BC26w==
X-Received: by 2002:a05:6402:13c7:b0:5d3:ba42:e9f8 with SMTP id 4fb4d7f45d1cf-5d81ddf80bcmr7932034a12.7.1735428605995;
        Sat, 28 Dec 2024 15:30:05 -0800 (PST)
Received: from d9dabf0abd47.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80701ac68sm12635156a12.78.2024.12.28.15.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2024 15:30:04 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v9 4/4] iio: accel: adxl345: complete the list of defines
Date: Sat, 28 Dec 2024 23:29:49 +0000
Message-Id: <20241228232949.72487-5-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241228232949.72487-1-l.rubusch@gmail.com>
References: <20241228232949.72487-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Having interrupts events and FIFO available allows to evaluate the
sensor events. Cover the list of interrupt based sensor events. Keep
them in the header file for readability.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345.h | 54 ++++++++++++++++++++++++++++++++-----
 1 file changed, 48 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
index b78b4973a..bf7cf15a8 100644
--- a/drivers/iio/accel/adxl345.h
+++ b/drivers/iio/accel/adxl345.h
@@ -9,10 +9,35 @@
 #define _ADXL345_H_
 
 #define ADXL345_REG_DEVID		0x00
+#define ADXL345_REG_THRESH_TAP		0x1D
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
 #define ADXL345_REG_BW_RATE		0x2C
 #define ADXL345_REG_POWER_CTL		0x2D
 #define ADXL345_REG_INT_ENABLE		0x2E
@@ -30,19 +55,36 @@
 
 #define ADXL345_INT_OVERRUN		BIT(0)
 #define ADXL345_INT_WATERMARK		BIT(1)
+#define ADXL345_INT_FREE_FALL		BIT(2)
+#define ADXL345_INT_INACTIVITY		BIT(3)
+#define ADXL345_INT_ACTIVITY		BIT(4)
+#define ADXL345_INT_DOUBLE_TAP		BIT(5)
+#define ADXL345_INT_SINGLE_TAP		BIT(6)
 #define ADXL345_INT_DATA_READY		BIT(7)
+
+/*
+ * BW_RATE bits - Bandwidth and output data rate. The default value is
+ * 0x0A, which translates to a 100 Hz output data rate
+ */
 #define ADXL345_BW_RATE			GENMASK(3, 0)
+#define ADXL345_BW_LOW_POWER		BIT(4)
 #define ADXL345_BASE_RATE_NANO_HZ	97656250LL
 
 #define ADXL345_POWER_CTL_STANDBY	0x00
+#define ADXL345_POWER_CTL_WAKEUP	GENMASK(1, 0)
+#define ADXL345_POWER_CTL_SLEEP	BIT(2)
 #define ADXL345_POWER_CTL_MEASURE	BIT(3)
+#define ADXL345_POWER_CTL_AUTO_SLEEP	BIT(4)
+#define ADXL345_POWER_CTL_LINK		BIT(5)
 
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
-- 
2.39.5


