Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 617E1D4F5D
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2019 13:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729002AbfJLLfB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Oct 2019 07:35:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:42116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728636AbfJLLfA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 Oct 2019 07:35:00 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 299462089C;
        Sat, 12 Oct 2019 11:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570880100;
        bh=M8pIuI3N9q6O19inwH7iwVRpRXidMZc87RjRVHszNGA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Agu+IATAylmCBlT5b/EgQcCruhFS4xRBrIagE47BvVsQdvK2+f01Klj3luzu7i7H5
         vfdtPY3aTojd4PoJSU/pvuDiXL8MigMgKGIpVYpO5mykAJhjZzBXNKoygiqR6hH/XK
         WTbaksUlStkjqZqm5ILC1KCZx4DZ+lI0zfL65Sbc=
Date:   Sat, 12 Oct 2019 12:34:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 2/8] iio: adc: max1027: Make it optional to use
 interrupts
Message-ID: <20191012123455.7317c298@archlinux>
In-Reply-To: <20191011144347.19146-3-miquel.raynal@bootlin.com>
References: <20191011144347.19146-1-miquel.raynal@bootlin.com>
        <20191011144347.19146-3-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 11 Oct 2019 16:43:41 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> The chip has a 'start conversion' and a 'end of conversion' pair of
> pins. They can be used but this is absolutely not mandatory as regular
> polling of the value is totally fine with the current internal
> clocking setup. Turn the interrupts optional and do not error out if
> they are not inquired in the device tree. This has the effect to
> prevent triggered buffers use though.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Applied.

Thanks,

> ---
>  drivers/iio/adc/max1027.c | 57 +++++++++++++++++++++------------------
>  1 file changed, 31 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
> index 6cdfe9ef73fc..823223b77a70 100644
> --- a/drivers/iio/adc/max1027.c
> +++ b/drivers/iio/adc/max1027.c
> @@ -430,35 +430,40 @@ static int max1027_probe(struct spi_device *spi)
>  		return -ENOMEM;
>  	}
>  
> -	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
> -					&iio_pollfunc_store_time,
> -					&max1027_trigger_handler, NULL);
> -	if (ret < 0) {
> -		dev_err(&indio_dev->dev, "Failed to setup buffer\n");
> -		return ret;
> -	}
> +	if (spi->irq) {
> +		ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
> +						      &iio_pollfunc_store_time,
> +						      &max1027_trigger_handler,
> +						      NULL);
> +		if (ret < 0) {
> +			dev_err(&indio_dev->dev, "Failed to setup buffer\n");
> +			return ret;
> +		}
>  
> -	st->trig = devm_iio_trigger_alloc(&spi->dev, "%s-trigger",
> -							indio_dev->name);
> -	if (st->trig == NULL) {
> -		ret = -ENOMEM;
> -		dev_err(&indio_dev->dev, "Failed to allocate iio trigger\n");
> -		return ret;
> -	}
> +		st->trig = devm_iio_trigger_alloc(&spi->dev, "%s-trigger",
> +						  indio_dev->name);
> +		if (st->trig == NULL) {
> +			ret = -ENOMEM;
> +			dev_err(&indio_dev->dev,
> +				"Failed to allocate iio trigger\n");
> +			return ret;
> +		}
>  
> -	st->trig->ops = &max1027_trigger_ops;
> -	st->trig->dev.parent = &spi->dev;
> -	iio_trigger_set_drvdata(st->trig, indio_dev);
> -	iio_trigger_register(st->trig);
> +		st->trig->ops = &max1027_trigger_ops;
> +		st->trig->dev.parent = &spi->dev;
> +		iio_trigger_set_drvdata(st->trig, indio_dev);
> +		iio_trigger_register(st->trig);
>  
> -	ret = devm_request_threaded_irq(&spi->dev, spi->irq,
> -					iio_trigger_generic_data_rdy_poll,
> -					NULL,
> -					IRQF_TRIGGER_FALLING,
> -					spi->dev.driver->name, st->trig);
> -	if (ret < 0) {
> -		dev_err(&indio_dev->dev, "Failed to allocate IRQ.\n");
> -		return ret;
> +		ret = devm_request_threaded_irq(&spi->dev, spi->irq,
> +						iio_trigger_generic_data_rdy_poll,
> +						NULL,
> +						IRQF_TRIGGER_FALLING,
> +						spi->dev.driver->name,
> +						st->trig);
> +		if (ret < 0) {
> +			dev_err(&indio_dev->dev, "Failed to allocate IRQ.\n");
> +			return ret;
> +		}
>  	}
>  
>  	/* Disable averaging */

