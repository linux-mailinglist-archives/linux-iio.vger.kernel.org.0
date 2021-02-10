Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58C7431696C
	for <lists+linux-iio@lfdr.de>; Wed, 10 Feb 2021 15:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbhBJOvd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 10 Feb 2021 09:51:33 -0500
Received: from ns.pmeerw.net ([84.19.176.117]:53024 "EHLO ns.pmeerw.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229934AbhBJOvc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 10 Feb 2021 09:51:32 -0500
Received: by ns.pmeerw.net (Postfix, from userid 1000)
        id 86F41E0400; Wed, 10 Feb 2021 15:50:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pmeerw.net; s=mail;
        t=1612968645; bh=soRSyaS57ePxCaBsk6NgyjZGBdrIdJYc59V3j3RUnpA=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=Fxq7LJe2X96mWbElkA8/YdNr4flbDoZchbCJTQDiIbQNgYv9VIHVc2SVBHpTKfsS3
         Mu6MXp8yV1GxcBSryDao456OSm/HSsNsN4dVqXevVhdxoYVymZrumr5A+ue48hMmCD
         zI0pUe91V+pgXt3UH2VV9ffazTHbKUDkNY1fY7s4=
Received: from localhost (localhost [127.0.0.1])
        by ns.pmeerw.net (Postfix) with ESMTP id 7AFDDE0049;
        Wed, 10 Feb 2021 15:50:45 +0100 (CET)
Date:   Wed, 10 Feb 2021 15:50:45 +0100 (CET)
From:   Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To:     Joe Sandom <joe.sandom@outlook.com>
cc:     jic23@kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Added AMS tsl2591 driver implementation
In-Reply-To: <DB8P195MB0728103C5874083BD441AA0D888D9@DB8P195MB0728.EURP195.PROD.OUTLOOK.COM>
Message-ID: <74dbf436-eb99-ea76-af48-72e484bc7ea@pmeerw.net>
References: <DB8P195MB0728103C5874083BD441AA0D888D9@DB8P195MB0728.EURP195.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


> Driver implementation for AMS/TAOS tsl2591 ambient light sensor.

please see comments below
> 
> This driver supports configuration via device tree and sysfs.
> Supported channels for raw infrared light, raw visible light,
> raw combined light and combined lux value.
> The driver additionally supports iio events on lower and
> upper thresholds.
> 
> This is a very-high sensitivity light-to-digital converter that
> transforms light intensity into a digital signal.
> 
> Datasheet Available at: https://ams.com/tsl25911
> 
> Signed-off-by: Joe Sandom <joe.sandom@outlook.com>
> ---
> Changes in v2:
> - Significant modifications to ensure compatibility with standard userspace ABI
> - Removed unneccesary device tree properties where configuration can be
>   handled either through sysfs or event properties
> - Improved readability of code by inlining where appropriate and
>   modified naming in areas for clarity
> - Cleaned up Makefile and Kconfig to follow correct ordering
> - Removed noisy print outs and unnecessary use of __func__
> - All chip configuration done in probe before exposing interfaces to
>   userspace to avoid race conditions
> - Removed having events directly from probe, now follows appropriate
>   event enable path
> - Removed channel showing visible light only as no real use case for it.
>   Channels are now IR (raw), Visible + IR (raw) and Lux.
> - Cleaned up binding file to reflect removal of device tree properties
> 
> NOTE:
> Apologies that v2 took a while to get submitted, making the changes to
> ensure compatibility with the standard userspace ABI took a lot longer
> than anticipated! mostly with the conversion of persist cycles to time
> in seconds with respect to ADC integration time amongst other things. 
> 
>  .../bindings/iio/light/amstaos,tsl2591.yaml   |   50 +
>  drivers/iio/light/Kconfig                     |   11 +
>  drivers/iio/light/Makefile                    |    1 +
>  drivers/iio/light/tsl2591.c                   | 1247 +++++++++++++++++
>  4 files changed, 1309 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/amstaos,tsl2591.yaml
>  create mode 100644 drivers/iio/light/tsl2591.c
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/amstaos,tsl2591.yaml b/Documentation/devicetree/bindings/iio/light/amstaos,tsl2591.yaml
> new file mode 100644
> index 000000000000..030d0bbfdc7b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/amstaos,tsl2591.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/light/tsl2591.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AMS/TAOS TSL2591 Ambient Light Sensor (ALS)
> +
> +maintainers:
> +  - Joe Sandom <joe.sandom@outlook.com>
> +
> +description: |
> +  AMS/TAOS TSL2591 is a very-high sensitivity
> +  light-to-digital converter that transforms light intensity into a digital
> +  signal.
> +
> +properties:
> +  compatible:
> +    const: amstaos,tsl2591
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +    description:
> +      Interrupt (INT:Pin 2) Active low. Should be set to IRQ_TYPE_EDGE_FALLING.
> +      interrupt is used to detect if lux value has reached below or above defined

Interrupt
is it lux always? or just intensity in some cases

> +      threshold values.
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        tsl2591@29 {
> +            compatible = "amstaos,tsl2591";
> +            reg = <0x29>;
> +            interrupts = <20 IRQ_TYPE_EDGE_FALLING>;
> +       };
> +    };
> +...
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index 33ad4dd0b5c7..0b0950a94925 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -501,6 +501,17 @@ config TSL2583
>  	  Provides support for the TAOS tsl2580, tsl2581 and tsl2583 devices.
>  	  Access ALS data via iio, sysfs.
>  
> +config TSL2591
> +        tristate "TAOS TSL2591 ambient light sensor"
> +        depends on I2C
> +        help
> +          Select Y here for support of the AMS/TAOS TSL2591 ambient light sensor,
> +          featuring visible and infrared lux output. Access als data via

I think lux is defined for visible light only?
als -> ALS

> +          iio and sysfs. Supports iio_events.
> +
> +          To compile this driver as a module, select M: the
> +          module will be called tsl2591.
> +
>  config TSL2772
>  	tristate "TAOS TSL/TMD2x71 and TSL/TMD2x72 Family of light and proximity sensors"
>  	depends on I2C
> diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> index ea376deaca54..d10912faf964 100644
> --- a/drivers/iio/light/Makefile
> +++ b/drivers/iio/light/Makefile
> @@ -48,6 +48,7 @@ obj-$(CONFIG_ST_UVIS25_SPI)	+= st_uvis25_spi.o
>  obj-$(CONFIG_TCS3414)		+= tcs3414.o
>  obj-$(CONFIG_TCS3472)		+= tcs3472.o
>  obj-$(CONFIG_TSL2583)		+= tsl2583.o
> +obj-$(CONFIG_TSL2591)		+= tsl2591.o
>  obj-$(CONFIG_TSL2772)		+= tsl2772.o
>  obj-$(CONFIG_TSL4531)		+= tsl4531.o
>  obj-$(CONFIG_US5182D)		+= us5182d.o
> diff --git a/drivers/iio/light/tsl2591.c b/drivers/iio/light/tsl2591.c
> new file mode 100644
> index 000000000000..fb402ddabeaf
> --- /dev/null
> +++ b/drivers/iio/light/tsl2591.c
> @@ -0,0 +1,1247 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2020 Joe Sandom <joe.sandom@outlook.com>
> + *
> + * Datasheet Available at: https://ams.com/tsl25911

available

