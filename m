Return-Path: <linux-iio+bounces-24437-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E8DBA0C1C
	for <lists+linux-iio@lfdr.de>; Thu, 25 Sep 2025 19:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DB80188B27E
	for <lists+linux-iio@lfdr.de>; Thu, 25 Sep 2025 17:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC7B30DD37;
	Thu, 25 Sep 2025 17:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jpbozD9T"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE38830B53B
	for <linux-iio@vger.kernel.org>; Thu, 25 Sep 2025 17:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758820200; cv=none; b=ncZpC+ZEcvqMZ5pE/r7p+eZUfcsSNYksbL8ZeAJTC9wddjHWQEHGxPEparw6wXaXboNAcfWln9I0KIA8axA+3eoVhriya/GILwuW6ozD6rvId5bgxNxYlrk2crLhi6AYibO57cfLetYwgVAa//zqFj0r9vZttmyf4+wjHthSSWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758820200; c=relaxed/simple;
	bh=R8DoOC7TKelfCVl3NxWs9FgYKJgcvNUgtix1hDSRviA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WecZwJGKUUU1pe02u5t0IZnIH1ZHDJADEWq/9KrCIlVU1q9jrKS6gfzmgvBxgSUmF/lIK/VQODsOCbf3m5Ksa/WMVOKWZhaKIUfmZKZ6oWLmHh3Wd0NcoqDYfRLB8HnOc3jR6MSSGKqMNqNU9c72zZpQL3VyVRvKMe/C/yQQ3CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jpbozD9T; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b551b040930so819450a12.2
        for <linux-iio@vger.kernel.org>; Thu, 25 Sep 2025 10:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758820198; x=1759424998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=efxMyZPKgLvNKUWEHGdjVtr3N7dT/6ejSioFKUkhlks=;
        b=jpbozD9TWcenLgvK0pkeWB2sPH8GNMOEfCT+Tj0CH00P0sIJlgdvQie2Qy4yueeNxw
         metzNa5vQfKRRPAqv8iZvoPW084AjNxPYmwDDFbdEDzgWBupLsqAIwKfyvOIz5ZwLQ7u
         5QNP1/s30pAT2kHuk5+2oGlYA76e6I4fvUxYm4dlRtH/bXkljd5FARngVKbIPcWT4/ms
         rBvFPaY4OVom65XdRNJtFoDS8/fgAOj8ZfrBN1dtbu/sNrpZa/OVk8hWheZnILsNm5LC
         SZ4CCakuORz1wYjCxVf8a5mF1PvKOgvz2SIzeYV/I9CkRhaS/qtjBP4e38w+Jk4yuYuG
         3hNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758820198; x=1759424998;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=efxMyZPKgLvNKUWEHGdjVtr3N7dT/6ejSioFKUkhlks=;
        b=NjpJuhUF4W6D8DoAmlvNGkULe1i/SLIahVu5d/VHS34bljLKmkFLR/Ktti8sanJspM
         Lk+ZWYpaWYDRu1fsCNpu8j72t5FAfgsDdZlUl4E61Lr3Dl/KaFtzFPk4SUMuO/ZcDrMA
         /ioELmtjPxFeSjwPyKYO1GmJwCuvVyzThXZ/dE2f33PxkjdJMoHbOMgXYhUN2pXtKT55
         eoFdtMdgMUdfVuVYIhWIj3uXu81C7bHMvBNZV9WA6cRh1mj8Be4QnGAggVTI6AtkBXa5
         U1W9RS1UzeYCMaKh1R48Ufy+DNw5SNsG/d9ICUTJa/g/W5SYRx59K9ek61g9R5bfa1EY
         SysA==
X-Forwarded-Encrypted: i=1; AJvYcCVzjD43RG9M/5r23Fcgf7+0BG8PwDJBlTSXFc02lP4Z7PjbVh3rseduMjSfKOv+k1T4I2Bg1n1nzSI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvn6Uc8TeNhRWq1dLT5iTDWkodkyD7gfrfGF6kStdNbdO9d1lL
	9tzv8Scjcv6uyunsQ4Q/N5BvoAkOV8x9RyBImcgt9FEUM8zE7SDwky+0
X-Gm-Gg: ASbGncsWEi+3xQvhegDP95xnevMDqR+UOqMkW6aneLLP2yLJO8PJxT+U6BqKUlgJX5J
	0FRauFcY60dciS5JSAGiJDY1VhSOlMczZ3c09qRb+WqCad1ROXzzK9d7yz/89bX7a0AwPFosjAd
	/jAWVn9A+u9uLyReTwlfJirgnGzcJchnhgkp40/faJSrGkonowPlbIIUAL3HUMWeFhQkgiOF64H
	ViDOzY343fXumGFe7fIYdehRMfZKKV/aqrywqVM2aDAW8VaJ/lhyF3OS9OqUf5v99+quAlP6Vd8
	bqfY8op3XY3oZD0Qw0Iz8InEvrtMJt/JX8sDYH89EQ59AqLrhFx0X2p+aQ9kEjlmtOE5L3i7QGr
	m8vbW+BxTwt64UMkOrDvRdG109m5UArDG
