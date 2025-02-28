Return-Path: <linux-iio+bounces-16212-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0C0A4A66F
	for <lists+linux-iio@lfdr.de>; Sat,  1 Mar 2025 00:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCEFD3B2362
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 23:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34DD1DF271;
	Fri, 28 Feb 2025 23:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bkf1H6yc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C351DF258;
	Fri, 28 Feb 2025 23:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740783841; cv=none; b=PmOk3aARHQ8upVFhBU3Af22v/rAV2e04OfQ1JoJVdDGdnQYcf/yvMfw44uO4InQDwK00MTIGBJ8OJLZnAiHuNyqiEV0NnCFS1XILzW40oP/Xx5KdW/vlVkEFAPTj3nUyZRH1Bc2AyR1gudwenlPMGc3MvBShv+zaNNNxsKTC7yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740783841; c=relaxed/simple;
	bh=cJUQOIbTN8eNND6lP9f5LF7Pa3D404GKy0353pPAVm8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BT6vb63c680nEgu6aZCnlsbYjIhG+O9lt5xe7ATOh8fjzDKtKW28tIjsCgV1n8TCGnITZ3PvwCy6XbqBQMr1ubcH00G58F0rTAAviqb+WSSVm4rD/C2VHW5eO/czExHamypc4tvTF2oQPsWHPuqYpkJHRSnv5sGA/zm59gltBHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bkf1H6yc; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22339936bbfso41398655ad.1;
        Fri, 28 Feb 2025 15:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740783839; x=1741388639; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+7O/hrvstZvHUG+IHHgHeJpWw8FZjuMGEnoX2VM0mCs=;
        b=Bkf1H6ycrYaF1lEKOysWgUfATxrqJdhvnSeyWMxYPuUozr6pdoUFHzSMLa6/OHhh6v
         6rlnqoeFg3yvuERblkDSpj0zMIUsv55lygQsSblxasMDVntgjAXAT8+YD+Cx8S6UViH5
         XgAnWfBtfNIM9nLQ9ErDSO5B87YduIi8GIzhAnoxfVcQbfQijX98dAA8LRcJDctaA9M8
         75h7LU2vopWasF/4jZb58p6hb3TCsPVV5Qwu2pMDdvOyoVhAyE4jxpAngnMfzrTsfWJE
         Aow6f2lj9eqjY1iyPXFkZx46yVdyav5EukDDkyslhfmf/iuKdPyEA+DpjT12rAU+JWcp
         qHZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740783839; x=1741388639;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+7O/hrvstZvHUG+IHHgHeJpWw8FZjuMGEnoX2VM0mCs=;
        b=l3cjXf76vJHlH34qmlDON+lX+W/yvforKA7V0csApTIjGMnN8Mum8CyT5JXeRVesCZ
         h4GCb59aQlRwVopkSMs3N0DjIZQjR+/khpy9qdj85EFB2MhtOuX20f3fBRGPl+Udz5jb
         +rCT9POAK9T6UV+nvhrxppSOaieieLBM6jIArg1jFbr3QxsviXa9WK5jdN4fprxnKUPk
         54LAav9r40Or+5OfWRMgroHdK1nkZmsppAQlurbQQhn85qePags6Oq+1Br7zrD4Cl6A0
         07uzMtsMJVdW4gDm8CabRcB4408CPMgSCvYs1yuaXcFEDo4GnB7Ar75w3UynLz95IWMx
         D40g==
X-Forwarded-Encrypted: i=1; AJvYcCUEGL7bKeyyj8rk68rBJ0stYqjMu9QIIO9fA+KLHJS1v53qBLf0NorWT3Re2tVMSM6D+A2DoRKSxoteNu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP2te6xU2gJVKq8RCidpOwZXwKIfcdvM7zq+VBUWhuc3QVsrYM
	rODyyoBCCa4kEXgLfUfjyyictKpRl39FmJ3ZPgUyhXmozytS1CN8
X-Gm-Gg: ASbGnctTUYd60D1epZEAWaikxmIZG2hnGz8fzR4uUS40YO5ARL/8WYtS6ayGkWASNoF
	EtcxjYC+qCee5StVE+fH+e4dwwBERq3lZG9dDP4o9kJ0uKrxllikZ/U+0fKhfMl/FxI7nnNRzVt
	m839BwRrBtw0SlBI/BySC3iMvsBFAqYVSxhru8Q3JkgzXw2OHYvoMhqKjnUFpGY0/1n+pJk0it+
	iBWxdpxp3OE0BG01u2wQKBb1OP0z/rxGeGQOCurtEciADklH3lJx8RzL66e46FxVOYL3jleWe6f
	LlqYPLJnVWSlLdRJBxf7mJSGGmUgIL/Ydh+SuQ==
X-Google-Smtp-Source: AGHT+IEjA+cAN8ALBBrLiwmHv8vkXM9NNJFqNVl9vrB+2sSCTnoUb6qc3mhcILuRy+wsyR0GVpPTIg==
X-Received: by 2002:a05:6a20:734b:b0:1ee:d418:f758 with SMTP id adf61e73a8af0-1f2f4cdb421mr8917377637.17.1740783839155;
        Fri, 28 Feb 2025 15:03:59 -0800 (PST)
Received: from [192.168.0.107] ([2804:14d:90a8:854f::10dc])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7ddf230dsm3974875a12.8.2025.02.28.15.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 15:03:58 -0800 (PST)
From: Gustavo Silva <gustavograzs@gmail.com>
Date: Fri, 28 Feb 2025 20:03:48 -0300
Subject: [PATCH v2 1/3] iio: imu: bmi270: move private struct declaration
 to source file
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-bmi270-irq-v2-1-3f97a4e8f551@gmail.com>
References: <20250228-bmi270-irq-v2-0-3f97a4e8f551@gmail.com>
In-Reply-To: <20250228-bmi270-irq-v2-0-3f97a4e8f551@gmail.com>
To: Alex Lanzano <lanzano.alex@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gustavo Silva <gustavograzs@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740783831; l=2465;
 i=gustavograzs@gmail.com; s=20250111; h=from:subject:message-id;
 bh=cJUQOIbTN8eNND6lP9f5LF7Pa3D404GKy0353pPAVm8=;
 b=XTHQ8Nmvg2Ja8S6ciWdeEKquDHmZ2bwb1PmuPW4PuFZKhQvhXiAXPjwt6tCYviYB6wH8Nk9xg
 gLoVsyxe+18AdQY/OPWV2xX5RI2A2iPGid4hwjkUdqmzIcxMdFDZ6vi
X-Developer-Key: i=gustavograzs@gmail.com; a=ed25519;
 pk=g2TFXpo1jMCOCN+rzVoM9NDFNfSMOgVyY0rlyvk4RTM=

The device's private data struct is currently declared in the header
file, but it does not need to be exposed there. Move it to the driver's
core source file to avoid unnecessary #include directives or forward
declarations in the header.

Acked-by: Alex Lanzano <lanzano.alex@gmail.com>
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


