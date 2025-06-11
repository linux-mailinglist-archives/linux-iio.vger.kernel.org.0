Return-Path: <linux-iio+bounces-20429-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17478AD54C0
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 13:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDDD816BA38
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 11:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338F6280005;
	Wed, 11 Jun 2025 11:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="GoQZ5liL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613AE27FD61;
	Wed, 11 Jun 2025 11:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749642749; cv=none; b=ZDShzbZm/Atm03GK68k+mJ63HJxf2Xj/zJWarwGtVNLB94NCBrk1Dr8M3yD/eGTgKZVT03aYXzRq2Oqm19Iv1TUU+W56ruB4lQV4pVYVFO6djUJOwxZGmiV9TZK/hOo/+Ok1EBCnwBQdYIvRRNR7LPNDJD6ZUYc8GQXhNQV9mKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749642749; c=relaxed/simple;
	bh=KH/uGcpNKe59M/jW/2zmh03X9SdcLuGi4pvUOPA+2Ow=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OkSdQSYX//9/VNOVVUsryBA4v8JvYfgLZZAlbwVC60kg9t/w06gm3JKPNkILG2hG8ADlryKMhuB3HZzLfERk2zTQJe2Q3JSQo2/7r70vBgLJEjlW5+HwjJ3AOoE4aPnFUQav4RDwAOmZCuT3avLEAvMIA81WR3F5gVjFZQJ9/Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=GoQZ5liL; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55B91kIT016838;
	Wed, 11 Jun 2025 07:52:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=GMgjx
	Ty8mOIqGeKQIWqHPAdxYMsS577jy6J6Gp+hMsY=; b=GoQZ5liL6xnURxbggqDUL
	YkidED1I9PfboD/fhN15FksXihm8y3BuDKcUp2aoqmQ/nSmbE4lj39Eh9zhcmnEj
	hQSCrbjhGIlCv/ZkhW8C0/kuNeVZ6yzPce33/A7sHt+jtbj73WrZ1cIfUG+sUp7I
	oxpGrbAK2A8AI2Sz32Ep08xUbMrdeBiW4QjHCtAbNf+gEIXUIF7DBq9Ax4yVhmtj
	kDc+KuoGKQkgtPZRDH+jSVVXcnuR+KTfcHYIRH3fKg+up2qyB0j3nzmwEsUH+fZl
	6AAAQ0ahmwLsW/CZRpDbrxEfABbHGjCwO2ExnxleCqqK9/f5YUk4ajm8yArlL/At
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4776tdgvxa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 07:52:21 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 55BBqKK4031772
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 11 Jun 2025 07:52:20 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 11 Jun
 2025 07:52:20 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 11 Jun 2025 07:52:20 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 55BBq5P2008952;
	Wed, 11 Jun 2025 07:52:08 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <andy@kernel.org>,
        <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
        <marcelo.schmitt@analog.com>, <jic23@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>, <linus.walleij@linaro.org>,
        <brgl@bgdev.pl>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <jonath4nns@gmail.com>, <dlechner@baylibre.com>
Subject: [PATCH v11 11/11] iio: adc: ad7768-1: add low pass -3dB cutoff attribute
Date: Wed, 11 Jun 2025 08:52:03 -0300
Message-ID: <804d66f1858014d7278aec3344d81c223661e878.1749569957.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1749569957.git.Jonathan.Santos@analog.com>
References: <cover.1749569957.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: vgMbvfqAqX-kArYpl0uX7CHp_vR_oTaR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDEwMSBTYWx0ZWRfXyJ4XMfagPp8u
 YopnYcjE8oY+G5emYpQVghHy6t8dcrJfZLzKwb2Y3e0xIE+3gba0F63Kifozfx6M67kxX6JBbbF
 OoscrbUAeqayH6VfutFG60wmdBCN2R6LiX6itywXwd3iUuEgjqHpRlLfLzVk7/SK+pECXBJpTNz
 lC/V35d/S1vNETHWdjIW2kqNWJCSQxPG6QPWyzSzFEHP2SFQz28wQy7aQEs2bBCOpAvTKGzyIwN
 0tiA1GzXfWeUCFdiFVhX8lndMb+8swjTbwAK50xJMqMIn4xXLFB6pjSJ0A/itr+oY4nA0jbVXB6
 TNkFpEGsKcn0ZtjnR+FKqo1ukYhyrwYwEYj3jeMLKYSnjrA45vfY5g5b3xFvpMrfQIzxNyUdel8
 qEXshWmNNhwtfSgMr+PWrcKqCPavvJUnXYEc9oLSolXq+Kt3o8iXfqJuq2+8uuRiLwX2zJ8V
X-Authority-Analysis: v=2.4 cv=BezY0qt2 c=1 sm=1 tr=0 ts=68496df5 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=6IFa9wvqVegA:10 a=gAnH3GRIAAAA:8 a=IpJZQVW2AAAA:8 a=UvUlGJLpmzXXuVQgGPIA:9
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: vgMbvfqAqX-kArYpl0uX7CHp_vR_oTaR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_05,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 spamscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506110101

Ad7768-1 has a different -3db frequency multiplier depending on
the filter type configured. The cutoff frequency also varies according
to the current ODR.

Add a readonly low pass -3dB frequency cutoff attribute to clarify to
the user which bandwidth is being allowed depending on the filter
configurations.

Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
v11 Changes:
* Applied suggestions from Andy.

v10 Changes:
* None

v9 Changes:
* Rearranged new BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) to
  make the diff look cleaner.

v8 Changes:
* None

v7 Changes:
* None

v6 Changes:
* None

v5 Changes:
* None

v4 Changes:
* None

v3 Changes:
* None

v2 Changes:
* New patch in v2.
---
 drivers/iio/adc/ad7768-1.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 291ed801a8a0..e4716e20fcdf 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -152,6 +152,14 @@ enum ad7768_scan_type {
 	AD7768_SCAN_TYPE_HIGH_SPEED,
 };
 
+/* -3dB cutoff frequency multipliers (relative to ODR) for each filter type. */
+static const int ad7768_filter_3db_odr_multiplier[] = {
+	[AD7768_FILTER_SINC5] = 204,		/* 0.204 */
+	[AD7768_FILTER_SINC3] = 262,		/* 0.2617 */
+	[AD7768_FILTER_SINC3_REJ60] = 262,	/* 0.2617 */
+	[AD7768_FILTER_WIDEBAND] = 433,		/* 0.433 */
+};
+
 static const int ad7768_mclk_div_rates[] = {
 	16, 8, 4, 2,
 };
@@ -746,6 +754,7 @@ static const struct iio_chan_spec ad7768_channels[] = {
 		.type = IIO_VOLTAGE,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |
+					    BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) |
 					    BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
 		.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
 		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
@@ -766,7 +775,7 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
 {
 	struct ad7768_state *st = iio_priv(indio_dev);
 	const struct iio_scan_type *scan_type;
-	int scale_uv, ret;
+	int scale_uv, ret, temp;
 
 	scan_type = iio_get_current_scan_type(indio_dev, chan);
 	if (IS_ERR(scan_type))
@@ -804,6 +813,12 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		*val = st->oversampling_ratio;
 
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		temp = st->samp_freq * ad7768_filter_3db_odr_multiplier[st->filter_type];
+		*val = DIV_ROUND_CLOSEST(temp, 1000);
+
 		return IIO_VAL_INT;
 	}
 
-- 
2.34.1


