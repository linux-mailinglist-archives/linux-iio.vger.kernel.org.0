Return-Path: <linux-iio+bounces-7854-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C1993B400
	for <lists+linux-iio@lfdr.de>; Wed, 24 Jul 2024 17:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28A4E1C23A46
	for <lists+linux-iio@lfdr.de>; Wed, 24 Jul 2024 15:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE3B15B554;
	Wed, 24 Jul 2024 15:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="nH7Dltkw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F72C158849;
	Wed, 24 Jul 2024 15:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721835637; cv=none; b=lSzq2Xs4ZBD90+azcX+h51j+6m16xH9vNiC1ncfHX7x5vABlewyWLl0hjNoOW3/DnL6WLovqo77Hn90tXkhn0hz9Qe0yj7cSspnsbwBsLXOi0aY0cD7tuxe4Pl65CkoqPWJ0z3ZQiwob+1Y7zxm3xnHGWuQAgQ5fa1iXe4zVQ8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721835637; c=relaxed/simple;
	bh=DROFa2dhgfRnJjkwP7CG/XgFQ6P5ByE5XGITGZQdNi8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a5MvxOXpNuyPrKnhIyE2kZeGmlmX/VJFmHktURQYFd+j8RHzgr/x/tQLvbBXPwv/BYJY7NdLcKJlLq4eRdzBnXxneIynFv/86TfWsOyLIQrZyzoBCdWSxv6jcxcoEBaUWZuTxNocI9eieKEtkl6ZLsvLvMSnRlU0xloITXSJH1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=nH7Dltkw; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46OBtLCW014213;
	Wed, 24 Jul 2024 17:40:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	zDNWMdypfg8LkK3fUwWbqgyUaepKSExo7kBVgLi+evA=; b=nH7DltkwdKQc8x20
	1rBUczhjZ9VJC9B8oDWxxFK3ZjocRLzaAsnyIKl4x+RhJrNOtHuj/LwxULgBNR7M
	6pIC8EtsapL+aNMxdTTpEOln5lEyCUZEq0hQG7MsqWSbBQSNReCoFxVc9v8UDovi
	RfT2WshxcjDNDmIclF2sIVZ8ji/lzIOuWvA4TsdXDK68grIXKaQXCKiYu7OEuCoJ
	mc97AvqZrrsNe8C2bIJaZt1CK6bX7qrTAGJlUJOhYZn0CznmWclaJqy8oMPfn9L2
	qDK99GVPfHDjow5GJZP7+1JuNrCDQytytQiTXJj3Hs7suy3NOnmOEbj1uWlyhMt6
	UVSJQg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 40g2nh87rq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 17:40:08 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id A85BC40048;
	Wed, 24 Jul 2024 17:40:04 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 43264241B43;
	Wed, 24 Jul 2024 17:39:35 +0200 (CEST)
Received: from localhost (10.252.12.39) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 24 Jul
 2024 17:39:34 +0200
From: Olivier Moysan <olivier.moysan@foss.st.com>
To: <fabrice.gasnier@foss.st.com>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: Olivier Moysan <olivier.moysan@foss.st.com>, <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 7/9] iio: adc: stm32-dfsdm: adopt generic channels bindings
Date: Wed, 24 Jul 2024 17:36:35 +0200
Message-ID: <20240724153639.803263-8-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240724153639.803263-1-olivier.moysan@foss.st.com>
References: <20240724153639.803263-1-olivier.moysan@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_15,2024-07-24_01,2024-05-17_01

Move to generic channels binding to ease new backend framework adoption
and prepare the convergence with MDF IP support on STM32MP2 SoC family.

Legacy binding:
DFSDM is an IIO channel consumer.
SD modulator is an IIO channels provider.
The channel phandles are provided in DT through io-channels property
and channel indexes through st,adc-channels property.

New binding:
DFSDM is an IIO channel provider.
The channel indexes are given by reg property in channel child node.

This new binding is intended to be used with SD modulator IIO backends.
It does not support SD modulator legacy IIO devices.
The st,adc-channels property presence is used to discriminate
between legacy and backend bindings.

