Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44040156586
	for <lists+linux-iio@lfdr.de>; Sat,  8 Feb 2020 17:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbgBHQjr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Feb 2020 11:39:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:42870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727341AbgBHQjr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 8 Feb 2020 11:39:47 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 388FA217BA;
        Sat,  8 Feb 2020 16:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581179986;
        bh=tqrUZ/jGcb2dyM3IngNypNvzJPOW//Pyd4e3xKhd/Zs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QBo7gkDQYdwgJwEIruJd5ztOctDoW/EmZ8hlVhIRfE4nO6D17Gbqv1+BOx0Rztg4/
         bPACMTJT7j/t0NApDZvhpnLOzQt7MhwJ5ZAeY6oQcPgomL870j1sTWT/Qehfeqe+1Z
         VxOhIUamV9eqjkntDTU5Le43/UGF/m6f6lqDhXB8=
Date:   Sat, 8 Feb 2020 16:39:43 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 1/3] iio: chemical: atlas-sensor: allow probe without
 interrupt line
Message-ID: <20200208163943.098ba614@archlinux>
In-Reply-To: <20200206061332.20427-2-matt.ranostay@konsulko.com>
References: <20200206061332.20427-1-matt.ranostay@konsulko.com>
        <20200206061332.20427-2-matt.ranostay@konsulko.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed,  5 Feb 2020 22:13:30 -0800
Matt Ranostay <matt.ranostay@konsulko.com> wrote:

> Sensors don't actually need a interrupt line to give valid readings,
> and can triggered with CONFIG_IIO_HRTIMER_TRIGGER as well. Remove
> the required check for interrupt, and continue along in the probe
> function.

Basic aim is good, but if you don't have an interrupt doesn't make
sense to register the trigger either.

The interrupt enable / disable is also tied up with the buffer whereas
it should probably be done via the trigger enable callback or am I
missing something?

Jonathan

> 
> Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
> ---
>  drivers/iio/chemical/atlas-sensor.c | 27 ++++++++++++---------------
>  1 file changed, 12 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical/atlas-sensor.c
> index 2f0a6fed2589..2e34c82cb65d 100644
> --- a/drivers/iio/chemical/atlas-sensor.c
> +++ b/drivers/iio/chemical/atlas-sensor.c
> @@ -572,11 +572,6 @@ static int atlas_probe(struct i2c_client *client,
>  	if (ret)
>  		return ret;
>  
> -	if (client->irq <= 0) {
> -		dev_err(&client->dev, "no valid irq defined\n");
> -		return -EINVAL;
> -	}
> -
>  	ret = chip->calibration(data);
>  	if (ret)
>  		return ret;
> @@ -596,16 +591,18 @@ static int atlas_probe(struct i2c_client *client,
>  
>  	init_irq_work(&data->work, atlas_work_handler);
>  
> -	/* interrupt pin toggles on new conversion */
> -	ret = devm_request_threaded_irq(&client->dev, client->irq,
> -					NULL, atlas_interrupt_handler,
> -					IRQF_TRIGGER_RISING |
> -					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> -					"atlas_irq",
> -					indio_dev);
> -	if (ret) {
> -		dev_err(&client->dev, "request irq (%d) failed\n", client->irq);
> -		goto unregister_buffer;
> +	if (client->irq <= 0) {
> +		/* interrupt pin toggles on new conversion */
> +		ret = devm_request_threaded_irq(&client->dev, client->irq,
> +				NULL, atlas_interrupt_handler,
> +				IRQF_TRIGGER_RISING |
> +				IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +				"atlas_irq",
> +				indio_dev);
> +
> +		if (ret)
> +			dev_warn(&client->dev,
> +				"request irq (%d) failed\n", client->irq);
>  	}
>  
>  	ret = atlas_set_powermode(data, 1);

