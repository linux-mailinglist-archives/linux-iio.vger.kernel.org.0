Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7CD6311E36
	for <lists+linux-iio@lfdr.de>; Sat,  6 Feb 2021 16:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbhBFO7o (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 6 Feb 2021 09:59:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:46898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230196AbhBFO7n (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 6 Feb 2021 09:59:43 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AA7E64EBC;
        Sat,  6 Feb 2021 14:59:02 +0000 (UTC)
Date:   Sat, 6 Feb 2021 14:58:58 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     lars@metafoo.de, swboyd@chromium.org, campello@chromium.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: sx9310: Support ACPI property
Message-ID: <20210206145858.2a09d6a5@archlinux>
In-Reply-To: <20210205215811.2033425-1-gwendal@chromium.org>
References: <20210205215811.2033425-1-gwendal@chromium.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri,  5 Feb 2021 13:58:11 -0800
Gwendal Grignou <gwendal@chromium.org> wrote:

> Use device_property_read_... to support both device tree and ACPI
> bindings.
> 
> Add support for variable array per documentation
> ("iio/proximity/semtech,sx9310.yaml").
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  Changes since v1:
>    Use device_property_count_u32(...) instead of device_property_read_u32_array(..., NULL, 0)
> 
>  drivers/iio/proximity/sx9310.c | 35 +++++++++++++++++++---------------
>  1 file changed, 20 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
> index 6a04959df35e5..bba9dc6ac844d 100644
> --- a/drivers/iio/proximity/sx9310.c
> +++ b/drivers/iio/proximity/sx9310.c
> @@ -20,6 +20,7 @@
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/pm.h>
> +#include <linux/property.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/slab.h>
> @@ -1215,31 +1216,35 @@ static int sx9310_init_compensation(struct iio_dev *indio_dev)
>  }
>  
>  static const struct sx9310_reg_default *
> -sx9310_get_default_reg(struct sx9310_data *data, int i,
> +sx9310_get_default_reg(struct device *dev, int i,
>  		       struct sx9310_reg_default *reg_def)
>  {
> -	int ret;
> -	const struct device_node *np = data->client->dev.of_node;
> +	int ret, count;
>  	u32 combined[SX9310_NUM_CHANNELS] = { 4, 4, 4, 4 };
>  	unsigned long comb_mask = 0;
>  	const char *res;
>  	u32 start = 0, raw = 0, pos = 0;
>  
>  	memcpy(reg_def, &sx9310_default_regs[i], sizeof(*reg_def));
> -	if (!np)
> -		return reg_def;
> -
>  	switch (reg_def->reg) {
>  	case SX9310_REG_PROX_CTRL2:
> -		if (of_property_read_bool(np, "semtech,cs0-ground")) {
> +		if (device_property_read_bool(dev, "semtech,cs0-ground")) {
>  			reg_def->def &= ~SX9310_REG_PROX_CTRL2_SHIELDEN_MASK;
>  			reg_def->def |= SX9310_REG_PROX_CTRL2_SHIELDEN_GROUND;
>  		}
>  
>  		reg_def->def &= ~SX9310_REG_PROX_CTRL2_COMBMODE_MASK;
> -		of_property_read_u32_array(np, "semtech,combined-sensors",
> -					   combined, ARRAY_SIZE(combined));
> -		for (i = 0; i < ARRAY_SIZE(combined); i++) {
> +		count = device_property_count_u32(dev, "semtech,combined-sensors");
> +		if (count > 0 && count <= ARRAY_SIZE(combined))
> +			ret = device_property_read_u32_array(dev,
> +					"semtech,combined-sensors", combined,
> +					count);
> +		else
> +			ret = -EINVAL;
> +		if (ret)
> +			count = ARRAY_SIZE(combined);

This is odd enough please give a comment on why we would set count to
the array size on error in reading the array.
(obviously we do that before by ignoring the error, but still good
to improve clarity on what is going on here - I assume we are just
falling back to defaults...)

Also, this crossed with Stephen continuing the thread on v1 and suggesting
an alternative form so I'll wait for that discussion to be resolved.

Thanks,

Jonathan


> +
> +		for (i = 0; i < count; i++) {
>  			if (combined[i] <= SX9310_NUM_CHANNELS)
>  				comb_mask |= BIT(combined[i]);
>  		}
> @@ -1256,7 +1261,7 @@ sx9310_get_default_reg(struct sx9310_data *data, int i,
>  
>  		break;
>  	case SX9310_REG_PROX_CTRL4:
> -		ret = of_property_read_string(np, "semtech,resolution", &res);
> +		ret = device_property_read_string(dev, "semtech,resolution", &res);
>  		if (ret)
>  			break;
>  
> @@ -1280,7 +1285,7 @@ sx9310_get_default_reg(struct sx9310_data *data, int i,
>  
>  		break;
>  	case SX9310_REG_PROX_CTRL5:
> -		ret = of_property_read_u32(np, "semtech,startup-sensor", &start);
> +		ret = device_property_read_u32(dev, "semtech,startup-sensor", &start);
>  		if (ret) {
>  			start = FIELD_GET(SX9310_REG_PROX_CTRL5_STARTUPSENS_MASK,
>  					  reg_def->def);
> @@ -1290,7 +1295,7 @@ sx9310_get_default_reg(struct sx9310_data *data, int i,
>  		reg_def->def |= FIELD_PREP(SX9310_REG_PROX_CTRL5_STARTUPSENS_MASK,
>  					   start);
>  
> -		ret = of_property_read_u32(np, "semtech,proxraw-strength", &raw);
> +		ret = device_property_read_u32(dev, "semtech,proxraw-strength", &raw);
>  		if (ret) {
>  			raw = FIELD_GET(SX9310_REG_PROX_CTRL5_RAWFILT_MASK,
>  					reg_def->def);
> @@ -1303,7 +1308,7 @@ sx9310_get_default_reg(struct sx9310_data *data, int i,
>  					   raw);
>  		break;
>  	case SX9310_REG_PROX_CTRL7:
> -		ret = of_property_read_u32(np, "semtech,avg-pos-strength", &pos);
> +		ret = device_property_read_u32(dev, "semtech,avg-pos-strength", &pos);
>  		if (ret)
>  			break;
>  
> @@ -1339,7 +1344,7 @@ static int sx9310_init_device(struct iio_dev *indio_dev)
>  
>  	/* Program some sane defaults. */
>  	for (i = 0; i < ARRAY_SIZE(sx9310_default_regs); i++) {
> -		initval = sx9310_get_default_reg(data, i, &tmp);
> +		initval = sx9310_get_default_reg(&indio_dev->dev, i, &tmp);
>  		ret = regmap_write(data->regmap, initval->reg, initval->def);
>  		if (ret)
>  			return ret;

