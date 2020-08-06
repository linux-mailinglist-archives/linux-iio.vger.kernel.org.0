Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3015423E0D6
	for <lists+linux-iio@lfdr.de>; Thu,  6 Aug 2020 20:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729079AbgHFSir (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Aug 2020 14:38:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:60656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726899AbgHFSin (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 6 Aug 2020 14:38:43 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 878AF221E3;
        Thu,  6 Aug 2020 18:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596739123;
        bh=2kQR9I4zXt/WNULI01GY/ypUOHIRns3YKmoIz1UaEr4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fRTYpEGCjZWeocG4aY97dzfbZvAO437sqaVl2VpUuxiYy7sElhR1g3gUyoezzPBMS
         9hojTb0yDIbtJjxuXpZpdoi+mIF/q0DYfIMi0exfQeg05CMS6LCSTCIOG/8qsYEX3X
         ydTPApw7fIA7o+rGUqq8tYAhmdGBDpfk9d4phDC4=
Date:   Thu, 6 Aug 2020 19:38:38 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Daniel Campello <campello@chromium.org>
Cc:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 11/15] iio: sx9310: Use variable to hold &client->dev
Message-ID: <20200806193838.092d1567@archlinux>
In-Reply-To: <20200803175559.v5.11.If9d9c0fe089e43ea2dbc7900b6d61cd05c66f1f7@changeid>
References: <20200803235815.778997-1-campello@chromium.org>
        <20200803175559.v5.11.If9d9c0fe089e43ea2dbc7900b6d61cd05c66f1f7@changeid>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  3 Aug 2020 17:58:11 -0600
Daniel Campello <campello@chromium.org> wrote:

> Improves readability by storing &client->dev in a local variable.
> 
> Signed-off-by: Daniel Campello <campello@chromium.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
This one needed some tweaking to apply as the parent is now
set by the core code.

Applied (and the ones before I didn't metion) to the togreg branch
of iio.git and pushed out as testing,

Thanks,

Jonathan

> ---
> 
> Changes in v5: None
> Changes in v4: None
> Changes in v3: None
> Changes in v2:
>  - Added '\n' to dev_err()
> 
>  drivers/iio/proximity/sx9310.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
> index adb707e2d79612..589052d2d1146e 100644
> --- a/drivers/iio/proximity/sx9310.c
> +++ b/drivers/iio/proximity/sx9310.c
> @@ -887,11 +887,12 @@ static int sx9310_set_indio_dev_name(struct device *dev,
>  static int sx9310_probe(struct i2c_client *client)
>  {
>  	int ret;
> +	struct device *dev = &client->dev;
>  	struct iio_dev *indio_dev;
>  	struct sx9310_data *data;
>  
> -	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> -	if (indio_dev == NULL)
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
>  		return -ENOMEM;
>  
>  	data = iio_priv(indio_dev);
> @@ -905,17 +906,16 @@ static int sx9310_probe(struct i2c_client *client)
>  
>  	ret = regmap_read(data->regmap, SX9310_REG_WHOAMI, &data->whoami);
>  	if (ret) {
> -		dev_err(&client->dev, "error in reading WHOAMI register: %d",
> -			ret);
> +		dev_err(dev, "error in reading WHOAMI register: %d\n", ret);
>  		return ret;
>  	}
>  
> -	ret = sx9310_set_indio_dev_name(&client->dev, indio_dev, data->whoami);
> +	ret = sx9310_set_indio_dev_name(dev, indio_dev, data->whoami);
>  	if (ret)
>  		return ret;
>  
> -	ACPI_COMPANION_SET(&indio_dev->dev, ACPI_COMPANION(&client->dev));
> -	indio_dev->dev.parent = &client->dev;
> +	ACPI_COMPANION_SET(&indio_dev->dev, ACPI_COMPANION(dev));
> +	indio_dev->dev.parent = dev;
>  	indio_dev->channels = sx9310_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(sx9310_channels);
>  	indio_dev->info = &sx9310_info;
> @@ -927,7 +927,7 @@ static int sx9310_probe(struct i2c_client *client)
>  		return ret;
>  
>  	if (client->irq) {
> -		ret = devm_request_threaded_irq(&client->dev, client->irq,
> +		ret = devm_request_threaded_irq(dev, client->irq,
>  						sx9310_irq_handler,
>  						sx9310_irq_thread_handler,
>  						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> @@ -935,29 +935,29 @@ static int sx9310_probe(struct i2c_client *client)
>  		if (ret)
>  			return ret;
>  
> -		data->trig =
> -			devm_iio_trigger_alloc(&client->dev, "%s-dev%d",
> -					       indio_dev->name, indio_dev->id);
> +		data->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
> +						    indio_dev->name,
> +						    indio_dev->id);
>  		if (!data->trig)
>  			return -ENOMEM;
>  
> -		data->trig->dev.parent = &client->dev;
> +		data->trig->dev.parent = dev;
>  		data->trig->ops = &sx9310_trigger_ops;
>  		iio_trigger_set_drvdata(data->trig, indio_dev);
>  
> -		ret = devm_iio_trigger_register(&client->dev, data->trig);
> +		ret = devm_iio_trigger_register(dev, data->trig);
>  		if (ret)
>  			return ret;
>  	}
>  
> -	ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev,
> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
>  					      iio_pollfunc_store_time,
>  					      sx9310_trigger_handler,
>  					      &sx9310_buffer_setup_ops);
>  	if (ret)
>  		return ret;
>  
> -	return devm_iio_device_register(&client->dev, indio_dev);
> +	return devm_iio_device_register(dev, indio_dev);
>  }
>  
>  static int __maybe_unused sx9310_suspend(struct device *dev)

