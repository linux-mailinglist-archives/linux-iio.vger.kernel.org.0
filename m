Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 203B13009BF
	for <lists+linux-iio@lfdr.de>; Fri, 22 Jan 2021 18:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729584AbhAVR2S (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 Jan 2021 12:28:18 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:15408 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729107AbhAVP4U (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 Jan 2021 10:56:20 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10MFV0ma019193;
        Fri, 22 Jan 2021 10:55:24 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 3668rbtjpv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jan 2021 10:55:24 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 10MFtNK8002553
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 Jan 2021 10:55:23 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2; Fri, 22 Jan 2021
 10:55:22 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.721.2 via Frontend Transport;
 Fri, 22 Jan 2021 10:55:22 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 10MFtF56014933;
        Fri, 22 Jan 2021 10:55:20 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 03/12] iio: buffer: rework buffer & scan_elements dir creation
Date:   Fri, 22 Jan 2021 17:57:56 +0200
Message-ID: <20210122155805.83012-4-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210122155805.83012-1-alexandru.ardelean@analog.com>
References: <20210122155805.83012-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-22_11:2021-01-22,2021-01-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 malwarescore=0 impostorscore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 adultscore=0 mlxlogscore=758
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101220087
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When adding more than one IIO buffer per IIO device, we will need to create
a buffer & scan_elements directory for each buffer.
We also want to move the 'scan_elements' to be a sub-directory of the
'buffer' folder.

The format we want to reach is, for a iio:device0 folder, for 2 buffers
[for example], we have a 'buffer0' and a 'buffer1' subfolder, and each with
it's own 'scan_elements' subfolder.

So, for example:
   iio:device0/buffer0
      scan_elements/

   iio:device0/buffer1
      scan_elements/

The other attributes under 'bufferX' would remain unchanged.

However, we would also need to symlink back to the old 'buffer' &
'scan_elements' folders, to keep backwards compatibility.

Doing all these, require that we maintain the kobjects for each 'bufferX'
and 'scan_elements' so that we can symlink them back. We also need to
implement the sysfs_ops for these folders.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/industrialio-buffer.c | 195 +++++++++++++++++++++++++++---
 drivers/iio/industrialio-core.c   |  24 ++--
 include/linux/iio/buffer_impl.h   |  14 ++-
 include/linux/iio/iio.h           |   2 +-
 4 files changed, 200 insertions(+), 35 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 0412c4fda4c1..0f470d902790 100644
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
@@ -1252,6 +1250,124 @@ static struct attribute *iio_buffer_attrs[] = {
 	&dev_attr_data_available.attr,
 };
 
+#define to_dev_attr(_attr) container_of(_attr, struct device_attribute, attr)
+
+static ssize_t iio_buffer_dir_attr_show(struct kobject *kobj,
+					struct attribute *attr,
+					char *buf)
+{
+	struct iio_buffer *buffer = container_of(kobj, struct iio_buffer, buffer_dir);
+	struct device_attribute *dattr;
+
+	dattr = to_dev_attr(attr);
+
+	return dattr->show(&buffer->indio_dev->dev, dattr, buf);
+}
+
+static ssize_t iio_buffer_dir_attr_store(struct kobject *kobj,
+					 struct attribute *attr,
+					 const char *buf,
+					 size_t len)
+{
+	struct iio_buffer *buffer = container_of(kobj, struct iio_buffer, buffer_dir);
+	struct device_attribute *dattr;
+
+	dattr = to_dev_attr(attr);
+
+	return dattr->store(&buffer->indio_dev->dev, dattr, buf, len);
+}
+
+static const struct sysfs_ops iio_buffer_dir_sysfs_ops = {
+	.show = iio_buffer_dir_attr_show,
+	.store = iio_buffer_dir_attr_store,
+};
+
+static struct kobj_type iio_buffer_dir_ktype = {
+	.sysfs_ops = &iio_buffer_dir_sysfs_ops,
+};
+
+static ssize_t iio_scan_el_dir_attr_show(struct kobject *kobj,
+					 struct attribute *attr,
+					 char *buf)
+{
+	struct iio_buffer *buffer = container_of(kobj, struct iio_buffer, scan_el_dir);
+	struct device_attribute *dattr = to_dev_attr(attr);
+
+	return dattr->show(&buffer->indio_dev->dev, dattr, buf);
+}
+
+static ssize_t iio_scan_el_dir_attr_store(struct kobject *kobj,
+					  struct attribute *attr,
+					  const char *buf,
+					  size_t len)
+{
+	struct iio_buffer *buffer = container_of(kobj, struct iio_buffer, scan_el_dir);
+	struct device_attribute *dattr = to_dev_attr(attr);
+
+	return dattr->store(&buffer->indio_dev->dev, dattr, buf, len);
+}
+
+static const struct sysfs_ops iio_scan_el_dir_sysfs_ops = {
+	.show = iio_scan_el_dir_attr_show,
+	.store = iio_scan_el_dir_attr_store,
+};
+
+static struct kobj_type iio_scan_el_dir_ktype = {
+	.sysfs_ops = &iio_scan_el_dir_sysfs_ops,
+};
+
+/*
+ * These iio_sysfs_{add,del}_attrs() are essentially re-implementations of
+ * sysfs_create_files() & sysfs_remove_files(), but they are meant to get
+ * around the const-pointer mismatch situation with using them.
+ *
+ * sysfs_{create,remove}_files() uses 'const struct attribute * const *ptr',
+ * while these are happy with just 'struct attribute **ptr'
+ */
+static int iio_sysfs_add_attrs(struct kobject *kobj, struct attribute **ptr)
+{
+	int err = 0;
+	int i;
+
+	for (i = 0; ptr[i] && !err; i++)
+		err = sysfs_create_file(kobj, ptr[i]);
+	if (err)
+		while (--i >= 0)
+			sysfs_remove_file(kobj, ptr[i]);
+	return err;
+}
+
+static void iio_sysfs_del_attrs(struct kobject *kobj, struct attribute **ptr)
+{
+	int i;
+
+	for (i = 0; ptr[i]; i++)
+		sysfs_remove_file(kobj, ptr[i]);
+}
+
+/**
+ * __iio_buffer_alloc_sysfs_and_mask() - Allocate sysfs attributes to an attached buffer
+ * @buffer: the buffer object for which the sysfs attributes are created for
+ * @indio_dev: the iio device to which the iio buffer belongs to
+ *
+ * Return 0, or negative for error.
+ *
+ * This function must be called for each single buffer. The sysfs attributes for that
+ * buffer will be created, and the IIO device object will be the parent kobject of that
+ * the kobjects created here.
+ * Because we need to redirect sysfs attribute to it's IIO buffer object, we need to
+ * implement our own sysfs_ops, and each IIO buffer will keep a kobject for the
+ * 'bufferX' directory and one for the 'scan_elements' directory.
+ * And in order to do this, this function must be called after the IIO device object
+ * has been added via device_add(). This fundamentally changes how sysfs attributes
+ * were created before (with one single IIO buffer per IIO device), where the
+ * sysfs attributes for the buffer were mapped as attribute groups on the IIO device
+ * groups object list.
+ * Using kobjects directly for the 'bufferX' and 'scan_elements' directories allows
+ * us to symlink them back to keep backwards compatibility for the old sysfs interface
+ * for IIO buffers while also allowing us to support multiple IIO buffers per one
+ * IIO device.
+ */
 static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
 					     struct iio_dev *indio_dev)
 {
@@ -1282,12 +1398,16 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
 		memcpy(&attr[ARRAY_SIZE(iio_buffer_attrs)], buffer->attrs,
 		       sizeof(struct attribute *) * attrcount);
 
-	attr[attrcount + ARRAY_SIZE(iio_buffer_attrs)] = NULL;
+	buffer->buffer_attrs = attr;
 
-	buffer->buffer_group.name = "buffer";
-	buffer->buffer_group.attrs = attr;
+	ret = kobject_init_and_add(&buffer->buffer_dir, &iio_buffer_dir_ktype,
+				   &indio_dev->dev.kobj, "buffer");
+	if (ret)
+		goto error_buffer_free_attrs;
 
-	indio_dev->groups[indio_dev->groupcounter++] = &buffer->buffer_group;
+	ret = iio_sysfs_add_attrs(&buffer->buffer_dir, buffer->buffer_attrs);
+	if (ret)
+		goto error_buffer_kobject_put;
 
 	attrcount = 0;
 	INIT_LIST_HEAD(&buffer->scan_el_dev_attr_list);
@@ -1317,32 +1437,57 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
 		}
 	}
 
