Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34BEA172056
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2020 15:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730805AbgB0Ntj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Feb 2020 08:49:39 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:13680 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731062AbgB0Ntj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Feb 2020 08:49:39 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01RDj80V008513;
        Thu, 27 Feb 2020 08:49:38 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 2ydtrx39we-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Feb 2020 08:49:38 -0500
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 01RDnaAI059113
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 27 Feb 2020 08:49:36 -0500
Received: from SCSQCASHYB6.ad.analog.com (10.77.17.132) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 27 Feb 2020 05:49:35 -0800
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB6.ad.analog.com (10.77.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 27 Feb 2020 05:49:01 -0800
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 27 Feb 2020 05:49:34 -0800
Received: from saturn.ad.analog.com ([10.48.65.109])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 01RDnVoj027892;
        Thu, 27 Feb 2020 08:49:32 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 2/8] iio: core: drop devm_iio_triggered_buffer_cleanup() API call
Date:   Thu, 27 Feb 2020 15:52:21 +0200
Message-ID: <20200227135227.12433-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200227135227.12433-1-alexandru.ardelean@analog.com>
References: <20200227135227.12433-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
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
 Documentation/driver-api/driver-model/devres.rst   |  1 -
 drivers/iio/buffer/industrialio-triggered-buffer.c | 11 -----------
 include/linux/iio/triggered_buffer.h               |  2 --
 3 files changed, 14 deletions(-)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index 0580c64ebdfd..1431d5e44abc 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -289,7 +289,6 @@ IIO
   devm_iio_kfifo_allocate()
   devm_iio_kfifo_free()
   devm_iio_triggered_buffer_setup()
-  devm_iio_triggered_buffer_cleanup()
   devm_iio_trigger_alloc()
   devm_iio_trigger_free()
   devm_iio_trigger_register()
diff --git a/drivers/iio/buffer/industrialio-triggered-buffer.c b/drivers/iio/buffer/industrialio-triggered-buffer.c
index cb322b2f09cd..e8046c1ecd6b 100644
--- a/drivers/iio/buffer/industrialio-triggered-buffer.c
+++ b/drivers/iio/buffer/industrialio-triggered-buffer.c
@@ -126,17 +126,6 @@ int devm_iio_triggered_buffer_setup(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_iio_triggered_buffer_setup);
 
-void devm_iio_triggered_buffer_cleanup(struct device *dev,
-				       struct iio_dev *indio_dev)
-{
-	int rc;
-
-	rc = devres_release(dev, devm_iio_triggered_buffer_clean,
-			    devm_iio_device_match, indio_dev);
-	WARN_ON(rc);
-}
-EXPORT_SYMBOL_GPL(devm_iio_triggered_buffer_cleanup);
-
 MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
 MODULE_DESCRIPTION("IIO helper functions for setting up triggered buffers");
 MODULE_LICENSE("GPL");
diff --git a/include/linux/iio/triggered_buffer.h b/include/linux/iio/triggered_buffer.h
index 238ad30ce166..e99c91799359 100644
--- a/include/linux/iio/triggered_buffer.h
+++ b/include/linux/iio/triggered_buffer.h
@@ -18,7 +18,5 @@ int devm_iio_triggered_buffer_setup(struct device *dev,
 				    irqreturn_t (*h)(int irq, void *p),
 				    irqreturn_t (*thread)(int irq, void *p),
 				    const struct iio_buffer_setup_ops *ops);
-void devm_iio_triggered_buffer_cleanup(struct device *dev,
-				       struct iio_dev *indio_dev);
 
 #endif
-- 
2.20.1