> + *
> + * Device driver for the TAOS TSL2591. This is a very-high sensitivity
> + * light-to-digital converter that transforms light intensity into a digital
> + * signal.
> + */
> +
> +#include <linux/debugfs.h>
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/pm_runtime.h>
> +
> +#include <linux/iio/events.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +
> +#define als_time_secs_to_ms(x) (((x) + 1) * 100)
> +#define als_time_ms_to_secs(x) (((x) / 100) - 1)

maybe UPPERCASE macros?

> +
> +/* TSL2591 Register Set */
> +#define TSL2591_ENABLE      0x00
> +#define TSL2591_CONTROL     0x01
> +#define TSL2591_AILTL       0x04
> +#define TSL2591_AILTH       0x05
> +#define TSL2591_AIHTL       0x06
> +#define TSL2591_AIHTH       0x07
> +#define TSL2591_NP_AILTL    0x08
> +#define TSL2591_NP_AILTH    0x09
> +#define TSL2591_NP_AIHTL    0x0A
> +#define TSL2591_NP_AIHTH    0x0B
> +#define TSL2591_PERSIST     0x0C
> +#define TSL2591_PACKAGE_ID  0x11
> +#define TSL2591_DEVICE_ID   0x12
> +#define TSL2591_STATUS      0x13
> +#define TSL2591_C0_DATAL    0x14
> +#define TSL2591_C0_DATAH    0x15
> +#define TSL2591_C1_DATAL    0x16
> +#define TSL2591_C1_DATAH    0x17
> +
> +/* TSL2591 Command Register Masks */

doesn't look like masks, more like values :)

> +#define TSL2591_CMD_NOP             0xA0
> +#define TSL2591_CMD_SF_INTSET       0xE4
> +#define TSL2591_CMD_SF_CALS_I       0xE5
> +#define TSL2591_CMD_SF_CALS_NPI     0xE7
> +#define TSL2591_CMD_SF_CNP_ALSI     0xEA
> +
> +/* TSL2591 Enable Register Masks */
> +#define TSL2591_PWR_ON              0x01

could use BIT()

> +#define TSL2591_PWR_OFF             0x00
> +#define TSL2591_ENABLE_ALS          0x02
> +#define TSL2591_ENABLE_ALS_INT      0x10
> +#define TSL2591_ENABLE_SLEEP_INT    0x40
> +#define TSL2591_ENABLE_NP_INT       0x80
> +
> +/* TSL2591 Control Register Masks */
> +#define TSL2591_CTRL_ALS_INTEGRATION_100MS  0x00
> +#define TSL2591_CTRL_ALS_INTEGRATION_200MS  0x01
> +#define TSL2591_CTRL_ALS_INTEGRATION_300MS  0x02
> +#define TSL2591_CTRL_ALS_INTEGRATION_400MS  0x03
> +#define TSL2591_CTRL_ALS_INTEGRATION_500MS  0x04
> +#define TSL2591_CTRL_ALS_INTEGRATION_600MS  0x05
> +#define TSL2591_CTRL_ALS_LOW_GAIN           0x00
> +#define TSL2591_CTRL_ALS_MED_GAIN           0x10
> +#define TSL2591_CTRL_ALS_HIGH_GAIN          0x20
> +#define TSL2591_CTRL_ALS_MAX_GAIN           0x30
> +#define TSL2591_CTRL_SYS_RESET              0x80
> +
> +/* TSL2591 Persist Register Masks */

not very mask-y

> +#define TSL2591_PRST_ALS_INT_CYCLE_0        0x00
> +#define TSL2591_PRST_ALS_INT_CYCLE_ANY      0x01
> +#define TSL2591_PRST_ALS_INT_CYCLE_2        0x02
> +#define TSL2591_PRST_ALS_INT_CYCLE_3        0x03
> +#define TSL2591_PRST_ALS_INT_CYCLE_5        0x04
> +#define TSL2591_PRST_ALS_INT_CYCLE_10       0x05
> +#define TSL2591_PRST_ALS_INT_CYCLE_15       0x06
> +#define TSL2591_PRST_ALS_INT_CYCLE_20       0x07
> +#define TSL2591_PRST_ALS_INT_CYCLE_25       0x08
> +#define TSL2591_PRST_ALS_INT_CYCLE_30       0x09
> +#define TSL2591_PRST_ALS_INT_CYCLE_35       0x0A
> +#define TSL2591_PRST_ALS_INT_CYCLE_40       0x0B
> +#define TSL2591_PRST_ALS_INT_CYCLE_45       0x0C
> +#define TSL2591_PRST_ALS_INT_CYCLE_50       0x0D
> +#define TSL2591_PRST_ALS_INT_CYCLE_55       0x0E
> +#define TSL2591_PRST_ALS_INT_CYCLE_60       0x0F
> +#define TSL2591_PRST_ALS_INT_CYCLE_MAX      TSL2591_PRST_ALS_INT_CYCLE_60
> +
> +/* TSL2591 Persist Interrupt Cycle Literals */
> +#define TSL2591_PRST_ALS_INT_CYCLE_1_LIT      1
> +#define TSL2591_PRST_ALS_INT_CYCLE_2_LIT      2
> +#define TSL2591_PRST_ALS_INT_CYCLE_3_LIT      3
> +#define TSL2591_PRST_ALS_INT_CYCLE_5_LIT      5
> +#define TSL2591_PRST_ALS_INT_CYCLE_10_LIT     10
> +#define TSL2591_PRST_ALS_INT_CYCLE_15_LIT     15
> +#define TSL2591_PRST_ALS_INT_CYCLE_20_LIT     20
> +#define TSL2591_PRST_ALS_INT_CYCLE_25_LIT     25
> +#define TSL2591_PRST_ALS_INT_CYCLE_30_LIT     30
> +#define TSL2591_PRST_ALS_INT_CYCLE_35_LIT     35
> +#define TSL2591_PRST_ALS_INT_CYCLE_40_LIT     40
> +#define TSL2591_PRST_ALS_INT_CYCLE_45_LIT     45
> +#define TSL2591_PRST_ALS_INT_CYCLE_50_LIT     50
> +#define TSL2591_PRST_ALS_INT_CYCLE_55_LIT     55
> +#define TSL2591_PRST_ALS_INT_CYCLE_60_LIT     60
> +
> +/* TSL2591 PID Register Mask */
> +#define TSL2591_PACKAGE_ID_MASK 0x30
> +
> +/* TSL2591 ID Register Mask */
> +#define TSL2591_DEVICE_ID_MASK  0xFF
> +
> +/* TSL2591 Status Register Masks */
> +#define TSL2591_STS_ALS_VALID   0x01
> +#define TSL2591_STS_ALS_INT     0x10
> +#define TSL2591_STS_NPERS_INT   0x20
> +#define TSL2591_STS_VAL_HIGH    0x01
> +
> +/* TSL2591 Constant Values */
> +#define TSL2591_PACKAGE_ID_VAL  0x00
> +#define TSL2591_DEVICE_ID_VAL   0x50
> +
> +/* Power off suspend delay time MS */
> +#define TSL2591_POWER_OFF_DELAY_MS	2000
> +
> +/* TSL2591 Default Values */

there are not just default values

