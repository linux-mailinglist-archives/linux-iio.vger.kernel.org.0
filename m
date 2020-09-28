Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB5E027AEE3
	for <lists+linux-iio@lfdr.de>; Mon, 28 Sep 2020 15:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgI1NOY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Sep 2020 09:14:24 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:29198 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726681AbgI1NOW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Sep 2020 09:14:22 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08SD9QEK011250;
        Mon, 28 Sep 2020 09:14:10 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 33syg5ycep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Sep 2020 09:14:10 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 08SDE9RO065305
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 28 Sep 2020 09:14:09 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Mon, 28 Sep
 2020 09:14:03 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 28 Sep 2020 09:14:03 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 08SDDuB7030926;
        Mon, 28 Sep 2020 09:14:04 -0400
From:   Mircea Caprioru <mircea.caprioru@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <alexandru.ardelean@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
        Mircea Caprioru <mircea.caprioru@analog.com>
Subject: [PATCH 4/5] iio: adc: vf610_adc: Replace indio_dev->mlock with own device lock
Date:   Mon, 28 Sep 2020 16:13:32 +0300
Message-ID: <20200928131333.36646-4-mircea.caprioru@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200928131333.36646-1-mircea.caprioru@analog.com>
References: <20200928131333.36646-1-mircea.caprioru@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-28_11:2020-09-28,2020-09-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 mlxscore=0 clxscore=1015 mlxlogscore=778
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009280104
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>

As part of the general cleanup of indio_dev->mlock, this change replaces
it with a local lock on the device's state structure.

This is part of a bigger cleanup.
Link: https://lore.kernel.org/linux-iio/CA+U=Dsoo6YABe5ODLp+eFNPGFDjk5ZeQEceGkqjxXcVEhLWubw@mail.gmail.com/

Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
---
 drivers/iio/adc/vf610_adc.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
index 1d794cf3e3f1..b7d583993f0b 100644
--- a/drivers/iio/adc/vf610_adc.c
+++ b/drivers/iio/adc/vf610_adc.c
@@ -168,6 +168,15 @@ struct vf610_adc {
 
 	struct completion completion;
 	u16 buffer[8];
+	/*
+	 * Lock to protect the device state during a potential concurrent
+	 * read access from userspace. Reading a raw value requires a sequence
+	 * of register writes, then a wait for a completion callback,
+	 * and finally a register read, during which userspace could issue
+	 * another read request. This lock protects a read access from
+	 * ocurring before another one has finished.
+	 */
+	struct mutex lock;
 };
 
 static const u32 vf610_hw_avgs[] = { 1, 4, 8, 16, 32 };
@@ -464,11 +473,11 @@ static int vf610_set_conversion_mode(struct iio_dev *indio_dev,
 {
 	struct vf610_adc *info = iio_priv(indio_dev);
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&info->lock);
 	info->adc_feature.conv_mode = mode;
 	vf610_adc_calculate_rates(info);
 	vf610_adc_hw_init(info);
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&info->lock);
 
 	return 0;
 }
@@ -632,9 +641,9 @@ static int vf610_read_raw(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 	case IIO_CHAN_INFO_PROCESSED:
-		mutex_lock(&indio_dev->mlock);
+		mutex_lock(&info->lock);
 		if (iio_buffer_enabled(indio_dev)) {
-			mutex_unlock(&indio_dev->mlock);
+			mutex_unlock(&info->lock);
 			return -EBUSY;
 		}
 
@@ -645,11 +654,11 @@ static int vf610_read_raw(struct iio_dev *indio_dev,
 		ret = wait_for_completion_interruptible_timeout
 				(&info->completion, VF610_ADC_TIMEOUT);
 		if (ret == 0) {
-			mutex_unlock(&indio_dev->mlock);
+			mutex_unlock(&info->lock);
 			return -ETIMEDOUT;
 		}
 		if (ret < 0) {
-			mutex_unlock(&indio_dev->mlock);
+			mutex_unlock(&info->lock);
 			return ret;
 		}
 
@@ -668,11 +677,11 @@ static int vf610_read_raw(struct iio_dev *indio_dev,
 
 			break;
 		default:
-			mutex_unlock(&indio_dev->mlock);
+			mutex_unlock(&info->lock);
 			return -EINVAL;
 		}
 
-		mutex_unlock(&indio_dev->mlock);
+		mutex_unlock(&info->lock);
 		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_SCALE:
@@ -807,6 +816,9 @@ static int vf610_adc_probe(struct platform_device *pdev)
 	}
 
 	info = iio_priv(indio_dev);
+
+	mutex_init(&info->lock);
+
 	info->dev = &pdev->dev;
 
 	info->regs = devm_platform_ioremap_resource(pdev, 0);
-- 
2.25.1

