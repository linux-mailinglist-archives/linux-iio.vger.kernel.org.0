Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E94236B857
	for <lists+linux-iio@lfdr.de>; Mon, 26 Apr 2021 19:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237515AbhDZRv1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Apr 2021 13:51:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:48526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237557AbhDZRv1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 26 Apr 2021 13:51:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6A4F5613BA;
        Mon, 26 Apr 2021 17:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619459445;
        bh=Ewu2A1EUpUcpA6v/3YvAk39V1hiR+pBnERol3CgoKrU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tuAHp3j7+Z5XFITNYVkCCaqF4FEFSb3/20TPOsgQsK6FJ05RznNFZzpmq0kTbtbse
         2/0CqUYmsEM1zhF38PkE6RmF9Xs2Kma28zseO79PooTxDB6g6qeica5dnN8QgynoDM
         NwKBcxpsvtidVkZ9BYS9iuRHHWvK+vlpXS4tuSQdYjd3yzWyZx0GZfeamR5XX8oI5E
         rTqz9GGy0qEOsfJwa3TpkMmUAkpxZC3te7cdIGewQdlCjnVtXsYS6E9lnhgv8a7aRK
         73F6h7mQJysqvjTtOgD3thChTDDQdMQGoO/EzC4lBU/9LGkG6WJHAm85Z4UjHOZ6Z6
         4in3RTIBEDGyQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 8/9] iio: core: move @flags from struct iio_dev to struct iio_dev_opaque
Date:   Mon, 26 Apr 2021 18:49:10 +0100
Message-Id: <20210426174911.397061-9-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210426174911.397061-1-jic23@kernel.org>
References: <20210426174911.397061-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

No reason any driver should ever need access to this field, so hide it.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/industrialio-core.c | 6 +++---
 include/linux/iio/iio-opaque.h  | 2 ++
 include/linux/iio/iio.h         | 2 --
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 6fbe29f0b1de..4a4c02fea152 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1720,7 +1720,7 @@ static int iio_chrdev_open(struct inode *inode, struct file *filp)
 	struct iio_dev *indio_dev = &iio_dev_opaque->indio_dev;
 	struct iio_dev_buffer_pair *ib;
 
-	if (test_and_set_bit(IIO_BUSY_BIT_POS, &indio_dev->flags))
+	if (test_and_set_bit(IIO_BUSY_BIT_POS, &iio_dev_opaque->flags))
 		return -EBUSY;
 
 	iio_device_get(indio_dev);
@@ -1728,7 +1728,7 @@ static int iio_chrdev_open(struct inode *inode, struct file *filp)
 	ib = kmalloc(sizeof(*ib), GFP_KERNEL);
 	if (!ib) {
 		iio_device_put(indio_dev);
-		clear_bit(IIO_BUSY_BIT_POS, &indio_dev->flags);
+		clear_bit(IIO_BUSY_BIT_POS, &iio_dev_opaque->flags);
 		return -ENOMEM;
 	}
 
@@ -1754,7 +1754,7 @@ static int iio_chrdev_release(struct inode *inode, struct file *filp)
 		container_of(inode->i_cdev, struct iio_dev_opaque, chrdev);
 	struct iio_dev *indio_dev = &iio_dev_opaque->indio_dev;
 	kfree(ib);
-	clear_bit(IIO_BUSY_BIT_POS, &indio_dev->flags);
+	clear_bit(IIO_BUSY_BIT_POS, &iio_dev_opaque->flags);
 	iio_device_put(indio_dev);
 
 	return 0;
diff --git a/include/linux/iio/iio-opaque.h b/include/linux/iio/iio-opaque.h
index 2f8ef5d15a66..d7c3036861ac 100644
--- a/include/linux/iio/iio-opaque.h
+++ b/include/linux/iio/iio-opaque.h
@@ -25,6 +25,7 @@
  * @legacy_buffer_group:	attribute group for legacy buffer attributes group
  * @scan_index_timestamp:	cache of the index to the timestamp
  * @chrdev:			associated character device
+ * @flags:			file ops related flags including busy flag.
  * @debugfs_dentry:		device specific debugfs dentry
  * @cached_reg_addr:		cached register address for debugfs reads
  * @read_buf:			read buffer to be used for the initial reg read
@@ -51,6 +52,7 @@ struct iio_dev_opaque {
 
 	unsigned int			scan_index_timestamp;
 	struct cdev			chrdev;
+	unsigned long			flags;
 
 #if defined(CONFIG_DEBUG_FS)
 	struct dentry			*debugfs_dentry;
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 586e2dc4fbf3..ed0537015eee 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -512,7 +512,6 @@ struct iio_buffer_setup_ops {
  * @clock_id:		[INTERN] timestamping clock posix identifier
  * @setup_ops:		[DRIVER] callbacks to call before and after buffer
  *			enable/disable
- * @flags:		[INTERN] file ops related flags including busy flag.
  * @priv:		[DRIVER] reference to driver's private information
  *			**MUST** be accessed **ONLY** via iio_priv() helper
  */
@@ -542,7 +541,6 @@ struct iio_dev {
 	clockid_t			clock_id;
 	const struct iio_buffer_setup_ops	*setup_ops;
 
-	unsigned long			flags;
 	void				*priv;
 };
 
-- 
2.31.1