> +#define TSL2591_DEFAULT_ALS_INT_TIME          TSL2591_CTRL_ALS_INTEGRATION_300MS
> +#define TSL2591_MAX_ALS_INT_TIME_MS           600
> +#define TSL2591_DEFAULT_ALS_GAIN              TSL2591_CTRL_ALS_MED_GAIN
> +#define TSL2591_NUM_DATA_CHANNELS             4
> +#define TSL2591_DEFAULT_ALS_PERSIST           TSL2591_PRST_ALS_INT_CYCLE_ANY
> +#define TSL2591_DEFAULT_ALS_LOWER_THRESHOLD   100
> +#define TSL2591_DEFAULT_ALS_UPPER_THRESHOLD   1500
> +
> +#define TSL2591_ALS_MAX_VALUE	       65535
> +#define TSL2591_ALS_STS_VALID_COUNT    10
> +
> +/* LUX Calculations */
> +/* AGAIN values from Adafruits TSL2591 Arduino library */
> +/* https://github.com/adafruit/Adafruit_TSL2591_Library */
> +#define TSL2591_CTRL_ALS_LOW_GAIN_MULTIPLIER   1
> +#define TSL2591_CTRL_ALS_MED_GAIN_MULTIPLIER   25
> +#define TSL2591_CTRL_ALS_HIGH_GAIN_MULTIPLIER  428
> +#define TSL2591_CTRL_ALS_MAX_GAIN_MULTIPLIER   9876
> +#define TSL2591_LUX_COEFFICIENT      408
> +
> +static const u8 tsl2591_data_channels[] = {
> +	TSL2591_C0_DATAL,
> +	TSL2591_C0_DATAH,
> +	TSL2591_C1_DATAL,
> +	TSL2591_C1_DATAH,
> +};
> +
> +struct tsl2591_als_readings {
> +	u16 als_ch0;
> +	u16 als_ch1;
> +	u16 als_lux_int;
> +	u16 als_lux_decimal;
> +};
> +
> +struct tsl2591_settings {

_als_settings for consistency?
everything seems to relate to ALS anyway

> +	u8 als_int_time;
> +	u8 als_gain;
> +	u8 als_persist;
> +	u16 als_lower_threshold;
> +	u16 als_upper_threshold;
> +};
> +
> +struct tsl2591_chip {
> +	/* Ambient light sensor mutex */

who would have guessed :) maybe drop comment

> +	struct mutex als_mutex;
> +	struct i2c_client *client;
> +	struct tsl2591_settings als_settings;
> +	struct tsl2591_als_readings als_readings;
> +
> +	bool events_enabled;
> +};
> +
> +/* Period table is als persist cycle x integration time setting */

ALS
multi-line comment?

> +/* Integration times: 100ms, 200ms, 300ms, 400ms, 500ms, 600ms */
> +/* ALS cycles: 1, 2, 3, 5, 10, 20, 25, 30, 35, 40, 45, 50, 55, 60 */
> +static const char * const tsl2591_als_period_list[] = {
> +	"0.1 0.2 0.3 0.5 1.0 2.0 2.5 3.0 3.5 4.0 4.5 5.0 5.5 6.0 ",

remove space at the end?

> +	"0.2 0.4 0.6 1.0 2.0 4.0 5.0 6.0 7.0 8.0 9.0 10.0 11.0 12.0",
> +	"0.3 0.6 0.9 1.5 3.0 6.0 7.5 9.0 10.5 12.0 13.5 15.0 16.5 18.0",
> +	"0.4 0.8 1.2 2.0 4.0 8.0 10.0 12.0 14.0 16.0 18.0 20.0 22.0 24.0 ",

remove space at the end?

> +	"0.5 1.0 1.5 2.5 5.0 10.0 12.5 15.0 17.5 20.0 22.5 25.0 27.5 30.0",
> +	"0.6 1.2 1.8 3.0 6.0 12.0 15.0 18.0 21.0 24.0 27.0 30.0 33.0 36.0",
> +};
> +
> +static int tsl2591_gain_to_multiplier(const u8 als_gain)

const necessary? just a bit unusual...

