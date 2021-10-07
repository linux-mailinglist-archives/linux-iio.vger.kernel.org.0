Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDF1C425694
	for <lists+linux-iio@lfdr.de>; Thu,  7 Oct 2021 17:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240871AbhJGPcK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Thu, 7 Oct 2021 11:32:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:42098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230410AbhJGPcJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 7 Oct 2021 11:32:09 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C03926113E;
        Thu,  7 Oct 2021 15:30:14 +0000 (UTC)
Date:   Thu, 7 Oct 2021 16:34:18 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Florian Boor <florian.boor@kernelconcepts.de>
Cc:     linux-iio@vger.kernel.org, Jonathan.Cameron@huawei.com,
        Michael.Hennerich@analog.com, devicetree@vger.kernel.org,
        robh+dt@kernel.org
Subject: Re: [PATCH v6 1/2] iio: adc: ad799x: Implement selecting external
 reference voltage input on AD7991, AD7995 and AD7999.
Message-ID: <20211007163418.7607a60e@jic23-huawei>
In-Reply-To: <20210930104249.2924336-1-florian.boor@kernelconcepts.de>
References: <20210930104249.2924336-1-florian.boor@kernelconcepts.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 30 Sep 2021 12:42:48 +0200
Florian Boor <florian.boor@kernelconcepts.de> wrote:

> Make use of the AD7991_REF_SEL bit and support using the external
> reference voltage if 'vref-supply' is present. Use VCC voltage supply
> as reference if no extra reference is supplied.
> 
> Signed-off-by: Florian Boor <florian.boor@kernelconcepts.de>

Hi Florian,

Applied, but there were are whole bunch of trailing white space issues in here
that I manually fixed up.

Please run checkpatch.pl over future patches

Applied to the togreg branch of iio.git and pushed out as testing to
see what 0-day makes of it.

Thanks,

Jonathan
> ---
> 
> Changes in v6:
> - Minor documentation change (label and contact info)
> 
> Changes in v5:
> - Correct errors in documentation found by
>   'make DT_CHECKER_FLAGS=-m dt_binding_check'
>   + Reduce title length
>   + Move information to description
>   + Add I²C bits to example
> 
> Changes in v4:
> - Check devm_regulator_get_optional() return value and
>   handle values other from -ENODEV separately.
> - Update documentation description
> 
> Changes in v3:
> - Do not create dummy reference regulator, check for vref presence where needed.
> - Use VCC as reference if no extra reference voltage is provided
> - Add interrupt information to documentation
> 
> Changes in v2:
> - Check if a provided external vref regulator is provided.
> - Drop unused setting
> - Add ad79xx documentation (second patch)
> 
> 
>  drivers/iio/adc/ad799x.c | 68 ++++++++++++++++++++++++++++++----------
>  1 file changed, 51 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
> index 18bf8386d50a..b67b3076d76e 100644
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
> @@ -797,14 +802,36 @@ static int ad799x_probe(struct i2c_client *client,
>  	ret = regulator_enable(st->reg);
>  	if (ret)
>  		return ret;
> -	st->vref = devm_regulator_get(&client->dev, "vref");
> +		
> +	/* check if an external reference is supplied */
> +	st->vref = devm_regulator_get_optional(&client->dev, "vref");
> +
>  	if (IS_ERR(st->vref)) {
> -		ret = PTR_ERR(st->vref);
> -		goto error_disable_reg;
> +		if (PTR_ERR(st->vref) == -ENODEV) {
> +			st->vref = NULL;
> +			dev_info(&client->dev, "Using VCC reference voltage\n");
> +		} else {
> +			ret = PTR_ERR(st->vref);
> +			goto error_disable_reg;
> +		}
> +	}
> +		
> +	if (st->vref) {
> +		/* 
> +		 * Use external reference voltage if supported by hardware.
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
> @@ -815,7 +842,7 @@ static int ad799x_probe(struct i2c_client *client,
>  	indio_dev->channels = st->chip_config->channel;
>  	indio_dev->num_channels = chip_info->num_channels;
>  
> -	ret = ad799x_update_config(st, st->chip_config->default_config);
> +	ret = ad799x_update_config(st, st->chip_config->default_config | extra_config);
>  	if (ret)
>  		goto error_disable_vref;
>  
> @@ -845,7 +872,8 @@ static int ad799x_probe(struct i2c_client *client,
>  error_cleanup_ring:
>  	iio_triggered_buffer_cleanup(indio_dev);
>  error_disable_vref:
> -	regulator_disable(st->vref);
> +	if (st->vref) 
> +		regulator_disable(st->vref);
>  error_disable_reg:
>  	regulator_disable(st->reg);
>  
> @@ -860,7 +888,8 @@ static int ad799x_remove(struct i2c_client *client)
>  	iio_device_unregister(indio_dev);
>  
>  	iio_triggered_buffer_cleanup(indio_dev);
> -	regulator_disable(st->vref);
> +	if (st->vref) 
> +		regulator_disable(st->vref);
>  	regulator_disable(st->reg);
>  	kfree(st->rx_buf);
>  
> @@ -872,7 +901,8 @@ static int __maybe_unused ad799x_suspend(struct device *dev)
>  	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
>  	struct ad799x_state *st = iio_priv(indio_dev);
>  
> -	regulator_disable(st->vref);
> +	if (st->vref) 
> +		regulator_disable(st->vref);
>  	regulator_disable(st->reg);
>  
>  	return 0;
> @@ -889,17 +919,21 @@ static int __maybe_unused ad799x_resume(struct device *dev)
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

