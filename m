Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A85B74079A1
	for <lists+linux-iio@lfdr.de>; Sat, 11 Sep 2021 18:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbhIKQku (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 Sep 2021 12:40:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:41070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232241AbhIKQkt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 11 Sep 2021 12:40:49 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87B8861209;
        Sat, 11 Sep 2021 16:39:35 +0000 (UTC)
Date:   Sat, 11 Sep 2021 17:43:06 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Florian Boor <florian.boor@kernelconcepts.de>
Cc:     linux-iio@vger.kernel.org, Jonathan.Cameron@huawei.com,
        Michael.Hennerich@analog.com
Subject: Re: [PATCH v2 1/2] iio: adc: ad799x: Implement selecting external
 reference voltage input on AD7991, AD7995 and AD7999.
Message-ID: <20210911174306.16779384@jic23-huawei>
In-Reply-To: <20210908152525.2946785-1-florian.boor@kernelconcepts.de>
References: <20210908152525.2946785-1-florian.boor@kernelconcepts.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed,  8 Sep 2021 17:25:24 +0200
Florian Boor <florian.boor@kernelconcepts.de> wrote:

> Make use of the AD7991_REF_SEL bit and support using the external
> reference voltage if 'vref-supply' is present.
> 
> Signed-off-by: Florian Boor <florian.boor@kernelconcepts.de>

Hi Florian,

> ---
> 
> Changes in v2:
> - Check if a provided external vref regulator is provided.
> - Drop unused setting
> - Add ad79xx documentation (second patch)
> 
>  drivers/iio/adc/ad799x.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
> index 18bf8386d50a..2ff926a4e9b3 100644
> --- a/drivers/iio/adc/ad799x.c
> +++ b/drivers/iio/adc/ad799x.c
> @@ -770,6 +770,8 @@ static int ad799x_probe(struct i2c_client *client,
>  				   const struct i2c_device_id *id)
>  {
>  	int ret;
> +	int extra_config = 0;
> +	bool vref_external = true;
>  	struct ad799x_state *st;
>  	struct iio_dev *indio_dev;
>  	const struct ad799x_chip_info *chip_info =
> @@ -797,7 +799,15 @@ static int ad799x_probe(struct i2c_client *client,
>  	ret = regulator_enable(st->reg);
>  	if (ret)
>  		return ret;
> -	st->vref = devm_regulator_get(&client->dev, "vref");
> +		
> +	/* check if an external reference is supplied */
> +	st->vref = devm_regulator_get_optional(&client->dev, "vref");
> +
> +	if (PTR_ERR(st->vref) == -ENODEV) {
> +		vref_external = false;
> +		/* get dummy */
> +		st->vref = devm_regulator_get(&client->dev, "vref");

Why?  Instead of doing this add if (st->vref) around the regulator
enable and disable.  We don't want to pretend there is a regulator when
there isn't one connected and we are using VDD as the reference.

If we are in that mode, we need to change which regulator is read in
read_raw()


> +	}
>  	if (IS_ERR(st->vref)) {
>  		ret = PTR_ERR(st->vref);
>  		goto error_disable_reg;
> @@ -806,6 +816,13 @@ static int ad799x_probe(struct i2c_client *client,
>  	if (ret)
>  		goto error_disable_reg;
>  
> +	/* use external reference voltage, optional if regulator present */
> +	if (vref_external && 
> +	   ((st->id == ad7991) || (st->id == ad7995) || (st->id == ad7999))) {
> +		dev_info(&client->dev, "Using external reference voltage\n");
> +		extra_config |= AD7991_REF_SEL;
> +	}
> +
>  	st->client = client;
>  
>  	indio_dev->name = id->name;
> @@ -815,7 +832,7 @@ static int ad799x_probe(struct i2c_client *client,
>  	indio_dev->channels = st->chip_config->channel;
>  	indio_dev->num_channels = chip_info->num_channels;
>  
> -	ret = ad799x_update_config(st, st->chip_config->default_config);
> +	ret = ad799x_update_config(st, st->chip_config->default_config | extra_config);
>  	if (ret)
>  		goto error_disable_vref;
>  

