Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7682B2E81
	for <lists+linux-iio@lfdr.de>; Sat, 14 Nov 2020 17:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgKNQnG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 Nov 2020 11:43:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:57920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbgKNQnG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 14 Nov 2020 11:43:06 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 926C720709;
        Sat, 14 Nov 2020 16:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605372185;
        bh=Nx3rG6IfbMv1i9YTP1H7gtdHK9WxEdOHeHtdB3jQehY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YvIxaogw1nRabWUNLyMfZjnTff/sDf8mlCkb8LHezpGaLVJ6UaSZ8W1Xwnhru9rTf
         1mAbwX0CJfiymOTdBXcoQEx+yo9u6fmxZwXiCizdJLsNuCPlP6sm0AuH58X1rMahr+
         PpSMd1CPRmB3f70OcgrzdyvTUR22w0SgaQMmjcHY=
Date:   Sat, 14 Nov 2020 16:42:59 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH 3/3 v2] iio: accel: bmc150-accel: Add rudimentary
 regulator support
Message-ID: <20201114164259.38e52abb@archlinux>
In-Reply-To: <20201112215451.2606136-3-linus.walleij@linaro.org>
References: <20201112215451.2606136-1-linus.walleij@linaro.org>
        <20201112215451.2606136-3-linus.walleij@linaro.org>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 12 Nov 2020 22:54:51 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> These Bosch accelerometers have two supplies, VDD and VDDIO.
> Add some rudimentary support to obtain and enable these
> regulators during probe() and disable them during remove()
> or on the errorpath.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Looks good.

J
> ---
> ChangeLog v1->v2:
> - Use dev_err_probe() to simplify the errorpath.
> ---
>  drivers/iio/accel/bmc150-accel-core.c | 35 +++++++++++++++++++++++++--
>  1 file changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
> index 0dafe4052856..a9714cfacf4d 100644
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
> @@ -1593,10 +1595,33 @@ int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
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
> @@ -1613,7 +1638,7 @@ int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
>  					 &bmc150_accel_buffer_ops);
>  	if (ret < 0) {
>  		dev_err(dev, "Failed: iio triggered buffer setup\n");
> -		return ret;
> +		goto err_disable_regulators;
>  	}
>  
>  	if (data->irq > 0) {
> @@ -1674,6 +1699,9 @@ int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
>  	bmc150_accel_unregister_triggers(data, BMC150_ACCEL_TRIGGERS - 1);
>  err_buffer_cleanup:
>  	iio_triggered_buffer_cleanup(indio_dev);
> +err_disable_regulators:
> +	regulator_bulk_disable(ARRAY_SIZE(data->regulators),
> +			       data->regulators);
>  
>  	return ret;
>  }
> @@ -1698,6 +1726,9 @@ int bmc150_accel_core_remove(struct device *dev)
>  	bmc150_accel_set_mode(data, BMC150_ACCEL_SLEEP_MODE_DEEP_SUSPEND, 0);
>  	mutex_unlock(&data->mutex);
>  
> +	regulator_bulk_disable(ARRAY_SIZE(data->regulators),
> +			       data->regulators);
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(bmc150_accel_core_remove);

