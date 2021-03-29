Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55CF034CFE2
	for <lists+linux-iio@lfdr.de>; Mon, 29 Mar 2021 14:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbhC2MS4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Mar 2021 08:18:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:33614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229689AbhC2MS3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 29 Mar 2021 08:18:29 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 781F460235;
        Mon, 29 Mar 2021 12:18:25 +0000 (UTC)
Date:   Mon, 29 Mar 2021 13:18:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     lars@metafoo.de, swboyd@chromium.org, campello@chromium.org,
        andy.shevchenko@gmail.com, ardeleanalex@gmail.com,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v7 1/2] iio: sx9310: Fix access to variable DT array
Message-ID: <20210329131831.7eff5058@jic23-huawei>
In-Reply-To: <20210326184603.251683-2-gwendal@chromium.org>
References: <20210326184603.251683-1-gwendal@chromium.org>
        <20210326184603.251683-2-gwendal@chromium.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 26 Mar 2021 11:46:02 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> With the current code, we want to read 4 entries from DT array
> "semtech,combined-sensors". If there are less, we silently fail as
> of_property_read_u32_array() returns -EOVERFLOW.
> 
> First count the number of entries and if between 1 and 4, collect the
> content of the array.
> 
> Fixes: 5b19ca2c78a0 ("iio: sx9310: Set various settings from DT")
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Applying this one to the fixes-togreg branch of iio.git.

As the second patch isn't a fix it might take a while to get applied.
Gwendal, feel free to poke me if I seem to have lost it after the first
patch reaches my togreg branch.

Thanks,

Jonathan

> ---
>  No changes in v7.
> 
>  Changes in v6:
>  Fix error in of_property_count_elems_of_size() argumnent:
>  Used ARRAY_SIZE(combined) [4] instead of sizeof(u32).
> 
>  Changes in v5:
>  new, split fixes from changes needed for ACPI support.
> 
>  drivers/iio/proximity/sx9310.c | 40 ++++++++++++++++++++++++----------
>  1 file changed, 28 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
> index 394c2afe0f233..289c76bb3b024 100644
> --- a/drivers/iio/proximity/sx9310.c
> +++ b/drivers/iio/proximity/sx9310.c
> @@ -1213,17 +1213,17 @@ static int sx9310_init_compensation(struct iio_dev *indio_dev)
>  }
>  
>  static const struct sx9310_reg_default *
> -sx9310_get_default_reg(struct sx9310_data *data, int i,
> +sx9310_get_default_reg(struct sx9310_data *data, int idx,
>  		       struct sx9310_reg_default *reg_def)
>  {
> -	int ret;
>  	const struct device_node *np = data->client->dev.of_node;
> -	u32 combined[SX9310_NUM_CHANNELS] = { 4, 4, 4, 4 };
> +	u32 combined[SX9310_NUM_CHANNELS];
> +	u32 start = 0, raw = 0, pos = 0;
>  	unsigned long comb_mask = 0;
> +	int ret, i, count;
>  	const char *res;
> -	u32 start = 0, raw = 0, pos = 0;
>  
> -	memcpy(reg_def, &sx9310_default_regs[i], sizeof(*reg_def));
> +	memcpy(reg_def, &sx9310_default_regs[idx], sizeof(*reg_def));
>  	if (!np)
>  		return reg_def;
>  
> @@ -1234,15 +1234,31 @@ sx9310_get_default_reg(struct sx9310_data *data, int i,
>  			reg_def->def |= SX9310_REG_PROX_CTRL2_SHIELDEN_GROUND;
>  		}
>  
> -		reg_def->def &= ~SX9310_REG_PROX_CTRL2_COMBMODE_MASK;
> -		of_property_read_u32_array(np, "semtech,combined-sensors",
> -					   combined, ARRAY_SIZE(combined));
> -		for (i = 0; i < ARRAY_SIZE(combined); i++) {
> -			if (combined[i] <= SX9310_NUM_CHANNELS)
> -				comb_mask |= BIT(combined[i]);
> +		count = of_property_count_elems_of_size(np, "semtech,combined-sensors",
> +							sizeof(u32));
> +		if (count > 0 && count <= ARRAY_SIZE(combined)) {
> +			ret = of_property_read_u32_array(np, "semtech,combined-sensors",
> +							 combined, count);
> +			if (ret)
> +				break;
> +		} else {
> +			/*
> +			 * Either the property does not exist in the DT or the
> +			 * number of entries is incorrect.
> +			 */
> +			break;
> +		}
> +		for (i = 0; i < count; i++) {
> +			if (combined[i] >= SX9310_NUM_CHANNELS) {
> +				/* Invalid sensor (invalid DT). */
> +				break;
> +			}
> +			comb_mask |= BIT(combined[i]);
>  		}
> +		if (i < count)
> +			break;
>  
> -		comb_mask &= 0xf;
> +		reg_def->def &= ~SX9310_REG_PROX_CTRL2_COMBMODE_MASK;
>  		if (comb_mask == (BIT(3) | BIT(2) | BIT(1) | BIT(0)))
>  			reg_def->def |= SX9310_REG_PROX_CTRL2_COMBMODE_CS0_CS1_CS2_CS3;
>  		else if (comb_mask == (BIT(1) | BIT(2)))

