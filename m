Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34910D4F38
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2019 13:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbfJLLEf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Oct 2019 07:04:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:35522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726793AbfJLLEf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 Oct 2019 07:04:35 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08ADC2087E;
        Sat, 12 Oct 2019 11:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570878272;
        bh=yDtvmvKTsw2KNm1ZclOCuto2+dLsbDHW/6AIqDk8l+M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RkBexPQ/SUgue5asNMP7c0zJU6UQzA+CIe086IvV1vTOHtBtvdOuCKQF6eyYaxAJt
         OeLb7l2jLLUlkExz2NIliScztCJE19ONH1g6RYMOSJHtyWvSyGkUHjlx/wzVVmM2iA
         ZPfM2viunReVLQC4215sjCUJVESimrxjQzFmBGX4=
Date:   Sat, 12 Oct 2019 12:04:26 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
Subject: Re: [PATCH v4 1/2] iio: temperature: Add support for LTC2983
Message-ID: <20191012120426.58e6679a@archlinux>
In-Reply-To: <20191011084038.45829-1-nuno.sa@analog.com>
References: <20191011084038.45829-1-nuno.sa@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 11 Oct 2019 10:40:37 +0200
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> The LTC2983 is a Multi-Sensor High Accuracy Digital Temperature
> Measurement System. It measures a wide variety of temperature sensors and
> digitally outputs the result, in =C2=B0C or =C2=B0F, with 0.1=C2=B0C accu=
racy and
> 0.001=C2=B0C resolution. It can measure the temperature of all standard
> thermocouples (type B,E,J,K,N,S,R,T), standard 2-,3-,4-wire RTDs,
> thermistors and diodes.
>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>

There are a few mostly stylistic little bits inline. If you don't need
to do a v5 for the binding, I'll probably just apply this and tidy
them up whilst doing so.

If it looks like I've lost the driver, feel free to poke me in a few
weeks time!

Great stuff,

Thanks,

Jonathan

> ---
> Changes in v2:
>  * Added some needed blank lines (for readability);
>  * Allocate iio_chan in the setup() function;
>  * Rename reset to sleep;
>  * Remove unneeded dev_dbg calls;
>  * Remove unneeded line wrapping;
>  * Remove unneeded comments;
>  * Remove extend_names. Use the standard ABI;
>  * Adapt the scales to report in millivolt and milli degrees;
>  * Adapt the of_property readings to the renaming of the properties;
>  * For custom thermistors, excitation-current cannot be set to Auto range.
>=20
> Changes in v3:
>  * Use normal `devm_request_irq`;
>  * Handle and decode the new devicetree properties for sensor configurati=
on.
>=20
> Changes in v4:
>  * Add 'select REGMAP_SPI';
>  * Use `____cacheline_aligned` for regmap_bulk_read();
>  * Read rsense value as u32 (due to dt bindings change);
>  * __ltc2983_custom_sensor_new(): new argument to identify the property n=
ame;
>  * __ltc2983_custom_sensor_new(): uses u32 api to read steinhart values;
>  * Drop sleep flag and calls to mutex_* in suspend/resume;
>  * Add error handling for regmap calls in setup();
>  * Drop temp_farenheit boolean.
>=20
>  MAINTAINERS                       |    7 +
>  drivers/iio/temperature/Kconfig   |   11 +
>  drivers/iio/temperature/Makefile  |    1 +
>  drivers/iio/temperature/ltc2983.c | 1557 +++++++++++++++++++++++++++++
>  4 files changed, 1576 insertions(+)
>  create mode 100644 drivers/iio/temperature/ltc2983.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f0c03740b9fb..14a256e785ca 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9491,6 +9491,13 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/dac/ltc1660.txt
>  F:	drivers/iio/dac/ltc1660.c
> =20
> +LTC2983 IIO TEMPERATURE DRIVER
> +M:	Nuno S=C3=A1 <nuno.sa@analog.com>
> +W:	http://ez.analog.com/community/linux-device-drivers
> +L:	linux-iio@vger.kernel.org
> +S:	Supported
> +F:	drivers/iio/temperature/ltc2983.c
> +
>  LTC4261 HARDWARE MONITOR DRIVER
>  M:	Guenter Roeck <linux@roeck-us.net>
>  L:	linux-hwmon@vger.kernel.org
> diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kc=
onfig
> index 737faa0901fe..e1ccb4003015 100644
> --- a/drivers/iio/temperature/Kconfig
> +++ b/drivers/iio/temperature/Kconfig
> @@ -4,6 +4,17 @@
>  #
>  menu "Temperature sensors"
> =20
> +config LTC2983
> +	tristate "Analog Devices Multi-Sensor Digital Temperature Measurement S=
ystem"
> +	depends on SPI
> +	select REGMAP_SPI
> +	help
> +	  Say yes here to build support for the LTC2983 Multi-Sensor
> +	  high accuracy digital temperature measurement system.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called ltc2983.
> +
>  config MAXIM_THERMOCOUPLE
>  	tristate "Maxim thermocouple sensors"
>  	depends on SPI
> diff --git a/drivers/iio/temperature/Makefile b/drivers/iio/temperature/M=
akefile
> index baca4776ca0d..d6b850b0cf63 100644
> --- a/drivers/iio/temperature/Makefile
> +++ b/drivers/iio/temperature/Makefile
> @@ -3,6 +3,7 @@
>  # Makefile for industrial I/O temperature drivers
>  #
> =20
> +obj-$(CONFIG_LTC2983) +=3D ltc2983.o
>  obj-$(CONFIG_HID_SENSOR_TEMP) +=3D hid-sensor-temperature.o
>  obj-$(CONFIG_MAXIM_THERMOCOUPLE) +=3D maxim_thermocouple.o
>  obj-$(CONFIG_MAX31856) +=3D max31856.o
> diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/=
ltc2983.c
> new file mode 100644
> index 000000000000..9532cbe06574
> --- /dev/null
> +++ b/drivers/iio/temperature/ltc2983.c
> @@ -0,0 +1,1557 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Analog Devices LTC2983 Multi-Sensor Digital Temperature Measurement S=
ystem
> + * driver
> + *
> + * Copyright 2019 Analog Devices Inc.
> + */
> +#include <linux/bitfield.h>
> +#include <linux/completion.h>
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/iio/iio.h>
> +#include <linux/interrupt.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/of_gpio.h>
> +#include <linux/regmap.h>
> +#include <linux/spi/spi.h>
> +
> +/* register map */
> +#define LTC2983_STATUS_REG			0x0000
> +#define LTC2983_TEMP_RES_START_REG		0x0010
> +#define LTC2983_TEMP_RES_END_REG		0x005F
> +#define LTC2983_GLOBAL_CONFIG_REG		0x00F0
> +#define LTC2983_MULT_CHANNEL_START_REG		0x00F4
> +#define LTC2983_MULT_CHANNEL_END_REG		0x00F7
> +#define LTC2983_MUX_CONFIG_REG			0x00FF
> +#define LTC2983_CHAN_ASSIGN_START_REG		0x0200
> +#define LTC2983_CHAN_ASSIGN_END_REG		0x024F
> +#define LTC2983_CUST_SENS_TBL_START_REG		0x0250
> +#define LTC2983_CUST_SENS_TBL_END_REG		0x03CF
> +
> +#define LTC2983_DIFFERENTIAL_CHAN_MIN		2
> +#define LTC2983_MAX_CHANNELS_NR			20
> +#define LTC2983_MIN_CHANNELS_NR			1
> +#define LTC2983_SLEEP				0x97
> +#define LTC2983_CUSTOM_STEINHART_SIZE		24
> +#define LTC2983_CUSTOM_SENSOR_ENTRY_SZ		6
> +#define LTC2983_CUSTOM_STEINHART_ENTRY_SZ	4
> +
> +#define LTC2983_CHAN_START_ADDR(chan) \
> +			(((chan - 1) * 4) + LTC2983_CHAN_ASSIGN_START_REG)
> +#define LTC2983_CHAN_RES_ADDR(chan) \
> +			(((chan - 1) * 4) + LTC2983_TEMP_RES_START_REG)
> +#define LTC2983_THERMOCOUPLE_DIFF_MASK		BIT(3)
> +#define LTC2983_THERMOCOUPLE_SGL(x) \
> +				FIELD_PREP(LTC2983_THERMOCOUPLE_DIFF_MASK, x)
> +#define LTC2983_THERMOCOUPLE_OC_CURR_MASK	GENMASK(1, 0)
> +#define LTC2983_THERMOCOUPLE_OC_CURR(x) \
> +				FIELD_PREP(LTC2983_THERMOCOUPLE_OC_CURR_MASK, x)
> +#define LTC2983_THERMOCOUPLE_OC_CHECK_MASK	BIT(2)
> +#define LTC2983_THERMOCOUPLE_OC_CHECK(x) \
> +			FIELD_PREP(LTC2983_THERMOCOUPLE_OC_CHECK_MASK, x)
> +
> +#define LTC2983_THERMISTOR_DIFF_MASK		BIT(2)
> +#define LTC2983_THERMISTOR_SGL(x) \
> +				FIELD_PREP(LTC2983_THERMISTOR_DIFF_MASK, x)
> +#define LTC2983_THERMISTOR_R_SHARE_MASK		BIT(1)
> +#define LTC2983_THERMISTOR_R_SHARE(x) \
> +				FIELD_PREP(LTC2983_THERMISTOR_R_SHARE_MASK, x)
> +#define LTC2983_THERMISTOR_C_ROTATE_MASK	BIT(0)
> +#define LTC2983_THERMISTOR_C_ROTATE(x) \
> +				FIELD_PREP(LTC2983_THERMISTOR_C_ROTATE_MASK, x)
> +
> +#define LTC2983_DIODE_DIFF_MASK			BIT(2)
> +#define LTC2983_DIODE_SGL(x) \
> +			FIELD_PREP(LTC2983_DIODE_DIFF_MASK, x)
> +#define LTC2983_DIODE_3_CONV_CYCLE_MASK		BIT(1)
> +#define LTC2983_DIODE_3_CONV_CYCLE(x) \
> +				FIELD_PREP(LTC2983_DIODE_3_CONV_CYCLE_MASK, x)
> +#define LTC2983_DIODE_AVERAGE_ON_MASK		BIT(0)
> +#define LTC2983_DIODE_AVERAGE_ON(x) \
> +				FIELD_PREP(LTC2983_DIODE_AVERAGE_ON_MASK, x)
> +
> +#define LTC2983_RTD_4_WIRE_MASK			BIT(3)
> +#define LTC2983_RTD_ROTATION_MASK		BIT(1)
> +#define LTC2983_RTD_C_ROTATE(x) \
> +			FIELD_PREP(LTC2983_RTD_ROTATION_MASK, x)
> +#define LTC2983_RTD_KELVIN_R_SENSE_MASK		GENMASK(3, 2)
> +#define LTC2983_RTD_N_WIRES_MASK		GENMASK(3, 2)
> +#define LTC2983_RTD_N_WIRES(x) \
> +			FIELD_PREP(LTC2983_RTD_N_WIRES_MASK, x)
> +#define LTC2983_RTD_R_SHARE_MASK		BIT(0)
> +#define LTC2983_RTD_R_SHARE(x) \
> +			FIELD_PREP(LTC2983_RTD_R_SHARE_MASK, 1)
> +
> +#define LTC2983_COMMON_HARD_FAULT_MASK	GENMASK(31, 30)
> +#define LTC2983_COMMON_SOFT_FAULT_MASK	GENMASK(27, 25)
> +
> +#define	LTC2983_STATUS_START_MASK	BIT(7)
> +#define	LTC2983_STATUS_START(x)		FIELD_PREP(LTC2983_STATUS_START_MASK, x)
> +
> +#define	LTC2983_STATUS_CHAN_SEL_MASK	GENMASK(4, 0)
> +#define	LTC2983_STATUS_CHAN_SEL(x) \
> +				FIELD_PREP(LTC2983_STATUS_CHAN_SEL_MASK, x)
> +
> +#define LTC2983_TEMP_UNITS_MASK		BIT(2)
> +#define LTC2983_TEMP_UNITS(x)		FIELD_PREP(LTC2983_TEMP_UNITS_MASK, x)
> +
> +#define LTC2983_NOTCH_FREQ_MASK		GENMASK(1, 0)
> +#define LTC2983_NOTCH_FREQ(x)		FIELD_PREP(LTC2983_NOTCH_FREQ_MASK, x)
> +
> +#define LTC2983_RES_VALID_MASK		BIT(24)
> +#define LTC2983_DATA_MASK		GENMASK(23, 0)
> +#define LTC2983_DATA_SIGN_BIT		23
> +
> +#define LTC2983_CHAN_TYPE_MASK		GENMASK(31, 27)
> +#define LTC2983_CHAN_TYPE(x)		FIELD_PREP(LTC2983_CHAN_TYPE_MASK, x)
> +
> +/* cold junction for thermocouples and rsense for rtd's and thermistor's=
 */
