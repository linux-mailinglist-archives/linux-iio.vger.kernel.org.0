Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 738903D3D56
	for <lists+linux-iio@lfdr.de>; Fri, 23 Jul 2021 18:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbhGWPfv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Jul 2021 11:35:51 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3475 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbhGWPfu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Jul 2021 11:35:50 -0400
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GWZ2z62Z0z6H71x;
        Sat, 24 Jul 2021 00:07:23 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 23 Jul 2021 18:16:22 +0200
Received: from localhost (10.210.170.238) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Fri, 23 Jul
 2021 17:16:21 +0100
Date:   Fri, 23 Jul 2021 17:15:58 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Christophe Branchereau <cbranchereau@gmail.com>
CC:     <paul@crapouillou.net>, <jic23@kernel.org>, <lars@metafoo.de>,
        <linux-mips@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux@roeck-us.net>,
        <contact@artur-rojek.eu>
Subject: Re: [PATCH V2 4/5] iio/adc: ingenic: add JZ4760B support to the
 sadc driver
Message-ID: <20210723171558.00005383@Huawei.com>
In-Reply-To: <20210723085813.1523934-5-cbranchereau@gmail.com>
References: <893d6165-0f12-d0da-44be-449a4ae96ac2@roeck-us.net>
        <20210723085813.1523934-1-cbranchereau@gmail.com>
        <20210723085813.1523934-5-cbranchereau@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.170.238]
X-ClientProxiedBy: lhreml704-chm.china.huawei.com (10.201.108.53) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 23 Jul 2021 10:58:12 +0200
Christophe Branchereau <cbranchereau@gmail.com> wrote:

> The JZ4760B variant differs slightly from the JZ4760: it has a bit called 
> VBAT_SEL in the CFG register.
> 
> In order to correctly sample the battery voltage on existing handhelds 
> using this SOC, the bit must be cleared.
> 
> We leave the possibility to set the bit, by adding the 
> "ingenic,use-internal-divider" property to a devicetree.
> 
> Signed-off-by: Christophe Branchereau <cbranchereau@gmail.com>

One minor formatting comment inline.  If that is all that comes up in
review I can just change it whilst applying.

Jonathan

> ---
>  drivers/iio/adc/ingenic-adc.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/iio/adc/ingenic-adc.c b/drivers/iio/adc/ingenic-adc.c
> index 6b9af0530590..09937c05d2af 100644
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
> @@ -879,6 +880,12 @@ static int ingenic_adc_probe(struct platform_device *pdev)
>  	/* Put hardware in a known passive state. */
>  	writeb(0x00, adc->base + JZ_ADC_REG_ENABLE);
>  	writeb(0xff, adc->base + JZ_ADC_REG_CTRL);
> +
> +	if (device_property_present(dev, "ingenic,use-internal-divider")) /* JZ4760B specific */
> +		ingenic_adc_set_config(adc, JZ_ADC_REG_CFG_VBAT_SEL, JZ_ADC_REG_CFG_VBAT_SEL);
Please break this line and move the comment on the one above.

Whilst we have relaxed the kernel style to allow longer lines, it's nice
to still keep them to the 80 char limit when it doesn't really hurt readability.
Here I don't think it would make much difference.

> +	else
> +		ingenic_adc_set_config(adc, JZ_ADC_REG_CFG_VBAT_SEL, 0);
> +
>  	usleep_range(2000, 3000); /* Must wait at least 2ms. */
>  	clk_disable(adc->clk);
>  
> @@ -906,6 +913,7 @@ static const struct of_device_id ingenic_adc_of_match[] = {
>  	{ .compatible = "ingenic,jz4725b-adc", .data = &jz4725b_adc_soc_data, },
>  	{ .compatible = "ingenic,jz4740-adc", .data = &jz4740_adc_soc_data, },
>  	{ .compatible = "ingenic,jz4760-adc", .data = &jz4760_adc_soc_data, },
> +	{ .compatible = "ingenic,jz4760b-adc", .data = &jz4760_adc_soc_data, },
>  	{ .compatible = "ingenic,jz4770-adc", .data = &jz4770_adc_soc_data, },
>  	{ },
>  };

