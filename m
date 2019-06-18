Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3353A4A5EA
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2019 17:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729209AbfFRPyn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 Jun 2019 11:54:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:39560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729189AbfFRPyn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 18 Jun 2019 11:54:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43B52213F2;
        Tue, 18 Jun 2019 15:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560873282;
        bh=Df3tc5L/PDmS6+eHgeMCqR5DooYjYgVv9we8HKrDk+g=;
        h=Date:From:To:Cc:Subject:From;
        b=xqC8ewjdJ7M6IbXR5hSy6QOdkXcAwDqWMns2HVjSU6a/7h/P+6rM/Sh0fPHdEaQ+Y
         Ku+pdba9vNOll4goJuUwYLGQ8GgF6xn95wgF/a+e1690xh2E7wfNxm8y3S5Rj3Kd/k
         WZLIhXCImneCyU1F+SPLkAacTJEsaHR8rLSHjRhA=
Date:   Tue, 18 Jun 2019 17:54:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-iio@vger.kernel.org
Subject: [PATCH] iio: core: no need to check return value of debugfs_create
 functions
Message-ID: <20190618155440.GA20071@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/industrialio-core.c | 35 ++++++++-------------------------
 1 file changed, 8 insertions(+), 27 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index f5a4581302f4..503970137590 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -369,39 +369,25 @@ static void iio_device_unregister_debugfs(struct iio_dev *indio_dev)
 	debugfs_remove_recursive(indio_dev->debugfs_dentry);
 }
 
-static int iio_device_register_debugfs(struct iio_dev *indio_dev)
+static void iio_device_register_debugfs(struct iio_dev *indio_dev)
 {
-	struct dentry *d;
-
 	if (indio_dev->info->debugfs_reg_access == NULL)
-		return 0;
+		return;
 
 	if (!iio_debugfs_dentry)
-		return 0;
+		return;
 
 	indio_dev->debugfs_dentry =
 		debugfs_create_dir(dev_name(&indio_dev->dev),
 				   iio_debugfs_dentry);
-	if (indio_dev->debugfs_dentry == NULL) {
-		dev_warn(indio_dev->dev.parent,
-			 "Failed to create debugfs directory\n");
-		return -EFAULT;
-	}
-
-	d = debugfs_create_file("direct_reg_access", 0644,
-				indio_dev->debugfs_dentry,
-				indio_dev, &iio_debugfs_reg_fops);
-	if (!d) {
-		iio_device_unregister_debugfs(indio_dev);
-		return -ENOMEM;
-	}
 
-	return 0;
+	debugfs_create_file("direct_reg_access", 0644,
+			    indio_dev->debugfs_dentry, indio_dev,
+			    &iio_debugfs_reg_fops);
 }
 #else
-static int iio_device_register_debugfs(struct iio_dev *indio_dev)
+static void iio_device_register_debugfs(struct iio_dev *indio_dev)
 {
-	return 0;
 }
 
 static void iio_device_unregister_debugfs(struct iio_dev *indio_dev)
@@ -1672,12 +1658,7 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
 	/* configure elements for the chrdev */
 	indio_dev->dev.devt = MKDEV(MAJOR(iio_devt), indio_dev->id);
 
-	ret = iio_device_register_debugfs(indio_dev);
-	if (ret) {
-		dev_err(indio_dev->dev.parent,
-			"Failed to register debugfs interfaces\n");
-		return ret;
-	}
+	iio_device_register_debugfs(indio_dev);
 
 	ret = iio_buffer_alloc_sysfs_and_mask(indio_dev);
 	if (ret) {
-- 
2.22.0

