Return-Path: <linux-iio+bounces-7882-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2630793C253
	for <lists+linux-iio@lfdr.de>; Thu, 25 Jul 2024 14:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A0C61F2199B
	for <lists+linux-iio@lfdr.de>; Thu, 25 Jul 2024 12:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9593D19A2B8;
	Thu, 25 Jul 2024 12:48:43 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from out198-19.us.a.mail.aliyun.com (out198-19.us.a.mail.aliyun.com [47.90.198.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E62E199EBE;
	Thu, 25 Jul 2024 12:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721911723; cv=none; b=WpDVkqoo+bTjNUtwK49zmI0xHvHUvUcG/EwAOjI4eJWJHS+NjRv8vDjTe7PZBhNIlYy/+Qr/QpohKy+ghYJtdeLmPbx6vKIjJlBRzCOtVmPE78gQVOJnYOe45ZHyYRn1dPgnYaqOGzE8YOkQSfjudkRl2KtPbiqSdixlsR6bev0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721911723; c=relaxed/simple;
	bh=P1/oBZy/ngwL5jtS4YPBd8/lp+KIzAaL3jgEgKqbEX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aylNHJtlzw9bc9qyV0K5j5A8BKRGJfj6ub0ghCMQjD01cyTD+g+GCzBHEtOlMQ1WDwWiDtW5LepcFMqcgcIRFJ+96wym+6w4k5dsggp75KM/uY7nzlxGE9saM8RcEw7FBh5LSkgHD0J0GOp7S81I7vc2TbrOZSp/VbAjASnVhfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com; spf=pass smtp.mailfrom=awinic.com; arc=none smtp.client-ip=47.90.198.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=awinic.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436259|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0901258-0.000156517-0.909718;FP=17947816747728639162|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037088118;MF=wangshuaijie@awinic.com;NM=1;PH=DS;RN=13;RT=13;SR=0;TI=SMTPD_---.YZYNTk5_1721911691;
Received: from awinic..(mailfrom:wangshuaijie@awinic.com fp:SMTPD_---.YZYNTk5_1721911691)
          by smtp.aliyun-inc.com;
          Thu, 25 Jul 2024 20:48:20 +0800
From: wangshuaijie@awinic.com
To: krzk@kernel.org
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	jic23@kernel.org,
	kangjiajun@awinic.com,
	krzk+dt@kernel.org,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liweilei@awinic.com,
	robh@kernel.org,
	wangshuaijie@awinic.com,
	waqar.hameed@axis.com
Subject: Re: [PATCH V3 2/2] Add support for Awinic proximity sensor
Date: Thu, 25 Jul 2024 12:48:11 +0000
Message-ID: <20240725124811.890843-1-wangshuaijie@awinic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <dad53de8-eb62-4d9b-b760-dc2548f05232@kernel.org>
References: <dad53de8-eb62-4d9b-b760-dc2548f05232@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,=0D
=0D
On Fri, 12 Jul 2024 14:01:07 +0200, krzk@kernel.org wrote:=0D
>On 12/07/2024 13:32, wangshuaijie@awinic.com wrote:=0D
>> From: shuaijie wang <wangshuaijie@awinic.com>=0D
>> =0D
>> 1. Modify the structure of the driver.=0D
>> 2. Change the style of the driver's comments.=0D
>> 3. Remove unnecessary log printing.=0D
>> 4. Modify the function used for memory allocation.=0D
>> 5. Modify the driver registration process.=0D
>> 6. Remove the functionality related to updating firmware.=0D
>> 7. Change the input subsystem in the driver to the iio subsystem.=0D
>> 8. Modify the usage of the interrupt pin.=0D
>=0D
>I don't understand why do you put some sort of changelog into commit=0D
>msg. Please read submitting patches.=0D
>=0D
=0D
The patch for v4 will fix these issues.=0D
=0D
>> =0D
>> Signed-off-by: shuaijie wang <wangshuaijie@awinic.com>=0D
>> ---=0D
>=0D
>Please use subject prefixes matching the subsystem. You can get them for=0D
>example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory=0D
>your patch is touching. For bindings, the preferred subjects are=0D
>explained here:=0D
>https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patc=
hes.html#i-for-patch-submitters=0D
>=0D
>>  drivers/iio/proximity/Kconfig                 |   10 +=0D
>>  drivers/iio/proximity/Makefile                |    2 +=0D
>>  drivers/iio/proximity/aw9610x.c               | 1150 ++++++++++=0D
>>  drivers/iio/proximity/aw963xx.c               | 1371 ++++++++++++=0D
>>  drivers/iio/proximity/aw_sar.c                | 1850 +++++++++++++++++=
=0D
>>  drivers/iio/proximity/aw_sar.h                |   23 +=0D
>>  drivers/iio/proximity/aw_sar_comm_interface.c |  550 +++++=0D
>>  drivers/iio/proximity/aw_sar_comm_interface.h |  172 ++=0D
>>  drivers/iio/proximity/aw_sar_type.h           |  371 ++++=0D
>>  9 files changed, 5499 insertions(+)=0D
>>  create mode 100644 drivers/iio/proximity/aw9610x.c=0D
>>  create mode 100644 drivers/iio/proximity/aw963xx.c=0D
>>  create mode 100644 drivers/iio/proximity/aw_sar.c=0D
>>  create mode 100644 drivers/iio/proximity/aw_sar.h=0D
>>  create mode 100644 drivers/iio/proximity/aw_sar_comm_interface.c=0D
>>  create mode 100644 drivers/iio/proximity/aw_sar_comm_interface.h=0D
>>  create mode 100644 drivers/iio/proximity/aw_sar_type.h=0D
>> =0D
>> diff --git a/drivers/iio/proximity/Kconfig b/drivers/iio/proximity/Kconf=
ig=0D
>> index 2ca3b0bc5eba..a60d3dc955b3 100644=0D
>> --- a/drivers/iio/proximity/Kconfig=0D
>> +++ b/drivers/iio/proximity/Kconfig=0D
>> @@ -219,4 +219,14 @@ config VL53L0X_I2C=0D
>>  	  To compile this driver as a module, choose M here: the=0D
>>  	  module will be called vl53l0x-i2c.=0D
>>  =0D
>> +config AWINIC_SAR=0D
>> +	tristate "Awinic AW96XXX proximity sensor"=0D
>> +	depends on I2C=0D
>> +	help=0D
>> +	  Say Y here to build a driver for Awinic's AW96XXX capacitive=0D
>> +	  proximity sensor.=0D
>> +=0D
>> +	  To compile this driver as a module, choose M here: the=0D
>> +	  module will be called awinic_sar.=0D
>> +=0D
>>  endmenu=0D
>> diff --git a/drivers/iio/proximity/Makefile b/drivers/iio/proximity/Make=
file=0D
>> index f36598380446..d4bd9edd8362 100644=0D
>> --- a/drivers/iio/proximity/Makefile=0D
>> +++ b/drivers/iio/proximity/Makefile=0D
>> @@ -21,4 +21,6 @@ obj-$(CONFIG_SX_COMMON) 	+=3D sx_common.o=0D
>>  obj-$(CONFIG_SX9500)		+=3D sx9500.o=0D
>>  obj-$(CONFIG_VCNL3020)		+=3D vcnl3020.o=0D
>>  obj-$(CONFIG_VL53L0X_I2C)	+=3D vl53l0x-i2c.o=0D
>> +obj-$(CONFIG_AWINIC_SAR)	+=3D awinic_sar.o=0D
>> +awinic_sar-objs			:=3D aw_sar_comm_interface.o aw_sar.o aw9610x.o aw963=
xx.o=0D
>>  =0D
>=0D
>=0D
>=0D
>> +=0D
>> +static void aw_sar_power_deinit(struct aw_sar *p_sar)=0D
>> +{=0D
>> +	if (p_sar->power_enable) {=0D
>> +		/*=0D
>> +		 * Turn off the power output. However,=0D
>> +		 * it may not be turned off immediately=0D
>> +		 * There are scenes where power sharing can exist=0D
>> +		 */=0D
>> +		regulator_disable(p_sar->vcc);=0D
>> +		regulator_put(p_sar->vcc);=0D
>> +	}=0D
>> +}=0D
>> +=0D
>> +static void aw_sar_power_enable(struct aw_sar *p_sar, bool on)=0D
>> +{=0D
>> +	int rc;=0D
>> +=0D
>> +	if (on) {=0D
>> +		rc =3D regulator_enable(p_sar->vcc);=0D
>> +		if (rc) {=0D
>> +			dev_err(p_sar->dev, "regulator_enable vol failed rc =3D %d", rc);=0D
>=0D
>Again example of ugly code.=0D
>=0D
=0D
The v4 version patch will delete related code.=0D
=0D
>> +		} else {=0D
>> +			p_sar->power_enable =3D AW_TRUE;=0D
>=0D
>NAK.=0D
>=0D
>All this driver is some ancient, downstream or user-space-generic-code.=0D
>Sorry, you already got such comment.=0D
>=0D
>First, your control of power seems like entire code is spaghetti.=0D
>Basically, your control flow is random, no functions know when they are=0D
>called. To solve this, you introduce "power_enable" so the functions can=0D
>figure out if they are called with power enabled or not.=0D
>=0D
>That's just crappy and spaghetti design.=0D
>=0D
>This redefinition of true and false is a cherry on top. DO NOT EVER send=0D
>such code. NEVER.=0D
>=0D
>You must clean up all such user-space/Windows/whatever you have there stuf=
f.=0D
>=0D
=0D
The patch for v4 will fix these issues.=0D
=0D
>> +			msleep(20);=0D
>> +		}=0D
>> +	} else {=0D
>> +		rc =3D regulator_disable(p_sar->vcc);=0D
>> +		if (rc)=0D
>> +			dev_err(p_sar->dev, "regulator_disable vol failed rc =3D %d", rc);=0D
>> +		else=0D
>> +			p_sar->power_enable =3D AW_FALSE;=0D
>> +	}=0D
>> +}=0D
>> +=0D
>> +static int regulator_is_get_voltage(struct aw_sar *p_sar)=0D
>> +{=0D
>> +	unsigned int cnt =3D 10;=0D
>> +	int voltage_val;=0D
>> +=0D
>> +	while (cnt--) {=0D
>> +		voltage_val =3D regulator_get_voltage(p_sar->vcc);=0D
>=0D
>What is that?=0D
>=0D
>Did you just forgot to set proper ramp delays?=0D
>=0D
=0D
The v4 version patch will delete related code.=0D
=0D
>> +		if (voltage_val >=3D AW_SAR_VCC_MIN_UV)=0D
>> +			return 0;=0D
>> +		mdelay(1);=0D
>> +	}=0D
>> +	/* Ensure that the chip initialization is completed */=0D
>> +	msleep(20);=0D
>> +=0D
>> +	return -EINVAL;=0D
>> +}=0D
>> +/* AW_SAR_REGULATOR_POWER_ON end */=0D
>=0D
>=0D
>...=0D
>=0D
>> +static int aw_sar_regulator_power(struct aw_sar *p_sar)=0D
>> +{=0D
>> +	struct aw_sar_dts_info *p_dts_info =3D &p_sar->dts_info;=0D
>> +	int ret =3D 0;=0D
>> +=0D
>> +	p_dts_info->use_regulator_flag =3D=0D
>> +		of_property_read_bool(p_sar->i2c->dev.of_node, "awinic,regulator-powe=
r-supply");=0D
>> +=0D
>> +	/* Configure the use of regulator power supply in DTS */=0D
>> +	if (p_sar->dts_info.use_regulator_flag =3D=3D true) {=0D
>> +		ret =3D aw_sar_regulator_power_init(p_sar);=0D
>> +		if (ret !=3D 0) {=0D
>> +			dev_err(p_sar->dev, "power init failed");=0D
>> +			return ret;=0D
>> +		}=0D
>> +		aw_sar_power_enable(p_sar, AW_TRUE);=0D
>> +		ret =3D regulator_is_get_voltage(p_sar);=0D
>> +		if (ret !=3D 0) {=0D
>> +			dev_err(p_sar->dev, "get_voltage failed");=0D
>> +			aw_sar_power_deinit(p_sar);=0D
>> +		}=0D
>> +	}=0D
>> +=0D
>> +	return ret;=0D
>> +}=0D
>> +=0D
>> +static int aw_sar_get_chip_info(struct aw_sar *p_sar)=0D
>> +{=0D
>> +	int ret;=0D
>> +	unsigned char i;=0D
>> +=0D
>> +	for (i =3D 0; i < AW_SAR_DRIVER_MAX; i++) {=0D
>> +		if (g_aw_sar_driver_list[i].p_who_am_i !=3D NULL) {=0D
>=0D
>Sorry, this overall code is just ugly and with poor readability.=0D
>Variables like "g_aw_sar_driver_list" are just not helping.=0D
>=0D
>The driver is really huge for a "simple" proximity sensor, so I wonder=0D
>if this was somehow over-engineered or is not really simple, but quite=0D
>complex sensor.=0D
>=0D
>Anyway, huge driver with poor code is not helping to review.=0D
>=0D
>=0D
=0D
Thank you for your suggestion. I agree with you that the software=0D
architecture is indeed too complex for proximity sensors. I will=0D
remove the compatibility code in the v4 version patch and only=0D
support the aw9610x series.=0D
=0D
>> +=0D
>> +=0D
>> +/* Drive logic entry */=0D
>> +static int aw_sar_i2c_probe(struct i2c_client *i2c)=0D
>> +{=0D
>> +	struct iio_dev *sar_iio_dev;=0D
>> +	struct aw_sar *p_sar;=0D
>> +	int ret;=0D
>> +=0D
>> +	if (!i2c_check_functionality(i2c->adapter, I2C_FUNC_I2C)) {=0D
>> +		pr_err("check_functionality failed!\n");=0D
>> +		return -EIO;=0D
>> +	}=0D
>> +=0D
>> +	sar_iio_dev =3D devm_iio_device_alloc(&i2c->dev, sizeof(*p_sar));=0D
>> +	if (!sar_iio_dev)=0D
>> +		return -ENOMEM;=0D
>> +	p_sar =3D iio_priv(sar_iio_dev);=0D
>> +	p_sar->aw_iio_dev =3D sar_iio_dev;=0D
>> +	p_sar->dev =3D &i2c->dev;=0D
>> +	p_sar->i2c =3D i2c;=0D
>> +	i2c_set_clientdata(i2c, p_sar);=0D
>> +=0D
>> +	/* 1.Judge whether to use regular power supply. If yes, supply power *=
/=0D
>> +	ret =3D aw_sar_regulator_power(p_sar);=0D
>> +	if (ret !=3D 0) {=0D
>> +		dev_err(&i2c->dev, "regulator_power error!");=0D
>> +		return ret;=0D
>> +	}=0D
>> +=0D
>> +	/* 2.Get chip initialization resources */=0D
>> +	ret =3D aw_sar_get_chip_info(p_sar);=0D
>> +	if (ret !=3D 0) {=0D
>> +		dev_err(&i2c->dev, "chip_init error!");=0D
>=0D
>Not much improved.=0D
>=0D
>=0D
><form letter>=0D
>This is a friendly reminder during the review process.=0D
>=0D
>It seems my or other reviewer's previous comments were not fully=0D
>addressed. Maybe the feedback got lost between the quotes, maybe you=0D
>just forgot to apply it. Please go back to the previous discussion and=0D
>either implement all requested changes or keep discussing them.=0D
>=0D
>Thank you.=0D
></form letter>=0D
>=0D
=0D
The v4 version patch will delete related code.=0D
=0D
>> +=0D
>> +static const struct dev_pm_ops aw_sar_pm_ops =3D {=0D
>> +	.suspend =3D aw_sar_suspend,=0D
>> +	.resume =3D aw_sar_resume,=0D
>> +};=0D
>> +=0D
>> +static const struct of_device_id aw_sar_dt_match[] =3D {=0D
>> +	{ .compatible =3D "awinic,aw96103" },=0D
>> +	{ .compatible =3D "awinic,aw96105" },=0D
>> +	{ .compatible =3D "awinic,aw96303" },=0D
>> +	{ .compatible =3D "awinic,aw96305" },=0D
>> +	{ .compatible =3D "awinic,aw96308" },=0D
>> +	{ },=0D
>> +};=0D
>> +=0D
>> +static const struct i2c_device_id aw_sar_i2c_id[] =3D {=0D
>> +	{ AW_SAR_I2C_NAME, 0 },=0D
>=0D
>Having device_id tables not in sync is usually bad sign. Why do you need=0D
>i2c_device_id in the first place?=0D
>=0D
=0D
The patch for v4 will fix these issues.=0D
=0D
>> +	{ },=0D
>> +};=0D
>> +MODULE_DEVICE_TABLE(i2c, aw_sar_i2c_id);=0D
>> +=0D
>> +static struct i2c_driver aw_sar_i2c_driver =3D {=0D
>> +	.driver =3D {=0D
>> +		.name =3D AW_SAR_I2C_NAME,=0D
>> +		.of_match_table =3D aw_sar_dt_match,=0D
>> +		.pm =3D &aw_sar_pm_ops,=0D
>> +	},=0D
>> +	.probe =3D aw_sar_i2c_probe,=0D
>> +	.remove =3D aw_sar_i2c_remove,=0D
>> +	.shutdown =3D aw_sar_i2c_shutdown,=0D
>> +	.id_table =3D aw_sar_i2c_id,=0D
>> +};=0D
>> +module_i2c_driver(aw_sar_i2c_driver);=0D
>> +=0D
>> +MODULE_DESCRIPTION("AWINIC SAR Driver");=0D
>> +MODULE_LICENSE("GPL v2");=0D
>> +MODULE_IMPORT_NS(AWINIC_PROX);=0D
>=0D
>=0D
>=0D
>Best regards,=0D
>Krzysztof=0D
=0D
Thank you for your response. I will optimize the code in the next=0D
version to make it look more concise.=0D
=0D
Kind regards,=0D
Wang Shuaijie=

