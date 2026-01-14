Return-Path: <linux-iio+bounces-27802-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0283DD20602
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 17:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 77A0B3054B01
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 16:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5375A3A7E17;
	Wed, 14 Jan 2026 16:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="Akyk87YY"
X-Original-To: linux-iio@vger.kernel.org
Received: from nalicastle.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7F43A7837;
	Wed, 14 Jan 2026 16:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768409799; cv=none; b=TeCXAT9/WqgwyOmfeDG7U9DPf6yCGfAvMsYE9Nxu0qcNZ821ENWxTmrliC1EydFtgiW9UeRfYbKdn9/+kf3ugHmT77WhcWzLNkedsshslAaZQIqsm5V97hH2xKXUDVoDHOyHTrjokyeYPX71xyhUJT9pB0jMVnbNDx76mEy3UWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768409799; c=relaxed/simple;
	bh=l4oM/PcxnXbvRDYnzqNNnxFnZWLOZuKsGfGJ+F9/GRs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rZijEGCjsifdZ5ZDxEfpUc/IXeXDsqdnUvkO/PrHD+y8bsMUgJgyYeHpIvicj1C+86EPesHZvbx9a4pwByr9zNK5m1kb7AyzXfsERFqsAR4zJjeqIyP0ulsVG7At9kW3HgFY8d9l92m3xtjDNHX8A+t0PV7ZNMyv5Y9Wfatnz5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=Akyk87YY; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire.home.arpa (unknown [IPv6:2a02:2f0e:300:8a00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by nalicastle.subdimension.ro (Postfix) with ESMTPSA id 0132016020F;
	Wed, 14 Jan 2026 18:56:23 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1768409784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mp8j0cHdkzrUS3FrxBmij8zCiF/6rdy71KnbhOUXrjk=;
	b=Akyk87YYOpALWBi+4BMbYuVHzRM8E86VaK2BSxOHFcNLR6nP9Ky2AOBZsuFL2iqx/lkr6q
	NltzXta/PdMDwYc78FAAYjGZCo2w1ntPJknsBHyB6eLDgemRT2Ti4XBFeHPAqyNREYrv2z
	Zbds7yrWjW7pCvt+xsMNN3XN745VPxg3AYVrLcWyPA5usimc/sbuO0CN71ksMDI8jy9aey
	7E5JV2ECvlmVum1nlKcddWaImLI69xe5via+xXXNTgxJ6zMVDmCrg2FbMaiMmAVXx1cXpw
	3JOk5jW59hOh1krddRkHuMpnw+xTEiwYxq8RTYFYzl00c2WmPDDvaAVohLhahA==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Wed, 14 Jan 2026 18:55:34 +0200
Subject: [PATCH v3 05/13] iio: pressure: mprls0025pa: fix pressure
 calculation
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-mprls_cleanup-v3-5-bc7f1c2957c2@subdimension.ro>
References: <20260114-mprls_cleanup-v3-0-bc7f1c2957c2@subdimension.ro>
In-Reply-To: <20260114-mprls_cleanup-v3-0-bc7f1c2957c2@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Andreas Klinger <ak@it-klinger.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Petre Rodan <petre.rodan@subdimension.ro>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3728;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=l4oM/PcxnXbvRDYnzqNNnxFnZWLOZuKsGfGJ+F9/GRs=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFHSkFuYjlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2xueXFBQ0xEMFpGOEg5a1ZwYStBSHNDZ3FtCnhlV2hNVFZqTHpEQldnMWhN
 bURPNG9rQ1R3UUFBUW9BT1JZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKcFo4cWd
 HeFNBQUFBQUFBUUFEbTFoYm5VeUxESXVOU3N4TGpFeExESXNNZ0FLQ1JCMEt5ZW5ZenBKWXltbg
 pELzRobWF1NlJ4R2Q3YnlBQlcwazlmdDFpSWpuWUVWYkJDSVNWRUoyTzVaNEIyczhVVXFndUVvV
 1RuV2krc05MCkFVTEpHSncreTlhME5HQ2hqNHBnV1FzMi93MG1LZ1E0WGZlTFVzS25BWUYvNEsx
 SmZzY09FaFBJK1dWRms0eHYKTXd0UzBPL0xSOE04UmJSa1hBRVVUcnRRb09ueVB3NmZabHY1WU5
 lVUcvbHAxdlNMZGZWNUpCdjRzUlorRGtBOAp2aU55bDVPNU8weVZsMmFXVFFlbDZnUzE0cGZua1
 ZXVTlsUXl5SFQ4Q1VnVzZpSnRDRitnUjNLSTgvUTVCRzV0Ck1veStZdnBqaU9MVjlZMmpEdjh3U
 2lYQVAzM1lCTTd6WTNTeDNyUTdSV0NuSXQrQ2xCUEduNVUxcUpwdldvYW8KSUdtQTM5MWJHam1Z
 WXNibWFRMFVkV1VrUnk3alNZVkRtTEFBTURTUkY3WVRHS01xNHNTZTZveUpubEFUQUtZdApXSjd
 JNUJacWorN0E1ZWpaejZDb1RUbjhiQUUzQ3RvSmFjdHBFYWNDWEFVM0toQWR1S1VGaklOdnhCNG
 VYempUCmxRdHhRZFJMaW1qSUZPeUlEN3BmdHVIUjhEcWE3Tlhzbmg1aHhReTlyN243UUY3OTkyV
 04xYnV1M3NoSXVKOUUKYzZXL3o1dzgySm5KS0V2aldXYkpqYWZJT1g5Z2dKc0hhVEZTMmh3M0Vm
 bEl1T0tjNHJPL1c2ZzJEbG5uNkRaYQpoTjVyRVRxZkJCSURZR1hwOU1VWktSdTVGazRCWThQKzJ
 qY0ZVV3hWQThwZk5ha2tGQXRnQ0Y1a3NVUzhJR0Y1ClBCcG1vUWk3c2dRQzZHU0JXZjJUMTdYZ3
 N4ZlAzbDBscEJ5Nm9SRlB1MXJ6YXhFZUc4MD0KPXQxMC8KLS0tLS1FTkQgUEdQIE1FU1NBR0UtL
 S0tLQo=
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

A sign change is needed for proper calculation of the pressure.

This is a minor fix since it only affects users that might have custom
silicon from Honeywell that has honeywell,pmin-pascal != 0.

Also due to the fact that raw pressure values can not be lower
than output_min (400k-3.3M) there is no need to calculate a decimal for
the offset.

Fixes: 713337d9143e ("iio: pressure: Honeywell mprls0025pa pressure sensor")
Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v1 -> v2 slightly changed commit message, added fixes tag
v2 -> v3 reorder variables
---
 drivers/iio/pressure/mprls0025pa.c | 26 +++++++++++---------------
 drivers/iio/pressure/mprls0025pa.h |  2 --
 2 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/pressure/mprls0025pa.c b/drivers/iio/pressure/mprls0025pa.c
index 6ba45d4c16b3..d4133fef91fa 100644
--- a/drivers/iio/pressure/mprls0025pa.c
+++ b/drivers/iio/pressure/mprls0025pa.c
@@ -59,7 +59,7 @@
  *
  * Values given to the userspace in sysfs interface:
  * * raw	- press_cnt
- * * offset	- (-1 * outputmin) - pmin / scale
+ * * offset	- (-1 * outputmin) + pmin / scale
  *                note: With all sensors from the datasheet pmin = 0
  *                which reduces the offset to (-1 * outputmin)
  */
@@ -313,8 +313,7 @@ static int mpr_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT_PLUS_NANO;
 	case IIO_CHAN_INFO_OFFSET:
 		*val = data->offset;
-		*val2 = data->offset2;
-		return IIO_VAL_INT_PLUS_NANO;
+		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
 	}
@@ -330,8 +329,9 @@ int mpr_common_probe(struct device *dev, const struct mpr_ops *ops, int irq)
 	struct mpr_data *data;
 	struct iio_dev *indio_dev;
 	const char *triplet;
-	s64 scale, offset;
+	s64 odelta, pdelta;
 	u32 func;
+	s32 tmp;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
@@ -405,17 +405,13 @@ int mpr_common_probe(struct device *dev, const struct mpr_ops *ops, int irq)
 	data->outmin = mpr_func_spec[data->function].output_min;
 	data->outmax = mpr_func_spec[data->function].output_max;
 
-	/* use 64 bit calculation for preserving a reasonable precision */
-	scale = div_s64(((s64)(data->pmax - data->pmin)) * NANO,
-			data->outmax - data->outmin);
-	data->scale = div_s64_rem(scale, NANO, &data->scale2);
-	/*
-	 * multiply with NANO before dividing by scale and later divide by NANO
-	 * again.
-	 */
-	offset = ((-1LL) * (s64)data->outmin) * NANO -
-		  div_s64(div_s64((s64)data->pmin * NANO, scale), NANO);
-	data->offset = div_s64_rem(offset, NANO, &data->offset2);
+	odelta = data->outmax - data->outmin;
+	pdelta = data->pmax - data->pmin;
+
+	data->scale = div_s64_rem(div_s64(pdelta * NANO, odelta), NANO, &tmp);
+	data->scale2 = tmp;
+
+	data->offset = div_s64(odelta * data->pmin, pdelta) - data->outmin;
 
 	if (data->irq > 0) {
 		ret = devm_request_irq(dev, data->irq, mpr_eoc_handler, 0,
diff --git a/drivers/iio/pressure/mprls0025pa.h b/drivers/iio/pressure/mprls0025pa.h
index d62a018eaff3..b6944b305126 100644
--- a/drivers/iio/pressure/mprls0025pa.h
+++ b/drivers/iio/pressure/mprls0025pa.h
@@ -53,7 +53,6 @@ enum mpr_func_id {
  * @scale: pressure scale
  * @scale2: pressure scale, decimal number
  * @offset: pressure offset
- * @offset2: pressure offset, decimal number
  * @gpiod_reset: reset
  * @irq: end of conversion irq. used to distinguish between irq mode and
  *       reading in a loop until data is ready
@@ -75,7 +74,6 @@ struct mpr_data {
 	int			scale;
 	int			scale2;
 	int			offset;
-	int			offset2;
 	struct gpio_desc	*gpiod_reset;
 	int			irq;
 	struct completion	completion;

-- 
2.52.0


