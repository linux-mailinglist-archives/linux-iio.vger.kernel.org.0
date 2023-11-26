Return-Path: <linux-iio+bounces-413-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FB47F9517
	for <lists+linux-iio@lfdr.de>; Sun, 26 Nov 2023 20:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E110280D59
	for <lists+linux-iio@lfdr.de>; Sun, 26 Nov 2023 19:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A9512E4C;
	Sun, 26 Nov 2023 19:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b="my8K0AbC"
X-Original-To: linux-iio@vger.kernel.org
X-Greylist: delayed 484 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 26 Nov 2023 11:41:33 PST
Received: from mail.systec-electronic.com (mail.systec-electronic.com [77.220.239.22])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4545CFB;
	Sun, 26 Nov 2023 11:41:33 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id 29A0F9400107;
	Sun, 26 Nov 2023 20:33:27 +0100 (CET)
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id KIOwCtcQtbmb; Sun, 26 Nov 2023 20:33:27 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id DE658940013F;
	Sun, 26 Nov 2023 20:33:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.systec-electronic.com DE658940013F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=systec-electronic.com; s=B34D3B04-5DC7-11EE-83E3-4D8CAB78E8CD;
	t=1701027206; bh=BIAYnnvZIxCliz9/XPiLtrDjPidAlbyqGkqo9D3YcjI=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=my8K0AbCb+gHDmKCHSlqiChxAjzyhtSVq/7v7D1/dEl08d1F4uMsc9+8iDmIflsjX
	 4lmg3PLG6QlPTIpomRKYzBOlEq1w+aTlbuV4BcMoB5yelauFjLf6f8re//bKrG/r9q
	 UOI5W4UZ+l6KEH1SH8NPF5GNmyS7rvIji6kwUEJ9mBY8M53Dp3woYXOBl9D+/JajoL
	 MxzYGo/acr0xpHRCSb4ayPDdqMHYhrL4TCHFidTbrYg599XkrqxahH0P5edkG49nTi
	 GXZsa+CIDIDB497tJID6tnj/dLtj2quvxunVutk/C9pkIQ7lsueBrp0hUqBLIxsfN2
	 9MGTeylZDupeg==
X-Virus-Scanned: amavis at systec-electronic.com
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 5xMO7SSsPwDO; Sun, 26 Nov 2023 20:33:26 +0100 (CET)
Received: from mail.systec-electronic.com (mail.systec-electronic.com [77.220.239.22])
	by mail.systec-electronic.com (Postfix) with ESMTP id 9EF9E9400107;
	Sun, 26 Nov 2023 20:33:26 +0100 (CET)
Date: Sun, 26 Nov 2023 20:33:26 +0100 (CET)
From: "Dr.-Ing. Andre Werner" <andre.werner@systec-electronic.com>
To: Marek Vasut <marex@denx.de>
Cc: linux-iio@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Matti Vaittinen <mazziesaccount@gmail.com>, 
	Alexander Stein <alexander.stein@ew.tq-group.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, 
	Conor Dooley <conor+dt@kernel.org>, Fabio Estevam <festevam@denx.de>, 
	Guenter Roeck <linux@roeck-us.net>, 
	Jonathan Cameron <jic23@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Mark Brown <broonie@kernel.org>, 
	Naresh Solanki <naresh.solanki@9elements.com>, 
	Patrick Rudolph <patrick.rudolph@9elements.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>, 
	Vincent Tremblay <vincent@vtremblay.dev>, devicetree@vger.kernel.org
Message-ID: <907048010.848203.1701027206602.JavaMail.zimbra@systec-electronic.com>
In-Reply-To: <20231125222738.97875-2-marex@denx.de>
References: <20231125222738.97875-1-marex@denx.de> <20231125222738.97875-2-marex@denx.de>
Subject: Re: [PATCH v5 2/2] iio: light: isl76682: Add ISL76682 driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Thread-Topic: light: isl76682: Add ISL76682 driver
Thread-Index: F3dDbnfSZojnCzNiJEArniYAuN0+Hw==

Dear Marek,

see remarks below.

Best regards.

Andr=C3=A9

