Return-Path: <linux-iio+bounces-21076-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 986BFAEC980
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 19:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0B7D3A2639
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 17:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9032E2356B9;
	Sat, 28 Jun 2025 17:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lu6opnum"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED7A2BCFB
	for <linux-iio@vger.kernel.org>; Sat, 28 Jun 2025 17:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751132148; cv=none; b=sYRozL6xcNypCtASTuTHb4+waD0081ZwsT2zGHRobolAYQd5gG4X09wYJm+NXAOCMqmK8WwZhJ5ujTig0rFyZgqSq37hzcpjXByHSswmCVrTUyMMm9G1vU1MHtgblfPCwqcouRhg5aAwZfiwm/S2xkMDGvqJiFhLWaseMT6lj9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751132148; c=relaxed/simple;
	bh=UXhHbQsaH5BObS0S9K1Nbq3kty+/MtaUifa7qqkMuAw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZAzXtQQiuCCsHT03u1525T3Q7FuXJbRullwlm+ueT2Ml4Gds2AOn8bbL/p3JAm4COO6XFj9c0xeTKMSLXf5laqNlNEa94Oe6RcHvKfze+bH0vYtT+UCQ9xckEGMBgcehU7BRI1f/NQzn7Ocd8uxsKCEEesx6JLXkHaI7X3My3p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lu6opnum; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6119cd1a154so495175eaf.0
        for <linux-iio@vger.kernel.org>; Sat, 28 Jun 2025 10:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751132145; x=1751736945; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jVKsTd69QDg1pS/BuRC3rNLL7OUDxdS29NeSVG86pDU=;
        b=lu6opnum2wK1tcc2Pg8Jhl2FdkvS8VMiNWcRO38L1EE6hFQFmzKCTk+36J5Z3PcruU
         XOysccEZ18OTehEWtKuRJFrTFk8/wyJfESKAi3a5Qni5M5f5BMpjJEUn58oIJyrcFEbo
         CzAl8CjV3sy5csoDkLnG00Z45H/8BC2Nbb4mGmbuEtGcVhemYmAGN7TosD1KZkKKZRfj
         QFuQbmSbCSZIFMAQ1iXaCmn/cucXI8m9D8D/RW2/At+fNiYTKiZa9P1Cuo7SYbGP2YOM
         kHh2o8lxuJ56g8vgm+xp3YNxzNFHJmopNl1A5nH6MRMA16o2kgNr0FzJHmOa/sdAhFtK
         wyBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751132145; x=1751736945;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jVKsTd69QDg1pS/BuRC3rNLL7OUDxdS29NeSVG86pDU=;
        b=VCqypckgwM2qiOtWQn00SOInPuoRaAjRk/oNTI8zuvnJqYjHCn0PI+aSwjDWdtgmkl
         kpFbQlQPfGZEZmg9R+6pWE8TLMt791J2UKtWfVz9xuXky31fe0LVrCmyA1IRZrGwFGcK
         EDZ2kBgWPHILAdcHXwAvkyjVJgK3Sv3/6etQCnMLvibTSwzBbccqMd6AQOfq/WyhTlK4
         CSWx8fAjn9ILA7mwLCc15JPGqhN9iLd6XxjjDGoYiPLgpp8GvmvaSKYIbdzeyXhpCt7T
         i9QncYJtSnEJ4d7MLO+bfoPAga7RgNwifMhaQFdu614tuTkkcKbtXn+fgX9rw40IdGg+
         DaIA==
X-Gm-Message-State: AOJu0YxDGFJYgpmascMNHjQTUiJ8k+mrAo0BxwDUu++M4QUnXCYvr679
	yXSO55YJzXQ8tuGoRUlS7/VaaNVXHJVJWR267qp4l+YOulUvtP+SLDRT9/pBr4u5e5M=
X-Gm-Gg: ASbGncuA+HMh4eXxJNC5VGYMTBHhXjQ3dHrQ2sIrKS7WAhk7wEMQz1ZA4sqXB16RVWZ
	OTuSBjD8ZNmEBPn2l+WYXbiWGtaApUUztEm13Ucgt1T0YiGTVE5W081Z4ry+sjD4btsGBqao4tj
	bdrAfUxLMhwfmWpb9Gp9Y2hwteHYyK7+9Mj3x1wVCU2kcT3qvfO+7kDEOUZys3srRh4jucFr4hy
	ofZJXvkFGahGwJj/mFMQBMAD3CP5cIc32Gjed9l/TK+cl1nTguh/FnXZKyYy9A2aGO0dqsoewd5
	QXCS6VE9s/ju7lli4PGbU/Mil6cKE+Dy2QF43W+NwIysXrO/4PnyBG2tqXIAqv41adEg
X-Google-Smtp-Source: AGHT+IHx5DBpG9P7FRRarN8Ib5d8Mpbv/uY2k5r8JnP5vjt2sq6ejamcExVbwX4WIj2s+PVp3+c59A==
X-Received: by 2002:a05:6870:f22a:b0:2c2:d2b8:e179 with SMTP id 586e51a60fabf-2efed451d4fmr5476724fac.4.1751132145342;
        Sat, 28 Jun 2025 10:35:45 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:3092:a48c:b0c6:cbf4])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2efd50f852bsm1618771fac.33.2025.06.28.10.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jun 2025 10:35:45 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Sat, 28 Jun 2025 12:35:36 -0500
Subject: [PATCH] iio: imu: bno055: make bno055_sysfs_attr const
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250628-iio-const-data-19-v1-1-a17e7c16b122@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAOcnYGgC/x2MQQqAIBAAvxJ7bkEFQ/tKdBBday8aKhGEf086D
 sPMC5UKU4V1eqHQzZVzGiDnCfzp0kHIYTAoobRYlEHmjD6n2jC45lBaVNZ4YcLQUcPorkKRn/+
 57b1/8lR5jmMAAAA=
