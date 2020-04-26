Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57EEA1B8D86
	for <lists+linux-iio@lfdr.de>; Sun, 26 Apr 2020 09:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbgDZHif (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Apr 2020 03:38:35 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:1234 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726135AbgDZHiS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Apr 2020 03:38:18 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03Q7b5IH003593;
        Sun, 26 Apr 2020 03:38:03 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 30mj452m9q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Apr 2020 03:38:03 -0400
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 03Q7c1hD013212
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Sun, 26 Apr 2020 03:38:02 -0400
Received: from SCSQCASHYB6.ad.analog.com (10.77.17.132) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Sun, 26 Apr 2020 00:38:00 -0700
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by
 SCSQCASHYB6.ad.analog.com (10.77.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Sun, 26 Apr 2020 00:37:58 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Sun, 26 Apr 2020 00:37:59 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 03Q7bqdw011885;
        Sun, 26 Apr 2020 03:37:58 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <lars@metafoo.de>, <jic23@kernel.org>, <pmeerw@pmeerw.net>,
        "Alexandru Ardelean" <alexandru.ardelean@analog.com>
Subject: [PATCH v5 4/6] iio: buffer,event: duplicate chardev creation for buffers & events
Date:   Sun, 26 Apr 2020 10:38:15 +0300
Message-ID: <20200426073817.33307-5-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200426073817.33307-1-alexandru.ardelean@analog.com>
References: <20200426073817.33307-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-25_14:2020-04-24,2020-04-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 suspectscore=2 malwarescore=0 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004260070
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch moves the chardev creation into industrialio-buffer.c &
industrialio-event.c. The move has to be in a single step (which makes the
patch a bit big), in order to pass the reference of the chardev to
'indio_dev->chrdev'.

For structure purposes, industrialio-core.c should be the place where
cdev_device_add()/device_add() gets called, and the deletion function as
well.

What happens after this patch is:
- 'indio_dev->chrdev' is converted to a pointer
- if there is an IIO buffer, iio_device_buffer_attach_chrdev() will attach
  it's chardev to 'indio_chrdev'
- if it doesn't, the event interface will attach a reference to it's
  chardev (if it is instantiated) via iio_device_event_attach_chrdev()

That way, the control of the 'legacy' chardev is still visible in
'industrialio-core.c'. So, each logic file (for buffers & events) shouldn't
hide things too much away from the core file.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/iio_core.h            |  16 ++---
 drivers/iio/industrialio-buffer.c |  90 +++++++++++++++++++++++--
 drivers/iio/industrialio-core.c   | 105 ++++--------------------------
 drivers/iio/industrialio-event.c  |  98 +++++++++++++++++++++++++++-
 include/linux/iio/buffer_impl.h   |   7 ++
 include/linux/iio/iio.h           |   6 +-
 6 files changed, 208 insertions(+), 114 deletions(-)

diff --git a/drivers/iio/iio_core.h b/drivers/iio/iio_core.h
index 39ec0344fb68..a527a66be9e5 100644
--- a/drivers/iio/iio_core.h
+++ b/drivers/iio/iio_core.h
@@ -40,17 +40,14 @@ ssize_t iio_format_value(char *buf, unsigned int type, int size, int *vals);
 #ifdef CONFIG_IIO_BUFFER
 struct poll_table_struct;
 
-__poll_t iio_buffer_poll(struct file *filp,
-			     struct poll_table_struct *wait);
-ssize_t iio_buffer_read_outer(struct file *filp, char __user *buf,
-			      size_t n, loff_t *f_ps);
+long iio_device_event_ioctl(struct iio_dev *indio_dev, struct file *filp,
+			    unsigned int cmd, unsigned long arg);
+
+void iio_device_buffer_attach_chrdev(struct iio_dev *indio_dev);
 
 int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev);
 void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev);
 
-#define iio_buffer_poll_addr (&iio_buffer_poll)
-#define iio_buffer_read_outer_addr (&iio_buffer_read_outer)
-
 void iio_device_buffers_put(struct iio_dev *indio_dev);
 
 void iio_disable_all_buffers(struct iio_dev *indio_dev);
@@ -58,8 +55,7 @@ void iio_buffer_wakeup_poll(struct iio_dev *indio_dev);
 
 #else
 
