Return-Path: <linux-iio+bounces-24671-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5AFBB4E94
	for <lists+linux-iio@lfdr.de>; Thu, 02 Oct 2025 20:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E639819C7074
	for <lists+linux-iio@lfdr.de>; Thu,  2 Oct 2025 18:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2293F27B4E5;
	Thu,  2 Oct 2025 18:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abo1N0yi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A012797AF
	for <linux-iio@vger.kernel.org>; Thu,  2 Oct 2025 18:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759430531; cv=none; b=V+Ujtk74KZxdehOFX5bebUYSUM3EP6kg0xzVIXLDC9j1zSbGiYcXnlqcjjisJzqjf9Hjc6VqzdqIU4gxGEbPskOeNi3JBV/FmGR/vOXyStVcgZzlsFRr5XcrDVKVQpUvlUYmzJQEXVr+j00le9wneoGwlTmUxD6IG7A56Giw0oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759430531; c=relaxed/simple;
	bh=CgdLoSRqcqubsg0rI377cLUrOqK7eOYKEPqDrL7PqVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X5kKqAnZw/gzmrANcU+eTD0VOe8As0ZArjEbk1lYDzuJIOPkeEui7dFdT9t1TU64qz3dLCa1LyA0BVW9nuWVptNtIEaageC7x0/LZ1z8a2jNeTKXaFsqR28hcy02JWcg0Cql41s3Aiy/KVGFPGnurYOrLvm4wjblyCPlQixR/kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=abo1N0yi; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-77f5d497692so2004828b3a.1
        for <linux-iio@vger.kernel.org>; Thu, 02 Oct 2025 11:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759430529; x=1760035329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XDyDktYkrwmeCiCnLdbEvncGAxhs/BH7a/A0BkO50cg=;
        b=abo1N0yiwGc9rCzEndi3uUgf+ADodkbL9AVrYl/qUe3NYohiCKApw6m+XI4TqsLBj8
         BZrfStpLvUX9sbxMQcqnoAFlDzuF7q9KWqy1bcoOHcMMIMO9PRNhm46MJuvV/rwUvuum
         Z7GPh+lTKcqhlx6zmylIBnf1Q6TsNNUjEpPnOpzDHhDlsmX1GByXEx6GWSOjm4/kAu6i
         c3Q1jYCwyyjEmR8J1NiutAk7LCeXDRsOfvQBRSmnsanuyKgz5dyd9RO0oyxoZcc0Hy5W
         L86Uq2qMpM8GtKiGcZ4tyj7b2854ZwNxY8bYmtpCzu+jn9MCk/6cZdoYmRD+xSa1AKLv
         cNgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759430529; x=1760035329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XDyDktYkrwmeCiCnLdbEvncGAxhs/BH7a/A0BkO50cg=;
        b=noHCfQq1EZk8i9NB9d8XWQbLVn3djSI7eO22hxE9DR6w6MD0KwTSHFELo0rcQDmGgy
         xyF6Ld3UW1eiUDhU7YuszIpsyRD5oe8mgpz0B6v1z4qnnS/PepGSEesIvfRm6tALMrgl
         Jd5QqiwM2x9vmk17cYe1bVWBGIxncaL5vzSri83JusT0Cn4j2+b5PAhvmH2UXnllAmu3
         XSxflA8eQ4b1Bh53y4MOXpyRfcbM0HgiZCStD06Ot2rmMnVyzq4qlXc9XtKKXBNF1HAM
         EdcJGlCaiCxpnJt45dM+UPbjowBap1NYIt37TyJU5rUI91ehtbMh7VYKx/j9wPmIfJX8
         WgCA==
X-Forwarded-Encrypted: i=1; AJvYcCUCaNO3poKb27viswOTWbrfmom8hZ+lu2NoP2mn2i2V/RFH7/gjO0VkXDdanywYYZLVhe05A3KmZqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlxkE2mxzTLi0lDRjdb/U22t2QLSwNPY2vnyDE0M62RH+gEslt
	ZM0wuRnHZ54WAKINxfmIYYHds5hoZxfDfuFyLjqGDXKHR3kYNLvIQrMc
