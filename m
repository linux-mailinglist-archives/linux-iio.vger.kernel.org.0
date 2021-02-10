Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06CAE316359
	for <lists+linux-iio@lfdr.de>; Wed, 10 Feb 2021 11:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbhBJKKL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 10 Feb 2021 05:10:11 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:47802 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230380AbhBJKHK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 10 Feb 2021 05:07:10 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11AA2cxp017577;
        Wed, 10 Feb 2021 05:06:17 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 36hr7qc5x2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Feb 2021 05:06:17 -0500
Received: from SCSQMBX10.ad.analog.com (SCSQMBX10.ad.analog.com [10.77.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 11AA6FWX025905
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 Feb 2021 05:06:16 -0500
Received: from SCSQCASHYB6.ad.analog.com (10.77.17.132) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Wed, 10 Feb 2021 02:06:14 -0800
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB6.ad.analog.com (10.77.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.721.2;
 Wed, 10 Feb 2021 02:06:14 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 10 Feb 2021 02:06:14 -0800
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 11AA5x0C018045;
        Wed, 10 Feb 2021 05:06:11 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>, <rafael@kernel.org>,
        <gregkh@linuxfoundation.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v4 06/17] iio: core: merge buffer/ & scan_elements/ attributes
Date:   Wed, 10 Feb 2021 12:08:12 +0200
Message-ID: <20210210100823.46780-7-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210210100823.46780-1-alexandru.ardelean@analog.com>
References: <20210210100823.46780-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-10_03:2021-02-10,2021-02-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102100097
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

With this change, we create a new directory for the IIO device called
buffer0, under which both the old buffer/ and scan_elements/ are stored.

This is done to simplify the addition of multiple IIO buffers per IIO
device. Otherwise we would need to add a bufferX/ and scan_elementsX/
directory for each IIO buffer.
With the current way of storing attribute groups, we can't have directories
stored under each other (i.e. scan_elements/ under buffer/), so the best
approach moving forward is to merge their attributes.

The old/legacy buffer/ & scan_elements/ groups are not stored on the opaque
IIO device object. This way the IIO buffer can have just a single
attribute_group object, saving a bit of memory when adding multiple IIO
buffers.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/industrialio-buffer.c | 115 +++++++++++++++++++++++-------
 include/linux/iio/buffer_impl.h   |   9 +--
 include/linux/iio/iio-opaque.h    |   4 ++
 3 files changed, 95 insertions(+), 33 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 23f22be62cc7..fcbbffb904bf 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1175,8 +1175,6 @@ static ssize_t iio_buffer_store_enable(struct device *dev,
 	return (ret < 0) ? ret : len;
 }
 
-static const char * const iio_scan_elements_group_name = "scan_elements";
-
 static ssize_t iio_buffer_show_watermark(struct device *dev,
 					 struct device_attribute *attr,
 					 char *buf)
@@ -1252,8 +1250,68 @@ static struct attribute *iio_buffer_attrs[] = {
 	&dev_attr_data_available.attr,
 };
 
+static int iio_buffer_register_legacy_sysfs_groups(struct iio_dev *indio_dev,
+						   struct attribute **buffer_attrs,
+						   int buffer_attrcount,
+						   int scan_el_attrcount)
+{
+	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
+	struct attribute_group *group;
+	int ret;
+
+	group = &iio_dev_opaque->legacy_buffer_group;
+
+	group->attrs = kcalloc(buffer_attrcount + 1,
+			       sizeof(struct attribute *), GFP_KERNEL);
+	if (!group->attrs)
+		return -ENOMEM;
+
+	memcpy(group->attrs, buffer_attrs,
+	       buffer_attrcount * sizeof(struct attribute *));
+	group->name = "buffer";
+
+	ret = iio_device_register_sysfs_group(indio_dev, group);
+	if (ret)
+		goto error_free_buffer_attrs;
+
+	group = &iio_dev_opaque->legacy_scan_el_group;
+
+	group->attrs = kcalloc(scan_el_attrcount + 1,
+			       sizeof(struct attribute *), GFP_KERNEL);
+	if (!group->attrs) {
+		ret = -ENOMEM;
+		goto error_free_buffer_attrs;
+	}
+
+	memcpy(group->attrs, &buffer_attrs[buffer_attrcount],
+	       scan_el_attrcount * sizeof(struct attribute *));
+	group->name = "scan_elements";
+
+	ret = iio_device_register_sysfs_group(indio_dev, group);
+	if (ret)
+		goto error_free_scan_el_attrs;
+
+	return 0;
+
+error_free_buffer_attrs:
+	kfree(iio_dev_opaque->legacy_buffer_group.attrs);
+error_free_scan_el_attrs:
+	kfree(iio_dev_opaque->legacy_scan_el_group.attrs);
+
+	return ret;
+}
+
+static void iio_buffer_unregister_legacy_sysfs_groups(struct iio_dev *indio_dev)
+{
+	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
+
+	kfree(iio_dev_opaque->legacy_buffer_group.attrs);
+	kfree(iio_dev_opaque->legacy_scan_el_group.attrs);
+}
+
 static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
-					     struct iio_dev *indio_dev)
+					     struct iio_dev *indio_dev,
+					     int index)
 {
 	struct iio_dev_attr *p;
 	struct attribute **attr;
@@ -1294,8 +1352,8 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
 		}
 	}
 
