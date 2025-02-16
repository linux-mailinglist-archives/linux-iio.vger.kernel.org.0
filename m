Return-Path: <linux-iio+bounces-15557-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19870A374A3
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 15:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 139173AF222
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 14:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E8C197556;
	Sun, 16 Feb 2025 14:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aNch5udG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A00B192B9D;
	Sun, 16 Feb 2025 14:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739715306; cv=none; b=twYRxLphS2k5ppL4uAJ8+s006mbk6nvLbIzzwHJjfQ/sjUU1JsGhwOJDmuSI/ldC28V7fSjfvuiBBjpuK12kPygmjwuaRybYdUpwjdohq29mhG08fF2dBxPFu0h9vNAh4LLYaeaxFaJ7CgfYv186poa7wHBBaBF0kf2pmIenH5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739715306; c=relaxed/simple;
	bh=0oCEo+7yotf5nuXekGVwlfitATvY6kEPqmsOqRb9UCU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tElEjgp0MlGxIz1kXPwlx/Kzv5NRfJaHxCqYoi4d4oKiYRXAWulVwqEUgRNbnhebqn21dI6DYXa10DgV2Tw8taMBx7MkVXgHV7KfvkpYs5HYgWYsiSaMEptWWfLZsiJtHfjGfTakh4u8GdDe6sjR4t9R1qGGf/nmLkKJoMKJOxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aNch5udG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D07B0C4CEDD;
	Sun, 16 Feb 2025 14:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739715304;
	bh=0oCEo+7yotf5nuXekGVwlfitATvY6kEPqmsOqRb9UCU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aNch5udGLjt/8JgGARw92n0/QgGX9AqwKlcnhDijK5F3NxM8DZ+3TDVlti5k0fdxf
	 cBxs5X/KSPI4xLTofPE2uxAfH5YK2tV9axZltVhDNDkmm53uBCc7lGB2+huGaqjewz
	 ozqNMLldWrFClNGNULVhwIPKtLx2ykRDMeHZoMNpWpojknkPco+Z7lxIJUX0NSlFRx
	 AP7l/blMiTcAR0QY8PQaZHSCDaCKhRTAzfkTKWsgtqxwFzqWgJHHgrDvyjehFAp6Nf
	 IqBxmIhTutKHd+GbbV+HIZo3PBFbfr+ipZmVEKg1vmAnCP92he7D01bXTyl1XH7ns6
	 xnl7pZ0DnVJYg==
Date: Sun, 16 Feb 2025 14:14:55 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: "Sperling, Tobias" <Tobias.Sperling@Softing.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] iio: adc: Add driver for ADS7128 / ADS7138
Message-ID: <20250216141455.0706300b@jic23-huawei>
In-Reply-To: <BE1P281MB24204588A273E7444E10DB20EFFC2@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
References: <20250206-adc_ml-v3-0-1d0bd3483aa2@softing.com>
	<20250206-adc_ml-v3-2-1d0bd3483aa2@softing.com>
	<20250208150526.10ee8f1c@jic23-huawei>
	<BE1P281MB24204588A273E7444E10DB20EFFC2@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Feb 2025 12:23:15 +0000
"Sperling, Tobias" <Tobias.Sperling@Softing.com> wrote:

> Hi Jonathan,
> 
> I'll change the things you've mentioned. Just some comments inline.
> 
> Regards,
> Tobias
> 
> > Von: Jonathan Cameron <jic23@kernel.org>
> > Gesendet: Samstag, 8. Februar 2025 16:05
> >   
> > > From: Tobias Sperling <tobias.sperling@softing.com>
> > >
> > > Add driver for ADS7128 and ADS7138 12-bit, 8-channel analog-to-digital
> > > converters. These ADCs have a wide operating range and a wide feature
> > > set. Communication is based on the I2C interface.
> > > ADS7128 differs in the addition of further hardware features, like a
> > > root-mean-square (RMS) and a zero-crossing-detect (ZCD) module.
> > >
> > > Signed-off-by: Tobias Sperling <tobias.sperling@softing.com>  
> > 
> > Hi Tobias,
> > 
> > Minor comments below and one question about power management
> > 
> > Thanks,
> > 
> > Jonathan
> > 
> >   
> > > +static int ads71x8_i2c_write(const struct i2c_client *client, u8 reg, u8 value)
> > > +{
> > > +	return ads71x8_i2c_write_block(client, reg, &value, sizeof(value));  
> > 
> > Maybe this should use the single register write (figure 35) rather than bulk one?
> > It makes no real difference though other than different opcode.  
> 
> Yeah can be done, but as there's no difference I didn't want to introduce yet
> another function just for single writes. However, as you mentioned below,
> ads71x8_i2c_setclear_bit() can be used for that, too. So I'll change that.
> 
> > > +}
> > > +
> > > +static int ads71x8_i2c_setclear_bit(const struct i2c_client *client, u8 reg,
> > > +				    u8 bits, u8 opcode)  
> >   
> > > +{
> > > +	u8 buf[3] = { opcode, reg, bits };
> > > +	int ret;
> > > +
> > > +	ret = i2c_master_send(client, buf, ARRAY_SIZE(buf));
> > > +	if (ret < 0)
> > > +		return ret;
> > > +	if (ret != ARRAY_SIZE(buf))
> > > +		return -EIO;
> > > +
> > > +	return 0;
> > > +}  
> > 
> > Whilst this is currently just used for setclear_bit, it is slightly more general
> > so maybe the name should reflect that it could be used for single register
> > writes for instance.  Naming is hard though and I can't immediately think
> > what name covers this combination.  
> 
> Having something like _write_single_reg_with_opcode() in mind.
> 
> > > +static int ads7138_init_hw(struct ads71x8_data *data)
> > > +{
> > > +	int ret;
> > > +
> > > +	data->vref_regu = devm_regulator_get_optional(&data->client->dev,  
> > "avdd");
> > 
> > avdd isn't optional. We need the power!  As such I'd not paper over the lack
> > of it being available.  To avoid weird effects on reading the scale later,
> > you may want to do a read here so that we can error out if a stub regulator
> > has been provided.  
> 
> Ok, just wanted to add flexibility for the enduser to not having to define it
> in the DTS, but right, AVDD needs to be connected physically. Will change
> accordingly.

In most cases they will have that flexibility anyway.  It is normally
fine to not provide regulators.
The regulator core just provides a stub regulator instead that
represents an always on supply of unknown characteristics.

> 
> > > +
> > > +static const struct dev_pm_ops ads71x8_pm_ops = {
> > > +	RUNTIME_PM_OPS(ads71x8_runtime_suspend,  
> > ads71x8_runtime_resume, NULL)
> > 
> > Given it's likely that the runtime pm ops are better than nothing in
> > suspend and resume cases as well could we make this
> > DEFINE_RUNTIME_PM_OPS() which uses the runtime ops for those
> > cases as well?
> >   
> 
> Yes, looks like DEFINE_RUNTIME_DEV_PM_OPS() can be used to use
> these functions for the other cases, too.
> 
> >   
> > > +};  