X-Google-Smtp-Source: AGHT+IEBZS0e/+42Nfj1FR2mIyLxS78lgGBCYRxyu3ai9z3f1JXJA+1VWJBG3XnpgC6bq0uy62Emzw==
X-Received: by 2002:a17:903:2c0d:b0:275:27ab:f6c4 with SMTP id d9443c01a7336-27ed4a315b5mr49339555ad.33.1758820197852;
        Thu, 25 Sep 2025 10:09:57 -0700 (PDT)
Received: from akshayaj-lenovo.. ([223.233.78.39])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed68821desm30779385ad.91.2025.09.25.10.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 10:09:57 -0700 (PDT)
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
Subject: [PATCH v2] iio: accel: bma400: Refactor generic interrupt configuration
Date: Thu, 25 Sep 2025 22:39:40 +0530
Message-ID: <20250925170942.259314-1-akshayaj.lkd@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor generic interrupt configuration to replace hard-coded
register values with logical macros and enums, thereby making the
configuration understandable and in-style with common kernel
patterns.

Introduce a const struct with a helper to map event direction to the
corresponding generic interrupt and sanitize the input before use.

Rename activity_event_en() to generic_event_en() to better describe
its role in activity and inactivity detection.

No functional changes done.

Signed-off-by: Akshay Jindal <akshayaj.lkd@gmail.com>
---

Changes since v1:
- Address Nuno's feedback of using a helper function to sanitize dir.
- Fixed a bug introduced in v1 changes (incorrect bit set in GENINT_CONFIG0 register).
- Rename bma400_activity_event_en() to bma400_generic_event_en(), since
  bma400 offers 3 variety of events related to activity. Renaming to generic
  makes it more relatable to the functionality.
- Added Testing summary.
- Edited minor comment.

Testing Summary:
- Tested on raspberrypi 4b and 7-semi bma400 sensor breakout board.
- Since no functional impact is there, so before functionality is
  expected to be equal to after change functionality.
- Tested mapping of GEN1 and GEN2 both on INT1 pin as before.
- Tested both activity and inactivity detection by setting attributes
  events/in_accel_mag_falling_en as well as events/in_accel_mag_rising_en.
- Did read and writes on various attributes such that write_event_config(),
  write_event_value() and read_event_value() callbacks are triggered.

 drivers/iio/accel/bma400.h      |  71 ++++++++++++--
 drivers/iio/accel/bma400_core.c | 163 ++++++++++++++++++++------------
 2 files changed, 161 insertions(+), 73 deletions(-)

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
index 85e23badf733..aabbe74e1db7 100644
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
@@ -1155,63 +1178,83 @@ static int bma400_steps_event_enable(struct bma400_data *data, int state)
 	return 0;
 }
 
-static int bma400_activity_event_en(struct bma400_data *data,
-				    enum iio_event_direction dir,
-				    int state)
+static inline const struct bma400_genintr_info *
+get_bma400_genintr_info(enum iio_event_direction dir)
 {
-	int ret, reg, msk, value;
-	int field_value = 0;
-
 	switch (dir) {
 	case IIO_EV_DIR_RISING:
-		reg = BMA400_GEN1INT_CONFIG0;
-		msk = BMA400_INT_GEN1_MSK;
-		value = 2;
-		set_mask_bits(&field_value, BMA400_INT_GEN1_MSK,
-			      FIELD_PREP(BMA400_INT_GEN1_MSK, state));
-		break;
 	case IIO_EV_DIR_FALLING:
-		reg = BMA400_GEN2INT_CONFIG0;
-		msk = BMA400_INT_GEN2_MSK;
-		value = 0;
-		set_mask_bits(&field_value, BMA400_INT_GEN2_MSK,
-			      FIELD_PREP(BMA400_INT_GEN2_MSK, state));
-		break;
+		return &bma400_genintrs[dir];
 	default:
+		return NULL;
+
+	};
+}
+
+static int bma400_generic_event_en(struct bma400_data *data,
+				   enum iio_event_direction dir,
+				   int state)
+{
+	int ret, regval;
+	u8 genintr, detect_criterion;
+	unsigned int intrmask;
+	const struct bma400_genintr_info *bma400_genintr;
+
+	bma400_genintr = get_bma400_genintr_info(dir);
+	if (!bma400_genintr)
 		return -EINVAL;
-	}
 
