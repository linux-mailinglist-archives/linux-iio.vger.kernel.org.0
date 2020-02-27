Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5275172076
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2020 15:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731715AbgB0OnK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Feb 2020 09:43:10 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:14992 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731070AbgB0Ntk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Feb 2020 08:49:40 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01RDj6UT008510;
        Thu, 27 Feb 2020 08:49:39 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2ydtrx39wh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Feb 2020 08:49:39 -0500
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 01RDnbxT017476
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 27 Feb 2020 08:49:38 -0500
Received: from SCSQCASHYB6.ad.analog.com (10.77.17.132) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 27 Feb 2020 05:49:36 -0800
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB6.ad.analog.com (10.77.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 27 Feb 2020 05:49:03 -0800
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 27 Feb 2020 05:49:36 -0800
Received: from saturn.ad.analog.com ([10.48.65.109])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 01RDnVol027892;
        Thu, 27 Feb 2020 08:49:34 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 4/8] iio: core: drop devm_iio_trigger_unregister() API call
Date:   Thu, 27 Feb 2020 15:52:23 +0200
Message-ID: <20200227135227.12433-4-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200227135227.12433-1-alexandru.ardelean@analog.com>
References: <20200227135227.12433-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-27_04:2020-02-26,2020-02-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 phishscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 suspectscore=2 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002270109
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

It's unused so far, so it can't be removed. Also makes sense to remove it
to discourage weird uses of this call during review.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 .../driver-api/driver-model/devres.rst        |  1 -
 Documentation/driver-api/iio/triggers.rst     |  1 -
 drivers/iio/industrialio-trigger.c            | 21 -------------------
 include/linux/iio/trigger.h                   |  3 ---
 4 files changed, 26 deletions(-)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index 6ae6c67dfec0..f638a035e6d2 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -291,7 +291,6 @@ IIO
   devm_iio_trigger_alloc()
   devm_iio_trigger_free()
   devm_iio_trigger_register()
-  devm_iio_trigger_unregister()
   devm_iio_channel_get()
   devm_iio_channel_release()
   devm_iio_channel_get_all()
diff --git a/Documentation/driver-api/iio/triggers.rst b/Documentation/driver-api/iio/triggers.rst
index 5c2156de6284..160faa810d12 100644
--- a/Documentation/driver-api/iio/triggers.rst
+++ b/Documentation/driver-api/iio/triggers.rst
@@ -6,7 +6,6 @@ Triggers
 * :c:func:`devm_iio_trigger_alloc` — Resource-managed iio_trigger_alloc
 * :c:func:`devm_iio_trigger_free` — Resource-managed iio_trigger_free
 * :c:func:`devm_iio_trigger_register` — Resource-managed iio_trigger_register
-* :c:func:`devm_iio_trigger_unregister` — Resource-managed
   iio_trigger_unregister
 * :c:func:`iio_trigger_validate_own_device` — Check if a trigger and IIO
   device belong to the same device
diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index 3908a9a90035..611f608a9da2 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -673,9 +673,6 @@ static void devm_iio_trigger_unreg(struct device *dev, void *res)
  * calls iio_trigger_register() internally. Refer to that function for more
  * information.
  *
- * If an iio_trigger registered with this function needs to be unregistered
- * separately, devm_iio_trigger_unregister() must be used.
- *
  * RETURNS:
  * 0 on success, negative error number on failure.
  */
@@ -701,24 +698,6 @@ int __devm_iio_trigger_register(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(__devm_iio_trigger_register);
 
-/**
- * devm_iio_trigger_unregister - Resource-managed iio_trigger_unregister()
- * @dev:	device this iio_trigger belongs to
- * @trig_info:	the trigger associated with the device
- *
- * Unregister trigger registered with devm_iio_trigger_register().
- */
-void devm_iio_trigger_unregister(struct device *dev,
-				 struct iio_trigger *trig_info)
-{
-	int rc;
-
-	rc = devres_release(dev, devm_iio_trigger_unreg, devm_iio_trigger_match,
-			    trig_info);
-	WARN_ON(rc);
-}
-EXPORT_SYMBOL_GPL(devm_iio_trigger_unregister);
-
 bool iio_trigger_using_own(struct iio_dev *indio_dev)
 {
 	return indio_dev->trig->attached_own_device;
diff --git a/include/linux/iio/trigger.h b/include/linux/iio/trigger.h
index 84995e2967ac..cad8325903f9 100644
--- a/include/linux/iio/trigger.h
+++ b/include/linux/iio/trigger.h
@@ -141,9 +141,6 @@ int __devm_iio_trigger_register(struct device *dev,
  **/
 void iio_trigger_unregister(struct iio_trigger *trig_info);
 
-void devm_iio_trigger_unregister(struct device *dev,
-				 struct iio_trigger *trig_info);
-
 /**
  * iio_trigger_set_immutable() - set an immutable trigger on destination
  *
-- 
2.20.1

