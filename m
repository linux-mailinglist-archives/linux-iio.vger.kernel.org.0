Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 231D61CB114
	for <lists+linux-iio@lfdr.de>; Fri,  8 May 2020 15:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgEHNy0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 May 2020 09:54:26 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:57460 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728385AbgEHNyZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 8 May 2020 09:54:25 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 048Diipe006142;
        Fri, 8 May 2020 09:54:12 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 30vtef2j6d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 May 2020 09:54:12 -0400
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 048DsAJ0040868
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 8 May 2020 09:54:11 -0400
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 8 May 2020 06:54:09 -0700
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 8 May 2020 06:54:09 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 8 May 2020 06:54:09 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 048Drpww030263;
        Fri, 8 May 2020 09:54:06 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [RFC PATCH 12/14] iio: buffer: symlink the scan_elements dir back into IIO device's dir
Date:   Fri, 8 May 2020 16:53:46 +0300
Message-ID: <20200508135348.15229-13-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200508135348.15229-1-alexandru.ardelean@analog.com>
References: <20200508135348.15229-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-08_13:2020-05-08,2020-05-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 suspectscore=2
 clxscore=1015 phishscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2005080122
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

WIP

Need to explicitly create the scan_elements dir to symlink it.
Admittedly we could try to use some kernfs logic to dig out the kobject of
the 'scan_elements' group, it doesn't seem to be done outside of the fs/
kernel directory.

We need to use the sysfs_() function suite, and that means creating it by
hand after the IIO buffer device was created and added so that we have a
parent kobject to attach this folder to.

After we create it by hand there is a kobject to which to symlink this to
back to the IIO device.

IIO still broken
What's left:
- convert all external buffer attributes to unpack to IIO buffers and not
  IIO devices
- symlink the chardev of the first IIO buffer device to the IIO device

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/industrialio-buffer.c | 149 ++++++++++++++++++++++++------
 include/linux/iio/buffer_impl.h   |   7 +-
 2 files changed, 122 insertions(+), 34 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 6c35de7ebd9e..b14281442387 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1310,15 +1310,11 @@ static struct attribute *iio_buffer_attrs[] = {
 	&dev_attr_data_available.attr,
 };
 
-static int iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer)
+static int iio_buffer_alloc_sysfs(struct iio_buffer *buffer)
 {
-	struct iio_dev *indio_dev = buffer->indio_dev;
-	struct iio_dev_attr *p;
 	struct attribute **attr;
-	int ret, i, attrn, attrcount;
-	const struct iio_chan_spec *channels;
+	int attrcount = 0;
 
-	attrcount = 0;
 	if (buffer->attrs) {
 		while (buffer->attrs[attrcount] != NULL)
 			attrcount++;
@@ -1346,7 +1342,60 @@ static int iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer)
 
 	buffer->groups[0] = &buffer->buffer_group;
 
-	attrcount = 0;
+	return 0;
+}
+
+static ssize_t iio_scan_el_dir_show(struct kobject *kobj,
+				    struct attribute *attr, char *buf)
+{
+	struct device_attribute *dattr =
+		container_of(attr, struct device_attribute, attr);
+	struct iio_buffer *buffer =
+		container_of(kobj, struct iio_buffer, scan_el_dir);
+
+	if (!dattr->show)
+		return -EIO;
+
+	return dattr->show(&buffer->dev, dattr, buf);
+}
+
+static ssize_t iio_scan_el_dir_store(struct kobject *kobj,
+				     struct attribute *attr,
+				     const char *buf, size_t len)
+{
+	struct device_attribute *dattr =
+		container_of(attr, struct device_attribute, attr);
+	struct iio_buffer *buffer =
+		container_of(kobj, struct iio_buffer, scan_el_dir);
+
+	if (!dattr->store)
+		return -EIO;
+
+	return dattr->store(&buffer->dev, dattr, buf, len);
+}
+
+static struct sysfs_ops iio_scan_el_dir_ops = {
+	.show = iio_scan_el_dir_show,
+	.store = iio_scan_el_dir_store,
+};
+
+static void iio_buffer_dir_noop_release(struct kobject *kobj)
+{
+	/* nothing to do yet */
+}
+
+static struct kobj_type iio_scan_el_dir_ktype = {
+	.release = iio_buffer_dir_noop_release,
+	.sysfs_ops = &iio_scan_el_dir_ops,
+};
+
+static int iio_buffer_alloc_scan_sysfs(struct iio_buffer *buffer)
+{
+	struct iio_dev *indio_dev = buffer->indio_dev;
+	struct iio_dev_attr *p;
+	int ret, i;
+	const struct iio_chan_spec *channels;
+
 	INIT_LIST_HEAD(&buffer->scan_el_dev_attr_list);
 	channels = indio_dev->channels;
 	if (channels) {
@@ -1359,7 +1408,6 @@ static int iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer)
 							 &channels[i]);
 			if (ret < 0)
 				goto error_cleanup_dynamic;
