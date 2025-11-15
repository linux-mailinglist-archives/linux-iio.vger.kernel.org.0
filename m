Return-Path: <linux-iio+bounces-26237-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A92EC6091F
	for <lists+linux-iio@lfdr.de>; Sat, 15 Nov 2025 18:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 60E0435472D
	for <lists+linux-iio@lfdr.de>; Sat, 15 Nov 2025 17:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B6F30170E;
	Sat, 15 Nov 2025 17:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="arbtmIjA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A7426E179;
	Sat, 15 Nov 2025 17:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763227454; cv=none; b=Hc2bcck+eykELrKSae/kY5pbs+jiHccIEKTyOlAU0DxUl2cOUer4qwLTxmPYkMlcN8ZmGSZdKBWVscdBHZmCtW9Vt8b9hGI0nMctRSfL0cx8d+Xx5tenntOLueAaVHvOoxCj6+T5YyMsui5+sh+rT5EdyKYIm06C67PFEbTYsv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763227454; c=relaxed/simple;
	bh=RQQr8CGCDpTmfgYXtgNEaJcaQGcoe9L22DH1cj008fY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i1TNJqfG+lchEHg5pVR/vKXds4IdZtT9ZU080rwkr+BG6gd0VWNnS02EH3GDI0y/KrNI5Tx5bI9kvkiNia1tkG8GgERCGf2tQhHRzCraiDYetdJAPHjnpV+3JOzHKHp+MkP41CncBKSWXh8TKvwR9VLfftZEnFrpoPQ92kOOOzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=arbtmIjA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BDD7C4CEF7;
	Sat, 15 Nov 2025 17:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763227453;
	bh=RQQr8CGCDpTmfgYXtgNEaJcaQGcoe9L22DH1cj008fY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=arbtmIjANQByK++M85G+t9ms7sdvnfUf212CN6XR3j6JAKBXPZcLaZLURwVclItm7
	 F963BlqepQUwGDtqlxAK7Qxxh4m7hyAf357W3NA4kjRJwUNht+ZADD5NKfR4WuyUaZ
	 YqeE8xQO2aOczXReGgT5X32fhMn3M2HHp0K94Qo1UuNsNaEgidHR5tQLJv7vz1qQE5
	 zssNyVQ1sYsdT+WdhHIMYaNM9EoZLWgnc5uq36eoYoQT2I3UUSwa5DyYjq0PgpbLfH
	 6nqMpp4R6+9sqEm2/ph5Xr7rIdqClJ8k8Gb93iDeMyj1kp9tZb4Tnxq08Fh6cnV6gh
	 ydi/Z0m3C8hQg==
Date: Sat, 15 Nov 2025 17:24:07 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <robh@kernel.org>, <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 linux-clk@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 2/2] iio: frequency: adf4377: add clk provider support
Message-ID: <20251115172407.2c00d58c@jic23-huawei>
In-Reply-To: <20251114120908.6502-3-antoniu.miclaus@analog.com>
References: <20251114120908.6502-1-antoniu.miclaus@analog.com>
	<20251114120908.6502-3-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Nov 2025 12:09:08 +0000
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add clk provider feature for the adf4377.
> 
> Even though the driver was sent as an IIO driver in most cases the
> device is actually seen as a clock provider.
> 
> This patch aims to cover actual usecases requested by users in order to
> completely control the output frequencies from userspace.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

Given this new code is basically a clock driver, I'd expect to see some
relevant folk +CC.

Added Michael, Stephen and linux-clk.

One question from me right at the end around whether it makes sense
to register an IIO device with no channels.  I left the rest so it was
easy for the people added to the thread to see all the code.

Thanks,

Jonathan


