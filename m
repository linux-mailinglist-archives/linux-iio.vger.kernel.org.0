Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2744F17206E
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2020 15:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731111AbgB0Omw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Feb 2020 09:42:52 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:21242 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730678AbgB0Ntq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Feb 2020 08:49:46 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01RDlDgK003925;
        Thu, 27 Feb 2020 08:49:45 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2ydtrwka63-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Feb 2020 08:49:44 -0500
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 01RDnhdM017499
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 27 Feb 2020 08:49:43 -0500
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Thu, 27 Feb
 2020 05:49:41 -0800
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 27 Feb 2020 05:49:41 -0800
Received: from saturn.ad.analog.com ([10.48.65.109])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 01RDnVop027892;
        Thu, 27 Feb 2020 08:49:39 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 8/8] iio: buffer: drop devm_iio_kfifo_free() API call
Date:   Thu, 27 Feb 2020 15:52:27 +0200
Message-ID: <20200227135227.12433-8-alexandru.ardelean@analog.com>
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

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 .../driver-api/driver-model/devres.rst        |  1 -
 drivers/iio/buffer/kfifo_buf.c                | 22 -------------------
 include/linux/iio/kfifo_buf.h                 |  1 -
 3 files changed, 24 deletions(-)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index 10ccebe9f7c1..91b0b8e5556c 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -286,7 +286,6 @@ IIO
   devm_iio_device_alloc()
   devm_iio_device_register()
   devm_iio_kfifo_allocate()
-  devm_iio_kfifo_free()
   devm_iio_triggered_buffer_setup()
   devm_iio_trigger_alloc()
   devm_iio_trigger_register()
diff --git a/drivers/iio/buffer/kfifo_buf.c b/drivers/iio/buffer/kfifo_buf.c
index 3150f8ab984b..1359abed3b31 100644
--- a/drivers/iio/buffer/kfifo_buf.c
+++ b/drivers/iio/buffer/kfifo_buf.c
@@ -179,16 +179,6 @@ static void devm_iio_kfifo_release(struct device *dev, void *res)
 	iio_kfifo_free(*(struct iio_buffer **)res);
 }
 
-static int devm_iio_kfifo_match(struct device *dev, void *res, void *data)
-{
-	struct iio_buffer **r = res;
-
-	if (WARN_ON(!r || !*r))
-		return 0;
-
-	return *r == data;
-}
-
 /**
  * devm_iio_fifo_allocate - Resource-managed iio_kfifo_allocate()
  * @dev:		Device to allocate kfifo buffer for
@@ -216,16 +206,4 @@ struct iio_buffer *devm_iio_kfifo_allocate(struct device *dev)
 }
 EXPORT_SYMBOL(devm_iio_kfifo_allocate);
 
-/**
- * devm_iio_fifo_free - Resource-managed iio_kfifo_free()
- * @dev:		Device the buffer belongs to
- * @r:			The buffer associated with the device
- */
-void devm_iio_kfifo_free(struct device *dev, struct iio_buffer *r)
-{
-	WARN_ON(devres_release(dev, devm_iio_kfifo_release,
-			       devm_iio_kfifo_match, r));
-}
-EXPORT_SYMBOL(devm_iio_kfifo_free);
-
 MODULE_LICENSE("GPL");
diff --git a/include/linux/iio/kfifo_buf.h b/include/linux/iio/kfifo_buf.h
index 764659e01b68..1fc1efa7799d 100644
--- a/include/linux/iio/kfifo_buf.h
+++ b/include/linux/iio/kfifo_buf.h
@@ -9,6 +9,5 @@ struct iio_buffer *iio_kfifo_allocate(void);
 void iio_kfifo_free(struct iio_buffer *r);
 
 struct iio_buffer *devm_iio_kfifo_allocate(struct device *dev);
-void devm_iio_kfifo_free(struct device *dev, struct iio_buffer *r);
 
 #endif
-- 
2.20.1

