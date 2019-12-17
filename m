Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E344123001
	for <lists+linux-iio@lfdr.de>; Tue, 17 Dec 2019 16:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbfLQPTn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Dec 2019 10:19:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:56038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728227AbfLQPTn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 17 Dec 2019 10:19:43 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E188206A5;
        Tue, 17 Dec 2019 15:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576595982;
        bh=K3G4TQZr7CYHmEJwoV7I2f70tg7GGFtXgrXSz/VHhVA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HzsVL0/VBaicl1VLel0zxkkX6nH5/SKo6OtcFJXfjdk/C/FJ6J/Dymf+7uqRKkB6E
         Tg/cCyJEdvPfqOgErNyOziApd8aCCSeICOHC4wcFECxzg+0Z5gCMr9YO0Vsi4KVfhb
         Kp8nWv1fsPObJbgsS/OmlynFml+xC9SLHTj5i8m8=
Date:   Tue, 17 Dec 2019 16:19:40 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        jic23@kernel.org, Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: [PATCH] iio: core: print error message on debugfs register
 failure
Message-ID: <20191217151940.GB3654493@kroah.com>
References: <20191211151636.13547-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211151636.13547-1-alexandru.ardelean@analog.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Dec 11, 2019 at 05:16:36PM +0200, Alexandru Ardelean wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> If there's a failure when registering a debugfs entry for a device, don't
> silently ignore the failure. Instead, print an error message and an error
> code signaling the failure.

No, never do that.

> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  drivers/iio/industrialio-core.c | 34 +++++++++++++++++++++++++++------
>  1 file changed, 28 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index dab67cb69fe6..662dabf8b08c 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -364,23 +364,45 @@ static const struct file_operations iio_debugfs_reg_fops = {
>  static void iio_device_unregister_debugfs(struct iio_dev *indio_dev)
>  {
>  	debugfs_remove_recursive(indio_dev->debugfs_dentry);
> +	indio_dev->debugfs_dentry = NULL;
>  }
>  
>  static void iio_device_register_debugfs(struct iio_dev *indio_dev)
>  {
> +	struct dentry *d;
> +	int ret;
> +
>  	if (indio_dev->info->debugfs_reg_access == NULL)
>  		return;
>  
>  	if (!iio_debugfs_dentry)
>  		return;
>  
> -	indio_dev->debugfs_dentry =
> -		debugfs_create_dir(dev_name(&indio_dev->dev),
> -				   iio_debugfs_dentry);
> +	d = debugfs_create_dir(dev_name(&indio_dev->dev), iio_debugfs_dentry);
> +	if (IS_ERR_OR_NULL(d))
> +		goto error;

No, don't do that, I spent a lot of time removing all of these pointless
checks.

No kernel code shoudl ever care if debugfs is workign or not, just make
the call and move on.   You can always pass the result of a debugfs call
into another one with no problems.

> +
> +	indio_dev->debugfs_dentry = d;
> +
> +	d = debugfs_create_file("direct_reg_access", 0644,
> +				indio_dev->debugfs_dentry, indio_dev,
> +				&iio_debugfs_reg_fops);
> +
> +	if (IS_ERR_OR_NULL(d))
> +		goto error;

This check isn't even correct :)

So this isn't going to work no matter what, sorry.

just don't do this.

The code is just fine as-is.

thanks,

greg k-h
