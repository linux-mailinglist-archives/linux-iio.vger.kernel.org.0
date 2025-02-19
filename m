Return-Path: <linux-iio+bounces-15818-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5DCA3CDF1
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 00:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E3E21896AC1
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 23:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2511E26138D;
	Wed, 19 Feb 2025 23:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eG19biEy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65055261381;
	Wed, 19 Feb 2025 23:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740009308; cv=none; b=cfxEUJPp2aWKpDo+Ib36XKjozlT0TtUR2S3Swli3AULzwp6RjesXyPKF44ykAB7YHP6DOeSbX+knPfdGurmsuZ3DFHfOnZIjQNrpjJsNp200goItEdKMXuXSuqJEo0MDmiY7VxsuCmoFfTSfpnzOTMMTQHWTAGbi2mHENqxDIcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740009308; c=relaxed/simple;
	bh=SSkQOzSssGZELoiHSg0tF0b27g+2d0QD0yYcLsNIgw8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q4/XXd8yiE3Yo/i7nMajsCmYfNTGgXAZK5NiLDm+nDknsg5/0Tysa5fnNZJyd9W3HLqMrcxlCtDLL7nMnVKB1sfc08tfvzz5jiIdHZMeuqc+dD5Zziso+sTxxMVK7MqCqKhjH9WBWcnCc34Xbdf6BJM4+ke8vaQ0SEpsLjxmTIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eG19biEy; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-72736498817so197059a34.1;
        Wed, 19 Feb 2025 15:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740009305; x=1740614105; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9MyLUQ1Rfh6h7afl12jZ1tZGCRAO1x6ONaSO++6VPjI=;
        b=eG19biEyRgVHlVTxZIv8tckO29Sr8Oy4isPffvMsBkvTvnU0LaQmd/EcrTPod6EWVS
         ZZxqgkRKlnCuB6D2JO80liby4S0TUyzhjcO2RkWqzU98NXKVIyE4QjNGuFgBKweFv0RO
         wgs6sYz50kxnlb/AIoZcyS5sRYUC5cCcQyaknF0qH02gMUvWi7UpHOYqIjVOTP/qjAFd
         mpGACLsckJJbce/Rv4D20OQkBWS1Fd4Ud5xysLV/sQqsxLCQAz0j2dAHa6cF6gUD7Wnx
         KIQ6vsCkUR4KLsMC51pUFerVKIL1x3/dZlbON45zFCJCBxU/1IWLKJHYAQvUQyhY7YPT
         z8Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740009305; x=1740614105;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9MyLUQ1Rfh6h7afl12jZ1tZGCRAO1x6ONaSO++6VPjI=;
        b=F+wIgtKEfeZ3Ro5T+bxV+d4ofA2u/B4ji4hv9eAeL1etahR8HxeZmG+Vx9aG//tR2e
         6M1VbNqPkT0h0wdTqiwijohzqg18JXjopLl1o6C9YQIBhI0ZMEq2GlkP185g7M2kEM3R
         U18Ydr3iefqSzbTFwk4Rt5hVqIFerBuaDXk6ER+ohxxXBWcvEibMIBBE6YQSz6XCkteU
         RyTeciZ+jbmlz4JJpQHTO+BXQyDMddR7SGK8VxxOGZqNLuLCK0wLpKkTbS2xegXV4ZaN
         L+PnSrDmqjUtzO9vJ41Dy3g7BozVeWSMFmpPJO/J3sVCJ7uSwMjaMSt2frYe4SlbPIpX
         2GVQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4hhFXxjecv+8K0Zp0E6sHB/ta0Fypo12mN2r0qkHPWWft0MxHPnpX/haQuzx6AjbfudurgXOZ93pFq3A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7oJ6vxgR0sqWk3dAEMVn3sBNRT2p9jYOWQPjSWMNg0bSeXIJY
	RrmjK7kxTklqgClM2hLAzVtEUJ0p+TdPHDg3/FPmdAR0O35qcmAg
X-Gm-Gg: ASbGncsw+fN7jPHEx4ZksL2WD8bxhIhS0NBGkQ/PtuWcQxobxSJi/MpniO+239BOx8F
	DDareKf26SVLukNp7nga6ovmcDMWbt0QRIgYni0woZBpCrY7ZO7BPUG0a22awKP/XxFwlFoaD0B
	Si8TtM4c7eoM/H6ms+XgBDjyn4mbQgqiAQyKE+Sf7ajqC6TYzQhQsxc1H5fzegueMHQY9t5l7ef
	CgI3yfk4ejXW93ck78PMjgd9U8poGB3nmZlTi4bXwWSFDn0F40ZjyDezQaBliuYz4AGKnZntWbO
	wQXHFth6
