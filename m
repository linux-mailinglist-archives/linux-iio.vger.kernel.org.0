Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5615DCD051
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2019 12:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbfJFKSo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Oct 2019 06:18:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:59026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbfJFKSo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 Oct 2019 06:18:44 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C1182084B;
        Sun,  6 Oct 2019 10:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570357123;
        bh=Hs0o7/dBnlcRwvSMzuuAN5/kh1ICB959hgUeMY2CjFE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ais7wBHIGPFz5WZWvZkzghxsi6cnHYcriJXw1KSgkmLJ5nBQFqIgFIe2Z83qz/sma
         r6vbn438WfnpW5z50m4mfFFIEwAq8ZAS9hz85WQzrCdK6clRwM7u+JBCZbn7yMOkHA
         o5r33tlMCl4g/OrvR0eub12YCyPQPgWJbiNRTYqk=
Date:   Sun, 6 Oct 2019 11:18:37 +0100
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
Subject: Re: [PATCH v2 2/7] iio: adc: max1027: Make it optional to use
 interrupts
Message-ID: <20191006111837.33fdfe25@archlinux>
In-Reply-To: <20191003173401.16343-3-miquel.raynal@bootlin.com>
References: <20191003173401.16343-1-miquel.raynal@bootlin.com>
        <20191003173401.16343-3-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  3 Oct 2019 19:33:56 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> The chip has a 'start conversion' and a 'end of conversion' pair of
> pins. They can be used but this is absolutely not mandatory as regular
> polling of the value is totally fine with the current internal
> clocking setup. Turn the interrupts optional and do not error out if
> they are not inquired in the device tree. This has the effect to
> prevent triggered buffers use though.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Hmm. I haven't looked a this in a great deal of depth but if we support
single channel reads it should be possible to allow the use of a
trigger from elsewhere.  Looks like a fair bit of new code would be needed
to support that though.  So perhaps this is a good first step.

It's a bit annoying that the hardware doesn't provide a EOC bit
anywhere in the registers.  That would have allowed us to be a bit
cleverer.

Anyhow, this looks fine to me.

Thanks,

Jonathan

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

