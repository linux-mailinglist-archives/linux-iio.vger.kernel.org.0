Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91A792CFDDB
	for <lists+linux-iio@lfdr.de>; Sat,  5 Dec 2020 19:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbgLESpU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Dec 2020 13:45:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:49662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726932AbgLEQtb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Dec 2020 11:49:31 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C704D20731;
        Sat,  5 Dec 2020 15:38:51 +0000 (UTC)
Date:   Sat, 5 Dec 2020 15:38:48 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 4/4] iio: gyro: bmg160: Add rudimentary regulator
 support
Message-ID: <20201205153848.697c77a5@archlinux>
In-Reply-To: <20201202093322.77114-4-stephan@gerhold.net>
References: <20201202093322.77114-1-stephan@gerhold.net>
        <20201202093322.77114-4-stephan@gerhold.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed,  2 Dec 2020 10:33:22 +0100
Stephan Gerhold <stephan@gerhold.net> wrote:

> BMG160 needs VDD and VDDIO regulators that might need to be explicitly
> enabled. Add some rudimentary support to obtain and enable these
> regulators during probe() and disable them during remove()
> or on the error path.
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>

Hi Stephan,

This one is a bit tricky due to the extensive use of devm_ managed
cleanup.  Normally I'd be very fussy about ensuring remove order
is precise reverse of probe, but in this driver it isn't quite
already, due to that chip_init being before the interrupt allocation.

Having said that I'd rather not make it worse.  Would you mind
using automated clean up of the regulator_enable as well via
devm_add_action_or_reset() call?

As a side note, should we not have more cleanup of chip_init()
in error paths, specifically putting the device into it's suspended
mode?  Obviously nothing to do with your patch...

Thanks,

Jonathan

> ---
>  drivers/iio/gyro/bmg160_core.c | 38 +++++++++++++++++++++++++++-------
>  1 file changed, 31 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
> index 2d5015801a75..4baa4169c5a2 100644
> --- a/drivers/iio/gyro/bmg160_core.c
> +++ b/drivers/iio/gyro/bmg160_core.c
> @@ -19,6 +19,7 @@
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/iio/triggered_buffer.h>
>  #include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
>  #include "bmg160.h"
>  
>  #define BMG160_IRQ_NAME		"bmg160_event"
> @@ -92,6 +93,7 @@
>  
>  struct bmg160_data {
>  	struct regmap *regmap;
> +	struct regulator_bulk_data regulators[2];
>  	struct iio_trigger *dready_trig;
>  	struct iio_trigger *motion_trig;
>  	struct iio_mount_matrix orientation;
> @@ -1077,14 +1079,28 @@ int bmg160_core_probe(struct device *dev, struct regmap *regmap, int irq,
>  	data->irq = irq;
>  	data->regmap = regmap;
>  
> +	data->regulators[0].supply = "vdd";
> +	data->regulators[1].supply = "vddio";
> +	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(data->regulators),
> +				      data->regulators);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get regulators\n");
> +
>  	ret = iio_read_mount_matrix(dev, "mount-matrix",
>  				&data->orientation);
>  	if (ret)
>  		return ret;

Why not put regulator get and enable together?  

>  
> +	ret = regulator_bulk_enable(ARRAY_SIZE(data->regulators),
> +				    data->regulators);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to enable regulators: %d\n", ret);
> +		return ret;
> +	}
> +

If you were to use devm_add_action_or_reset() and a trivial wrapper
the disable would be automated, simplifying the error handling etc.

>  	ret = bmg160_chip_init(data);
>  	if (ret < 0)
> -		return ret;
> +		goto err_regulator_disable;
>  
>  	mutex_init(&data->mutex);
>  
> @@ -1107,28 +1123,32 @@ int bmg160_core_probe(struct device *dev, struct regmap *regmap, int irq,
>  						BMG160_IRQ_NAME,
>  						indio_dev);
>  		if (ret)
> -			return ret;
> +			goto err_regulator_disable;
>  
>  		data->dready_trig = devm_iio_trigger_alloc(dev,
>  							   "%s-dev%d",
>  							   indio_dev->name,
>  							   indio_dev->id);
> -		if (!data->dready_trig)
> -			return -ENOMEM;
> +		if (!data->dready_trig) {
> +			ret = -ENOMEM;
> +			goto err_regulator_disable;
> +		}
>  
>  		data->motion_trig = devm_iio_trigger_alloc(dev,
>  							  "%s-any-motion-dev%d",
>  							  indio_dev->name,
>  							  indio_dev->id);
> -		if (!data->motion_trig)
> -			return -ENOMEM;
> +		if (!data->motion_trig) {
> +			ret = -ENOMEM;
> +			goto err_regulator_disable;
> +		}
>  
>  		data->dready_trig->dev.parent = dev;
>  		data->dready_trig->ops = &bmg160_trigger_ops;
>  		iio_trigger_set_drvdata(data->dready_trig, indio_dev);
>  		ret = iio_trigger_register(data->dready_trig);
>  		if (ret)
> -			return ret;
> +			goto err_regulator_disable;
>  
>  		data->motion_trig->dev.parent = dev;
>  		data->motion_trig->ops = &bmg160_trigger_ops;
> @@ -1174,6 +1194,8 @@ int bmg160_core_probe(struct device *dev, struct regmap *regmap, int irq,
>  		iio_trigger_unregister(data->dready_trig);
>  	if (data->motion_trig)
>  		iio_trigger_unregister(data->motion_trig);
> +err_regulator_disable:
> +	regulator_bulk_disable(ARRAY_SIZE(data->regulators), data->regulators);
>  
>  	return ret;
>  }
> @@ -1200,6 +1222,8 @@ void bmg160_core_remove(struct device *dev)
>  	mutex_lock(&data->mutex);
>  	bmg160_set_mode(data, BMG160_MODE_DEEP_SUSPEND);
>  	mutex_unlock(&data->mutex);
> +
> +	regulator_bulk_disable(ARRAY_SIZE(data->regulators), data->regulators);
>  }
>  EXPORT_SYMBOL_GPL(bmg160_core_remove);
>  

