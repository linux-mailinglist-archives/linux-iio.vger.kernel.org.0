Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFE81BBC1B
	for <lists+linux-iio@lfdr.de>; Tue, 28 Apr 2020 13:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgD1LOa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Apr 2020 07:14:30 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:16768 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726759AbgD1LOU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Apr 2020 07:14:20 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03SBBofY020265;
        Tue, 28 Apr 2020 07:14:17 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 30mj45baag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Apr 2020 07:14:17 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 03SBEGDa013689
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 28 Apr 2020 07:14:16 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 28 Apr 2020 07:14:15 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 28 Apr 2020 07:14:15 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 28 Apr 2020 07:14:15 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 03SBEAgu032471;
        Tue, 28 Apr 2020 07:14:12 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <rachna@ti.com>, <mugunthanvnm@ti.com>,
        <vigneshr@ti.com>, <afd@ti.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 2/3] iio: adc: ti_am335x_adc: alloc kfifo & IRQ via devm_ functions
Date:   Tue, 28 Apr 2020 14:14:29 +0300
Message-ID: <20200428111430.71723-2-alexandru.ardelean@analog.com>
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
 lowpriorityscore=0 bulkscore=0 mlxlogscore=856 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004280091
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change attaches the life-cycle of the kfifo buffer & IRQ to the
parent-device. This in turn cleans up the exit & error paths, since we
don't need to explicitly cleanup these resources.

The main intent here is to remove the explicit cleanup of the
'indio_dev->buffer' via 'iio_kfifo_free(indio_dev->buffer);'.

As we want to add support for multiple buffers per IIO device, having it
exposed like this makes it tricky to consider a safe backwards compatible
approach for it.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/adc/ti_am335x_adc.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index d932fe383a24..03b2ab649cc3 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -377,7 +377,8 @@ static const struct iio_buffer_setup_ops tiadc_buffer_setup_ops = {
 	.postdisable = &tiadc_buffer_postdisable,
 };
 
-static int tiadc_iio_buffered_hardware_setup(struct iio_dev *indio_dev,
+static int tiadc_iio_buffered_hardware_setup(struct device *dev,
+	struct iio_dev *indio_dev,
 	irqreturn_t (*pollfunc_bh)(int irq, void *p),
 	irqreturn_t (*pollfunc_th)(int irq, void *p),
 	int irq,
@@ -387,13 +388,13 @@ static int tiadc_iio_buffered_hardware_setup(struct iio_dev *indio_dev,
 	struct iio_buffer *buffer;
 	int ret;
 
-	buffer = iio_kfifo_allocate();
+	buffer = devm_iio_kfifo_allocate(dev);
 	if (!buffer)
 		return -ENOMEM;
 
 	iio_device_attach_buffer(indio_dev, buffer);
 
-	ret = request_threaded_irq(irq,	pollfunc_th, pollfunc_bh,
+	ret = devm_request_threaded_irq(dev, irq, pollfunc_th, pollfunc_bh,
 				flags, indio_dev->name, indio_dev);
 	if (ret)
 		goto error_kfifo_free;
@@ -408,15 +409,6 @@ static int tiadc_iio_buffered_hardware_setup(struct iio_dev *indio_dev,
 	return ret;
 }
 
-static void tiadc_iio_buffered_hardware_remove(struct iio_dev *indio_dev)
-{
-	struct tiadc_device *adc_dev = iio_priv(indio_dev);
-
-	free_irq(adc_dev->mfd_tscadc->irq, indio_dev);
-	iio_kfifo_free(indio_dev->buffer);
-}
-
-
 static const char * const chan_name_ain[] = {
 	"AIN0",
 	"AIN1",
@@ -636,7 +628,7 @@ static int tiadc_probe(struct platform_device *pdev)
 	if (err < 0)
 		return err;
 
-	err = tiadc_iio_buffered_hardware_setup(indio_dev,
+	err = tiadc_iio_buffered_hardware_setup(&pdev->dev, indio_dev,
 		&tiadc_worker_h,
 		&tiadc_irq_h,
 		adc_dev->mfd_tscadc->irq,
@@ -661,7 +653,6 @@ static int tiadc_probe(struct platform_device *pdev)
 err_dma:
 	iio_device_unregister(indio_dev);
 err_buffer_unregister:
-	tiadc_iio_buffered_hardware_remove(indio_dev);
 err_free_channels:
 	return err;
 }
@@ -679,7 +670,6 @@ static int tiadc_remove(struct platform_device *pdev)
 		dma_release_channel(dma->chan);
 	}
 	iio_device_unregister(indio_dev);
-	tiadc_iio_buffered_hardware_remove(indio_dev);
 
 	step_en = get_adc_step_mask(adc_dev);
 	am335x_tsc_se_clr(adc_dev->mfd_tscadc, step_en);
-- 
2.17.1

