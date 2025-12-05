Return-Path: <linux-iio+bounces-26810-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B87CA9436
	for <lists+linux-iio@lfdr.de>; Fri, 05 Dec 2025 21:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5AAE5302C2BA
	for <lists+linux-iio@lfdr.de>; Fri,  5 Dec 2025 20:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499EA2D780C;
	Fri,  5 Dec 2025 20:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKn1o3tU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8982DF146
	for <linux-iio@vger.kernel.org>; Fri,  5 Dec 2025 20:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764966505; cv=none; b=Fkiba1cHuSbDvdmzmyKypJU1Z8uDoPuhUN+tSbRCF7lLtxLyxdPWJnBCUasVDE1q40pRyDrCnkEIj885hIvCt5n7qwKnAaOiuqwlbYfYQzfSs/0YuxveetLqHqK+o+60d8rMEu/AMRdJWPMp13ZW7Vx/K1SAHmSa9OOixAjB7D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764966505; c=relaxed/simple;
	bh=VhjRdW4KfUHyNC/C+mtuazEPEEU4C1nG1wSKWcNKCz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u5R6gHAm6whbuNKEmU/9sp3gtT0dFlfJydzXakcTuH/0MAlcIkjd5k55L95+uE6Z2Y8qwXlUs0HTjx30aqrcDuTBpXPJrO2a82zW80DFP3WkaB4ToLqiH8iovcw07ZYfguZisUEzbg/QggDjZX6NK+RvwnhUiyqbE+8Ez4AG6Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MKn1o3tU; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-29568d93e87so25668735ad.2
        for <linux-iio@vger.kernel.org>; Fri, 05 Dec 2025 12:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764966502; x=1765571302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E1kT6K3Ob3aEghOazhmPBd7i4Md15BQDt3Jsih2JLy4=;
        b=MKn1o3tUnHf9twNB9HPSWc72dHvYzvEZMSPZXLxM5ktt1RAM41qAwCqwxXhlebs4Ua
         2WzKVwjK4gnZYZ9e+DIURGJu3+tUZXvcwhFdML7bZ8z6nlfkU+9Fbp1ubJfxPf6OYQ9z
         JeN38YGOB7XOYh7TM9m9GkhKFTQZqX8yWUlT0kX992xjHPeRadtGqsqNbvnHgPbdjrYD
         dLx55JDxe+nJiklEk0yA0RzMKLx8tzMpIiEDWC4oMgzlv/H7kfaoDgFXdqTRApxemIn+
         mMwuYcCMPgIjEKBTZMklSXLAPRWNOD6K95SbBph6c+XKJbzajGvBI5p5zVvof40/ESLp
         YWlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764966502; x=1765571302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E1kT6K3Ob3aEghOazhmPBd7i4Md15BQDt3Jsih2JLy4=;
        b=ixhKMbsq+1Qqv9Dbgw8SfmS0adiGJvt3XGLceDCz8J5Y9LkoAKoQX2TDk3Q4NE69Cv
         xtI8bte8JBWElzlL6rgGM4VgA0zTJ/n14tShIg3JZ1arqFCQDGr8nrE/1AeZDpw9VR/h
         cZ5DTn++A9noSgsYg1e8U/+qPifNlQqHNIudLfaL24PMH4ztjP7bQFDChVi9/Sw4BQgP
         iMHdIiYCSaUO+93ClWxeCQRqRXdUB0EkZO1MQUwtYsa/e4V2Y/Zu63H8B/sLmAn3HEya
         llbnOZ+b8UR5wBB/qLhVppfHgdWr16ndPLgfklNV8rJOmWkfBCFaFIWWwzT77E/i/xYR
         2oBw==
X-Forwarded-Encrypted: i=1; AJvYcCUQyNK+oDXQpw07LjYaplapnV0IOkHaCSriw81Vt/2wLFqkJ6buBEdVohvqT71vos5hr/YbjloTWSw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx98TOoRVG/r8zbpKo5dnUePc5uExCFx9IVF+w79jJKOlsOKK8A
	n/WXzsNia5E0by/myVAfy/cU253DOWBBL42gucj+lCwpSJ824fyptU9u
X-Gm-Gg: ASbGncsQqnE7QQXDBL1D4ZtIElDnmAlGf/VxCR9Bh42KgAY761AscmuB6A8yK/vc5vj
	x/ANNyJ8/GU9FnqdovuJZRhrqs2fY5mAhFAjOpn6nnRYQUzdHcPEfiRcVouJKyNT7oTocmx4qjH
	w4XcDpKResLl7KQix2VLiDNa6Z/29Hxwz+/ocS3OddCQBOBJQe/SaUIef5W3Sq2wULk+3tIf/z2
	n7BuD3XG7aIV7hLvIQYGx7toP4+FcqCZhMkIqZc054V+nIEmw76zMYalcmaeB2UR8UHj3mfeWEp
	n1hhm0EurcGIBSmdsS4RRZIrGOzlvBmpvQVZ0sfT31y13uak9m1swoiFMoCB/8ZUr3MtGCYg6do
	QHXDj6eZXpUnaLdGR/Uo/Ie4mTc2TSOvrg/9stTQ+KTFGZYTIBJ8xHQrHnt38zovXPbuvZuDn83
	ThvHs2+i4qoMevyI0DdVCUfSdWRFpWURnHnJBQr8jIVMArHasa/IAmoe/bghbvoZTZYB5Bd5AFl
	+PNhBdYgniWpXfSsLKEF0Qg8WogfktvWVKaugcusqRFnEMcavXZ7H7lQQJHZZ7eO8wqK5/4
X-Google-Smtp-Source: AGHT+IFTMT5Gqt3zxUUZz4Uief0KidTbdHtVVj8Bdg+zDGW3adOU9RZX8JRZKLTJtpJNPMg3XEQQqQ==
X-Received: by 2002:a17:902:e783:b0:296:3f23:b93b with SMTP id d9443c01a7336-29df5a9d23fmr1726475ad.2.1764966502353;
        Fri, 05 Dec 2025 12:28:22 -0800 (PST)
Received: from Lewboski.localdomain ([181.191.143.42])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae99fa59sm57256845ad.58.2025.12.05.12.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 12:28:22 -0800 (PST)
From: Tomas Borquez <tomasborquez13@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Tomas Borquez <tomasborquez13@gmail.com>
Subject: [RFC PATCH 1/3] staging: iio: ad9832: remove platform_data support
Date: Fri,  5 Dec 2025 17:27:41 -0300
Message-ID: <20251205202743.10530-2-tomasborquez13@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251205202743.10530-1-tomasborquez13@gmail.com>
References: <20251205202743.10530-1-tomasborquez13@gmail.com>
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

Original discussion started here [1].

Link: https://lore.kernel.org/linux-iio/20250628161040.3d21e2c4@jic23-huawei/ [1]
Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Tomas Borquez <tomasborquez13@gmail.com>
---
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


