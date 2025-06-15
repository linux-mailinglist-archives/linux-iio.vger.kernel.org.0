Return-Path: <linux-iio+bounces-20686-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BB7ADA451
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jun 2025 00:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9357E16906F
	for <lists+linux-iio@lfdr.de>; Sun, 15 Jun 2025 22:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBC227F747;
	Sun, 15 Jun 2025 22:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hx1jMFxH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EE21E4BE;
	Sun, 15 Jun 2025 22:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750026190; cv=none; b=pjoJIdKrXnzANctv/97MMZcntxWXm4kOm59KM2TnV7gXUVWRlsTJxCdlU6ffQ5Yf9+fRIKmrrzqKsFooDPVa6M1KJ4zkCMNkBcNo0N1RkjVifdKUvenbxQuEultxI2Qv2VT/9cViQUvO1xjlN5pE1rPL9c+Kcus0aMm7M+CwwG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750026190; c=relaxed/simple;
	bh=XjCwok4P/lRUHSEGFzqQ/bP+tTBFIbWyVqSF2e0Toj8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tT1Rm9Sw9Cgm/R1YjZQ/60mtsfOhgzAga38ilGu2N6hyJ/lfVby5eyRE4hVUDw8VUi4yGONlPPdDSiOFAgu58N/T9E8weXUJNx82FI4oEvQBJ8jJ3xBluPQ1H8VLkMjII4nUBTOkhLYMW+zFd/jgkYAh8E27hzr/vFn8M89nyag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hx1jMFxH; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ad89c10dfabso109807366b.0;
        Sun, 15 Jun 2025 15:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750026187; x=1750630987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZSSTsxLI9eNEfTQkHUSiZwxVDDndT1QNIjJcXV88c3g=;
        b=hx1jMFxH+c4DHC488UTLEY3FCNbjGhnpQN49JeJwDx85gikXP9twDfWTdogBcpOwkd
         99OmFNzzX3SLSblyv/QHzwDKGb4gIBeCbqWmn99z6YB8XXOldyz+ED4BYCQncabmzNUW
         aHJHO41TPjCyD/chw0mNlMaQ2uiF9SL4/6/bzG3Jjw61JKiW4T1jR4gSAhTPg73i34WE
         MXyFRYgzO1c/aE7ycHl2yN0THQyEpm7B3sxwLBCYs/ugWtfRxaz6xNOJ3i4epns8d5Jh
         Z/jrZhhbTIRDazDlPODdLgv1Nqq79UfjEUyJldnrZoZAHA8FLS/20mR741+gf9wD81So
         5nxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750026187; x=1750630987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZSSTsxLI9eNEfTQkHUSiZwxVDDndT1QNIjJcXV88c3g=;
        b=gbo9xCz6s4/2R5O4CN7bSbPsBusnFNFCgdnB5T2itwD/cBM38dklHv5Ia0xxX45A3N
         8PiWaGqik8YSdAH4qHvsvP9nhRNi3NCPO5YLS/SZxFjnwI1czo6/oZxReDaAW/wRYgQE
         +0RFIPH5BjWbdgKuStYCZkIMj14q/+NEObHSEqS8skgZNy3+2rbS0JPcVK7aTkX6d6AI
         iR3HNkS+wKATdlcoRTYdFbx2XFa+szrxZYw+NfRg8qlyAado5MAv6VjL6EiptDKlEMcI
         uvj7HZ+CkdaK56z/sJnxfiOT9HDStt/+3bngPrqeoYEPP8EkeIeAjPaReSWAmfUJZ5c9
         PUlw==
X-Forwarded-Encrypted: i=1; AJvYcCUoiXLuIfKpDFGxWH+L+Pir1yKRrJVO7I+Hi7KauF8+W9k9D9xuKyBBXCDPqCrTiW0tWhaWEyHsQ5ZY@vger.kernel.org, AJvYcCVqAslqP3D5hQBJzQ+/L2bar1mKlXV5RWsRvN9E/TYrgDWyLYZ2heJxrCvjJ8bCMsp3E+DcIuTyyRg/nCJM@vger.kernel.org, AJvYcCX2bjPw75kDde0kWZ7VX48fg2MnND7DbS+T83G4gQO2EfmbgiMfFVIfbDQ2so7veMmBF/qzFuEDQXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwG0tz8jyIQwqjF3GAxANwb0ZDtAe4Q0S0eax3gcjOJBsSzlnX
	2kEWC2dkWsFVcjUhZsZLTmll83sQpRLjH6Hjw5kS58P4cI4iHdjtsoZz
