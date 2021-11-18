Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10E48455BA1
	for <lists+linux-iio@lfdr.de>; Thu, 18 Nov 2021 13:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344740AbhKRMo5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 18 Nov 2021 07:44:57 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:57712 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1344732AbhKRMoz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Nov 2021 07:44:55 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AI9ZkHS011332;
        Thu, 18 Nov 2021 13:41:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=bZLyccCPkGwBC1ILuSoOqJaq32TOZCofwJur9eMV86c=;
 b=OgwKPvKIo8GkStXgpTIemvV3xjtrU71q80vfqsu+RPjq8KNkagcNevO+gMJu6Hefqm39
 j8qU8SEVwUHIRg7S6MeMxrpqY2TPFRc9pgSE27MurQcQZfrenOKBOYY1PkPdXL7ir9uY
 hnC2b14uHPk+mZ29WUn2PWjvO5WEq60QQ1bnYyTYSZccmmyWUcEPorbcFZ/7/Fpmw0y0
 a8TgtYC4QUatnBW6QRQlIIa4nOrS3X7R+dyT19VhVEyMWeBbXWtCJx81ptBWAQ6AsGxb
 NrUaPP+Yy22urQHSdNyFnj2YYTi9dslV/5ERtjW19OQcm3rWTFNEDx/IWb1Q+zE/ueTv ag== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3cdcvuumpd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Nov 2021 13:41:22 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2B35710002A;
        Thu, 18 Nov 2021 13:41:19 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 224BB2291A7;
        Thu, 18 Nov 2021 13:41:19 +0100 (CET)
Received: from localhost (10.75.127.51) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Thu, 18 Nov 2021 13:41:18
 +0100
From:   Olivier Moysan <olivier.moysan@foss.st.com>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Wan Jiabing <wanjiabing@vivo.com>, Xu Wang <vulab@iscas.ac.cn>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH] iio: adc: stm32: fix null pointer on defer_probe error
Date:   Thu, 18 Nov 2021 13:39:52 +0100
Message-ID: <20211118123952.15383-1-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-18_05,2021-11-17_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

dev_err_probe() calls __device_set_deferred_probe_reason()
on -EPROBE_DEFER error.
If device pointer to driver core private structure is not initialized,
a null pointer error occurs.
This pointer is set too late on iio_device_register() call, for iio device.
So use parent device instead for dev_err_probe() call.

Fixes: 0e346b2cfa85 ("iio: adc: stm32-adc: add vrefint calibration support")

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 drivers/iio/adc/stm32-adc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index 7f1fb36c747c..14c7c9d390e8 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -217,6 +217,7 @@ struct stm32_adc_cfg {
 
 /**
  * struct stm32_adc - private data of each ADC IIO instance
+ * dev:			parent device
  * @common:		reference to ADC block common data
  * @offset:		ADC instance register offset in ADC block
  * @cfg:		compatible configuration data
@@ -243,6 +244,7 @@ struct stm32_adc_cfg {
  * @int_ch:		internal channel indexes array
  */
 struct stm32_adc {
+	struct device		*dev;
 	struct stm32_adc_common	*common;
 	u32			offset;
 	const struct stm32_adc_cfg	*cfg;
@@ -1986,8 +1988,7 @@ static int stm32_adc_populate_int_ch(struct iio_dev *indio_dev, const char *ch_n
 			/* Get calibration data for vrefint channel */
 			ret = nvmem_cell_read_u16(&indio_dev->dev, "vrefint", &vrefint);
 			if (ret && ret != -ENOENT) {
-				return dev_err_probe(&indio_dev->dev, ret,
-						     "nvmem access error\n");
+				return dev_err_probe(adc->dev, ret, "nvmem access error\n");
 			}
 			if (ret == -ENOENT)
 				dev_dbg(&indio_dev->dev, "vrefint calibration not found\n");
@@ -2221,6 +2222,7 @@ static int stm32_adc_probe(struct platform_device *pdev)
 	init_completion(&adc->completion);
 	adc->cfg = (const struct stm32_adc_cfg *)
 		of_match_device(dev->driver->of_match_table, dev)->data;
+	adc->dev = &pdev->dev;
 
 	indio_dev->name = dev_name(&pdev->dev);
 	indio_dev->dev.of_node = pdev->dev.of_node;
-- 
2.17.1

