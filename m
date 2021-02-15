Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A548731B775
	for <lists+linux-iio@lfdr.de>; Mon, 15 Feb 2021 11:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbhBOKkn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Feb 2021 05:40:43 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:7678 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230260AbhBOKkR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 Feb 2021 05:40:17 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11FAZkTr028471;
        Mon, 15 Feb 2021 05:39:25 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 36pcjamakh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Feb 2021 05:39:25 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 11FAdNDC008344
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 15 Feb 2021 05:39:23 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.721.2; Mon, 15 Feb 2021
 05:39:23 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 15 Feb 2021 05:39:23 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 11FAcQUo017530;
        Mon, 15 Feb 2021 05:39:19 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v6 21/24] iio: core: rename 'dev' -> 'indio_dev' in iio_device_alloc()
Date:   Mon, 15 Feb 2021 12:40:40 +0200
Message-ID: <20210215104043.91251-22-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210215104043.91251-1-alexandru.ardelean@analog.com>
References: <20210215104043.91251-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-15_03:2021-02-12,2021-02-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 adultscore=0 clxscore=1015 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102150087
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The 'dev' variable name usually refers to 'struct device' types. However in
iio_device_alloc() this was used for the 'struct iio_dev' type, which was
sometimes causing minor confusions.

This change renames the variable to 'indio_dev', which is the usual name
used around IIO for 'struct iio_dev' type objects.
It makes grepping a bit easier as well.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/industrialio-core.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index f7f785431106..bdb55901e97c 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1602,7 +1602,7 @@ struct device_type iio_device_type = {
 struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv)
 {
 	struct iio_dev_opaque *iio_dev_opaque;
-	struct iio_dev *dev;
+	struct iio_dev *indio_dev;
 	size_t alloc_size;
 
 	alloc_size = sizeof(struct iio_dev_opaque);
@@ -1615,31 +1615,31 @@ struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv)
 	if (!iio_dev_opaque)
 		return NULL;
 
-	dev = &iio_dev_opaque->indio_dev;
-	dev->priv = (char *)iio_dev_opaque +
+	indio_dev = &iio_dev_opaque->indio_dev;
+	indio_dev->priv = (char *)iio_dev_opaque +
 		ALIGN(sizeof(struct iio_dev_opaque), IIO_ALIGN);
 
-	dev->dev.parent = parent;
-	dev->dev.type = &iio_device_type;
-	dev->dev.bus = &iio_bus_type;
-	device_initialize(&dev->dev);
-	dev_set_drvdata(&dev->dev, (void *)dev);
-	mutex_init(&dev->mlock);
-	mutex_init(&dev->info_exist_lock);
+	indio_dev->dev.parent = parent;
+	indio_dev->dev.type = &iio_device_type;
+	indio_dev->dev.bus = &iio_bus_type;
+	device_initialize(&indio_dev->dev);
+	dev_set_drvdata(&indio_dev->dev, (void *)indio_dev);
+	mutex_init(&indio_dev->mlock);
+	mutex_init(&indio_dev->info_exist_lock);
 	INIT_LIST_HEAD(&iio_dev_opaque->channel_attr_list);
 
-	dev->id = ida_simple_get(&iio_ida, 0, 0, GFP_KERNEL);
-	if (dev->id < 0) {
+	indio_dev->id = ida_simple_get(&iio_ida, 0, 0, GFP_KERNEL);
+	if (indio_dev->id < 0) {
 		/* cannot use a dev_err as the name isn't available */
 		pr_err("failed to get device id\n");
 		kfree(iio_dev_opaque);
 		return NULL;
 	}
-	dev_set_name(&dev->dev, "iio:device%d", dev->id);
+	dev_set_name(&indio_dev->dev, "iio:device%d", indio_dev->id);
 	INIT_LIST_HEAD(&iio_dev_opaque->buffer_list);
 	INIT_LIST_HEAD(&iio_dev_opaque->ioctl_handlers);
 
-	return dev;
+	return indio_dev;
 }
 EXPORT_SYMBOL(iio_device_alloc);
 
-- 
2.17.1

