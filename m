Return-Path: <linux-iio+bounces-7303-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C1F9272E1
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2024 11:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EA1A281B9C
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2024 09:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FD61AAE2A;
	Thu,  4 Jul 2024 09:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="PHFr8nvk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3791A4F2E;
	Thu,  4 Jul 2024 09:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720084953; cv=none; b=BnJirCwk14MYWf8ivEWMVAOXiPherYTy0Ws+E2cfQrkP3NsQBBr0rWFLJjuCKwVETCUt7PQvju9NnTZTiJT542E3Tbq9tnLMuh5T4V2iSo87m/dRC5cJ9ewo1shLhMTm4suhYjGT0fH6HXNwwLPcaXUgHWLZ7E4oclRuHmtvgKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720084953; c=relaxed/simple;
	bh=gBAqolJDoKKxUsMcWU5dctLAviaSEp3Un9ndWmGAUaw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=UfhSCRdmTSvnEjkRkJAXv1BwMp4YytAF3K1pMI4FCI/koWCVtxh0YkR5DlA8jN5xmXF0U3TbQLtO0kJ39Pj7QxI9DVf2vXULpl1TFRrDa6RU3huHcxVvGvDtea429mnwN0U4x3PMkYZRsw5Kkbe0vTlZOjViPHa0wKNGzAgb8J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=PHFr8nvk; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4644oaUJ006817;
	Thu, 4 Jul 2024 05:22:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=hj6Eh
	tO3p8a/UTP1zzbQGeNU9qL2fESOwMbBPYsJ3Rg=; b=PHFr8nvkXnhBFPqXC03Wv
	3yFP6fEabj8aDFU2g1+kffP/bOVUgxrd/jhPq5yDrlFPHcfZLsJu0FlGpLgZvewt
	ck3qDRbP5oxecD87cx6t3eJ+XpFYWDVHHSKnnNNtZz+f/ADVQ90M7BPx0escMvTL
	PwJM8KgDS8+Hn9oAhuEOqfSlrnzYMiTh9SCcz/3hpkfPDEtYS+ChEixAMLLeQHBL
	oyVD9858s0MVIg5wV+/C3cHgwgfTi8O18Q3JyNWWg0+QyoHJ2/SfiNvVR8YhIElM
	VUdjAzU4/L3daMb2lmFS7wK5qOLGxaLeC3w0cPi/o5yw/7Sk04GniEwwft7eimwC
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 405n2p0u71-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jul 2024 05:22:15 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 4649METD058888
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 4 Jul 2024 05:22:14 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 4 Jul 2024 05:22:13 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 4 Jul 2024 05:22:13 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 4 Jul 2024 05:22:13 -0400
Received: from [127.0.0.1] ([10.44.3.56])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4649M1dk012858;
	Thu, 4 Jul 2024 05:22:08 -0400
From: Nuno Sa <nuno.sa@analog.com>
Date: Thu, 4 Jul 2024 11:25:22 +0200
Subject: [PATCH 2/5] iio: adc: ad9467: add new chip_info variables
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240704-dev-iio-ad9467-new-devs-v1-2-f1adfee921f7@analog.com>
References: <20240704-dev-iio-ad9467-new-devs-v1-0-f1adfee921f7@analog.com>
In-Reply-To: <20240704-dev-iio-ad9467-new-devs-v1-0-f1adfee921f7@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720085156; l=5687;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=gBAqolJDoKKxUsMcWU5dctLAviaSEp3Un9ndWmGAUaw=;
 b=G54969LMHLK44Kq72tOCR193byqTCkwLzlY7EQ3bgKh7BzygOG3JSSxQxMhZEVaJvSpOo9jso
 CQfHovo1GzDAM14gYQXkljhNEjheiHoybaKi5NzfMp2qt+SqBirzDoM
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 1FDCBw4uHsaoPbNgnJrHIY6fC8y57fgK
X-Proofpoint-GUID: 1FDCBw4uHsaoPbNgnJrHIY6fC8y57fgK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-04_06,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 spamscore=0 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 clxscore=1011 mlxlogscore=964 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407040064

Add new variables to the per chip info structure:

* test_points: Number of valid test points for calibration;
* has_dco_invert: Supports inverting DCO (Data clock output) polarity;
* dco_en: Specicic mask to enable DCO delays.

This is in preparation for supporting new parts with subtle differences
in how to configure the hardware.

Note that with the new test_points variable, we also add a new
calib_map_size to 'struct ad9467_state' so we know our map size
depending on how many test points we have and if we can run the
calibration in the inverted state or not.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/adc/ad9467.c | 38 +++++++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index 1d8270a5bccb..077c3a594bfc 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -105,6 +105,8 @@
 #define AD9467_REG_VREF_MASK		0x0F
 
 #define AD9647_MAX_TEST_POINTS		32
