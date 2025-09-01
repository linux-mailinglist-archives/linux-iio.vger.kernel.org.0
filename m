Return-Path: <linux-iio+bounces-23613-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0C3B3EED3
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 21:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A4DD3A7856
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 19:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF2732ED20;
	Mon,  1 Sep 2025 19:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="bJYOUVGh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE26320E011;
	Mon,  1 Sep 2025 19:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756756086; cv=none; b=k9SpN6fGEh5CNPxjh/83GGXslPUZKCq9QXJkWEV8CfZexoFaeuWN0soMgvk3gKIBsEhRckuav+DCmzrJGgYtv9txCoDlyN0WJlhdDoBoVlHpOjJCd6a7ofC21gisGoP/N7JwoJvIZfvrQG++ewans/PsMfyXU1m4awwvks22Jcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756756086; c=relaxed/simple;
	bh=wLmWmflf8u7y40Xzi81r7dRJzmbcJfPGyzoimcWuoDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a403Y34U3irZBQe22YnzNant59ddryAhUWW1yHW6Zo047G8Kgwiu2w9QpVe1FbeRsJKJDH+lMSehPDGO+FKREG2Z+Z2yI5ZQ6Mejv0QSqZuwq0JstUXj7+KdfUkUYmcChjFJauIW/lFOCCOcncD0bU7o3yPSi/vC1E5hBtrWPwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=bJYOUVGh; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from localhost.localdomain (unknown [IPv6:2a02:2f0e:3503:4a00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 9E656173BEE;
	Mon, 01 Sep 2025 22:47:56 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1756756076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=69u6iKKI76eah3bWQ71TVwjN/VHHBc+0BJ2bQX2S/fU=;
	b=bJYOUVGh9IisUx3CTNDqzNswCMJmeO86RnNaUveDT9eDBzrpUmGwXK+hG9F/VXK3mV1RW+
	hwQCRPA8uF+4Ub/t1hORAKqNdTIjJJdJZiRZqWjht+aiFvTHkdTaCxwZtwygb5Q7yeOavN
	aaQUNRqHVEcY/41lFtc2EXdrZ5u+UiNpcAOXJgrQmc+8LZ4g+5t3l30gm3pNkx8IPxv/1q
	7lajN7Lz2UFBjbKzaUhEmIsbI4xyYQZLtCyUFCzq2b09bDl9zF6R+4dhYdqefJ9+HJnGM8
	R5bR8uNRqi2sIyRpFPbN3FeizhaGmbpWhKIi4+zeSko2Lc26ppt/DBw+soZRUA==
From: Petre Rodan <petre.rodan@subdimension.ro>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Petre Rodan <petre.rodan@subdimension.ro>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: [PATCH 06/10] iio: accel: BMA220 add LPF cut-off frequency mapping
Date: Mon,  1 Sep 2025 22:47:32 +0300
Message-ID: <20250901194742.11599-7-petre.rodan@subdimension.ro>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250901194742.11599-1-petre.rodan@subdimension.ro>
References: <20250901194742.11599-1-petre.rodan@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

 - add mapping for the low pass filter cut-off frequency.
 - make valid values visible for both the cut-off frequency and the scale.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
 drivers/iio/accel/bma220_core.c | 60 ++++++++++++++++++++++++++++++++-
 1 file changed, 59 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/bma220_core.c b/drivers/iio/accel/bma220_core.c
index 86347cf8ab1e..e60acd62cf96 100644
--- a/drivers/iio/accel/bma220_core.c
+++ b/drivers/iio/accel/bma220_core.c
@@ -4,6 +4,15 @@
  *
  * Copyright (c) 2016,2020 Intel Corporation.
  * Copyright (c) 2025 Petre Rodan  <petre.rodan@subdimension.ro>
+ *
+ *
+ * Device register to IIO ABI mapping:
+ *
+ * Register                  | IIO ABI (sysfs)                | valid values
+ * --------------------------+--------------------------------+---------------
+ * scale (range)             | in_accel_scale                 | see _available
+ * cut-off freq (filt_config)| in_accel_filter_low_pass_...   | see _available
+ * ---------------------------------------------------------------------------
  */

 #include <linux/bits.h>
@@ -135,13 +144,23 @@

 #define BMA220_DEVICE_NAME			"bma220"

+#define BMA220_COF_1000HZ			0x0
+#define BMA220_COF_500HZ			0x1
+#define BMA220_COF_250HZ			0x2
+#define BMA220_COF_125HZ			0x3
+#define BMA220_COF_64HZ				0x4
+#define BMA220_COF_32HZ				0x5
+
 #define BMA220_ACCEL_CHANNEL(index, reg, axis) {			\
 	.type = IIO_ACCEL,						\
 	.address = reg,							\
 	.modified = 1,							\
 	.channel2 = IIO_MOD_##axis,					\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
-	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
+	    BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),		\
+	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE) |\
+	    BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),		\
 	.scan_index = index,						\
 	.scan_type = {							\
 		.sign = 's',						\
@@ -172,6 +191,7 @@ struct bma220_data {
 	struct device *dev;
 	struct regmap *regmap;
 	struct mutex lock;
+	u8 lpf_3db_freq_idx;
 	u8 range_idx;
 	struct iio_trigger *trig;
 	struct {
@@ -188,6 +208,18 @@ static const struct iio_chan_spec bma220_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(3),
 };

+/*
+ * Available cut-off frequencies of the low pass filter in Hz.
+ */
+static const int bma220_lpf_3db_freq_hz_table[][2] = {
+	[BMA220_COF_1000HZ] = {1000, 0},
+	[BMA220_COF_500HZ] = {500, 0},
+	[BMA220_COF_250HZ] = {250, 0},
+	[BMA220_COF_125HZ] = {125, 0},
+	[BMA220_COF_64HZ] = {64, 0},
+	[BMA220_COF_32HZ] = {32, 0},
+};
+
 static const unsigned long bma220_accel_scan_masks[] = {
 	BIT(AXIS_X) | BIT(AXIS_Y) | BIT(AXIS_Z),
 	0
@@ -309,6 +341,11 @@ static int bma220_read_raw(struct iio_dev *indio_dev,
 		*val = bma220_scale_table[index][0];
 		*val2 = bma220_scale_table[index][1];
 		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		index = data->lpf_3db_freq_idx;
+		*val = bma220_lpf_3db_freq_hz_table[index][0];
+		*val2 = bma220_lpf_3db_freq_hz_table[index][1];
+		return IIO_VAL_INT_PLUS_MICRO;
 	}

 	return -EINVAL;
@@ -353,6 +390,22 @@ static int bma220_write_raw(struct iio_dev *indio_dev,
 				"failed to set measurement range\n");
 		data->range_idx = index;

+		return 0;
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		index = bma220_find_match(bma220_lpf_3db_freq_hz_table,
+					  ARRAY_SIZE(bma220_lpf_3db_freq_hz_table),
+					  val, val2);
+		if (index < 0)
+			return -EINVAL;
+
+		ret = regmap_update_bits(data->regmap, BMA220_REG_FILTER,
+					 BMA220_FILTER_MASK,
+					 FIELD_PREP(BMA220_FILTER_MASK, index));
+		if (ret < 0)
+			dev_err(data->dev,
+				"failed to set low pass filter\n");
+		data->lpf_3db_freq_idx = index;
+
 		return 0;
 	}

@@ -370,6 +423,11 @@ static int bma220_read_avail(struct iio_dev *indio_dev,
 		*type = IIO_VAL_INT_PLUS_MICRO;
 		*length = ARRAY_SIZE(bma220_scale_table) * 2;
 		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		*vals = (const int *)bma220_lpf_3db_freq_hz_table;
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		*length = ARRAY_SIZE(bma220_lpf_3db_freq_hz_table) * 2;
+		return IIO_AVAIL_LIST;
 	default:
 		return -EINVAL;
 	}
--
2.49.1


