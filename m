Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08B691BBC18
	for <lists+linux-iio@lfdr.de>; Tue, 28 Apr 2020 13:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgD1LOW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Apr 2020 07:14:22 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:17486 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726762AbgD1LOV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Apr 2020 07:14:21 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03SBBMGJ020165;
        Tue, 28 Apr 2020 07:14:18 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 30mj45baah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Apr 2020 07:14:18 -0400
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 03SBEHDx017060
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 28 Apr 2020 07:14:17 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Tue, 28 Apr
 2020 07:14:16 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 28 Apr 2020 07:14:16 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 03SBEAgv032471;
        Tue, 28 Apr 2020 07:14:14 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <rachna@ti.com>, <mugunthanvnm@ti.com>,
        <vigneshr@ti.com>, <afd@ti.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 3/3] iio: adc: ti_am335x_adc: convert rest of probe to devm_ functions
Date:   Tue, 28 Apr 2020 14:14:30 +0300
Message-ID: <20200428111430.71723-3-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200428111430.71723-1-alexandru.ardelean@analog.com>
References: <20200428111430.71723-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-28_07:2020-04-28,2020-04-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 suspectscore=2 malwarescore=0 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004280091
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change converts the rest of the probe to use devm_ functions.
Consequently this allows us to remove the remove hook.

It tries to preserve the initial order or probe & remove.
The devm_add_action() call hooks the cleanup routine (what's needed still
for the remove part).
If that doesn't work the DMA channel is cleaned up manually inside the
probe hook. This done (like this) because the remove hook has a peculiar
cleanup that tries to restore a step-mask, and that only seems to happen on
the remove hook, and not in any probe error-cleanup paths.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/adc/ti_am335x_adc.c | 63 +++++++++++++++++----------------
 1 file changed, 32 insertions(+), 31 deletions(-)

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index 03b2ab649cc3..9fac83e036c1 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -562,6 +562,18 @@ static int tiadc_request_dma(struct platform_device *pdev,
 	return -ENOMEM;
 }
 
+static void tiadc_cleanup_dma(struct tiadc_device *adc_dev)
+{
+	struct tiadc_dma *dma = &adc_dev->dma;
+
+	if (!dma->chan)
+		return;
+
+	dma_free_coherent(dma->chan->device->dev, DMA_BUFFER_SIZE,
+			  dma->buf, dma->addr);
+	dma_release_channel(dma->chan);
+}
+
 static int tiadc_parse_dt(struct platform_device *pdev,
 			  struct tiadc_device *adc_dev)
 {
@@ -593,6 +605,17 @@ static int tiadc_parse_dt(struct platform_device *pdev,
 	return 0;
 }
 
+static void tiadc_cleanup(void *data)
+{
+	struct tiadc_device *adc_dev = data;
+	u32 step_en;
+
+	tiadc_cleanup_dma(adc_dev);
+
+	step_en = get_adc_step_mask(adc_dev);
+	am335x_tsc_se_clr(adc_dev->mfd_tscadc, step_en);
+}
+
 static int tiadc_probe(struct platform_device *pdev)
 {
 	struct iio_dev		*indio_dev;
@@ -635,48 +658,27 @@ static int tiadc_probe(struct platform_device *pdev)
 		IRQF_SHARED,
 		&tiadc_buffer_setup_ops);
 
+	err = devm_iio_device_register(&pdev->dev, indio_dev);
 	if (err)
-		goto err_free_channels;
-
-	err = iio_device_register(indio_dev);
-	if (err)
-		goto err_buffer_unregister;
+		return err;
 
 	platform_set_drvdata(pdev, indio_dev);
 
 	err = tiadc_request_dma(pdev, adc_dev);
 	if (err && err == -EPROBE_DEFER)
-		goto err_dma;
+		return err;
+
+	err = devm_add_action(&pdev->dev, tiadc_cleanup, adc_dev);
+	if (err)
+		goto err_free_dma;
 
 	return 0;
 
-err_dma:
-	iio_device_unregister(indio_dev);
-err_buffer_unregister:
-err_free_channels:
+err_free_dma:
+	tiadc_cleanup_dma(adc_dev);
 	return err;
 }
 
-static int tiadc_remove(struct platform_device *pdev)
-{
-	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
-	struct tiadc_device *adc_dev = iio_priv(indio_dev);
-	struct tiadc_dma *dma = &adc_dev->dma;
-	u32 step_en;
-
-	if (dma->chan) {
-		dma_free_coherent(dma->chan->device->dev, DMA_BUFFER_SIZE,
-				  dma->buf, dma->addr);
-		dma_release_channel(dma->chan);
-	}
-	iio_device_unregister(indio_dev);
-
-	step_en = get_adc_step_mask(adc_dev);
-	am335x_tsc_se_clr(adc_dev->mfd_tscadc, step_en);
-
-	return 0;
-}
-
 static int __maybe_unused tiadc_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
@@ -723,7 +725,6 @@ static struct platform_driver tiadc_driver = {
 		.of_match_table = ti_adc_dt_ids,
 	},
 	.probe	= tiadc_probe,
-	.remove	= tiadc_remove,
 };
 module_platform_driver(tiadc_driver);
 
-- 
2.17.1

