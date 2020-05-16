Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDDA1D6207
	for <lists+linux-iio@lfdr.de>; Sat, 16 May 2020 17:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgEPPaM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 May 2020 11:30:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:35798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbgEPPaM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 May 2020 11:30:12 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61E3C2065C;
        Sat, 16 May 2020 15:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589643011;
        bh=z8bxyBLYB8fq2Zb7d+hY8J3R/obCjAXeuupwbdAv0vI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=whLZIXImWP+hzMqnZu0EuwDWxc4WjpxqL0/aDoe6yoNJhlHJ/WikE5r/OvRgHrqDK
         EPTqX1/4mBMNAvxy5/dwnK7oCDkTwY/aNNaiBAep/qvh5gAYYdm8cp2MDHEdKoPUyY
         NOvfxp0XHo8Im4PNQFqhDezyVyhB7TBPpsZxsgXg=
Date:   Sat, 16 May 2020 16:30:07 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        Stefan Popa <stefan.popa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Michael Hennerich" <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] iio: dac: ad5686: Replace indio_dev->mlock with own
 device lock
Message-ID: <20200516163007.275a3da4@archlinux>
In-Reply-To: <20200514091940.81494-1-sergiu.cuciurean@analog.com>
References: <20200514091940.81494-1-sergiu.cuciurean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 14 May 2020 12:19:38 +0300
Sergiu Cuciurean <sergiu.cuciurean@analog.com> wrote:

> As part of the general cleanup of indio_dev->mlock, this change replaces
> it with a local lock on the device's state structure.
> 
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Applied,

Thanks,

Jonathan

> ---
>  drivers/iio/dac/ad5686.c | 10 ++++++----
>  drivers/iio/dac/ad5686.h |  2 ++
>  2 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
> index e06b29c565b9..8dd67da0a7da 100644
> --- a/drivers/iio/dac/ad5686.c
> +++ b/drivers/iio/dac/ad5686.c
> @@ -127,9 +127,9 @@ static int ad5686_read_raw(struct iio_dev *indio_dev,
>  
>  	switch (m) {
>  	case IIO_CHAN_INFO_RAW:
> -		mutex_lock(&indio_dev->mlock);
> +		mutex_lock(&st->lock);
>  		ret = st->read(st, chan->address);
> -		mutex_unlock(&indio_dev->mlock);
> +		mutex_unlock(&st->lock);
>  		if (ret < 0)
>  			return ret;
>  		*val = (ret >> chan->scan_type.shift) &
> @@ -157,12 +157,12 @@ static int ad5686_write_raw(struct iio_dev *indio_dev,
>  		if (val > (1 << chan->scan_type.realbits) || val < 0)
>  			return -EINVAL;
>  
> -		mutex_lock(&indio_dev->mlock);
> +		mutex_lock(&st->lock);
>  		ret = st->write(st,
>  				AD5686_CMD_WRITE_INPUT_N_UPDATE_N,
>  				chan->address,
>  				val << chan->scan_type.shift);
> -		mutex_unlock(&indio_dev->mlock);
> +		mutex_unlock(&st->lock);
>  		break;
>  	default:
>  		ret = -EINVAL;
> @@ -468,6 +468,8 @@ int ad5686_probe(struct device *dev,
>  	indio_dev->channels = st->chip_info->channels;
>  	indio_dev->num_channels = st->chip_info->num_channels;
>  
> +	mutex_init(&st->lock);
> +
>  	switch (st->chip_info->regmap_type) {
>  	case AD5310_REGMAP:
>  		cmd = AD5686_CMD_CONTROL_REG;
> diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
> index 70a779939ddb..52009b5eef88 100644
> --- a/drivers/iio/dac/ad5686.h
> +++ b/drivers/iio/dac/ad5686.h
> @@ -117,6 +117,7 @@ struct ad5686_chip_info {
>   * @pwr_down_mask:	power down mask
>   * @pwr_down_mode:	current power down mode
>   * @use_internal_vref:	set to true if the internal reference voltage is used
> + * @lock		lock to protect the data buffer during regmap ops
>   * @data:		spi transfer buffers
>   */
>  
> @@ -130,6 +131,7 @@ struct ad5686_state {
>  	ad5686_write_func		write;
>  	ad5686_read_func		read;
>  	bool				use_internal_vref;
> +	struct mutex			lock;
>  
>  	/*
>  	 * DMA (thus cache coherency maintenance) requires the

