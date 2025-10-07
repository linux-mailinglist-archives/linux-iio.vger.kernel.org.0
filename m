Return-Path: <linux-iio+bounces-24793-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7339EBC0462
	for <lists+linux-iio@lfdr.de>; Tue, 07 Oct 2025 07:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6054C4F361F
	for <lists+linux-iio@lfdr.de>; Tue,  7 Oct 2025 05:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD60225760;
	Tue,  7 Oct 2025 05:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCOOXfhc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3492222C5
	for <linux-iio@vger.kernel.org>; Tue,  7 Oct 2025 05:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759816546; cv=none; b=qCUJyTnx7GxHX+uCZwDiKgmaiZhi6XmDDO34+IC0PW/i3MiRRqdRHnv8Zbob6UdGcfi9V0CIJ+Ivcraa/yVvH43pz0L1fqIp4E9Zo255u6SQSLLrz/cory/we8U5XM3l8ZKeVwllRmDd3taUem5Z08T9n6jLyFwQr5uykfDD+40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759816546; c=relaxed/simple;
	bh=Hsm386edsEgo2dKwST7fj8bp3dCE8dDU900XM/na56Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sS3Ms9bpV0FqDohMfKkRbchmbkoaDpiC6wt/A5x1uL/TwZHTPrfaFHUlVnMapX5zP4iPugwglrbJzLQ6lq8P4JRRFAmS8X8k2DJi+ogUDpRfnGiQN5TB6LoKWXek79zqlfnCyuVsN4AM3vcEKrjTEKfX2mQwoiFSpx1AAIiuGhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YCOOXfhc; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-330469eb750so6919209a91.2
        for <linux-iio@vger.kernel.org>; Mon, 06 Oct 2025 22:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759816544; x=1760421344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X4w/nd5rmbgVq820HXsBhd3BuutmUjq9o+AodC2L7+g=;
        b=YCOOXfhcydVWmXB4bmq6Id/SXSdvLtRre55JTKwAKSEfVg8T6IhuUkVFCiMfs2nyno
         AX3+1lJPRnCfkts3Cao6z3+80ogYbGlw+x5+zAiPf2Lpyz9bqmtk5gib3tkI/cRt42Gw
         59eFzid6JiSbBDt97jh76SaORwF9EvV0nq1VjGDDFerEnyk3EkXW9Bptt7hv4M8+Qaib
         Tm6eOmL+20LqCdp28aVLy7Xyd15pfS19G87x05veNfcu/Adflpj3SvErA3T7LdARzhUr
         wVtGTaYLvULo3jv46Gsrnq6jRAbKY4CcGjenTt7vpKLf/bBg8gHT/IPKJxurvk5trAmf
         23Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759816544; x=1760421344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X4w/nd5rmbgVq820HXsBhd3BuutmUjq9o+AodC2L7+g=;
        b=e2qr31J3A09pmf6QXyPkJ8k2eX4i2gMG8/TT1mQhRFaUNi3QRep7jMDGFtWaVj3sj5
         stlQG7z16yikrj+4COKDhVreiaoJBegdCPdlJvJlA6pJoeFbcvD49JPcEKy2GXxplhPR
         /d2AH2yphEaCEEx21Qs4aiRoMl9fx6G34lAPbIzrUOBKs04yQGrsIX+uYlGk92kCWnh3
         2IvAb1cXfJXs79KuyTVq5znh2Uvo7zK9bhui3Z/mz77OE1XjiyBNlAKE/Lg56RChjw1p
         S4v3ToW2mDdjcyfvHO7JccQe0SUWvd1lVZqHpb5hbOpTgGf+VVNNJb4ff7oPm7ejBbk7
         PaaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLeZLr+9ZCKEPWDyB+cc+llpivQY6m8g+AazVxjvwblv5NHEOqRbU6Ge3PI+H59jQN21KzGMRbx/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVspt80/o43Ntmx8UICXz0lvAr9myh8VbywXdP+coiFB31cY5h
	HUlM20/6o27o6qoei0T8JVWMcSwFnOM25cswRAq6/WXSpyVA/usDcP84eolmZg==
