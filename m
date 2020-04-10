Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB5221A473C
	for <lists+linux-iio@lfdr.de>; Fri, 10 Apr 2020 16:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgDJOQ6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 10 Apr 2020 10:16:58 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:40242 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726687AbgDJOQ5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Apr 2020 10:16:57 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03AEBi5N008078;
        Fri, 10 Apr 2020 10:16:45 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 3091pqsjyh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Apr 2020 10:16:45 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 03AEGi2Z010458
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 10 Apr 2020 10:16:44 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 10 Apr 2020 10:16:43 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 10 Apr 2020 10:16:43 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 10 Apr 2020 10:16:43 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 03AEGZX0028552;
        Fri, 10 Apr 2020 10:16:41 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v3 5/5] iio: event: move event-only chardev in industrialio-event.c
Date:   Fri, 10 Apr 2020 17:17:29 +0300
Message-ID: <20200410141729.82834-6-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200410141729.82834-1-alexandru.ardelean@analog.com>
References: <20200410141729.82834-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-10_05:2020-04-09,2020-04-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 suspectscore=2 malwarescore=0 mlxscore=0 lowpriorityscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004100119
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

At this point, we should be able to move the IIO device's chardev from the
iio_dev struct to the event_interface struct.

The IIO buffer chardev will also take-care of event ioctl() (if it is
initialized. The chardev for the event_interface (which has been moved to
industrialio-event.c) will be initialized only if iio_device_buffers_init()
returns -ENOTSUPP.

This does require an extra pair of iio_device_register_event_chrdev() &
iio_device_unregister_event_chrdev() functions. The
iio_device_register_event_chrdev() should (and will) be  only called if
iio_device_buffers_init() returns -ENOTSUPP.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/iio_core.h           |   5 +-
 drivers/iio/industrialio-core.c  |  94 +-----------------------
 drivers/iio/industrialio-event.c | 122 ++++++++++++++++++++++++++++++-
 include/linux/iio/iio.h          |   6 --
 4 files changed, 128 insertions(+), 99 deletions(-)

diff --git a/drivers/iio/iio_core.h b/drivers/iio/iio_core.h
index 1d69071e1426..2249e5b28023 100644
--- a/drivers/iio/iio_core.h
+++ b/drivers/iio/iio_core.h
@@ -68,10 +68,13 @@ static inline void iio_buffer_wakeup_poll(struct iio_dev *indio_dev) {}
 
 #endif
 
+int iio_device_register_event_chrdev(struct iio_dev *indio_dev,
+				     struct module *this_mod);
+void iio_device_unregister_event_chrdev(struct iio_dev *indio_dev);
+
 int iio_device_register_eventset(struct iio_dev *indio_dev);
 void iio_device_unregister_eventset(struct iio_dev *indio_dev);
 void iio_device_wakeup_eventset(struct iio_dev *indio_dev);
-int iio_event_getfd(struct iio_dev *indio_dev);
 
 struct iio_event_interface;
 bool iio_event_enabled(const struct iio_event_interface *ev_int);
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 794aaa4be832..7d3258f4528b 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1609,76 +1609,6 @@ void devm_iio_device_free(struct device *dev, struct iio_dev *iio_dev)
 }
 EXPORT_SYMBOL_GPL(devm_iio_device_free);
 
