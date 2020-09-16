Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABC826C099
	for <lists+linux-iio@lfdr.de>; Wed, 16 Sep 2020 11:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgIPJbv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Sep 2020 05:31:51 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:46876 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726688AbgIPJbi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Sep 2020 05:31:38 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08G9PWrX012821;
        Wed, 16 Sep 2020 05:31:31 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 33k5p61v2p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Sep 2020 05:31:30 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 08G9VT0n050743
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 16 Sep 2020 05:31:29 -0400
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Wed, 16 Sep
 2020 02:31:36 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 16 Sep 2020 02:31:36 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 08G9VL9d022209;
        Wed, 16 Sep 2020 05:31:22 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <kgene@kernel.org>, <krzk@kernel.org>,
        Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2] iio: adc: exynos_adc: Replace indio_dev->mlock with own device lock
Date:   Wed, 16 Sep 2020 12:31:23 +0300
Message-ID: <20200916093123.78954-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200826132203.236748-1-alexandru.ardelean@analog.com>
References: <20200826132203.236748-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-16_02:2020-09-15,2020-09-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=949
 lowpriorityscore=0 impostorscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 clxscore=1011 suspectscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009160069
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>

As part of the general cleanup of indio_dev->mlock, this change replaces
it with a local lock, to protect potential concurrent access to the
completion callback during a conversion.

This is part of a bigger cleanup.
Link: https://lore.kernel.org/linux-iio/CA+U=Dsoo6YABe5ODLp+eFNPGFDjk5ZeQEceGkqjxXcVEhLWubw@mail.gmail.com/

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/adc/exynos_adc.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
index 20477b249f2a..99f4404e9fd1 100644
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -138,6 +138,16 @@ struct exynos_adc {
 	bool			read_ts;
 	u32			ts_x;
 	u32			ts_y;
+
+	/*
+	 * Lock to protect from potential concurrent access to the
+	 * completion callback during a manual conversion. For this driver
+	 * a wait-callback is used to wait for the conversion result,
+	 * so in the meantime no other read request (or conversion start)
+	 * must be performed, otherwise it would interfere with the
+	 * current conversion result.
+	 */
+	struct mutex		lock;
 };
 
 struct exynos_adc_data {
@@ -542,7 +552,7 @@ static int exynos_read_raw(struct iio_dev *indio_dev,
 		return -EINVAL;
 	}
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&info->lock);
 	reinit_completion(&info->completion);
 
 	/* Select the channel to be used and Trigger conversion */
@@ -562,7 +572,7 @@ static int exynos_read_raw(struct iio_dev *indio_dev,
 		ret = IIO_VAL_INT;
 	}
 
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&info->lock);
 
 	return ret;
 }
@@ -573,7 +583,7 @@ static int exynos_read_s3c64xx_ts(struct iio_dev *indio_dev, int *x, int *y)
 	unsigned long timeout;
 	int ret;
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&info->lock);
 	info->read_ts = true;
 
 	reinit_completion(&info->completion);
@@ -598,7 +608,7 @@ static int exynos_read_s3c64xx_ts(struct iio_dev *indio_dev, int *x, int *y)
 	}
 
 	info->read_ts = false;
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&info->lock);
 
 	return ret;
 }
@@ -868,6 +878,8 @@ static int exynos_adc_probe(struct platform_device *pdev)
 	indio_dev->channels = exynos_adc_iio_channels;
 	indio_dev->num_channels = info->data->num_channels;
 
+	mutex_init(&info->lock);
+
 	ret = request_irq(info->irq, exynos_adc_isr,
 					0, dev_name(&pdev->dev), info);
 	if (ret < 0) {
-- 
2.17.1

