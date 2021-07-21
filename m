Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68F873D164D
	for <lists+linux-iio@lfdr.de>; Wed, 21 Jul 2021 20:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238794AbhGURoF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Wed, 21 Jul 2021 13:44:05 -0400
Received: from aposti.net ([89.234.176.197]:48802 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236999AbhGURoE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 21 Jul 2021 13:44:04 -0400
Date:   Wed, 21 Jul 2021 19:24:29 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 4/6] iio/adc: ingenic: add JZ4760B support to the sadc
 driver
To:     citral23 <cbranchereau@gmail.com>
Cc:     jic23@kernel.org, lars@metafoo.de, linux-mips@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org, linux@roeck-us.net,
        contact@artur-rojek.eu
Message-Id: <TSXLWQ.2A9E0DYPFZ8Q1@crapouillou.net>
In-Reply-To: <20210721105317.36742-5-cbranchereau@gmail.com>
References: <20210721105317.36742-1-cbranchereau@gmail.com>
        <20210721105317.36742-5-cbranchereau@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Christophe,

Le mer., juil. 21 2021 at 12:53:15 +0200, citral23 
<cbranchereau@gmail.com> a écrit :
> The JZ4760B variant differs slightly from the JZ4760, in that it has 
> a bit called VBAT_SEL
> in the CFG register. In order to correctly sample the battery voltage 
> on existing handhelds
> using this SOC, the bit must be cleared.
> 
> We leave the possibility to set the bit, by using the 
> "ingenic,use-internal-divider" in the devicetree.
> 
> Signed-off-by: citral23 <cbranchereau@gmail.com>
> ---
>  drivers/iio/adc/ingenic-adc.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/iio/adc/ingenic-adc.c 
> b/drivers/iio/adc/ingenic-adc.c
> index 285e7aa8e37a..618150475421 100644
> --- a/drivers/iio/adc/ingenic-adc.c
> +++ b/drivers/iio/adc/ingenic-adc.c
> @@ -37,6 +37,7 @@
>  #define JZ_ADC_REG_CFG_SAMPLE_NUM(n)	((n) << 10)
>  #define JZ_ADC_REG_CFG_PULL_UP(n)	((n) << 16)
>  #define JZ_ADC_REG_CFG_CMD_SEL		BIT(22)
> +#define JZ_ADC_REG_CFG_VBAT_SEL		BIT(30)
>  #define JZ_ADC_REG_CFG_TOUCH_OPS_MASK	(BIT(31) | GENMASK(23, 10))
>  #define JZ_ADC_REG_ADCLK_CLKDIV_LSB	0
>  #define JZ4725B_ADC_REG_ADCLK_CLKDIV10US_LSB	16
> @@ -869,6 +870,10 @@ static int ingenic_adc_probe(struct 
> platform_device *pdev)
>  	/* Put hardware in a known passive state. */
>  	writeb(0x00, adc->base + JZ_ADC_REG_ENABLE);
>  	writeb(0xff, adc->base + JZ_ADC_REG_CTRL);
> +
> +	if (!device_property_present(dev, "ingenic,use-internal-divider")) 
> /* JZ4760B specific */
> +		ingenic_adc_set_config(adc, JZ_ADC_REG_CFG_VBAT_SEL, 0);

You miss an "else" part, no? Set the bit if the property is present, 
clear it if it is missing? You can't really rely on the reset value, 
since (e.g.) the bootloader could have changed it.

Cheers,
-Paul

> +
>  	usleep_range(2000, 3000); /* Must wait at least 2ms. */
>  	clk_disable(adc->clk);
> 
> @@ -896,6 +901,7 @@ static const struct of_device_id 
> ingenic_adc_of_match[] = {
>  	{ .compatible = "ingenic,jz4725b-adc", .data = 
> &jz4725b_adc_soc_data, },
>  	{ .compatible = "ingenic,jz4740-adc", .data = &jz4740_adc_soc_data, 
> },
>  	{ .compatible = "ingenic,jz4760-adc", .data = &jz4760_adc_soc_data, 
> },
> +	{ .compatible = "ingenic,jz4760b-adc", .data = 
> &jz4760_adc_soc_data, },
>  	{ .compatible = "ingenic,jz4770-adc", .data = &jz4770_adc_soc_data, 
> },
>  	{ },
>  };
> --
> 2.30.2
> 


