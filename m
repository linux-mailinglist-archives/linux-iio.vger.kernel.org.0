Return-Path: <linux-iio+bounces-24751-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEB0BB96E2
	for <lists+linux-iio@lfdr.de>; Sun, 05 Oct 2025 15:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BCFB18979FA
	for <lists+linux-iio@lfdr.de>; Sun,  5 Oct 2025 13:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB3E296BAA;
	Sun,  5 Oct 2025 13:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="JMeH+6Cd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259D52882CC;
	Sun,  5 Oct 2025 13:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759669996; cv=none; b=GyPg5KXodtQcV4CJ8GSK1gpGQjDy6AHJEpBQtzI/3mjruT7y4tS+roBRXEhYyL/FnsXdrqbjTdQQCwhk3S/t4A0rZrzQEe9djALDnnkV8f0Pwv+zCB9JoMxKhK/QPVB8/PR+oeTZaBX/SEOJbXBuJAhAiJvAH//XtqXP6OKPxKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759669996; c=relaxed/simple;
	bh=Cr5yCqlqwxcx8TbSWAbTEX7W4rNpVRq41ROaWboQjtM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HyOIy9YXPwd9PKcqyB1Opo7+ntZAdNyNXH/4CMSx3shGtFUNTfMROGVbt95utP1jHwUhfbyfz/tVdI/RqnSGV4+wk/hcumCxapnQIAO4c6u9YAKeYnZv/YvPblarnMuTQN3czUu991OXao7CJC51YVht4upTwXCZvB2xDzFAo9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=JMeH+6Cd; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from [10.212.0.13] (unknown [IPv6:2a02:2f0e:3e0c:5b00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 7E576173BF9;
	Sun, 05 Oct 2025 16:13:06 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1759669986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y29vDzVout/ALq4vqu39VhS/cwV3LKAo3f/aaUbkGGc=;
	b=JMeH+6CdvHcg2O5LuLb8gXdp6L/Plj3syLkL6GmEtLuiAMNRAxO9uSperDED44JTp8nP51
	SpILXfquIt/Nn4ZPKFqqKBiFng4nBpRyMYtoYaLI9Qez48oufp7gC5pvzTPsC+Ygo6pKmA
	s84WxvI57bQahk0FZx9cxE6fplYpx7qY0JuBVYkbrsIshaFtq7OU6pvf7hhx9o+MWV37fR
	t1BNllHlT8PXocnaz+DCdF/MRnVBMezuN2Qj/2Euo38fiDElh4gZGXGUvUYbrzv7t1LzVx
	8Ceo4MHmYqBrJ5MlJcw/d+Ixw24Qr3nRJ6Nogr37w3bMwNIwnjy7QTqkFA2k7Q==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Sun, 05 Oct 2025 16:12:26 +0300
Subject: [PATCH v4 17/19] iio: accel: bma220: add LPF cut-off frequency
 mapping
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251005-b4-bma220_improvements-v4-17-0f449ba31585@subdimension.ro>
References: <20251005-b4-bma220_improvements-v4-0-0f449ba31585@subdimension.ro>
In-Reply-To: <20251005-b4-bma220_improvements-v4-0-0f449ba31585@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4224;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=Cr5yCqlqwxcx8TbSWAbTEX7W4rNpVRq41ROaWboQjtM=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2ppYnRiVFpFWUdibEZuT0pHWGExa09LVDY0ClZiZ2hCTWY0QWFZQWR5VkNv
 QVlWNm9rQ013UUFBUW9BSFJZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKbzRtN1d
 BQW9KRUhRcko2ZGpPa2xqcU5FUUFKMzNOMkxNbUljUmJwRzFoeVhzQ2R4Wms1Rm85RkZUeGtRRQ
 plTWZlQzJQKzdXdDFJdS9lUTc5YUJ5K3FlQ0Z4aXVUK0h3MEZ2eUphaSs5SFZDVlc0RzkxK3VCM
 08rUlVXbWJaClhJZGQ4UGluc05CVVNDODBtSERraXJ4QUp0R2FHK2JRakNuNUR2NnNZazIwcmJl
 OXVmYmZjNWpIOE8yZ0dHaWkKazd2eGVVTlpQK2ZNUHVsWTFhYU91cnlDNURxb3N2Z2M1WU1HU2E
 1SzRabkFneG1KRXU0bXU4cWkxcjJzVmVWUApRRFErWkNobUhtUjAvdEg5aXdjb1gwbVJneTNZaU
 hUNC91allMQ0xGMVRmeVFmcHlVSUozZFdYdHdVeVVqb1d6ClNTS3BOOTJQb2l5dHZtQndxRnd3d
 jRzRDR4TFU5SDlORnNrZmRLVkNyNDI3TDlEOVZDSDg3Zk0vS1doa1RsNFIKbnFGa1k2MWxRNnF5
 b2lVWmlaemF2Y3h1dUNyaFd2dXViUFpnZ3FMVzVOSk1OdmNQREpBSzQ1SzNwMVdmaTNMZAoxZG1
 ENks3cHM4S3J3d3pEUWlMeUxkU3FaaTdrWWljNldsY2l4YkJoOGs3VmxESGg4clZVbk0wbno5Yy
 s4dXlkCnJLWkZVNTFnVituQkU5QlRNNnM3MnIyS0x5djlGNExVVmZjc1BySGtqNlNkOTFoOFBIT
 FBsUk8xYlJ6QWZXdzQKZTRLangrSnB5d005bFU3Nlo3OWRwUE4wZmpQZzEyVHdncDF1OXVRQm0x
 SmhkT1p5L0taVzY3Y291VGlWTmVoRwpGZVYycWE0OEZ6RDVSNThrNU16MGY1dEpkcXdCcmcwbTN
 kT2x4TzJjVUxpUUZ1Q2VmUGg3b2VEVDBFZjEzOGVNClJTNzZVcjN4eFhzNEVBPT0KPThMSWMKLS
 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Add mapping for the low pass filter cut-off frequency.
Make valid values visible for both the cut-off frequency and the scale.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v1->v2 rename variables to include unit capitalization (dB, Hz)
v2->v3 make comment one-liner (Jonathan)
v4 no change
---
 drivers/iio/accel/bma220_core.c | 59 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/bma220_core.c b/drivers/iio/accel/bma220_core.c
index 8f0cbd0aacb92a21afc57aaa350547d0c767d4b6..7109759e28397d2660f17707124a8803a254cb14 100644
--- a/drivers/iio/accel/bma220_core.c
+++ b/drivers/iio/accel/bma220_core.c
@@ -93,13 +93,23 @@
 
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
@@ -123,6 +133,7 @@ static const int bma220_scale_table[][2] = {
 struct bma220_data {
 	struct regmap *regmap;
 	struct mutex lock;
+	u8 lpf_3dB_freq_idx;
 	u8 range_idx;
 	struct iio_trigger *trig;
 	struct {
@@ -139,6 +150,16 @@ static const struct iio_chan_spec bma220_channels[] = {
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
@@ -253,6 +274,10 @@ static int bma220_read_raw(struct iio_dev *indio_dev,
 		*val = bma220_scale_table[index][0];
 		*val2 = bma220_scale_table[index][1];
 		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		index = data->lpf_3dB_freq_idx;
+		*val = bma220_lpf_3dB_freq_Hz_table[index];
+		return IIO_VAL_INT;
 	}
 
 	return -EINVAL;
@@ -271,6 +296,18 @@ static int bma220_find_match_2dt(const int (*tbl)[2], const int n,
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
@@ -296,6 +333,21 @@ static int bma220_write_raw(struct iio_dev *indio_dev,
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
 
@@ -313,6 +365,11 @@ static int bma220_read_avail(struct iio_dev *indio_dev,
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