-#define iio_buffer_poll_addr NULL
-#define iio_buffer_read_outer_addr NULL
+static inline void iio_device_buffer_attach_chrdev(struct iio_dev *indio_dev) {}
 
 static inline int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
 {
@@ -77,8 +73,8 @@ static inline void iio_buffer_wakeup_poll(struct iio_dev *indio_dev) {}
 
 int iio_device_register_eventset(struct iio_dev *indio_dev);
 void iio_device_unregister_eventset(struct iio_dev *indio_dev);
+void iio_device_event_attach_chrdev(struct iio_dev *indio_dev);
 void iio_device_wakeup_eventset(struct iio_dev *indio_dev);
-int iio_event_getfd(struct iio_dev *indio_dev);
 
 struct iio_event_interface;
 bool iio_event_enabled(const struct iio_event_interface *ev_int);
diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index a66d3fbc2905..f5a975079bf4 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -99,11 +99,11 @@ static bool iio_buffer_ready(struct iio_dev *indio_dev, struct iio_buffer *buf,
  * Return: negative values corresponding to error codes or ret != 0
  *	   for ending the reading activity
  **/
-ssize_t iio_buffer_read_outer(struct file *filp, char __user *buf,
-			      size_t n, loff_t *f_ps)
+static ssize_t iio_buffer_read_outer(struct file *filp, char __user *buf,
+				     size_t n, loff_t *f_ps)
 {
-	struct iio_dev *indio_dev = filp->private_data;
-	struct iio_buffer *rb = indio_dev->buffer;
+	struct iio_buffer *rb = filp->private_data;
+	struct iio_dev *indio_dev = rb->indio_dev;
 	DEFINE_WAIT_FUNC(wait, woken_wake_function);
 	size_t datum_size;
 	size_t to_wait;
@@ -165,11 +165,11 @@ ssize_t iio_buffer_read_outer(struct file *filp, char __user *buf,
  * Return: (EPOLLIN | EPOLLRDNORM) if data is available for reading
  *	   or 0 for other cases
  */
-__poll_t iio_buffer_poll(struct file *filp,
+static __poll_t iio_buffer_poll(struct file *filp,
 			     struct poll_table_struct *wait)
 {
-	struct iio_dev *indio_dev = filp->private_data;
-	struct iio_buffer *rb = indio_dev->buffer;
+	struct iio_buffer *rb = filp->private_data;
+	struct iio_dev *indio_dev = rb->indio_dev;
 
 	if (!indio_dev->info || rb == NULL)
 		return 0;
@@ -180,6 +180,48 @@ __poll_t iio_buffer_poll(struct file *filp,
 	return 0;
 }
 
+/**
+ * iio_buffer_chrdev_open() - chrdev file open for buffer access
+ * @inode:	Inode structure for identifying the device in the file system
+ * @filp:	File structure for iio device used to keep and later access
+ *		private data
+ *
+ * Return: 0 on success or -EBUSY if the device is already opened
+ **/
+static int iio_buffer_chrdev_open(struct inode *inode, struct file *filp)
+{
+	struct iio_buffer *buffer = container_of(inode->i_cdev,
+						 struct iio_buffer, chrdev);
+
+	if (test_and_set_bit(IIO_BUSY_BIT_POS, &buffer->file_ops_flags))
+		return -EBUSY;
+
+	iio_buffer_get(buffer);
+
+	filp->private_data = buffer;
+
+	return 0;
+}
+
+/**
+ * iio_buffer_chrdev_release() - chrdev file close for buffer access
+ * @inode:	Inode structure pointer for the char device
+ * @filp:	File structure pointer for the char device
+ *
+ * Return: 0 for successful release
+ */
+static int iio_buffer_chrdev_release(struct inode *inode, struct file *filp)
+{
+	struct iio_buffer *buffer = container_of(inode->i_cdev,
+						 struct iio_buffer, chrdev);
+
+	clear_bit(IIO_BUSY_BIT_POS, &buffer->file_ops_flags);
+
+	iio_buffer_put(buffer);
+
+	return 0;
+}
+
 /**
  * iio_buffer_wakeup_poll - Wakes up the buffer waitqueue
  * @indio_dev: The IIO device
@@ -1129,6 +1171,17 @@ void iio_disable_all_buffers(struct iio_dev *indio_dev)
 	iio_buffer_deactivate_all(indio_dev);
 }
 
+static long iio_buffer_ioctl(struct file *filep, unsigned int cmd,
+			     unsigned long arg)
+{
+	struct iio_buffer *buffer = filep->private_data;
+
+	if (!buffer || !buffer->access)
+		return -ENODEV;
+
+	return iio_device_event_ioctl(buffer->indio_dev, filep, cmd, arg);
+}
+
 static ssize_t iio_buffer_store_enable(struct device *dev,
 				       struct device_attribute *attr,
 				       const char *buf,
@@ -1355,6 +1408,29 @@ void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev)
 	iio_free_chan_devattr_list(&buffer->scan_el_dev_attr_list);
 }
 
+static const struct file_operations iio_buffer_fileops = {
+	.read = iio_buffer_read_outer,
+	.release = iio_buffer_chrdev_release,
+	.open = iio_buffer_chrdev_open,
+	.poll = iio_buffer_poll,
+	.owner = THIS_MODULE,
+	.llseek = noop_llseek,
+	.unlocked_ioctl = iio_buffer_ioctl,
+	.compat_ioctl = compat_ptr_ioctl,
+};
+
+void iio_device_buffer_attach_chrdev(struct iio_dev *indio_dev)
+{
+	struct iio_buffer *buffer = indio_dev->buffer;
+
+	if (!buffer)
+		return;
+
+	cdev_init(&buffer->chrdev, &iio_buffer_fileops);
+
+	indio_dev->chrdev = &buffer->chrdev;
+}
+
 void iio_device_buffers_put(struct iio_dev *indio_dev)
 {
 	struct iio_buffer *buffer = indio_dev->buffer;
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index a65022396329..aec585cc8453 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1584,79 +1584,6 @@ struct iio_dev *devm_iio_device_alloc(struct device *dev, int sizeof_priv)
 }
 EXPORT_SYMBOL_GPL(devm_iio_device_alloc);
 
-/**
- * iio_chrdev_open() - chrdev file open for buffer access and ioctls
- * @inode:	Inode structure for identifying the device in the file system
- * @filp:	File structure for iio device used to keep and later access
- *		private data
- *
- * Return: 0 on success or -EBUSY if the device is already opened
- **/
-static int iio_chrdev_open(struct inode *inode, struct file *filp)
-{
-	struct iio_dev *indio_dev = container_of(inode->i_cdev,
-						struct iio_dev, chrdev);
-
-	if (test_and_set_bit(IIO_BUSY_BIT_POS, &indio_dev->flags))
-		return -EBUSY;
-
-	iio_device_get(indio_dev);
-
-	filp->private_data = indio_dev;
-
-	return 0;
-}
-
-/**
- * iio_chrdev_release() - chrdev file close buffer access and ioctls
- * @inode:	Inode structure pointer for the char device
- * @filp:	File structure pointer for the char device
- *
- * Return: 0 for successful release
- */
-static int iio_chrdev_release(struct inode *inode, struct file *filp)
-{
-	struct iio_dev *indio_dev = container_of(inode->i_cdev,
-						struct iio_dev, chrdev);
-	clear_bit(IIO_BUSY_BIT_POS, &indio_dev->flags);
-	iio_device_put(indio_dev);
-
-	return 0;
-}
-
-/* Somewhat of a cross file organization violation - ioctls here are actually
- * event related */
-static long iio_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
-{
-	struct iio_dev *indio_dev = filp->private_data;
-	int __user *ip = (int __user *)arg;
-	int fd;
-
-	if (!indio_dev->info)
-		return -ENODEV;
-
-	if (cmd == IIO_GET_EVENT_FD_IOCTL) {
-		fd = iio_event_getfd(indio_dev);
-		if (fd < 0)
-			return fd;
-		if (copy_to_user(ip, &fd, sizeof(fd)))
-			return -EFAULT;
-		return 0;
-	}
-	return -EINVAL;
-}
-
-static const struct file_operations iio_buffer_fileops = {
-	.read = iio_buffer_read_outer_addr,
-	.release = iio_chrdev_release,
-	.open = iio_chrdev_open,
-	.poll = iio_buffer_poll_addr,
-	.owner = THIS_MODULE,
-	.llseek = noop_llseek,
-	.unlocked_ioctl = iio_ioctl,
-	.compat_ioctl = compat_ptr_ioctl,
-};
-
 static int iio_check_unique_scan_index(struct iio_dev *indio_dev)
 {
 	int i, j;
@@ -1682,15 +1609,6 @@ static int iio_check_unique_scan_index(struct iio_dev *indio_dev)
 
 static const struct iio_buffer_setup_ops noop_ring_setup_ops;
 
-static const struct file_operations iio_event_fileops = {
-	.release = iio_chrdev_release,
-	.open = iio_chrdev_open,
-	.owner = THIS_MODULE,
-	.llseek = noop_llseek,
-	.unlocked_ioctl = iio_ioctl,
-	.compat_ioctl = compat_ptr_ioctl,
-};
-
 int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
 {
 	int ret;
@@ -1741,16 +1659,17 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
 		indio_dev->setup_ops == NULL)
 		indio_dev->setup_ops = &noop_ring_setup_ops;
 
-	if (indio_dev->buffer)
-		cdev_init(&indio_dev->chrdev, &iio_buffer_fileops);
-	else if (indio_dev->event_interface)
-		cdev_init(&indio_dev->chrdev, &iio_event_fileops);
+	iio_device_buffer_attach_chrdev(indio_dev);
 
-	indio_dev->chrdev.owner = this_mod;
+	/* no chrdev attached from buffer, we go with event-only chrdev */
+	if (!indio_dev->chrdev)
+		iio_device_event_attach_chrdev(indio_dev);
 
-	if (indio_dev->buffer || indio_dev->event_interface)
-		ret = cdev_device_add(&indio_dev->chrdev, &indio_dev->dev);
-	else
+	if (indio_dev->chrdev) {
+		indio_dev->chrdev->owner = this_mod;
+
+		ret = cdev_device_add(indio_dev->chrdev, &indio_dev->dev);
+	} else
 		ret = device_add(&indio_dev->dev);
 
 	if (ret < 0)
@@ -1776,13 +1695,15 @@ EXPORT_SYMBOL(__iio_device_register);
  **/
 void iio_device_unregister(struct iio_dev *indio_dev)
 {
-	if (indio_dev->buffer || indio_dev->event_interface)
-		cdev_device_del(&indio_dev->chrdev, &indio_dev->dev);
+	if (indio_dev->chrdev)
+		cdev_device_del(indio_dev->chrdev, &indio_dev->dev);
 	else
 		device_del(&indio_dev->dev);
 
 	mutex_lock(&indio_dev->info_exist_lock);
 
+	indio_dev->chrdev = NULL;
+
 	iio_device_unregister_debugfs(indio_dev);
 
 	iio_disable_all_buffers(indio_dev);
diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
index 5b17c92d3b50..0674b2117c98 100644
--- a/drivers/iio/industrialio-event.c
+++ b/drivers/iio/industrialio-event.c
@@ -30,6 +30,8 @@
  * @flags:		file operations related flags including busy flag.
  * @group:		event interface sysfs attribute group
  * @read_lock:		lock to protect kfifo read operations
+ * @chrdev:		associated chardev for this event
+ * @indio_dev:		IIO device to which this event interface belongs to
  */
 struct iio_event_interface {
 	wait_queue_head_t	wait;
@@ -39,6 +41,9 @@ struct iio_event_interface {
 	unsigned long		flags;
 	struct attribute_group	group;
 	struct mutex		read_lock;
+
+	struct cdev		chrdev;
+	struct iio_dev		*indio_dev;
 };
 
 bool iio_event_enabled(const struct iio_event_interface *ev_int)
@@ -182,7 +187,7 @@ static const struct file_operations iio_event_chrdev_fileops = {
 	.llseek = noop_llseek,
 };
 
-int iio_event_getfd(struct iio_dev *indio_dev)
+static int iio_event_getfd(struct iio_dev *indio_dev)
 {
 	struct iio_event_interface *ev_int = indio_dev->event_interface;
 	int fd;
@@ -215,6 +220,97 @@ int iio_event_getfd(struct iio_dev *indio_dev)
 	return fd;
 }
 
+/**
+ * iio_chrdev_open() - chrdev file open for event ioctls
+ * @inode:	Inode structure for identifying the device in the file system
+ * @filp:	File structure for iio device used to keep and later access
+ *		private data
+ *
+ * Return: 0 on success or -EBUSY if the device is already opened
+ **/
+static int iio_chrdev_open(struct inode *inode, struct file *filp)
+{
+	struct iio_event_interface *ev =
+		container_of(inode->i_cdev, struct iio_event_interface, chrdev);
+
+	if (test_and_set_bit(IIO_BUSY_BIT_POS, &ev->flags))
+		return -EBUSY;
+
+	iio_device_get(ev->indio_dev);
+
+	filp->private_data = ev;
+
+	return 0;
+}
+
+/**
+ * iio_chrdev_release() - chrdev file close for event ioctls
+ * @inode:	Inode structure pointer for the char device
+ * @filp:	File structure pointer for the char device
+ *
+ * Return: 0 for successful release
+ */
+static int iio_chrdev_release(struct inode *inode, struct file *filp)
+{
+	struct iio_event_interface *ev =
+		container_of(inode->i_cdev, struct iio_event_interface, chrdev);
+
+	clear_bit(IIO_BUSY_BIT_POS, &ev->flags);
+	iio_device_put(ev->indio_dev);
+
+	return 0;
+}
+
+long iio_device_event_ioctl(struct iio_dev *indio_dev, struct file *filp,
+			    unsigned int cmd, unsigned long arg)
+{
+	int __user *ip = (int __user *)arg;
+	int fd;
+
+	if (!indio_dev->info)
+		return -ENODEV;
+
+	if (cmd == IIO_GET_EVENT_FD_IOCTL) {
+		fd = iio_event_getfd(indio_dev);
+		if (fd < 0)
+			return fd;
+		if (copy_to_user(ip, &fd, sizeof(fd)))
+			return -EFAULT;
+		return 0;
+	}
+	return -EINVAL;
+}
+
+static long iio_event_ioctl_wrapper(struct file *filp, unsigned int cmd,
+				    unsigned long arg)
+{
+	struct iio_event_interface *ev = filp->private_data;
+
+	return iio_device_event_ioctl(ev->indio_dev, filp, cmd, arg);
+}
+
+static const struct file_operations iio_event_fileops = {
+	.release = iio_chrdev_release,
+	.open = iio_chrdev_open,
+	.owner = THIS_MODULE,
+	.llseek = noop_llseek,
+	.unlocked_ioctl = iio_event_ioctl_wrapper,
+	.compat_ioctl = compat_ptr_ioctl,
+};
+
+void iio_device_event_attach_chrdev(struct iio_dev *indio_dev)
+{
+	struct iio_event_interface *ev = indio_dev->event_interface;
+
+	if (!ev)
+		return;
+
+	cdev_init(&ev->chrdev, &iio_event_fileops);
+
+	ev->indio_dev = indio_dev;
+	indio_dev->chrdev = &ev->chrdev;
+}
+
 static const char * const iio_ev_type_text[] = {
 	[IIO_EV_TYPE_THRESH] = "thresh",
 	[IIO_EV_TYPE_MAG] = "mag",
diff --git a/include/linux/iio/buffer_impl.h b/include/linux/iio/buffer_impl.h
index 67d73d465e02..46fc977deae3 100644
--- a/include/linux/iio/buffer_impl.h
+++ b/include/linux/iio/buffer_impl.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _IIO_BUFFER_GENERIC_IMPL_H_
 #define _IIO_BUFFER_GENERIC_IMPL_H_
+#include <linux/cdev.h>
 #include <linux/sysfs.h>
 #include <linux/kref.h>
 
@@ -72,6 +73,12 @@ struct iio_buffer {
 	/** @indio_dev: IIO device to which this buffer belongs to. */
 	struct iio_dev *indio_dev;
 
+	/** @chrdev: associated character device. */
+	struct cdev chrdev;
+
+	/** @file_ops_flags: file ops related flags including busy flag. */
+	unsigned long file_ops_flags;
+
 	/** @length: Number of datums in buffer. */
 	unsigned int length;
 
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 5f9f439a4f01..52992be44e9e 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -516,10 +516,9 @@ struct iio_buffer_setup_ops {
  * @info_exist_lock:	[INTERN] lock to prevent use during removal
  * @setup_ops:		[DRIVER] callbacks to call before and after buffer
  *			enable/disable
- * @chrdev:		[INTERN] associated character device
+ * @chrdev:		[INTERN] reference to associated character device
  * @groups:		[INTERN] attribute groups
  * @groupcounter:	[INTERN] index of next attribute group
- * @flags:		[INTERN] file ops related flags including busy flag.
  * @debugfs_dentry:	[INTERN] device specific debugfs dentry.
  * @cached_reg_addr:	[INTERN] cached register address for debugfs reads.
  */
@@ -559,12 +558,11 @@ struct iio_dev {
 	clockid_t			clock_id;
 	struct mutex			info_exist_lock;
 	const struct iio_buffer_setup_ops	*setup_ops;
-	struct cdev			chrdev;
+	struct cdev			*chrdev;
 #define IIO_MAX_GROUPS 6
 	const struct attribute_group	*groups[IIO_MAX_GROUPS + 1];
 	int				groupcounter;
 
-	unsigned long			flags;
 #if defined(CONFIG_DEBUG_FS)
 	struct dentry			*debugfs_dentry;
 	unsigned			cached_reg_addr;
-- 
2.17.1

