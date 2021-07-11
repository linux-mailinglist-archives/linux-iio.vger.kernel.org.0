Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96C5C3C3B77
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jul 2021 12:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbhGKKVJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Jul 2021 06:21:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:36752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229800AbhGKKVJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Jul 2021 06:21:09 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 531E06124B;
        Sun, 11 Jul 2021 10:18:21 +0000 (UTC)
Date:   Sun, 11 Jul 2021 11:20:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     lars@metafoo.de, sre@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 2/2] power: supply: rn5t618: Add voltage_now property
Message-ID: <20210711112039.43c4af7b@jic23-huawei>
In-Reply-To: <20210705113637.28908-3-andreas@kemnade.info>
References: <20210705113637.28908-1-andreas@kemnade.info>
        <20210705113637.28908-3-andreas@kemnade.info>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  5 Jul 2021 13:36:37 +0200
Andreas Kemnade <andreas@kemnade.info> wrote:

> Read voltage_now via IIO and provide the property.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> Reported-by: kernel test robot <lkp@intel.com>
Huh?  Seems unlikely it pointed out that this patch was necessary in general.
If highlighting a particular fix in an earlier version, then state what it was
in the commit message. Note for fixes that get rolled into patches, it's
often just mentioned in the change log and we skip the tag because it can
cause confusion.

One other comment inline but it's up to you whether you care or not!

These could go via the IIO tree or power. I don't mind which, but unless
someone shouts, I'm assuming power.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Jonathan


> ---
> Changes in v2:
> - different error handling needed for iio_map usage
> - fix dependencies in Kconfig
> 
>  drivers/power/supply/Kconfig         |  2 ++
>  drivers/power/supply/rn5t618_power.c | 40 ++++++++++++++++++++++++++++
>  2 files changed, 42 insertions(+)
> 
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index e696364126f1..b2910d950929 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -790,6 +790,8 @@ config CHARGER_WILCO
>  config RN5T618_POWER
>  	tristate "RN5T618 charger/fuel gauge support"
>  	depends on MFD_RN5T618
> +	depends on RN5T618_ADC
> +	depends on IIO
>  	help
>  	  Say Y here to have support for RN5T618 PMIC family fuel gauge and charger.
>  	  This driver can also be built as a module. If so, the module will be
> diff --git a/drivers/power/supply/rn5t618_power.c b/drivers/power/supply/rn5t618_power.c
> index 819061918b2a..bca3fd86c14d 100644
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

It's a recent addition, but we now have an iio_read_channel_processed_scale()
function that can retain a little more precision because, in a fractional scale
case like with the adc here, it will multiply by 1000 before doing the division.

May make a negligable difference though depending on noise level of the ADC etc.


> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -711,6 +737,20 @@ static int rn5t618_power_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, info);
>  
> +	info->channel_vusb = devm_iio_channel_get(&pdev->dev, "vusb");
> +	if (IS_ERR(info->channel_vusb)) {
> +		if (PTR_ERR(info->channel_vusb) == -ENODEV)
> +			return -EPROBE_DEFER;
> +		return PTR_ERR(info->channel_vusb);
> +	}
> +
> +	info->channel_vadp = devm_iio_channel_get(&pdev->dev, "vadp");
> +	if (IS_ERR(info->channel_vadp)) {
> +		if (PTR_ERR(info->channel_vadp) == -ENODEV)
> +			return -EPROBE_DEFER;
> +		return PTR_ERR(info->channel_vadp);
> +	}
> +
>  	ret = regmap_read(info->rn5t618->regmap, RN5T618_CONTROL, &v);
>  	if (ret)
>  		return ret;

