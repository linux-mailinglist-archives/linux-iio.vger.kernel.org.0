Return-Path: <linux-iio+bounces-20137-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C7FACAD73
	for <lists+linux-iio@lfdr.de>; Mon,  2 Jun 2025 13:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DC843BE7C1
	for <lists+linux-iio@lfdr.de>; Mon,  2 Jun 2025 11:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BFE2116E0;
	Mon,  2 Jun 2025 11:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="UT/VHevy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C0120F067;
	Mon,  2 Jun 2025 11:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748864461; cv=none; b=q3RYKbQsv6h+zTr589ihMqWLlScbMSasOGAJcCxa7HueZv2NBF0MCVt6IA+9vVciigzetukLiqRhpx633y6rSEtzsZolPaszSNZdQqJZzb71b5qzur3lCKpYRBE91oGyE0tyg1GzxvUWhMtTtDNKnxniybgDVtged41tQipaZ/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748864461; c=relaxed/simple;
	bh=frO+5Uw+FFWvnZhmxBsgg95PnNMzamfOuSyyhM7pW/E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aU1MEZ0bUfoqSuxSfi1KrWgf1nDsY4vbUhyVukeloL/j6I28ucDbAOLFa8OUDPpf2PULVXqgOMwmrjxicrLDxpmk8R1cWUuAH/TvOtp5CSpYitX1bG+UxtUfb+s19hBa0ePO9aKBDaWAwaXSd/BEH7LlrPBXY3ztmO2psO456JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=UT/VHevy; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 552BSViv006785;
	Mon, 2 Jun 2025 07:40:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=FOb5a
	J2aVNLZu+0Loa+8hBFtGDoQeca0LadPc3yuziE=; b=UT/VHevygegDf09CgX+ef
	TEKw38uZ07lUNHBoAHYfXdQgZcYk/k8ZF33NdbexPdIJS9dwF8136SGsbaqp+E4i
	GZhqjvYrJAsu5dggjlepsO4BiXu8SB/HCRGu53bP/G4EkBGXQpv0EX4OhjAPbGD+
	mL/4AISSGZc/FQhWj1dkL+rR/6a76JgZJvV7+0XK0QToDAEVhcaGlPO/qiA1FYT0
	XW8gLCjVIuSRLq5YQie60LiQS9RypQqmaUBhyZtvoaXLp3T3G3ps/ZAJ3GRX3pKc
	j5S6YZVWHNNPOskEF4NlF+bCq0tCCcDW8hRO6kKqwtq2F1JuQ0ZxWxtpSFVbP4Ax
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 47133mj2rd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Jun 2025 07:40:43 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 552BeaPX023600
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 2 Jun 2025 07:40:36 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 2 Jun
 2025 07:40:36 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 2 Jun 2025 07:40:36 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 552BeKS8025010;
	Mon, 2 Jun 2025 07:40:23 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v4 11/11] iio: adc: ad4170: Add timestamp channel
Date: Mon, 2 Jun 2025 08:40:17 -0300
Message-ID: <40f7403efbca2cade808a769a9b3b50135a24fec.1748829860.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1748829860.git.marcelo.schmitt@analog.com>
References: <cover.1748829860.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: uv6iOJUWhFW5DeZ6ZySy4S-3Og5mA2Nm
X-Proofpoint-ORIG-GUID: uv6iOJUWhFW5DeZ6ZySy4S-3Og5mA2Nm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAyMDEwMSBTYWx0ZWRfXxvnatpSFvHSv
 0ii+4auimX24jw/Zl4BOGTEz2G0fH2rApxEAIJkVVKgf8ID6b7W0R0W5TVlRSJPvCFDCFSxtbWM
 hcCcwn+uLbeOqwBPBxTeLsHveW6JJzCltjqAb1hu4PxQSFAmbZ0xUT2M669riqsOSILjKT6+2h6
 +l6jhfj0EA9Ni22fufGfy0AvELi/fZcgU+Go0RManRc5qZJs+ONbfcjPc/7taZbE1Y0aHwuDpx5
 00Q4/sLfQzfNvj4XDYBLy6GLAYxluATW1uE8ih5XeXBtO8FRbrnN6oemWb8yGBoamkKTMueDVmR
 RV5Gz6nMu+wTPz76oZMvFb7vuTPBz08zEAnMHvlk422sRwMW7A7ftxsjbfoUOheHXkhudta+wU4
 xU4Jvu5sHdpuET3OKEVlBQaheSSzMElFQwd59IcAiGppYTiAu3xUcv+uOsRRhe9Ml3g2NNWN
