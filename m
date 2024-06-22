Return-Path: <linux-iio+bounces-6725-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7599135BB
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2024 20:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A79E1F21F59
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2024 18:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A017D39851;
	Sat, 22 Jun 2024 18:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gxb+vuVf"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1B81C294;
	Sat, 22 Jun 2024 18:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719082227; cv=none; b=OLQOb7CIAQkePi65L0MEEKNRvt0p3/SjJxZtOkGL0gkN/3mANB03zeOrO3UU/GDL6AvM0fxbgoN5AWcWgedCYMauCOfD+4rdEHughr0Ldh2SSVWUZ5RKKPYENVynP5Gz1rWhNu6Dxg51q45X6zUseatgMT33PXEfADbwl3Fr4Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719082227; c=relaxed/simple;
	bh=hjpL8sBLRmDXwQAkwY/Az+tIeeHDtbnbJXHCvXbMkMY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OY8mIp1WDRhAOfAMCJBktf3fPVT1sO4FO5f5kEOd9AIQBZeWz81rQanb5RGHRQf3nVW/gp8LOiU2dnwtmwZ33HwH7/bJWsCasle2zffMKg3FuzuoTtSuqsceSatS06nXYYyIvEiaPvz/4K+kRyLXkmiSnqDJVHW441rDUn8Ta5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gxb+vuVf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE5DC3277B;
	Sat, 22 Jun 2024 18:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719082226;
	bh=hjpL8sBLRmDXwQAkwY/Az+tIeeHDtbnbJXHCvXbMkMY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gxb+vuVfi1dbrSqTeE1jSoDW2CVkMqhNgCvMoayI/UmTdAgMQyl/6bf7fVWfWqjsc
	 +v1tSEwhPdBCQRLdVOcQVOuwS8q9UGZAhEyj/xR20eUrybNqvcQ/eIY1GFkFVkVmto
	 6T0rSKhqwudppSgVS13Bap9DA+uiP37tBmwd1muQ5qxyPf5+avobrJvhxtnuhKviC+
	 HtuVdzsz1tUwHbRcOT9xNoMugSy5u411k1chgvcSlUJj0TW84dHFLt1dYfNIfQtAid
	 dYmwDBDRWp2R8zEW6t4761Y1hSyfALQZm9rXbjzVV2oALUVClrUxzABxQFXzdAmVGr
	 2K7gZ+MYcbl+w==
Date: Sat, 22 Jun 2024 19:50:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, <linux-clk@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v6 2/2] iio: frequency: adf4350: add clk provider
Message-ID: <20240622195018.587997ae@jic23-huawei>
In-Reply-To: <20240621121403.47912-2-antoniu.miclaus@analog.com>
References: <20240621121403.47912-1-antoniu.miclaus@analog.com>
	<20240621121403.47912-2-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Jun 2024 15:13:59 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add clk provider feature for the adf4350.
> 
> Even though the driver was sent as an IIO driver in most cases the
> device is actually seen as a clock provider.
> 
> This patch aims to cover actual usecases requested by users in order to
> completely control the output frequencies from userspace.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
You addressed both of Nuno's comments and I didn't have anything to add,
 so I'll pick this up (can still add a tag though if Nuno wants to give one).

Series applied to the togreg branch of iio.git and pushed out as testing
for 0-day to have fun.

Thanks,

Jonathan

