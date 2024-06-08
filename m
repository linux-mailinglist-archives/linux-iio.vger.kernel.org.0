Return-Path: <linux-iio+bounces-6080-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7764A90131A
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 19:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F34B1F21BD1
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 17:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584C31C698;
	Sat,  8 Jun 2024 17:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vO+NfRKx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F06817740;
	Sat,  8 Jun 2024 17:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717869008; cv=none; b=bYyt5JWjoFNDdfPx+zmlHIRpcXH4i6Z9tp4Ob6DrL3uggP15RpHPaH59GjfDhKtus1PLm8Nb03z5aklKbOziEOv8jq0N3u+7TuNB6V64mj9ClJTWlvQfoz2jM+6RpWPeijIOhwVNg/cxaoc+yQDBClc293gy4vcrjXVWLClxEk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717869008; c=relaxed/simple;
	bh=6IdIe5e9L/tLGAyZxslwT/zaYAAu/18SjMHGxfidCDk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r6W3mdGlAd/Js7YSdEU5JHsLGU0Cm7c/4T7E2GE5yjbwAESV0J0gEXDRuMRA7P/KoFVCAf6lrQvoOkxgG1tpz/NZsOv2FKkkyqb+zTGBVfM+phHrN2jqIk+it4Io5CrSdyHhXq1e7l2Qcg+BrMaZJ/xOzZoC8Yt+a1HCLYbK5bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vO+NfRKx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7A72C2BD11;
	Sat,  8 Jun 2024 17:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717869007;
	bh=6IdIe5e9L/tLGAyZxslwT/zaYAAu/18SjMHGxfidCDk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vO+NfRKx6WHMBvmBVpGJOkeJQ5xmi0o/YNJ57GZ72gf09/E9mXE1+BnPvPeDKp+oM
	 /faI739wzd4a1W9FM4RMFaTc5wfak0OmIOajyS5zOhxV2uHtG1w1Y6UiDGeKYX4lPr
	 T73j4GJZi3sd1ONVSQxo5UWdfiyA/+b/ugmCFa0OmBSjW89TbcToFhOZKfnVe0kE1w
	 XMlFETJH5hg0m39lCvPQbb3ZK1/MpYLMCR49vd/+cDYJtO36y14bEBXVgK5QFeHLy6
	 TvDmEJaWLeYwE2t6cp2mtLRk2AA7MmffJgeBDdgdFGaXZ8X1pmGs4q9Hw9QlYbBCji
	 lfkBsldfG+Z2Q==
Date: Sat, 8 Jun 2024 18:49:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: Alisa-Dariana Roman <alisa.roman@analog.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Michael Hennerich
 <michael.hennerich@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Alexandru Tachici
 <alexandru.tachici@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 3/3] iio: adc: ad7192: Fix clock config
Message-ID: <20240608184958.1c38516a@jic23-huawei>
In-Reply-To: <20240605075154.625123-3-alisa.roman@analog.com>
References: <20240605075154.625123-1-alisa.roman@analog.com>
	<20240605075154.625123-3-alisa.roman@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  5 Jun 2024 10:51:54 +0300
Alisa-Dariana Roman <alisadariana@gmail.com> wrote:

> There are actually 4 configuration modes of clock source for AD719X
> devices. Either a crystal can be attached externally between MCLK1 and
> MCLK2 pins, or an external CMOS-compatible clock can drive the MCLK2
> pin. The other 2 modes make use of the 4.92MHz internal clock, which can
> be made available on the MCLK2 pin.
> 
> Rename mclk to ext_clk for clarity.
> 
> Note that the fix tag is for the commit that moved the driver out of
> staging.
> 
> Fixes: b581f748cce0 ("staging: iio: adc: ad7192: move out of staging")
> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
A few comments inline.

