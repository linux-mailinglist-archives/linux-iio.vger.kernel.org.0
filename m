Return-Path: <linux-iio+bounces-24791-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B440BC043F
	for <lists+linux-iio@lfdr.de>; Tue, 07 Oct 2025 07:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AD8E834B0DC
	for <lists+linux-iio@lfdr.de>; Tue,  7 Oct 2025 05:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F80D22370A;
	Tue,  7 Oct 2025 05:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZsIoFUA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB60D21FF38
	for <linux-iio@vger.kernel.org>; Tue,  7 Oct 2025 05:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759816536; cv=none; b=Tnfv8VD6XninirsqMpJPfx3LuZ8WS8f9PgWsGN15o6FX3tp0LiDMabX13mjcHHSLzaX9pfsdV5FKfNlTjwpFB4lbIoaoQacXu1kwtxk86R3dA3L0ujDFTREH47FA46Gh+Uy5pXeBQd4ECJhIaNlzqQU1iIvHV2ZzvnJYhfDoPGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759816536; c=relaxed/simple;
	bh=ZeuZdARXiHTymxE1JlTUOp5nSPhm3AOcEAYBoYJnaes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J0UhrcG/UW1PhgD1RymjfIdwtBe7wQSZVGHwsEd+TGnaDtQNdJlS6mekFs0vXqSPl6sLVJmNrotyll0xF2otOUPteEzPCwoSf/CBkkU9rtKU7dYqs/ABfa5CDNUFHEJ1GRHLpm52u5JnEACxawPz8mmtiZ5b8z+lKeYH82qAb0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jZsIoFUA; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7800ff158d5so4922909b3a.1
        for <linux-iio@vger.kernel.org>; Mon, 06 Oct 2025 22:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759816534; x=1760421334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0X1+1j7EZByUZ/MjMj/zCkGEHjVnb1pL8CqUc0voxw4=;
        b=jZsIoFUAzHrvZbS9/rDo1YhiW4EggRtba6uCUYnrVRkayym4mDqZOeRhTOATOWJboz
         I7gIweixT93Aa7ybwFdfFx5EDTEnvoMg4RQDSeiPvGqNnNXQ7WvWY93hZKh3puzEZJ41
         iFe3iqn62dzoM6fojc/i56EjL3ryMy5piP+6Phxh2K7ocVRP8ya5PGCUH4ABmB63xz7Y
         DbNK0pirzIUAK1OAoL9wYdgVzVh+6SOgqL5zT6ITZd/ccijx8OljPw92NFUm9v3K8rXl
         I8eEKvJGVfr61ZjvzWt34Z5TQRRLIBFUck2wkjRDIWFgCZO07iSfUZOve0bACrobnsie
         1vrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759816534; x=1760421334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0X1+1j7EZByUZ/MjMj/zCkGEHjVnb1pL8CqUc0voxw4=;
        b=IQDMDCa9QQFofo6hxglWW29AyUofpT7Ji/CKuXonuEJBQfmK80AAt/qFk1fecpaXy7
         H34t+yKlsb7IWBsWcD9eLS6TtvfoTbClNqELvNdTjqemhqDDTmau712RijnWzVji+Lxm
         H5F9Snx+QDSZWDLrPkoEQ9D1htf0PgTcZHPaEUr+2rJQ5xomHyDD8tD9ajLpBdxxQZXq
         pCGvcp1raHKdojhypEhRg/m3o+gGC1/PxTpCK+dOGUnZmZmqLeqvKF3ksJQHb5Qk3+9q
         0jyOHLqgiksfoSLVlNk5gE7O59u7BLhxnG+tX/epWbtqg/LxhcPHuXTO+zrBCs1TJqL0
         IRrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJv/h6I++medxoW5qvLJjR6MRwhkK48uIxxcr8UuuORCtARNJuw2xS8AehVfeu9+VGluDF1asrq1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIxI92cbeN9mhjSRU2kocqJzcUFMiE5DRa3BiK1TvCmf26sikV
	TcK0iOaM0lsaoJQ+Gx82wm1FfHsBCxY83k0t7qjVA+Ul41tanDfvVNeV