-	attr = kcalloc(buffer_attrcount + ARRAY_SIZE(iio_buffer_attrs) + 1,
-		       sizeof(struct attribute *), GFP_KERNEL);
+	attrn = buffer_attrcount + scan_el_attrcount + ARRAY_SIZE(iio_buffer_attrs);
+	attr = kcalloc(attrn + 1, sizeof(struct attribute *), GFP_KERNEL);
 	if (!attr) {
 		ret = -ENOMEM;
 		goto error_free_scan_mask;
@@ -1313,37 +1371,38 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
 		       sizeof(struct attribute *) * buffer_attrcount);
 
 	buffer_attrcount += ARRAY_SIZE(iio_buffer_attrs);
-	attr[buffer_attrcount] = NULL;
-
-	buffer->buffer_group.name = "buffer";
-	buffer->buffer_group.attrs = attr;
 
-	ret = iio_device_register_sysfs_group(indio_dev, &buffer->buffer_group);
-	if (ret)
-		goto error_free_buffer_attrs;
+	attrn = buffer_attrcount;
 
-	buffer->scan_el_group.name = iio_scan_elements_group_name;
+	list_for_each_entry(p, &buffer->scan_el_dev_attr_list, l)
+		attr[attrn++] = &p->dev_attr.attr;
 
