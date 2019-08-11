Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32195890D1
	for <lists+linux-iio@lfdr.de>; Sun, 11 Aug 2019 11:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbfHKJAc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Aug 2019 05:00:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:53168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbfHKJAc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Aug 2019 05:00:32 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A57FF208C2;
        Sun, 11 Aug 2019 09:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565514031;
        bh=iyH/cUx17oamFY6wZF/MwlfV/Qh3cGvuxjYSc3KZ8IE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MxOcaQRnaUV/7d90hW7VdqU6wkBO3KJDp6xgyKhZYNF/A6BQXo7IiVWCD8ZxtkwXn
         Kqtq61VrW6ktEOwmBga8gmVCmlciPL6A/gevwPM2tOwkmDmClanracIOfNmd2O8Wob
         hmoR78czcSiECmdqDBl2EXy9Lg8bT48M2XouhctE=
Date:   Sun, 11 Aug 2019 10:00:22 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Healy <cphealy@gmail.com>,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: Re: [PATCH] iio: hi8435: Drop hi8435_remove()
Message-ID: <20190811100022.4fe91756@archlinux>
In-Reply-To: <20190811054545.6922-1-andrew.smirnov@gmail.com>
References: <20190811054545.6922-1-andrew.smirnov@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 10 Aug 2019 22:45:45 -0700
Andrey Smirnov <andrew.smirnov@gmail.com> wrote:

> Convert the remainder of hi8435_probe() to use devres and get rid of
> hi8435_remove().
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-iio@vger.kernel.org
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Chris Healy <cphealy@gmail.com>
+CC as before.

I've tweaked things a little bit (see below)

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Still time for others to comment btw!

Thanks,

Jonathan

> ---
>  drivers/iio/adc/hi8435.c | 30 +++++++++++++-----------------
>  1 file changed, 13 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iio/adc/hi8435.c b/drivers/iio/adc/hi8435.c
> index c15f0e154e4d..fe1341383d30 100644
> --- a/drivers/iio/adc/hi8435.c
> +++ b/drivers/iio/adc/hi8435.c
> @@ -456,6 +456,11 @@ static irqreturn_t hi8435_trigger_handler(int irq, void *private)
>  	return IRQ_HANDLED;
>  }
>  
> +static void hi8435_triggered_event_cleanup(void *data)
> +{
> +	iio_triggered_event_cleanup(data);
> +}

Hmm. I wonder if we should do a full devm_iio_triggered_event_setup()
but given we have very few callers that can be a job for another day.

> +
>  static int hi8435_probe(struct spi_device *spi)
>  {
>  	struct iio_dev *idev;
> @@ -513,26 +518,18 @@ static int hi8435_probe(struct spi_device *spi)
>  	if (ret)
>  		return ret;
>  
> -	ret = iio_device_register(idev);
> +	ret = devm_add_action_or_reset(&spi->dev,
> +				       hi8435_triggered_event_cleanup,
> +				       idev);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_iio_device_register(&spi->dev, idev);
>  	if (ret < 0) {
>  		dev_err(&spi->dev, "unable to register device\n");
> -		goto unregister_triggered_event;
> +		return ret;

We could tidy up a little more and do
	if (ret)
		dev_err...

	return ret;

Or, given all the likely paths in iio_device_register() have 
error prints anyway, can just do
	return devm_iio_device_register();

I'll change it to this last one whilst applying.

>  	}
>  
> -	return 0;
> -
> -unregister_triggered_event:
> -	iio_triggered_event_cleanup(idev);
> -	return ret;
> -}
> -
> -static int hi8435_remove(struct spi_device *spi)
> -{
> -	struct iio_dev *idev = spi_get_drvdata(spi);
> -
> -	iio_device_unregister(idev);
> -	iio_triggered_event_cleanup(idev);
> -
>  	return 0;
>  }
>  
> @@ -554,7 +551,6 @@ static struct spi_driver hi8435_driver = {
>  		.of_match_table	= of_match_ptr(hi8435_dt_ids),
>  	},
>  	.probe		= hi8435_probe,
> -	.remove		= hi8435_remove,
>  	.id_table	= hi8435_id,
>  };
>  module_spi_driver(hi8435_driver);