X-Gm-Gg: ASbGncuahZnrq8aMNu48mi9eL6HcvDrz04QXRVTcE5Zbxha4DQGgGO5bruD2QepyK+g
	D5bw1oQWAtxi08+uKU4qN+9AHXNkDRd0B6rln8DMDu+OMZkj39b1p3O3yo+YtZi92+lNmmm3b8J
	uKxsCbAD/w5BsX5DROXHaM07vQoDnkoc34th+Bj46PRDSuocmBl/gi4uS4iCXC0bkSh5uEL5pQ6
	lpsGdEQ1MGGbs112qL616PJbubj4S9mZkcdpMENOlHQUKtC036/OLAylEq8aqkxI7Pbcgy7mImV
	O/+pRPmc4ae0RplW8vW2xq9ypLA+wvbIkgRxHMdpuodwhop+nDzyHbPJ+M0/q0Is3cclxbhh0hm
	uwwcQN4sJ22ooaaGtRh70Emz2qTZduPhonAzcWUvJz/OcHzcrkWApnzsfzMsU6sm+Jws=
X-Google-Smtp-Source: AGHT+IGP8WFUpp6D5O3V3PcWBOeK8FWgcAKMa1vb9ii5DoVIizWgPxfaNyi7VlxqzxFNS83t349/jA==
X-Received: by 2002:a05:6a21:998e:b0:302:9f3b:3e5c with SMTP id adf61e73a8af0-32b620a8d65mr538970637.39.1759430529439;
        Thu, 02 Oct 2025 11:42:09 -0700 (PDT)
Received: from akshayaj-lenovo.. ([223.233.78.22])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b62ce55205csm162917a12.18.2025.10.02.11.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 11:42:08 -0700 (PDT)
From: Akshay Jindal <akshayaj.lkd@gmail.com>
To: dan@dlrobertson.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: Akshay Jindal <akshayaj.lkd@gmail.com>,
	shuah@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/5] iio: accel: bma400: Use index-based register addressing and lookup
Date: Fri,  3 Oct 2025 00:11:04 +0530
Message-ID: <20251002184120.495193-4-akshayaj.lkd@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251002184120.495193-1-akshayaj.lkd@gmail.com>
References: <20251002184120.495193-1-akshayaj.lkd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce formula-based macros to compute GEN INTR configuration register
addresses from the interrupt number and register index. This reduces the
need for 22 explicit register macros to three base definitions.

Add a centralized lookup table keyed by IIO event direction and replace
get_gen_config_reg() with a helper integrated with this table.

Apply these changes across the affected callbacks to ensure consistent
access to generic interrupt registers.

No functional changes are intended.

Signed-off-by: Akshay Jindal <akshayaj.lkd@gmail.com>
---
 drivers/iio/accel/bma400.h      |  17 +++--
 drivers/iio/accel/bma400_core.c | 131 +++++++++++++++++++-------------
 2 files changed, 88 insertions(+), 60 deletions(-)

diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
index 13fe2e5a3175..48fcaeeb553d 100644
--- a/drivers/iio/accel/bma400.h
+++ b/drivers/iio/accel/bma400.h
@@ -91,6 +91,11 @@
 #define BMA400_INT_CONFIG0_GEN2_MASK		BIT(3)
 #define BMA400_INT_CONFIG0_DRDY_MASK		BIT(7)
 
+enum bma400_generic_intr {
+	BMA400_GEN1_INTR = 1,
+	BMA400_GEN2_INTR,
+};
+
 #define BMA400_INT_CONFIG1_REG	    0x20
 #define BMA400_INT_CONFIG1_STEP_INT_MASK	BIT(0)
 #define BMA400_INT_CONFIG1_S_TAP_MASK		BIT(2)
@@ -103,8 +108,12 @@
 #define BMA400_TWO_BITS_MASK        GENMASK(1, 0)
 
 /* Generic interrupts register */
-#define BMA400_GEN1INT_CONFIG0_REG      0x3f
-#define BMA400_GEN2INT_CONFIG0_REG      0x4A
+#define BMA400_GENINT_CONFIG_REG_BASE		0x3f
+#define BMA400_NUM_GENINT_CONFIG_REGS		11
+#define BMA400_GENINT_CONFIG_REG(gen_intr, config_idx)		\
+	(BMA400_GENINT_CONFIG_REG_BASE +			\
+	(gen_intr - 1) * BMA400_NUM_GENINT_CONFIG_REGS +	\
+	(config_idx))
 #define BMA400_GENINT_CONFIG0_HYST_MASK		GENMASK(1, 0)
 #define BMA400_GENINT_CONFIG0_REF_UPD_MODE_MASK	GENMASK(3, 2)
 #define BMA400_GENINT_CONFIG0_DATA_SRC_MASK	BIT(4)
