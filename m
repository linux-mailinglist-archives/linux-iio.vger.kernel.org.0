Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92F3E457FE7
	for <lists+linux-iio@lfdr.de>; Sat, 20 Nov 2021 18:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235201AbhKTRrn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 20 Nov 2021 12:47:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:49890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhKTRrn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 20 Nov 2021 12:47:43 -0500
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76BC760C49;
        Sat, 20 Nov 2021 17:44:38 +0000 (UTC)
Date:   Sat, 20 Nov 2021 17:49:30 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Evgeny Boger <boger@wirenboard.com>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Chen-Yu Tsai <wens@csie.org>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: Re: [PATCH v2] iio: adc: axp20x_adc: fix charging current reporting
 on AXP22x
Message-ID: <20211120174930.1ec11e77@jic23-huawei>
In-Reply-To: <20211116213746.264378-1-boger@wirenboard.com>
References: <20211116213746.264378-1-boger@wirenboard.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 17 Nov 2021 00:37:46 +0300
Evgeny Boger <boger@wirenboard.com> wrote:

> Both the charging and discharging currents on AXP22x are stored as
> 12-bit integers, in accordance with the datasheet.
> It's also confirmed by vendor BSP (axp20x_adc.c:axp22_icharge_to_mA).
> 
> The scale factor of 0.5 is never mentioned in datasheet, nor in the
> vendor source code. I think it was here to compensate for
> erroneous addition bit in register width.
> 
> Tested on custom A40i+AXP221s board with external ammeter as
> a reference.
> 
> Signed-off-by: Evgeny Boger <boger@wirenboard.com>

I know Quentin has moved on from Bootlin, so looking for input from Chen-Yu Tsai
for these as I have no idea :)

I have pinged Quentin as well on off chance he still wants to take a look.

Jonathan

> ---
> 
> Notes:
>     Changes from v1:
>       - return scale factor of 1 as IIO_VAL_INT, not IIO_VAL_INT_PLUS_MICRO
>       - get rid of unused variable
> 
>  drivers/iio/adc/axp20x_adc.c | 18 +++---------------
>  1 file changed, 3 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
> index 3e0c0233b431..df99f1365c39 100644
> --- a/drivers/iio/adc/axp20x_adc.c
> +++ b/drivers/iio/adc/axp20x_adc.c
> @@ -251,19 +251,8 @@ static int axp22x_adc_raw(struct iio_dev *indio_dev,
>  			  struct iio_chan_spec const *chan, int *val)
>  {
>  	struct axp20x_adc_iio *info = iio_priv(indio_dev);
> -	int size;
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
> @@ -386,9 +375,8 @@ static int axp22x_adc_scale(struct iio_chan_spec const *chan, int *val,
>  		return IIO_VAL_INT_PLUS_MICRO;
>  
>  	case IIO_CURRENT:
> -		*val = 0;
> -		*val2 = 500000;
> -		return IIO_VAL_INT_PLUS_MICRO;
> +		*val = 1;
> +		return IIO_VAL_INT;
>  
>  	case IIO_TEMP:
>  		*val = 100;

