Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6367D3FB41F
	for <lists+linux-iio@lfdr.de>; Mon, 30 Aug 2021 12:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236411AbhH3KwJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Aug 2021 06:52:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:46016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236324AbhH3KwJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Aug 2021 06:52:09 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E387F610D1;
        Mon, 30 Aug 2021 10:51:13 +0000 (UTC)
Date:   Mon, 30 Aug 2021 11:54:25 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-iio@vger.kernel.org, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 16/16] iio: adc: max1027: Enable software triggers to be
 used without IRQ
Message-ID: <20210830115425.3fdb31b9@jic23-huawei>
In-Reply-To: <20210818111139.330636-17-miquel.raynal@bootlin.com>
References: <20210818111139.330636-1-miquel.raynal@bootlin.com>
        <20210818111139.330636-17-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 18 Aug 2021 13:11:39 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Software triggers do not need a device IRQ to work. As opposed to
> hardware triggers which need it to yield the data to the IIO core,
> software triggers run a dedicated thread which does all the tasks on
> their behalf. Then, the end of conversion status may either come from an
> interrupt or from a sufficient enough extra delay. IRQs are not
> mandatory so move the triggered buffer setup out of the IRQ condition.

I'd stop referring to software triggers in these descriptions.  This
could just as easily be about enabling a different hardware trigger
such as a gpio trigger or indeed on a dataready trigger provided by
an entirely different device.

Otherwise the logic is correct.

Good to get this more flexible support into the driver.  If we can
make it a tiny bit more flexible by enabling use of the cnvst trigger
to drive this 'and' other drivers that would be even better and
conform more closely to the normal way an IIO driver work.

The validate_device / validate_trigger callbacks are often about
making it easier to bring a device driver up in the first place, so
it's great to see them go away in later improvements like this.
(note I'm not saying there aren't complex cases where we can't remove
them though!)

Jonathan


> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/iio/adc/max1027.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
> index bb437e43adaf..e767437a578e 100644
> --- a/drivers/iio/adc/max1027.c
> +++ b/drivers/iio/adc/max1027.c
> @@ -567,16 +567,18 @@ static int max1027_probe(struct spi_device *spi)
>  	if (!st->buffer)
>  		return -ENOMEM;
>  
> +	/* Enable triggered buffers */
> +	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
> +					      &iio_pollfunc_store_time,
> +					      &max1027_trigger_handler,
> +					      NULL);
> +	if (ret < 0) {
> +		dev_err(&indio_dev->dev, "Failed to setup buffer\n");
> +		return ret;
> +	}
> +
> +	/* If there is an EOC interrupt, enable the hardware trigger (cnvst) */
>  	if (spi->irq) {
> -		ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
> -						      &iio_pollfunc_store_time,
> -						      &max1027_trigger_handler,
> -						      NULL);
> -		if (ret < 0) {
> -			dev_err(&indio_dev->dev, "Failed to setup buffer\n");
> -			return ret;
> -		}
> -
>  		st->trig = devm_iio_trigger_alloc(&spi->dev, "%s-trigger",
>  						  indio_dev->name);
>  		if (st->trig == NULL) {

