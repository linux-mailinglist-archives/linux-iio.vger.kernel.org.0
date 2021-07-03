Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 937013BA963
	for <lists+linux-iio@lfdr.de>; Sat,  3 Jul 2021 18:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbhGCQMl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 3 Jul 2021 12:12:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:41214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229463AbhGCQMl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 3 Jul 2021 12:12:41 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6F2A616EC;
        Sat,  3 Jul 2021 16:10:03 +0000 (UTC)
Date:   Sat, 3 Jul 2021 17:12:27 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, lars@metafoo.de,
        sre@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org, leonard.crestez@nxp.com,
        letux-kernel@openphoenux.org
Subject: Re: [PATCH 4/4] power: supply: rn5t618: Add voltage_now property
Message-ID: <20210703171227.77e36483@jic23-huawei>
In-Reply-To: <20210703084224.31623-5-andreas@kemnade.info>
References: <20210703084224.31623-1-andreas@kemnade.info>
        <20210703084224.31623-5-andreas@kemnade.info>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat,  3 Jul 2021 10:42:24 +0200
Andreas Kemnade <andreas@kemnade.info> wrote:

> Read voltage_now via IIO and provide the property.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

Hi Andreas,

One comment inline, but looks fine to me in general.

> ---
>  drivers/power/supply/rn5t618_power.c | 56 ++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
> 
> diff --git a/drivers/power/supply/rn5t618_power.c b/drivers/power/supply/rn5t618_power.c
> index 819061918b2a..b062208c8a91 100644
> --- a/drivers/power/supply/rn5t618_power.c
> +++ b/drivers/power/supply/rn5t618_power.c
> @@ -9,10 +9,12 @@
>  #include <linux/device.h>
>  #include <linux/bitops.h>
>  #include <linux/errno.h>
> +#include <linux/iio/consumer.h>
>  #include <linux/init.h>
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
>  #include <linux/mfd/rn5t618.h>
> +#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/power_supply.h>
>  #include <linux/regmap.h>
> @@ -64,6 +66,8 @@ struct rn5t618_power_info {
>  	struct power_supply *battery;
>  	struct power_supply *usb;
>  	struct power_supply *adp;
> +	struct iio_channel *channel_vusb;
> +	struct iio_channel *channel_vadp;
>  	int irq;
>  };
>  
> @@ -77,6 +81,7 @@ static enum power_supply_usb_type rn5t618_usb_types[] = {
>  static enum power_supply_property rn5t618_usb_props[] = {
>  	/* input current limit is not very accurate */
>  	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
>  	POWER_SUPPLY_PROP_STATUS,
>  	POWER_SUPPLY_PROP_USB_TYPE,
>  	POWER_SUPPLY_PROP_ONLINE,
> @@ -85,6 +90,7 @@ static enum power_supply_property rn5t618_usb_props[] = {
>  static enum power_supply_property rn5t618_adp_props[] = {
>  	/* input current limit is not very accurate */
>  	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
>  	POWER_SUPPLY_PROP_STATUS,
>  	POWER_SUPPLY_PROP_ONLINE,
>  };
> @@ -464,6 +470,16 @@ static int rn5t618_adp_get_property(struct power_supply *psy,
>  
>  		val->intval = FROM_CUR_REG(regval);
>  		break;
> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +		if (!info->channel_vadp)
> +			return -ENODATA;
> +
> +		ret = iio_read_channel_processed(info->channel_vadp, &val->intval);
> +		if (ret < 0)
> +			return ret;
> +
> +		val->intval *= 1000;
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -589,6 +605,16 @@ static int rn5t618_usb_get_property(struct power_supply *psy,
>  			val->intval = FROM_CUR_REG(regval);
>  		}
>  		break;
> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +		if (!info->channel_vusb)
> +			return -ENODATA;
> +
> +		ret = iio_read_channel_processed(info->channel_vusb, &val->intval);
> +		if (ret < 0)
> +			return ret;
> +
> +		val->intval *= 1000;
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -711,6 +737,28 @@ static int rn5t618_power_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, info);
>  
> +	info->channel_vusb = devm_iio_channel_get(&pdev->dev, "vusb");
> +	if (IS_ERR(info->channel_vusb)) {
> +		ret = PTR_ERR(info->channel_vusb);
> +		if (ret == -EPROBE_DEFER)
> +			return ret;
> +
> +		dev_warn(&pdev->dev, "could not request vusb iio channel (%d)",
> +			 ret);

I wonder if you should distinguish between -ENODEV to indicate there wasn't
one specified vs something else when wrong.   Might not be worth bothering
as there are not many things that could go wrong (things like small memory
allocations which will never fail..)

> +		info->channel_vusb = NULL;
> +	}
> +
> +	info->channel_vadp = devm_iio_channel_get(&pdev->dev, "vadp");
> +	if (IS_ERR(info->channel_vadp)) {
> +		ret = PTR_ERR(info->channel_vadp);
> +		if (ret == -EPROBE_DEFER)
> +			return ret;
> +
> +		dev_warn(&pdev->dev, "could not request vadp iio channel (%d)",
> +			 ret);
> +		info->channel_vadp = NULL;
> +	}
> +
>  	ret = regmap_read(info->rn5t618->regmap, RN5T618_CONTROL, &v);
>  	if (ret)
>  		return ret;
> @@ -778,9 +826,17 @@ static int rn5t618_power_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static const struct of_device_id rn5t618_power_of_match[] = {
> +	{.compatible = "ricoh,rc5t619-power", },
> +	{.compatible = "ricoh,rn5t618-power", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, rn5t618_power_of_match);
> +
>  static struct platform_driver rn5t618_power_driver = {
>  	.driver = {
>  		.name   = "rn5t618-power",
> +		.of_match_table = of_match_ptr(rn5t618_power_of_match),
>  	},
>  	.probe = rn5t618_power_probe,
>  };

