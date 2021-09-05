Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35278401059
	for <lists+linux-iio@lfdr.de>; Sun,  5 Sep 2021 16:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234859AbhIEOpX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Sep 2021 10:45:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:55682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232764AbhIEOpX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Sep 2021 10:45:23 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3BBA60E8B;
        Sun,  5 Sep 2021 14:44:14 +0000 (UTC)
Date:   Sun, 5 Sep 2021 15:47:36 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     <lars@metafoo.de>, <pmeerw@pmeerw.net>, <robh+dt@kernel.org>,
        <joel@jms.id.au>, <andrew@aj.id.au>, <p.zabel@pengutronix.de>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <BMC-SW@aspeedtech.com>
Subject: Re: [v5 11/15] iio: adc: aspeed: Fix the calculate error of clock.
Message-ID: <20210905154737.6c41bae0@jic23-huawei>
In-Reply-To: <20210831071458.2334-12-billy_tsai@aspeedtech.com>
References: <20210831071458.2334-1-billy_tsai@aspeedtech.com>
        <20210831071458.2334-12-billy_tsai@aspeedtech.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 31 Aug 2021 15:14:54 +0800
Billy Tsai <billy_tsai@aspeedtech.com> wrote:

> The ADC clock formula is
> ast2400/2500:
> ADC clock period = PCLK * 2 * (ADC0C[31:17] + 1) * (ADC0C[9:0] + 1)
> ast2600:
> ADC clock period = PCLK * 2 * (ADC0C[15:0] + 1)
> They all have one fixed divided 2 and the legacy driver didn't handle it.
> This patch register the fixed factory clock device as the parent of ADC
> clock scaler to fix this issue.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  drivers/iio/adc/aspeed_adc.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
> index 40b7ba58c1dc..349377b9fac0 100644
> --- a/drivers/iio/adc/aspeed_adc.c
> +++ b/drivers/iio/adc/aspeed_adc.c
> @@ -4,6 +4,12 @@
>   *
>   * Copyright (C) 2017 Google, Inc.
>   * Copyright (C) 2021 Aspeed Technology Inc.
> + *
> + * ADC clock formula:
> + * Ast2400/Ast2500:
> + * clock period = period of PCLK * 2 * (ADC0C[31:17] + 1) * (ADC0C[9:0] + 1)
> + * Ast2600:
> + * clock period = period of PCLK * 2 * (ADC0C[15:0] + 1)
>   */
>  
>  #include <linux/clk.h>
> @@ -85,6 +91,7 @@ struct aspeed_adc_data {
>  	struct regulator	*regulator;
>  	void __iomem		*base;
>  	spinlock_t		clk_lock;
> +	struct clk_hw		*fixed_div_clk;
>  	struct clk_hw		*clk_prescaler;
>  	struct clk_hw		*clk_scaler;
>  	struct reset_control	*rst;
> @@ -204,6 +211,13 @@ static void aspeed_adc_unregister_divider(void *data)
>  	clk_hw_unregister_divider(clk);
>  }
>  
> +static void aspeed_adc_unregister_fixed_divider(void *data)
> +{
> +	struct clk_hw *clk = data;
> +
> +	clk_hw_unregister_fixed_factor(clk);
> +}
> +
>  static void aspeed_adc_reset_assert(void *data)
>  {
>  	struct reset_control *rst = data;
> @@ -328,6 +342,19 @@ static int aspeed_adc_probe(struct platform_device *pdev)
>  	spin_lock_init(&data->clk_lock);
>  	snprintf(clk_parent_name, ARRAY_SIZE(clk_parent_name), "%s",
>  		 of_clk_get_parent_name(pdev->dev.of_node, 0));
> +	snprintf(clk_name, ARRAY_SIZE(clk_name), "%s-fixed-div",
> +		 data->model_data->model_name);
> +	data->fixed_div_clk = clk_hw_register_fixed_factor(
> +		&pdev->dev, clk_name, clk_parent_name, 0, 1, 2);

Obvious follow on from Philipp's review - there is a devm_ version of
this as well which you can use rather than rolling a custom version.
As a side note, I'm fairly sure you could refactor all those devm_clk_hw
functions to use devm_add_action_or_reset() internally and simplify that
code nicely.

A recent series did the same for all the similar functions in IIO.



> +	if (IS_ERR(data->fixed_div_clk))
> +		return PTR_ERR(data->fixed_div_clk);
> +
> +	ret = devm_add_action_or_reset(data->dev,
> +				       aspeed_adc_unregister_fixed_divider,
> +				       data->clk_prescaler);
> +	if (ret)
> +		return ret;
> +	snprintf(clk_parent_name, ARRAY_SIZE(clk_parent_name), clk_name);
>  
>  	if (data->model_data->need_prescaler) {
>  		snprintf(clk_name, ARRAY_SIZE(clk_name), "%s-prescaler",

