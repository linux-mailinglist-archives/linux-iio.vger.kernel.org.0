Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9EB3D4CE4
	for <lists+linux-iio@lfdr.de>; Sun, 25 Jul 2021 11:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbhGYImO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sun, 25 Jul 2021 04:42:14 -0400
Received: from aposti.net ([89.234.176.197]:44272 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230272AbhGYImO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 25 Jul 2021 04:42:14 -0400
Date:   Sun, 25 Jul 2021 10:22:34 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v3 4/5] iio/adc: ingenic: add JZ4760B support to the sadc
 driver
To:     Christophe Branchereau <cbranchereau@gmail.com>
Cc:     jic23@kernel.org, lars@metafoo.de, linux-mips@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org, linux@roeck-us.net,
        contact@artur-rojek.eu
Message-Id: <MDNSWQ.IN488S2UMGEP1@crapouillou.net>
In-Reply-To: <20210724190449.221894-5-cbranchereau@gmail.com>
References: <20210724190449.221894-1-cbranchereau@gmail.com>
        <20210724190449.221894-5-cbranchereau@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Christophe,

Where did the
+ { .compatible = "ingenic,jz4760b-adc", .data = &jz4760_adc_soc_data },

go?

Cheers,
-Paul


Le sam., juil. 24 2021 at 21:04:48 +0200, Christophe Branchereau 
<cbranchereau@gmail.com> a écrit :
> The JZ4760B variant differs slightly from the JZ4760: it has a bit 
> called VBAT_SEL in the CFG register.
> 
> In order to correctly sample the battery voltage on existing 
> handhelds using this SOC, the bit must be cleared.
> 
> We leave the possibility to set the bit, by using the 
> "ingenic,use-internal-divider" in the devicetree.
> 
> Signed-off-by: Christophe Branchereau <cbranchereau@gmail.com>
> ---
>  drivers/iio/adc/ingenic-adc.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/iio/adc/ingenic-adc.c 
> b/drivers/iio/adc/ingenic-adc.c
> index 6b9af0530590..eaa8ab36183c 100644
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
> @@ -879,6 +880,14 @@ static int ingenic_adc_probe(struct 
> platform_device *pdev)
>  	/* Put hardware in a known passive state. */
>  	writeb(0x00, adc->base + JZ_ADC_REG_ENABLE);
>  	writeb(0xff, adc->base + JZ_ADC_REG_CTRL);
> +
> +	/* JZ4760B specific */
> +	if (device_property_present(dev, "ingenic,use-internal-divider"))
> +		ingenic_adc_set_config(adc, JZ_ADC_REG_CFG_VBAT_SEL,
> +					    JZ_ADC_REG_CFG_VBAT_SEL);
> +	else
> +		ingenic_adc_set_config(adc, JZ_ADC_REG_CFG_VBAT_SEL, 0);
> +
>  	usleep_range(2000, 3000); /* Must wait at least 2ms. */
>  	clk_disable(adc->clk);
> 
> --
> 2.30.2
> 


