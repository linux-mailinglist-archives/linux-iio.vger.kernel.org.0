Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91329185C06
	for <lists+linux-iio@lfdr.de>; Sun, 15 Mar 2020 11:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbgCOKpK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Mar 2020 06:45:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:51484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728234AbgCOKpK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Mar 2020 06:45:10 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC355206BE;
        Sun, 15 Mar 2020 10:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584269108;
        bh=gkh11zDEo1pnss11Co1FUTaFN4NHg8nff0OfebZvCBs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zGiDGlorhra0FDn0URVdL+E+QHuLZ1SOMTbmhJV/OFrfZxuie0paYe+Jf0dSlBSCh
         drXbxgEO7W9VxMD4qRwa9O6hhpVIiPxqwXWvHpQQ99xx8r9EKUfk+TzOX3g9gY7QFC
         3aFbNLypMFQoXKYjQRcGDArnrf7kvUkJlKEk2r+w=
Date:   Sun, 15 Mar 2020 10:45:03 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, sre@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 4/5] power: supply: Add support for mps mp2629
 battery charger
Message-ID: <20200315104503.0e98c923@archlinux>
In-Reply-To: <20200315000013.4440-5-sravanhome@gmail.com>
References: <20200315000013.4440-1-sravanhome@gmail.com>
        <20200315000013.4440-5-sravanhome@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 15 Mar 2020 01:00:12 +0100
Saravanan Sekar <sravanhome@gmail.com> wrote:

> The mp2629 provides switching-mode battery charge management for
> single-cell Li-ion or Li-polymer battery. Driver supports the
> access/control input source and battery charging parameters.
> 
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
Hi Saravanan.

Just to play devils advocate, are the ADC channels on this device actually
usable for anything other than power supply control? 

If not, what is the benefit in exposing them at all to IIO and going through
the dance of having an MFD?  As far as I'm concerned its perfectly acceptable
to have ADC channels and handling embedded directly in a power supply driver
if that's all they are for.

Things get a lot messier when we have general purpose ADC channels that might
be used for battery monitoring or a device that provides some AUX channels.
As far as I can tell (can't get to the data sheet right now as waiting for
account confirmation), this isn't true here.  They are internal measurements
of the power supply and battery charging outputs.

My initial impression is you would be better off with a monolithic power
supply driver combining the 3 parts you currently have and not exposing
IIO interfaces at all.

Thanks,

Jonathan

