Return-Path: <linux-iio+bounces-20427-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02478AD54B2
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 13:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADD9B17E5E6
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 11:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9FF28314B;
	Wed, 11 Jun 2025 11:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ru8BRChp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE56026A0AB;
	Wed, 11 Jun 2025 11:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749642721; cv=none; b=qVYhmux5IoeyYo+CxCxZ+jBuO/o9Ogk6EKPqiiHScRwjo1BqpVDLFxoGRp4/HLM2Kzo14kH5/Xjv08v8kYLKXi7PDhdW8x/WFUU7vYEZyMDQiqgIQKl4qFREijxh9If5na0V6KBViGR6k7GvPE0LTcNSXpviZGqUyrEjwWRPaZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749642721; c=relaxed/simple;
	bh=sjw5AdgTbZgkK3Lh+me8YrozkEi04z5OdZyMvu8Yi04=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hRU2eEdS+8IgDBxj+ycb00L47c4yGW+vVEo9QHUMmPLz71tuTQWMOVAH4rujsAa0YLB7kCJWrWg2YZvV5UxGh46zIyzzKnmx1CnHrqoLoMu7zND9JkW+D5Xj9uhu2ypEuRBfwdHN3xBbwZ2sY4eJLXoWAYowVhq4IPOTwZuwA1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ru8BRChp; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55B91jvW016819;
	Wed, 11 Jun 2025 07:51:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=YH667
	lUYLBsPy8V27iFxmTlIeywwbLjp2XopLcDbedM=; b=ru8BRChpqgY7TVb71FvJL
	8q9g+ic2nyA0LwaaDC18e3CPxJDET7hZnfRLFT1g+YP5r7fR/ZKINzZK/GjIMuQu
	E0WCa3xBoRFr79dMGDzxCS/3d3ZTClDMICUEaJ+tLHTkwKR8UGGu5es/V5UvEsJJ
	2v/Krwfrl4lCMw0yIAF5IoOs4+pCxkQLstTUM8KN4JQtYZSkS5xW/tkxbImpjau8
	9FYPP3YPJPJTE1v/VT+IMtud8S6FkrcA4+5XbhpKsR238V58g5e65gt1BayzJfI8
	qqRv6FC89oNqh/bCFuFIkNcrPI7Whr/Lhnz67253hd+LDVUCmyI7AzMnAFte/X/C
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4776tdgvvs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 07:51:53 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 55BBpqBU031701
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 11 Jun 2025 07:51:52 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 11 Jun
 2025 07:51:52 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 11 Jun 2025 07:51:52 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 55BBpceY008944;
	Wed, 11 Jun 2025 07:51:40 -0400
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
Subject: [PATCH v11 09/11] iio: adc: ad7768-1: replace manual attribute declaration
Date: Wed, 11 Jun 2025 08:51:38 -0300
Message-ID: <b2653d270131b2c873373a6f81cde9a5bdf5d1ff.1749569957.git.Jonathan.Santos@analog.com>
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
X-Proofpoint-GUID: 9Dm5fOwefc30a_VNNbYDazG2K6FojTst
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDEwMSBTYWx0ZWRfX/VoPdHoUqQq7
 DVW10M/1nu7pcIQ+aSSNi5/cf4S+Yx5wAeA0FUd20TPmXrKgJuO9I9G8tA15uGnoY0RjbFUUm8x
 8vlRtpqykpucQoBn+LVGIKm8aE4F0wdhknm7R4DHRluYeOVR2SWKx8fa6qoHWmw48+zUM2yUs4Y
 26RM+2EB996WynJtg3qWCihrE3Nia+MRjDDqEMfP7nrD1x9ie5Ck7W9kkb0bMKchX1wUhCBx0ji
 curMjSzEXJ6NwH/uSW5GRItVtjfqUlsvPTNCEN8wNtkl4J7vm9+tDjuz0Spve2S0d/Fhiuv3eil
 ceEs7VWra3wMdocAYLzi3okRueH/M22RRN6naG/m3meETi+/n9zzQRpTDVPdAJQ41LjEqB2t7hw
 EWvIIONTmOJzfeP2c1Z0KDRZZp+kuSAziof3XDbsUiu0kGqcMdalElM323lHA/8Qvv6ks3/2
X-Authority-Analysis: v=2.4 cv=BezY0qt2 c=1 sm=1 tr=0 ts=68496dd9 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=6IFa9wvqVegA:10 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8 a=L6hIjVXnctlZ6DB8sOoA:9
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: 9Dm5fOwefc30a_VNNbYDazG2K6FojTst
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_05,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 spamscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506110101

Use read_avail callback from struct iio_info to replace the manual
declaration of sampling_frequency_available attribute.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
v11 Changes:
* None.

v10 Changes:
* None.

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
index c1e05755b9d5..0be5e17260cf 100644
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
@@ -1152,6 +1150,7 @@ static int ad7768_probe(struct spi_device *spi)
 		return PTR_ERR(st->mclk);
 
 	st->mclk_freq = clk_get_rate(st->mclk);
+	ad7768_fill_samp_freq_tbl(st);
 
 	indio_dev->channels = ad7768_channels;
 	indio_dev->num_channels = ARRAY_SIZE(ad7768_channels);
-- 
2.34.1