-	buffer->scan_el_group.attrs = kcalloc(scan_el_attrcount + 1,
-					      sizeof(buffer->scan_el_group.attrs[0]),
-					      GFP_KERNEL);
-	if (buffer->scan_el_group.attrs == NULL) {
+	buffer->buffer_group.name = kasprintf(GFP_KERNEL, "buffer%d", index);
+	if (!buffer->buffer_group.name) {
 		ret = -ENOMEM;
-		goto error_free_scan_mask;
+		goto error_free_buffer_attrs;
 	}
-	attrn = 0;
 
-	list_for_each_entry(p, &buffer->scan_el_dev_attr_list, l)
-		buffer->scan_el_group.attrs[attrn++] = &p->dev_attr.attr;
+	buffer->buffer_group.attrs = attr;
 
-	ret = iio_device_register_sysfs_group(indio_dev, &buffer->scan_el_group);
+	ret = iio_device_register_sysfs_group(indio_dev, &buffer->buffer_group);
 	if (ret)
-		goto error_free_scan_el_attrs;
+		goto error_free_buffer_attr_group_name;
+
+	/* we only need to link the legacy buffer groups for the first buffer */
+	if (index > 0)
+		return 0;
+
+	ret = iio_buffer_register_legacy_sysfs_groups(indio_dev, attr,
+						      buffer_attrcount,
+						      scan_el_attrcount);
+	if (ret)
+		goto error_free_buffer_attr_group_name;
 
 	return 0;
 
-error_free_scan_el_attrs:
-	kfree(buffer->scan_el_group.attrs);
+error_free_buffer_attr_group_name:
+	kfree(buffer->buffer_group.name);
 error_free_buffer_attrs:
 	kfree(buffer->buffer_group.attrs);
 error_free_scan_mask:
@@ -1372,14 +1431,14 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
 	if (!buffer)
 		return 0;
 
-	return __iio_buffer_alloc_sysfs_and_mask(buffer, indio_dev);
+	return __iio_buffer_alloc_sysfs_and_mask(buffer, indio_dev, 0);
 }
 
 static void __iio_buffer_free_sysfs_and_mask(struct iio_buffer *buffer)
 {
 	bitmap_free(buffer->scan_mask);
+	kfree(buffer->buffer_group.name);
 	kfree(buffer->buffer_group.attrs);
-	kfree(buffer->scan_el_group.attrs);
 	iio_free_chan_devattr_list(&buffer->scan_el_dev_attr_list);
 }
 
@@ -1390,6 +1449,8 @@ void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev)
 	if (!buffer)
 		return;
 
+	iio_buffer_unregister_legacy_sysfs_groups(indio_dev);
+
 	__iio_buffer_free_sysfs_and_mask(buffer);
 }
 
diff --git a/include/linux/iio/buffer_impl.h b/include/linux/iio/buffer_impl.h
index a63dc07b7350..3e555e58475b 100644
--- a/include/linux/iio/buffer_impl.h
+++ b/include/linux/iio/buffer_impl.h
@@ -100,14 +100,11 @@ struct iio_buffer {
 	/* @scan_el_dev_attr_list: List of scan element related attributes. */
 	struct list_head scan_el_dev_attr_list;
 
-	/* @buffer_group: Attributes of the buffer group. */
-	struct attribute_group buffer_group;
-
 	/*
-	 * @scan_el_group: Attribute group for those attributes not
-	 * created from the iio_chan_info array.
+	 * @buffer_group: Attributes of the new buffer group.
+	 * Includes scan elements attributes.
 	 */
-	struct attribute_group scan_el_group;
+	struct attribute_group buffer_group;
 
 	/* @attrs: Standard attributes of the buffer. */
 	const struct attribute **attrs;
diff --git a/include/linux/iio/iio-opaque.h b/include/linux/iio/iio-opaque.h
index 8ba13a5c7af6..3e4c3cd248fd 100644
--- a/include/linux/iio/iio-opaque.h
+++ b/include/linux/iio/iio-opaque.h
@@ -14,6 +14,8 @@
  * @ioctl_handlers:		ioctl handlers registered with the core handler
  * @groups:			attribute groups
  * @groupcounter:		index of next attribute group
+ * @legacy_scan_el_group:	attribute group for legacy scan elements attribute group
+ * @legacy_buffer_el_group:	attribute group for legacy buffer attributes group
  * @debugfs_dentry:		device specific debugfs dentry
  * @cached_reg_addr:		cached register address for debugfs reads
  * @read_buf:			read buffer to be used for the initial reg read
@@ -28,6 +30,8 @@ struct iio_dev_opaque {
 	struct list_head		ioctl_handlers;
 	const struct attribute_group	**groups;
 	int				groupcounter;
+	struct attribute_group		legacy_scan_el_group;
+	struct attribute_group		legacy_buffer_group;
 #if defined(CONFIG_DEBUG_FS)
 	struct dentry			*debugfs_dentry;
 	unsigned			cached_reg_addr;
-- 
2.17.1

