Return-Path: <linux-iio+bounces-9847-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD80989083
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 18:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92CD11C211FF
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 16:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D7517C95;
	Sat, 28 Sep 2024 16:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UsLr9df0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7B441C7F;
	Sat, 28 Sep 2024 16:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727541782; cv=none; b=YNH8/n4A0eOFQw8SlvBiNkYOcrXUUKV/+zjzOxJQFWej7y0I5h8S6WnfpHGb/RScARfZ0jdExA6G0Url8o1LO1srdFySDzgshp23rJC5WsE5roLDLg5jnETSo8gVTbLylOrDguioPYBPYP5MOElkfSh4Fc/c2Sp3JWCV7HPDB4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727541782; c=relaxed/simple;
	bh=F6V9xi2zcq1VTifc7ioJNEV8FVo04pNx2XSTqvzikHI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UNNXjrmozxgFQhcA3ZF9BHEfeFeAbGhVZtpcMTmE2IJvp4XVOqll80jyEP51V+Atan/Lb16ljRSRsVHrV+olq85RcmOstPpN9+htJBO82NAzf5Iwcm5m5hleFhQbOTZRmNXlmiDAaPw+UAyxxJaGuAruwmqpPsipAdLVLaY3IQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UsLr9df0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61350C4CEC3;
	Sat, 28 Sep 2024 16:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727541781;
	bh=F6V9xi2zcq1VTifc7ioJNEV8FVo04pNx2XSTqvzikHI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UsLr9df0W58WKbX/sLVh3t9WOQFiTunIlG2o5zbGFJHezPIhwFMcQB3v6/fKOjOeR
	 qpoAO+9+rpyeRV9etJizuLUoXh+6IPPbSayOFTC2WwAA6tydaUsbwXA3GfrROu5ANO
	 JBlkQetME1ZWd4X2WvAGfLhw6kXy8qukY70QiONINNHAjb+cScf63tQxlrHcD/LZog
	 asu0DHwO2ttJmk75JgynAcPDV5cqhj053MB6QyQiP20clhoiE1NXtisrhfWDp9MHYz
	 I3Iu8KK9s2awduDRyJbAnN/mWpQHT2yPmNmR+CmnavNrXFsK+/qS9HHJjPATlF/Al/
	 1Ht0oNdpKb6qw==
Date: Sat, 28 Sep 2024 17:42:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: <victor.duicu@microchip.com>
Cc: <matteomartelli3@gmail.com>, <lars@metafoo.de>,
 <marius.cristea@microchip.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] iio: adc: pac1921: add ACPI support for pac1921
Message-ID: <20240928174253.15e1fe7a@jic23-huawei>
In-Reply-To: <20240925150856.19441-1-victor.duicu@microchip.com>
References: <20240925150856.19441-1-victor.duicu@microchip.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Sep 2024 18:08:56 +0300
<victor.duicu@microchip.com> wrote:

> From: Victor Duicu <victor.duicu@microchip.com>
> 
> This patch implements ACPI support for pac1921.
> Driver can read shunt resistor value and device name from ACPI table.
> 
> Signed-off-by: Victor Duicu <victor.duicu@microchip.com>
Hi Victor.

Comments inline on top of what Matteo already provided.

Thanks,

Jonathan



If there is documentation for the DSM etc here available, then please
add a comment with a link to it.

> +static int pac1921_match_acpi_device(struct i2c_client *client, struct pac1921_priv *priv)
> +{
> +	const struct acpi_device_id *device_pointer;
> +	acpi_handle handle;
> +	union acpi_object *rez;
> +	guid_t guid;
> +	struct device *dev = &client->dev;
> +
> +	guid_parse(PAC1921_DSM_UUID, &guid);
> +	handle = ACPI_HANDLE(&client->dev);
> +
> +	device_pointer = acpi_match_device(dev->driver->acpi_match_table, dev);

check the fw type rather than doing this.
The ACPI_HANDLE() check you have below should be sufficient already.


> +	if (!device_pointer)
> +		return -EINVAL;
> +
> +	rez = acpi_evaluate_dsm(handle, &guid, 1, PAC1921_ACPI_GET_UOHMS_VALS, NULL);
> +	if (!rez)
> +		return dev_err_probe(&client->dev, -EINVAL,
> +				     "Could not read shunt from ACPI table\n");
> +
> +	priv->rshunt_uohm = rez->package.elements[0].integer.value;
> +	ACPI_FREE(rez);
> +
> +	if (priv->rshunt_uohm == 0)
> +		return dev_err_probe(&client->dev, -EINVAL, "Shunt value is 0.");
Say why it is an error. "Shunt value cannot be 0\n");

Note also the new line.
> +
> +	pac1921_calc_current_scales(priv);
> +
> +	rez = acpi_evaluate_dsm(handle, &guid, 1, PAC1921_ACPI_GET_NAME, NULL);
> +	if (!rez) {
> +		priv->name = "";
Not a huge point in clearing this if you are going to error out anyway. 
I woudn't bother doing so.

> +		return dev_err_probe(&client->dev, -EINVAL,
> +				     "Could not read name from ACPI table\n");
> +	}
> +
> +	priv->name = devm_kmemdup(&client->dev, rez->package.elements->string.pointer,
> +				  (size_t)rez->package.elements->string.length + 1,
> +				  GFP_KERNEL);
> +	priv->name[rez->package.elements->string.length] = '\0';
> +	ACPI_FREE(rez);
> +
> +	return 0;
> +}
> +
> +static int pac1921_match_of_device(struct i2c_client *client, struct pac1921_priv *priv)
This isn't matching the device, it's reading parameters from fw.


	pac1921_parse_of_fw() or something like that for the function name.

