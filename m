Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8EB6178CA3
	for <lists+linux-iio@lfdr.de>; Wed,  4 Mar 2020 09:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbgCDIj2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 4 Mar 2020 03:39:28 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:54938 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728642AbgCDIj2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Mar 2020 03:39:28 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0248cpPd032256;
        Wed, 4 Mar 2020 03:39:25 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 2yfnrannqf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Mar 2020 03:39:25 -0500
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 0248dOTc040184
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 4 Mar 2020 03:39:24 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 4 Mar 2020 03:39:23 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 4 Mar 2020 03:39:23 -0500
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 4 Mar 2020 03:39:23 -0500
Received: from saturn.ad.analog.com ([10.48.65.112])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0248dJYr021800;
        Wed, 4 Mar 2020 03:39:21 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <eugen.hristev@microchip.com>,
        <ludovic.desroches@microchip.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 2/2] iio: at91-sama5d2_adc: adjust iio_triggered_buffer_{predisable,postenable} positions
Date:   Wed, 4 Mar 2020 10:42:19 +0200
Message-ID: <20200304084219.20810-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200304084219.20810-1-alexandru.ardelean@analog.com>
References: <20200304084219.20810-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-04_01:2020-03-03,2020-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003040067
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The iio_triggered_buffer_{predisable,postenable} functions attach/detach
poll functions.

In most cases the iio_triggered_buffer_postenable() should be called first
to attach the poll function, and then the driver can init the data to be
triggered.
In this case it's the other way around: the DMA code should be initialized
before the attaching the poll function and the reverse should be done when
un-initializing.

To make things easier when removing the iio_triggered_buffer_postenable() &
iio_triggered_buffer_predisable() functions from the IIO core API, the DMA
code has been moved into preenable() for init, and postdisable() for
uninit.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 32 ++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index f2a74c47c768..2e01073d401d 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -882,7 +882,7 @@ static bool at91_adc_current_chan_is_touch(struct iio_dev *indio_dev)
 			       AT91_SAMA5D2_MAX_CHAN_IDX + 1);
 }
 
-static int at91_adc_buffer_postenable(struct iio_dev *indio_dev)
+static int at91_adc_buffer_preenable(struct iio_dev *indio_dev)
 {
 	int ret;
 	struct at91_adc_state *st = iio_priv(indio_dev);
@@ -902,13 +902,20 @@ static int at91_adc_buffer_postenable(struct iio_dev *indio_dev)
 		return ret;
 	}
 
+	return 0;
+}
+
+static int at91_adc_buffer_postenable(struct iio_dev *indio_dev)
+{
+	if (at91_adc_current_chan_is_touch(indio_dev))
+		return 0;
+
 	return iio_triggered_buffer_postenable(indio_dev);
 }
 
-static int at91_adc_buffer_predisable(struct iio_dev *indio_dev)
+static int at91_adc_buffer_postdisable(struct iio_dev *indio_dev)
 {
 	struct at91_adc_state *st = iio_priv(indio_dev);
-	int ret;
 	u8 bit;
 
 	/* check if we are disabling triggered buffer or the touchscreen */
@@ -919,13 +926,8 @@ static int at91_adc_buffer_predisable(struct iio_dev *indio_dev)
 	if (!(indio_dev->currentmode & INDIO_ALL_TRIGGERED_MODES))
 		return -EINVAL;
 
-	/* continue with the triggered buffer */
-	ret = iio_triggered_buffer_predisable(indio_dev);
-	if (ret < 0)
-		dev_err(&indio_dev->dev, "buffer predisable failed\n");
-
 	if (!st->dma_st.dma_chan)
-		return ret;
+		return 0;
 
 	/* if we are using DMA we must clear registers and end DMA */
 	dmaengine_terminate_sync(st->dma_st.dma_chan);
@@ -952,10 +954,20 @@ static int at91_adc_buffer_predisable(struct iio_dev *indio_dev)
 
 	/* read overflow register to clear possible overflow status */
 	at91_adc_readl(st, AT91_SAMA5D2_OVER);
-	return ret;
+	return 0;
+}
+
+static int at91_adc_buffer_predisable(struct iio_dev *indio_dev)
+{
+	if (at91_adc_current_chan_is_touch(indio_dev))
+		return 0;
+
+	return iio_triggered_buffer_predisable(indio_dev);
 }
 
 static const struct iio_buffer_setup_ops at91_buffer_setup_ops = {
+	.preenable = &at91_adc_buffer_preenable,
+	.postdisable = &at91_adc_buffer_postdisable,
 	.postenable = &at91_adc_buffer_postenable,
 	.predisable = &at91_adc_buffer_predisable,
 };
-- 
2.20.1

