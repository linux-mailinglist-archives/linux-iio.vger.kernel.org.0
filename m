Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7668E1DE7A8
	for <lists+linux-iio@lfdr.de>; Fri, 22 May 2020 15:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbgEVNHp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 May 2020 09:07:45 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:34476 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729384AbgEVNHo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 May 2020 09:07:44 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04MD4a7I023330;
        Fri, 22 May 2020 09:07:35 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 312a17ejh8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 May 2020 09:07:34 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 04MD7XlK028479
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 22 May 2020 09:07:33 -0400
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 22 May 2020 06:07:32 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 22 May 2020 06:07:31 -0700
Received: from saturn.ad.analog.com ([10.48.65.112])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 04MD7Rhm012558;
        Fri, 22 May 2020 09:07:27 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: stm32-adc: keep a reference to the iio device on the state struct
Date:   Fri, 22 May 2020 16:07:19 +0300
Message-ID: <20200522130719.630714-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-22_05:2020-05-22,2020-05-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 cotscore=-2147483648
 suspectscore=0 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005220107
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
 drivers/iio/adc/stm32-adc.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index ae622ee6d08c..7e58c4443e3f 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -171,6 +171,7 @@ struct stm32_adc_cfg {
 
 /**
  * struct stm32_adc - private data of each ADC IIO instance
+ * @indio_dev:		back-reference to the IIO device object
  * @common:		reference to ADC block common data
  * @offset:		ADC instance register offset in ADC block
  * @cfg:		compatible configuration data
@@ -194,6 +195,7 @@ struct stm32_adc_cfg {
  * @chan_name:		channel name array
  */
 struct stm32_adc {
+	struct iio_dev		*indio_dev;
 	struct stm32_adc_common	*common;
 	u32			offset;
 	const struct stm32_adc_cfg	*cfg;
@@ -637,7 +639,7 @@ static void stm32h7_adc_start_conv(struct stm32_adc *adc, bool dma)
 
 static void stm32h7_adc_stop_conv(struct stm32_adc *adc)
 {
-	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
+	struct iio_dev *indio_dev = adc->indio_dev;
 	int ret;
 	u32 val;
 
@@ -654,7 +656,7 @@ static void stm32h7_adc_stop_conv(struct stm32_adc *adc)
 
 static int stm32h7_adc_exit_pwr_down(struct stm32_adc *adc)
 {
-	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
+	struct iio_dev *indio_dev = adc->indio_dev;
 	int ret;
 	u32 val;
 
@@ -692,7 +694,7 @@ static void stm32h7_adc_enter_pwr_down(struct stm32_adc *adc)
 
 static int stm32h7_adc_enable(struct stm32_adc *adc)
 {
-	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
+	struct iio_dev *indio_dev = adc->indio_dev;
 	int ret;
 	u32 val;
 
@@ -715,7 +717,7 @@ static int stm32h7_adc_enable(struct stm32_adc *adc)
 
 static void stm32h7_adc_disable(struct stm32_adc *adc)
 {
-	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
+	struct iio_dev *indio_dev = adc->indio_dev;
 	int ret;
 	u32 val;
 
@@ -735,7 +737,7 @@ static void stm32h7_adc_disable(struct stm32_adc *adc)
  */
 static int stm32h7_adc_read_selfcalib(struct stm32_adc *adc)
 {
-	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
+	struct iio_dev *indio_dev = adc->indio_dev;
 	int i, ret;
 	u32 lincalrdyw_mask, val;
 
@@ -779,7 +781,7 @@ static int stm32h7_adc_read_selfcalib(struct stm32_adc *adc)
  */
 static int stm32h7_adc_restore_selfcalib(struct stm32_adc *adc)
 {
-	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
+	struct iio_dev *indio_dev = adc->indio_dev;
 	int i, ret;
 	u32 lincalrdyw_mask, val;
 
@@ -852,7 +854,7 @@ static int stm32h7_adc_restore_selfcalib(struct stm32_adc *adc)
  */
 static int stm32h7_adc_selfcalib(struct stm32_adc *adc)
 {
-	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
+	struct iio_dev *indio_dev = adc->indio_dev;
 	int ret;
 	u32 val;
 
@@ -1228,7 +1230,7 @@ static int stm32_adc_read_raw(struct iio_dev *indio_dev,
 static irqreturn_t stm32_adc_threaded_isr(int irq, void *data)
 {
 	struct stm32_adc *adc = data;
-	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
+	struct iio_dev *indio_dev = adc->indio_dev;
 	const struct stm32_adc_regspec *regs = adc->cfg->regs;
 	u32 status = stm32_adc_readl(adc, regs->isr_eoc.reg);
 
@@ -1241,7 +1243,7 @@ static irqreturn_t stm32_adc_threaded_isr(int irq, void *data)
 static irqreturn_t stm32_adc_isr(int irq, void *data)
 {
 	struct stm32_adc *adc = data;
-	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
+	struct iio_dev *indio_dev = adc->indio_dev;
 	const struct stm32_adc_regspec *regs = adc->cfg->regs;
 	u32 status = stm32_adc_readl(adc, regs->isr_eoc.reg);
 
@@ -1879,6 +1881,7 @@ static int stm32_adc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	adc = iio_priv(indio_dev);
+	adc->indio_dev = indio_dev;
 	adc->common = dev_get_drvdata(pdev->dev.parent);
 	spin_lock_init(&adc->lock);
 	init_completion(&adc->completion);
@@ -1990,7 +1993,7 @@ static int stm32_adc_probe(struct platform_device *pdev)
 static int stm32_adc_remove(struct platform_device *pdev)
 {
 	struct stm32_adc *adc = platform_get_drvdata(pdev);
-	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
+	struct iio_dev *indio_dev = adc->indio_dev;
 
 	pm_runtime_get_sync(&pdev->dev);
 	iio_device_unregister(indio_dev);
@@ -2013,7 +2016,7 @@ static int stm32_adc_remove(struct platform_device *pdev)
 static int stm32_adc_suspend(struct device *dev)
 {
 	struct stm32_adc *adc = dev_get_drvdata(dev);
-	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
+	struct iio_dev *indio_dev = adc->indio_dev;
 
 	if (iio_buffer_enabled(indio_dev))
 		__stm32_adc_buffer_predisable(indio_dev);
@@ -2024,7 +2027,7 @@ static int stm32_adc_suspend(struct device *dev)
 static int stm32_adc_resume(struct device *dev)
 {
 	struct stm32_adc *adc = dev_get_drvdata(dev);
-	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
+	struct iio_dev *indio_dev = adc->indio_dev;
 	int ret;
 
 	ret = pm_runtime_force_resume(dev);
-- 
2.25.1

