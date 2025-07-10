Return-Path: <linux-iio+bounces-21497-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C076AFF6B9
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 04:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E6E316EAEC
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 02:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB1519D065;
	Thu, 10 Jul 2025 02:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pGAHSaz/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBF327F4D9
	for <linux-iio@vger.kernel.org>; Thu, 10 Jul 2025 02:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752114037; cv=none; b=nn6zUQQc95qTIK6rydY4lPGg6jOkb9xbb/VSwWOBwvmk21No0i6Qg+H946bE42qD5jJTEeXKPjfR0DxgQB65tg7t0OgWZj+ND2wzxFimfJt05HlwkZ0CFDbR7DnCZOmyfWNw3xlqxXEkuHH9By03Ik3KtohMwXScPICZxbNclxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752114037; c=relaxed/simple;
	bh=Xl8o2DtSaigWESa1n7kRRDmN3sTUITSG1wrwo5ezoAU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sRnT8OIvp0cnezSrRy0xGmYACx2vPAi1fJqyt9ln9d8pvq/m/u11PbOYCpYb0VM6XBSaELvZ4Wn4izCa2mw0YeLS8b9JHx7nM53nK0SFOihIfA7OrTk+86aKYlgQqVZkYtF1Z5bKo3aDh4ZQWIBKVcnMsMj0K+piVOiKylVZhEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=pGAHSaz/; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-60f0a92391bso306261eaf.0
        for <linux-iio@vger.kernel.org>; Wed, 09 Jul 2025 19:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752114034; x=1752718834; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IImpk5jGtMH+w7dUqRTc1wLzrv2Bvf1SOOEFKZMUB0Y=;
        b=pGAHSaz/WYDUE+LBTGQKz8XKV78ByaCXn8WB/SBg+igS1axmL66v5Hd6UTv6tL9H5n
         ITC0qL1HpnVSHgREWByQg0aEP+FQ9EVuZpSDuLoze9bFVX+FgFlfmPqWCBglwdU9MJd3
         o4e7yfk5CsaIsVh2khFtGA4adnpOi9Iofhm/Zf5Kp3Q6f8JRXMBnIuzswUkIkYeo02mD
         YHO5pJSWSH4Ckr1oMPCNZhDJG5xtlN+XGE2yiTiwtixlPGpNQCfscgTFeolSZVhogeNd
         lHScxtBaGVrlc9zUEiKP6cSBespGSPa6YlJ8ztPsRBd/zPJfu4SlOi7GpE+sT+Wirgfu
         l2PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752114034; x=1752718834;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IImpk5jGtMH+w7dUqRTc1wLzrv2Bvf1SOOEFKZMUB0Y=;
        b=kyvDLjVe7g9s2U90RuUOCHLzaGSNJl38uWsyEW6YSaVHLf0fVpcE8YhxahyQtkRrwi
         7hjBVVK8yPwq6r86lna9+MpmdisvKShRfpaxYHBEfqzYtDJmr2hjod4C/tWfsMVITe2y
         MVgcTm40YKxhu9hPHzdInsN1SgR9rFX2+xNdGmuvdrPFCkR3uyhLUIcwUA35yP1XVm2J
         CXfuEiJ9H0tIof2c7nvpQdzGVmh56ivuYu2ZS3h0VUjzic7pT1FrACYRGzuli/otgw30
         on7UA4R1S/v0VYvNn+aE1W3SBAiLmi+k8AADBenUmLXi9EqyCnHvAydgy35ujMgCoWvo
         +oLA==
X-Gm-Message-State: AOJu0YzDFuwFLw9UPblC8y63l8nNU4hDsUVaCHcgYhd90EhIaZ39uJJw
	YZ4Hdbp/WFQnUVBpyc6Wbcx+FL0MFrbjqcROKVDrF0ud406p40KLqwfzx7V2FNxDjQJgWDEG5k1
	4SpOgEfY=
X-Gm-Gg: ASbGncsTP7b1ej9cMQlgzesmcWtvbK5O2c5C9Uq8Rzz+Zq6ibPFBV+5NM5V5Sq4SeFw
	NhdY3gSORML9/SzdByPIMqztRJi8lVvAQkMjXHTrJ6R3vvaYaPWOCPufdSZ0GdywdfqTmev/iqN
	9kgqi6Z0olsFVhIgh7BWRPHzJmPbVjGYQgiBcBDi2tOnI1SMczyZtIaYBuNP//G5pjVUqvrCX50
	QTUw+4y232/dYaUK8ADX5N+4wiTle6I69bV9vEY0T9OtLSFdf7mLBjkaQdSqZG0ui+OrIf8ssvg
	bySd74GUhy1hn+CrQiIHTKPG6d5RHVvI2K6hnkd6GAOTjKPtE7GQFSRItdNzmVzgSdB+
