Return-Path: <linux-iio+bounces-25001-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDC9BD0945
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 20:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 802593BC41B
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 18:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6AA2F1FDF;
	Sun, 12 Oct 2025 18:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCkPNs84"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCAB2F066A
	for <linux-iio@vger.kernel.org>; Sun, 12 Oct 2025 18:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760292438; cv=none; b=fLUwJkYUIKnQVGAaRsXzwLxLnkR/ZsMlob9vs/zY4vflwVTIKda99/fjUsowqoe/W20zqudC1cbyFrDxbMOM+rQkBR1l2UQ6HbHSCZ8AHQd05TTOI4W/PW3u7M4pp2ohIk7bSf1oAMCvCVHFMN7124Y1yVBjliKpyPae5Un10qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760292438; c=relaxed/simple;
	bh=m7hFlCg3kCEqX/JQPFwfTWfUr39vj84qrAodgGrxjEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SeOo0S7RCPtqdB3ZhNDuYonWLjp+A8tpzNY1sO5T08X7mdVrHF7kcp7i9xmFzMtAMHxnMPyVx1PzTRMSVwHVv596Y+Itwh+oIWHJoNozch/qkvJEb3lm8x0091O+78enKGaWrXrKZOFKxOUncNKxyQAE3WI7MGGqo8yaEMD/VZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iCkPNs84; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2698384978dso24452495ad.0
        for <linux-iio@vger.kernel.org>; Sun, 12 Oct 2025 11:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760292436; x=1760897236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eu8vg3VcSANbIaWzuLj/Mw5GdPep/60laAOsGBe3Qn0=;
        b=iCkPNs84KLvfeibIoYujAV5PnSOgtpkF2/nxiFSgGIRgHosnrZH6TSBSTt6q4QM6Fb
         QjWTyYJ2ISQsQcpGZZxotSbqwWbE5VcKFmmZA8U8bWeHNFRWorIirv8pA03xjprzkN4o
         BifhnyWSkrIIj6zVYf3IXaIshPSTMnwUpaj8fKo/9fNm+Novr+jngFB8tlok8hfSd7BL
         /dDuA+SW08qT9ycrcTpKkBrT1DhqSGEMvxP8rzruw8Qk2czB9kD2zGQtu+7rlYsCOMN/
         eVGczFxxoaxiqnbvtpXjLBwtgmGr/dTjzz5885f4sRUQNz9xxSPptCg5yUq607MYEKEe
         irQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760292436; x=1760897236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eu8vg3VcSANbIaWzuLj/Mw5GdPep/60laAOsGBe3Qn0=;
        b=I3luc4FrCQ5TIndfSCKKtEj5zqPGoZuGmuIO7FNfTQuEACCSitRpupBmnnixIBmvjP
         nl7KkFFexQtWx5Qc99L9/3SrtWMFt2fqSu1DwPVJdxevQBHil4ieNbjHTWIVjYhQrcwo
         as8lD9o9Fb5NPPjBVhVsEdKAujWMXkXTeD1A4qX2bzv9GyObS0J3ShhAB//qZHXApwS2
         CBLaVvxCSCWCpx9we2so5p6J+i38BD+mx6WFy2DQTj4J+xYtR0Rr4hAP9SvqvzfyMFOs
         HHgX2XXxmExxe0fzsrkPWl+/DCcCEsGi/sxSOOJIMfm0r+nq0sYoEqi9o3VLnFuTzMch
         mEVA==
X-Forwarded-Encrypted: i=1; AJvYcCXO/u4WmNkDaZjIWarMQwrja+ormysG/ujoUf4gL1Bq0qFPyBUlQUntj+Xqz3XSCyr6qPBB3RZknGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBIQJqi0eH346Miy/5Wj6h5lGsN70LWoxpynXMtiIsS1sJUhCY
	PcNnF23a54L7UPgtnfGXsVIH3rmiUlf68v7YYF9T7hImy0EosXTHy4R5
X-Gm-Gg: ASbGnctMJTBdmFPX0e9N3Cs2leypo1xlSlwRjMhGBSz9M/v/bgpHbIC5sJXcSzq96uP
	ZXqvsqYA/hE8wYhKgtI2gwqgIHdt21Ay1s8vgHxGVri8i37PXfIVf4PNoieIoPHZVc//khtnTjF
	k8kOknMFkFsR1q3w9bISbueiSeIeRkf7Iqk1m0RwdqTXCPboMGH4fHmgCQiNR0uFel9GoYuP3kk
	csF7InoKWwylalLCpDp9DQ2w3rBSWxQOSQZg0Pps8xRj5HJqBmbO7RAGvryRG7cdDcSsJpwsV25
	xOnke5FBL+EEgugJocutgXd4JlpkI4NEF1FYIIk11vP/hTkd0FTKColbT+XF1gtPOB9H7IttU6n
	QZR7p/AiVn3xTPU4YTGOI+l7ZmvZnjl0jKOMMYbCM0sVgc02OG00=
X-Google-Smtp-Source: AGHT+IFPZRs8NbjuxRsjqFPcahUml+X/J8bGahNqayP9NaOCV3GpwRD1Amy0L/80k/WkLGGJBDJ07g==
X-Received: by 2002:a17:902:cf41:b0:267:776b:a315 with SMTP id d9443c01a7336-290272c2019mr224101645ad.32.1760292436271;
        Sun, 12 Oct 2025 11:07:16 -0700 (PDT)
