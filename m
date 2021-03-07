Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56809330100
	for <lists+linux-iio@lfdr.de>; Sun,  7 Mar 2021 13:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbhCGMrA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Mar 2021 07:47:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:48488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230260AbhCGMqa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Mar 2021 07:46:30 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2949650FA;
        Sun,  7 Mar 2021 12:46:28 +0000 (UTC)
Date:   Sun, 7 Mar 2021 12:46:25 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Evgeny Boger <boger@wirenboard.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: Re: [PATCH] iio: adc: axp20x_adc: fix charging current reporting on
 AXP22x
Message-ID: <20210307124625.08109dea@archlinux>
In-Reply-To: <20210306235238.30379-1-boger@wirenboard.com>
References: <20210306235238.30379-1-boger@wirenboard.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun,  7 Mar 2021 02:52:38 +0300
Evgeny Boger <boger@wirenboard.com> wrote:

> Both the charging and discharging currents on AXP22x are stored as
> 12-bit integers, in accordance with the datasheet.
> It's also confirmed by vendor BSP (axp20x_adc.c:axp22_icharge_to_mA).
> 
> The scale factor of 0.5 is never mentioned in datasheet, nor in the
> vendor source code. I think it was here to compensate for
> erroneous additional bit in register width.
> 
> Tested on custom A40i+AXP221s board with external ammeter as
> a reference.
> 
> Signed-off-by: Evgeny Boger <boger@wirenboard.com>

+CC Quentin's bootlin address.

One comment inline,

Jonathan

> ---
>  drivers/iio/adc/axp20x_adc.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
> index 3e0c0233b431..8db6699c20c3 100644
> --- a/drivers/iio/adc/axp20x_adc.c
> +++ b/drivers/iio/adc/axp20x_adc.c
> @@ -253,17 +253,7 @@ static int axp22x_adc_raw(struct iio_dev *indio_dev,
>  	struct axp20x_adc_iio *info = iio_priv(indio_dev);
>  	int size;
>  
> -	/*
> -	 * N.B.: Unlike the Chinese datasheets tell, the charging current is
> -	 * stored on 12 bits, not 13 bits. Only discharging current is on 13
> -	 * bits.
> -	 */
> -	if (chan->type == IIO_CURRENT && chan->channel == AXP22X_BATT_DISCHRG_I)
> -		size = 13;
> -	else
> -		size = 12;
> -
> -	*val = axp20x_read_variable_width(info->regmap, chan->address, size);
> +	*val = axp20x_read_variable_width(info->regmap, chan->address, 12);
>  	if (*val < 0)
>  		return *val;
>  
> @@ -387,7 +377,7 @@ static int axp22x_adc_scale(struct iio_chan_spec const *chan, int *val,
>  
>  	case IIO_CURRENT:
>  		*val = 0;
> -		*val2 = 500000;
> +		*val2 = 1000000;
>  		return IIO_VAL_INT_PLUS_MICRO;
		*val = 1;
		return IIO_VAL_INT;

Should work if the scale factor is 1.
Note that we could just have reported the channel as _processed in the first place, but
given we didn't better to keep the ABI the same and just have a noop scale factor.

>  
>  	case IIO_TEMP:

