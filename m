Return-Path: <linux-iio+bounces-24705-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 237A5BB8DCC
	for <lists+linux-iio@lfdr.de>; Sat, 04 Oct 2025 15:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B8F294E6022
	for <lists+linux-iio@lfdr.de>; Sat,  4 Oct 2025 13:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C360F273D9F;
	Sat,  4 Oct 2025 13:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ccjXR+w5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE1C25A642;
	Sat,  4 Oct 2025 13:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759583815; cv=none; b=kKiKGbbeRUGvct5VIvqcvDH4gsA9kZLstTaVAp4Ie5V/eA2wZLBZ/5By4qLq4d6xjLEcPFoHTdZCqWhfTlK3Y+nfWNMNI+8WXlaMm7UGBe3x64HH+jYQdVucaT35p+nPyf4nYZu1ePgu7eovWNDta16FAzSkfEmCDin0GcUjqbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759583815; c=relaxed/simple;
	bh=hzxcdp7JsMWXprVyzYy5th44+3G4WR8/1+0zoIxXo1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ev/oD4BFGa5/kUqWqmecbKNN1/Oe+p4RkPsZ3R4bwujUGEQAzifI0bVXmY7U/keA1JyMzhQf2iwh7AiL6meYrbFe5NHeYeyHnESYcpQWM4uM0Ae07GdzVFwt8daEZtmN+b1lDNvEtGiB/R2DTewFzxTh+it9mg3CGJ4aSYh3Vrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ccjXR+w5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA180C4CEF1;
	Sat,  4 Oct 2025 13:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759583814;
	bh=hzxcdp7JsMWXprVyzYy5th44+3G4WR8/1+0zoIxXo1Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ccjXR+w5iVWiklHsEyDLwvfx+No3oghNKAD9wybGzpQ9awVF9sdbKBxlPzJwEFDZ1
	 BQtB/pOgi1xItVlYT4ydp+g49Bfa3U23sfrReTgwyZTsm7LtQWg7W2nGvaajGhS//5
	 JZZrQ/uLhiXPWzojWz0b/zFa9dQakc94+Mugrw4a94OQuQ00WxzBzB/3Kk8PpaCMvg
	 LsJfshbpEOp/HQwZ3fdZhk1U0FOYnwbqnIdkktSBnvhuo/IM7v1e+i2544d+9wf+3V
	 nS8Eah+H6x9GpUg3HUPIzx90KTD+FEjymu1p3huNu3EoCJcHqXTmmfLl5u6mYysRCd
	 gfyjzgNk3p6Zg==
Date: Sat, 4 Oct 2025 14:16:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Shrikant Raskar <raskar.shree97@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 matt@ranostay.sg, skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH 2/2] iio: health: max30100: Add pulse-width
 configuration via DT
Message-ID: <20251004141644.7fcb9106@jic23-huawei>
In-Reply-To: <20251004015623.7019-3-raskar.shree97@gmail.com>
References: <20251004015623.7019-1-raskar.shree97@gmail.com>
	<20251004015623.7019-3-raskar.shree97@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  4 Oct 2025 07:26:23 +0530
Shrikant Raskar <raskar.shree97@gmail.com> wrote:

> The MAX30100 driver previously hardcoded the SPO2 pulse width to
> 1600us. This patch adds support for reading the pulse width from
> device tree (`maxim,pulse-width`) and programming it into the SPO2
> configuration register.
> 
> If no property is provided, the driver falls back to 1600us to
> preserve existing behavior.
> 
> Testing:
> Hardware: Raspberry Pi 3B + MAX30100 breakout
> Verified DT property read in probe()
> Confirmed SPO2_CONFIG register written correctly using regmap_read()
A few minor comments inline.
Thanks,

Jonathan

> 
> Signed-off-by: Shrikant Raskar <raskar.shree97@gmail.com>
> ---
>  drivers/iio/health/max30100.c | 39 +++++++++++++++++++++++++++++++++--
>  1 file changed, 37 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/health/max30100.c b/drivers/iio/health/max30100.c
> index 814f521e47ae..2b3348c75beb 100644
> --- a/drivers/iio/health/max30100.c
> +++ b/drivers/iio/health/max30100.c
> @@ -5,7 +5,6 @@
>   * Copyright (C) 2015, 2018
>   * Author: Matt Ranostay <matt.ranostay@konsulko.com>
>   *
> - * TODO: enable pulse length controls via device tree properties
>   */
>  
>  #include <linux/module.h>
> @@ -54,6 +53,9 @@
>  #define MAX30100_REG_SPO2_CONFIG		0x07
>  #define MAX30100_REG_SPO2_CONFIG_100HZ		BIT(2)
>  #define MAX30100_REG_SPO2_CONFIG_HI_RES_EN	BIT(6)
> +#define MAX30100_REG_SPO2_CONFIG_200US		0x0
> +#define MAX30100_REG_SPO2_CONFIG_400US		0x1
> +#define MAX30100_REG_SPO2_CONFIG_800US		0x2
>  #define MAX30100_REG_SPO2_CONFIG_1600US		0x3
>  
>  #define MAX30100_REG_LED_CONFIG			0x09
> @@ -306,19 +308,52 @@ static int max30100_led_init(struct max30100_data *data)
>  		MAX30100_REG_LED_CONFIG_LED_MASK, reg);
>  }
>  
> +static int max30100_get_pulse_width(unsigned int pwidth_us)
> +{
> +	switch (pwidth_us) {
> +	case 200:
> +		return MAX30100_REG_SPO2_CONFIG_200US;
> +	case 400:
> +		return MAX30100_REG_SPO2_CONFIG_400US;
> +	case 800:
> +		return MAX30100_REG_SPO2_CONFIG_800US;
> +	case 1600:
> +		return MAX30100_REG_SPO2_CONFIG_1600US;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>  static int max30100_chip_init(struct max30100_data *data)
>  {
>  	int ret;
> +	unsigned int pulse_us;
> +	unsigned int pulse_width;
> +	struct device *dev = &data->client->dev;
>  
>  	/* setup LED current settings */
>  	ret = max30100_led_init(data);
>  	if (ret)
>  		return ret;
>  
> +	/* Get pulse width from DT, default = 1600us */
> +	ret = device_property_read_u32(dev, "maxim,pulse-width", &pulse_us);
> +	if (ret) {
> +		dev_warn(dev, "no pulse-width defined, defaulting to 1600us\n");
> +		pulse_width = MAX30100_REG_SPO2_CONFIG_1600US;

Usual trick for these is to set pulse_us to 1600 before calling the
device_property_read_u32(). If that fails then the default value will remain
in the variable and we can just call the code below without needing
to explicitly handle two cases.

> +	} else {
> +		pulse_width = max30100_get_pulse_width(pulse_us);
> +		if (pulse_width < 0) {
> +			dev_err(dev, "invalid pulse-width %u\n", pulse_us);

Only happens in probe() so prefer use of return dev_err_probe()
for compactness in this case.

> +			return pulse_width;
> +		}
> +	}
> +
>  	/* enable hi-res SPO2 readings at 100Hz */
>  	ret = regmap_write(data->regmap, MAX30100_REG_SPO2_CONFIG,
>  				 MAX30100_REG_SPO2_CONFIG_HI_RES_EN |
> -				 MAX30100_REG_SPO2_CONFIG_100HZ);
> +				 MAX30100_REG_SPO2_CONFIG_100HZ |
> +				 pulse_width);

Even though it's the lowest field in this register. I'd prefer
a mask being defined and FIELD_PREP() used to set it.
That way we don't need to know it is the lowest field when looking at this
code.

>  	if (ret)
>  		return ret;
>  


