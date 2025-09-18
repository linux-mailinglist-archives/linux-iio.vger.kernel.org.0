Return-Path: <linux-iio+bounces-24270-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF85EB869EA
	for <lists+linux-iio@lfdr.de>; Thu, 18 Sep 2025 21:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 647321B2619D
	for <lists+linux-iio@lfdr.de>; Thu, 18 Sep 2025 19:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8A72D3737;
	Thu, 18 Sep 2025 19:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLyH5h/M"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6279827F4D5
	for <linux-iio@vger.kernel.org>; Thu, 18 Sep 2025 19:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758222472; cv=none; b=lUt7WjrlLst5wH7s9mV+107i0uiPtR8OiDbhsdIgEHPPQGs8WdVl8vVqEWzvU93rkjbYTHj/rMIm3aJAcvViVzJjTKfup+s2Ccc+3UmiXRhep94wtRwAXid3xljb/forxdAOVlzVftqVMg9cYLlc5nA0dyMXEsana0zscfb6hho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758222472; c=relaxed/simple;
	bh=jrIvI+w6CK9otr03Fn28JkgZC0RCwPVB7AkcnRP1j40=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A1Hqkh1CxlvPbpr1xWpnkQYM6YQzHRzIqCIChmiCMUmaH9vHdme2Tw1bR0PWZVhAcpJf0lHbbWcB5mGd7OHpeRs5ThPc32Q//Y9KFLsgFCww5R+SVd+5tHbtJcp8+oU4mvmYjoZmrJSRNcFq9k/MS+gQ8vjhuiQLG09vixezgfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DLyH5h/M; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-26799bf6a2eso13559335ad.3
        for <linux-iio@vger.kernel.org>; Thu, 18 Sep 2025 12:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758222469; x=1758827269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MB2jfHSKSzLMOVGGO7AnFq090fGDv2evBNxwEJ6iueg=;
        b=DLyH5h/Mi/B1i63bJJKvk5L2MfmMlq/e+x5JAkJgZpgc0hsCohFEGMBS+j1/x2H/Fd
         2Wyk2vcScV9vBzfP8MrIc4OclwJoL96lCOgbJ9nRKmC+oyNzV76oYl8KyOa+9psPtRAI
         gKxQEEgU47+ZR4DKoUY6DkT51+RVqKE0O3apCAn07PA5F8OPE1FtzOLZm6w9ce9Z21ra
         A6uJ7bgjyWyIU4m6+RK7AC/ECdDFfSME4izQW2b/zj3IljisY0pS678aKcc1T/Ls1md8
         BiDRcGKL6j4/IkaTYgQaDXltRFLsWYEgFZiswAwFVWP5HQYqjKgdSqYn0l800BLNG9V9
         vuFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758222469; x=1758827269;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MB2jfHSKSzLMOVGGO7AnFq090fGDv2evBNxwEJ6iueg=;
        b=UlvC+k+OXVp4qJDiqmfePkNVeSamMUNP/R9xlqHqdkNg+0beKKpR1qBgXALLkcuUk0
         fkmOAjWm9Cfpu3SX3ugEJvjGrzMVOqztH/qzvvU/lTz7ILI9uoD+Bw8fHOe6FfuwLPG/
         wrRyChkZVg8CsYpBAyKLGMoNujhwLgpBXLtK6RjpYZ7pEshh4G9t2VYfbaTY4JF09pew
         WbxMIdWNqzuhUL0W38ZOZHgReAM3Tuo2Mc2Jx31PVXNrGA2lxP8UqT7nPmj2cD1PqPZr
         l/DcaEWUtgMCxf516qSgbE45Exy99rX4cfUhl5ML++lpE/wD9CQ1te1uv5dhtWrDR6g8
         qbHw==
X-Forwarded-Encrypted: i=1; AJvYcCWGLTu25X6XstfNOmJ0UP/JlPzv/MnCn3Ow2/+IaZ5diYRs9muaXDIQCTWX30PyWC2SaEH1cxQBk50=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ7+DxEIw7DjhDjPyHSh54vOaMBZcgwexZSJTCr7pb9MI/U1dN
	f9Eh+OxCfarVvjaxvlP+cI5e9ZGoa2HVf+jw/ESKTE7vdt+afEhtLkmIdQVbNQ==
