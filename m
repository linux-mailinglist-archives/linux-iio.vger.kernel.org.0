Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9D115416F
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2020 10:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgBFJ5D (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Feb 2020 04:57:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:34838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727543AbgBFJ5D (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 6 Feb 2020 04:57:03 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25D00218AC;
        Thu,  6 Feb 2020 09:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580983022;
        bh=w5Y3Ebc9eXglcMDX0+yLDXi/+gEfId6scYpQlhbnOB4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yDRQhegVLxfBg/vQDPaq2zQYj8Lg5yMrJ9+FCjaLE20fPcNZHTx/p6oZH1mj7O20j
         vmRB283zBbLC9ieUPnzOjQ7lrNTL8pz5DR3PbPsnooWd0GX3ey0ZOpjO9260TmrEQc
         5sUOIlRZb9l/S13iTd50BZCPeL5TchmY1GZQOWcE=
Date:   Thu, 6 Feb 2020 09:56:59 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Tachici <alexandru.tachici@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5 V2] staging: iio: adc: ad7192: fail probe on
 get_voltage
Message-ID: <20200206095659.639218f7@archlinux>
In-Reply-To: <20200205171511.25912-2-alexandru.tachici@analog.com>
References: <20200202162215.50915c83@archlinux>
        <20200205171511.25912-1-alexandru.tachici@analog.com>
        <20200205171511.25912-2-alexandru.tachici@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 5 Feb 2020 19:15:07 +0200
Alexandru Tachici <alexandru.tachici@analog.com> wrote:

> This patch makes the ad7192_probe fail in case
> regulator_get_voltage will return an error.
> 
> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>

There is a subtlety in here we should handle.

> ---
>  drivers/staging/iio/adc/ad7192.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
> index bf3e2a9cc07f..4780ddf99b13 100644
> --- a/drivers/staging/iio/adc/ad7192.c
> +++ b/drivers/staging/iio/adc/ad7192.c
> @@ -899,10 +899,13 @@ static int ad7192_probe(struct spi_device *spi)
>  
>  	voltage_uv = regulator_get_voltage(st->avdd);
>
I had to dig a bit to check this as it's not documented.
regulator_get_voltage returns negative for error, not 0.
0 typically means the voltage has not been set or has been
explicitly set to 0. 

So if it is set to 0 I suppose we could try setting it as it
might be a variable high precision reference?

Perhaps for now just spitting out an error is the best plan.

  
> -	if (voltage_uv)
> +	if (voltage_uv) {
>  		st->int_vref_mv = voltage_uv / 1000;
> -	else
> +	} else {
> +		ret = voltage_uv;
>  		dev_err(&spi->dev, "Device tree error, reference voltage undefined\n");
> +		goto error_disable_avdd;
> +	}
>  
>  	spi_set_drvdata(spi, indio_dev);
>  	st->devid = spi_get_device_id(spi)->driver_data;
> @@ -957,6 +960,7 @@ static int ad7192_probe(struct spi_device *spi)
>  	ret = iio_device_register(indio_dev);
>  	if (ret < 0)
>  		goto error_disable_clk;
> +
We shouldn't have stray white space changes in a patch making a real change.

Thanks,

Jonathan

>  	return 0;
>  
>  error_disable_clk:

