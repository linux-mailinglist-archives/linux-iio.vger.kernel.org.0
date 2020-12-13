Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B49E2D8D27
	for <lists+linux-iio@lfdr.de>; Sun, 13 Dec 2020 14:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729216AbgLMNES (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Dec 2020 08:04:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:47092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbgLMNES (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Dec 2020 08:04:18 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C142022EBE;
        Sun, 13 Dec 2020 13:03:35 +0000 (UTC)
Date:   Sun, 13 Dec 2020 13:03:30 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 2/2] iio: gyro: bmg160: Add rudimentary regulator
 support
Message-ID: <20201213130330.3929e956@archlinux>
In-Reply-To: <20201211183815.51269-2-stephan@gerhold.net>
References: <20201211183815.51269-1-stephan@gerhold.net>
        <20201211183815.51269-2-stephan@gerhold.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 11 Dec 2020 19:38:15 +0100
Stephan Gerhold <stephan@gerhold.net> wrote:

> BMG160 needs VDD and VDDIO regulators that might need to be explicitly
> enabled. Add some rudimentary support to obtain and enable these
> regulators during probe() and disable them using a devm action.
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
Looks good to me.  I'm going to let this sit a little longer though
(we've missed the merge window anyway so lots of time) in order to
give Linus a chance to look at this new version seeing as he
gave a Reviewed-by on previous but this is significantly different.

If it looks like I've managed to loose this (it has happened a few times!)
then please give me a poke in a few weeks time.

Thanks,

Jonathan

> ---
> Changes in v2:
>   - Do regulator_bulk_enable() immediately after devm_regulator_bulk_get()
>   - Simplify error handling using devm_add_action_or_reset()
> ---
>  drivers/iio/gyro/bmg160_core.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
> index 2d5015801a75..029ef4c34604 100644
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
> @@ -1061,6 +1063,13 @@ static const char *bmg160_match_acpi_device(struct device *dev)
>  	return dev_name(dev);
>  }
>  
> +static void bmg160_disable_regulators(void *d)
> +{
> +	struct bmg160_data *data = d;
> +
> +	regulator_bulk_disable(ARRAY_SIZE(data->regulators), data->regulators);
> +}
> +
>  int bmg160_core_probe(struct device *dev, struct regmap *regmap, int irq,
>  		      const char *name)
>  {
> @@ -1077,6 +1086,22 @@ int bmg160_core_probe(struct device *dev, struct regmap *regmap, int irq,
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
> +	ret = regulator_bulk_enable(ARRAY_SIZE(data->regulators),
> +				    data->regulators);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(dev, bmg160_disable_regulators, data);
> +	if (ret)
> +		return ret;
> +
>  	ret = iio_read_mount_matrix(dev, "mount-matrix",
>  				&data->orientation);
>  	if (ret)

