Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45D3677ABA
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2019 19:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387823AbfG0RRt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Jul 2019 13:17:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:34808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387814AbfG0RRt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 27 Jul 2019 13:17:49 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2684B2087C;
        Sat, 27 Jul 2019 17:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564247867;
        bh=CJ3l7czGcf01NJN/jvzDvAh2w37DWgQGgHLk7dxWoz4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nnfBPtXhvRgfcIO4xwsW1Hc85LSNV57/RIkGGuo9W7v63DMnsY4GiL8B1ccWzF1Jq
         xS+VIcxz8H/ueYJGTcqu4nwZnBO7uYYv/cS3lDp7YNjGX+1U8TbbHma+RMnrTZMH3E
         2/XOxJfz+bTlCc+ASAlmwV2tp+fOsVIbyuCZkmsw=
Date:   Sat, 27 Jul 2019 18:17:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Matt Ranostay <matt.ranostay@konsulko.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: humidity: Use device-managed APIs
Message-ID: <20190727181743.6701f1dc@archlinux>
In-Reply-To: <20190726080255.13226-1-hslester96@gmail.com>
References: <20190726080255.13226-1-hslester96@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 26 Jul 2019 16:02:55 +0800
Chuhong Yuan <hslester96@gmail.com> wrote:

> Use device-managed APIs to simplify the code.
> The remove functions are redundant now and can
> be deleted.
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
This one I've tidied up and applied, but see note below.

Also, two patches would have been nicer as different potential
reviewers. 
+CC Matt as I think I have a current address for him.

These will be in a rebaseable tree for a week or so, hence
plenty of time for more comments.

Thanks for tidying these up.

Jonathan

> ---
>  drivers/iio/humidity/am2315.c  | 21 ++++-----------------
>  drivers/iio/humidity/hdc100x.c | 18 ++++--------------
>  2 files changed, 8 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/iio/humidity/am2315.c b/drivers/iio/humidity/am2315.c
> index f18da7859229..038638e92f4a 100644
> --- a/drivers/iio/humidity/am2315.c
> +++ b/drivers/iio/humidity/am2315.c
> @@ -240,32 +240,20 @@ static int am2315_probe(struct i2c_client *client,
>  	indio_dev->channels = am2315_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(am2315_channels);
>  
> -	ret = iio_triggered_buffer_setup(indio_dev, iio_pollfunc_store_time,
> +	ret = devm_iio_triggered_buffer_setup(&client->dev,
> +					indio_dev, iio_pollfunc_store_time,
>  					 am2315_trigger_handler, NULL);
>  	if (ret < 0) {
>  		dev_err(&client->dev, "iio triggered buffer setup failed\n");
>  		return ret;
>  	}
>  
> -	ret = iio_device_register(indio_dev);
> +	ret = devm_iio_device_register(&client->dev, indio_dev);
>  	if (ret < 0)
> -		goto err_buffer_cleanup;
> +		return ret;
>  
>  	return 0;
>  
> -err_buffer_cleanup:
> -	iio_triggered_buffer_cleanup(indio_dev);
> -	return ret;
> -}
> -
> -static int am2315_remove(struct i2c_client *client)
> -{
> -	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> -
> -	iio_device_unregister(indio_dev);
> -	iio_triggered_buffer_cleanup(indio_dev);
> -
> -	return 0;
>  }
>  
>  static const struct i2c_device_id am2315_i2c_id[] = {
> @@ -287,7 +275,6 @@ static struct i2c_driver am2315_driver = {
>  		.acpi_match_table = ACPI_PTR(am2315_acpi_id),
>  	},
>  	.probe =            am2315_probe,
> -	.remove =	    am2315_remove,
>  	.id_table =         am2315_i2c_id,
>  };
>  
> diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
> index 066e05f92081..5186fd9bfdc5 100644
> --- a/drivers/iio/humidity/hdc100x.c
> +++ b/drivers/iio/humidity/hdc100x.c
> @@ -385,26 +385,17 @@ static int hdc100x_probe(struct i2c_client *client,
>  	hdc100x_set_it_time(data, 1, hdc100x_int_time[1][0]);
>  	hdc100x_update_config(data, HDC100X_REG_CONFIG_ACQ_MODE, 0);
>  
> -	ret = iio_triggered_buffer_setup(indio_dev, NULL,
> +	ret = devm_iio_triggered_buffer_setup(&client->dev,
> +					 indio_dev, NULL,
>  					 hdc100x_trigger_handler,
>  					 &hdc_buffer_setup_ops);
>  	if (ret < 0) {
>  		dev_err(&client->dev, "iio triggered buffer setup failed\n");
>  		return ret;
>  	}
> -	ret = iio_device_register(indio_dev);
> +	ret = devm_iio_device_register(&client->dev, indio_dev);
>  	if (ret < 0)
> -		iio_triggered_buffer_cleanup(indio_dev);
> -
> -	return ret;
> -}
> -
> -static int hdc100x_remove(struct i2c_client *client)
> -{
> -	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> -
> -	iio_device_unregister(indio_dev);
> -	iio_triggered_buffer_cleanup(indio_dev);
> +		return ret;
return devm_iio_device_register(..);

Note that this has come up several time.  If I had been you I would
have sent these patches out slightly slower so that any feedback on
the first 1 or 2 could be applied to the others and saved on rerolling
the lot.

It's easy enough for me to reply the same thing multiple times to short
patches, but I'd not have bothered if it had been more substantial
changes (and would have ranted rather more about this ;)

Sadly, even the 'obvious' patches aren't always as simple as they seem.
>  
>  	return 0;
>  }
> @@ -436,7 +427,6 @@ static struct i2c_driver hdc100x_driver = {
>  		.of_match_table = of_match_ptr(hdc100x_dt_ids),
>  	},
>  	.probe = hdc100x_probe,
> -	.remove = hdc100x_remove,
>  	.id_table = hdc100x_id,
>  };
>  module_i2c_driver(hdc100x_driver);

