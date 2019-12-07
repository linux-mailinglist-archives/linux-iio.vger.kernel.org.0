Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38381115BE5
	for <lists+linux-iio@lfdr.de>; Sat,  7 Dec 2019 11:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbfLGKwA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Dec 2019 05:52:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:38626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbfLGKwA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 7 Dec 2019 05:52:00 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EE94217BA;
        Sat,  7 Dec 2019 10:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575715919;
        bh=braAqbniemF86Kz1AA1SskekDQQQIlg5TlLCStOMguM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wuklIbA2zKgC5C7XBvBVR+4SsBPlT3cj1N6eHj/2D5UYdSzj+1wMk6tS2gYidQyWD
         BBOuGxf0+g/pZppTuEK0mi/XIrohI+9AumGryl3dHJYzO0zKiQbNwu2rQGwu5xcdCd
         WgcUZqXzKo6uiIoenoizoHJUY5RNcYsZ5N5DdQQo=
Date:   Sat, 7 Dec 2019 10:51:55 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v1 2/2] iio: adc: ti-ads1015: Make use of device
 property API
Message-ID: <20191207105155.7a5f80f5@archlinux>
In-Reply-To: <20191203111753.55146-2-andriy.shevchenko@linux.intel.com>
References: <20191203111753.55146-1-andriy.shevchenko@linux.intel.com>
        <20191203111753.55146-2-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue,  3 Dec 2019 13:17:53 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Make use of device property API in this driver so that both OF based
> system and ACPI based system can use this driver.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Really minor comment...

Using the construction around i = -1, then inc to 0 on first channel
is a bit of a convoluted way of setting what is at heart a boolean flag
to say 1 or more channels had description.

Otherwise seems fine to me and that's minor enough lets just ignore it.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan


> ---
>  drivers/iio/adc/ti-ads1015.c | 59 +++++++++++++++++-------------------
>  1 file changed, 27 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> index 3b123b4f0b99..a128236ec3cc 100644
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
> +	struct fwnode_handle *fwnode = dev_fwnode(dev), *child;
> +	int i = -1;
>  
> -	if (!client->dev.of_node ||
> -	    !of_get_next_child(client->dev.of_node, NULL))
> -		return -EINVAL;
> -
> -	for_each_child_of_node(client->dev.of_node, node) {
> +	fwnode_for_each_child_node(fwnode, child) {
>  		u32 pval;
>  		unsigned int channel;
>  		unsigned int pga = ADS1015_DEFAULT_PGA;
>  		unsigned int data_rate = ADS1015_DEFAULT_DATA_RATE;
>  
> -		if (of_property_read_u32(node, "reg", &pval)) {
> -			dev_err(&client->dev, "invalid reg on %pOF\n",
> -				node);
> +		if (fwnode_property_read_u32(child, "reg", &pval)) {
> +			dev_err(dev, "invalid reg on %pfw\n", child);
>  			continue;
>  		}
>  
>  		channel = pval;
>  		if (channel >= ADS1015_CHANNELS) {
> -			dev_err(&client->dev,
> -				"invalid channel index %d on %pOF\n",
> -				channel, node);
> +			dev_err(dev, "invalid channel index %d on %pfw\n",
> +				channel, child);
>  			continue;
>  		}
>  
> -		if (!of_property_read_u32(node, "ti,gain", &pval)) {
> +		if (!fwnode_property_read_u32(child, "ti,gain", &pval)) {
>  			pga = pval;
>  			if (pga > 6) {
> -				dev_err(&client->dev, "invalid gain on %pOF\n",
> -					node);
> -				of_node_put(node);
> +				dev_err(dev, "invalid gain on %pfw\n", child);
> +				fwnode_handle_put(child);
>  				return -EINVAL;
>  			}
>  		}
>  
> -		if (!of_property_read_u32(node, "ti,datarate", &pval)) {
> +		if (!fwnode_property_read_u32(child, "ti,datarate", &pval)) {
>  			data_rate = pval;
>  			if (data_rate > 7) {
> -				dev_err(&client->dev,
> -					"invalid data_rate on %pOF\n",
> -					node);
> -				of_node_put(node);
> +				dev_err(dev, "invalid data_rate on %pfw\n", child);
> +				fwnode_handle_put(child);
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

