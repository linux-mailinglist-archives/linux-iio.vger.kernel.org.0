Return-Path: <linux-iio+bounces-18747-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E69EA9E56D
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 02:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A9B5189A7B6
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 00:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F284206B;
	Mon, 28 Apr 2025 00:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="JnB8d7UW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958D6200A3;
	Mon, 28 Apr 2025 00:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745799299; cv=none; b=H+HNp+U6gsIvSaTYc695VU7PQZsajOCGyZjsEBj7l1ML4s8sKkxP0MFnDNpGwCABjhdpDmbn6wvT+c+sQJMMR4G15fYpDwLYyy8yPzlT4Q/q5bhl2fe+fNvHKV+Iv2r83o3a1BR3nddwdBaI4wm/YkOBx7HvlU3lWYrBw8Eam/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745799299; c=relaxed/simple;
	bh=JBaJvXRE7jyjafzttminOMPNX7nE4b/InSUyfUluYrE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bpew5fq9vrOKR1Xx6H4QMsxiOHyIkjzaswkOqEc6Y6UOIH/StSziOUaHrAmCHHQAFRJtcqHpXybKmXXw1ChSgygmc+R3nvm4noelR2hAgdnK78HTCEuvBeLUQMCLeKj3NxrNSkFQITxmUnJ75WAc19XhXEKILXS/1QNt5NWBAW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=JnB8d7UW; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53RNVfK7013777;
	Sun, 27 Apr 2025 20:14:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=aXsKY
	a5dhkRWkUSNTZAKmMp3lz4NKiQ5F36lPxtC3w0=; b=JnB8d7UWbt1DGslG4HpPE
	YJKYcGHBXcep8xMrC8Ff/T+EddBgQlVyzk+CaOzC4KhUcZQi2n8Mwaq1itFjPdK2
	ABHhZcBByFaKkR5WM58E8lmYQFDsm4YWz/lKWaB3FPvgZoec1xb4u+MQsfhcErUE
	veWbx9XnuOq5aTsHxdjEt9h69PpHcRzggnbgVoDd2oEsjHnVBXUUm6IafpQaYXT8
	sqJC1AnkyiSE7KgK4m425pYBWi6NA4dfPICqAQmVOYH1GcNnA+Hv45GKaeW3G4cc
	LZDecVi8Ab42ntdQn8LvH05ypZXTDdMJ1OBXk7XmO3aIAhummN2nAqyjke85qk3q
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 468sb727gq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 27 Apr 2025 20:14:51 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 53S0EoQn029106
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 27 Apr 2025 20:14:50 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Sun, 27 Apr 2025 20:14:50 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Sun, 27 Apr 2025 20:14:50 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Sun, 27 Apr 2025 20:14:50 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 53S0EWEv014657;
	Sun, 27 Apr 2025 20:14:35 -0400
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
Subject: [PATCH v6 11/11] iio: adc: ad7768-1: add low pass -3dB cutoff attribute
Date: Sun, 27 Apr 2025 21:14:31 -0300
Message-ID: <da665263cfd3f3e4841722caf1ac45c29eb817ba.1745605382.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1745605382.git.Jonathan.Santos@analog.com>
References: <cover.1745605382.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: YjB5Dyu6SRonN2jxxWurk39tJ3h__fwO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI3MDIwMiBTYWx0ZWRfXxdqgZTIrRRM/ njO/MI+OKNZ4zD3hBmkJhmJqbGLTh/YBbwqZ/irlRhMXofoHAe5mPvTwTdhvqKzp7DixI+JE+HH U1MFRo9MU706wjeDn9V6Wr4NJYDlDCbBKZeR+cgU1Tmcfvb+2XIqmC8xkeIhnZvGZk7rDLKMTFd
 CickwaRlxPbWxkO0xKAxmH/yeFBP/y6J7JJG7gs89l3cN57NKoPnY+zy8p5VbLq9tuQmzR5ZtQ0 mbXbX6Ieo1J6PJJ/8J4dWt5vEk5Y9drlSi8/VRPL0gcYieQOw/ozFefH/cmla8JRd6IjLLFBR+Y oq3YtSRNBWAMaTWJzjPLswwNwpfEkEXTQ0uKpgI0a8kIxbfz2qy7Iz9pZERxLuBSzkttu/8+CFp
 YxKJqV7B+ovpZf6RKtKy8GMtIAq2UmyU+8sOWVBbubi/zLetfMzxc6Keib2WaMcARwvz/i/Z
X-Proofpoint-ORIG-GUID: YjB5Dyu6SRonN2jxxWurk39tJ3h__fwO
X-Authority-Analysis: v=2.4 cv=HPzDFptv c=1 sm=1 tr=0 ts=680ec87c cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=XR8D0OoHHMoA:10 a=gAnH3GRIAAAA:8 a=IpJZQVW2AAAA:8 a=ZkoTrUv0hqWFqrPu6skA:9 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-27_08,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 impostorscore=0 phishscore=0 mlxscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504270202

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
index e2b8f12260a5..8734859fc24e 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -148,6 +148,17 @@ enum ad7768_scan_type {
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
 static const int ad7768_mclk_div_rates[4] = {
 	16, 8, 4, 2,
 };
@@ -226,7 +237,8 @@ static const struct iio_chan_spec ad7768_channels[] = {
 		.type = IIO_VOLTAGE,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |
-					    BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+					    BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |
+					    BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
 		.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
 		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
 		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),
@@ -770,7 +782,7 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
 {
 	struct ad7768_state *st = iio_priv(indio_dev);
 	const struct iio_scan_type *scan_type;
-	int scale_uv, ret;
+	int scale_uv, ret, temp;
 
 	scan_type = iio_get_current_scan_type(indio_dev, chan);
 	if (IS_ERR(scan_type))
@@ -808,6 +820,12 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
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


