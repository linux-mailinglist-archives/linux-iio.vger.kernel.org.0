Return-Path: <linux-iio+bounces-24998-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F87BD0933
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 20:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B2F218932C2
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 18:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB67B2EDD4D;
	Sun, 12 Oct 2025 18:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ai12n3IL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E402EFDAF
	for <linux-iio@vger.kernel.org>; Sun, 12 Oct 2025 18:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760292411; cv=none; b=Acsagn4P5sRK9Qfny55/a66gaAD2Bk+em3zwAWdRKZ3FAdF/hMKk9j3lSbRlFQN+Gt+f5mplda9XfHgX00nGqVLPBIr7Jmj3sJKhymRFqluM13oZaHVn7nCOVbF6OVXsPlpg+nikrY6ooK+sF5pO533iCJoH0Wf8sysjxRUD19w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760292411; c=relaxed/simple;
	bh=5cRpz/cGs2jwu8uzbZzdcA2ek9WFM+WzDiYvxFOFnMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cXeqDEgGa1Whr8XHZ23K/8Abc1ZCNlD8g2n30AUn2a7JcoHevd7TUWgQ/Aot5wFaTihIuG36fU5tOo2jFjkmSktmgoEXSOUUtf6bD8lgw833ODlI7KyUQuIVggW7zxp3szhDkz0ENSRgXiKo2NU5csOuCyTbONMPUxIKDTGLmcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ai12n3IL; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-27edcbbe7bfso42583835ad.0
        for <linux-iio@vger.kernel.org>; Sun, 12 Oct 2025 11:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760292408; x=1760897208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ClGYYW1uXNGP6vic75OLMf+2JKlHrGDWFRNq5iNbb+A=;
        b=ai12n3ILn2kI0FBPTJldKoGshRA7Au9zwP6pPijBCtoHgf2BvpD3N7qgnjJ3Z+RSh/
         nauvEDFgKxz3kA1uo3Ebf3K4MD0RZw30g5kFawiI6mi9szmXpFxKIVNRJa+ACVtGn2Zt
         Rf2KOe2huGOB9jxRSxFJz3b9zJ0l/0l9eeTSQmifUWLSVlEhwnM9oB1hbK1aOKTai6T1
         ytLrOwgUaRPLrm2uomPvZ416m+9fXfZ0Id1dI/WvHIjya59aBh7SI96g3hjnI+q9y/nO
         ofeCZ3N2OkSsLVdrabZ5lGWR4tG/+XlMLXyz+cwsSkFT9RYEtQPqlihzRFCyKoPDZ3Me
         HiZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760292408; x=1760897208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ClGYYW1uXNGP6vic75OLMf+2JKlHrGDWFRNq5iNbb+A=;
        b=efk86aNshujfsE+LRyYreTj6DDqrq8nRtGTvDgnTbNWMSobaCFzoUKofA1Ee+L9NeZ
         yLivEELSBQ3/sZpOOoIKjna0/Ix0hwayFzLw4oFOGI6rbgszUizxGf+S+qa/C9a1x/Mg
         YStQvv3vZhDnhWpO50+M7+ciImUD6lpN/f7nP4TT4yt5TQ6Bh/GWBQXPaoLwQeAw+Ewc
         WLsTzTrAg648Ta+rwBtTPPBscw6x2n2jMk5qegApcTJAP5chckBcXI0l5AHRrylmJGYT
         fdACdHFNmV6DomwEvylT1DskJGt7w6NBw9iuGbrQP6fobLV7ehqOQK5rmZEHEVuMNsx6
         Zhgw==
X-Forwarded-Encrypted: i=1; AJvYcCUopHrCsoaoj+nge0wvUfZthGvfBqdNbyxrvpxQQ5wAYzq4TNPt0ksF13G4GG7v85ocN/RIgwUwTbM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzn6nfLZNfhN9dqobNWQRorrE9pROqG4Bm9x6y6P5ou6Opsm7h
	jcFV6v8dieoH0lSQgeMOxpi14KGSQUW2IXyM5loy1THYgq18AXVvJwiv
X-Gm-Gg: ASbGncvcjBKw7qgZHuxiHnt1yf+AF3JgIxCOD35GURdIDm6IK+19vCwTrHCP2Jssn8E
	65wqGpJuffXfC1wyj/25g0DM9QJynU/2ii4LooACaszggu2qxnioKS0hg1Nf0qvlM45iN9De93G
	uenGBP2ipwyR7O7e39wOWM8Qx1D7sh/WUwEI4irNY4ZKfH/h0jCxmcGyOetIA47bvrbzJozMRhd
	EToOdKcMQBbPxQsZTRmKvG7seJJzq497WHk+Ud82nbYyt6scW95dW5BmyO92Bo6TbHV+BeyCgqn
	ySKYRwsET687v7BFhEr7UbbyHAw4VHEQvl028KhzlGaBSBvMclguLIl2EI5Wh4dLMbNTqK5FVVc
	rkP7U47XZ1vP89E7TRVA8WTlzf241ajV6Im6efMfCHbp8O/9wAkA=
X-Google-Smtp-Source: AGHT+IHxhQzW+ByGPIfw24UEol3/0PnIts2hHNgB21YM8YzxnIvtrSSqXo848LQdZ/6qW/8Z8RlIlA==
X-Received: by 2002:a17:903:1b4b:b0:269:b6c8:4a4b with SMTP id d9443c01a7336-29027214ee7mr255843205ad.6.1760292407622;
        Sun, 12 Oct 2025 11:06:47 -0700 (PDT)
Received: from akshayaj-lenovo.. ([223.233.65.54])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f56c0fsm111734345ad.104.2025.10.12.11.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 11:06:47 -0700 (PDT)
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
Subject: [PATCH v5 1/6] iio: accel: bma400: Reorganize and rename register and field macros
Date: Sun, 12 Oct 2025 23:36:08 +0530
Message-ID: <20251012180619.195244-2-akshayaj.lkd@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251012180619.195244-1-akshayaj.lkd@gmail.com>
References: <20251012180619.195244-1-akshayaj.lkd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reorganize register and field macros to improve consistency with the
datasheet and naming style:

