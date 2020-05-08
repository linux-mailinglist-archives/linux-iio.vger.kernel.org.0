Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0FE01CB111
	for <lists+linux-iio@lfdr.de>; Fri,  8 May 2020 15:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728418AbgEHNyY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 May 2020 09:54:24 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:53496 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728366AbgEHNyW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 8 May 2020 09:54:22 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 048Dqt4H016877;
        Fri, 8 May 2020 09:54:09 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 30vtek2gd1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 May 2020 09:54:09 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 048Ds8OV040859
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 8 May 2020 09:54:08 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Fri, 8 May 2020
 09:54:07 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 8 May 2020 09:54:06 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 048Drpwv030263;
        Fri, 8 May 2020 09:54:05 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [RFC PATCH 11/14] iio: buffer: add underlying device object and convert buffers to devices
Date:   Fri, 8 May 2020 16:53:45 +0300
Message-ID: <20200508135348.15229-12-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200508135348.15229-1-alexandru.ardelean@analog.com>
References: <20200508135348.15229-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-08_13:2020-05-08,2020-05-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 clxscore=1015 mlxscore=0
 bulkscore=0 malwarescore=0 suspectscore=2 adultscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005080123
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

WIP

Currently, IIO is broken here.
Each buffer is now an object.
The part where this is broken is backwards compatibility.
We need to:
- convert all external buffer attributes to unpack to IIO buffers and not
  IIO devices
- symlink the 'scan_elements' folder of the (first) IIO buffer device to
  the IIO device
- symlink the chardev of the first IIO buffer device to the IIO device

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/iio_core.h            | 11 ++--
 drivers/iio/industrialio-buffer.c | 98 ++++++++++++++++++++++++-------
 drivers/iio/industrialio-core.c   | 39 +++++++-----
 include/linux/iio/buffer_impl.h   |  6 ++
 include/linux/iio/iio.h           |  2 +-
 5 files changed, 116 insertions(+), 40 deletions(-)

diff --git a/drivers/iio/iio_core.h b/drivers/iio/iio_core.h
index f68de4af2738..890577766f9b 100644
--- a/drivers/iio/iio_core.h
+++ b/drivers/iio/iio_core.h
@@ -54,10 +54,13 @@ ssize_t iio_format_value(char *buf, unsigned int type, int size, int *vals);
 #ifdef CONFIG_IIO_BUFFER
 struct poll_table_struct;
 
+int iio_device_alloc_chrdev_id(struct device *dev);
+void iio_device_free_chrdev_id(struct device *dev);
+
 void iio_device_buffer_attach_chrdev(struct iio_dev *indio_dev);
 
-int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev);
-void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev);
+int iio_device_buffers_init(struct iio_dev *indio_dev);
+void iio_device_buffers_cleanup(struct iio_dev *indio_dev);
 
 void iio_device_buffers_put(struct iio_dev *indio_dev);
 
@@ -68,12 +71,12 @@ void iio_buffer_wakeup_poll(struct iio_dev *indio_dev);
 
 static inline void iio_device_buffer_attach_chrdev(struct iio_dev *indio_dev) {}
 
-static inline int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
+static inline int iio_device_buffers_init(struct iio_dev *indio_dev)
 {
 	return 0;
 }
 
-static inline void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev) {}
+static inline void iio_device_buffers_cleanup(struct iio_dev *indio_dev) {}
 
 static inline void iio_device_buffers_put(struct iio_dev *indio_dev) {}
 
diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index efebf74a05af..6c35de7ebd9e 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1235,8 +1235,6 @@ static ssize_t iio_buffer_store_enable(struct device *dev,
 	return (ret < 0) ? ret : len;
 }
 
-static const char * const iio_scan_elements_group_name = "scan_elements";
-
 static ssize_t iio_buffer_show_watermark(struct device *dev,
 					 struct device_attribute *attr,
 					 char *buf)
@@ -1312,7 +1310,7 @@ static struct attribute *iio_buffer_attrs[] = {
 	&dev_attr_data_available.attr,
 };
 
-static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer)
+static int iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer)
 {
 	struct iio_dev *indio_dev = buffer->indio_dev;
 	struct iio_dev_attr *p;
@@ -1344,10 +1342,9 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer)
 
 	attr[attrcount + ARRAY_SIZE(iio_buffer_attrs)] = NULL;
 
-	buffer->buffer_group.name = "buffer";
 	buffer->buffer_group.attrs = attr;
 
