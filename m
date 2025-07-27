Return-Path: <linux-iio+bounces-22037-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E94AAB12F75
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 14:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60964176FDD
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 12:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E952135DD;
	Sun, 27 Jul 2025 12:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T/arjZke"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9A486329;
	Sun, 27 Jul 2025 12:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753619367; cv=none; b=Bm9DRtuFEw5LQZs0jbbjqjFrOt10t3fVMfVqe/dPzkrFsnxyM9Dt+iI7+jCHL/LX0ZCvPoWvEmf8L6ubrL+iAXpiDCr2ocbfpmSRI9zYpTjTITQuo19yMlh5sV6NaWuR/LbWsTPxxy1836A6PK8Ha3yMFqz8in+ckTRggnb0sD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753619367; c=relaxed/simple;
	bh=tMd4CZJTltaQuHDXkARYYaauBeKUx1e3VzDgy/Lq9/k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dSjAbP5z7sn9z7w31QzeUxTRjQllWy4eKcQ38kyYEnDFJR97QeHsR0fKLa56Sbuf8k2Us9z78YvYiRuyStClGzFTvmu47rqFPqbwAukDybtjYxWdRrn4B9eX5Go6NlA7Gz8dD0f9mtN1MG4CG7ZdIkuTE9HR5xpq18qwnbwD+bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T/arjZke; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92950C4CEEB;
	Sun, 27 Jul 2025 12:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753619366;
	bh=tMd4CZJTltaQuHDXkARYYaauBeKUx1e3VzDgy/Lq9/k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T/arjZkeni9bFV5ALp2u7z92w2BmtA9vvb9Vz1FbTjEtHy+SSKeEM7Irh4dvnVgHQ
	 q7nOqPmld+opBjk+fI5WjF1wNsPGvQ5lYEWnXmelxBb0wxgh0fxoK0G+1WZzSJdqil
	 7GD0Vc2IuvkKymaJ02xnwwTLhg67yHXzxAWhxuLtSmP5AE6aypdkLtcif8KsEQ/BYv
	 OMqGRIPy8K8TFQdtL4ZGjQf4cWs9oTb9XKgyzYlVhci2XFnhitLMi/jm0x6haOowxk
	 +5sFGfdwX/7pBCEmP3Au8gTw0utB1H0hSv6EiVRnZrZc4Ih3tUvj7xW9FXyTjJMPPC
	 L3n1FKE6mNMlA==
Date: Sun, 27 Jul 2025 13:29:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] iio: adc: ad7124: add clock output support
Message-ID: <20250727132916.609755f4@jic23-huawei>
In-Reply-To: <20250724-iio-adc-ad7124-proper-clock-support-v1-4-88f35db2fcaf@baylibre.com>
References: <20250724-iio-adc-ad7124-proper-clock-support-v1-0-88f35db2fcaf@baylibre.com>
	<20250724-iio-adc-ad7124-proper-clock-support-v1-4-88f35db2fcaf@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Jul 2025 18:25:25 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Add support for the AD7124's internal clock output. If the #clock-cells
> property is present, turn on the internal clock output during probe.
> 
> If both the clocks and #clock-names properties are present (not allowed
> by devicetree bindings), assume that an external clock is being used so
> that we don't accidentally have two outputs fighting each other.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> 
> We could make this fancier and only turn on the output on demand of a
> clock consumer, but then we have to deal with locking of the SPI bus
> to be able to write to the register. So I opted for the simpler
> solution of always turning it on during probe. This would only be used
> for synchronizing with other similar ADCs, so implementing the functions
> for a more general-purpose clock seems a bit overkill.
Seems reasonable.  One comment inline.
> ---
>  drivers/iio/adc/ad7124.c | 35 ++++++++++++++++++++++++++++++++---
>  1 file changed, 32 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> index b0b03f838eed730347a3afcd759be7c1a8ab201e..b18229ff037596c6e98e12dc22b1552bf13fdc4e 100644
> --- a/drivers/iio/adc/ad7124.c
> +++ b/drivers/iio/adc/ad7124.c
> @@ -7,6 +7,7 @@
>  #include <linux/bitfield.h>
>  #include <linux/bitops.h>
>  #include <linux/clk.h>
> +#include <linux/clk-provider.h>
>  #include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/err.h>
> @@ -125,10 +126,12 @@ static const unsigned int ad7124_reg_size[] = {
>  	3, 3, 3, 3, 3
>  };
>  
> +#define AD7124_INT_CLK_HZ 614400
> +
>  static const int ad7124_master_clk_freq_hz[3] = {
> -	[AD7124_LOW_POWER] = 76800,
> -	[AD7124_MID_POWER] = 153600,
> -	[AD7124_FULL_POWER] = 614400,
> +	[AD7124_LOW_POWER] = AD7124_INT_CLK_HZ / 8,
> +	[AD7124_MID_POWER] = AD7124_INT_CLK_HZ / 4,
> +	[AD7124_FULL_POWER] = AD7124_INT_CLK_HZ,
>  };
>  
>  static const char * const ad7124_ref_names[] = {
> @@ -1163,6 +1166,32 @@ static int ad7124_setup(struct ad7124_state *st)
>  		}
>  
>  		clk_sel = AD7124_ADC_CONTROL_CLK_SEL_INT;
> +	} else if (!device_property_present(dev, "clocks") &&
> +		   device_property_present(dev, "clock-names")) {
> +		struct clk_hw *clk_hw;
> +		char *name;
> +
> +		name = devm_kasprintf(dev, GFP_KERNEL, "%s-clk",
> +				      fwnode_get_name(dev_fwnode(dev)));

I think for anything that isn't const the clock core will copy the name
during registration.  Ultimately __clk_register()
https://elixir.bootlin.com/linux/v6.15.8/source/drivers/clk/clk.c#L4342

As such tying this to devm lifespans is excessive.  Should be fine
using a __free(kfree) to clean it up at the end of this scope.

> +		if (!name)
> +			return -ENOMEM;
> +
> +		clk_hw = devm_clk_hw_register_fixed_rate(dev, name, NULL, 0,
> +							 AD7124_INT_CLK_HZ);
> +		if (IS_ERR(clk_hw))
> +			return dev_err_probe(dev, PTR_ERR(clk_hw), "Failed to register clock provider\n");
> +
> +		ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get,
> +						  clk_hw);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "Failed to add clock provider\n");
> +
> +		/*
> +		 * Treat the clock as always on. This way we don't have to deal
> +		 * with someone trying to enable/disable the clock while we are
> +		 * reading samples.
> +		 */
> +		clk_sel = AD7124_ADC_CONTROL_CLK_SEL_INT_OUT;
>  	} else {
>  		struct clk *clk;
>  
> 