- Move field macros next to their corresponding register macros
- Reorder register macros to follow address order from the datasheet
- Rename field macros to include the register name in the macro name
- Add a _REG suffix to register macros where missing
- Add INT_STAT register fields corresponding to used INT_CONFIG fields

No functional changes are intended.

Signed-off-by: Akshay Jindal <akshayaj.lkd@gmail.com>
---

Changes since v4:
- Add INT_STATx field macros corresponding to used INT_CONFIGx fields.
- Make INT_STATx field macro names consistent with the overall convention used.
- Tied the INT_STATx field to correct INT_STAT register.
- Modified changelog of PATCH 1/6 due to addition of INT_STATx fields.

 drivers/iio/accel/bma400.h      | 117 ++++++++++--------
 drivers/iio/accel/bma400_core.c | 212 ++++++++++++++++----------------
 2 files changed, 170 insertions(+), 159 deletions(-)

diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
index 932358b45f17..fcafd1fba57a 100644
--- a/drivers/iio/accel/bma400.h
+++ b/drivers/iio/accel/bma400.h
@@ -16,31 +16,44 @@
  * Read-Only Registers
  */
 
+/* Chip ID of BMA 400 devices found in the chip ID register. */
+#define BMA400_ID_REG_VAL           0x90
+
 /* Status and ID registers */
 #define BMA400_CHIP_ID_REG          0x00
 #define BMA400_ERR_REG              0x02
 #define BMA400_STATUS_REG           0x03
 
 /* Acceleration registers */
-#define BMA400_X_AXIS_LSB_REG       0x04
-#define BMA400_X_AXIS_MSB_REG       0x05
-#define BMA400_Y_AXIS_LSB_REG       0x06
-#define BMA400_Y_AXIS_MSB_REG       0x07
-#define BMA400_Z_AXIS_LSB_REG       0x08
-#define BMA400_Z_AXIS_MSB_REG       0x09
+#define BMA400_ACC_X_LSB_REG		0x04
+#define BMA400_ACC_X_MSB_REG		0x05
+#define BMA400_ACC_Y_LSB_REG		0x06
+#define BMA400_ACC_Y_MSB_REG		0x07
+#define BMA400_ACC_Z_LSB_REG		0x08
+#define BMA400_ACC_Z_MSB_REG		0x09
 
 /* Sensor time registers */
-#define BMA400_SENSOR_TIME0         0x0a
-#define BMA400_SENSOR_TIME1         0x0b
-#define BMA400_SENSOR_TIME2         0x0c
+#define BMA400_SENSOR_TIME0_REG         0x0a
+#define BMA400_SENSOR_TIME1_REG         0x0b
+#define BMA400_SENSOR_TIME2_REG         0x0c
 
 /* Event and interrupt registers */
 #define BMA400_EVENT_REG            0x0d
+
 #define BMA400_INT_STAT0_REG        0x0e
+#define BMA400_INT_STAT0_GEN1_MASK		BIT(2)
+#define BMA400_INT_STAT0_GEN2_MASK		BIT(3)
+#define BMA400_INT_STAT0_DRDY_MASK		BIT(7)
+
 #define BMA400_INT_STAT1_REG        0x0f
+#define BMA400_INT_STAT1_STEP_INT_MASK		GENMASK(9, 8)
+#define BMA400_INT_STAT1_S_TAP_MASK		BIT(10)
+#define BMA400_INT_STAT1_D_TAP_MASK		BIT(11)
+
 #define BMA400_INT_STAT2_REG        0x10
-#define BMA400_INT12_MAP_REG        0x23
-#define BMA400_INT_ENG_OVRUN_MSK    BIT(4)
+
+/* Bit present in all INT_STAT registers */
+#define BMA400_INT_STAT_ENG_OVRRUN_MASK		BIT(4)
 
 /* Temperature register */
 #define BMA400_TEMP_DATA_REG        0x11
@@ -55,70 +68,68 @@
 #define BMA400_STEP_CNT1_REG        0x16
 #define BMA400_STEP_CNT3_REG        0x17
 #define BMA400_STEP_STAT_REG        0x18
-#define BMA400_STEP_INT_MSK         BIT(0)
 #define BMA400_STEP_RAW_LEN         0x03
-#define BMA400_STEP_STAT_MASK       GENMASK(9, 8)
 
 /*
  * Read-write configuration registers
  */
-#define BMA400_ACC_CONFIG0_REG      0x19
-#define BMA400_ACC_CONFIG1_REG      0x1a
+#define BMA400_ACC_CONFIG0_REG		0x19
+#define BMA400_ACC_CONFIG0_LP_OSR_MASK		GENMASK(6, 5)
+#define BMA400_LP_OSR_SHIFT		5
+
+#define BMA400_ACC_CONFIG1_REG		0x1a
+#define BMA400_ACC_CONFIG1_ODR_MASK		GENMASK(3, 0)
+#define BMA400_ACC_CONFIG1_ODR_MIN_RAW		0x05
+#define BMA400_ACC_CONFIG1_ODR_LP_RAW		0x06
+#define BMA400_ACC_CONFIG1_ODR_MAX_RAW		0x0b
+#define BMA400_ACC_CONFIG1_ODR_MAX_HZ		800
+#define BMA400_ACC_CONFIG1_ODR_MIN_WHOLE_HZ	25
+#define BMA400_ACC_CONFIG1_ODR_MIN_HZ		12
+#define BMA400_ACC_CONFIG1_NP_OSR_MASK		GENMASK(5, 4)
+#define BMA400_NP_OSR_SHIFT		4
+#define BMA400_ACC_CONFIG1_ACC_RANGE_MASK	GENMASK(7, 6)
+#define BMA400_ACC_RANGE_SHIFT		6
+
 #define BMA400_ACC_CONFIG2_REG      0x1b