X-Gm-Gg: ASbGncut/Cz54zLq4EktOaJW/Iwaf4/675XdvDgKPYr+FsBhtdETogLsmHY3R83WjWw
	vFkONWkhKFCPaBf6hA0D7zRvU/tATbOfMZUJjrU8L78dY5iVXziLZl+gwO/yltqa+Vjkr9+X/cA
	34es58ocM6Es8LX6hKmq7+c0yK9DwqEVmdoU501mng7bGkP8time+3/vyuHeLRwx+Q3f0etfmEd
	sr6UoJelQE+45K9/PUnUf8Ulb6Xr2S3VQ78qvOqS/1d7pTCXQndTTL6LIh5S6Pgz4kxa9ZOrjxn
	rWKOVzyXPX0hI5WJ8GB8Z20SgOcWAaqCBvjFJgGUwJ4A6n6vsIjoYzDFB/QJvFZvO4USUW4Cm0Y
	hvMTX1AwNE1pKBU0R3W4SSTj4pQhUfJizUQuAuT8LVpn2kHGjVsGLmSCr/dYKj50+3tw=
X-Google-Smtp-Source: AGHT+IHGq5lnEao3EPpA/kkYQkTWiqahXKnLIaznnb1YAy69hlrybXkT66SGtfHrZHLstajCPK/4qA==
X-Received: by 2002:a17:90a:e7c2:b0:32e:9a24:2df9 with SMTP id 98e67ed59e1d1-339c2720c8amr21600122a91.14.1759816544072;
        Mon, 06 Oct 2025 22:55:44 -0700 (PDT)
Received: from akshayaj-lenovo.. ([223.233.78.22])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339c4a1a9e8sm12983829a91.11.2025.10.06.22.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 22:55:43 -0700 (PDT)
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
Subject: [PATCH v4 4/6] iio: accel: bma400: Replace bit shifts with FIELD_PREP and FIELD_GET
Date: Tue,  7 Oct 2025 11:25:04 +0530
Message-ID: <20251007055511.108984-5-akshayaj.lkd@gmail.com>
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

set_* functions involve left shift of param values into respective
register fields before writing to register. Similarly get_* functions
involve right shift to extract values from the respective bit fields.
Replace these explicit shifting statements with standard kernel style
macros FIELD_GET and FIELD_PREP.

Signed-off-by: Akshay Jindal <akshayaj.lkd@gmail.com>
---
 drivers/iio/accel/bma400.h      |  3 ---
 drivers/iio/accel/bma400_core.c | 12 ++++++------
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
index 12836111710e..d0e91481c799 100644
--- a/drivers/iio/accel/bma400.h
+++ b/drivers/iio/accel/bma400.h
@@ -68,7 +68,6 @@
  */
 #define BMA400_ACC_CONFIG0_REG		0x19
 #define BMA400_ACC_CONFIG0_LP_OSR_MASK		GENMASK(6, 5)
-#define BMA400_LP_OSR_SHIFT		5
 
 #define BMA400_ACC_CONFIG1_REG		0x1a
 #define BMA400_ACC_CONFIG1_ODR_MASK		GENMASK(3, 0)
@@ -79,9 +78,7 @@
 #define BMA400_ACC_CONFIG1_ODR_MIN_WHOLE_HZ	25
 #define BMA400_ACC_CONFIG1_ODR_MIN_HZ		12
 #define BMA400_ACC_CONFIG1_NP_OSR_MASK		GENMASK(5, 4)
-#define BMA400_NP_OSR_SHIFT		4
 #define BMA400_ACC_CONFIG1_ACC_RANGE_MASK	GENMASK(7, 6)
-#define BMA400_ACC_RANGE_SHIFT		6
 
 #define BMA400_ACC_CONFIG2_REG      0x1b
 
diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
index a0e994f9882b..665c8df93008 100644
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


