Return-Path: <linux-iio+bounces-20028-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B78AC84A8
	for <lists+linux-iio@lfdr.de>; Fri, 30 May 2025 00:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 766209E7BBC
	for <lists+linux-iio@lfdr.de>; Thu, 29 May 2025 22:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4488322DF86;
	Thu, 29 May 2025 22:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="CVIyso2t"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668C8224227;
	Thu, 29 May 2025 22:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748559074; cv=none; b=keMxgaGn7DkE5ySzK99RATaxSTmIVvHtmKpUgqH/OjVcRvVqi1g5K49K/KMuLeyjl5nYs68e2wHEAozpRE6LIv3r+NNy/pPtbttDsewagm7nOzViP8UdhaPTV9Tuw/nQnv7PTlE7DHdwdLv6LdR9FdIAi9e191bdX0O9Ntf6rrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748559074; c=relaxed/simple;
	bh=Ptd4W+T7zNLmLMxdOav0OFnzWJqHf1y4zmD1kqfK0sY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=huFJSQpX69FFVPgybiX4/f09EWrx0i8nP5/trkZnhfIWc+hvIvsrXi5EGyXQc+jytwT8lAc5iak9T/mvMPtEfWGkwNLmpyf560or0uBe3NUw4z9PK02ens1nIsU5r0QFnUnMMLgmNtm+GdIkO3vz6EoRjRmRF80b4N9ml4uCV3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=CVIyso2t; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TLi0Xg022879;
	Thu, 29 May 2025 18:51:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=/x3fP
	CmmnoS647B3z8WIl4mcmK0EZKGbwjYYDGrQwmA=; b=CVIyso2tRtasvdmkPZy0w
	s6Y82HNIq+AMUkA6dOG6Maug0ruL4tOjYoMbKnEAih6Lqo6Lk53PPibtNUAj/DHH
	+xymtjvXdU0+9arwVWw0rB75KvlqW6QlK9xlJaIz4JThoaa86nHS/2YNEecQSD/t
	XAOSdZeVQjqeg8+6MT4nsY81awFNHwgq/9ACh4GAfsUDlzm4+DGDV8+65aaJNvkv
	zwl1aSud6PFZFpJtc2ouR8/DzBKrUit/RYTSeZAtHV2KGEFmjxHDZawUTjQAuKaq
	EEf1jM0T4oE0s23rtwGu9styhIpml+TV2ejSEWQ4SxO9fairnsd769FEEAq962TE
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 46wu5837m0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 May 2025 18:51:03 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 54TMp2Ds010356
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 29 May 2025 18:51:02 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 29 May
 2025 18:51:02 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 29 May 2025 18:51:02 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 54TMoiJv017215;
	Thu, 29 May 2025 18:50:47 -0400
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
Subject: [PATCH v9 10/12] iio: adc: ad7768-1: replace manual attribute declaration
Date: Thu, 29 May 2025 19:50:44 -0300
Message-ID: <ee689aa36fbec7e0f8bb03166c251be766546343.1748447035.git.Jonathan.Santos@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDIyMyBTYWx0ZWRfXwVWjXTdrAw+J
 d1xZ98/W7C4fgLZF5HZYkTenKjL05m80ZBBo/1+mXBeNAHrURTj0EcmQrxDgaPPRFTBCA46uP7M
 k+tnut+Hookhs7+zlI0JBOUb2VjpPytF/OFw4OetO7daSktm7uUCb5wjUyPljNvyh37mD1jQ6t4
 LzPimUmmkUFvAp2RGiWf9laB8V+e/n1yMi7m76xtO8k1LOQ2K0MjgdjxUVyrDQC+0vaSTxRkkoS
 TRzCwqraYGGedDiPGoOt+RD+ScwjEZEis0ndGMk+LwCAOjNbb8NTavi+D10MQPoPWqQ8mDJU/lN
 BQgnBuGkUoBrIp6UzTbQt9itdtQ4o2luN9YnzrhyGJx3SPXFsEYyi4hx1PZhl4NPJHXr7fvunLP
 fxGk9JQb8/hc057oZj75PFS2iONIRqJxGeTpY0nLlUK9huLG+4ya9nVJW3eopepXDTYDC+qW
X-Authority-Analysis: v=2.4 cv=FZ03xI+6 c=1 sm=1 tr=0 ts=6838e4d7 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=dt9VzEwgFbYA:10 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8 a=L6hIjVXnctlZ6DB8sOoA:9
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: QVBAahy7MzRBQFyeihfCJMDOZqAmZndB
X-Proofpoint-ORIG-GUID: QVBAahy7MzRBQFyeihfCJMDOZqAmZndB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_10,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 priorityscore=1501 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505290223

