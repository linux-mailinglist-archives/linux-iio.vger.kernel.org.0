Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C032F1D62CA
	for <lists+linux-iio@lfdr.de>; Sat, 16 May 2020 18:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbgEPQ5w (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 May 2020 12:57:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:40194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726237AbgEPQ5t (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 May 2020 12:57:49 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A6692065C;
        Sat, 16 May 2020 16:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589648269;
        bh=yrEFJDYoN/FggKDClCKUlGRV30ppunF5ObL3yT+UHMY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=i1r0eFRS1CrTWaTLh2ht841l38l415ZP6vkYFqps0X1ffld5qxhfkEAkZkj2eoNcx
         rUs8Dub27QzwyG8FS2PMJMcyGEHVV/rhq612jj3tEuG4GuYk0iahLRydK2PjYr4nDO
         kjCqxoYjGxiHfNLnb1wTJN3AsphphKhu5CeLEYLY=
Date:   Sat, 16 May 2020 17:57:42 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: buffer: remove attrcount_orig var from sysfs
 creation
Message-ID: <20200516175742.192853f5@archlinux>
In-Reply-To: <20200511125322.17147-1-alexandru.ardelean@analog.com>
References: <20200511125322.17147-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 11 May 2020 15:53:22 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> The variable no longer does anything.
> It should have been removed with commit 2e036804d773e ("iio: buffer: remove
> 'scan_el_attrs' attribute group from buffer struct").
> That was about the last time this was needed.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to hopefully not notice it.

Thanks,

Jonathan

> ---
> 
> If desired (and still possible) this can be squashed in
> commit 2e036804d773e ("iio: buffer: remove 'scan_el_attrs' attribute group
> from buffer struct").
> 
>  drivers/iio/industrialio-buffer.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index eae39eaf49af..386c9231c2ee 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -1244,7 +1244,7 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
>  	struct iio_dev_attr *p;
>  	struct attribute **attr;
>  	struct iio_buffer *buffer = indio_dev->buffer;
> -	int ret, i, attrn, attrcount, attrcount_orig = 0;
> +	int ret, i, attrn, attrcount;
>  	const struct iio_chan_spec *channels;
>  
>  	channels = indio_dev->channels;
> @@ -1288,7 +1288,7 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
>  
>  	indio_dev->groups[indio_dev->groupcounter++] = &buffer->buffer_group;
>  
> -	attrcount = attrcount_orig;
> +	attrcount = 0;
>  	INIT_LIST_HEAD(&buffer->scan_el_dev_attr_list);
>  	channels = indio_dev->channels;
>  	if (channels) {
> @@ -1325,7 +1325,7 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
>  		ret = -ENOMEM;
>  		goto error_free_scan_mask;
>  	}
> -	attrn = attrcount_orig;
> +	attrn = 0;
>  
>  	list_for_each_entry(p, &buffer->scan_el_dev_attr_list, l)
>  		buffer->scan_el_group.attrs[attrn++] = &p->dev_attr.attr;

