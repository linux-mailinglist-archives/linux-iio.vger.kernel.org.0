Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F19E767E7A
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jul 2019 12:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfGNKMn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Jul 2019 06:12:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:45690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726034AbfGNKMm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Jul 2019 06:12:42 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6913720838;
        Sun, 14 Jul 2019 10:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563099161;
        bh=rpeojTgbMOqo5i6wiQrim8gZdOJKcxS+lZsGwPaUuZw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0IbsGnfHgBhmVxvZYqe867HTKAEI9l5aqz4pKgrRwCLb7R/bfzen9+v9zYKnVsSCu
         v9peQi8BfaJOKLTqQg2l9zLcXEHSjUdsyqmAZbYhdeBwDFNvbo9jFoncC5KqlqYYGS
         cWhV+nlyRklPY8hbeKmyjt6vEz9wcIlNkul1Z8LM=
Date:   Sun, 14 Jul 2019 11:12:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <andriy.shevchenko@linux.intel.com>, <lars@metafoo.de>
Subject: Re: [PATCH 1/3][V3] lib: fix __sysfs_match_string() helper when n
 != -1
Message-ID: <20190714111237.183eb826@archlinux>
In-Reply-To: <20190508111913.7276-1-alexandru.ardelean@analog.com>
References: <20190508111913.7276-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 8 May 2019 14:19:11 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> The documentation the `__sysfs_match_string()` helper mentions that `n`
> (the size of the given array) should be:
>  * @n: number of strings in the array or -1 for NULL terminated arrays
> 
> The behavior of the function is different, in the sense that it exits on
> the first NULL element in the array.
> 
> This patch changes the behavior, to exit the loop when a NULL element is
> found, and the size of the array is provided as -1.
> 
> All current users of __sysfs_match_string() & sysfs_match_string() provide
> contiguous arrays of strings, so this behavior change doesn't influence
> anything (at this point in time).
> 
> This behavior change allows for an array of strings to have NULL elements
> within the array, which will be ignored. This is particularly useful when
> creating mapping of strings and integers (as bitfields or other HW
> description).
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Looks good to me.  I can take it through IIO given patch 3, but
fine with it taking another route if people would prefer as I don't
think the two 'need' to go together.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
> 
> Changelog v2 -> v3:
> * fix __sysfs_match_string() vs adding a new
>   __sysfs_match_string_with_gaps() helper
> 
>  lib/string.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/string.c b/lib/string.c
> index 3ab861c1a857..5bea3f98478a 100644
> --- a/lib/string.c
> +++ b/lib/string.c
> @@ -674,8 +674,11 @@ int __sysfs_match_string(const char * const *array, size_t n, const char *str)
>  
>  	for (index = 0; index < n; index++) {
>  		item = array[index];
> -		if (!item)
> +		if (!item) {
> +			if (n != (size_t)-1)
> +				continue;
>  			break;
> +		}
>  		if (sysfs_streq(item, str))
>  			return index;
>  	}

