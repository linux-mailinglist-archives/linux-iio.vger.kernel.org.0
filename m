Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F06B61AC14B
	for <lists+linux-iio@lfdr.de>; Thu, 16 Apr 2020 14:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635650AbgDPMdB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Apr 2020 08:33:01 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:44444 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2635625AbgDPMc4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Apr 2020 08:32:56 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03GCIhFB001327;
        Thu, 16 Apr 2020 08:32:54 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 30dn9adkdp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Apr 2020 08:32:54 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 03GCWqfi024890
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 16 Apr 2020 08:32:53 -0400
Received: from SCSQCASHYB6.ad.analog.com (10.77.17.132) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 16 Apr 2020 05:32:51 -0700
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by
 SCSQCASHYB6.ad.analog.com (10.77.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 16 Apr 2020 05:32:44 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 16 Apr 2020 05:32:50 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 03GCWnWI007655;
        Thu, 16 Apr 2020 08:32:49 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: core: fail early in iio_device_alloc() if we can't get a device id
Date:   Thu, 16 Apr 2020 15:33:31 +0300
Message-ID: <20200416123331.68790-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-16_03:2020-04-14,2020-04-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015
 mlxscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004160088
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change moves the 'ida_simple_get()' call to be the first one in
iio_device_alloc(). It cleans up the error path a bit as we don't need to
call any kfree(dev) anymore. We allocate an IIO device only if we have
managed to obtain a device ID.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/industrialio-core.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index f4daf19f2a3b..7c1d8a3ab2f3 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1494,6 +1494,14 @@ struct iio_dev *iio_device_alloc(int sizeof_priv)
 {
 	struct iio_dev *dev;
 	size_t alloc_size;
+	int id;
+
+	id = ida_simple_get(&iio_ida, 0, 0, GFP_KERNEL);
+	if (id < 0) {
+		/* cannot use a dev_err as the name isn't available */
+		pr_err("failed to get device id\n");
+		return NULL;
+	}
 
 	alloc_size = sizeof(struct iio_dev);
 	if (sizeof_priv) {
@@ -1506,6 +1514,8 @@ struct iio_dev *iio_device_alloc(int sizeof_priv)
 	dev = kzalloc(alloc_size, GFP_KERNEL);
 
 	if (dev) {
+		dev->id = id;
+		dev_set_name(&dev->dev, "iio:device%d", dev->id);
 		dev->dev.groups = dev->groups;
 		dev->dev.type = &iio_device_type;
 		dev->dev.bus = &iio_bus_type;
@@ -1514,15 +1524,6 @@ struct iio_dev *iio_device_alloc(int sizeof_priv)
 		mutex_init(&dev->mlock);
 		mutex_init(&dev->info_exist_lock);
 		INIT_LIST_HEAD(&dev->channel_attr_list);
-
-		dev->id = ida_simple_get(&iio_ida, 0, 0, GFP_KERNEL);
-		if (dev->id < 0) {
-			/* cannot use a dev_err as the name isn't available */
-			pr_err("failed to get device id\n");
-			kfree(dev);
-			return NULL;
-		}
-		dev_set_name(&dev->dev, "iio:device%d", dev->id);
 		INIT_LIST_HEAD(&dev->buffer_list);
 	}
 
-- 
2.17.1

