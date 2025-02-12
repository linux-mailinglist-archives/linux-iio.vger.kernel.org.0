Return-Path: <linux-iio+bounces-15472-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 834BFA32E7A
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 19:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9E91188ADD1
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 18:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F5725C6FD;
	Wed, 12 Feb 2025 18:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="g6efmRyD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF8B1DC075;
	Wed, 12 Feb 2025 18:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739384361; cv=none; b=HfInC8+juLaGkLyLJdjzz+ihEBBP0U/VF6Ve9mRQMcR4XsCblBHF/A3vkpB5xtPEue9WYW1d3W1XIL5QrbVpsMe9UZHgcexwAwtaov4YsD+qU9Ml6ZJQFn7QDKQ/hgSxLFU7uMG4O/duKo2OTvr0IPLh+HYc06jHbwzgbV0MSNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739384361; c=relaxed/simple;
	bh=SRy4zTzM6245aOP1biR73JXoDBHG5EpddWMLLRlLkuI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uHqh8urb5U2jzWPB3hzN9fX6LN/JYmVh1JNUl0PlLxHFSfvrst2n6SqYiK3hi1fr2Bg4Jdny6Cg3tisTdUQu+IAr3A3K2tXr0FdKmuDaVav0UhIqzZR611MMJTTJEZlwx6to6/zUrb4FPgQ0pdD5SgyhO13165vZf4ajxU+36S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=g6efmRyD; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51CF81jK019227;
	Wed, 12 Feb 2025 13:19:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ClU66
	BLK455sndyg8lcVgoL2Lgk38I/+nZixdUt7Czs=; b=g6efmRyDQ7JP5tX7eZ7kG
	sAsOacTKSsFcwGJymWVIFSvWjSOHHIfLVQVZm6WppAvjWwobTWSDmZcXGqgCyM20
	OJJJekA4mn2dK57QpiZOuIjovtQWoKBk2jwJT3gXPdS/0ZgaT3jveSAdf7vHLuKS
	BiqoyYqBtBZHLn6c9q9isDcvpPbOVyAFusxUP966QSVoa/0Wclfx7YzBud6/nxKG
	PHx0f773+mAcuevGk0mAQulM9ixg7CWEAPdKeIw4KgX2CxvYMJ3ZVZdn6pxMLcIz
	YXZobEdjRMbVLGTDnMQmkTDktHXylHWPdUIqnlAjt/qypRmdq8/lA7sXWCS+L7Mj
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 44rs9aa4vm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 13:19:05 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 51CIJ42c041165
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Feb 2025 13:19:04 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 12 Feb 2025 13:19:04 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 12 Feb 2025 13:19:04 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 12 Feb 2025 13:19:04 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 51CIImfo017528;
	Wed, 12 Feb 2025 13:18:51 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
        <jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <jonath4nns@gmail.com>,
        <marcelo.schmitt1@gmail.com>, <dlechner@baylibre.com>
Subject: [PATCH RESEND v3 15/17] iio: adc: ad7768-1: replace manual attribute declaration
Date: Wed, 12 Feb 2025 15:18:48 -0300
Message-ID: <ea5d5ef777d4d7d15471369813c1613990fee862.1739368121.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1739368121.git.Jonathan.Santos@analog.com>
References: <cover.1739368121.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: p6_-Ytj9wD5nlGaFFAGzyJHnk9nPORd8
X-Authority-Analysis: v=2.4 cv=ZdznNtVA c=1 sm=1 tr=0 ts=67ace619 cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=T2h4t0Lz3GQA:10 a=gAnH3GRIAAAA:8 a=34ukCDL0mvVEODs9j24A:9 a=4k2dNJAxD_26jHyv--em:22 a=oVHKYsEdi7-vN-J5QA_j:22
X-Proofpoint-ORIG-GUID: p6_-Ytj9wD5nlGaFFAGzyJHnk9nPORd8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_05,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 spamscore=0 suspectscore=0 mlxscore=0 clxscore=1015
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502120132

Use read_avail callback from struct iio_info to replace the manual
declaration of sampling_frequency_available attribute.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
v3 Changes:
* New patch in v3.
---
 drivers/iio/adc/ad7768-1.c | 58 +++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 32 deletions(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 716cf3582577..8aea38c154fe 100644
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
@@ -207,6 +208,7 @@ struct ad7768_state {
 	unsigned int mclk_freq;
 	unsigned int dec_rate;
 	unsigned int samp_freq;
+	unsigned int samp_freq_avail[ARRAY_SIZE(ad7768_clk_config)];
 	struct completion completion;
 	struct iio_trigger *trig;
 	struct gpio_desc *gpio_sync_in;
@@ -564,28 +566,6 @@ static int ad7768_set_freq(struct ad7768_state *st,
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
@@ -633,6 +613,29 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
+static int ad7768_read_avail(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     const int **vals, int *type, int *length,
+			     long info)
+{
+	struct ad7768_state *st = iio_priv(indio_dev);
+	int i;
+
+	switch (info) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		for (i = 0; i < ARRAY_SIZE(ad7768_clk_config); i++)
+			st->samp_freq_avail[i] = DIV_ROUND_CLOSEST(st->mclk_freq,
+								   ad7768_clk_config[i].clk_div);
+
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
@@ -655,15 +658,6 @@ static int ad7768_read_label(struct iio_dev *indio_dev,
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
@@ -674,8 +668,8 @@ static int ad7768_get_current_scan_type(const struct iio_dev *indio_dev,
 }
 
 static const struct iio_info ad7768_info = {
-	.attrs = &ad7768_group,
 	.read_raw = &ad7768_read_raw,
+	.read_avail = &ad7768_read_avail,
 	.write_raw = &ad7768_write_raw,
 	.read_label = ad7768_read_label,
 	.get_current_scan_type = &ad7768_get_current_scan_type,
-- 
2.34.1