> +{
> +	switch (als_gain) {
> +	case TSL2591_CTRL_ALS_LOW_GAIN:
> +		return TSL2591_CTRL_ALS_LOW_GAIN_MULTIPLIER;
> +	case TSL2591_CTRL_ALS_MED_GAIN:
> +		return TSL2591_CTRL_ALS_MED_GAIN_MULTIPLIER;
> +	case TSL2591_CTRL_ALS_HIGH_GAIN:
> +		return TSL2591_CTRL_ALS_HIGH_GAIN_MULTIPLIER;
> +	case TSL2591_CTRL_ALS_MAX_GAIN:
> +		return TSL2591_CTRL_ALS_MAX_GAIN_MULTIPLIER;
> +	default:
> +		break;

maybe have the return -EINVAL right here and save some lines?
(here and elsewhere)

> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static u8 tsl2591_multiplier_to_gain(const u32 multiplier)
> +{
> +	switch (multiplier) {
> +	case TSL2591_CTRL_ALS_LOW_GAIN_MULTIPLIER:
> +		return TSL2591_CTRL_ALS_LOW_GAIN;
> +	case TSL2591_CTRL_ALS_MED_GAIN_MULTIPLIER:
> +		return TSL2591_CTRL_ALS_MED_GAIN;
> +	case TSL2591_CTRL_ALS_HIGH_GAIN_MULTIPLIER:
> +		return TSL2591_CTRL_ALS_HIGH_GAIN;
> +	case TSL2591_CTRL_ALS_MAX_GAIN_MULTIPLIER:
> +		return TSL2591_CTRL_ALS_MAX_GAIN;
> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int tsl2591_persist_cycle_to_lit(const u8 als_persist)
> +{
> +	switch (als_persist) {
> +	case TSL2591_PRST_ALS_INT_CYCLE_ANY:
> +		return TSL2591_PRST_ALS_INT_CYCLE_1_LIT;
> +	case TSL2591_PRST_ALS_INT_CYCLE_2:
> +		return TSL2591_PRST_ALS_INT_CYCLE_2_LIT;
> +	case TSL2591_PRST_ALS_INT_CYCLE_3:
> +		return TSL2591_PRST_ALS_INT_CYCLE_3_LIT;
> +	case TSL2591_PRST_ALS_INT_CYCLE_5:
> +		return TSL2591_PRST_ALS_INT_CYCLE_5_LIT;
> +	case TSL2591_PRST_ALS_INT_CYCLE_10:
> +		return TSL2591_PRST_ALS_INT_CYCLE_10_LIT;
> +	case TSL2591_PRST_ALS_INT_CYCLE_15:
> +		return TSL2591_PRST_ALS_INT_CYCLE_15_LIT;
> +	case TSL2591_PRST_ALS_INT_CYCLE_20:
> +		return TSL2591_PRST_ALS_INT_CYCLE_20_LIT;
> +	case TSL2591_PRST_ALS_INT_CYCLE_25:
> +		return TSL2591_PRST_ALS_INT_CYCLE_25_LIT;
> +	case TSL2591_PRST_ALS_INT_CYCLE_30:
> +		return TSL2591_PRST_ALS_INT_CYCLE_30_LIT;
> +	case TSL2591_PRST_ALS_INT_CYCLE_35:
> +		return TSL2591_PRST_ALS_INT_CYCLE_35_LIT;
> +	case TSL2591_PRST_ALS_INT_CYCLE_40:
> +		return TSL2591_PRST_ALS_INT_CYCLE_40_LIT;
> +	case TSL2591_PRST_ALS_INT_CYCLE_45:
> +		return TSL2591_PRST_ALS_INT_CYCLE_45_LIT;
> +	case TSL2591_PRST_ALS_INT_CYCLE_50:
> +		return TSL2591_PRST_ALS_INT_CYCLE_50_LIT;
> +	case TSL2591_PRST_ALS_INT_CYCLE_55:
> +		return TSL2591_PRST_ALS_INT_CYCLE_55_LIT;
> +	case TSL2591_PRST_ALS_INT_CYCLE_60:
> +		return TSL2591_PRST_ALS_INT_CYCLE_60_LIT;
> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int tsl2591_persist_lit_to_cycle(const u8 als_persist)
> +{
> +	switch (als_persist) {
> +	case TSL2591_PRST_ALS_INT_CYCLE_1_LIT:
> +		return TSL2591_PRST_ALS_INT_CYCLE_ANY;
> +	case TSL2591_PRST_ALS_INT_CYCLE_2_LIT:
> +		return TSL2591_PRST_ALS_INT_CYCLE_2;
> +	case TSL2591_PRST_ALS_INT_CYCLE_3_LIT:
> +		return TSL2591_PRST_ALS_INT_CYCLE_3;
> +	case TSL2591_PRST_ALS_INT_CYCLE_5_LIT:
> +		return TSL2591_PRST_ALS_INT_CYCLE_5;
> +	case TSL2591_PRST_ALS_INT_CYCLE_10_LIT:
> +		return TSL2591_PRST_ALS_INT_CYCLE_10;
> +	case TSL2591_PRST_ALS_INT_CYCLE_15_LIT:
> +		return TSL2591_PRST_ALS_INT_CYCLE_15;
> +	case TSL2591_PRST_ALS_INT_CYCLE_20_LIT:
> +		return TSL2591_PRST_ALS_INT_CYCLE_20;
> +	case TSL2591_PRST_ALS_INT_CYCLE_25_LIT:
> +		return TSL2591_PRST_ALS_INT_CYCLE_25;
> +	case TSL2591_PRST_ALS_INT_CYCLE_30_LIT:
> +		return TSL2591_PRST_ALS_INT_CYCLE_30;
> +	case TSL2591_PRST_ALS_INT_CYCLE_35_LIT:
> +		return TSL2591_PRST_ALS_INT_CYCLE_35;
> +	case TSL2591_PRST_ALS_INT_CYCLE_40_LIT:
> +		return TSL2591_PRST_ALS_INT_CYCLE_40;
> +	case TSL2591_PRST_ALS_INT_CYCLE_45_LIT:
> +		return TSL2591_PRST_ALS_INT_CYCLE_45;
> +	case TSL2591_PRST_ALS_INT_CYCLE_50_LIT:
> +		return TSL2591_PRST_ALS_INT_CYCLE_50;
> +	case TSL2591_PRST_ALS_INT_CYCLE_55_LIT:
> +		return TSL2591_PRST_ALS_INT_CYCLE_55;
> +	case TSL2591_PRST_ALS_INT_CYCLE_60_LIT:
> +		return TSL2591_PRST_ALS_INT_CYCLE_60;
> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int tsl2591_compatible_int_time(struct tsl2591_chip *chip,
> +				       u32 als_integration_time)

const u32 for consistency? here and elsewhere

> +{
> +	switch (als_integration_time) {
> +	case TSL2591_CTRL_ALS_INTEGRATION_100MS:
> +	case TSL2591_CTRL_ALS_INTEGRATION_200MS:
> +	case TSL2591_CTRL_ALS_INTEGRATION_300MS:
> +	case TSL2591_CTRL_ALS_INTEGRATION_400MS:
> +	case TSL2591_CTRL_ALS_INTEGRATION_500MS:
> +	case TSL2591_CTRL_ALS_INTEGRATION_600MS:
> +		chip->als_settings.als_int_time = als_integration_time;
> +		return 0;
> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int tsl2591_compatible_gain(struct tsl2591_chip *chip, u8 als_gain)
> +{
> +	switch (als_gain) {
> +	case TSL2591_CTRL_ALS_LOW_GAIN:
> +	case TSL2591_CTRL_ALS_MED_GAIN:
> +	case TSL2591_CTRL_ALS_HIGH_GAIN:
> +	case TSL2591_CTRL_ALS_MAX_GAIN:
> +		chip->als_settings.als_gain = als_gain;
> +		return 0;
> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int tsl2591_compatible_als_persist(struct tsl2591_chip *chip,
> +					  u32 als_persist)
> +{
> +	switch (als_persist) {
> +	case TSL2591_PRST_ALS_INT_CYCLE_ANY:
> +	case TSL2591_PRST_ALS_INT_CYCLE_2:
> +	case TSL2591_PRST_ALS_INT_CYCLE_3:
> +	case TSL2591_PRST_ALS_INT_CYCLE_5:
> +	case TSL2591_PRST_ALS_INT_CYCLE_10:
> +	case TSL2591_PRST_ALS_INT_CYCLE_15:
> +	case TSL2591_PRST_ALS_INT_CYCLE_20:
> +	case TSL2591_PRST_ALS_INT_CYCLE_25:
> +	case TSL2591_PRST_ALS_INT_CYCLE_30:
> +	case TSL2591_PRST_ALS_INT_CYCLE_35:
> +	case TSL2591_PRST_ALS_INT_CYCLE_40:
> +	case TSL2591_PRST_ALS_INT_CYCLE_45:
> +	case TSL2591_PRST_ALS_INT_CYCLE_50:
> +	case TSL2591_PRST_ALS_INT_CYCLE_55:
> +	case TSL2591_PRST_ALS_INT_CYCLE_60:
> +		chip->als_settings.als_persist = als_persist;
> +		return 0;
> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int tsl2591_wait_adc_complete(struct tsl2591_chip *chip)
> +{
> +	struct i2c_client *client = chip->client;
> +	struct tsl2591_settings settings = chip->als_settings;
> +	int delay = als_time_secs_to_ms(settings.als_int_time);
> +	int ret;
> +	int i;
> +
> +	if (!delay)
> +		return -EINVAL;
> +
> +	/*
> +	 * Sleep for als integration time to allow enough time

ALS (here and elsewhere)

> +	 * for an ADC read cycle to complete. Check status after
> +	 * delay for als valid
> +	 */
> +	msleep(delay);
> +
> +	/* Check for status als valid flag for up to 100ms */
> +	for (i = 0; i < TSL2591_ALS_STS_VALID_COUNT; ++i) {
> +		ret = i2c_smbus_read_byte_data(client, TSL2591_CMD_NOP |
> +			TSL2591_STATUS);
> +		if (ret < 0) {
> +			dev_err(&client->dev, "failed to read register\n");
> +			return -EINVAL;
> +		}
> +
> +		if ((ret & TSL2591_STS_ALS_VALID) == TSL2591_STS_VAL_HIGH)
> +			break;
> +
> +		if (i == (TSL2591_ALS_STS_VALID_COUNT - 1))
> +			return -ENODATA;
> +
> +		usleep_range(9000, 10000);
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * tsl2591_read_channel_data() - Reads raw channel data and calculates lux
> + *
> + * Formula for lux calculation;
> + * Derived from Adafruit's TSL2591 library
> + * Link: https://github.com/adafruit/Adafruit_TSL2591_Library
> + * Counts Per Lux (CPL) = (ATIME_ms * AGAIN) / LUX DF
> + * lux = ((C0DATA - C1DATA) * (1 - (C1DATA / C0DATA))) / CPL
> + *
> + * Scale values to get more representative value of lux i.e.
> + * lux = ((C0DATA - C1DATA) * (1000 - ((C1DATA * 1000) / C0DATA))) / CPL
> + *
> + * Channel 0 = IR + Visible
> + * Channel 1 = IR only
> + * Visible = Channel 0 - Channel 1
> + *
> + */
> +static int tsl2591_read_channel_data(struct iio_dev *indio_dev)
> +{
> +	struct tsl2591_chip *chip = iio_priv(indio_dev);
> +	struct tsl2591_settings *settings = &chip->als_settings;
> +	struct i2c_client *client = chip->client;
> +	int i;
> +	int ret;
> +	u8 channel_data[TSL2591_NUM_DATA_CHANNELS];
> +
> +	int counts_per_lux;
> +	int lux;
> +	int gain_multiplier;
> +
> +	ret = tsl2591_wait_adc_complete(chip);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "No data available. Err: %d\n", ret);
> +		return -ENODATA;

return ret; _wait_adc_complete() may also return -EINVAL

> +	}
> +
> +	for (i = 0; i < TSL2591_NUM_DATA_CHANNELS; ++i) {
> +		int reg = TSL2591_CMD_NOP | tsl2591_data_channels[i];
> +
> +		ret = i2c_smbus_read_byte_data(client, TSL2591_CMD_NOP | reg);
> +		if (ret < 0) {
> +			dev_err(&client->dev,
> +				"Failed to read register %#04x\n", reg);
> +			return -EINVAL;
> +		}
> +		channel_data[i] = ret;
> +	}
> +
> +	chip->als_readings.als_ch0 =
> +		le16_to_cpup((const __le16 *)&channel_data[0]);
> +	chip->als_readings.als_ch1 =
> +		le16_to_cpup((const __le16 *)&channel_data[2]);
> +
> +	dev_dbg(&client->dev, "both: %d\n", chip->als_readings.als_ch0);
> +	dev_dbg(&client->dev, "ir: %d\n", chip->als_readings.als_ch1);
> +
> +	gain_multiplier = tsl2591_gain_to_multiplier(settings->als_gain);
> +	if (gain_multiplier < 0) {
> +		dev_err(&client->dev, "Invalid multiplier. Err: %d\n",
> +			gain_multiplier);
> +		return -EINVAL;
> +	}
> +
> +	/* Calculate counts per lux value */
> +	counts_per_lux = (als_time_secs_to_ms(settings->als_int_time) *
> +			gain_multiplier) / TSL2591_LUX_COEFFICIENT;
> +
> +	dev_dbg(&client->dev, "Counts Per Lux (CPL): %d\n", counts_per_lux);
> +
> +	/* Calculate lux value */
> +	lux = ((chip->als_readings.als_ch0 - chip->als_readings.als_ch1) *
> +	(1000 - ((chip->als_readings.als_ch1 * 1000) /
> +	chip->als_readings.als_ch0))) / counts_per_lux;
> +
> +	/* Divide by 1000 to get real lux value before scaling */
> +	chip->als_readings.als_lux_int = lux / 1000;
> +
> +	/* Get the decimal part of lux reading */
> +	chip->als_readings.als_lux_decimal =
> +		(lux - (chip->als_readings.als_lux_int * 1000));
> +
> +	dev_dbg(&client->dev, "Raw lux calculation: %d\n", lux);
> +
> +	return ret;
> +}
> +
> +static int tsl2591_set_als_gain_int_time(struct tsl2591_chip *chip)
> +{
> +	struct i2c_client *client = chip->client;
> +	struct tsl2591_settings als_settings = chip->als_settings;
> +	int ret;
> +
> +	ret = i2c_smbus_write_byte_data(client,
> +					TSL2591_CMD_NOP | TSL2591_CONTROL,
> +					als_settings.als_int_time |
> +					als_settings.als_gain);
> +	if (ret < 0)
> +		dev_err(&client->dev, "Failed to set als gain & int time\n");
> +
> +	return ret;
> +}
> +
> +static int tsl2591_set_als_thresholds(struct tsl2591_chip *chip)
> +{
> +	struct i2c_client *client = chip->client;
> +	struct tsl2591_settings als_settings = chip->als_settings;
> +	int ret;
> +
> +	u8 als_lower_l;
> +	u8 als_lower_h;
> +	u8 als_upper_l;
> +	u8 als_upper_h;
> +
> +	if (als_settings.als_lower_threshold >= als_settings.als_upper_threshold) {
> +		dev_warn(&client->dev, "lower threshold higher than upper\n");
> +		return -EINVAL;
> +	}
> +
> +	if (als_settings.als_upper_threshold > TSL2591_ALS_MAX_VALUE) {
> +		dev_warn(&client->dev, "upper threshold higher than max\n");
> +		return -EINVAL;
> +	}
> +
> +	als_lower_l = (als_settings.als_lower_threshold & 0x00FF);
> +	als_lower_h = ((als_settings.als_lower_threshold >> 8) & 0x00FF);
> +	als_upper_l = (als_settings.als_upper_threshold & 0x00FF);
> +	als_upper_h = ((als_settings.als_upper_threshold >> 8) & 0x00FF);
> +
> +	dev_dbg(&client->dev, "Setting configuration - als lower l: %#04x\n",
> +		als_lower_l);
> +	dev_dbg(&client->dev, "Setting configuration - als lower h: %#04x\n",
> +		als_lower_h);
> +	dev_dbg(&client->dev, "Setting configuration - als upper l: %#04x\n",
> +		als_upper_l);
> +	dev_dbg(&client->dev, "Setting configuration - als upper h: %#04x\n",
> +		als_upper_h);
> +
> +	ret = i2c_smbus_write_byte_data(client, TSL2591_CMD_NOP |
> +		TSL2591_AILTL, als_lower_l);
> +	if (ret < 0)
> +		dev_err(&client->dev, "Failed to set als lower threshold\n");
> +
> +	ret = i2c_smbus_write_byte_data(client, TSL2591_CMD_NOP |
> +		TSL2591_AILTH, als_lower_h);
> +	if (ret < 0)
> +		dev_err(&client->dev, "Failed to set als lower threshold\n");
> +
> +	ret = i2c_smbus_write_byte_data(client, TSL2591_CMD_NOP |
> +		TSL2591_AIHTL, als_upper_l);
> +	if (ret < 0)
> +		dev_err(&client->dev, "Failed to set als upper threshold\n");
> +
> +	ret = i2c_smbus_write_byte_data(client, TSL2591_CMD_NOP |
> +		TSL2591_AIHTH, als_upper_h);
> +	if (ret < 0)
> +		dev_err(&client->dev, "Failed to set als upper threshold\n");
> +
> +	return ret;
> +}
> +
> +static int tsl2591_set_als_persist_cycle(struct tsl2591_chip *chip)
> +{
> +	struct i2c_client *client = chip->client;
> +	struct tsl2591_settings als_settings = chip->als_settings;
> +	int ret;
> +
> +	ret = i2c_smbus_write_byte_data(client, TSL2591_CMD_NOP |
> +		TSL2591_PERSIST, als_settings.als_persist);
> +	if (ret < 0)
> +		dev_err(&client->dev, "Failed to set als persist cycle\n");
> +
> +	return ret;
> +}
> +
> +static int tsl2591_set_power_state(struct tsl2591_chip *chip, u8 state)
> +{
> +	struct i2c_client *client = chip->client;
> +	int ret;
> +
> +	ret = i2c_smbus_write_byte_data(client, TSL2591_CMD_NOP |
> +					TSL2591_ENABLE, state);
> +	if (ret < 0)
> +		dev_err(&client->dev,
> +			"Failed to set the power state to %#04x\n", state);
> +
> +	return ret;
> +}
> +
> +static int tsl2591_get_power_state(struct tsl2591_chip *chip)
> +{
> +	struct i2c_client *client = chip->client;
> +	int ret;
> +
> +	ret = i2c_smbus_read_byte_data(client, TSL2591_CMD_NOP |
> +					TSL2591_ENABLE);
> +	if (ret < 0)
> +		dev_err(&client->dev, "Failed to get power state\n");
> +
> +	return ret;
> +}
> +
> +static ssize_t in_illuminance_integration_time_show(struct device *dev,

tsl2591_ prefix missing

> +						    struct device_attribute *attr,
> +						    char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct tsl2591_chip *chip = iio_priv(indio_dev);
> +	int ret;
> +
> +	int als_int_time = als_time_secs_to_ms(chip->als_settings.als_int_time);
> +
> +	mutex_lock(&chip->als_mutex);

what purpose does the mutex serve?

> +	ret = sprintf(buf, "%d\n", als_int_time);
> +	mutex_unlock(&chip->als_mutex);
> +
> +	return ret;
> +}
> +
> +static ssize_t in_illuminance_integration_time_store(struct device *dev,

tsl2591_ prefix

> +						     struct device_attribute *attr,
> +						     const char *buf, size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct tsl2591_chip *chip = iio_priv(indio_dev);
> +	struct i2c_client *client = chip->client;
> +
> +	u32 int_time;
> +	int value;
> +
> +	if (kstrtoint(buf, 0, &value) || !value)
> +		return -EINVAL;
> +
> +	mutex_lock(&chip->als_mutex);
> +
> +	int_time = als_time_ms_to_secs(value);
> +
> +	if (tsl2591_compatible_int_time(chip, int_time))
> +		goto calibrate_error;
> +
> +	if (tsl2591_set_als_gain_int_time(chip))
> +		goto calibrate_error;
> +
> +	mutex_unlock(&chip->als_mutex);
> +
> +	return len;
> +
> +calibrate_error:
> +	dev_err(&client->dev, "Failed to calibrate sensor\n");
> +	mutex_unlock(&chip->als_mutex);
> +	return -EINVAL;
> +}
> +
> +static ssize_t in_illuminance_calibscale_show(struct device *dev,
> +					      struct device_attribute *attr,
> +						char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct tsl2591_chip *chip = iio_priv(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&chip->als_mutex);
> +	ret = sprintf(buf, "%d\n", tsl2591_gain_to_multiplier
> +		(chip->als_settings.als_gain));
> +	mutex_unlock(&chip->als_mutex);
> +
> +	return ret;
> +}
> +
> +static ssize_t in_illuminance_calibscale_store(struct device *dev,
> +					       struct device_attribute *attr,
> +						const char *buf, size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct tsl2591_chip *chip = iio_priv(indio_dev);
> +	struct i2c_client *client = chip->client;
> +
> +	u8 gain;
> +	int value;
> +
> +	if (kstrtoint(buf, 0, &value) || !value)
> +		return -EINVAL;
> +
> +	mutex_lock(&chip->als_mutex);
> +
> +	gain = tsl2591_multiplier_to_gain(value);
> +
> +	if (tsl2591_compatible_gain(chip, gain))
> +		goto calibrate_error;
> +
> +	if (tsl2591_set_als_gain_int_time(chip))
> +		goto calibrate_error;
> +
> +	mutex_unlock(&chip->als_mutex);
> +
> +	return len;
> +
> +calibrate_error:
> +	dev_err(&client->dev, "Failed to calibrate sensor\n");
> +	mutex_unlock(&chip->als_mutex);
> +	return -EINVAL;
> +}
> +
> +static ssize_t in_illuminance_period_available_show(struct device *dev,
> +						    struct device_attribute *attr,
> +						char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct tsl2591_chip *chip = iio_priv(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&chip->als_mutex);
> +	ret = snprintf(buf, PAGE_SIZE, "%s\n",
> +		       tsl2591_als_period_list[chip->als_settings.als_int_time]);
> +	mutex_unlock(&chip->als_mutex);
> +
> +	return ret;
> +}
> +
> +static IIO_CONST_ATTR(in_illuminance_integration_time_available,
> +				"100 200 300 400 500 600");
> +static IIO_CONST_ATTR(in_illuminance_calibscale_available,
> +				"1 25 428 9876");
> +static IIO_DEVICE_ATTR_RW(in_illuminance_integration_time, 0);
> +static IIO_DEVICE_ATTR_RW(in_illuminance_calibscale, 0);
> +
> +static struct attribute *tsl2591_sysfs_attrs_ctrl[] = {
> +	&iio_const_attr_in_illuminance_integration_time_available.dev_attr.attr,
> +	&iio_const_attr_in_illuminance_calibscale_available.dev_attr.attr,
> +	&iio_dev_attr_in_illuminance_integration_time.dev_attr.attr,
> +	&iio_dev_attr_in_illuminance_calibscale.dev_attr.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group tsl2591_sysfs_attribute_group = {
> +	.attrs = tsl2591_sysfs_attrs_ctrl,
> +};
> +
> +static IIO_DEVICE_ATTR_RO(in_illuminance_period_available, 0);
> +
> +static struct attribute *tsl2591_event_attrs_ctrl[] = {
> +	&iio_dev_attr_in_illuminance_period_available.dev_attr.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group tsl2591_event_attribute_group = {
> +	.attrs = tsl2591_event_attrs_ctrl,
> +};
> +
> +static const struct iio_event_spec tsl2591_events[] = {
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_RISING,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE),
> +	}, {
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_FALLING,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE),
> +	}, {
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_EITHER,
> +		.mask_separate = BIT(IIO_EV_INFO_PERIOD) |
> +				BIT(IIO_EV_INFO_ENABLE),
> +	},
> +};
> +
> +static const struct iio_chan_spec tsl2591_channels[] = {
> +	{
> +		.type = IIO_INTENSITY,
> +		.modified = 1,
> +		.channel2 = IIO_MOD_LIGHT_IR,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +	},
> +	{
> +		.type = IIO_INTENSITY,
> +		.modified = 1,
> +		.channel2 = IIO_MOD_LIGHT_BOTH,
> +		.event_spec = tsl2591_events,
> +		.num_event_specs = ARRAY_SIZE(tsl2591_events),
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +	},
> +	{
> +		.type = IIO_LIGHT,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> +	},
> +};
> +
> +static int tsl2591_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct tsl2591_chip *chip = iio_priv(indio_dev);
> +	struct i2c_client *client = chip->client;
> +	int ret;
> +
> +	dev_dbg(&client->dev, "Reading from sensor");
> +
> +	pm_runtime_get_sync(&chip->client->dev);
> +
> +	mutex_lock(&chip->als_mutex);
> +
> +	ret = -EINVAL;
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (chan->type == IIO_INTENSITY) {
> +			ret = tsl2591_read_channel_data(indio_dev);
> +			if (ret < 0)
> +				break;
> +
> +			if (chan->channel2 == IIO_MOD_LIGHT_BOTH) {
> +				*val = chip->als_readings.als_ch0;
> +				ret = IIO_VAL_INT;
> +			} else if (chan->channel2 == IIO_MOD_LIGHT_IR) {
> +				*val = chip->als_readings.als_ch1;
> +				ret = IIO_VAL_INT;
> +			} else {
> +				ret = -EINVAL;
> +			}
> +		}
> +		break;
> +	case IIO_CHAN_INFO_PROCESSED:
> +		if (chan->type == IIO_LIGHT) {
> +			ret = tsl2591_read_channel_data(indio_dev);
> +			if (ret < 0)
> +				break;
> +			*val = chip->als_readings.als_lux_int;
> +			*val2 = (chip->als_readings.als_lux_decimal * 1000);
> +			ret = IIO_VAL_INT_PLUS_MICRO;
> +		}
> +		break;
> +	}
> +
> +	mutex_unlock(&chip->als_mutex);
> +
> +	pm_runtime_mark_last_busy(&chip->client->dev);
> +	pm_runtime_put_autosuspend(&chip->client->dev);
> +
> +	return ret;
> +}
> +
> +static int tsl2591_read_event_value(struct iio_dev *indio_dev,
> +				    const struct iio_chan_spec *chan,
> +				enum iio_event_type type,
> +				enum iio_event_direction dir,
> +				enum iio_event_info info, int *val,
> +				int *val2)
> +{
> +	struct tsl2591_chip *chip = iio_priv(indio_dev);
> +	struct i2c_client *client = chip->client;
> +	int als_persist;
> +	int period;
> +	int ret;
> +	int int_time;
> +
> +	switch (info) {
> +	case IIO_EV_INFO_VALUE:
> +		switch (dir) {
> +		case IIO_EV_DIR_RISING:
> +			mutex_lock(&chip->als_mutex);
> +			*val = chip->als_settings.als_upper_threshold;
> +			mutex_unlock(&chip->als_mutex);
> +			break;
> +		case IIO_EV_DIR_FALLING:
> +			mutex_lock(&chip->als_mutex);
> +			*val = chip->als_settings.als_lower_threshold;
> +			mutex_unlock(&chip->als_mutex);
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		ret = IIO_VAL_INT;
> +		break;
> +	case IIO_EV_INFO_PERIOD:
> +		mutex_lock(&chip->als_mutex);
> +
> +		ret = i2c_smbus_read_byte_data(client,
> +					       TSL2591_CMD_NOP | TSL2591_PERSIST);
> +		if (ret <= 0 || ret > TSL2591_PRST_ALS_INT_CYCLE_MAX)
> +			goto err;
> +
> +		als_persist = tsl2591_persist_cycle_to_lit(ret);
> +		int_time = als_time_secs_to_ms(chip->als_settings.als_int_time);
> +		period = als_persist * (int_time * MSEC_PER_SEC);
> +
> +		*val = period / USEC_PER_SEC;
> +		*val2 = period % USEC_PER_SEC;
> +
> +		mutex_unlock(&chip->als_mutex);
> +		ret = IIO_VAL_INT_PLUS_MICRO;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +
> +err:
> +	mutex_unlock(&chip->als_mutex);
> +	return -EINVAL;
> +}
> +
> +static int tsl2591_write_event_value(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				enum iio_event_type type,
> +				enum iio_event_direction dir,
> +				enum iio_event_info info, int val,
> +				int val2)
> +{
> +	struct tsl2591_chip *chip = iio_priv(indio_dev);
> +	int period, int_time, als_cycle;
> +
> +	if (val < 0 || val2 < 0)
> +		return -EINVAL;
> +
> +	switch (info) {
> +	case IIO_EV_INFO_VALUE:
> +		if (val > TSL2591_ALS_MAX_VALUE)
> +			return -EINVAL;
> +		/* Lower threshold should not be higher than upper */
> +		if (dir == IIO_EV_DIR_FALLING)
> +			if (val > chip->als_settings.als_upper_threshold)
> +				return -EINVAL;
> +
> +		switch (dir) {
> +		case IIO_EV_DIR_RISING:
> +			mutex_lock(&chip->als_mutex);
> +			chip->als_settings.als_upper_threshold = val;
> +			if (tsl2591_set_als_thresholds(chip))
> +				goto err;
> +			mutex_unlock(&chip->als_mutex);
> +			break;
> +		case IIO_EV_DIR_FALLING:
> +			mutex_lock(&chip->als_mutex);
> +			chip->als_settings.als_lower_threshold = val;
> +			if (tsl2591_set_als_thresholds(chip))
> +				goto err;
> +			mutex_unlock(&chip->als_mutex);
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		break;
> +	case IIO_EV_INFO_PERIOD:
> +		mutex_lock(&chip->als_mutex);
> +		int_time = als_time_secs_to_ms(chip->als_settings.als_int_time);
> +		if (!val && val2)
> +			period = (val2 / MSEC_PER_SEC) / int_time;
> +		else if (val && !val2)
> +			period = (val * MSEC_PER_SEC) / int_time;
> +		else if (val && val2)
> +			period = ((val * MSEC_PER_SEC) +
> +				(val2 / MSEC_PER_SEC)) / int_time;
> +		else
> +			goto err;
> +
> +		als_cycle = tsl2591_persist_lit_to_cycle(period);
> +		if (als_cycle < 0)
> +			goto err;
> +		if (tsl2591_compatible_als_persist(chip, als_cycle))
> +			goto err;
> +		if (tsl2591_set_als_persist_cycle(chip))
> +			goto err;
> +		mutex_unlock(&chip->als_mutex);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +err:
> +	mutex_unlock(&chip->als_mutex);
> +	return -EINVAL;
> +}
> +
> +static int tsl2591_read_event_config(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				enum iio_event_type type,
> +				enum iio_event_direction dir)
> +{
> +	struct tsl2591_chip *chip = iio_priv(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&chip->als_mutex);
> +	ret = tsl2591_get_power_state(chip);
> +	mutex_unlock(&chip->als_mutex);
> +	if (ret < 0)
> +		return ret;
> +
> +	return !!(ret & TSL2591_ENABLE_ALS_INT);
> +}
> +
> +static int tsl2591_write_event_config(struct iio_dev *indio_dev,
> +				      const struct iio_chan_spec *chan,
> +				enum iio_event_type type,
> +				enum iio_event_direction dir,
> +				int state)
> +{
> +	struct tsl2591_chip *chip = iio_priv(indio_dev);
> +	struct i2c_client *client = chip->client;
> +
> +	if (state && !chip->events_enabled) {
> +		chip->events_enabled = true;
> +		pm_runtime_get_sync(&client->dev);
> +	} else if (!state && chip->events_enabled) {
> +		chip->events_enabled = false;
> +		pm_runtime_mark_last_busy(&client->dev);
> +		pm_runtime_put_autosuspend(&client->dev);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct iio_info tsl2591_info = {
> +	.attrs = &tsl2591_sysfs_attribute_group,
> +	.event_attrs = &tsl2591_event_attribute_group,
> +	.read_raw = tsl2591_read_raw,
> +	.read_event_value = tsl2591_read_event_value,
> +	.write_event_value = tsl2591_write_event_value,
> +	.read_event_config = tsl2591_read_event_config,
> +	.write_event_config = tsl2591_write_event_config,
> +};
> +
> +static int __maybe_unused tsl2591_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct tsl2591_chip *chip = iio_priv(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&chip->als_mutex);
> +	ret = tsl2591_set_power_state(chip, TSL2591_PWR_OFF);
> +	mutex_unlock(&chip->als_mutex);
> +
> +	return ret;
> +}
> +
> +static int __maybe_unused tsl2591_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct tsl2591_chip *chip = iio_priv(indio_dev);
> +	int ret;
> +	int power_state;
> +
> +	if (chip->events_enabled)
> +		power_state = TSL2591_PWR_ON | TSL2591_ENABLE_ALS_INT |
> +				TSL2591_ENABLE_ALS;
> +	else
> +		power_state = TSL2591_PWR_ON | TSL2591_ENABLE_ALS;
> +
> +	mutex_lock(&chip->als_mutex);
> +	ret = tsl2591_set_power_state(chip, power_state);
> +	mutex_unlock(&chip->als_mutex);
> +
> +	return ret;
> +}
> +
> +static const struct dev_pm_ops tsl2591_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +				pm_runtime_force_resume)
> +	SET_RUNTIME_PM_OPS(tsl2591_suspend, tsl2591_resume, NULL)
> +};
> +
> +static irqreturn_t tsl2591_event_handler(int irq, void *private)
> +{
> +	struct iio_dev *dev_info = private;
> +	struct tsl2591_chip *chip = iio_priv(dev_info);
> +	struct i2c_client *client = chip->client;
> +	int ret;
> +
> +	if (!chip->events_enabled)
> +		return IRQ_HANDLED;
> +
> +	iio_push_event(dev_info,
> +		       IIO_UNMOD_EVENT_CODE(IIO_LIGHT, 0,
> +					    IIO_EV_TYPE_THRESH,
> +					IIO_EV_DIR_EITHER),
> +			iio_get_time_ns(dev_info));
> +
> +	/* Clear als irq */
> +	ret = i2c_smbus_write_byte(client, TSL2591_CMD_SF_CALS_NPI);
> +	if (ret < 0)
> +		dev_err(&client->dev, "failed to clear als irq\n");
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int tsl2591_load_defaults(struct tsl2591_chip *chip)
> +{
> +	struct i2c_client *client = chip->client;
> +
> +	chip->als_settings.als_int_time = TSL2591_DEFAULT_ALS_INT_TIME;
> +	chip->als_settings.als_gain = TSL2591_DEFAULT_ALS_GAIN;
> +	chip->als_settings.als_persist = TSL2591_DEFAULT_ALS_PERSIST;
> +	chip->als_settings.als_lower_threshold =
> +		TSL2591_DEFAULT_ALS_LOWER_THRESHOLD;
> +	chip->als_settings.als_upper_threshold =
> +		TSL2591_DEFAULT_ALS_UPPER_THRESHOLD;
> +
> +	if (tsl2591_set_als_gain_int_time(chip)) {
> +		dev_err(&client->dev, "Failed to set als gain and int time\n");
> +		return -EINVAL;
> +	}
> +
> +	if (tsl2591_set_als_persist_cycle(chip)) {
> +		dev_err(&client->dev, "Failed to set als thresholds\n");

wrong message, should refer to persist_cycle?

> +		return -EINVAL;
> +	}
> +
> +	if (tsl2591_set_als_thresholds(chip)) {
> +		dev_err(&client->dev, "Failed to set als thresholds\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static void tsl2591_chip_off(void *data)
> +{
> +	struct iio_dev *indio_dev = data;
> +	struct tsl2591_chip *chip = iio_priv(indio_dev);
> +	struct i2c_client *client = chip->client;
> +
> +	pm_runtime_disable(&client->dev);
> +	pm_runtime_set_suspended(&client->dev);
> +	pm_runtime_put_noidle(&client->dev);
> +
> +	tsl2591_set_power_state(chip, TSL2591_PWR_OFF);
> +}
> +
> +static int tsl2591_probe(struct i2c_client *client)
> +{
> +	struct tsl2591_chip *chip;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	if (!i2c_check_functionality(client->adapter,
> +				     I2C_FUNC_SMBUS_BYTE_DATA)) {
> +		dev_err(&client->dev,
> +			"I2C smbus byte data functionality is not supported\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	chip = iio_priv(indio_dev);
> +	chip->client = client;
> +	i2c_set_clientdata(client, indio_dev);
> +
> +	if (client->irq) {
> +		ret = devm_request_threaded_irq(&client->dev, client->irq,
> +						NULL, tsl2591_event_handler,
> +				IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +				"tsl2591_irq", indio_dev);
> +		if (ret) {
> +			dev_err(&client->dev, "irq request error %d\n", -ret);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	mutex_init(&chip->als_mutex);
> +
> +	ret = i2c_smbus_read_byte_data(client,
> +				       TSL2591_CMD_NOP | TSL2591_DEVICE_ID);
> +	if (ret < 0) {
> +		dev_err(&client->dev,
> +			"Failed to read the device ID register\n");
> +		return ret;
> +	}
> +
> +	if ((ret & TSL2591_DEVICE_ID_MASK) != TSL2591_DEVICE_ID_VAL) {
> +		dev_err(&client->dev, "Device ID: %#04x unknown\n", ret);
> +		return -EINVAL;
> +	}
> +
> +	indio_dev->info = &tsl2591_info;
> +	indio_dev->channels = tsl2591_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(tsl2591_channels);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->name = chip->client->name;
> +	chip->events_enabled = false;
> +
> +	pm_runtime_enable(&client->dev);
> +	pm_runtime_set_autosuspend_delay(&client->dev,
> +					 TSL2591_POWER_OFF_DELAY_MS);
> +	pm_runtime_use_autosuspend(&client->dev);
> +
> +	if (tsl2591_load_defaults(chip)) {
> +		dev_err(&client->dev, "Failed to load sensor defaults\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = i2c_smbus_write_byte(client, TSL2591_CMD_SF_CALS_NPI);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "failed to clear als irq\n");

maybe consistent first letter: Failed vs failed

> +		return -EINVAL;
> +	}
> +
> +	/* Add chip off to automatically managed path */
> +	ret = devm_add_action_or_reset(&client->dev,
> +				       tsl2591_chip_off,
> +					indio_dev);
> +	if (ret < 0)
> +		return -EINVAL;
> +
> +	ret = devm_iio_device_register(&client->dev, indio_dev);
> +	if (ret) {
> +		dev_err(&client->dev, "iio registration failed\n");

probably not a very informative message

> +		return ret;
> +	}
> +
> +	dev_info(&client->dev, "Probe complete - tsl2591 found.\n");

message needed?

> +
> +	return 0;
> +}
> +
> +static const struct of_device_id tsl2591_of_match[] = {
> +	{ .compatible = "amstaos,tsl2591"},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, tsl2591_of_match);
> +
> +static struct i2c_driver tsl2591_driver = {
> +	.driver = {
> +		.name = "tsl2591",
> +		.pm = &tsl2591_pm_ops,
> +		.of_match_table = tsl2591_of_match,
> +	},
> +	.probe_new = tsl2591_probe,
> +};
> +module_i2c_driver(tsl2591_driver);
> +
> +MODULE_AUTHOR("Joe Sandom <joe.sandom@outlook.com>");
> +MODULE_DESCRIPTION("TAOS tsl2591 ambient light sensor driver");
> +MODULE_LICENSE("GPL");
> 

-- 

Peter Meerwald-Stadler
Mobile: +43 664 24 44 418
