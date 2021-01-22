Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A802A3009BE
	for <lists+linux-iio@lfdr.de>; Fri, 22 Jan 2021 18:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729571AbhAVR2J (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 Jan 2021 12:28:09 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:19972 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729176AbhAVP4U (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 Jan 2021 10:56:20 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10MFU0BW004515;
        Fri, 22 Jan 2021 10:55:27 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 3668rcjhwu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jan 2021 10:55:27 -0500
Received: from SCSQMBX11.ad.analog.com (SCSQMBX11.ad.analog.com [10.77.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 10MFtP1c002556
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 22 Jan 2021 10:55:25 -0500
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 22 Jan 2021 07:55:24 -0800
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Fri, 22 Jan 2021 07:55:24 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by scsqmbx10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.2.721.2 via Frontend Transport;
 Fri, 22 Jan 2021 07:55:23 -0800
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 10MFtF57014933;
        Fri, 22 Jan 2021 10:55:21 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 04/12] iio: buffer: add index to the first IIO buffer dir and symlink it back
Date:   Fri, 22 Jan 2021 17:57:57 +0200
Message-ID: <20210122155805.83012-5-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210122155805.83012-1-alexandru.ardelean@analog.com>
References: <20210122155805.83012-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-22_11:2021-01-22,2021-01-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 clxscore=1015 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101220087
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change makes it so that the first buffer directory is named 'buffer0'
and moves the 'scan_elements' under it.

For backwards compatibility these folders are symlinked back to the
original folders.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/industrialio-buffer.c | 66 +++++++++++++++++++++----------
 1 file changed, 46 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 0f470d902790..628d78125126 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1369,7 +1369,8 @@ static void iio_sysfs_del_attrs(struct kobject *kobj, struct attribute **ptr)
  * IIO device.
  */
 static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
-					     struct iio_dev *indio_dev)
+					     struct iio_dev *indio_dev,
+					     unsigned int idx)
 {
 	struct iio_dev_attr *p;
 	struct attribute **attr;
@@ -1401,7 +1402,7 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
 	buffer->buffer_attrs = attr;
 
 	ret = kobject_init_and_add(&buffer->buffer_dir, &iio_buffer_dir_ktype,
-				   &indio_dev->dev.kobj, "buffer");
+				   &indio_dev->dev.kobj, "buffer%u", idx);
 	if (ret)
 		goto error_buffer_free_attrs;
 
@@ -1446,7 +1447,7 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
 	}
 
 	ret = kobject_init_and_add(&buffer->scan_el_dir, &iio_scan_el_dir_ktype,
-				   &indio_dev->dev.kobj, "scan_elements");
+				   &buffer->buffer_dir, "scan_elements");
 	if (ret)
 		goto error_free_scan_attrs;
 
@@ -1477,6 +1478,22 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
 	return ret;
 }
 
+/**
+ * __iio_buffer_free_sysfs_and_mask() - Free sysfs objects for a single IIO buffer
+ * @buffer: the iio buffer for which to destroy the objects
+ */
+static void __iio_buffer_free_sysfs_and_mask(struct iio_buffer *buffer)
+{
+	iio_sysfs_del_attrs(&buffer->scan_el_dir, buffer->scan_el_attrs);
+	kobject_put(&buffer->scan_el_dir);
+	kfree(buffer->scan_el_attrs);
+	bitmap_free(buffer->scan_mask);
+	iio_sysfs_del_attrs(&buffer->buffer_dir, buffer->buffer_attrs);
+	iio_free_chan_devattr_list(&buffer->scan_el_dev_attr_list);
+	kobject_put(&buffer->buffer_dir);
+	kfree(buffer->buffer_attrs);
+}
+
 /**
  * iio_buffer_alloc_sysfs_and_mask() - Allocate sysfs attributes to attached buffers
  * @indio_dev: the iio device for which to create the buffer sysfs attributes
@@ -1492,7 +1509,7 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
 {
 	struct iio_buffer *buffer = indio_dev->buffer;
 	const struct iio_chan_spec *channels;
-	int i;
+	int i, ret;
 
 	channels = indio_dev->channels;
 	if (channels) {
@@ -1506,23 +1523,29 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
 	if (!buffer)
 		return 0;
 
-	return __iio_buffer_alloc_sysfs_and_mask(buffer, indio_dev);
-}
+	ret = __iio_buffer_alloc_sysfs_and_mask(buffer, indio_dev, 0);
+	if (ret)
+		return ret;
 
-/**
- * __iio_buffer_free_sysfs_and_mask() - Free sysfs objects for a single IIO buffer
- * @buffer: the iio buffer for which to destroy the objects
- */
-static void __iio_buffer_free_sysfs_and_mask(struct iio_buffer *buffer)
-{
-	iio_sysfs_del_attrs(&buffer->scan_el_dir, buffer->scan_el_attrs);
-	kobject_put(&buffer->scan_el_dir);
-	kfree(buffer->scan_el_attrs);
-	bitmap_free(buffer->scan_mask);
-	iio_sysfs_del_attrs(&buffer->buffer_dir, buffer->buffer_attrs);
-	iio_free_chan_devattr_list(&buffer->scan_el_dev_attr_list);
-	kobject_put(&buffer->buffer_dir);
-	kfree(buffer->buffer_attrs);
+	ret = sysfs_create_link(&indio_dev->dev.kobj,
+				&indio_dev->buffer->buffer_dir,
+				"buffer");
+	if (ret)
+		goto error_free_sysfs_and_mask;
+
+	ret = sysfs_create_link(&indio_dev->dev.kobj,
+				&indio_dev->buffer->scan_el_dir,
+				"scan_elements");
+	if (ret)
+		goto error_remove_buffer_dir_link;
+
+	return 0;
+
+error_remove_buffer_dir_link:
+	sysfs_remove_link(&indio_dev->dev.kobj, "buffer");
+error_free_sysfs_and_mask:
+	__iio_buffer_free_sysfs_and_mask(buffer);
+	return ret;
 }
 
 /**
@@ -1538,6 +1561,9 @@ void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev)
 	if (!buffer)
 		return;
 
+	sysfs_remove_link(&indio_dev->dev.kobj, "scan_elements");
+	sysfs_remove_link(&indio_dev->dev.kobj, "buffer");
+
 	__iio_buffer_free_sysfs_and_mask(buffer);
 }
 
-- 
2.17.1

