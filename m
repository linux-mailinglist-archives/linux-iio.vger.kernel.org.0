Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C85131E08C6
	for <lists+linux-iio@lfdr.de>; Mon, 25 May 2020 10:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgEYI06 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 May 2020 04:26:58 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:63042 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726222AbgEYI06 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 May 2020 04:26:58 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04P8PFpa020002;
        Mon, 25 May 2020 04:26:48 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 316wp7x507-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 May 2020 04:26:48 -0400
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 04P8QlC5047948
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 25 May 2020 04:26:47 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 25 May 2020 04:26:46 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 25 May 2020 04:26:45 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 25 May 2020 04:26:45 -0400
Received: from saturn.ad.analog.com ([10.48.65.112])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 04P8QhCH008659;
        Mon, 25 May 2020 04:26:44 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2] iio: stm32-dfsdm-adc: remove usage of iio_priv_to_dev() helper
Date:   Mon, 25 May 2020 11:26:48 +0300
Message-ID: <20200525082648.39656-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200522130804.631508-1-alexandru.ardelean@analog.com>
References: <20200522130804.631508-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-25_03:2020-05-22,2020-05-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 impostorscore=0 clxscore=1015
 malwarescore=0 mlxscore=0 lowpriorityscore=0 cotscore=-2147483648
 spamscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005250066
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

We may want to get rid of the iio_priv_to_dev() helper. The reason is that
we will hide some of the members of the iio_dev structure (to prevent
drivers from accessing them directly), and that will also mean hiding the
implementation of the iio_priv_to_dev() helper inside the IIO core.

Hiding the implementation of iio_priv_to_dev() implies that some fast-paths
may not be fast anymore, so a general idea is to try to get rid of the
iio_priv_to_dev() altogether.
The iio_priv() helper won't be affected by the rework, as the iio_dev
struct will keep a reference to the private information.

For this driver, not using iio_priv_to_dev(), means reworking some paths to
pass the iio device and using iio_priv() to access the private information.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---

Changelog v1 -> v2:
* changed some paths to pass a reference to ref to iio device and access
  private state-struct via iio_priv()

 drivers/iio/adc/stm32-dfsdm-adc.c | 65 ++++++++++++++++---------------
 1 file changed, 33 insertions(+), 32 deletions(-)

diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index 76a60d93fe23..03dfc0b6ba98 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -330,9 +330,9 @@ static int stm32_dfsdm_compute_all_osrs(struct iio_dev *indio_dev,
 	return 0;
 }
 
-static int stm32_dfsdm_start_channel(struct stm32_dfsdm_adc *adc)
+static int stm32_dfsdm_start_channel(struct iio_dev *indio_dev)
 {
-	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
+	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
 	struct regmap *regmap = adc->dfsdm->regmap;
 	const struct iio_chan_spec *chan;
 	unsigned int bit;
@@ -350,9 +350,9 @@ static int stm32_dfsdm_start_channel(struct stm32_dfsdm_adc *adc)
 	return 0;
 }
 
-static void stm32_dfsdm_stop_channel(struct stm32_dfsdm_adc *adc)
+static void stm32_dfsdm_stop_channel(struct iio_dev *indio_dev)
 {
-	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
+	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
 	struct regmap *regmap = adc->dfsdm->regmap;
 	const struct iio_chan_spec *chan;
 	unsigned int bit;
@@ -418,11 +418,11 @@ static void stm32_dfsdm_stop_filter(struct stm32_dfsdm *dfsdm,
 			   DFSDM_CR1_DFEN_MASK, DFSDM_CR1_DFEN(0));
 }
 