-	buffer->scan_el_group.name = iio_scan_elements_group_name;
-
-	buffer->scan_el_group.attrs = kcalloc(attrcount + 1,
-					      sizeof(buffer->scan_el_group.attrs[0]),
-					      GFP_KERNEL);
-	if (buffer->scan_el_group.attrs == NULL) {
+	buffer->scan_el_attrs = kcalloc(attrcount + 1,
+					sizeof(buffer->scan_el_attrs[0]),
+					GFP_KERNEL);
+	if (buffer->scan_el_attrs == NULL) {
 		ret = -ENOMEM;
 		goto error_free_scan_mask;
 	}
-	attrn = 0;
 
+	ret = kobject_init_and_add(&buffer->scan_el_dir, &iio_scan_el_dir_ktype,
+				   &indio_dev->dev.kobj, "scan_elements");
+	if (ret)
+		goto error_free_scan_attrs;
+
+	attrn = 0;
 	list_for_each_entry(p, &buffer->scan_el_dev_attr_list, l)
-		buffer->scan_el_group.attrs[attrn++] = &p->dev_attr.attr;
-	indio_dev->groups[indio_dev->groupcounter++] = &buffer->scan_el_group;
+		buffer->scan_el_attrs[attrn++] = &p->dev_attr.attr;
+
+	ret = iio_sysfs_add_attrs(&buffer->scan_el_dir, buffer->scan_el_attrs);
+	if (ret)
+		goto error_scan_kobject_put;
 
 	return 0;
 
+error_scan_kobject_put:
+	kobject_put(&buffer->scan_el_dir);
+error_free_scan_attrs:
+	kfree(buffer->scan_el_attrs);
 error_free_scan_mask:
 	bitmap_free(buffer->scan_mask);
 error_cleanup_dynamic:
+	iio_sysfs_del_attrs(&buffer->buffer_dir, buffer->buffer_attrs);
 	iio_free_chan_devattr_list(&buffer->scan_el_dev_attr_list);
-	kfree(buffer->buffer_group.attrs);
+error_buffer_kobject_put:
+	kobject_put(&buffer->buffer_dir);
+error_buffer_free_attrs:
+	kfree(buffer->buffer_attrs);
 
 	return ret;
 }
 
