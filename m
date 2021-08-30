Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 220ED3FB5D2
	for <lists+linux-iio@lfdr.de>; Mon, 30 Aug 2021 14:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbhH3MQP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Aug 2021 08:16:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:47598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236624AbhH3MQO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Aug 2021 08:16:14 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13367610FB;
        Mon, 30 Aug 2021 12:15:17 +0000 (UTC)
Date:   Mon, 30 Aug 2021 13:18:29 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Eugen Hristev <eugen.hristev@microchip.com>
Cc:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nicolas.ferre@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <ludovic.desroches@microchip.com>
Subject: Re: [PATCH v2 06/10] iio: adc: at91-sama5d2_adc: add helper for COR
 register
Message-ID: <20210830131829.782546eb@jic23-huawei>
In-Reply-To: <20210824115441.681253-7-eugen.hristev@microchip.com>
References: <20210824115441.681253-1-eugen.hristev@microchip.com>
        <20210824115441.681253-7-eugen.hristev@microchip.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 24 Aug 2021 14:54:37 +0300
Eugen Hristev <eugen.hristev@microchip.com> wrote:

> Add helper for the COR register. This helper allows to modify the COR
> register, removes duplicate code and improves readability.
> The COR offset is now part of the register layout. This will allow
> different platform with a different offset to use the same helper.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
Nitpick inline.  If this is all I find in the series I'll tidy it up whilst
applying.

J

> ---
>  drivers/iio/adc/at91-sama5d2_adc.c | 40 +++++++++++++++---------------
>  1 file changed, 20 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index 23be7cec063e..bb4e5e1e3ce4 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -151,8 +151,8 @@ struct at91_adc_reg_layout {
>  	u16				CGR;
>  /* Channel Offset Register */
>  	u16				COR;
> -#define AT91_SAMA5D2_COR_DIFF_OFFSET	16
> -
> +/* Channel Offset Register differential offset - constant, not a register */
> +	u16				COR_diff_offset;
>  /* Analog Control Register */
>  	u16				ACR;
>  /* Analog Control Register - Pen detect sensitivity mask */
> @@ -246,6 +246,7 @@ static const struct at91_adc_reg_layout sama5d2_layout = {
>  	.CWR =			0x44,
>  	.CGR =			0x48,
>  	.COR =			0x4c,
> +	.COR_diff_offset =	16,
>  	.ACR =			0x94,
>  	.TSMR =			0xb0,
>  	.XPOSR =		0xb4,
> @@ -589,6 +590,21 @@ static unsigned int at91_adc_active_scan_mask_to_reg(struct iio_dev *indio_dev)
>  	return mask & GENMASK(st->soc_info.platform->nr_channels, 0);
>  }
>  
> +static void at91_adc_cor(struct at91_adc_state *st,
> +			 struct iio_chan_spec const *chan)
> +{
> +	u32 cor, cur_cor;
> +
> +	cor = (BIT(chan->channel) | BIT(chan->channel2));

Excessive brackets.


> +
> +	cur_cor = at91_adc_readl(st, COR);
> +	cor <<= st->soc_info.platform->layout->COR_diff_offset;
> +	if (chan->differential)
> +		at91_adc_writel(st, COR, cur_cor | cor);
> +	else
> +		at91_adc_writel(st, COR, cur_cor & ~cor);
> +}
> +
>  static void at91_adc_irq_status(struct at91_adc_state *st, u32 *status,
>  				u32 *eoc)
>  {
> @@ -1033,8 +1049,6 @@ static int at91_adc_buffer_prepare(struct iio_dev *indio_dev)
>  			 indio_dev->num_channels) {
>  		struct iio_chan_spec const *chan =
>  					at91_adc_chan_get(indio_dev, bit);
> -		u32 cor;
> -
>  		if (!chan)
>  			continue;
>  		/* these channel types cannot be handled by this trigger */
> @@ -1042,16 +1056,7 @@ static int at91_adc_buffer_prepare(struct iio_dev *indio_dev)
>  		    chan->type == IIO_PRESSURE)
>  			continue;
>  
> -		cor = at91_adc_readl(st, COR);
> -
> -		if (chan->differential)
> -			cor |= (BIT(chan->channel) | BIT(chan->channel2)) <<
> -				AT91_SAMA5D2_COR_DIFF_OFFSET;
> -		else
> -			cor &= ~(BIT(chan->channel) <<
> -			       AT91_SAMA5D2_COR_DIFF_OFFSET);
> -
> -		at91_adc_writel(st, COR, cor);
> +		at91_adc_cor(st, chan);
>  
>  		at91_adc_writel(st, CHER, BIT(chan->channel));
>  	}
> @@ -1439,7 +1444,6 @@ static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
>  				  struct iio_chan_spec const *chan, int *val)
>  {
>  	struct at91_adc_state *st = iio_priv(indio_dev);
> -	u32 cor = 0;
>  	u16 tmp_val;
>  	int ret;
>  
> @@ -1485,11 +1489,7 @@ static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
>  
>  	st->chan = chan;
>  
> -	if (chan->differential)
> -		cor = (BIT(chan->channel) | BIT(chan->channel2)) <<
> -		      AT91_SAMA5D2_COR_DIFF_OFFSET;
> -
> -	at91_adc_writel(st, COR, cor);
> +	at91_adc_cor(st, chan);
>  	at91_adc_writel(st, CHER, BIT(chan->channel));
>  	at91_adc_eoc_ena(st, chan->channel);
>  	at91_adc_writel(st, CR, AT91_SAMA5D2_CR_START);