> ---
>  drivers/iio/adc/ad7192.c | 153 ++++++++++++++++++++++++++++++---------
>  1 file changed, 119 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> index f06cb7ac4b42..75b0724142b1 100644
> --- a/drivers/iio/adc/ad7192.c
> +++ b/drivers/iio/adc/ad7192.c
> @@ -8,6 +8,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/bitfield.h>
>  #include <linux/clk.h>
> +#include <linux/clk-provider.h>
>  #include <linux/device.h>
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
> @@ -202,7 +203,8 @@ struct ad7192_state {
>  	const struct ad7192_chip_info	*chip_info;
>  	struct regulator		*avdd;
>  	struct regulator		*vref;
> -	struct clk			*mclk;
> +	struct clk			*ext_clk;
> +	struct clk_hw			int_clk_hw;
>  	u16				int_vref_mv;
>  	u32				aincom_mv;
>  	u32				fclk;
> @@ -398,27 +400,6 @@ static inline bool ad7192_valid_external_frequency(u32 freq)
>  		freq <= AD7192_EXT_FREQ_MHZ_MAX);
>  }
>

> +
> +static const struct clk_ops ad7192_int_clk_ops = {
> +	.recalc_rate = ad7192_clk_recalc_rate,
> +	.is_enabled = ad7192_clk_output_is_enabled,
> +	.prepare = ad7192_clk_prepare,
> +	.unprepare = ad7192_clk_unprepare,
> +};
> +
> +static int ad7192_register_clk_provider(struct iio_dev *indio_dev)
As Nuno pointed out - new feature, separate patch.

> +{
> +	struct ad7192_state *st = iio_priv(indio_dev);
> +	struct device *dev = indio_dev->dev.parent;
> +	struct fwnode_handle *fwnode = dev_fwnode(dev);
> +	struct clk_init_data init = {};
> +	int ret;
> +
> +	if (!IS_ENABLED(CONFIG_COMMON_CLK))
> +		return 0;
> +
> +	init.name = fwnode_get_name(fwnode);
> +	init.ops = &ad7192_int_clk_ops;
> +
> +	st->int_clk_hw.init = &init;
> +	ret = devm_clk_hw_register(dev, &st->int_clk_hw);
> +	if (ret)
> +		return ret;
> +
> +	return devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get,
> +					   &st->int_clk_hw);
> +}
> +
>  static int ad7192_probe(struct spi_device *spi)
>  {
>  	struct device *dev = &spi->dev;
> @@ -1312,20 +1383,34 @@ static int ad7192_probe(struct spi_device *spi)
>  
>  	st->fclk = AD7192_INT_FREQ_MHZ;
>  
> -	st->mclk = devm_clk_get_optional_enabled(dev, "mclk");
> -	if (IS_ERR(st->mclk))
> -		return PTR_ERR(st->mclk);
> +	ret = device_property_match_property_string(dev, "clock-names",
> +						    ad7192_clock_names,
> +						    ARRAY_SIZE(ad7192_clock_names));
> +	if (ret < 0) {
> +		st->clock_sel = AD7192_CLK_INT;
> +		st->fclk = AD7192_INT_FREQ_MHZ;
>  
> -	st->clock_sel = ad7192_clock_select(st);
> +		ret = ad7192_register_clk_provider(indio_dev);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Registration of clock provider failed\n");
> +	} else {
> +		st->clock_sel = AD7192_CLK_EXT_MCLK1_2 + ret;
>  
> -	if (st->clock_sel == AD7192_CLK_EXT_MCLK1_2 ||
> -	    st->clock_sel == AD7192_CLK_EXT_MCLK2) {
> -		st->fclk = clk_get_rate(st->mclk);
> -		if (!ad7192_valid_external_frequency(st->fclk)) {
> -			dev_err(dev,
> -				"External clock frequency out of bounds\n");
> -			return -EINVAL;
> -		}
> +		st->ext_clk = devm_clk_get_enabled(dev, ad7192_clock_names[ret]);
> +		if (IS_ERR(st->ext_clk))
> +			return PTR_ERR(st->ext_clk);
> +
> +		ret = devm_add_action_or_reset(dev,
> +					       ad7192_clk_disable_unprepare,

I'm confused. Why do you need this if using devm_clk_get_enabled()?
I'd assume that did this for you.

> +					       st->ext_clk);
> +		if (ret)
> +			return ret;
> +
> +		st->fclk = clk_get_rate(st->ext_clk);
> +		if (!ad7192_valid_external_frequency(st->fclk))
> +			return dev_err_probe(dev, -EINVAL,
> +					     "External clock frequency out of bounds\n");
>  	}
>  
>  	ret = ad7192_setup(indio_dev, dev);


