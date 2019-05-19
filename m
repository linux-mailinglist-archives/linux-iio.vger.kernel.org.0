Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 004AD227DF
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2019 19:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfESRhW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 May 2019 13:37:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:39214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726472AbfESRhV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 May 2019 13:37:21 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A0AE214D8;
        Sun, 19 May 2019 10:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558261797;
        bh=XzlTETSMrzArR830GrEOHizV3Tpk3ohasxsl/cG3kLo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HvjBcJ20xJPkYcnBZXtTexX3Q9oLp+na2+udcGibyOclGZLbFG+S8H1FXz3GXfioz
         fnTjdd1L6Y2F18ct5mvA08pAi47sJ5rnZ9c+NYlnM+fRMj1Tsuh9hIQtxgKtnlT10y
         YtkC1zvVFsgv2RmjxJmbjIbN4A4oKjRUrtPbzUss=
Date:   Sun, 19 May 2019 11:29:52 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Melissa Wen <melissa.srw@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Barry Song <21cnbao@gmail.com>, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com
Subject: Re: [PATCH] staging:iio:ad7150: fix threshold mode config bit
Message-ID: <20190519112952.58142fb0@archlinux>
In-Reply-To: <20190519010456.lwq7n2e6nkqa6niz@smtp.gmail.com>
References: <20190519010456.lwq7n2e6nkqa6niz@smtp.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 18 May 2019 22:04:56 -0300
Melissa Wen <melissa.srw@gmail.com> wrote:

> According to the AD7150 configuration register description, bit 7 assumes
> value 1 when the threshold mode is fixed and 0 when it is adaptive,
> however, the operation that identifies this mode was considering the
> opposite values.
> 
> This patch renames the boolean variable to describe it correctly and
> properly replaces it in the places where it is used.
> 
> Fixes: 531efd6aa0991 ("staging:iio:adc:ad7150: chan_spec conv + i2c_smbus commands + drop unused poweroff timeout control.")
> Signed-off-by: Melissa Wen <melissa.srw@gmail.com>

Looks good to me.  Applied to the fixes-togreg branch of iio.git pushed out as
as testing-fixes for the autobuilders to see if they can find anything
we have missed.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/cdc/ad7150.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
> index dd7fcab8e19e..e075244c602b 100644
> --- a/drivers/staging/iio/cdc/ad7150.c
> +++ b/drivers/staging/iio/cdc/ad7150.c
> @@ -5,6 +5,7 @@
>   * Copyright 2010-2011 Analog Devices Inc.
>   */
>  
> +#include <linux/bitfield.h>
>  #include <linux/interrupt.h>
>  #include <linux/device.h>
>  #include <linux/kernel.h>
> @@ -130,7 +131,7 @@ static int ad7150_read_event_config(struct iio_dev *indio_dev,
>  {
>  	int ret;
>  	u8 threshtype;
> -	bool adaptive;
> +	bool thrfixed;
>  	struct ad7150_chip_info *chip = iio_priv(indio_dev);
>  
>  	ret = i2c_smbus_read_byte_data(chip->client, AD7150_CFG);
> @@ -138,21 +139,23 @@ static int ad7150_read_event_config(struct iio_dev *indio_dev,
>  		return ret;
>  
>  	threshtype = (ret >> 5) & 0x03;
> -	adaptive = !!(ret & 0x80);
> +
> +	/*check if threshold mode is fixed or adaptive*/
> +	thrfixed = FIELD_GET(AD7150_CFG_FIX, ret);
>  
>  	switch (type) {
>  	case IIO_EV_TYPE_MAG_ADAPTIVE:
>  		if (dir == IIO_EV_DIR_RISING)
> -			return adaptive && (threshtype == 0x1);
> -		return adaptive && (threshtype == 0x0);
> +			return !thrfixed && (threshtype == 0x1);
> +		return !thrfixed && (threshtype == 0x0);
>  	case IIO_EV_TYPE_THRESH_ADAPTIVE:
>  		if (dir == IIO_EV_DIR_RISING)
> -			return adaptive && (threshtype == 0x3);
> -		return adaptive && (threshtype == 0x2);
> +			return !thrfixed && (threshtype == 0x3);
> +		return !thrfixed && (threshtype == 0x2);
>  	case IIO_EV_TYPE_THRESH:
>  		if (dir == IIO_EV_DIR_RISING)
> -			return !adaptive && (threshtype == 0x1);
> -		return !adaptive && (threshtype == 0x0);
> +			return thrfixed && (threshtype == 0x1);
> +		return thrfixed && (threshtype == 0x0);
>  	default:
>  		break;
>  	}

