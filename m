Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 868911BF429
	for <lists+linux-iio@lfdr.de>; Thu, 30 Apr 2020 11:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgD3J3M (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Apr 2020 05:29:12 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:19722 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726404AbgD3J3J (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Apr 2020 05:29:09 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03U9SODP004608;
        Thu, 30 Apr 2020 11:28:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=tPSl8U7fRW8ZKuW1r9MplGDa5LvBZylklxKzBDbnnZI=;
 b=PBGPAlJta4nLIzyCT6BSNzBErO+ArOOi+wPL3Ei1rlsPclCHqYG180cka8x6p7QiYh8c
 iHFcvpFK1Ev+IVC81sayWNFYFFGFyNv9onXYEdTPOWcvTpkxZ7qF86tK3BVB0Mrim1MR
 Ih0MVTpUQs7AwGf+Sma4VqpDYHztD+9fP8Zg96t47VB3skHJkszfh5yzw2yfyhr5/s0z
 zmcnHCfmMcO6f1tbR8Bw24Pz3xXekdG1Ebz35LO76fOQYQSP/HNShAw14ZyE3Nc31bm5
 pAPuIrZ4DV6GcKiA+T5GjxQlLAuZ6JQhQPPpPo9SzHx1PZlBNpinSyfbPvsu6/W2XZJ1 Zw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30n4j67guw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Apr 2020 11:28:58 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 56F9D10002A;
        Thu, 30 Apr 2020 11:28:58 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 45E0D2ABF9D;
        Thu, 30 Apr 2020 11:28:58 +0200 (CEST)
Received: from localhost (10.75.127.45) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 30 Apr 2020 11:28:57
 +0200
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <jic23@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <fabrice.gasnier@st.com>,
        <olivier.moysan@st.com>, <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH] iio: adc: stm32-dfsdm: fix device used to request dma
Date:   Thu, 30 Apr 2020 11:28:46 +0200
Message-ID: <1588238926-23964-2-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588238926-23964-1-git-send-email-fabrice.gasnier@st.com>
References: <1588238926-23964-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG7NODE1.st.com (10.75.127.19) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-30_05:2020-04-30,2020-04-30 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

DMA channel request should use device struct from platform device struct.
Currently it's using iio device struct. But at this stage when probing,
device struct isn't yet registered (e.g. device_register is done in
iio_device_register). Since commit 71723a96b8b1 ("dmaengine: Create
symlinks between DMA channels and slaves"), a warning message is printed
as the links in sysfs can't be created, due to device isn't yet registered:
- Cannot create DMA slave symlink
- Cannot create DMA dma:rx symlink

Fix this by using device struct from platform device to request dma chan.

Fixes: eca949800d2d ("IIO: ADC: add stm32 DFSDM support for PDM microphone")

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/iio/adc/stm32-dfsdm-adc.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index 76a60d9..506bf51 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -62,7 +62,7 @@ enum sd_converter_type {
 
 struct stm32_dfsdm_dev_data {
 	int type;
-	int (*init)(struct iio_dev *indio_dev);
+	int (*init)(struct device *dev, struct iio_dev *indio_dev);
 	unsigned int num_channels;
 	const struct regmap_config *regmap_cfg;
 };
@@ -1365,11 +1365,12 @@ static void stm32_dfsdm_dma_release(struct iio_dev *indio_dev)
 	}
 }
 
-static int stm32_dfsdm_dma_request(struct iio_dev *indio_dev)
+static int stm32_dfsdm_dma_request(struct device *dev,
+				   struct iio_dev *indio_dev)
 {
 	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
 
-	adc->dma_chan = dma_request_chan(&indio_dev->dev, "rx");
+	adc->dma_chan = dma_request_chan(dev, "rx");
 	if (IS_ERR(adc->dma_chan)) {
 		int ret = PTR_ERR(adc->dma_chan);
 
@@ -1425,7 +1426,7 @@ static int stm32_dfsdm_adc_chan_init_one(struct iio_dev *indio_dev,
 					  &adc->dfsdm->ch_list[ch->channel]);
 }
 
-static int stm32_dfsdm_audio_init(struct iio_dev *indio_dev)
+static int stm32_dfsdm_audio_init(struct device *dev, struct iio_dev *indio_dev)
 {
 	struct iio_chan_spec *ch;
 	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
@@ -1452,10 +1453,10 @@ static int stm32_dfsdm_audio_init(struct iio_dev *indio_dev)
 	indio_dev->num_channels = 1;
 	indio_dev->channels = ch;
 
-	return stm32_dfsdm_dma_request(indio_dev);
+	return stm32_dfsdm_dma_request(dev, indio_dev);
 }
 
-static int stm32_dfsdm_adc_init(struct iio_dev *indio_dev)
+static int stm32_dfsdm_adc_init(struct device *dev, struct iio_dev *indio_dev)
 {
 	struct iio_chan_spec *ch;
 	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
@@ -1499,17 +1500,17 @@ static int stm32_dfsdm_adc_init(struct iio_dev *indio_dev)
 	init_completion(&adc->completion);
 
 	/* Optionally request DMA */
-	ret = stm32_dfsdm_dma_request(indio_dev);
+	ret = stm32_dfsdm_dma_request(dev, indio_dev);
 	if (ret) {
 		if (ret != -ENODEV) {
 			if (ret != -EPROBE_DEFER)
-				dev_err(&indio_dev->dev,
+				dev_err(dev,
 					"DMA channel request failed with %d\n",
 					ret);
 			return ret;
 		}
 
-		dev_dbg(&indio_dev->dev, "No DMA support\n");
+		dev_dbg(dev, "No DMA support\n");
 		return 0;
 	}
 
@@ -1622,7 +1623,7 @@ static int stm32_dfsdm_adc_probe(struct platform_device *pdev)
 		adc->dfsdm->fl_list[adc->fl_id].sync_mode = val;
 
 	adc->dev_data = dev_data;
-	ret = dev_data->init(iio);
+	ret = dev_data->init(dev, iio);
 	if (ret < 0)
 		return ret;
 
-- 
2.7.4

