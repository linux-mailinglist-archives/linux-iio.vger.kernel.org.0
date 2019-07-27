Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0F5377ABD
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2019 19:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387814AbfG0RUw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Jul 2019 13:20:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:35816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387665AbfG0RUv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 27 Jul 2019 13:20:51 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD1E32087C;
        Sat, 27 Jul 2019 17:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564248050;
        bh=8DARoeGTUmpxxO7pWm5eZSLoaX3TmdO2TXyRi5cuXv0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=F2SK/llYzBc2MHFYZUas+E9dVadvElt4KDVIJQ5I9BoW8o8G0YyVcFDkWBUA8nwDu
         9c1ZMkLE26VAC8Qgonqgnbp+4hEe3qZSN5z/jDwTc1pQYQazBJHEpUrsjmb8pM1Sqm
         12JDSg2xhgh4eFks1ZBr59fPxXydgQNDO2/H4hd0=
Date:   Sat, 27 Jul 2019 18:20:45 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: mxc4005: Use device-managed APIs
Message-ID: <20190727182045.283fef07@archlinux>
In-Reply-To: <20190726063616.11045-1-hslester96@gmail.com>
References: <20190726063616.11045-1-hslester96@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 26 Jul 2019 14:36:16 +0800
Chuhong Yuan <hslester96@gmail.com> wrote:

> Use device-managed APIs to simplify the code.
> The remove function is redundant now and can
> be deleted.
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
Applied, with a similar change to the other patches I modified earlier.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/mxc4005.c | 35 +++++++----------------------------
>  1 file changed, 7 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/iio/accel/mxc4005.c b/drivers/iio/accel/mxc4005.c
> index 637e6e676061..d8b999023ef2 100644
> --- a/drivers/iio/accel/mxc4005.c
> +++ b/drivers/iio/accel/mxc4005.c
> @@ -424,7 +424,7 @@ static int mxc4005_probe(struct i2c_client *client,
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->info = &mxc4005_info;
>  
> -	ret = iio_triggered_buffer_setup(indio_dev,
> +	ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev,
>  					 iio_pollfunc_store_time,
>  					 mxc4005_trigger_handler,
>  					 NULL);
> @@ -452,7 +452,7 @@ static int mxc4005_probe(struct i2c_client *client,
>  		if (ret) {
>  			dev_err(&client->dev,
>  				"failed to init threaded irq\n");
> -			goto err_buffer_cleanup;
> +			return ret;
>  		}
>  
>  		data->dready_trig->dev.parent = &client->dev;
> @@ -460,43 +460,23 @@ static int mxc4005_probe(struct i2c_client *client,
>  		iio_trigger_set_drvdata(data->dready_trig, indio_dev);
>  		indio_dev->trig = data->dready_trig;
>  		iio_trigger_get(indio_dev->trig);
> -		ret = iio_trigger_register(data->dready_trig);
> +		ret = devm_iio_trigger_register(&client->dev,
> +						data->dready_trig);
>  		if (ret) {
>  			dev_err(&client->dev,
>  				"failed to register trigger\n");
> -			goto err_trigger_unregister;
> +			return ret;
>  		}
>  	}
>  
> -	ret = iio_device_register(indio_dev);
> +	ret = devm_iio_device_register(&client->dev, indio_dev);
>  	if (ret < 0) {
>  		dev_err(&client->dev,
>  			"unable to register iio device %d\n", ret);
> -		goto err_buffer_cleanup;
> +		return ret;
I dropped the print out and tidied this up as
return devm_iio_device_register();

>  	}
>  
>  	return 0;
> -
> -err_trigger_unregister:
> -	iio_trigger_unregister(data->dready_trig);
> -err_buffer_cleanup:
> -	iio_triggered_buffer_cleanup(indio_dev);
> -
> -	return ret;
> -}
> -
> -static int mxc4005_remove(struct i2c_client *client)
> -{
> -	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> -	struct mxc4005_data *data = iio_priv(indio_dev);
> -
> -	iio_device_unregister(indio_dev);
> -
> -	iio_triggered_buffer_cleanup(indio_dev);
> -	if (data->dready_trig)
> -		iio_trigger_unregister(data->dready_trig);
> -
> -	return 0;
>  }
>  
>  static const struct acpi_device_id mxc4005_acpi_match[] = {
> @@ -517,7 +497,6 @@ static struct i2c_driver mxc4005_driver = {
>  		.acpi_match_table = ACPI_PTR(mxc4005_acpi_match),
>  	},
>  	.probe		= mxc4005_probe,
> -	.remove		= mxc4005_remove,
>  	.id_table	= mxc4005_id,
>  };
>  

