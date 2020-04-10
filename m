Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B21C1A4663
	for <lists+linux-iio@lfdr.de>; Fri, 10 Apr 2020 14:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgDJMjN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 10 Apr 2020 08:39:13 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:1892 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726676AbgDJMjN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Apr 2020 08:39:13 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03ACYkIp028747;
        Fri, 10 Apr 2020 08:39:02 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 3091nb13kh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Apr 2020 08:39:02 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 03ACd1pk054943
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 10 Apr 2020 08:39:01 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 10 Apr 2020 08:39:00 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 10 Apr 2020 08:39:00 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 10 Apr 2020 08:39:00 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 03ACcqPQ021764;
        Fri, 10 Apr 2020 08:38:58 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 4/5] iio: buffer: move sysfs alloc/free in industrialio-buffer.c
Date:   Fri, 10 Apr 2020 15:39:47 +0300
Message-ID: <20200410123948.80578-5-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200410123948.80578-1-alexandru.ardelean@analog.com>
References: <20200410123948.80578-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-10_04:2020-04-09,2020-04-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 clxscore=1015 suspectscore=2
 mlxscore=0 phishscore=0 adultscore=0 priorityscore=1501 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004100104
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Since we now have the 'iio_device_buffers_{un}init()' entry-points into the
industrialio-buffer.c we can now move the sysfs alloc & free in there as
part of that init/uninit.

This changes the order of iio_device_register()/iio_device_unregister() a
bit, but overall this shouldn't matter.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/iio_core.h            | 10 ----------
 drivers/iio/industrialio-buffer.c | 29 +++++++++++++++--------------
 drivers/iio/industrialio-core.c   | 14 +-------------
 3 files changed, 16 insertions(+), 37 deletions(-)

diff --git a/drivers/iio/iio_core.h b/drivers/iio/iio_core.h
index 4bdadeac2710..1d69071e1426 100644
--- a/drivers/iio/iio_core.h
+++ b/drivers/iio/iio_core.h
@@ -48,9 +48,6 @@ void iio_device_buffers_uninit(struct iio_dev *indio_dev);
 
 void iio_device_buffers_put(struct iio_dev *indio_dev);
 
-int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev);
-void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev);
-
 void iio_disable_all_buffers(struct iio_dev *indio_dev);
 void iio_buffer_wakeup_poll(struct iio_dev *indio_dev);
 
@@ -66,13 +63,6 @@ static inline void iio_device_buffers_uninit(struct iio_dev *indio_dev) {}
 
 static inline void iio_device_buffers_put(struct iio_dev *indio_dev) {}
 
-static inline int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
-{
-	return 0;
-}
-
-static inline void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev) {}
-
 static inline void iio_disable_all_buffers(struct iio_dev *indio_dev) {}
 static inline void iio_buffer_wakeup_poll(struct iio_dev *indio_dev) {}
 
diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 4b5c3baadaab..8ab089a9c3bc 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1284,11 +1284,11 @@ static struct attribute *iio_buffer_attrs[] = {
 	&dev_attr_data_available.attr,
 };
 
-int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
+static int iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer)
 {
+	struct iio_dev *indio_dev = buffer->indio_dev;
 	struct iio_dev_attr *p;
 	struct attribute **attr;
-	struct iio_buffer *buffer = indio_dev->buffer;
 	int ret, i, attrn, attrcount, attrcount_orig = 0;
 	const struct iio_chan_spec *channels;
 
@@ -1301,9 +1301,6 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
 		indio_dev->masklength = ml;
 	}
 
-	if (!buffer)
-		return 0;
-
 	attrcount = 0;
 	if (buffer->attrs) {
 		while (buffer->attrs[attrcount] != NULL)
@@ -1395,15 +1392,12 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
 	return ret;
 }
 
-void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev)
+static void iio_buffer_free_sysfs_and_mask(struct iio_buffer *buffer)
 {
-	if (!indio_dev->buffer)
-		return;
-
-	bitmap_free(indio_dev->buffer->scan_mask);
-	kfree(indio_dev->buffer->buffer_group.attrs);
-	kfree(indio_dev->buffer->scan_el_group.attrs);
-	iio_free_chan_devattr_list(&indio_dev->buffer->scan_el_dev_attr_list);
+	bitmap_free(buffer->scan_mask);
+	kfree(buffer->buffer_group.attrs);
+	kfree(buffer->scan_el_group.attrs);
+	iio_free_chan_devattr_list(&buffer->scan_el_dev_attr_list);
 }
 
 static const struct file_operations iio_buffer_fileops = {
@@ -1425,13 +1419,19 @@ int iio_device_buffers_init(struct iio_dev *indio_dev, struct module *this_mod)
 	if (!buffer)
 		return -ENOTSUPP;
 
+	ret = iio_buffer_alloc_sysfs_and_mask(buffer);
+	if (ret)
+		return ret;
+
 	cdev_init(&buffer->chrdev, &iio_buffer_fileops);
 
 	buffer->chrdev.owner = this_mod;
 
 	ret = cdev_device_add(&buffer->chrdev, &indio_dev->dev);
-	if (ret)
+	if (ret) {
+		iio_buffer_free_sysfs_and_mask(buffer);
 		return ret;
+	}
 
 	iio_device_get(indio_dev);
 	iio_buffer_get(buffer);
@@ -1457,6 +1457,7 @@ void iio_device_buffers_uninit(struct iio_dev *indio_dev)
 		return;
 
 	cdev_device_del(&buffer->chrdev, &indio_dev->dev);
+	iio_buffer_free_sysfs_and_mask(buffer);
 	iio_buffer_put(buffer);
 	iio_device_put(indio_dev);
 }
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 2158aeab0bd2..794aaa4be832 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1737,18 +1737,11 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
 
 	iio_device_register_debugfs(indio_dev);
 
-	ret = iio_buffer_alloc_sysfs_and_mask(indio_dev);
-	if (ret) {
-		dev_err(indio_dev->dev.parent,
-			"Failed to create buffer sysfs interfaces\n");
-		goto error_unreg_debugfs;
-	}
-
 	ret = iio_device_register_sysfs(indio_dev);
 	if (ret) {
 		dev_err(indio_dev->dev.parent,
 			"Failed to register sysfs interfaces\n");
-		goto error_buffer_free_sysfs;
+		goto error_free_sysfs;
 	}
 	ret = iio_device_register_eventset(indio_dev);
 	if (ret) {
@@ -1785,9 +1778,6 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
 	iio_device_unregister_eventset(indio_dev);
 error_free_sysfs:
 	iio_device_unregister_sysfs(indio_dev);
-error_buffer_free_sysfs:
-	iio_buffer_free_sysfs_and_mask(indio_dev);
-error_unreg_debugfs:
 	iio_device_unregister_debugfs(indio_dev);
 	return ret;
 }
@@ -1818,8 +1808,6 @@ void iio_device_unregister(struct iio_dev *indio_dev)
 	iio_buffer_wakeup_poll(indio_dev);
 
 	mutex_unlock(&indio_dev->info_exist_lock);
-
-	iio_buffer_free_sysfs_and_mask(indio_dev);
 }
 EXPORT_SYMBOL(iio_device_unregister);
 
-- 
2.17.1

