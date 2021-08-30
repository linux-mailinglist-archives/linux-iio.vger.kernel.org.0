Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 854833FB3D2
	for <lists+linux-iio@lfdr.de>; Mon, 30 Aug 2021 12:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236278AbhH3K1q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Aug 2021 06:27:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:59736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233248AbhH3K1q (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Aug 2021 06:27:46 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BA2C610C7;
        Mon, 30 Aug 2021 10:26:50 +0000 (UTC)
Date:   Mon, 30 Aug 2021 11:30:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-iio@vger.kernel.org, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 13/16] iio: adc: max1027: Prepare re-using the EOC
 interrupt
Message-ID: <20210830112947.6f1806f5@jic23-huawei>
In-Reply-To: <20210818111139.330636-14-miquel.raynal@bootlin.com>
References: <20210818111139.330636-1-miquel.raynal@bootlin.com>
        <20210818111139.330636-14-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 18 Aug 2021 13:11:36 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Right now the driver only has hardware trigger support, which makes use
> of the End Of Conversion (EOC) interrupt by:
> - Enabling the external trigger
> - At completion of the conversion, run a generic handler
> - Push the data to the IIO subsystem by using the triggered buffer
>   infrastructure, which may not only serve this purpose.
> 
> In fact, the interrupt will fire for more reasons than just a hardware
> trigger condition, so make a dedicated interrupt handler which will be
> enhanced by the upcoming changes to handle more situations.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
one suggestion inline.
> ---
>  drivers/iio/adc/max1027.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
> index 2d6485591761..8d86e77fb5db 100644
> --- a/drivers/iio/adc/max1027.c
> +++ b/drivers/iio/adc/max1027.c
> @@ -472,6 +472,24 @@ static int max1027_read_scan(struct iio_dev *indio_dev)
>  	return 0;
>  }
>  
> +static irqreturn_t max1027_eoc_irq_handler(int irq, void *private)
> +{
> +	struct iio_dev *indio_dev = private;
> +	struct max1027_state *st = iio_priv(indio_dev);
> +	int ret = 0;
> +
> +	if (st->cnvst_trigger) {

I missed this earlier, but it is very similar in purpose to the
logic used in iio_trigger_validate_own_device.  Perhaps you could reuse that
rather than carrying an explicit variable to check for this?

> +		ret = max1027_read_scan(indio_dev);
> +		iio_trigger_notify_done(indio_dev->trig);
> +	}
> +
> +	if (ret)
> +		dev_err(&indio_dev->dev,
> +			"Cannot read scanned values (%d)\n", ret);

Perhaps better to move that into the if statement.  I guess this may
make more sense later though!


> +
> +	return IRQ_HANDLED;
> +}
> +
>  static irqreturn_t max1027_trigger_handler(int irq, void *private)
>  {
>  	struct iio_poll_func *pf = private;
> @@ -563,11 +581,11 @@ static int max1027_probe(struct spi_device *spi)
>  		}
>  
>  		ret = devm_request_threaded_irq(&spi->dev, spi->irq,
> -						iio_trigger_generic_data_rdy_poll,
> +						max1027_eoc_irq_handler,
>  						NULL,
>  						IRQF_TRIGGER_FALLING,
>  						spi->dev.driver->name,
> -						st->trig);
> +						indio_dev);
>  		if (ret < 0) {
>  			dev_err(&indio_dev->dev, "Failed to allocate IRQ.\n");
>  			return ret;

