Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1379E36B856
	for <lists+linux-iio@lfdr.de>; Mon, 26 Apr 2021 19:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234754AbhDZRv1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Apr 2021 13:51:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:48512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237645AbhDZRvZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 26 Apr 2021 13:51:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A99F661007;
        Mon, 26 Apr 2021 17:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619459443;
        bh=S6IA0jORHg5jGpkyFVGHI27KVXAzfeS7TuXtyYHPxQc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KvHUQ6ffse7PCrcRdqJ0/RthgxY1RavXwkS5UeQFCdLFAN6hB8a80E2cv4JcvrK6f
         dUT7Oy8FJnCHeoFAk5daCbRYnDSTkgFVQR79Enpywl+mL3fc9pvhM6o4DkyScSuYyG
         08Vl39jZsT4ixeCWRWUpn4PXOisjlx2cjE8xeKHO+Aq5gwOtDLJrVJ77R7HqpKLJ0O
         bBWou8Daw5MLNtw5LqBscSMwRKjckvSnva730hxwejxPBMEqW4IuMaL1yrawX8gbTB
         FopV7LUXHi3XMo6n1yoG40p+7xhroaqPHWRoiSFOvl920l3SJH9Odu0gV3ioJ3Ebuz
         pLk5OiHrGRhZQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 7/9] iio: core: move @chrdev from struct iio_dev to struct iio_dev_opaque
Date:   Mon, 26 Apr 2021 18:49:09 +0100
Message-Id: <20210426174911.397061-8-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210426174911.397061-1-jic23@kernel.org>
References: <20210426174911.397061-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

No reason for this to be exposed to the drivers, so lets move it to the
opaque structure.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/industrialio-core.c | 20 +++++++++++---------
 include/linux/iio/iio-opaque.h  |  2 ++
 include/linux/iio/iio.h         |  2 --
 3 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index f3b38d69b7e1..6fbe29f0b1de 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1715,8 +1715,9 @@ EXPORT_SYMBOL_GPL(devm_iio_device_alloc);
  **/
 static int iio_chrdev_open(struct inode *inode, struct file *filp)
 {
-	struct iio_dev *indio_dev = container_of(inode->i_cdev,
-						struct iio_dev, chrdev);
+	struct iio_dev_opaque *iio_dev_opaque =
+		container_of(inode->i_cdev, struct iio_dev_opaque, chrdev);
+	struct iio_dev *indio_dev = &iio_dev_opaque->indio_dev;
 	struct iio_dev_buffer_pair *ib;
 
 	if (test_and_set_bit(IIO_BUSY_BIT_POS, &indio_dev->flags))
@@ -1749,8 +1750,9 @@ static int iio_chrdev_open(struct inode *inode, struct file *filp)
 static int iio_chrdev_release(struct inode *inode, struct file *filp)
 {
 	struct iio_dev_buffer_pair *ib = filp->private_data;
-	struct iio_dev *indio_dev = container_of(inode->i_cdev,
-						struct iio_dev, chrdev);
+	struct iio_dev_opaque *iio_dev_opaque =
+		container_of(inode->i_cdev, struct iio_dev_opaque, chrdev);
+	struct iio_dev *indio_dev = &iio_dev_opaque->indio_dev;
 	kfree(ib);
 	clear_bit(IIO_BUSY_BIT_POS, &indio_dev->flags);
 	iio_device_put(indio_dev);
@@ -1901,19 +1903,19 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
 		indio_dev->setup_ops = &noop_ring_setup_ops;
 
 	if (iio_dev_opaque->attached_buffers_cnt)
-		cdev_init(&indio_dev->chrdev, &iio_buffer_fileops);
+		cdev_init(&iio_dev_opaque->chrdev, &iio_buffer_fileops);
 	else if (iio_dev_opaque->event_interface)
-		cdev_init(&indio_dev->chrdev, &iio_event_fileops);
+		cdev_init(&iio_dev_opaque->chrdev, &iio_event_fileops);
 
 	if (iio_dev_opaque->attached_buffers_cnt || iio_dev_opaque->event_interface) {
 		indio_dev->dev.devt = MKDEV(MAJOR(iio_devt), iio_dev_opaque->id);
-		indio_dev->chrdev.owner = this_mod;
+		iio_dev_opaque->chrdev.owner = this_mod;
 	}
 
 	/* assign device groups now; they should be all registered now */
 	indio_dev->dev.groups = iio_dev_opaque->groups;
 
-	ret = cdev_device_add(&indio_dev->chrdev, &indio_dev->dev);
+	ret = cdev_device_add(&iio_dev_opaque->chrdev, &indio_dev->dev);
 	if (ret < 0)
 		goto error_unreg_eventset;
 
@@ -1940,7 +1942,7 @@ void iio_device_unregister(struct iio_dev *indio_dev)
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 	struct iio_ioctl_handler *h, *t;
 
-	cdev_device_del(&indio_dev->chrdev, &indio_dev->dev);
+	cdev_device_del(&iio_dev_opaque->chrdev, &indio_dev->dev);
 
 	mutex_lock(&iio_dev_opaque->info_exist_lock);
 
diff --git a/include/linux/iio/iio-opaque.h b/include/linux/iio/iio-opaque.h
index 538b4b5ef1a9..2f8ef5d15a66 100644
--- a/include/linux/iio/iio-opaque.h
+++ b/include/linux/iio/iio-opaque.h
@@ -24,6 +24,7 @@
  * @legacy_scan_el_group:	attribute group for legacy scan elements attribute group
  * @legacy_buffer_group:	attribute group for legacy buffer attributes group
  * @scan_index_timestamp:	cache of the index to the timestamp
+ * @chrdev:			associated character device
  * @debugfs_dentry:		device specific debugfs dentry
  * @cached_reg_addr:		cached register address for debugfs reads
  * @read_buf:			read buffer to be used for the initial reg read
@@ -49,6 +50,7 @@ struct iio_dev_opaque {
 	struct attribute_group		legacy_buffer_group;
 
 	unsigned int			scan_index_timestamp;
+	struct cdev			chrdev;
 
 #if defined(CONFIG_DEBUG_FS)
 	struct dentry			*debugfs_dentry;
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index a12bbd8b1e74..586e2dc4fbf3 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -512,7 +512,6 @@ struct iio_buffer_setup_ops {
  * @clock_id:		[INTERN] timestamping clock posix identifier
  * @setup_ops:		[DRIVER] callbacks to call before and after buffer
  *			enable/disable
- * @chrdev:		[INTERN] associated character device
  * @flags:		[INTERN] file ops related flags including busy flag.
  * @priv:		[DRIVER] reference to driver's private information
  *			**MUST** be accessed **ONLY** via iio_priv() helper
@@ -542,7 +541,6 @@ struct iio_dev {
 	const struct iio_info		*info;
 	clockid_t			clock_id;
 	const struct iio_buffer_setup_ops	*setup_ops;
-	struct cdev			chrdev;
 
 	unsigned long			flags;
 	void				*priv;
-- 
2.31.1

