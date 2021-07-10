Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFB803C3573
	for <lists+linux-iio@lfdr.de>; Sat, 10 Jul 2021 18:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbhGJQIz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 10 Jul 2021 12:08:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:37744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230325AbhGJQIz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 10 Jul 2021 12:08:55 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D65BB61249;
        Sat, 10 Jul 2021 16:06:06 +0000 (UTC)
Date:   Sat, 10 Jul 2021 17:08:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com,
        charles-antoine.couret@essensium.com, Nuno.Sa@analog.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v2 1/4] iio: adc: ad7949: define and use bitfield names
Message-ID: <20210710170837.263d6b1a@jic23-huawei>
In-Reply-To: <20210709155856.1732245-2-liambeguin@gmail.com>
References: <20210709155856.1732245-1-liambeguin@gmail.com>
        <20210709155856.1732245-2-liambeguin@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri,  9 Jul 2021 11:58:53 -0400
Liam Beguin <liambeguin@gmail.com> wrote:

> From: Liam Beguin <lvb@xiphos.com>
> 
> Replace raw configuration register values by using FIELD_PREP and
> defines to improve readability.
> 
> Signed-off-by: Liam Beguin <lvb@xiphos.com>

Ideally fixes should come before any refactors / cleanups like this one.
That reduces the burden if people want to backport them.

In this particular case I'm guessing no one ran into the issues the
following patches deal with so we can just take these in the order
you have here.

Otherwise, good cleanup.  A few minor comments inline, mostly as a result
of some less than ideal name choices on the datasheet.

> ---
>  drivers/iio/adc/ad7949.c | 38 +++++++++++++++++++++++++++++++-------
>  1 file changed, 31 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
> index 1b4b3203e428..93aacf4f680b 100644
> --- a/drivers/iio/adc/ad7949.c
> +++ b/drivers/iio/adc/ad7949.c
> @@ -12,12 +12,27 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/spi/spi.h>
>  
> -#define AD7949_MASK_CHANNEL_SEL		GENMASK(9, 7)
>  #define AD7949_MASK_TOTAL		GENMASK(13, 0)
> -#define AD7949_OFFSET_CHANNEL_SEL	7
> -#define AD7949_CFG_READ_BACK		0x1
>  #define AD7949_CFG_REG_SIZE_BITS	14
>  
> +#define AD7949_CFG_BIT_CFG		BIT(13)

Even though that's the name on the datasheet it is silly!

I would have just one define called
AD7949_CFG_VAL_OVERWRITE BIT(13)

It's common to do that for single flags where
FIELD_PREP(AD7949_CFG_VAL_OVERWRITE, 1) for example has an
obvious meaning for the 1.

> +#define AD7949_CFG_VAL_CFG_OVERWRITE		1
> +#define AD7949_CFG_VAL_CFG_KEEP			0
> +#define AD7949_CFG_BIT_INCC		GENMASK(12, 10)
> +#define AD7949_CFG_VAL_INCC_UNIPOLAR_GND	7
> +#define AD7949_CFG_VAL_INCC_UNIPOLAR_COMM	6
> +#define AD7949_CFG_VAL_INCC_UNIPOLAR_DIFF	4
> +#define AD7949_CFG_VAL_INCC_TEMP		3
> +#define AD7949_CFG_VAL_INCC_BIPOLAR		2
> +#define AD7949_CFG_VAL_INCC_BIPOLAR_DIFF	0
> +#define AD7949_CFG_BIT_INX		GENMASK(9, 7)

This is rather non obvious abbreviation. _INx would be clearer
perhaps, but then we'd get someone fixing the camel case...
Given it would be good to match the datasheet, keep the name
but add a comment to say this is the input channel select.

> +#define AD7949_CFG_BIT_BW		BIT(6)

As above, I'd suggest just defining AD7949_CFG_VAL_BW_FULL BIT(6)
then it's either full or not depending on a 0 or 1 write.

> +#define AD7949_CFG_VAL_BW_FULL			1
> +#define AD7949_CFG_VAL_BW_QUARTER		0
> +#define AD7949_CFG_BIT_REF		GENMASK(5, 3)
> +#define AD7949_CFG_BIT_SEQ		GENMASK(2, 1)
> +#define AD7949_CFG_BIT_RBN		BIT(0)
> +
>  enum {
>  	ID_AD7949 = 0,
>  	ID_AD7682,
> @@ -109,8 +124,8 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
>  	 */
>  	for (i = 0; i < 2; i++) {
>  		ret = ad7949_spi_write_cfg(ad7949_adc,
> -					   channel << AD7949_OFFSET_CHANNEL_SEL,
> -					   AD7949_MASK_CHANNEL_SEL);
> +					   FIELD_PREP(AD7949_CFG_BIT_INX, channel),
> +					   AD7949_CFG_BIT_INX);
>  		if (ret)
>  			return ret;
>  		if (channel == ad7949_adc->current_channel)
> @@ -214,10 +229,19 @@ static int ad7949_spi_init(struct ad7949_adc_chip *ad7949_adc)
>  {
>  	int ret;
>  	int val;
> +	u16 cfg;
>  
> -	/* Sequencer disabled, CFG readback disabled, IN0 as default channel */
>  	ad7949_adc->current_channel = 0;
> -	ret = ad7949_spi_write_cfg(ad7949_adc, 0x3C79, AD7949_MASK_TOTAL);
> +
> +	cfg = FIELD_PREP(AD7949_CFG_BIT_CFG, AD7949_CFG_VAL_CFG_OVERWRITE) |
> +		FIELD_PREP(AD7949_CFG_BIT_INCC, AD7949_CFG_VAL_INCC_UNIPOLAR_GND) |
> +		FIELD_PREP(AD7949_CFG_BIT_INX, ad7949_adc->current_channel) |
> +		FIELD_PREP(AD7949_CFG_BIT_BW, AD7949_CFG_VAL_BW_FULL) |
> +		FIELD_PREP(AD7949_CFG_BIT_REF, AD7949_REF_EXT_BUF) |
> +		FIELD_PREP(AD7949_CFG_BIT_SEQ, 0x0) |
> +		FIELD_PREP(AD7949_CFG_BIT_RBN, 1);
> +
> +	ret = ad7949_spi_write_cfg(ad7949_adc, cfg, AD7949_MASK_TOTAL);
>  
>  	/*
>  	 * Do two dummy conversions to apply the first configuration setting.