Received: from akshayaj-lenovo.. ([223.233.65.54])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f56c0fsm111734345ad.104.2025.10.12.11.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 11:07:15 -0700 (PDT)
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
Subject: [PATCH v5 4/6] iio: accel: bma400: Replace bit shifts with FIELD_PREP() and FIELD_GET()
Date: Sun, 12 Oct 2025 23:36:11 +0530
Message-ID: <20251012180619.195244-5-akshayaj.lkd@gmail.com>
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

set_* functions involve left shift of param values into respective
register fields before writing to register. Similarly get_* functions
involve right shift to extract values from the respective bit fields.
Replace these explicit shifting statements with standard kernel style
macros FIELD_GET() and FIELD_PREP().

Signed-off-by: Akshay Jindal <akshayaj.lkd@gmail.com>
---

Changes since v4:
- Modified changelog of PATCH 4/6.

 drivers/iio/accel/bma400.h      |  3 ---
 drivers/iio/accel/bma400_core.c | 12 ++++++------
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
index e2832d33862d..b5f3cac51610 100644
--- a/drivers/iio/accel/bma400.h
+++ b/drivers/iio/accel/bma400.h
@@ -75,7 +75,6 @@
  */
 #define BMA400_ACC_CONFIG0_REG		0x19
 #define BMA400_ACC_CONFIG0_LP_OSR_MASK		GENMASK(6, 5)
-#define BMA400_LP_OSR_SHIFT		5
 
 #define BMA400_ACC_CONFIG1_REG		0x1a
 #define BMA400_ACC_CONFIG1_ODR_MASK		GENMASK(3, 0)
@@ -86,9 +85,7 @@
 #define BMA400_ACC_CONFIG1_ODR_MIN_WHOLE_HZ	25
 #define BMA400_ACC_CONFIG1_ODR_MIN_HZ		12
 #define BMA400_ACC_CONFIG1_NP_OSR_MASK		GENMASK(5, 4)
-#define BMA400_NP_OSR_SHIFT		4
 #define BMA400_ACC_CONFIG1_ACC_RANGE_MASK	GENMASK(7, 6)
-#define BMA400_ACC_RANGE_SHIFT		6
 
 #define BMA400_ACC_CONFIG2_REG      0x1b
 
diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
index 42cd55fa1609..cec59d409531 100644
--- a/drivers/iio/accel/bma400_core.c
+++ b/drivers/iio/accel/bma400_core.c
@@ -627,7 +627,7 @@ static int bma400_get_accel_oversampling_ratio(struct bma400_data *data)
 			return ret;
 		}
 
-		osr = (val & BMA400_ACC_CONFIG0_LP_OSR_MASK) >> BMA400_LP_OSR_SHIFT;
+		osr = FIELD_GET(BMA400_ACC_CONFIG0_LP_OSR_MASK, val);
 
 		data->oversampling_ratio = osr;
 		return 0;
@@ -638,7 +638,7 @@ static int bma400_get_accel_oversampling_ratio(struct bma400_data *data)
 			return ret;
 		}
 
-		osr = (val & BMA400_ACC_CONFIG1_NP_OSR_MASK) >> BMA400_NP_OSR_SHIFT;
+		osr = FIELD_GET(BMA400_ACC_CONFIG1_NP_OSR_MASK, val);
 
 		data->oversampling_ratio = osr;
 		return 0;
@@ -673,7 +673,7 @@ static int bma400_set_accel_oversampling_ratio(struct bma400_data *data,
 
 		ret = regmap_write(data->regmap, BMA400_ACC_CONFIG0_REG,
 				   (acc_config & ~BMA400_ACC_CONFIG0_LP_OSR_MASK) |
-				   (val << BMA400_LP_OSR_SHIFT));
+				   FIELD_PREP(BMA400_ACC_CONFIG0_LP_OSR_MASK, val));
 		if (ret) {
 			dev_err(data->dev, "Failed to write out OSR\n");
 			return ret;
@@ -689,7 +689,7 @@ static int bma400_set_accel_oversampling_ratio(struct bma400_data *data,
 
 		ret = regmap_write(data->regmap, BMA400_ACC_CONFIG1_REG,
 				   (acc_config & ~BMA400_ACC_CONFIG1_NP_OSR_MASK) |
-				   (val << BMA400_NP_OSR_SHIFT));
+				   FIELD_PREP(BMA400_ACC_CONFIG1_NP_OSR_MASK, val));
 		if (ret) {
 			dev_err(data->dev, "Failed to write out OSR\n");
 			return ret;
@@ -730,7 +730,7 @@ static int bma400_get_accel_scale(struct bma400_data *data)
 	if (ret)
 		return ret;
 
-	raw_scale = (val & BMA400_ACC_CONFIG1_ACC_RANGE_MASK) >> BMA400_ACC_RANGE_SHIFT;
+	raw_scale = FIELD_GET(BMA400_ACC_CONFIG1_ACC_RANGE_MASK, val);
 	if (raw_scale > BMA400_TWO_BITS_MASK)
 		return -EINVAL;
 
@@ -755,7 +755,7 @@ static int bma400_set_accel_scale(struct bma400_data *data, unsigned int val)
 
 	ret = regmap_write(data->regmap, BMA400_ACC_CONFIG1_REG,
 			   (acc_config & ~BMA400_ACC_CONFIG1_ACC_RANGE_MASK) |
-			   (raw << BMA400_ACC_RANGE_SHIFT));
+			   FIELD_PREP(BMA400_ACC_CONFIG1_ACC_RANGE_MASK, raw));
 	if (ret)
 		return ret;
 
-- 
2.43.0


