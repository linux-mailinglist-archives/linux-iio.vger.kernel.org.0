Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE47A1D6203
	for <lists+linux-iio@lfdr.de>; Sat, 16 May 2020 17:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgEPP1j (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 May 2020 11:27:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:35154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726715AbgEPP1j (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 May 2020 11:27:39 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86F652065C;
        Sat, 16 May 2020 15:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589642858;
        bh=ZPXKLSvA67ABmYzHMRhZ4zr3Hz8urY4fRCL7lFkBP18=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Yhzqgr6JK4sjWLINCXIRlIvXj/PVoWANEwakky1BNXdpjYsGTN6AQ+ECh6LfnqtFC
         auw8zvGJrxXWnmDgABZdWX8buFNzzjglbtjQf3fv558HbYPP8/zbMUs8bibx1UWTSx
         S9oGey3YDw/sEJoua5np+x/gHeO3iUKZsbi5M2rc=
Date:   Sat, 16 May 2020 16:27:34 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH] iio: dac: ad5421: Replace indio_dev->mlock with own
 device lock
Message-ID: <20200516162734.5888c326@archlinux>
In-Reply-To: <20200514091756.81425-1-sergiu.cuciurean@analog.com>
References: <20200514091756.81425-1-sergiu.cuciurean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 14 May 2020 12:17:53 +0300
Sergiu Cuciurean <sergiu.cuciurean@analog.com> wrote:

> As part of the general cleanup of indio_dev->mlock, this change replaces
> it with a local lock on the device's state structure.
> 
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Applied.

Thanks,

J

> ---
>  drivers/iio/dac/ad5421.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5421.c b/drivers/iio/dac/ad5421.c
> index 63063e85cd0a..fec27764cea8 100644
> --- a/drivers/iio/dac/ad5421.c
> +++ b/drivers/iio/dac/ad5421.c
> @@ -62,12 +62,14 @@
>   * @current_range:	current range which the device is configured for
>   * @data:		spi transfer buffers
>   * @fault_mask:		software masking of events
> + * @lock	lock to protect the data buffer during SPI ops
>   */
>  struct ad5421_state {
>  	struct spi_device		*spi;
>  	unsigned int			ctrl;
>  	enum ad5421_current_range	current_range;
>  	unsigned int			fault_mask;
> +	struct mutex			lock;
>  
>  	/*
>  	 * DMA (thus cache coherency maintenance) requires the
> @@ -142,11 +144,12 @@ static int ad5421_write_unlocked(struct iio_dev *indio_dev,
>  static int ad5421_write(struct iio_dev *indio_dev, unsigned int reg,
>  	unsigned int val)
>  {
> +	struct ad5421_state *st = iio_priv(indio_dev);
>  	int ret;
>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&st->lock);
>  	ret = ad5421_write_unlocked(indio_dev, reg, val);
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->lock);
>  
>  	return ret;
>  }
> @@ -166,7 +169,7 @@ static int ad5421_read(struct iio_dev *indio_dev, unsigned int reg)
>  		},
>  	};
>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&st->lock);
>  
>  	st->data[0].d32 = cpu_to_be32((1 << 23) | (reg << 16));
>  
> @@ -174,7 +177,7 @@ static int ad5421_read(struct iio_dev *indio_dev, unsigned int reg)
>  	if (ret >= 0)
>  		ret = be32_to_cpu(st->data[1].d32) & 0xffff;
>  
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->lock);
>  
>  	return ret;
>  }
> @@ -185,14 +188,14 @@ static int ad5421_update_ctrl(struct iio_dev *indio_dev, unsigned int set,
>  	struct ad5421_state *st = iio_priv(indio_dev);
>  	unsigned int ret;
>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&st->lock);
>  
>  	st->ctrl &= ~clr;
>  	st->ctrl |= set;
>  
>  	ret = ad5421_write_unlocked(indio_dev, AD5421_REG_CTRL, st->ctrl);
>  
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->lock);
>  
>  	return ret;
>  }
> @@ -400,12 +403,12 @@ static int ad5421_write_event_config(struct iio_dev *indio_dev,
>  		return -EINVAL;
>  	}
>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&st->lock);
>  	if (state)
>  		st->fault_mask |= mask;
>  	else
>  		st->fault_mask &= ~mask;
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->lock);
>  
>  	return 0;
>  }
> @@ -491,6 +494,8 @@ static int ad5421_probe(struct spi_device *spi)
>  	indio_dev->channels = ad5421_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(ad5421_channels);
>  
> +	mutex_init(&st->lock);
> +
>  	st->ctrl = AD5421_CTRL_WATCHDOG_DISABLE |
>  			AD5421_CTRL_AUTO_FAULT_READBACK;
>  

