Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88BCC154342
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2020 12:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbgBFLki (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Feb 2020 06:40:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:34604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726687AbgBFLki (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 6 Feb 2020 06:40:38 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1660214AF;
        Thu,  6 Feb 2020 11:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580989237;
        bh=A3b9tUzaOsGv1NT9DORNJCp04+OBPFpX1hxspkG6mMs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YVrxdhhiv3fiSit4eVNEijuXpbQ2beULya0+7piOcX6KneZm6LciBbp4C7o+qfDiv
         6+nS8MhVQc4nkzd8jh8dFgXURqdRVMxYuBk2mwXn8kCIDzM8nAOqPXWWNi1S+JgjsM
         wP4PrHfoLIiUfR9/2yUubZ6+F54E+36fsUxvOb+I=
Date:   Thu, 6 Feb 2020 11:40:31 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com, avifishman70@gmail.com,
        tali.perry1@gmail.com, venture@google.com, yuenn@google.com,
        benjaminfair@google.com, joel@jms.id.au, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
Subject: Re: [PATCH v2 2/2] iio: adc: modify NPCM reset support
Message-ID: <20200206114031.0f31538b@archlinux>
In-Reply-To: <20200203150917.176391-2-tmaimon77@gmail.com>
References: <20200203150917.176391-1-tmaimon77@gmail.com>
        <20200203150917.176391-2-tmaimon77@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  3 Feb 2020 17:09:17 +0200
Tomer Maimon <tmaimon77@gmail.com> wrote:

> Modify NPCM ADC reset support from
> direct register access to reset controller support.
> 
> please make sure to modify NPCM adc device tree
> parameters as described at nuvoton,npcm-adc.txt
> document for using this change.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>

Applied.  I added a note for anyone browsing the tree in future
to say that we know this is a breaking change, but in this case
close ecosystem etc so it's fine..

I don't want others to point at your patch when I tell them no
for similar changes in more generic parts!

Thanks,

Jonathan

> ---
>  drivers/iio/adc/npcm_adc.c | 30 +++++++++---------------------
>  1 file changed, 9 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/iio/adc/npcm_adc.c b/drivers/iio/adc/npcm_adc.c
> index a6170a37ebe8..83bad2d5575d 100644
> --- a/drivers/iio/adc/npcm_adc.c
> +++ b/drivers/iio/adc/npcm_adc.c
> @@ -14,6 +14,7 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/spinlock.h>
>  #include <linux/uaccess.h>
> +#include <linux/reset.h>
>  
>  struct npcm_adc {
>  	bool int_status;
> @@ -23,13 +24,9 @@ struct npcm_adc {
>  	struct clk *adc_clk;
>  	wait_queue_head_t wq;
>  	struct regulator *vref;
> -	struct regmap *rst_regmap;
> +	struct reset_control *reset;
>  };
>  
> -/* NPCM7xx reset module */
> -#define NPCM7XX_IPSRST1_OFFSET		0x020
> -#define NPCM7XX_IPSRST1_ADC_RST		BIT(27)
> -
>  /* ADC registers */
>  #define NPCM_ADCCON	 0x00
>  #define NPCM_ADCDATA	 0x04
> @@ -106,13 +103,11 @@ static int npcm_adc_read(struct npcm_adc *info, int *val, u8 channel)
>  					       msecs_to_jiffies(10));
>  	if (ret == 0) {
>  		regtemp = ioread32(info->regs + NPCM_ADCCON);
> -		if ((regtemp & NPCM_ADCCON_ADC_CONV) && info->rst_regmap) {
> +		if (regtemp & NPCM_ADCCON_ADC_CONV) {
>  			/* if conversion failed - reset ADC module */
> -			regmap_write(info->rst_regmap, NPCM7XX_IPSRST1_OFFSET,
> -				     NPCM7XX_IPSRST1_ADC_RST);
> +			reset_control_assert(info->reset);
>  			msleep(100);
> -			regmap_write(info->rst_regmap, NPCM7XX_IPSRST1_OFFSET,
> -				     0x0);
> +			reset_control_deassert(info->reset);
>  			msleep(100);
>  
>  			/* Enable ADC and start conversion module */
> @@ -186,7 +181,6 @@ static int npcm_adc_probe(struct platform_device *pdev)
>  	struct npcm_adc *info;
>  	struct iio_dev *indio_dev;
>  	struct device *dev = &pdev->dev;
> -	struct device_node *np = pdev->dev.of_node;
>  
>  	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*info));
>  	if (!indio_dev)
> @@ -199,6 +193,10 @@ static int npcm_adc_probe(struct platform_device *pdev)
>  	if (IS_ERR(info->regs))
>  		return PTR_ERR(info->regs);
>  
> +	info->reset = devm_reset_control_get(&pdev->dev, NULL);
> +	if (IS_ERR(info->reset))
> +		return PTR_ERR(info->reset);
> +
>  	info->adc_clk = devm_clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(info->adc_clk)) {
>  		dev_warn(&pdev->dev, "ADC clock failed: can't read clk\n");
> @@ -211,16 +209,6 @@ static int npcm_adc_probe(struct platform_device *pdev)
>  	div = div >> NPCM_ADCCON_DIV_SHIFT;
>  	info->adc_sample_hz = clk_get_rate(info->adc_clk) / ((div + 1) * 2);
>  
> -	if (of_device_is_compatible(np, "nuvoton,npcm750-adc")) {
> -		info->rst_regmap = syscon_regmap_lookup_by_compatible
> -			("nuvoton,npcm750-rst");
> -		if (IS_ERR(info->rst_regmap)) {
> -			dev_err(&pdev->dev, "Failed to find nuvoton,npcm750-rst\n");
> -			ret = PTR_ERR(info->rst_regmap);
> -			goto err_disable_clk;
> -		}
> -	}
> -
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq <= 0) {
>  		ret = -EINVAL;