+#define AD9467_CAN_INVERT(st)	\
+	(!(st)->info->has_dco || (st)->info->has_dco_invert)
 
 struct ad9467_chip_info {
 	const char *name;
@@ -117,8 +119,11 @@ struct ad9467_chip_info {
 	unsigned int default_output_mode;
 	unsigned int vref_mask;
 	unsigned int num_lanes;
+	unsigned int dco_en;
+	unsigned int test_points;
 	/* data clock output */
 	bool has_dco;
+	bool has_dco_invert;
 };
 
 struct ad9467_state {
@@ -138,6 +143,8 @@ struct ad9467_state {
 	 * at the io delay control section.
 	 */
 	DECLARE_BITMAP(calib_map, AD9647_MAX_TEST_POINTS * 2);
+	/* number of bits of the map */
+	unsigned int calib_map_size;
 	struct gpio_desc *pwrdown_gpio;
 	/* ensure consistent state obtained on multiple related accesses */
 	struct mutex lock;
@@ -256,6 +263,7 @@ static const struct ad9467_chip_info ad9467_chip_tbl = {
 	.num_scales = ARRAY_SIZE(ad9467_scale_table),
 	.channels = ad9467_channels,
 	.num_channels = ARRAY_SIZE(ad9467_channels),
+	.test_points = AD9647_MAX_TEST_POINTS,
 	.default_output_mode = AD9467_DEF_OUTPUT_MODE,
 	.vref_mask = AD9467_REG_VREF_MASK,
 	.num_lanes = 8,
@@ -269,6 +277,7 @@ static const struct ad9467_chip_info ad9434_chip_tbl = {
 	.num_scales = ARRAY_SIZE(ad9434_scale_table),
 	.channels = ad9434_channels,
 	.num_channels = ARRAY_SIZE(ad9434_channels),
+	.test_points = AD9647_MAX_TEST_POINTS,
 	.default_output_mode = AD9434_DEF_OUTPUT_MODE,
 	.vref_mask = AD9434_REG_VREF_MASK,
 	.num_lanes = 6,
@@ -282,9 +291,11 @@ static const struct ad9467_chip_info ad9265_chip_tbl = {
 	.num_scales = ARRAY_SIZE(ad9265_scale_table),
 	.channels = ad9467_channels,
 	.num_channels = ARRAY_SIZE(ad9467_channels),
+	.test_points = AD9647_MAX_TEST_POINTS,
 	.default_output_mode = AD9265_DEF_OUTPUT_MODE,
 	.vref_mask = AD9265_REG_VREF_MASK,
 	.has_dco = true,
+	.has_dco_invert = true,
 };
 
 static int ad9467_get_scale(struct ad9467_state *st, int *val, int *val2)
@@ -468,7 +479,7 @@ static int ad9467_calibrate_apply(struct ad9467_state *st, unsigned int val)
 
 	if (st->info->has_dco) {
 		ret = ad9467_spi_write(st, AN877_ADC_REG_OUTPUT_DELAY,
-				       val);
+				       val | st->info->dco_en);
 		if (ret)
 			return ret;
 
@@ -524,14 +535,14 @@ static int ad9467_calibrate(struct ad9467_state *st)
 	 * Half of the bitmap is for the inverted signal. The number of test
 	 * points is the same though...
 	 */
-	unsigned int test_points = AD9647_MAX_TEST_POINTS;
+	unsigned int test_points = st->info->test_points;
 	unsigned long sample_rate = clk_get_rate(st->clk);
 	struct device *dev = &st->spi->dev;
 	bool invert = false, stat;
 	int ret;
 
 	/* all points invalid */
-	bitmap_fill(st->calib_map, BITS_PER_TYPE(st->calib_map));
+	bitmap_fill(st->calib_map, st->calib_map_size);
 
 	ret = ad9647_calibrate_prepare(st);
 	if (ret)
@@ -541,7 +552,7 @@ static int ad9467_calibrate(struct ad9467_state *st)
 	if (ret)
 		return ret;
 
-	for (point = 0; point < test_points; point++) {
+	for (point = 0; point < st->info->test_points; point++) {
 		ret = ad9467_calibrate_apply(st, point);
 		if (ret)
 			return ret;
@@ -576,8 +587,13 @@ static int ad9467_calibrate(struct ad9467_state *st)
 		 * a row.
 		 */
 		if (cnt < 3) {
-			invert = true;
-			goto retune;
+			if (AD9467_CAN_INVERT(st)) {
+				invert = true;
+				goto retune;
+			}
+
+			if (!cnt)
+				return -EIO;
 		}
 	} else {
 		inv_cnt = ad9467_find_optimal_point(st->calib_map, test_points,
@@ -802,7 +818,7 @@ static ssize_t ad9467_dump_calib_table(struct file *file,
 				       size_t count, loff_t *ppos)
 {
 	struct ad9467_state *st = file->private_data;
-	unsigned int bit, size = BITS_PER_TYPE(st->calib_map);
+	unsigned int bit;
 	/* +2 for the newline and +1 for the string termination */
 	unsigned char map[AD9647_MAX_TEST_POINTS * 2 + 3];
 	ssize_t len = 0;
@@ -811,8 +827,8 @@ static ssize_t ad9467_dump_calib_table(struct file *file,
 	if (*ppos)
 		goto out_read;
 
-	for (bit = 0; bit < size; bit++) {
-		if (bit == size / 2)
+	for (bit = 0; bit < st->calib_map_size; bit++) {
+		if (AD9467_CAN_INVERT(st) && bit == st->calib_map_size / 2)
 			len += scnprintf(map + len, sizeof(map) - len, "\n");
 
 		len += scnprintf(map + len, sizeof(map) - len, "%c",
@@ -861,6 +877,10 @@ static int ad9467_probe(struct spi_device *spi)
 	if (!st->info)
 		return -ENODEV;
 
+	st->calib_map_size = st->info->test_points;
+	if (AD9467_CAN_INVERT(st))
+		st->calib_map_size *= 2;
+
 	st->clk = devm_clk_get_enabled(&spi->dev, "adc-clk");
 	if (IS_ERR(st->clk))
 		return PTR_ERR(st->clk);

-- 
2.45.2


