Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 269D9172058
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2020 15:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731079AbgB0Ntl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Feb 2020 08:49:41 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:14972 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731069AbgB0Ntk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Feb 2020 08:49:40 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01RDlNZc009483;
        Thu, 27 Feb 2020 08:49:39 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 2ydtrwka5r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Feb 2020 08:49:39 -0500
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 01RDncNl059116
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 27 Feb 2020 08:49:38 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 27 Feb 2020 08:49:37 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 27 Feb 2020 08:49:37 -0500
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 27 Feb 2020 08:49:37 -0500
Received: from saturn.ad.analog.com ([10.48.65.109])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 01RDnVom027892;
        Thu, 27 Feb 2020 08:49:35 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 5/8] iio: core: drop devm_iio_trigger_free() API call
Date:   Thu, 27 Feb 2020 15:52:24 +0200
Message-ID: <20200227135227.12433-5-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200227135227.12433-1-alexandru.ardelean@analog.com>
References: <20200227135227.12433-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
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
 .../driver-api/driver-model/devres.rst        |  1 -
 Documentation/driver-api/iio/triggers.rst     |  1 -
 drivers/iio/industrialio-trigger.c            | 32 -------------------
 include/linux/iio/iio.h                       |  2 --
 4 files changed, 36 deletions(-)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index f638a035e6d2..6c401c74e480 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -289,7 +289,6 @@ IIO
   devm_iio_kfifo_free()
   devm_iio_triggered_buffer_setup()
   devm_iio_trigger_alloc()
-  devm_iio_trigger_free()
   devm_iio_trigger_register()
   devm_iio_channel_get()
   devm_iio_channel_release()
diff --git a/Documentation/driver-api/iio/triggers.rst b/Documentation/driver-api/iio/triggers.rst
index 160faa810d12..dfd7ba3eabde 100644
--- a/Documentation/driver-api/iio/triggers.rst
+++ b/Documentation/driver-api/iio/triggers.rst
@@ -4,7 +4,6 @@ Triggers
 
 * struct :c:type:`iio_trigger` — industrial I/O trigger device
 * :c:func:`devm_iio_trigger_alloc` — Resource-managed iio_trigger_alloc
-* :c:func:`devm_iio_trigger_free` — Resource-managed iio_trigger_free
 * :c:func:`devm_iio_trigger_register` — Resource-managed iio_trigger_register
   iio_trigger_unregister
 * :c:func:`iio_trigger_validate_own_device` — Check if a trigger and IIO
diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index 611f608a9da2..53d1931f6be8 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -585,18 +585,6 @@ static void devm_iio_trigger_release(struct device *dev, void *res)
 	iio_trigger_free(*(struct iio_trigger **)res);
 }
 
-static int devm_iio_trigger_match(struct device *dev, void *res, void *data)
-{
-	struct iio_trigger **r = res;
-
-	if (!r || !*r) {
-		WARN_ON(!r || !*r);
-		return 0;
-	}
-
-	return *r == data;
-}
-
 /**
  * devm_iio_trigger_alloc - Resource-managed iio_trigger_alloc()
  * @dev:		Device to allocate iio_trigger for
@@ -608,9 +596,6 @@ static int devm_iio_trigger_match(struct device *dev, void *res, void *data)
  * Managed iio_trigger_alloc.  iio_trigger allocated with this function is
  * automatically freed on driver detach.
  *
- * If an iio_trigger allocated with this function needs to be freed separately,
- * devm_iio_trigger_free() must be used.
- *
  * RETURNS:
  * Pointer to allocated iio_trigger on success, NULL on failure.
  */
@@ -640,23 +625,6 @@ struct iio_trigger *devm_iio_trigger_alloc(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_iio_trigger_alloc);
 
-/**
- * devm_iio_trigger_free - Resource-managed iio_trigger_free()
- * @dev:		Device this iio_dev belongs to
- * @iio_trig:		the iio_trigger associated with the device
- *
- * Free iio_trigger allocated with devm_iio_trigger_alloc().
- */
-void devm_iio_trigger_free(struct device *dev, struct iio_trigger *iio_trig)
-{
-	int rc;
-
-	rc = devres_release(dev, devm_iio_trigger_release,
-			    devm_iio_trigger_match, iio_trig);
-	WARN_ON(rc);
-}
-EXPORT_SYMBOL_GPL(devm_iio_trigger_free);
-
 static void devm_iio_trigger_unreg(struct device *dev, void *res)
 {
 	iio_trigger_unregister(*(struct iio_trigger **)res);
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 2920c065ab9b..1a5d3d630ec1 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -689,8 +689,6 @@ void iio_device_free(struct iio_dev *indio_dev);
 struct iio_dev *devm_iio_device_alloc(struct device *dev, int sizeof_priv);
 struct iio_trigger *devm_iio_trigger_alloc(struct device *dev,
 						const char *fmt, ...);
-void devm_iio_trigger_free(struct device *dev, struct iio_trigger *iio_trig);
-
 /**
  * iio_buffer_enabled() - helper function to test if the buffer is enabled
  * @indio_dev:		IIO device structure for device
-- 
2.20.1