-#define BMA400_CMD_REG              0x7e
 
 /* Interrupt registers */
 #define BMA400_INT_CONFIG0_REG	    0x1f
+#define BMA400_INT_CONFIG0_GEN1_MASK		BIT(2)
+#define BMA400_INT_CONFIG0_GEN2_MASK		BIT(3)
+#define BMA400_INT_CONFIG0_DRDY_MASK		BIT(7)
+
 #define BMA400_INT_CONFIG1_REG	    0x20
+#define BMA400_INT_CONFIG1_STEP_INT_MASK	BIT(0)
+#define BMA400_INT_CONFIG1_S_TAP_MASK		BIT(2)
+#define BMA400_INT_CONFIG1_D_TAP_MASK		BIT(3)
+
 #define BMA400_INT1_MAP_REG	    0x21
+#define BMA400_INT12_MAP_REG        0x23
 #define BMA400_INT_IO_CTRL_REG	    0x24
-#define BMA400_INT_DRDY_MSK	    BIT(7)
-
-/* Chip ID of BMA 400 devices found in the chip ID register. */
-#define BMA400_ID_REG_VAL           0x90
-
-#define BMA400_LP_OSR_SHIFT         5
-#define BMA400_NP_OSR_SHIFT         4
-#define BMA400_SCALE_SHIFT          6
 
 #define BMA400_TWO_BITS_MASK        GENMASK(1, 0)
-#define BMA400_LP_OSR_MASK          GENMASK(6, 5)
-#define BMA400_NP_OSR_MASK          GENMASK(5, 4)
-#define BMA400_ACC_ODR_MASK         GENMASK(3, 0)
-#define BMA400_ACC_SCALE_MASK       GENMASK(7, 6)
-
-#define BMA400_ACC_ODR_MIN_RAW      0x05
-#define BMA400_ACC_ODR_LP_RAW       0x06
-#define BMA400_ACC_ODR_MAX_RAW      0x0b
-
-#define BMA400_ACC_ODR_MAX_HZ       800
-#define BMA400_ACC_ODR_MIN_WHOLE_HZ 25
-#define BMA400_ACC_ODR_MIN_HZ       12
 
 /* Generic interrupts register */
-#define BMA400_GEN1INT_CONFIG0      0x3f
-#define BMA400_GEN2INT_CONFIG0      0x4A
+#define BMA400_GEN1INT_CONFIG0_REG      0x3f
+#define BMA400_GEN2INT_CONFIG0_REG      0x4A
+#define BMA400_GENINT_CONFIG0_HYST_MASK		GENMASK(1, 0)
+
 #define BMA400_GEN_CONFIG1_OFF      0x01
 #define BMA400_GEN_CONFIG2_OFF      0x02
 #define BMA400_GEN_CONFIG3_OFF      0x03
 #define BMA400_GEN_CONFIG31_OFF     0x04
-#define BMA400_INT_GEN1_MSK         BIT(2)
-#define BMA400_INT_GEN2_MSK         BIT(3)
-#define BMA400_GEN_HYST_MSK         GENMASK(1, 0)
 
 /* TAP config registers */
-#define BMA400_TAP_CONFIG           0x57
-#define BMA400_TAP_CONFIG1          0x58
-#define BMA400_S_TAP_MSK            BIT(2)
-#define BMA400_D_TAP_MSK            BIT(3)
-#define BMA400_INT_S_TAP_MSK        BIT(10)
-#define BMA400_INT_D_TAP_MSK        BIT(11)
-#define BMA400_TAP_SEN_MSK          GENMASK(2, 0)
-#define BMA400_TAP_TICSTH_MSK       GENMASK(1, 0)
-#define BMA400_TAP_QUIET_MSK        GENMASK(3, 2)
-#define BMA400_TAP_QUIETDT_MSK      GENMASK(5, 4)
+#define BMA400_TAP_CONFIG_REG		0x57
+#define BMA400_TAP_CONFIG_SEN_MASK	GENMASK(2, 0)
+
+#define BMA400_TAP_CONFIG1_REG          0x58
+#define BMA400_TAP_CONFIG1_TICSTH_MASK		GENMASK(1, 0)
+#define BMA400_TAP_CONFIG1_QUIET_MASK		GENMASK(3, 2)
+#define BMA400_TAP_CONFIG1_QUIETDT_MASK		GENMASK(5, 4)
 #define BMA400_TAP_TIM_LIST_LEN     4
 
+#define BMA400_CMD_REG              0x7e
 /*
  * BMA400_SCALE_MIN macro value represents m/s^2 for 1 LSB before
  * converting to micro values for +-2g range.
@@ -138,8 +149,8 @@
  * To select +-8g = 9577 << 2 = raw value to write is 2.
  * To select +-16g = 9577 << 3 = raw value to write is 3.
  */
-#define BMA400_SCALE_MIN            9577
-#define BMA400_SCALE_MAX            76617
+#define BMA400_ACC_SCALE_MIN            9577
+#define BMA400_ACC_SCALE_MAX            76617
 
 extern const struct regmap_config bma400_regmap_config;
 
diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
index 85e23badf733..2324c4ef645c 100644
--- a/drivers/iio/accel/bma400_core.c
+++ b/drivers/iio/accel/bma400_core.c
@@ -127,15 +127,15 @@ static bool bma400_is_writable_reg(struct device *dev, unsigned int reg)
 	case BMA400_CHIP_ID_REG:
 	case BMA400_ERR_REG:
 	case BMA400_STATUS_REG:
