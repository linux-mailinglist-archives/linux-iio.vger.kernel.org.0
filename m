Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D75240102E
	for <lists+linux-iio@lfdr.de>; Sun,  5 Sep 2021 16:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbhIEO2k (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Sep 2021 10:28:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:51728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229566AbhIEO2k (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Sep 2021 10:28:40 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C6C760F3A;
        Sun,  5 Sep 2021 14:27:31 +0000 (UTC)
Date:   Sun, 5 Sep 2021 15:30:54 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     <lars@metafoo.de>, <pmeerw@pmeerw.net>, <robh+dt@kernel.org>,
        <joel@jms.id.au>, <andrew@aj.id.au>, <p.zabel@pengutronix.de>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <BMC-SW@aspeedtech.com>
Subject: Re: [v5 03/15] iio: adc: aspeed: completes the bitfield declare.
Message-ID: <20210905153054.56159999@jic23-huawei>
In-Reply-To: <20210831071458.2334-4-billy_tsai@aspeedtech.com>
References: <20210831071458.2334-1-billy_tsai@aspeedtech.com>
        <20210831071458.2334-4-billy_tsai@aspeedtech.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 31 Aug 2021 15:14:46 +0800
Billy Tsai <billy_tsai@aspeedtech.com> wrote:

> This patch completes the declare of ADC register bitfields and uses the
> same prefix ASPEED_ADC_* for these bitfields. In addition, tidy up space
> alignment of the codes.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
LGTM

Applied to the togreg branch of iio.git.

Note this won't be going out as non rebasing for a while yet (given mid merge window)
so if anyone else has time to look at this that would be much appreciated!

Jonathan

> ---
>  drivers/iio/adc/aspeed_adc.c | 64 ++++++++++++++++++++++++++----------
>  1 file changed, 47 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
> index 34ec0c28b2df..f055fe7b2c40 100644
> --- a/drivers/iio/adc/aspeed_adc.c
> +++ b/drivers/iio/adc/aspeed_adc.c
> @@ -3,6 +3,7 @@
>   * Aspeed AST2400/2500 ADC
>   *
>   * Copyright (C) 2017 Google, Inc.
> + * Copyright (C) 2021 Aspeed Technology Inc.
>   */
>  
>  #include <linux/clk.h>
> @@ -16,6 +17,7 @@
>  #include <linux/reset.h>
>  #include <linux/spinlock.h>
>  #include <linux/types.h>
> +#include <linux/bitfield.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/driver.h>
> @@ -28,15 +30,39 @@
>  #define ASPEED_REG_INTERRUPT_CONTROL	0x04
>  #define ASPEED_REG_VGA_DETECT_CONTROL	0x08
>  #define ASPEED_REG_CLOCK_CONTROL	0x0C
> -#define ASPEED_REG_MAX			0xC0
> -
> -#define ASPEED_OPERATION_MODE_POWER_DOWN	(0x0 << 1)
> -#define ASPEED_OPERATION_MODE_STANDBY		(0x1 << 1)
> -#define ASPEED_OPERATION_MODE_NORMAL		(0x7 << 1)
> -
> -#define ASPEED_ENGINE_ENABLE		BIT(0)
> -
> -#define ASPEED_ADC_CTRL_INIT_RDY	BIT(8)
> +#define ASPEED_REG_COMPENSATION_TRIM	0xC4
> +/*
> + * The register offset between 0xC8~0xCC can be read and won't affect the
> + * hardware logic in each version of ADC.
> + */
> +#define ASPEED_REG_MAX			0xD0
> +
> +#define ASPEED_ADC_ENGINE_ENABLE		BIT(0)
> +#define ASPEED_ADC_OP_MODE			GENMASK(3, 1)
> +#define ASPEED_ADC_OP_MODE_PWR_DOWN		0
> +#define ASPEED_ADC_OP_MODE_STANDBY		1
> +#define ASPEED_ADC_OP_MODE_NORMAL		7
> +#define ASPEED_ADC_CTRL_COMPENSATION		BIT(4)
> +#define ASPEED_ADC_AUTO_COMPENSATION		BIT(5)
> +/*
> + * Bit 6 determines not only the reference voltage range but also the dividing
> + * circuit for battery sensing.
> + */
> +#define ASPEED_ADC_REF_VOLTAGE			GENMASK(7, 6)
> +#define ASPEED_ADC_REF_VOLTAGE_2500mV		0
> +#define ASPEED_ADC_REF_VOLTAGE_1200mV		1
> +#define ASPEED_ADC_REF_VOLTAGE_EXT_HIGH		2
> +#define ASPEED_ADC_REF_VOLTAGE_EXT_LOW		3
> +#define ASPEED_ADC_BAT_SENSING_DIV		BIT(6)
> +#define ASPEED_ADC_BAT_SENSING_DIV_2_3		0
> +#define ASPEED_ADC_BAT_SENSING_DIV_1_3		1
> +#define ASPEED_ADC_CTRL_INIT_RDY		BIT(8)
> +#define ASPEED_ADC_CH7_MODE			BIT(12)
> +#define ASPEED_ADC_CH7_NORMAL			0
> +#define ASPEED_ADC_CH7_BAT			1
> +#define ASPEED_ADC_BAT_SENSING_ENABLE		BIT(13)
> +#define ASPEED_ADC_CTRL_CHANNEL			GENMASK(31, 16)
> +#define ASPEED_ADC_CTRL_CHANNEL_ENABLE(ch)	FIELD_PREP(ASPEED_ADC_CTRL_CHANNEL, BIT(ch))
>  
>  #define ASPEED_ADC_INIT_POLLING_TIME	500
>  #define ASPEED_ADC_INIT_TIMEOUT		500000
> @@ -227,7 +253,9 @@ static int aspeed_adc_probe(struct platform_device *pdev)
>  
>  	if (model_data->wait_init_sequence) {
>  		/* Enable engine in normal mode. */
> -		writel(ASPEED_OPERATION_MODE_NORMAL | ASPEED_ENGINE_ENABLE,
> +		writel(FIELD_PREP(ASPEED_ADC_OP_MODE,
> +				  ASPEED_ADC_OP_MODE_NORMAL) |
> +			       ASPEED_ADC_ENGINE_ENABLE,
>  		       data->base + ASPEED_REG_ENGINE_CONTROL);
>  
>  		/* Wait for initial sequence complete. */
> @@ -246,10 +274,12 @@ static int aspeed_adc_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto clk_enable_error;
>  
> -	adc_engine_control_reg_val = GENMASK(31, 16) |
> -		ASPEED_OPERATION_MODE_NORMAL | ASPEED_ENGINE_ENABLE;
> +	adc_engine_control_reg_val =
> +		ASPEED_ADC_CTRL_CHANNEL |
> +		FIELD_PREP(ASPEED_ADC_OP_MODE, ASPEED_ADC_OP_MODE_NORMAL) |
> +		ASPEED_ADC_ENGINE_ENABLE;
>  	writel(adc_engine_control_reg_val,
> -		data->base + ASPEED_REG_ENGINE_CONTROL);
> +	       data->base + ASPEED_REG_ENGINE_CONTROL);
>  
>  	model_data = of_device_get_match_data(&pdev->dev);
>  	indio_dev->name = model_data->model_name;
> @@ -265,8 +295,8 @@ static int aspeed_adc_probe(struct platform_device *pdev)
>  	return 0;
>  
>  iio_register_error:
> -	writel(ASPEED_OPERATION_MODE_POWER_DOWN,
> -		data->base + ASPEED_REG_ENGINE_CONTROL);
> +	writel(FIELD_PREP(ASPEED_ADC_OP_MODE, ASPEED_ADC_OP_MODE_PWR_DOWN),
> +	       data->base + ASPEED_REG_ENGINE_CONTROL);
>  	clk_disable_unprepare(data->clk_scaler->clk);
>  clk_enable_error:
>  poll_timeout_error:
> @@ -284,8 +314,8 @@ static int aspeed_adc_remove(struct platform_device *pdev)
>  	struct aspeed_adc_data *data = iio_priv(indio_dev);
>  
>  	iio_device_unregister(indio_dev);
> -	writel(ASPEED_OPERATION_MODE_POWER_DOWN,
> -		data->base + ASPEED_REG_ENGINE_CONTROL);
> +	writel(FIELD_PREP(ASPEED_ADC_OP_MODE, ASPEED_ADC_OP_MODE_PWR_DOWN),
> +	       data->base + ASPEED_REG_ENGINE_CONTROL);
>  	clk_disable_unprepare(data->clk_scaler->clk);
>  	reset_control_assert(data->rst);
>  	clk_hw_unregister_divider(data->clk_scaler);