-	/* Enabling all axis for interrupt evaluation */
-	ret = regmap_write(data->regmap, reg, 0xF8);
+	genintr = bma400_genintr->genintr;
+	detect_criterion = bma400_genintr->detect_mode;
+	intrmask = bma400_genintr->intrmask;
+
+	/*
+	 * Enabling all axis for interrupt evaluation.
+	 * Acc_filt2 is recommended as data source in datasheet (Section 4.7).
+	 */
+	ret = regmap_write(data->regmap, BMA400_GENINT_CONFIG_REG(genintr, 0),
+			   BMA400_GENINT_CONFIG0_X_EN_MASK |
+			   BMA400_GENINT_CONFIG0_Y_EN_MASK |
+			   BMA400_GENINT_CONFIG0_Z_EN_MASK|
+			   FIELD_PREP(BMA400_GENINT_CONFIG0_DATA_SRC_MASK, ACCEL_FILT2)|
+			   FIELD_PREP(BMA400_GENINT_CONFIG0_REF_UPD_MODE_MASK,
+				      BMA400_REF_EVERYTIME_UPDT_MODE));
 	if (ret)
 		return ret;
 
 	/* OR combination of all axis for interrupt evaluation */
-	ret = regmap_write(data->regmap, reg + BMA400_GEN_CONFIG1_OFF, value);
+	regval = FIELD_PREP(BMA400_GENINT_CONFIG1_AXES_COMB_MASK, BMA400_EVAL_X_OR_Y_OR_Z) |
+		 FIELD_PREP(BMA400_GENINT_CONFIG1_DETCT_CRIT_MASK, detect_criterion);
+	ret = regmap_write(data->regmap, BMA400_GENINT_CONFIG_REG(genintr, 1), regval);
 	if (ret)
 		return ret;
 
-	/* Initial value to avoid interrupts while enabling*/
-	ret = regmap_write(data->regmap, reg + BMA400_GEN_CONFIG2_OFF, 0x0A);
+	/*
+	 * Initial value to avoid (activity) interrupts while enabling
+	 * Value is in units of 8mg/lsb, i.e. effective val is val * 8mg/lsb
+	 */
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
 
@@ -1303,7 +1346,7 @@ static int bma400_write_event_config(struct iio_dev *indio_dev,
 		switch (type) {
 		case IIO_EV_TYPE_MAG:
 			mutex_lock(&data->mutex);
-			ret = bma400_activity_event_en(data, dir, state);
+			ret = bma400_generic_event_en(data, dir, state);
 			mutex_unlock(&data->mutex);
 			return ret;
 		case IIO_EV_TYPE_GESTURE:
@@ -1336,18 +1379,6 @@ static int bma400_write_event_config(struct iio_dev *indio_dev,
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
@@ -1356,22 +1387,24 @@ static int bma400_read_event_value(struct iio_dev *indio_dev,
 				   int *val, int *val2)
 {
 	struct bma400_data *data = iio_priv(indio_dev);
-	int ret, reg, reg_val, raw;
+	int ret, genintr, reg_val, raw;
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
@@ -1379,7 +1412,7 @@ static int bma400_read_event_value(struct iio_dev *indio_dev,
 		case IIO_EV_INFO_PERIOD:
 			mutex_lock(&data->mutex);
 			ret = regmap_bulk_read(data->regmap,
-					       reg + BMA400_GEN_CONFIG3_OFF,
+					       BMA400_GENINT_CONFIG_REG(genintr, 3),
 					       &data->duration,
 					       sizeof(data->duration));
 			if (ret) {
@@ -1390,10 +1423,12 @@ static int bma400_read_event_value(struct iio_dev *indio_dev,
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
@@ -1444,16 +1479,18 @@ static int bma400_write_event_value(struct iio_dev *indio_dev,
 				    int val, int val2)
 {
 	struct bma400_data *data = iio_priv(indio_dev);
-	int reg, ret, raw;
+	int genintr, ret, raw;
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
@@ -1461,7 +1498,7 @@ static int bma400_write_event_value(struct iio_dev *indio_dev,
 				return -EINVAL;
 
 			return regmap_write(data->regmap,
-					    reg + BMA400_GEN_CONFIG2_OFF,
+					    BMA400_GENINT_CONFIG_REG(genintr, 2),
 					    val);
 		case IIO_EV_INFO_PERIOD:
 			if (val < 1 || val > 65535)
@@ -1470,7 +1507,7 @@ static int bma400_write_event_value(struct iio_dev *indio_dev,
 			mutex_lock(&data->mutex);
 			put_unaligned_be16(val, &data->duration);
 			ret = regmap_bulk_write(data->regmap,
-						reg + BMA400_GEN_CONFIG3_OFF,
+						BMA400_GENINT_CONFIG_REG(genintr, 3),
 						&data->duration,
 						sizeof(data->duration));
 			mutex_unlock(&data->mutex);
@@ -1479,10 +1516,10 @@ static int bma400_write_event_value(struct iio_dev *indio_dev,
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
@@ -1650,10 +1687,10 @@ static irqreturn_t bma400_interrupt(int irq, void *private)
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