X-Google-Smtp-Source: AGHT+IEEGgNaKerFsyUJJWorvfslU+18vHJJFJDUB57QZFhnACLq4mbGzR7rlCtzgtucsxsfy14nGQ==
X-Received: by 2002:a05:6830:6717:b0:727:2f79:ce31 with SMTP id 46e09a7af769-7272f79d01cmr7247517a34.23.1740009305461;
        Wed, 19 Feb 2025 15:55:05 -0800 (PST)
Received: from [192.168.0.107] ([2804:14d:90a8:854f::10dc])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7273a14070esm658173a34.49.2025.02.19.15.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 15:55:05 -0800 (PST)
From: Gustavo Silva <gustavograzs@gmail.com>
Date: Wed, 19 Feb 2025 20:54:45 -0300
Subject: [PATCH 1/3] iio: imu: bmi270: move private struct declaration to
 source file
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-bmi270-irq-v1-1-145d02bbca3b@gmail.com>
References: <20250219-bmi270-irq-v1-0-145d02bbca3b@gmail.com>
In-Reply-To: <20250219-bmi270-irq-v1-0-145d02bbca3b@gmail.com>
To: Alex Lanzano <lanzano.alex@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gustavo Silva <gustavograzs@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740009298; l=2416;
 i=gustavograzs@gmail.com; s=20250111; h=from:subject:message-id;
 bh=SSkQOzSssGZELoiHSg0tF0b27g+2d0QD0yYcLsNIgw8=;
 b=/HYvHG+DkX96vjJxNNhfBv0V7aAhtX0rXimKW4tWot4z6oQlKn3/LZdEAKgirPMHP7s4NrG/I
 iDLRCQBPst5D2eCoY/tlTl4ZMrUjgvrDqMsnckZcdcxVPMejveOURBx
X-Developer-Key: i=gustavograzs@gmail.com; a=ed25519;
 pk=g2TFXpo1jMCOCN+rzVoM9NDFNfSMOgVyY0rlyvk4RTM=

The device's private data struct is currently declared in the header
file, but it does not need to be exposed there. Move it to the driver's
core source file to avoid unnecessary #include directives or forward
declarations in the header.

Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>
---
 drivers/iio/imu/bmi270/bmi270.h      | 17 +----------------
 drivers/iio/imu/bmi270/bmi270_core.c | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/imu/bmi270/bmi270.h b/drivers/iio/imu/bmi270/bmi270.h
index fdfad5784cc52043475b6816286619fac5824684..d94525f6aee85f21cc9e9ae1bc9c1db0dc00b927 100644
--- a/drivers/iio/imu/bmi270/bmi270.h
+++ b/drivers/iio/imu/bmi270/bmi270.h
@@ -6,22 +6,6 @@
 #include <linux/regmap.h>
 #include <linux/iio/iio.h>
 
-struct device;
-struct bmi270_data {
-	struct device *dev;
-	struct regmap *regmap;
-	const struct bmi270_chip_info *chip_info;
-
-	/*
-	 * Where IIO_DMA_MINALIGN may be larger than 8 bytes, align to
-	 * that to ensure a DMA safe buffer.
-	 */
-	struct {
-		__le16 channels[6];
-		aligned_s64 timestamp;
-	} data __aligned(IIO_DMA_MINALIGN);
-};
-
 struct bmi270_chip_info {
 	const char *name;
 	int chip_id;
@@ -32,6 +16,7 @@ extern const struct regmap_config bmi270_regmap_config;
 extern const struct bmi270_chip_info bmi260_chip_info;
 extern const struct bmi270_chip_info bmi270_chip_info;
 
+struct device;
 int bmi270_core_probe(struct device *dev, struct regmap *regmap,
 		      const struct bmi270_chip_info *chip_info);
 
diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
index 464dcdd657c4ba27fdb7620c80e9f05e2a831910..9f24d4044ed6f00f67fd3a8f5adda821c3140a18 100644
--- a/drivers/iio/imu/bmi270/bmi270_core.c
+++ b/drivers/iio/imu/bmi270/bmi270_core.c
@@ -78,6 +78,21 @@
 #define BMI260_INIT_DATA_FILE "bmi260-init-data.fw"
 #define BMI270_INIT_DATA_FILE "bmi270-init-data.fw"
 
+struct bmi270_data {
+	struct device *dev;
+	struct regmap *regmap;
+	const struct bmi270_chip_info *chip_info;
+
+	/*
+	 * Where IIO_DMA_MINALIGN may be larger than 8 bytes, align to
+	 * that to ensure a DMA safe buffer.
+	 */
+	struct {
+		__le16 channels[6];
+		aligned_s64 timestamp;
+	} data __aligned(IIO_DMA_MINALIGN);
+};
+
 enum bmi270_scan {
 	BMI270_SCAN_ACCEL_X,
 	BMI270_SCAN_ACCEL_Y,

-- 
2.48.1


