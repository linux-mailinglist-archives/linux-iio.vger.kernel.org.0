Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06522174F4E
	for <lists+linux-iio@lfdr.de>; Sun,  1 Mar 2020 20:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgCAT4c (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Mar 2020 14:56:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:59100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726188AbgCAT4b (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 1 Mar 2020 14:56:31 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24D5F24697;
        Sun,  1 Mar 2020 19:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583092591;
        bh=MacymB2vKUbAqcgzSJx30qCNGZQS5jp0BUtsCj6EcwU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=C1B78bVGAhhxECX3MbAyYPNcMPoZFtHWnwp6S/D4yKlEFLltFuaFgQfvjwVGfUCys
         byMNxjdeEa6ZpWnLF13dcvfyvyV4veSfJ8OyMnmeCl1Ery2CymqN46MGn1Xo4urSJg
         NNw8jftF+BW1qVG0Bk0Kk+4+qzLdDPB5rQvmDMws=
Date:   Sun, 1 Mar 2020 19:56:22 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Tachici <alexandru.tachici@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: Re: [PATCH v2] iio: industrialio-core: Fix debugfs read
Message-ID: <20200301195622.0dfa31fc@archlinux>
In-Reply-To: <20200221120655.20252-1-alexandru.tachici@analog.com>
References: <20200221120655.20252-1-alexandru.tachici@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 21 Feb 2020 14:06:55 +0200
Alexandru Tachici <alexandru.tachici@analog.com> wrote:

> Currently iio_debugfs_read_reg calls debugfs_reg_access
> every time it is ran. Reading the same hardware register
> multiple times during the same reading of a debugfs file
> can cause unintended effects.
> 
> For example for each: cat iio:device0/direct_reg_access
> the file_operations.read function will be called at least
> twice. First will return the full length of the string in
> bytes  and the second will return 0.
> 
> This patch makes iio_debugfs_read_reg to call debugfs_reg_access
> only when the user's buffer position (*ppos) is 0. (meaning
> it is the beginning of a new reading of the debugfs file).
> 
> Fixes: e553f182d55b ("staging: iio: core: Introduce debugfs support, add support for direct register access")
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>

I'm going to take this one via the slow path to give it a bit of time
to soak in linux-next.   I think we are fine for unexpected side effects
but it's been there for a long time so we can take this slowly.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/industrialio-core.c | 15 +++++++++++----
>  include/linux/iio/iio.h         |  2 ++
>  2 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 65ff0d067018..c4d5104934fc 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -301,11 +301,14 @@ static ssize_t iio_debugfs_read_reg(struct file *file, char __user *userbuf,
>  			      size_t count, loff_t *ppos)
>  {
>  	struct iio_dev *indio_dev = file->private_data;
> -	char buf[20];
>  	unsigned val = 0;
> -	ssize_t len;
>  	int ret;
>  
> +	if (*ppos > 0)
> +		return simple_read_from_buffer(userbuf, count, ppos,
> +					       indio_dev->read_buf,
> +					       indio_dev->read_buf_len);
> +
>  	ret = indio_dev->info->debugfs_reg_access(indio_dev,
>  						  indio_dev->cached_reg_addr,
>  						  0, &val);
> @@ -314,9 +317,13 @@ static ssize_t iio_debugfs_read_reg(struct file *file, char __user *userbuf,
>  		return ret;
>  	}
>  
> -	len = snprintf(buf, sizeof(buf), "0x%X\n", val);
> +	indio_dev->read_buf_len = snprintf(indio_dev->read_buf,
> +					   sizeof(indio_dev->read_buf),
> +					   "0x%X\n", val);
>  
> -	return simple_read_from_buffer(userbuf, count, ppos, buf, len);
> +	return simple_read_from_buffer(userbuf, count, ppos,
> +				       indio_dev->read_buf,
> +				       indio_dev->read_buf_len);
>  }
>  
>  static ssize_t iio_debugfs_write_reg(struct file *file,
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 862ce0019eba..eed58ed2f368 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -568,6 +568,8 @@ struct iio_dev {
>  #if defined(CONFIG_DEBUG_FS)
>  	struct dentry			*debugfs_dentry;
>  	unsigned			cached_reg_addr;
> +	char				read_buf[20];
> +	unsigned int			read_buf_len;
>  #endif
>  };
>  

