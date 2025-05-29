Return-Path: <linux-iio+bounces-20030-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 792EEAC84BA
	for <lists+linux-iio@lfdr.de>; Fri, 30 May 2025 00:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DA197A7594
	for <lists+linux-iio@lfdr.de>; Thu, 29 May 2025 22:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95AF2244673;
	Thu, 29 May 2025 22:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="rIOZK4ut"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D680122CBFE;
	Thu, 29 May 2025 22:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748559126; cv=none; b=GIjhNDt2xfI7qhrCR3AyUKykCxsv4m4CU3DEhUgBrtCa0wxpGdHc3mw98vRit/VxhePU9+zQBIqPKouIXA/QOFZ0CQTxslT46CKuP0n3xjRCVbNFJkKIeJCye9iNwQDPKW3Y8+yrxs42sPXaNn1EekK2TJRgqN+57hq2E9qRnxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748559126; c=relaxed/simple;
	bh=gHP5x+3TXr1yuRpbZvDleYFohwjuR1d/TxLWEP+V7Xs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BHU2ow14ZcKdUNqEEfICeHjCbJmw6khhUOEp41rS9J2swSGsCrj9xgo0iyZbiD4IODoBz5OBwZ/gJnJLygmxfw/CbQrWotFAaih05YRTJmtz5pKKn4pmLC0sLAkiwEEDSPqrm8NYmmr83VIcKEt57Hp74oyLowTuyvcTsnO3VE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=rIOZK4ut; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TKZkdC022889;
	Thu, 29 May 2025 18:51:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=BJLTU
	nW8X5rtQ+gdr/fGcIeYyJBQ1h4FJK3318ODJA0=; b=rIOZK4utc5kqvc3mYA2mQ
	WrQg8wc74DZNFp/JJDsUGKfJuM8z9Ogc/+VOpvEWLrqY4sS5ebHp7TOaLM/VfwDs
	oVcvCIoo/zAo7nc3DxO/WSoyKipQTJrLShjRN+qD8DVaZn9ZxSeyjD0GdjNIEclm
	meKkx5S8j5j8UCaXToJcjvcPpG42wA6tjY+WRQ4oZ0IiGuxlslYOuQnGuhFrjzUQ
	ThgEoCv+3mFilgDEjdFhgcTJizIdqM/D0oqCDzbGlguXsckiaby5IdDjeRgLbdpu
	Po3LLpJdW0UpvNL+YUC5vIHrQ+WEttef8aeB7saK4SbJFanLTdR9OpNArtbXsDTJ
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 46wu5837rf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 May 2025 18:51:56 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 54TMpslk008785
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 29 May 2025 18:51:54 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 29 May
 2025 18:51:54 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 29 May 2025 18:51:54 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 54TMpZ5o017228;
	Thu, 29 May 2025 18:51:37 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <andy@kernel.org>,
        <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
        <marcelo.schmitt@analog.com>, <jic23@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>, <linus.walleij@linaro.org>,
        <brgl@bgdev.pl>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <jonath4nns@gmail.com>, <dlechner@baylibre.com>,
        <andriy.shevchenko@linux.intel.com>, <rafael@kernel.org>,
        <djrscally@gmail.com>
Subject: [PATCH v9 12/12] iio: adc: ad7768-1: add low pass -3dB cutoff attribute
Date: Thu, 29 May 2025 19:51:32 -0300
Message-ID: <1f23ce87655090fc446dd725537fe29f4e870f1f.1748447035.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1748447035.git.Jonathan.Santos@analog.com>
References: <cover.1748447035.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDIyMyBTYWx0ZWRfX7l5bEPHY9x7y
 +7b0rJ3ohflJ0OAmSTQlJJNNhBtWm4VTL7A2JlpWJB74Q+F6nqyqjTW/faigN1wpduIadwgrCzq
 rH3hcJXK1wbVm+jYkxj52RGu2AKFa/0N2GwxACaUecmPWHQAvbhD69ppNBkZy/1TeoV+encKwx7
 hQ78hf2eE2mrQaKEYvRMCn7QsI8esigZwX0rk0plvHRS35LaW0pf6B7cj06WOFsi5JnjwVTaDiX
 NMxOPl+yvrmpGan7b+wMSVzy8xDHpK/v7mLtuA4aw8uk3P14MvVvpAzXDQKmNU4HP4VdMXTycyn
 XMjJ8l4tIOTtg+5JEWoEq6q5BJWZWOSV9SlaVZRELIPTQknBib6UtzlKvaGVVY1LIX9Mi7dYCbq
 GiGmwNdg5rpI+XKpK85jsaa27aWu98bwIEWXhUuPeAS9MIuB1X209kfjb5pHYeJzI4MYVhae
X-Authority-Analysis: v=2.4 cv=FZ03xI+6 c=1 sm=1 tr=0 ts=6838e50c cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=dt9VzEwgFbYA:10 a=gAnH3GRIAAAA:8 a=IpJZQVW2AAAA:8 a=UvUlGJLpmzXXuVQgGPIA:9
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: bQPnZJm_eggTDYfa99k-zC2Z-_f4J-gZ
X-Proofpoint-ORIG-GUID: bQPnZJm_eggTDYfa99k-zC2Z-_f4J-gZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_10,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 priorityscore=1501 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505290223

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
index c86afb0fc4c1..dfc1f49d4b81 100644
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


