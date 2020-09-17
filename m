Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 947E126E437
	for <lists+linux-iio@lfdr.de>; Thu, 17 Sep 2020 20:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgIQSmj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 17 Sep 2020 14:42:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:46450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbgIQSmi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 17 Sep 2020 14:42:38 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF69721D7B;
        Thu, 17 Sep 2020 18:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600368157;
        bh=CdigQ/+3mxrVUS6hZ+1nUMXkX34CWxjHp9qYy4kPe2g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Yvxz1yVf9HlZKzaI5XZkJ0swb7TQ4GqZr5VoHlNGY1vEsoFTw8PnkUhgufYWgD8jz
         ZI+i1i20lHPi6Tz7A5APBnNcSVHKL+tK688hMge35fRAhUtLSodp4abWRjClpBk758
         o++88nfw29MtbOExF3szyxHr+yM8CzlSS/vZR+u8=
Date:   Thu, 17 Sep 2020 19:42:33 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] iio: dac: ad5592r: localize locks only where needed
 in ad5592r_read_raw()
Message-ID: <20200917194233.57b548be@archlinux>
In-Reply-To: <20200706110259.23947-3-alexandru.ardelean@analog.com>
References: <20200706110259.23947-1-alexandru.ardelean@analog.com>
        <20200706110259.23947-3-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 6 Jul 2020 14:02:59 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> Since there was a recently discovered issue with these locks, it probably
> makes sense to cleanup the code a bit, to prevent it from being used as an
> example/reference.
> 
> This change moves the lock only where it is explicitly needed to protect
> resources from potential concurrent accesses.
> 
> It also reworks the switch statements to do direct returns vs caching the
> return value on a variable.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied these two to the togreg branch of iio.git

Thanks,

Jonathan

> ---
>  drivers/iio/dac/ad5592r-base.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5592r-base.c b/drivers/iio/dac/ad5592r-base.c
> index 7ea79e9bfa1d..f697b20efb6e 100644
> --- a/drivers/iio/dac/ad5592r-base.c
> +++ b/drivers/iio/dac/ad5592r-base.c
> @@ -380,32 +380,32 @@ static int ad5592r_read_raw(struct iio_dev *iio_dev,
>  
>  	switch (m) {
>  	case IIO_CHAN_INFO_RAW:
> -		mutex_lock(&st->lock);
> -
>  		if (!chan->output) {
> +			mutex_lock(&st->lock);
>  			ret = st->ops->read_adc(st, chan->channel, &read_val);
> +			mutex_unlock(&st->lock);
>  			if (ret)
> -				goto unlock;
> +				return ret;
>  
>  			if ((read_val >> 12 & 0x7) != (chan->channel & 0x7)) {
>  				dev_err(st->dev, "Error while reading channel %u\n",
>  						chan->channel);
> -				ret = -EIO;
> -				goto unlock;
> +				return -EIO;
>  			}
>  
>  			read_val &= GENMASK(11, 0);
>  
>  		} else {
> +			mutex_lock(&st->lock);
>  			read_val = st->cached_dac[chan->channel];
> +			mutex_unlock(&st->lock);
>  		}
>  
>  		dev_dbg(st->dev, "Channel %u read: 0x%04hX\n",
>  				chan->channel, read_val);
>  
>  		*val = (int) read_val;
> -		ret = IIO_VAL_INT;
> -		break;
> +		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
>  		*val = ad5592r_get_vref(st);
>  
> @@ -425,11 +425,13 @@ static int ad5592r_read_raw(struct iio_dev *iio_dev,
>  			mult = !!(st->cached_gp_ctrl &
>  				AD5592R_REG_CTRL_ADC_RANGE);
>  
> +		mutex_unlock(&st->lock);
> +
>  		*val *= ++mult;
>  
>  		*val2 = chan->scan_type.realbits;
> -		ret = IIO_VAL_FRACTIONAL_LOG2;
> -		break;
> +
> +		return IIO_VAL_FRACTIONAL_LOG2;
>  	case IIO_CHAN_INFO_OFFSET:
>  		ret = ad5592r_get_vref(st);
>  
> @@ -439,15 +441,13 @@ static int ad5592r_read_raw(struct iio_dev *iio_dev,
>  			*val = (-34365 * 25) / ret;
>  		else
>  			*val = (-75365 * 25) / ret;
> -		ret =  IIO_VAL_INT;
> -		break;
> +
> +		mutex_unlock(&st->lock);
> +
> +		return IIO_VAL_INT;
>  	default:
>  		return -EINVAL;
>  	}
> -
> -unlock:
> -	mutex_unlock(&st->lock);
> -	return ret;
>  }
>  
>  static int ad5592r_write_raw_get_fmt(struct iio_dev *indio_dev,