+/**
+ * iio_buffer_alloc_sysfs_and_mask() - Allocate sysfs attributes to attached buffers
+ * @indio_dev: the iio device for which to create the buffer sysfs attributes
+ *
+ * Return 0, or negative for error.
+ *
+ * If the IIO device has no buffer attached, no sysfs attributes will be created.
+ * This function must be called after the IIO device object has been created and
+ * registered with device_add(). See __iio_buffer_alloc_sysfs_and_mask() for more
+ * details.
+ */
 int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
 {
 	struct iio_buffer *buffer = indio_dev->buffer;
@@ -1364,14 +1509,28 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
 	return __iio_buffer_alloc_sysfs_and_mask(buffer, indio_dev);
 }
 
+/**
+ * __iio_buffer_free_sysfs_and_mask() - Free sysfs objects for a single IIO buffer
+ * @buffer: the iio buffer for which to destroy the objects
+ */
 static void __iio_buffer_free_sysfs_and_mask(struct iio_buffer *buffer)
 {
+	iio_sysfs_del_attrs(&buffer->scan_el_dir, buffer->scan_el_attrs);
+	kobject_put(&buffer->scan_el_dir);
+	kfree(buffer->scan_el_attrs);
 	bitmap_free(buffer->scan_mask);
-	kfree(buffer->buffer_group.attrs);
-	kfree(buffer->scan_el_group.attrs);
+	iio_sysfs_del_attrs(&buffer->buffer_dir, buffer->buffer_attrs);
 	iio_free_chan_devattr_list(&buffer->scan_el_dev_attr_list);
+	kobject_put(&buffer->buffer_dir);
+	kfree(buffer->buffer_attrs);
 }
 
