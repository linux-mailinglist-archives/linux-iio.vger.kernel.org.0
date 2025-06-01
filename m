Return-Path: <linux-iio+bounces-20100-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE86AC9F85
	for <lists+linux-iio@lfdr.de>; Sun,  1 Jun 2025 19:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D1011716BD
	for <lists+linux-iio@lfdr.de>; Sun,  1 Jun 2025 17:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053CB1FAC34;
	Sun,  1 Jun 2025 17:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMhVIBwB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1CB1F151D;
	Sun,  1 Jun 2025 17:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748798516; cv=none; b=ZeBiz93Amea+VI0A/nNWX9uSSo95qigyx/iuS+nvrLCeEZdpzYqgG4Z5ueCEP2GdOc5q/GsNfFiekNr5GrCAs59ihFMdXm9oA7StvJAvyC2Zy8Z5ywqobXGgPVQYnW+u9RWa/0BCejwrK5SSTvdWWj8hbHrEfu1LwWexwcPVpv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748798516; c=relaxed/simple;
	bh=/p9vBRUZH5DSs8sEgpgj+vVFu1JVSWMfF5ad2iZj84c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gb8jyyfsHjner6NfGZ0sM0ZZKcDhKqbK61mWNYUeBRX/sWkKoCFrPY2H+AiKL6rHbds090lK99KttzaPrpghDZBAPuBU9MzlM2+QDENAPCVFwsXUt76YsluD2wuBBrqSHXZMiOwSLSNUjB+0CCISsYVNDkbUVCf8rKmgd000Jp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RMhVIBwB; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-450ddb35583so424065e9.1;
        Sun, 01 Jun 2025 10:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748798513; x=1749403313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nkC+i/O09kqU1WcdP/dP2GnoPIaaTxjblb2LNGEDcpA=;
        b=RMhVIBwByxcbPlVMreb+0y3tMJ3+rlnatFL1vcWxZDC3YKE/oyyv4UyxdMde8Udjw1
         xUcDJdbpopXUV3K9E7njDL0TsYw8bv7IBsUGs6cSv1UW331jT+kBKLwQTFj+s7tGhvgm
         Yx9094T/m3CBqkkD+14FhFe2QIIo25YtDTbBZebGweIh75D7CGAv3VxWJhI+iblXkXUF
         fk3IEH0NDW6rERHHPjmmhD5LFo/sFBSeLt3+zyKLMSeUe9WZCHpCxt/iPIQx5ks9pjUb
         r4g7ycPIJKPn2L5/HlPQCaeBOBdGmXTcP9GHX/a9deQNm0IZTYrT8UE/pC02Lt3a/2HX
         GLmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748798513; x=1749403313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nkC+i/O09kqU1WcdP/dP2GnoPIaaTxjblb2LNGEDcpA=;
        b=CqJCc1++qkutghuKTsLtqv1/iAmsGn2Rz1hOwDcDKI8kVk/6GKu8QUcI6ip/Va7aL/
         Nz5PLAMRJ2prdDB4yFmKESjfOq0QUs04jCyFfCK18BBHw2HfEqYbRnxcp26FKnxs4SCc
         4DZVNHBHfk5ImYNP+3lXQhSp6MP69zOGvl8Nocxre5nE54t5XTvPm2s2tcGV9qXTbYKa
         xfgkFvrV+vIVvPD2uofh5j36F2QjpbeONx3AUFKY3Ythsen8+euM5HAE3YdUm0JZZKUd
         tZku905r8ILk28yruhagZB2Lm+YUxdbtFb2OTkSVifFf3Mzzu+0uwV0/D4nO4HO88p/S
         TWQA==
X-Forwarded-Encrypted: i=1; AJvYcCVX2d4fvbEoGTYYOfdfSVjCaRQRmDSAch4ULYY66jITgcgdChEz/RH1HZLhrah1hw+dqDPeHLTNCUAaGKZi@vger.kernel.org, AJvYcCVzS4rDHp0DfJv66vgTsgv+4NzVu42WgRGg9IlNKH/0mpWva5+foXxMA27rfzDk8Ex4V0j41/WdSio=@vger.kernel.org, AJvYcCW1bor65hSan3wji1Ka45YRUpFsZnf2TBYEhTyLs+RkfP0Of4ZoKIyOPylUnz+74uOFRcZJrf52Jqi4@vger.kernel.org
X-Gm-Message-State: AOJu0YwjlWlpU4/+plySTgvKICGdbGpoERzpPealy3zOWyH5iElzvCcN
	T5f+AAj5JZILBL06ODcwayJ1dlfWOURPh2hRmdBVYaUZq5ZeG+Ro7Q2a
X-Gm-Gg: ASbGncsk4XxJOIi3wQVVmoO0Bp28aLjUl+zHJ9fjI9WIRRZ8LqN862iVMpih/kDv2sI
	FLQPrySGHz9znDTws59P0+QbVL9icNIW4/k3YrnN1EIi9F6o+w3PP1YPfksllZbV/LhMhJWxBcA
	VFAKdvcKi/E8acnGp9JFpCa5Ne5X1C6NcCKkD9CViW2+tQ5OciyY19CfT+LmDdTfRX7bUjlwGGO
	SGeFXP2g6R6FV90tHquwdWnhFN9NcZnczH+T320e/x12kdt4/aSy4dRfIAFfmzWiieIVSXhANfl
	2WDUT2U3MFjW/RAAyxaJjpD4QBAotfb9lm7nq7a3virRG9yfftw8OmjW19eQqVihv10vT8xMH7Z
	Q0xlbC1oapiU2k8UQqPzMr7JSK1gIsMxq
X-Google-Smtp-Source: AGHT+IHe7Kisg2praPSQBOkCJl+bv+Fx/s+RyYm8WqvftkcBFip3pjX8j+chvpOJkHEcQiP+1AMqhQ==
X-Received: by 2002:a05:600c:1c8d:b0:43b:c0fa:f9c4 with SMTP id 5b1f17b1804b1-450d7bae255mr27584565e9.4.1748798513065;
        Sun, 01 Jun 2025 10:21:53 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f009f9d6sm11890444f8f.84.2025.06.01.10.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jun 2025 10:21:52 -0700 (PDT)
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
Subject: [PATCH v4 03/11] iio: accel: adxl313: make use of regmap cache
Date: Sun,  1 Jun 2025 17:21:31 +0000
Message-Id: <20250601172139.59156-4-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250601172139.59156-1-l.rubusch@gmail.com>
References: <20250601172139.59156-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Setup regmap cache to cache register configuration. This is a preparatory
step for follow up patches. Using cached settings will help at inerrupt
handling, to generate activity and inactivity events.

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