----- Original Message -----
From: "Marek Vasut" <marex@denx.de>
To: linux-iio@vger.kernel.org
Cc: "Marek Vasut" <marex@denx.de>, "Andy Shevchenko" <andriy.shevchenko@lin=
ux.intel.com>, "Matti Vaittinen" <mazziesaccount@gmail.com>, "Alexander Ste=
in" <alexander.stein@ew.tq-group.com>, "Werner Andre" <andre.werner@systec-=
electronic.com>, "Bjorn Helgaas" <bhelgaas@google.com>, "Conor Dooley" <con=
or+dt@kernel.org>, "Fabio Estevam" <festevam@denx.de>, "Guenter Roeck" <lin=
ux@roeck-us.net>, "Jonathan Cameron" <jic23@kernel.org>, "Krzysztof Kozlows=
ki" <krzysztof.kozlowski+dt@linaro.org>, "Lars-Peter Clausen" <lars@metafoo=
.de>, "Luca Ceresoli" <luca.ceresoli@bootlin.com>, "Mark Brown" <broonie@ke=
rnel.org>, "Naresh Solanki" <naresh.solanki@9elements.com>, "Patrick Rudolp=
h" <patrick.rudolph@9elements.com>, "Rob Herring" <robh+dt@kernel.org>, "St=
efan Windfeldt-Prytz" <stefan.windfeldt-prytz@axis.com>, "Vincent Tremblay"=
 <vincent@vtremblay.dev>, devicetree@vger.kernel.org
Sent: Saturday, November 25, 2023 11:26:23 PM
Subject: [PATCH v5 2/2] iio: light: isl76682: Add ISL76682 driver

The ISL76682 is very basic ALS which only supports ALS or IR mode
in four ranges, 1k/4k/16k/64k LUX. There is no IRQ support or any
other fancy functionality.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Andre Werner <andre.werner@systec-electronic.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Fabio Estevam <festevam@denx.de>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Naresh Solanki <naresh.solanki@9elements.com>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>
Cc: Vincent Tremblay <vincent@vtremblay.dev>
Cc: devicetree@vger.kernel.org
Cc: linux-iio@vger.kernel.org
---
V2: - Overhaul the driver
    - Cache the entire 8-bit command register instead of parts of it
      and build up and rewrite the entire register if necessary
    - Fix illumination scale, add intensity scale, add integration time
V3: - Limit the read data to 16bit ADC range
    - Update Kconfig description
    - Update macros, drop bitshifts
    - Switch over to table lookup for lux ranges
    - Switch over to .read_avail instead of attributes
    - Use guard where applicable
    - Drop remove function in favor of reset action
V4: - Address feedback from Andy
    - Add missing includes
    - Change ISL76682_ADC_MAX to BIT(16) - 1
    - Drop initial ret assignment in isl76682_read_raw()
    - Move return -EINVAL to default: switch-case branch
    - Use switch-case consistenly instead of if/else
    - Drop trailing commas
    - Add comment to isl76682_clear_configure_reg on command zeroing on fai=
lure
    - Drop i2c_set_clientdata
    - Update devm_regmap_init_i2c return value handling
V5: - Remove newline, add newline, around module_i2c_driver
    - Combine if:s
    - Drop inner comma in isl76682_of_match
    - Replace one more break with return -EINVAL
    - Add RB from Andy and Matti
    - Dispose of dependency on i2c_device_id, use ISL76682_DRIVER_NAME
---
 drivers/iio/light/Kconfig    |  15 ++
 drivers/iio/light/Makefile   |   1 +
 drivers/iio/light/isl76682.c | 361 +++++++++++++++++++++++++++++++++++
 3 files changed, 377 insertions(+)
 create mode 100644 drivers/iio/light/isl76682.c

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 45edba797e4c7..9e8cdc091556d 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -252,6 +252,21 @@ config ISL29125
 =09  To compile this driver as a module, choose M here: the module will be
 =09  called isl29125.
