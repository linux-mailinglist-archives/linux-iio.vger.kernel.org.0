Return-Path: <linux-iio+bounces-11147-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE579AEB8F
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 18:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E69D1F22D37
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 16:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD7B1F76B3;
	Thu, 24 Oct 2024 16:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="avfvlAd+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A121F76A5
	for <linux-iio@vger.kernel.org>; Thu, 24 Oct 2024 16:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729786340; cv=none; b=O/0+moPXAnkju2mYnvIWxMjxvmwDuF4OfF1t7/NjBxe8CJrplfPx2yY3mI7tMehR5mZMUljYUXpDd0P4joJk57z/oFEaSDd7PdDtSLF2K+W9fIeh9QbAaW9V9zqKOHcmAR3/hxbtLJESRwYiGeStngiNwedw7xUITqfyJ/1CGVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729786340; c=relaxed/simple;
	bh=YOl+jdRdLxBkVt8b/cajw2Uh9M6+GntmVhC8RkIqJwo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Zv4/SE/v7HsH/nclmViX56M55LSwH2A12aHdW0dvOSGqRARuvZCw4JqPK/mVWZixeVt1SwxR2AyZkRkdQ03MWMaMB7lrIUUswV5OsXkc6GkUgIOMMM34iSLgq6JTVfdVQpr1s1tuwroKjM7KmN91XP7vobnmbX+cuBOvhXansq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=avfvlAd+; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7180d9d0dcbso589496a34.3
        for <linux-iio@vger.kernel.org>; Thu, 24 Oct 2024 09:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729786336; x=1730391136; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yqHRHn8vLXvapMZ39Cgc0iJX3AUAdIkxL0Txgf+Yb1M=;
        b=avfvlAd+9lCVpRyLauMnMF4xlycMe9EeRqZMmvuJaMCQ4AtSYSvO+OYQrJXjDDDLm7
         4UCtzdfgYdt6ySFbtc15bBYQCd2ZbBXvrOsN/8sTnDuM20+JUgFFU5OTJnZGm69k1sts
         D+vV61sOdIXKk5YVUGbkg/pV9OZmJn0pyLVX5z55ymzMiV1Alyi+2XwFYoaeES4nYvZ6
         2lqVkUxK3/eQqUhr50PCGFfC3Q9iU0pSsKd/MYR90aDkNkAeN4wF2RUhFgpZ1YHS19NW
         fX937TrCTzNh2KHtYpFSA+ZDYPLEPRv2J0tZVtUBhmpSIe3eZ0k2ni+PLIyJuDBH/Wxb
         Zb+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729786336; x=1730391136;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yqHRHn8vLXvapMZ39Cgc0iJX3AUAdIkxL0Txgf+Yb1M=;
        b=dXvhiiE97LmWclDZPfIYRljG0umTRcWWe4S5WoxUW5uPrs4+R5f1IkEuvKsSJpmvxM
         B3gr98gtlFEOBMmiod/be2Mc5Jzoakgg1ryPXATrrDnCKs+VoNLsDxSEuZhj57yxJp1e
         mJCwcIkI7vzX/372wQjYuhs0KkZWeneJcef5Q1w3H8YvbnbyY7O1fSG+bafwGI1fgtV8
         ESa52Nd6tB/HCv7Dt3WLrJQM+WjQDPOZGzv4LFtl8oprR0gWdmvhFEMuJWvIvQswgPuC
         q6Yin36cey6cxvGyt6503/ClIa6XZEWeU4/RxFzFRRkmhMzrD4Uh7BjfwWVuSwbFVYcm
         r8bQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDJGBN5SpjSCab5YYdt3mdStR5K3EQoh5nbRdTALa7BwY/ReDTgdpJ10kwu5/EBlAZGf2nBdQop2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwroanxCdrL0xFGMIl3U/Lxw8hzWgjr72uzbF+6ZB5iWN6RZXyu
	XQG5slxtlYC868aLYKztE9DF7p4pA4uP3kX6HGAxnKa5ltCxnnsePTbicE8zy1Y=
X-Google-Smtp-Source: AGHT+IHFS2g+HAiwrBGtBUE2E1tTT5mJ8knQJc868BjEF+Hh0NWfqW+DfIUaRbNNK8gnX0OdGFIpyw==
X-Received: by 2002:a05:6830:6f01:b0:718:10ce:c6a7 with SMTP id 46e09a7af769-7184b348e49mr5715982a34.30.1729786336306;
        Thu, 24 Oct 2024 09:12:16 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7182eb21b6asm2166675a34.8.2024.10.24.09.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 09:12:15 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 24 Oct 2024 11:12:10 -0500
Subject: [PATCH v2] iio: adc: ad7380: use if_not_cond_guard for claim
 direct
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241024-cleanup-if_not_cond_guard-v2-1-1bef98c9fd2e@baylibre.com>
X-B4-Tracking: v=1; b=H4sIANlxGmcC/42NWw6DIBBFt2LmuzRgH1C/uo/GGIRBJ7FgQE2Nc
 e+lrqCf5yT33A0SRsIEVbFBxIUSBZ+hPBVgeu07ZGQzQ8nLq+BcMDOg9vPIyDU+TI0J3jbdrKN
 l/KGEVXdprVOQ92NER5+j/aoz95SmENfjahE/+091EYwzKW8XJXjLndTPVq8DtRHPJryh3vf9C
 378CkTFAAAA
