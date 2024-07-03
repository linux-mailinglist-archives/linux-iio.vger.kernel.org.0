Return-Path: <linux-iio+bounces-7267-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 738409265B4
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 18:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3F921F22D83
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 16:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403181849D2;
	Wed,  3 Jul 2024 16:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="OR2DpzSc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2977B181BB2;
	Wed,  3 Jul 2024 16:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720022982; cv=none; b=SAemTcGsuW6lO5+ADJefJ6UAMGjUpr5U1lzIVDGRH6vHydcdaFUXPvjrgfaSUKKMpHQzfnVJS4W5S0XFo3QHf6h5vPhbT9qSpZg20xefA/5RHI2qA6S5YpFAjhPU6MNljgEQM/XeeM9MLwiUpLxd9h/uKIEqW8Pn0h2d/jo3zV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720022982; c=relaxed/simple;
	bh=YC9J80tdn+Oh5xJApI1mLPZR8CEykn4BVCHYvHEQhNc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HZ/jNCF5KQHOwIw+J4/MJse1ZuGfDyOWp2HYwzwX9um1sbzCSp58qdEFEyu7ndDMJWdLEptkpDdksLhPHvK7IBesuUFqmqpHD2P8a6YVpxAiO7QSP83L9oC5VDRZ5vs+wjD5GKvvTD3fiKNPkwpJsXgY9S5kdAhu4ZGQ1hudE7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=OR2DpzSc; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 463EYwVC010013;
	Wed, 3 Jul 2024 18:09:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	5+DgVyRcKG3lK13V7LR7tKkeRWS1ulizVadzVOae5rY=; b=OR2DpzScShH27Zbx
	9JE59UGCAaAR0i/w+shAc4AxTOh06cghrfSJ/zbj7W02mlndVoFBXI4qagHdK/BJ
	pOy8aOnN3xbvAZjvWE/2BjGRs3I9uJZdic9s6FRdD6LRMvODuejVokhi7Cx+0H89
	GhCXHvcf062C5ELwYE3EIFXErtPprH3xLkx8YdPRMgl+YdAKvSNU8EMQGnsNWxpx
	BbiTM+biVUN5GoyxAt+aEWdncqm1aUTw+qd2JolAydp4EZWyd2M1rGiFUyDrYrO3
	xDmC7HJ5g9VbCPxsUronlfv1DHvsH/IZPyvE1Grdwh2PlU3bWtft0DMHn4w3vfYN
	DC+Zdg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4027pgstm5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jul 2024 18:09:18 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id A6D2840046;
	Wed,  3 Jul 2024 18:09:08 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 430BD2291B2;
	Wed,  3 Jul 2024 18:08:35 +0200 (CEST)
Received: from localhost (10.252.27.110) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 3 Jul
 2024 18:08:34 +0200
From: Olivier Moysan <olivier.moysan@foss.st.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>
CC: Olivier Moysan <olivier.moysan@foss.st.com>, Nuno Sa <nuno.sa@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 8/8] iio: adc: stm32-dfsdm: add scaling support to dfsdm
Date: Wed, 3 Jul 2024 18:05:33 +0200
Message-ID: <20240703160535.2277871-9-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240703160535.2277871-1-olivier.moysan@foss.st.com>
References: <20240703160535.2277871-1-olivier.moysan@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_11,2024-07-03_01,2024-05-17_01

Add scaling support to STM32 DFSDM.

When used in an analog context, a DFSDM filter typically converts the data
from a sigma delta modulator. The IIO device associated to the DFSDM
filter provides these data as raw data.
The IIO device can provide scaling information (voltage and offset) to
allow conversion of raw data into physical values.

With the new binding based on IIO backend framework, the sigma delta
modulators are defined as backends providing scaling information.

The scaling is not supported with legacy binding.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
Acked-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/adc/Kconfig           |  1 +
 drivers/iio/adc/stm32-dfsdm-adc.c | 98 ++++++++++++++++++++++++++++++-
 2 files changed, 97 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 14b1773f02d9..36ef0de9140f 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1226,6 +1226,7 @@ config STM32_DFSDM_ADC
 	select IIO_BUFFER
 	select IIO_BUFFER_HW_CONSUMER
 	select IIO_TRIGGERED_BUFFER
