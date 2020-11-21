Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF012BC09D
	for <lists+linux-iio@lfdr.de>; Sat, 21 Nov 2020 17:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbgKUQpM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Nov 2020 11:45:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:59852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726580AbgKUQpM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Nov 2020 11:45:12 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6DE222206;
        Sat, 21 Nov 2020 16:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605977111;
        bh=vRkBpia8JLsIKlMg9vKYHzNNReo6cDTdQUGHnEM+HqU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BzS3boMvLWnxo3wsp2WDJNsnDga/6UqXZ/GEpTRX/8ypFji7t2vWE8gWa85F+uhff
         M1F5by4dcwiD6CbAAckovKNTKjuNER1nEhJG8MFmKHaeUX9x+hvWkEDprXMdk5+2OF
         BUFassEav9sBMZXowmbnXfinzbmtJBXzvLrxcyik=
Date:   Sat, 21 Nov 2020 16:45:05 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH 3/3 v3] iio: accel: bmc150-accel: Add rudimentary
 regulator support
Message-ID: <20201121164505.30767f9f@archlinux>
In-Reply-To: <20201115205745.618455-3-linus.walleij@linaro.org>
References: <20201115205745.618455-1-linus.walleij@linaro.org>
        <20201115205745.618455-3-linus.walleij@linaro.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 15 Nov 2020 21:57:45 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> These Bosch accelerometers have two supplies, VDD and VDDIO.
> Add some rudimentary support to obtain and enable these
> regulators during probe() and disable them during remove()
> or on the errorpath.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
All looks good to me.  Will leave it for a bit longer though to let
Rob have a chance to look at the dt binding doc.

As ever, if it seems to have gotten lost it is probably worth
poking me.

Thanks,

Jonathan
> ---
> ChangeLog v2->v3:
> - Resend with the rest.
> ChangeLog v1->v2:
> - Use dev_err_probe() to simplify the errorpath.
> ---
>  drivers/iio/accel/bmc150-accel-core.c | 35 +++++++++++++++++++++++++--
>  1 file changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
> index 01dbc01e328f..caa984612e88 100644
> --- a/drivers/iio/accel/bmc150-accel-core.c
> +++ b/drivers/iio/accel/bmc150-accel-core.c
> @@ -28,6 +28,7 @@
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/iio/triggered_buffer.h>
>  #include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
>  
>  #include "bmc150-accel.h"
>  
> @@ -184,6 +185,7 @@ enum bmc150_accel_trigger_id {
>  
>  struct bmc150_accel_data {
>  	struct regmap *regmap;
> +	struct regulator_bulk_data regulators[2];
>  	int irq;
>  	struct bmc150_accel_interrupt interrupts[BMC150_ACCEL_INTERRUPTS];
>  	struct bmc150_accel_trigger triggers[BMC150_ACCEL_TRIGGERS];
> @@ -1591,10 +1593,33 @@ int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
>  				     &data->orientation);
>  	if (ret)
>  		return ret;
> +	/*
> +	 * VDD   is the analog and digital domain voltage supply
> +	 * VDDIO is the digital I/O voltage supply
> +	 */
> +	data->regulators[0].supply = "vdd";
> +	data->regulators[1].supply = "vddio";
> +	ret = devm_regulator_bulk_get(dev,
> +				      ARRAY_SIZE(data->regulators),
> +				      data->regulators);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to get regulators\n");
> +
> +	ret = regulator_bulk_enable(ARRAY_SIZE(data->regulators),
> +				    data->regulators);
> +	if (ret) {
> +		dev_err(dev, "failed to enable regulators: %d\n", ret);
> +		return ret;
> +	}
> +	/*
> +	 * 2ms or 3ms power-on time according to datasheets, let's better
> +	 * be safe than sorry and set this delay to 5ms.
> +	 */
> +	msleep(5);
>  
>  	ret = bmc150_accel_chip_init(data);
>  	if (ret < 0)
> -		return ret;
> +		goto err_disable_regulators;
>  
>  	mutex_init(&data->mutex);
>  
> @@ -1611,7 +1636,7 @@ int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
>  					 &bmc150_accel_buffer_ops);
>  	if (ret < 0) {
>  		dev_err(dev, "Failed: iio triggered buffer setup\n");
> -		return ret;
> +		goto err_disable_regulators;
>  	}
>  
>  	if (data->irq > 0) {
> @@ -1672,6 +1697,9 @@ int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
>  	bmc150_accel_unregister_triggers(data, BMC150_ACCEL_TRIGGERS - 1);
>  err_buffer_cleanup:
>  	iio_triggered_buffer_cleanup(indio_dev);
> +err_disable_regulators:
> +	regulator_bulk_disable(ARRAY_SIZE(data->regulators),
> +			       data->regulators);
>  
>  	return ret;
>  }
> @@ -1696,6 +1724,9 @@ int bmc150_accel_core_remove(struct device *dev)
>  	bmc150_accel_set_mode(data, BMC150_ACCEL_SLEEP_MODE_DEEP_SUSPEND, 0);
>  	mutex_unlock(&data->mutex);
>  
> +	regulator_bulk_disable(ARRAY_SIZE(data->regulators),
> +			       data->regulators);
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(bmc150_accel_core_remove);

