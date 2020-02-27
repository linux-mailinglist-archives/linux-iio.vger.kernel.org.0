Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89B4C172080
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2020 15:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731065AbgB0Nti (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Feb 2020 08:49:38 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:11858 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731058AbgB0Nti (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Feb 2020 08:49:38 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01RDlNvm009712;
        Thu, 27 Feb 2020 08:49:36 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2ydtrwka5m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Feb 2020 08:49:36 -0500
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 01RDnYPK017467
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 27 Feb 2020 08:49:34 -0500
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Thu, 27 Feb
 2020 05:49:33 -0800
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 27 Feb 2020 05:49:33 -0800
Received: from saturn.ad.analog.com ([10.48.65.109])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 01RDnVoi027892;
        Thu, 27 Feb 2020 08:49:31 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 1/8] iio: core: drop devm_iio_device_unregister() API call
Date:   Thu, 27 Feb 2020 15:52:20 +0200
Message-ID: <20200227135227.12433-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
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

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 .../driver-api/driver-model/devres.rst          |  1 -
 drivers/iio/industrialio-core.c                 | 17 -----------------
 include/linux/iio/iio.h                         |  4 ----
 3 files changed, 22 deletions(-)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index 46c13780994c..0580c64ebdfd 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -286,7 +286,6 @@ IIO
   devm_iio_device_alloc()
   devm_iio_device_free()
   devm_iio_device_register()
-  devm_iio_device_unregister()
   devm_iio_kfifo_allocate()
   devm_iio_kfifo_free()
   devm_iio_triggered_buffer_setup()
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 0b14666dff09..e4011f8431f9 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1823,23 +1823,6 @@ int __devm_iio_device_register(struct device *dev, struct iio_dev *indio_dev,
 }
 EXPORT_SYMBOL_GPL(__devm_iio_device_register);
 
-/**
- * devm_iio_device_unregister - Resource-managed iio_device_unregister()
- * @dev:	Device this iio_dev belongs to
- * @indio_dev:	the iio_dev associated with the device
- *
- * Unregister iio_dev registered with devm_iio_device_register().
- */
-void devm_iio_device_unregister(struct device *dev, struct iio_dev *indio_dev)
-{
-	int rc;
-
-	rc = devres_release(dev, devm_iio_device_unreg,
-			    devm_iio_device_match, indio_dev);
-	WARN_ON(rc);
-}
-EXPORT_SYMBOL_GPL(devm_iio_device_unregister);
-
 /**
  * iio_device_claim_direct_mode - Keep device in direct mode
  * @indio_dev:	the iio_dev associated with the device
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 862ce0019eba..0eb9e8d7ec68 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -591,9 +591,6 @@ void iio_device_unregister(struct iio_dev *indio_dev);
  * calls iio_device_register() internally. Refer to that function for more
  * information.
  *
- * If an iio_dev registered with this function needs to be unregistered
- * separately, devm_iio_device_unregister() must be used.
- *
  * RETURNS:
  * 0 on success, negative error number on failure.
  */
@@ -601,7 +598,6 @@ void iio_device_unregister(struct iio_dev *indio_dev);
 	__devm_iio_device_register((dev), (indio_dev), THIS_MODULE);
 int __devm_iio_device_register(struct device *dev, struct iio_dev *indio_dev,
 			       struct module *this_mod);
-void devm_iio_device_unregister(struct device *dev, struct iio_dev *indio_dev);
 int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp);
 int iio_device_claim_direct_mode(struct iio_dev *indio_dev);
 void iio_device_release_direct_mode(struct iio_dev *indio_dev);
-- 
2.20.1

