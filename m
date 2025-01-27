Return-Path: <linux-iio+bounces-14630-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E24A1D94E
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 16:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FD7D166E4B
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 15:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB0815667B;
	Mon, 27 Jan 2025 15:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="TTohG8pf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAA714A630;
	Mon, 27 Jan 2025 15:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737990900; cv=none; b=vDXpkwJJ29Mn1lVRYPtG95w0smgyUXmlOO+4M6O0zQnZkAh+y/gPDxXNg67QAfXHM6uMZghiZsdB4df/Acuk2Bo2vUiBuRhZLGau2YdYrTSwK1XVm8PCRflH3S5LzTx475rYBMsoNd3KJ4+DKgeHSZQS78Ht+qXlamw4N+rL1ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737990900; c=relaxed/simple;
	bh=vjcQkQgpYpar4YF8wJPb0qQjbsU4Jj0yEOpyN5bDYjc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=adSEATYplSdQkP4UuXRHBOF1MvZRf1aRvx93EwZEzJpBxY79Qs+Hj6u1zybiSHYHox1tegjXQ8+IFbDjILCKEklSgBHc+h4ASMyh5+3Cw9Bunt5nMMRa0nfunYscPRCwwzYSxliKwQeTF6bwjfXgcJeRpiJ/Jkrk7EcBTNvejtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=TTohG8pf; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50RDWB9U005682;
	Mon, 27 Jan 2025 10:14:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=FiWRO
	hV+YSU4lSmrrRh3jrZVpIJthc4jSCHfbK4WoGQ=; b=TTohG8pfwTeMA7Bl/ESmp
	KZJZzqzpIZs4eY/2i19AMc6CO6pzb1iYa3Zd16dJb6azSvGgQkiwIovK489eanqp
	G0v9dNWdKzUHJUE3h+m2tG9qPN98PJlhTpo/jBoqK7jKPuci+7CXIHZpGtcH0wYY
	bPed/wetJXINonsfY1iUMsLFiKJK/rKyBmk6lm9RmwkCi6I1TLesqoddrekMnqor
	cr+azAzOA9BDnhyI81ECYG9bbn2v14iSuTLBh9GXKIutNl4KdAgCKyIkmez2YWLF
	hTyJMMc55y+yn5XI/Z76WnktxcvHBOSNGPe2D5FZKgKfjDorJCc51mQwZXNJrZ6v
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 44eb44gdqm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jan 2025 10:14:44 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 50RFEhnC011128
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 27 Jan 2025 10:14:43 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 27 Jan
 2025 10:14:43 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 27 Jan 2025 10:14:43 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 50RFEWPk008470;
	Mon, 27 Jan 2025 10:14:34 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
        <jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <jonath4nns@gmail.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2 16/16] iio: adc: ad7768-1: add low pass -3dB cutoff attribute
Date: Mon, 27 Jan 2025 12:14:31 -0300
Message-ID: <91b697b66a42ead9e05dd4e79d6fb1e776c569d6.1737985435.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1737985435.git.Jonathan.Santos@analog.com>
References: <cover.1737985435.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: YKygPqYe-rc38pZs783o70mI8dS4A2yp
X-Proofpoint-GUID: YKygPqYe-rc38pZs783o70mI8dS4A2yp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-27_07,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 malwarescore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0
 adultscore=0 suspectscore=0 clxscore=1015 mlxscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501270121

Ad7768-1 has a different -3db frequency multiplier depending on
the filter type configured. The cutoff frequency also varies according
to the current ODR.

Add a readonly low pass -3dB frequency cutoff attribute to clarify to
the user which bandwidth is being allowed depending on the filter
configurations.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
v2 Changes:
* New patch in v2.
---
 drivers/iio/adc/ad7768-1.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 6d0b430a8d54..daf91ef6f77b 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -149,6 +149,18 @@ enum ad7768_scan_type {
 	AD7768_SCAN_TYPE_HIGH_SPEED,
 };
 
+/*
+ * -3dB cutoff frequency multipliers (relative to ODR) for
+ * each filter type. Values are multiplied by 1000.
+ */
+static const int ad7768_filter_3db_odr_multiplier[] = {
+	[SINC5] = 204,
+	[SINC5_DEC_X8] = 204,
+	[SINC5_DEC_X16] = 204,
+	[SINC3] = 261,
+	[WIDEBAND] = 433,
+};
+
 static const int ad7768_mclk_div_rates[4] = {
 	16, 8, 4, 2,
 };
@@ -202,7 +214,8 @@ static const struct iio_chan_spec ad7768_channels[] = {
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
 		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
-					   BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+					   BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |
+					   BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
 		.ext_info = ad7768_ext_info,
 		.indexed = 1,
 		.channel = 0,
@@ -802,7 +815,7 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
 {
 	struct ad7768_state *st = iio_priv(indio_dev);
 	const struct iio_scan_type *scan_type;
-	int scale_uv, ret;
+	int scale_uv, ret, temp;
 
 	scan_type = iio_get_current_scan_type(indio_dev, chan);
 	if (IS_ERR(scan_type))
@@ -842,6 +855,12 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
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


