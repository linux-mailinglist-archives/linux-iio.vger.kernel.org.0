Return-Path: <linux-iio+bounces-20847-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FD6AE2FD3
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 14:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0127D16FEF2
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 12:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012B31E0DB0;
	Sun, 22 Jun 2025 12:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9y4N23+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6431DED6D;
	Sun, 22 Jun 2025 12:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750595385; cv=none; b=I6ISHuaHYy/QFulLTJCXlGuoEDl9kygP1kZ4beI63iEK1sSGGemRzicDGKBWd/oeh1bHcCPkZ+dOMQ3MEc/1w/Wx9BfM3YZUSvRl8gE8GTqq9qSpjearqJrnK1itDkiyYlRrD5cc0baxO/OMe9BKiExshiIZQya5TFdsjO10wYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750595385; c=relaxed/simple;
	bh=x3Tl8ENdDkTbFqKFT8QM98diGnmwQXw3ZGN9E02Igv4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XhoV4GH6dkvg4LUKiycsl90A5awB4KbNYT9RheQLg/+oz6FlcsZrikzTJ7/XWYrBo7r7dVOgL6nG9gI69JwHT+Im2S7j/iNb06OO0h7YRIC+u/l3ZoYdVrm9Qx+4yBcEvxiUOtVu1rVFh5aBV7ufIMG1CChaoMDV9ck26WtNlrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B9y4N23+; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ade6ef7e6b5so63320166b.3;
        Sun, 22 Jun 2025 05:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750595382; x=1751200182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vyMc7SlAsIwQqZXqc0Yozk4T29hi06CER9FeMOKcH+0=;
        b=B9y4N23+1TxUVc41DWkh+gNI+lt1iyWztb9vz40cxWhFN2aVXMiNgHh/jYOaYZ4rbl
         CBZqHxs9E8u88lpxPZN0mWRlLa9S/N4H3EE45FsINh9D1OJicMco+OucG2hxT+g8XocM
         vPvkNJb+Yp4obC+9d9+7gIM0x0sb9oQ8UQF2yF0MYjzqcc4b0RIuz2mOm1V5Ffk1VmSE
         FpysV1f5m94EWz7fkvRW+z8X2IUMouz9I9tefSzLW1oE/DgOuwFvZFj4yKFS5ICG2IUt
         c2wwZY1A3scDeITBh8GPq4pYPA38SThH9QQ+vKy+Z/zZVAtHQB5m/WBwr5rJefa2hAu+
         pS7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750595382; x=1751200182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vyMc7SlAsIwQqZXqc0Yozk4T29hi06CER9FeMOKcH+0=;
        b=dtnOJLoRVV+mstzhHs49zxWntZvBcV+I6IKkv04Vzb1GOWny2atGKkd341lLxyglN9
         SztQ9i6g1lACpuiFxKQWGHa/WLf7VoRGmPGVML7zzTi7oiAnK2fzq3BnVZaLPh1K5HIO
         AfVNdAqNQEiJULFKZSflKwtF7gQ73GgyMqMO74l2h5AC0qLThi23X9XCimA51036rL9M
         ea/NrPr8ZIzwC+tlZbNM8BBdA6okqPDa1VH6HrPX4FFFRdo3XXRi0d1bMes7ZVyziCJS
         xD078kXXaoC38aJS1N6AfPJ8OXxmWHvscEMkqK8gsOmOh0G+91tRWwIPK+1kUHxILmLb
         SOyg==
X-Forwarded-Encrypted: i=1; AJvYcCV0Hjojtp37KFfXaJuSbHHVEQ/Mqmy/BuAsLETYsbuzgxXFPtxSfY5Sqto/tXNjKJ60QvLvUvfYdXBC@vger.kernel.org, AJvYcCV9xLNQqYF/ha3KHxtx/BDSoDLIJUh7bvqLNPEJ9K2V3swiD1j8bQm6CEKFuI7vO4DgyIGNBD2PiJI=@vger.kernel.org, AJvYcCVoWJ4cL7R3NoO7zAL7buCuSqTDa3tTWJiqcTJrG4Tu8uulGEwj5UxpEjPAlzSvtGH+Imb6+RBKlhUKQhQ2@vger.kernel.org
X-Gm-Message-State: AOJu0YzxhAyMe9AwACSrcJvwC4qYZZzqxqMPBkQin1YblfYLS665sQ4t
	FLtKd/mHhVXQZKHH3zIdJCWoCA/bsqALz/GSidvP0YyAoIu8G1X2BVEN
X-Gm-Gg: ASbGncvuoXT5uv2ePgAJ5VZ8PW1hUz5vGT+MCn9SxsJRoOtFzVjYvuMJqmLqHQhIT8Z
	/lacldqSF0VI7iTE6jdlhtDuy9e6gSU4gfV7bhQ0AOGsCYj4riRnp2hOdRuFJClnerzq2OUgSyq
	J7RR+6i15Jlw9P2QuQqQbI08AvuvPA9Wr4ZNyYKE84dZKgDK8/p8QYoKom1oFR8IHG1fEz9rBNZ
	GnLUSwXRwBWJ0DsGgJPhpx0P+z1q5cG+6EIC84C7lZxSCrav6/9SIXa6kHm8MOLLSdrvhrNnn6D
	ETJi7E6oIUgp03d2kBbrpdmsFr03msWGK9fM8yA55F7UDzzggOPSS7DIPsgeqBiDOESYrbDapbR
	0GrHi7GWbzTORcuszvkWu8A9b4iNa4JCcWNnoxBKDrgo=
X-Google-Smtp-Source: AGHT+IHb13r//By+XO2L1rvSx2zzW4cP/nSWQ2gVEIkMDTpE+0nYpLfCa4LDBZN+WkOVzGXMfHJ72g==
X-Received: by 2002:a17:907:c24:b0:adb:1331:a508 with SMTP id a640c23a62f3a-ae0578fbb18mr300664066b.5.1750595381962;
        Sun, 22 Jun 2025 05:29:41 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae053edc0e9sm533917566b.54.2025.06.22.05.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 05:29:41 -0700 (PDT)
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
Subject: [PATCH v6 1/8] iio: accel: adxl313: make use of regmap cache
Date: Sun, 22 Jun 2025 12:29:30 +0000
Message-Id: <20250622122937.156930-2-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250622122937.156930-1-l.rubusch@gmail.com>
References: <20250622122937.156930-1-l.rubusch@gmail.com>
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


