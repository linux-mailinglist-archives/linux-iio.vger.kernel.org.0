Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCEC27BD94
	for <lists+linux-iio@lfdr.de>; Tue, 29 Sep 2020 09:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbgI2HKF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Sep 2020 03:10:05 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:58234 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725535AbgI2HKC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 29 Sep 2020 03:10:02 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08T75BkT016026;
        Tue, 29 Sep 2020 03:09:56 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 33syg625df-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Sep 2020 03:09:56 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 08T79tLL049583
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 29 Sep 2020 03:09:55 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 29 Sep 2020 03:09:47 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 29 Sep 2020 03:09:47 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 29 Sep 2020 03:09:47 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 08T79hUl013506;
        Tue, 29 Sep 2020 03:09:49 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <eugen.hristev@microchip.com>,
        <nicolas.ferre@microchip.com>, <ludovic.desroches@microchip.com>,
        <bleung@chromium.org>, <enric.balletbo@collabora.com>,
        <groeck@chromium.org>, <srinivas.pandruvada@linux.intel.com>,
        <andy.shevchenko@gmail.com>, <gwendal@chromium.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 2/9] iio: adc: at91-sama5d2_adc: merge buffer & trigger init into a function
Date:   Tue, 29 Sep 2020 10:09:01 +0300
Message-ID: <20200929070908.10456-3-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929070908.10456-1-alexandru.ardelean@analog.com>
References: <20200929070908.10456-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-29_01:2020-09-29,2020-09-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009290065
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change is mostly cosmetic, but it's also a pre-cursor to the
the change for 'iio_buffer_set_attrs()', where the helper gets updated to
better support multiple IIO buffers for 1 IIO device.

The only functional change is that the error message for the trigger alloc
failure is bound to the parent device vs the IIO device object.

Also, the new at91_adc_buffer_and_trigger_init() function was moved after
the definition of the 'at91_adc_fifo_attributes'.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 78 ++++++++++++++----------------
 1 file changed, 36 insertions(+), 42 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index ad7d9819f83c..b9c3cc6d5913 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -1014,21 +1014,6 @@ static struct iio_trigger *at91_adc_allocate_trigger(struct iio_dev *indio,
 
 	return trig;
 }
-
-static int at91_adc_trigger_init(struct iio_dev *indio)
-{
-	struct at91_adc_state *st = iio_priv(indio);
-
-	st->trig = at91_adc_allocate_trigger(indio, st->selected_trig->name);
-	if (IS_ERR(st->trig)) {
-		dev_err(&indio->dev,
-			"could not allocate trigger\n");
-		return PTR_ERR(st->trig);
-	}
-
-	return 0;
-}
-
 static void at91_adc_trigger_handler_nodma(struct iio_dev *indio_dev,
 					   struct iio_poll_func *pf)
 {
@@ -1156,13 +1141,6 @@ static irqreturn_t at91_adc_trigger_handler(int irq, void *p)
 	return IRQ_HANDLED;
 }
 
-static int at91_adc_buffer_init(struct iio_dev *indio)
-{
-	return devm_iio_triggered_buffer_setup(&indio->dev, indio,
-		&iio_pollfunc_store_time,
-		&at91_adc_trigger_handler, &at91_buffer_setup_ops);
-}
-
 static unsigned at91_adc_startup_time(unsigned startup_time_min,
 				      unsigned adc_clk_khz)
 {
@@ -1683,6 +1661,40 @@ static const struct iio_info at91_adc_info = {
 	.hwfifo_set_watermark = &at91_adc_set_watermark,
 };
 
+static int at91_adc_buffer_and_trigger_init(struct device *dev,
+					    struct iio_dev *indio)
+{
+	struct at91_adc_state *st = iio_priv(indio);
+	int ret;
+
+	ret = devm_iio_triggered_buffer_setup(&indio->dev, indio,
+		&iio_pollfunc_store_time,
+		&at91_adc_trigger_handler, &at91_buffer_setup_ops);
+	if (ret < 0) {
+		dev_err(dev, "couldn't initialize the buffer.\n");
+		return ret;
+	}
+
+	if (!st->selected_trig->hw_trig)
+		return 0;
+
+	iio_buffer_set_attrs(indio->buffer, at91_adc_fifo_attributes);
+
+	st->trig = at91_adc_allocate_trigger(indio, st->selected_trig->name);
+	if (IS_ERR(st->trig)) {
+		dev_err(dev, "could not allocate trigger\n");
+		return PTR_ERR(st->trig);
+	}
+
+	/*
+	 * Initially the iio buffer has a length of 2 and
+	 * a watermark of 1
+	 */
+	st->dma_st.watermark = 1;
+
+	return 0;
+}
+
 static int at91_adc_probe(struct platform_device *pdev)
 {
 	struct iio_dev *indio_dev;
@@ -1818,27 +1830,9 @@ static int at91_adc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, indio_dev);
 
-	ret = at91_adc_buffer_init(indio_dev);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "couldn't initialize the buffer.\n");
+	ret = at91_adc_buffer_and_trigger_init(&pdev->dev, indio_dev);
+	if (ret < 0)
 		goto per_clk_disable_unprepare;
-	}
-
-	if (st->selected_trig->hw_trig) {
-		ret = at91_adc_trigger_init(indio_dev);
-		if (ret < 0) {
-			dev_err(&pdev->dev, "couldn't setup the triggers.\n");
-			goto per_clk_disable_unprepare;
-		}
-		/*
-		 * Initially the iio buffer has a length of 2 and
-		 * a watermark of 1
-		 */
-		st->dma_st.watermark = 1;
-
-		iio_buffer_set_attrs(indio_dev->buffer,
-				     at91_adc_fifo_attributes);
-	}
 
 	if (dma_coerce_mask_and_coherent(&indio_dev->dev, DMA_BIT_MASK(32)))
 		dev_info(&pdev->dev, "cannot set DMA mask to 32-bit\n");
-- 
2.17.1

