Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86C652D8F3A
	for <lists+linux-iio@lfdr.de>; Sun, 13 Dec 2020 19:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbgLMSFL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Dec 2020 13:05:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:56834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725287AbgLMSFL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Dec 2020 13:05:11 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08F83224BD;
        Sun, 13 Dec 2020 18:04:28 +0000 (UTC)
Date:   Sun, 13 Dec 2020 18:04:25 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     devajithvs <devajithvs@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Robert Yang <decatf@gmail.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: accel: kxcjk1013: Add rudimentary regulator
 support
Message-ID: <20201213180425.34eb8a3a@archlinux>
In-Reply-To: <20201213172437.2779-2-devajithvs@gmail.com>
References: <20201213172437.2779-1-devajithvs@gmail.com>
        <20201213172437.2779-2-devajithvs@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 13 Dec 2020 22:54:36 +0530
devajithvs <devajithvs@gmail.com> wrote:

> From: Devajith V S <devajithvs@gmail.com>
> 
> kxcjk1013 devices have VDD and VDDIO power lines. Need
> to make sure the regulators are enabled before any
> communication with kxcjk1013. This patch introduces
> vdd/vddio regulators for kxcjk1013.
> 
> Signed-off-by: Devajith V S <devajithvs@gmail.com>
Looks good to me. Trivial comment on the comment inline that I can fix
whilst applying.

I'll let this sit on the list for a little while though in case
anyone else spots something I have missed.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/kxcjk-1013.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> index e92c7e676..67d3d8270 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -14,6 +14,7 @@
>  #include <linux/acpi.h>
>  #include <linux/pm.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  #include <linux/iio/buffer.h>
> @@ -133,6 +134,7 @@ enum kx_acpi_type {
>  };
>  
>  struct kxcjk1013_data {
> +	struct regulator_bulk_data regulators[2];
>  	struct i2c_client *client;
>  	struct iio_trigger *dready_trig;
>  	struct iio_trigger *motion_trig;
> @@ -1300,6 +1302,13 @@ static const char *kxcjk1013_match_acpi_device(struct device *dev,
>  	return dev_name(dev);
>  }
>  
> +static void kxcjk1013_disable_regulators(void *d)
> +{
> +	struct kxcjk1013_data *data = d;
> +
> +	regulator_bulk_disable(ARRAY_SIZE(data->regulators), data->regulators);
> +}
> +
>  static int kxcjk1013_probe(struct i2c_client *client,
>  			   const struct i2c_device_id *id)
>  {
> @@ -1330,6 +1339,28 @@ static int kxcjk1013_probe(struct i2c_client *client,
>  			return ret;
>  	}
>  
> +	data->regulators[0].supply = "vdd";
> +	data->regulators[1].supply = "vddio";
> +	ret = devm_regulator_bulk_get(&client->dev, ARRAY_SIZE(data->regulators),
> +				      data->regulators);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret, "Failed to get regulators\n");
> +
> +	ret = regulator_bulk_enable(ARRAY_SIZE(data->regulators),
> +				    data->regulators);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(&client->dev, kxcjk1013_disable_regulators, data);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * A typical delay of 10ms is required for powering up
> +	 * according to the data sheets of supported chips.

Probably want to add something like "so double it to play safe."

> +	 */
> +	msleep(20);
> +
>  	if (id) {
>  		data->chipset = (enum kx_chipset)(id->driver_data);
>  		name = id->name;

