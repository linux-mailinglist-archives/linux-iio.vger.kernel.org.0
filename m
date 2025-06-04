Return-Path: <linux-iio+bounces-20226-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65695ACE51D
	for <lists+linux-iio@lfdr.de>; Wed,  4 Jun 2025 21:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C811177790
	for <lists+linux-iio@lfdr.de>; Wed,  4 Jun 2025 19:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45ED8232367;
	Wed,  4 Jun 2025 19:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="TysVnJDF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5068921421A;
	Wed,  4 Jun 2025 19:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749065893; cv=none; b=b1b+PW6MWL/3rDAzxSdTBQbe1cqWafsVuOX0EaVdEAKymyx/15fzaKWHNJWoGcPuqoFrOs6ARfV/AB+30L7icWbzw2Fn+DlDIY2L4J7+lC3nSfs8ViOrWZaanIPnxk2WyimqZVyNl/HtgKRnCYXA16B1ntigLvZCrLYsPOXte00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749065893; c=relaxed/simple;
	bh=FHOEiBODj2G9UyE72mk1HnQax8YclrU91a73d4kjH9c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fW6BpVVYEqK3CCENNAhw15ye+f0IMvM6+LSIiaigjR/gnfuPf0iGfPmpSfQTX7Oh2g6m12/dN2qmHeyXH387KcZunFCqxebuI+mWVBZkSmd0f0D063cLmPcxfLVZxeKDGz2v/kkt6ilbvbq9fxA8XUSSnOLJP8+LKMLEpBQBhqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=TysVnJDF; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554H2VL7023305;
	Wed, 4 Jun 2025 15:38:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=tQgrO
	A4KAU/bHOFoeFuCgqAMEqbgzJC/AdzwLzM8/N8=; b=TysVnJDFcmhH9HcVpeGEg
	FS6EOfziAbHek2u+BCESoaiVakLEGUIhisPsS+07wwj11uxkn8mZpX3C5xghXYCr
	mTB4aLFoz+c76gSZ5UjwdgVhHO/aUqNhmpl8Ea6azYIVWG5BFBnyTST/YA7Z9URj
	P9DjPJktJ0dmomTq/EO0drq8hqgf6+51S+5PIVmkNUhDFPBf1oRx1paVk8TV/JM9
	zNtxWxgUXXz+1iM4yYyOn2672Y0E85IgiCPyVa0NPbW8XlQM5SI9guce7zaQwa8W
	zav9kpruG9JbrAk0JKbJoA/mBrF8mZdwgeNA0VhN5V16oEwlpiZAniZT/SOBEPhu
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 472k2u2r11-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Jun 2025 15:38:05 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 554Jc4PA053893
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 4 Jun 2025 15:38:04 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 4 Jun
 2025 15:38:04 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 4 Jun 2025 15:38:04 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 554Jbn6L014372;
	Wed, 4 Jun 2025 15:37:51 -0400
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
Subject: [PATCH v10 12/12] iio: adc: ad7768-1: add low pass -3dB cutoff attribute
Date: Wed, 4 Jun 2025 16:37:49 -0300
Message-ID: <e53b113a7edfa8fbe68fd6a45503f2250e264808.1749063024.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1749063024.git.Jonathan.Santos@analog.com>
References: <cover.1749063024.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: P97-NGToECrFgox5PbUEm23MwEChibJJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDE1NSBTYWx0ZWRfXwMQtq3SCyKku
 PpZJm3D4Vuk7HOcUSgSv/wsHSYFApnuceQwrpDlGKTjdyxzCU6qeqbHVmU1zBq88pHPJniRXNwQ
 zPdCB0oeA9udBqkZ6hUTq4cFgNIHOGX1PrBbrtzyRy18FZAY5VogmGpiX/RcPdkAtyf1rGaKPd7
 +AbOvlnkyeOv2t0LIN9YkV0a9P/BiECkF6r3vu1TkEXiPyGyAgPIWZdSvfAeHMpM4oEQ6e73+Kq
 LYsHkUMWW4b30JVkC8wU9pwJNmTNC3Jp8HPMT/cL5gH3t4N4oce+Zfqg9hCZE3kl84OOiERjSrI
 vjZ9F3JKMZpC6ZKs3nKH7vL7iMmbeNZNo+ErhWksONSFLUeck0nYijFO03AGQbIf17gdVhm2qCr
 H3dmQPWW/tyaCnDROIpkGk5admXbomAJCZB1zG1R2lbMZfZo9K+U/LBc/W3AyijKjsgMgcvX
X-Proofpoint-ORIG-GUID: P97-NGToECrFgox5PbUEm23MwEChibJJ
X-Authority-Analysis: v=2.4 cv=Fv4F/3rq c=1 sm=1 tr=0 ts=6840a09d cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=6IFa9wvqVegA:10 a=gAnH3GRIAAAA:8 a=IpJZQVW2AAAA:8 a=UvUlGJLpmzXXuVQgGPIA:9
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_04,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 malwarescore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506040155

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
v10 Changes:
* None

v9 Changes:
* Rearraged new BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) to 
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
 drivers/iio/adc/ad7768-1.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 8c56b7243211..475d3e1b55ec 100644
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
@@ -746,6 +757,7 @@ static const struct iio_chan_spec ad7768_channels[] = {
 		.type = IIO_VOLTAGE,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |
+					    BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) |
 					    BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
 		.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
 		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
@@ -766,7 +778,7 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
 {
 	struct ad7768_state *st = iio_priv(indio_dev);
 	const struct iio_scan_type *scan_type;
-	int scale_uv, ret;
+	int scale_uv, ret, temp;
 
 	scan_type = iio_get_current_scan_type(indio_dev, chan);
 	if (IS_ERR(scan_type))
@@ -804,6 +816,12 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
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


