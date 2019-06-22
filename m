Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66D2F4F4CE
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2019 11:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbfFVJjZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 Jun 2019 05:39:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:53770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbfFVJjZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 Jun 2019 05:39:25 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 668842070B;
        Sat, 22 Jun 2019 09:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561196363;
        bh=62wqamZTufCpuZJ2+wwSe9gHyryf/3KEt5zf+QDPazA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AivjhXf/pCteBL38ChM4XsrZCIl4SXwVurhN97FIwh7bxNv4IP+1Z2Vvg+03XLer9
         cw0yYJrEf7ZfxGO3hiSQLbc5X4Q7JjmxQHPgOeJ3SkSg2cFMLxleAu2n1NDqfmxXUz
         SQgYKw4i7GUUdYZT6/5Rki7NlKgQ0QoPXeOUy3zU=
Date:   Sat, 22 Jun 2019 10:39:18 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     <robh+dt@kernel.org>, <alexandre.torgue@st.com>,
        <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] iio: adc: stm32-adc: add missing vdda-supply
Message-ID: <20190622103918.1ccbd452@archlinux>
In-Reply-To: <1560947398-11592-3-git-send-email-fabrice.gasnier@st.com>
References: <1560947398-11592-1-git-send-email-fabrice.gasnier@st.com>
        <1560947398-11592-3-git-send-email-fabrice.gasnier@st.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 19 Jun 2019 14:29:55 +0200
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> Add missing vdda-supply, analog power supply, to STM32 ADC. When vdda is
> an independent supply, it needs to be properly turned on or off to supply
> the ADC.
> 
> Fixes: 1add69880240 ("iio: adc: Add support for STM32 ADC core").
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
I'm going to assume there is a board out there where this matters as that
doesn't seem to be the case for the two in tree dts files so I've
marked it for stable.

Going via togreg branch however rather than fixes as we are late in this
cycle so this can wait for the merge window.

Thanks,

Jonathan


> ---
>  drivers/iio/adc/stm32-adc-core.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
> index 2327ec1..1f7ce51 100644
> --- a/drivers/iio/adc/stm32-adc-core.c
> +++ b/drivers/iio/adc/stm32-adc-core.c
> @@ -87,6 +87,7 @@ struct stm32_adc_priv_cfg {
>   * @domain:		irq domain reference
>   * @aclk:		clock reference for the analog circuitry
>   * @bclk:		bus clock common for all ADCs, depends on part used
> + * @vdda:		vdda analog supply reference
>   * @vref:		regulator reference
>   * @cfg:		compatible configuration data
>   * @common:		common data for all ADC instances
> @@ -97,6 +98,7 @@ struct stm32_adc_priv {
>  	struct irq_domain		*domain;
>  	struct clk			*aclk;
>  	struct clk			*bclk;
> +	struct regulator		*vdda;
>  	struct regulator		*vref;
>  	const struct stm32_adc_priv_cfg	*cfg;
>  	struct stm32_adc_common		common;
> @@ -394,10 +396,16 @@ static int stm32_adc_core_hw_start(struct device *dev)
>  	struct stm32_adc_priv *priv = to_stm32_adc_priv(common);
>  	int ret;
>  
> +	ret = regulator_enable(priv->vdda);
> +	if (ret < 0) {
> +		dev_err(dev, "vdda enable failed %d\n", ret);
> +		return ret;
> +	}
> +
>  	ret = regulator_enable(priv->vref);
>  	if (ret < 0) {
>  		dev_err(dev, "vref enable failed\n");
> -		return ret;
> +		goto err_vdda_disable;
>  	}
>  
>  	if (priv->bclk) {
> @@ -425,6 +433,8 @@ static int stm32_adc_core_hw_start(struct device *dev)
>  		clk_disable_unprepare(priv->bclk);
>  err_regulator_disable:
>  	regulator_disable(priv->vref);
> +err_vdda_disable:
> +	regulator_disable(priv->vdda);
>  
>  	return ret;
>  }
> @@ -441,6 +451,7 @@ static void stm32_adc_core_hw_stop(struct device *dev)
>  	if (priv->bclk)
>  		clk_disable_unprepare(priv->bclk);
>  	regulator_disable(priv->vref);
> +	regulator_disable(priv->vdda);
>  }
>  
>  static int stm32_adc_probe(struct platform_device *pdev)
> @@ -468,6 +479,14 @@ static int stm32_adc_probe(struct platform_device *pdev)
>  		return PTR_ERR(priv->common.base);
>  	priv->common.phys_base = res->start;
>  
> +	priv->vdda = devm_regulator_get(&pdev->dev, "vdda");
> +	if (IS_ERR(priv->vdda)) {
> +		ret = PTR_ERR(priv->vdda);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "vdda get failed, %d\n", ret);
> +		return ret;
> +	}
> +
>  	priv->vref = devm_regulator_get(&pdev->dev, "vref");
>  	if (IS_ERR(priv->vref)) {
>  		ret = PTR_ERR(priv->vref);