-/**
- * iio_chrdev_open() - chrdev file open for event ioctls
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
- * iio_chrdev_release() - chrdev file close for event ioctls
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
-long iio_device_event_ioctl(struct iio_dev *indio_dev, struct file *filp,
-			    unsigned int cmd, unsigned long arg)
-{
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
-/* Somewhat of a cross file organization violation - ioctls here are actually
- * event related */
-static long iio_event_ioctl_wrapper(struct file *filp, unsigned int cmd,
-				    unsigned long arg)
-{
-	struct iio_dev *indio_dev = filp->private_data;
-
-	return iio_device_event_ioctl(indio_dev, filp, cmd, arg);
-}
-
 static int iio_check_unique_scan_index(struct iio_dev *indio_dev)
 {
 	int i, j;
@@ -1704,15 +1634,6 @@ static int iio_check_unique_scan_index(struct iio_dev *indio_dev)
 
 static const struct iio_buffer_setup_ops noop_ring_setup_ops;
 
-static const struct file_operations iio_event_fileops = {
-	.release = iio_chrdev_release,
-	.open = iio_chrdev_open,
-	.owner = THIS_MODULE,
-	.llseek = noop_llseek,
-	.unlocked_ioctl = iio_event_ioctl_wrapper,
-	.compat_ioctl = compat_ptr_ioctl,
-};
-
 int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
 {
 	int ret;
@@ -1761,15 +1682,9 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
 		if (ret != -ENOTSUPP)
 			goto error_unreg_eventset;
 
-		cdev_init(&indio_dev->chrdev, &iio_event_fileops);
-
-		indio_dev->chrdev.owner = this_mod;
-
-		ret = cdev_device_add(&indio_dev->chrdev, &indio_dev->dev);
-		if (ret < 0)
+		ret = iio_device_register_event_chrdev(indio_dev, this_mod);
+		if (ret)
 			goto error_unreg_eventset;
-
-		indio_dev->chrdev_initialized = true;
 	}
 
 	return 0;
@@ -1789,10 +1704,7 @@ EXPORT_SYMBOL(__iio_device_register);
  **/
 void iio_device_unregister(struct iio_dev *indio_dev)
 {
-	if (indio_dev->chrdev_initialized)
-		cdev_device_del(&indio_dev->chrdev, &indio_dev->dev);
-
-	indio_dev->chrdev_initialized = false;
+	iio_device_unregister_event_chrdev(indio_dev);
 
 	iio_device_buffers_uninit(indio_dev);
 
diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
index 5b17c92d3b50..da01c8c38f21 100644
--- a/drivers/iio/industrialio-event.c
+++ b/drivers/iio/industrialio-event.c
@@ -30,6 +30,9 @@
  * @flags:		file operations related flags including busy flag.
  * @group:		event interface sysfs attribute group
  * @read_lock:		lock to protect kfifo read operations
+ * @chrdev:		associated chardev for this event
+ * @chrdev_initialized:	true if this @chrdev was initialized
+ * @indio_dev:		IIO device to which this event interface belongs to
  */
 struct iio_event_interface {
 	wait_queue_head_t	wait;
@@ -39,6 +42,10 @@ struct iio_event_interface {
 	unsigned long		flags;
 	struct attribute_group	group;
 	struct mutex		read_lock;
+
+	struct cdev		chrdev;
+	bool			chrdev_initialized;
+	struct iio_dev		*indio_dev;
 };
 
 bool iio_event_enabled(const struct iio_event_interface *ev_int)
@@ -182,7 +189,7 @@ static const struct file_operations iio_event_chrdev_fileops = {
 	.llseek = noop_llseek,
 };
 
-int iio_event_getfd(struct iio_dev *indio_dev)
+static int iio_event_getfd(struct iio_dev *indio_dev)
 {
 	struct iio_event_interface *ev_int = indio_dev->event_interface;
 	int fd;
@@ -215,6 +222,119 @@ int iio_event_getfd(struct iio_dev *indio_dev)
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
+static const struct file_operations iio_device_event_fileops = {
+	.release = iio_chrdev_release,
+	.open = iio_chrdev_open,
+	.owner = THIS_MODULE,
+	.llseek = noop_llseek,
+	.unlocked_ioctl = iio_event_ioctl_wrapper,
+	.compat_ioctl = compat_ptr_ioctl,
+};
+
+int iio_device_register_event_chrdev(struct iio_dev *indio_dev,
+				     struct module *this_mod)
+{
+	struct iio_event_interface *ev = indio_dev->event_interface;
+	int ret;
+
+	if (!ev)
+		return 0;
+
+	cdev_init(&ev->chrdev, &iio_device_event_fileops);
+
+	ev->chrdev.owner = this_mod;
+
+	ret = cdev_device_add(&ev->chrdev, &indio_dev->dev);
+	if (ret < 0)
+		return ret;
+
+	ev->chrdev_initialized = true;
+
+	return 0;
+}
+
+void iio_device_unregister_event_chrdev(struct iio_dev *indio_dev)
+{
+	struct iio_event_interface *ev = indio_dev->event_interface;
+
+	if (!ev)
+		return;
+
+	if (ev->chrdev_initialized)
+		cdev_device_del(&ev->chrdev, &indio_dev->dev);
+
+	ev->chrdev_initialized = false;
+}
+
 static const char * const iio_ev_type_text[] = {
 	[IIO_EV_TYPE_THRESH] = "thresh",
 	[IIO_EV_TYPE_MAG] = "mag",
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index e93497f483f7..8fa22e4e246f 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -516,11 +516,8 @@ struct iio_buffer_setup_ops {
  * @info_exist_lock:	[INTERN] lock to prevent use during removal
  * @setup_ops:		[DRIVER] callbacks to call before and after buffer
  *			enable/disable
- * @chrdev:		[INTERN] associated character device
- * @chrdev_initialized:	[INTERN] true if @chrdev device has been initialized
  * @groups:		[INTERN] attribute groups
  * @groupcounter:	[INTERN] index of next attribute group
- * @flags:		[INTERN] file ops related flags including busy flag.
  * @debugfs_dentry:	[INTERN] device specific debugfs dentry.
  * @cached_reg_addr:	[INTERN] cached register address for debugfs reads.
  */
@@ -560,13 +557,10 @@ struct iio_dev {
 	clockid_t			clock_id;
 	struct mutex			info_exist_lock;
 	const struct iio_buffer_setup_ops	*setup_ops;
-	struct cdev			chrdev;
-	int				chrdev_initialized;
 #define IIO_MAX_GROUPS 6
 	const struct attribute_group	*groups[IIO_MAX_GROUPS + 1];
 	int				groupcounter;
 
-	unsigned long			flags;
 #if defined(CONFIG_DEBUG_FS)
 	struct dentry			*debugfs_dentry;
 	unsigned			cached_reg_addr;
-- 
2.17.1

