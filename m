Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 044C4172072
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2020 15:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731280AbgB0OnB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Feb 2020 09:43:01 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:20122 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731091AbgB0Ntp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Feb 2020 08:49:45 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01RDlLkY008336;
        Thu, 27 Feb 2020 08:49:43 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2ydtrwka60-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Feb 2020 08:49:42 -0500
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 01RDnfB3017488
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 27 Feb 2020 08:49:41 -0500
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 27 Feb 2020 05:49:40 -0800
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 27 Feb 2020 05:49:40 -0800
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 27 Feb 2020 05:49:39 -0800
Received: from saturn.ad.analog.com ([10.48.65.109])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 01RDnVoo027892;
        Thu, 27 Feb 2020 08:49:38 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 7/8] iio: buffer: drop devm_iio_hw_consumer_free() API call
Date:   Thu, 27 Feb 2020 15:52:26 +0200
Message-ID: <20200227135227.12433-7-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200227135227.12433-1-alexandru.ardelean@analog.com>
References: <20200227135227.12433-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-27_04:2020-02-26,2020-02-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 phishscore=0 adultscore=0 spamscore=0 mlxscore=0 mlxlogscore=991
 suspectscore=2 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002270109
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

It's unused so far, so it can't be removed. Also makes sense to remove it
to discourage weird uses of this call during review.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/buffer/industrialio-hw-consumer.c | 31 -------------------
 include/linux/iio/hw-consumer.h               |  1 -
 2 files changed, 32 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-hw-consumer.c b/drivers/iio/buffer/industrialio-hw-consumer.c
index 95165697d8ae..f2d27788f666 100644
--- a/drivers/iio/buffer/industrialio-hw-consumer.c
+++ b/drivers/iio/buffer/industrialio-hw-consumer.c
@@ -142,17 +142,6 @@ static void devm_iio_hw_consumer_release(struct device *dev, void *res)
 	iio_hw_consumer_free(*(struct iio_hw_consumer **)res);
 }
 
-static int devm_iio_hw_consumer_match(struct device *dev, void *res, void *data)
-{
-	struct iio_hw_consumer **r = res;
-
-	if (!r || !*r) {
-		WARN_ON(!r || !*r);
-		return 0;
-	}
-	return *r == data;
-}
-
 /**
  * devm_iio_hw_consumer_alloc - Resource-managed iio_hw_consumer_alloc()
  * @dev: Pointer to consumer device.
@@ -160,9 +149,6 @@ static int devm_iio_hw_consumer_match(struct device *dev, void *res, void *data)
  * Managed iio_hw_consumer_alloc. iio_hw_consumer allocated with this function
  * is automatically freed on driver detach.
  *
- * If an iio_hw_consumer allocated with this function needs to be freed
- * separately, devm_iio_hw_consumer_free() must be used.
- *
  * returns pointer to allocated iio_hw_consumer on success, NULL on failure.
  */
 struct iio_hw_consumer *devm_iio_hw_consumer_alloc(struct device *dev)
@@ -186,23 +172,6 @@ struct iio_hw_consumer *devm_iio_hw_consumer_alloc(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(devm_iio_hw_consumer_alloc);
 
-/**
- * devm_iio_hw_consumer_free - Resource-managed iio_hw_consumer_free()
- * @dev: Pointer to consumer device.
- * @hwc: iio_hw_consumer to free.
- *
- * Free iio_hw_consumer allocated with devm_iio_hw_consumer_alloc().
- */
-void devm_iio_hw_consumer_free(struct device *dev, struct iio_hw_consumer *hwc)
-{
-	int rc;
-
-	rc = devres_release(dev, devm_iio_hw_consumer_release,
-			    devm_iio_hw_consumer_match, hwc);
-	WARN_ON(rc);
-}
-EXPORT_SYMBOL_GPL(devm_iio_hw_consumer_free);
-
 /**
  * iio_hw_consumer_enable() - Enable IIO hardware consumer
  * @hwc: iio_hw_consumer to enable.
diff --git a/include/linux/iio/hw-consumer.h b/include/linux/iio/hw-consumer.h
index 44d48bb1d39f..e8255c2e33bc 100644
--- a/include/linux/iio/hw-consumer.h
+++ b/include/linux/iio/hw-consumer.h
@@ -14,7 +14,6 @@ struct iio_hw_consumer;
 struct iio_hw_consumer *iio_hw_consumer_alloc(struct device *dev);
 void iio_hw_consumer_free(struct iio_hw_consumer *hwc);
 struct iio_hw_consumer *devm_iio_hw_consumer_alloc(struct device *dev);
-void devm_iio_hw_consumer_free(struct device *dev, struct iio_hw_consumer *hwc);
 int iio_hw_consumer_enable(struct iio_hw_consumer *hwc);
 void iio_hw_consumer_disable(struct iio_hw_consumer *hwc);
 
-- 
2.20.1

