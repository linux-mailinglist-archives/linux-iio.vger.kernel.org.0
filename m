Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0B853FACBC
	for <lists+linux-iio@lfdr.de>; Sun, 29 Aug 2021 17:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235606AbhH2PnO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Aug 2021 11:43:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:39688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235576AbhH2PnN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 29 Aug 2021 11:43:13 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B75B460E94;
        Sun, 29 Aug 2021 15:42:16 +0000 (UTC)
Date:   Sun, 29 Aug 2021 16:45:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     <lars@metafoo.de>, <pmeerw@pmeerw.net>, <robh+dt@kernel.org>,
        <joel@jms.id.au>, <andrew@aj.id.au>, <p.zabel@pengutronix.de>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <BMC-SW@aspeedtech.com>
Subject: Re: [RESEND v4 15/15] iio: adc: aspeed: Get and set trimming data.
Message-ID: <20210829164531.44cbcc21@jic23-huawei>
In-Reply-To: <202108250007.17P07NFj097422@twspam01.aspeedtech.com>
References: <20210824091243.9393-1-billy_tsai@aspeedtech.com>
        <202108250007.17P07NFj097422@twspam01.aspeedtech.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 24 Aug 2021 17:12:43 +0800
Billy Tsai <billy_tsai@aspeedtech.com> wrote:

> The adc controller have trimming register for fine-tune the reference

Nice to have ADC instead of adc (though not that important as meaning is clear).

> voltage. The trimming value come from the otp register which will be
> written before chip product. This patch will read this otp value and

written during chip production? (perhaps that's what is intended?)

> configure it to the adc register when adc controller probe and using dts
> property "aspeed,trim-data-valid" to determine whether to execute this
> flow.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  drivers/iio/adc/aspeed_adc.c | 68 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
> 
> diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
> index 0c5d84e82561..bd7fb23f3510 100644
> --- a/drivers/iio/adc/aspeed_adc.c
> +++ b/drivers/iio/adc/aspeed_adc.c
> @@ -25,6 +25,8 @@
>  #include <linux/spinlock.h>
>  #include <linux/types.h>
>  #include <linux/bitfield.h>
> +#include <linux/regmap.h>
> +#include <linux/mfd/syscon.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/driver.h>
> @@ -72,6 +74,11 @@
>   */
>  #define ASPEED_ADC_DEF_SAMPLING_RATE	65000
>  
> +struct aspeed_adc_trim_locate {
> +	const unsigned int offset;
> +	const unsigned int field;
> +};
> +
>  struct aspeed_adc_model_data {
>  	const char *model_name;
>  	unsigned int min_sampling_rate;	// Hz
> @@ -82,6 +89,7 @@ struct aspeed_adc_model_data {
>  	bool bat_sense_sup;
>  	u8 scaler_bit_width;
>  	unsigned int num_channels;
> +	const struct aspeed_adc_trim_locate *trim_locate;
>  };
>  
>  struct adc_gain {
> @@ -136,6 +144,44 @@ static const struct iio_chan_spec aspeed_adc_iio_channels[] = {
>  	ASPEED_CHAN(15, 0x2E),
>  };
>  
> +static int aspeed_adc_set_trim_data(struct iio_dev *indio_dev)
> +{
> +	struct device_node *syscon;
> +	struct regmap *scu;
> +	u32 scu_otp, trimming_val;
> +	struct aspeed_adc_data *data = iio_priv(indio_dev);
> +
> +	syscon = of_find_node_by_name(NULL, "syscon");
> +	if (syscon == NULL) {
> +		dev_warn(data->dev, "Couldn't find syscon node\n");
> +		return -EOPNOTSUPP;
> +	}
> +	scu = syscon_node_to_regmap(syscon);
> +	if (IS_ERR(scu)) {
> +		dev_warn(data->dev, "Failed to get syscon regmap\n");
> +		return -EOPNOTSUPP;
> +	}
> +	if (data->model_data->trim_locate) {
> +		if (regmap_read(scu, data->model_data->trim_locate->offset,
> +				&scu_otp)) {
> +			dev_warn(data->dev,
> +				 "Failed to get adc trimming data\n");
> +			trimming_val = 0x8;
> +		} else {
> +			trimming_val =
> +				((scu_otp) &
> +				 (data->model_data->trim_locate->field)) >>
> +				__ffs(data->model_data->trim_locate->field);
> +		}
> +		dev_dbg(data->dev,
> +			"trimming val = %d, offset = %08x, fields = %08x\n",
> +			trimming_val, data->model_data->trim_locate->offset,
> +			data->model_data->trim_locate->field);
> +		writel(trimming_val, data->base + ASPEED_REG_COMPENSATION_TRIM);
> +	}
> +	return 0;
> +}
> +
>  static int aspeed_adc_compensation(struct iio_dev *indio_dev)
>  {
>  	struct aspeed_adc_data *data = iio_priv(indio_dev);
> @@ -506,6 +552,10 @@ static int aspeed_adc_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	if (of_find_property(data->dev->of_node, "aspeed,trim-data-valid",
> +			     NULL))
> +		aspeed_adc_set_trim_data(indio_dev);
> +
>  	if (of_find_property(data->dev->of_node, "aspeed,battery-sensing",
>  			     NULL)) {
>  		if (data->model_data->bat_sense_sup) {
> @@ -579,6 +629,21 @@ static int aspeed_adc_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static const struct aspeed_adc_trim_locate ast2500_adc_trim = {
> +	.offset = 0x154,
> +	.field = GENMASK(31, 28),
> +};
> +
> +static const struct aspeed_adc_trim_locate ast2600_adc0_trim = {
> +	.offset = 0x5d0,
> +	.field = GENMASK(3, 0),
> +};
> +
> +static const struct aspeed_adc_trim_locate ast2600_adc1_trim = {
> +	.offset = 0x5d0,
> +	.field = GENMASK(7, 4),
> +};
> +
>  static const struct aspeed_adc_model_data ast2400_model_data = {
>  	.model_name = "ast2400-adc",
>  	.vref_fixed = 2500, // mV
> @@ -598,6 +663,7 @@ static const struct aspeed_adc_model_data ast2500_model_data = {
>  	.need_prescaler = true,
>  	.scaler_bit_width = 10,
>  	.num_channels = 16,
> +	.trim_locate = &ast2500_adc_trim,
>  };
>  
>  static const struct aspeed_adc_model_data ast2600_adc0_model_data = {
> @@ -608,6 +674,7 @@ static const struct aspeed_adc_model_data ast2600_adc0_model_data = {
>  	.bat_sense_sup = true,
>  	.scaler_bit_width = 16,
>  	.num_channels = 8,
> +	.trim_locate = &ast2600_adc0_trim,
>  };
>  
>  static const struct aspeed_adc_model_data ast2600_adc1_model_data = {
> @@ -618,6 +685,7 @@ static const struct aspeed_adc_model_data ast2600_adc1_model_data = {
>  	.bat_sense_sup = true,
>  	.scaler_bit_width = 16,
>  	.num_channels = 8,
> +	.trim_locate = &ast2600_adc1_trim,
>  };
>  
>  static const struct of_device_id aspeed_adc_matches[] = {