X-Authority-Analysis: v=2.4 cv=DY4XqutW c=1 sm=1 tr=0 ts=683d8dbb cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=6IFa9wvqVegA:10 a=gAnH3GRIAAAA:8 a=ooJTjvKFDTQpXrV7GjsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-02_05,2025-05-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 spamscore=0 clxscore=1015 malwarescore=0 adultscore=0
 bulkscore=0 impostorscore=0 phishscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2506020101

Add timestamp channel allowing to record the moment at which ADC samples
are captured in buffered read mode.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 drivers/iio/adc/ad4170.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad4170.c b/drivers/iio/adc/ad4170.c
index 23b634d324a7..28466b245567 100644
--- a/drivers/iio/adc/ad4170.c
+++ b/drivers/iio/adc/ad4170.c
@@ -182,6 +182,7 @@
 #define AD4170_NUM_ANALOG_PINS				9
 #define AD4170_NUM_GPIO_PINS				4
 #define AD4170_MAX_CHANNELS				16
+#define AD4170_MAX_IIO_CHANNELS				(AD4170_MAX_CHANNELS + 1)
 #define AD4170_MAX_ANALOG_PINS				8
 #define AD4170_MAX_SETUPS				8
 #define AD4170_INVALID_SETUP				9
@@ -426,7 +427,7 @@ struct ad4170_state {
 	int vrefs_uv[AD4170_MAX_SUP];
 	u32 mclk_hz;
 	struct ad4170_setup_info setup_infos[AD4170_MAX_SETUPS];
-	struct iio_chan_spec chans[AD4170_MAX_CHANNELS];
+	struct iio_chan_spec chans[AD4170_MAX_IIO_CHANNELS];
 	struct ad4170_chan_info chan_infos[AD4170_MAX_CHANNELS];
 	struct spi_device *spi;
 	struct regmap *regmap;
@@ -443,6 +444,7 @@ struct ad4170_state {
 	unsigned int clock_ctrl;
 	int gpio_fn[AD4170_NUM_GPIO_PINS];
 	unsigned int cur_src_pins[AD4170_NUM_CURRENT_SRC];
+	unsigned int num_adc_chans;
 	/*
 	 * DMA (thus cache coherency maintenance) requires the transfer buffers
 	 * to live in their own cache lines.
@@ -2385,7 +2387,16 @@ static int ad4170_parse_channels(struct iio_dev *indio_dev)
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
 
@@ -2577,7 +2588,7 @@ static int ad4170_initial_config(struct iio_dev *indio_dev)
 		return dev_err_probe(dev, ret,
 				     "Failed to set ADC mode to idle\n");
 
-	for (i = 0; i < indio_dev->num_channels; i++) {
+	for (i = 0; i < st->num_adc_chans; i++) {
 		struct ad4170_chan_info *chan_info;
 		struct iio_chan_spec const *chan;
 		struct ad4170_setup *setup;
@@ -2702,7 +2713,7 @@ static int ad4170_buffer_predisable(struct iio_dev *indio_dev)
 	 * is done after buffer disable. Disable all channels so only requested
 	 * channels will be read.
 	 */
-	for (i = 0; i < indio_dev->num_channels; i++) {
+	for (i = 0; i < st->num_adc_chans; i++) {
 		ret = ad4170_set_channel_enable(st, i, false);
 		if (ret)
 			return ret;
@@ -2752,7 +2763,9 @@ static irqreturn_t ad4170_trigger_handler(int irq, void *p)
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


