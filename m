Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A84A81A5DF2
	for <lists+linux-iio@lfdr.de>; Sun, 12 Apr 2020 12:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbgDLKC5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Apr 2020 06:02:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:47228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgDLKC4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 12 Apr 2020 06:02:56 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17ED4206DA;
        Sun, 12 Apr 2020 10:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586685776;
        bh=3TI71pGqOglXGFWs6U3O6CSa3M5ETRL11QWYGd3ewkE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=i6QVA8dj6M3c3VK5zilZuC/jPe7zozoMAcnM5E/rNxERDQiiNMUSKJRrCvy2jMksY
         QO/H0IVWWwUu7/053/dj3Wdz5DODPcPgU6cFjGGoB1tvcW51I4uRGcz18qn7mfBk0p
         /q99HQ5x6nIMgEqG7X8BjCv09YXVXq7UNG86cUD8=
Date:   Sun, 12 Apr 2020 11:02:53 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lars@metafoo.de>
Subject: Re: [PATCH][RFC] iio: buffer: remove 'scan_el_attrs' attribute
 group from buffer struct
Message-ID: <20200412110253.52d93e71@archlinux>
In-Reply-To: <20200410093607.74516-1-alexandru.ardelean@analog.com>
References: <20200410093607.74516-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 10 Apr 2020 12:36:07 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> This field doesn't seem used. It seems that only 'buffer->attrs' was ever
> used to extend sysfs attributes for an IIO buffer.
> 
> Moving forward, it may not make sense to keep it. This patch removes the
> field and it's initialization code.
> 
> Since we want to rework IIO buffer, to be able to add more buffers per IIO
> device, we will merge [somehow] the 'buffer' & 'scan_elements' groups, and
> we will continue to add the attributes to the 'buffer' group.
> 
> Removing it here, will also make the rework here a bit smaller, since
> this code will not be present.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Looks like dead code to me.  Applied to the togreg branch of iio.git and
pushed out as testing for the autobuilders to play with it.

Thanks,

Jonathan

> ---
> 
> I have no idea whether removing this is acceptable or not.
> If it is acceptable, then this can be applied.
> I am a bit vague on how this was ever used, of if it was ever used, but
> it looks like dead code.
> 
> 
>  drivers/iio/industrialio-buffer.c | 8 --------
>  include/linux/iio/buffer_impl.h   | 6 ------
>  2 files changed, 14 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index e6fa1a4e135d..221157136af6 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -1283,11 +1283,6 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
>  
>  	indio_dev->groups[indio_dev->groupcounter++] = &buffer->buffer_group;
>  
> -	if (buffer->scan_el_attrs != NULL) {
> -		attr = buffer->scan_el_attrs->attrs;
> -		while (*attr++ != NULL)
> -			attrcount_orig++;
> -	}
>  	attrcount = attrcount_orig;
>  	INIT_LIST_HEAD(&buffer->scan_el_dev_attr_list);
>  	channels = indio_dev->channels;
> @@ -1325,9 +1320,6 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
>  		ret = -ENOMEM;
>  		goto error_free_scan_mask;
>  	}
> -	if (buffer->scan_el_attrs)
> -		memcpy(buffer->scan_el_group.attrs, buffer->scan_el_attrs,
> -		       sizeof(buffer->scan_el_group.attrs[0])*attrcount_orig);
>  	attrn = attrcount_orig;
>  
>  	list_for_each_entry(p, &buffer->scan_el_dev_attr_list, l)
> diff --git a/include/linux/iio/buffer_impl.h b/include/linux/iio/buffer_impl.h
> index 1e7edf6bed96..a63dc07b7350 100644
> --- a/include/linux/iio/buffer_impl.h
> +++ b/include/linux/iio/buffer_impl.h
> @@ -94,12 +94,6 @@ struct iio_buffer {
>  	unsigned int watermark;
>  
>  	/* private: */
> -	/*
> -	 * @scan_el_attrs: Control of scan elements if that scan mode
> -	 * control method is used.
> -	 */
> -	struct attribute_group *scan_el_attrs;
> -
>  	/* @scan_timestamp: Does the scan mode include a timestamp. */
>  	bool scan_timestamp;
>  

