Return-Path: <linux-iio+bounces-21271-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9449AF65F3
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 01:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F9FE7B2864
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 23:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886A32609E6;
	Wed,  2 Jul 2025 23:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSb3wCQH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8141224468B;
	Wed,  2 Jul 2025 23:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751497708; cv=none; b=jHOIRtNdSL1COUyg3jJn2vDXGebomqsp3YCtbVYRwjc3Jd/c+5F1KsqxtkdukL0fVXXZcqsVlNphIi76aQqRLmcU0fOMHgYvAyBdtpGBqBr4JNRRqTOyD74oAlV0awn4ChEY5I5FEOa9VjJu2Dlvkpw5G5eQ+ZXB4stfqs5lXgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751497708; c=relaxed/simple;
	bh=Z2XacSIID+4lkYZM56GjoTT4Y5pbDnIpPBGUC1jJzOk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NIBaYS2QtPd8RLwkH7+r4gO6NJCw8MuIE4Q11yfgL6MczM7fDNUxZI2UpF/G+Dq6UO538DLt7OytanN6NmKpWgnSG0TByqfMu+ZMPt7j268N3QmNgFVAoRkdONf51d9aFgc97rx5eiCMjCmB9WP4VrHPMePn5bJjCLevAFF4GMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YSb3wCQH; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ae34f43be56so76265566b.2;
        Wed, 02 Jul 2025 16:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751497705; x=1752102505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7BwLEP9LlzZdfUMh50cIBwDtf2I1quEhp+zF9nPrh4w=;
        b=YSb3wCQHjisywLOaXoEmS30FbNOAS2kXC9xbZRc2ZtF/APJXKyJ1/agQ8Im2JByzAp
         07yBIUOhp6MfZurQZerKCmMYoPBrftp+DygHenVCLvDGoR1irQkriMa8gM6I3b5HJyFO
         Afi7+OLnk65gyWow3o4xpK0APJUL2/TVOKprfJbpBn5aHxhOq6RGDmX+EvZKu/qQrME8
         qaiokBmcPIuAyQdqDdDsjovoDDvRL9MDfRSm+5IXpY5MKBQQB5+ZEPnArDVtIW+MPBI5
         p9wuCjH8mdvxIOWnMaq8E92xpz45R31U0KM+dShdkf5lqvUmSSZA+8rTJWlDejhJ8SLG
         BnKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751497705; x=1752102505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7BwLEP9LlzZdfUMh50cIBwDtf2I1quEhp+zF9nPrh4w=;
        b=rUpAK+9GOz5YtWe6qqj63ifZq7TyTPJnhwiABKlaT5y1+XU9WxWL2bJlKPW81v95Jn
         H65BBr+B+/7JeaAa4F9mfIOzt/XbZO7u4GiSZTHBm47EvYlQTsqQTlvkZSEAQ0L5mg5P
         VMgBFaEBXnGQAu+8bdqOgzYgnZavTwcNW5Ae8XbUcScDp6wH9oqhx0nm+fzBFHqeZHj/
         QVRUdmaB6gmceKO4j6jK68E9cg38kOstNCZMET5YA+l6pTyf81oij7XXqa7bEHov7+bP
         PYSI8C7lhfXmxnbrge0T+7cQV75Dw4CChLgYk2XI0zBSiN7Ab8E/kZYsyASkPdjNj8F6
         t3zg==
X-Forwarded-Encrypted: i=1; AJvYcCU9JuWM//qFeHqp6CTUs38f06p9HmUPHcPMXjJewVeRhiXFjXUvc7ratyNlVU3hhZ4LyMw5hrv2ayaF@vger.kernel.org, AJvYcCVRVRzp9gScl1RYu65n2s7N/g+rjGeX1SMSf/FkeAJo0P+oRyHUj9g3y78yEiLWCWFKuasWd46CssqYrIup@vger.kernel.org, AJvYcCX6W+pZiA+PEyicTN0tZ3DjqoEGPXJyrp1jvWjCgDgyPSLP5Hzem4CJueOj3wShG2JksgwyaH2LSQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKHstv5RawTdDcWyQ/ZnxegfBZKFb3UK4suPTNRBISKw1yONQS
	kx/bMJuHJOENMOtkv6a8j9MCFAIcLtIDl2JSEFoKoF6yV01aHtzx+dPV
X-Gm-Gg: ASbGncvgiwzNCLAcbOtntsL4PvEggMWw3AEowt+qlULhUwO3N+r+byjNEhz64TFTJIs
	3ueks5Iq6/oZ/SZJ8MDe99HqSPcAsa8atMwivngDO5VB/kVxhJykSjXXFuFMjwdVfBVh/xCBIir
	ISnsoVHZoesUseQbej1izKOc1lWH9voq/RjVevGIeeF3iIBTBOfo6Zt2bWPYrWwqP5hfUN98lQV
	0TpxkyboO1h7aWl303OoXOQhtExViQ6wJ0USy13YFfBGbDjNANASHaxtbT+SYbJr66zOZvaiuaP
	vQkHIgcyhybc3vj2x5sijRKsnrWU9Yy6C0qi6fle3UX66o8akKG7LvSCPwbk5xRubeOT9g5iwXy
	6UZg49oB1as/gxa1CIfKW86HCyQUIH/nK
X-Google-Smtp-Source: AGHT+IFt9r/Kfes1GR3sPNDTetl98lRZVJOGcdXz8SB8ozOVeo0OmH7OUn9i5Uur8BS/o+qA8l4AZQ==
X-Received: by 2002:a17:906:6a10:b0:ad8:8f5a:9d2b with SMTP id a640c23a62f3a-ae3e2a2a444mr3789066b.16.1751497704653;
        Wed, 02 Jul 2025 16:08:24 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353ca18bbsm1158355566b.151.2025.07.02.16.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 16:08:24 -0700 (PDT)
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
Subject: [PATCH v7 1/8] iio: accel: adxl313: make use of regmap cache
Date: Wed,  2 Jul 2025 23:08:12 +0000
Message-Id: <20250702230819.19353-2-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250702230819.19353-1-l.rubusch@gmail.com>
References: <20250702230819.19353-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Setup regmap cache to cache register configuration, reducing bus traffic
for repeated accesses to non volatile registers.

Reviewed-by: Andy Shevchenko <andy@kernel.org>
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
index 8996180f1e18..dc5f04b17b29 100644
--- a/drivers/iio/accel/adxl313_core.c
+++ b/drivers/iio/accel/adxl313_core.c
@@ -46,6 +46,24 @@ const struct regmap_access_table adxl314_readable_regs_table = {
 };
 EXPORT_SYMBOL_NS_GPL(adxl314_readable_regs_table, "IIO_ADXL313");
 
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
index dfa51860cd83..b67ff0b4dc54 100644
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
index 17b25f3b2027..cb6a676ec7a0 100644
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