> ---
> changes in v6:
>  - rework `init.name` handling.
>  - simplify iio channels initialization.
>  drivers/iio/frequency/adf4350.c | 124 +++++++++++++++++++++++++++++++-
>  1 file changed, 122 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4350.c
> index 4abf80f75ef5..e13e64a5164c 100644
> --- a/drivers/iio/frequency/adf4350.c
> +++ b/drivers/iio/frequency/adf4350.c
> @@ -19,6 +19,7 @@
>  #include <linux/gpio/consumer.h>
>  #include <asm/div64.h>
>  #include <linux/clk.h>
> +#include <linux/clk-provider.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> @@ -36,6 +37,9 @@ struct adf4350_state {
>  	struct gpio_desc		*lock_detect_gpiod;
>  	struct adf4350_platform_data	*pdata;
>  	struct clk			*clk;
> +	struct clk			*clkout;
> +	const char			*clk_out_name;
> +	struct clk_hw			hw;
>  	unsigned long			clkin;
>  	unsigned long			chspc; /* Channel Spacing */
>  	unsigned long			fpfd; /* Phase Frequency Detector */
> @@ -61,6 +65,8 @@ struct adf4350_state {
>  	__be32				val __aligned(IIO_DMA_MINALIGN);
>  };
>  
> +#define to_adf4350_state(_hw) container_of(_hw, struct adf4350_state, hw)
> +
>  static struct adf4350_platform_data default_pdata = {
>  	.channel_spacing = 10000,
>  	.r2_user_settings = ADF4350_REG2_PD_POLARITY_POS |
> @@ -381,6 +387,113 @@ static const struct iio_info adf4350_info = {
>  	.debugfs_reg_access = &adf4350_reg_access,
>  };
>  
> +static void adf4350_clk_del_provider(void *data)
> +{
> +	struct adf4350_state *st = data;
> +
> +	of_clk_del_provider(st->spi->dev.of_node);
> +}
> +
> +static unsigned long adf4350_clk_recalc_rate(struct clk_hw *hw,
> +					     unsigned long parent_rate)
> +{
> +	struct adf4350_state *st = to_adf4350_state(hw);
> +	unsigned long long tmp;
> +
> +	tmp = (u64)(st->r0_int * st->r1_mod + st->r0_fract) * st->fpfd;
> +	do_div(tmp, st->r1_mod * (1 << st->r4_rf_div_sel));
> +
> +	return tmp;
> +}
> +
> +static int adf4350_clk_set_rate(struct clk_hw *hw,
> +				unsigned long rate,
> +				unsigned long parent_rate)
> +{
> +	struct adf4350_state *st = to_adf4350_state(hw);
> +
> +	if (parent_rate == 0 || parent_rate > ADF4350_MAX_FREQ_REFIN)
> +		return -EINVAL;
> +
> +	st->clkin = parent_rate;
> +
> +	return adf4350_set_freq(st, rate);
> +}
> +
> +static int adf4350_clk_prepare(struct clk_hw *hw)
> +{
> +	struct adf4350_state *st = to_adf4350_state(hw);
> +
> +	st->regs[ADF4350_REG2] &= ~ADF4350_REG2_POWER_DOWN_EN;
> +
> +	return adf4350_sync_config(st);
> +}
> +
> +static void adf4350_clk_unprepare(struct clk_hw *hw)
> +{
> +	struct adf4350_state *st = to_adf4350_state(hw);
> +
> +	st->regs[ADF4350_REG2] |= ADF4350_REG2_POWER_DOWN_EN;
> +
> +	adf4350_sync_config(st);
> +}
> +
> +static int adf4350_clk_is_enabled(struct clk_hw *hw)
> +{
> +	struct adf4350_state *st = to_adf4350_state(hw);
> +
> +	return (st->regs[ADF4350_REG2] & ADF4350_REG2_POWER_DOWN_EN);
> +}
> +
> +static const struct clk_ops adf4350_clk_ops = {
> +	.recalc_rate = adf4350_clk_recalc_rate,
> +	.set_rate = adf4350_clk_set_rate,
> +	.prepare = adf4350_clk_prepare,
> +	.unprepare = adf4350_clk_unprepare,
> +	.is_enabled = adf4350_clk_is_enabled,
> +};
> +
> +static int adf4350_clk_register(struct adf4350_state *st)
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
> +	init.ops = &adf4350_clk_ops;
> +	init.parent_names = &parent_name;
> +	init.num_parents = 1;
> +	init.flags = CLK_SET_RATE_PARENT;
> +
> +	st->hw.init = &init;
> +	clk = devm_clk_register(&spi->dev, &st->hw);
> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);
> +
> +	ret = of_clk_add_provider(spi->dev.of_node, of_clk_src_simple_get, clk);
> +	if (ret)
> +		return ret;
> +
> +	st->clkout = clk;
> +
> +	return devm_add_action_or_reset(&spi->dev, adf4350_clk_del_provider, st);
> +}
> +
>  static struct adf4350_platform_data *adf4350_parse_dt(struct device *dev)
>  {
>  	struct adf4350_platform_data *pdata;
> @@ -522,8 +635,6 @@ static int adf4350_probe(struct spi_device *spi)
>  
>  	indio_dev->info = &adf4350_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> -	indio_dev->channels = &adf4350_chan;
> -	indio_dev->num_channels = 1;
>  
>  	mutex_init(&st->lock);
>  
> @@ -551,6 +662,15 @@ static int adf4350_probe(struct spi_device *spi)
>  			return ret;
>  	}
>  
> +	ret = adf4350_clk_register(st);
> +	if (ret)
> +		return ret;
> +
> +	if (!st->clkout) {
> +		indio_dev->channels = &adf4350_chan;
> +		indio_dev->num_channels = 1;
> +	}
> +
>  	ret = devm_add_action_or_reset(&spi->dev, adf4350_power_down, indio_dev);
>  	if (ret)
>  		return dev_err_probe(&spi->dev, ret,


