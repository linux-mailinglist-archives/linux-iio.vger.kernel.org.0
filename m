Return-Path: <linux-iio+bounces-7535-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE6792F9D4
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 14:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A1621F234B9
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 12:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D99B16CD30;
	Fri, 12 Jul 2024 12:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xdvsr3pa"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C2D15EFA6;
	Fri, 12 Jul 2024 12:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720785674; cv=none; b=RUQcGM9qxOkACkznoEIUwy0japOD94ViEWwS9P8qtQVVZPY6w2GV0ZyinluO+b67rLfV1yPnjbyu3JaWPtQRTRoUHBN7w22xM7l2R4lGA9ceMAQBhxh12cny9q+saw/EQnVSH9QdZqkhP+Hh6PaUZ9j99jWN7Rv4qOfkSS/q/Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720785674; c=relaxed/simple;
	bh=m8gxeVTMeFpQG9BUlRSXLTmcL9t4lHKryB0B+cWJTAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rqFgM7vJqjKuXlgMsJtz69/axD2UT4MxI31oOws+EaLhG4qcH7SZGOrAgHUjV4E15mlmN+g94C2SuwG6zjuUGx2DaAcg++htcfZ9htmQPlurGWu1f/LjZi5LeAI9Fb0CeV5P8tvVg5IAXQDzJgoKQF3PzX6RGmX6gXHcWtfdDvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xdvsr3pa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD511C32782;
	Fri, 12 Jul 2024 12:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720785673;
	bh=m8gxeVTMeFpQG9BUlRSXLTmcL9t4lHKryB0B+cWJTAs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Xdvsr3paoPtZWEZaqNQhOTsV/wBYIMfNJy3JLo0PtNZ7YS1oTQUErqheVhUU+eVWb
	 aBCHp7K8HU8rqox8QUe2/EnmLY3GKg6M62S8+TBKRvYcX2NQaygUB+qPhKSaBxCXu5
	 Ywcet5SycQTGGbQNcmsjBoyrETtr9BONcoaJYYflBGf++jaEaUYMoWhGorzhitSloV
	 xR/AQnSUihaxQRdMcLoqCeRODWk6x8sYGGHp5AiGncpAAwDEHZT5t23ncqxobFcl3H
	 DEfJ7gxQH5y6eoPS1u3bZ4Rk8sAf2x9fIDG/fRjlv5pU2Al5VpbtFCpdJOuokkGgbh
	 eBq97Q63qMlSw==
Message-ID: <dad53de8-eb62-4d9b-b760-dc2548f05232@kernel.org>
Date: Fri, 12 Jul 2024 14:01:07 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 2/2] Add support for Awinic proximity sensor
To: wangshuaijie@awinic.com, jic23@kernel.org, lars@metafoo.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 waqar.hameed@axis.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: liweilei@awinic.com, kangjiajun@awinic.com
References: <20240712113200.2468249-1-wangshuaijie@awinic.com>
 <20240712113200.2468249-3-wangshuaijie@awinic.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240712113200.2468249-3-wangshuaijie@awinic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/07/2024 13:32, wangshuaijie@awinic.com wrote:
> From: shuaijie wang <wangshuaijie@awinic.com>
> 
> 1. Modify the structure of the driver.
> 2. Change the style of the driver's comments.
> 3. Remove unnecessary log printing.
> 4. Modify the function used for memory allocation.
> 5. Modify the driver registration process.
> 6. Remove the functionality related to updating firmware.
> 7. Change the input subsystem in the driver to the iio subsystem.
> 8. Modify the usage of the interrupt pin.

I don't understand why do you put some sort of changelog into commit
msg. Please read submitting patches.

> 
> Signed-off-by: shuaijie wang <wangshuaijie@awinic.com>
> ---

Please use subject prefixes matching the subsystem. You can get them for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching. For bindings, the preferred subjects are
explained here:
https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters

