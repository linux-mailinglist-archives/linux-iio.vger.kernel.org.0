Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 564D937FAE4
	for <lists+linux-iio@lfdr.de>; Thu, 13 May 2021 17:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234957AbhEMPiz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 May 2021 11:38:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:42776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234960AbhEMPix (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 13 May 2021 11:38:53 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2896561439;
        Thu, 13 May 2021 15:37:41 +0000 (UTC)
Date:   Thu, 13 May 2021 16:38:50 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan.Cameron@huawei.com, alexandru.tachici@analog.com,
        linux@deviqon.com
Subject: Re: [PATCH v4 04/12] iio: adc: ad7192: handle regulator voltage
 error first
Message-ID: <20210513163850.434d8994@jic23-huawei>
In-Reply-To: <20210513120752.90074-5-aardelean@deviqon.com>
References: <20210513120752.90074-1-aardelean@deviqon.com>
        <20210513120752.90074-5-aardelean@deviqon.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 13 May 2021 15:07:44 +0300
Alexandru Ardelean <aardelean@deviqon.com> wrote:

> This change fixes a corner-case, where for a zero regulator value, the
> driver would exit early, initializing the driver only partially.
> The driver would be in an unknown state.
> 
> This change reworks the code to check regulator_voltage() return value
> for negative (error) first, and return early. This is the more common
> idiom.
> 
> Also, this change is removing the 'voltage_uv' variable and using the 'ret'
> value directly. The only place where 'voltage_uv' is being used is to
> compute the internal reference voltage, and the type of this variable is
> 'int' (same are for 'ret'). Using only 'ret' avoids having to assign it on
> the error path.
> 
> Fixes: ab0afa65bbc7 ("staging: iio: adc: ad7192: fail probe on get_voltage")
> Cc: Alexandru Tachici <alexandru.tachici@analog.com>
> Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>

I've applied the first 4 patches to the fixes-togreg branch of iio.git and
cc'd stable.

Added note to the first 3 about the sign-off chain as its a bit unusual
for it to include loops ;)  I always debate if I should sign-off again
when this happens, but decide against.

Jonathan

> ---
>  drivers/iio/adc/ad7192.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> index d3be67aa0522..1141cc13a124 100644
> --- a/drivers/iio/adc/ad7192.c
> +++ b/drivers/iio/adc/ad7192.c
> @@ -912,7 +912,7 @@ static int ad7192_probe(struct spi_device *spi)
>  {
>  	struct ad7192_state *st;
>  	struct iio_dev *indio_dev;
> -	int ret, voltage_uv = 0;
> +	int ret;
>  
>  	if (!spi->irq) {
>  		dev_err(&spi->dev, "no IRQ?\n");
> @@ -949,15 +949,12 @@ static int ad7192_probe(struct spi_device *spi)
>  		goto error_disable_avdd;
>  	}
>  
> -	voltage_uv = regulator_get_voltage(st->avdd);
> -
> -	if (voltage_uv > 0) {
> -		st->int_vref_mv = voltage_uv / 1000;
> -	} else {
> -		ret = voltage_uv;
> +	ret = regulator_get_voltage(st->avdd);
> +	if (ret < 0) {
>  		dev_err(&spi->dev, "Device tree error, reference voltage undefined\n");
>  		goto error_disable_avdd;
>  	}
> +	st->int_vref_mv = ret / 1000;
>  
>  	spi_set_drvdata(spi, indio_dev);
>  	st->chip_info = of_device_get_match_data(&spi->dev);