The support of the DFSDM legacy channels and SD modulator IIO devices
is kept for backward compatibility.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 drivers/iio/adc/stm32-dfsdm-adc.c | 190 ++++++++++++++++++++++++------
 1 file changed, 154 insertions(+), 36 deletions(-)

diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index fabd654245f5..da7dd804c84d 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -666,6 +666,64 @@ static int stm32_dfsdm_channel_parse_of(struct stm32_dfsdm *dfsdm,
 	return 0;
 }
 
+static int stm32_dfsdm_generic_channel_parse_of(struct stm32_dfsdm *dfsdm,
+						struct iio_dev *indio_dev,
+						struct iio_chan_spec *ch,
+						struct fwnode_handle *node)
+{
+	struct stm32_dfsdm_channel *df_ch;
+	const char *of_str;
+	int ret, val;
+
+	ret = fwnode_property_read_u32(node, "reg", &ch->channel);
+	if (ret < 0) {
+		dev_err(&indio_dev->dev, "Missing channel index %d\n", ret);
+		return ret;
+	}
+
+	if (ch->channel >= dfsdm->num_chs) {
+		dev_err(&indio_dev->dev, " Error bad channel number %d (max = %d)\n",
+			ch->channel, dfsdm->num_chs);
+		return -EINVAL;
+	}
+
+	ret = fwnode_property_read_string(node, "label", &ch->datasheet_name);
+	if (ret < 0) {
+		dev_err(&indio_dev->dev,
+			" Error parsing 'label' for idx %d\n", ch->channel);
+		return ret;
+	}
+
+	df_ch =  &dfsdm->ch_list[ch->channel];
+	df_ch->id = ch->channel;
+
+	ret = fwnode_property_read_string(node, "st,adc-channel-type", &of_str);
+	if (!ret) {
+		val = stm32_dfsdm_str2val(of_str, stm32_dfsdm_chan_type);
+		if (val < 0)
+			return val;
+	} else {
+		val = 0;
+	}
+	df_ch->type = val;
+
+	ret = fwnode_property_read_string(node, "st,adc-channel-clk-src", &of_str);
+	if (!ret) {
+		val = stm32_dfsdm_str2val(of_str, stm32_dfsdm_chan_src);
+		if (val < 0)
+			return val;
+	} else {
+		val = 0;
+	}
+	df_ch->src = val;
+
+	ret = fwnode_property_read_u32(node, "st,adc-alt-channel", &df_ch->alt_si);
+	if (ret != -EINVAL)
+		df_ch->alt_si = 0;
+
+	return 0;
+}
+
 static ssize_t dfsdm_adc_audio_get_spiclk(struct iio_dev *indio_dev,
 					  uintptr_t priv,
 					  const struct iio_chan_spec *chan,
@@ -1227,7 +1285,8 @@ static int stm32_dfsdm_read_raw(struct iio_dev *indio_dev,
 		ret = iio_device_claim_direct_mode(indio_dev);
 		if (ret)
 			return ret;
-		ret = iio_hw_consumer_enable(adc->hwc);
+		if (adc->hwc)
+			ret = iio_hw_consumer_enable(adc->hwc);
 		if (ret < 0) {
 			dev_err(&indio_dev->dev,
 				"%s: IIO enable failed (channel %d)\n",
@@ -1236,7 +1295,8 @@ static int stm32_dfsdm_read_raw(struct iio_dev *indio_dev,
 			return ret;
 		}
 		ret = stm32_dfsdm_single_conv(indio_dev, chan, val);
-		iio_hw_consumer_disable(adc->hwc);
+		if (adc->hwc)
+			iio_hw_consumer_disable(adc->hwc);
 		if (ret < 0) {
 			dev_err(&indio_dev->dev,
 				"%s: Conversion failed (channel %d)\n",
@@ -1362,15 +1422,18 @@ static int stm32_dfsdm_dma_request(struct device *dev,
 	return 0;
 }
 
-static int stm32_dfsdm_adc_chan_init_one(struct iio_dev *indio_dev,
-					 struct iio_chan_spec *ch)
+static int stm32_dfsdm_adc_chan_init_one(struct iio_dev *indio_dev, struct iio_chan_spec *ch,
+					 struct fwnode_handle *child)
 {
 	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
 	int ret;
 
-	ret = stm32_dfsdm_channel_parse_of(adc->dfsdm, indio_dev, ch);
+	if (child)
+		ret = stm32_dfsdm_generic_channel_parse_of(adc->dfsdm, indio_dev, ch, child);
+	else /* Legacy binding */
+		ret = stm32_dfsdm_channel_parse_of(adc->dfsdm, indio_dev, ch);
 	if (ret < 0)
-		return ret;
+		return dev_err_probe(&indio_dev->dev, ret, "Failed to parse channel\n");
 
 	ch->type = IIO_VOLTAGE;
 	ch->indexed = 1;
@@ -1385,6 +1448,7 @@ static int stm32_dfsdm_adc_chan_init_one(struct iio_dev *indio_dev,
 
 	if (adc->dev_data->type == DFSDM_AUDIO) {
 		ch->ext_info = dfsdm_adc_audio_ext_info;
+		ch->scan_index = 0;
 	} else {
 		ch->scan_type.shift = 8;
 	}
@@ -1396,20 +1460,67 @@ static int stm32_dfsdm_adc_chan_init_one(struct iio_dev *indio_dev,
 					  &adc->dfsdm->ch_list[ch->channel]);
 }
 
+static int stm32_dfsdm_chan_init(struct iio_dev *indio_dev, struct iio_chan_spec *channels)
+{
+	int num_ch = indio_dev->num_channels;
+	int chan_idx = 0;
+	int ret;
+
+	for (chan_idx = 0; chan_idx < num_ch; chan_idx++) {
+		channels[chan_idx].scan_index = chan_idx;
+		ret = stm32_dfsdm_adc_chan_init_one(indio_dev, &channels[chan_idx], NULL);
+		if (ret < 0)
+			return dev_err_probe(&indio_dev->dev, ret, "Channels init failed\n");
+	}
+
+	return 0;
+}
+
+static int stm32_dfsdm_generic_chan_init(struct iio_dev *indio_dev, struct iio_chan_spec *channels)
+{
+	int chan_idx = 0, ret;
+
+	device_for_each_child_node_scoped(&indio_dev->dev, child) {
+		/* Skip DAI node in DFSDM audio nodes */
+		if (fwnode_property_present(child, "compatible"))
+			continue;
+
+		channels[chan_idx].scan_index = chan_idx;
+		ret = stm32_dfsdm_adc_chan_init_one(indio_dev, &channels[chan_idx], child);
+		if (ret < 0)
+			return dev_err_probe(&indio_dev->dev, ret, "Channels init failed\n");
+
+		chan_idx++;
+	}
+
+	return chan_idx;
+}
+
 static int stm32_dfsdm_audio_init(struct device *dev, struct iio_dev *indio_dev)
 {
 	struct iio_chan_spec *ch;
 	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
 	struct stm32_dfsdm_channel *d_ch;
-	int ret;
+	bool legacy = false;
+	int num_ch, ret;
+
+	/* If st,adc-channels is defined legacy binding is used. Else assume generic binding. */
+	num_ch = of_property_count_u32_elems(indio_dev->dev.of_node, "st,adc-channels");
+	if (num_ch == 1)
+		legacy = true;
 
 	ch = devm_kzalloc(&indio_dev->dev, sizeof(*ch), GFP_KERNEL);
 	if (!ch)
 		return -ENOMEM;
 
-	ch->scan_index = 0;
+	indio_dev->num_channels = 1;
+	indio_dev->channels = ch;
+
+	if (legacy)
+		ret = stm32_dfsdm_chan_init(indio_dev, ch);
+	else
+		ret = stm32_dfsdm_generic_chan_init(indio_dev, ch);
 
-	ret = stm32_dfsdm_adc_chan_init_one(indio_dev, ch);
 	if (ret < 0) {
 		dev_err(&indio_dev->dev, "Channels init failed\n");
 		return ret;
@@ -1420,9 +1531,6 @@ static int stm32_dfsdm_audio_init(struct device *dev, struct iio_dev *indio_dev)
 	if (d_ch->src != DFSDM_CHANNEL_SPI_CLOCK_EXTERNAL)
 		adc->spi_freq = adc->dfsdm->spi_master_freq;
 
-	indio_dev->num_channels = 1;
-	indio_dev->channels = ch;
-
 	return stm32_dfsdm_dma_request(dev, indio_dev);
 }
 
@@ -1430,43 +1538,53 @@ static int stm32_dfsdm_adc_init(struct device *dev, struct iio_dev *indio_dev)
 {
 	struct iio_chan_spec *ch;
 	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
-	int num_ch;
-	int ret, chan_idx;
+	int num_ch, ret;
+	bool legacy = false;
 
 	adc->oversamp = DFSDM_DEFAULT_OVERSAMPLING;
 	ret = stm32_dfsdm_compute_all_osrs(indio_dev, adc->oversamp);
 	if (ret < 0)
 		return ret;
 
-	num_ch = of_property_count_u32_elems(indio_dev->dev.of_node,
-					     "st,adc-channels");
-	if (num_ch < 0 || num_ch > adc->dfsdm->num_chs) {
-		dev_err(&indio_dev->dev, "Bad st,adc-channels\n");
-		return num_ch < 0 ? num_ch : -EINVAL;
-	}
+	num_ch = device_get_child_node_count(&indio_dev->dev);
+	if (!num_ch) {
+		/* No channels nodes found. Assume legacy binding */
+		num_ch = of_property_count_u32_elems(indio_dev->dev.of_node, "st,adc-channels");
+		if (num_ch < 0) {
+			dev_err(&indio_dev->dev, "Bad st,adc-channels\n");
+			return num_ch;
+		}
 
-	/* Bind to SD modulator IIO device */
-	adc->hwc = devm_iio_hw_consumer_alloc(&indio_dev->dev);
-	if (IS_ERR(adc->hwc))
-		return -EPROBE_DEFER;
+		legacy = true;
+	}
 
-	ch = devm_kcalloc(&indio_dev->dev, num_ch, sizeof(*ch),
-			  GFP_KERNEL);
-	if (!ch)
-		return -ENOMEM;
+	if (num_ch > adc->dfsdm->num_chs) {
+		dev_err(&indio_dev->dev, "Number of channel [%d] exceeds [%d]\n",
+			num_ch, adc->dfsdm->num_chs);
+		return -EINVAL;
+	}
+	indio_dev->num_channels = num_ch;
 
-	for (chan_idx = 0; chan_idx < num_ch; chan_idx++) {
-		ch[chan_idx].scan_index = chan_idx;
-		ret = stm32_dfsdm_adc_chan_init_one(indio_dev, &ch[chan_idx]);
-		if (ret < 0) {
-			dev_err(&indio_dev->dev, "Channels init failed\n");
-			return ret;
-		}
+	if (legacy) {
+		/* Bind to SD modulator IIO device. */
+		adc->hwc = devm_iio_hw_consumer_alloc(&indio_dev->dev);
+		if (IS_ERR(adc->hwc))
+			return dev_err_probe(&indio_dev->dev, -EPROBE_DEFER,
+					     "waiting for SD modulator\n");
 	}
 
-	indio_dev->num_channels = num_ch;
+	ch = devm_kcalloc(&indio_dev->dev, num_ch, sizeof(*ch), GFP_KERNEL);
+	if (!ch)
+		return -ENOMEM;
 	indio_dev->channels = ch;
 
+	if (legacy)
+		ret = stm32_dfsdm_chan_init(indio_dev, ch);
+	else
+		ret = stm32_dfsdm_generic_chan_init(indio_dev, ch);
+	if (ret < 0)
+		return ret;
+
 	init_completion(&adc->completion);
 
 	/* Optionally request DMA */
-- 
2.25.1


