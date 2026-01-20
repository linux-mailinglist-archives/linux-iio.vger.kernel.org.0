Return-Path: <linux-iio+bounces-28053-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E17D3C5E2
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jan 2026 11:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 811BA762A5B
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jan 2026 10:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425273F23A7;
	Tue, 20 Jan 2026 10:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rmsXChc5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD4A3B8D60;
	Tue, 20 Jan 2026 10:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768905209; cv=none; b=L8KKH5/qhiW5LsNIFBEQoMTdfNEoKO9Z2UxRN+BCY9ntS9o6RwjI4V26bce7jOnXi3glI1JLalcSk11/Fr/favb9hF+RCMM0q9h7Ll67+rGts374SAlwPGRF4QsnineVNdHBEiCIMTEwjAtsRovmqkA+DOcZt7fuegHP2ei0Z4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768905209; c=relaxed/simple;
	bh=JmobZY0MC5V+D0VELbz0Keuoc4LhR7cCkroCWV7u844=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nyTat6G30B8fCSALVn4QuXWU0XLjHb4Jif+xwGZve5nFnCs7nD8roQVOoa1rObDHBJxi22pjKHWymOgoIMWJiHyn3XjPVUMW05OaqDRVI7WeRDtboKFT3SU+cXvYcATQ1vGtGHnj4YxV0CBgJXF3a3MgMj0IUdZnjnbbPEJ3BRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rmsXChc5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFB03C2BC86;
	Tue, 20 Jan 2026 10:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768905208;
	bh=JmobZY0MC5V+D0VELbz0Keuoc4LhR7cCkroCWV7u844=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rmsXChc59v3HDNf1zBlLAALhRMCpJPF0kvwxI4M37TKg/T8Bd1OMIA8VLOLd4X283
	 Ol5Bu0AA19xkbF+Bsh8/Y0F7MVMchKAKzhi5eq/4fCbdhnYqK50KVcgG0pVzS/hyA1
	 aOAvkAjcyR7OlB4TkQAwCSs35u7eRdIKqg0NhJQELak9NyeD024w9ccD2AIIwpJ70h
	 jhz8Hfkp3auXq9qJfTWcGBMVMCQ6eQvXefyQoxW+shSjtJbn3N91Layp2PMwn8QXWT
	 gB3Hwy5DEigSI01eKI3gRaVImrBqrCov/QlkL4+gC0r0SxcdVGAN+bZpURyOUoQyW4
	 FVAhw2Jhypo/w==
Date: Tue, 20 Jan 2026 11:33:26 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Petr Hodina <petr.hodina@protonmail.com>
Cc: Song Qiang <songqiang1304521@gmail.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	David Heidelberg <david@ixit.cz>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] iio: proximity: vl53l0x-i2c: Fix reset sequence
Message-ID: <20260120-dragon-of-fascinating-felicity-b0cf4d@quoll>
References: <20260119-vl53l0x-v1-0-cf71715a1353@protonmail.com>
 <20260119-vl53l0x-v1-3-cf71715a1353@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260119-vl53l0x-v1-3-cf71715a1353@protonmail.com>

On Mon, Jan 19, 2026 at 06:19:57PM +0100, Petr Hodina wrote:
> Fix the reset GPIO handling and power-up timing to better match the
> VL53L0X reset requirements.
> 
> Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
> ---
>  drivers/iio/proximity/vl53l0x-i2c.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/vl53l0x-i2c.c
> index 7bfab396377a..6901ce7dd835 100644
> --- a/drivers/iio/proximity/vl53l0x-i2c.c
> +++ b/drivers/iio/proximity/vl53l0x-i2c.c
> @@ -275,9 +275,13 @@ static int vl53l0x_power_on(struct vl53l0x_data *data)
>  			return ret;
>  	}
>  
> -	gpiod_set_value_cansleep(data->reset_gpio, 0);
> -
> -	usleep_range(3200, 5000);
> +	usleep_range(5000, 6000);
> +	if (data->reset_gpio) {
> +		gpiod_set_value_cansleep(data->reset_gpio, 1);
> +		usleep_range(5000, 6000);
> +		gpiod_set_value_cansleep(data->reset_gpio, 0);
> +		usleep_range(5000, 6000);
> +	}
>  
>  	return 0;
>  }
> @@ -354,7 +358,7 @@ static int vl53l0x_probe(struct i2c_client *client)
>  		return dev_err_probe(&client->dev, PTR_ERR(data->vio_supply),
>  				     "Unable to get VDDIO regulator\n");
>  
> -	data->reset_gpio = devm_gpiod_get_optional(&client->dev, "reset", GPIOD_OUT_HIGH);
> +	data->reset_gpio = devm_gpiod_get_optional(&client->dev, "reset", GPIOD_OUT_LOW);

This feels wrong - you are now bringing the device out of reset without
observing any of the reset sequence constraints.

Best regards,
Krzysztof


