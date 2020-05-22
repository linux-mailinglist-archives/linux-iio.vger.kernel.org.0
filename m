Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 914831DE7AD
	for <lists+linux-iio@lfdr.de>; Fri, 22 May 2020 15:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729344AbgEVNIX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 May 2020 09:08:23 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:22204 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729377AbgEVNIQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 May 2020 09:08:16 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04MD77X3027265;
        Fri, 22 May 2020 09:08:08 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 312d365vak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 May 2020 09:08:07 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 04MD859n028639
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 22 May 2020 09:08:05 -0400
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 22 May 2020 06:08:03 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 22 May 2020 06:08:03 -0700
Received: from saturn.ad.analog.com ([10.48.65.112])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 04MD81UG012565;
        Fri, 22 May 2020 09:08:01 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: stm32-dfsdm-adc: keep a reference to the iio device on the state struct
Date:   Fri, 22 May 2020 16:08:04 +0300
Message-ID: <20200522130804.631508-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-22_05:2020-05-22,2020-05-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 mlxscore=0 phishscore=0 cotscore=-2147483648
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 clxscore=1015 adultscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005220107
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
The iio_priv() helper won't be affected by the rework.

For this driver, not using iio_priv_to_dev(), means keeping a reference to
the IIO device on the state struct.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/adc/stm32-dfsdm-adc.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index 76a60d93fe23..ff7a6afa4558 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -69,6 +69,7 @@ struct stm32_dfsdm_dev_data {
 
 struct stm32_dfsdm_adc {
 	struct stm32_dfsdm *dfsdm;
+	struct iio_dev *indio_dev;
 	const struct stm32_dfsdm_dev_data *dev_data;
 	unsigned int fl_id;
 	unsigned int nconv;
@@ -332,7 +333,7 @@ static int stm32_dfsdm_compute_all_osrs(struct iio_dev *indio_dev,
 
 static int stm32_dfsdm_start_channel(struct stm32_dfsdm_adc *adc)
 {
-	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
+	struct iio_dev *indio_dev = adc->indio_dev;
 	struct regmap *regmap = adc->dfsdm->regmap;
 	const struct iio_chan_spec *chan;
 	unsigned int bit;
@@ -352,7 +353,7 @@ static int stm32_dfsdm_start_channel(struct stm32_dfsdm_adc *adc)
 
 static void stm32_dfsdm_stop_channel(struct stm32_dfsdm_adc *adc)
 {
-	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
+	struct iio_dev *indio_dev = adc->indio_dev;
 	struct regmap *regmap = adc->dfsdm->regmap;
 	const struct iio_chan_spec *chan;
 	unsigned int bit;
@@ -422,7 +423,7 @@ static int stm32_dfsdm_filter_set_trig(struct stm32_dfsdm_adc *adc,
 				       unsigned int fl_id,
 				       struct iio_trigger *trig)
 {
-	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
+	struct iio_dev *indio_dev = adc->indio_dev;
 	struct regmap *regmap = adc->dfsdm->regmap;
 	u32 jextsel = 0, jexten = STM32_DFSDM_JEXTEN_DISABLED;
 	int ret;
@@ -451,7 +452,7 @@ static int stm32_dfsdm_channels_configure(struct stm32_dfsdm_adc *adc,
 					  unsigned int fl_id,
 					  struct iio_trigger *trig)
 {
-	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
+	struct iio_dev *indio_dev = adc->indio_dev;
 	struct regmap *regmap = adc->dfsdm->regmap;
 	struct stm32_dfsdm_filter *fl = &adc->dfsdm->fl_list[fl_id];
 	struct stm32_dfsdm_filter_osr *flo = &fl->flo[0];
@@ -495,7 +496,7 @@ static int stm32_dfsdm_filter_configure(struct stm32_dfsdm_adc *adc,
 					unsigned int fl_id,
 					struct iio_trigger *trig)
 {
-	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
+	struct iio_dev *indio_dev = adc->indio_dev;
 	struct regmap *regmap = adc->dfsdm->regmap;
 	struct stm32_dfsdm_filter *fl = &adc->dfsdm->fl_list[fl_id];
 	struct stm32_dfsdm_filter_osr *flo = &fl->flo[fl->fast];
@@ -1314,7 +1315,7 @@ static const struct iio_info stm32_dfsdm_info_adc = {
 static irqreturn_t stm32_dfsdm_irq(int irq, void *arg)
 {
 	struct stm32_dfsdm_adc *adc = arg;
-	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
+	struct iio_dev *indio_dev = adc->indio_dev;
 	struct regmap *regmap = adc->dfsdm->regmap;
 	unsigned int status, int_en;
 
@@ -1569,6 +1570,7 @@ static int stm32_dfsdm_adc_probe(struct platform_device *pdev)
 
 	adc = iio_priv(iio);
 	adc->dfsdm = dev_get_drvdata(dev->parent);
+	adc->indio_dev = iio;
 
 	iio->dev.parent = dev;
 	iio->dev.of_node = np;
@@ -1651,7 +1653,7 @@ static int stm32_dfsdm_adc_probe(struct platform_device *pdev)
 static int stm32_dfsdm_adc_remove(struct platform_device *pdev)
 {
 	struct stm32_dfsdm_adc *adc = platform_get_drvdata(pdev);
-	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
+	struct iio_dev *indio_dev = adc->indio_dev;
 
 	if (adc->dev_data->type == DFSDM_AUDIO)
 		of_platform_depopulate(&pdev->dev);
@@ -1664,7 +1666,7 @@ static int stm32_dfsdm_adc_remove(struct platform_device *pdev)
 static int __maybe_unused stm32_dfsdm_adc_suspend(struct device *dev)
 {
 	struct stm32_dfsdm_adc *adc = dev_get_drvdata(dev);
-	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
+	struct iio_dev *indio_dev = adc->indio_dev;
 
 	if (iio_buffer_enabled(indio_dev))
 		__stm32_dfsdm_predisable(indio_dev);
@@ -1675,7 +1677,7 @@ static int __maybe_unused stm32_dfsdm_adc_suspend(struct device *dev)
 static int __maybe_unused stm32_dfsdm_adc_resume(struct device *dev)
 {
 	struct stm32_dfsdm_adc *adc = dev_get_drvdata(dev);
-	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
+	struct iio_dev *indio_dev = adc->indio_dev;
 	const struct iio_chan_spec *chan;
 	struct stm32_dfsdm_channel *ch;
 	int i, ret;
-- 
2.25.1

