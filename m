Return-Path: <linux-iio+bounces-18745-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3D7A9E561
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 02:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D502189A7B0
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 00:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E8927468;
	Mon, 28 Apr 2025 00:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="jKhwZvQY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1835D8F49;
	Mon, 28 Apr 2025 00:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745799268; cv=none; b=N/v+1T2EH/MBoNBdaYxVtyAhVlMT9jTFtlI9Os4YcHWsCl22hnO+JvlgbFnkNWOTaNzIztayqUROu5Uw1wACSJzmlr/SIOJlEU2r6vxGfUx1OskucoU+SG2c7/a5NI8yx9918RG7+Sq0FvLwU3PiXrYTK125vSORir7ynLXg3jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745799268; c=relaxed/simple;
	bh=05it4FmNmWbIfWDUmwyS1+SdvabUdu3Sh5xOEmToPk4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dhpFV13UU+i2R3IZZNs89t3CptLN6KdQglSQHSFtWcKacj9S6ZkxwbqY8ytk230a5v4/CXxkyzBORR64a4aJgX9EdWxX1LIOy7TQC3njB7HE+LBtqeltsXnr2S27SsK5hWj+sjj90WGgtewKqEnDmH/Vy1Mgg0XrK5VGDqiR0CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=jKhwZvQY; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53RMuqsU019002;
	Sun, 27 Apr 2025 20:14:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=NOfmw
	YH15bgHsJVEp4gXwTqzZ8ugL9s3cRwxc9eYESk=; b=jKhwZvQY+UEMsc5xWS0fm
	sHelnI91+9FweJC/mlqX0eqsdvPN3UAJ/ydR2tT/MJ4W2qtNHqDtR9f7pBXAGS48
	ffkVwaNKfyXq3/hb6h8bYsR/l31TlgDoIlZZSkT/IjQHsdlID7zx3P0tXqwBcvg6
	00GqlInMPT3Eqa+g0vxNxiP06iLMXipVP/BHeMlfYkr+yfrXzChAUT0U3Lb8qw5H
	WWAe8q3wq08m4UQtR4qWTweIOCLWbErNBfGR+uQEKwUfPaSYaUi9mkXx5RWkicm6
	LQisjGkmiIT+p+FB9wsBt8B496pDmIe94a+SvdpsQx/tb8BiyueYRu7pSo0Tq/2s
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 468vd6sbup-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 27 Apr 2025 20:14:21 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 53S0EKAj029033
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 27 Apr 2025 20:14:20 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Sun, 27 Apr 2025 20:14:20 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Sun, 27 Apr 2025 20:14:19 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Sun, 27 Apr 2025 20:14:19 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 53S0E4Lw014648;
	Sun, 27 Apr 2025 20:14:07 -0400
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
Subject: [PATCH v6 09/11] iio: adc: ad7768-1: replace manual attribute declaration
Date: Sun, 27 Apr 2025 21:14:01 -0300
Message-ID: <7c308dac8869a0152c09f6218df32bbc516594d4.1745605382.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1745605382.git.Jonathan.Santos@analog.com>
References: <cover.1745605382.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: lFtg0Wa9_XH9ZK8fa5U-3EbhOdy5hV6e
X-Authority-Analysis: v=2.4 cv=b+Wy4sGx c=1 sm=1 tr=0 ts=680ec85d cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=XR8D0OoHHMoA:10 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8 a=8rrw0zspLT4GB54sGJwA:9 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI3MDIwMiBTYWx0ZWRfX5ksmkXItbf4/ inKhQ2txVV5NvG9Lsu1Fk5TzrE5KvlHMTCcIQ7FxW5fvZQbyaOhPzNv/J2Iqi3kqgtETJci0lsE BHgxuj2W8gDVzYgAqxwoDmglEdiA46NOqZnZdPCjPeqFEFNeC9KGdQ3rmxIpLm2hzFXMKpSMSiD
 5fdxS6radmQ47gZUPz0uaOUxjMwKUl9hYJViJ4obVPyo4Gf+VS+AFZkthtllZ06YwZCD1mUR7E8 1v1qKng/lZZ/Tx4NILyPL7ZPaerJ1NZDNFKKPY5cTjbML0olArJlDuQaVnFS82G1VQKExssKtbE wLUen7WJKCUAZ4pTJ6zBPJrQwypFypEa4jIAugXSD2x/UHzwD34oo6Dz99OdUCjhE58IGHcv1Mu
 F5l332BePSE8pjNCxZVbGCnNiOJuHVvVB2XdCHCiwmmxNWxvGGU6tIiPBMvvZGE8gImYxW9a
X-Proofpoint-ORIG-GUID: lFtg0Wa9_XH9ZK8fa5U-3EbhOdy5hV6e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-27_08,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0 impostorscore=0
 clxscore=1015 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2504270202

Use read_avail callback from struct iio_info to replace the manual
declaration of sampling_frequency_available attribute.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
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
index c00571f17254..10791a85d2c5 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -188,6 +188,7 @@ static const struct iio_chan_spec ad7768_channels[] = {
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
@@ -313,6 +315,15 @@ static int ad7768_send_sync_pulse(struct ad7768_state *st)
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
@@ -570,28 +581,6 @@ static int ad7768_set_freq(struct ad7768_state *st,
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
@@ -637,6 +626,24 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
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
@@ -659,15 +666,6 @@ static int ad7768_read_label(struct iio_dev *indio_dev,
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
@@ -678,8 +676,8 @@ static int ad7768_get_current_scan_type(const struct iio_dev *indio_dev,
 }
 
 static const struct iio_info ad7768_info = {
-	.attrs = &ad7768_group,
 	.read_raw = &ad7768_read_raw,
+	.read_avail = &ad7768_read_avail,
 	.write_raw = &ad7768_write_raw,
 	.read_label = ad7768_read_label,
 	.get_current_scan_type = &ad7768_get_current_scan_type,
@@ -1174,6 +1172,7 @@ static int ad7768_probe(struct spi_device *spi)
 		return PTR_ERR(st->mclk);
 
 	st->mclk_freq = clk_get_rate(st->mclk);
+	ad7768_fill_samp_freq_tbl(st);
 
 	indio_dev->channels = ad7768_channels;
 	indio_dev->num_channels = ARRAY_SIZE(ad7768_channels);
-- 
2.34.1


