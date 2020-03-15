Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D142185BB9
	for <lists+linux-iio@lfdr.de>; Sun, 15 Mar 2020 10:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbgCOJyv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Mar 2020 05:54:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:45088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728159AbgCOJyv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Mar 2020 05:54:51 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D89E8206EB;
        Sun, 15 Mar 2020 09:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584266090;
        bh=K8wnhNFEIYULB/96Krs65zMXAmqNPB09nyxJvLsiISA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kJ33sIgpvurzUGqpo+OWfxdHlWY+vLCIcAR8rOjBeINSzf9ED31QaJu6mr/go1Yp0
         tfvdQiIApPwMRVXgXzLahTWvj9paKpWFWkms5lZHw7ucDv8MjDghhBpdVies/oMdWq
         Uc+HarDNsIEOTAS0yLh/96kVIkOz26WmzEZlZlXM=
Date:   Sun, 15 Mar 2020 09:54:46 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: core: Use scnprintf() for avoiding potential
 buffer overflow
Message-ID: <20200315095446.4f2aa451@archlinux>
In-Reply-To: <20200311074325.7922-2-tiwai@suse.de>
References: <20200311074325.7922-1-tiwai@suse.de>
        <20200311074325.7922-2-tiwai@suse.de>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 11 Mar 2020 08:43:24 +0100
Takashi Iwai <tiwai@suse.de> wrote:

> Since snprintf() returns the would-be-output size instead of the
> actual output size, the succeeding calls may go beyond the given
> buffer limit.  Fix it by replacing with scnprintf().

Hmm. This is definitely in the somewhat theoretical bug category, but
given it can be called to print a list of values that is defined
in a driver, fair enough - it's good protection.

I'm not going to rush this in given we don't have any drivers
that are known to run into this.  Hence I've queued it up for
the togreg branch of iio.git targeting the merge window rather than
as a fix.

Thanks,

Jonathan


> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  drivers/iio/industrialio-core.c | 34 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 65ff0d067018..197006b5d5c2 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -559,46 +559,46 @@ static ssize_t __iio_format_value(char *buf, size_t len, unsigned int type,
>  
>  	switch (type) {
>  	case IIO_VAL_INT:
> -		return snprintf(buf, len, "%d", vals[0]);
> +		return scnprintf(buf, len, "%d", vals[0]);
>  	case IIO_VAL_INT_PLUS_MICRO_DB:
>  		scale_db = true;
>  		/* fall through */
>  	case IIO_VAL_INT_PLUS_MICRO:
>  		if (vals[1] < 0)
> -			return snprintf(buf, len, "-%d.%06u%s", abs(vals[0]),
> +			return scnprintf(buf, len, "-%d.%06u%s", abs(vals[0]),
>  					-vals[1], scale_db ? " dB" : "");
>  		else
> -			return snprintf(buf, len, "%d.%06u%s", vals[0], vals[1],
> +			return scnprintf(buf, len, "%d.%06u%s", vals[0], vals[1],
>  					scale_db ? " dB" : "");
>  	case IIO_VAL_INT_PLUS_NANO:
>  		if (vals[1] < 0)
> -			return snprintf(buf, len, "-%d.%09u", abs(vals[0]),
> +			return scnprintf(buf, len, "-%d.%09u", abs(vals[0]),
>  					-vals[1]);
>  		else
> -			return snprintf(buf, len, "%d.%09u", vals[0], vals[1]);
> +			return scnprintf(buf, len, "%d.%09u", vals[0], vals[1]);
>  	case IIO_VAL_FRACTIONAL:
>  		tmp = div_s64((s64)vals[0] * 1000000000LL, vals[1]);
>  		tmp1 = vals[1];
>  		tmp0 = (int)div_s64_rem(tmp, 1000000000, &tmp1);
> -		return snprintf(buf, len, "%d.%09u", tmp0, abs(tmp1));
> +		return scnprintf(buf, len, "%d.%09u", tmp0, abs(tmp1));
>  	case IIO_VAL_FRACTIONAL_LOG2:
>  		tmp = shift_right((s64)vals[0] * 1000000000LL, vals[1]);
>  		tmp0 = (int)div_s64_rem(tmp, 1000000000LL, &tmp1);
> -		return snprintf(buf, len, "%d.%09u", tmp0, abs(tmp1));
> +		return scnprintf(buf, len, "%d.%09u", tmp0, abs(tmp1));
>  	case IIO_VAL_INT_MULTIPLE:
>  	{
>  		int i;
>  		int l = 0;
>  
>  		for (i = 0; i < size; ++i) {
> -			l += snprintf(&buf[l], len - l, "%d ", vals[i]);
> +			l += scnprintf(&buf[l], len - l, "%d ", vals[i]);
>  			if (l >= len)
>  				break;
>  		}
>  		return l;
>  	}
>  	case IIO_VAL_CHAR:
> -		return snprintf(buf, len, "%c", (char)vals[0]);
> +		return scnprintf(buf, len, "%c", (char)vals[0]);
>  	default:
>  		return 0;
>  	}
> @@ -669,10 +669,10 @@ static ssize_t iio_format_avail_list(char *buf, const int *vals,
>  			if (len >= PAGE_SIZE)
>  				return -EFBIG;
>  			if (i < length - 1)
> -				len += snprintf(buf + len, PAGE_SIZE - len,
> +				len += scnprintf(buf + len, PAGE_SIZE - len,
>  						" ");
>  			else
> -				len += snprintf(buf + len, PAGE_SIZE - len,
> +				len += scnprintf(buf + len, PAGE_SIZE - len,
>  						"\n");
>  			if (len >= PAGE_SIZE)
>  				return -EFBIG;
> @@ -685,10 +685,10 @@ static ssize_t iio_format_avail_list(char *buf, const int *vals,
>  			if (len >= PAGE_SIZE)
>  				return -EFBIG;
>  			if (i < length / 2 - 1)
> -				len += snprintf(buf + len, PAGE_SIZE - len,
> +				len += scnprintf(buf + len, PAGE_SIZE - len,
>  						" ");
>  			else
> -				len += snprintf(buf + len, PAGE_SIZE - len,
> +				len += scnprintf(buf + len, PAGE_SIZE - len,
>  						"\n");
>  			if (len >= PAGE_SIZE)
>  				return -EFBIG;
> @@ -712,10 +712,10 @@ static ssize_t iio_format_avail_range(char *buf, const int *vals, int type)
>  			if (len >= PAGE_SIZE)
>  				return -EFBIG;
>  			if (i < 2)
> -				len += snprintf(buf + len, PAGE_SIZE - len,
> +				len += scnprintf(buf + len, PAGE_SIZE - len,
>  						" ");
>  			else
> -				len += snprintf(buf + len, PAGE_SIZE - len,
> +				len += scnprintf(buf + len, PAGE_SIZE - len,
>  						"]\n");
>  			if (len >= PAGE_SIZE)
>  				return -EFBIG;
> @@ -728,10 +728,10 @@ static ssize_t iio_format_avail_range(char *buf, const int *vals, int type)
>  			if (len >= PAGE_SIZE)
>  				return -EFBIG;
>  			if (i < 2)
> -				len += snprintf(buf + len, PAGE_SIZE - len,
> +				len += scnprintf(buf + len, PAGE_SIZE - len,
>  						" ");
>  			else
> -				len += snprintf(buf + len, PAGE_SIZE - len,
> +				len += scnprintf(buf + len, PAGE_SIZE - len,
>  						"]\n");
>  			if (len >= PAGE_SIZE)
>  				return -EFBIG;