> ---
>  drivers/iio/frequency/adf4377.c | 131 +++++++++++++++++++++++++++++++-
>  1 file changed, 129 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/frequency/adf4377.c b/drivers/iio/frequency/adf4377.c
> index 08833b7035e4..08dc2110cf8c 100644
> --- a/drivers/iio/frequency/adf4377.c
> +++ b/drivers/iio/frequency/adf4377.c
> @@ -8,6 +8,7 @@
>  #include <linux/bitfield.h>
>  #include <linux/bits.h>
>  #include <linux/clk.h>
> +#include <linux/clk-provider.h>
>  #include <linux/clkdev.h>
>  #include <linux/delay.h>
>  #include <linux/device.h>
> @@ -435,9 +436,14 @@ struct adf4377_state {
>  	struct gpio_desc	*gpio_ce;
>  	struct gpio_desc	*gpio_enclk1;
>  	struct gpio_desc	*gpio_enclk2;
> +	struct clk		*clk;
> +	struct clk		*clkout;
> +	struct clk_hw		hw;
>  	u8			buf[2] __aligned(IIO_DMA_MINALIGN);
>  };
>  
> +#define to_adf4377_state(h)	container_of(h, struct adf4377_state, hw)
> +
>  static const char * const adf4377_muxout_modes[] = {
>  	[ADF4377_MUXOUT_HIGH_Z] = "high_z",
>  	[ADF4377_MUXOUT_LKDET] = "lock_detect",
> @@ -929,6 +935,120 @@ static int adf4377_freq_change(struct notifier_block *nb, unsigned long action,
>  	return NOTIFY_OK;
>  }
>  
> +static void adf4377_clk_del_provider(void *data)
> +{
> +	struct adf4377_state *st = data;
> +
> +	of_clk_del_provider(st->spi->dev.of_node);
> +}
> +
> +static unsigned long adf4377_clk_recalc_rate(struct clk_hw *hw,
> +					      unsigned long parent_rate)
> +{
> +	struct adf4377_state *st = to_adf4377_state(hw);
> +	u64 freq;
> +	int ret;
> +
> +	ret = adf4377_get_freq(st, &freq);
> +	if (ret)
> +		return 0;
> +
> +	return freq;
> +}
> +
> +static int adf4377_clk_set_rate(struct clk_hw *hw,
> +				unsigned long rate,
> +				unsigned long parent_rate)
> +{
> +	struct adf4377_state *st = to_adf4377_state(hw);
> +
> +	return adf4377_set_freq(st, rate);
> +}
> +
> +static int adf4377_clk_prepare(struct clk_hw *hw)
> +{
> +	struct adf4377_state *st = to_adf4377_state(hw);
> +
> +	return regmap_update_bits(st->regmap, 0x1a, ADF4377_001A_PD_CLKOUT1_MSK |
> +				  ADF4377_001A_PD_CLKOUT2_MSK,
> +				  FIELD_PREP(ADF4377_001A_PD_CLKOUT1_MSK, 0) |
> +				  FIELD_PREP(ADF4377_001A_PD_CLKOUT2_MSK, 0));
> +}
> +
> +static void adf4377_clk_unprepare(struct clk_hw *hw)
> +{
> +	struct adf4377_state *st = to_adf4377_state(hw);
> +
> +	regmap_update_bits(st->regmap, 0x1a, ADF4377_001A_PD_CLKOUT1_MSK |
> +			   ADF4377_001A_PD_CLKOUT2_MSK,
> +			   FIELD_PREP(ADF4377_001A_PD_CLKOUT1_MSK, 1) |
> +			   FIELD_PREP(ADF4377_001A_PD_CLKOUT2_MSK, 1));
> +}
> +
> +static int adf4377_clk_is_enabled(struct clk_hw *hw)
> +{
> +	struct adf4377_state *st = to_adf4377_state(hw);
> +	unsigned int readval;
> +	int ret;
> +
> +	ret = regmap_read(st->regmap, 0x1a, &readval);
> +	if (ret)
> +		return ret;
> +
> +	return !(readval & (ADF4377_001A_PD_CLKOUT1_MSK | ADF4377_001A_PD_CLKOUT2_MSK));
> +}
> +
> +static const struct clk_ops adf4377_clk_ops = {
> +	.recalc_rate = adf4377_clk_recalc_rate,
> +	.set_rate = adf4377_clk_set_rate,
> +	.prepare = adf4377_clk_prepare,
> +	.unprepare = adf4377_clk_unprepare,
> +	.is_enabled = adf4377_clk_is_enabled,
> +};
> +
> +static int adf4377_clk_register(struct adf4377_state *st)
> +{
> +	struct spi_device *spi = st->spi;
> +	struct clk_init_data init;
> +	struct clk *clk;
> +	const char *parent_name;
> +	int ret;
> +
> +	if (!device_property_present(&spi->dev, "#clock-cells"))
> +		return 0;
> +
> +	if (device_property_read_string(&spi->dev, "clock-output-names", &init.name)) {
> +		init.name = devm_kasprintf(&spi->dev, GFP_KERNEL, "%s-clk",
> +					   fwnode_get_name(dev_fwnode(&spi->dev)));
> +		if (!init.name)
> +			return -ENOMEM;
> +	}
> +
> +	parent_name = of_clk_get_parent_name(spi->dev.of_node, 0);
> +	if (!parent_name)
> +		return -EINVAL;
> +
> +	init.ops = &adf4377_clk_ops;
> +	init.parent_names = &parent_name;
> +	init.num_parents = 1;
> +	init.flags = CLK_SET_RATE_PARENT;
> +
> +	st->hw.init = &init;
> +	clk = devm_clk_register(&spi->dev, &st->hw);
> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);
> +
> +	st->clk = clk;
> +
> +	ret = of_clk_add_provider(spi->dev.of_node, of_clk_src_simple_get, clk);
> +	if (ret)
> +		return ret;
> +
> +	st->clkout = clk;
> +
> +	return devm_add_action_or_reset(&spi->dev, adf4377_clk_del_provider, st);
> +}
> +
>  static const struct adf4377_chip_info adf4377_chip_info = {
>  	.name = "adf4377",
>  	.has_gpio_enclk2 = true,
> @@ -958,8 +1078,6 @@ static int adf4377_probe(struct spi_device *spi)
>  
>  	indio_dev->info = &adf4377_info;
>  	indio_dev->name = "adf4377";
> -	indio_dev->channels = adf4377_channels;
> -	indio_dev->num_channels = ARRAY_SIZE(adf4377_channels);
>  
>  	st->regmap = regmap;
>  	st->spi = spi;
> @@ -979,6 +1097,15 @@ static int adf4377_probe(struct spi_device *spi)
>  	if (ret)
>  		return ret;
>  
> +	ret = adf4377_clk_register(st);
> +	if (ret)
> +		return ret;
> +
> +	if (!st->clkout) {
> +		indio_dev->channels = adf4377_channels;
> +		indio_dev->num_channels = ARRAY_SIZE(adf4377_channels);

Why register a channel free iio device? Probably better to just not register
it at all in this path.

> +	}
> +
>  	return devm_iio_device_register(&spi->dev, indio_dev);
>  }
>  