X-Gm-Gg: ASbGncvdNlrZaCAmXw9KgtonToOoWBE8W402uSMVA92uFyWp7fS590qFGjzAZ0hmEws
	ue3LuTVCn5uF5vTGTDsvfHutmnOXMPmpasx9/EH/EzjDknseF+KcLQ8egH6bliP/2CNjcpVREtK
	zami8pe6EhEpW6/An3P1siAjoSSiyTA/R8JkY0kxwUv0NRspWg4doWmTJTqPIgQEd+4QPwk5Yj1
	lYCqtEs4l9tKybJaroTWZXAscXKkvBc9ZANRppH0G/ap5OsdXgdrqkIl+g1PwMhxVKrbvjL2Htu
	ercDiDokwt/A20ID5sO+lhdkQpmfzH0WChCbvIDJm9KdDmaEeVaHovQxOtSOV3QxInevgChcI1X
	k+KowE8YeOJHwHUj1bpV0YjsHJywZ0vt8ooY+FjWrjvpj0Ad59tE=
X-Google-Smtp-Source: AGHT+IEtuI2s8Fy98EzG7d6EdEZGY4CPQNtcHrHxMNfvblBRQK9roCHaxPBCYJ3HUAC/EffzpLZtPQ==
X-Received: by 2002:a17:903:380d:b0:246:de71:1839 with SMTP id d9443c01a7336-269ba5512ddmr8012325ad.50.1758222469506;
        Thu, 18 Sep 2025 12:07:49 -0700 (PDT)
Received: from akshayaj-lenovo.. ([223.233.78.39])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802de635sm32989235ad.82.2025.09.18.12.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 12:07:48 -0700 (PDT)
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
Subject: [PATCH] iio: accel: bma400: Refactor generic interrupt configuration
Date: Fri, 19 Sep 2025 00:37:21 +0530
Message-ID: <20250918190729.387117-1-akshayaj.lkd@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor the generic interrupt configuration logic to improve readability
and reduce repetitive code. Replace hard-coded register values with macros
and enums, making it clearer what configuration is written to hardware.

Introduce a const struct to map event direction to the corresponding
generic interrupt. This removes the need for switch statements in multiple
callbacks, including activity event setup, read_event_value, and
write_event_value, while still performing the selection at runtime.

This change has no functional impact but simplifies the code and makes it
easier to maintain and extend in future updates.

Signed-off-by: Akshay Jindal <akshayaj.lkd@gmail.com>
---
 drivers/iio/accel/bma400.h      |  71 +++++++++++++++---
 drivers/iio/accel/bma400_core.c | 128 ++++++++++++++++----------------
 2 files changed, 125 insertions(+), 74 deletions(-)

diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
index 932358b45f17..ab7d1d139b66 100644
--- a/drivers/iio/accel/bma400.h
+++ b/drivers/iio/accel/bma400.h
@@ -68,7 +68,19 @@
 #define BMA400_CMD_REG              0x7e
 
 /* Interrupt registers */
-#define BMA400_INT_CONFIG0_REG	    0x1f
+#define BMA400_INT_CONFIG0_REG			0x1f
+#define BMA400_INT_CONFIG0_ORTN_CHG_MASK	BIT(1)
+#define BMA400_INT_CONFIG0_GEN1_MASK		BIT(2)
+#define BMA400_INT_CONFIG0_GEN2_MASK		BIT(3)
+#define BMA400_INT_CONFIG0_FIFO_FULL_MASK	BIT(5)
+#define BMA400_INT_CONFIG0_FIFO_WTRMRK_MASK	BIT(6)
+#define BMA400_INT_CONFIG0_DRDY_MASK		BIT(7)
+
+enum generic_intr {
+	GEN1_INTR,
+	GEN2_INTR
+};
+
 #define BMA400_INT_CONFIG1_REG	    0x20
 #define BMA400_INT1_MAP_REG	    0x21
 #define BMA400_INT_IO_CTRL_REG	    0x24
@@ -96,15 +108,53 @@
 #define BMA400_ACC_ODR_MIN_HZ       12
 
 /* Generic interrupts register */