> ---
>  drivers/power/supply/Kconfig          |  10 +
>  drivers/power/supply/Makefile         |   1 +
>  drivers/power/supply/mp2629_charger.c | 702 ++++++++++++++++++++++++++
>  3 files changed, 713 insertions(+)
>  create mode 100644 drivers/power/supply/mp2629_charger.c
> 
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index f3424fdce341..f45409d26d54 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -541,6 +541,16 @@ config CHARGER_MAX8998
>  	  Say Y to enable support for the battery charger control sysfs and
>  	  platform data of MAX8998/LP3974 PMICs.
>  
> +config CHARGER_MP2629
> +	bool "Monolithic power system MP2629 Battery charger"
> +	depends on MFD_MP2629
> +	depends on MP2629_ADC
> +	depends on IIO
> +	help
> +	  Select this option to enable support for Monolithic power system
> +	  Battery charger. This driver provies Battery charger power management
> +	  functions on the systems.
> +
>  config CHARGER_QCOM_SMBB
>  	tristate "Qualcomm Switch-Mode Battery Charger and Boost"
>  	depends on MFD_SPMI_PMIC || COMPILE_TEST
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index 6c7da920ea83..41cb64f09e49 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -75,6 +75,7 @@ obj-$(CONFIG_CHARGER_MAX77650)	+= max77650-charger.o
>  obj-$(CONFIG_CHARGER_MAX77693)	+= max77693_charger.o
>  obj-$(CONFIG_CHARGER_MAX8997)	+= max8997_charger.o
>  obj-$(CONFIG_CHARGER_MAX8998)	+= max8998_charger.o
> +obj-$(CONFIG_CHARGER_MP2629)	+= mp2629_charger.o
>  obj-$(CONFIG_CHARGER_QCOM_SMBB)	+= qcom_smbb.o
>  obj-$(CONFIG_CHARGER_BQ2415X)	+= bq2415x_charger.o
>  obj-$(CONFIG_CHARGER_BQ24190)	+= bq24190_charger.o
> diff --git a/drivers/power/supply/mp2629_charger.c b/drivers/power/supply/mp2629_charger.c
> new file mode 100644
> index 000000000000..8dab4250710f
> --- /dev/null
> +++ b/drivers/power/supply/mp2629_charger.c
> @@ -0,0 +1,702 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * MP2629 battery charger driver
> + *
> + * Copyright 2020 Monolithic Power Systems, Inc
> + *
> + * Author: Saravanan Sekar <sravanhome@gmail.com>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/of_device.h>
> +#include <linux/interrupt.h>
> +#include <linux/iio/consumer.h>
> +#include <linux/iio/types.h>
> +#include <linux/power_supply.h>
> +#include <linux/workqueue.h>
> +#include <linux/regmap.h>
> +
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/mp2629.h>
> +
> +#define MP2629_REG_INPUT_ILIM		0x00
> +#define MP2629_REG_INPUT_VLIM		0x01
> +#define MP2629_REG_CHARGE_CTRL		0x04
> +#define MP2629_REG_CHARGE_ILIM		0x05
> +#define MP2629_REG_PRECHARGE		0x06
> +#define MP2629_REG_TERM_CURRENT		0x06
> +#define MP2629_REG_CHARGE_VLIM		0x07
> +#define MP2629_REG_TIMER_CTRL		0x08
> +#define MP2629_REG_IMPEDANCE_COMP	0x09
> +#define MP2629_REG_INTERRUPT		0x0b
> +#define MP2629_REG_STATUS		0x0c
> +#define MP2629_REG_FAULT		0x0d
> +
> +#define MP2629_MASK_INPUT_TYPE		0xe0
> +#define MP2629_MASK_CHARGE_TYPE		0x18
> +#define MP2629_MASK_CHARGE_CTRL		0x30
> +#define MP2629_MASK_WDOG_CTRL		0x30
> +#define MP2629_MASK_IMPEDANCE		0xf0
> +
> +#define MP2629_INPUTSOURCE_CHANGE	GENMASK(7, 5)
> +#define MP2629_CHARGING_CHANGE		GENMASK(4, 3)
> +#define MP2629_FAULT_BATTERY		BIT(3)
> +#define MP2629_FAULT_THERMAL		BIT(4)
> +#define MP2629_FAULT_INPUT		BIT(5)
> +#define MP2629_FAULT_OTG		BIT(6)
> +
> +#define MP2629_MAX_BATT_CAPACITY	100
> +
> +#define MP2629_PROPS(_idx, _min, _max, _step)		\
> +	[_idx] = {					\
> +		.min	= _min,				\
> +		.max	= _max,				\
> +		.step	= _step,			\
> +}
> +
> +enum mp2629_source_type {
> +	MP2629_SOURCE_TYPE_NO_INPUT,
> +	MP2629_SOURCE_TYPE_NON_STD,
> +	MP2629_SOURCE_TYPE_SDP,
> +	MP2629_SOURCE_TYPE_CDP,
> +	MP2629_SOURCE_TYPE_DCP,
> +	MP2629_SOURCE_TYPE_OTG = 7,
> +};
> +
> +enum mp2629_field {
> +	INPUT_ILIM,
> +	INPUT_VLIM,
> +	CHARGE_ILIM,
> +	CHARGE_VLIM,
> +	PRECHARGE,
> +	TERM_CURRENT,
> +};
> +
> +struct mp2629_charger {
> +	struct mp2629_info *info;
> +	struct device *dev;
> +	struct work_struct charger_work;
> +	int status;
> +	int fault;
> +
> +	struct regmap_field *regmap_fields[TERM_CURRENT + 1];
> +	struct mutex lock;
> +	struct power_supply *usb;
> +	struct power_supply *battery;
> +	struct iio_channel *iiochan[MP2629_ADC_CHAN_END];
> +};
> +
> +struct mp2629_prop {
> +	int reg;
> +	int mask;
> +	int min;
> +	int max;
> +	int step;
> +	int shift;
> +};
> +
> +static enum power_supply_usb_type mp2629_usb_types[] = {
> +	POWER_SUPPLY_USB_TYPE_SDP,
> +	POWER_SUPPLY_USB_TYPE_DCP,
> +	POWER_SUPPLY_USB_TYPE_CDP,
> +	POWER_SUPPLY_USB_TYPE_PD_DRP,
> +	POWER_SUPPLY_USB_TYPE_UNKNOWN
> +};
> +
> +static enum power_supply_property mp2629_charger_usb_props[] = {
> +	POWER_SUPPLY_PROP_ONLINE,
> +	POWER_SUPPLY_PROP_USB_TYPE,
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +	POWER_SUPPLY_PROP_CURRENT_NOW,
> +	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
> +	POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT,
> +};
> +
> +static enum power_supply_property mp2629_charger_bat_props[] = {
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_HEALTH,
> +	POWER_SUPPLY_PROP_CHARGE_TYPE,
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +	POWER_SUPPLY_PROP_CURRENT_NOW,
> +	POWER_SUPPLY_PROP_CAPACITY,
> +	POWER_SUPPLY_PROP_PRECHARGE_CURRENT,
> +	POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
> +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
> +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
> +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
> +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
> +};
> +
> +static struct mp2629_prop props[] = {
> +	MP2629_PROPS(INPUT_ILIM, 100000, 3250000, 50000),
> +	MP2629_PROPS(INPUT_VLIM, 3800000, 5300000, 100000),
> +	MP2629_PROPS(CHARGE_ILIM, 320000, 4520000, 40000),
> +	MP2629_PROPS(CHARGE_VLIM, 3400000, 4670000, 10000),
> +	MP2629_PROPS(PRECHARGE, 120000, 720000, 40000),
> +	MP2629_PROPS(TERM_CURRENT, 80000, 680000, 40000),
> +};
> +
> +static const struct reg_field mp2629_reg_fields[] = {
> +	[INPUT_ILIM]	= REG_FIELD(MP2629_REG_INPUT_ILIM, 0, 5),
> +	[INPUT_VLIM]	= REG_FIELD(MP2629_REG_INPUT_VLIM, 0, 3),
> +	[CHARGE_ILIM]	= REG_FIELD(MP2629_REG_CHARGE_ILIM, 0, 6),
> +	[CHARGE_VLIM]	= REG_FIELD(MP2629_REG_CHARGE_VLIM, 1, 7),
> +	[PRECHARGE]	= REG_FIELD(MP2629_REG_PRECHARGE, 4, 7),
> +	[TERM_CURRENT]	= REG_FIELD(MP2629_REG_TERM_CURRENT, 0, 3),
> +};
> +
> +static char *adc_chan_name[] = {
> +	"mp2629-batt-volt",
> +	"mp2629-system-volt",
> +	"mp2629-input-volt",
> +	"mp2629-batt-current",
> +	"mp2629-input-current",
> +};
> +
> +static int mp2629_read_adc(struct mp2629_charger *charger,
> +			   enum mp2629_adc_chan ch,
> +			   union power_supply_propval *val)
> +{
> +	int ret;
> +	int chval;
> +
> +	ret = iio_read_channel_processed(charger->iiochan[ch], &chval);
> +	if (ret < 0)
> +		return ret;
> +
> +	val->intval = chval * 1000;
> +
> +	return 0;
> +}
> +
> +static int mp2629_get_prop(struct mp2629_charger *charger,
> +			   enum mp2629_field fld,
> +			   union power_supply_propval *val)
> +{
> +	int ret;
> +	unsigned int rval;
> +
> +	ret = regmap_field_read(charger->regmap_fields[fld], &rval);
> +	if (!ret)
> +		val->intval = (rval * props[fld].step) + props[fld].min;
> +
> +	return ret;
> +}
> +
> +static int mp2629_set_prop(struct mp2629_charger *charger,
> +			   enum mp2629_field fld,
> +			   const union power_supply_propval *val)
> +{
> +	unsigned int rval;
> +
> +	if (val->intval < props[fld].min || val->intval > props[fld].max)
> +		return -EINVAL;
> +
> +	rval = (val->intval - props[fld].min) / props[fld].step;
> +	return regmap_field_write(charger->regmap_fields[fld], rval);
> +}
> +
> +static int mp2629_get_battery_capacity(struct mp2629_charger *charger,
> +				       union power_supply_propval *val)
> +{
> +	union power_supply_propval vnow, vlim;
> +	int ret;
> +
> +	ret = mp2629_read_adc(charger, MP2629_BATT_VOLT, &vnow);
> +	if (ret)
> +		return ret;
> +
> +	ret = mp2629_get_prop(charger, CHARGE_VLIM, &vlim);
> +	if (ret)
> +		return ret;
> +
> +	val->intval = (vnow.intval * 100) / vlim.intval;
> +	val->intval = min(val->intval, MP2629_MAX_BATT_CAPACITY);
> +
> +	return 0;
> +}
> +
> +static int mp2629_charger_battery_get_prop(struct power_supply *psy,
> +					enum power_supply_property psp,
> +					union power_supply_propval *val)
> +{
> +	struct mp2629_charger *charger = dev_get_drvdata(psy->dev.parent);
> +	struct mp2629_info *info = charger->info;
> +	unsigned int rval;
> +	int ret = 0;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +		ret = mp2629_read_adc(charger, MP2629_BATT_VOLT, val);
> +		break;
> +
> +	case POWER_SUPPLY_PROP_CURRENT_NOW:
> +		ret = mp2629_read_adc(charger, MP2629_BATT_CURRENT, val);
> +		break;
> +
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
> +		val->intval = 4520000;
> +		break;
> +
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
> +		val->intval = 4670000;
> +		break;
> +
> +	case POWER_SUPPLY_PROP_CAPACITY:
> +		ret = mp2629_get_battery_capacity(charger, val);
> +		break;
> +
> +	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
> +		ret = mp2629_get_prop(charger, TERM_CURRENT, val);
> +		break;
> +
> +	case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
> +		ret = mp2629_get_prop(charger, PRECHARGE, val);
> +		break;
> +
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
> +		ret = mp2629_get_prop(charger, CHARGE_VLIM, val);
> +		break;
> +
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
> +		ret = mp2629_get_prop(charger, CHARGE_ILIM, val);
> +		break;
> +
> +	case POWER_SUPPLY_PROP_HEALTH:
> +		if (!charger->fault)
> +			val->intval = POWER_SUPPLY_HEALTH_GOOD;
> +		if (MP2629_FAULT_BATTERY & charger->fault)
> +			val->intval = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
> +		else if (MP2629_FAULT_THERMAL & charger->fault)
> +			val->intval = POWER_SUPPLY_HEALTH_OVERHEAT;
> +		else if (MP2629_FAULT_INPUT & charger->fault)
> +			val->intval = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
> +		break;
> +
> +	case POWER_SUPPLY_PROP_STATUS:
> +		ret = regmap_read(info->regmap, MP2629_REG_STATUS, &rval);
> +		if (ret)
> +			break;
> +
> +		rval = (rval & MP2629_MASK_CHARGE_TYPE) >> 3;
> +		switch (rval) {
> +		case 0x00:
> +			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
> +			break;
> +		case 0x01:
> +		case 0x10:
> +			val->intval = POWER_SUPPLY_STATUS_CHARGING;
> +			break;
> +		case 0x11:
> +			val->intval = POWER_SUPPLY_STATUS_FULL;
> +		}
> +		break;
> +
> +	case POWER_SUPPLY_PROP_CHARGE_TYPE:
> +		ret = regmap_read(info->regmap, MP2629_REG_STATUS, &rval);
> +		if (ret)
> +			break;
> +
> +		rval = (rval & MP2629_MASK_CHARGE_TYPE) >> 3;
> +		switch (rval) {
> +		case 0x00:
> +			val->intval = POWER_SUPPLY_CHARGE_TYPE_NONE;
> +			break;
> +		case 0x01:
> +			val->intval = POWER_SUPPLY_CHARGE_TYPE_TRICKLE;
> +			break;
> +		case 0x10:
> +			val->intval = POWER_SUPPLY_CHARGE_TYPE_STANDARD;
> +			break;
> +		default:
> +			val->intval = POWER_SUPPLY_CHARGE_TYPE_UNKNOWN;
> +		}
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static int mp2629_charger_battery_set_prop(struct power_supply *psy,
> +					enum power_supply_property psp,
> +					const union power_supply_propval *val)
> +{
> +	struct mp2629_charger *charger = dev_get_drvdata(psy->dev.parent);
> +	int ret;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
> +		ret = mp2629_set_prop(charger, TERM_CURRENT, val);
> +		break;
> +
> +	case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
> +		ret = mp2629_set_prop(charger, PRECHARGE, val);
> +		break;
> +
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
> +		ret = mp2629_set_prop(charger, CHARGE_VLIM, val);
> +		break;
> +
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
> +		ret = mp2629_set_prop(charger, CHARGE_ILIM, val);
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static int mp2629_charger_usb_get_prop(struct power_supply *psy,
> +				enum power_supply_property psp,
> +				union power_supply_propval *val)
> +{
> +	struct mp2629_charger *charger = dev_get_drvdata(psy->dev.parent);
> +	struct mp2629_info *info = charger->info;
> +	unsigned int rval;
> +	int ret;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_ONLINE:
> +		ret = regmap_read(info->regmap, MP2629_REG_STATUS, &rval);
> +		if (!ret)
> +			val->intval = !!(rval & MP2629_MASK_INPUT_TYPE);
> +		break;
> +
> +	case POWER_SUPPLY_PROP_USB_TYPE:
> +		ret = regmap_read(info->regmap, MP2629_REG_STATUS, &rval);
> +		if (ret)
> +			break;
> +
> +		rval = (rval & MP2629_MASK_INPUT_TYPE) >> 5;
> +		switch (rval) {
> +		case MP2629_SOURCE_TYPE_SDP:
> +			val->intval = POWER_SUPPLY_USB_TYPE_SDP;
> +			break;
> +		case MP2629_SOURCE_TYPE_CDP:
> +			val->intval = POWER_SUPPLY_USB_TYPE_CDP;
> +			break;
> +		case MP2629_SOURCE_TYPE_DCP:
> +			val->intval = POWER_SUPPLY_USB_TYPE_DCP;
> +			break;
> +		case MP2629_SOURCE_TYPE_OTG:
> +			val->intval = POWER_SUPPLY_USB_TYPE_PD_DRP;
> +			break;
> +		default:
> +			val->intval = POWER_SUPPLY_USB_TYPE_UNKNOWN;
> +			break;
> +		}
> +		break;
> +
> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +		ret = mp2629_read_adc(charger, MP2629_INPUT_VOLT, val);
> +		break;
> +
> +	case POWER_SUPPLY_PROP_CURRENT_NOW:
> +		ret = mp2629_read_adc(charger, MP2629_INPUT_CURRENT, val);
> +		break;
> +
> +	case POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT:
> +		ret = mp2629_get_prop(charger, INPUT_VLIM, val);
> +		break;
> +
> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +		ret = mp2629_get_prop(charger, INPUT_ILIM, val);
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static int mp2629_charger_usb_set_prop(struct power_supply *psy,
> +				enum power_supply_property psp,
> +				const union power_supply_propval *val)
> +{
> +	struct mp2629_charger *charger = dev_get_drvdata(psy->dev.parent);
> +	int ret;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT:
> +		ret = mp2629_set_prop(charger, INPUT_VLIM, val);
> +		break;
> +
> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +		ret = mp2629_set_prop(charger, INPUT_ILIM, val);
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static int mp2629_charger_battery_prop_writeable(struct power_supply *psy,
> +				     enum power_supply_property psp)
> +{
> +	return (psp == POWER_SUPPLY_PROP_PRECHARGE_CURRENT ||
> +		psp == POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT ||
> +		psp == POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT ||
> +		psp == POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE);
> +}
> +
> +static int mp2629_charger_usb_prop_writeable(struct power_supply *psy,
> +				     enum power_supply_property psp)
> +{
> +	return (psp == POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT ||
> +		psp == POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT);
> +}
> +
> +static void mp2629_charger_work(struct work_struct *work)
> +{
> +	struct mp2629_charger *charger;
> +	struct mp2629_info *info;
> +	unsigned int rval;
> +	int ret;
> +
> +	charger = container_of(work, struct mp2629_charger, charger_work);
> +	info = charger->info;
> +
> +	mutex_lock(&charger->lock);
> +
> +	ret = regmap_read(info->regmap, MP2629_REG_FAULT, &rval);
> +	if (ret)
> +		goto unlock;
> +
> +	if (rval) {
> +		charger->fault = rval;
> +		if (MP2629_FAULT_BATTERY & rval)
> +			dev_err(info->dev, "Battery fault OVP");
> +		else if (MP2629_FAULT_THERMAL & rval)
> +			dev_err(info->dev, "Thermal shutdown fault");
> +		else if (MP2629_FAULT_INPUT & rval)
> +			dev_err(info->dev, "no input or input OVP");
> +		else if (MP2629_FAULT_OTG & rval)
> +			dev_err(info->dev, "VIN overloaded");
> +
> +		goto unlock;
> +	}
> +
> +	ret = regmap_read(info->regmap, MP2629_REG_STATUS, &rval);
> +	if (ret)
> +		goto unlock;
> +
> +	if (rval & MP2629_INPUTSOURCE_CHANGE)
> +		power_supply_changed(charger->usb);
> +	else if (rval & MP2629_CHARGING_CHANGE)
> +		power_supply_changed(charger->battery);
> +
> +unlock:
> +	mutex_unlock(&charger->lock);
> +}
> +
> +static irqreturn_t mp2629_irq_handler(int irq, void *dev_id)
> +{
> +	struct mp2629_charger *charger = dev_id;
> +
> +	schedule_work(&charger->charger_work);
> +	return IRQ_HANDLED;
> +}
> +
> +static const struct power_supply_desc mp2629_usb_desc = {
> +	.name		= "mp2629_usb",
> +	.type		= POWER_SUPPLY_TYPE_USB,
> +	.usb_types      = mp2629_usb_types,
> +	.num_usb_types  = ARRAY_SIZE(mp2629_usb_types),
> +	.properties	= mp2629_charger_usb_props,
> +	.num_properties	= ARRAY_SIZE(mp2629_charger_usb_props),
> +	.get_property	= mp2629_charger_usb_get_prop,
> +	.set_property	= mp2629_charger_usb_set_prop,
> +	.property_is_writeable = mp2629_charger_usb_prop_writeable,
> +};
> +
> +static const struct power_supply_desc mp2629_battery_desc = {
> +	.name		= "mp2629_battery",
> +	.type		= POWER_SUPPLY_TYPE_BATTERY,
> +	.properties	= mp2629_charger_bat_props,
> +	.num_properties	= ARRAY_SIZE(mp2629_charger_bat_props),
> +	.get_property	= mp2629_charger_battery_get_prop,
> +	.set_property	= mp2629_charger_battery_set_prop,
> +	.property_is_writeable = mp2629_charger_battery_prop_writeable,
> +};
> +
> +static ssize_t batt_impedance_compensation_show(struct device *dev,
> +					   struct device_attribute *attr,
> +					   char *buf)
> +{
> +	struct mp2629_charger *charger = dev_get_drvdata(dev->parent);
> +	struct mp2629_info *info = charger->info;
> +	unsigned int rval;
> +	int ret;
> +
> +	ret = regmap_read(info->regmap, MP2629_REG_IMPEDANCE_COMP, &rval);
> +	if (ret < 0)
> +		return ret;
> +
> +	rval = (rval >> 4) * 10;
> +
> +	return scnprintf(buf, PAGE_SIZE, "%d mohm\n", rval);
> +}
> +
> +static ssize_t batt_impedance_compensation_store(struct device *dev,
> +					    struct device_attribute *attr,
> +					    const char *buf,
> +					    size_t count)
> +{
> +	struct mp2629_charger *charger = dev_get_drvdata(dev->parent);
> +	struct mp2629_info *info = charger->info;
> +	long val;
> +	int ret;
> +
> +	ret = kstrtol(buf, 10, &val);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (val < 0 && val > 140)
> +		return -ERANGE;
> +
> +	/* multiples of 10 mohm so round off */
> +	val = val / 10;
> +	ret = regmap_update_bits(info->regmap, MP2629_REG_IMPEDANCE_COMP,
> +					MP2629_MASK_IMPEDANCE, val << 4);
> +	if (ret < 0)
> +		return ret;
> +
> +	return count;
> +}
> +
> +static DEVICE_ATTR_RW(batt_impedance_compensation);
> +
> +static struct attribute *mp2629_charger_sysfs_attrs[] = {
> +	&dev_attr_batt_impedance_compensation.attr,
> +	NULL
> +};
> +ATTRIBUTE_GROUPS(mp2629_charger_sysfs);
> +
> +static int mp2629_charger_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct mp2629_charger *charger;
> +	struct mp2629_info *info = dev_get_drvdata(dev->parent);
> +	struct power_supply_config psy_cfg = {0};
> +	int ret, i;
> +
> +	charger = devm_kzalloc(dev, sizeof(*charger), GFP_KERNEL);
> +	if (!charger)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, charger);
> +	charger->info = info;
> +	charger->dev = dev;
> +
> +	for (i = 0; i <= TERM_CURRENT; i++) {
> +		charger->regmap_fields[i] = devm_regmap_field_alloc(dev,
> +					info->regmap, mp2629_reg_fields[i]);
> +		if (IS_ERR(charger->regmap_fields[i])) {
> +			dev_err(dev, "regmap field alloc fail %d\n", i);
> +			return PTR_ERR(charger->regmap_fields[i]);
> +		}
> +	}
> +
> +	for (i = 0; i < MP2629_ADC_CHAN_END; i++) {
> +		charger->iiochan[i] = iio_channel_get(dev, adc_chan_name[i]);
> +		if (IS_ERR(charger->iiochan[i])) {
> +			ret = PTR_ERR(charger->iiochan[i]);
> +			goto iio_fail;
> +		}
> +	}
> +
> +	charger->usb = devm_power_supply_register(dev, &mp2629_usb_desc, NULL);
> +	if (IS_ERR(charger->usb)) {
> +		ret = PTR_ERR(charger->usb);
> +		goto iio_fail;
> +	}
> +
> +	psy_cfg.drv_data = charger;
> +	psy_cfg.attr_grp = mp2629_charger_sysfs_groups;
> +	charger->battery = devm_power_supply_register(dev,
> +					 &mp2629_battery_desc, &psy_cfg);
> +	if (IS_ERR(charger->battery)) {
> +		ret = PTR_ERR(charger->battery);
> +		goto iio_fail;
> +	}
> +
> +	ret = regmap_update_bits(info->regmap, MP2629_REG_CHARGE_CTRL,
> +					MP2629_MASK_CHARGE_CTRL, BIT(4));
> +	if (ret) {
> +		dev_err(dev, "enable charge fail: %d\n", ret);
> +		goto iio_fail;
> +	}
> +
> +	regmap_update_bits(info->regmap, MP2629_REG_TIMER_CTRL,
> +					MP2629_MASK_WDOG_CTRL, 0);
> +
> +	INIT_WORK(&charger->charger_work, mp2629_charger_work);
> +	mutex_init(&charger->lock);
> +
> +	if (info->irq) {
> +		ret = devm_request_irq(dev, info->irq, mp2629_irq_handler,
> +				 IRQF_TRIGGER_RISING, "mp2629-charger",
> +				 charger);
> +		if (ret) {
> +			dev_info(dev, "failed to request gpio IRQ\n");
> +			goto iio_fail;
> +		}
> +	}
> +
> +	regmap_update_bits(info->regmap, MP2629_REG_INTERRUPT,
> +				GENMASK(6, 5), (BIT(6) | BIT(5)));
> +
> +	return 0;
> +
> +iio_fail:
> +	while (i--)
> +		iio_channel_release(charger->iiochan[i]);
> +
> +	dev_err(dev, "driver register fail: %d\n", ret);
> +	return ret;
> +}
> +
> +static int mp2629_charger_remove(struct platform_device *pdev)
> +{
> +	struct mp2629_charger *charger = platform_get_drvdata(pdev);
> +	struct mp2629_info *info = charger->info;
> +	int i;
> +
> +	cancel_work_sync(&charger->charger_work);
> +
> +	for (i = 0; i < MP2629_ADC_CHAN_END; i++)
> +		iio_channel_release(charger->iiochan[i]);
> +
> +	regmap_update_bits(info->regmap, MP2629_REG_CHARGE_CTRL,
> +					MP2629_MASK_CHARGE_CTRL, 0);
> +	return 0;
> +}
> +
> +static const struct of_device_id mp2629_charger_of_match[] = {
> +	{ .compatible = "mps,mp2629_charger"},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, mp2629_charger_of_match);
> +
> +static struct platform_driver mp2629_charger_driver = {
> +	.driver = {
> +		.name = "mp2629_charger",
> +		.of_match_table = mp2629_charger_of_match,
> +	},
> +	.probe		= mp2629_charger_probe,
> +	.remove		= mp2629_charger_remove,
> +};
> +module_platform_driver(mp2629_charger_driver);
> +
> +MODULE_AUTHOR("Saravanan Sekar <sravanhome@gmail.com>");
> +MODULE_DESCRIPTION("MP2629 Charger driver");
> +MODULE_LICENSE("GPL");

