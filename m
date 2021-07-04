Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78A2C3BADCD
	for <lists+linux-iio@lfdr.de>; Sun,  4 Jul 2021 18:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbhGDQ05 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 4 Jul 2021 12:26:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:41874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229539AbhGDQ05 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 4 Jul 2021 12:26:57 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 468B8613E7;
        Sun,  4 Jul 2021 16:24:19 +0000 (UTC)
Date:   Sun, 4 Jul 2021 17:26:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     peda@axentia.se, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v3 03/10] iio: inkern: make a best effort on offset
 calculation
Message-ID: <20210704172643.074cf8c6@jic23-huawei>
In-Reply-To: <20210701010034.303088-4-liambeguin@gmail.com>
References: <20210701010034.303088-1-liambeguin@gmail.com>
        <20210701010034.303088-4-liambeguin@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 30 Jun 2021 21:00:27 -0400
Liam Beguin <liambeguin@gmail.com> wrote:

> From: Liam Beguin <lvb@xiphos.com>
> 
> iio_convert_raw_to_processed_unlocked() assumes the offset is an
> integer. Make a best effort to get a valid offset value for fractional
> cases without breaking implicit truncations.
> 
> Fixes: 48e44ce0f881 ("iio:inkern: Add function to read the processed value")
> Signed-off-by: Liam Beguin <lvb@xiphos.com>
Looks good, but a few really minor comments  / questions inline.

Thanks,

Jonathan

> ---
>  drivers/iio/inkern.c | 36 +++++++++++++++++++++++++++++++-----
>  1 file changed, 31 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index b69027690ed5..e1712c1099c5 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -578,13 +578,39 @@ EXPORT_SYMBOL_GPL(iio_read_channel_average_raw);
>  static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
>  	int raw, int *processed, unsigned int scale)
>  {
> -	int scale_type, scale_val, scale_val2, offset;
> +	int scale_type, scale_val, scale_val2;
> +	int offset_type, offset_val, offset_val2;
>  	s64 raw64 = raw;
> -	int ret;
> +	int tmp;
>  
> -	ret = iio_channel_read(chan, &offset, NULL, IIO_CHAN_INFO_OFFSET);
> -	if (ret >= 0)
> -		raw64 += offset;
> +	offset_type = iio_channel_read(chan, &offset_val, &offset_val2,
> +				       IIO_CHAN_INFO_OFFSET);
> +	if (offset_type >= 0) {
> +		switch (offset_type) {
> +		case IIO_VAL_INT:
> +			break;
> +		case IIO_VAL_INT_PLUS_MICRO:
> +			fallthrough;

I'm fairly sure you don't need to mark fallthroughs in the case where
there is nothing in the case statement at all.  That case is assumed
to be deliberate by the various static checkers.  I am seeing a few
examples as you have it here in kernel, but it certainly isn't particularly common
so I'm assuming those where the result of people falsely thinking it was necessary
or the outcomes of code changes in the surrounding code.

> +		case IIO_VAL_INT_PLUS_NANO:
> +			/*
> +			 * Both IIO_VAL_INT_PLUS_MICRO and IIO_VAL_INT_PLUS_NANO
> +			 * implicitely truncate the offset to it's integer form.
> +			 */
> +			break;
> +		case IIO_VAL_FRACTIONAL:
> +			tmp = offset_val / offset_val2;
> +			offset_val = tmp;

What benefit do we get from the local variable?
offset_val /= offset_val2; would be alternative.

> +			break;
> +		case IIO_VAL_FRACTIONAL_LOG2:
> +			tmp = offset_val / (1 << offset_val2);
> +			offset_val = tmp;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +
> +		raw64 += offset_val;
> +	}
>  
>  	scale_type = iio_channel_read(chan, &scale_val, &scale_val2,
>  					IIO_CHAN_INFO_SCALE);

