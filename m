Return-Path: <linux-iio+bounces-24999-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDFFBD0939
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 20:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4C611892F2F
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 18:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615FB2F0678;
	Sun, 12 Oct 2025 18:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+hbt/Am"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96E82F0665
	for <linux-iio@vger.kernel.org>; Sun, 12 Oct 2025 18:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760292425; cv=none; b=iu6w9DPDY6XKs/y2EdKQ3GPta1UDRmQ9OOEIxO/0ad+Ve2tULyW67gtcteaQ1nwNlI81E3sXJQn2KQ9Xf/QRVKTnlhEzhFKVCaTjtZ/m2LuyIxVKwbFt7+Xz1oScTAq/r2BOWRtIpAHg0ncTX+W05YAJXdGbFGMLv1G8qC1oRd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760292425; c=relaxed/simple;
	bh=ClX01rlXMoXjKQ/J6oSs+dW0I5v1HXnoT4iu6978AV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gdJLz0wl6ORCrxkGZyS+5U5235aJjtWeMrm5vPNPLwb99kgJb4XKGXF81o/1CPeKFSdZh6DMvYj04oj8REy5Z1OO1400bJiOUmmPtsMXC72RG36LncQ9TK+WEibq5rhML6qbi2w1OayChQNpZpH8STaGlNWaVYLeNEd/tR5Aa/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a+hbt/Am; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-789fb76b466so3094522b3a.0
        for <linux-iio@vger.kernel.org>; Sun, 12 Oct 2025 11:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760292423; x=1760897223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EA5A5uOGNzPpYhd/jiWtutSSlSi/Og+euueasT4P/UE=;
        b=a+hbt/AmpbEQR3HX8az8hr6Ahj2w+ixD8/nax/XTgY7Kr2SNz6oL1CGIQrqC7xXCFu
         OYtU2XVNWwcyssBmQidbjK8KjskVR9hiDwCFlu+Q9Rjt+jSnXMzTRDBnGW2udgXK2rCG
         h5YKektL5XXCr+WaUSC2MTtD7sliqkugF7xfW17dGAaFRsEOVTplWYvVjH28Ced40Pm9
         0r6Al5vt4isFOIpXMgbXhCcoAPst9Td8E6T6yKJYKVn3DU+cEni2Gz9BMgd35auBzVHp
         pinqAyIMJUHNQw/dYt4MiGR8Nx5pohOiGNEEnJWTpXQ+m9ughYwka/md/JBKiPMIilOn
         mgaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760292423; x=1760897223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EA5A5uOGNzPpYhd/jiWtutSSlSi/Og+euueasT4P/UE=;
        b=HAx+6CgjsAh1dokyIW6rJ6r60wbCgvWZ22t34NaQRVvU888EYBdXXACR0zcckbPyMR
         xM40Zc2erqtz3CqWxtAxiRfVT5cVggPBozzY+MwFZorFNWm7ieQcGIOaCtDySSEgpmKz
         OzXIxhaSBmj4S4C03q7hMBsticZprown5JBflHbzmqWawFDb7ZiPaLJsVtbn2RoVIW2+
         EsojGMyLW708+eRbSuTW9HKBEycMRAlTefnoEDT0JPYcLMME4nLc9i8IL+rs/rdGDESz
         sxiQzvoRXWr+3B0mThw1qDqEN5Tkl5qHq4EwJkf+KYeANjeOuWZh9vkAel7kRi6C6wnZ
         2S+g==
X-Forwarded-Encrypted: i=1; AJvYcCUzZrlC766nCpiBUCSXO/9D7E+VvDVgJJsf1fPrnx+p00ak5pXkM/fvpQEyYIr0ji6AF+lYNn4MThU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRTEAjdAvP6b5JigjP/QJEcj6iXYhRAF18MLBMo6cLf7OLr3QG
	n6B4dMfwGAzSCuvz1hzCr1RK5pMn3cVtj1lAm8zpNaYg7k30djlk1QD5
X-Gm-Gg: ASbGncts2dAlYUrvlq/Xr8mTLJIBjJ6c/tJjxzJ4/UGXlsRSniVoD9iycamawcYLTD8
	2hgwefYB2pTwuKLwR1s12Aa2zKqBRxUegTf8y5MY2xURUQUjTqn3vyAxPlSq6EaPhFbRKFl4VXe
	Nd94hS7ajkPEIkE3PKVCpGBSfeOmwBgCxvWlamV72QEPzlqxGJfz77+5mlX7clsGN3FlNUaNXEN
	9pnWSL+/cHFc2CUSa9bsALzojiz2ctU6B4jk2KlHOoEE4/UsfVp/eDLjgRj4v0MTVJd34qW0aPT
	lmZ4CL7xbsN1+stvVyi5/hsv7KVR4M66G8uOeybIa89JAoJFeVCtNzbExw5yaMWqt/Yf0Hhxhc1
	yLQR3zU0uO4BALAqDaWzW+vItQ6zlmTfIV2aSjnGSrzzE7J1zK/M=
X-Google-Smtp-Source: AGHT+IFiF/Ba1DV6ZO0HpC19hA+TpwY4BxbEecfq0ewa8tmyEUIHREHyuLz2xm3GCuT7NlL4ULrsPw==
X-Received: by 2002:a17:902:d588:b0:27e:f06b:ae31 with SMTP id d9443c01a7336-290273a5f2bmr234627825ad.61.1760292422854;
        Sun, 12 Oct 2025 11:07:02 -0700 (PDT)
Received: from akshayaj-lenovo.. ([223.233.65.54])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f56c0fsm111734345ad.104.2025.10.12.11.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 11:07:02 -0700 (PDT)
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
Subject: [PATCH v5 2/6] iio: accel: bma400: Use macros for generic event configuration values
Date: Sun, 12 Oct 2025 23:36:09 +0530
Message-ID: <20251012180619.195244-3-akshayaj.lkd@gmail.com>
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
index fcafd1fba57a..12e7bf5fe647 100644
--- a/drivers/iio/accel/bma400.h
+++ b/drivers/iio/accel/bma400.h
@@ -113,8 +113,38 @@
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
index 2324c4ef645c..46855073ce3a 100644
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