-	indio_dev->groups[indio_dev->groupcounter++] = &buffer->buffer_group;
+	buffer->groups[0] = &buffer->buffer_group;
 
 	attrcount = 0;
 	INIT_LIST_HEAD(&buffer->scan_el_dev_attr_list);
@@ -1373,7 +1370,7 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer)
 			goto error_cleanup_dynamic;
 	}
 
-	buffer->scan_el_group.name = iio_scan_elements_group_name;
+	buffer->scan_el_group.name = "scan_elements";
 
 	buffer->scan_el_group.attrs = kcalloc(attrcount + 1,
 					      sizeof(buffer->scan_el_group.attrs[0]),
@@ -1386,7 +1383,7 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer)
 
 	list_for_each_entry(p, &buffer->scan_el_dev_attr_list, l)
 		buffer->scan_el_group.attrs[attrn++] = &p->dev_attr.attr;
-	indio_dev->groups[indio_dev->groupcounter++] = &buffer->scan_el_group;
+	buffer->groups[1] = &buffer->scan_el_group;
 
 	return 0;
 
@@ -1399,11 +1396,66 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer)
 	return ret;
 }
 
-int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
+static void iio_buffer_free_sysfs_and_mask(struct iio_buffer *buffer)
+{
+	iio_buffer_free_scanmask(buffer);
+	kfree(buffer->buffer_group.attrs);
+	kfree(buffer->scan_el_group.attrs);
+	iio_free_chan_devattr_list(&buffer->scan_el_dev_attr_list);
+}
+
+static int iio_device_buffer_init(struct iio_dev *indio_dev,
+				  struct iio_buffer *buffer,
+				  int index)
+{
+	int ret;
+
+	ret = iio_buffer_alloc_sysfs_and_mask(buffer);
+	if (ret)
+		return ret;
+
+	ret = iio_device_alloc_chrdev_id(&buffer->dev);
+	if (ret)
+		goto error_free_sysfs_and_mask;
+
+	buffer->dev.parent = &indio_dev->dev;
+	buffer->dev.groups = buffer->groups;
+	buffer->dev.bus = &iio_bus_type;
+	device_initialize(&buffer->dev);
+
+	dev_set_name(&buffer->dev, "iio:buffer%d:%d",
+		     indio_dev->id, index);
+
+	ret = cdev_device_add(&buffer->chrdev, &buffer->dev);
+	if (ret)
+		goto error_free_chrdev_id;
+
+	return 0;
+
+error_free_chrdev_id:
+	iio_device_free_chrdev_id(&buffer->dev);
+error_free_sysfs_and_mask:
+	iio_buffer_free_sysfs_and_mask(buffer);
+	return ret;
+}
+
+void iio_device_buffer_cleanup(struct iio_buffer *buffer)
+{
+	if (!buffer)
+		return;
+
+	iio_buffer_free_sysfs_and_mask(buffer);
+
+	cdev_device_del(&buffer->chrdev, &buffer->dev);
+
+	iio_device_free_chrdev_id(&buffer->dev);
+}
+
+int iio_device_buffers_init(struct iio_dev *indio_dev)
 {
 	struct iio_buffer *buffer = indio_dev->buffer;
 	const struct iio_chan_spec *channels;
-	int i;
+	int i, ret;
 
 	channels = indio_dev->channels;
 	if (channels) {
@@ -1417,25 +1469,29 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
 	if (!buffer)
 		return 0;
 
-	return __iio_buffer_alloc_sysfs_and_mask(buffer);
-}
+	ret = iio_device_buffer_init(indio_dev, buffer, 0);
+	if (ret)
+		return ret;
 
-static void __iio_buffer_free_sysfs_and_mask(struct iio_buffer *buffer)
-{
-	iio_buffer_free_scanmask(buffer);
-	kfree(buffer->buffer_group.attrs);
-	kfree(buffer->scan_el_group.attrs);
-	iio_free_chan_devattr_list(&buffer->scan_el_dev_attr_list);
+	ret = sysfs_create_link(&indio_dev->dev.kobj,
+				&buffer->dev.kobj, "buffer");
+	if (ret)
+		goto error_cleanup_buffers;
+
+	return 0;
+
+error_cleanup_buffers:
+	iio_device_buffer_cleanup(buffer);
+	return 0;
 }
 
-void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev)
+void iio_device_buffers_cleanup(struct iio_dev *indio_dev)
 {
 	struct iio_buffer *buffer = indio_dev->buffer;
 
-	if (!buffer)
-		return;
+	sysfs_remove_link(&indio_dev->dev.kobj, "buffer");
 
-	__iio_buffer_free_sysfs_and_mask(buffer);
+	iio_device_buffer_cleanup(buffer);
 }
 
 static const struct file_operations iio_buffer_fileops = {
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 5df3af5e7dcb..b27fabf13e9c 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1638,7 +1638,7 @@ static int iio_check_unique_scan_index(struct iio_dev *indio_dev)
 	return 0;
 }
 
