Return-Path: <linux-iio+bounces-24079-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD813B56204
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 17:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C261164BC8
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 15:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606002F99B6;
	Sat, 13 Sep 2025 15:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="LufokHwa"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB55B2F60C9;
	Sat, 13 Sep 2025 15:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757778021; cv=none; b=ULpU8PYt9hz1G2E9ZIckXxZ9oG0phL/G/JElEPmFpRVPJNXQDtjw/qKHD1faFsaY+uoZPJ/vyz3AXThCsEt90gVcXgZhg6C5P0nCBiWo6f+5lTjxirHeagfEju8nFO6hfrJXetmq2Z1OSnqveJIzIL1vKEo98p8vtUGgHOqinnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757778021; c=relaxed/simple;
	bh=sUyLK4mjiPxml6XLVuyl+KqXPWsk9XNuaLa7OgMP9DY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j7ndWIWcv2LjJctsewOWKNxyjRKWnJ38zj1aTsNY8V1wCAvZBMktz+4we8NG8NlycH06UK0f4IiNzfYz40RiRmlZNn+s2/uvDv5DdLcDguz57i0u9qbkZq6cvrDOdnrYXm+v9LGD4hdTc7GH3Du6BGTagn9jA3qZ1ggIw9uzruM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=LufokHwa; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from [10.212.0.13] (unknown [IPv6:2a02:2f0e:3e0c:5b00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 5D8DE173BF8;
	Sat, 13 Sep 2025 18:40:11 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1757778011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=84hboF7CiZVHfrjWCxq7XHkJM0RXSj6s0PaFgrkOxYY=;
	b=LufokHwa6+K4ikmLTJiwTXdVjWbytrU+YdVBQNzfx9FBdhsOdpU4cEWhwJwKwiWy+qzE33
	/9LWnIZ1/a3gJ21wuP1tr4lbzw8nuV0qOyq8Brhg6cwh1qxhJiEKATIkeSRRfBvGdH2pPN
	CgtRDYY7doqu5Tbqy0g2iQRsukP/gmtOYTyl1JMRGwBo/nJJ1y3iTSoKJGxbxU9f6AdumM
	DCqNepGoaEgcsPxLXqnYKRjpsPEG6nPtLlZ+0pkoNM2GQr1w6D/qxTkZLpxn1ItIMokDBL
	9t5aWMGfypjaEcpPZM4N5V1m+I1iXOlHJWwP7MqbJ1tKwRbnjCRMSmv6tOMTKg==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Sat, 13 Sep 2025 18:39:37 +0300
Subject: [PATCH v3 16/18] iio: accel: bma220: add LPF cut-off frequency
 mapping
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250913-b4-bma220_improvements-v3-16-0b97279b4e45@subdimension.ro>
References: <20250913-b4-bma220_improvements-v3-0-0b97279b4e45@subdimension.ro>
In-Reply-To: <20250913-b4-bma220_improvements-v3-0-0b97279b4e45@subdimension.ro>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4181;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=sUyLK4mjiPxml6XLVuyl+KqXPWsk9XNuaLa7OgMP9DY=;
 b=owEBbQKS/ZANAwAIAc8mmZmETn8wAcsmYgBoxZBSADDmM2duwKa5lMTwu74KlgE5tph4z3oHe
 5YtI2763M+JAjMEAAEIAB0WIQTYCn/BdhUZNew+X6nPJpmZhE5/MAUCaMWQUgAKCRDPJpmZhE5/
 MIT2EACybHMNu0NhmB6ZoObb0nOl3GxfXLrOxnwDsgNOWOj7dMWzrejPVsIzD3c4QK7BRkK9fWN
 g+CVamykWC2jkcOW3ckg8b9PHqfQ5+KYJjYPPgbFfp9ObqR1JGmkjlzaGCee1DchS8LoN7D0JCe
 5vJ5r5w9g3RK3koRX7QhPdFAxL5XjECy1sIsPxsNmOoJe+Dtrg4Z1hP+Q5Y4Lq3NRwzs0BJswgR
 7T3gUZbHewhD2URiZpFAiIpUu9EIgI/p7FggdfIVKa9Cvi9AN+rpdeYJeEl9H7CRefKbhGDEjZE
 8l27RxhDeJD3U4ScbksK3gzPWDa8K62EYAhV/lvMnj5s6/xnob+EKsCQ1jGdr4jgOT6mnQSb2/C
 um6nVKaFJSniX2Kf+XnUyMfBOP9ijNE2sDVBvHsc7K8+XFaZOC0gjEIeX7xI5/Oj4PoktA9fF/O
 yllBL1qHRVw8b9kDr5U5p/iab/gSxfMQ3KXKSLICWQmyeD0dl2Lt7+4uyZmyrIseEnMNEveSw3w
 if/BFhHlLMJf/2K+4UNbbY4bUuizudMzP7Uv7AK8Uq4JhjDgkyUupHeH4pMzgFk+wUR7PeeSq0i
 IsLEK6d7DxnQc46xxLQ2ckZ6huLfRQ0Hxc8/FLqo9OkHYdZgwIey7PaSGKDpIcwSjb/1shXzdmN
 fIx1FcnpfY2WslA==
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Add mapping for the low pass filter cut-off frequency.
Make valid values visible for both the cut-off frequency and the scale.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v1->v2 rename variables to include unit capitalization (dB, Hz)
v2->v3 3->1 line comment (Jonathan)
---
 drivers/iio/accel/bma220_core.c | 59 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/bma220_core.c b/drivers/iio/accel/bma220_core.c
index 6297882bcf1b955291a2d8747984648bc6ee8512..508a1142a74b3fb330eea5222c4b0abc8fc37e49 100644
--- a/drivers/iio/accel/bma220_core.c
+++ b/drivers/iio/accel/bma220_core.c
@@ -94,13 +94,23 @@
 
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
@@ -125,6 +135,7 @@ struct bma220_data {
 	struct device *dev;
 	struct regmap *regmap;
 	struct mutex lock;
+	u8 lpf_3dB_freq_idx;
 	u8 range_idx;
 	struct iio_trigger *trig;
 	struct {
@@ -141,6 +152,16 @@ static const struct iio_chan_spec bma220_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(3),
 };
 
+/* Available cut-off frequencies of the low pass filter in Hz. */
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
@@ -254,6 +275,10 @@ static int bma220_read_raw(struct iio_dev *indio_dev,
 		*val = bma220_scale_table[index][0];
 		*val2 = bma220_scale_table[index][1];
 		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		index = data->lpf_3dB_freq_idx;
+		*val = bma220_lpf_3dB_freq_Hz_table[index];
+		return IIO_VAL_INT;
 	}
 
 	return -EINVAL;
@@ -272,6 +297,18 @@ static int bma220_find_match_2dt(const int (*tbl)[2], const int n,
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
@@ -297,6 +334,21 @@ static int bma220_write_raw(struct iio_dev *indio_dev,
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
 
@@ -314,6 +366,11 @@ static int bma220_read_avail(struct iio_dev *indio_dev,
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