X-Google-Smtp-Source: AGHT+IEM0Ysmp21GGMggoZwDFO+qiHN33lKFW/Brnj2s4UMHLtA+QhysRcAWqjOcvP9MWblYhuy33g==
X-Received: by 2002:a05:6808:16aa:b0:40a:b141:8f57 with SMTP id 5614622812f47-413abe70954mr1688660b6e.3.1752114034470;
        Wed, 09 Jul 2025 19:20:34 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:6f38:cf8f:abb1:34f7])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-613d9f00d46sm66972eaf.22.2025.07.09.19.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 19:20:33 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 09 Jul 2025 21:20:01 -0500
Subject: [PATCH v2 2/2] iio: imu: bno055: make bno055_sysfs_attr const
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-iio-const-data-19-v2-2-fb3fc9191251@baylibre.com>
References: <20250709-iio-const-data-19-v2-0-fb3fc9191251@baylibre.com>
In-Reply-To: <20250709-iio-const-data-19-v2-0-fb3fc9191251@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andrea Merello <andrea.merello@iit.it>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4938; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=Xl8o2DtSaigWESa1n7kRRDmN3sTUITSG1wrwo5ezoAU=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBobyNlraRWW7K8uZDXgQLj+ENEEPzweXxt7C4vB
 NMNfZiH3fOJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaG8jZQAKCRDCzCAB/wGP
 wKpIB/4rRcQqwnTUqv458/jvmUABudUHoudfABuvizaJ6Oq3BD1ZnDUakM7vJe2JkPKFo50Gxhl
 algDuQApJ7dK8m8R99KMgBs0Mj/pBJtRD1SxkeYKLlIZ53bfd9oN6zThGGnnzENuhb+oQcY4mfD
 hS1k36K/k2P+TsCRb08OPApmb9VYKR9UIgpGxY3B29IrCnpQDE84ei8xQU2d0YDVocIa2NY3+4B
 cWzTI2GlRvOymIR1LbkbuwMpjUBCH2CC0/xB56CY8J/VD2bnYro8E102mhhmBPA93rBPzFFPdq1
 5lM1zq5Jojv74x+aenkeozVXEvEQv+RPS4ne1J0DNI4G5HHU
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add const qualifier to struct bno055_sysfs_attr and its array fields.
All of this is read-only data so it can be made const.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/imu/bno055/bno055.c | 49 ++++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/imu/bno055/bno055.c b/drivers/iio/imu/bno055/bno055.c
index 0eb5e1334e5564284c7f4bf560424b5ec734903d..a8e71679ec21dc2cfb0cbbce978fc7cad9929d96 100644
--- a/drivers/iio/imu/bno055/bno055.c
+++ b/drivers/iio/imu/bno055/bno055.c
@@ -114,35 +114,35 @@
 #define BNO055_UID_LEN 16
 
 struct bno055_sysfs_attr {
-	int *vals;
+	const int *vals;
 	int len;
-	int *fusion_vals;
-	int *hw_xlate;
+	const int *fusion_vals;
+	const int *hw_xlate;
 	int hw_xlate_len;
 	int type;
 };
 
