Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAC5641081D
	for <lists+linux-iio@lfdr.de>; Sat, 18 Sep 2021 20:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbhIRS3m (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Sep 2021 14:29:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:40082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231128AbhIRS3m (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Sep 2021 14:29:42 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8FD06113A;
        Sat, 18 Sep 2021 18:28:16 +0000 (UTC)
Date:   Sat, 18 Sep 2021 19:31:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Florian Boor <florian.boor@kernelconcepts.de>
Cc:     linux-iio@vger.kernel.org, Jonathan.Cameron@huawei.com,
        Michael.Hennerich@analog.com
Subject: Re: [PATCH 1/2] iio: adc: ad799x: Implement selecting external
 reference voltage input on AD7991, AD7995 and AD7999.
Message-ID: <20210918193155.33bafa7c@jic23-huawei>
In-Reply-To: <20210914145142.138324-1-florian.boor@kernelconcepts.de>
References: <20210914145142.138324-1-florian.boor@kernelconcepts.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 14 Sep 2021 16:51:41 +0200
Florian Boor <florian.boor@kernelconcepts.de> wrote:

> Make use of the AD7991_REF_SEL bit and support using the external
> reference voltage if 'vref-supply' is present. Use VCC voltage supply
> as reference if no extra reference is supplied.
> 
> Signed-off-by: Florian Boor <florian.boor@kernelconcepts.de>
Hi Florian,

Looks fairly good, but you need to be careful about what error return
you get.  It may not indicate the case you are thinking of (no regulator
provided) and for at least some other values you want to fail the probe.

Thanks,

Jonathan

> ---
> Changes in v3:
> - Do not create dummy reference regulator, check for vref presence where needed.
> - Use VCC as reference if no extra reference voltage is provided
> - Add interrupt information to documentation
> 
> 
> Changes in v2:
> - Check if a provided external vref regulator is provided.
> - Drop unused setting
> - Add ad79xx documentation (second patch)
> 
>  drivers/iio/adc/ad799x.c | 60 ++++++++++++++++++++++++++++------------
>  1 file changed, 43 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
> index 18bf8386d50a..af72fd980030 100644
> --- a/drivers/iio/adc/ad799x.c
> +++ b/drivers/iio/adc/ad799x.c
> @@ -299,7 +299,11 @@ static int ad799x_read_raw(struct iio_dev *indio_dev,
>  			GENMASK(chan->scan_type.realbits - 1, 0);
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
> -		ret = regulator_get_voltage(st->vref);
> +		if (st->vref)
> +			ret = regulator_get_voltage(st->vref);
> +		else
> +			ret = regulator_get_voltage(st->reg);
> +		
>  		if (ret < 0)
>  			return ret;
>  		*val = ret / 1000;
> @@ -770,6 +774,7 @@ static int ad799x_probe(struct i2c_client *client,
>  				   const struct i2c_device_id *id)
>  {
>  	int ret;
> +	int extra_config = 0;
>  	struct ad799x_state *st;
>  	struct iio_dev *indio_dev;
>  	const struct ad799x_chip_info *chip_info =
> @@ -797,14 +802,28 @@ static int ad799x_probe(struct i2c_client *client,
>  	ret = regulator_enable(st->reg);
>  	if (ret)
>  		return ret;
> -	st->vref = devm_regulator_get(&client->dev, "vref");
> +		
> +	/* check if an external reference is supplied */
> +	st->vref = devm_regulator_get_optional(&client->dev, "vref");
> +
>  	if (IS_ERR(st->vref)) {

Ah. We need to be careful here as not all errors indicate no regulator is
provided.  IIRC you need to check for -ENODEV (check that)

If we got a deferred probe return we should error out here as the driver
will re probe later after the regulator driver is ready.

> -		ret = PTR_ERR(st->vref);
> -		goto error_disable_reg;
> +		st->vref = NULL;
> +		dev_info(&client->dev, "Using VCC reference voltage\n");
> +	} else {
> +		/* Use external reference voltage if supported by hardware.

IIO preferred comment syntax is

		/*
		 * Use....
		 * This...
		 */

> +		 * This is optional if voltage / regulator present, use VCC otherwise.
> +		 */
> +		if ((st->id == ad7991) || (st->id == ad7995) || (st->id == ad7999)) {
> +			dev_info(&client->dev, "Using external reference voltage\n");
> +			extra_config |= AD7991_REF_SEL;
> +			ret = regulator_enable(st->vref);
> +			if (ret)
> +				goto error_disable_reg;
> +		} else {
> +			st->vref = NULL;
> +			dev_warn(&client->dev, "Supplied reference not supported\n");
> +		}
>  	}
> -	ret = regulator_enable(st->vref);
> -	if (ret)
> -		goto error_disable_reg;
>  
>  	st->client = client;
>  
> @@ -815,7 +834,7 @@ static int ad799x_probe(struct i2c_client *client,
>  	indio_dev->channels = st->chip_config->channel;
>  	indio_dev->num_channels = chip_info->num_channels;
>  
> -	ret = ad799x_update_config(st, st->chip_config->default_config);
> +	ret = ad799x_update_config(st, st->chip_config->default_config | extra_config);
>  	if (ret)
>  		goto error_disable_vref;
>  
> @@ -845,7 +864,8 @@ static int ad799x_probe(struct i2c_client *client,
>  error_cleanup_ring:
>  	iio_triggered_buffer_cleanup(indio_dev);
>  error_disable_vref:
> -	regulator_disable(st->vref);
> +	if (st->vref) 
> +		regulator_disable(st->vref);
>  error_disable_reg:
>  	regulator_disable(st->reg);
>  
> @@ -860,7 +880,8 @@ static int ad799x_remove(struct i2c_client *client)
>  	iio_device_unregister(indio_dev);
>  
>  	iio_triggered_buffer_cleanup(indio_dev);
> -	regulator_disable(st->vref);
> +	if (st->vref) 
> +		regulator_disable(st->vref);
>  	regulator_disable(st->reg);
>  	kfree(st->rx_buf);
>  
> @@ -872,7 +893,8 @@ static int __maybe_unused ad799x_suspend(struct device *dev)
>  	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
>  	struct ad799x_state *st = iio_priv(indio_dev);
>  
> -	regulator_disable(st->vref);
> +	if (st->vref) 
> +		regulator_disable(st->vref);
>  	regulator_disable(st->reg);
>  
>  	return 0;
> @@ -889,17 +911,21 @@ static int __maybe_unused ad799x_resume(struct device *dev)
>  		dev_err(dev, "Unable to enable vcc regulator\n");
>  		return ret;
>  	}
> -	ret = regulator_enable(st->vref);
> -	if (ret) {
> -		regulator_disable(st->reg);
> -		dev_err(dev, "Unable to enable vref regulator\n");
> -		return ret;
> +
> +	if (st->vref) {
> +		ret = regulator_enable(st->vref);
> +		if (ret) {
> +			regulator_disable(st->reg);
> +			dev_err(dev, "Unable to enable vref regulator\n");
> +			return ret;
> +		}
>  	}
>  
>  	/* resync config */
>  	ret = ad799x_update_config(st, st->config);
>  	if (ret) {
> -		regulator_disable(st->vref);
> +		if (st->vref) 
> +			regulator_disable(st->vref);
>  		regulator_disable(st->reg);
>  		return ret;
>  	}