-#define BMA400_GEN1INT_CONFIG0      0x3f
-#define BMA400_GEN2INT_CONFIG0      0x4A
-#define BMA400_GEN_CONFIG1_OFF      0x01
-#define BMA400_GEN_CONFIG2_OFF      0x02
-#define BMA400_GEN_CONFIG3_OFF      0x03
-#define BMA400_GEN_CONFIG31_OFF     0x04
-#define BMA400_INT_GEN1_MSK         BIT(2)
-#define BMA400_INT_GEN2_MSK         BIT(3)
-#define BMA400_GEN_HYST_MSK         GENMASK(1, 0)
+#define BMA400_GENINT_CONFIG_REG_BASE	0x3f
+#define BMA400_NUM_GENINT_CONFIG_REGS	11
+#define BMA400_GENINT_CONFIG_REG(gen_intr, config_idx)	\
+	(BMA400_GENINT_CONFIG_REG_BASE +		\
+	(gen_intr) * BMA400_NUM_GENINT_CONFIG_REGS +	\
+	(config_idx))
+
+/* Generic Interrupt Config0 register */
+#define BMA400_GENINT_CONFIG0_HYST_MASK			GENMASK(1, 0)
+#define BMA400_GENINT_CONFIG0_REF_UPD_MODE_MASK		GENMASK(3, 2)
+#define BMA400_GENINT_CONFIG0_DATA_SRC_MASK		BIT(4)
+#define BMA400_GENINT_CONFIG0_X_EN_MASK			BIT(5)
+#define BMA400_GENINT_CONFIG0_Y_EN_MASK			BIT(6)
+#define BMA400_GENINT_CONFIG0_Z_EN_MASK			BIT(7)
+
+enum bma400_hysteresis_config {
+	NO_HYSTERESIS,
+	HYSTERESIS_24MG,
+	HYSTERESIS_48MG,
+	HYSTERESIS_96MG
+};
+
+enum bma400_accel_data_src {
+	ACCEL_FILT1,
+	ACCEL_FILT2
+};
+
+enum bma400_ref_updt_mode {
+	BMA400_REF_MANUAL_UPDT_MODE,
+	BMA400_REF_ONETIME_UPDT_MODE,
+	BMA400_REF_EVERYTIME_UPDT_MODE,
+	BMA400_REF_EVERYTIME_LP_UPDT_MODE
+};
+
+/* Generic Interrupt Config1 register */
+#define BMA400_GENINT_CONFIG1_AXES_COMB_MASK		BIT(0)
+#define BMA400_GENINT_CONFIG1_DETCT_CRIT_MASK		BIT(1)
+
+enum bma400_genintr_acceleval_axescomb {
+	BMA400_EVAL_X_OR_Y_OR_Z,
+	BMA400_EVAL_X_AND_Y_AND_Z,
+};
+
+enum bma400_detect_criterion {
+	BMA400_DETECT_INACTIVITY,
+	BMA400_DETECT_ACTIVITY,
+};
 
 /* TAP config registers */
 #define BMA400_TAP_CONFIG           0x57
@@ -119,6 +169,7 @@
 #define BMA400_TAP_QUIETDT_MSK      GENMASK(5, 4)
 #define BMA400_TAP_TIM_LIST_LEN     4
 
+
 /*
  * BMA400_SCALE_MIN macro value represents m/s^2 for 1 LSB before
  * converting to micro values for +-2g range.
diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
index 85e23badf733..d59c26b8a57f 100644
--- a/drivers/iio/accel/bma400_core.c
+++ b/drivers/iio/accel/bma400_core.c
@@ -121,6 +121,29 @@ struct bma400_data {
 	__be16 duration;
 };
 
+struct bma400_genintr_info {
+	u8 genintr;
+	unsigned int intrmask;
+	enum iio_event_direction dir;
+	enum bma400_detect_criterion detect_mode;
+};
+
+/* Lookup struct for determining GEN1/GEN2 based on dir */
+static const struct bma400_genintr_info bma400_genintrs[] = {
+	[IIO_EV_DIR_RISING] = {
+		.genintr = GEN1_INTR,	/* 0 for GEN1 */
+		.intrmask = BMA400_INT_CONFIG0_GEN1_MASK,
+		.dir = IIO_EV_DIR_RISING,
+		.detect_mode = BMA400_DETECT_ACTIVITY,
+	},
+	[IIO_EV_DIR_FALLING] = {
+		.genintr = GEN2_INTR,	/* 1 for GEN2 */
+		.intrmask = BMA400_INT_CONFIG0_GEN2_MASK,
+		.dir = IIO_EV_DIR_FALLING,
+		.detect_mode = BMA400_DETECT_INACTIVITY,
+	}
+};
+
 static bool bma400_is_writable_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
