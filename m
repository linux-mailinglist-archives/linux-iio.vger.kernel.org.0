Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D62F4F4D7
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2019 11:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbfFVJow (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 Jun 2019 05:44:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:60082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbfFVJow (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 Jun 2019 05:44:52 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DBC02084E;
        Sat, 22 Jun 2019 09:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561196691;
        bh=2iD5VH4IjVtegwbp6/w60P+NtFQ7w4htzmDQZSNz8GE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Vj9AEo89UQ4HGnfARmNRpRWDlT40Kp+TF4P5vsHO7yd6N2sDWYDCrBurilw5jEFaM
         o4FTUSk/yNQfHqcjqFPY1HDaoZo+mXQvmVGWPgWuoW826LBpoWJ2ghChEKNV0yD92h
         ol9tJxj2xLq+bGRdDlyaU9aIO76IgGYnuCCT0WMI=
Date:   Sat, 22 Jun 2019 10:44:47 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: core: no need to check return value of
 debugfs_create functions
Message-ID: <20190622104447.37cbdf57@archlinux>
In-Reply-To: <20190618155440.GA20071@kroah.com>
References: <20190618155440.GA20071@kroah.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 18 Jun 2019 17:54:40 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
> 
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Cc: linux-iio@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to poke it a bit.

Thanks,

Jonathan

> ---
>  drivers/iio/industrialio-core.c | 35 ++++++++-------------------------
>  1 file changed, 8 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index f5a4581302f4..503970137590 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -369,39 +369,25 @@ static void iio_device_unregister_debugfs(struct iio_dev *indio_dev)
>  	debugfs_remove_recursive(indio_dev->debugfs_dentry);
>  }
>  
> -static int iio_device_register_debugfs(struct iio_dev *indio_dev)
> +static void iio_device_register_debugfs(struct iio_dev *indio_dev)
>  {
> -	struct dentry *d;
> -
>  	if (indio_dev->info->debugfs_reg_access == NULL)
> -		return 0;
> +		return;
>  
>  	if (!iio_debugfs_dentry)
> -		return 0;
> +		return;
>  
>  	indio_dev->debugfs_dentry =
>  		debugfs_create_dir(dev_name(&indio_dev->dev),
>  				   iio_debugfs_dentry);
> -	if (indio_dev->debugfs_dentry == NULL) {
> -		dev_warn(indio_dev->dev.parent,
> -			 "Failed to create debugfs directory\n");
> -		return -EFAULT;
> -	}
> -
> -	d = debugfs_create_file("direct_reg_access", 0644,
> -				indio_dev->debugfs_dentry,
> -				indio_dev, &iio_debugfs_reg_fops);
> -	if (!d) {
> -		iio_device_unregister_debugfs(indio_dev);
> -		return -ENOMEM;
> -	}
>  
> -	return 0;
> +	debugfs_create_file("direct_reg_access", 0644,
> +			    indio_dev->debugfs_dentry, indio_dev,
> +			    &iio_debugfs_reg_fops);
>  }
>  #else
> -static int iio_device_register_debugfs(struct iio_dev *indio_dev)
> +static void iio_device_register_debugfs(struct iio_dev *indio_dev)
>  {
> -	return 0;
>  }
>  
>  static void iio_device_unregister_debugfs(struct iio_dev *indio_dev)
> @@ -1672,12 +1658,7 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
>  	/* configure elements for the chrdev */
>  	indio_dev->dev.devt = MKDEV(MAJOR(iio_devt), indio_dev->id);
>  
> -	ret = iio_device_register_debugfs(indio_dev);
> -	if (ret) {
> -		dev_err(indio_dev->dev.parent,
> -			"Failed to register debugfs interfaces\n");
> -		return ret;
> -	}
> +	iio_device_register_debugfs(indio_dev);
>  
>  	ret = iio_buffer_alloc_sysfs_and_mask(indio_dev);
>  	if (ret) {

