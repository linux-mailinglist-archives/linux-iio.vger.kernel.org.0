Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92E461D61DB
	for <lists+linux-iio@lfdr.de>; Sat, 16 May 2020 17:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbgEPPPH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 May 2020 11:15:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:59292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726416AbgEPPPH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 May 2020 11:15:07 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 728ED206F4;
        Sat, 16 May 2020 15:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589642106;
        bh=1wnDYawOrwvFaHHFJo8KFJj2DbpUF3y3YoF9gS4jVeg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QMotZ5njogEH7T0uezDzexY35QIwhVqQHMjHAuQgoEZy2vK03Nb1fRRG5RQVuxlZ8
         vr9a8OHYVrKXEpxdHSLIzzpbuClYpNBESWOnBLgmFdaoO74n57998+2ac+6wl1GqTb
         It/mPJLdq/j4tuOZYbBh+Kr0KXD4Nv222Sjkd+xQ=
Date:   Sat, 16 May 2020 16:15:02 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        "Stefan Popa" <stefan.popa@analog.com>,
        "Hartmut Knaack" <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH] iio: dac: ad5446: Replace indio_dev->mlock with own
 device lock
Message-ID: <20200516161502.48a2a181@archlinux>
In-Reply-To: <20200514090048.80359-1-sergiu.cuciurean@analog.com>
References: <20200514090048.80359-1-sergiu.cuciurean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 14 May 2020 12:00:42 +0300
Sergiu Cuciurean <sergiu.cuciurean@analog.com> wrote:

> As part of the general cleanup of indio_dev->mlock, this change replaces
> it with a local lock on the device's state structure.
> 
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/dac/ad5446.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
> index 9884e29b19b7..8f8afc8999bc 100644
> --- a/drivers/iio/dac/ad5446.c
> +++ b/drivers/iio/dac/ad5446.c
> @@ -33,6 +33,7 @@
>   * @chip_info:		chip model specific constants, available modes etc
>   * @reg:		supply regulator
>   * @vref_mv:		actual reference voltage used
> + * @lock		lock to protect the data buffer during write ops
>   */
>  
>  struct ad5446_state {
> @@ -43,6 +44,7 @@ struct ad5446_state {
>  	unsigned			cached_val;
>  	unsigned			pwr_down_mode;
>  	unsigned			pwr_down;
> +	struct mutex			lock;
>  };
>  
>  /**
> @@ -112,7 +114,7 @@ static ssize_t ad5446_write_dac_powerdown(struct iio_dev *indio_dev,
>  	if (ret)
>  		return ret;
>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&st->lock);
>  	st->pwr_down = powerdown;
>  
>  	if (st->pwr_down) {
> @@ -123,7 +125,7 @@ static ssize_t ad5446_write_dac_powerdown(struct iio_dev *indio_dev,
>  	}
>  
>  	ret = st->chip_info->write(st, val);
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->lock);
>  
>  	return ret ? ret : len;
>  }
> @@ -197,11 +199,11 @@ static int ad5446_write_raw(struct iio_dev *indio_dev,
>  			return -EINVAL;
>  
>  		val <<= chan->scan_type.shift;
> -		mutex_lock(&indio_dev->mlock);
> +		mutex_lock(&st->lock);
>  		st->cached_val = val;
>  		if (!st->pwr_down)
>  			ret = st->chip_info->write(st, val);
> -		mutex_unlock(&indio_dev->mlock);
> +		mutex_unlock(&st->lock);
>  		break;
>  	default:
>  		ret = -EINVAL;
> @@ -256,6 +258,8 @@ static int ad5446_probe(struct device *dev, const char *name,
>  	indio_dev->channels = &st->chip_info->channel;
>  	indio_dev->num_channels = 1;
>  
> +	mutex_init(&st->lock);
> +
>  	st->pwr_down_mode = MODE_PWRDWN_1k;
>  
>  	if (st->chip_info->int_vref_mv)