X-Gm-Gg: ASbGncsDuCze9pgPxoF73wueF87oZCa+kLVVOe1Q1hHHFGAoKCbbWC3MoJazPhURT1C
	kle5rGDSydDB507i8dUn+l/nRGUNqKSpYcDR8hgXl3+ucbYn/Gl6fRpyQA17Nrq4xcgPHykbZOk
	APGmT85JV+YY0R8F8dQfiiV9Q/XS9cIJI+YfiCynKgN9+AfPo1hp9Dt+UvBrtGI/fG7aNxl0zQH
	tZuxv0lAyLhrb5xlntv6JXNtCt6U4JW4V+436rBKXrMCXgIR9XIXXM5biK0IRKLou8dl2MvNV32
	+zzBBWiTT/3060pEl4ukr+Fc6IvGAMShx9f0I02S/pSLlQXcWhFuXdcvJSF47Q7e8dCV+dn6Vdf
	IQ3pGt1j0l9KqV84GHXKrBC1xkDkeeFVDUA+EjbzdGbw1ubsFVwz2/xJs
X-Google-Smtp-Source: AGHT+IHSS//6jn631H9SIMTuLsvPZlhi2waQ0tfsUdXJNWA75Dgnd2jEdLw04ZD5wYBDEl3kfzmYmg==
X-Received: by 2002:a05:6a21:e083:b0:253:1e04:4e8 with SMTP id adf61e73a8af0-32b62107fcdmr20491457637.56.1759816533863;
        Mon, 06 Oct 2025 22:55:33 -0700 (PDT)
Received: from akshayaj-lenovo.. ([223.233.78.22])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339c4a1a9e8sm12983829a91.11.2025.10.06.22.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 22:55:33 -0700 (PDT)
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
Subject: [PATCH v4 2/6] iio: accel: bma400: Use macros for generic event configuration values
Date: Tue,  7 Oct 2025 11:25:02 +0530
Message-ID: <20251007055511.108984-3-akshayaj.lkd@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007055511.108984-1-akshayaj.lkd@gmail.com>
References: <20251007055511.108984-1-akshayaj.lkd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add macros and enums for configuration values used in generic event
handling for activity and inactivity detection. Replace hard-coded
values in activity_event_en() with the new definitions to make the
configuration explicit.

No functional changes are intended.

Signed-off-by: Akshay Jindal <akshayaj.lkd@gmail.com>
---

Changes since v3:
- Assigned explicit values to reg field enums introduced.

 drivers/iio/accel/bma400.h      | 30 ++++++++++++++++++++++++++++++
 drivers/iio/accel/bma400_core.c | 14 +++++++++++---
 2 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
index ae3411c090c9..60fc323958f3 100644
--- a/drivers/iio/accel/bma400.h
+++ b/drivers/iio/accel/bma400.h
@@ -106,8 +106,38 @@
 #define BMA400_GEN1INT_CONFIG0_REG      0x3f
 #define BMA400_GEN2INT_CONFIG0_REG      0x4A
 #define BMA400_GENINT_CONFIG0_HYST_MASK		GENMASK(1, 0)
+#define BMA400_GENINT_CONFIG0_REF_UPD_MODE_MASK	GENMASK(3, 2)
+#define BMA400_GENINT_CONFIG0_DATA_SRC_MASK	BIT(4)
+#define BMA400_GENINT_CONFIG0_X_EN_MASK		BIT(5)
+#define BMA400_GENINT_CONFIG0_Y_EN_MASK		BIT(6)
+#define BMA400_GENINT_CONFIG0_Z_EN_MASK		BIT(7)
+
+enum bma400_accel_data_src {
+	ACCEL_FILT1 = 0x0,
+	ACCEL_FILT2 = 0x1,
+};
+
+enum bma400_ref_updt_mode {
+	BMA400_REF_MANUAL_UPDT_MODE = 0x0,
+	BMA400_REF_ONETIME_UPDT_MODE = 0x1,
+	BMA400_REF_EVERYTIME_UPDT_MODE = 0x2,
+	BMA400_REF_EVERYTIME_LP_UPDT_MODE = 0x3,
+};
 
 #define BMA400_GEN_CONFIG1_OFF      0x01