-			attrcount += ret;
 			if (channels[i].type == IIO_TIMESTAMP)
 				indio_dev->scan_index_timestamp =
 					channels[i].scan_index;
@@ -1370,37 +1418,52 @@ static int iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer)
 			goto error_cleanup_dynamic;
 	}
 
-	buffer->scan_el_group.name = "scan_elements";
-
-	buffer->scan_el_group.attrs = kcalloc(attrcount + 1,
-					      sizeof(buffer->scan_el_group.attrs[0]),
-					      GFP_KERNEL);
-	if (buffer->scan_el_group.attrs == NULL) {
-		ret = -ENOMEM;
+	ret = kobject_init_and_add(&buffer->scan_el_dir,
+				   &iio_scan_el_dir_ktype, &buffer->dev.kobj,
+				   "scan_elements");
+	if (ret)
 		goto error_free_scan_mask;
-	}
-	attrn = 0;
 
-	list_for_each_entry(p, &buffer->scan_el_dev_attr_list, l)
-		buffer->scan_el_group.attrs[attrn++] = &p->dev_attr.attr;
-	buffer->groups[1] = &buffer->scan_el_group;
+	i = 0;
+	list_for_each_entry(p, &buffer->scan_el_dev_attr_list, l) {
+		ret = sysfs_create_file(&buffer->scan_el_dir,
+					&p->dev_attr.attr);
+		if (ret)
+			goto error_remove_scan_el_dir;
+		i++;
+	}
 
 	return 0;
 
+error_remove_scan_el_dir:
+	list_for_each_entry(p, &buffer->scan_el_dev_attr_list, l) {
+		if (i == 0)
+			break;
+		sysfs_remove_file(&buffer->scan_el_dir, &p->dev_attr.attr);
+		i--;
+	}
+	kobject_put(&buffer->scan_el_dir);
 error_free_scan_mask:
 	iio_buffer_free_scanmask(buffer);
 error_cleanup_dynamic:
 	iio_free_chan_devattr_list(&buffer->scan_el_dev_attr_list);
-	kfree(buffer->buffer_group.attrs);
 
 	return ret;
 }
 
-static void iio_buffer_free_sysfs_and_mask(struct iio_buffer *buffer)
+static void iio_buffer_free_sysfs(struct iio_buffer *buffer)
 {
 	iio_buffer_free_scanmask(buffer);
 	kfree(buffer->buffer_group.attrs);
-	kfree(buffer->scan_el_group.attrs);
+}
+
+static void iio_buffer_free_scan_sysfs(struct iio_buffer *buffer)
+{
+	struct iio_dev_attr *p;
+
+	list_for_each_entry(p, &buffer->scan_el_dev_attr_list, l)
+		sysfs_remove_file(&buffer->scan_el_dir, &p->dev_attr.attr);
+	kobject_put(&buffer->scan_el_dir);
 	iio_free_chan_devattr_list(&buffer->scan_el_dev_attr_list);
 }
 
