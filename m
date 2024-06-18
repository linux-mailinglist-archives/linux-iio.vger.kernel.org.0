Return-Path: <linux-iio+bounces-6524-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA8190D927
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 18:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BFCCB27316
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 16:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B7114F13E;
	Tue, 18 Jun 2024 16:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="EfjyD904"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6145A14EC79;
	Tue, 18 Jun 2024 16:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718727153; cv=none; b=QUYdCfOJic327qKQccNqHpCYBpyIpF60UgQBcFX6NUueu/henjGWfJfqCwh/dvzwh6H0N619rkBBvRaA1OH7rYNbPfkyUQthHSFVBuiDfP8uEXalGJV/1IlNcXUuYz9lZjrUOPOc6LmZhewMWbTKrhlKlPiu6DF0ybVlFn6UPfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718727153; c=relaxed/simple;
	bh=1F52Yx/ZQ4nCWj8eVMsenNJs/hsF0vmXXhuKUIvd89w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kaFuRXN0/B3e0mZGIJu0ygoEMcfiB8lejuOVq/8OCntwK9TIlbXovixNEkW2s/dpgiltNrAuD4cHRfGkiKCAVr3HPPJvwBz/3XU/XOWityDWfMbB85+o1JyoI7gv+wKhvyNU8kynykjHweNtH6PJHFCAE4QOQ8hFi9S3UqCbxyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=EfjyD904; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45IFAEX5008943;
	Tue, 18 Jun 2024 18:12:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	S+H8H+djGQYAAsQ0PjdqLYQJy1Hwlzih8CMqVRnehcE=; b=EfjyD9044mkD/CzS
	aQyX5J8AxI0RFm2bxYDYHjqPGsFy2FDAWVMdZSPWydiRib+V8AD7Mc1Xz/U7JNb9
	YXFnpOVTtVFmO6AjzVp00NrhL3eLEuzaTUUHpOGBwFwTdraaypUa8TrBr6ZDUr4F
	oLfvYsCLArgGoVNCuBFfDTv95Px8TqiGcabS1cZ1r03cQIHsn/h30FADp/1EUteL
	LhVNEv4D60hvmibrVSnKhEgcuO6Azjvkrwfh7C45iX645UU0/xZsDdN5jL63DK4J
	JAH6z/cktZQsudySTjs/O/w0Aa/q7wndNg+doXN5hiMLgVlzPR7c59bvjbKlt9pj
	HT+mFQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ysnwja5h9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 18:12:04 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 41F5F40045;
	Tue, 18 Jun 2024 18:12:00 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 13D6721197B;
	Tue, 18 Jun 2024 18:11:32 +0200 (CEST)
Received: from localhost (10.252.27.64) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 18 Jun
 2024 18:11:31 +0200
From: Olivier Moysan <olivier.moysan@foss.st.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>
CC: Olivier Moysan <olivier.moysan@foss.st.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 8/8] iio: adc: stm32-dfsdm: add scaling support to dfsdm
Date: Tue, 18 Jun 2024 18:08:34 +0200
Message-ID: <20240618160836.945242-9-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240618160836.945242-1-olivier.moysan@foss.st.com>
References: <20240618160836.945242-1-olivier.moysan@foss.st.com>
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
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01

Add scaling support to STM32 DFSDM.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 drivers/iio/adc/Kconfig           |  1 +
 drivers/iio/adc/stm32-dfsdm-adc.c | 94 ++++++++++++++++++++++++++++++-
 2 files changed, 92 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index f3dfdaa80678..858ae8161fa4 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1223,6 +1223,7 @@ config STM32_DFSDM_ADC
 	select IIO_BUFFER
 	select IIO_BUFFER_HW_CONSUMER
 	select IIO_TRIGGERED_BUFFER
+	select IIO_BACKEND
 	help
 	  Select this option to support ADCSigma delta modulator for
 	  STMicroelectronics STM32 digital filter for sigma delta converter.
diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index 69b4764d7cba..93bf6035bd6d 100644
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
+		backend = devm_iio_backend_subnode_get(&indio_dev->dev, NULL, node);
+		if (IS_ERR(backend))
+			return dev_err_probe(&indio_dev->dev, PTR_ERR(backend),
+					     "Failed to get backend\n");
+		adc->backend[ch->scan_index] = backend;
+	}
+
 	return 0;
 }
 
