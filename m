Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08B543FB39D
	for <lists+linux-iio@lfdr.de>; Mon, 30 Aug 2021 12:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbhH3KKW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Aug 2021 06:10:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:53998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230194AbhH3KKV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Aug 2021 06:10:21 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64D49610A2;
        Mon, 30 Aug 2021 10:09:26 +0000 (UTC)
Date:   Mon, 30 Aug 2021 11:12:38 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-iio@vger.kernel.org, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 05/16] iio: adc: max1027: Drop extra warning message
Message-ID: <20210830111217.02de96e4@jic23-huawei>
In-Reply-To: <20210818111139.330636-6-miquel.raynal@bootlin.com>
References: <20210818111139.330636-1-miquel.raynal@bootlin.com>
        <20210818111139.330636-6-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 18 Aug 2021 13:11:28 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Memory allocation errors automatically trigger the right logs, no need
> to have our own.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/iio/adc/max1027.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
> index d79dabf20567..ac603b4ca787 100644
> --- a/drivers/iio/adc/max1027.c
> +++ b/drivers/iio/adc/max1027.c
> @@ -461,10 +461,8 @@ static int max1027_probe(struct spi_device *spi)
>  	st->buffer = devm_kmalloc_array(&indio_dev->dev,
>  				  indio_dev->num_channels, 2,
>  				  GFP_KERNEL);
> -	if (st->buffer == NULL) {
> -		dev_err(&indio_dev->dev, "Can't allocate buffer\n");
> +	if (!st->buffer)
Don't change the form of the check.  Whilst it doesn't matter in general
which of these is used (and I actually prefer the one you end up with) this
change makes this case inconsistent with the style elsewhere in the driver.

If you want to clean these all up then I don't mind that, but please do
the lot in one patch doing just that.

Thanks,

Jonathan

>  		return -ENOMEM;
> -	}
>  
>  	if (spi->irq) {
>  		ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,