>  drivers/iio/proximity/Kconfig                 |   10 +
>  drivers/iio/proximity/Makefile                |    2 +
>  drivers/iio/proximity/aw9610x.c               | 1150 ++++++++++
>  drivers/iio/proximity/aw963xx.c               | 1371 ++++++++++++
>  drivers/iio/proximity/aw_sar.c                | 1850 +++++++++++++++++
>  drivers/iio/proximity/aw_sar.h                |   23 +
>  drivers/iio/proximity/aw_sar_comm_interface.c |  550 +++++
>  drivers/iio/proximity/aw_sar_comm_interface.h |  172 ++
>  drivers/iio/proximity/aw_sar_type.h           |  371 ++++
>  9 files changed, 5499 insertions(+)
>  create mode 100644 drivers/iio/proximity/aw9610x.c
>  create mode 100644 drivers/iio/proximity/aw963xx.c
>  create mode 100644 drivers/iio/proximity/aw_sar.c
>  create mode 100644 drivers/iio/proximity/aw_sar.h
>  create mode 100644 drivers/iio/proximity/aw_sar_comm_interface.c
>  create mode 100644 drivers/iio/proximity/aw_sar_comm_interface.h
>  create mode 100644 drivers/iio/proximity/aw_sar_type.h
> 
> diff --git a/drivers/iio/proximity/Kconfig b/drivers/iio/proximity/Kconfig
> index 2ca3b0bc5eba..a60d3dc955b3 100644
> --- a/drivers/iio/proximity/Kconfig
> +++ b/drivers/iio/proximity/Kconfig
> @@ -219,4 +219,14 @@ config VL53L0X_I2C
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called vl53l0x-i2c.
>  
> +config AWINIC_SAR
> +	tristate "Awinic AW96XXX proximity sensor"
> +	depends on I2C
> +	help
> +	  Say Y here to build a driver for Awinic's AW96XXX capacitive
> +	  proximity sensor.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called awinic_sar.
> +
>  endmenu
> diff --git a/drivers/iio/proximity/Makefile b/drivers/iio/proximity/Makefile
> index f36598380446..d4bd9edd8362 100644
> --- a/drivers/iio/proximity/Makefile
> +++ b/drivers/iio/proximity/Makefile
> @@ -21,4 +21,6 @@ obj-$(CONFIG_SX_COMMON) 	+= sx_common.o
>  obj-$(CONFIG_SX9500)		+= sx9500.o
>  obj-$(CONFIG_VCNL3020)		+= vcnl3020.o
>  obj-$(CONFIG_VL53L0X_I2C)	+= vl53l0x-i2c.o
> +obj-$(CONFIG_AWINIC_SAR)	+= awinic_sar.o
> +awinic_sar-objs			:= aw_sar_comm_interface.o aw_sar.o aw9610x.o aw963xx.o
>  



> +
> +static void aw_sar_power_deinit(struct aw_sar *p_sar)
> +{
> +	if (p_sar->power_enable) {
> +		/*
> +		 * Turn off the power output. However,
> +		 * it may not be turned off immediately
> +		 * There are scenes where power sharing can exist
> +		 */
> +		regulator_disable(p_sar->vcc);
> +		regulator_put(p_sar->vcc);
> +	}
> +}
> +
> +static void aw_sar_power_enable(struct aw_sar *p_sar, bool on)
> +{
> +	int rc;
> +
> +	if (on) {
> +		rc = regulator_enable(p_sar->vcc);
> +		if (rc) {
> +			dev_err(p_sar->dev, "regulator_enable vol failed rc = %d", rc);

Again example of ugly code.

> +		} else {
> +			p_sar->power_enable = AW_TRUE;

NAK.

All this driver is some ancient, downstream or user-space-generic-code.
Sorry, you already got such comment.

First, your control of power seems like entire code is spaghetti.
Basically, your control flow is random, no functions know when they are
called. To solve this, you introduce "power_enable" so the functions can
figure out if they are called with power enabled or not.

That's just crappy and spaghetti design.

This redefinition of true and false is a cherry on top. DO NOT EVER send
such code. NEVER.

You must clean up all such user-space/Windows/whatever you have there stuff.

> +			msleep(20);
> +		}
> +	} else {
> +		rc = regulator_disable(p_sar->vcc);
> +		if (rc)
> +			dev_err(p_sar->dev, "regulator_disable vol failed rc = %d", rc);
> +		else
> +			p_sar->power_enable = AW_FALSE;
> +	}
> +}
> +
> +static int regulator_is_get_voltage(struct aw_sar *p_sar)
> +{
> +	unsigned int cnt = 10;
> +	int voltage_val;
> +
> +	while (cnt--) {
> +		voltage_val = regulator_get_voltage(p_sar->vcc);

What is that?

Did you just forgot to set proper ramp delays?

> +		if (voltage_val >= AW_SAR_VCC_MIN_UV)
> +			return 0;
> +		mdelay(1);
> +	}
> +	/* Ensure that the chip initialization is completed */
> +	msleep(20);
> +
> +	return -EINVAL;
> +}
> +/* AW_SAR_REGULATOR_POWER_ON end */


...

