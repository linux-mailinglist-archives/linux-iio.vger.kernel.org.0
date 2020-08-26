Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95C5D252F98
	for <lists+linux-iio@lfdr.de>; Wed, 26 Aug 2020 15:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730129AbgHZNWR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 Aug 2020 09:22:17 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:52906 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728276AbgHZNWR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 26 Aug 2020 09:22:17 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07QDKK90016639;
        Wed, 26 Aug 2020 09:22:16 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 332w765qt0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Aug 2020 09:22:16 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 07QDMEDk019387
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 26 Aug 2020 09:22:14 -0400
Received: from SCSQCASHYB6.ad.analog.com (10.77.17.132) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 26 Aug 2020 06:22:13 -0700
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB6.ad.analog.com (10.77.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 26 Aug 2020 06:21:45 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 26 Aug 2020 06:22:12 -0700
Received: from saturn.ad.analog.com ([10.48.65.100])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 07QDM8tD003222;
        Wed, 26 Aug 2020 09:22:09 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <kgene@kernel.org>, <krzk@kernel.org>,
        "Sergiu Cuciurean" <sergiu.cuciurean@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: adc: exynos_adc: Replace indio_dev->mlock with own device lock
Date:   Wed, 26 Aug 2020 16:22:03 +0300
Message-ID: <20200826132203.236748-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-26_09:2020-08-26,2020-08-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=927 spamscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 clxscore=1011
 impostorscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008260105
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>

As part of the general cleanup of indio_dev->mlock, this change replaces
it with a local lock, to protect potential concurrent access to the
completion callback during a conversion.

Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/adc/exynos_adc.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
index 7d23b6c33284..6a49f8dfab22 100644
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -132,6 +132,8 @@ struct exynos_adc {
 
 	struct completion	completion;
 
+	struct mutex		lock;
+
 	u32			value;
 	unsigned int            version;
 
@@ -542,7 +544,7 @@ static int exynos_read_raw(struct iio_dev *indio_dev,
 		return -EINVAL;
 	}
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&info->lock);
 	reinit_completion(&info->completion);
 
 	/* Select the channel to be used and Trigger conversion */
@@ -562,7 +564,7 @@ static int exynos_read_raw(struct iio_dev *indio_dev,
 		ret = IIO_VAL_INT;
 	}
 
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&info->lock);
 
 	return ret;
 }
@@ -573,7 +575,7 @@ static int exynos_read_s3c64xx_ts(struct iio_dev *indio_dev, int *x, int *y)
 	unsigned long timeout;
 	int ret;
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&info->lock);
 	info->read_ts = true;
 
 	reinit_completion(&info->completion);
@@ -598,7 +600,7 @@ static int exynos_read_s3c64xx_ts(struct iio_dev *indio_dev, int *x, int *y)
 	}
 
 	info->read_ts = false;
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&info->lock);
 
 	return ret;
 }
@@ -872,6 +874,8 @@ static int exynos_adc_probe(struct platform_device *pdev)
 	indio_dev->channels = exynos_adc_iio_channels;
 	indio_dev->num_channels = info->data->num_channels;
 
+	mutex_init(&info->lock);
+
 	ret = request_irq(info->irq, exynos_adc_isr,
 					0, dev_name(&pdev->dev), info);
 	if (ret < 0) {
-- 
2.25.1