@@ -1410,7 +1473,7 @@ static int iio_device_buffer_init(struct iio_dev *indio_dev,
 {
 	int ret;
 
-	ret = iio_buffer_alloc_sysfs_and_mask(buffer);
+	ret = iio_buffer_alloc_sysfs(buffer);
 	if (ret)
 		return ret;
 
@@ -1430,12 +1493,18 @@ static int iio_device_buffer_init(struct iio_dev *indio_dev,
 	if (ret)
 		goto error_free_chrdev_id;
 
+	ret = iio_buffer_alloc_scan_sysfs(buffer);
+	if (ret)
+		goto error_cdev_device_del;
+
 	return 0;
 
+error_cdev_device_del:
+	cdev_device_del(&buffer->chrdev, &buffer->dev);
 error_free_chrdev_id:
 	iio_device_free_chrdev_id(&buffer->dev);
 error_free_sysfs_and_mask:
-	iio_buffer_free_sysfs_and_mask(buffer);
+	iio_buffer_free_sysfs(buffer);
 	return ret;
 }
 
@@ -1444,13 +1513,33 @@ void iio_device_buffer_cleanup(struct iio_buffer *buffer)
 	if (!buffer)
 		return;
 
-	iio_buffer_free_sysfs_and_mask(buffer);
+	iio_buffer_free_scan_sysfs(buffer);
 
 	cdev_device_del(&buffer->chrdev, &buffer->dev);
 
+	iio_buffer_free_sysfs(buffer);
+
 	iio_device_free_chrdev_id(&buffer->dev);
 }
 
+static int iio_device_link_legacy_folders(struct iio_dev *indio_dev,
+					  struct iio_buffer *buffer)
+{
+	int ret;
+
+	ret = sysfs_create_link(&indio_dev->dev.kobj,
+				&buffer->dev.kobj, "buffer");
+	if (ret)
+		return ret;
+
+	ret = sysfs_create_link(&indio_dev->dev.kobj,
+				&buffer->scan_el_dir, "scan_elements");
+	if (ret)
+		sysfs_remove_link(&indio_dev->dev.kobj,  "buffer");
+
+	return ret;
+}
+
 int iio_device_buffers_init(struct iio_dev *indio_dev)
 {
 	struct iio_buffer *buffer = indio_dev->buffer;
@@ -1473,14 +1562,13 @@ int iio_device_buffers_init(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
-	ret = sysfs_create_link(&indio_dev->dev.kobj,
-				&buffer->dev.kobj, "buffer");
+	ret = iio_device_link_legacy_folders(indio_dev, buffer);
 	if (ret)
-		goto error_cleanup_buffers;
+		goto error_buffers_cleanup;
 
 	return 0;
 
-error_cleanup_buffers:
+error_buffers_cleanup:
 	iio_device_buffer_cleanup(buffer);
 	return 0;
 }
@@ -1490,6 +1578,7 @@ void iio_device_buffers_cleanup(struct iio_dev *indio_dev)
 	struct iio_buffer *buffer = indio_dev->buffer;
 
 	sysfs_remove_link(&indio_dev->dev.kobj, "buffer");
+	sysfs_remove_link(&indio_dev->dev.kobj, "scan_elements");
 
 	iio_device_buffer_cleanup(buffer);
 }
diff --git a/include/linux/iio/buffer_impl.h b/include/linux/iio/buffer_impl.h
index eca3fe630230..e8203b6d51a1 100644
--- a/include/linux/iio/buffer_impl.h
+++ b/include/linux/iio/buffer_impl.h
@@ -107,7 +107,7 @@ struct iio_buffer {
 	/* @dev: underlying device object. */
 	struct device dev;
 
-#define IIO_BUFFER_MAX_GROUP	2
+#define IIO_BUFFER_MAX_GROUP	1
 	const struct attribute_group *groups[IIO_BUFFER_MAX_GROUP + 1];
 
 	/* @scan_timestamp: Does the scan mode include a timestamp. */
@@ -120,10 +120,9 @@ struct iio_buffer {
 	struct attribute_group buffer_group;
 
 	/*
-	 * @scan_el_group: Attribute group for those attributes not
-	 * created from the iio_chan_info array.
+	 * @scan_el_dir: kobject for the 'scan_elements' directory
 	 */
-	struct attribute_group scan_el_group;
+	struct kobject scan_el_dir;
 
 	/* @attrs: Standard attributes of the buffer. */
 	const struct attribute **attrs;
-- 
2.17.1