@@ -138,10 +147,6 @@ enum bma400_detect_criterion {
 	BMA400_DETECT_ACTIVITY,
 };
 
-#define BMA400_GEN_CONFIG2_OFF      0x02
-#define BMA400_GEN_CONFIG3_OFF      0x03
-#define BMA400_GEN_CONFIG31_OFF     0x04
-
 /* TAP config registers */
 #define BMA400_TAP_CONFIG_REG		0x57
 #define BMA400_TAP_CONFIG_SEN_MASK	GENMASK(2, 0)
diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
index 58c378ba9931..a0e994f9882b 100644
--- a/drivers/iio/accel/bma400_core.c
+++ b/drivers/iio/accel/bma400_core.c
@@ -121,6 +121,41 @@ struct bma400_data {
 	__be16 duration;
 };
 
+struct bma400_genintr_info {
+	enum bma400_generic_intr genintr;
+	unsigned int intrmask;
+	enum iio_event_direction dir;
+	enum bma400_detect_criterion detect_mode;
+};
+
+/* Lookup struct for determining GEN1/GEN2 based on dir */
+static const struct bma400_genintr_info bma400_genintrs[] = {
+	[IIO_EV_DIR_RISING] = {
+		.genintr = BMA400_GEN1_INTR,
+		.intrmask = BMA400_INT_CONFIG0_GEN1_MASK,
+		.dir = IIO_EV_DIR_RISING,
+		.detect_mode = BMA400_DETECT_ACTIVITY,
+	},
+	[IIO_EV_DIR_FALLING] = {
+		.genintr = BMA400_GEN2_INTR,
+		.intrmask = BMA400_INT_CONFIG0_GEN2_MASK,
+		.dir = IIO_EV_DIR_FALLING,
+		.detect_mode = BMA400_DETECT_INACTIVITY,
+	}
+};
+
+static inline const struct bma400_genintr_info *
+get_bma400_genintr_info(enum iio_event_direction dir)
+{
+	switch (dir) {
+	case IIO_EV_DIR_RISING:
+	case IIO_EV_DIR_FALLING:
+		return &bma400_genintrs[dir];
+	default:
+		return NULL;
+	};
+}
+
 static bool bma400_is_writable_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