@@ -1114,10 +1137,10 @@ static int bma400_read_event_config(struct iio_dev *indio_dev,
 	case IIO_ACCEL:
 		switch (dir) {
 		case IIO_EV_DIR_RISING:
-			return FIELD_GET(BMA400_INT_GEN1_MSK,
+			return FIELD_GET(BMA400_INT_CONFIG0_GEN1_MASK,
 					 data->generic_event_en);
 		case IIO_EV_DIR_FALLING:
-			return FIELD_GET(BMA400_INT_GEN2_MSK,
+			return FIELD_GET(BMA400_INT_CONFIG0_GEN2_MASK,
 					 data->generic_event_en);
 		case IIO_EV_DIR_SINGLETAP:
 			return FIELD_GET(BMA400_S_TAP_MSK,
@@ -1159,59 +1182,50 @@ static int bma400_activity_event_en(struct bma400_data *data,
 				    enum iio_event_direction dir,
 				    int state)
 {
-	int ret, reg, msk, value;
-	int field_value = 0;
-
-	switch (dir) {
-	case IIO_EV_DIR_RISING:
-		reg = BMA400_GEN1INT_CONFIG0;
-		msk = BMA400_INT_GEN1_MSK;
-		value = 2;
-		set_mask_bits(&field_value, BMA400_INT_GEN1_MSK,
-			      FIELD_PREP(BMA400_INT_GEN1_MSK, state));
-		break;
-	case IIO_EV_DIR_FALLING:
-		reg = BMA400_GEN2INT_CONFIG0;
-		msk = BMA400_INT_GEN2_MSK;
-		value = 0;
-		set_mask_bits(&field_value, BMA400_INT_GEN2_MSK,
-			      FIELD_PREP(BMA400_INT_GEN2_MSK, state));
-		break;
-	default:
-		return -EINVAL;
-	}
+	int ret, regval;
+	u8 genintr = bma400_genintrs[dir].genintr;
+	u8 detect_criterion = bma400_genintrs[dir].detect_mode;
+	unsigned int intrmask = bma400_genintrs[dir].intrmask;
 
 	/* Enabling all axis for interrupt evaluation */
-	ret = regmap_write(data->regmap, reg, 0xF8);
+	ret = regmap_write(data->regmap, BMA400_GENINT_CONFIG_REG(genintr, 0),
+			   BMA400_GENINT_CONFIG0_X_EN_MASK |
+			   BMA400_GENINT_CONFIG0_Y_EN_MASK |
+			   BMA400_GENINT_CONFIG0_Z_EN_MASK|
+			   BMA400_REF_EVERYTIME_UPDT_MODE);
 	if (ret)
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
+	regval = FIELD_PREP(BMA400_INT_CONFIG0_GEN1_MASK, state);
+	if (genintr)
+		regval = FIELD_PREP(BMA400_INT_CONFIG0_GEN2_MASK, state);
+
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
 
@@ -1336,18 +1350,6 @@ static int bma400_write_event_config(struct iio_dev *indio_dev,
 	}
 }
 
-static int get_gen_config_reg(enum iio_event_direction dir)
-{
-	switch (dir) {
-	case IIO_EV_DIR_FALLING:
-		return BMA400_GEN2INT_CONFIG0;
-	case IIO_EV_DIR_RISING:
-		return BMA400_GEN1INT_CONFIG0;
-	default:
-		return -EINVAL;
-	}
-}
-
 static int bma400_read_event_value(struct iio_dev *indio_dev,
 				   const struct iio_chan_spec *chan,
 				   enum iio_event_type type,
@@ -1356,22 +1358,20 @@ static int bma400_read_event_value(struct iio_dev *indio_dev,
 				   int *val, int *val2)
 {
 	struct bma400_data *data = iio_priv(indio_dev);
-	int ret, reg, reg_val, raw;
+	int ret, genintr, reg_val, raw;
 
 	if (chan->type != IIO_ACCEL)
 		return -EINVAL;
 
 	switch (type) {
 	case IIO_EV_TYPE_MAG:
-		reg = get_gen_config_reg(dir);
-		if (reg < 0)
-			return -EINVAL;
+		genintr = bma400_genintrs[dir].genintr;
 
 		*val2 = 0;
 		switch (info) {
 		case IIO_EV_INFO_VALUE:
 			ret = regmap_read(data->regmap,
-					  reg + BMA400_GEN_CONFIG2_OFF,
+					  BMA400_GENINT_CONFIG_REG(genintr, 2),
 					  val);
 			if (ret)
 				return ret;
@@ -1379,7 +1379,7 @@ static int bma400_read_event_value(struct iio_dev *indio_dev,
 		case IIO_EV_INFO_PERIOD:
 			mutex_lock(&data->mutex);
 			ret = regmap_bulk_read(data->regmap,
-					       reg + BMA400_GEN_CONFIG3_OFF,
+					       BMA400_GENINT_CONFIG_REG(genintr, 3),
 					       &data->duration,
 					       sizeof(data->duration));
 			if (ret) {
@@ -1390,10 +1390,12 @@ static int bma400_read_event_value(struct iio_dev *indio_dev,
 			mutex_unlock(&data->mutex);
 			return IIO_VAL_INT;
 		case IIO_EV_INFO_HYSTERESIS:
-			ret = regmap_read(data->regmap, reg, val);
+			ret = regmap_read(data->regmap,
+					  BMA400_GENINT_CONFIG_REG(genintr, 0),
+					  val);
 			if (ret)
 				return ret;
-			*val = FIELD_GET(BMA400_GEN_HYST_MSK, *val);
+			*val = FIELD_GET(BMA400_GENINT_CONFIG0_HYST_MASK, *val);
 			return IIO_VAL_INT;
 		default:
 			return -EINVAL;
@@ -1444,16 +1446,14 @@ static int bma400_write_event_value(struct iio_dev *indio_dev,
 				    int val, int val2)
 {
 	struct bma400_data *data = iio_priv(indio_dev);
-	int reg, ret, raw;
+	int genintr, ret, raw;
 
 	if (chan->type != IIO_ACCEL)
 		return -EINVAL;
 
 	switch (type) {
 	case IIO_EV_TYPE_MAG:
-		reg = get_gen_config_reg(dir);
-		if (reg < 0)
-			return -EINVAL;
+		genintr = bma400_genintrs[dir].genintr;
 
 		switch (info) {
 		case IIO_EV_INFO_VALUE:
@@ -1461,7 +1461,7 @@ static int bma400_write_event_value(struct iio_dev *indio_dev,
 				return -EINVAL;
 
 			return regmap_write(data->regmap,
-					    reg + BMA400_GEN_CONFIG2_OFF,
+					    BMA400_GENINT_CONFIG_REG(genintr, 2),
 					    val);
 		case IIO_EV_INFO_PERIOD:
 			if (val < 1 || val > 65535)
@@ -1470,7 +1470,7 @@ static int bma400_write_event_value(struct iio_dev *indio_dev,
 			mutex_lock(&data->mutex);
 			put_unaligned_be16(val, &data->duration);
 			ret = regmap_bulk_write(data->regmap,
-						reg + BMA400_GEN_CONFIG3_OFF,
+						BMA400_GENINT_CONFIG_REG(genintr, 3),
 						&data->duration,
 						sizeof(data->duration));
 			mutex_unlock(&data->mutex);
@@ -1479,10 +1479,10 @@ static int bma400_write_event_value(struct iio_dev *indio_dev,
 			if (val < 0 || val > 3)
 				return -EINVAL;
 
-			return regmap_update_bits(data->regmap, reg,
-						  BMA400_GEN_HYST_MSK,
-						  FIELD_PREP(BMA400_GEN_HYST_MSK,
-							     val));
+			return regmap_update_bits(data->regmap,
+						  BMA400_GENINT_CONFIG_REG(genintr, 0),
+						  BMA400_GENINT_CONFIG0_HYST_MASK,
+						  FIELD_PREP(BMA400_GENINT_CONFIG0_HYST_MASK, val));
 		default:
 			return -EINVAL;
 		}
@@ -1650,10 +1650,10 @@ static irqreturn_t bma400_interrupt(int irq, void *private)
 						  IIO_EV_DIR_DOUBLETAP),
 			       timestamp);
 
-	if (FIELD_GET(BMA400_INT_GEN1_MSK, le16_to_cpu(data->status)))
+	if (FIELD_GET(BMA400_INT_CONFIG0_GEN1_MASK, le16_to_cpu(data->status)))
 		ev_dir = IIO_EV_DIR_RISING;
 
-	if (FIELD_GET(BMA400_INT_GEN2_MSK, le16_to_cpu(data->status)))
+	if (FIELD_GET(BMA400_INT_CONFIG0_GEN2_MASK, le16_to_cpu(data->status)))
 		ev_dir = IIO_EV_DIR_FALLING;
 
 	if (ev_dir != IIO_EV_DIR_NONE) {
-- 
2.43.0


