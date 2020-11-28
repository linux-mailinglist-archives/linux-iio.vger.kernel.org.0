Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46C852C7548
	for <lists+linux-iio@lfdr.de>; Sat, 28 Nov 2020 23:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732756AbgK1VtY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Nov 2020 16:49:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:46996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729872AbgK1Sb4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 28 Nov 2020 13:31:56 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 596DC246B3;
        Sat, 28 Nov 2020 15:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606578177;
        bh=PehoDkJGJYuvwMfXbqGvqcusVZuYX70NuYcbiOg9oZE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rAT0j+UHvy9ewef3k+3wzoup8sA0nVJwBOl98SpqzCogRl16uqZHNnKjBnn3I2QLo
         H6kZo7FPXCdqP+ihFpnMBjhRfz1p0qyI4PnV5wL5JnLvzt1lyOL4GwQ2rdjMKusACT
         9nJr/BMTcCM6MZZo0DMjnjw16KvP8Szc/AFzb6Vo=
Date:   Sat, 28 Nov 2020 15:42:54 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: core: Consolidate
 iio_format_avail_{list,range}()
Message-ID: <20201128154254.4619329e@archlinux>
In-Reply-To: <20201114120000.6533-1-lars@metafoo.de>
References: <20201114120000.6533-1-lars@metafoo.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 14 Nov 2020 12:59:59 +0100
Lars-Peter Clausen <lars@metafoo.de> wrote:

> The iio_format_avail_list() and iio_format_avail_range() functions are
> almost identical. The only differences are that iio_format_avail_range()
> expects a fixed amount of items and adds brackets "[ ]" around the output.
> 
> Refactor them into a common helper function. This improves the
> maintainability of the code as it makes it easier to modify the
> implementation of these functions.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Nice little cleanup.  Series applied to the togreg branch of iio.git and pushed
out as testing for the autobuilders to poke at it.

Thanks,

Jonathan

> ---
>  drivers/iio/industrialio-core.c | 57 ++++++++-------------------------
>  1 file changed, 14 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 9955672fc16a..3e71fcab7cbd 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -698,11 +698,13 @@ static ssize_t iio_read_channel_info(struct device *dev,
>  	return iio_format_value(buf, ret, val_len, vals);
>  }
>  
> -static ssize_t iio_format_avail_list(char *buf, const int *vals,
> -				     int type, int length)
> +static ssize_t iio_format_list(char *buf, const int *vals, int type, int length,
> +			       const char *prefix, const char *suffix)
>  {
> +	ssize_t len;
>  	int i;
> -	ssize_t len = 0;
> +
> +	len = scnprintf(buf, PAGE_SIZE, prefix);
>  
>  	switch (type) {
>  	case IIO_VAL_INT:
> @@ -716,7 +718,7 @@ static ssize_t iio_format_avail_list(char *buf, const int *vals,
>  						" ");
>  			else
>  				len += scnprintf(buf + len, PAGE_SIZE - len,
> -						"\n");
> +						"%s\n", suffix);
>  			if (len >= PAGE_SIZE)
>  				return -EFBIG;
>  		}
> @@ -732,7 +734,7 @@ static ssize_t iio_format_avail_list(char *buf, const int *vals,
>  						" ");
>  			else
>  				len += scnprintf(buf + len, PAGE_SIZE - len,
> -						"\n");
> +						"%s\n", suffix);
>  			if (len >= PAGE_SIZE)
>  				return -EFBIG;
>  		}
> @@ -741,47 +743,16 @@ static ssize_t iio_format_avail_list(char *buf, const int *vals,
>  	return len;
>  }
>  
> -static ssize_t iio_format_avail_range(char *buf, const int *vals, int type)
> +static ssize_t iio_format_avail_list(char *buf, const int *vals,
> +				     int type, int length)
>  {
> -	int i;
> -	ssize_t len;
>  
> -	len = snprintf(buf, PAGE_SIZE, "[");
> -	switch (type) {
> -	case IIO_VAL_INT:
> -		for (i = 0; i < 3; i++) {
> -			len += __iio_format_value(buf + len, PAGE_SIZE - len,
> -						  type, 1, &vals[i]);
> -			if (len >= PAGE_SIZE)
> -				return -EFBIG;
> -			if (i < 2)
> -				len += scnprintf(buf + len, PAGE_SIZE - len,
> -						" ");
> -			else
> -				len += scnprintf(buf + len, PAGE_SIZE - len,
> -						"]\n");
> -			if (len >= PAGE_SIZE)
> -				return -EFBIG;
> -		}
> -		break;
> -	default:
> -		for (i = 0; i < 3; i++) {
> -			len += __iio_format_value(buf + len, PAGE_SIZE - len,
> -						  type, 2, &vals[i * 2]);
> -			if (len >= PAGE_SIZE)
> -				return -EFBIG;
> -			if (i < 2)
> -				len += scnprintf(buf + len, PAGE_SIZE - len,
> -						" ");
> -			else
> -				len += scnprintf(buf + len, PAGE_SIZE - len,
> -						"]\n");
> -			if (len >= PAGE_SIZE)
> -				return -EFBIG;
> -		}
> -	}
> +	return iio_format_list(buf, vals, type, length, "", "");
> +}
>  
> -	return len;
> +static ssize_t iio_format_avail_range(char *buf, const int *vals, int type)
> +{
> +	return iio_format_list(buf, vals, type, 3, "[", "]");
>  }
>  
>  static ssize_t iio_read_channel_info_avail(struct device *dev,

