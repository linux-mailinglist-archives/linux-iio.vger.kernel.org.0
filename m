Return-Path: <linux-iio+bounces-19619-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C9AABAFC1
	for <lists+linux-iio@lfdr.de>; Sun, 18 May 2025 13:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F0C27A50BA
	for <lists+linux-iio@lfdr.de>; Sun, 18 May 2025 11:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D5B21ADA3;
	Sun, 18 May 2025 11:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHxQ+bpj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41AB219A89;
	Sun, 18 May 2025 11:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747566822; cv=none; b=j4x8yw45ab2BhpBoMeLoX/Z9uyjOlK9dqdrlklp7/NUdLnZunWGFuPykwg2T+G0FyN1huGDA3IVPm3xEV2JKkJ2LaM2qBk4kUNQqe2IHJaiWdIIhwx/Tvt2WUkXEPDr8s3BBZ6g1qFdL7LSg3F4BCv0eV47KrURXsCFQsXr1+W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747566822; c=relaxed/simple;
	bh=Bv+oEum1p9D+YG8VBoUJFzdegAl2TPTPtWPNdkz7Lig=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RQFQKJeZElRkNvdgas/XflMC7uoa9MN665Ulx4ZPHlhb7xSnjnI6pGUjO7EK22cE3Vv7CCkfj6D5tiRS7hmbTmBfcB1/Hx1bhoMZhOVIxcCheAjwtEFac8IMW3LGhxnq1nAeHHCUkL2XAExgNjub54sHwGzyCIchS1Z0O9hu3AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHxQ+bpj; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a367226ad2so169195f8f.0;
        Sun, 18 May 2025 04:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747566819; x=1748171619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ncWZ4jjjp6XB32qF1Br4RkScyWJ4V5bIlyOAukhTdNs=;
        b=UHxQ+bpjru6vzs9EIhi4uzhVh6KFnEUirzN0IFxA2qc7yDHKzc1uJ9v2d27J4kraP0
         n4ibZNI2Vy79TeK9FbtJKu+UK+b0taYheSUWntaqrgPeX5PZfi6pngvPEhrYw0Zv/OO9
         yBa7gGU059UmuOtV78ZfdFbFyC0j7Br9KUjPzH58H9oSbILzPx3xQuUX1Y0KTsSLcARI
         mpH1Lufrbws8JRAacQNg73Co1diOj/2bwcBNlc3A4Te6qyW7fBnZhOgQDLWd6i9XmWLz
         iPxSB/R1fojJNdu3Ngx56lwDA1V++vbr3tiBCFoLOb/yh/gsVPPvBRBkGIi2G6+iw5jR
         CkeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747566819; x=1748171619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ncWZ4jjjp6XB32qF1Br4RkScyWJ4V5bIlyOAukhTdNs=;
        b=iGI7BL4tljM1gqZ8mO2K8P0s4ocvAB5GIxcwlSTpW6UndS5Y0FIca2F6BrAIBD5Q8d
         SX0DcoBcL5qJXVwv8UUvoduviEHerjMska9/gXN8TNkGEbJzwNv7aXE2fCnc8QtLMrU3
         /6puJExPDImbSlTo2JIiALGVUDOhUa8j+kjbQPrH9COQEmLXu4DhvGgTQDyBiFmaHPFO
         H3UJK118uIAViC77pt5TZkKtnBN/r/uZ8fhHhgU/+0i7oAJ+9jfTDvwgnaoUnTbzqkVO
         VSeTM+kOXE++HKWlw2pdf6kw7WuRJnDwART+xzvdsXGKJsrh+cqP4IVa5dGrgyHn3B26
         ggZA==
X-Forwarded-Encrypted: i=1; AJvYcCW7CQ5EXbaI6dk1MpboDIZw3BWhSh/jHSxEtk9SH/Rh5Nqb4lj3RVfoG8bz+zAFU4bUIUia2fAz5tALDTbP@vger.kernel.org, AJvYcCXuVNdfhkM0eUx5U0wVAAqIqiIJ6OYzCP2p/SJIfOXhW+t+VCQtP17G9EW8AQF6kGWhaD+WqlUmVh4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC2k+mUq9Ijvr3kcRnm+5kYIoTzDkEzVNc8Xx+gkMtEP/YI/l2
	JuTpT52YRgDfHo8gFLZKD6i5TFrNi368xArzJcqrNYqygVtrGt3Rpfit
X-Gm-Gg: ASbGncsHTFRzrqoMNe0GcDvk97cY7pldw04LnA6snqsExOxR3BUr8NI2l8POEhUuMS4
	eC10IL16adAnwPNvnXKGjv3JcrH30F9hNPjGluytudRHAvnFd/1l2vOLeheq2Jyaz8VvNBpJNoT
	DOlDRMNQfD/TniH4VoOpJK+x+BkexLkx/0oMRFGlFH5W5qpX5aVCyiW3ahFyWcpQZEA3EeOrTVP
	p0agm0JzpLy2e2GqZHMe8nUY9eNIntrU/kby/diWFMobH3Bny4SvLtQH/5CViwWSP7HZC0g0Ery
	IyLZBKEOqTo8QamjuulOjRqyaPxXIBv5I8L2Moeh96D+5MpOvNSeEG9bTizxiRWrYZXsFnMHRfH
	BSCIk7HEvyuB47iVq5Hl/Gw==
X-Google-Smtp-Source: AGHT+IGShDkJDXwWVy3gi/p7emybaKdopmTMhfnbzWyEfYyMzgrEQCu0Tg2p5XflAaSNO2DNn4LbgA==
X-Received: by 2002:a05:6000:2012:b0:3a0:9575:fac2 with SMTP id ffacd0b85a97d-3a35c845459mr2556352f8f.13.1747566819012;
        Sun, 18 May 2025 04:13:39 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca4d1dfsm9287446f8f.18.2025.05.18.04.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 May 2025 04:13:38 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com
Cc: linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lothar Rubusch <l.rubusch@gmail.com>
Subject: [PATCH v1 04/12] iio: accel: adxl313: make use of regmap cache
Date: Sun, 18 May 2025 11:13:13 +0000
Message-Id: <20250518111321.75226-5-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250518111321.75226-1-l.rubusch@gmail.com>
References: <20250518111321.75226-1-l.rubusch@gmail.com>
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
index ab889d50b4d4..6e0c5704e333 100644
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


