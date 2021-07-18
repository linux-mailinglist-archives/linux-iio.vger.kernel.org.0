Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE9F53CC990
	for <lists+linux-iio@lfdr.de>; Sun, 18 Jul 2021 16:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233693AbhGROaL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Jul 2021 10:30:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:46140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232973AbhGROaL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 18 Jul 2021 10:30:11 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F115D611AB;
        Sun, 18 Jul 2021 14:27:11 +0000 (UTC)
Date:   Sun, 18 Jul 2021 15:29:36 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maury Anderson <maury.anderson@rockwellcollins.com>
Subject: Re: [PATCH] iio: potentiometer: max5481: convert probe to
 device-managed
Message-ID: <20210718152936.3d4194e6@jic23-huawei>
In-Reply-To: <20210624080641.9953-1-aardelean@deviqon.com>
References: <20210624080641.9953-1-aardelean@deviqon.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 24 Jun 2021 11:06:41 +0300
Alexandru Ardelean <aardelean@deviqon.com> wrote:

> The change converts the probe function to use the
> devm_iio_device_register() function.
> 
> Before calling that, we need to register an action to store the wiper back
> to non-volatile memory when the device is de-registered.
> 
> We don't need to do this if the probe fails, because the only place where
> the probe can fail now is devm_iio_device_register() and that shouldn't
> create an IIO device (for userspace to poke at) if it fails.
> 
> Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
Hi Alex,

This one took a little bit of thought because it's a bit unusual in that
that wiper write back isn't technically unwinding anything so doesn't
have an obvious match in probe.  However, as it logically wants to happen
just after we've removed the userspace interfaces, I agree with your
logic that it makes sense to do it with a devm triggered call.

So, on that basis applied. 

+CC Maury on basis might still be about on that address and want to
express a view on whether this makes sense.

Jonathan

> ---
>  drivers/iio/potentiometer/max5481.c | 22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iio/potentiometer/max5481.c b/drivers/iio/potentiometer/max5481.c
> index 6e22b538091f..098d144a8fdd 100644
> --- a/drivers/iio/potentiometer/max5481.c
> +++ b/drivers/iio/potentiometer/max5481.c
> @@ -125,6 +125,11 @@ static const struct of_device_id max5481_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, max5481_match);
>  
> +static void max5481_wiper_save(void *data)
> +{
> +	max5481_write_cmd(data, MAX5481_COPY_AB_TO_NV, 0);
> +}
> +
>  static int max5481_probe(struct spi_device *spi)
>  {
>  	struct iio_dev *indio_dev;
> @@ -136,7 +141,6 @@ static int max5481_probe(struct spi_device *spi)
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
> -	spi_set_drvdata(spi, indio_dev);
>  	data = iio_priv(indio_dev);
>  
>  	data->spi = spi;
> @@ -158,18 +162,11 @@ static int max5481_probe(struct spi_device *spi)
>  	if (ret < 0)
>  		return ret;
>  
> -	return iio_device_register(indio_dev);
> -}
> -
> -static int max5481_remove(struct spi_device *spi)
> -{
> -	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> -	struct max5481_data *data = iio_priv(indio_dev);
> -
> -	iio_device_unregister(indio_dev);
> +	ret = devm_add_action(&spi->dev, max5481_wiper_save, data);
> +	if (ret < 0)
> +		return ret;
>  
> -	/* save wiper reg to NV reg */
> -	return max5481_write_cmd(data, MAX5481_COPY_AB_TO_NV, 0);
> +	return devm_iio_device_register(&spi->dev, indio_dev);
>  }
>  
>  static const struct spi_device_id max5481_id_table[] = {
> @@ -187,7 +184,6 @@ static struct spi_driver max5481_driver = {
>  		.of_match_table = max5481_match,
>  	},
>  	.probe = max5481_probe,
> -	.remove = max5481_remove,
>  	.id_table = max5481_id_table,
>  };
>  

