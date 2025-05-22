Return-Path: <linux-iio+bounces-19810-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD50AC11EA
	for <lists+linux-iio@lfdr.de>; Thu, 22 May 2025 19:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCF9A17D31A
	for <lists+linux-iio@lfdr.de>; Thu, 22 May 2025 17:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572FF186E40;
	Thu, 22 May 2025 17:12:47 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBCA184E;
	Thu, 22 May 2025 17:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747933967; cv=none; b=bykViGnz/OxG60RPktOkVWJVpNPnVDPiXb4kk3UXS8iXYhDSakpBNfWCr9qF9mO39sqbtpu4o1ycoib5IyseJew7HdakI148UI2XrvF+DMkR/sH08+LtAk5urg8CpOP5NoHC/W5aJql8OeRZ/l5iIrebJx/cq3jq5otgJiNv0m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747933967; c=relaxed/simple;
	bh=LtiazRno9Ataxyk0m+897/yEdSqBOJZINOR0rvp3zf8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oD68vBAF6RQQZVjTu7yX0MGEJUy3b1LP23QJgeXU1FYydKAckdWguXuR1yhadIy3JPPaASarYMEfz1gdQ0UGr+26YUIgJYW40Sghr116kuP9JR44J6p7qUdyZMoQWiJyOODF4IIUWJcbKB3BuT/s23gjhfgmG8YjP31e06CWj9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b3FBr0kYFz6L5Gr;
	Fri, 23 May 2025 01:09:24 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 3DFE71402EF;
	Fri, 23 May 2025 01:12:39 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 22 May
 2025 19:12:38 +0200
Date: Thu, 22 May 2025 18:12:36 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Maud Spierings via B4 Relay
	<devnull+maudspierings.gocontroll.com@kernel.org>
CC: <maudspierings@gocontroll.com>, Jonathan Cameron <jic23@kernel.org>,
	"David Lechner" <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
	<nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Christian Heusel
	<christian@heusel.eu>, Linus Walleij <linus.walleij@linaro.org>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, <gregkh@linuxfoundation.org>, <dsimic@manjaro.com>
Subject: Re: [PATCH v2] iio: common: st_sensors: Fix use of uninitialize
 device structs
Message-ID: <20250522181236.00006dda@huawei.com>
In-Reply-To: <20250522-st_iio_fix-v2-1-07a32655a996@gocontroll.com>
References: <20250522-st_iio_fix-v2-1-07a32655a996@gocontroll.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 22 May 2025 13:18:55 +0200
Maud Spierings via B4 Relay <devnull+maudspierings.gocontroll.com@kernel.org> wrote:

> From: Maud Spierings <maudspierings@gocontroll.com>
> 
> Throughout the various probe functions &indio_dev->dev is used before it
> is initialized. This caused a kernel panic in st_sensors_power_enable
> when the call to devm_regulator_bulk_get_enable() fails and then calls
> dev_err_probe() with the uninitialized device.
Hi Maud,


Curious.  Given the device_initialize() is in the allocation function
it isn't immediately obvious that something needed might not have been initialized.
Any idea what is being accessed in there that fails? (i.e. any idea if my
shallow detective work found it ;)

https://elixir.bootlin.com/linux/v6.14.7/source/drivers/iio/industrialio-core.c#L1675
in iio_device_alloc() is where device_initialize() is called.

Using the device in the iio_dev structure is almost certainly wrong
but I'm surprised it crashes... So I had a quick dig.

The only path that isn't a simple print that I can spot
is device_set_deferred_reason()  That accesses dev->p (device private
data)  Which is initialized only in device_add().

I wonder if we should harden device_set_deferred_reason()
against p == NULL, perhaps with a message strongly advising against
using it with a device that hasn't been added?

Being in error paths this is the sort of subtle bug that
rarely rears it's head :(

+CC Greg and Dragan for thoughts before anyone spins a patch.

This change is good either way. I'm just on wrong computer to pick it up
right now.

Jonathan




