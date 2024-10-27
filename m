Return-Path: <linux-iio+bounces-11399-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D3C9B1D9F
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 13:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E57BAB210C8
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 12:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE07153803;
	Sun, 27 Oct 2024 12:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cs2OVS4Q"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D91145A0B;
	Sun, 27 Oct 2024 12:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730031261; cv=none; b=TmC0MFHF98m1X7YTmDOpHmFZu38Xx371Qs+b4C5dTMCbaQBaZsrpnjsvAjBKrDHqNUpGYMWoQIZWOfs5cnB4h/gA/CvISDFgt7iWAob0wRR5WMVFzHkV8nwCVFk3QtjdpaT2lVvmeNwaQv2qGKJdE59ztG0H0Lu8dymWsa+nAa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730031261; c=relaxed/simple;
	bh=K7mregKkm97B4UPy/3KG+ChtXDnIj722Cg4nu0OcQo4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uodfHkz2PIu/MvX1GSdMhPkoGEm8Po5ttxjiorieJaYttVEkNrX36wnR4paNngfLTn5vcl14K+Iq+xsG5IrSUz5JFLg73EdH9cSyDxhdRqxZ9VX4wAjpSMIfBiI+1dP3HfIU2frxtdK2XRJXLLU0jykMs26tc+W0Ljejo9U5Jb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cs2OVS4Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE50EC4CEC3;
	Sun, 27 Oct 2024 12:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730031260;
	bh=K7mregKkm97B4UPy/3KG+ChtXDnIj722Cg4nu0OcQo4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cs2OVS4QiuO2vtmi0FttGb/TU9hJlSJ4VyA2eZmmwZG6iz3ke1ATlLavT8/UfM6dd
	 xRNm7ExTV01i5aKwgmAXsFbt4Cm5fWxeTdZ/oKLYg9xmxBg+zHbMqeG6jmsm8xQCwl
	 NppURYlTFFwkASRMfVbYJEQSJsW0nFKHeyFKFdA+A7zMs3HZcTYO+lLNu5BZ2mQNpt
	 ex/SJRvyOWItBTCBOqDj3SSVEMW0z2pnrjJ/6E+y9sTnElPBjk/dacECdi86Q86jXM
	 +KoWAT/faEA0td0fiikrR7A/yogJTFv5/CVj3htjT0CMr4i40wDsWnCWAew9ZZMnjv
	 iEMNI0Ogm2fvw==
Date: Sun, 27 Oct 2024 12:14:12 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: <victor.duicu@microchip.com>
Cc: <matteomartelli3@gmail.com>, <lars@metafoo.de>,
 <marius.cristea@microchip.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6] iio: adc: pac1921: Add ACPI support to Microchip
 pac1921
Message-ID: <20241027121412.0a71eb55@jic23-huawei>
In-Reply-To: <20241024100050.4727-1-victor.duicu@microchip.com>
References: <20241024100050.4727-1-victor.duicu@microchip.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Oct 2024 13:00:50 +0300
<victor.duicu@microchip.com> wrote:

> From: Victor Duicu <victor.duicu@microchip.com>
> 
> This patch implements ACPI support to Microchip pac1921.
> The driver can read shunt resistor value and label from ACPI table.
> 
> Signed-off-by: Victor Duicu <victor.duicu@microchip.com>
Hi Victor,

Been a while since I looked at a version of this. Some comments inline
on stuff that I probably missed before now.

Jonathan

>  };
>  
> +static inline bool pac1921_shunt_is_invalid(u32 shunt_val)
> +{
> +	return (shunt_val == 0 || shunt_val > INT_MAX);

Drop the brackets as they don't add anything much.

> +}
> +