+	select IIO_BACKEND
 	help
 	  Select this option to support ADCSigma delta modulator for
 	  STMicroelectronics STM32 digital filter for sigma delta converter.
diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index ae5d95e38cd7..7e91e3df5592 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -9,6 +9,7 @@
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
 #include <linux/iio/adc/stm32-dfsdm-adc.h>
+#include <linux/iio/backend.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/hw-consumer.h>
 #include <linux/iio/sysfs.h>
@@ -78,6 +79,7 @@ struct stm32_dfsdm_adc {
 	/* ADC specific */
 	unsigned int oversamp;
 	struct iio_hw_consumer *hwc;
+	struct iio_backend **backend;
 	struct completion completion;
 	u32 *buffer;
 
@@ -672,6 +674,8 @@ static int stm32_dfsdm_generic_channel_parse_of(struct stm32_dfsdm *dfsdm,
 						struct fwnode_handle *node)
 {
 	struct stm32_dfsdm_channel *df_ch;
+	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
+	struct iio_backend *backend;
 	const char *of_str;
 	int ret, val;
 
@@ -721,6 +725,14 @@ static int stm32_dfsdm_generic_channel_parse_of(struct stm32_dfsdm *dfsdm,
 	if (ret != -EINVAL)
 		df_ch->alt_si = 0;
 
+	if (adc->dev_data->type == DFSDM_IIO) {
+		backend = devm_iio_backend_fwnode_get(&indio_dev->dev, NULL, node);
+		if (IS_ERR(backend))
+			return dev_err_probe(&indio_dev->dev, PTR_ERR(backend),
+					     "Failed to get backend\n");
+		adc->backend[ch->scan_index] = backend;
+	}
+
 	return 0;
 }
 
@@ -1056,6 +1068,7 @@ static int stm32_dfsdm_update_scan_mode(struct iio_dev *indio_dev,
 static int stm32_dfsdm_postenable(struct iio_dev *indio_dev)
 {
 	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
+	int i = 0;
 	int ret;
 
 	/* Reset adc buffer index */
@@ -1067,6 +1080,15 @@ static int stm32_dfsdm_postenable(struct iio_dev *indio_dev)
 			return ret;
 	}
 
+	if (adc->backend) {
+		while (adc->backend[i]) {
+			ret = iio_backend_enable(adc->backend[i]);
+			if (ret < 0)
+				return ret;
+			i++;
+		}
+	}
+
 	ret = stm32_dfsdm_start_dfsdm(adc->dfsdm);
 	if (ret < 0)
 		goto err_stop_hwc;
@@ -1099,6 +1121,7 @@ static int stm32_dfsdm_postenable(struct iio_dev *indio_dev)
 static int stm32_dfsdm_predisable(struct iio_dev *indio_dev)
 {
 	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
+	int i = 0;
 
 	stm32_dfsdm_stop_conv(indio_dev);
 
@@ -1106,6 +1129,13 @@ static int stm32_dfsdm_predisable(struct iio_dev *indio_dev)
 
 	stm32_dfsdm_stop_dfsdm(adc->dfsdm);
 
+	if (adc->backend) {
+		while (adc->backend[i]) {
+			iio_backend_disable(adc->backend[i]);
+			i++;
+		}
+	}
+
 	if (adc->hwc)
 		iio_hw_consumer_disable(adc->hwc);
 
@@ -1278,7 +1308,14 @@ static int stm32_dfsdm_read_raw(struct iio_dev *indio_dev,
 				int *val2, long mask)
 {
 	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
-	int ret;
+
+	struct stm32_dfsdm_filter *fl = &adc->dfsdm->fl_list[adc->fl_id];
+	struct stm32_dfsdm_filter_osr *flo = &fl->flo[fl->fast];
+	u32 max = flo->max << (flo->lshift - chan->scan_type.shift);
+	int ret, idx = chan->scan_index;
+
+	if (flo->lshift < chan->scan_type.shift)
+		max = flo->max >> (chan->scan_type.shift - flo->lshift);
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
@@ -1287,6 +1324,8 @@ static int stm32_dfsdm_read_raw(struct iio_dev *indio_dev,
 			return ret;
 		if (adc->hwc)
 			ret = iio_hw_consumer_enable(adc->hwc);
+		if (adc->backend)
+			ret = iio_backend_enable(adc->backend[idx]);
 		if (ret < 0) {
 			dev_err(&indio_dev->dev,
 				"%s: IIO enable failed (channel %d)\n",
@@ -1297,6 +1336,8 @@ static int stm32_dfsdm_read_raw(struct iio_dev *indio_dev,
 		ret = stm32_dfsdm_single_conv(indio_dev, chan, val);
 		if (adc->hwc)
 			iio_hw_consumer_disable(adc->hwc);
+		if (adc->backend)
+			iio_backend_disable(adc->backend[idx]);
 		if (ret < 0) {
 			dev_err(&indio_dev->dev,
 				"%s: Conversion failed (channel %d)\n",
@@ -1316,6 +1357,50 @@ static int stm32_dfsdm_read_raw(struct iio_dev *indio_dev,
 		*val = adc->sample_freq;
 
 		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		/*
+		 * Scale is expressed in mV.
+		 * When fast mode is disabled, actual resolution may be lower
+		 * than 2^n, where n = realbits - 1.
+		 * This leads to underestimating the input voltage.
+		 * To compensate this deviation, the voltage reference can be
+		 * corrected with a factor = realbits resolution / actual max
+		 */
+		if (adc->backend) {
+			ret = iio_backend_read_scale(adc->backend[idx], chan, val);
+			if (ret < 0)
+				return ret;
+
+			*val = div_u64((u64)*val * (u64)BIT(DFSDM_DATA_RES - 1), max);
+			*val2 = chan->scan_type.realbits;
+			if (chan->differential)
+				*val *= 2;
+		}
+		return IIO_VAL_FRACTIONAL_LOG2;
+
+	case IIO_CHAN_INFO_OFFSET:
+		/*
+		 * DFSDM output data are in the range [-2^n, 2^n],
+		 * with n = realbits - 1.
+		 * - Differential modulator:
+		 * Offset correspond to SD modulator offset.
+		 * - Single ended modulator:
+		 * Input is in [0V, Vref] range,
+		 * where 0V corresponds to -2^n, and Vref to 2^n.
+		 * Add 2^n to offset. (i.e. middle of input range)
+		 * offset = offset(sd) * vref / res(sd) * max / vref.
+		 */
+		if (adc->backend) {
+			ret = iio_backend_read_offset(adc->backend[idx], chan, val);
+			if (ret < 0)
+				return ret;
+
+			*val = div_u64((u64)max * *val, BIT(*val2 - 1));
+			if (!chan->differential)
+				*val += max;
+		}
+		return IIO_VAL_INT;
 	}
 
 	return -EINVAL;
@@ -1444,7 +1529,15 @@ static int stm32_dfsdm_adc_chan_init_one(struct iio_dev *indio_dev, struct iio_c
 	 * IIO_CHAN_INFO_RAW: used to compute regular conversion
 	 * IIO_CHAN_INFO_OVERSAMPLING_RATIO: used to set oversampling
 	 */
-	ch->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
+	if (child) {
+		ch->info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+					 BIT(IIO_CHAN_INFO_SCALE) |
+					 BIT(IIO_CHAN_INFO_OFFSET);
+	} else {
+		/* Legacy. Scaling not supported */
+		ch->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
+	}
+
 	ch->info_mask_shared_by_all = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |
 					BIT(IIO_CHAN_INFO_SAMP_FREQ);
 
@@ -1805,3 +1898,4 @@ module_platform_driver(stm32_dfsdm_adc_driver);
 MODULE_DESCRIPTION("STM32 sigma delta ADC");
 MODULE_AUTHOR("Arnaud Pouliquen <arnaud.pouliquen@st.com>");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_BACKEND);
-- 
2.25.1


