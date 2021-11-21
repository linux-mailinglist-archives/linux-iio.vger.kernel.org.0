Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E387B45830B
	for <lists+linux-iio@lfdr.de>; Sun, 21 Nov 2021 12:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238071AbhKULJm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Nov 2021 06:09:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:35192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238066AbhKULJl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 21 Nov 2021 06:09:41 -0500
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0937B60E0C;
        Sun, 21 Nov 2021 11:06:34 +0000 (UTC)
Date:   Sun, 21 Nov 2021 11:11:29 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     peda@axentia.se, lars@metafoo.de, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org
Subject: Re: [PATCH v9 05/14] iio: afe: rescale: add INT_PLUS_{MICRO,NANO}
 support
Message-ID: <20211121111129.31104550@jic23-huawei>
In-Reply-To: <20211115034334.1713050-6-liambeguin@gmail.com>
References: <20211115034334.1713050-1-liambeguin@gmail.com>
        <20211115034334.1713050-6-liambeguin@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 14 Nov 2021 22:43:25 -0500
Liam Beguin <liambeguin@gmail.com> wrote:

> From: Liam Beguin <lvb@xiphos.com>
> 
> Some ADCs use IIO_VAL_INT_PLUS_{NANO,MICRO} scale types.
> Add support for these to allow using the iio-rescaler with them.
> 
> Signed-off-by: Liam Beguin <lvb@xiphos.com>
> ---
>  drivers/iio/afe/iio-rescale.c | 36 +++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
> index d0669fd8eac5..2c25a6375f99 100644
> --- a/drivers/iio/afe/iio-rescale.c
> +++ b/drivers/iio/afe/iio-rescale.c
> @@ -22,6 +22,9 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
>  			  int *val, int *val2)
>  {
>  	unsigned long long tmp;
> +	s32 rem;
> +	u32 mult;
> +	u32 neg;
>  
>  	switch (scale_type) {
>  	case IIO_VAL_FRACTIONAL:
> @@ -40,6 +43,39 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
>  		tmp *= rescale->numerator;
>  		do_div(tmp, 1000000000LL);
>  		*val = tmp;
> +		return scale_type;
> +	case IIO_VAL_INT_PLUS_NANO:
> +	case IIO_VAL_INT_PLUS_MICRO:
> +		if (scale_type == IIO_VAL_INT_PLUS_NANO)
> +			mult = 1000000000LL;
> +		else
> +			mult = 1000000LL;

Trivial but perhaps you can use the multipliers defined in include/linux/units.h?
			mut = MICRO; etc.

I think that patch set crossed with the earlier versions of this one but given
it's now there I think it would slightly improve readability.


> +		/*
> +		 * For IIO_VAL_INT_PLUS_{MICRO,NANO} scale types if either *val
> +		 * OR *val2 is negative the schan scale is negative, i.e.
> +		 * *val = 1 and *val2 = -0.5 yields -1.5 not -0.5.
> +		 */
> +		neg = *val < 0 || *val2 < 0;
> +
> +		tmp = (s64)abs(*val) * abs(rescale->numerator);
> +		*val = div_s64_rem(tmp, abs(rescale->denominator), &rem);
> +
> +		tmp = (s64)rem * mult + (s64)abs(*val2) * abs(rescale->numerator);
> +		tmp = div_s64(tmp, abs(rescale->denominator));
> +
> +		*val += div_s64_rem(tmp, mult, val2);
> +
> +		/*
> +		 * If only one of the rescaler elements or the schan scale is
> +		 * negative, the combined scale is negative.
> +		 */
> +		if (neg ^ ((rescale->numerator < 0) ^ (rescale->denominator < 0))) {
> +			if (*val)
> +				*val = -*val;
> +			else
> +				*val2 = -*val2;
> +		}
> +
>  		return scale_type;
>  	default:
>  		return -EOPNOTSUPP;

