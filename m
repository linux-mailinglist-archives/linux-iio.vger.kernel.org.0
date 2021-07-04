Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D08EB3BADE9
	for <lists+linux-iio@lfdr.de>; Sun,  4 Jul 2021 19:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbhGDRI3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 4 Jul 2021 13:08:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:47530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229539AbhGDRI3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 4 Jul 2021 13:08:29 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 543AB61283;
        Sun,  4 Jul 2021 17:05:52 +0000 (UTC)
Date:   Sun, 4 Jul 2021 18:08:17 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: accel: bma220: convert probe to device-managed
 functions
Message-ID: <20210704180817.3160e83f@jic23-huawei>
In-Reply-To: <20210625140137.362282-1-aardelean@deviqon.com>
References: <20210625140137.362282-1-aardelean@deviqon.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 25 Jun 2021 17:01:36 +0300
Alexandru Ardelean <aardelean@deviqon.com> wrote:

> This change converts the driver to use devm_iio_triggered_buffer_setup()
> and devm_iio_device_register() for initializing and registering the IIO
> device.
> 
> The bma220_deinit() is converted into a callback for a
> devm_add_action_or_reset() hook, so that the device is put in stand-by when
> the driver gets uninitialized.
> The return value of the bma220_deinit() function isn't used as it does not
> add any value. On the error path of the probe function, this can just
> override the actual error with -EBUSY, or can even return 0 (no error), on
> the error path.
> 
> Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
Hmm. That return on the error path issue in probe is almost worth a backported
fix, but meh, it's been there for ages so unless anyone shouts, let us assume
it never bit anyone.

Otherwise, this looks fine.  I'm not going to comment on all the similar
devm patches you have on list unless I have something I want changed.
I'll pick them all up in a week or two once we are well into the new cycle.

thanks,

Jonathan

> ---
>  drivers/iio/accel/bma220_spi.c | 44 +++++++++-------------------------
>  1 file changed, 11 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/iio/accel/bma220_spi.c b/drivers/iio/accel/bma220_spi.c
> index 0622c7936499..0095931a11f8 100644
> --- a/drivers/iio/accel/bma220_spi.c
> +++ b/drivers/iio/accel/bma220_spi.c
> @@ -218,20 +218,14 @@ static int bma220_init(struct spi_device *spi)
>  	return 0;
>  }
>  
> -static int bma220_deinit(struct spi_device *spi)
> +static void bma220_deinit(void *spi)
>  {
>  	int ret;
>  
>  	/* Make sure the chip is powered off */
>  	ret = bma220_read_reg(spi, BMA220_REG_SUSPEND);
>  	if (ret == BMA220_SUSPEND_SLEEP)
> -		ret = bma220_read_reg(spi, BMA220_REG_SUSPEND);
> -	if (ret < 0)
> -		return ret;
> -	if (ret == BMA220_SUSPEND_SLEEP)
> -		return -EBUSY;
> -
> -	return 0;
> +		bma220_read_reg(spi, BMA220_REG_SUSPEND);
>  }
>  
>  static int bma220_probe(struct spi_device *spi)
> @@ -262,34 +256,19 @@ static int bma220_probe(struct spi_device *spi)
>  	if (ret)
>  		return ret;
>  
> -	ret = iio_triggered_buffer_setup(indio_dev, iio_pollfunc_store_time,
> -					 bma220_trigger_handler, NULL);
> -	if (ret < 0) {
> -		dev_err(&spi->dev, "iio triggered buffer setup failed\n");
> -		goto err_suspend;
> -	}
> +	ret = devm_add_action_or_reset(&spi->dev, bma220_deinit, spi);
> +	if (ret)
> +		return ret;
>  
> -	ret = iio_device_register(indio_dev);
> +	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
> +					      iio_pollfunc_store_time,
> +					      bma220_trigger_handler, NULL);
>  	if (ret < 0) {
> -		dev_err(&spi->dev, "iio_device_register failed\n");
> -		iio_triggered_buffer_cleanup(indio_dev);
> -		goto err_suspend;
> +		dev_err(&spi->dev, "iio triggered buffer setup failed\n");
> +		return ret;
>  	}
>  
> -	return 0;
> -
> -err_suspend:
> -	return bma220_deinit(spi);
> -}
> -
> -static int bma220_remove(struct spi_device *spi)
> -{
> -	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> -
> -	iio_device_unregister(indio_dev);
> -	iio_triggered_buffer_cleanup(indio_dev);
> -
> -	return bma220_deinit(spi);
> +	return devm_iio_device_register(&spi->dev, indio_dev);
>  }
>  
>  static __maybe_unused int bma220_suspend(struct device *dev)
> @@ -326,7 +305,6 @@ static struct spi_driver bma220_driver = {
>  		.acpi_match_table = bma220_acpi_id,
>  	},
>  	.probe =            bma220_probe,
> -	.remove =           bma220_remove,
>  	.id_table =         bma220_spi_id,
>  };
>  module_spi_driver(bma220_driver);