> +static int aw_sar_regulator_power(struct aw_sar *p_sar)
> +{
> +	struct aw_sar_dts_info *p_dts_info = &p_sar->dts_info;
> +	int ret = 0;
> +
> +	p_dts_info->use_regulator_flag =
> +		of_property_read_bool(p_sar->i2c->dev.of_node, "awinic,regulator-power-supply");
> +
> +	/* Configure the use of regulator power supply in DTS */
> +	if (p_sar->dts_info.use_regulator_flag == true) {
> +		ret = aw_sar_regulator_power_init(p_sar);
> +		if (ret != 0) {
> +			dev_err(p_sar->dev, "power init failed");
> +			return ret;
> +		}
> +		aw_sar_power_enable(p_sar, AW_TRUE);
> +		ret = regulator_is_get_voltage(p_sar);
> +		if (ret != 0) {
> +			dev_err(p_sar->dev, "get_voltage failed");
> +			aw_sar_power_deinit(p_sar);
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static int aw_sar_get_chip_info(struct aw_sar *p_sar)
> +{
> +	int ret;
> +	unsigned char i;
> +
> +	for (i = 0; i < AW_SAR_DRIVER_MAX; i++) {
> +		if (g_aw_sar_driver_list[i].p_who_am_i != NULL) {

Sorry, this overall code is just ugly and with poor readability.
Variables like "g_aw_sar_driver_list" are just not helping.

The driver is really huge for a "simple" proximity sensor, so I wonder
if this was somehow over-engineered or is not really simple, but quite
complex sensor.

Anyway, huge driver with poor code is not helping to review.


> +
> +
> +/* Drive logic entry */
> +static int aw_sar_i2c_probe(struct i2c_client *i2c)
> +{
> +	struct iio_dev *sar_iio_dev;
> +	struct aw_sar *p_sar;
> +	int ret;
> +
> +	if (!i2c_check_functionality(i2c->adapter, I2C_FUNC_I2C)) {
> +		pr_err("check_functionality failed!\n");
> +		return -EIO;
> +	}
> +
> +	sar_iio_dev = devm_iio_device_alloc(&i2c->dev, sizeof(*p_sar));
> +	if (!sar_iio_dev)
> +		return -ENOMEM;
> +	p_sar = iio_priv(sar_iio_dev);
> +	p_sar->aw_iio_dev = sar_iio_dev;
> +	p_sar->dev = &i2c->dev;
> +	p_sar->i2c = i2c;
> +	i2c_set_clientdata(i2c, p_sar);
> +
> +	/* 1.Judge whether to use regular power supply. If yes, supply power */
> +	ret = aw_sar_regulator_power(p_sar);
> +	if (ret != 0) {
> +		dev_err(&i2c->dev, "regulator_power error!");
> +		return ret;
> +	}
> +
> +	/* 2.Get chip initialization resources */
> +	ret = aw_sar_get_chip_info(p_sar);
> +	if (ret != 0) {
> +		dev_err(&i2c->dev, "chip_init error!");

Not much improved.


<form letter>
This is a friendly reminder during the review process.

It seems my or other reviewer's previous comments were not fully
addressed. Maybe the feedback got lost between the quotes, maybe you
just forgot to apply it. Please go back to the previous discussion and
either implement all requested changes or keep discussing them.

Thank you.
</form letter>

> +
> +static const struct dev_pm_ops aw_sar_pm_ops = {
> +	.suspend = aw_sar_suspend,
> +	.resume = aw_sar_resume,
> +};
> +
> +static const struct of_device_id aw_sar_dt_match[] = {
> +	{ .compatible = "awinic,aw96103" },
> +	{ .compatible = "awinic,aw96105" },
> +	{ .compatible = "awinic,aw96303" },
> +	{ .compatible = "awinic,aw96305" },
> +	{ .compatible = "awinic,aw96308" },
> +	{ },
> +};
> +
> +static const struct i2c_device_id aw_sar_i2c_id[] = {
> +	{ AW_SAR_I2C_NAME, 0 },

Having device_id tables not in sync is usually bad sign. Why do you need
i2c_device_id in the first place?

> +	{ },
> +};
> +MODULE_DEVICE_TABLE(i2c, aw_sar_i2c_id);
> +
> +static struct i2c_driver aw_sar_i2c_driver = {
> +	.driver = {
> +		.name = AW_SAR_I2C_NAME,
> +		.of_match_table = aw_sar_dt_match,
> +		.pm = &aw_sar_pm_ops,
> +	},
> +	.probe = aw_sar_i2c_probe,
> +	.remove = aw_sar_i2c_remove,
> +	.shutdown = aw_sar_i2c_shutdown,
> +	.id_table = aw_sar_i2c_id,
> +};
> +module_i2c_driver(aw_sar_i2c_driver);
> +
> +MODULE_DESCRIPTION("AWINIC SAR Driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_IMPORT_NS(AWINIC_PROX);



Best regards,
Krzysztof