@@ -1060,7 +1072,7 @@ static int stm32_dfsdm_update_scan_mode(struct iio_dev *indio_dev,
 static int stm32_dfsdm_postenable(struct iio_dev *indio_dev)
 {
 	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
-	int ret;
+	int i = 0, ret;
 
 	/* Reset adc buffer index */
 	adc->bufi = 0;
@@ -1071,6 +1083,15 @@ static int stm32_dfsdm_postenable(struct iio_dev *indio_dev)
 			return ret;
 	}
 
+	if (adc->backend) {
+		while (adc->backend[i]) {
+			ret = iio_backend_enable(&indio_dev->dev, adc->backend[i]);
+			if (ret < 0)
+				return ret;
+			i++;
+		}
+	}
+
 	ret = stm32_dfsdm_start_dfsdm(adc->dfsdm);
 	if (ret < 0)
 		goto err_stop_hwc;
@@ -1103,6 +1124,7 @@ static int stm32_dfsdm_postenable(struct iio_dev *indio_dev)
 static int stm32_dfsdm_predisable(struct iio_dev *indio_dev)
 {
 	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
+	int i = 0;
 
 	stm32_dfsdm_stop_conv(indio_dev);
 
@@ -1110,6 +1132,13 @@ static int stm32_dfsdm_predisable(struct iio_dev *indio_dev)
 
 	stm32_dfsdm_stop_dfsdm(adc->dfsdm);
 
+	if (adc->backend) {
+		while (adc->backend[i]) {
+			iio_backend_disable(&indio_dev->dev, adc->backend[i]);
+			i++;
+		}
+	}
+
 	if (adc->hwc)
 		iio_hw_consumer_disable(adc->hwc);
 
@@ -1282,7 +1311,14 @@ static int stm32_dfsdm_read_raw(struct iio_dev *indio_dev,
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
@@ -1291,6 +1327,8 @@ static int stm32_dfsdm_read_raw(struct iio_dev *indio_dev,
 			return ret;
 		if (adc->hwc)
 			ret = iio_hw_consumer_enable(adc->hwc);
+		if (adc->backend[idx])
+			ret = iio_backend_enable(&indio_dev->dev, adc->backend[idx]);
 		if (ret < 0) {
 			dev_err(&indio_dev->dev,
 				"%s: IIO enable failed (channel %d)\n",
@@ -1301,6 +1339,8 @@ static int stm32_dfsdm_read_raw(struct iio_dev *indio_dev,
 		ret = stm32_dfsdm_single_conv(indio_dev, chan, val);
 		if (adc->hwc)
 			iio_hw_consumer_disable(adc->hwc);
+		if (adc->backend[idx])
+			iio_backend_disable(&indio_dev->dev, adc->backend[idx]);
 		if (ret < 0) {
 			dev_err(&indio_dev->dev,
 				"%s: Conversion failed (channel %d)\n",
@@ -1320,6 +1360,45 @@ static int stm32_dfsdm_read_raw(struct iio_dev *indio_dev,
 		*val = adc->sample_freq;
 
 		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		/*
+		 * Scale is expressed in mV.
+		 * When fast mode is disabled, actual resolution may be lower
+		 * than 2^n, where n=realbits-1.
+		 * This leads to underestimating input voltage. To
+		 * compensate this deviation, the voltage reference can be
+		 * corrected with a factor = realbits resolution / actual max
+		 */
+		if (adc->backend[idx]) {
+			iio_backend_read_raw(adc->backend[idx], val, val2, mask);
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
+		 * DFSDM output data are in the range [-2^n,2^n],
+		 * with n=realbits-1.
+		 * - Differential modulator:
+		 * Offset correspond to SD modulator offset.
+		 * - Single ended modulator:
+		 * Input is in [0V,Vref] range, where 0V corresponds to -2^n, and Vref to 2^n.
+		 * Add 2^n to offset. (i.e. middle of input range)
+		 * offset = offset(sd) * vref / res(sd) * max / vref.
+		 */
+		if (adc->backend[idx]) {
+			iio_backend_read_raw(adc->backend[idx], val, val2, mask);
+
+			*val = div_u64((u64)max * *val, BIT(*val2 - 1));
+			if (!chan->differential)
+				*val += max;
+		}
+		return IIO_VAL_INT;
 	}
 
 	return -EINVAL;
@@ -1449,7 +1528,15 @@ static int stm32_dfsdm_adc_chan_init_one(struct iio_dev *indio_dev, struct iio_c
 	 * IIO_CHAN_INFO_RAW: used to compute regular conversion
 	 * IIO_CHAN_INFO_OVERSAMPLING_RATIO: used to set oversampling
 	 */
-	ch->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
+	if (child) {
+		ch->info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+					BIT(IIO_CHAN_INFO_SCALE) |
+					BIT(IIO_CHAN_INFO_OFFSET);
+	} else {
+		/* Legacy. Scaling not supported */
+		ch->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
+	}
+
 	ch->info_mask_shared_by_all = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |
 					BIT(IIO_CHAN_INFO_SAMP_FREQ);
 
@@ -1816,3 +1903,4 @@ module_platform_driver(stm32_dfsdm_adc_driver);
 MODULE_DESCRIPTION("STM32 sigma delta ADC");
 MODULE_AUTHOR("Arnaud Pouliquen <arnaud.pouliquen@st.com>");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_BACKEND);
-- 
2.25.1