> +/*
> + * documentation related to the ACPI device definition
> + * https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ApplicationNotes/ApplicationNotes/PAC193X-Integration-Notes-for-Microsoft-Windows-10-and-Windows-11-Driver-Support-DS00002534.pdf
> + */
> +static int pac1921_match_acpi_device(struct i2c_client *client, struct pac1921_priv *priv,
> +				     struct iio_dev *indio_dev)
> +{
> +	acpi_handle handle;
> +	union acpi_object *rez;
> +	guid_t guid;
> +	char *label;
> +
> +	guid_parse(PAC1921_DSM_UUID, &guid);
> +	handle = ACPI_HANDLE(&client->dev);
> +
> +	rez = acpi_evaluate_dsm(handle, &guid, 1, PAC1921_ACPI_GET_UOHMS_VALS, NULL);
> +	if (!rez)
> +		return dev_err_probe(&client->dev, -EINVAL,
> +				     "Could not read shunt from ACPI table\n");
> +
> +	priv->rshunt_uohm = rez->package.elements[0].integer.value;
> +	ACPI_FREE(rez);
> +
> +	if (pac1921_shunt_is_invalid(priv->rshunt_uohm))
> +		return dev_err_probe(&client->dev, -EINVAL, "Invalid shunt resistor\n");
> +
> +	pac1921_calc_current_scales(priv);

As below - I'd do this and the validity check outside of this function to avoid
duplication for the two firmware types.

> +
> +	rez = acpi_evaluate_dsm(handle, &guid, 1, PAC1921_ACPI_GET_LABEL, NULL);
> +	if (!rez)
> +		return dev_err_probe(&client->dev, -EINVAL,
> +				     "Could not read label from ACPI table\n");
> +
> +	label = devm_kmemdup(&client->dev, rez->package.elements->string.pointer,
> +			     (size_t)rez->package.elements->string.length + 1,
Are you duplicating one off the of the string?
I'm curious at the need for a null.

Consider devm_kstrdup() which only copies the actual string + adds the terminator.

+ check for allocation failure label may be NULL.

> +			     GFP_KERNEL);
> +	label[rez->package.elements->string.length] = '\0';
> +	indio_dev->label = label;
> +	ACPI_FREE(rez);
> +
> +	return 0;
> +}
> +
> +static int pac1921_parse_of_fw(struct i2c_client *client, struct pac1921_priv *priv)
> +{
> +	int ret;
> +	struct device *dev = &client->dev;
> +
> +	ret = device_property_read_u32(dev, "shunt-resistor-micro-ohms",
> +				       &priv->rshunt_uohm);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Cannot read shunt resistor property\n");
> +
> +	if (pac1921_shunt_is_invalid(priv->rshunt_uohm))
> +		return dev_err_probe(dev, -EINVAL, "Invalid shunt resistor: %u\n",
> +				     priv->rshunt_uohm);
> +
> +	pac1921_calc_current_scales(priv);

Why not do the sanity checks and scale calc outside of the firmware specific code
given it is duplicated and not related to the firmware parsing itself.


> +
> +	return 0;
> +}
> +
>  static int pac1921_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
> @@ -1176,17 +1254,13 @@ static int pac1921_probe(struct i2c_client *client)
>  	priv->di_gain = PAC1921_DEFAULT_DI_GAIN;
>  	priv->n_samples = PAC1921_DEFAULT_NUM_SAMPLES;
>  
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
> +	if (ACPI_HANDLE(&client->dev))
> +		ret = pac1921_match_acpi_device(client, priv, indio_dev);

priv is trivial to get from the indio_dev, so don't pass them both in.
Client also trivial to get from there, so just pass in the indio_dev to both
calls.


> +	else
> +		ret = pac1921_parse_of_fw(client, priv);
> +	if (ret < 0)
> +		return dev_err_probe(&client->dev, ret,
Use dev as it is the same device.

> +				     "parameter parsing error\n");
>  
>  	priv->vdd = devm_regulator_get(dev, "vdd");
>  	if (IS_ERR(priv->vdd))
> @@ -1243,11 +1317,17 @@ static const struct of_device_id pac1921_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, pac1921_of_match);


