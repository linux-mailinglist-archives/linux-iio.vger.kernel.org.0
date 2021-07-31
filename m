Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62FF93DC644
	for <lists+linux-iio@lfdr.de>; Sat, 31 Jul 2021 16:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbhGaOSf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Jul 2021 10:18:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:39452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232752AbhGaOSe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Jul 2021 10:18:34 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EF3360F48;
        Sat, 31 Jul 2021 14:18:25 +0000 (UTC)
Date:   Sat, 31 Jul 2021 15:21:05 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     lars@metafoo.de, swboyd@chromium.org, campello@chromium.org,
        andy.shevchenko@gmail.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH v5] iio: sx9310: Support ACPI property
Message-ID: <20210731152105.3ce8cfd6@jic23-huawei>
In-Reply-To: <20210728181757.187627-1-gwendal@chromium.org>
References: <20210728181757.187627-1-gwendal@chromium.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 28 Jul 2021 11:17:57 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> Use device_property_read_... to support both device tree and ACPI
> bindings.
> Simplify the logic for reading "combined-sensors" array, as we assume
> it has been vetted at firmware build time.

I wondered a bit about this assumption.  Always dangerous to assume firmware
writers will get this stuff right.  However, the result of them doing that
here would be that you'd end up with some unexpected bits set and hence it
would match none of the if/else branches.   That looks bad until you check
what the default will be and it's a valid mode anyway so we are fine.

So whilst my inclination would probably have been to not remove the check
to make this a tiny bit easier to review, now I've gone to that effort
I'll apply it as is.

Applied to the togreg branch of iio.git and pushed out as testing for 0-day
to poke at it and see if we missed anything.

Thanks,

Jonathan



> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>

> ---
>  Changes since v4:
>    Separate the patch in 2, the fix for 5b19ca2c78a0 ("iio: sx9310: Set various settings from DT")
>    went in f0078ae704d9 ("iio: sx9310: Fix access to variable DT array")
>    Simplify decoding of "combined-sensors" array, assuming it formatted
>    properly when available.
>  Changes since v3:
>    Add "Fixes" comment in commit message
>    Fix the logic set COMBMODE register: when we know the DT property is
>    missing or incorrect, exit as soon as possible.
>  Changes since v2:
>    Add comment how the default array is used.
>    Add comment in commit message to indicate this CL fix an issue with
>      existing use of of_property_read_u32_array() when reading a variale
>      length array.
>  Changes since v1:
>    Use device_property_count_u32(...) instead of device_property_read_u32_array(..., NULL, 0)
> 
>  drivers/iio/proximity/sx9310.c | 48 ++++++++++++----------------------
>  1 file changed, 16 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
> index 36d34e308e873..6708c3a7886e8 100644
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
> @@ -1223,10 +1224,9 @@ static int sx9310_init_compensation(struct iio_dev *indio_dev)
>  }
>  
>  static const struct sx9310_reg_default *
> -sx9310_get_default_reg(struct sx9310_data *data, int idx,
> +sx9310_get_default_reg(struct device *dev, int idx,
>  		       struct sx9310_reg_default *reg_def)
>  {
> -	const struct device_node *np = data->client->dev.of_node;
>  	u32 combined[SX9310_NUM_CHANNELS];
>  	u32 start = 0, raw = 0, pos = 0;
>  	unsigned long comb_mask = 0;
> @@ -1234,40 +1234,24 @@ sx9310_get_default_reg(struct sx9310_data *data, int idx,
>  	const char *res;
>  
>  	memcpy(reg_def, &sx9310_default_regs[idx], sizeof(*reg_def));
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
> -		count = of_property_count_elems_of_size(np, "semtech,combined-sensors",
> -							sizeof(u32));
> -		if (count > 0 && count <= ARRAY_SIZE(combined)) {
> -			ret = of_property_read_u32_array(np, "semtech,combined-sensors",
> -							 combined, count);
> -			if (ret)
> -				break;
> -		} else {
> -			/*
> -			 * Either the property does not exist in the DT or the
> -			 * number of entries is incorrect.
> -			 */
> +		count = device_property_count_u32(dev, "semtech,combined-sensors");
> +		if (count < 0 || count > ARRAY_SIZE(combined))
>  			break;
> -		}
> -		for (i = 0; i < count; i++) {
> -			if (combined[i] >= SX9310_NUM_CHANNELS) {
> -				/* Invalid sensor (invalid DT). */
> -				break;
> -			}
> -			comb_mask |= BIT(combined[i]);
> -		}
> -		if (i < count)
> +		ret = device_property_read_u32_array(dev, "semtech,combined-sensors",
> +				combined, count);
> +		if (ret)
>  			break;
>  
> +		for (i = 0; i < count; i++)
> +			comb_mask |= BIT(combined[i]);
> +
>  		reg_def->def &= ~SX9310_REG_PROX_CTRL2_COMBMODE_MASK;
>  		if (comb_mask == (BIT(3) | BIT(2) | BIT(1) | BIT(0)))
>  			reg_def->def |= SX9310_REG_PROX_CTRL2_COMBMODE_CS0_CS1_CS2_CS3;
> @@ -1280,7 +1264,7 @@ sx9310_get_default_reg(struct sx9310_data *data, int idx,
>  
>  		break;
>  	case SX9310_REG_PROX_CTRL4:
> -		ret = of_property_read_string(np, "semtech,resolution", &res);
> +		ret = device_property_read_string(dev, "semtech,resolution", &res);
>  		if (ret)
>  			break;
>  
> @@ -1304,7 +1288,7 @@ sx9310_get_default_reg(struct sx9310_data *data, int idx,
>  
>  		break;
>  	case SX9310_REG_PROX_CTRL5:
> -		ret = of_property_read_u32(np, "semtech,startup-sensor", &start);
> +		ret = device_property_read_u32(dev, "semtech,startup-sensor", &start);
>  		if (ret) {
>  			start = FIELD_GET(SX9310_REG_PROX_CTRL5_STARTUPSENS_MASK,
>  					  reg_def->def);
> @@ -1314,7 +1298,7 @@ sx9310_get_default_reg(struct sx9310_data *data, int idx,
>  		reg_def->def |= FIELD_PREP(SX9310_REG_PROX_CTRL5_STARTUPSENS_MASK,
>  					   start);
>  
> -		ret = of_property_read_u32(np, "semtech,proxraw-strength", &raw);
> +		ret = device_property_read_u32(dev, "semtech,proxraw-strength", &raw);
>  		if (ret) {
>  			raw = FIELD_GET(SX9310_REG_PROX_CTRL5_RAWFILT_MASK,
>  					reg_def->def);
> @@ -1327,7 +1311,7 @@ sx9310_get_default_reg(struct sx9310_data *data, int idx,
>  					   raw);
>  		break;
>  	case SX9310_REG_PROX_CTRL7:
> -		ret = of_property_read_u32(np, "semtech,avg-pos-strength", &pos);
> +		ret = device_property_read_u32(dev, "semtech,avg-pos-strength", &pos);
>  		if (ret)
>  			break;
>  
> @@ -1363,7 +1347,7 @@ static int sx9310_init_device(struct iio_dev *indio_dev)
>  
>  	/* Program some sane defaults. */
>  	for (i = 0; i < ARRAY_SIZE(sx9310_default_regs); i++) {
> -		initval = sx9310_get_default_reg(data, i, &tmp);
> +		initval = sx9310_get_default_reg(&indio_dev->dev, i, &tmp);
>  		ret = regmap_write(data->regmap, initval->reg, initval->def);
>  		if (ret)
>  			return ret;

