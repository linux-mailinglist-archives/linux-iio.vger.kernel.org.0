Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3384025766A
	for <lists+linux-iio@lfdr.de>; Mon, 31 Aug 2020 11:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgHaJVt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 31 Aug 2020 05:21:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:57234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727833AbgHaJVt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 31 Aug 2020 05:21:49 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D4972073A;
        Mon, 31 Aug 2020 09:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598865709;
        bh=LBMlpvt8vx7YE8hUMwweeewewDzYo//6Gu4riCMFwSw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Zw4wMTVtflHP+iVNRYwW9icinjGS0TDzieUJG67D0sCGOhWRB9UyvZQtdDG6BPGh4
         Ztt2F7aAQ9gBgDJZ7VIMQ8nrJNXuM23cM7of6QAZS7KXUM1wIkv3+1dUO8xsiI7WTW
         DBjPEqmivlDGLjlnPe9zceAOOQKF8EJ35X5QOoAw=
Date:   Mon, 31 Aug 2020 10:21:45 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v1 1/8] iio: accel: bma220: Fix returned codes from
 bma220_init(), bma220_deinit()
Message-ID: <20200831102145.0eaebb77@archlinux>
In-Reply-To: <20200831090813.78841-1-andriy.shevchenko@linux.intel.com>
References: <20200831090813.78841-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 31 Aug 2020 12:08:06 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Potentially bma220_init() and bma220_deinit() may return positive codes.
> Fix the logic to return proper error codes instead.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Hi Andy

A nice straight forward set and I suspect we aren't going to get any other
reviews, hence...

Series applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to poke at it.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/bma220_spi.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/accel/bma220_spi.c b/drivers/iio/accel/bma220_spi.c
> index da8b36cc8628..3247b9c8abcb 100644
> --- a/drivers/iio/accel/bma220_spi.c
> +++ b/drivers/iio/accel/bma220_spi.c
> @@ -198,10 +198,12 @@ static int bma220_init(struct spi_device *spi)
>  
>  	/* Make sure the chip is powered on */
>  	ret = bma220_read_reg(spi, BMA220_REG_SUSPEND);
> +	if (ret == BMA220_SUSPEND_WAKE)
> +		ret = bma220_read_reg(spi, BMA220_REG_SUSPEND);
>  	if (ret < 0)
>  		return ret;
> -	else if (ret == BMA220_SUSPEND_WAKE)
> -		return bma220_read_reg(spi, BMA220_REG_SUSPEND);
> +	if (ret == BMA220_SUSPEND_WAKE)
> +		return -EBUSY;
>  
>  	return 0;
>  }
> @@ -212,10 +214,12 @@ static int bma220_deinit(struct spi_device *spi)
>  
>  	/* Make sure the chip is powered off */
>  	ret = bma220_read_reg(spi, BMA220_REG_SUSPEND);
> +	if (ret == BMA220_SUSPEND_SLEEP)
> +		ret = bma220_read_reg(spi, BMA220_REG_SUSPEND);
>  	if (ret < 0)
>  		return ret;
> -	else if (ret == BMA220_SUSPEND_SLEEP)
> -		return bma220_read_reg(spi, BMA220_REG_SUSPEND);
> +	if (ret == BMA220_SUSPEND_SLEEP)
> +		return -EBUSY;
>  
>  	return 0;
>  }
> @@ -245,7 +249,7 @@ static int bma220_probe(struct spi_device *spi)
>  	indio_dev->available_scan_masks = bma220_accel_scan_masks;
>  
>  	ret = bma220_init(data->spi_device);
> -	if (ret < 0)
> +	if (ret)
>  		return ret;
>  
>  	ret = iio_triggered_buffer_setup(indio_dev, iio_pollfunc_store_time,

