Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A72312993A
	for <lists+linux-iio@lfdr.de>; Mon, 23 Dec 2019 18:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfLWRSQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Dec 2019 12:18:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:50604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbfLWRSQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Dec 2019 12:18:16 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD94620663;
        Mon, 23 Dec 2019 17:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577121495;
        bh=jj/dGES1OOQJ0TdDm9mR6PvAKZnUuo4YdOX0tiMVEr4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rl9mVtq2w6xS+U6v0di1+Aq99935B7E2XwoXZRGiBzoj/NpkVbVOgzx/GBZHl7FU6
         S4S+vQvdON1n/oGQSyOWrAqxQ/ukY6+uaJ/16WDLiv3cR19wnOIGGkyXZ46kMH5b45
         g7AcVZ0Up5XV05BvYQpbWwoxXDYa4sGfvDflodSY=
Date:   Mon, 23 Dec 2019 17:18:11 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
Subject: Re: [PATCH 1/4] iio: accel: bma180: Add dev helper variable
Message-ID: <20191223171811.634e10b7@archlinux>
In-Reply-To: <20191211213819.14024-1-linus.walleij@linaro.org>
References: <20191211213819.14024-1-linus.walleij@linaro.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 11 Dec 2019 22:38:16 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> Having a shorthand "dev" instead of &client->dev everywhere
> makes the code easier to read (more compact).
> 
> Cc: Peter Meerwald <pmeerw@pmeerw.net>
> Cc: Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Seems sensible to me.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/bma180.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
> index 1574e4604a4f..518efbe4eaf6 100644
> --- a/drivers/iio/accel/bma180.c
> +++ b/drivers/iio/accel/bma180.c
> @@ -712,12 +712,13 @@ static const struct iio_trigger_ops bma180_trigger_ops = {
>  static int bma180_probe(struct i2c_client *client,
>  		const struct i2c_device_id *id)
>  {
> +	struct device *dev = &client->dev;
>  	struct bma180_data *data;
>  	struct iio_dev *indio_dev;
>  	enum chip_ids chip;
>  	int ret;
>  
> -	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
> @@ -725,12 +726,12 @@ static int bma180_probe(struct i2c_client *client,
>  	i2c_set_clientdata(client, indio_dev);
>  	data->client = client;
>  	if (client->dev.of_node)
> -		chip = (enum chip_ids)of_device_get_match_data(&client->dev);
> +		chip = (enum chip_ids)of_device_get_match_data(dev);
>  	else
>  		chip = id->driver_data;
>  	data->part_info = &bma180_part_info[chip];
>  
> -	ret = iio_read_mount_matrix(&client->dev, "mount-matrix",
> +	ret = iio_read_mount_matrix(dev, "mount-matrix",
>  				&data->orientation);
>  	if (ret)
>  		return ret;
> @@ -740,7 +741,7 @@ static int bma180_probe(struct i2c_client *client,
>  		goto err_chip_disable;
>  
>  	mutex_init(&data->mutex);
> -	indio_dev->dev.parent = &client->dev;
> +	indio_dev->dev.parent = dev;
>  	indio_dev->channels = data->part_info->channels;
>  	indio_dev->num_channels = data->part_info->num_channels;
>  	indio_dev->name = id->name;
> @@ -755,15 +756,15 @@ static int bma180_probe(struct i2c_client *client,
>  			goto err_chip_disable;
>  		}
>  
> -		ret = devm_request_irq(&client->dev, client->irq,
> +		ret = devm_request_irq(dev, client->irq,
>  			iio_trigger_generic_data_rdy_poll, IRQF_TRIGGER_RISING,
>  			"bma180_event", data->trig);
>  		if (ret) {
> -			dev_err(&client->dev, "unable to request IRQ\n");
> +			dev_err(dev, "unable to request IRQ\n");
>  			goto err_trigger_free;
>  		}
>  
> -		data->trig->dev.parent = &client->dev;
> +		data->trig->dev.parent = dev;
>  		data->trig->ops = &bma180_trigger_ops;
>  		iio_trigger_set_drvdata(data->trig, indio_dev);
>  		indio_dev->trig = iio_trigger_get(data->trig);
> @@ -776,13 +777,13 @@ static int bma180_probe(struct i2c_client *client,
>  	ret = iio_triggered_buffer_setup(indio_dev, NULL,
>  			bma180_trigger_handler, NULL);
>  	if (ret < 0) {
> -		dev_err(&client->dev, "unable to setup iio triggered buffer\n");
> +		dev_err(dev, "unable to setup iio triggered buffer\n");
>  		goto err_trigger_unregister;
>  	}
>  
>  	ret = iio_device_register(indio_dev);
>  	if (ret < 0) {
> -		dev_err(&client->dev, "unable to register iio device\n");
> +		dev_err(dev, "unable to register iio device\n");
>  		goto err_buffer_cleanup;
>  	}
>  