@@ -1159,32 +1194,22 @@ static int bma400_activity_event_en(struct bma400_data *data,
 				    enum iio_event_direction dir,
 				    int state)
 {
-	int ret, reg, msk, value;
-	int field_value = 0;
+	int ret;
+	unsigned int intrmask, regval;
+	enum bma400_generic_intr genintr;
+	enum bma400_detect_criterion detect_criterion;
+	const struct bma400_genintr_info *bma400_genintr;
 
-	switch (dir) {
-	case IIO_EV_DIR_RISING:
-		reg = BMA400_GEN1INT_CONFIG0_REG;
-		msk = BMA400_INT_CONFIG0_GEN1_MASK;
-		value = FIELD_PREP(BMA400_GENINT_CONFIG1_AXES_COMB_MASK, BMA400_EVAL_X_OR_Y_OR_Z) |
-			FIELD_PREP(BMA400_GENINT_CONFIG1_DETCT_CRIT_MASK, BMA400_DETECT_ACTIVITY);
-		set_mask_bits(&field_value, BMA400_INT_CONFIG0_GEN1_MASK,
-			      FIELD_PREP(BMA400_INT_CONFIG0_GEN1_MASK, state));
-		break;
-	case IIO_EV_DIR_FALLING:
-		reg = BMA400_GEN2INT_CONFIG0_REG;
-		msk = BMA400_INT_CONFIG0_GEN2_MASK;
-		value = FIELD_PREP(BMA400_GENINT_CONFIG1_AXES_COMB_MASK, BMA400_EVAL_X_OR_Y_OR_Z) |
-			FIELD_PREP(BMA400_GENINT_CONFIG1_DETCT_CRIT_MASK, BMA400_DETECT_INACTIVITY);
-		set_mask_bits(&field_value, BMA400_INT_CONFIG0_GEN2_MASK,
-			      FIELD_PREP(BMA400_INT_CONFIG0_GEN2_MASK, state));
-		break;
-	default:
+	bma400_genintr = get_bma400_genintr_info(dir);
+	if (!bma400_genintr)
 		return -EINVAL;
-	}
+
+	genintr = bma400_genintr->genintr;
+	detect_criterion = bma400_genintr->detect_mode;
+	intrmask = bma400_genintr->intrmask;
 
 	/* Enabling all axis for interrupt evaluation */
-	ret = regmap_write(data->regmap, reg,
+	ret = regmap_write(data->regmap, BMA400_GENINT_CONFIG_REG(genintr, 0),
 			   BMA400_GENINT_CONFIG0_X_EN_MASK |
 			   BMA400_GENINT_CONFIG0_Y_EN_MASK |
 			   BMA400_GENINT_CONFIG0_Z_EN_MASK|
@@ -1195,31 +1220,32 @@ static int bma400_activity_event_en(struct bma400_data *data,
 		return ret;
 
 	/* OR combination of all axis for interrupt evaluation */
-	ret = regmap_write(data->regmap, reg + BMA400_GEN_CONFIG1_OFF, value);
+	regval = FIELD_PREP(BMA400_GENINT_CONFIG1_AXES_COMB_MASK, BMA400_EVAL_X_OR_Y_OR_Z) |
+		 FIELD_PREP(BMA400_GENINT_CONFIG1_DETCT_CRIT_MASK, detect_criterion);
+	ret = regmap_write(data->regmap, BMA400_GENINT_CONFIG_REG(genintr, 1), regval);
 	if (ret)
 		return ret;
 
 	/* Initial value to avoid interrupts while enabling*/
-	ret = regmap_write(data->regmap, reg + BMA400_GEN_CONFIG2_OFF, 0x0A);
+	ret = regmap_write(data->regmap, BMA400_GENINT_CONFIG_REG(genintr, 2), 0x0A);
 	if (ret)
 		return ret;
 
 	/* Initial duration value to avoid interrupts while enabling*/
-	ret = regmap_write(data->regmap, reg + BMA400_GEN_CONFIG31_OFF, 0x0F);
+	ret = regmap_write(data->regmap, BMA400_GENINT_CONFIG_REG(genintr, 4), 0x0F);
 	if (ret)
 		return ret;
 
-	ret = regmap_update_bits(data->regmap, BMA400_INT1_MAP_REG, msk,
-				 field_value);
+	regval = state ? intrmask : 0;
+	ret = regmap_update_bits(data->regmap, BMA400_INT1_MAP_REG, intrmask, regval);
 	if (ret)
 		return ret;
 
-	ret = regmap_update_bits(data->regmap, BMA400_INT_CONFIG0_REG, msk,
-				 field_value);
+	ret = regmap_update_bits(data->regmap, BMA400_INT_CONFIG0_REG, intrmask, regval);
 	if (ret)
 		return ret;
 
-	set_mask_bits(&data->generic_event_en, msk, field_value);
+	set_mask_bits(&data->generic_event_en, intrmask, regval);
 	return 0;
 }
 
@@ -1344,18 +1370,6 @@ static int bma400_write_event_config(struct iio_dev *indio_dev,
 	}
 }
 
-static int get_gen_config_reg(enum iio_event_direction dir)
-{
-	switch (dir) {
-	case IIO_EV_DIR_FALLING:
-		return BMA400_GEN2INT_CONFIG0_REG;
-	case IIO_EV_DIR_RISING:
-		return BMA400_GEN1INT_CONFIG0_REG;
-	default:
-		return -EINVAL;
-	}
-}
-
 static int bma400_read_event_value(struct iio_dev *indio_dev,
 				   const struct iio_chan_spec *chan,
 				   enum iio_event_type type,
@@ -1364,22 +1378,25 @@ static int bma400_read_event_value(struct iio_dev *indio_dev,
 				   int *val, int *val2)
 {
 	struct bma400_data *data = iio_priv(indio_dev);
-	int ret, reg, reg_val, raw;
+	int ret, reg_val, raw;
+	enum bma400_generic_intr genintr;
+	const struct bma400_genintr_info *bma400_genintr;
 
 	if (chan->type != IIO_ACCEL)
 		return -EINVAL;
 
 	switch (type) {
 	case IIO_EV_TYPE_MAG:
-		reg = get_gen_config_reg(dir);
-		if (reg < 0)
+		bma400_genintr = get_bma400_genintr_info(dir);
+		if (!bma400_genintr)
 			return -EINVAL;
+		genintr = bma400_genintr->genintr;
 
 		*val2 = 0;
 		switch (info) {
 		case IIO_EV_INFO_VALUE:
 			ret = regmap_read(data->regmap,
-					  reg + BMA400_GEN_CONFIG2_OFF,
+					  BMA400_GENINT_CONFIG_REG(genintr, 2),
 					  val);
 			if (ret)
 				return ret;
@@ -1387,7 +1404,7 @@ static int bma400_read_event_value(struct iio_dev *indio_dev,
 		case IIO_EV_INFO_PERIOD:
 			mutex_lock(&data->mutex);
 			ret = regmap_bulk_read(data->regmap,
-					       reg + BMA400_GEN_CONFIG3_OFF,
+					       BMA400_GENINT_CONFIG_REG(genintr, 3),
 					       &data->duration,
 					       sizeof(data->duration));
 			if (ret) {
@@ -1398,7 +1415,9 @@ static int bma400_read_event_value(struct iio_dev *indio_dev,
 			mutex_unlock(&data->mutex);
 			return IIO_VAL_INT;
 		case IIO_EV_INFO_HYSTERESIS:
-			ret = regmap_read(data->regmap, reg, val);
+			ret = regmap_read(data->regmap,
+					  BMA400_GENINT_CONFIG_REG(genintr, 0),
+					  val);
 			if (ret)
 				return ret;
 			*val = FIELD_GET(BMA400_GENINT_CONFIG0_HYST_MASK, *val);
@@ -1452,16 +1471,19 @@ static int bma400_write_event_value(struct iio_dev *indio_dev,
 				    int val, int val2)
 {
 	struct bma400_data *data = iio_priv(indio_dev);
-	int reg, ret, raw;
+	int ret, raw;
+	enum bma400_generic_intr genintr;
+	const struct bma400_genintr_info *bma400_genintr;
 
 	if (chan->type != IIO_ACCEL)
 		return -EINVAL;
 
 	switch (type) {
 	case IIO_EV_TYPE_MAG:
-		reg = get_gen_config_reg(dir);
-		if (reg < 0)
+		bma400_genintr = get_bma400_genintr_info(dir);
+		if (!bma400_genintr)
 			return -EINVAL;
+		genintr = bma400_genintr->genintr;
 
 		switch (info) {
 		case IIO_EV_INFO_VALUE:
@@ -1469,7 +1491,7 @@ static int bma400_write_event_value(struct iio_dev *indio_dev,
 				return -EINVAL;
 
 			return regmap_write(data->regmap,
-					    reg + BMA400_GEN_CONFIG2_OFF,
+					    BMA400_GENINT_CONFIG_REG(genintr, 2),
 					    val);
 		case IIO_EV_INFO_PERIOD:
 			if (val < 1 || val > 65535)
@@ -1478,7 +1500,7 @@ static int bma400_write_event_value(struct iio_dev *indio_dev,
 			mutex_lock(&data->mutex);
 			put_unaligned_be16(val, &data->duration);
 			ret = regmap_bulk_write(data->regmap,
-						reg + BMA400_GEN_CONFIG3_OFF,
+						BMA400_GENINT_CONFIG_REG(genintr, 3),
 						&data->duration,
 						sizeof(data->duration));
 			mutex_unlock(&data->mutex);
@@ -1487,7 +1509,8 @@ static int bma400_write_event_value(struct iio_dev *indio_dev,
 			if (val < 0 || val > 3)
 				return -EINVAL;
 
-			return regmap_update_bits(data->regmap, reg,
+			return regmap_update_bits(data->regmap,
+						  BMA400_GENINT_CONFIG_REG(genintr, 0),
 						  BMA400_GENINT_CONFIG0_HYST_MASK,
 						  FIELD_PREP(BMA400_GENINT_CONFIG0_HYST_MASK,
 							     val));
-- 
2.43.0