X-Gm-Gg: ASbGncs708ol50OOAE5WQlAbzBPp+2UmnrkuZWaVsc1iyrP2r65K+s7UrsUhXkLOphI
	MEs2qNDw5uFMU7zlxh7RRvUvkF3EcZI8aue53kSwAX0nrbf60/Ml8k1QOcvry5Sv7+EmRYBtSCo
	SFgiYOpWBOSFiHYO+RI1MPHywm2YhGM+6K9tgfrSDgK6bZwIzj0zr4g6ccZJtRKJyupA+UkKKuS
	jN7VZmgCTfAEniZxJMTiGGlLrhabATX3eQvDiglMMwmHzG2zdUPhV0ssS4aeEnjKL31qLEuKZ41
	z1P8AYzpiyWBluyoMY88xynso56zhvEHe9ueKCgULMMqsbYuRgh7Mjpuagp5IBK8+OUlaYj6guH
	ITIh19hGQbYocGPQ4MHeA7EHdLm11+xAM
X-Google-Smtp-Source: AGHT+IEmHk2xK58T3WeDA20lR3opzcP/HZi1SuNRlKyxsiqwVg4AvnoOJHI3JoyZZ/x3ZBpz54TINg==
X-Received: by 2002:a17:907:70b:b0:ad8:8189:2563 with SMTP id a640c23a62f3a-adfad550105mr218303466b.12.1750026186603;
        Sun, 15 Jun 2025 15:23:06 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adf8b393ea8sm412692766b.159.2025.06.15.15.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 15:23:06 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	bagasdotme@gmail.com
Cc: l.rubusch@gmail.com,
	linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/8] iio: accel: adxl313: make use of regmap cache
Date: Sun, 15 Jun 2025 22:22:51 +0000
Message-Id: <20250615222258.117771-2-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250615222258.117771-1-l.rubusch@gmail.com>
References: <20250615222258.117771-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Setup regmap cache to cache register configuration, reducing bus traffic
for repeated accesses to non volatile registers.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl313.h      |  3 +++
 drivers/iio/accel/adxl313_core.c | 18 ++++++++++++++++++
 drivers/iio/accel/adxl313_i2c.c  |  6 ++++++
 drivers/iio/accel/adxl313_spi.c  |  6 ++++++
 4 files changed, 33 insertions(+)

diff --git a/drivers/iio/accel/adxl313.h b/drivers/iio/accel/adxl313.h
index 72f624af4686..2bc86ac8ffd4 100644
--- a/drivers/iio/accel/adxl313.h
+++ b/drivers/iio/accel/adxl313.h
@@ -22,6 +22,7 @@
 #define ADXL313_REG_BW_RATE		0x2C
 #define ADXL313_REG_POWER_CTL		0x2D
 #define ADXL313_REG_INT_MAP		0x2F
+#define ADXL313_REG_INT_SOURCE		0x30
 #define ADXL313_REG_DATA_FORMAT		0x31
 #define ADXL313_REG_DATA_AXIS(index)	(0x32 + ((index) * 2))
 #define ADXL313_REG_FIFO_CTL		0x38
@@ -54,6 +55,8 @@ extern const struct regmap_access_table adxl312_writable_regs_table;
 extern const struct regmap_access_table adxl313_writable_regs_table;
 extern const struct regmap_access_table adxl314_writable_regs_table;
 
