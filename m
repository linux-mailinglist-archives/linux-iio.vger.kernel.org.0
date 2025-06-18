Return-Path: <linux-iio+bounces-20774-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FB3ADF428
	for <lists+linux-iio@lfdr.de>; Wed, 18 Jun 2025 19:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 522DE1BC29CA
	for <lists+linux-iio@lfdr.de>; Wed, 18 Jun 2025 17:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0C92F4305;
	Wed, 18 Jun 2025 17:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="TTJLXC1c"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E842F363C;
	Wed, 18 Jun 2025 17:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750268393; cv=none; b=HcFMVVbKxk3aMzIcp0nAvqDgpSKvMgp1ox7n6BA79bqVrJkKmuooTZr3t3XkBl5kh0Ft+yCdqEipaUo/AlF5wF+qSu89Pc1hlZRMLFhcNA6nxT8zNgMenAOklyLMSiYROoBP4xRwPM5N0WMFeNL/R+WzxwH93mwM1E9iuj6Rpa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750268393; c=relaxed/simple;
	bh=/pPJSNAfLSroCKYHXJLWwJVsQr93kBLP7GVw4wmp2I4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kEFV7Wt9wzmoDn37o+dqZrACdwQol9DNFCAQo9Ds6+0hNa1ubgNZlhmZzbpuASDlqmw8LpxrmdHXk2o1vjXlnyN0pqMD4JsiGqLNXNacIe6JC5Pfy2FAg4Xh5MlQCLIralG/YMWKw7YwDI/3HhGRMRpBNIRQwVQV1jwHai/6AxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=TTJLXC1c; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55IG03ao031954;
	Wed, 18 Jun 2025 13:39:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=HTMmK
	MgAUBd8WEFA9l2xGUFLTHm+A38dMxJbz03dPNY=; b=TTJLXC1ctWFL3aQ38Qqsz
	rEP74v9btSVWUiwaiRtVLBz3VN/tCfkQubWS3FJ08zG+XkZmNWStNlZFZxv6QbEw
	1ufkLn6mJxwzPjZwtH+0YE1mLJ4qYfAhUzRUyXb24KTR6iEAV+l6ay6WOFzDsM64
	QcpSZX5GCRoVfp3gLNPEl2QSW3OlVl1OtfnX1hVJ3Z+Y8P2S0bFxqxU8vtuBiCl4
	Zdvri0lxwn+Llkkl3kkJiaaUJ1XIMEEpi2MjC7SScF3gwdfsehfzIfpqoz6VGrTw
	VSQMaacxPIm+BdvYTtYUmc7iuLD/mgPp14AiXq5Q9LTiNMU/IGsvI6G0Ssv3Kipo
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 47bfshddpc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Jun 2025 13:39:32 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 55IHdVpY016246
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 18 Jun 2025 13:39:31 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 18 Jun
 2025 13:39:31 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 18 Jun 2025 13:39:31 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 55IHdDLx007658;
	Wed, 18 Jun 2025 13:39:15 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linus.walleij@linaro.org>, <brgl@bgdev.pl>, <broonie@kernel.org>,
        <lgirdwood@gmail.com>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v6 12/12] iio: adc: ad4170: Add timestamp channel
Date: Wed, 18 Jun 2025 14:39:12 -0300
Message-ID: <63ebf4408a118a749481ecb3f5ce7ad67cedfa7b.1750258776.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1750258776.git.marcelo.schmitt@analog.com>
References: <cover.1750258776.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: wbgdZ0c0wYrprg2Qn6H9Y4KcxBfgpDQV
X-Authority-Analysis: v=2.4 cv=SKhCVPvH c=1 sm=1 tr=0 ts=6852f9d4 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=6IFa9wvqVegA:10 a=gAnH3GRIAAAA:8 a=ooJTjvKFDTQpXrV7GjsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDE1MCBTYWx0ZWRfX8r2pr08BrSmd
 ftGGA6y4QdW9K/9Ig3fcG4o8Hz+N9NnwK08dYyAZ5MJ8Xpr0RRz1SjAMooWB9JUp/y3SWizUpC9
 A91KdbN1JwbNg6ZPZ9uQT9RlwNZ6jbwMp0BKzJAhU1oJXV7ensto+tnRIgkT9eB1h4B68DXpVqB
 v5UxoTeJ/k45sXZgHnS9cBlvuKAcwWqVNgIywAlUsxavwcY1WXBTtppXaRCI6NRgaM0cpqLc22g
 XmG6wJICxUxpcb2CwspgAY9BYUJY61O+8g69/TQH8NXgKCL5KPkLVg9VzTB0v48/R5N4YyKHQLm
 6/poQI6ElkC23WnQstmm1gQi29CyOseusM0X0LLNyRLUV8S1fXgE9BT4W+v+XvVc8eilzMqqNKy
 e/wbKu6Rwhl65f/fPBjZ6Erc0v0n5ZJbN+0Cs3RKdZx6FlYahJKADd4rmdUmo/LKUYpfTI3b
