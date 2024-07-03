Return-Path: <linux-iio+bounces-7247-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5177292602D
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 14:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 839281C221D0
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 12:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594B9178CF1;
	Wed,  3 Jul 2024 12:22:06 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DD2170836;
	Wed,  3 Jul 2024 12:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720009326; cv=none; b=U6zj5KqprfpY+EhQNyENymP5dybWeSALcuqCGXECz2LvBPEdlBn7Lhc7wrA52+RdqGpAJCBZVbXZotCi8NDmtQw2qdCoXt7V7aPICn75dMfebsd2WwbPL2gsrSmydJwPEcSsq/40P3D5EAayjXZr+BMsJE2/Cs+8eq/VwfZnIQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720009326; c=relaxed/simple;
	bh=vYuco9/NSRpqebQ4mYUp/0sTq0aoO3JjDyeQJOZxcqs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gN4fa1LmimKXZFyT08WDq5IiYMVETjeD5FN2cHTaNzwFEEZMNCHVkMeiI7KIYO69opxr6IbBsQXPZm82YepUvxJXVYtPIlCDZiE2Py3/TPb1gQJUWZ0fHU6a9vhXpk4Aw3kKlGPTg8e/+CCCsPDF9bZ2RS21TN1u6z3STXs8aiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0FA3367;
	Wed,  3 Jul 2024 05:22:27 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 079283F766;
	Wed,  3 Jul 2024 05:21:54 -0700 (PDT)
Date: Wed, 3 Jul 2024 13:21:52 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Rob Herring <robh@kernel.org>, Saravana
 Kannan <saravanak@google.com>, Nathan Chancellor <nathan@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Tony Lindgren <tony@atomide.com>, Bjorn Andersson
 <andersson@kernel.org>, Emilio =?UTF-8?B?TMOzcGV6?= <emilio@elopez.com.ar>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Krzysztof Kozlowski
 <krzk@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas
 Gleixner <tglx@linutronix.de>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Jonathan
 Cameron <jic23@kernel.org>, Lee Jones <lee@kernel.org>, Shawn Guo
 <shawnguo@kernel.org>, Pengutronix Kernel Team <kernel@pengutronix.de>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Richard
 Leitner <richard.leitner@linux.dev>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, "Naveen N. Rao"
 <naveen.n.rao@linux.ibm.com>, Damien Le Moal <dlemoal@kernel.org>, "Peng
 Fan (OSS)" <peng.fan@oss.nxp.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, llvm@lists.linux.dev,
 linux-clk@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-samsung-soc@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-usb@vger.kernel.org, patches@opensource.cirrus.com,
 linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org
Subject: Re: [PATCH 04/20] clk: sunxi: clk-simple-gates: convert to
 of_property_for_each_u32_new()
Message-ID: <20240703132152.6c306a48@donnerap.manchester.arm.com>
In-Reply-To: <20240703-of_property_for_each_u32-v1-4-42c1fc0b82aa@bootlin.com>
References: <20240703-of_property_for_each_u32-v1-0-42c1fc0b82aa@bootlin.com>
	<20240703-of_property_for_each_u32-v1-4-42c1fc0b82aa@bootlin.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 03 Jul 2024 12:36:48 +0200
Luca Ceresoli <luca.ceresoli@bootlin.com> wrote:

> Simplify code using of_property_for_each_u32_new() as the two additional
> parameters in of_property_for_each_u32() are not used here.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  drivers/clk/sunxi/clk-simple-gates.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/sunxi/clk-simple-gates.c b/drivers/clk/sunxi/clk-simple-gates.c
> index 0399627c226a..a30d14937e0b 100644
> --- a/drivers/clk/sunxi/clk-simple-gates.c
> +++ b/drivers/clk/sunxi/clk-simple-gates.c
> @@ -21,11 +21,9 @@ static void __init sunxi_simple_gates_setup(struct device_node *node,
>  {
>  	struct clk_onecell_data *clk_data;
>  	const char *clk_parent, *clk_name;
> -	struct property *prop;
>  	struct resource res;
>  	void __iomem *clk_reg;
>  	void __iomem *reg;
> -	const __be32 *p;
>  	int number, i = 0, j;
>  	u8 clk_bit;
>  	u32 index;
> @@ -47,7 +45,7 @@ static void __init sunxi_simple_gates_setup(struct device_node *node,
>  	if (!clk_data->clks)
>  		goto err_free_data;
>  
> -	of_property_for_each_u32(node, "clock-indices", prop, p, index) {
> +	of_property_for_each_u32_new(node, "clock-indices", index) {
>  		of_property_read_string_index(node, "clock-output-names",
>  					      i, &clk_name);
>  
> 


