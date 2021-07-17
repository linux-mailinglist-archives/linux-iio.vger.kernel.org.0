Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC463CC53B
	for <lists+linux-iio@lfdr.de>; Sat, 17 Jul 2021 20:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234042AbhGQSUF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 17 Jul 2021 14:20:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:35628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233441AbhGQSUF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 17 Jul 2021 14:20:05 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60EE761153;
        Sat, 17 Jul 2021 18:17:07 +0000 (UTC)
Date:   Sat, 17 Jul 2021 19:19:30 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmeerw@pmeerw.net
Subject: Re: [PATCH 2/2] iio: temperature: tmp006: make sure the chip is
 powered up in probe
Message-ID: <20210717191930.256a2cca@jic23-huawei>
In-Reply-To: <20210624081924.15897-2-aardelean@deviqon.com>
References: <20210624081924.15897-1-aardelean@deviqon.com>
        <20210624081924.15897-2-aardelean@deviqon.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 24 Jun 2021 11:19:24 +0300
Alexandru Ardelean <aardelean@deviqon.com> wrote:

> When the device is probed, there's no guarantee that the device is not in
> power-down mode. This can happen if the driver is unregistered and
> re-probed.
> 
> To make sure this doesn't happen, the value of the TMP006_CONFIG register
> (which is read in the probe function and stored in the device's private
> data) is being checked to see if the MOD bits have the correct value.
> 
> This is a fix for a somewhat-rare corner case. As it stands, this doesn't
> look like a high priority to go into the Fixes route.
> 
> Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
This one 'looks' right and as it's been on the list a while I'll apply it.
Would be great if anyone can test it though!

Series applied.

Thanks,

Jonathan

> ---
>  drivers/iio/temperature/tmp006.c | 33 +++++++++++++++++++++-----------
>  1 file changed, 22 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/temperature/tmp006.c b/drivers/iio/temperature/tmp006.c
> index db1ac6029c27..e4943a0bc9aa 100644
> --- a/drivers/iio/temperature/tmp006.c
> +++ b/drivers/iio/temperature/tmp006.c
> @@ -193,15 +193,23 @@ static bool tmp006_check_identification(struct i2c_client *client)
>  	return mid == TMP006_MANUFACTURER_MAGIC && did == TMP006_DEVICE_MAGIC;
>  }
>  
> -static int tmp006_powerdown(struct tmp006_data *data)
> +static int tmp006_power(struct device *dev, bool up)
>  {
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +	struct tmp006_data *data = iio_priv(indio_dev);
> +
> +	if (up)
> +		data->config |= TMP006_CONFIG_MOD_MASK;
> +	else
> +		data->config &= ~TMP006_CONFIG_MOD_MASK;
> +
>  	return i2c_smbus_write_word_swapped(data->client, TMP006_CONFIG,
> -		data->config & ~TMP006_CONFIG_MOD_MASK);
> +		data->config);
>  }
>  
> -static void tmp006_powerdown_cleanup(void *data)
> +static void tmp006_powerdown_cleanup(void *dev)
>  {
> -	tmp006_powerdown(data);
> +	tmp006_power(dev, false);
>  }
>  
>  static int tmp006_probe(struct i2c_client *client,
> @@ -239,7 +247,14 @@ static int tmp006_probe(struct i2c_client *client,
>  		return ret;
>  	data->config = ret;
>  
> -	ret = devm_add_action(&client->dev, tmp006_powerdown_cleanup, data);
> +	if ((ret & TMP006_CONFIG_MOD_MASK) != TMP006_CONFIG_MOD_MASK) {
> +		ret = tmp006_power(&client->dev, true);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	ret = devm_add_action_or_reset(&client->dev, tmp006_powerdown_cleanup,
> +				       &client->dev);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -249,16 +264,12 @@ static int tmp006_probe(struct i2c_client *client,
>  #ifdef CONFIG_PM_SLEEP
>  static int tmp006_suspend(struct device *dev)
>  {
> -	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> -	return tmp006_powerdown(iio_priv(indio_dev));
> +	return tmp006_power(dev, false);
>  }
>  
>  static int tmp006_resume(struct device *dev)
>  {
> -	struct tmp006_data *data = iio_priv(i2c_get_clientdata(
> -		to_i2c_client(dev)));
> -	return i2c_smbus_write_word_swapped(data->client, TMP006_CONFIG,
> -		data->config | TMP006_CONFIG_MOD_MASK);
> +	return tmp006_power(dev, true);
>  }
>  #endif
>  

