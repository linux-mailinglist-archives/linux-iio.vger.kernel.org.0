Return-Path: <linux-iio+bounces-20383-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2BDAD43F7
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jun 2025 22:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88DB5169612
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jun 2025 20:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B6A266EE7;
	Tue, 10 Jun 2025 20:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="cEHJuXEp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD3C265CCA;
	Tue, 10 Jun 2025 20:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749587688; cv=none; b=tivQ55HkmJTtzOpT7t+xhxCwwfzg4N44lJgOZZgvfh3txQ5a5Gii6IyMr25L3lHzBuasvGCsIIROE0wfNacxA04YnQmqXfdwCP7FSbI75g04w2wBZs4MDoa1jN8TTSeunlVTM86Qx3NpQANDz+xbS7uLNZCzcA1ZCK+NTECdNdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749587688; c=relaxed/simple;
	bh=IS2J/Pbk1mvtGe9o1qv4NM9OVy1mivGH7q5Z2v32i6M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TjUj2eyk7BPsNEH5FtzrU5pgrKnKZ4OhZ1m1UZHvWPCNXnPdGHx1b8ipBbk7igTdRRGK1DEXoKIB511vm4J+UniTtchi0Hcric8mcEt+Cx0IW+lZDivWWJzfOrLj9mE3UlNN5UfVMLT8DD4Aq27r7xV7v6g0sF6TXJ5aN8Rt3XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=cEHJuXEp; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AIBr05016764;
	Tue, 10 Jun 2025 16:34:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ZWVFn
	cBfVIe7OCSqZnxFhbUoI6mT5blcCrJbZBydjPU=; b=cEHJuXEpAmJ0GTmSe/KPM
	eZEfVbqGrysYD8HESAWgGeRi4l+WBfB4+QwN35hyRyfkzA/BjEO0BhcFAw1273rX
	wBzH8i7fFCnYW81sUUXo++XZ11DhGh9XoVvXR0+u3fzJKXk8Yrw/x0zz04IY+2o5
	PcmNv9J9y52oofhRbjCvkJfioo17+ovzXgSUtIT5ptFEalaDUow8S1wI5GuN8Epx
	eKA2bLjK1tWJHULyXBs13kTPiI+vR/4VGiG2xOO3iPLUAjnZzjWn+XmjK5iedNO6
	M0DbYIwu9nXFP6yd2wd4hlBy4U1lzoR44naizUbCKID6Hw4UbqYKJQuZ678CNApd
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 476n7yadwd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Jun 2025 16:34:30 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 55AKYTSJ040414
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 10 Jun 2025 16:34:29 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 10 Jun 2025 16:34:29 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 10 Jun 2025 16:34:29 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 10 Jun 2025 16:34:29 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 55AKYDTh019956;
	Tue, 10 Jun 2025 16:34:16 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v5 11/11] iio: adc: ad4170: Add timestamp channel
Date: Tue, 10 Jun 2025 17:34:13 -0300
Message-ID: <ed276200954d13ebb78b257815cc039c6991cf19.1749582679.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1749582679.git.marcelo.schmitt@analog.com>
References: <cover.1749582679.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=Z7TsHGRA c=1 sm=1 tr=0 ts=684896d6 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=6IFa9wvqVegA:10 a=gAnH3GRIAAAA:8 a=ooJTjvKFDTQpXrV7GjsA:9
X-Proofpoint-ORIG-GUID: 1CjA6B8zqibm4_m5_Pr23wQrFii_vCKt
X-Proofpoint-GUID: 1CjA6B8zqibm4_m5_Pr23wQrFii_vCKt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDE2NiBTYWx0ZWRfX1AaAZdG2zVYo
 Sy4c4Z9HlV57m+nrc+XPHoq9QQQl1a6I16z0i7VmDTCNgrYVX80INIJkR3Vx2HFalFaaXzn1cD2
 DoYBkz7bH5qoQvblSpZZFWP2J6qN/9vWM80hDnOIOfO5vivA1dOndq1FlFUnU/2aAq7WYT8JCc/
 3iYUcpFVn5WKKwEuNp9qi+3KEelcOzRYpT6frgcWIYkUgV9DCnurxfeGgi0DKetYPP//39fkp8Y
 MIgeeyGxncNJHPHkpjK8OAfovu8QhpCfgjIvY4fAnim5PDXWcLgSMkuyoKLk70DNb8Jt/7BUkiE
 RMR05dyBkl6pJl3hEwnEd3sQM/Ydj/OxlZHMNEbzZo4falHEUUrsc2yw6CmZsmCg6WiZ4W6VwLM
 JP+BkbXnukr1iM6iLPXgEOuhmJSwmOkx2e0n/zK4cS5fPXosZlVJ2066HkBxZYXZhDzcuhkb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_09,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 mlxscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=999
 malwarescore=0 suspectscore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506100166

Add timestamp channel allowing to record the moment at which ADC samples
are captured in buffered read mode.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
No changes from v4.

 drivers/iio/adc/ad4170.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad4170.c b/drivers/iio/adc/ad4170.c
index 96274b20e9d2..db244c1533b4 100644
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
@@ -429,7 +430,7 @@ struct ad4170_state {
 	int vrefs_uv[AD4170_MAX_SUP];
 	u32 mclk_hz;
 	struct ad4170_setup_info setup_infos[AD4170_MAX_SETUPS];
-	struct iio_chan_spec chans[AD4170_MAX_CHANNELS];
+	struct iio_chan_spec chans[AD4170_MAX_IIO_CHANNELS];
 	struct ad4170_chan_info chan_infos[AD4170_MAX_CHANNELS];
 	struct spi_device *spi;
 	struct regmap *regmap;
@@ -446,6 +447,7 @@ struct ad4170_state {
 	unsigned int clock_ctrl;
 	int gpio_fn[AD4170_NUM_GPIO_PINS];
 	unsigned int cur_src_pins[AD4170_NUM_CURRENT_SRC];
+	unsigned int num_adc_chans;
 	/*
 	 * DMA (thus cache coherency maintenance) requires the transfer buffers
 	 * to live in their own cache lines.
@@ -2387,7 +2389,16 @@ static int ad4170_parse_channels(struct iio_dev *indio_dev)
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
 
@@ -2579,7 +2590,7 @@ static int ad4170_initial_config(struct iio_dev *indio_dev)
 		return dev_err_probe(dev, ret,
 				     "Failed to set ADC mode to idle\n");
 
-	for (i = 0; i < indio_dev->num_channels; i++) {
+	for (i = 0; i < st->num_adc_chans; i++) {
 		struct ad4170_chan_info *chan_info;
 		struct iio_chan_spec const *chan;
 		struct ad4170_setup *setup;
@@ -2704,7 +2715,7 @@ static int ad4170_buffer_predisable(struct iio_dev *indio_dev)
 	 * is done after buffer disable. Disable all channels so only requested
 	 * channels will be read.
 	 */
-	for (i = 0; i < indio_dev->num_channels; i++) {
+	for (i = 0; i < st->num_adc_chans; i++) {
 		ret = ad4170_set_channel_enable(st, i, false);
 		if (ret)
 			return ret;
@@ -2754,7 +2765,9 @@ static irqreturn_t ad4170_trigger_handler(int irq, void *p)
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