+bool adxl313_is_volatile_reg(struct device *dev, unsigned int reg);
+
 enum adxl313_device_type {
 	ADXL312,
 	ADXL313,
diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
index 2f26da5857d4..39f16f97bb4a 100644
--- a/drivers/iio/accel/adxl313_core.c
+++ b/drivers/iio/accel/adxl313_core.c
@@ -46,6 +46,24 @@ const struct regmap_access_table adxl314_readable_regs_table = {
 };
 EXPORT_SYMBOL_NS_GPL(adxl314_readable_regs_table, IIO_ADXL313);
 
+bool adxl313_is_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case ADXL313_REG_DATA_AXIS(0):
+	case ADXL313_REG_DATA_AXIS(1):
+	case ADXL313_REG_DATA_AXIS(2):
+	case ADXL313_REG_DATA_AXIS(3):
+	case ADXL313_REG_DATA_AXIS(4):
+	case ADXL313_REG_DATA_AXIS(5):
+	case ADXL313_REG_FIFO_STATUS:
+	case ADXL313_REG_INT_SOURCE:
+		return true;
+	default:
+		return false;
+	}
+}
+EXPORT_SYMBOL_NS_GPL(adxl313_is_volatile_reg, "IIO_ADXL313");
+
 static int adxl312_check_id(struct device *dev,
 			    struct adxl313_data *data)
 {
diff --git a/drivers/iio/accel/adxl313_i2c.c b/drivers/iio/accel/adxl313_i2c.c
index a4cf0cf2c5aa..e8636e8ab14f 100644
--- a/drivers/iio/accel/adxl313_i2c.c
+++ b/drivers/iio/accel/adxl313_i2c.c
@@ -21,6 +21,8 @@ static const struct regmap_config adxl31x_i2c_regmap_config[] = {
 		.rd_table	= &adxl312_readable_regs_table,
 		.wr_table	= &adxl312_writable_regs_table,
 		.max_register	= 0x39,
+		.volatile_reg	= adxl313_is_volatile_reg,
+		.cache_type	= REGCACHE_MAPLE,
 	},
 	[ADXL313] = {
 		.reg_bits	= 8,
@@ -28,6 +30,8 @@ static const struct regmap_config adxl31x_i2c_regmap_config[] = {
 		.rd_table	= &adxl313_readable_regs_table,
 		.wr_table	= &adxl313_writable_regs_table,
 		.max_register	= 0x39,
+		.volatile_reg	= adxl313_is_volatile_reg,
+		.cache_type	= REGCACHE_MAPLE,
 	},
 	[ADXL314] = {
 		.reg_bits	= 8,
@@ -35,6 +39,8 @@ static const struct regmap_config adxl31x_i2c_regmap_config[] = {
 		.rd_table	= &adxl314_readable_regs_table,
 		.wr_table	= &adxl314_writable_regs_table,
 		.max_register	= 0x39,
+		.volatile_reg	= adxl313_is_volatile_reg,
+		.cache_type	= REGCACHE_MAPLE,
 	},
 };
 
diff --git a/drivers/iio/accel/adxl313_spi.c b/drivers/iio/accel/adxl313_spi.c
index 9a16b40bff34..68e323e81aeb 100644
--- a/drivers/iio/accel/adxl313_spi.c
+++ b/drivers/iio/accel/adxl313_spi.c
@@ -24,6 +24,8 @@ static const struct regmap_config adxl31x_spi_regmap_config[] = {
 		.max_register	= 0x39,
 		/* Setting bits 7 and 6 enables multiple-byte read */
 		.read_flag_mask	= BIT(7) | BIT(6),
+		.volatile_reg	= adxl313_is_volatile_reg,
+		.cache_type	= REGCACHE_MAPLE,
 	},
 	[ADXL313] = {
 		.reg_bits	= 8,
@@ -33,6 +35,8 @@ static const struct regmap_config adxl31x_spi_regmap_config[] = {
 		.max_register	= 0x39,
 		/* Setting bits 7 and 6 enables multiple-byte read */
 		.read_flag_mask	= BIT(7) | BIT(6),
+		.volatile_reg	= adxl313_is_volatile_reg,
+		.cache_type	= REGCACHE_MAPLE,
 	},
 	[ADXL314] = {
 		.reg_bits	= 8,
@@ -42,6 +46,8 @@ static const struct regmap_config adxl31x_spi_regmap_config[] = {
 		.max_register	= 0x39,
 		/* Setting bits 7 and 6 enables multiple-byte read */
 		.read_flag_mask	= BIT(7) | BIT(6),
+		.volatile_reg	= adxl313_is_volatile_reg,
+		.cache_type	= REGCACHE_MAPLE,
 	},
 };
 
-- 
2.39.5


