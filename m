Return-Path: <linux-iio+bounces-17971-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60215A862B0
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 18:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01E124E0EC5
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 16:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23ED21A43C;
	Fri, 11 Apr 2025 15:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="dCN9TiVN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D8E2165E9;
	Fri, 11 Apr 2025 15:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744387193; cv=none; b=XESdWGoRCrS/dUgGxAGF2lNUeIH4eJ8rskwkAHNZDGh3mj9/2rg1n7Uq3HTsZxDA/QDM/XElxZYEQOOpnEVnQyNbmJGWbXBw06lKAc1Ufr8uZHDo09q4mIXPF4hrc9JB++g8peY5KdkWAdzClhzIOz8KSf4ETD+lxQ1XR6NhjMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744387193; c=relaxed/simple;
	bh=DFqXN9+cm+tTalfoxQahvpgLc5wgkfNgFwfMnkLB9Bo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bcSc1OiicFzX55Vs7OpVNrVlMCGFJ3agHGb9Qw/CqW5oxrok5lcLvS+ZqijUg7OiMGR0I4JN9KjOSZUZ1FeKmPScXT3Nfv6YEyAGiZDUrg2ukAy1Pcqz3yqCA96CQQIoskXS05zho55jXrpEsnMT2Kilw5m1KvhWayF80cQo/m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=dCN9TiVN; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53BFHdVV015162;
	Fri, 11 Apr 2025 11:59:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=k7/TG
	ozs0r7B3yLHxyAJn1dKbkhli79duWZxIYniFlE=; b=dCN9TiVNj9e16KgYvKMXU
	BKHDZMBlj0JRbS3KtMsJ6F8JvSxi0RXIztpHkb3L9WvwL8+hM1KFyFGzV8jJ2Z8X
	JGYSlOjLkLFbUrxJRFQF7ZQSgnrBcuFujFMmiGNfYTOvMO4kd27Qdae/Zj7vgnYm
	FDHHpe1s90leQBipbaCFq1mZl3LSvoDNbuJIWH7y3HtkRQIMyzcS1f76CC3z/Ro3
	fP2DxJV3NeoHNwbN5M/MZaUuRz9+vfIJN0qSsAfHSo9O0Se5KGvlKFMSuXWfjUAt
	Oc5RRcwHtHfPDaKhrzT83wmE7+3O7x4h9zeENjvcTx6zl3ZxiUPT/YInl3gpLCN5
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 45u1e6uytc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 11:59:33 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 53BFxWs2022452
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 11 Apr 2025 11:59:32 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 11 Apr 2025 11:59:32 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 11 Apr 2025 11:59:32 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 11 Apr 2025 11:59:32 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 53BFxEC5015670;
	Fri, 11 Apr 2025 11:59:16 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
        <jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <marcelo.schmitt1@gmail.com>,
        <linus.walleij@linaro.org>, <brgl@bgdev.pl>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <jonath4nns@gmail.com>, <dlechner@baylibre.com>
Subject: [PATCH v5 14/14] iio: adc: ad7768-1: add low pass -3dB cutoff attribute
Date: Fri, 11 Apr 2025 12:59:13 -0300
Message-ID: <8d3393a297fbdd99d0df3d6d924cacc9edf8f741.1744325346.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1744325346.git.Jonathan.Santos@analog.com>
References: <cover.1744325346.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: BhojdHvz7FUxk3T3V6a2lbc_PcnN1-VT
X-Authority-Analysis: v=2.4 cv=cdjSrmDM c=1 sm=1 tr=0 ts=67f93c66 cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=XR8D0OoHHMoA:10 a=gAnH3GRIAAAA:8 a=IpJZQVW2AAAA:8 a=ZkoTrUv0hqWFqrPu6skA:9 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: BhojdHvz7FUxk3T3V6a2lbc_PcnN1-VT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_06,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999
 phishscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504110101

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
index ab46714ee20a..d3d5b3505c41 100644
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
 static const int ad7768_mclk_div_rates[4] = {
 	16, 8, 4, 2,
 };
@@ -230,7 +241,8 @@ static const struct iio_chan_spec ad7768_channels[] = {
 		.type = IIO_VOLTAGE,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |
-					    BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+					    BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |
+					    BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
 		.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
 		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
 		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),
@@ -765,7 +777,7 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
 {
 	struct ad7768_state *st = iio_priv(indio_dev);
 	const struct iio_scan_type *scan_type;
-	int scale_uv, ret;
+	int scale_uv, ret, temp;
 
 	scan_type = iio_get_current_scan_type(indio_dev, chan);
 	if (IS_ERR(scan_type))
@@ -803,6 +815,12 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
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


