Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 975453BADDE
	for <lists+linux-iio@lfdr.de>; Sun,  4 Jul 2021 18:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbhGDQyH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 4 Jul 2021 12:54:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:44142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229539AbhGDQyH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 4 Jul 2021 12:54:07 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A64D0613E1;
        Sun,  4 Jul 2021 16:51:28 +0000 (UTC)
Date:   Sun, 4 Jul 2021 17:53:52 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     peda@axentia.se, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v3 06/10] iio: afe: rescale: add offset support
Message-ID: <20210704175352.586c9ae8@jic23-huawei>
In-Reply-To: <20210701010034.303088-7-liambeguin@gmail.com>
References: <20210701010034.303088-1-liambeguin@gmail.com>
        <20210701010034.303088-7-liambeguin@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 30 Jun 2021 21:00:30 -0400
Liam Beguin <liambeguin@gmail.com> wrote:

> From: Liam Beguin <lvb@xiphos.com>
> 
> This is a preparatory change required for the addition of temperature
> sensing front ends.
> 
> Signed-off-by: Liam Beguin <lvb@xiphos.com>
Hi Liam.

A few remaining things inline.

Looking good in general.

Jonathan

> ---
>  drivers/iio/afe/iio-rescale.c | 63 +++++++++++++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
> 
> diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
> index 8f79c582519c..c8750286c308 100644
> --- a/drivers/iio/afe/iio-rescale.c
> +++ b/drivers/iio/afe/iio-rescale.c
> @@ -32,6 +32,7 @@ struct rescale {
>  	bool chan_processed;
>  	s32 numerator;
>  	s32 denominator;
> +	s32 offset;
>  };
>  
>  static int rescale_read_raw(struct iio_dev *indio_dev,
> @@ -39,6 +40,8 @@ static int rescale_read_raw(struct iio_dev *indio_dev,
>  			    int *val, int *val2, long mask)
>  {
>  	struct rescale *rescale = iio_priv(indio_dev);
> +	int scale, scale2;
> +	int schan_off = 0;
>  	s64 tmp, tmp2;
>  	u32 factor;
>  	int ret;
> @@ -99,6 +102,62 @@ static int rescale_read_raw(struct iio_dev *indio_dev,
>  			dev_err(&indio_dev->dev, "unsupported type %d\n", ret);
>  			return -EOPNOTSUPP;
>  		}
> +	case IIO_CHAN_INFO_OFFSET:
> +		/*
> +		 * Processed channels are scaled 1-to-1 and source offset is
> +		 * already taken into account.
> +		 *
> +		 * In other cases, the final offset value is defined by:
> +		 *	offset = schan_offset + rescaler_offset / schan_scale

Maths is right, but perhaps useful to express how this is derived as I had
to scribble it down to check.

		Want to express real world measurement as:
		scale * (raw + offset)
		Given we applying scale and offset recursively we have.
		rescaler_scale * (schan_scale * (raw + schan_offset) + rescaler_offset) 
		which can be rearrange into the correct form at.
		rescaler_scale *schan_scale* (raw + (schan_offset + rescaler_offset/schan_scale))
		Thus the scale and offset we expose to userspace should be.
		scale = rescaler_scale * schan_scale
		offset = schan_offset + rescaler_offset/schan_scale;


> +		 */
> +		if (rescale->chan_processed) {
> +			*val = rescale->offset;
> +			return IIO_VAL_INT;
> +		}
> +
> +		if (iio_channel_has_info(rescale->source->channel,
> +					 IIO_CHAN_INFO_OFFSET)) {
> +			ret = iio_read_channel_offset(rescale->source,
> +						      &schan_off, NULL);
> +			if (ret < 0)
> +				return ret;
if you've returned in the first branch of the if, no need to worry about the
else for checking the second condition.

			if (ret != IIO_VAL_INT)
				return...


> +			else if (ret != IIO_VAL_INT)
> +				return -EOPNOTSUPP;
> +		}
> +
> +		ret = iio_read_channel_scale(rescale->source, &scale, &scale2);
> +		switch (ret) {
> +		case IIO_VAL_FRACTIONAL:
> +			tmp = (s64)rescale->offset * scale2;
> +			*val = div_s64(tmp, scale) + schan_off;
> +			return IIO_VAL_INT;
> +		case IIO_VAL_INT:
> +			*val = div_s64(rescale->offset, scale) + schan_off;
> +			return IIO_VAL_INT;
> +		case IIO_VAL_FRACTIONAL_LOG2:
> +			tmp = (s64)rescale->offset * (1 << scale2);
> +			*val = div_s64(tmp, scale) + schan_off;
> +			return IIO_VAL_INT;
> +		case IIO_VAL_INT_PLUS_NANO:
> +			tmp = (s64)rescale->offset * 1000000000UL;
> +			tmp2 = ((s64)scale * 1000000000UL) + scale2;
> +			factor = gcd(tmp, tmp2);
> +			tmp /= factor;
> +			tmp2 /= factor;

What is the benefit to doing gcd division before div_s64?

> +			*val = div_s64(tmp, tmp2) + schan_off;
> +			return IIO_VAL_INT;
> +		case IIO_VAL_INT_PLUS_MICRO:
> +			tmp = (s64)rescale->offset * 1000000UL;
> +			tmp2 = ((s64)scale * 1000000UL) + scale2;
> +			factor = gcd(tmp, tmp2);
> +			tmp /= factor;
> +			tmp2 /= factor;
> +			*val = div_s64(tmp, tmp2) + schan_off;
> +			return IIO_VAL_INT;
> +		default:
> +			dev_err(&indio_dev->dev, "unsupported type %d\n", ret);
> +			return -EOPNOTSUPP;
> +		}
>  	default:
>  		return -EINVAL;
>  	}
> @@ -175,6 +234,9 @@ static int rescale_configure_channel(struct device *dev,
>  	chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>  		BIT(IIO_CHAN_INFO_SCALE);
>  
> +	if (rescale->offset)
> +	    chan->info_mask_separate |= BIT(IIO_CHAN_INFO_OFFSET);
> +
>  	/*
>  	 * Using .read_avail() is fringe to begin with and makes no sense
>  	 * whatsoever for processed channels, so we make sure that this cannot
> @@ -339,6 +401,7 @@ static int rescale_probe(struct platform_device *pdev)
>  	rescale->cfg = of_device_get_match_data(dev);
>  	rescale->numerator = 1;
>  	rescale->denominator = 1;
> +	rescale->offset = 0;
>  
>  	ret = rescale->cfg->props(dev, rescale);
>  	if (ret)