-	case BMA400_X_AXIS_LSB_REG:
-	case BMA400_X_AXIS_MSB_REG:
-	case BMA400_Y_AXIS_LSB_REG:
-	case BMA400_Y_AXIS_MSB_REG:
-	case BMA400_Z_AXIS_LSB_REG:
-	case BMA400_Z_AXIS_MSB_REG:
-	case BMA400_SENSOR_TIME0:
-	case BMA400_SENSOR_TIME1:
-	case BMA400_SENSOR_TIME2:
+	case BMA400_ACC_X_LSB_REG:
+	case BMA400_ACC_X_MSB_REG:
+	case BMA400_ACC_Y_LSB_REG:
+	case BMA400_ACC_Y_MSB_REG:
+	case BMA400_ACC_Z_LSB_REG:
+	case BMA400_ACC_Z_MSB_REG:
+	case BMA400_SENSOR_TIME0_REG:
+	case BMA400_SENSOR_TIME1_REG:
+	case BMA400_SENSOR_TIME2_REG:
 	case BMA400_EVENT_REG:
 	case BMA400_INT_STAT0_REG:
 	case BMA400_INT_STAT1_REG:
@@ -159,15 +159,15 @@ static bool bma400_is_volatile_reg(struct device *dev, unsigned int reg)
 	switch (reg) {
 	case BMA400_ERR_REG:
 	case BMA400_STATUS_REG:
-	case BMA400_X_AXIS_LSB_REG:
-	case BMA400_X_AXIS_MSB_REG:
-	case BMA400_Y_AXIS_LSB_REG:
-	case BMA400_Y_AXIS_MSB_REG:
-	case BMA400_Z_AXIS_LSB_REG:
-	case BMA400_Z_AXIS_MSB_REG:
-	case BMA400_SENSOR_TIME0:
-	case BMA400_SENSOR_TIME1:
-	case BMA400_SENSOR_TIME2:
+	case BMA400_ACC_X_LSB_REG:
+	case BMA400_ACC_X_MSB_REG:
+	case BMA400_ACC_Y_LSB_REG:
+	case BMA400_ACC_Y_MSB_REG:
+	case BMA400_ACC_Z_LSB_REG:
+	case BMA400_ACC_Z_MSB_REG:
+	case BMA400_SENSOR_TIME0_REG:
+	case BMA400_SENSOR_TIME1_REG:
+	case BMA400_SENSOR_TIME2_REG:
 	case BMA400_EVENT_REG:
 	case BMA400_INT_STAT0_REG:
 	case BMA400_INT_STAT1_REG:
@@ -275,11 +275,11 @@ static ssize_t in_accel_gesture_tap_maxtomin_time_show(struct device *dev,
 	struct bma400_data *data = iio_priv(indio_dev);
 	int ret, reg_val, raw, vals[2];
 
-	ret = regmap_read(data->regmap, BMA400_TAP_CONFIG1, &reg_val);
+	ret = regmap_read(data->regmap, BMA400_TAP_CONFIG1_REG, &reg_val);
 	if (ret)
 		return ret;
 
-	raw = FIELD_GET(BMA400_TAP_TICSTH_MSK, reg_val);
+	raw = FIELD_GET(BMA400_TAP_CONFIG1_TICSTH_MASK, reg_val);
 	vals[0] = 0;
 	vals[1] = tap_max2min_time[raw];
 
@@ -302,9 +302,9 @@ static ssize_t in_accel_gesture_tap_maxtomin_time_store(struct device *dev,
 	if (raw < 0)
 		return -EINVAL;
 
-	ret = regmap_update_bits(data->regmap, BMA400_TAP_CONFIG1,
-				 BMA400_TAP_TICSTH_MSK,
-				 FIELD_PREP(BMA400_TAP_TICSTH_MSK, raw));
+	ret = regmap_update_bits(data->regmap, BMA400_TAP_CONFIG1_REG,
+				 BMA400_TAP_CONFIG1_TICSTH_MASK,
+				 FIELD_PREP(BMA400_TAP_CONFIG1_TICSTH_MASK, raw));
 	if (ret)
 		return ret;
 
@@ -449,13 +449,13 @@ static int bma400_get_accel_reg(struct bma400_data *data,
 
 	switch (chan->channel2) {
 	case IIO_MOD_X:
-		lsb_reg = BMA400_X_AXIS_LSB_REG;
+		lsb_reg = BMA400_ACC_X_LSB_REG;
 		break;
 	case IIO_MOD_Y:
-		lsb_reg = BMA400_Y_AXIS_LSB_REG;
+		lsb_reg = BMA400_ACC_Y_LSB_REG;
 		break;
 	case IIO_MOD_Z:
-		lsb_reg = BMA400_Z_AXIS_LSB_REG;
+		lsb_reg = BMA400_ACC_Z_LSB_REG;
 		break;
 	default:
 		dev_err(data->dev, "invalid axis channel modifier\n");
@@ -475,8 +475,8 @@ static int bma400_get_accel_reg(struct bma400_data *data,
 static void bma400_output_data_rate_from_raw(int raw, unsigned int *val,
 					     unsigned int *val2)
 {
-	*val = BMA400_ACC_ODR_MAX_HZ >> (BMA400_ACC_ODR_MAX_RAW - raw);
-	if (raw > BMA400_ACC_ODR_MIN_RAW)
+	*val = BMA400_ACC_CONFIG1_ODR_MAX_HZ >> (BMA400_ACC_CONFIG1_ODR_MAX_RAW - raw);
+	if (raw > BMA400_ACC_CONFIG1_ODR_MIN_RAW)
 		*val2 = 0;
 	else
 		*val2 = 500000;
@@ -494,7 +494,7 @@ static int bma400_get_accel_output_data_rate(struct bma400_data *data)
 		 * Runs at a fixed rate in low-power mode. See section 4.3
 		 * in the datasheet.
 		 */
-		bma400_output_data_rate_from_raw(BMA400_ACC_ODR_LP_RAW,
+		bma400_output_data_rate_from_raw(BMA400_ACC_CONFIG1_ODR_LP_RAW,
 						 &data->sample_freq.hz,
 						 &data->sample_freq.uhz);
 		return 0;
@@ -507,9 +507,9 @@ static int bma400_get_accel_output_data_rate(struct bma400_data *data)
 		if (ret)
 			goto error;
 
-		odr = val & BMA400_ACC_ODR_MASK;
-		if (odr < BMA400_ACC_ODR_MIN_RAW ||
-		    odr > BMA400_ACC_ODR_MAX_RAW) {
+		odr = val & BMA400_ACC_CONFIG1_ODR_MASK;
+		if (odr < BMA400_ACC_CONFIG1_ODR_MIN_RAW ||
+		    odr > BMA400_ACC_CONFIG1_ODR_MAX_RAW) {
 			ret = -EINVAL;
 			goto error;
 		}
@@ -539,19 +539,19 @@ static int bma400_set_accel_output_data_rate(struct bma400_data *data,
 	unsigned int val;
 	int ret;
 
-	if (hz >= BMA400_ACC_ODR_MIN_WHOLE_HZ) {
-		if (uhz || hz > BMA400_ACC_ODR_MAX_HZ)
+	if (hz >= BMA400_ACC_CONFIG1_ODR_MIN_WHOLE_HZ) {
+		if (uhz || hz > BMA400_ACC_CONFIG1_ODR_MAX_HZ)
 			return -EINVAL;
 
 		/* Note this works because MIN_WHOLE_HZ is odd */
 		idx = __ffs(hz);
 
-		if (hz >> idx != BMA400_ACC_ODR_MIN_WHOLE_HZ)
+		if (hz >> idx != BMA400_ACC_CONFIG1_ODR_MIN_WHOLE_HZ)
 			return -EINVAL;
 
-		idx += BMA400_ACC_ODR_MIN_RAW + 1;
-	} else if (hz == BMA400_ACC_ODR_MIN_HZ && uhz == 500000) {
-		idx = BMA400_ACC_ODR_MIN_RAW;
+		idx += BMA400_ACC_CONFIG1_ODR_MIN_RAW + 1;
+	} else if (hz == BMA400_ACC_CONFIG1_ODR_MIN_HZ && uhz == 500000) {
+		idx = BMA400_ACC_CONFIG1_ODR_MIN_RAW;
 	} else {
 		return -EINVAL;
 	}
@@ -561,7 +561,7 @@ static int bma400_set_accel_output_data_rate(struct bma400_data *data,
 		return ret;
 
 	/* preserve the range and normal mode osr */
-	odr = (~BMA400_ACC_ODR_MASK & val) | idx;
+	odr = (~BMA400_ACC_CONFIG1_ODR_MASK & val) | idx;
 
 	ret = regmap_write(data->regmap, BMA400_ACC_CONFIG1_REG, odr);
 	if (ret)
@@ -592,7 +592,7 @@ static int bma400_get_accel_oversampling_ratio(struct bma400_data *data)
 			return ret;
 		}
 
-		osr = (val & BMA400_LP_OSR_MASK) >> BMA400_LP_OSR_SHIFT;
+		osr = (val & BMA400_ACC_CONFIG0_LP_OSR_MASK) >> BMA400_LP_OSR_SHIFT;
 
 		data->oversampling_ratio = osr;
 		return 0;
@@ -603,7 +603,7 @@ static int bma400_get_accel_oversampling_ratio(struct bma400_data *data)
 			return ret;
 		}
 
-		osr = (val & BMA400_NP_OSR_MASK) >> BMA400_NP_OSR_SHIFT;
+		osr = (val & BMA400_ACC_CONFIG1_NP_OSR_MASK) >> BMA400_NP_OSR_SHIFT;
 
 		data->oversampling_ratio = osr;
 		return 0;
@@ -637,7 +637,7 @@ static int bma400_set_accel_oversampling_ratio(struct bma400_data *data,
 			return ret;
 
 		ret = regmap_write(data->regmap, BMA400_ACC_CONFIG0_REG,
-				   (acc_config & ~BMA400_LP_OSR_MASK) |
+				   (acc_config & ~BMA400_ACC_CONFIG0_LP_OSR_MASK) |
 				   (val << BMA400_LP_OSR_SHIFT));
 		if (ret) {
 			dev_err(data->dev, "Failed to write out OSR\n");
@@ -653,7 +653,7 @@ static int bma400_set_accel_oversampling_ratio(struct bma400_data *data,
 			return ret;
 
 		ret = regmap_write(data->regmap, BMA400_ACC_CONFIG1_REG,
-				   (acc_config & ~BMA400_NP_OSR_MASK) |
+				   (acc_config & ~BMA400_ACC_CONFIG1_NP_OSR_MASK) |
 				   (val << BMA400_NP_OSR_SHIFT));
 		if (ret) {
 			dev_err(data->dev, "Failed to write out OSR\n");
@@ -679,7 +679,7 @@ static int bma400_accel_scale_to_raw(struct bma400_data *data,
 	/* Note this works because BMA400_SCALE_MIN is odd */
 	raw = __ffs(val);
 
-	if (val >> raw != BMA400_SCALE_MIN)
+	if (val >> raw != BMA400_ACC_SCALE_MIN)
 		return -EINVAL;
 
 	return raw;
@@ -695,11 +695,11 @@ static int bma400_get_accel_scale(struct bma400_data *data)
 	if (ret)
 		return ret;
 
-	raw_scale = (val & BMA400_ACC_SCALE_MASK) >> BMA400_SCALE_SHIFT;
+	raw_scale = (val & BMA400_ACC_CONFIG1_ACC_RANGE_MASK) >> BMA400_ACC_RANGE_SHIFT;
 	if (raw_scale > BMA400_TWO_BITS_MASK)
 		return -EINVAL;
 
-	data->scale = BMA400_SCALE_MIN << raw_scale;
+	data->scale = BMA400_ACC_SCALE_MIN << raw_scale;
 
 	return 0;
 }
@@ -719,8 +719,8 @@ static int bma400_set_accel_scale(struct bma400_data *data, unsigned int val)
 		return raw;
 
 	ret = regmap_write(data->regmap, BMA400_ACC_CONFIG1_REG,
-			   (acc_config & ~BMA400_ACC_SCALE_MASK) |
-			   (raw << BMA400_SCALE_SHIFT));
+			   (acc_config & ~BMA400_ACC_CONFIG1_ACC_RANGE_MASK) |
+			   (raw << BMA400_ACC_RANGE_SHIFT));
 	if (ret)
 		return ret;
 
@@ -786,8 +786,8 @@ static int bma400_enable_steps(struct bma400_data *data, int val)
 		return 0;
 
 	ret = regmap_update_bits(data->regmap, BMA400_INT_CONFIG1_REG,
-				 BMA400_STEP_INT_MSK,
-				 FIELD_PREP(BMA400_STEP_INT_MSK, val ? 1 : 0));
+				 BMA400_INT_CONFIG1_STEP_INT_MASK,
+				 FIELD_PREP(BMA400_INT_CONFIG1_STEP_INT_MASK, val ? 1 : 0));
 	if (ret)
 		return ret;
 	data->steps_enabled = val;
@@ -826,7 +826,7 @@ static void bma400_init_tables(void)
 	for (i = 0; i + 1 < ARRAY_SIZE(bma400_scales); i += 2) {
 		raw = i / 2;
 		bma400_scales[i] = 0;
-		bma400_scales[i + 1] = BMA400_SCALE_MIN << raw;
+		bma400_scales[i + 1] = BMA400_ACC_SCALE_MIN << raw;
 	}
 }
 
@@ -1063,7 +1063,7 @@ static int bma400_write_raw(struct iio_dev *indio_dev,
 		return ret;
 	case IIO_CHAN_INFO_SCALE:
 		if (val != 0 ||
-		    val2 < BMA400_SCALE_MIN || val2 > BMA400_SCALE_MAX)
+		    val2 < BMA400_ACC_SCALE_MIN || val2 > BMA400_ACC_SCALE_MAX)
 			return -EINVAL;
 
 		mutex_lock(&data->mutex);
@@ -1114,16 +1114,16 @@ static int bma400_read_event_config(struct iio_dev *indio_dev,
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
-			return FIELD_GET(BMA400_S_TAP_MSK,
+			return FIELD_GET(BMA400_INT_CONFIG1_S_TAP_MASK,
 					 data->tap_event_en_bitmask);
 		case IIO_EV_DIR_DOUBLETAP:
-			return FIELD_GET(BMA400_D_TAP_MSK,
+			return FIELD_GET(BMA400_INT_CONFIG1_D_TAP_MASK,
 					 data->tap_event_en_bitmask);
 		default:
 			return -EINVAL;
@@ -1146,8 +1146,8 @@ static int bma400_steps_event_enable(struct bma400_data *data, int state)
 		return ret;
 
 	ret = regmap_update_bits(data->regmap, BMA400_INT12_MAP_REG,
-				 BMA400_STEP_INT_MSK,
-				 FIELD_PREP(BMA400_STEP_INT_MSK,
+				 BMA400_INT_CONFIG1_STEP_INT_MASK,
+				 FIELD_PREP(BMA400_INT_CONFIG1_STEP_INT_MASK,
 					    state));
 	if (ret)
 		return ret;
@@ -1164,18 +1164,18 @@ static int bma400_activity_event_en(struct bma400_data *data,
 
 	switch (dir) {
 	case IIO_EV_DIR_RISING:
-		reg = BMA400_GEN1INT_CONFIG0;
-		msk = BMA400_INT_GEN1_MSK;
+		reg = BMA400_GEN1INT_CONFIG0_REG;
+		msk = BMA400_INT_CONFIG0_GEN1_MASK;
 		value = 2;
-		set_mask_bits(&field_value, BMA400_INT_GEN1_MSK,
-			      FIELD_PREP(BMA400_INT_GEN1_MSK, state));
+		set_mask_bits(&field_value, BMA400_INT_CONFIG0_GEN1_MASK,
+			      FIELD_PREP(BMA400_INT_CONFIG0_GEN1_MASK, state));
 		break;
 	case IIO_EV_DIR_FALLING:
-		reg = BMA400_GEN2INT_CONFIG0;
-		msk = BMA400_INT_GEN2_MSK;
+		reg = BMA400_GEN2INT_CONFIG0_REG;
+		msk = BMA400_INT_CONFIG0_GEN2_MASK;
 		value = 0;
-		set_mask_bits(&field_value, BMA400_INT_GEN2_MSK,
-			      FIELD_PREP(BMA400_INT_GEN2_MSK, state));
+		set_mask_bits(&field_value, BMA400_INT_CONFIG0_GEN2_MASK,
+			      FIELD_PREP(BMA400_INT_CONFIG0_GEN2_MASK, state));
 		break;
 	default:
 		return -EINVAL;
@@ -1240,21 +1240,21 @@ static int bma400_tap_event_en(struct bma400_data *data,
 	}
 
 	ret = regmap_update_bits(data->regmap, BMA400_INT12_MAP_REG,
-				 BMA400_S_TAP_MSK,
-				 FIELD_PREP(BMA400_S_TAP_MSK, state));
+				 BMA400_INT_CONFIG1_S_TAP_MASK,
+				 FIELD_PREP(BMA400_INT_CONFIG1_S_TAP_MASK, state));
 	if (ret)
 		return ret;
 
 	switch (dir) {
 	case IIO_EV_DIR_SINGLETAP:
-		mask = BMA400_S_TAP_MSK;
-		set_mask_bits(&field_value, BMA400_S_TAP_MSK,
-			      FIELD_PREP(BMA400_S_TAP_MSK, state));
+		mask = BMA400_INT_CONFIG1_S_TAP_MASK;
+		set_mask_bits(&field_value, BMA400_INT_CONFIG1_S_TAP_MASK,
+			      FIELD_PREP(BMA400_INT_CONFIG1_S_TAP_MASK, state));
 		break;
 	case IIO_EV_DIR_DOUBLETAP:
-		mask = BMA400_D_TAP_MSK;
-		set_mask_bits(&field_value, BMA400_D_TAP_MSK,
-			      FIELD_PREP(BMA400_D_TAP_MSK, state));
+		mask = BMA400_INT_CONFIG1_D_TAP_MASK;
+		set_mask_bits(&field_value, BMA400_INT_CONFIG1_D_TAP_MASK,
+			      FIELD_PREP(BMA400_INT_CONFIG1_D_TAP_MASK, state));
 		break;
 	default:
 		return -EINVAL;
@@ -1340,9 +1340,9 @@ static int get_gen_config_reg(enum iio_event_direction dir)
 {
 	switch (dir) {
 	case IIO_EV_DIR_FALLING:
-		return BMA400_GEN2INT_CONFIG0;
+		return BMA400_GEN2INT_CONFIG0_REG;
 	case IIO_EV_DIR_RISING:
-		return BMA400_GEN1INT_CONFIG0;
+		return BMA400_GEN1INT_CONFIG0_REG;
 	default:
 		return -EINVAL;
 	}
@@ -1393,7 +1393,7 @@ static int bma400_read_event_value(struct iio_dev *indio_dev,
 			ret = regmap_read(data->regmap, reg, val);
 			if (ret)
 				return ret;
-			*val = FIELD_GET(BMA400_GEN_HYST_MSK, *val);
+			*val = FIELD_GET(BMA400_GENINT_CONFIG0_HYST_MASK, *val);
 			return IIO_VAL_INT;
 		default:
 			return -EINVAL;
@@ -1401,30 +1401,30 @@ static int bma400_read_event_value(struct iio_dev *indio_dev,
 	case IIO_EV_TYPE_GESTURE:
 		switch (info) {
 		case IIO_EV_INFO_VALUE:
-			ret = regmap_read(data->regmap, BMA400_TAP_CONFIG,
+			ret = regmap_read(data->regmap, BMA400_TAP_CONFIG_REG,
 					  &reg_val);
 			if (ret)
 				return ret;
 
-			*val = FIELD_GET(BMA400_TAP_SEN_MSK, reg_val);
+			*val = FIELD_GET(BMA400_TAP_CONFIG_SEN_MASK, reg_val);
 			return IIO_VAL_INT;
 		case IIO_EV_INFO_RESET_TIMEOUT:
-			ret = regmap_read(data->regmap, BMA400_TAP_CONFIG1,
+			ret = regmap_read(data->regmap, BMA400_TAP_CONFIG1_REG,
 					  &reg_val);
 			if (ret)
 				return ret;
 
-			raw = FIELD_GET(BMA400_TAP_QUIET_MSK, reg_val);
+			raw = FIELD_GET(BMA400_TAP_CONFIG1_QUIET_MASK, reg_val);
 			*val = 0;
 			*val2 = tap_reset_timeout[raw];
 			return IIO_VAL_INT_PLUS_MICRO;
 		case IIO_EV_INFO_TAP2_MIN_DELAY:
-			ret = regmap_read(data->regmap, BMA400_TAP_CONFIG1,
+			ret = regmap_read(data->regmap, BMA400_TAP_CONFIG1_REG,
 					  &reg_val);
 			if (ret)
 				return ret;
 
-			raw = FIELD_GET(BMA400_TAP_QUIETDT_MSK, reg_val);
+			raw = FIELD_GET(BMA400_TAP_CONFIG1_QUIETDT_MASK, reg_val);
 			*val = 0;
 			*val2 = double_tap2_min_delay[raw];
 			return IIO_VAL_INT_PLUS_MICRO;
@@ -1480,8 +1480,8 @@ static int bma400_write_event_value(struct iio_dev *indio_dev,
 				return -EINVAL;
 
 			return regmap_update_bits(data->regmap, reg,
-						  BMA400_GEN_HYST_MSK,
-						  FIELD_PREP(BMA400_GEN_HYST_MSK,
+						  BMA400_GENINT_CONFIG0_HYST_MASK,
+						  FIELD_PREP(BMA400_GENINT_CONFIG0_HYST_MASK,
 							     val));
 		default:
 			return -EINVAL;
@@ -1493,9 +1493,9 @@ static int bma400_write_event_value(struct iio_dev *indio_dev,
 				return -EINVAL;
 
 			return regmap_update_bits(data->regmap,
-						  BMA400_TAP_CONFIG,
-						  BMA400_TAP_SEN_MSK,
-						  FIELD_PREP(BMA400_TAP_SEN_MSK,
+						  BMA400_TAP_CONFIG_REG,
+						  BMA400_TAP_CONFIG_SEN_MASK,
+						  FIELD_PREP(BMA400_TAP_CONFIG_SEN_MASK,
 							     val));
 		case IIO_EV_INFO_RESET_TIMEOUT:
 			raw = usec_to_tapreg_raw(val2, tap_reset_timeout);
@@ -1503,9 +1503,9 @@ static int bma400_write_event_value(struct iio_dev *indio_dev,
 				return -EINVAL;
 
 			return regmap_update_bits(data->regmap,
-						  BMA400_TAP_CONFIG1,
-						  BMA400_TAP_QUIET_MSK,
-						  FIELD_PREP(BMA400_TAP_QUIET_MSK,
+						  BMA400_TAP_CONFIG1_REG,
+						  BMA400_TAP_CONFIG1_QUIET_MASK,
+						  FIELD_PREP(BMA400_TAP_CONFIG1_QUIET_MASK,
 							     raw));
 		case IIO_EV_INFO_TAP2_MIN_DELAY:
 			raw = usec_to_tapreg_raw(val2, double_tap2_min_delay);
@@ -1513,9 +1513,9 @@ static int bma400_write_event_value(struct iio_dev *indio_dev,
 				return -EINVAL;
 
 			return regmap_update_bits(data->regmap,
-						  BMA400_TAP_CONFIG1,
-						  BMA400_TAP_QUIETDT_MSK,
-						  FIELD_PREP(BMA400_TAP_QUIETDT_MSK,
+						  BMA400_TAP_CONFIG1_REG,
+						  BMA400_TAP_CONFIG1_QUIETDT_MASK,
+						  FIELD_PREP(BMA400_TAP_CONFIG1_QUIETDT_MASK,
 							     raw));
 		default:
 			return -EINVAL;
@@ -1533,14 +1533,14 @@ static int bma400_data_rdy_trigger_set_state(struct iio_trigger *trig,
 	int ret;
 
 	ret = regmap_update_bits(data->regmap, BMA400_INT_CONFIG0_REG,
-				 BMA400_INT_DRDY_MSK,
-				 FIELD_PREP(BMA400_INT_DRDY_MSK, state));
+				 BMA400_INT_CONFIG0_DRDY_MASK,
+				 FIELD_PREP(BMA400_INT_CONFIG0_DRDY_MASK, state));
 	if (ret)
 		return ret;
 
 	return regmap_update_bits(data->regmap, BMA400_INT1_MAP_REG,
-				  BMA400_INT_DRDY_MSK,
-				  FIELD_PREP(BMA400_INT_DRDY_MSK, state));
+				  BMA400_INT_CONFIG0_DRDY_MASK,
+				  FIELD_PREP(BMA400_INT_CONFIG0_DRDY_MASK, state));
 }
 
 static const unsigned long bma400_avail_scan_masks[] = {
@@ -1578,7 +1578,7 @@ static irqreturn_t bma400_trigger_handler(int irq, void *p)
 	mutex_lock(&data->mutex);
 
 	/* bulk read six registers, with the base being the LSB register */
-	ret = regmap_bulk_read(data->regmap, BMA400_X_AXIS_LSB_REG,
+	ret = regmap_bulk_read(data->regmap, BMA400_ACC_X_LSB_REG,
 			       &data->buffer.buff, sizeof(data->buffer.buff));
 	if (ret)
 		goto unlock_err;
@@ -1628,13 +1628,13 @@ static irqreturn_t bma400_interrupt(int irq, void *private)
 	 * Disable all advance interrupts if interrupt engine overrun occurs.
 	 * See section 4.7 "Interrupt engine overrun" in datasheet v1.2.
 	 */
-	if (FIELD_GET(BMA400_INT_ENG_OVRUN_MSK, le16_to_cpu(data->status))) {
+	if (FIELD_GET(BMA400_INT_STAT_ENG_OVRRUN_MASK, le16_to_cpu(data->status))) {
 		bma400_disable_adv_interrupt(data);
 		dev_err(data->dev, "Interrupt engine overrun\n");
 		goto unlock_err;
 	}
 
-	if (FIELD_GET(BMA400_INT_S_TAP_MSK, le16_to_cpu(data->status)))
+	if (FIELD_GET(BMA400_INT_STAT1_S_TAP_MASK, le16_to_cpu(data->status)))
 		iio_push_event(indio_dev,
 			       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
 						  IIO_MOD_X_OR_Y_OR_Z,
@@ -1642,7 +1642,7 @@ static irqreturn_t bma400_interrupt(int irq, void *private)
 						  IIO_EV_DIR_SINGLETAP),
 			       timestamp);
 
-	if (FIELD_GET(BMA400_INT_D_TAP_MSK, le16_to_cpu(data->status)))
+	if (FIELD_GET(BMA400_INT_STAT1_D_TAP_MASK, le16_to_cpu(data->status)))
 		iio_push_event(indio_dev,
 			       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
 						  IIO_MOD_X_OR_Y_OR_Z,
@@ -1650,10 +1650,10 @@ static irqreturn_t bma400_interrupt(int irq, void *private)
 						  IIO_EV_DIR_DOUBLETAP),
 			       timestamp);
 
-	if (FIELD_GET(BMA400_INT_GEN1_MSK, le16_to_cpu(data->status)))
+	if (FIELD_GET(BMA400_INT_STAT0_GEN1_MASK, le16_to_cpu(data->status)))
 		ev_dir = IIO_EV_DIR_RISING;
 
-	if (FIELD_GET(BMA400_INT_GEN2_MSK, le16_to_cpu(data->status)))
+	if (FIELD_GET(BMA400_INT_STAT0_GEN2_MASK, le16_to_cpu(data->status)))
 		ev_dir = IIO_EV_DIR_FALLING;
 
 	if (ev_dir != IIO_EV_DIR_NONE) {
@@ -1664,7 +1664,7 @@ static irqreturn_t bma400_interrupt(int irq, void *private)
 			       timestamp);
 	}
 
-	if (FIELD_GET(BMA400_STEP_STAT_MASK, le16_to_cpu(data->status))) {
+	if (FIELD_GET(BMA400_INT_STAT1_STEP_INT_MASK, le16_to_cpu(data->status))) {
 		iio_push_event(indio_dev,
 			       IIO_MOD_EVENT_CODE(IIO_STEPS, 0, IIO_NO_MOD,
 						  IIO_EV_TYPE_CHANGE,
@@ -1686,7 +1686,7 @@ static irqreturn_t bma400_interrupt(int irq, void *private)
 		}
 	}
 
-	if (FIELD_GET(BMA400_INT_DRDY_MSK, le16_to_cpu(data->status))) {
+	if (FIELD_GET(BMA400_INT_STAT0_DRDY_MASK, le16_to_cpu(data->status))) {
 		mutex_unlock(&data->mutex);
 		iio_trigger_poll_nested(data->trig);
 		return IRQ_HANDLED;
-- 
2.43.0