To: Peter Zijlstra <peterz@infradead.org>, 
 Jonathan Cameron <jic23@kernel.org>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Replace usage of iio_device_claim_direct_scoped() with
if_not_cond_guard().

This makes fewer lines of code, less indentation, avoids having the
error return statement in the macro args, and avoids needing to use
unreachable().

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
This is addressing the build failure reported on Peter's locking/test
branch [1]. I've done a test compile locally with LLVM=1 and it compiles
successfully.

[1]: https://lore.kernel.org/oe-kbuild-all/202410240802.VMztsHsW-lkp@intel.com/
---
Changes in v2:
- Add {} around case statements to avoid clang compiler error
- Link to v1: https://lore.kernel.org/r/20241001-cleanup-if_not_cond_guard-v1-0-7753810b0f7a@baylibre.com
---
 drivers/iio/adc/ad7380.c | 76 ++++++++++++++++++++++++------------------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
index e8bddfb0d07d..34adc5aeb6f3 100644
--- a/drivers/iio/adc/ad7380.c
+++ b/drivers/iio/adc/ad7380.c
@@ -569,15 +569,15 @@ static const struct regmap_config ad7380_regmap_config = {
 static int ad7380_debugfs_reg_access(struct iio_dev *indio_dev, u32 reg,
 				     u32 writeval, u32 *readval)
 {
-	iio_device_claim_direct_scoped(return  -EBUSY, indio_dev) {
-		struct ad7380_state *st = iio_priv(indio_dev);
+	struct ad7380_state *st = iio_priv(indio_dev);
 
-		if (readval)
-			return regmap_read(st->regmap, reg, readval);
-		else
-			return regmap_write(st->regmap, reg, writeval);
-	}
-	unreachable();
+	if_not_cond_guard(iio_claim_direct_try, indio_dev)
+		return -EBUSY;
+
+	if (readval)
+		return regmap_read(st->regmap, reg, readval);
+
+	return regmap_write(st->regmap, reg, writeval);
 }
 
 /*
@@ -819,12 +819,12 @@ static int ad7380_read_raw(struct iio_dev *indio_dev,
 		return PTR_ERR(scan_type);
 
 	switch (info) {
-	case IIO_CHAN_INFO_RAW:
-		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
-			return ad7380_read_direct(st, chan->scan_index,
-						  scan_type, val);
-		}
-		unreachable();
+	case IIO_CHAN_INFO_RAW: {
+		if_not_cond_guard(iio_claim_direct_try, indio_dev)
+			return -EBUSY;
+
+		return ad7380_read_direct(st, chan->scan_index, scan_type, val);
+	}
 	case IIO_CHAN_INFO_SCALE:
 		/*
 		 * According to the datasheet, the LSB size is:
@@ -901,7 +901,7 @@ static int ad7380_write_raw(struct iio_dev *indio_dev,
 	int ret, osr, boost;
 
 	switch (mask) {
-	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO: {
 		osr = ad7380_osr_to_regval(val);
 		if (osr < 0)
 			return osr;
@@ -909,31 +909,31 @@ static int ad7380_write_raw(struct iio_dev *indio_dev,
 		/* always enable resolution boost when oversampling is enabled */
 		boost = osr > 0 ? 1 : 0;
 
-		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
-			ret = regmap_update_bits(st->regmap,
-					AD7380_REG_ADDR_CONFIG1,
-					AD7380_CONFIG1_OSR | AD7380_CONFIG1_RES,
-					FIELD_PREP(AD7380_CONFIG1_OSR, osr) |
-					FIELD_PREP(AD7380_CONFIG1_RES, boost));
+		if_not_cond_guard(iio_claim_direct_try, indio_dev)
+			return -EBUSY;
 
-			if (ret)
-				return ret;
+		ret = regmap_update_bits(st->regmap,
+					 AD7380_REG_ADDR_CONFIG1,
+					 AD7380_CONFIG1_OSR | AD7380_CONFIG1_RES,
+					 FIELD_PREP(AD7380_CONFIG1_OSR, osr) |
+					 FIELD_PREP(AD7380_CONFIG1_RES, boost));
 
-			st->oversampling_ratio = val;
-			st->resolution_boost_enabled = boost;
-
-			/*
-			 * Perform a soft reset. This will flush the oversampling
-			 * block and FIFO but will maintain the content of the
-			 * configurable registers.
-			 */
-			return regmap_update_bits(st->regmap,
-					AD7380_REG_ADDR_CONFIG2,
-					AD7380_CONFIG2_RESET,
-					FIELD_PREP(AD7380_CONFIG2_RESET,
-						   AD7380_CONFIG2_RESET_SOFT));
-		}
-		unreachable();
+		if (ret)
+			return ret;
+
+		st->oversampling_ratio = val;
+		st->resolution_boost_enabled = boost;
+
+		/*
+		 * Perform a soft reset. This will flush the oversampling block
+		 * and FIFO but will maintain the content of the configurable
+		 * registers.
+		 */
+		return regmap_update_bits(st->regmap, AD7380_REG_ADDR_CONFIG2,
+					  AD7380_CONFIG2_RESET,
+					  FIELD_PREP(AD7380_CONFIG2_RESET,
+						     AD7380_CONFIG2_RESET_SOFT));
+	}
 	default:
 		return -EINVAL;
 	}

---
base-commit: 431c39f6d3edbab14f48dbf37a58ccdc0ac3be1e
change-id: 20241001-cleanup-if_not_cond_guard-0981d867ddf8

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


