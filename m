Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B54623FAC67
	for <lists+linux-iio@lfdr.de>; Sun, 29 Aug 2021 17:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235495AbhH2PLC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Aug 2021 11:11:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:35040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231216AbhH2PLB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 29 Aug 2021 11:11:01 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A3E06054F;
        Sun, 29 Aug 2021 15:10:04 +0000 (UTC)
Date:   Sun, 29 Aug 2021 16:13:18 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     <lars@metafoo.de>, <pmeerw@pmeerw.net>, <robh+dt@kernel.org>,
        <joel@jms.id.au>, <andrew@aj.id.au>, <p.zabel@pengutronix.de>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <BMC-SW@aspeedtech.com>
Subject: Re: [RESEND v4 05/15] iio: adc: aspeed: Refactory model data
 structure
Message-ID: <20210829161318.54997151@jic23-huawei>
In-Reply-To: <20210824091243.9393-6-billy_tsai@aspeedtech.com>
References: <20210824091243.9393-1-billy_tsai@aspeedtech.com>
        <20210824091243.9393-6-billy_tsai@aspeedtech.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 24 Aug 2021 17:12:33 +0800
Billy Tsai <billy_tsai@aspeedtech.com> wrote:

> This patch refactory the model data structure to distinguish the
> function form differnet version of aspeed adc.

from different versions 

> - Rename the vref_voltag to vref_fixed and add vref driver data

vref_voltage

> When driver probe will check vref_fixed value and store it
> to vref which isn't const value.
> - Add num_channels
> Make num_channles of iio device can be changed by differnet model_data

different

> - Add need_prescaler flag and scaler_bit_width
> The need_prescaler flag used to tell the driver the clock divider needs
> another prescaler and the scaler_bit_width to set the clock divider
> bitfiled width.

bitfield?

> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  drivers/iio/adc/aspeed_adc.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
> index d85aa31ee3b1..f03c7921d534 100644
> --- a/drivers/iio/adc/aspeed_adc.c
> +++ b/drivers/iio/adc/aspeed_adc.c
> @@ -63,8 +63,11 @@ struct aspeed_adc_model_data {
>  	const char *model_name;
>  	unsigned int min_sampling_rate;	// Hz
>  	unsigned int max_sampling_rate;	// Hz
> -	unsigned int vref_voltage;	// mV
> +	unsigned int vref_fixed;	// mV

Whilst here, you could make the name carry the information of the units.
e.g. vref_fixed_mv;  That way we always know what the units are without having
to spot this comment.

>  	bool wait_init_sequence;
> +	bool need_prescaler;
> +	u8 scaler_bit_width;
> +	unsigned int num_channels;
>  };
>  
>  struct aspeed_adc_data {
> @@ -75,6 +78,7 @@ struct aspeed_adc_data {
>  	struct clk_hw		*clk_prescaler;
>  	struct clk_hw		*clk_scaler;
>  	struct reset_control	*rst;
> +	int			vref;
vref_mv as above perhaps?
>  };
>  
>  #define ASPEED_CHAN(_idx, _data_reg_addr) {			\
> @@ -118,7 +122,7 @@ static int aspeed_adc_read_raw(struct iio_dev *indio_dev,
>  		return IIO_VAL_INT;
>  
>  	case IIO_CHAN_INFO_SCALE:
> -		*val = data->model_data->vref_voltage;
> +		*val = data->model_data->vref_fixed;
>  		*val2 = ASPEED_RESOLUTION_BITS;
>  		return IIO_VAL_FRACTIONAL_LOG2;
>  
> @@ -312,17 +316,23 @@ static int aspeed_adc_remove(struct platform_device *pdev)
>  
>  static const struct aspeed_adc_model_data ast2400_model_data = {
>  	.model_name = "ast2400-adc",
> -	.vref_voltage = 2500, // mV
> +	.vref_fixed = 2500, // mV
>  	.min_sampling_rate = 10000,
>  	.max_sampling_rate = 500000,
> +	.need_prescaler = true,
> +	.scaler_bit_width = 10,
> +	.num_channels = 16,
>  };
>  
>  static const struct aspeed_adc_model_data ast2500_model_data = {
>  	.model_name = "ast2500-adc",
> -	.vref_voltage = 1800, // mV
> +	.vref_fixed = 1800, // mV
>  	.min_sampling_rate = 1,
>  	.max_sampling_rate = 1000000,
>  	.wait_init_sequence = true,
> +	.need_prescaler = true,
> +	.scaler_bit_width = 10,
> +	.num_channels = 16,
>  };
>  
>  static const struct of_device_id aspeed_adc_matches[] = {

