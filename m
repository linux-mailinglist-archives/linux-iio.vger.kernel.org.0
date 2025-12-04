Return-Path: <linux-iio+bounces-26769-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D45CA503A
	for <lists+linux-iio@lfdr.de>; Thu, 04 Dec 2025 19:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 154E730F27A9
	for <lists+linux-iio@lfdr.de>; Thu,  4 Dec 2025 18:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AC2349B13;
	Thu,  4 Dec 2025 18:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+UEPaAr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61D2349AFF
	for <linux-iio@vger.kernel.org>; Thu,  4 Dec 2025 18:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764874530; cv=none; b=tNR1Cvxd5v1xyasVOBqsUAB3liWRADm6nPwQ8PH57EvCZ0DFlyirSaB5GbpRoF+triKT7mj5ke4XQsrwFjBOek72RsR9sD6NTjKl8soVZz9BwRbFG4bYHzCfKR5p23ejrP7palqVjdhJJ6KU2gJ1JY6v4++jYrv7PQQFclMG/l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764874530; c=relaxed/simple;
	bh=/zCl0HuPLWjC7Sa6krfiRVgt0gQ+G9nABtH88tweDYg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T2gV8ZW9gW8WrIZ8ouxweZz9+an3H1R4jWBEBBQfHxlVmR3usmPcXvDx1iOn4ZRSMyqTalKNnV/W8Nbzv0ZL9q+cTAl4yxmIekHSb1bZtCq4TtHa3PoYZ7R+28NcH1ZvnpVSzJlVKmDNlhggIj1vh4ihnvvTAaobanK/8T2XkM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+UEPaAr; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7ba92341f83so1536717b3a.0
        for <linux-iio@vger.kernel.org>; Thu, 04 Dec 2025 10:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764874521; x=1765479321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2RVHBZV4NpZC/dFubhuGIj8Sf/h6laSe7o6mJh9Dj8=;
        b=F+UEPaArtquoUXI54Mn+rCLLwttSHhsvEnQA8dd39ggCAie3GiyJoElRDi8xazpZ4q
         yzuDW2Or2zuvytvqgesVbCP3I8MgAsTBxgOv8lFvjThmq7Sl460x8/GNldfr6bLmcn1Z
         609NsRBkEsdTClXA+5aFWKmAGvk5qyMCKZ+LnGI319oi7fdLYqGlhRSQdp5JllhDQ4hN
         8LaYOPHFMpcRoYj/BiKUSGaJLTY15FrUS9nYZX2BtVgX3sWQpAYcHaUq3JB9uIZw+kF2
         td3SAWS0HAo5+Bik+qCGOOSWdxewFJoWQIlN2l4/53T3193MFTNqS5W8mqQEb1N6QC1E
         ysTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764874521; x=1765479321;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y2RVHBZV4NpZC/dFubhuGIj8Sf/h6laSe7o6mJh9Dj8=;
        b=M3MrqAuoqzPvT6gNNhtZkce9Mi1mUhY6MhaneIRuRQhuYwn7RACXnHwkjSK74Y2xRx
         kJ8/lXTTCeblPWSM1/WeqqWoKOEs2IBb/Kui0vfBQSWWNim59BU7dQSgO6mi2UlWJRTe
         L1jnSX78u5jokW3ukGGV6QKKPkLs3cYCXvy3Yg6za5rVMU4yWDSsYMG8f2xo4xhTdTiO
         pFrSTRHLvn3WXrtNEh9snAUHkdUQK33SLxvQ1N12G4u1ZYkJCeppVmHXZx9TsKauUXf8
         4NrYKX2q6tVGp0fPHaJALPYHN9xAg3hs19lIKrQgs71I/Dz9WQ70fp/rPwtbxTjUHrBH
         BNpA==
X-Forwarded-Encrypted: i=1; AJvYcCVTM/s3Hozdz/Od8UyW7ZlgpVf/MtM9a6sChaXyIicvtXZIVgujWJQ2/846fM6DWfaSH35MpW23gu8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo6XEY61rbJboSF6ifsfLZiVgz+iPjxvV0YWDIvKTsauEpzGSG
	b1R+LOPGD+5pr598M1wvQ1eSKc231XRcaHG240+IWHxMFc71aXk5l5xM
X-Gm-Gg: ASbGnctyTdrDAoNxElMByOEBf7Zg47o2DuPBAigPvKP1mk+kaIm/eL6/5Z5Px45/zO6
	ct8wfapJzyBJqRwZN0mWupCb3NeTL0yD7fy91wCtyBIdLX3LRGzVY/GshXJBfsJqZyOX2ECfgik
	6qgqD+hjjMDGS0F1edL5NdZuRIY9JMaylf9UCJCxeh1H/Fl6QgM9JEdkCMPJfENKzGqp8vU8U7Z
	Ve+22kz4Y7D6O2iZ7/dIPDMsV4avxsS1d7AiQeqh8Y1Tnubue23r42x4/qdb9HEobPlx3PRc4Cm
	GcYkjOIQSDW8+WFatK2yv/oy7eqscdfDtEIijWbYDTolfpzC6CanaTIrE5HDf9z/YjbqwnXc+FY
	QWxsDfpDO9MfYvTLFNsHqIvkYUrcWEN6y+p2Yjp4CC02qWdQGcZB+NHaUNnPL2p7SdC8Bb95tr7
	8tlr53MDNlllYc7ttfBHsysFlCjAfkWOPyIDQ//uC9CHDnrTSKTrhSn6w6UDL47KTXjdIUENMdD
	GP0D4m6cMjSdoTYRxRjz1l6iSXJTBXrl+Rb60WcxvgxBnk0m/hKLSuWAGDSm0i2zeycwrsu