> +#define LTC2983_CHAN_ASSIGN_MASK	GENMASK(26, 22)
> +#define LTC2983_CHAN_ASSIGN(x)		FIELD_PREP(LTC2983_CHAN_ASSIGN_MASK, x)
> +
> +#define LTC2983_CUSTOM_LEN_MASK		GENMASK(5, 0)
> +#define LTC2983_CUSTOM_LEN(x)		FIELD_PREP(LTC2983_CUSTOM_LEN_MASK, x)
> +
> +#define LTC2983_CUSTOM_ADDR_MASK	GENMASK(11, 6)
> +#define LTC2983_CUSTOM_ADDR(x)		FIELD_PREP(LTC2983_CUSTOM_ADDR_MASK, x)
> +
> +#define LTC2983_THERMOCOUPLE_CFG_MASK	GENMASK(21, 18)
> +#define LTC2983_THERMOCOUPLE_CFG(x) \
> +				FIELD_PREP(LTC2983_THERMOCOUPLE_CFG_MASK, x)
> +#define LTC2983_THERMOCOUPLE_HARD_FAULT_MASK	GENMASK(31, 29)
> +#define LTC2983_THERMOCOUPLE_SOFT_FAULT_MASK	GENMASK(28, 25)
> +
> +#define LTC2983_RTD_CFG_MASK		GENMASK(21, 18)
> +#define LTC2983_RTD_CFG(x)		FIELD_PREP(LTC2983_RTD_CFG_MASK, x)
> +#define LTC2983_RTD_EXC_CURRENT_MASK	GENMASK(17, 14)
> +#define LTC2983_RTD_EXC_CURRENT(x) \
> +				FIELD_PREP(LTC2983_RTD_EXC_CURRENT_MASK, x)
> +#define LTC2983_RTD_CURVE_MASK		GENMASK(13, 12)
> +#define LTC2983_RTD_CURVE(x)		FIELD_PREP(LTC2983_RTD_CURVE_MASK, x)
> +
> +#define LTC2983_THERMISTOR_CFG_MASK	GENMASK(21, 19)
> +#define LTC2983_THERMISTOR_CFG(x) \
> +				FIELD_PREP(LTC2983_THERMISTOR_CFG_MASK, x)
> +#define LTC2983_THERMISTOR_EXC_CURRENT_MASK	GENMASK(18, 15)
> +#define LTC2983_THERMISTOR_EXC_CURRENT(x) \
> +			FIELD_PREP(LTC2983_THERMISTOR_EXC_CURRENT_MASK, x)
> +
> +#define LTC2983_DIODE_CFG_MASK		GENMASK(26, 24)
> +#define LTC2983_DIODE_CFG(x)		FIELD_PREP(LTC2983_DIODE_CFG_MASK, x)
> +#define LTC2983_DIODE_EXC_CURRENT_MASK	GENMASK(23, 22)
> +#define LTC2983_DIODE_EXC_CURRENT(x) \
> +				FIELD_PREP(LTC2983_DIODE_EXC_CURRENT_MASK, x)
> +#define LTC2983_DIODE_IDEAL_FACTOR_MASK	GENMASK(21, 0)
> +#define LTC2983_DIODE_IDEAL_FACTOR(x) \
> +				FIELD_PREP(LTC2983_DIODE_IDEAL_FACTOR_MASK, x)
> +
> +#define LTC2983_R_SENSE_VAL_MASK	GENMASK(26, 0)
> +#define LTC2983_R_SENSE_VAL(x)		FIELD_PREP(LTC2983_R_SENSE_VAL_MASK, x)
> +
> +#define LTC2983_ADC_SINGLE_ENDED_MASK	BIT(26)
> +#define LTC2983_ADC_SINGLE_ENDED(x) \
> +				FIELD_PREP(LTC2983_ADC_SINGLE_ENDED_MASK, x)
> +
> +enum {
> +	LTC2983_SENSOR_THERMOCOUPLE =3D 1,
> +	LTC2983_SENSOR_THERMOCOUPLE_CUSTOM =3D 9,
> +	LTC2983_SENSOR_RTD =3D 10,
> +	LTC2983_SENSOR_RTD_CUSTOM =3D 18,
> +	LTC2983_SENSOR_THERMISTOR =3D 19,
> +	LTC2983_SENSOR_THERMISTOR_STEINHART =3D 26,
> +	LTC2983_SENSOR_THERMISTOR_CUSTOM =3D 27,
> +	LTC2983_SENSOR_DIODE =3D 28,
> +	LTC2983_SENSOR_SENSE_RESISTOR =3D 29,
> +	LTC2983_SENSOR_DIRECT_ADC =3D 30,
> +};
> +
> +#define to_thermocouple(_sensor) \
> +		container_of(_sensor, struct ltc2983_thermocouple, sensor)
> +
> +#define to_rtd(_sensor) \
> +		container_of(_sensor, struct ltc2983_rtd, sensor)
> +
> +#define to_thermistor(_sensor) \
> +		container_of(_sensor, struct ltc2983_thermistor, sensor)
> +
> +#define to_diode(_sensor) \
> +		container_of(_sensor, struct ltc2983_diode, sensor)
> +
> +#define to_rsense(_sensor) \
> +		container_of(_sensor, struct ltc2983_rsense, sensor)
> +
> +#define to_adc(_sensor) \
> +		container_of(_sensor, struct ltc2983_adc, sensor)
> +
> +struct ltc2983_data {
> +	struct regmap *regmap;
> +	struct spi_device *spi;
> +	struct mutex lock;
> +	struct completion completion;
> +	struct iio_chan_spec *iio_chan;
> +	struct ltc2983_sensor **sensors;
> +	u32 mux_delay_config;
> +	u32 filter_notch_freq;
> +	u16 custom_table_size;
> +	u8 num_channels;
> +	u8 iio_channels;
> +	/*
> +	 * DMA (thus cache coherency maintenance) requires the
> +	 * transfer buffers to live in their own cache lines.
> +	 * Holds the converted temperature
> +	 */
> +	__be32 temp ____cacheline_aligned;
> +};
> +
> +struct ltc2983_sensor {
> +	int (*fault_handler)(const struct ltc2983_data *st, const u32 result);
> +	int (*assign_chan)(struct ltc2983_data *st,
> +			   const struct ltc2983_sensor *sensor);
> +	/* specifies the sensor channel */
> +	u32 chan;
> +	/* sensor type */
> +	u32 type;
> +};
> +
> +struct ltc2983_custom_sensor {
> +	/* raw table sensor data */
> +	u8 *table;
> +	size_t size;
> +	/* address offset */
> +	s8 offset;
> +	bool is_steinhart;
> +};
> +
> +struct ltc2983_thermocouple {
> +	struct ltc2983_sensor sensor;
> +	struct ltc2983_custom_sensor *custom;
> +	u32 sensor_config;
> +	u32 cold_junction_chan;
> +};
> +
> +struct ltc2983_rtd {
> +	struct ltc2983_sensor sensor;
> +	struct ltc2983_custom_sensor *custom;
> +	u32 sensor_config;
> +	u32 r_sense_chan;
> +	u32 excitation_current;
> +	u32 rtd_curve;
> +};
> +
> +struct ltc2983_thermistor {
> +	struct ltc2983_sensor sensor;
> +	struct ltc2983_custom_sensor *custom;
> +	u32 sensor_config;
> +	u32 r_sense_chan;
> +	u32 excitation_current;
> +};
> +
> +struct ltc2983_diode {
> +	struct ltc2983_sensor sensor;
> +	u32 sensor_config;
> +	u32 excitation_current;
> +	u32 ideal_factor_value;
> +};
> +
> +struct ltc2983_rsense {
> +	struct ltc2983_sensor sensor;
> +	u32 r_sense_val;
> +};
> +
> +struct ltc2983_adc {
> +	struct ltc2983_sensor sensor;
> +	bool single_ended;
> +};
> +
> +/*
> + * Convert to Q format numbers. These number's are integers where
> + * the number of integer and fractional bits are specified. The resoluti=
on
> + * is given by 1/@resolution and tell us the number of fractional bits. =
For
> + * instance a resolution of 2^-10 means we have 10 fractional bits.
> + */
> +static u32 __convert_to_raw(const u64 val, const u32 resolution)
> +{
> +	u64 __res =3D val * resolution;
> +
> +	/* all values are multiplied by 1000000 to remove the fraction */
> +	do_div(__res, 1000000);
> +
> +	return __res;
> +}
> +
> +static u32 __convert_to_raw_sign(const u64 val, const u32 resolution)
> +{
> +	s64 __res =3D -(s32)val;
> +
> +	__res =3D __convert_to_raw(__res, resolution);
> +
> +	return (u32)-__res;
> +}
> +
> +static int __ltc2983_fault_handler(const struct ltc2983_data *st,
> +				   const u32 result, const u32 hard_mask,
> +				   const u32 soft_mask)
> +{
> +	const struct device *dev =3D &st->spi->dev;
> +
> +	if (result & hard_mask) {
> +		dev_err(dev, "Invalid conversion: Sensor HARD fault\n");
> +		return -EIO;
> +	} else if (result & soft_mask) {
> +		/* just print a warning */
> +		dev_warn(dev, "Suspicious conversion: Sensor SOFT fault\n");
> +	}
> +
> +	return 0;
> +}
> +
> +static int __ltc2983_chan_assign_common(const struct ltc2983_data *st,
> +					const struct ltc2983_sensor *sensor,
> +					u32 chan_val)
> +{
> +	u32 reg =3D LTC2983_CHAN_START_ADDR(sensor->chan);
> +	__be32 __chan_val;
> +
> +	chan_val |=3D LTC2983_CHAN_TYPE(sensor->type);
> +	dev_dbg(&st->spi->dev, "Assign reg:0x%04X, val:0x%08X\n", reg,
> +								chan_val);
> +	__chan_val =3D cpu_to_be32(chan_val);
> +	return regmap_bulk_write(st->regmap, reg, &__chan_val,
> +				 sizeof(__chan_val));
> +}
> +
> +static int __ltc2983_chan_custom_sensor_assign(struct ltc2983_data *st,
> +					  struct ltc2983_custom_sensor *custom,
> +					  u32 *chan_val)
> +{
> +	u32 reg;
> +	u8 mult =3D custom->is_steinhart ? LTC2983_CUSTOM_STEINHART_ENTRY_SZ :
> +		LTC2983_CUSTOM_SENSOR_ENTRY_SZ;
> +	const struct device *dev =3D &st->spi->dev;
> +	/*
> +	 * custom->size holds the raw size of the table. However, when
> +	 * configuring the sensor channel, we must write the number of
> +	 * entries of the table minus 1. For steinhart sensors 0 is written
> +	 * since the size is constant!
> +	 */
> +	const u8 len =3D custom->is_steinhart ? 0 :
> +		(custom->size / LTC2983_CUSTOM_SENSOR_ENTRY_SZ) - 1;
> +	/*
> +	 * Check if the offset was assigned already. It should be for steinhart
> +	 * sensors. When coming from sleep, it should be assigned for all.
> +	 */
> +	if (custom->offset < 0) {
> +		/*
> +		 * This needs to be done again here because, from the moment
> +		 * when this test was done (successfully) for this custom
> +		 * sensor, a steinhart sensor might have been added changing
> +		 * custom_table_size...
> +		 */
> +		if (st->custom_table_size + custom->size >
> +		    (LTC2983_CUST_SENS_TBL_END_REG -
> +		     LTC2983_CUST_SENS_TBL_START_REG) + 1) {
> +			dev_err(dev,
> +				"Not space left(%d) for new custom sensor(%zu)",
> +							st->custom_table_size,
> +							custom->size);
> +			return -EINVAL;
> +		}
> +
> +		custom->offset =3D st->custom_table_size /
> +					LTC2983_CUSTOM_SENSOR_ENTRY_SZ;
> +		st->custom_table_size +=3D custom->size;
> +	}
> +
> +	reg =3D (custom->offset * mult) + LTC2983_CUST_SENS_TBL_START_REG;
> +
> +	*chan_val |=3D LTC2983_CUSTOM_LEN(len);
> +	*chan_val |=3D LTC2983_CUSTOM_ADDR(custom->offset);
> +	dev_dbg(dev, "Assign custom sensor, reg:0x%04X, off:%d, sz:%zu",
> +							reg, custom->offset,
> +							custom->size);
> +	/* write custom sensor table */
> +	return regmap_bulk_write(st->regmap, reg, custom->table, custom->size);
> +}
> +
> +static struct ltc2983_custom_sensor *__ltc2983_custom_sensor_new(
> +						struct ltc2983_data *st,
> +						const struct device_node *np,
> +						const char *propname,
> +						const bool is_steinhart,
> +						const u32 resolution,
> +						const bool has_signed)
> +{
> +	struct ltc2983_custom_sensor *new_custom;
> +	u8 index, n_entries, tbl =3D 0;
> +	struct device *dev =3D &st->spi->dev;
> +	/*
> +	 * For custom steinhart, the full u32 is taken. For all the others
> +	 * the MSB is discarded.
> +	 */
> +	const u8 n_size =3D (is_steinhart =3D=3D true) ? 4 : 3;
> +	const u8 e_size =3D (is_steinhart =3D=3D true) ? sizeof(u32) : sizeof(u=
64);
> +
> +	n_entries =3D of_property_count_elems_of_size(np, propname, e_size);
> +	/* n_entries must be an even number */
> +	if (!n_entries || (n_entries % 2) !=3D 0) {
> +		dev_err(dev, "Number of entries either 0 or not even\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	new_custom =3D devm_kzalloc(dev, sizeof(*new_custom), GFP_KERNEL);
> +	if (!new_custom)
> +		return ERR_PTR(-ENOMEM);
> +
> +	new_custom->size =3D n_entries * n_size;
> +	/* check Steinhart size */
> +	if (is_steinhart && new_custom->size !=3D LTC2983_CUSTOM_STEINHART_SIZE=
) {
> +		dev_err(dev, "Steinhart sensors size(%zu) must be 24",
> +							new_custom->size);
> +		return ERR_PTR(-EINVAL);
> +	}
> +	/* Check space on the table. */
> +	if (st->custom_table_size + new_custom->size >
> +	    (LTC2983_CUST_SENS_TBL_END_REG -
> +	     LTC2983_CUST_SENS_TBL_START_REG) + 1) {
> +		dev_err(dev, "No space left(%d) for new custom sensor(%zu)",
> +				st->custom_table_size, new_custom->size);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	/* allocate the table */
> +	new_custom->table =3D devm_kzalloc(dev, new_custom->size, GFP_KERNEL);
> +	if (!new_custom->table)
> +		return ERR_PTR(-ENOMEM);
> +
> +	for (index =3D 0; index < n_entries; index++) {
> +		u64 temp =3D 0, j;
> +		/*
> +		 * Steinhart sensors are configured with raw values in the
> +		 * devicetree. For the other sensors we must convert the
> +		 * value to raw. The odd index's correspond to temperarures
> +		 * and always have 1/1024 of resolution. Temperatures also
> +		 * come in kelvin, so signed values is not possible
> +		 */
> +		if (!is_steinhart) {
> +			of_property_read_u64_index(np, propname, index, &temp);
> +
> +			if ((index % 2) !=3D 0)
> +				temp =3D __convert_to_raw(temp, 1024);
> +			else if (has_signed && (s64)temp < 0)
> +				temp =3D __convert_to_raw_sign(temp, resolution);
> +			else
> +				temp =3D __convert_to_raw(temp, resolution);
> +		} else {
> +			of_property_read_u32_index(np, propname, index,
> +						   (u32 *)&temp);
> +		}
> +
> +		for (j =3D 0; j < n_size; j++)
> +			new_custom->table[tbl++] =3D
> +				temp >> (8 * (n_size - j - 1));
> +	}
> +
> +	new_custom->is_steinhart =3D is_steinhart;
> +	/*
> +	 * This is done to first add all the steinhart sensors to the table,
> +	 * in order to maximize the table usage. If we mix adding steinhart
> +	 * with the other sensors, we might have to do some roundup to make
> +	 * sure that sensor_addr - 0x250(start address) is a multiple of 4
> +	 * (for steinhart), and a multiple of 6 for all the other sensors.
> +	 * Since we have const 24 bytes for steinhart sensors and 24 is
> +	 * also a multiple of 6, we guarantee that the first non-steinhart
> +	 * sensor will sit in a correct address without the need of filling
> +	 * addresses.
> +	 */
> +	if (is_steinhart) {
> +		new_custom->offset =3D st->custom_table_size /
> +					LTC2983_CUSTOM_STEINHART_ENTRY_SZ;
> +		st->custom_table_size +=3D new_custom->size;
> +	} else {
> +		/* mark as unset. This is checked later on the assign phase */
> +		new_custom->offset =3D -1;
> +	}
> +
> +	return new_custom;
> +}
> +
> +static int ltc2983_thermocouple_fault_handler(const struct ltc2983_data =
*st,
> +					      const u32 result)
> +{
> +	return __ltc2983_fault_handler(st, result,
> +				       LTC2983_THERMOCOUPLE_HARD_FAULT_MASK,
> +				       LTC2983_THERMOCOUPLE_SOFT_FAULT_MASK);
> +}
> +
> +static int ltc2983_common_fault_handler(const struct ltc2983_data *st,
> +					const u32 result)
> +{
> +	return __ltc2983_fault_handler(st, result,
> +				       LTC2983_COMMON_HARD_FAULT_MASK,
> +				       LTC2983_COMMON_SOFT_FAULT_MASK);
> +}
> +
> +static int ltc2983_thermocouple_assign_chan(struct ltc2983_data *st,
> +				const struct ltc2983_sensor *sensor)
> +{
> +	struct ltc2983_thermocouple *thermo =3D to_thermocouple(sensor);
> +	u32 chan_val;
> +
> +	chan_val =3D LTC2983_CHAN_ASSIGN(thermo->cold_junction_chan);
> +	chan_val |=3D LTC2983_THERMOCOUPLE_CFG(thermo->sensor_config);
> +
> +	if (thermo->custom) {
> +		int ret;
> +
> +		ret =3D __ltc2983_chan_custom_sensor_assign(st, thermo->custom,
> +							  &chan_val);
> +		if (ret)
> +			return ret;
> +	}
> +	return __ltc2983_chan_assign_common(st, sensor, chan_val);
> +}
> +
> +static int ltc2983_rtd_assign_chan(struct ltc2983_data *st,
> +				   const struct ltc2983_sensor *sensor)
> +{
> +	struct ltc2983_rtd *rtd =3D to_rtd(sensor);
> +	u32 chan_val;
> +
> +	chan_val =3D LTC2983_CHAN_ASSIGN(rtd->r_sense_chan);
> +	chan_val |=3D LTC2983_RTD_CFG(rtd->sensor_config);
> +	chan_val |=3D LTC2983_RTD_EXC_CURRENT(rtd->excitation_current);
> +	chan_val |=3D LTC2983_RTD_CURVE(rtd->rtd_curve);
> +
> +	if (rtd->custom) {
> +		int ret;
> +
> +		ret =3D __ltc2983_chan_custom_sensor_assign(st, rtd->custom,
> +							  &chan_val);
> +		if (ret)
> +			return ret;
> +	}
> +	return __ltc2983_chan_assign_common(st, sensor, chan_val);
> +}
> +
> +static int ltc2983_thermistor_assign_chan(struct ltc2983_data *st,
> +					  const struct ltc2983_sensor *sensor)
> +{
> +	struct ltc2983_thermistor *thermistor =3D to_thermistor(sensor);
> +	u32 chan_val;
> +
> +	chan_val =3D LTC2983_CHAN_ASSIGN(thermistor->r_sense_chan);
> +	chan_val |=3D LTC2983_THERMISTOR_CFG(thermistor->sensor_config);
> +	chan_val |=3D
> +		LTC2983_THERMISTOR_EXC_CURRENT(thermistor->excitation_current);
> +
> +	if (thermistor->custom) {
> +		int ret;
> +
> +		ret =3D __ltc2983_chan_custom_sensor_assign(st,
> +							  thermistor->custom,
> +							  &chan_val);
> +		if (ret)
> +			return ret;
> +	}
> +	return __ltc2983_chan_assign_common(st, sensor, chan_val);
> +}
> +
> +static int ltc2983_diode_assign_chan(struct ltc2983_data *st,
> +				     const struct ltc2983_sensor *sensor)
> +{
> +	struct ltc2983_diode *diode =3D to_diode(sensor);
> +	u32 chan_val;
> +
> +	chan_val =3D LTC2983_DIODE_CFG(diode->sensor_config);
> +	chan_val |=3D LTC2983_DIODE_EXC_CURRENT(diode->excitation_current);
> +	chan_val |=3D LTC2983_DIODE_IDEAL_FACTOR(diode->ideal_factor_value);
> +
> +	return __ltc2983_chan_assign_common(st, sensor, chan_val);
> +}
> +
> +static int ltc2983_r_sense_assign_chan(struct ltc2983_data *st,
> +				       const struct ltc2983_sensor *sensor)
> +{
> +	struct ltc2983_rsense *rsense =3D to_rsense(sensor);
> +	u32 chan_val;
> +
> +	chan_val =3D LTC2983_R_SENSE_VAL(rsense->r_sense_val);
> +
> +	return __ltc2983_chan_assign_common(st, sensor, chan_val);
> +}
> +
> +static int ltc2983_adc_assign_chan(struct ltc2983_data *st,
> +				   const struct ltc2983_sensor *sensor)
> +{
> +	struct ltc2983_adc *adc =3D to_adc(sensor);
> +	u32 chan_val;
> +
> +	chan_val =3D LTC2983_ADC_SINGLE_ENDED(adc->single_ended);
> +
> +	return __ltc2983_chan_assign_common(st, sensor, chan_val);
> +}
> +
> +static struct ltc2983_sensor *ltc2983_thermocouple_new(
> +					const struct device_node *child,
> +					struct ltc2983_data *st,
> +					const struct ltc2983_sensor *sensor)
> +{
> +	struct ltc2983_thermocouple *thermo;
> +	struct device_node *phandle;
> +	u32 oc_current;
> +	int ret;
> +
> +	thermo =3D devm_kzalloc(&st->spi->dev, sizeof(*thermo), GFP_KERNEL);
> +	if (!thermo)
> +		return ERR_PTR(-ENOMEM);
> +
> +	if (of_property_read_bool(child, "adi,single-ended"))
> +		thermo->sensor_config =3D LTC2983_THERMOCOUPLE_SGL(1);
> +
> +	ret =3D of_property_read_u32(child, "adi,sensor-oc-current-microamp",
> +				   &oc_current);
> +	if (!ret) {
> +		switch (oc_current) {
> +		case 10:
> +			thermo->sensor_config |=3D
> +					LTC2983_THERMOCOUPLE_OC_CURR(0);
> +			break;
> +		case 100:
> +			thermo->sensor_config |=3D
> +					LTC2983_THERMOCOUPLE_OC_CURR(1);
> +			break;
> +		case 500:
> +			thermo->sensor_config |=3D
> +					LTC2983_THERMOCOUPLE_OC_CURR(2);
> +			break;
> +		case 1000:
> +			thermo->sensor_config |=3D
> +					LTC2983_THERMOCOUPLE_OC_CURR(3);
> +			break;
> +		default:
> +			dev_err(&st->spi->dev,
> +				"Invalid open circuit current:%u", oc_current);
> +			return ERR_PTR(-EINVAL);
> +		}
> +
> +		thermo->sensor_config |=3D LTC2983_THERMOCOUPLE_OC_CHECK(1);
> +	}
> +	/* validate channel index */
> +	if (!(thermo->sensor_config & LTC2983_THERMOCOUPLE_DIFF_MASK) &&
> +	    sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN) {
> +		dev_err(&st->spi->dev,
> +			"Invalid chann:%d for differential thermocouple",
> +								sensor->chan);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	phandle =3D of_parse_phandle(child, "adi,cold-junction-handle", 0);
> +	if (phandle) {
> +		int ret;
> +
> +		ret =3D of_property_read_u32(phandle, "reg",
> +					   &thermo->cold_junction_chan);
> +		if (ret) {
> +			/*
> +			 * This would be catched later but we can just return
> +			 * the error right away.
> +			 */
> +			dev_err(&st->spi->dev, "Property reg must be given\n");
> +			of_node_put(phandle);
> +			return ERR_PTR(-EINVAL);
> +		}
> +	}
> +
> +	/* check custom sensor */
> +	if (sensor->type =3D=3D LTC2983_SENSOR_THERMOCOUPLE_CUSTOM) {
> +		const char *propname =3D "adi,custom-thermocouple";
> +
> +		thermo->custom =3D __ltc2983_custom_sensor_new(st, child,
> +							     propname, false,
> +							     16384, true);
> +		if (IS_ERR(thermo->custom)) {
> +			of_node_put(phandle);
> +			return ERR_CAST(thermo->custom);
> +		}
> +	}
> +
> +	/* set common parameters */
> +	thermo->sensor.fault_handler =3D ltc2983_thermocouple_fault_handler;
> +	thermo->sensor.assign_chan =3D ltc2983_thermocouple_assign_chan;
> +
> +	of_node_put(phandle);
> +	return &thermo->sensor;
> +}
> +
> +static struct ltc2983_sensor *ltc2983_rtd_new(const struct device_node *=
child,
> +					  struct ltc2983_data *st,
> +					  const struct ltc2983_sensor *sensor)
> +{
> +	struct ltc2983_rtd *rtd;
> +	int ret =3D 0;
> +	struct device *dev =3D &st->spi->dev;
> +	struct device_node *phandle;
> +	u32 excitation_current =3D 0, n_wires =3D 0;
> +
> +	rtd =3D devm_kzalloc(dev, sizeof(*rtd), GFP_KERNEL);
> +	if (!rtd)
> +		return ERR_PTR(-ENOMEM);
> +
> +	phandle =3D of_parse_phandle(child, "adi,rsense-handle", 0);
> +	if (!phandle) {
> +		dev_err(dev, "Property adi,rsense-handle missing or invalid");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	ret =3D of_property_read_u32(phandle, "reg", &rtd->r_sense_chan);
> +	if (ret) {
> +		dev_err(dev, "Property reg must be given\n");
> +		goto fail;
> +	}
> +
> +	ret =3D of_property_read_u32(child, "adi,number-of-wires", &n_wires);
> +	if (!ret) {
> +		switch (n_wires) {
> +		case 2:
> +			rtd->sensor_config =3D LTC2983_RTD_N_WIRES(0);
> +			break;
> +		case 3:
> +			rtd->sensor_config =3D LTC2983_RTD_N_WIRES(1);
> +			break;
> +		case 4:
> +			rtd->sensor_config =3D LTC2983_RTD_N_WIRES(2);
> +			break;
> +		case 5:
> +			/* 4 wires, Kelvin Rsense */
> +			rtd->sensor_config =3D LTC2983_RTD_N_WIRES(3);
> +			break;
> +		default:
> +			dev_err(dev, "Invalid number of wires:%u\n", n_wires);
> +			ret =3D -EINVAL;
> +			goto fail;
> +		}
> +	}
> +
> +	if (of_property_read_bool(child, "adi,rsense-share")) {
> +		/* Current rotation is only available with rsense sharing */
> +		if (of_property_read_bool(child, "adi,current-rotate")) {
> +			if (n_wires =3D=3D 2 || n_wires =3D=3D 3) {
> +				dev_err(dev,
> +					"Rotation not allowed for 2/3 Wire RTDs");
> +				ret =3D -EINVAL;
> +				goto fail;
> +			}
> +			rtd->sensor_config |=3D LTC2983_RTD_C_ROTATE(1);
> +		} else {
> +			rtd->sensor_config |=3D LTC2983_RTD_R_SHARE(1);
> +		}
> +	}
> +	/*
> +	 * rtd channel indexes are a bit more complicated to validate.
> +	 * For 4wire RTD with rotation, the channel selection cannot be
> +	 * >=3D19 since the chann + 1 is used in this configuration.
> +	 * For 4wire RTDs with kelvin rsense, the rsense channel cannot be
> +	 * <=3D1 since chanel - 1 and channel - 2 are used.
> +	 */
> +	if (rtd->sensor_config & LTC2983_RTD_4_WIRE_MASK) {
> +		/* 4-wire */
> +		u8 min =3D LTC2983_DIFFERENTIAL_CHAN_MIN,
> +			max =3D LTC2983_MAX_CHANNELS_NR;
> +
> +		if (rtd->sensor_config & LTC2983_RTD_ROTATION_MASK)
> +			max =3D LTC2983_MAX_CHANNELS_NR - 1;
> +
> +		if (((rtd->sensor_config & LTC2983_RTD_KELVIN_R_SENSE_MASK)
> +		     =3D=3D LTC2983_RTD_KELVIN_R_SENSE_MASK) &&
> +		    (rtd->r_sense_chan <=3D  min)) {
> +			/* kelvin rsense*/
> +			dev_err(dev,
> +				"Invalid rsense chann:%d to use in kelvin rsense",
> +							rtd->r_sense_chan);
> +
> +			ret =3D -EINVAL;
> +			goto fail;
> +		}
> +
> +		if (sensor->chan < min || sensor->chan > max) {
> +			dev_err(dev, "Invalid chann:%d for the rtd config",
> +								sensor->chan);
> +
> +			ret =3D -EINVAL;
> +			goto fail;
> +		}
> +	} else {
> +		/* same as differential case */
> +		if (sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN) {
> +			dev_err(&st->spi->dev,
> +				"Invalid chann:%d for RTD", sensor->chan);
> +
> +			ret =3D -EINVAL;
> +			goto fail;
> +		}
> +	}
> +
> +	/* check custom sensor */
> +	if (sensor->type =3D=3D LTC2983_SENSOR_RTD_CUSTOM) {
> +		rtd->custom =3D __ltc2983_custom_sensor_new(st, child,
> +							  "adi,custom-rtd",
> +							  false, 2048, false);
> +		if (IS_ERR(rtd->custom)) {
> +			of_node_put(phandle);
> +			return ERR_CAST(rtd->custom);
> +		}
> +	}
> +
> +	/* set common parameters */
> +	rtd->sensor.fault_handler =3D ltc2983_common_fault_handler;
> +	rtd->sensor.assign_chan =3D ltc2983_rtd_assign_chan;
> +
> +	ret =3D of_property_read_u32(child, "adi,excitation-current-microamp",
> +				   &excitation_current);
> +	if (ret) {
> +		/* default to 5uA */
> +		rtd->excitation_current =3D 1;
> +	} else {
> +		switch (excitation_current) {
> +		case 5:
> +			rtd->excitation_current =3D 0x01;
> +			break;
> +		case 10:
> +			rtd->excitation_current =3D 0x02;
> +			break;
> +		case 25:
> +			rtd->excitation_current =3D 0x03;
> +			break;
> +		case 50:
> +			rtd->excitation_current =3D 0x04;
> +			break;
> +		case 100:
> +			rtd->excitation_current =3D 0x05;
> +			break;
> +		case 250:
> +			rtd->excitation_current =3D 0x06;
> +			break;
> +		case 500:
> +			rtd->excitation_current =3D 0x07;
> +			break;
> +		case 1000:
> +			rtd->excitation_current =3D 0x08;
> +			break;
> +		default:
> +			dev_err(&st->spi->dev,
> +				"Invalid value for excitation current(%u)",
> +							excitation_current);
> +			ret =3D -EINVAL;
> +			goto fail;
> +		}
> +	}
> +
> +	of_property_read_u32(child, "adi,rtd-curve", &rtd->rtd_curve);
> +
> +	of_node_put(phandle);
> +	return &rtd->sensor;
> +fail:
> +	of_node_put(phandle);
> +	return ERR_PTR(ret);
> +}
> +
> +static struct ltc2983_sensor *ltc2983_thermistor_new(
> +					const struct device_node *child,
> +					struct ltc2983_data *st,
> +					const struct ltc2983_sensor *sensor)
> +{
> +	struct ltc2983_thermistor *thermistor;
> +	struct device *dev =3D &st->spi->dev;
> +	struct device_node *phandle;
> +	u32 excitation_current =3D 0;
> +	int ret =3D 0;
> +
> +	thermistor =3D devm_kzalloc(dev, sizeof(*thermistor), GFP_KERNEL);
> +	if (!thermistor)
> +		return ERR_PTR(-ENOMEM);
> +
> +	phandle =3D of_parse_phandle(child, "adi,rsense-handle", 0);
> +	if (!phandle) {
> +		dev_err(dev, "Property adi,rsense-handle missing or invalid");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	ret =3D of_property_read_u32(phandle, "reg", &thermistor->r_sense_chan);
> +	if (ret) {
> +		dev_err(dev, "rsense channel must be configured...\n");
> +		goto fail;
> +	}
> +
> +	if (of_property_read_bool(child, "adi,single-ended")) {
> +		thermistor->sensor_config =3D LTC2983_THERMISTOR_SGL(1);
> +	} else if (of_property_read_bool(child, "adi,rsense-share")) {
> +		/* rotation is only possible if sharing rsense */
> +		if (of_property_read_bool(child, "adi,current-rotate"))
> +			thermistor->sensor_config =3D
> +						LTC2983_THERMISTOR_C_ROTATE(1);
> +		else
> +			thermistor->sensor_config =3D
> +						LTC2983_THERMISTOR_R_SHARE(1);
> +	}
> +	/* validate channel index */
> +	if (!(thermistor->sensor_config & LTC2983_THERMISTOR_DIFF_MASK) &&
> +	    sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN) {
> +		dev_err(&st->spi->dev,
> +			"Invalid chann:%d for differential thermistor",
> +								sensor->chan);
> +		ret =3D -EINVAL;
> +		goto fail;
> +	}
> +
> +	/* check custom sensor */
> +	if (sensor->type >=3D LTC2983_SENSOR_THERMISTOR_STEINHART) {
> +		bool steinhart =3D false;
> +		const char *propname;
> +
> +		if (sensor->type =3D=3D LTC2983_SENSOR_THERMISTOR_STEINHART) {
> +			steinhart =3D true;
> +			propname =3D "adi,custom-steinhart";
> +		} else {
> +			propname =3D "adi,custom-thermistor";
> +		}
> +
> +		thermistor->custom =3D __ltc2983_custom_sensor_new(st, child,
> +								 propname,
> +								 steinhart,
> +								 64, false);
> +		if (IS_ERR(thermistor->custom)) {
> +			of_node_put(phandle);
> +			return ERR_CAST(thermistor->custom);
> +		}
> +	}
> +	/* set common parameters */
> +	thermistor->sensor.fault_handler =3D ltc2983_common_fault_handler;
> +	thermistor->sensor.assign_chan =3D ltc2983_thermistor_assign_chan;
> +
> +	ret =3D of_property_read_u32(child, "adi,excitation-current-nanoamp",
> +				   &excitation_current);
> +	if (ret) {
> +		/* Auto range is not allowed for custom sensors */
> +		if (sensor->type >=3D LTC2983_SENSOR_THERMISTOR_STEINHART)
> +			/* default to 1uA */
> +			thermistor->excitation_current =3D 0x03;
> +		else
> +			/* default to auto-range */
> +			thermistor->excitation_current =3D 0x0c;
> +	} else {
> +		switch (excitation_current) {
> +		case 0:
> +			/* auto range */
> +			if (sensor->type >=3D
> +			    LTC2983_SENSOR_THERMISTOR_STEINHART) {
> +				dev_err(&st->spi->dev,
> +					"Auto Range not allowed for custom sensors\n");
> +				ret =3D -EINVAL;
> +				goto fail;
> +			}
> +			thermistor->excitation_current =3D 0x0c;
> +			break;
> +		case 250:
> +			thermistor->excitation_current =3D 0x01;
> +			break;
> +		case 500:
> +			thermistor->excitation_current =3D 0x02;
> +			break;
> +		case 1000:
> +			thermistor->excitation_current =3D 0x03;
> +			break;
> +		case 5000:
> +			thermistor->excitation_current =3D 0x04;
> +			break;
> +		case 10000:
> +			thermistor->excitation_current =3D 0x05;
> +			break;
> +		case 25000:
> +			thermistor->excitation_current =3D 0x06;
> +			break;
> +		case 50000:
> +			thermistor->excitation_current =3D 0x07;
> +			break;
> +		case 100000:
> +			thermistor->excitation_current =3D 0x08;
> +			break;
> +		case 250000:
> +			thermistor->excitation_current =3D 0x09;
> +			break;
> +		case 500000:
> +			thermistor->excitation_current =3D 0x0a;
> +			break;
> +		case 1000000:
> +			thermistor->excitation_current =3D 0x0b;
> +			break;
> +		default:
> +			dev_err(&st->spi->dev,
> +				"Invalid value for excitation current(%u)",
> +							excitation_current);
> +			ret =3D -EINVAL;
> +			goto fail;
> +		}
> +	}
> +
> +	of_node_put(phandle);
> +	return &thermistor->sensor;
> +fail:
> +	of_node_put(phandle);
> +	return ERR_PTR(ret);
> +}
> +
> +static struct ltc2983_sensor *ltc2983_diode_new(
> +					const struct device_node *child,
> +					const struct ltc2983_data *st,
> +					const struct ltc2983_sensor *sensor)
> +{
> +	struct ltc2983_diode *diode;
> +	u32 temp =3D 0, excitation_current =3D 0;
> +	int ret;
> +
> +	diode =3D devm_kzalloc(&st->spi->dev, sizeof(*diode), GFP_KERNEL);
> +	if (!diode)
> +		return ERR_PTR(-ENOMEM);
> +
> +	if (of_property_read_bool(child, "adi,single-ended"))
> +		diode->sensor_config =3D LTC2983_DIODE_SGL(1);
> +
> +	if (of_property_read_bool(child, "adi,three-conversion-cycles"))
> +		diode->sensor_config |=3D LTC2983_DIODE_3_CONV_CYCLE(1);
> +
> +	if (of_property_read_bool(child, "adi,average-on"))
> +		diode->sensor_config |=3D LTC2983_DIODE_AVERAGE_ON(1);
> +
> +	/* validate channel index */
> +	if (!(diode->sensor_config & LTC2983_DIODE_DIFF_MASK) &&
> +	    sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN) {
> +		dev_err(&st->spi->dev,
> +			"Invalid chann:%d for differential thermistor",
> +								sensor->chan);
> +		return ERR_PTR(-EINVAL);
> +	}
> +	/* set common parameters */
> +	diode->sensor.fault_handler =3D ltc2983_common_fault_handler;
> +	diode->sensor.assign_chan =3D ltc2983_diode_assign_chan;
> +
> +	ret =3D of_property_read_u32(child, "adi,excitation-current-microamp",
> +				   &excitation_current);
> +	if (!ret) {
> +		switch (excitation_current) {
> +		case 10:
> +			diode->excitation_current =3D 0x00;
> +			break;
> +		case 20:
> +			diode->excitation_current =3D 0x01;
> +			break;
> +		case 40:
> +			diode->excitation_current =3D 0x02;
> +			break;
> +		case 80:
> +			diode->excitation_current =3D 0x03;
> +			break;
> +		default:
> +			dev_err(&st->spi->dev,
> +				"Invalid value for excitation current(%u)",
> +							excitation_current);
> +			return ERR_PTR(-EINVAL);
> +		}
> +	}
> +
> +	of_property_read_u32(child, "adi,ideal-factor-value", &temp);
> +
> +	/* 2^20 resolution */
> +	diode->ideal_factor_value =3D __convert_to_raw(temp, 1048576);
> +
> +	return &diode->sensor;
> +}
> +
> +static struct ltc2983_sensor *ltc2983_r_sense_new(struct device_node *ch=
ild,
> +					struct ltc2983_data *st,
> +					const struct ltc2983_sensor *sensor)
> +{
> +	struct ltc2983_rsense *rsense;
> +	int ret;
> +	u32 temp;
> +
> +	rsense =3D devm_kzalloc(&st->spi->dev, sizeof(*rsense), GFP_KERNEL);
> +	if (!rsense)
> +		return ERR_PTR(-ENOMEM);
> +
> +	/* validate channel index */
> +	if (sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN) {
> +		dev_err(&st->spi->dev, "Invalid chann:%d for r_sense",
> +							sensor->chan);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	ret =3D of_property_read_u32(child, "adi,rsense-val-milli-ohms", &temp);
> +	if (ret) {
> +		dev_err(&st->spi->dev, "Property adi,rsense-val-milli-ohms missing\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +	/*
> +	 * Times 1000 because we have milli-ohms and __convert_to_raw
> +	 * expects scales of 1000000 which are used for all other
> +	 * properties.
> +	 * 2^10 resolution
> +	 */
> +	rsense->r_sense_val =3D __convert_to_raw((u64)temp * 1000, 1024);
> +
> +	/* set common parameters */
> +	rsense->sensor.assign_chan =3D ltc2983_r_sense_assign_chan;
> +
> +	return &rsense->sensor;
> +}
> +
> +static struct ltc2983_sensor *ltc2983_adc_new(struct device_node *child,
> +					 struct ltc2983_data *st,
> +					 const struct ltc2983_sensor *sensor)
> +{
> +	struct ltc2983_adc *adc;
> +
> +	adc =3D devm_kzalloc(&st->spi->dev, sizeof(*adc), GFP_KERNEL);
> +	if (!adc)
> +		return ERR_PTR(-ENOMEM);
> +
> +	if (of_property_read_bool(child, "adi,single-ended"))
> +		adc->single_ended =3D true;
> +
> +	if (!adc->single_ended &&
> +	    sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN) {
> +		dev_err(&st->spi->dev, "Invalid chan:%d for differential adc\n",
> +								sensor->chan);

That parameter should be aligned with the open bracket.

> +		return ERR_PTR(-EINVAL);
> +	}
> +	/* set common parameters */
> +	adc->sensor.assign_chan =3D ltc2983_adc_assign_chan;
> +	adc->sensor.fault_handler =3D ltc2983_common_fault_handler;
> +
> +	return &adc->sensor;
> +}
> +
> +static int ltc2983_chan_read(struct ltc2983_data *st,
> +			const struct ltc2983_sensor *sensor, int *val)
> +{
> +	u32 start_conversion =3D 0;
> +	int ret;
> +	unsigned long time;
> +
> +	start_conversion =3D LTC2983_STATUS_START(true);
> +	start_conversion |=3D LTC2983_STATUS_CHAN_SEL(sensor->chan);
> +	dev_dbg(&st->spi->dev, "Start conversion on chan:%d, status:%02X\n",
> +		sensor->chan, start_conversion);
> +	/* start conversion */
> +	ret =3D regmap_write(st->regmap, LTC2983_STATUS_REG, start_conversion);
> +	if (ret)
> +		return ret;
> +
> +	reinit_completion(&st->completion);
> +	/*
> +	 * wait for conversion to complete.
> +	 * 300 ms should be more than enough to complete the conversion.
> +	 * Depending on the sensor configuration, there are 2/3 conversions
> +	 * cycles of 82ms.
> +	 */
> +	time =3D wait_for_completion_timeout(&st->completion,
> +					   msecs_to_jiffies(300));
> +	if (!time) {
> +		dev_warn(&st->spi->dev, "Conversion timed out\n");
> +		return -ETIMEDOUT;
> +	}
> +
> +	/* read the converted data */
> +	ret =3D regmap_bulk_read(st->regmap, LTC2983_CHAN_RES_ADDR(sensor->chan=
),
> +			       &st->temp, sizeof(st->temp));
> +	if (ret)
> +		return ret;
> +
> +	*val =3D __be32_to_cpu(st->temp);
> +
> +	if (!(LTC2983_RES_VALID_MASK & *val)) {
> +		dev_err(&st->spi->dev, "Invalid conversion detected\n");
> +		return -EIO;
> +	}
> +
> +	ret =3D sensor->fault_handler(st, *val);
> +	if (ret)
> +		return ret;
> +
> +	*val =3D sign_extend32((*val) & LTC2983_DATA_MASK, LTC2983_DATA_SIGN_BI=
T);
> +	return 0;
> +}
> +
> +static int ltc2983_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct ltc2983_data *st =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	/* sanity check */
> +	if (chan->address >=3D st->num_channels) {
> +		dev_err(&st->spi->dev, "Invalid chan address:%ld",
> +							chan->address);

Odd indent.

> +		return -EINVAL;
> +	}
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		mutex_lock(&st->lock);
> +		ret =3D ltc2983_chan_read(st, st->sensors[chan->address], val);
> +		mutex_unlock(&st->lock);
> +		return ret ?: IIO_VAL_INT;
Would have preferred separate error handling.
		if (ret)
			return ret;

		return IIO_VAL_INT;

> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_TEMP:
> +			/* value in milli degrees */
> +			*val =3D 1000;
> +			/* 2^10 */
> +			*val2 =3D 1024;
> +			return IIO_VAL_FRACTIONAL;
> +		case IIO_VOLTAGE:
> +			/* value in millivolt */
> +			*val =3D 1000;
> +			/* 2^21 */
> +			*val2 =3D 2097152;
> +			return IIO_VAL_FRACTIONAL;
> +		default:
> +			return -EINVAL;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int ltc2983_reg_access(struct iio_dev *indio_dev,
> +			      unsigned int reg,
> +			      unsigned int writeval,
> +			      unsigned int *readval)
> +{
> +	struct ltc2983_data *st =3D iio_priv(indio_dev);
> +
> +	if (readval)
> +		return regmap_read(st->regmap, reg, readval);
> +	else
> +		return regmap_write(st->regmap, reg, writeval);
> +}
> +
> +static irqreturn_t ltc2983_irq_handler(int irq, void *data)
> +{
> +	struct ltc2983_data *st =3D data;
> +
> +	complete(&st->completion);
> +	return IRQ_HANDLED;
> +}
> +
> +#define LTC2983_CHAN(__type, index, __address) ({ \
> +	struct iio_chan_spec __chan =3D { \
> +		.type =3D __type, \
> +		.indexed =3D 1, \
> +		.channel =3D index, \
> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW), \
> +		.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE), \
> +		.address =3D __address, \
> +	}; \
> +	__chan; \
> +})
> +
> +static int ltc2983_parse_dt(struct ltc2983_data *st)
> +{
> +	struct device_node *child;
> +	struct device *dev =3D &st->spi->dev;
> +	int ret =3D 0, chan =3D 0, channel_avail_mask =3D 0;
> +
> +	of_property_read_u32(dev->of_node, "adi,mux-delay-config-us",
> +			     &st->mux_delay_config);
> +
> +	of_property_read_u32(dev->of_node, "adi,filter-notch-freq",
> +			     &st->filter_notch_freq);
> +
> +	st->num_channels =3D of_get_available_child_count(dev->of_node);
> +	st->sensors =3D devm_kcalloc(dev, st->num_channels, sizeof(*st->sensors=
),
> +				   GFP_KERNEL);
> +	if (!st->sensors)
> +		return -ENOMEM;
> +
> +	st->iio_channels =3D st->num_channels;
> +	for_each_available_child_of_node(dev->of_node, child) {
> +		struct ltc2983_sensor sensor;
> +
> +		ret =3D of_property_read_u32(child, "reg", &sensor.chan);
> +		if (ret) {
> +			dev_err(dev, "reg property must given for child nodes\n");
> +			return ret;
> +		}
> +
> +		/* check if we have a valid channel */
> +		if (sensor.chan < LTC2983_MIN_CHANNELS_NR ||
> +		    sensor.chan > LTC2983_MAX_CHANNELS_NR) {
> +			dev_err(dev,
> +				"chan:%d must be from 1 to 20\n", sensor.chan);
> +			return -EINVAL;
> +		} else if (channel_avail_mask & BIT(sensor.chan)) {
> +			dev_err(dev, "chan:%d already in use\n", sensor.chan);
> +			return -EINVAL;
> +		}
> +
> +		ret =3D of_property_read_u32(child, "adi,sensor-type",
> +					       &sensor.type);
> +		if (ret) {
> +			dev_err(dev,
> +				"adi,sensor-type property must given for child nodes\n");
> +			return ret;
> +		}
> +
> +		dev_dbg(dev, "Create new sensor, type %u, chann %u",
> +								sensor.type,
> +								sensor.chan);
> +
> +		if (sensor.type >=3D LTC2983_SENSOR_THERMOCOUPLE &&
> +		    sensor.type <=3D LTC2983_SENSOR_THERMOCOUPLE_CUSTOM) {
> +			st->sensors[chan] =3D ltc2983_thermocouple_new(child, st,
> +								     &sensor);
> +		} else if (sensor.type >=3D LTC2983_SENSOR_RTD &&
> +			   sensor.type <=3D LTC2983_SENSOR_RTD_CUSTOM) {
> +			st->sensors[chan] =3D ltc2983_rtd_new(child, st, &sensor);
> +		} else if (sensor.type >=3D LTC2983_SENSOR_THERMISTOR &&
> +			   sensor.type <=3D LTC2983_SENSOR_THERMISTOR_CUSTOM) {
> +			st->sensors[chan] =3D ltc2983_thermistor_new(child, st,
> +								   &sensor);
> +		} else if (sensor.type =3D=3D LTC2983_SENSOR_DIODE) {
> +			st->sensors[chan] =3D ltc2983_diode_new(child, st,
> +							      &sensor);
> +		} else if (sensor.type =3D=3D LTC2983_SENSOR_SENSE_RESISTOR) {
> +			st->sensors[chan] =3D ltc2983_r_sense_new(child, st,
> +								&sensor);
> +			/* don't add rsense to iio */
> +			st->iio_channels--;
> +		} else if (sensor.type =3D=3D LTC2983_SENSOR_DIRECT_ADC) {
> +			st->sensors[chan] =3D ltc2983_adc_new(child, st, &sensor);
> +		} else {
> +			dev_err(dev, "Unknown sensor type %d\n", sensor.type);
> +			return -EINVAL;
> +		}
> +
> +		if (IS_ERR(st->sensors[chan])) {
> +			dev_err(dev, "Failed to create sensor %ld",
> +						PTR_ERR(st->sensors[chan]));
> +			return PTR_ERR(st->sensors[chan]);
> +		}
> +		/* set generic sensor parameters */
> +		st->sensors[chan]->chan =3D sensor.chan;
> +		st->sensors[chan]->type =3D sensor.type;
> +
> +		channel_avail_mask |=3D BIT(sensor.chan);
> +		chan++;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ltc2983_setup(struct ltc2983_data *st, bool assign_iio)
> +{
> +	u32 iio_chan_t =3D 0, iio_chan_v =3D 0, chan, iio_idx =3D 0;
> +	int ret;
> +	unsigned long time;
> +
> +	/* make sure the device is up */
> +	time =3D wait_for_completion_timeout(&st->completion,
> +					    msecs_to_jiffies(250));
> +
> +	if (!time) {
> +		dev_err(&st->spi->dev, "Device startup timed out\n");
> +		return -ETIMEDOUT;
> +	}
> +
> +	st->iio_chan =3D devm_kzalloc(&st->spi->dev,
> +				    st->iio_channels * sizeof(*st->iio_chan),
> +				    GFP_KERNEL);
> +

Bit a stylistic inconsistency here on whether you have a blank line
before error checks or not.  I might tweak that when applying depending
on how fussy I feel.

> +	if (!st->iio_chan)
> +		return -ENOMEM;
> +
> +	ret =3D regmap_update_bits(st->regmap, LTC2983_GLOBAL_CONFIG_REG,
> +				 LTC2983_NOTCH_FREQ_MASK,
> +				 LTC2983_NOTCH_FREQ(st->filter_notch_freq));
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_write(st->regmap, LTC2983_MUX_CONFIG_REG,
> +			   st->mux_delay_config);
> +	if (ret)
> +		return ret;
> +
> +	for (chan =3D 0; chan < st->num_channels; chan++) {
> +		u32 chan_type =3D 0, *iio_chan;
> +
> +		ret =3D st->sensors[chan]->assign_chan(st, st->sensors[chan]);
> +		if (ret)
> +			return ret;
> +		/*
> +		 * The assign_iio flag is necessary for when the device is
> +		 * coming out of sleep. In that case, we just need to
> +		 * re-configure the device channels.
> +		 * We also don't assign iio channels for rsense.
> +		 */
> +		if (st->sensors[chan]->type =3D=3D LTC2983_SENSOR_SENSE_RESISTOR ||
> +		    !assign_iio)
> +			continue;
> +
> +		/* assign iio channel */
> +		if (st->sensors[chan]->type !=3D LTC2983_SENSOR_DIRECT_ADC) {
> +			chan_type =3D IIO_TEMP;
> +			iio_chan =3D &iio_chan_t;
> +		} else {
> +			chan_type =3D IIO_VOLTAGE;
> +			iio_chan =3D &iio_chan_v;
> +		}
> +
> +		/*
> +		 * add chan as the iio .address so that, we can directly
> +		 * reference the sensor given the iio_chan_spec
> +		 */
> +		st->iio_chan[iio_idx++] =3D LTC2983_CHAN(chan_type, (*iio_chan)++,
> +						       chan);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct regmap_range ltc2983_reg_ranges[] =3D {
> +	regmap_reg_range(LTC2983_STATUS_REG, LTC2983_STATUS_REG),
> +	regmap_reg_range(LTC2983_TEMP_RES_START_REG, LTC2983_TEMP_RES_END_REG),
> +	regmap_reg_range(LTC2983_GLOBAL_CONFIG_REG, LTC2983_GLOBAL_CONFIG_REG),
> +	regmap_reg_range(LTC2983_MULT_CHANNEL_START_REG,
> +			 LTC2983_MULT_CHANNEL_END_REG),
> +	regmap_reg_range(LTC2983_MUX_CONFIG_REG, LTC2983_MUX_CONFIG_REG),
> +	regmap_reg_range(LTC2983_CHAN_ASSIGN_START_REG,
> +			 LTC2983_CHAN_ASSIGN_END_REG),
> +	regmap_reg_range(LTC2983_CUST_SENS_TBL_START_REG,
> +			 LTC2983_CUST_SENS_TBL_END_REG),
> +};
> +
> +static const struct regmap_access_table ltc2983_reg_table =3D {
> +	.yes_ranges =3D ltc2983_reg_ranges,
> +	.n_yes_ranges =3D ARRAY_SIZE(ltc2983_reg_ranges),
> +};
> +
> +/*
> + *  The reg_bits are actually 12 but the device needs the first *complet=
e*
> + *  byte for the command (R/W).
> + */
> +static const struct regmap_config ltc2983_regmap_config =3D {
> +	.reg_bits =3D 24,
> +	.val_bits =3D 8,
> +	.wr_table =3D &ltc2983_reg_table,
> +	.rd_table =3D &ltc2983_reg_table,
> +	.read_flag_mask =3D GENMASK(1, 0),
> +	.write_flag_mask =3D BIT(1),
> +};
> +
> +static const struct  iio_info ltc2983_iio_info =3D {
> +	.read_raw =3D ltc2983_read_raw,
> +	.debugfs_reg_access =3D ltc2983_reg_access,
> +};
> +
> +static int ltc2983_probe(struct spi_device *spi)
> +{
> +	struct ltc2983_data *st;
> +	struct iio_dev *indio_dev;
> +	const char *name =3D spi_get_device_id(spi)->name;
> +	int ret;
> +
> +	indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st =3D iio_priv(indio_dev);
> +
> +	st->regmap =3D devm_regmap_init_spi(spi, &ltc2983_regmap_config);
> +	if (IS_ERR(st->regmap)) {
> +		dev_err(&spi->dev, "Failed to initialize regmap\n");
> +		return PTR_ERR(st->regmap);
> +	}
> +
> +	mutex_init(&st->lock);
> +	init_completion(&st->completion);
> +	st->spi =3D spi;
> +	spi_set_drvdata(spi, st);
> +
> +	ret =3D ltc2983_parse_dt(st);
> +	if (ret)
> +		return ret;
> +	/*
> +	 * let's request the irq now so it is used to sync the device
> +	 * startup in ltc2983_setup()
> +	 */
> +	ret =3D devm_request_irq(&spi->dev, spi->irq, ltc2983_irq_handler,
> +			       IRQF_TRIGGER_RISING, name, st);
> +	if (ret) {
> +		dev_err(&spi->dev, "failed to request an irq, %d", ret);
> +		return ret;
> +	}
> +
> +	ret =3D ltc2983_setup(st, true);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->dev.parent =3D &spi->dev;
> +	indio_dev->name =3D name;
> +	indio_dev->num_channels =3D st->iio_channels;
> +	indio_dev->channels =3D st->iio_chan;
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +	indio_dev->info =3D &ltc2983_iio_info;
> +
> +	return devm_iio_device_register(&spi->dev, indio_dev);
> +}
> +
> +static int __maybe_unused ltc2983_resume(struct device *dev)
> +{
> +	struct ltc2983_data *st =3D spi_get_drvdata(to_spi_device(dev));
> +	int dummy;
> +
> +	/* dummy read to bring the device out of sleep */
> +	regmap_read(st->regmap, LTC2983_STATUS_REG, &dummy);
> +	/* we need to re-assign the channels */
> +	return ltc2983_setup(st, false);
> +}
> +
> +static int __maybe_unused ltc2983_suspend(struct device *dev)
> +{
> +	struct ltc2983_data *st =3D spi_get_drvdata(to_spi_device(dev));
> +
> +	return regmap_write(st->regmap, LTC2983_STATUS_REG, LTC2983_SLEEP);
> +}
> +
> +static SIMPLE_DEV_PM_OPS(ltc2983_pm_ops, ltc2983_suspend, ltc2983_resume=
);
> +
> +static const struct spi_device_id ltc2983_id_table[] =3D {
> +	{ "ltc2983" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(spi, ltc2983_id_table);
> +
> +static const struct of_device_id ltc2983_of_match[] =3D {
> +	{ .compatible =3D "adi,ltc2983" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, ltc2983_id_table);
> +
> +static struct spi_driver ltc2983_driver =3D {
> +	.driver =3D {
> +		.name =3D "ltc2983",
> +		.of_match_table =3D ltc2983_of_match,
> +		.pm =3D &ltc2983_pm_ops,
> +	},
> +	.probe =3D ltc2983_probe,
> +	.id_table =3D ltc2983_id_table,
> +};
> +
> +module_spi_driver(ltc2983_driver);
> +
> +MODULE_AUTHOR("Nuno Sa <nuno.sa@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices LTC2983 SPI Temperature sensors");
> +MODULE_LICENSE("GPL");