+#define BMA400_GENINT_CONFIG1_AXES_COMB_MASK	BIT(0)
+#define BMA400_GENINT_CONFIG1_DETCT_CRIT_MASK	BIT(1)
+
+enum bma400_genintr_acceleval_axescomb {
+	BMA400_EVAL_X_OR_Y_OR_Z = 0x0,
+	BMA400_EVAL_X_AND_Y_AND_Z = 0x1,
+};
+
+enum bma400_detect_criterion {
+	BMA400_DETECT_INACTIVITY = 0x0,
+	BMA400_DETECT_ACTIVITY = 0x1,
+};
+
 #define BMA400_GEN_CONFIG2_OFF      0x02
 #define BMA400_GEN_CONFIG3_OFF      0x03
 #define BMA400_GEN_CONFIG31_OFF     0x04
diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
index 35d2b90425f8..58c378ba9931 100644
--- a/drivers/iio/accel/bma400_core.c
+++ b/drivers/iio/accel/bma400_core.c
@@ -1166,14 +1166,16 @@ static int bma400_activity_event_en(struct bma400_data *data,
 	case IIO_EV_DIR_RISING:
 		reg = BMA400_GEN1INT_CONFIG0_REG;
 		msk = BMA400_INT_CONFIG0_GEN1_MASK;
-		value = 2;
+		value = FIELD_PREP(BMA400_GENINT_CONFIG1_AXES_COMB_MASK, BMA400_EVAL_X_OR_Y_OR_Z) |
+			FIELD_PREP(BMA400_GENINT_CONFIG1_DETCT_CRIT_MASK, BMA400_DETECT_ACTIVITY);
 		set_mask_bits(&field_value, BMA400_INT_CONFIG0_GEN1_MASK,
 			      FIELD_PREP(BMA400_INT_CONFIG0_GEN1_MASK, state));
 		break;
 	case IIO_EV_DIR_FALLING:
 		reg = BMA400_GEN2INT_CONFIG0_REG;
 		msk = BMA400_INT_CONFIG0_GEN2_MASK;
-		value = 0;
+		value = FIELD_PREP(BMA400_GENINT_CONFIG1_AXES_COMB_MASK, BMA400_EVAL_X_OR_Y_OR_Z) |
+			FIELD_PREP(BMA400_GENINT_CONFIG1_DETCT_CRIT_MASK, BMA400_DETECT_INACTIVITY);
 		set_mask_bits(&field_value, BMA400_INT_CONFIG0_GEN2_MASK,
 			      FIELD_PREP(BMA400_INT_CONFIG0_GEN2_MASK, state));
 		break;
@@ -1182,7 +1184,13 @@ static int bma400_activity_event_en(struct bma400_data *data,
 	}
 
 	/* Enabling all axis for interrupt evaluation */
-	ret = regmap_write(data->regmap, reg, 0xF8);
+	ret = regmap_write(data->regmap, reg,
+			   BMA400_GENINT_CONFIG0_X_EN_MASK |
+			   BMA400_GENINT_CONFIG0_Y_EN_MASK |
+			   BMA400_GENINT_CONFIG0_Z_EN_MASK|
+			   FIELD_PREP(BMA400_GENINT_CONFIG0_DATA_SRC_MASK, ACCEL_FILT2)|
+			   FIELD_PREP(BMA400_GENINT_CONFIG0_REF_UPD_MODE_MASK,
+				      BMA400_REF_EVERYTIME_UPDT_MODE));
 	if (ret)
 		return ret;
 
-- 
2.43.0