> 
> This seems to only cause a panic with dev_err_probe(), dev_err,
> dev_warn and dev_info don't seem to cause a panic, but are fixed
> as well.
> 
> Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
> ---
> When I search for general &indio_dev->dev usage, I see quite a lot more
> hits, but I am not sure if there are issues with those too.
> 
> This issue has existed for a long time it seems and therefore it is
> nearly impossible to find a proper fixes tag. I would love to see it at
> least backported to 6.12 as that is where I encountered it, and I
> believe the patch should apply without conflicts.
> 
> The investigation into this issue can be found in this thread [1]
> 
> [1]: https://lore.kernel.org/all/AM7P189MB100986A83D2F28AF3FFAF976E39EA@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM/
> ---
> Changes in v2:
> - Added SoB in commit message
> - Link to v1: https://lore.kernel.org/r/20250522-st_iio_fix-v1-1-d689b35f1612@gocontroll.com
> ---
>  drivers/iio/accel/st_accel_core.c                  | 10 +++----
>  drivers/iio/common/st_sensors/st_sensors_core.c    | 35 +++++++++++-----------
>  drivers/iio/common/st_sensors/st_sensors_trigger.c | 18 +++++------
>  3 files changed, 31 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
> index 99cb661fabb2d9cc1943fa8d0a6f3becb71126e6..a7961c610ed203d039bbf298c8883031a578fb0b 100644
> --- a/drivers/iio/accel/st_accel_core.c
> +++ b/drivers/iio/accel/st_accel_core.c
> @@ -1353,6 +1353,7 @@ static int apply_acpi_orientation(struct iio_dev *indio_dev)
>  	union acpi_object *ont;
>  	union acpi_object *elements;
>  	acpi_status status;
> +	struct device *parent = indio_dev->dev.parent;
>  	int ret = -EINVAL;
>  	unsigned int val;
>  	int i, j;
> @@ -1371,7 +1372,7 @@ static int apply_acpi_orientation(struct iio_dev *indio_dev)
>  	};
>  
>  
> -	adev = ACPI_COMPANION(indio_dev->dev.parent);
> +	adev = ACPI_COMPANION(parent);
>  	if (!adev)
>  		return -ENXIO;
>  
> @@ -1380,8 +1381,7 @@ static int apply_acpi_orientation(struct iio_dev *indio_dev)
>  	if (status == AE_NOT_FOUND) {
>  		return -ENXIO;
>  	} else if (ACPI_FAILURE(status)) {
> -		dev_warn(&indio_dev->dev, "failed to execute _ONT: %d\n",
> -			 status);
> +		dev_warn(parent, "failed to execute _ONT: %d\n", status);
>  		return status;
>  	}
>  
> @@ -1457,12 +1457,12 @@ static int apply_acpi_orientation(struct iio_dev *indio_dev)
>  	}
>  
>  	ret = 0;
> -	dev_info(&indio_dev->dev, "computed mount matrix from ACPI\n");
> +	dev_info(parent, "computed mount matrix from ACPI\n");
>  
>  out:
>  	kfree(buffer.pointer);
>  	if (ret)
> -		dev_dbg(&indio_dev->dev,
> +		dev_dbg(parent,
>  			"failed to apply ACPI orientation data: %d\n", ret);
>  
>  	return ret;
> diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
> index 8ce1dccfea4f5aaff45d3d40f6542323dd1f0b09..11cbf561b16d41f429745abb516c137cfbb302bb 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_core.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_core.c
> @@ -154,7 +154,7 @@ static int st_sensors_set_fullscale(struct iio_dev *indio_dev, unsigned int fs)
>  	return err;
>  
>  st_accel_set_fullscale_error:
> -	dev_err(&indio_dev->dev, "failed to set new fullscale.\n");
> +	dev_err(indio_dev->dev.parent, "failed to set new fullscale.\n");
>  	return err;
>  }
>  
> @@ -231,7 +231,7 @@ int st_sensors_power_enable(struct iio_dev *indio_dev)
>  					     ARRAY_SIZE(regulator_names),
>  					     regulator_names);
>  	if (err)
> -		return dev_err_probe(&indio_dev->dev, err,
> +		return dev_err_probe(parent, err,
>  				     "unable to enable supplies\n");
>  
>  	return 0;
> @@ -241,13 +241,14 @@ EXPORT_SYMBOL_NS(st_sensors_power_enable, "IIO_ST_SENSORS");
>  static int st_sensors_set_drdy_int_pin(struct iio_dev *indio_dev,
>  					struct st_sensors_platform_data *pdata)
>  {
> +	struct device *parent = indio_dev->dev.parent;
>  	struct st_sensor_data *sdata = iio_priv(indio_dev);
>  
>  	/* Sensor does not support interrupts */
>  	if (!sdata->sensor_settings->drdy_irq.int1.addr &&
>  	    !sdata->sensor_settings->drdy_irq.int2.addr) {
>  		if (pdata->drdy_int_pin)
> -			dev_info(&indio_dev->dev,
> +			dev_info(parent,
>  				 "DRDY on pin INT%d specified, but sensor does not support interrupts\n",
>  				 pdata->drdy_int_pin);
>  		return 0;
> @@ -256,29 +257,27 @@ static int st_sensors_set_drdy_int_pin(struct iio_dev *indio_dev,
>  	switch (pdata->drdy_int_pin) {
>  	case 1:
>  		if (!sdata->sensor_settings->drdy_irq.int1.mask) {
> -			dev_err(&indio_dev->dev,
> -					"DRDY on INT1 not available.\n");
> +			dev_err(parent, "DRDY on INT1 not available.\n");
>  			return -EINVAL;
>  		}
>  		sdata->drdy_int_pin = 1;
>  		break;
>  	case 2:
>  		if (!sdata->sensor_settings->drdy_irq.int2.mask) {
> -			dev_err(&indio_dev->dev,
> -					"DRDY on INT2 not available.\n");
> +			dev_err(parent, "DRDY on INT2 not available.\n");
>  			return -EINVAL;
>  		}
>  		sdata->drdy_int_pin = 2;
>  		break;
>  	default:
> -		dev_err(&indio_dev->dev, "DRDY on pdata not valid.\n");
> +		dev_err(parent, "DRDY on pdata not valid.\n");
>  		return -EINVAL;
>  	}
>  
>  	if (pdata->open_drain) {
>  		if (!sdata->sensor_settings->drdy_irq.int1.addr_od &&
>  		    !sdata->sensor_settings->drdy_irq.int2.addr_od)
> -			dev_err(&indio_dev->dev,
> +			dev_err(parent,
>  				"open drain requested but unsupported.\n");
>  		else
>  			sdata->int_pin_open_drain = true;
> @@ -336,6 +335,7 @@ EXPORT_SYMBOL_NS(st_sensors_dev_name_probe, "IIO_ST_SENSORS");
>  int st_sensors_init_sensor(struct iio_dev *indio_dev,
>  					struct st_sensors_platform_data *pdata)
>  {
> +	struct device *parent = indio_dev->dev.parent;
>  	struct st_sensor_data *sdata = iio_priv(indio_dev);
>  	struct st_sensors_platform_data *of_pdata;
>  	int err = 0;
> @@ -343,7 +343,7 @@ int st_sensors_init_sensor(struct iio_dev *indio_dev,
>  	mutex_init(&sdata->odr_lock);
>  
>  	/* If OF/DT pdata exists, it will take precedence of anything else */
> -	of_pdata = st_sensors_dev_probe(indio_dev->dev.parent, pdata);
> +	of_pdata = st_sensors_dev_probe(parent, pdata);
>  	if (IS_ERR(of_pdata))
>  		return PTR_ERR(of_pdata);
>  	if (of_pdata)
> @@ -370,7 +370,7 @@ int st_sensors_init_sensor(struct iio_dev *indio_dev,
>  		if (err < 0)
>  			return err;
>  	} else
> -		dev_info(&indio_dev->dev, "Full-scale not possible\n");
> +		dev_info(parent, "Full-scale not possible\n");
>  
>  	err = st_sensors_set_odr(indio_dev, sdata->odr);
>  	if (err < 0)
> @@ -405,7 +405,7 @@ int st_sensors_init_sensor(struct iio_dev *indio_dev,
>  			mask = sdata->sensor_settings->drdy_irq.int2.mask_od;
>  		}
>  
> -		dev_info(&indio_dev->dev,
> +		dev_info(parent,
>  			 "set interrupt line to open drain mode on pin %d\n",
>  			 sdata->drdy_int_pin);
>  		err = st_sensors_write_data_with_mask(indio_dev, addr,
> @@ -593,21 +593,20 @@ EXPORT_SYMBOL_NS(st_sensors_get_settings_index, "IIO_ST_SENSORS");
>  int st_sensors_verify_id(struct iio_dev *indio_dev)
>  {
>  	struct st_sensor_data *sdata = iio_priv(indio_dev);
> +	struct device *parent = indio_dev->dev.parent;
>  	int wai, err;
>  
>  	if (sdata->sensor_settings->wai_addr) {
>  		err = regmap_read(sdata->regmap,
>  				  sdata->sensor_settings->wai_addr, &wai);
>  		if (err < 0) {
> -			dev_err(&indio_dev->dev,
> -				"failed to read Who-Am-I register.\n");
> -			return err;
> +			return dev_err_probe(parent, err,
> +					     "failed to read Who-Am-I register.\n");
>  		}
>  
>  		if (sdata->sensor_settings->wai != wai) {
> -			dev_warn(&indio_dev->dev,
> -				"%s: WhoAmI mismatch (0x%x).\n",
> -				indio_dev->name, wai);
> +			dev_warn(parent, "%s: WhoAmI mismatch (0x%x).\n",
> +				 indio_dev->name, wai);
>  		}
>  	}
>  
> diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> index 9d4bf822a15dfcdd6c2835f6b9d7698cd3cb0b08..32c3278968089699dff5329e943d92b151b55fdf 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> @@ -127,7 +127,7 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
>  	sdata->trig = devm_iio_trigger_alloc(parent, "%s-trigger",
>  					     indio_dev->name);
>  	if (sdata->trig == NULL) {
> -		dev_err(&indio_dev->dev, "failed to allocate iio trigger.\n");
> +		dev_err(parent, "failed to allocate iio trigger.\n");
>  		return -ENOMEM;
>  	}
>  
> @@ -143,7 +143,7 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
>  	case IRQF_TRIGGER_FALLING:
>  	case IRQF_TRIGGER_LOW:
>  		if (!sdata->sensor_settings->drdy_irq.addr_ihl) {
> -			dev_err(&indio_dev->dev,
> +			dev_err(parent,
>  				"falling/low specified for IRQ but hardware supports only rising/high: will request rising/high\n");
>  			if (irq_trig == IRQF_TRIGGER_FALLING)
>  				irq_trig = IRQF_TRIGGER_RISING;
> @@ -156,21 +156,21 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
>  				sdata->sensor_settings->drdy_irq.mask_ihl, 1);
>  			if (err < 0)
>  				return err;
> -			dev_info(&indio_dev->dev,
> +			dev_info(parent,
>  				 "interrupts on the falling edge or active low level\n");
>  		}
>  		break;
>  	case IRQF_TRIGGER_RISING:
> -		dev_info(&indio_dev->dev,
> +		dev_info(parent,
>  			 "interrupts on the rising edge\n");
>  		break;
>  	case IRQF_TRIGGER_HIGH:
> -		dev_info(&indio_dev->dev,
> +		dev_info(parent,
>  			 "interrupts active high level\n");
>  		break;
>  	default:
>  		/* This is the most preferred mode, if possible */
> -		dev_err(&indio_dev->dev,
> +		dev_err(parent,
>  			"unsupported IRQ trigger specified (%lx), enforce rising edge\n", irq_trig);
>  		irq_trig = IRQF_TRIGGER_RISING;
>  	}
> @@ -179,7 +179,7 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
>  	if (irq_trig == IRQF_TRIGGER_FALLING ||
>  	    irq_trig == IRQF_TRIGGER_RISING) {
>  		if (!sdata->sensor_settings->drdy_irq.stat_drdy.addr) {
> -			dev_err(&indio_dev->dev,
> +			dev_err(parent,
>  				"edge IRQ not supported w/o stat register.\n");
>  			return -EOPNOTSUPP;
>  		}
> @@ -214,13 +214,13 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
>  					sdata->trig->name,
>  					sdata->trig);
>  	if (err) {
> -		dev_err(&indio_dev->dev, "failed to request trigger IRQ.\n");
> +		dev_err(parent, "failed to request trigger IRQ.\n");
>  		return err;
>  	}
>  
>  	err = devm_iio_trigger_register(parent, sdata->trig);
>  	if (err < 0) {
> -		dev_err(&indio_dev->dev, "failed to register iio trigger.\n");
> +		dev_err(parent, "failed to register iio trigger.\n");
>  		return err;
>  	}
>  	indio_dev->trig = iio_trigger_get(sdata->trig);
> 
> ---
> base-commit: 7bac2c97af4078d7a627500c9bcdd5b033f97718
> change-id: 20250522-st_iio_fix-1c58fdd4d420
> 
> Best regards,


