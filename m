Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42DF93A1E14
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jun 2021 22:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbhFIU2z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Jun 2021 16:28:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:59380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229507AbhFIU2y (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 9 Jun 2021 16:28:54 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D174661278;
        Wed,  9 Jun 2021 20:26:57 +0000 (UTC)
Date:   Wed, 9 Jun 2021 21:28:50 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     peda@axentia.se, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v2 3/8] iio: inkern: error out on unsupported offset
 type
Message-ID: <20210609212850.008d7f84@jic23-huawei>
In-Reply-To: <20210607144718.1724413-4-liambeguin@gmail.com>
References: <20210607144718.1724413-1-liambeguin@gmail.com>
        <20210607144718.1724413-4-liambeguin@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  7 Jun 2021 10:47:13 -0400
Liam Beguin <liambeguin@gmail.com> wrote:

> From: Liam Beguin <lvb@xiphos.com>
> 
> iio_convert_raw_to_processed_unlocked() assumes the offset is an
> integer.
> Make that clear to the consumer by returning an error on unsupported
> offset types without breaking valid implicit truncations.
> 
> Signed-off-by: Liam Beguin <lvb@xiphos.com>
> ---
>  drivers/iio/inkern.c | 34 +++++++++++++++++++++++++++++-----
>  1 file changed, 29 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index b69027690ed5..0b5667f22b1d 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -578,13 +578,37 @@ EXPORT_SYMBOL_GPL(iio_read_channel_average_raw);
>  static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
>  	int raw, int *processed, unsigned int scale)
>  {
> -	int scale_type, scale_val, scale_val2, offset;
> +	int scale_type, scale_val, scale_val2;
> +	int offset_type, offset_val, offset_val2;
>  	s64 raw64 = raw;
> -	int ret;
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
> +			if (offset_val2 > 1000)

What's the logic behind this one?  > 1000000
would be an interesting corner case, though I'm not sure we've ever
explicitly disallowed it before.

Why are we at 1000th of that for the check?

> +				return -EINVAL;
> +			break;
> +		case IIO_VAL_INT_PLUS_NANO:
> +			if (offset_val2 > 1000000)

Similar this is a bit odd.

> +				return -EINVAL;
> +		case IIO_VAL_FRACTIONAL:
> +			if (offset_val2 != 1)
> +				return -EINVAL;

We could be more flexible on this, but I don't recall any
channels using this so far.

> +			break;
> +		case IIO_VAL_FRACTIONAL_LOG2:
> +			if (offset_val2)
> +				return -EINVAL;

Same in this case.

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

