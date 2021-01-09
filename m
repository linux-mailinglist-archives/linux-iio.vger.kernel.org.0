Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A37F32F0325
	for <lists+linux-iio@lfdr.de>; Sat,  9 Jan 2021 20:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbhAITY0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 9 Jan 2021 14:24:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:50106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726005AbhAITY0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 9 Jan 2021 14:24:26 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5AE1239D1;
        Sat,  9 Jan 2021 19:23:44 +0000 (UTC)
Date:   Sat, 9 Jan 2021 19:23:40 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lars@metafoo.de>, <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v8] iio: Handle enumerated properties with gaps
Message-ID: <20210109192340.0e8e422b@archlinux>
In-Reply-To: <20210107112049.10815-1-alexandru.ardelean@analog.com>
References: <20210107112049.10815-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 7 Jan 2021 13:20:49 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> From: Lars-Peter Clausen <lars@metafoo.de>
> 
> Some enums might have gaps or reserved values in the middle of their value
> range. E.g. consider a 2-bit enum where the values 0, 1 and 3 have a
> meaning, but 2 is a reserved value and can not be used.
> 
> Add support for such enums to the IIO enum helper functions. A reserved
> values is marked by setting its entry in the items array to NULL rather
> than the normal descriptive string value.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Applied to the togreg branch of iio.git and pushed out as testing for all
the normal autobuilder related reasons.

Note I can still rebase so if anyone wants to add tags or comment it's
not yet too late!

Jonathan

> ---
> 
> Changelog v7 -> v8:
> * https://lore.kernel.org/linux-iio/20210107084434.35283-1-alexandru.ardelean@analog.com/
> * dropped patch 'lib/string.c: add __sysfs_match_string_with_gaps() helper'
> * merged __sysfs_match_string_with_gaps into  drivers/iio/industrial-core.c 
>   as iio_sysfs_match_string_with_gaps()
> 
>  drivers/iio/industrialio-core.c | 39 ++++++++++++++++++++++++++++++---
>  1 file changed, 36 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index e9ee9363fed0..db20e2ab437d 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -169,6 +169,36 @@ static const char * const iio_chan_info_postfix[] = {
>  	[IIO_CHAN_INFO_CALIBAMBIENT] = "calibambient",
>  };
>  
> +/**
> + * iio_sysfs_match_string_with_gaps - matches given string in an array with gaps
> + * @array: array of strings
> + * @n: number of strings in the array
> + * @str: string to match with
> + *
> + * Returns index of @str in the @array or -EINVAL, similar to match_string().
> + * Uses sysfs_streq instead of strcmp for matching.
> + *
> + * This routine will look for a string in an array of strings.
> + * The search will continue until the element is found or the n-th element
> + * is reached, regardless of any NULL elements in the array.
> + */
> +static int iio_sysfs_match_string_with_gaps(const char * const *array, size_t n,
> +					    const char *str)
> +{
> +	const char *item;
> +	int index;
> +
> +	for (index = 0; index < n; index++) {
> +		item = array[index];
> +		if (!item)
> +			continue;
> +		if (sysfs_streq(item, str))
> +			return index;
> +	}
> +
> +	return -EINVAL;
> +}
> +
>  #if defined(CONFIG_DEBUG_FS)
>  /*
>   * There's also a CONFIG_DEBUG_FS guard in include/linux/iio/iio.h for
> @@ -470,8 +500,11 @@ ssize_t iio_enum_available_read(struct iio_dev *indio_dev,
>  	if (!e->num_items)
>  		return 0;
>  
> -	for (i = 0; i < e->num_items; ++i)
> +	for (i = 0; i < e->num_items; ++i) {
> +		if (!e->items[i])
> +			continue;
>  		len += scnprintf(buf + len, PAGE_SIZE - len, "%s ", e->items[i]);
> +	}
>  
>  	/* replace last space with a newline */
>  	buf[len - 1] = '\n';
> @@ -492,7 +525,7 @@ ssize_t iio_enum_read(struct iio_dev *indio_dev,
>  	i = e->get(indio_dev, chan);
>  	if (i < 0)
>  		return i;
> -	else if (i >= e->num_items)
> +	else if (i >= e->num_items || !e->items[i])
>  		return -EINVAL;
>  
>  	return snprintf(buf, PAGE_SIZE, "%s\n", e->items[i]);
> @@ -509,7 +542,7 @@ ssize_t iio_enum_write(struct iio_dev *indio_dev,
>  	if (!e->set)
>  		return -EINVAL;
>  
> -	ret = __sysfs_match_string(e->items, e->num_items, buf);
> +	ret = iio_sysfs_match_string_with_gaps(e->items, e->num_items, buf);
>  	if (ret < 0)
>  		return ret;
>  

