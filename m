Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14ED9129940
	for <lists+linux-iio@lfdr.de>; Mon, 23 Dec 2019 18:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfLWRUp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Dec 2019 12:20:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:51916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726907AbfLWRUp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Dec 2019 12:20:45 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9449F20715;
        Mon, 23 Dec 2019 17:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577121644;
        bh=mG3jWs3C23Ef+pdTe8I8KmB22fvJ7thEhMEGvnXfGTo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dH4P/pv6suDCyy7+W2WWXXtQIj5gPzg4UnPU0Sq1Heer6OykcZytFL8SGqGWHhzvT
         9FS9sX81P0kx5qF09M+r32K85jhNJd2r4hiI0ojW2ba6zvJ1+921gQaltJF6SqTGHl
         oFLnZBI+hd4pb+GW0TSYhPUFh0P1PV3OHi/z2XTE=
Date:   Mon, 23 Dec 2019 17:20:40 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
Subject: Re: [PATCH 2/4] iio: accel: bma180: Basic regulator support
Message-ID: <20191223172040.176524aa@archlinux>
In-Reply-To: <20191211213819.14024-2-linus.walleij@linaro.org>
References: <20191211213819.14024-1-linus.walleij@linaro.org>
        <20191211213819.14024-2-linus.walleij@linaro.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 11 Dec 2019 22:38:17 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> This brings up the VDD and VDDIO regulators using the
> regulator framework. Platforms that do not use regulators
> will provide stubs or dummy regulators.
> 
> Cc: Peter Meerwald <pmeerw@pmeerw.net>
> Cc: Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
I made a totally trivial tweak. See below.

Applied to the togreg branch of iio.git and pushed out as testing..

etc. etc.

Jonathan

> ---
>  drivers/iio/accel/bma180.c | 43 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
> index 518efbe4eaf6..4a619b5a544a 100644
> --- a/drivers/iio/accel/bma180.c
> +++ b/drivers/iio/accel/bma180.c
> @@ -18,6 +18,7 @@
>  #include <linux/of_device.h>
>  #include <linux/of.h>
>  #include <linux/bitops.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/slab.h>
>  #include <linux/string.h>
>  #include <linux/iio/iio.h>
> @@ -110,6 +111,8 @@ struct bma180_part_info {
>  #define BMA250_INT_RESET_MASK	BIT(7) /* Reset pending interrupts */
>  
>  struct bma180_data {
> +	struct regulator *vdd_supply;
> +	struct regulator *vddio_supply;
>  	struct i2c_client *client;
>  	struct iio_trigger *trig;
>  	const struct bma180_part_info *part_info;
> @@ -736,6 +739,40 @@ static int bma180_probe(struct i2c_client *client,
>  	if (ret)
>  		return ret;
>  
> +	data->vdd_supply = devm_regulator_get(dev, "vdd");
> +	if (IS_ERR(data->vdd_supply)) {
> +		if (PTR_ERR(data->vdd_supply) != -EPROBE_DEFER)
> +			dev_err(dev, "Failed to get vdd regulator %d\n",
> +				(int)PTR_ERR(data->vdd_supply));
> +		return PTR_ERR(data->vdd_supply);
> +	}
> +	data->vddio_supply = devm_regulator_get(dev, "vddio");
> +	if (IS_ERR(data->vddio_supply)) {
> +		if (PTR_ERR(data->vddio_supply) != -EPROBE_DEFER)
> +			dev_err(dev, "Failed to get vddio regulator %d\n",
> +				(int)PTR_ERR(data->vddio_supply));
> +		return PTR_ERR(data->vddio_supply);
> +	}
> +	/* Typical voltage 2.4V these are min and max */
> +	ret = regulator_set_voltage(data->vdd_supply, 1620000, 3600000);
> +	if (ret)
> +		return ret;
> +	ret = regulator_set_voltage(data->vddio_supply, 1200000, 3600000);
> +	if (ret)
> +		return ret;
> +	ret = regulator_enable(data->vdd_supply);
> +	if (ret) {
> +		dev_err(dev, "Failed to enable vdd regulator: %d\n", ret);
> +		return ret;
> +	}
> +	ret = regulator_enable(data->vddio_supply);
> +	if (ret) {
> +		dev_err(dev, "Failed to enable vddio regulator: %d\n", ret);
> +		goto err_disable_vdd;
> +	}
> +	/* Wait to make sure we started up properly (3 ms at least) */
> +	usleep_range(3000, 5000);
> +
>  	ret = data->part_info->chip_config(data);
>  	if (ret < 0)
>  		goto err_chip_disable;
> @@ -798,7 +835,9 @@ static int bma180_probe(struct i2c_client *client,
>  	iio_trigger_free(data->trig);
>  err_chip_disable:
>  	data->part_info->chip_disable(data);
> -
If I were feeling really nit pick friendly.  Don't mess with the whitespace!

> +	regulator_disable(data->vddio_supply);
> +err_disable_vdd:
> +	regulator_disable(data->vdd_supply);
>  	return ret;
>  }
>  
> @@ -817,6 +856,8 @@ static int bma180_remove(struct i2c_client *client)
>  	mutex_lock(&data->mutex);
>  	data->part_info->chip_disable(data);
>  	mutex_unlock(&data->mutex);
> +	regulator_disable(data->vddio_supply);
> +	regulator_disable(data->vdd_supply);
>  
>  	return 0;
>  }

