Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F50F3CC4B3
	for <lists+linux-iio@lfdr.de>; Sat, 17 Jul 2021 19:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbhGQRLE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 17 Jul 2021 13:11:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:50552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232307AbhGQRLD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 17 Jul 2021 13:11:03 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91D2A601FA;
        Sat, 17 Jul 2021 17:08:03 +0000 (UTC)
Date:   Sat, 17 Jul 2021 18:10:26 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com,
        charles-antoine.couret@essensium.com, Nuno.Sa@analog.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v3 1/4] iio: adc: ad7949: define and use bitfield names
Message-ID: <20210717181026.16232db1@jic23-huawei>
In-Reply-To: <20210713043425.3321230-2-liambeguin@gmail.com>
References: <20210713043425.3321230-1-liambeguin@gmail.com>
        <20210713043425.3321230-2-liambeguin@gmail.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 13 Jul 2021 00:34:22 -0400
Liam Beguin <liambeguin@gmail.com> wrote:

> From: Liam Beguin <lvb@xiphos.com>
> 
> Replace raw configuration register values by using FIELD_PREP and
> defines to improve readability.
> 
> Signed-off-by: Liam Beguin <lvb@xiphos.com>

Nice. This looks good to me.  Will pick up when the rest of the
series is ready to go.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad7949.c | 50 +++++++++++++++++++++++++++++++++-------
>  1 file changed, 42 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
> index 1b4b3203e428..0b549b8bd7a9 100644
> --- a/drivers/iio/adc/ad7949.c
> +++ b/drivers/iio/adc/ad7949.c
> @@ -11,12 +11,37 @@
>  #include <linux/module.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/spi/spi.h>
> +#include <linux/bitfield.h>
>  
> -#define AD7949_MASK_CHANNEL_SEL		GENMASK(9, 7)
>  #define AD7949_MASK_TOTAL		GENMASK(13, 0)
> -#define AD7949_OFFSET_CHANNEL_SEL	7
> -#define AD7949_CFG_READ_BACK		0x1
> -#define AD7949_CFG_REG_SIZE_BITS	14
> +
> +/* CFG: Configuration Update */
> +#define AD7949_CFG_BIT_OVERWRITE	BIT(13)
> +
> +/* INCC: Input Channel Configuration */
> +#define AD7949_CFG_BIT_INCC		GENMASK(12, 10)
> +#define AD7949_CFG_VAL_INCC_UNIPOLAR_GND	7
> +#define AD7949_CFG_VAL_INCC_UNIPOLAR_COMM	6
> +#define AD7949_CFG_VAL_INCC_UNIPOLAR_DIFF	4
> +#define AD7949_CFG_VAL_INCC_TEMP		3
> +#define AD7949_CFG_VAL_INCC_BIPOLAR		2
> +#define AD7949_CFG_VAL_INCC_BIPOLAR_DIFF	0
> +
> +/* INX: Input channel Selection in a binary fashion */
> +#define AD7949_CFG_BIT_INX		GENMASK(9, 7)
> +
> +/* BW: select bandwidth for low-pass filter. Full or Quarter */
> +#define AD7949_CFG_BIT_BW_FULL			BIT(6)
> +
> +/* REF: reference/buffer selection */
> +#define AD7949_CFG_BIT_REF		GENMASK(5, 3)
> +#define AD7949_CFG_VAL_REF_EXT_BUF		7
> +
> +/* SEQ: channel sequencer. Allows for scanning channels */
> +#define AD7949_CFG_BIT_SEQ		GENMASK(2, 1)
> +
> +/* RB: Read back the CFG register */
> +#define AD7949_CFG_BIT_RBN		BIT(0)
>  
>  enum {
>  	ID_AD7949 = 0,
> @@ -109,8 +134,8 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
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
> @@ -214,10 +239,19 @@ static int ad7949_spi_init(struct ad7949_adc_chip *ad7949_adc)
>  {
>  	int ret;
>  	int val;
> +	u16 cfg;
>  
> -	/* Sequencer disabled, CFG readback disabled, IN0 as default channel */
>  	ad7949_adc->current_channel = 0;
> -	ret = ad7949_spi_write_cfg(ad7949_adc, 0x3C79, AD7949_MASK_TOTAL);
> +
> +	cfg = FIELD_PREP(AD7949_CFG_BIT_OVERWRITE, 1) |
> +		FIELD_PREP(AD7949_CFG_BIT_INCC, AD7949_CFG_VAL_INCC_UNIPOLAR_GND) |
> +		FIELD_PREP(AD7949_CFG_BIT_INX, ad7949_adc->current_channel) |
> +		FIELD_PREP(AD7949_CFG_BIT_BW_FULL, 1) |
> +		FIELD_PREP(AD7949_CFG_BIT_REF, AD7949_CFG_VAL_REF_EXT_BUF) |
> +		FIELD_PREP(AD7949_CFG_BIT_SEQ, 0x0) |
> +		FIELD_PREP(AD7949_CFG_BIT_RBN, 1);
> +
> +	ret = ad7949_spi_write_cfg(ad7949_adc, cfg, AD7949_MASK_TOTAL);
>  
>  	/*
>  	 * Do two dummy conversions to apply the first configuration setting.