=20
+config ISL76682
+=09tristate "Intersil ISL76682 Light Sensor"
+=09depends on I2C
+=09select REGMAP_I2C
+=09help
+=09  Say Y here if you want to build a driver for the Intersil ISL76682
+=09  Ambient Light Sensor and IR Intensity sensor. This driver provides
+=09  the readouts via standard IIO sysfs and device interface. Both ALS
+=09  illuminance and IR illuminance are provided raw with separate scale
+=09  setting which can be configured via sysfs, the default scale is 1000
+=09  lux, other options are 4000/16000/64000 lux.
+
+=09  To compile this driver as a module, choose M here: the module will be
+=09  called isl76682.
+
 config HID_SENSOR_ALS
 =09depends on HID_SENSOR_HUB
 =09select IIO_BUFFER
diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
index c0db4c4c36ec9..09fa585f3109f 100644
--- a/drivers/iio/light/Makefile
+++ b/drivers/iio/light/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_IQS621_ALS)=09+=3D iqs621-als.o
 obj-$(CONFIG_SENSORS_ISL29018)=09+=3D isl29018.o
 obj-$(CONFIG_SENSORS_ISL29028)=09+=3D isl29028.o
 obj-$(CONFIG_ISL29125)=09=09+=3D isl29125.o
+obj-$(CONFIG_ISL76682)=09=09+=3D isl76682.o
 obj-$(CONFIG_JSA1212)=09=09+=3D jsa1212.o
 obj-$(CONFIG_SENSORS_LM3533)=09+=3D lm3533-als.o
 obj-$(CONFIG_LTR501)=09=09+=3D ltr501.o