X-Change-ID: 20250628-iio-const-data-19-298c08d506f5
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4721; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=UXhHbQsaH5BObS0S9K1Nbq3kty+/MtaUifa7qqkMuAw=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoYCfpHsraJFSIki9rdFtHVHLzdH6C14ENP/uTJ
 dKWuhn/BiGJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaGAn6QAKCRDCzCAB/wGP
 wCKkB/0XQoSlqiIVoOWGEvcdVBef2qWOpqVpkA5l3rzSaFXQvbAlOBSSTrgumX/ex5aj89+RMFo
 ApW2TGUJfBdMwF0OJk56EZQNujJZJBi9QO0rl3jjKTpd9KuYln42o4grz+gKbBW1nBYFV7NdMAa
 NBy0s/fyu8nw48haUlswxRxIca7Cit2TYGQNQCzynJXQsNYG344uMYae3f+B96C2SinCrUwz5dB
 fABxw/dE5ptPna0EQEVyYl0a1AeLHVnZjNEAVRGDqneZDzGnCk8/pPio8MvOgIT918vf8sndLL3
 cVwybOm66mooJX8fpPmKlu6zr39Dra2P/ZU3dxtm82k3/CAf
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add const qualifier to struct bno055_sysfs_attr and its array fields.
All of this is read-only data so it can be made const.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/imu/bno055/bno055.c | 47 ++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/imu/bno055/bno055.c b/drivers/iio/imu/bno055/bno055.c
index 3f4c18dc3ee983fe3c5569406a2c6350b0cc756c..09912c7cbe29cee3ce451fe6b78a8672d71fe2a3 100644
--- a/drivers/iio/imu/bno055/bno055.c
+++ b/drivers/iio/imu/bno055/bno055.c
@@ -114,31 +114,31 @@
 #define BNO055_UID_LEN 16
 
 struct bno055_sysfs_attr {
-	int *vals;
+	const int *vals;
 	int len;
-	int *fusion_vals;
-	int *hw_xlate;
+	const int *fusion_vals;
+	const int *hw_xlate;
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
 	.fusion_vals = (int[]){3924}, /* 4G */
@@ -165,33 +165,33 @@ static struct bno055_sysfs_attr bno055_acc_range = {
  *     = hwval * (dps_range/(2^15 * k))
  * where k is rad-to-deg factor
  */
-static int bno055_gyr_scale_vals[] = {
+static const int bno055_gyr_scale_vals[] = {
 	125, 1877467, 250, 1877467, 500, 1877467,
 	1000, 1877467, 2000, 1877467,
 };
 
-static struct bno055_sysfs_attr bno055_gyr_scale = {
+static const struct bno055_sysfs_attr bno055_gyr_scale = {
 	.vals = bno055_gyr_scale_vals,
 	.len = ARRAY_SIZE(bno055_gyr_scale_vals),
-	.fusion_vals = (int[]){1, 900},
-	.hw_xlate = (int[]){4, 3, 2, 1, 0},
+	.fusion_vals = (const int[]){1, 900},
+	.hw_xlate = (const int[]){4, 3, 2, 1, 0},
 	.type = IIO_VAL_FRACTIONAL,
 };
 
-static int bno055_gyr_lpf_vals[] = {12, 23, 32, 47, 64, 116, 230, 523};
-static struct bno055_sysfs_attr bno055_gyr_lpf = {
+static const int bno055_gyr_lpf_vals[] = {12, 23, 32, 47, 64, 116, 230, 523};
+static const struct bno055_sysfs_attr bno055_gyr_lpf = {
 	.vals = bno055_gyr_lpf_vals,
 	.len = ARRAY_SIZE(bno055_gyr_lpf_vals),
-	.fusion_vals = (int[]){32},
-	.hw_xlate = (int[]){5, 4, 7, 3, 6, 2, 1, 0},
+	.fusion_vals = (const int[]){32},
+	.hw_xlate = (const int[]){5, 4, 7, 3, 6, 2, 1, 0},
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
 
@@ -548,7 +548,8 @@ static const struct iio_chan_spec bno055_channels[] = {
 };
 
 static int bno055_get_regmask(struct bno055_priv *priv, int *val, int *val2,
-			      int reg, int mask, struct bno055_sysfs_attr *attr)
+			      int reg, int mask,
+			      const struct bno055_sysfs_attr *attr)
 {
 	const int shift = __ffs(mask);
 	int hwval, idx;
@@ -577,7 +578,8 @@ static int bno055_get_regmask(struct bno055_priv *priv, int *val, int *val2,
 }
 
 static int bno055_set_regmask(struct bno055_priv *priv, int val, int val2,
-			      int reg, int mask, struct bno055_sysfs_attr *attr)
+			      int reg, int mask,
+			      const struct bno055_sysfs_attr *attr)
 {
 	const int shift = __ffs(mask);
 	int best_delta;
@@ -758,7 +760,8 @@ static int bno055_read_simple_chan(struct iio_dev *indio_dev,
 	}
 }
 
-static int bno055_sysfs_attr_avail(struct bno055_priv *priv, struct bno055_sysfs_attr *attr,
+static int bno055_sysfs_attr_avail(struct bno055_priv *priv,
+				   const struct bno055_sysfs_attr *attr,
 				   const int **vals, int *length)
 {
 	if (priv->operation_mode != BNO055_OPR_MODE_AMG) {

---
base-commit: 14071b9cf2d751ff9bc8b5e43fa94fbf08aceea1
change-id: 20250628-iio-const-data-19-298c08d506f5

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


