Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C65252B0183
	for <lists+linux-iio@lfdr.de>; Thu, 12 Nov 2020 10:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgKLJGL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Nov 2020 04:06:11 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:36842 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725902AbgKLJGI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Nov 2020 04:06:08 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AC8wePM017718;
        Thu, 12 Nov 2020 04:05:54 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 34nsc98gym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Nov 2020 04:05:54 -0500
Received: from SCSQMBX10.ad.analog.com (SCSQMBX10.ad.analog.com [10.77.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 0AC95q9K024241
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 12 Nov 2020 04:05:53 -0500
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Thu, 12 Nov
 2020 01:05:51 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 12 Nov 2020 01:05:51 -0800
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0AC95mLl004225;
        Thu, 12 Nov 2020 04:05:49 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <alexandru.ardelean@analog.com>, <lars@metafoo.de>,
        <jic23@kernel.org>
Subject: [PATCH] iio: ad_sigma_delta: Don't put SPI transfer buffer on the stack
Date:   Thu, 12 Nov 2020 11:10:50 +0200
Message-ID: <20201112091050.84991-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-12_02:2020-11-10,2020-11-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 adultscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011120055
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Lars-Peter Clausen <lars@metafoo.de>

Use a heap allocated memory for the SPI transfer buffer. Using stack memory
can corrupt stack memory when using DMA on some systems.

This change adds 4 bytes at the end of the current DMA buffer, which will
be used by the trigger handler.
This is required because the first 4 bytes are reserved for register data.

Fixes: af3008485ea03 ("iio:adc: Add common code for ADI Sigma Delta devices")
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/adc/ad_sigma_delta.c       | 4 ++--
 include/linux/iio/adc/ad_sigma_delta.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 86039e9ecaca..33297f26508a 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -395,11 +395,11 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
+	uint8_t *data = &sigma_delta->data[4];
 	unsigned int reg_size;
 	unsigned int data_reg;
-	uint8_t data[16];
 
-	memset(data, 0x00, 16);
+	memset(data, 0x00, 4);
 
 	reg_size = indio_dev->channels[0].scan_type.realbits +
 			indio_dev->channels[0].scan_type.shift;
diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
index a3a838dcf8e4..ac4ac4752c62 100644
--- a/include/linux/iio/adc/ad_sigma_delta.h
+++ b/include/linux/iio/adc/ad_sigma_delta.h
@@ -80,7 +80,7 @@ struct ad_sigma_delta {
 	 * DMA (thus cache coherency maintenance) requires the
 	 * transfer buffers to live in their own cache lines.
 	 */
-	uint8_t				data[4] ____cacheline_aligned;
+	uint8_t				data[8] ____cacheline_aligned;
 };
 
 static inline int ad_sigma_delta_set_channel(struct ad_sigma_delta *sd,
-- 
2.17.1

