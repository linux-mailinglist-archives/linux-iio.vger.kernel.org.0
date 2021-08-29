Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB1353FACA0
	for <lists+linux-iio@lfdr.de>; Sun, 29 Aug 2021 17:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235245AbhH2Pba (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Aug 2021 11:31:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:38304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231216AbhH2Pb3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 29 Aug 2021 11:31:29 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A7F860F45;
        Sun, 29 Aug 2021 15:30:32 +0000 (UTC)
Date:   Sun, 29 Aug 2021 16:33:46 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     <lars@metafoo.de>, <pmeerw@pmeerw.net>, <robh+dt@kernel.org>,
        <joel@jms.id.au>, <andrew@aj.id.au>, <p.zabel@pengutronix.de>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <BMC-SW@aspeedtech.com>
Subject: Re: [RESEND v4 11/15] iio: adc: aspeed: Fix the calculate error of
 clock.
Message-ID: <20210829163346.501fdb43@jic23-huawei>
In-Reply-To: <20210824091243.9393-12-billy_tsai@aspeedtech.com>
References: <20210824091243.9393-1-billy_tsai@aspeedtech.com>
        <20210824091243.9393-12-billy_tsai@aspeedtech.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 24 Aug 2021 17:12:39 +0800
Billy Tsai <billy_tsai@aspeedtech.com> wrote:

> The adc clcok formula is

clock

> ast2400/2500:
> ADC clock period = PCLK * 2 * (ADC0C[31:17] + 1) * (ADC0C[9:0] + 1)
> ast2600:
> ADC clock period = PCLK * 2 * (ADC0C[15:0] + 1)
> They all have one fixed divided 2 and the legacy driver didn't handle it.
> This patch register the fixed factory clock device as the parent of adc
> clock scaler to fix this issue.

What are the impacts of this being wrong before?  Is this something we
should look to backport?

Comment inline.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  drivers/iio/adc/aspeed_adc.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
> index ea3e9a52fcc9..8fe7da1a651f 100644
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
> @@ -77,6 +83,7 @@ struct aspeed_adc_data {
>  	struct regulator	*regulator;
>  	void __iomem		*base;
>  	spinlock_t		clk_lock;
> +	struct clk_hw		*fixed_div_clk;
>  	struct clk_hw		*clk_prescaler;
>  	struct clk_hw		*clk_scaler;
>  	struct reset_control	*rst;
> @@ -196,6 +203,13 @@ static void aspeed_adc_unregister_divider(void *data)
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
> @@ -312,6 +326,18 @@ static int aspeed_adc_probe(struct platform_device *pdev)
>  	/* Register ADC clock prescaler with source specified by device tree. */
>  	spin_lock_init(&data->clk_lock);
>  	snprintf(clk_parent_name, 32, of_clk_get_parent_name(pdev->dev.of_node, 0));
> +	snprintf(clk_name, 32, "%s-fixed-div", data->model_data->model_name);

ARRAY_SIZE

> +	data->fixed_div_clk = clk_hw_register_fixed_factor(
> +		&pdev->dev, clk_name, clk_parent_name, 0, 1, 2);
> +	if (IS_ERR(data->fixed_div_clk))
> +		return PTR_ERR(data->fixed_div_clk);
> +
> +	ret = devm_add_action_or_reset(data->dev,
> +				       aspeed_adc_unregister_fixed_divider,
> +				       data->clk_prescaler);
> +	if (ret)
> +		return ret;
> +	snprintf(clk_parent_name, 32, clk_name);
>  	if (data->model_data->need_prescaler) {
>  		snprintf(clk_name, 32, "%s-prescaler",
>  			 data->model_data->model_name);

