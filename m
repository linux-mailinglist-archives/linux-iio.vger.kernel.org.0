Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4042444485D
	for <lists+linux-iio@lfdr.de>; Wed,  3 Nov 2021 19:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhKCSka (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 Nov 2021 14:40:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:48466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229940AbhKCSka (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 3 Nov 2021 14:40:30 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D0C361076;
        Wed,  3 Nov 2021 18:37:51 +0000 (UTC)
Date:   Wed, 3 Nov 2021 18:42:25 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     lars@metafoo.de, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: Re: [PATCH 1/4] iio: Use scan_type shift and realbits when
 processing raw data
Message-ID: <20211103184225.1706aa59@jic23-huawei>
In-Reply-To: <20211101071822.522178-2-gwendal@chromium.org>
References: <20211101071822.522178-1-gwendal@chromium.org>
        <20211101071822.522178-2-gwendal@chromium.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  1 Nov 2021 00:18:19 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> When user space application read iio buffer though libiio, data is
> converted (see iio_channel_convert()) using the _type sysfs parameter.
> In particular, scan_type.shift and scan_type.realbits are used to shift
> and tell on how many bits signed elements are encoded on.
> 
> When reading elements directly using the raw sysfs attributes, the same
> rules for shifting and signing should apply.
> 
> Use channel definition as root of trust and replace constant with
> them for the simple cases.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>

Hmm. I'd have been tempted to do this as a long series, at least
partly so it would let me pick up the ones I'm happy with + also
we may create some history that needs backporting at some stage
and that's a mess if we have code touching lots of drivers in one patch.

Ludovic, Eugen,  This change raised a question about the current
code in at91-sama5d2_adc.c

> ---
>  drivers/iio/accel/bma220_spi.c     | 3 ++-
>  drivers/iio/accel/kxcjk-1013.c     | 3 ++-
>  drivers/iio/accel/mma7455_core.c   | 3 ++-
>  drivers/iio/accel/sca3000.c        | 5 +++--
>  drivers/iio/accel/stk8312.c        | 2 +-
>  drivers/iio/accel/stk8ba50.c       | 3 ++-
>  drivers/iio/adc/ad7266.c           | 3 ++-
>  drivers/iio/adc/at91-sama5d2_adc.c | 3 ++-
>  drivers/iio/adc/ti-adc12138.c      | 3 ++-
>  drivers/iio/magnetometer/mag3110.c | 6 ++++--
>  10 files changed, 22 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/accel/bma220_spi.c b/drivers/iio/accel/bma220_spi.c
> index bc4c626e454d3..812d6749b24a7 100644
> --- a/drivers/iio/accel/bma220_spi.c
> +++ b/drivers/iio/accel/bma220_spi.c
> @@ -125,7 +125,8 @@ static int bma220_read_raw(struct iio_dev *indio_dev,
>  		ret = bma220_read_reg(data->spi_device, chan->address);
>  		if (ret < 0)
>  			return -EINVAL;
> -		*val = sign_extend32(ret >> BMA220_DATA_SHIFT, 5);
> +		*val = sign_extend32(ret >> chan->scan_type.shift,
> +				     chan->scan_type.realbits - 1);

The BMA220_DATA_SHIFT define is now only used as the value for .shift, so
could you move the value inline to there and get rid of the define.

That will be match what is done for all the other parts of scan_type.
 
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
>  		ret = bma220_read_reg(data->spi_device, BMA220_REG_RANGE);


> diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
> index c6b75308148aa..938eb6bda73b3 100644
> --- a/drivers/iio/accel/sca3000.c
> +++ b/drivers/iio/accel/sca3000.c
> @@ -730,8 +730,9 @@ static int sca3000_read_raw(struct iio_dev *indio_dev,
>  				mutex_unlock(&st->lock);
>  				return ret;
>  			}
> -			*val = (be16_to_cpup((__be16 *)st->rx) >> 3) & 0x1FFF;
> -			*val = sign_extend32(*val, 12);
> +			*val = (be16_to_cpup((__be16 *)st->rx) >>
> +					chan->scan_type.shift) & 0x1FFF;

While here, GENMASK(12, 0) for the mask might be a nice to have..

> +			*val = sign_extend32(*val, chan->scan_type.realbits - 1);
>  		} else {
>  			/* get the temperature when available */
>  			ret = sca3000_read_data_short(st,
The code following this is exciting as well... and would benefit from
being rewritten as be16_to_cpup() with a shift and mask but that's a job for
a different patch, or you could add the scan_type to the temperature channel and
add it to this series using that... It's unsigned unlike the above, so
it probably doesn't make sense to have a single path.




> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index 4c922ef634f8e..92a57cf10fba4 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -1586,7 +1586,8 @@ static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
>  		*val = st->conversion_value;
>  		ret = at91_adc_adjust_val_osr(st, val);
>  		if (chan->scan_type.sign == 's')
> -			*val = sign_extend32(*val, 11);
> +			*val = sign_extend32(*val,
> +					     chan->scan_type.realbits - 1);
>  		st->conversion_done = false;
Hmm. This is exciting.  I'm not sure if the current code is correct.
There is a comment that says it's a voltage channel if we are in this path
a few lines earlier, yet the only signed voltage channel is from the
macro AT91_SAMA5D2_CHAN_DIFF() which sets realbits = 14, not 12.


>  	}
>  

The other changes all looked good to me.

Jonathan

