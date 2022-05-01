Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0F55166CB
	for <lists+linux-iio@lfdr.de>; Sun,  1 May 2022 19:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347242AbiEARxU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 May 2022 13:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236149AbiEARxU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 1 May 2022 13:53:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725CA344EE;
        Sun,  1 May 2022 10:49:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B10560FA1;
        Sun,  1 May 2022 17:49:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9435C385AA;
        Sun,  1 May 2022 17:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651427393;
        bh=HeIhu6CZzFtcH1ye3IUajsGOZ5ioD0j6OUVGNrgfaCo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aR6n+HTIrCElu1LIkykQeH8MMnA6WbQK/PvoV1rds63r5s5wry9qpCW5Qjh8A4RC7
         xI+0HjwxdO8CTIj+mFBg5JpcA5Jc1AFMQ8mWvouROIl0SmDtjJYMOEbNZ3M7aARyOu
         jRwRx3umkbb8qtwAxsxPg++w116YoZiRGKOZGIxozmjeUmU9DaVkcP0VyQ+53N3Apo
         yiC8MSGho04Rv6Ql8CXQLbkq+zqh4KG9lvpyYJnRWCmQIO+mG1pbYxgEwLdMIeDpW7
         0yHYeM2t38/TsePJeyNwIzAP8j7TxXCUgFMARdKrGxqHbWCZqD2cVS/ieLma8PAH6Y
         7Le47Icm0nf5g==
Date:   Sun, 1 May 2022 18:58:07 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Subject: Re: [PATCH] iio: adc: rzg2l_adc: Add support for RZ/G2UL ADC
Message-ID: <20220501185807.0273f96f@jic23-huawei>
In-Reply-To: <20220501081523.22479-1-biju.das.jz@bp.renesas.com>
References: <20220501081523.22479-1-biju.das.jz@bp.renesas.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun,  1 May 2022 09:15:23 +0100
Biju Das <biju.das.jz@bp.renesas.com> wrote:

> ADC found on RZ/G2UL SoC is almost identical to RZ/G2L SoC, but RZ/G2UL
> has 2 analog input channels compared to 8 channels on RZ/G2L. Therefore,
> added a new compatible to handle this difference.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Hi.

Please keep the driver changes and DT update in a series with a short
cover letter.  It makes much more sense to apply them when both
ready than to end up with them being handled separately.

A request inline to do this in a slightly different way that will prove
more flexible if we end up supporting more variants in the future.

> ---
>  drivers/iio/adc/rzg2l_adc.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
> index 7585144b9715..703b08254c9f 100644
> --- a/drivers/iio/adc/rzg2l_adc.c
> +++ b/drivers/iio/adc/rzg2l_adc.c
> @@ -16,6 +16,7 @@
>  #include <linux/io.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> +#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/reset.h>
> @@ -61,6 +62,8 @@
>  #define RZG2L_ADC_CHN_MASK		0x7
>  #define RZG2L_ADC_TIMEOUT		usecs_to_jiffies(1 * 4)
>  
> +#define RZG2UL_ADC_MAX_CHANNELS		2
> +
>  struct rzg2l_adc_data {
>  	const struct iio_chan_spec *channels;
>  	u8 num_channels;
> @@ -76,6 +79,7 @@ struct rzg2l_adc {
>  	const struct rzg2l_adc_data *data;
>  	struct mutex lock;
>  	u16 last_val[RZG2L_ADC_MAX_CHANNELS];
> +	u8 max_channels;
>  };
>  
>  static const char * const rzg2l_adc_channel_name[] = {
> @@ -260,7 +264,9 @@ static int rzg2l_adc_read_label(struct iio_dev *iio_dev,
>  				const struct iio_chan_spec *chan,
>  				char *label)
>  {
> -	if (chan->channel >= RZG2L_ADC_MAX_CHANNELS)
> +	struct rzg2l_adc *adc = iio_priv(iio_dev);
> +
> +	if (chan->channel >= adc->max_channels)
>  		return -EINVAL;
>  
>  	return sysfs_emit(label, "%s\n", rzg2l_adc_channel_name[chan->channel]);
> @@ -290,7 +296,7 @@ static irqreturn_t rzg2l_adc_isr(int irq, void *dev_id)
>  	if (!intst)
>  		return IRQ_NONE;
>  
> -	for_each_set_bit(ch, &intst, RZG2L_ADC_MAX_CHANNELS)
> +	for_each_set_bit(ch, &intst, adc->max_channels)
>  		adc->last_val[ch] = rzg2l_adc_readl(adc, RZG2L_ADCR(ch)) & RZG2L_ADCR_AD_MASK;
>  
>  	/* clear the channel interrupt */
> @@ -321,7 +327,7 @@ static int rzg2l_adc_parse_properties(struct platform_device *pdev, struct rzg2l
>  		return -ENODEV;
>  	}
>  
> -	if (num_channels > RZG2L_ADC_MAX_CHANNELS) {
> +	if (num_channels > adc->max_channels) {
>  		dev_err(&pdev->dev, "num of channel children out of range\n");
>  		return -EINVAL;
>  	}
> @@ -337,7 +343,7 @@ static int rzg2l_adc_parse_properties(struct platform_device *pdev, struct rzg2l
>  		if (ret)
>  			return ret;
>  
> -		if (channel >= RZG2L_ADC_MAX_CHANNELS)
> +		if (channel >= adc->max_channels)
>  			return -EINVAL;
>  
>  		chan_array[i].type = IIO_VOLTAGE;
> @@ -437,6 +443,7 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
>  
>  	adc = iio_priv(indio_dev);
>  
> +	adc->max_channels = (uintptr_t)of_device_get_match_data(dev);

For IIO drivers, where possible please use the generic firmware properties. 
The driver already uses them for everything else. Hence

device_get_match_data(dev);

>  	ret = rzg2l_adc_parse_properties(pdev, adc);
>  	if (ret)
>  		return ret;
> @@ -540,7 +547,8 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id rzg2l_adc_match[] = {
> -	{ .compatible = "renesas,rzg2l-adc",},
> +	{ .compatible = "renesas,r9a07g043-adc", .data = (void *)RZG2UL_ADC_MAX_CHANNELS },
> +	{ .compatible = "renesas,rzg2l-adc", .data = (void *)RZG2L_ADC_MAX_CHANNELS },
Whilst it is more work, I'd prefer that you introduce a small structure to represent
chip type specific information then have an array of those. Finally store a pointer
to an element of that array in here.

We almost always end up needing to add more chip type specific data over time and
so it is better to provide the means to do so flexibly in the first patch where
such support is added.

Thanks,

Jonathan

>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, rzg2l_adc_match);