> +{
> +	int ret;
> +	struct device *dev = &client->dev;
> +
> +	/* Read shunt resistor value */

Don't put comments in that are obvious from the code.
Comments have a nasty habit of bit rotting (people fail to keep them up to
date) so to reduce chances of that we only use them when they add information
not obvious from the code.

> +	ret = device_property_read_u32(dev, "shunt-resistor-micro-ohms", &priv->rshunt_uohm);

When it doesn't hurt readability, please try to stay under 80 chars.

> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Cannot read shunt resistor property\n");
> +
> +	if (priv->rshunt_uohm == 0 || priv->rshunt_uohm > INT_MAX)
> +		return dev_err_probe(dev, -EINVAL, "Invalid shunt resistor: %u\n",
> +				     priv->rshunt_uohm);
> +
> +	pac1921_calc_current_scales(priv);
> +
> +	if (device_property_present(dev, "name")) {
> +		ret = device_property_read_string(dev, "name", (const char **)&priv->name);

This is a new thing for the of binding so should have been in a precursor patch and included
DT binding documentation update.  + as per other discussion use label which
will just work out of the box.

> +		if (ret)
> +			return dev_err_probe(&client->dev, ret,
> +					     "Invalid rail-name value\n");
> +	} else {
> +		priv->name = "pac1921";
> +	}
> +
> +	return 0;
> +}
> +
>  static int pac1921_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
> @@ -1172,22 +1250,14 @@ static int pac1921_probe(struct i2c_client *client)
>  				     "Cannot initialize register map\n");
>  
>  	devm_mutex_init(dev, &priv->lock);
> +	if (ACPI_HANDLE(&client->dev))
> +		ret = pac1921_match_acpi_device(client, priv);
> +	else
> +		ret = pac1921_match_of_device(client, priv);
>  
> -	priv->dv_gain = PAC1921_DEFAULT_DV_GAIN;
> -	priv->di_gain = PAC1921_DEFAULT_DI_GAIN;
> -	priv->n_samples = PAC1921_DEFAULT_NUM_SAMPLES;
> -
> -	ret = device_property_read_u32(dev, "shunt-resistor-micro-ohms",
> -				       &priv->rshunt_uohm);
> -	if (ret)
> -		return dev_err_probe(dev, ret,
> -				     "Cannot read shunt resistor property\n");
> -	if (priv->rshunt_uohm == 0 || priv->rshunt_uohm > INT_MAX)
> -		return dev_err_probe(dev, -EINVAL,
> -				     "Invalid shunt resistor: %u\n",
> -				     priv->rshunt_uohm);
> -
> -	pac1921_calc_current_scales(priv);
> +	if (ret < 0)
> +		return dev_err_probe(&client->dev, ret,
> +				     "parameter parsing error\n");
>  
>  	priv->vdd = devm_regulator_get(dev, "vdd");
>  	if (IS_ERR(priv->vdd))
> @@ -1198,13 +1268,15 @@ static int pac1921_probe(struct i2c_client *client)
>  	if (ret)
>  		return dev_err_probe(dev, ret, "Cannot enable vdd regulator\n");
>  
> -	ret = devm_add_action_or_reset(dev, pac1921_regulator_disable,
> -				       priv->vdd);
> +	ret = devm_add_action_or_reset(dev, pac1921_regulator_disable, priv->vdd);

As Matteo stated, formatting changes don't belong in a patch making
more substantial changes such as this.  If you think they
should be done, then separate patch so we can assess them without
them adding noise to the real work here.

>  	if (ret)
>  		return dev_err_probe(dev, ret,
> -			"Cannot add action for vdd regulator disposal\n");
> +				     "Cannot add action for vdd regulator disposal\n");
>  
>  	msleep(PAC1921_POWERUP_TIME_MS);
> +	priv->dv_gain = PAC1921_DEFAULT_DV_GAIN;
> +	priv->di_gain = PAC1921_DEFAULT_DI_GAIN;
> +	priv->n_samples = PAC1921_DEFAULT_NUM_SAMPLES;
>  
>  	ret = pac1921_init(priv);
>  	if (ret)
> @@ -1212,7 +1284,7 @@ static int pac1921_probe(struct i2c_client *client)
>  
>  	priv->iio_info = pac1921_iio;
>  
> -	indio_dev->name = "pac1921";
> +	indio_dev->name = priv->name;

This name should remain the part number.  As Matteo commented we have
label for more board specific information such as distinguishing between
instances by easy to understand naming.

>  	indio_dev->info = &priv->iio_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->channels = pac1921_channels;
> @@ -1244,11 +1316,17 @@ static const struct of_device_id pac1921_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, pac1921_of_match);
>  
> +static const struct acpi_device_id pac1921_acpi_match[] = {
> +	{ "MCHP1921" },

That's a valid ID for once which is good. I'll assume Microchip
has a process for tracking these and avoiding clashes.

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, pac1921_acpi_match);
>  static struct i2c_driver pac1921_driver = {
>  	.driver	 = {
>  		.name = "pac1921",
>  		.pm = pm_sleep_ptr(&pac1921_pm_ops),
>  		.of_match_table = pac1921_of_match,
> +		.acpi_match_table = pac1921_acpi_match
>  	},
>  	.probe = pac1921_probe,
>  	.id_table = pac1921_id,
> 
> base-commit: fec496684388685647652ab4213454fbabdab099


