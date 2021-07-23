Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D69203D3C13
	for <lists+linux-iio@lfdr.de>; Fri, 23 Jul 2021 16:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235437AbhGWOPZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Jul 2021 10:15:25 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3467 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235351AbhGWOPZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Jul 2021 10:15:25 -0400
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GWX7N6Hl5z6D909;
        Fri, 23 Jul 2021 22:41:04 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 23 Jul 2021 16:55:56 +0200
Received: from localhost (10.210.170.238) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Fri, 23 Jul
 2021 15:55:55 +0100
Date:   Fri, 23 Jul 2021 15:55:30 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
CC:     <jic23@kernel.org>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <robh+dt@kernel.org>, <joel@jms.id.au>, <andrew@aj.id.au>,
        <p.zabel@pengutronix.de>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <BMC-SW@aspeedtech.com>
Subject: Re: [v2 3/8] iio: adc: aspeed: completes the bitfield declare.
Message-ID: <20210723155530.00000d1c@Huawei.com>
In-Reply-To: <20210723081621.29477-4-billy_tsai@aspeedtech.com>
References: <20210723081621.29477-1-billy_tsai@aspeedtech.com>
        <20210723081621.29477-4-billy_tsai@aspeedtech.com>
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

On Fri, 23 Jul 2021 16:16:16 +0800
Billy Tsai <billy_tsai@aspeedtech.com> wrote:

> This patch completes the declare of adc register bitfields and uses the
> same prefix ASPEED_ADC_* for these bitfields.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
Hi Billy

See inline,

Thanks,

Jonathan

> ---
>  drivers/iio/adc/aspeed_adc.c | 40 ++++++++++++++++++++++++------------
>  1 file changed, 27 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
> index 19efaa41bc34..99466a5924c7 100644
> --- a/drivers/iio/adc/aspeed_adc.c
> +++ b/drivers/iio/adc/aspeed_adc.c
> @@ -16,6 +16,7 @@
>  #include <linux/reset.h>
>  #include <linux/spinlock.h>
>  #include <linux/types.h>
> +#include <linux/bitfield.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/driver.h>
> @@ -28,15 +29,28 @@
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
> +#define ASPEED_REG_MAX			0xCC
> +
> +#define ASPEED_ADC_ENGINE_ENABLE		BIT(0)
> +#define ASPEED_ADC_OPERATION_MODE		GENMASK(3, 1)
> +#define ASPEED_ADC_OPERATION_MODE_POWER_DOWN	FIELD_PREP(ASPEED_ADC_OPERATION_MODE, 0)
It's more common to have the FIELD_PREP at the location where it
is used and just have defines here to be to the value of the field.

Perhaps also consider some abbreviations as I think we can safely
make them here without losing any meaning, given context.

ASPEED_ADC_OP_MODE
ASPEED_ADC_OP_MODE_PWR_DWN
ASPEED_ADC_OP_MODE_STANDBY
ASPEED_ADC_OP_MODE_NORMAL

etc.

> +#define ASPEED_ADC_OPERATION_MODE_STANDBY	FIELD_PREP(ASPEED_ADC_OPERATION_MODE, 1)
> +#define ASPEED_ADC_OPERATION_MODE_NORMAL	FIELD_PREP(ASPEED_ADC_OPERATION_MODE, 7)
> +#define ASPEED_ADC_CTRL_COMPENSATION		BIT(4)
> +#define ASPEED_ADC_AUTO_COMPENSATION		BIT(5)
> +#define ASPEED_ADC_REF_VOLTAGE			GENMASK(7, 6)
> +#define ASPEED_ADC_REF_VOLTAGE_2500mV		FIELD_PREP(ASPEED_ADC_REF_VOLTAGE, 0)
> +#define ASPEED_ADC_REF_VOLTAGE_1200mV		FIELD_PREP(ASPEED_ADC_REF_VOLTAGE, 1)
> +#define ASPEED_ADC_REF_VOLTAGE_EXT_HIGH		FIELD_PREP(ASPEED_ADC_REF_VOLTAGE, 2)
> +#define ASPEED_ADC_REF_VOLTAGE_EXT_LOW		FIELD_PREP(ASPEED_ADC_REF_VOLTAGE, 3)
> +#define ASPEED_ADC_CTRL_INIT_RDY		BIT(8)
> +#define ASPEED_ADC_CH7_MODE			BIT(12)
> +#define ASPEED_ADC_CH7_NORMAL			FIELD_PREP(ASPEED_ADC_CH7_MODE, 0)
> +#define ASPEED_ADC_CH7_BATTERY			FIELD_PREP(ASPEED_ADC_CH7_MODE, 1)
> +#define ASPEED_ADC_BATTERY_SENSING_ENABLE	BIT(13)
> +#define ASPEED_ADC_CTRL_CHANNEL			GENMASK(31, 16)
> +#define ASPEED_ADC_CTRL_CHANNEL_ENABLE(ch)	FIELD_PREP(ASPEED_ADC_CTRL_CHANNEL, BIT(ch))
>  
>  #define ASPEED_ADC_INIT_POLLING_TIME	500
>  #define ASPEED_ADC_INIT_TIMEOUT		500000
> @@ -226,7 +240,7 @@ static int aspeed_adc_probe(struct platform_device *pdev)
>  
>  	if (model_data->wait_init_sequence) {
>  		/* Enable engine in normal mode. */
> -		writel(ASPEED_OPERATION_MODE_NORMAL | ASPEED_ENGINE_ENABLE,
> +		writel(ASPEED_ADC_OPERATION_MODE_NORMAL | ASPEED_ADC_ENGINE_ENABLE,
>  		       data->base + ASPEED_REG_ENGINE_CONTROL);
>  
>  		/* Wait for initial sequence complete. */
> @@ -246,7 +260,7 @@ static int aspeed_adc_probe(struct platform_device *pdev)
>  		goto clk_enable_error;
>  
>  	adc_engine_control_reg_val = GENMASK(31, 16) |
> -		ASPEED_OPERATION_MODE_NORMAL | ASPEED_ENGINE_ENABLE;
> +		ASPEED_ADC_OPERATION_MODE_NORMAL | ASPEED_ADC_ENGINE_ENABLE;
>  	writel(adc_engine_control_reg_val,
>  		data->base + ASPEED_REG_ENGINE_CONTROL);
>  
> @@ -264,7 +278,7 @@ static int aspeed_adc_probe(struct platform_device *pdev)
>  	return 0;
>  
>  iio_register_error:
> -	writel(ASPEED_OPERATION_MODE_POWER_DOWN,
> +	writel(ASPEED_ADC_OPERATION_MODE_POWER_DOWN,
>  		data->base + ASPEED_REG_ENGINE_CONTROL);
>  	clk_disable_unprepare(data->clk_scaler->clk);
>  clk_enable_error:
> @@ -283,7 +297,7 @@ static int aspeed_adc_remove(struct platform_device *pdev)
>  	struct aspeed_adc_data *data = iio_priv(indio_dev);
>  
>  	iio_device_unregister(indio_dev);
> -	writel(ASPEED_OPERATION_MODE_POWER_DOWN,
> +	writel(ASPEED_ADC_OPERATION_MODE_POWER_DOWN,
>  		data->base + ASPEED_REG_ENGINE_CONTROL);
>  	clk_disable_unprepare(data->clk_scaler->clk);
>  	reset_control_assert(data->rst);

