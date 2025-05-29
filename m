Return-Path: <linux-iio+bounces-20026-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C662AC849F
	for <lists+linux-iio@lfdr.de>; Fri, 30 May 2025 00:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A8FC4E573E
	for <lists+linux-iio@lfdr.de>; Thu, 29 May 2025 22:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564BB22B8CF;
	Thu, 29 May 2025 22:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="XSAqdTLB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5998721D3CA;
	Thu, 29 May 2025 22:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748559047; cv=none; b=S1j8RmSiWcq29PY0d+K5kDfzG8EL/5O8tzSfnwkmBRzaSjz6EGRJBu7Kf2LvG2GbXDtMEGP4yFqzlHo9/WnEhEUDcd24zWb2iYDQeuPlBNsitIn0kCJjnO2vMlWUWf6YfOk0OQ3v6WoLbzxKC7+xBU0p4zFqJ27Ub+4udHB5RMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748559047; c=relaxed/simple;
	bh=B0vVxjfs7VGJ5jc5Dsmf0v/H6unN1ISbc80V6SZMaMc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NxHF26j3iwwoBsQaGgIsXdaj+o6KC6h4+3Wv2x3BC1E9r3+Clmd8ZnooVHh72oqDBvX4DF9LmjmV8J8Fnw4aesQwhilQTeBbf0JIdtzMNvMfxB3oGHiZmIViuvzXmiImupivnRkZoxvit67pjzielf2k65DmuKjdK5pE8Dg/AsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=XSAqdTLB; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TM67Wq012161;
	Thu, 29 May 2025 18:50:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=PYCIJ
	gmV0Hlc8cVFrPUY8/zqO2p5XFzrjcVMJIitCLA=; b=XSAqdTLBHQO6tZHOmBEjU
	yQYbVlHDXWxlSNl3XcIRz7hAnTR11DWJmcHFJqkgKqWrzabvpqXSsiee0WSPttox
	MKrcOvPG7eTp8eUGRvKrBX/3rdEwLKQOT8sPvfDvON4aKiNS7ecze1TUpYtDKIBU
	lkmFYRAPVaQ8h+18Vf9W4INbgNyF8qIYE4gnPS/A6YKUDwtM/vabCzeIliE7D1o3
	xozHC2TPSm5GQh9RcV9BC0KytStpEH6LLPVR3lShxfFTQNv+NM9EFDR/pp4HExog
	KOlVXo4hFPGAvU8qnqxfh33RisBGTfrk5bR1bqO/TGQRX7+Y637kny44v+0LdgUk
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 46xjw64bsy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 May 2025 18:50:38 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 54TMoVem010340
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 29 May 2025 18:50:31 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 29 May 2025 18:50:31 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 29 May 2025 18:50:31 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 29 May 2025 18:50:31 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 54TMoEis017202;
	Thu, 29 May 2025 18:50:16 -0400
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
Subject: [PATCH v9 08/12] iio: adc: ad7768-1: add multiple scan types to support 16-bits mode
Date: Thu, 29 May 2025 19:50:13 -0300
Message-ID: <65ed5b1652413b95a8b2816cbec826dc28e8b25b.1748447035.git.Jonathan.Santos@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDIyMyBTYWx0ZWRfX+zHpePfwBRQc
 7Pz4RF2oRwwNfVuWx5uwf68qWWFzsvDFIbMju+/6FHUadzIntUOkBfWP+GOLnRdRD1J6vKgY7QL
 YlqAriYyc7I6Tt/nxCdRpHX5yuVpkf/g0zEJt8abbn3wxjNHe9TJ/oc340dDoHV3kG0CXDLA24y
 Q3sllCOZmeAOuYriiLnk8F75ccDL2drEEDf9cwxoQukWZw9YdwbqicIEPqsQw8hU/f021fD3E+d
 UBJugSF3sr/sLdA+Js7GWqWIhdkGMwd6Um+eBXNnup2AjRN3DeUagRzn0JILiXYp7jeo9KW7dFf
 rcqalkJeYE7HDx5N3K+Iz+ikbPHg3j2Zp5wh4XLcGZNxV1qJqxFZbHPm2D2+lVzCSHho7AJicXi
 kc7nrYIGv2Ia0OP8kyXG+H/qGZ8cvJwInNXY7e4tDfpBr9tb8QtWiJBAuZvRNqfkuYMdp526