-static int iio_device_alloc_chrdev_id(struct device *dev)
+int iio_device_alloc_chrdev_id(struct device *dev)
 {
 	int id;
 
@@ -1654,7 +1654,7 @@ static int iio_device_alloc_chrdev_id(struct device *dev)
 	return 0;
 }
 
-static void iio_device_free_chrdev_id(struct device *dev)
+void iio_device_free_chrdev_id(struct device *dev)
 {
 	if (!dev->devt)
 		return;
@@ -1684,18 +1684,11 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
 
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
+		goto error_unreg_debugfs;
 	}
 	ret = iio_device_register_eventset(indio_dev);
 	if (ret) {
@@ -1712,6 +1705,26 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
 
 	iio_device_buffer_attach_chrdev(indio_dev);
 
+	if (indio_dev->chrdev) {
+		ret = device_add(&indio_dev->dev);
+
+		if (ret) {
+			put_device(&indio_dev->dev);
+			goto error_unreg_eventset;
+		}
+
+		ret = iio_device_buffers_init(indio_dev);
+		if (ret) {
+			device_del(&indio_dev->dev);
+
+			dev_err(indio_dev->dev.parent,
+				"Failed to create buffer sysfs interfaces\n");
+			goto error_unreg_eventset;
+		}
+
+		return 0;
+	}
+
 	/* No chrdev attached from buffer, we go with event-only chrdev */
 	if (!indio_dev->chrdev)
 		iio_device_event_attach_chrdev(indio_dev);
@@ -1736,8 +1749,6 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
 	iio_device_unregister_eventset(indio_dev);
 error_free_sysfs:
 	iio_device_unregister_sysfs(indio_dev);
-error_buffer_free_sysfs:
-	iio_buffer_free_sysfs_and_mask(indio_dev);
 error_unreg_debugfs:
 	iio_device_unregister_debugfs(indio_dev);
 	return ret;
@@ -1752,6 +1763,8 @@ void iio_device_unregister(struct iio_dev *indio_dev)
 {
 	struct iio_ioctl_handler *h, *t;
 
+	iio_device_buffers_cleanup(indio_dev);
+
 	cdev_device_del(indio_dev->chrdev, &indio_dev->dev);
 	iio_device_free_chrdev_id(&indio_dev->dev);
 
@@ -1770,8 +1783,6 @@ void iio_device_unregister(struct iio_dev *indio_dev)
 	iio_buffer_wakeup_poll(indio_dev);
 
 	mutex_unlock(&indio_dev->info_exist_lock);
-
-	iio_buffer_free_sysfs_and_mask(indio_dev);
 }
 EXPORT_SYMBOL(iio_device_unregister);
 
diff --git a/include/linux/iio/buffer_impl.h b/include/linux/iio/buffer_impl.h
index 46fc977deae3..eca3fe630230 100644
--- a/include/linux/iio/buffer_impl.h
+++ b/include/linux/iio/buffer_impl.h
@@ -104,6 +104,12 @@ struct iio_buffer {
 	unsigned int watermark;
 
 	/* private: */
+	/* @dev: underlying device object. */
+	struct device dev;
+
+#define IIO_BUFFER_MAX_GROUP	2
+	const struct attribute_group *groups[IIO_BUFFER_MAX_GROUP + 1];
+
 	/* @scan_timestamp: Does the scan mode include a timestamp. */
 	bool scan_timestamp;
 
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index b6ca8d85629e..671f5818fa67 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -561,7 +561,7 @@ struct iio_dev {
 	struct mutex			info_exist_lock;
 	const struct iio_buffer_setup_ops	*setup_ops;
 	struct cdev			*chrdev;
-#define IIO_MAX_GROUPS 6
+#define IIO_MAX_GROUPS 5
 	const struct attribute_group	*groups[IIO_MAX_GROUPS + 1];
 	int				groupcounter;
 
-- 
2.17.1

