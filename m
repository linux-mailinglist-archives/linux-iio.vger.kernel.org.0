Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27DD411F8F5
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2019 17:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbfLOQZa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Dec 2019 11:25:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:44954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbfLOQZa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Dec 2019 11:25:30 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB180206D8;
        Sun, 15 Dec 2019 16:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576427129;
        bh=ebPJw78bmW6AgDNVIJTZsDrjNqF2M5C3R6aRahkI0us=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xUNnHJsPTLt7sW2l9INfWsTWbyPB9Ml6zjnI1elhRzG+Koh0H9pRnuUdjvOJUCYsS
         QHslPWNnXhS7ZtkT7LMZL/ZzHjeEIrYW2v5AdrwM8tDwoDLnJ48bcRe6uPMD9o+tsk
         64Kq6SfACHTdnyYKvpL7vBCVv/52fS9k76W7eu8A=
Date:   Sun, 15 Dec 2019 16:25:25 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] iio: core: use debugfs_remove_recursive() on IIO unload
Message-ID: <20191215162525.56516ce4@archlinux>
In-Reply-To: <20191211145903.22395-1-alexandru.ardelean@analog.com>
References: <20191211145903.22395-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 11 Dec 2019 16:59:03 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> From: Lars-Peter Clausen <lars@metafoo.de>
> 
> The debugfs dir may have multiple files/dirs attached to it. Use
> debugfs_remove_recursive() to clean it up when the IIO module unloads.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
> 
> Note: note sure if this needs a Fixes tag. It's been in here for ages now,
>       so it may not be a big issue.

There is some argument in favour of doing this as a defensive measure, but
in current IIO debugfs directories are only created by drivers that call
(indirectly) iio_device_register_debugfs and those must call
(again indirectly) iio_device_unregister_debugfs which has called
the recursive free on everything in their directories.  So unless something
very odd is going on this isn't a bug.

Am I missing something?


> 
>  drivers/iio/industrialio-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 9a3579943574..dab67cb69fe6 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -292,7 +292,7 @@ static void __exit iio_exit(void)
>  	if (iio_devt)
>  		unregister_chrdev_region(iio_devt, IIO_DEV_MAX);
>  	bus_unregister(&iio_bus_type);
> -	debugfs_remove(iio_debugfs_dentry);
> +	debugfs_remove_recursive(iio_debugfs_dentry);
>  }
>  
>  #if defined(CONFIG_DEBUG_FS)

