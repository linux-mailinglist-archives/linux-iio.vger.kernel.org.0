Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C34FB172078
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2020 15:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731427AbgB0OnQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Feb 2020 09:43:16 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:13400 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731060AbgB0Ntj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Feb 2020 08:49:39 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01RDlLkX008336;
        Thu, 27 Feb 2020 08:49:37 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2ydtrwka5q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Feb 2020 08:49:37 -0500
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 01RDnaUR017473
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 27 Feb 2020 08:49:36 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Thu, 27 Feb
 2020 08:49:35 -0500
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 27 Feb 2020 08:49:35 -0500
Received: from saturn.ad.analog.com ([10.48.65.109])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 01RDnVok027892;
        Thu, 27 Feb 2020 08:49:33 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 3/8] iio: core: drop devm_iio_device_free() API call
Date:   Thu, 27 Feb 2020 15:52:22 +0200
Message-ID: <20200227135227.12433-3-alexandru.ardelean@analog.com>
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
 phishscore=0 adultscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=2 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002270109
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

It's unused so far, so it can't be removed. Also makes sense to remove it
to discourage weird uses of this call during review.

This is the last user of 'devm_iio_device_match()', so it can be removed as
well in this patch.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 .../driver-api/driver-model/devres.rst        |  1 -
 drivers/iio/industrialio-core.c               | 31 -------------------
 include/linux/iio/iio.h                       |  2 --
 3 files changed, 34 deletions(-)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index 1431d5e44abc..6ae6c67dfec0 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -284,7 +284,6 @@ I2C
 
 IIO
   devm_iio_device_alloc()
-  devm_iio_device_free()
   devm_iio_device_register()
   devm_iio_kfifo_allocate()
   devm_iio_kfifo_free()
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index e4011f8431f9..ebe338a0494f 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1539,17 +1539,6 @@ static void devm_iio_device_release(struct device *dev, void *res)
 	iio_device_free(*(struct iio_dev **)res);
 }
 
-int devm_iio_device_match(struct device *dev, void *res, void *data)
-{
-	struct iio_dev **r = res;
-	if (!r || !*r) {
-		WARN_ON(!r || !*r);
-		return 0;
-	}
-	return *r == data;
-}
-EXPORT_SYMBOL_GPL(devm_iio_device_match);
-
 /**
  * devm_iio_device_alloc - Resource-managed iio_device_alloc()
  * @dev:		Device to allocate iio_dev for
@@ -1558,9 +1547,6 @@ EXPORT_SYMBOL_GPL(devm_iio_device_match);
  * Managed iio_device_alloc. iio_dev allocated with this function is
  * automatically freed on driver detach.
  *
- * If an iio_dev allocated with this function needs to be freed separately,
- * devm_iio_device_free() must be used.
- *
  * RETURNS:
  * Pointer to allocated iio_dev on success, NULL on failure.
  */
@@ -1585,23 +1571,6 @@ struct iio_dev *devm_iio_device_alloc(struct device *dev, int sizeof_priv)
 }
 EXPORT_SYMBOL_GPL(devm_iio_device_alloc);
 
-/**
- * devm_iio_device_free - Resource-managed iio_device_free()
- * @dev:		Device this iio_dev belongs to
- * @iio_dev:		the iio_dev associated with the device
- *
- * Free iio_dev allocated with devm_iio_device_alloc().
- */
-void devm_iio_device_free(struct device *dev, struct iio_dev *iio_dev)
-{
-	int rc;
-
-	rc = devres_release(dev, devm_iio_device_release,
-			    devm_iio_device_match, iio_dev);
-	WARN_ON(rc);
-}
-EXPORT_SYMBOL_GPL(devm_iio_device_free);
-
 /**
  * iio_chrdev_open() - chrdev file open for buffer access and ioctls
  * @inode:	Inode structure for identifying the device in the file system
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 0eb9e8d7ec68..2920c065ab9b 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -686,9 +686,7 @@ static inline struct iio_dev *iio_priv_to_dev(void *priv)
 }
 
 void iio_device_free(struct iio_dev *indio_dev);
-int devm_iio_device_match(struct device *dev, void *res, void *data);
 struct iio_dev *devm_iio_device_alloc(struct device *dev, int sizeof_priv);
-void devm_iio_device_free(struct device *dev, struct iio_dev *indio_dev);
 struct iio_trigger *devm_iio_trigger_alloc(struct device *dev,
 						const char *fmt, ...);
 void devm_iio_trigger_free(struct device *dev, struct iio_trigger *iio_trig);
-- 
2.20.1

