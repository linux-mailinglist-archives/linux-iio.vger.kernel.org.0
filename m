Return-Path: <linux-iio+bounces-19330-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4E3AB010C
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 19:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BA531777E0
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 17:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7E1286413;
	Thu,  8 May 2025 17:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="mHpPycDp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C200284B26;
	Thu,  8 May 2025 17:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746723974; cv=none; b=jO0G8yboPypzYTRsCzZr4pwU0pJ97OljcR+k1Zc2iOmZjTO8FmMjfumGyHyD9z0f60QgDuBE3jnfhlQlsbdxrYg6XIwnBvBWUn0mOFK55wvUsnFneM7aRe5q4Oi7hdnxrV+FwLRlcCJ7FA/xhZhquPSqIbCxHRUzO3rZjTZ8Ixk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746723974; c=relaxed/simple;
	bh=5oB5XuQUAHY+iWIu7xO2YXp0L1tqVZjkQtTZeLmmlko=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SmPIkFLvBQBJVmjtdt2JwtlrQxNCTIoeszWn6rSrp8r2lb4049zRj+4jLEnE1gYPFDHWGqSGI6wnfDSBGfTO3lk1EcjRNrwPKCNAosh6IDrVWzQdN57beK1t3ojQFTjblrDYnCfgqbMs3NUbv4ckQw2kUmvzFfY14PrQpCmcTIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=mHpPycDp; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 548DMfTV013536;
	Thu, 8 May 2025 13:05:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Vr42C
	2tcFtKYH/kR/TkyurniNImfA3S11wrHsfaGJBo=; b=mHpPycDp3WCq0j73JnV5V
	bDf1ZvaBYfSJDo29Q/EDaB2dx5e9uONiYE7CfnXsMpGHq/KFoLypErBo4lFRd1V0
	nIHsBTz6RFTbajndr5oUrDzxnObBeBcHLbx6C7TkNFUh6L37QgnZKj135fee1niQ
	07rIlvA0uEOUYo7f+2PR4loUxHoc+TVjQzkr80iyQS/n3cmr9Vm6YIROS8Kg2W4L
	7EeMk94sZ6q+dEosC4UzWDFukOm3uLus3wsUbFg5m+qmZIFJDKGKkjR6TCj36xpW
	jK9aUBGgQFp21vrR8Jc2SrB3Z0ACvh+Ke0rv7YDoo65ysggtewc0oyRCrc11gJ/+
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 46gpct32qc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 May 2025 13:05:57 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 548H5ujR052999
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 May 2025 13:05:56 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 8 May 2025
 13:05:55 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 8 May 2025 13:05:55 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 548H5drA015955;
	Thu, 8 May 2025 13:05:42 -0400
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
Subject: [PATCH v7 12/12] iio: adc: ad7768-1: add low pass -3dB cutoff attribute
Date: Thu, 8 May 2025 14:05:39 -0300
Message-ID: <4a8b85097213311851a710df7c036c124c7862ed.1746662899.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1746662899.git.Jonathan.Santos@analog.com>
References: <cover.1746662899.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=J/eq7BnS c=1 sm=1 tr=0 ts=681ce475 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=dt9VzEwgFbYA:10 a=gAnH3GRIAAAA:8 a=IpJZQVW2AAAA:8 a=ZkoTrUv0hqWFqrPu6skA:9
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: lCYsiY6ywWlXGcoOtBfEO-AjC8Mk7FP8
X-Proofpoint-ORIG-GUID: lCYsiY6ywWlXGcoOtBfEO-AjC8Mk7FP8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDE0OSBTYWx0ZWRfX0QsmtxVLUXOQ
 wV1O9049CiB+oZqL86wZUfnYjSeyHmSKEWsq0cUqtIdX6guPNwKXbRmXDBOPLOelLSrF5wdty0S
 97wVtvrhC0tU2fmCs+KqY9+67oQTCiLVwP2UdThK8hQ+TWPdaMPtlAiHDSVqOKMh2J87nPNyVtG
 ehbIfFHNRbVBSpGPGKuifaZr1ikV66F+oeXYdDurOROpeERv0qzOH/x2G2GbIHSBIio/C0Q2zWV
 ukWurbS9DL+YKKV9t4gY3NhdCst/NkblMgKhVsoT2b9WsuG7hVntkIodwMfGGerP53n7cPJ96B1
 PI7sN4oBgW+V3M2XD18GtEOaKgI1y1A1p1llDegaKWJ0zLvQNriFrgZFyKryqkuDBHrIJrXqSzy
 pp/iR0FFeXCzYM6mxO0xbVRa82jR4P6Aul4w1g1+xBgLqvGR+sF7BaXbJ0E5MCRDeEiaq9+A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_05,2025-05-08_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 phishscore=0 malwarescore=0
 spamscore=0 mlxscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505080149

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
 drivers/iio/adc/ad7768-1.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 28998cb02761..335612bce3bd 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -152,6 +152,17 @@ enum ad7768_scan_type {
 	AD7768_SCAN_TYPE_HIGH_SPEED,
 };
 
+/*
+ * -3dB cutoff frequency multipliers (relative to ODR) for
+ * each filter type. Values are multiplied by 1000.
+ */
+static const int ad7768_filter_3db_odr_multiplier[] = {
+	[AD7768_FILTER_SINC5] = 204,
+	[AD7768_FILTER_SINC3] = 262,
+	[AD7768_FILTER_SINC3_REJ60] = 262,
+	[AD7768_FILTER_WIDEBAND] = 433,
+};
+
 static const int ad7768_mclk_div_rates[] = {
 	16, 8, 4, 2,
 };
@@ -757,7 +768,8 @@ static const struct iio_chan_spec ad7768_channels[] = {
 		.type = IIO_VOLTAGE,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |
-					    BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+					    BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |
+					    BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
 		.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
 		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
 		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),
@@ -777,7 +789,7 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
 {
 	struct ad7768_state *st = iio_priv(indio_dev);
 	const struct iio_scan_type *scan_type;
-	int scale_uv, ret;
+	int scale_uv, ret, temp;
 
 	scan_type = iio_get_current_scan_type(indio_dev, chan);
 	if (IS_ERR(scan_type))
@@ -815,6 +827,12 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
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


