Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3271B6CD5
	for <lists+linux-iio@lfdr.de>; Fri, 24 Apr 2020 06:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbgDXE4k (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 Apr 2020 00:56:40 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:38278 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725823AbgDXE4k (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Apr 2020 00:56:40 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03O4qul1024418;
        Fri, 24 Apr 2020 00:56:24 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-00128a01.pphosted.com with ESMTP id 30fxf6csfu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Apr 2020 00:56:24 -0400
Received: from m0167089.ppops.net (m0167089.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03O4tF9c030227;
        Fri, 24 Apr 2020 00:56:24 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 30fxf6csfq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Apr 2020 00:56:24 -0400
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 03O4uNfR047659
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 24 Apr 2020 00:56:23 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 24 Apr 2020 00:56:22 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 24 Apr 2020 00:56:21 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 24 Apr 2020 00:56:21 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 03O4uGpk017534;
        Fri, 24 Apr 2020 00:56:18 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <lars@metafoo.de>, <jic23@kernel.org>, <pmeerw@pmeerw.net>,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v4 1/7] iio: Use an early return in iio_device_alloc to simplify code.
Date:   Fri, 24 Apr 2020 07:56:36 +0300
Message-ID: <20200424045642.4903-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200424045642.4903-1-alexandru.ardelean@analog.com>
References: <20200424045642.4903-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-24_01:2020-04-23,2020-04-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 clxscore=1015 mlxscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004240035
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Noticed whilst reviewing Alexandru's patch to the same function.
If we simply flip the logic and return NULL immediately after memory
allocation failure we reduce the indent of the following block and
end up with more 'idiomatic' kernel code.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Alexandru Ardelean <alexandru.ardelean@analog.com>
Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/industrialio-core.c | 46 ++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index f4daf19f2a3b..3c97090c2ab9 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1492,7 +1492,7 @@ struct device_type iio_device_type = {
  **/
 struct iio_dev *iio_device_alloc(int sizeof_priv)
 {
-	struct iio_dev *dev;
+	struct iio_dev *indio_dev;
 	size_t alloc_size;
 
 	alloc_size = sizeof(struct iio_dev);
@@ -1503,30 +1503,30 @@ struct iio_dev *iio_device_alloc(int sizeof_priv)
 	/* ensure 32-byte alignment of whole construct ? */
 	alloc_size += IIO_ALIGN - 1;
 
-	dev = kzalloc(alloc_size, GFP_KERNEL);
-
-	if (dev) {
-		dev->dev.groups = dev->groups;
-		dev->dev.type = &iio_device_type;
-		dev->dev.bus = &iio_bus_type;
-		device_initialize(&dev->dev);
-		dev_set_drvdata(&dev->dev, (void *)dev);
-		mutex_init(&dev->mlock);
-		mutex_init(&dev->info_exist_lock);
-		INIT_LIST_HEAD(&dev->channel_attr_list);
-
-		dev->id = ida_simple_get(&iio_ida, 0, 0, GFP_KERNEL);
-		if (dev->id < 0) {
-			/* cannot use a dev_err as the name isn't available */
-			pr_err("failed to get device id\n");
-			kfree(dev);
-			return NULL;
-		}
-		dev_set_name(&dev->dev, "iio:device%d", dev->id);
-		INIT_LIST_HEAD(&dev->buffer_list);
+	indio_dev = kzalloc(alloc_size, GFP_KERNEL);
+	if (!indio_dev)
+		return NULL;
+
+	indio_dev->id = ida_simple_get(&iio_ida, 0, 0, GFP_KERNEL);
+	if (indio_dev->id < 0) {
+		/* cannot use a dev_err as the name isn't available */
+		pr_err("failed to get device id\n");
+		kfree(indio_dev);
+		return NULL;
 	}
 
-	return dev;
+	dev_set_name(&indio_dev->dev, "iio:device%d", indio_dev->id);
+	indio_dev->dev.groups = indio_dev->groups;
+	indio_dev->dev.type = &iio_device_type;
+	indio_dev->dev.bus = &iio_bus_type;
+	device_initialize(&indio_dev->dev);
+	dev_set_drvdata(&indio_dev->dev, (void *)indio_dev);
+	mutex_init(&indio_dev->mlock);
+	mutex_init(&indio_dev->info_exist_lock);
+	INIT_LIST_HEAD(&indio_dev->channel_attr_list);
+	INIT_LIST_HEAD(&indio_dev->buffer_list);
+
+	return indio_dev;
 }
 EXPORT_SYMBOL(iio_device_alloc);
 
-- 
2.17.1