X-Google-Smtp-Source: AGHT+IH9CgxiAXHcIB0H1EEjX3dtHjvletPsU8kPNx6CZxFd8Hf18KX/AyuG1/Mmw94t1QG1VOAinA==
X-Received: by 2002:a05:6a20:3d0b:b0:34f:28f7:ed75 with SMTP id adf61e73a8af0-36403763a2bmr4844083637.8.1764874521517;
        Thu, 04 Dec 2025 10:55:21 -0800 (PST)
Received: from Lewboski.localdomain ([181.191.143.42])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7e2af93d910sm2851475b3a.67.2025.12.04.10.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:55:21 -0800 (PST)
From: Tomas Borquez <tomasborquez13@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Tomas Borquez <tomasborquez13@gmail.com>
Subject: [PATCH] staging: iio: ad9832: remove platform_data support
Date: Thu,  4 Dec 2025 15:54:34 -0300
Message-ID: <20251204185434.4542-1-tomasborquez13@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove legacy platform_data support as there are no in tree users and
this approach belongs to a long gone era. The policy decision on what
to output is a userspace problem, not something that should be provided
from firmware.

The driver now initializes the device to a safe state (SLEEP|RESET|CLR)
outputting nothing. Userspace can configure the desired frequencies and
phases via the existing sysfs attributes once the device is ready to be 
used.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Tomas Borquez <tomasborquez13@gmail.com>
---
Original discussion: 
https://lore.kernel.org/linux-iio/20250628161040.3d21e2c4@jic23-huawei/

 drivers/staging/iio/frequency/ad9832.c | 32 -------------------------
 drivers/staging/iio/frequency/ad9832.h | 33 --------------------------
 2 files changed, 65 deletions(-)
 delete mode 100644 drivers/staging/iio/frequency/ad9832.h

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index 49388da5a6..e2ad3e5a7a 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -23,8 +23,6 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 
-#include "ad9832.h"
-
 #include "dds.h"
 
 /* Registers */
@@ -299,16 +297,10 @@ static const struct iio_info ad9832_info = {
 
 static int ad9832_probe(struct spi_device *spi)
 {
-	struct ad9832_platform_data *pdata = dev_get_platdata(&spi->dev);
 	struct iio_dev *indio_dev;
 	struct ad9832_state *st;
 	int ret;
 
-	if (!pdata) {
-		dev_dbg(&spi->dev, "no platform data?\n");
-		return -ENODEV;
-	}
-
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
 	if (!indio_dev)
 		return -ENOMEM;
@@ -379,30 +371,6 @@ static int ad9832_probe(struct spi_device *spi)
 		return ret;
 	}
 
-	ret = ad9832_write_frequency(st, AD9832_FREQ0HM, pdata->freq0);
-	if (ret)
-		return ret;
-
-	ret = ad9832_write_frequency(st, AD9832_FREQ1HM, pdata->freq1);
-	if (ret)
-		return ret;
-
-	ret = ad9832_write_phase(st, AD9832_PHASE0H, pdata->phase0);
-	if (ret)
-		return ret;
-
-	ret = ad9832_write_phase(st, AD9832_PHASE1H, pdata->phase1);
-	if (ret)
-		return ret;
-
-	ret = ad9832_write_phase(st, AD9832_PHASE2H, pdata->phase2);
-	if (ret)
-		return ret;
-
-	ret = ad9832_write_phase(st, AD9832_PHASE3H, pdata->phase3);
-	if (ret)
-		return ret;
-
 	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
diff --git a/drivers/staging/iio/frequency/ad9832.h b/drivers/staging/iio/frequency/ad9832.h
deleted file mode 100644
index d0d840edb8..0000000000
--- a/drivers/staging/iio/frequency/ad9832.h
+++ /dev/null
@@ -1,33 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * AD9832 SPI DDS driver
- *
- * Copyright 2011 Analog Devices Inc.
- */
-#ifndef IIO_DDS_AD9832_H_
-#define IIO_DDS_AD9832_H_
-
-/*
- * TODO: struct ad9832_platform_data needs to go into include/linux/iio
- */
-
-/**
- * struct ad9832_platform_data - platform specific information
- * @freq0:		power up freq0 tuning word in Hz
- * @freq1:		power up freq1 tuning word in Hz
- * @phase0:		power up phase0 value [0..4095] correlates with 0..2PI
- * @phase1:		power up phase1 value [0..4095] correlates with 0..2PI
- * @phase2:		power up phase2 value [0..4095] correlates with 0..2PI
- * @phase3:		power up phase3 value [0..4095] correlates with 0..2PI
- */
-
-struct ad9832_platform_data {
-	unsigned long		freq0;
-	unsigned long		freq1;
-	unsigned short		phase0;
-	unsigned short		phase1;
-	unsigned short		phase2;
-	unsigned short		phase3;
-};
-
-#endif /* IIO_DDS_AD9832_H_ */
-- 
2.43.0


