Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5439720C320
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jun 2020 18:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbgF0Qlz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Jun 2020 12:41:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:53802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725831AbgF0Qlz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 27 Jun 2020 12:41:55 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A16CD20674;
        Sat, 27 Jun 2020 16:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593276114;
        bh=bSLnyIaoKyTQEN4GDFuq4ZfjalH/3kAFHgfVvrl4EhQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bXMQ/QgVc74fOrJft265se1w+B0P5fCbE6Y2TNeljfbS9ig51sK3lnKPRWgx02WQ8
         1NNQ7JhECaxa9QxMMtgHD8KJo7FeH7qbh3OzNakaYvsarPnLdZjmpXZHu3kbPMul2w
         jnWQKfGgg0B+RvPpmtSVKNQ5YyFcj5WvEF0n0y2Y=
Date:   Sat, 27 Jun 2020 17:41:50 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>, <knaack.h@gmx.de>
Subject: Re: [PATCH v3 3/7] iio: core: remove padding from private
 information
Message-ID: <20200627174150.30d8f630@archlinux>
In-Reply-To: <20200621123345.2469-4-alexandru.ardelean@analog.com>
References: <20200621123345.2469-1-alexandru.ardelean@analog.com>
        <20200621123345.2469-4-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 21 Jun 2020 15:33:41 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> There was a recent discussion about this code:
>   https://lore.kernel.org/linux-iio/20200322165317.0b1f0674@archlinux/
> 
> This looks like a good time to removed this, since any issues about it
> should pop-up under testing, because the iio_dev is having a bit of an
> overhaul and stuff being moved to iio_dev_opaque.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
*crosses fingers*

Applied to the togreg branch of iio.git and pushed out as testing.

Jonathan

> ---
>  drivers/iio/industrialio-core.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 33e2953cf021..27005ba4d09c 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1507,8 +1507,6 @@ struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv)
>  		alloc_size = ALIGN(alloc_size, IIO_ALIGN);
>  		alloc_size += sizeof_priv;
>  	}
> -	/* ensure 32-byte alignment of whole construct ? */
> -	alloc_size += IIO_ALIGN - 1;
>  
>  	iio_dev_opaque = kzalloc(alloc_size, GFP_KERNEL);
>  	if (!iio_dev_opaque)