X-Proofpoint-GUID: hc6faoJe3rILaJZS_vCBoItJLMY1lOh3
X-Authority-Analysis: v=2.4 cv=RMGzH5i+ c=1 sm=1 tr=0 ts=6838e4be cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=dt9VzEwgFbYA:10 a=gAnH3GRIAAAA:8 a=IpJZQVW2AAAA:8 a=uM-NTnSxQ297Tim-omgA:9
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: hc6faoJe3rILaJZS_vCBoItJLMY1lOh3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_10,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 bulkscore=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0 priorityscore=1501
 phishscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505290223

When the device is configured to decimation x8, only possible in the
sinc5 filter, output data is reduced to 16-bits in order to support
1 MHz of sampling frequency due to clock limitation.

Use multiple scan types feature to enable the driver to switch
scan type at runtime, making it possible to support both 24-bit and
16-bit resolution.

Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
v9 Changes:
* Addressed indentation issue.

v8 Changes:
* Fixed typo in David's Email.
* Removed TODO comment related to the spi_bpw_to_bytes() function.

v7 Changes:
* Added TODO comment to use spi_bpw_to_bytes() helper function.
* Minor commit description changes.

v6 Changes:
* None.

v5 Changes:
* None.

v4 Changes:
* None.

v3 Changes:
* Decreased storagebits to 16 for AD7768_SCAN_TYPE_HIGH_SPEED
  scan type.

v2 Changes:
* Included the ".shift" value back to scan_type.
* Changed the number of bytes from regmap_read instead of shifting the 
  ADC sample value when the word size is lower (16-bits).
---
 drivers/iio/adc/ad7768-1.c | 74 ++++++++++++++++++++++++++++++++------
 1 file changed, 64 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index d0366d570c14..6a409a46773c 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -140,6 +140,15 @@ struct ad7768_clk_configuration {
 	enum ad7768_pwrmode pwrmode;
 };
 