diff --git a/drivers/iio/light/isl76682.c b/drivers/iio/light/isl76682.c
new file mode 100644
index 0000000000000..1bb44950fbc3e
--- /dev/null
+++ b/drivers/iio/light/isl76682.c
@@ -0,0 +1,361 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * IIO driver for the light sensor ISL76682.
+ * ISL76682 is Ambient Light Sensor
+ *
+ * Copyright (c) 2023 Marek Vasut <marex@denx.de>
+ */
+
+#include <linux/array_size.h>
+#include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/regmap.h>
+#include <linux/types.h>
+
+#include <linux/iio/iio.h>
+
+#define ISL76682_REG_COMMAND=09=09=090x00
+
+#define ISL76682_COMMAND_EN=09=09=09BIT(7)
+#define ISL76682_COMMAND_MODE_CONTINUOUS=09BIT(6)
+#define ISL76682_COMMAND_LIGHT_IR=09=09BIT(5)
+
+#define ISL76682_COMMAND_RANGE_LUX_1K=09=090x0
+#define ISL76682_COMMAND_RANGE_LUX_4K=09=090x1
+#define ISL76682_COMMAND_RANGE_LUX_16K=09=090x2
+#define ISL76682_COMMAND_RANGE_LUX_64K=09=090x3
+#define ISL76682_COMMAND_RANGE_LUX_MASK=09=09GENMASK(1, 0)
+
+#define ISL76682_REG_ALSIR_L=09=09=090x01
+
+#define ISL76682_REG_ALSIR_U=09=09=090x02
+
+#define ISL76682_NUM_REGS=09=09=09(ISL76682_REG_ALSIR_U + 1)
+
+#define ISL76682_CONV_TIME_MS=09=09=09100
+#define ISL76682_INT_TIME_US=09=09=0990000
+
+#define ISL76682_ADC_MAX=09=09=09(BIT(16) - 1)
+
+#define ISL76682_DRIVER_NAME=09=09=09"isl76682"
+
+struct isl76682_chip {
+=09/*
+=09 * Lock to synchronize access to device command register
+=09 * and the content of range variable below.
+=09 */
+=09struct mutex=09=09=09lock;
+=09struct regmap=09=09=09*regmap;
+=09u8=09=09=09=09range;
+=09u8=09=09=09=09command;
+};
+
+struct isl76682_range {
+=09u8=09=09=09=09range;
+=09u32=09=09=09=09als;
+=09u32=09=09=09=09ir;
+};
+
+static struct isl76682_range isl76682_range_table[] =3D {
+=09{ ISL76682_COMMAND_RANGE_LUX_1K, 15000, 10500 },
+=09{ ISL76682_COMMAND_RANGE_LUX_4K, 60000, 42000 },
+=09{ ISL76682_COMMAND_RANGE_LUX_16K, 240000, 168000 },
+=09{ ISL76682_COMMAND_RANGE_LUX_64K, 960000, 673000 }
+};
+
+static int isl76682_get(struct isl76682_chip *chip, bool mode_ir, int *dat=
a)
+{
+=09u8 command;
+=09int ret;
+
+=09command =3D ISL76682_COMMAND_EN | ISL76682_COMMAND_MODE_CONTINUOUS |
+=09=09  chip->range;
+
+=09if (mode_ir)
+=09=09command |=3D ISL76682_COMMAND_LIGHT_IR;
+
+=09if (command !=3D chip->command) {
+=09=09ret =3D regmap_write(chip->regmap, ISL76682_REG_COMMAND, command);
+=09=09if (ret)
+=09=09=09return ret;
+
+=09=09/* Need to wait for conversion time if ALS/IR mode enabled */
+=09=09msleep(ISL76682_CONV_TIME_MS);
+
+=09=09chip->command =3D command;
+=09}
+
+=09ret =3D regmap_bulk_read(chip->regmap, ISL76682_REG_ALSIR_L, data, 2);
+=09*data &=3D ISL76682_ADC_MAX;
+=09return ret;
+}
+
+static int isl76682_write_raw(struct iio_dev *indio_dev,
+=09=09=09      struct iio_chan_spec const *chan,
+=09=09=09      int val, int val2, long mask)
+{
+=09struct isl76682_chip *chip =3D iio_priv(indio_dev);
+=09int i;
+
+=09if (chan->type !=3D IIO_LIGHT && chan->type !=3D IIO_INTENSITY)
+=09=09return -EINVAL;

In my understanding, this is not necessary as you use that 'iio_chan_spec' =
to specify=20
the channels available at all. So there will be no other channel types crea=
ted by the IIO environment, I think.

+
+=09if (mask !=3D IIO_CHAN_INFO_SCALE)
+=09=09return -EINVAL;
+
+=09if (val !=3D 0)
+=09=09return -EINVAL;
+
+=09for (i =3D 0; i < ARRAY_SIZE(isl76682_range_table); i++) {
+=09=09if (chan->type =3D=3D IIO_LIGHT && val2 !=3D isl76682_range_table[i]=
.als)
+=09=09=09=09continue;
+=09=09if (chan->type =3D=3D IIO_INTENSITY && val2 !=3D isl76682_range_tabl=
e[i].ir)
+=09=09=09=09continue;
+
+=09=09scoped_guard(mutex, &chip->lock)
+=09=09=09chip->range =3D isl76682_range_table[i].range;
+=09=09return 0;
+=09}
+
+=09return -EINVAL;
+}
+
+static int isl76682_read_raw(struct iio_dev *indio_dev,
+=09=09=09     struct iio_chan_spec const *chan,
+=09=09=09     int *val, int *val2, long mask)
+{
+=09struct isl76682_chip *chip =3D iio_priv(indio_dev);
+=09int ret;
+=09int i;
+
+=09if (chan->type !=3D IIO_LIGHT && chan->type !=3D IIO_INTENSITY)
+=09=09return -EINVAL;

Same here as described above.

+
+=09guard(mutex)(&chip->lock);
+
+=09switch (mask) {
+=09case IIO_CHAN_INFO_RAW:
+=09=09switch (chan->type) {
+=09=09case IIO_LIGHT:
+=09=09=09ret =3D isl76682_get(chip, false, val);
+=09=09=09return (ret < 0) ? ret : IIO_VAL_INT;
+=09=09case IIO_INTENSITY:
+=09=09=09ret =3D isl76682_get(chip, true, val);
+=09=09=09return (ret < 0) ? ret : IIO_VAL_INT;
+=09=09default:
+=09=09=09return -EINVAL;
+=09=09}
+=09=09return -EINVAL;
+=09case IIO_CHAN_INFO_SCALE:
+=09=09for (i =3D 0; i < ARRAY_SIZE(isl76682_range_table); i++) {
+=09=09=09if (chip->range !=3D isl76682_range_table[i].range)
+=09=09=09=09continue;
+
+=09=09=09*val =3D 0;
+=09=09=09switch (chan->type) {
+=09=09=09case IIO_LIGHT:
+=09=09=09=09*val2 =3D isl76682_range_table[i].als;
+=09=09=09=09return IIO_VAL_INT_PLUS_MICRO;
+=09=09=09case IIO_INTENSITY:
+=09=09=09=09*val2 =3D isl76682_range_table[i].ir;
+=09=09=09=09return IIO_VAL_INT_PLUS_MICRO;
+=09=09=09default:
+=09=09=09=09return -EINVAL;
+=09=09=09}
+=09=09}
+=09=09return -EINVAL;
+=09case IIO_CHAN_INFO_INT_TIME:
+=09=09*val =3D 0;
+=09=09*val2 =3D ISL76682_INT_TIME_US;
+=09=09return IIO_VAL_INT_PLUS_MICRO;
+=09default:
+=09=09return -EINVAL;
+=09}
+}
+
+static int illuminance_scale_available[] =3D {
+=090, 15000,
+=090, 60000,
+=090, 240000,
+=090, 960000,
+};
+
+static int intensity_scale_available[] =3D {
+=090, 10500,
+=090, 42000,
+=090, 168000,
+=090, 673000,
+};
+
+static int integration_time_available[] =3D { 0, ISL76682_INT_TIME_US };
+
+static int isl76682_read_avail(struct iio_dev *indio_dev,
+=09=09=09       struct iio_chan_spec const *chan,
+=09=09=09       const int **vals, int *type,
+=09=09=09       int *length, long mask)
+{
+=09switch (mask) {
+=09case IIO_CHAN_INFO_SCALE:
+=09=09switch (chan->type) {
+=09=09case IIO_LIGHT:
+=09=09=09*vals =3D illuminance_scale_available;
+=09=09=09*length =3D ARRAY_SIZE(illuminance_scale_available);
+=09=09=09*type =3D IIO_VAL_INT_PLUS_MICRO;
+=09=09=09return IIO_AVAIL_LIST;
+=09=09case IIO_INTENSITY:
+=09=09=09*vals =3D intensity_scale_available;
+=09=09=09*length =3D ARRAY_SIZE(intensity_scale_available);
+=09=09=09*type =3D IIO_VAL_INT_PLUS_MICRO;
+=09=09=09return IIO_AVAIL_LIST;
+=09=09default:
+=09=09=09return -EINVAL;
+=09=09}
+=09case IIO_CHAN_INFO_INT_TIME:
+=09=09*vals =3D integration_time_available;
+=09=09*length =3D ARRAY_SIZE(integration_time_available);
+=09=09*type =3D IIO_VAL_INT_PLUS_MICRO;
+=09=09return IIO_AVAIL_LIST;
+=09default:
+=09=09return -EINVAL;
+=09}
+}
+
+static const struct iio_chan_spec isl76682_channels[] =3D {
+=09{
+=09=09.type =3D IIO_LIGHT,
+=09=09.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
+=09=09=09=09      BIT(IIO_CHAN_INFO_SCALE),
+=09=09.info_mask_shared_by_type_available =3D BIT(IIO_CHAN_INFO_SCALE),
+=09=09.info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_INT_TIME),
+=09}, {
+=09=09.type =3D IIO_INTENSITY,
+=09=09.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
+=09=09=09=09      BIT(IIO_CHAN_INFO_SCALE),
+=09=09.info_mask_shared_by_type_available =3D BIT(IIO_CHAN_INFO_SCALE),
+=09=09.info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_INT_TIME),
+=09}
+};
+
+static const struct iio_info isl76682_info =3D {
+=09.read_avail=09=3D isl76682_read_avail,
+=09.read_raw=09=3D isl76682_read_raw,
+=09.write_raw=09=3D isl76682_write_raw,
+};
+
+static int isl76682_clear_configure_reg(struct isl76682_chip *chip)
+{
+=09struct device *dev =3D regmap_get_device(chip->regmap);
+=09int ret;
+
+=09ret =3D regmap_write(chip->regmap, ISL76682_REG_COMMAND, 0x0);
+=09if (ret < 0)
+=09=09dev_err(dev, "Error %d clearing the CONFIGURE register\n", ret);
+
+=09/*
+=09 * In the success case, the command register was zeroed out.
+=09 *
+=09 * In the error case, we do not know in which state the command
+=09 * register is, so we assume it is zeroed out, so that it would
+=09 * be reprogrammed at the next data read out, and at that time
+=09 * we hope it would be reprogrammed successfully. That is very
+=09 * much a best effort approach.
+=09 */
+=09chip->command =3D 0;
+
+=09return ret;
+}
+
+static void isl76682_reset_action(void *chip)
+{
+=09isl76682_clear_configure_reg(chip);
+}
+
+static bool isl76682_is_volatile_reg(struct device *dev, unsigned int reg)
+{
+=09switch (reg) {
+=09case ISL76682_REG_ALSIR_L:
+=09case ISL76682_REG_ALSIR_U:
+=09=09return true;
+=09default:
+=09=09return false;
+=09}
+}
+
+static const struct regmap_config isl76682_regmap_config =3D {
+=09.reg_bits=09=09=3D 8,
+=09.val_bits=09=09=3D 8,
+=09.volatile_reg=09=09=3D isl76682_is_volatile_reg,
+=09.max_register=09=09=3D ISL76682_NUM_REGS - 1,
+=09.num_reg_defaults_raw=09=3D ISL76682_NUM_REGS,
+=09.cache_type=09=09=3D REGCACHE_FLAT,
+};
+
+static int isl76682_probe(struct i2c_client *client)
+{
+=09struct device *dev =3D &client->dev;
+=09struct isl76682_chip *chip;
+=09struct iio_dev *indio_dev;
+=09int ret;
+
+=09indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*chip));
+=09if (!indio_dev)
+=09=09return -ENOMEM;
+
+=09chip =3D iio_priv(indio_dev);
+
+=09mutex_init(&chip->lock);
+
+=09chip->regmap =3D devm_regmap_init_i2c(client, &isl76682_regmap_config);
+=09ret =3D PTR_ERR_OR_ZERO(chip->regmap);
+=09if (ret)
+=09=09return dev_err_probe(dev, ret, "Error initializing regmap\n");
+
+=09chip->range =3D ISL76682_COMMAND_RANGE_LUX_1K;
+
+=09ret =3D isl76682_clear_configure_reg(chip);
+=09if (ret < 0)
+=09=09return ret;
+
+=09ret =3D devm_add_action_or_reset(dev, isl76682_reset_action, chip);
+=09if (ret)
+=09=09return ret;
+
+=09indio_dev->info =3D &isl76682_info;
+=09indio_dev->channels =3D isl76682_channels;
+=09indio_dev->num_channels =3D ARRAY_SIZE(isl76682_channels);
+=09indio_dev->name =3D ISL76682_DRIVER_NAME;
+=09indio_dev->modes =3D INDIO_DIRECT_MODE;
+
+=09return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct i2c_device_id isl76682_id[] =3D {
+=09{ "isl76682" },
+=09{}
+};
+MODULE_DEVICE_TABLE(i2c, isl76682_id);
+
+static const struct of_device_id isl76682_of_match[] =3D {
+=09{ .compatible =3D "isil,isl76682" },
+=09{ }
+};
+MODULE_DEVICE_TABLE(of, isl76682_of_match);
+
+static struct i2c_driver isl76682_driver =3D {
+=09.driver  =3D {
+=09=09.name=09=09=3D ISL76682_DRIVER_NAME,
+=09=09.of_match_table=09=3D isl76682_of_match,
+=09},
+=09.probe=09=09=3D isl76682_probe,
+=09.id_table=09=3D isl76682_id,
+};
+module_i2c_driver(isl76682_driver);
+
+MODULE_DESCRIPTION("ISL76682 Ambient Light Sensor driver");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Marek Vasut <marex@denx.de>");
--=20
2.42.0

