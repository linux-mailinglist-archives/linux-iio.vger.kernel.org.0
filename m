Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13E9A115BF4
	for <lists+linux-iio@lfdr.de>; Sat,  7 Dec 2019 12:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbfLGLJo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Dec 2019 06:09:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:44282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbfLGLJo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 7 Dec 2019 06:09:44 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF00E24673;
        Sat,  7 Dec 2019 11:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575716982;
        bh=GpLI3dhwJXFUbKDyW39bXo8iROVT6YGtHtvoF1FXUGE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rTWdFPphDnYHCeGqAoZeBakiloIa7/nO3/F8pqYSBpbSuN976yEQJnqmZENI24l9o
         UaynhB+5GSRN7wpWP8KB+f0gVU5IwaNr/KvWx0SSy+wTmJDM6GjqynZSSAIxkBWxiD
         JVkpRDk6lyoOBFCiDFO5lAGP5pFAaxZlN3xLt+qo=
Date:   Sat, 7 Dec 2019 11:09:37 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v3 2/2] iio: adc: ti-ads1015: Make use of device
 property API
Message-ID: <20191207110937.6a0c1229@archlinux>
In-Reply-To: <20191205174637.47610-2-andriy.shevchenko@linux.intel.com>
References: <20191205174637.47610-1-andriy.shevchenko@linux.intel.com>
        <20191205174637.47610-2-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  5 Dec 2019 19:46:37 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Make use of device property API in this driver so that both OF based
> system and ACPI based system can use this driver.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied.

Thanks,

Jonathan

> ---
> v2:
> - use device_for_each_child_node()
> - leave 'node' variable name (reduce churn)
>  drivers/iio/adc/ti-ads1015.c | 57 ++++++++++++++++--------------------
>  1 file changed, 26 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> index 3b123b4f0b99..5ea4f45d6bad 100644
> --- a/drivers/iio/adc/ti-ads1015.c
> +++ b/drivers/iio/adc/ti-ads1015.c
> @@ -12,10 +12,10 @@
>   */
>  
>  #include <linux/module.h>
> -#include <linux/of_device.h>
>  #include <linux/init.h>
>  #include <linux/irq.h>
>  #include <linux/i2c.h>
> +#include <linux/property.h>
>  #include <linux/regmap.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/mutex.h>
> @@ -77,6 +77,7 @@
>  #define ADS1015_DEFAULT_CHAN		0
>  
>  enum chip_ids {
> +	ADSXXXX = 0,
>  	ADS1015,
>  	ADS1115,
>  };
> @@ -843,65 +844,58 @@ static const struct iio_info ads1115_info = {
>  	.attrs          = &ads1115_attribute_group,
>  };
>  
> -#ifdef CONFIG_OF
> -static int ads1015_get_channels_config_of(struct i2c_client *client)
> +static int ads1015_client_get_channels_config(struct i2c_client *client)
>  {
>  	struct iio_dev *indio_dev = i2c_get_clientdata(client);
>  	struct ads1015_data *data = iio_priv(indio_dev);
> -	struct device_node *node;
> +	struct device *dev = &client->dev;
> +	struct fwnode_handle *node;
> +	int i = -1;
>  
> -	if (!client->dev.of_node ||
> -	    !of_get_next_child(client->dev.of_node, NULL))
> -		return -EINVAL;
> -
> -	for_each_child_of_node(client->dev.of_node, node) {
> +	device_for_each_child_node(dev, node) {
>  		u32 pval;
>  		unsigned int channel;
>  		unsigned int pga = ADS1015_DEFAULT_PGA;
>  		unsigned int data_rate = ADS1015_DEFAULT_DATA_RATE;
>  
> -		if (of_property_read_u32(node, "reg", &pval)) {
> -			dev_err(&client->dev, "invalid reg on %pOF\n",
> -				node);
> +		if (fwnode_property_read_u32(node, "reg", &pval)) {
> +			dev_err(dev, "invalid reg on %pfw\n", node);
>  			continue;
>  		}
>  
>  		channel = pval;
>  		if (channel >= ADS1015_CHANNELS) {
> -			dev_err(&client->dev,
> -				"invalid channel index %d on %pOF\n",
> +			dev_err(dev, "invalid channel index %d on %pfw\n",
>  				channel, node);
>  			continue;
>  		}
>  
> -		if (!of_property_read_u32(node, "ti,gain", &pval)) {
> +		if (!fwnode_property_read_u32(node, "ti,gain", &pval)) {
>  			pga = pval;
>  			if (pga > 6) {
> -				dev_err(&client->dev, "invalid gain on %pOF\n",
> -					node);
> -				of_node_put(node);
> +				dev_err(dev, "invalid gain on %pfw\n", node);
> +				fwnode_handle_put(node);
>  				return -EINVAL;
>  			}
>  		}
>  
> -		if (!of_property_read_u32(node, "ti,datarate", &pval)) {
> +		if (!fwnode_property_read_u32(node, "ti,datarate", &pval)) {
>  			data_rate = pval;
>  			if (data_rate > 7) {
> -				dev_err(&client->dev,
> -					"invalid data_rate on %pOF\n",
> -					node);
> -				of_node_put(node);
> +				dev_err(dev, "invalid data_rate on %pfw\n", node);
> +				fwnode_handle_put(node);
>  				return -EINVAL;
>  			}
>  		}
>  
>  		data->channel_data[channel].pga = pga;
>  		data->channel_data[channel].data_rate = data_rate;
> +
> +		i++;
>  	}
>  
> -	return 0;
> +	return i < 0 ? -EINVAL : 0;
>  }
> -#endif
>  
>  static void ads1015_get_channels_config(struct i2c_client *client)
>  {
> @@ -910,10 +904,9 @@ static void ads1015_get_channels_config(struct i2c_client *client)
>  	struct iio_dev *indio_dev = i2c_get_clientdata(client);
>  	struct ads1015_data *data = iio_priv(indio_dev);
>  
> -#ifdef CONFIG_OF
> -	if (!ads1015_get_channels_config_of(client))
> +	if (!ads1015_client_get_channels_config(client))
>  		return;
> -#endif
> +
>  	/* fallback on default configuration */
>  	for (k = 0; k < ADS1015_CHANNELS; ++k) {
>  		data->channel_data[k].pga = ADS1015_DEFAULT_PGA;
> @@ -951,9 +944,8 @@ static int ads1015_probe(struct i2c_client *client,
>  	indio_dev->name = ADS1015_DRV_NAME;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
> -	if (client->dev.of_node)
> -		chip = (enum chip_ids)of_device_get_match_data(&client->dev);
> -	else
> +	chip = (enum chip_ids)device_get_match_data(&client->dev);
> +	if (chip == ADSXXXX)
>  		chip = id->driver_data;
>  	switch (chip) {
>  	case ADS1015:
> @@ -968,6 +960,9 @@ static int ads1015_probe(struct i2c_client *client,
>  		indio_dev->info = &ads1115_info;
>  		data->data_rate = (unsigned int *) &ads1115_data_rate;
>  		break;
> +	default:
> +		dev_err(&client->dev, "Unknown chip %d\n", chip);
> +		return -EINVAL;
>  	}
>  
>  	data->event_channel = ADS1015_CHANNELS;

