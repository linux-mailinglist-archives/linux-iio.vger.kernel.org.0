Return-Path: <linux-iio+bounces-16506-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF9BA5584A
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 22:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E28A33B4CDE
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 21:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED0827C850;
	Thu,  6 Mar 2025 21:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Ykg91wx/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8D927BF70;
	Thu,  6 Mar 2025 21:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741295091; cv=none; b=R9LOWr6RX4ZnLUyD67UNtvU5krT63jXkdwmGY3QFB0o5AHqoHQzdS8jfpET9Qloju1yh1F9FfkI0HPE9MfkHR0V1efWtCkxRhDW0b4tfP0w6/+TAM0S1tg7a3830cKGQjd4/T4zA+yDMz2d5ZKlvyQ1QVsAHpQX+UcL6oUh2GHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741295091; c=relaxed/simple;
	bh=YWz3oLww3UuzR6zFLRvsB/COezDDJ6SDc35E9H+CCzs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iCyo4scTbXGAQ9gdClVZis5QBNqpKkT8nAJNrYmNX+cB64Lryn85xpVRKD7YEwvdQcVccxnH3B8jtfxLA2AEQRzggEMEsEiqaaIwsR+Q6TOgxl7pzg8Qkhf7ZNP2PW0ArUPO4b65VDzP9m6UkaMs1DPdh0ShSohM2+LekF3UsXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Ykg91wx/; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526HfeVW032558;
	Thu, 6 Mar 2025 16:04:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=vD8hE
	aA+yJpOfP6fl5xUBgFobnAwlHXHoMkzYmNR4wY=; b=Ykg91wx/+qI0ydonya8Sx
	kXJh9549jewSTpmu+vk9skuKLE+mvggCERV6LG3sHV7z4F7hNPTVJMscleRjWaNp
	Ts9fBGSvfmR6NWJOBF7z0Tzd5qvan+AyET4L68aPIJqMQjA3oT/wmOPEyVMpjV2/
	bGQW/6jG4QT+L8N5ELhW//PM0jFpZBBzbpRYI2NLnhNUP/asaE7JVXTwuNgvgq+f
	5OPQo+eYvKx+juvUvCOYc5ex14zttbz6lwyeP19eY/OqqtF/HAhQYRyZsEeJnSqy
	AiqEI3KScasK4/mzTX/brPPa2+ERUXzMH/kQ7VKowIi5+/pKKPN2FIeH1tCDykZZ
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 457d6x1tfn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Mar 2025 16:04:27 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 526L4QRu035115
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 6 Mar 2025 16:04:26 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 6 Mar 2025
 16:04:25 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 6 Mar 2025 16:04:25 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 526L47Nb011700;
	Thu, 6 Mar 2025 16:04:10 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
        <jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <dlechner@baylibre.com>,
        <marcelo.schmitt1@gmail.com>, <jonath4nns@gmail.com>
Subject: [PATCH v4 15/17] iio: adc: ad7768-1: replace manual attribute declaration
Date: Thu, 6 Mar 2025 18:04:07 -0300
Message-ID: <6d429bf18851e9e423e90252d351db550b2da536.1741268122.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1741268122.git.Jonathan.Santos@analog.com>
References: <cover.1741268122.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: CcOdRD-tqQ9Bk0bgs5p0ytgUdq3uDVrY
X-Proofpoint-ORIG-GUID: CcOdRD-tqQ9Bk0bgs5p0ytgUdq3uDVrY
X-Authority-Analysis: v=2.4 cv=E4w3pbdl c=1 sm=1 tr=0 ts=67ca0ddb cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=Vs1iUdzkB0EA:10 a=gAnH3GRIAAAA:8 a=sZ3-a7YyMoAqg91e5hoA:9 a=-1-I_b6esv12khfgqfCz:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_07,2025-03-06_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 impostorscore=0 phishscore=0 clxscore=1015 mlxscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503060160

Use read_avail callback from struct iio_info to replace the manual
declaration of sampling_frequency_available attribute.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
v4 Changes:
* Added ad7768_fill_samp_freq_tbl() helper function.
* Sampling frequency table is precomputed at probe.

v3 Changes:
* New patch in v3.
---
 drivers/iio/adc/ad7768-1.c | 63 +++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 32 deletions(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index c48d3e0af985..0bdf2ae903c6 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -187,6 +187,7 @@ static const struct iio_chan_spec ad7768_channels[] = {
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
 		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),
 		.indexed = 1,
 		.channel = 0,
 		.scan_index = 0,
@@ -208,6 +209,7 @@ struct ad7768_state {
 	unsigned int mclk_freq;
 	unsigned int dec_rate;
 	unsigned int samp_freq;
+	unsigned int samp_freq_avail[ARRAY_SIZE(ad7768_clk_config)];
 	struct completion completion;
 	struct iio_trigger *trig;
 	struct gpio_desc *gpio_sync_in;
@@ -306,6 +308,15 @@ static int ad7768_send_sync_pulse(struct ad7768_state *st)
 	return 0;
 }
 
+static void ad7768_fill_samp_freq_tbl(struct ad7768_state *st)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ad7768_clk_config); i++)
+		st->samp_freq_avail[i] = DIV_ROUND_CLOSEST(st->mclk_freq,
+							   ad7768_clk_config[i].clk_div);
+}
+
 static int ad7768_set_mode(struct ad7768_state *st,
 			   enum ad7768_conv_mode mode)
 {
@@ -566,28 +577,6 @@ static int ad7768_set_freq(struct ad7768_state *st,
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
@@ -635,6 +624,24 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
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
@@ -657,15 +664,6 @@ static int ad7768_read_label(struct iio_dev *indio_dev,
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
@@ -676,8 +674,8 @@ static int ad7768_get_current_scan_type(const struct iio_dev *indio_dev,
 }
 
 static const struct iio_info ad7768_info = {
-	.attrs = &ad7768_group,
 	.read_raw = &ad7768_read_raw,
+	.read_avail = &ad7768_read_avail,
 	.write_raw = &ad7768_write_raw,
 	.read_label = ad7768_read_label,
 	.get_current_scan_type = &ad7768_get_current_scan_type,
@@ -1134,6 +1132,7 @@ static int ad7768_probe(struct spi_device *spi)
 		return PTR_ERR(st->mclk);
 
 	st->mclk_freq = clk_get_rate(st->mclk);
+	ad7768_fill_samp_freq_tbl(st);
 
 	indio_dev->channels = ad7768_channels;
 	indio_dev->num_channels = ARRAY_SIZE(ad7768_channels);
-- 
2.34.1


