Return-Path: <linux-iio+bounces-6303-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DB9909881
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jun 2024 15:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89B8C1C20A5E
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jun 2024 13:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE1B487B3;
	Sat, 15 Jun 2024 13:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E4iswMTH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C1C17BB6;
	Sat, 15 Jun 2024 13:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718457908; cv=none; b=KfbNGBXJ+Z1oAmrJG1+eE4OOwbonlaBZBosbGX0nL4Z1OI0oi1yghooQZvtF6x6Ffrnl/PlAk0/eleb4v6vBX3NQ3IKsdB1sGNd8FO8zTJHB6egEhdrQPRmc99u98NHH+TGIXwrFpyP9Ysq8P4ts4O5GHuEiNCJ32R42UNTcJyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718457908; c=relaxed/simple;
	bh=6vSNzjSQjuW10B30p2NRLttVM3hWzQ9U82Rx6xKl34A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gEGDnrSliqmYcba0mW3UjW1TRhBq7pV3nposS25UsevGCDqw0w2M3NnztnpSVWCuZUse3c046wpm0+jaxNoeq8z4L7wP2VYpBVgb8Gj/7yOThUugWi1mgP13I9Mrxf5MoQtUBEsFjrD0ZvXNU1m1wAn0E4XMmIuLZZdDeuiF6hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E4iswMTH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F32C116B1;
	Sat, 15 Jun 2024 13:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718457907;
	bh=6vSNzjSQjuW10B30p2NRLttVM3hWzQ9U82Rx6xKl34A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E4iswMTHhBOLHpSbGeMk8Io1Ja2beMNsnXNIuG2CleO48/xUDPHL8uk2rG0eX2xK0
	 KSgwdzsY6T8Wdbc5e4SP35jVpTzMjB3mLg9nRzj5LFiGBDBICjBg8g6F1h/uiZ8Mxi
	 a4NnmqiewQwspdNqR4ICVthsi+jIIexXtYlc+gKmuavFI+fLmkd5y+ncj3TR6UBzwf
	 dlswHs90qLJtAgzKk8gEOvTbvcQ0VG9aievU46xH4nRHRcyeyjTaVpYqIOGeL6J8K0
	 eX/nC1+b/EkmZF/cVmc84eLl86HwYkBHP335E6tRwwUtxuBvhp2k3JNcd6XjumrTJd
	 SZ73nazFNk4GA==
Date: Sat, 15 Jun 2024 14:24:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, "Rob Herring" <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] iio: frequency: adf4350: add clk provider
Message-ID: <20240615142459.382ca77d@jic23-huawei>
In-Reply-To: <20240612130232.7692-2-antoniu.miclaus@analog.com>
References: <20240612130232.7692-1-antoniu.miclaus@analog.com>
	<20240612130232.7692-2-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Jun 2024 16:02:29 +0300
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

As Nuno reminded, this needs the clock maintainers in the loop

Trivial comments inline.

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
> +	init.name = devm_kasprintf(&spi->dev, GFP_KERNEL, "%s-clk",
> +				   fwnode_get_name(dev_fwnode(&spi->dev)));

Check for failure.

> +	device_property_read_string(&spi->dev, "clock-output-names",
> +				    &init.name);

Also check for failure.

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
> @@ -522,7 +646,6 @@ static int adf4350_probe(struct spi_device *spi)
>  
>  	indio_dev->info = &adf4350_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> -	indio_dev->channels = &adf4350_chan;
>  	indio_dev->num_channels = 1;
>  
>  	mutex_init(&st->lock);
> @@ -551,6 +674,15 @@ static int adf4350_probe(struct spi_device *spi)
>  			return ret;
>  	}
>  
> +	ret = adf4350_clk_register(st);
> +	if (ret)
> +		return ret;
> +
> +	if (st->clkout)
> +		indio_dev->channels = &adf4350_clk_chan;
> +	else
> +		indio_dev->channels = &adf4350_chan;
> +
>  	ret = devm_add_action_or_reset(&spi->dev, adf4350_power_down, indio_dev);
>  	if (ret)
>  		return dev_err_probe(&spi->dev, ret,