+enum ad7768_scan_type {
+	AD7768_SCAN_TYPE_NORMAL,
+	AD7768_SCAN_TYPE_HIGH_SPEED,
+};
+
+static const int ad7768_mclk_div_rates[] = {
+	16, 8, 4, 2,
+};
+
 static const struct ad7768_clk_configuration ad7768_clk_config[] = {
 	{ AD7768_MCLK_DIV_2, AD7768_DEC_RATE_8, 16,  AD7768_FAST_MODE },
 	{ AD7768_MCLK_DIV_2, AD7768_DEC_RATE_16, 32,  AD7768_FAST_MODE },
@@ -154,6 +163,22 @@ static const struct ad7768_clk_configuration ad7768_clk_config[] = {
 	{ AD7768_MCLK_DIV_16, AD7768_DEC_RATE_1024, 16384, AD7768_ECO_MODE },
 };
 
+static const struct iio_scan_type ad7768_scan_type[] = {
+	[AD7768_SCAN_TYPE_NORMAL] = {
+		.sign = 's',
+		.realbits = 24,
+		.storagebits = 32,
+		.shift = 8,
+		.endianness = IIO_BE,
+	},
+	[AD7768_SCAN_TYPE_HIGH_SPEED] = {
+		.sign = 's',
+		.realbits = 16,
+		.storagebits = 16,
+		.endianness = IIO_BE,
+	},
+};
+
 static const struct iio_chan_spec ad7768_channels[] = {
 	{
 		.type = IIO_VOLTAGE,
@@ -163,13 +188,9 @@ static const struct iio_chan_spec ad7768_channels[] = {
 		.indexed = 1,
 		.channel = 0,
 		.scan_index = 0,
-		.scan_type = {
-			.sign = 's',
-			.realbits = 24,
-			.storagebits = 32,
-			.shift = 8,
-			.endianness = IIO_BE,
-		},
+		.has_ext_scan_type = 1,
+		.ext_scan_type = ad7768_scan_type,
+		.num_ext_scan_type = ARRAY_SIZE(ad7768_scan_type),
 	},
 };
 
@@ -182,6 +203,7 @@ struct ad7768_state {
 	unsigned int vcm_output_sel;
 	struct clk *mclk;
 	unsigned int mclk_freq;
+	unsigned int dec_rate;
 	unsigned int samp_freq;
 	struct completion completion;
 	struct iio_trigger *trig;
@@ -301,6 +323,15 @@ static int ad7768_scan_direct(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
+	/*
+	 * When the decimation rate is set to x8, the ADC data precision is
+	 * reduced from 24 bits to 16 bits. Since the AD7768_REG_ADC_DATA
+	 * register provides 24-bit data, the precision is reduced by
+	 * right-shifting the read value by 8 bits.
+	 */
+	if (st->dec_rate == 8)
+		readval >>= 8;
+
 	/*
 	 * Any SPI configuration of the AD7768-1 can only be
 	 * performed in continuous conversion mode.
@@ -517,6 +548,8 @@ static int ad7768_set_freq(struct ad7768_state *st,
 	if (ret < 0)
 		return ret;
 
+	st->dec_rate = ad7768_clk_config[idx].clk_div /
+		       ad7768_mclk_div_rates[ad7768_clk_config[idx].mclk_div];
 	st->samp_freq = DIV_ROUND_CLOSEST(st->mclk_freq,
 					  ad7768_clk_config[idx].clk_div);
 
@@ -550,8 +583,13 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
 			   int *val, int *val2, long info)
 {
 	struct ad7768_state *st = iio_priv(indio_dev);
+	const struct iio_scan_type *scan_type;
 	int scale_uv, ret;
 
+	scan_type = iio_get_current_scan_type(indio_dev, chan);
+	if (IS_ERR(scan_type))
+		return PTR_ERR(scan_type);
+
 	switch (info) {
 	case IIO_CHAN_INFO_RAW:
 		if (!iio_device_claim_direct(indio_dev))
@@ -562,7 +600,7 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
 		iio_device_release_direct(indio_dev);
 		if (ret < 0)
 			return ret;
-		*val = sign_extend32(ret, chan->scan_type.realbits - 1);
+		*val = sign_extend32(ret, scan_type->realbits - 1);
 
 		return IIO_VAL_INT;
 
@@ -572,7 +610,7 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
 			return scale_uv;
 
 		*val = (scale_uv * 2) / 1000;
-		*val2 = chan->scan_type.realbits;
+		*val2 = scan_type->realbits;
 
 		return IIO_VAL_FRACTIONAL_LOG2;
 
@@ -616,11 +654,21 @@ static const struct attribute_group ad7768_group = {
 	.attrs = ad7768_attributes,
 };
 
+static int ad7768_get_current_scan_type(const struct iio_dev *indio_dev,
+					const struct iio_chan_spec *chan)
+{
+	struct ad7768_state *st = iio_priv(indio_dev);
+
+	return st->dec_rate == 8 ?
+	       AD7768_SCAN_TYPE_HIGH_SPEED : AD7768_SCAN_TYPE_NORMAL;
+}
+
 static const struct iio_info ad7768_info = {
 	.attrs = &ad7768_group,
 	.read_raw = &ad7768_read_raw,
 	.write_raw = &ad7768_write_raw,
 	.read_label = ad7768_read_label,
+	.get_current_scan_type = &ad7768_get_current_scan_type,
 	.debugfs_reg_access = &ad7768_reg_access,
 };
 
@@ -675,9 +723,15 @@ static irqreturn_t ad7768_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct ad7768_state *st = iio_priv(indio_dev);
+	const struct iio_scan_type *scan_type;
 	int ret;
 
-	ret = spi_read(st->spi, &st->data.scan.chan, 3);
+	scan_type = iio_get_current_scan_type(indio_dev, &indio_dev->channels[0]);
+	if (IS_ERR(scan_type))
+		goto out;
+
+	ret = spi_read(st->spi, &st->data.scan.chan,
+		       BITS_TO_BYTES(scan_type->realbits));
 	if (ret < 0)
 		goto out;
 
-- 
2.34.1