Use read_avail callback from struct iio_info to replace the manual
declaration of sampling_frequency_available attribute.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
v9 Changes:
* None.

v8 Changes:
* Addressed formatting issue.

v7 Changes:
* Iteractor changed to unsigned in the ad7768_fill_samp_freq_tbl()
  function.

v6 Changes:
* none.

v5 Changes:
* none.

v4 Changes:
* Added ad7768_fill_samp_freq_tbl() helper function.
* Sampling frequency table is precomputed at probe.

v3 Changes:
* New patch in v3.
---
 drivers/iio/adc/ad7768-1.c | 63 +++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 32 deletions(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 01da1c2a138c..4c8152624c33 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -189,6 +189,7 @@ static const struct iio_chan_spec ad7768_channels[] = {
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
 		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),
 		.indexed = 1,
 		.channel = 0,
 		.scan_index = 0,
@@ -209,6 +210,7 @@ struct ad7768_state {
 	unsigned int mclk_freq;
 	unsigned int dec_rate;
 	unsigned int samp_freq;
+	unsigned int samp_freq_avail[ARRAY_SIZE(ad7768_clk_config)];
 	struct completion completion;
 	struct iio_trigger *trig;
 	struct gpio_desc *gpio_sync_in;
@@ -322,6 +324,15 @@ static int ad7768_send_sync_pulse(struct ad7768_state *st)
 	return 0;
 }
 
+static void ad7768_fill_samp_freq_tbl(struct ad7768_state *st)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(ad7768_clk_config); i++)
+		st->samp_freq_avail[i] =
+			DIV_ROUND_CLOSEST(st->mclk_freq, ad7768_clk_config[i].clk_div);
+}
+
 static int ad7768_set_mode(struct ad7768_state *st,
 			   enum ad7768_conv_mode mode)
 {
@@ -579,28 +590,6 @@ static int ad7768_set_freq(struct ad7768_state *st,
 	return 0;
 }
 
-static ssize_t ad7768_sampling_freq_avail(struct device *dev,
-					  struct device_attribute *attr,
-					  char *buf)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ad7768_state *st = iio_priv(indio_dev);
-	unsigned int freq;
-	int i, len = 0;
-
-	for (i = 0; i < ARRAY_SIZE(ad7768_clk_config); i++) {
-		freq = DIV_ROUND_CLOSEST(st->mclk_freq,
-					 ad7768_clk_config[i].clk_div);
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%d ", freq);
-	}
-
-	buf[len - 1] = '\n';
-
-	return len;
-}
-
-static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(ad7768_sampling_freq_avail);
-
 static int ad7768_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val, int *val2, long info)
@@ -646,6 +635,24 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
+static int ad7768_read_avail(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     const int **vals, int *type, int *length,
+			     long info)
+{
+	struct ad7768_state *st = iio_priv(indio_dev);
+
+	switch (info) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*vals = (int *)st->samp_freq_avail;
+		*length = ARRAY_SIZE(ad7768_clk_config);
+		*type = IIO_VAL_INT;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
 static int ad7768_write_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int val, int val2, long info)
@@ -668,15 +675,6 @@ static int ad7768_read_label(struct iio_dev *indio_dev,
 	return sprintf(label, "%s\n", st->labels[chan->channel]);
 }
 
-static struct attribute *ad7768_attributes[] = {
-	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
-	NULL
-};
-
-static const struct attribute_group ad7768_group = {
-	.attrs = ad7768_attributes,
-};
-
 static int ad7768_get_current_scan_type(const struct iio_dev *indio_dev,
 					const struct iio_chan_spec *chan)
 {
@@ -687,8 +685,8 @@ static int ad7768_get_current_scan_type(const struct iio_dev *indio_dev,
 }
 
 static const struct iio_info ad7768_info = {
-	.attrs = &ad7768_group,
 	.read_raw = &ad7768_read_raw,
+	.read_avail = &ad7768_read_avail,
 	.write_raw = &ad7768_write_raw,
 	.read_label = ad7768_read_label,
 	.get_current_scan_type = &ad7768_get_current_scan_type,
@@ -1137,6 +1135,7 @@ static int ad7768_probe(struct spi_device *spi)
 		return PTR_ERR(st->mclk);
 
 	st->mclk_freq = clk_get_rate(st->mclk);
+	ad7768_fill_samp_freq_tbl(st);
 
 	indio_dev->channels = ad7768_channels;
 	indio_dev->num_channels = ARRAY_SIZE(ad7768_channels);
-- 
2.34.1