X-Proofpoint-GUID: wbgdZ0c0wYrprg2Qn6H9Y4KcxBfgpDQV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_05,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015
 phishscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506180150

Add timestamp channel allowing to record the moment at which ADC samples
are captured in buffered read mode.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
No changes in v6.

 drivers/iio/adc/ad4170.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad4170.c b/drivers/iio/adc/ad4170.c
index 2a2d4a05e9af..33b9a6b2255b 100644
--- a/drivers/iio/adc/ad4170.c
+++ b/drivers/iio/adc/ad4170.c
@@ -185,6 +185,7 @@
 #define AD4170_NUM_ANALOG_PINS				9
 #define AD4170_NUM_GPIO_PINS				4
 #define AD4170_MAX_CHANNELS				16
+#define AD4170_MAX_IIO_CHANNELS				(AD4170_MAX_CHANNELS + 1)
 #define AD4170_MAX_ANALOG_PINS				8
 #define AD4170_MAX_SETUPS				8
 #define AD4170_INVALID_SETUP				9
@@ -437,7 +438,7 @@ struct ad4170_state {
 	int vrefs_uv[AD4170_MAX_SUP];
 	u32 mclk_hz;
 	struct ad4170_setup_info setup_infos[AD4170_MAX_SETUPS];
-	struct iio_chan_spec chans[AD4170_MAX_CHANNELS];
+	struct iio_chan_spec chans[AD4170_MAX_IIO_CHANNELS];
 	struct ad4170_chan_info chan_infos[AD4170_MAX_CHANNELS];
 	struct spi_device *spi;
 	struct regmap *regmap;
@@ -454,6 +455,7 @@ struct ad4170_state {
 	unsigned int clock_ctrl;
 	int gpio_fn[AD4170_NUM_GPIO_PINS];
 	unsigned int cur_src_pins[AD4170_NUM_CURRENT_SRC];
+	unsigned int num_adc_chans;
 	/*
 	 * DMA (thus cache coherency maintenance) requires the transfer buffers
 	 * to live in their own cache lines.
@@ -2389,7 +2391,16 @@ static int ad4170_parse_channels(struct iio_dev *indio_dev)
 			return dev_err_probe(dev, ret, "Invalid input config\n");
 
 		st->chan_infos[chan_num].input_range_uv = ret;
+		chan_num++;
 	}
+	st->num_adc_chans = chan_num;
+
+	/* Add timestamp channel */
+	struct iio_chan_spec ts_chan = IIO_CHAN_SOFT_TIMESTAMP(chan_num);
+
+	st->chans[chan_num] = ts_chan;
+	num_channels = num_channels + 1;
+
 	indio_dev->num_channels = num_channels;
 	indio_dev->channels = st->chans;
 
@@ -2581,7 +2592,7 @@ static int ad4170_initial_config(struct iio_dev *indio_dev)
 		return dev_err_probe(dev, ret,
 				     "Failed to set ADC mode to idle\n");
 
-	for (i = 0; i < indio_dev->num_channels; i++) {
+	for (i = 0; i < st->num_adc_chans; i++) {
 		struct ad4170_chan_info *chan_info;
 		struct iio_chan_spec const *chan;
 		struct ad4170_setup *setup;
@@ -2706,7 +2717,7 @@ static int ad4170_buffer_predisable(struct iio_dev *indio_dev)
 	 * is done after buffer disable. Disable all channels so only requested
 	 * channels will be read.
 	 */
-	for (i = 0; i < indio_dev->num_channels; i++) {
+	for (i = 0; i < st->num_adc_chans; i++) {
 		ret = ad4170_set_channel_enable(st, i, false);
 		if (ret)
 			return ret;
@@ -2758,7 +2769,9 @@ static irqreturn_t ad4170_trigger_handler(int irq, void *p)
 		memcpy(&st->bounce_buffer[i++], st->rx_buf, ARRAY_SIZE(st->rx_buf));
 	}
 
-	iio_push_to_buffers(indio_dev, st->bounce_buffer);
+	iio_push_to_buffers_with_ts(indio_dev, st->bounce_buffer,
+				    sizeof(st->bounce_buffer),
+				    iio_get_time_ns(indio_dev));
 err_out:
 	iio_trigger_notify_done(indio_dev->trig);
 	return IRQ_HANDLED;
-- 
2.47.2