-static int stm32_dfsdm_filter_set_trig(struct stm32_dfsdm_adc *adc,
+static int stm32_dfsdm_filter_set_trig(struct iio_dev *indio_dev,
 				       unsigned int fl_id,
 				       struct iio_trigger *trig)
 {
-	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
+	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
 	struct regmap *regmap = adc->dfsdm->regmap;
 	u32 jextsel = 0, jexten = STM32_DFSDM_JEXTEN_DISABLED;
 	int ret;
@@ -447,11 +447,11 @@ static int stm32_dfsdm_filter_set_trig(struct stm32_dfsdm_adc *adc,
 	return 0;
 }
 
-static int stm32_dfsdm_channels_configure(struct stm32_dfsdm_adc *adc,
+static int stm32_dfsdm_channels_configure(struct iio_dev *indio_dev,
 					  unsigned int fl_id,
 					  struct iio_trigger *trig)
 {
-	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
+	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
 	struct regmap *regmap = adc->dfsdm->regmap;
 	struct stm32_dfsdm_filter *fl = &adc->dfsdm->fl_list[fl_id];
 	struct stm32_dfsdm_filter_osr *flo = &fl->flo[0];
@@ -491,11 +491,11 @@ static int stm32_dfsdm_channels_configure(struct stm32_dfsdm_adc *adc,
 	return 0;
 }
 
-static int stm32_dfsdm_filter_configure(struct stm32_dfsdm_adc *adc,
+static int stm32_dfsdm_filter_configure(struct iio_dev *indio_dev,
 					unsigned int fl_id,
 					struct iio_trigger *trig)
 {
-	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
+	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
 	struct regmap *regmap = adc->dfsdm->regmap;
 	struct stm32_dfsdm_filter *fl = &adc->dfsdm->fl_list[fl_id];
 	struct stm32_dfsdm_filter_osr *flo = &fl->flo[fl->fast];
@@ -521,7 +521,7 @@ static int stm32_dfsdm_filter_configure(struct stm32_dfsdm_adc *adc,
 	if (ret)
 		return ret;
 
-	ret = stm32_dfsdm_filter_set_trig(adc, fl_id, trig);
+	ret = stm32_dfsdm_filter_set_trig(indio_dev, fl_id, trig);
 	if (ret)
 		return ret;
 
@@ -729,21 +729,22 @@ static ssize_t dfsdm_adc_audio_set_spiclk(struct iio_dev *indio_dev,
 	return len;
 }
 
-static int stm32_dfsdm_start_conv(struct stm32_dfsdm_adc *adc,
+static int stm32_dfsdm_start_conv(struct iio_dev *indio_dev,
 				  struct iio_trigger *trig)
 {
+	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
 	struct regmap *regmap = adc->dfsdm->regmap;
 	int ret;
 
-	ret = stm32_dfsdm_channels_configure(adc, adc->fl_id, trig);
+	ret = stm32_dfsdm_channels_configure(indio_dev, adc->fl_id, trig);
 	if (ret < 0)
 		return ret;
 
-	ret = stm32_dfsdm_start_channel(adc);
+	ret = stm32_dfsdm_start_channel(indio_dev);
 	if (ret < 0)
 		return ret;
 
-	ret = stm32_dfsdm_filter_configure(adc, adc->fl_id, trig);
+	ret = stm32_dfsdm_filter_configure(indio_dev, adc->fl_id, trig);
 	if (ret < 0)
 		goto stop_channels;
 
@@ -757,13 +758,14 @@ static int stm32_dfsdm_start_conv(struct stm32_dfsdm_adc *adc,
 	regmap_update_bits(regmap, DFSDM_CR1(adc->fl_id),
 			   DFSDM_CR1_CFG_MASK, 0);
 stop_channels:
-	stm32_dfsdm_stop_channel(adc);
+	stm32_dfsdm_stop_channel(indio_dev);
 
 	return ret;
 }
 
-static void stm32_dfsdm_stop_conv(struct stm32_dfsdm_adc *adc)
+static void stm32_dfsdm_stop_conv(struct iio_dev *indio_dev)
 {
+	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
 	struct regmap *regmap = adc->dfsdm->regmap;
 
 	stm32_dfsdm_stop_filter(adc->dfsdm, adc->fl_id);
@@ -771,7 +773,7 @@ static void stm32_dfsdm_stop_conv(struct stm32_dfsdm_adc *adc)
 	regmap_update_bits(regmap, DFSDM_CR1(adc->fl_id),
 			   DFSDM_CR1_CFG_MASK, 0);
 
-	stm32_dfsdm_stop_channel(adc);
+	stm32_dfsdm_stop_channel(indio_dev);
 }
 
 static int stm32_dfsdm_set_watermark(struct iio_dev *indio_dev,
@@ -1017,7 +1019,7 @@ static int __stm32_dfsdm_postenable(struct iio_dev *indio_dev)
 		goto stop_dfsdm;
 	}
 
-	ret = stm32_dfsdm_start_conv(adc, indio_dev->trig);
+	ret = stm32_dfsdm_start_conv(indio_dev, indio_dev->trig);
 	if (ret) {
 		dev_err(&indio_dev->dev, "Can't start conversion\n");
 		goto err_stop_dma;
@@ -1063,7 +1065,7 @@ static void __stm32_dfsdm_predisable(struct iio_dev *indio_dev)
 {
 	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
 
-	stm32_dfsdm_stop_conv(adc);
+	stm32_dfsdm_stop_conv(indio_dev);
 
 	stm32_dfsdm_adc_dma_stop(indio_dev);
 
@@ -1159,7 +1161,7 @@ static int stm32_dfsdm_single_conv(struct iio_dev *indio_dev,
 
 	adc->nconv = 1;
 	adc->smask = BIT(chan->scan_index);
-	ret = stm32_dfsdm_start_conv(adc, NULL);
+	ret = stm32_dfsdm_start_conv(indio_dev, NULL);
 	if (ret < 0) {
 		regmap_update_bits(adc->dfsdm->regmap, DFSDM_CR2(adc->fl_id),
 				   DFSDM_CR2_REOCIE_MASK, DFSDM_CR2_REOCIE(0));
@@ -1180,7 +1182,7 @@ static int stm32_dfsdm_single_conv(struct iio_dev *indio_dev,
 	else
 		ret = IIO_VAL_INT;
 
-	stm32_dfsdm_stop_conv(adc);
+	stm32_dfsdm_stop_conv(indio_dev);
 
 	stm32_dfsdm_process_data(adc, res);
 
@@ -1313,8 +1315,8 @@ static const struct iio_info stm32_dfsdm_info_adc = {
 
 static irqreturn_t stm32_dfsdm_irq(int irq, void *arg)
 {
-	struct stm32_dfsdm_adc *adc = arg;
-	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
+	struct iio_dev *indio_dev = arg;
+	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
 	struct regmap *regmap = adc->dfsdm->regmap;
 	unsigned int status, int_en;
 
@@ -1574,7 +1576,7 @@ static int stm32_dfsdm_adc_probe(struct platform_device *pdev)
 	iio->dev.of_node = np;
 	iio->modes = INDIO_DIRECT_MODE;
 
-	platform_set_drvdata(pdev, adc);
+	platform_set_drvdata(pdev, iio);
 
 	ret = of_property_read_u32(dev->of_node, "reg", &adc->fl_id);
 	if (ret != 0 || adc->fl_id >= adc->dfsdm->num_fls) {
@@ -1603,7 +1605,7 @@ static int stm32_dfsdm_adc_probe(struct platform_device *pdev)
 		return irq;
 
 	ret = devm_request_irq(dev, irq, stm32_dfsdm_irq,
-			       0, pdev->name, adc);
+			       0, pdev->name, iio);
 	if (ret < 0) {
 		dev_err(dev, "Failed to request IRQ\n");
 		return ret;
@@ -1650,8 +1652,8 @@ static int stm32_dfsdm_adc_probe(struct platform_device *pdev)
 
 static int stm32_dfsdm_adc_remove(struct platform_device *pdev)
 {
-	struct stm32_dfsdm_adc *adc = platform_get_drvdata(pdev);
-	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
 
 	if (adc->dev_data->type == DFSDM_AUDIO)
 		of_platform_depopulate(&pdev->dev);
@@ -1663,8 +1665,7 @@ static int stm32_dfsdm_adc_remove(struct platform_device *pdev)
 
 static int __maybe_unused stm32_dfsdm_adc_suspend(struct device *dev)
 {
-	struct stm32_dfsdm_adc *adc = dev_get_drvdata(dev);
-	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 
 	if (iio_buffer_enabled(indio_dev))
 		__stm32_dfsdm_predisable(indio_dev);
@@ -1674,8 +1675,8 @@ static int __maybe_unused stm32_dfsdm_adc_suspend(struct device *dev)
 
 static int __maybe_unused stm32_dfsdm_adc_resume(struct device *dev)
 {
-	struct stm32_dfsdm_adc *adc = dev_get_drvdata(dev);
-	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
 	const struct iio_chan_spec *chan;
 	struct stm32_dfsdm_channel *ch;
 	int i, ret;
-- 
2.25.1

