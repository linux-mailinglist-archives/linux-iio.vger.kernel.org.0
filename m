Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8776E37A861
	for <lists+linux-iio@lfdr.de>; Tue, 11 May 2021 16:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbhEKOEk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 May 2021 10:04:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:43590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231704AbhEKOEd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 11 May 2021 10:04:33 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB0206192E;
        Tue, 11 May 2021 14:03:25 +0000 (UTC)
Date:   Tue, 11 May 2021 15:04:32 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     srf@canb.auug.org.au, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org
Subject: Conflict for tomorrows linux-next between staging/staging-linus and
 iio/togreg
Message-ID: <20210511150432.3045a3f8@jic23-huawei>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi stephen

Heads up that I've just pushed out iio/togreg and that will conflict
with staging/staging-linus (and iio/fixes-togreg)

I'll rebase to fix this cleanly once rc2 is out.

Sorry for the noise in the meantime.

Resolution I would suggest looks like:

commit 7cf1fe472df0d6dbddb44a7996efa5245884fa55 (HEAD -> check)
Merge: ba9c25d94dea 68068fad0e1c
Author: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date:   Tue May 11 14:50:16 2021 +0100

    Merge branch 'togreg' into check

diff --cc drivers/iio/industrialio-core.c
index 59efb36db2c7,efb4cf91c9e4..bfa20a346f71
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@@ -1785,10 -1811,10 +1810,10 @@@ static long iio_ioctl(struct file *filp
        }
  
        if (ret == IIO_IOCTL_UNHANDLED)
 -              ret = -EINVAL;
 +              ret = -ENODEV;
  
  out_unlock:
-       mutex_unlock(&indio_dev->info_exist_lock);
+       mutex_unlock(&iio_dev_opaque->info_exist_lock);
  
        return ret;
  }
@@@ -1925,9 -1951,12 +1950,11 @@@ EXPORT_SYMBOL(__iio_device_register)
   **/
  void iio_device_unregister(struct iio_dev *indio_dev)
  {
-       cdev_device_del(&indio_dev->chrdev, &indio_dev->dev);
+       struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 -      struct iio_ioctl_handler *h, *t;
  
-       mutex_lock(&indio_dev->info_exist_lock);
+       cdev_device_del(&iio_dev_opaque->chrdev, &indio_dev->dev);
+ 
+       mutex_lock(&iio_dev_opaque->info_exist_lock);
  
        iio_device_unregister_debugfs(indio_dev);