+/**
+ * iio_buffer_free_sysfs_and_mask() - Free sysfs objects for all IIO buffers
+ * @indio_dev: the iio device for which to destroy the objects
+ *
+ * If the IIO device has no buffer attached, nothing will be done.
+ */
 void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev)
 {
 	struct iio_buffer *buffer = indio_dev->buffer;
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 0a6fd299a978..95d66745f118 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1817,18 +1817,11 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
 
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
@@ -1857,14 +1850,21 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
 	if (ret < 0)
 		goto error_unreg_eventset;
 
+	ret = iio_buffer_alloc_sysfs_and_mask(indio_dev);
+	if (ret) {
+		dev_err(indio_dev->dev.parent,
+			"Failed to create buffer sysfs interfaces\n");
+		goto error_device_del;
+	}
+
 	return 0;
 
+error_device_del:
+	cdev_device_del(&indio_dev->chrdev, &indio_dev->dev);
 error_unreg_eventset:
 	iio_device_unregister_eventset(indio_dev);
 error_free_sysfs:
 	iio_device_unregister_sysfs(indio_dev);
-error_buffer_free_sysfs:
-	iio_buffer_free_sysfs_and_mask(indio_dev);
 error_unreg_debugfs:
 	iio_device_unregister_debugfs(indio_dev);
 	return ret;
@@ -1880,6 +1880,8 @@ void iio_device_unregister(struct iio_dev *indio_dev)
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 	struct iio_ioctl_handler *h, *t;
 
+	iio_buffer_free_sysfs_and_mask(indio_dev);
+
 	cdev_device_del(&indio_dev->chrdev, &indio_dev->dev);
 
 	mutex_lock(&indio_dev->info_exist_lock);
@@ -1897,8 +1899,6 @@ void iio_device_unregister(struct iio_dev *indio_dev)
 	iio_buffer_wakeup_poll(indio_dev);
 
 	mutex_unlock(&indio_dev->info_exist_lock);
-
-	iio_buffer_free_sysfs_and_mask(indio_dev);
 }
 EXPORT_SYMBOL(iio_device_unregister);
 
diff --git a/include/linux/iio/buffer_impl.h b/include/linux/iio/buffer_impl.h
index 67d73d465e02..77e169e51434 100644
--- a/include/linux/iio/buffer_impl.h
+++ b/include/linux/iio/buffer_impl.h
@@ -103,14 +103,20 @@ struct iio_buffer {
 	/* @scan_el_dev_attr_list: List of scan element related attributes. */
 	struct list_head scan_el_dev_attr_list;
 
-	/* @buffer_group: Attributes of the buffer group. */
-	struct attribute_group buffer_group;
+	/* @buffer_dir: kobject for the 'buffer' directory of this buffer */
+	struct kobject buffer_dir;
+
+	/* @buffer_attrs: Attributes of the buffer group. */
+	struct attribute **buffer_attrs;
+
+	/* @scan_el_dir: kobject for the 'scan_elements' directory of this buffer */
+	struct kobject scan_el_dir;
 
 	/*
-	 * @scan_el_group: Attribute group for those attributes not
+	 * @scan_el_attrs: Array of attributes for those attributes not
 	 * created from the iio_chan_info array.
 	 */
-	struct attribute_group scan_el_group;
+	struct attribute **scan_el_attrs;
 
 	/* @attrs: Standard attributes of the buffer. */
 	const struct attribute **attrs;
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index e4a9822e6495..59b317dc45b8 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -556,7 +556,7 @@ struct iio_dev {
 	struct mutex			info_exist_lock;
 	const struct iio_buffer_setup_ops	*setup_ops;
 	struct cdev			chrdev;
-#define IIO_MAX_GROUPS 6
+#define IIO_MAX_GROUPS 4
 	const struct attribute_group	*groups[IIO_MAX_GROUPS + 1];
 	int				groupcounter;
 
-- 
2.17.1

