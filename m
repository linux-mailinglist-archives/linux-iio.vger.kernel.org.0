Return-Path: <linux-iio+bounces-23924-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F15C2B5103D
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 10:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE5BA46137F
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 08:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390EC311591;
	Wed, 10 Sep 2025 07:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="YjdYGZqz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0E830F94C;
	Wed, 10 Sep 2025 07:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757491095; cv=none; b=GEfufRdb84TnaWC+GmAdJtVuN/qd5nlrytmMNi+ycr1/710swXRt51F442Meqrx3Hvab9rpbHNDYEg7Ojt7dOAkUiABajEGucfEZaf5UgkRgMLNNI5b7tcCtWlcolBeWIc/Z6Cchqq1tK671IzD7Z9apgd711Inzgeysx6Z3eGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757491095; c=relaxed/simple;
	bh=409ZBhNOe9HaBHJimTYFEu+sSb/2bn/ZWFfpFbcTf1w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X5Dj2CVrcXqMo7Gp8be7c9/knTE31HMdIq25lZCPORl3b8hCm6hAMLiPM+FaBU2QYlF1a0+61Cg5mfdpb1Ri8ycU2fqB34St7/9i8reUVx37uoG+R1SOdpFEfjXcShIgzqfMttbPvVLGTEbzlzeByrCzA6Mj5QFCkgPbNRhM5Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=YjdYGZqz; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from [10.212.0.13] (unknown [IPv6:2a02:2f0e:3503:4a00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id D2CFB173BF4;
	Wed, 10 Sep 2025 10:58:06 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1757491087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+au2rMrozozcPYNNCeRGGmu+HJEQku2dK2UlpDdDD10=;
	b=YjdYGZqzPatLMlFfdoD0jHPJW0Muix+bQANFwWp7VhlQScuRisY1RQ9stfreaNgmb8O3kd
	ZrNdibf+NkYl4e1TStu980OkwWcv3Venms6YCgIk/te/Djhy32zidPYtzTK5/3cpnCmIva
	KU4jHxDNtehWBRfCzk8VW2H7ZqRulGhdsRhnuzRkQ7JEsv89hRZ0enekmnwN0NX0/vZrW9
	wW6a6mHJdxkXCm25cjOViPkKg8n50uWRthV8mLZJpz2547SlH2ujnlfJqWosEpS+8YMphQ
	D/adczSgXmN55vH+Tfb5EMCgLVAZGgUVgvdPGUofpAbdyygqES2J5YVmRUNCow==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Wed, 10 Sep 2025 10:57:17 +0300
Subject: [PATCH v2 12/14] iio: accel: bma220: add LPF cut-off frequency
 mapping
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-bma220_improvements-v2-12-e23f4f2b9745@subdimension.ro>
References: <20250910-bma220_improvements-v2-0-e23f4f2b9745@subdimension.ro>
In-Reply-To: <20250910-bma220_improvements-v2-0-e23f4f2b9745@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Petre Rodan <petre.rodan@subdimension.ro>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4159;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=409ZBhNOe9HaBHJimTYFEu+sSb/2bn/ZWFfpFbcTf1w=;
 b=owEBbQKS/ZANAwAIAc8mmZmETn8wAcsmYgBowS+HPCm0ikiLEQiLjqX1m/wkknHGFhxjAzzgV
 mKupNDtEwiJAjMEAAEIAB0WIQTYCn/BdhUZNew+X6nPJpmZhE5/MAUCaMEvhwAKCRDPJpmZhE5/
 MA/yD/9ktP9s1b0h5lB6+PbbhaqMusltawg+V8AZBlmm5tdKQx4f+7nb2JkULMWMXysQszElD4c
 uFBoOzdY6V/b0ezGlLoezS5dZcEQvQ86c29ks2lyBQL75NYG/stblb/MUhS0oiZt/8yDX+lz+BI
 RDa0cc4t0MU9q3lHaHXTI9Km8DXycWshUG25uy/JBCDXhC3gsnmzs+XWlQFkB1OJiadMvzaVzov
 fkBo7jjUTDIpv52ygJA4FEEAFYlv9Qlz9sC4M8ze1eWYEHA9YSkfkNW5a4plUiEPNoB/RGCVKC8
 5Ur6P8s5jR24DNbqyhEqq4UrUoyzAcaAoHBAQvNYe5ndw0Eo166YHuKWIESTNEcwcHOqvcHp+Uc
 dTVRibGA8sqHqZ27QdnxzS2gdpMUlS9cYTXVeP2DnTKuXwKXMEFTeplrDbmWO4iBcVrI9EavafF
 x59k1E9ne6IQ/5CWnd1XsdPqSyHyhZUuQ90n16mJr2pR6CkBjUrdk3UkPwXN26FZKOOl1TMmAtA
 2TU/v3OasMlPOtBcSGGaQvBWONLSFikvMaVYdce9r8XBQ9pJ7564eXpVx9khuH7ZDLHLgonFn7D
 s6Z7/X5dXOoaA6JNIVa44TYDepTGO48WI+rQeXUTVkpbZdUG61UuMcScOoT40iC6umfc4Obax0h
 Nn2AkB0zwUt8Weg==
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Add mapping for the low pass filter cut-off frequency.
Make valid values visible for both the cut-off frequency and the scale.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
ChangeLog:
- rename variables to include unit capitalization (dB, Hz)
---
 drivers/iio/accel/bma220_core.c | 61 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 60 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/bma220_core.c b/drivers/iio/accel/bma220_core.c
index 69bfd7f9f2b35e67835c6e1e41e02258e6741e7b..16a1aac5aa178ec06dc26e7e632f8ec5f43b5f78 100644
--- a/drivers/iio/accel/bma220_core.c
+++ b/drivers/iio/accel/bma220_core.c
@@ -95,13 +95,23 @@
 
 #define BMA220_DEVICE_NAME			"bma220"
 
+#define BMA220_COF_1000Hz			0x0
+#define BMA220_COF_500Hz			0x1
+#define BMA220_COF_250Hz			0x2
+#define BMA220_COF_125Hz			0x3
+#define BMA220_COF_64Hz				0x4
+#define BMA220_COF_32Hz				0x5
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
@@ -126,6 +136,7 @@ struct bma220_data {
 	struct device *dev;
 	struct regmap *regmap;
 	struct mutex lock;
+	u8 lpf_3dB_freq_idx;
 	u8 range_idx;
 	struct iio_trigger *trig;
 	struct {
@@ -142,6 +153,18 @@ static const struct iio_chan_spec bma220_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(3),
 };
 
+/*
+ * Available cut-off frequencies of the low pass filter in Hz.
+ */
+static const int bma220_lpf_3dB_freq_Hz_table[] = {
+	[BMA220_COF_1000Hz] = 1000,
+	[BMA220_COF_500Hz] = 500,
+	[BMA220_COF_250Hz] = 250,
+	[BMA220_COF_125Hz] = 125,
+	[BMA220_COF_64Hz] = 64,
+	[BMA220_COF_32Hz] = 32,
+};
+
 static const unsigned long bma220_accel_scan_masks[] = {
 	BIT(AXIS_X) | BIT(AXIS_Y) | BIT(AXIS_Z),
 	0
@@ -255,6 +278,10 @@ static int bma220_read_raw(struct iio_dev *indio_dev,
 		*val = bma220_scale_table[index][0];
 		*val2 = bma220_scale_table[index][1];
 		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		index = data->lpf_3dB_freq_idx;
+		*val = bma220_lpf_3dB_freq_Hz_table[index];
+		return IIO_VAL_INT;
 	}
 
 	return -EINVAL;
@@ -273,6 +300,18 @@ static int bma220_find_match_2dt(const int (*tbl)[2], const int n,
 	return -EINVAL;
 }
 
+static int bma220_find_match(const int *arr, const int n, const int val)
+{
+	int i;
+
+	for (i = 0; i < n; i++) {
+		if (arr[i] == val)
+			return i;
+	}
+
+	return -EINVAL;
+}
+
 static int bma220_write_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int val, int val2, long mask)
@@ -298,6 +337,21 @@ static int bma220_write_raw(struct iio_dev *indio_dev,
 			return ret;
 		data->range_idx = index;
 
+		return 0;
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		index = bma220_find_match(bma220_lpf_3dB_freq_Hz_table,
+					  ARRAY_SIZE(bma220_lpf_3dB_freq_Hz_table),
+					  val);
+		if (index < 0)
+			return -EINVAL;
+
+		ret = regmap_update_bits(data->regmap, BMA220_REG_FILTER,
+					 BMA220_FILTER_MASK,
+					 FIELD_PREP(BMA220_FILTER_MASK, index));
+		if (ret < 0)
+			return ret;
+		data->lpf_3dB_freq_idx = index;
+
 		return 0;
 	}
 
@@ -315,6 +369,11 @@ static int bma220_read_avail(struct iio_dev *indio_dev,
 		*type = IIO_VAL_INT_PLUS_MICRO;
 		*length = ARRAY_SIZE(bma220_scale_table) * 2;
 		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		*vals = (const int *)bma220_lpf_3dB_freq_Hz_table;
+		*type = IIO_VAL_INT;
+		*length = ARRAY_SIZE(bma220_lpf_3dB_freq_Hz_table);
+		return IIO_AVAIL_LIST;
 	default:
 		return -EINVAL;
 	}

-- 
2.49.1


