Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A22631B0C5
	for <lists+linux-iio@lfdr.de>; Sun, 14 Feb 2021 15:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhBNOcL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Feb 2021 09:32:11 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:20836 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229759AbhBNOcI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 Feb 2021 09:32:08 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11EESDCu017114;
        Sun, 14 Feb 2021 09:31:17 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 36pcjaj8da-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 14 Feb 2021 09:31:17 -0500
Received: from SCSQMBX11.ad.analog.com (SCSQMBX11.ad.analog.com [10.77.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 11EEVFW5054478
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Sun, 14 Feb 2021 09:31:15 -0500
Received: from SCSQCASHYB6.ad.analog.com (10.77.17.132) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Sun, 14 Feb 2021 06:31:14 -0800
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB6.ad.analog.com (10.77.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.721.2;
 Sun, 14 Feb 2021 06:31:14 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Sun, 14 Feb 2021 06:31:13 -0800
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 11EEV2tu027551;
        Sun, 14 Feb 2021 09:31:10 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 5/5] iio: kfifo: un-export devm_iio_kfifo_allocate() function
Date:   Sun, 14 Feb 2021 16:33:13 +0200
Message-ID: <20210214143313.67202-6-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210214143313.67202-1-alexandru.ardelean@analog.com>
References: <20210214143313.67202-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-14_04:2021-02-12,2021-02-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 adultscore=0 clxscore=1015 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102140120
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

At this point all drivers should use devm_iio_kfifo_buffer_setup() instead
of manually allocating via devm_iio_kfifo_allocate() and assigning ops and
modes.

With this change, the devm_iio_kfifo_allocate() will be made private to the
IIO core, since all drivers should call either
devm_iio_kfifo_buffer_setup() or devm_iio_triggered_buffer_setup() to
create a kfifo buffer.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 Documentation/driver-api/driver-model/devres.rst | 1 -
 drivers/iio/buffer/kfifo_buf.c                   | 3 +--
 include/linux/iio/kfifo_buf.h                    | 2 --
 3 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index 562f5722281e..4b15b3e9358b 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -285,7 +285,6 @@ I2C
 IIO
   devm_iio_device_alloc()
   devm_iio_device_register()
-  devm_iio_kfifo_allocate()
   devm_iio_kfifo_buffer_setup()
   devm_iio_triggered_buffer_setup()
   devm_iio_trigger_alloc()
diff --git a/drivers/iio/buffer/kfifo_buf.c b/drivers/iio/buffer/kfifo_buf.c
index 6472c9fa1937..c35a625280b1 100644
--- a/drivers/iio/buffer/kfifo_buf.c
+++ b/drivers/iio/buffer/kfifo_buf.c
@@ -186,7 +186,7 @@ static void devm_iio_kfifo_release(struct device *dev, void *res)
  * RETURNS:
  * Pointer to allocated iio_buffer on success, NULL on failure.
  */
-struct iio_buffer *devm_iio_kfifo_allocate(struct device *dev)
+static struct iio_buffer *devm_iio_kfifo_allocate(struct device *dev)
 {
 	struct iio_buffer **ptr, *r;
 
@@ -204,7 +204,6 @@ struct iio_buffer *devm_iio_kfifo_allocate(struct device *dev)
 
 	return r;
 }
-EXPORT_SYMBOL(devm_iio_kfifo_allocate);
 
 /**
  * devm_iio_kfifo_buffer_setup - Allocate a kfifo buffer & attach it to an IIO device
diff --git a/include/linux/iio/kfifo_buf.h b/include/linux/iio/kfifo_buf.h
index 92c411b9ac26..1522896e1daf 100644
--- a/include/linux/iio/kfifo_buf.h
+++ b/include/linux/iio/kfifo_buf.h
@@ -10,8 +10,6 @@ struct device;
 struct iio_buffer *iio_kfifo_allocate(void);
 void iio_kfifo_free(struct iio_buffer *r);
 
-struct iio_buffer *devm_iio_kfifo_allocate(struct device *dev);
-
 int devm_iio_kfifo_buffer_setup(struct device *dev,
 				struct iio_dev *indio_dev,
 				int mode_flags,
-- 
2.17.1