-static int bno055_acc_lpf_vals[] = {
+static const int bno055_acc_lpf_vals[] = {
 	7, 810000, 15, 630000, 31, 250000, 62, 500000,
 	125, 0, 250, 0, 500, 0, 1000, 0,
 };
 
-static struct bno055_sysfs_attr bno055_acc_lpf = {
+static const struct bno055_sysfs_attr bno055_acc_lpf = {
 	.vals = bno055_acc_lpf_vals,
 	.len = ARRAY_SIZE(bno055_acc_lpf_vals),
-	.fusion_vals = (int[]){62, 500000},
+	.fusion_vals = (const int[]){62, 500000},
 	.type = IIO_VAL_INT_PLUS_MICRO,
 };
 
-static int bno055_acc_range_vals[] = {
+static const int bno055_acc_range_vals[] = {
   /* G:    2,    4,    8,    16 */
 	1962, 3924, 7848, 15696
 };
 
-static struct bno055_sysfs_attr bno055_acc_range = {
+static const struct bno055_sysfs_attr bno055_acc_range = {
 	.vals = bno055_acc_range_vals,
 	.len = ARRAY_SIZE(bno055_acc_range_vals),
-	.fusion_vals = (int[]){3924}, /* 4G */
+	.fusion_vals = (const int[]){3924}, /* 4G */
 	.type = IIO_VAL_INT,
 };
 
@@ -166,37 +166,37 @@ static struct bno055_sysfs_attr bno055_acc_range = {
  *     = hwval * (dps_range/(2^15 * k))
  * where k is rad-to-deg factor
  */
-static int bno055_gyr_scale_vals[] = {
+static const int bno055_gyr_scale_vals[] = {
 	125, 1877467, 250, 1877467, 500, 1877467,
 	1000, 1877467, 2000, 1877467,
 };
 
-static int bno055_gyr_scale_hw_xlate[] = {0, 1, 2, 3, 4};
-static struct bno055_sysfs_attr bno055_gyr_scale = {
+static const int bno055_gyr_scale_hw_xlate[] = {0, 1, 2, 3, 4};
+static const struct bno055_sysfs_attr bno055_gyr_scale = {
 	.vals = bno055_gyr_scale_vals,
 	.len = ARRAY_SIZE(bno055_gyr_scale_vals),
-	.fusion_vals = (int[]){1, 900},
+	.fusion_vals = (const int[]){1, 900},
 	.hw_xlate = bno055_gyr_scale_hw_xlate,
 	.hw_xlate_len = ARRAY_SIZE(bno055_gyr_scale_hw_xlate),
 	.type = IIO_VAL_FRACTIONAL,
 };
 
-static int bno055_gyr_lpf_vals[] = {12, 23, 32, 47, 64, 116, 230, 523};
-static int bno055_gyr_lpf_hw_xlate[] = {5, 4, 7, 3, 6, 2, 1, 0};
-static struct bno055_sysfs_attr bno055_gyr_lpf = {
+static const int bno055_gyr_lpf_vals[] = {12, 23, 32, 47, 64, 116, 230, 523};
+static const int bno055_gyr_lpf_hw_xlate[] = {5, 4, 7, 3, 6, 2, 1, 0};
+static const struct bno055_sysfs_attr bno055_gyr_lpf = {
 	.vals = bno055_gyr_lpf_vals,
 	.len = ARRAY_SIZE(bno055_gyr_lpf_vals),
-	.fusion_vals = (int[]){32},
+	.fusion_vals = (const int[]){32},
 	.hw_xlate = bno055_gyr_lpf_hw_xlate,
 	.hw_xlate_len = ARRAY_SIZE(bno055_gyr_lpf_hw_xlate),
 	.type = IIO_VAL_INT,
 };
 
-static int bno055_mag_odr_vals[] = {2, 6, 8, 10, 15, 20, 25, 30};
-static struct bno055_sysfs_attr bno055_mag_odr = {
+static const int bno055_mag_odr_vals[] = {2, 6, 8, 10, 15, 20, 25, 30};
+static const struct bno055_sysfs_attr bno055_mag_odr = {
 	.vals = bno055_mag_odr_vals,
 	.len =  ARRAY_SIZE(bno055_mag_odr_vals),
-	.fusion_vals = (int[]){20},
+	.fusion_vals = (const int[]){20},
 	.type = IIO_VAL_INT,
 };
 
@@ -553,7 +553,8 @@ static const struct iio_chan_spec bno055_channels[] = {
 };
 
 static int bno055_get_regmask(struct bno055_priv *priv, int *val, int *val2,
-			      int reg, int mask, struct bno055_sysfs_attr *attr)
+			      int reg, int mask,
+			      const struct bno055_sysfs_attr *attr)
 {
 	const int shift = __ffs(mask);
 	int hwval, idx;
@@ -582,7 +583,8 @@ static int bno055_get_regmask(struct bno055_priv *priv, int *val, int *val2,
 }
 
 static int bno055_set_regmask(struct bno055_priv *priv, int val, int val2,
-			      int reg, int mask, struct bno055_sysfs_attr *attr)
+			      int reg, int mask,
+			      const struct bno055_sysfs_attr *attr)
 {
 	const int shift = __ffs(mask);
 	int best_delta;
@@ -763,7 +765,8 @@ static int bno055_read_simple_chan(struct iio_dev *indio_dev,
 	}
 }
 
-static int bno055_sysfs_attr_avail(struct bno055_priv *priv, struct bno055_sysfs_attr *attr,
+static int bno055_sysfs_attr_avail(struct bno055_priv *priv,
+				   const struct bno055_sysfs_attr *attr,
 				   const int **vals, int *length)
 {
 	if (priv->operation_mode != BNO055_OPR_MODE_AMG) {

-- 
2.43.0


