Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1E092A219F
	for <lists+linux-iio@lfdr.de>; Sun,  1 Nov 2020 21:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgKAUwY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Nov 2020 15:52:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:37052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726873AbgKAUwY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 1 Nov 2020 15:52:24 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB878221FC;
        Sun,  1 Nov 2020 20:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604263943;
        bh=Hm/e0lu/lYOoNysyeNbD7A4QIQFj7Vs44g0ZeBDAeyY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LXU+JdfkFmt7cV8sVOsnC3F8mT/Bdk6TSLIqsy0uM5xjP5qiwDIPhiMapCVTAWE0j
         WP6BMThety/jJytECLvRLMTAQTj/KW19TZUZcEVuD++51fzp1EnA4bQDFFznYrksP2
         /zAbzKL8lZUhkD0O0KLP52v2rAvoh0uRtyyzeRwM=
Date:   Sun, 1 Nov 2020 20:52:19 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: accel: bmc150-accel: Add rudimentary regulator
 support
Message-ID: <20201101205219.63ca6485@archlinux>
In-Reply-To: <20201101122833.1111424-3-linus.walleij@linaro.org>
References: <20201101122833.1111424-1-linus.walleij@linaro.org>
        <20201101122833.1111424-3-linus.walleij@linaro.org>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun,  1 Nov 2020 13:28:33 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> These Bosch accelerometers have two supplies, VDD and VDDIO.
> Add some rudimentary support to obtain and enable these
> regulators during probe() and disable them during remove()
> or on the errorpath.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Minor suggestion inline using new dev_err_probe()

thanks,

Jonathan
> ---
>  drivers/iio/accel/bmc150-accel-core.c | 37 +++++++++++++++++++++++++--
>  1 file changed, 35 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
> index 0dafe4052856..a69a4f54d69a 100644
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
> @@ -1593,10 +1595,35 @@ int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
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
> +	if (ret) {
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(dev, "Failed to get regulators %d\n", ret);
We have a magic print function for this now

return dev_err_probe(ret, "Failed to get regulators\n");

should do the job I think...

> +		return ret;
> +	}
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
> @@ -1613,7 +1640,7 @@ int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
>  					 &bmc150_accel_buffer_ops);
>  	if (ret < 0) {
>  		dev_err(dev, "Failed: iio triggered buffer setup\n");
> -		return ret;
> +		goto err_disable_regulators;
>  	}
>  
>  	if (data->irq > 0) {
> @@ -1674,6 +1701,9 @@ int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
>  	bmc150_accel_unregister_triggers(data, BMC150_ACCEL_TRIGGERS - 1);
>  err_buffer_cleanup:
>  	iio_triggered_buffer_cleanup(indio_dev);
> +err_disable_regulators:
> +	regulator_bulk_disable(ARRAY_SIZE(data->regulators),
> +			       data->regulators);
>  
>  	return ret;
>  }
> @@ -1698,6 +1728,9 @@ int bmc150_accel_core_remove(struct device *dev)
>  	bmc150_accel_set_mode(data, BMC150_ACCEL_SLEEP_MODE_DEEP_SUSPEND, 0);
>  	mutex_unlock(&data->mutex);
>  
> +	regulator_bulk_disable(ARRAY_SIZE(data->regulators),
> +			       data->regulators);
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(bmc150_accel_core_remove);

