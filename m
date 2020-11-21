Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D97322BC0A0
	for <lists+linux-iio@lfdr.de>; Sat, 21 Nov 2020 17:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgKUQtI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Nov 2020 11:49:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:60148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbgKUQtH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Nov 2020 11:49:07 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF82622206;
        Sat, 21 Nov 2020 16:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605977347;
        bh=rpZ4lK3MpJuSIHFUJum72piJ4vu3EBObuy5oBBIKPaE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xVtXLqaJd0/ni+SSEfxhohjJK9bB2EuLfSic0FjmdU0gyRDtJ66TK1mZYQsb/tKWu
         Gk/tf/RrUF/RJHar2kuo1Ar+tblAARq7v4IyGGw8DvM1DE2ia6mlQI8zqDQoyuyG4m
         ycGFL21cKB1otYAkHSJ4+mbqWTGdKktAI2xUeqlA=
Date:   Sat, 21 Nov 2020 16:49:00 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: core: return -EINVAL when no ioctl handler has
 been run
Message-ID: <20201121164900.10517348@archlinux>
In-Reply-To: <20201117095154.7189-1-alexandru.ardelean@analog.com>
References: <20201117095154.7189-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 17 Nov 2020 11:51:54 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> It seems that when this was tested the happy case was more tested. A few of
> the userspace apps rely on this returning negative error codes in case an
> ioctl() is not available.
> 
> When running multiple ioctl() handlers or when calling an ioctl() that
> doesn't exist, IIO_IOCTL_UNHANDLED is returned. In that case -EINVAL should
> be returned.
> 
> Fixes: 8dedcc3eee3a ("iio: core: centralize ioctl() calls to the main chardev")
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied.

Thanks,

Jonathan

> ---
> 
> Apologies for not noticing this earlier.
> This came up when trying to write more IIO buffer code.
> 
> From my side either is fine: whether it be applied as a fix or whether
> it's squashed into the original patch.
> 
>  drivers/iio/industrialio-core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index e53c771d66eb..419d6f8acc13 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1743,6 +1743,9 @@ static long iio_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  			break;
>  	}
>  
> +	if (ret == IIO_IOCTL_UNHANDLED)
> +		ret = -EINVAL;
> +
>  out_unlock:
>  	mutex_unlock(&indio_dev->info_exist_lock);
>  

