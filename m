Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE672918F2
	for <lists+linux-iio@lfdr.de>; Sun, 18 Aug 2019 20:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfHRSkX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Aug 2019 14:40:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:48562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726247AbfHRSkX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 18 Aug 2019 14:40:23 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AE6720B7C;
        Sun, 18 Aug 2019 18:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566153621;
        bh=meJqC7/AX0rwugLoFXfdiYsPkc55SQda8m3FYAF6tR0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UBO+B9SebXTSJYPls00r1xIsQX4qJWhg84bwALN3eX1zexkhkcPfX8P9rGPtv8P4m
         FCT6wWTU00a196WwkHHE/sgsOrzs0nNUnCK8tWJnZp6r7aphFLkd496Dw2odzBXZvm
         gta3ANyLnSYeYUOSxViPJMAj/1l/OinffoA9JlxE=
Date:   Sun, 18 Aug 2019 19:40:17 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mircea Caprioru <mircea.caprioru@analog.com>
Cc:     <Michael.Hennerich@analog.com>, <stefan.popa@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH V3 3/4] staging: iio: adc: ad7192: Add system
 calibration support
Message-ID: <20190818194017.7ba2fc97@archlinux>
In-Reply-To: <20190814073150.4602-3-mircea.caprioru@analog.com>
References: <20190814073150.4602-1-mircea.caprioru@analog.com>
        <20190814073150.4602-3-mircea.caprioru@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 14 Aug 2019 10:31:49 +0300
Mircea Caprioru <mircea.caprioru@analog.com> wrote:

> This patch will add a system calibration attribute for each channel. Using
> this option the user will have the ability to calibrate each channel for
> zero scale and full scale. It uses the iio_chan_spec_ext_info and IIO_ENUM
> to implement the functionality.
> 
> Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>

Hi, 

This introduces new ABI so needs documentation in
Documentation/ABI/testing/...

I'm not particularly keen on a write to what might be considered
a mode select register resulting in a calibration starting.
That is rather non obvious, I'd prefer to either two attributes
to trigger the two modes, or a mode attr and some sort of calibrate
now attribute.

I'll back out patch 2 for now, as it was there to support this.

Thanks,

Jonathan


> ---
> Changelog V2:
> - no changes here
> 
> Changelog V3:
> - no changes here
> 
>  drivers/staging/iio/adc/ad7192.c | 55 +++++++++++++++++++++++++++++++-
>  1 file changed, 54 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
> index d58ce08f3693..731072830f30 100644
> --- a/drivers/staging/iio/adc/ad7192.c
> +++ b/drivers/staging/iio/adc/ad7192.c
> @@ -155,6 +155,11 @@
>   * The DOUT/RDY output must also be wired to an interrupt capable GPIO.
>   */
>  
> +enum {
> +   AD7192_SYSCALIB_ZERO_SCALE,
> +   AD7192_SYSCALIB_FULL_SCALE,
> +};
> +
>  struct ad7192_state {
>  	struct regulator		*avdd;
>  	struct regulator		*dvdd;
> @@ -169,10 +174,56 @@ struct ad7192_state {
>  	u8				devid;
>  	u8				clock_sel;
>  	struct mutex			lock;	/* protect sensor state */
> +	u8				syscalib_mode[8];
>  
>  	struct ad_sigma_delta		sd;
>  };
>  
> +static const char * const ad7192_syscalib_modes[] = {
> +	[AD7192_SYSCALIB_ZERO_SCALE] = "zero_scale",
> +	[AD7192_SYSCALIB_FULL_SCALE] = "full_scale",
> +};
> +
> +static int ad7192_set_syscalib_mode(struct iio_dev *indio_dev,
> +				    const struct iio_chan_spec *chan,
> +				    unsigned int mode)
> +{
> +	struct ad7192_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	st->syscalib_mode[chan->channel] = mode;
> +
> +	if (mode == AD7192_SYSCALIB_ZERO_SCALE)
> +		ret = ad_sd_calibrate(&st->sd, AD7192_MODE_CAL_SYS_ZERO,
> +				      chan->address);
> +	else
> +		ret = ad_sd_calibrate(&st->sd, AD7192_MODE_CAL_SYS_FULL,
> +				      chan->address);
> +
> +	return ret;
> +}
> +
> +static int ad7192_get_syscalib_mode(struct iio_dev *indio_dev,
> +				    const struct iio_chan_spec *chan)
> +{
> +	struct ad7192_state *st = iio_priv(indio_dev);
> +
> +	return st->syscalib_mode[chan->channel];
> +}
> +
> +static const struct iio_enum ad7192_syscalib_mode_enum = {
> +	.items = ad7192_syscalib_modes,
> +	.num_items = ARRAY_SIZE(ad7192_syscalib_modes),
> +	.set = ad7192_set_syscalib_mode,
> +	.get = ad7192_get_syscalib_mode
> +};
> +
> +static const struct iio_chan_spec_ext_info ad7192_calibsys_ext_info[] = {
> +	IIO_ENUM("system_calibration", IIO_SEPARATE, &ad7192_syscalib_mode_enum),
> +	IIO_ENUM_AVAILABLE("system_calibration", &ad7192_syscalib_mode_enum),
> +	{}
> +};
> +
>  static struct ad7192_state *ad_sigma_delta_to_ad7192(struct ad_sigma_delta *sd)
>  {
>  	return container_of(sd, struct ad7192_state, sd);
> @@ -769,9 +820,11 @@ static int ad7192_channels_config(struct iio_dev *indio_dev)
>  		*chan = channels[i];
>  		chan->info_mask_shared_by_all |=
>  			BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY);
> -		if (chan->type != IIO_TEMP)
> +		if (chan->type != IIO_TEMP) {
>  			chan->info_mask_shared_by_type_available |=
>  				BIT(IIO_CHAN_INFO_SCALE);
> +			chan->ext_info = ad7192_calibsys_ext_info;
> +		}
>  		chan++;
>  	}
>  

