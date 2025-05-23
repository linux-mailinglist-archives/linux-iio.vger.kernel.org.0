Return-Path: <linux-iio+bounces-19840-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42039AC2BCD
	for <lists+linux-iio@lfdr.de>; Sat, 24 May 2025 00:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E63CC4E5680
	for <lists+linux-iio@lfdr.de>; Fri, 23 May 2025 22:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C170821420B;
	Fri, 23 May 2025 22:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2GuAR7Y"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5DE219A76;
	Fri, 23 May 2025 22:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748039760; cv=none; b=WuYLD+eVGNNEAHGZI18gQlNm/Oe62S1FNswhrwzXd5Zic+mr/5Cb+aouu/LChJt9690E4Gd8ZzhqUnplsCGGm7IB4D8tzCpYlIRbHfbOe5qaG6LLShY7vrmf8/2FoJHuT+qWwSQD2hL2eTT3DcbRr0M+nmdC/8gnOK/5fioP5CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748039760; c=relaxed/simple;
	bh=TCQwLS0syikPNV8WT/BYxzCcTwgQbI6UeNAiGmncCIE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MCiSHgsAfj9IqzxLrItytzLR61j4tkrSgbwmAzMQuHHMZ/NhnOPzR0X7QC+DR/IyOtiBQlJ3NoZ+tWoz+mB3VDCGf3tWDkV8h0xytpw8T9JCcH2SpQu9YgupVv6qis3ys3JJopFwQz3/lyjnUqS2WTUOKWZiAiGz0Z9Prr1hmos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2GuAR7Y; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-44069f5f3aaso49055e9.2;
        Fri, 23 May 2025 15:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748039756; x=1748644556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=68q0Ncd5UfHcauV6RTmhDNGvafZvU2UqPZBnr2W5EoE=;
        b=c2GuAR7Y6QgjosC97dJbasSkYzbL8KVsQcKZcMcwYfYbj6entPL94j4Au5iWIJvxdv
         0L07S1SdyvMDpSui/EwsW76k5fQNaa0vJekF6kg6Q7fkRTdvcTaSfGq2KxYI3QhAAxnq
         57T2dzgRX2eXdXGQNIKwszRtspaTBvc3Ko9JSnC/76/dZp+NPlIU+x+No6z/u6/na9U4
         zTayUtT1Bsga8NHRpPoJ3XHSBtgnXpiDV72xAXKS/pPDZE5JeR/T4SYlznC3Ufaw3H+k
         M8Q44B+FkpqL1iGS9AwH8hRNSTwNbpGzJd/bUuOEdlJTGayWdhhyl8Xn0tmfmqpnOfLe
         bIWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748039756; x=1748644556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=68q0Ncd5UfHcauV6RTmhDNGvafZvU2UqPZBnr2W5EoE=;
        b=ie5o+m099EqfpHg9QdzINQ6sQWPKJxMMNXWyO6Qr0B9p/ocGIKpY9VXUjxqAdm2fhe
         MMD6SvlqLqOnbD7iM7B6Jm5+MFLOr1KJ2HuiW4WqiVXbPSlVx659fgfX/wV3kmw08uvm
         s8lb0cNjd/NGgpztp6FjhB3KZ1jL2mt6fkhk9421d8KiocJykAa/88R0owHrFZ6IzEDX
         Ieu4WszGXRH87eBKOa8X01O2mDNESEUZkv/ReZw2T8AgSiQSiaB/guUO/HJ9STGKkm4N
         QsxYx2twF/Pm8aVzFCoy9gYKLvnlMhNe0NL7hKndXKGuRsC2C68BpOC8GYnzRiE+d6aZ
         ul2w==
X-Forwarded-Encrypted: i=1; AJvYcCVZ8TvO/3iOh5ZNAT99Q0Cp+uKet4nxaENw48QZqxLmfaLPDsrYeA4BRC8onVtcriHPdLrqOgB+QSU=@vger.kernel.org, AJvYcCWfB2L/ZMSyrfl/YZTdIRd48U0ZqXReOTvmdD52xuoJqXuLMLcneCEmYPk3SbuUzsVTfOC7+6g8hHQC@vger.kernel.org, AJvYcCXSQUhl+MpSIUn6O97NmeMkVo4m82tLliI2f/I7GLDi8br3m+aoXcl4Y7QkbHvEmPjNIA9pFyVhP4oHSlKa@vger.kernel.org
X-Gm-Message-State: AOJu0YzvN3ohe4Ay/cMb3ej2TbmpRmReswQUdbFYNZkIzr+8FTDKQKlp
	VKQSRdLwymcV9diWwYR5bm10Emq5aI7tqAN/18d6r1/IoOzWCIaiK3+7
X-Gm-Gg: ASbGncs11eAjFPg2FAptc9ZeJfNQaBLBlmu3x2nGplBk7Q3a+6BwxAAR48ECkLxDvZ3
	Kyy2qb3P9BETlaBPPh+80GJbaiQTu0ucTZmmiJUDirx8Mht4UOJdCyI8oE2KfIuHtPapIxJxsX4
	BRG0V4dvbjwZtKosB+JEVDYFvVMfBiP7Eq3iaNKvs1LtlxmZGH6dutqw433lOF/HKpHq152solG
	UmjrXmyzgmI8+/XntXAICRHlDGl7izvjXN5wP78kslOlntqZ72UUpUqdGhc7p+JElHR6SKgw67z
	j/TSP80qpDL8JTiTW0CSMehTBRikdmR+J7TEocjlmA4fglASDK3ZIBYnHadiX0Uj7IUM+fkaUS2
	rgoH8Iz7HoNtwXA2LbS9T9A==
X-Google-Smtp-Source: AGHT+IEJn7EJ+akYqQJlJgcMn1qZz/LeYw81XZlGws78M/9Ggfg3Lq2mXMvJT3tRvZEO4nbg40IAyw==
X-Received: by 2002:a05:600c:154c:b0:442:f97a:fee7 with SMTP id 5b1f17b1804b1-44c94f18408mr1776755e9.6.1748039755907;
        Fri, 23 May 2025 15:35:55 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f6b29672sm165202375e9.3.2025.05.23.15.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 15:35:55 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com
Cc: l.rubusch@gmail.com,
	linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 04/12] iio: accel: adxl313: make use of regmap cache
Date: Fri, 23 May 2025 22:35:15 +0000
Message-Id: <20250523223523.35218-5-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250523223523.35218-1-l.rubusch@gmail.com>
References: <20250523223523.35218-1-l.rubusch@gmail.com>
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


