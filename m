Return-Path: <linux-iio+bounces-19752-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1188EABE78D
	for <lists+linux-iio@lfdr.de>; Wed, 21 May 2025 00:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEDA24A311F
	for <lists+linux-iio@lfdr.de>; Tue, 20 May 2025 22:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD4C261591;
	Tue, 20 May 2025 22:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RiAUaF/t"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5CA25F78E;
	Tue, 20 May 2025 22:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747781444; cv=none; b=D7rXog4S314otrkzeCSuS3KSj+/3nxqSg4zzuKDI/SBHgnPOz9Q6lrVo6ywitzPza+bcfGjh61Yc/NYViRerFxkt+JRhyUatLrJ2g7xE500eCB7Vnhhxnm39nVPSJMXIcgjSvnwEmyiupmiKZl3z8kwxcSLlDcDEPOkXOsY65EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747781444; c=relaxed/simple;
	bh=TCQwLS0syikPNV8WT/BYxzCcTwgQbI6UeNAiGmncCIE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NwV+bAstV2d9gfUk943/Z0l4I04iQSSBWbHKznDJLExswN2n9E2r6ZnLI+18Hr55ctc+DMtyfjAoPq5sMacIRH3R+5Hn3hqz5G6vRHLx83C2vdfAU7bye2XeV/nnH7QFQC6Aq1/J965gOpfNAGLIj/HmjYqFcRQwYC1CNV9kYnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RiAUaF/t; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a368259589so550556f8f.3;
        Tue, 20 May 2025 15:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747781441; x=1748386241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=68q0Ncd5UfHcauV6RTmhDNGvafZvU2UqPZBnr2W5EoE=;
        b=RiAUaF/tsI97gptoBpadk9AYZ+h7bHHGzEIXXEk2YQfs930egTTrcyYyCLbLr7z8tb
         HNT+4H5pqs9hDJlla76mPNeHZvl3sJ/nORnKF/+xEs9Nf1pn04KmvgudnrCFJXQAQ83f
         2Ikcx8WCfDYtUcxWQxqtkAgpY8DopiyAG0g01Dvo6J1kgkrWkJ1JzptENCeNeFltGc0t
         byWQh2BUVPSN34opxarIasWcp8jn0ptcg7HvHr4QXmwrORNZdrdZWAPYjIhtN7u+JMf5
         Me5VyiBjCvfIoseE5oiJn6HLorstwXLSJhlJkD8P9tBw8WKbsTvMe0M2qVL6ceiGbCvH
         Rmrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747781441; x=1748386241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=68q0Ncd5UfHcauV6RTmhDNGvafZvU2UqPZBnr2W5EoE=;
        b=JebPuo8Ndfxu1My74ozoS5jsoiLs0DN0IyLLHS8khMaNMzlK+Q2mg0iVNpqJg2Xk6x
         S8VQTu26h2T6+IQyOLrbSRs0pZHnaLen5iALuA64pwsvovn+2McyNOZVUr43tiP//ljJ
         Jx7qYMICmEh76ig8k/Uofx56++EWFDkXimoncS2cVzS9avglpf2ip/2IAR5WbehmyPXi
         sahJMyO5CHyxtwCft5KI2bdINzeGeFGolhJ7/w3AVQlzI6OeegxjSzqa64m2r7UO+Mna
         MreSJ7hEVSBitkG0yWkjigKwCNlh/6I2pZimdPM2mVzhQ7JxHK0epZM0Do8r/Ns47a9c
         BbQA==
X-Forwarded-Encrypted: i=1; AJvYcCU13y4xl/v3D4QoqfuGCD/rYzl6vEZq5qN/4aRlPoia6Zw65iBU4z/3sHbrxmK46zv4AbrZ/dbshgmfmf5L@vger.kernel.org, AJvYcCXEwUIBvfU2ecnJqNlWLW/oZbtKIvBlu5guxaivhMHLvVkRtiLy0X1eOYtLLzxU+XQoBhdCedPvl8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuWtv1jISd1cHVT94SWxNKKHamcuz6+BXzlONvwLZ6j3Uo2eao
	bD0fwKGAFLpBAYW579E8zxnWTfuOC7gIHA4i8vgv5+yLyGNB/jN3QM6+
X-Gm-Gg: ASbGncu9uigK2CrvhoSgjqm7Ni2CIAgN7gtAgDnCXE7t3QSbT/nDBaMLbC3DWXtSwyr
	youLfsvYA2xXPTtbaZvonxxPE7fBVJ3C+S6RSX8RhtQRWZQ/W8S0Up1gkAyA06Ngah1+UR/RUET
	BMxwFWPDQpRwK0WyWJVmX1C2CIqHtRKVzVEoU30Q6Hpg0woEJA0PZQjn7MIH/wBwkG3jKqwTWk5
	ILPvIH+oLQQW3qJZlOqOMr1H7V33/2lA/+I3YACVK0P2Oa5PGsDQnWBULMGH71zQh0GRyZDHv05
	wRxpSR6de+BMMgqTJA/ev1W9UL4K3VazZ16TM61T15bmYybIVMABHr05lh/8F2BnrCOgX47dVXq
	H4TiMY0Vo7hsyorUPim7LTA==
X-Google-Smtp-Source: AGHT+IEvWWKqbi3SN6ESKboPx+X/Fg/msPMTxQ7GaEcMGWlZ5qQo5C8dLN+c/GTueDRt95X9q08kxA==
X-Received: by 2002:a5d:5f46:0:b0:3a0:b807:742c with SMTP id ffacd0b85a97d-3a35c826936mr6436308f8f.6.1747781441168;
        Tue, 20 May 2025 15:50:41 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca4d105sm18101588f8f.11.2025.05.20.15.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 15:50:40 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	l.rubusch@gmail.com
Cc: linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/12] iio: accel: adxl313: make use of regmap cache
Date: Tue, 20 May 2025 22:49:59 +0000
Message-Id: <20250520225007.10990-5-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250520225007.10990-1-l.rubusch@gmail.com>
References: <20250520225007.10990-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Setup regmap cache to cache register configuration. This is a preparatory
step for follow up patches, to allow easy acces to the cached
configuration.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl313.h      |  2 ++
 drivers/iio/accel/adxl313_core.c | 17 +++++++++++++++++
 drivers/iio/accel/adxl313_i2c.c  |  6 ++++++
 drivers/iio/accel/adxl313_spi.c  |  6 ++++++
 4 files changed, 31 insertions(+)

diff --git a/drivers/iio/accel/adxl313.h b/drivers/iio/accel/adxl313.h
index 72f624af4686..fc937bdf83b6 100644
--- a/drivers/iio/accel/adxl313.h
+++ b/drivers/iio/accel/adxl313.h
@@ -54,6 +54,8 @@ extern const struct regmap_access_table adxl312_writable_regs_table;
 extern const struct regmap_access_table adxl313_writable_regs_table;
 extern const struct regmap_access_table adxl314_writable_regs_table;
 
+bool adxl313_is_volatile_reg(struct device *dev, unsigned int reg);
+
 enum adxl313_device_type {
 	ADXL312,
 	ADXL313,
diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
index 06a771bb4726..0c893c286017 100644
--- a/drivers/iio/accel/adxl313_core.c
+++ b/drivers/iio/accel/adxl313_core.c
@@ -46,6 +46,23 @@ const struct regmap_access_table adxl314_readable_regs_table = {
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


