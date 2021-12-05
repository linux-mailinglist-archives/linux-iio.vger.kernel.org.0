Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54249468AA1
	for <lists+linux-iio@lfdr.de>; Sun,  5 Dec 2021 12:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbhLELol (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Dec 2021 06:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbhLELok (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Dec 2021 06:44:40 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751EEC061714;
        Sun,  5 Dec 2021 03:41:13 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id w1so31103221edc.6;
        Sun, 05 Dec 2021 03:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:cc
         :references:from:in-reply-to:content-transfer-encoding;
        bh=UilxCtUOnTCOam6+ik8dbLlJ7aw9mq+2QeNJSIGFTt8=;
        b=WmiKXwjifzVnKW7gviT+7+3kFiyew8BBGkqmwLCKtfzDu8xMWgcdoBS1xJ9VcU/sYc
         P0IvGnwXq2YiBB4qNzK1Vd4UaY+tYQxtW79Adp8O6eKxpA8NNOC8XPn1ZmI+1BQESIpA
         2cjfJODPgAo0lq89k1XWySp0z2WMzv9wkUGn36Qgheh69PGjHU/vUuZL6S4pIjX9bcYu
         iW6kwo8kV7Bb5t9Orcva99nw6w81nGT3rPRrozSsj3hpvxbDVH9bUvK7bz78E0OVOz0B
         C1eyH3+8BkClO+r3WwknJXd8fBj2w0In6BNPj7fMJv9IHEo1BFzpAi3ecH+rG26RDvuX
         Istw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UilxCtUOnTCOam6+ik8dbLlJ7aw9mq+2QeNJSIGFTt8=;
        b=IWvvam8HuZwf1w1bFBPB+KXY3K3oc8EBaLElXQKh8TjPQEvWyEdRBOkGBuF1ZhkuF3
         gBA5l5rOgyy+ZTuZrxtO5+dg14dLrGVYvn9QrKROXyWV8JohNgEsV02YpGuG2Y22THCe
         H63X8CODDJ0t0tF9CjI6nD52OB6W81SANvBTp51gcKW/QWvo/F3jElm2V3N1szjZIEXs
         wFMAQGS9kBn9ybAse729RJrHFCdjlYt+jurB2XjZxtQdFhvt8bDEMhc525oWByivA7ix
         STYvtppe1WqYV7TTZfTU32hCI0iEFv3KDsY5hsG7NvhmICI/uqOZyUAqD2Hh/9qQQ7y5
         CExg==
X-Gm-Message-State: AOAM532SSW3fgCrbxmEwLnOzPrPBxnCIfBulpsEwXdpffipdqA2kB5nB
        3o8s4yENdr9qUsxgAm69Lzk=
X-Google-Smtp-Source: ABdhPJwWtfSZ1yoimBGqadr04/EFkwURSAPG6k1x1YAi1U3/S6f5MQhqGtYZQNcF04YVNOs3f6mQ3A==
X-Received: by 2002:a05:6402:42c6:: with SMTP id i6mr44178702edc.223.1638704471796;
        Sun, 05 Dec 2021 03:41:11 -0800 (PST)
Received: from [192.168.0.182] ([188.24.96.74])
        by smtp.gmail.com with ESMTPSA id r24sm5666191edv.18.2021.12.05.03.41.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Dec 2021 03:41:11 -0800 (PST)
Message-ID: <ed607f26-b089-71ad-8b87-6de9da8100bd@gmail.com>
Date:   Sun, 5 Dec 2021 13:41:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v10 3/3] iio: addac: add AD74413R driver
Content-Language: en-US
Cc:     cosmin.tanislav@analog.com, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org
References: <20211205113426.41486-1-cosmin.tanislav@analog.com>
 <20211205113426.41486-4-cosmin.tanislav@analog.com>
From:   Cosmin Tanislav <demonsingur@gmail.com>
In-Reply-To: <20211205113426.41486-4-cosmin.tanislav@analog.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


Fixed an error in V11, ignore this.


On 12/5/21 13:34, Cosmin Tanislav wrote:
> The AD74412R and AD74413R are quad-channel, software configurable,
> input/output solutions for building and process control applications.
> 
> They contain functionality for analog output, analog input, digital input,
> resistance temperature detector, and thermocouple measurements integrated
> into a single chip solution with an SPI interface.
> 
> The devices feature a 16-bit ADC and four configurable 13-bit DACs to
> provide four configurable input/output channels and a suite of diagnostic
> functions.
> 
> The AD74413R differentiates itself from the AD74412R by being
> HART-compatible.
> 
> When configured with channel 0 as voltage output, channel 1 as current
> output, channel 2 as voltage input and channel 3 as current input, the
> following structure is created under the corresponding IIO device.
> 
> .
> ├── in_current0_offset
> ├── in_current0_raw
> ├── in_current0_sampling_frequency
> ├── in_current0_sampling_frequency_available
> ├── in_current0_scale
> ├── in_voltage1_offset
> ├── in_voltage1_raw
> ├── in_voltage1_sampling_frequency
> ├── in_voltage1_sampling_frequency_available
> ├── in_voltage1_scale
> ├── in_voltage2_offset
> ├── in_voltage2_raw
> ├── in_voltage2_sampling_frequency
> ├── in_voltage2_sampling_frequency_available
> ├── in_voltage2_scale
> ├── in_current3_offset
> ├── in_current3_raw
> ├── in_current3_sampling_frequency
> ├── in_current3_sampling_frequency_available
> ├── in_current3_scale
> ├── out_voltage0_raw
> ├── out_voltage0_scale
> ├── out_current1_raw
> ├── out_current1_scale
> ├── name
> ├── buffer
> │   ├── data_available
> │   ├── enable
> │   ├── length
> │   └── watermark
> └── scan_elements
>      ├── in_current0_en
>      ├── in_current0_index
>      ├── in_current0_type
>      ├── in_voltage1_en
>      ├── in_voltage1_index
>      ├── in_voltage1_type
>      ├── in_voltage2_en
>      ├── in_voltage2_index
>      ├── in_voltage2_type
>      ├── in_current3_en
>      ├── in_current3_index
>      └── in_current3_type
> 
> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>   MAINTAINERS                  |    9 +
>   drivers/iio/addac/Kconfig    |   12 +
>   drivers/iio/addac/Makefile   |    1 +
>   drivers/iio/addac/ad74413r.c | 1475 ++++++++++++++++++++++++++++++++++
>   4 files changed, 1497 insertions(+)
>   create mode 100644 drivers/iio/addac/ad74413r.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 46c915468801..57fb0f19ee08 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1069,6 +1069,15 @@ W:	http://ez.analog.com/community/linux-device-drivers
>   F:	Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml
>   F:	drivers/iio/adc/ad7780.c
>   
> +ANALOG DEVICES INC AD74413R DRIVER
> +M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Supported
> +W:	http://ez.analog.com/community/linux-device-drivers
> +F:	Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
> +F:	drivers/iio/addac/ad74413r.c
> +F:	include/dt-bindings/iio/addac/adi,ad74413r.h
> +
>   ANALOG DEVICES INC AD9389B DRIVER
>   M:	Hans Verkuil <hverkuil-cisco@xs4all.nl>
>   L:	linux-media@vger.kernel.org
> diff --git a/drivers/iio/addac/Kconfig b/drivers/iio/addac/Kconfig
> index 2e64d7755d5e..138492362f20 100644
> --- a/drivers/iio/addac/Kconfig
> +++ b/drivers/iio/addac/Kconfig
> @@ -5,4 +5,16 @@
>   
>   menu "Analog to digital and digital to analog converters"
>   
> +config AD74413R
> +	tristate "Analog Devices AD74412R/AD74413R driver"
> +	depends on GPIOLIB && SPI
> +	select REGMAP_SPI
> +	select CRC8
> +	help
> +	  Say yes here to build support for Analog Devices AD74412R/AD74413R
> +	  quad-channel software configurable input/output solution.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called ad74413r.
> +
>   endmenu
> diff --git a/drivers/iio/addac/Makefile b/drivers/iio/addac/Makefile
> index b888b9ee12da..cfd4bbe64ad3 100644
> --- a/drivers/iio/addac/Makefile
> +++ b/drivers/iio/addac/Makefile
> @@ -4,3 +4,4 @@
>   #
>   
>   # When adding new entries keep the list in alphabetical order
> +obj-$(CONFIG_AD74413R) += ad74413r.o
> diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
> new file mode 100644
> index 000000000000..ea3685b0c6dd
> --- /dev/null
> +++ b/drivers/iio/addac/ad74413r.c
> @@ -0,0 +1,1475 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2021 Analog Devices, Inc.
> + * Author: Cosmin Tanislav <cosmin.tanislav@analog.com>
> + */
> +
> +#include <asm/unaligned.h>
> +#include <linux/bitfield.h>
> +#include <linux/crc8.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/interrupt.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +
> +#include <dt-bindings/iio/addac/adi,ad74413r.h>
> +
> +#define AD74413R_CRC_POLYNOMIAL	0x7
> +DECLARE_CRC8_TABLE(ad74413r_crc8_table);
> +
> +#define AD74413R_CHANNEL_MAX	4
> +
> +#define AD74413R_FRAME_SIZE	4
> +
> +struct ad74413r_chip_info {
> +	const char	*name;
> +	bool		hart_support;
> +};
> +
> +struct ad74413r_channel_config {
> +	u32		func;
> +	bool		gpo_comparator;
> +	bool		initialized;
> +};
> +
> +struct ad74413r_channels {
> +	struct iio_chan_spec	*channels;
> +	unsigned int		num_channels;
> +};
> +
> +struct ad74413r_state {
> +	struct ad74413r_channel_config	channel_configs[AD74413R_CHANNEL_MAX];
> +	unsigned int			gpo_gpio_offsets[AD74413R_CHANNEL_MAX];
> +	unsigned int			comp_gpio_offsets[AD74413R_CHANNEL_MAX];
> +	struct gpio_chip		gpo_gpiochip;
> +	struct gpio_chip		comp_gpiochip;
> +	struct completion		adc_data_completion;
> +	unsigned int			num_gpo_gpios;
> +	unsigned int			num_comparator_gpios;
> +	u32				sense_resistor_ohms;
> +
> +	/*
> +	 * Synchronize consecutive operations when doing a one-shot
> +	 * conversion and when updating the ADC samples SPI message.
> +	 */
> +	struct mutex			lock;
> +
> +	const struct ad74413r_chip_info	*chip_info;
> +	struct spi_device		*spi;
> +	struct regulator		*refin_reg;
> +	struct regmap			*regmap;
> +	struct device			*dev;
> +	struct iio_trigger		*trig;
> +
> +	size_t			adc_active_channels;
> +	struct spi_message	adc_samples_msg;
> +	struct spi_transfer	adc_samples_xfer[AD74413R_CHANNEL_MAX + 1];
> +
> +	/*
> +	 * DMA (thus cache coherency maintenance) requires the
> +	 * transfer buffers to live in their own cache lines.
> +	 */
> +	struct {
> +		u8 rx_buf[AD74413R_FRAME_SIZE * AD74413R_CHANNEL_MAX];
> +		s64 timestamp;
> +	} adc_samples_buf ____cacheline_aligned;
> +
> +	u8	adc_samples_tx_buf[AD74413R_FRAME_SIZE * AD74413R_CHANNEL_MAX];
> +	u8	reg_tx_buf[AD74413R_FRAME_SIZE];
> +	u8	reg_rx_buf[AD74413R_FRAME_SIZE];
> +};
> +
> +#define AD74413R_REG_NOP		0x00
> +
> +#define AD74413R_REG_CH_FUNC_SETUP_X(x)	(0x01 + (x))
> +#define AD74413R_CH_FUNC_SETUP_MASK	GENMASK(3, 0)
> +
> +#define AD74413R_REG_ADC_CONFIG_X(x)		(0x05 + (x))
> +#define AD74413R_ADC_CONFIG_RANGE_MASK		GENMASK(7, 5)
> +#define AD74413R_ADC_CONFIG_REJECTION_MASK	GENMASK(4, 3)
> +#define AD74413R_ADC_RANGE_10V			0b000
> +#define AD74413R_ADC_RANGE_2P5V_EXT_POW		0b001
> +#define AD74413R_ADC_RANGE_2P5V_INT_POW		0b010
> +#define AD74413R_ADC_RANGE_5V_BI_DIR		0b011
> +#define AD74413R_ADC_REJECTION_50_60		0b00
> +#define AD74413R_ADC_REJECTION_NONE		0b01
> +#define AD74413R_ADC_REJECTION_50_60_HART	0b10
> +#define AD74413R_ADC_REJECTION_HART		0b11
> +
> +#define AD74413R_REG_DIN_CONFIG_X(x)	(0x09 + (x))
> +#define AD74413R_DIN_DEBOUNCE_MASK	GENMASK(4, 0)
> +#define AD74413R_DIN_DEBOUNCE_LEN	BIT(5)
> +
> +#define AD74413R_REG_DAC_CODE_X(x)	(0x16 + (x))
> +#define AD74413R_DAC_CODE_MAX		GENMASK(12, 0)
> +#define AD74413R_DAC_VOLTAGE_MAX	11000
> +
> +#define AD74413R_REG_GPO_PAR_DATA		0x0d
> +#define AD74413R_REG_GPO_CONFIG_X(x)		(0x0e + (x))
> +#define AD74413R_GPO_CONFIG_DATA_MASK	BIT(3)
> +#define AD74413R_GPO_CONFIG_SELECT_MASK		GENMASK(2, 0)
> +#define AD74413R_GPO_CONFIG_100K_PULL_DOWN	0b000
> +#define AD74413R_GPO_CONFIG_LOGIC		0b001
> +#define AD74413R_GPO_CONFIG_LOGIC_PARALLEL	0b010
> +#define AD74413R_GPO_CONFIG_COMPARATOR		0b011
> +#define AD74413R_GPO_CONFIG_HIGH_IMPEDANCE	0b100
> +
> +#define AD74413R_REG_ADC_CONV_CTRL	0x23
> +#define AD74413R_CONV_SEQ_MASK		GENMASK(9, 8)
> +#define AD74413R_CONV_SEQ_ON		0b00
> +#define AD74413R_CONV_SEQ_SINGLE	0b01
> +#define AD74413R_CONV_SEQ_CONTINUOUS	0b10
> +#define AD74413R_CONV_SEQ_OFF		0b11
> +#define AD74413R_CH_EN_MASK(x)		BIT(x)
> +
> +#define AD74413R_REG_DIN_COMP_OUT		0x25
> +#define AD74413R_DIN_COMP_OUT_SHIFT_X(x)	x
> +
> +#define AD74413R_REG_ADC_RESULT_X(x)	(0x26 + (x))
> +#define AD74413R_ADC_RESULT_MAX		GENMASK(15, 0)
> +
> +#define AD74413R_REG_READ_SELECT	0x41
> +
> +#define AD74413R_REG_CMD_KEY		0x44
> +#define AD74413R_CMD_KEY_LDAC		0x953a
> +#define AD74413R_CMD_KEY_RESET1		0x15fa
> +#define AD74413R_CMD_KEY_RESET2		0xaf51
> +
> +static const int ad74413r_adc_sampling_rates[] = {
> +	20, 4800,
> +};
> +
> +static const int ad74413r_adc_sampling_rates_hart[] = {
> +	10, 20, 1200, 4800,
> +};
> +
> +static int ad74413r_crc(u8 *buf)
> +{
> +	return crc8(ad74413r_crc8_table, buf, 3, 0);
> +}
> +
> +static void ad74413r_format_reg_write(u8 reg, u16 val, u8 *buf)
> +{
> +	buf[0] = reg;
> +	put_unaligned_be16(val, &buf[1]);
> +	buf[3] = ad74413r_crc(buf);
> +}
> +
> +static int ad74413r_reg_write(void *context, unsigned int reg, unsigned int val)
> +{
> +	struct ad74413r_state *st = context;
> +
> +	ad74413r_format_reg_write(reg, val, st->reg_tx_buf);
> +
> +	return spi_write(st->spi, st->reg_tx_buf, AD74413R_FRAME_SIZE);
> +}
> +
> +static int ad74413r_crc_check(struct ad74413r_state *st, u8 *buf)
> +{
> +	u8 expected_crc = ad74413r_crc(buf);
> +
> +	if (buf[3] != expected_crc) {
> +		dev_err(st->dev, "Bad CRC %02x for %02x%02x%02x\n",
> +			buf[3], buf[0], buf[1], buf[2]);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ad74413r_reg_read(void *context, unsigned int reg, unsigned int *val)
> +{
> +	struct ad74413r_state *st = context;
> +	struct spi_transfer reg_read_xfer[] = {
> +		{
> +			.tx_buf = st->reg_tx_buf,
> +			.len = AD74413R_FRAME_SIZE,
> +			.cs_change = 1,
> +		},
> +		{
> +			.rx_buf = st->reg_rx_buf,
> +			.len = AD74413R_FRAME_SIZE,
> +		},
> +	};
> +	int ret;
> +
> +	ad74413r_format_reg_write(AD74413R_REG_READ_SELECT, reg,
> +				  st->reg_tx_buf);
> +
> +	ret = spi_sync_transfer(st->spi, reg_read_xfer,
> +				ARRAY_SIZE(reg_read_xfer));
> +	if (ret)
> +		return ret;
> +
> +	ret = ad74413r_crc_check(st, st->reg_rx_buf);
> +	if (ret)
> +		return ret;
> +
> +	*val = get_unaligned_be16(&st->reg_rx_buf[1]);
> +
> +	return 0;
> +}
> +
> +const struct regmap_config ad74413r_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 16,
> +	.reg_read = ad74413r_reg_read,
> +	.reg_write = ad74413r_reg_write,
> +};
> +
> +static int ad74413r_set_gpo_config(struct ad74413r_state *st,
> +				   unsigned int offset, u8 mode)
> +{
> +	return regmap_update_bits(st->regmap, AD74413R_REG_GPO_CONFIG_X(offset),
> +				  AD74413R_GPO_CONFIG_SELECT_MASK, mode);
> +}
> +
> +static const unsigned int ad74413r_debounce_map[AD74413R_DIN_DEBOUNCE_LEN] = {
> +	0,     13,    18,    24,    32,    42,    56,    75,
> +	100,   130,   180,   240,   320,   420,   560,   750,
> +	1000,  1300,  1800,  2400,  3200,  4200,  5600,  7500,
> +	10000, 13000, 18000, 24000, 32000, 42000, 56000, 75000,
> +};
> +
> +static int ad74413r_set_comp_debounce(struct ad74413r_state *st,
> +				      unsigned int offset,
> +				      unsigned int debounce)
> +{
> +	unsigned int val = AD74413R_DIN_DEBOUNCE_LEN - 1;
> +	unsigned int i;
> +
> +	for (i = 0; i < AD74413R_DIN_DEBOUNCE_LEN; i++)
> +		if (debounce <= ad74413r_debounce_map[i]) {
> +			val = i;
> +			break;
> +		}
> +
> +	return regmap_update_bits(st->regmap,
> +				  AD74413R_REG_DIN_CONFIG_X(offset),
> +				  AD74413R_DIN_DEBOUNCE_MASK,
> +				  val);
> +}
> +
> +static void ad74413r_gpio_set(struct gpio_chip *chip,
> +			      unsigned int offset, int val)
> +{
> +	struct ad74413r_state *st = gpiochip_get_data(chip);
> +	unsigned int real_offset = st->gpo_gpio_offsets[offset];
> +	int ret;
> +
> +	ret = ad74413r_set_gpo_config(st, real_offset,
> +				      AD74413R_GPO_CONFIG_LOGIC);
> +	if (ret)
> +		return;
> +
> +	regmap_update_bits(st->regmap, AD74413R_REG_GPO_CONFIG_X(real_offset),
> +			   AD74413R_GPO_CONFIG_DATA_MASK,
> +			   val ? AD74413R_GPO_CONFIG_DATA_MASK : 0);
> +}
> +
> +static void ad74413r_gpio_set_multiple(struct gpio_chip *chip,
> +				       unsigned long *mask,
> +				       unsigned long *bits)
> +{
> +	struct ad74413r_state *st = gpiochip_get_data(chip);
> +	unsigned long real_mask = 0;
> +	unsigned long real_bits = 0;
> +	unsigned int offset = 0;
> +	int ret;
> +
> +	for_each_set_bit_from(offset, mask, AD74413R_CHANNEL_MAX) {
> +		unsigned int real_offset = st->gpo_gpio_offsets[offset];
> +
> +		ret = ad74413r_set_gpo_config(st, real_offset,
> +			AD74413R_GPO_CONFIG_LOGIC_PARALLEL);
> +		if (ret)
> +			return;
> +
> +		real_mask |= BIT(real_offset);
> +		if (*bits & offset)
> +			real_bits |= BIT(real_offset);
> +	}
> +
> +	regmap_update_bits(st->regmap, AD74413R_REG_GPO_PAR_DATA,
> +			   real_mask, real_bits);
> +}
> +
> +static int ad74413r_gpio_get(struct gpio_chip *chip, unsigned int offset)
> +{
> +	struct ad74413r_state *st = gpiochip_get_data(chip);
> +	unsigned int real_offset = st->comp_gpio_offsets[offset];
> +	unsigned int status;
> +	int ret;
> +
> +	ret = regmap_read(st->regmap, AD74413R_REG_DIN_COMP_OUT, &status);
> +	if (ret)
> +		return ret;
> +
> +	status &= AD74413R_DIN_COMP_OUT_SHIFT_X(real_offset);
> +
> +	return status ? 1 : 0;
> +}
> +
> +static int ad74413r_gpio_get_multiple(struct gpio_chip *chip,
> +				      unsigned long *mask,
> +				      unsigned long *bits)
> +{
> +	struct ad74413r_state *st = gpiochip_get_data(chip);
> +	unsigned int offset = 0;
> +	unsigned int val;
> +	int ret;
> +
> +	ret = regmap_read(st->regmap, AD74413R_REG_DIN_COMP_OUT, &val);
> +	if (ret)
> +		return ret;
> +
> +	for_each_set_bit_from(offset, mask, AD74413R_CHANNEL_MAX) {
> +		unsigned int real_offset = st->comp_gpio_offsets[offset];
> +
> +		if (val & BIT(real_offset))
> +			*bits |= offset;
> +	}
> +
> +	return ret;
> +}
> +
> +static int ad74413r_gpio_get_gpo_direction(struct gpio_chip *chip,
> +					   unsigned int offset)
> +{
> +	return GPIO_LINE_DIRECTION_OUT;
> +}
> +
> +static int ad74413r_gpio_get_comp_direction(struct gpio_chip *chip,
> +					    unsigned int offset)
> +{
> +	return GPIO_LINE_DIRECTION_IN;
> +}
> +
> +static int ad74413r_gpio_set_gpo_config(struct gpio_chip *chip,
> +					unsigned int offset,
> +					unsigned long config)
> +{
> +	struct ad74413r_state *st = gpiochip_get_data(chip);
> +	unsigned int real_offset = st->gpo_gpio_offsets[offset];
> +
> +	switch (pinconf_to_config_param(config)) {
> +	case PIN_CONFIG_BIAS_PULL_DOWN:
> +		return ad74413r_set_gpo_config(st, real_offset,
> +			AD74413R_GPO_CONFIG_100K_PULL_DOWN);
> +	case PIN_CONFIG_BIAS_HIGH_IMPEDANCE:
> +		return ad74413r_set_gpo_config(st, real_offset,
> +			AD74413R_GPO_CONFIG_HIGH_IMPEDANCE);
> +	default:
> +		return -ENOTSUPP;
> +	}
> +}
> +
> +static int ad74413r_gpio_set_comp_config(struct gpio_chip *chip,
> +					 unsigned int offset,
> +					 unsigned long config)
> +{
> +	struct ad74413r_state *st = gpiochip_get_data(chip);
> +	unsigned int real_offset = st->comp_gpio_offsets[offset];
> +
> +	switch (pinconf_to_config_param(config)) {
> +	case PIN_CONFIG_INPUT_DEBOUNCE:
> +		return ad74413r_set_comp_debounce(st, real_offset,
> +			pinconf_to_config_argument(config));
> +	default:
> +		return -ENOTSUPP;
> +	}
> +}
> +
> +static int ad74413r_reset(struct ad74413r_state *st)
> +{
> +	int ret;
> +
> +	ret = regmap_write(st->regmap, AD74413R_REG_CMD_KEY,
> +			   AD74413R_CMD_KEY_RESET1);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_write(st->regmap, AD74413R_REG_CMD_KEY,
> +			    AD74413R_CMD_KEY_RESET2);
> +}
> +
> +static int ad74413r_set_channel_dac_code(struct ad74413r_state *st,
> +					 unsigned int channel, int dac_code)
> +{
> +	struct reg_sequence reg_seq[2] = {
> +		{ AD74413R_REG_DAC_CODE_X(channel), dac_code },
> +		{ AD74413R_REG_CMD_KEY, AD74413R_CMD_KEY_LDAC },
> +	};
> +
> +	return regmap_multi_reg_write(st->regmap, reg_seq, 2);
> +}
> +
> +static int ad74413r_set_channel_function(struct ad74413r_state *st,
> +					 unsigned int channel, u8 func)
> +{
> +	return regmap_update_bits(st->regmap,
> +				  AD74413R_REG_CH_FUNC_SETUP_X(channel),
> +				  AD74413R_CH_FUNC_SETUP_MASK, func);
> +}
> +
> +static int ad74413r_set_adc_conv_seq(struct ad74413r_state *st,
> +				     unsigned int status)
> +{
> +	int ret;
> +
> +	/*
> +	 * These bits do not clear when a conversion completes.
> +	 * To enable a subsequent conversion, repeat the write.
> +	 */
> +	ret = regmap_write_bits(st->regmap, AD74413R_REG_ADC_CONV_CTRL,
> +				AD74413R_CONV_SEQ_MASK,
> +				FIELD_PREP(AD74413R_CONV_SEQ_MASK, status));
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Wait 100us before starting conversions.
> +	 */
> +	usleep_range(100, 120);
> +
> +	return 0;
> +}
> +
> +static int ad74413r_set_adc_channel_enable(struct ad74413r_state *st,
> +					   unsigned int channel,
> +					   bool status)
> +{
> +	return regmap_update_bits(st->regmap, AD74413R_REG_ADC_CONV_CTRL,
> +				  AD74413R_CH_EN_MASK(channel),
> +				  status ? AD74413R_CH_EN_MASK(channel) : 0);
> +}
> +
> +static int ad74413r_get_adc_range(struct ad74413r_state *st,
> +				  unsigned int channel,
> +				  unsigned int *val)
> +{
> +	int ret;
> +
> +	ret = regmap_read(st->regmap, AD74413R_REG_ADC_CONFIG_X(channel), val);
> +	if (ret)
> +		return ret;
> +
> +	*val = FIELD_GET(AD74413R_ADC_CONFIG_RANGE_MASK, *val);
> +
> +	return 0;
> +}
> +
> +static int ad74413r_get_adc_rejection(struct ad74413r_state *st,
> +				      unsigned int channel,
> +				      unsigned int *val)
> +{
> +	int ret;
> +
> +	ret = regmap_read(st->regmap, AD74413R_REG_ADC_CONFIG_X(channel), val);
> +	if (ret)
> +		return ret;
> +
> +	*val = FIELD_GET(AD74413R_ADC_CONFIG_REJECTION_MASK, *val);
> +
> +	return 0;
> +}
> +
> +static int ad74413r_set_adc_rejection(struct ad74413r_state *st,
> +				      unsigned int channel,
> +				      unsigned int val)
> +{
> +	return regmap_update_bits(st->regmap,
> +				  AD74413R_REG_ADC_CONFIG_X(channel),
> +				  AD74413R_ADC_CONFIG_REJECTION_MASK,
> +				  FIELD_PREP(AD74413R_ADC_CONFIG_REJECTION_MASK,
> +					     val));
> +}
> +
> +static int ad74413r_rejection_to_rate(struct ad74413r_state *st,
> +				      unsigned int rej, int *val)
> +{
> +	switch (rej) {
> +	case AD74413R_ADC_REJECTION_50_60:
> +		*val = 20;
> +		return 0;
> +	case AD74413R_ADC_REJECTION_NONE:
> +		*val = 4800;
> +		return 0;
> +	case AD74413R_ADC_REJECTION_50_60_HART:
> +		*val = 10;
> +		return 0;
> +	case AD74413R_ADC_REJECTION_HART:
> +		*val = 1200;
> +		return 0;
> +	default:
> +		dev_err(st->dev, "ADC rejection invalid\n");
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad74413r_rate_to_rejection(struct ad74413r_state *st,
> +				      int rate, unsigned int *val)
> +{
> +	switch (rate) {
> +	case 20:
> +		*val = AD74413R_ADC_REJECTION_50_60;
> +		return 0;
> +	case 4800:
> +		*val = AD74413R_ADC_REJECTION_NONE;
> +		return 0;
> +	case 10:
> +		*val = AD74413R_ADC_REJECTION_50_60_HART;
> +		return 0;
> +	case 1200:
> +		*val = AD74413R_ADC_REJECTION_HART;
> +		return 0;
> +	default:
> +		dev_err(st->dev, "ADC rate invalid\n");
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad74413r_range_to_voltage_range(struct ad74413r_state *st,
> +					   unsigned int range, int *val)
> +{
> +	switch (range) {
> +	case AD74413R_ADC_RANGE_10V:
> +		*val = 10000;
> +		return 0;
> +	case AD74413R_ADC_RANGE_2P5V_EXT_POW:
> +	case AD74413R_ADC_RANGE_2P5V_INT_POW:
> +		*val = 2500;
> +		return 0;
> +	case AD74413R_ADC_RANGE_5V_BI_DIR:
> +		*val = 5000;
> +		return 0;
> +	default:
> +		dev_err(st->dev, "ADC range invalid\n");
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad74413r_range_to_voltage_offset(struct ad74413r_state *st,
> +					    unsigned int range, int *val)
> +{
> +	switch (range) {
> +	case AD74413R_ADC_RANGE_10V:
> +	case AD74413R_ADC_RANGE_2P5V_EXT_POW:
> +		*val = 0;
> +		return 0;
> +	case AD74413R_ADC_RANGE_2P5V_INT_POW:
> +	case AD74413R_ADC_RANGE_5V_BI_DIR:
> +		*val = -2500;
> +		return 0;
> +	default:
> +		dev_err(st->dev, "ADC range invalid\n");
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad74413r_range_to_voltage_offset_raw(struct ad74413r_state *st,
> +						unsigned int range, int *val)
> +{
> +	switch (range) {
> +	case AD74413R_ADC_RANGE_10V:
> +	case AD74413R_ADC_RANGE_2P5V_EXT_POW:
> +		*val = 0;
> +		return 0;
> +	case AD74413R_ADC_RANGE_2P5V_INT_POW:
> +		*val = -((int)AD74413R_ADC_RESULT_MAX);
> +		return 0;
> +	case AD74413R_ADC_RANGE_5V_BI_DIR:
> +		*val = -((int)AD74413R_ADC_RESULT_MAX / 2);
> +		return 0;
> +	default:
> +		dev_err(st->dev, "ADC range invalid\n");
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad74413r_get_output_voltage_scale(struct ad74413r_state *st,
> +					     int *val, int *val2)
> +{
> +	*val = AD74413R_DAC_VOLTAGE_MAX;
> +	*val2 = AD74413R_DAC_CODE_MAX;
> +
> +	return IIO_VAL_FRACTIONAL;
> +}
> +
> +static int ad74413r_get_output_current_scale(struct ad74413r_state *st,
> +					     int *val, int *val2)
> +{
> +	*val = regulator_get_voltage(st->refin_reg);
> +	*val2 = st->sense_resistor_ohms * AD74413R_DAC_CODE_MAX * 1000;
> +
> +	return IIO_VAL_FRACTIONAL;
> +}
> +
> +static int ad74413r_get_input_voltage_scale(struct ad74413r_state *st,
> +					    unsigned int channel,
> +					    int *val, int *val2)
> +{
> +	unsigned int range;
> +	int ret;
> +
> +	ret = ad74413r_get_adc_range(st, channel, &range);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad74413r_range_to_voltage_range(st, range, val);
> +	if (ret)
> +		return ret;
> +
> +	*val2 = AD74413R_ADC_RESULT_MAX;
> +
> +	return IIO_VAL_FRACTIONAL;
> +}
> +
> +static int ad74413r_get_input_voltage_offset(struct ad74413r_state *st,
> +					     unsigned int channel, int *val)
> +{
> +	unsigned int range;
> +	int ret;
> +
> +	ret = ad74413r_get_adc_range(st, channel, &range);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad74413r_range_to_voltage_offset_raw(st, range, val);
> +	if (ret)
> +		return ret;
> +
> +	return IIO_VAL_INT;
> +}
> +
> +static int ad74413r_get_input_current_scale(struct ad74413r_state *st,
> +					    unsigned int channel, int *val,
> +					    int *val2)
> +{
> +	unsigned int range;
> +	int ret;
> +
> +	ret = ad74413r_get_adc_range(st, channel, &range);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad74413r_range_to_voltage_range(st, range, val);
> +	if (ret)
> +		return ret;
> +
> +	*val2 = AD74413R_ADC_RESULT_MAX * st->sense_resistor_ohms;
> +
> +	return IIO_VAL_FRACTIONAL;
> +}
> +
> +static int ad74413_get_input_current_offset(struct ad74413r_state *st,
> +					    unsigned int channel, int *val)
> +{
> +	unsigned int range;
> +	int voltage_range;
> +	int voltage_offset;
> +	int ret;
> +
> +	ret = ad74413r_get_adc_range(st, channel, &range);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad74413r_range_to_voltage_range(st, range, &voltage_range);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad74413r_range_to_voltage_offset(st, range, &voltage_offset);
> +	if (ret)
> +		return ret;
> +
> +	*val = voltage_offset * AD74413R_ADC_RESULT_MAX / voltage_range;
> +
> +	return IIO_VAL_INT;
> +}
> +
> +static int ad74413r_get_adc_rate(struct ad74413r_state *st,
> +				 unsigned int channel, int *val)
> +{
> +	unsigned int rejection;
> +	int ret;
> +
> +	ret = ad74413r_get_adc_rejection(st, channel, &rejection);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad74413r_rejection_to_rate(st, rejection, val);
> +	if (ret)
> +		return ret;
> +
> +	return IIO_VAL_INT;
> +}
> +
> +static int ad74413r_set_adc_rate(struct ad74413r_state *st,
> +				 unsigned int channel, int val)
> +{
> +	unsigned int rejection;
> +	int ret;
> +
> +	ret = ad74413r_rate_to_rejection(st, val, &rejection);
> +	if (ret)
> +		return ret;
> +
> +	return ad74413r_set_adc_rejection(st, channel, rejection);
> +}
> +
> +static irqreturn_t ad74413r_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct ad74413r_state *st = iio_priv(indio_dev);
> +	u8 *rx_buf = st->adc_samples_buf.rx_buf;
> +	unsigned int i;
> +	int ret;
> +
> +	ret = spi_sync(st->spi, &st->adc_samples_msg);
> +	if (ret)
> +		goto out;
> +
> +	for (i = 0; i < st->adc_active_channels; i++)
> +		ad74413r_crc_check(st, &rx_buf[i * AD74413R_FRAME_SIZE]);
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, &st->adc_samples_buf,
> +					   iio_get_time_ns(indio_dev));
> +
> +out:
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t ad74413r_adc_data_interrupt(int irq, void *data)
> +{
> +	struct iio_dev *indio_dev = data;
> +	struct ad74413r_state *st = iio_priv(indio_dev);
> +
> +	if (iio_buffer_enabled(indio_dev))
> +		iio_trigger_poll(st->trig);
> +	else
> +		complete(&st->adc_data_completion);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int _ad74413r_get_single_adc_result(struct ad74413r_state *st,
> +					   unsigned int channel, int *val)
> +{
> +	unsigned int uval;
> +	int ret;
> +
> +	reinit_completion(&st->adc_data_completion);
> +
> +	ret = ad74413r_set_adc_channel_enable(st, channel, true);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad74413r_set_adc_conv_seq(st, AD74413R_CONV_SEQ_SINGLE);
> +	if (ret)
> +		return ret;
> +
> +	ret = wait_for_completion_timeout(&st->adc_data_completion,
> +					  msecs_to_jiffies(1000));
> +	if (!ret) {
> +		ret = -ETIMEDOUT;
> +		return ret;
> +	}
> +
> +	ret = regmap_read(st->regmap, AD74413R_REG_ADC_RESULT_X(channel),
> +			  &uval);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad74413r_set_adc_conv_seq(st, AD74413R_CONV_SEQ_OFF);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad74413r_set_adc_channel_enable(st, channel, false);
> +	if (ret)
> +		return ret;
> +
> +	*val = uval;
> +
> +	return IIO_VAL_INT;
> +}
> +
> +static int ad74413r_get_single_adc_result(struct iio_dev *indio_dev,
> +					  unsigned int channel, int *val)
> +{
> +	struct ad74413r_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = iio_device_claim_direct_mode(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&st->lock);
> +	ret = _ad74413r_get_single_adc_result(st, channel, val);
> +	mutex_unlock(&st->lock);
> +
> +	iio_device_release_direct_mode(indio_dev);
> +
> +	return ret;
> +}
> +
> +static void ad74413r_adc_to_resistance_result(int adc_result, int *val)
> +{
> +	if (adc_result == AD74413R_ADC_RESULT_MAX)
> +		adc_result = AD74413R_ADC_RESULT_MAX - 1;
> +
> +	*val = DIV_ROUND_CLOSEST(adc_result * 2100,
> +				 AD74413R_ADC_RESULT_MAX - adc_result);
> +}
> +
> +static int ad74413r_update_scan_mode(struct iio_dev *indio_dev,
> +				     const unsigned long *active_scan_mask)
> +{
> +	struct ad74413r_state *st = iio_priv(indio_dev);
> +	struct spi_transfer *xfer = st->adc_samples_xfer;
> +	u8 *rx_buf = &st->adc_samples_buf.rx_buf[-1 * AD74413R_FRAME_SIZE];
> +	u8 *tx_buf = st->adc_samples_tx_buf;
> +	unsigned int channel;
> +	int ret;
> +
> +	mutex_lock(&st->lock);
> +
> +	spi_message_init(&st->adc_samples_msg);
> +	st->adc_active_channels = 0;
> +
> +	for_each_clear_bit(channel, active_scan_mask, AD74413R_CHANNEL_MAX) {
> +		ret = ad74413r_set_adc_channel_enable(st, channel, false);
> +		if (ret)
> +			goto out;
> +	}
> +
> +	if (*active_scan_mask == 0)
> +		goto out;
> +
> +	/*
> +	 * The read select register is used to select which register's value
> +	 * will be sent by the slave on the next SPI frame.
> +	 *
> +	 * Create an SPI message that, on each step, writes to the read select
> +	 * register to select the ADC result of the next enabled channel, and
> +	 * reads the ADC result of the previous enabled channel.
> +	 *
> +	 * Example:
> +	 * W: [WCH1] [WCH2] [WCH2] [WCH3] [    ]
> +	 * R: [    ] [RCH1] [RCH2] [RCH3] [RCH4]
> +	 */
> +
> +	for_each_set_bit(channel, active_scan_mask, AD74413R_CHANNEL_MAX) {
> +		ret = ad74413r_set_adc_channel_enable(st, channel, true);
> +		if (ret)
> +			goto out;
> +
> +		st->adc_active_channels++;
> +
> +		if (xfer == st->adc_samples_xfer)
> +			xfer->rx_buf = NULL;
> +		else
> +			xfer->rx_buf = rx_buf;
> +
> +		xfer->tx_buf = tx_buf;
> +		xfer->len = AD74413R_FRAME_SIZE;
> +		xfer->cs_change = 1;
> +
> +		ad74413r_format_reg_write(AD74413R_REG_READ_SELECT,
> +					  AD74413R_REG_ADC_RESULT_X(channel),
> +					  tx_buf);
> +
> +		spi_message_add_tail(xfer, &st->adc_samples_msg);
> +
> +		xfer++;
> +		tx_buf += AD74413R_FRAME_SIZE;
> +		rx_buf += AD74413R_FRAME_SIZE;
> +	}
> +
> +	xfer->rx_buf = rx_buf;
> +	xfer->tx_buf = NULL;
> +	xfer->len = AD74413R_FRAME_SIZE;
> +	xfer->cs_change = 0;
> +
> +	spi_message_add_tail(xfer, &st->adc_samples_msg);
> +
> +out:
> +	mutex_unlock(&st->lock);
> +
> +	return ret;
> +}
> +
> +static int ad74413r_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct ad74413r_state *st = iio_priv(indio_dev);
> +
> +	return ad74413r_set_adc_conv_seq(st, AD74413R_CONV_SEQ_CONTINUOUS);
> +}
> +
> +static int ad74413r_buffer_predisable(struct iio_dev *indio_dev)
> +{
> +	struct ad74413r_state *st = iio_priv(indio_dev);
> +
> +	return ad74413r_set_adc_conv_seq(st, AD74413R_CONV_SEQ_OFF);
> +}
> +
> +static int ad74413r_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int *val, int *val2, long info)
> +{
> +	struct ad74413r_state *st = iio_priv(indio_dev);
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			if (chan->output)
> +				return ad74413r_get_output_voltage_scale(st,
> +					val, val2);
> +			else
> +				return ad74413r_get_input_voltage_scale(st,
> +					chan->channel, val, val2);
> +		case IIO_CURRENT:
> +			if (chan->output)
> +				return ad74413r_get_output_current_scale(st,
> +					val, val2);
> +			else
> +				return ad74413r_get_input_current_scale(st,
> +					chan->channel, val, val2);
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_OFFSET:
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			return ad74413r_get_input_voltage_offset(st,
> +				chan->channel, val);
> +		case IIO_CURRENT:
> +			return ad74413_get_input_current_offset(st,
> +				chan->channel, val);
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_RAW:
> +		if (chan->output)
> +			return -EINVAL;
> +
> +		return ad74413r_get_single_adc_result(indio_dev, chan->channel,
> +						      val);
> +	case IIO_CHAN_INFO_PROCESSED: {
> +		int ret;
> +
> +		ret = ad74413r_get_single_adc_result(indio_dev, chan->channel,
> +						     val);
> +		if (ret)
> +			return ret;
> +
> +		ad74413r_adc_to_resistance_result(*val, val);
> +
> +		return ret;
> +	}
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		return ad74413r_get_adc_rate(st, chan->channel, val);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad74413r_write_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      int val, int val2, long info)
> +{
> +	struct ad74413r_state *st = iio_priv(indio_dev);
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (!chan->output)
> +			return -EINVAL;
> +
> +		if (val < 0 || val > AD74413R_DAC_CODE_MAX) {
> +			dev_err(st->dev, "Invalid DAC code\n");
> +			return -EINVAL;
> +		}
> +
> +		return ad74413r_set_channel_dac_code(st, chan->channel, val);
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		return ad74413r_set_adc_rate(st, chan->channel, val);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad74413r_read_avail(struct iio_dev *indio_dev,
> +			       struct iio_chan_spec const *chan,
> +			       const int **vals, int *type, int *length,
> +			       long info)
> +{
> +	struct ad74413r_state *st = iio_priv(indio_dev);
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		if (st->chip_info->hart_support) {
> +			*vals = ad74413r_adc_sampling_rates_hart;
> +			*length = ARRAY_SIZE(ad74413r_adc_sampling_rates_hart);
> +		} else {
> +			*vals = ad74413r_adc_sampling_rates;
> +			*length = ARRAY_SIZE(ad74413r_adc_sampling_rates);
> +		}
> +		*type = IIO_VAL_INT;
> +		return IIO_AVAIL_LIST;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_buffer_setup_ops ad74413r_buffer_ops = {
> +	.postenable = &ad74413r_buffer_postenable,
> +	.predisable = &ad74413r_buffer_predisable,
> +};
> +
> +static const struct iio_trigger_ops ad74413r_trigger_ops = {
> +	.validate_device = iio_trigger_validate_own_device,
> +};
> +
> +static const struct iio_info ad74413r_info = {
> +	.read_raw = &ad74413r_read_raw,
> +	.write_raw = &ad74413r_write_raw,
> +	.read_avail = &ad74413r_read_avail,
> +	.update_scan_mode = &ad74413r_update_scan_mode,
> +};
> +
> +#define AD74413R_DAC_CHANNEL(_type, extra_mask_separate)		\
> +	{								\
> +		.type = (_type),					\
> +		.indexed = 1,						\
> +		.output = 1,						\
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)		\
> +				      | (extra_mask_separate),		\
> +	}
> +
> +#define AD74413R_ADC_CHANNEL(_type, extra_mask_separate)		\
> +	{								\
> +		.type = (_type),					\
> +		.indexed = 1,						\
> +		.output = 0,						\
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)		\
> +				      | BIT(IIO_CHAN_INFO_SAMP_FREQ)	\
> +				      | (extra_mask_separate),		\
> +		.info_mask_separate_available =				\
> +					BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> +		.scan_type = {						\
> +			.sign = 'u',					\
> +			.realbits = 16,					\
> +			.storagebits = 32,				\
> +			.shift = 8,					\
> +			.endianness = IIO_BE,				\
> +		},							\
> +	}
> +
> +#define AD74413R_ADC_VOLTAGE_CHANNEL					\
> +	AD74413R_ADC_CHANNEL(IIO_VOLTAGE, BIT(IIO_CHAN_INFO_SCALE)	\
> +			     | BIT(IIO_CHAN_INFO_OFFSET))
> +
> +#define AD74413R_ADC_CURRENT_CHANNEL					\
> +	AD74413R_ADC_CHANNEL(IIO_CURRENT,  BIT(IIO_CHAN_INFO_SCALE)	\
> +			     | BIT(IIO_CHAN_INFO_OFFSET))
> +
> +static struct iio_chan_spec ad74413r_voltage_output_channels[] = {
> +	AD74413R_DAC_CHANNEL(IIO_VOLTAGE, BIT(IIO_CHAN_INFO_SCALE)),
> +	AD74413R_ADC_CURRENT_CHANNEL,
> +};
> +
> +static struct iio_chan_spec ad74413r_current_output_channels[] = {
> +	AD74413R_DAC_CHANNEL(IIO_CURRENT, BIT(IIO_CHAN_INFO_SCALE)),
> +	AD74413R_ADC_VOLTAGE_CHANNEL,
> +};
> +
> +static struct iio_chan_spec ad74413r_voltage_input_channels[] = {
> +	AD74413R_ADC_VOLTAGE_CHANNEL,
> +};
> +
> +static struct iio_chan_spec ad74413r_current_input_channels[] = {
> +	AD74413R_ADC_CURRENT_CHANNEL,
> +};
> +
> +static struct iio_chan_spec ad74413r_resistance_input_channels[] = {
> +	AD74413R_ADC_CHANNEL(IIO_RESISTANCE, BIT(IIO_CHAN_INFO_PROCESSED)),
> +};
> +
> +static struct iio_chan_spec ad74413r_digital_input_channels[] = {
> +	AD74413R_ADC_VOLTAGE_CHANNEL,
> +};
> +
> +#define _AD74413R_CHANNELS(_channels)			\
> +	{						\
> +		.channels = _channels,			\
> +		.num_channels = ARRAY_SIZE(_channels),	\
> +	}
> +
> +#define AD74413R_CHANNELS(name) \
> +	_AD74413R_CHANNELS(ad74413r_ ## name ## _channels)
> +
> +static const struct ad74413r_channels ad74413r_channels_map[] = {
> +	[CH_FUNC_HIGH_IMPEDANCE] = AD74413R_CHANNELS(voltage_input),
> +	[CH_FUNC_VOLTAGE_OUTPUT] = AD74413R_CHANNELS(voltage_output),
> +	[CH_FUNC_CURRENT_OUTPUT] = AD74413R_CHANNELS(current_output),
> +	[CH_FUNC_VOLTAGE_INPUT] = AD74413R_CHANNELS(voltage_input),
> +	[CH_FUNC_CURRENT_INPUT_EXT_POWER] = AD74413R_CHANNELS(current_input),
> +	[CH_FUNC_CURRENT_INPUT_LOOP_POWER] = AD74413R_CHANNELS(current_input),
> +	[CH_FUNC_RESISTANCE_INPUT] = AD74413R_CHANNELS(resistance_input),
> +	[CH_FUNC_DIGITAL_INPUT_LOGIC] = AD74413R_CHANNELS(digital_input),
> +	[CH_FUNC_DIGITAL_INPUT_LOOP_POWER] = AD74413R_CHANNELS(digital_input),
> +	[CH_FUNC_CURRENT_INPUT_EXT_POWER_HART] = AD74413R_CHANNELS(current_input),
> +	[CH_FUNC_CURRENT_INPUT_LOOP_POWER_HART] = AD74413R_CHANNELS(current_input),
> +};
> +
> +static int ad74413r_parse_channel_config(struct iio_dev *indio_dev,
> +					 struct fwnode_handle *channel_node)
> +{
> +	struct ad74413r_state *st = iio_priv(indio_dev);
> +	struct ad74413r_channel_config *config;
> +	u32 index;
> +	int ret;
> +
> +	ret = fwnode_property_read_u32(channel_node, "reg", &index);
> +	if (ret) {
> +		dev_err(st->dev, "Failed to read channel reg: %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (index > AD74413R_CHANNEL_MAX) {
> +		dev_err(st->dev, "Channel index %u is too large\n", index);
> +		return -EINVAL;
> +	}
> +
> +	config = &st->channel_configs[index];
> +	if (config->initialized) {
> +		dev_err(st->dev, "Channel %u already initialized\n", index);
> +		return -EINVAL;
> +	}
> +
> +	config->func = CH_FUNC_HIGH_IMPEDANCE;
> +	fwnode_property_read_u32(channel_node, "adi,ch-func", &config->func);
> +
> +	if (config->func < CH_FUNC_MIN || config->func > CH_FUNC_MAX) {
> +		dev_err(st->dev, "Invalid channel function %u\n", config->func);
> +		return -EINVAL;
> +	}
> +
> +	if (!st->chip_info->hart_support &&
> +	    (config->func == CH_FUNC_CURRENT_INPUT_EXT_POWER_HART ||
> +	     config->func == CH_FUNC_CURRENT_INPUT_LOOP_POWER_HART)) {
> +		dev_err(st->dev, "Unsupported HART function %u\n", config->func);
> +		return -EINVAL;
> +	}
> +
> +	if (config->func == CH_FUNC_DIGITAL_INPUT_LOGIC ||
> +	    config->func == CH_FUNC_DIGITAL_INPUT_LOOP_POWER)
> +		st->num_comparator_gpios++;
> +
> +	config->gpo_comparator = fwnode_property_read_bool(channel_node,
> +		"adi,gpo-comparator");
> +
> +	if (!config->gpo_comparator)
> +		st->num_gpo_gpios++;
> +
> +	indio_dev->num_channels += ad74413r_channels_map[config->func].num_channels;
> +
> +	config->initialized = true;
> +
> +	return 0;
> +}
> +
> +static int ad74413r_parse_channel_configs(struct iio_dev *indio_dev)
> +{
> +	struct ad74413r_state *st = iio_priv(indio_dev);
> +	struct fwnode_handle *channel_node = NULL;
> +	int ret;
> +
> +	fwnode_for_each_available_child_node(dev_fwnode(st->dev), channel_node) {
> +		ret = ad74413r_parse_channel_config(indio_dev, channel_node);
> +		if (ret)
> +			goto put_channel_node;
> +	}
> +
> +	return 0;
> +
> +put_channel_node:
> +	fwnode_handle_put(channel_node);
> +
> +	return ret;
> +}
> +
> +static int ad74413r_setup_channels(struct iio_dev *indio_dev)
> +{
> +	struct ad74413r_state *st = iio_priv(indio_dev);
> +	struct ad74413r_channel_config *config;
> +	struct iio_chan_spec *channels, *chans;
> +	unsigned int i, num_chans, chan_i;
> +	int ret;
> +
> +	channels = devm_kcalloc(st->dev, sizeof(*channels),
> +				indio_dev->num_channels, GFP_KERNEL);
> +	if (!channels)
> +		return -ENOMEM;
> +
> +	indio_dev->channels = channels;
> +
> +	for (i = 0; i < AD74413R_CHANNEL_MAX; i++) {
> +		config = &st->channel_configs[i];
> +		chans = ad74413r_channels_map[config->func].channels;
> +		num_chans = ad74413r_channels_map[config->func].num_channels;
> +
> +		memcpy(channels, chans, num_chans * sizeof(*chans));
> +
> +		for (chan_i = 0; chan_i < num_chans; chan_i++) {
> +			struct iio_chan_spec *chan = &channels[chan_i];
> +
> +			chan->channel = i;
> +			if (chan->output)
> +				chan->scan_index = -1;
> +			else
> +				chan->scan_index = i;
> +		}
> +
> +		ret = ad74413r_set_channel_function(st, i, config->func);
> +		if (ret)
> +			return ret;
> +
> +		channels += num_chans;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ad74413r_setup_gpios(struct ad74413r_state *st)
> +{
> +	struct ad74413r_channel_config *config;
> +	unsigned int comp_gpio_i = 0;
> +	unsigned int gpo_gpio_i = 0;
> +	unsigned int i;
> +	u8 gpo_config;
> +	int ret;
> +
> +	for (i = 0; i < AD74413R_CHANNEL_MAX; i++) {
> +		config = &st->channel_configs[i];
> +
> +		if (config->gpo_comparator) {
> +			gpo_config = AD74413R_GPO_CONFIG_COMPARATOR;
> +		} else {
> +			gpo_config = AD74413R_GPO_CONFIG_LOGIC;
> +			st->gpo_gpio_offsets[gpo_gpio_i++] = i;
> +		}
> +
> +		if (config->func == CH_FUNC_DIGITAL_INPUT_LOGIC ||
> +		    config->func == CH_FUNC_DIGITAL_INPUT_LOOP_POWER)
> +			st->comp_gpio_offsets[comp_gpio_i++] = i;
> +
> +		ret = ad74413r_set_gpo_config(st, i, gpo_config);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void ad74413r_regulator_disable(void *regulator)
> +{
> +	regulator_disable(regulator);
> +}
> +
> +static int ad74413r_probe(struct spi_device *spi)
> +{
> +	struct ad74413r_state *st;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +
> +	st->spi = spi;
> +	st->dev = &spi->dev;
> +	st->chip_info = device_get_match_data(&spi->dev);
> +	mutex_init(&st->lock);
> +	init_completion(&st->adc_data_completion);
> +
> +	st->regmap = devm_regmap_init(st->dev, NULL, st,
> +				      &ad74413r_regmap_config);
> +	if (IS_ERR(st->regmap))
> +		return PTR_ERR(st->regmap);
> +
> +	st->refin_reg = devm_regulator_get(st->dev, "refin");
> +	if (IS_ERR(st->refin_reg))
> +		return dev_err_probe(st->dev, PTR_ERR(st->refin_reg),
> +				     "Failed to get refin regulator\n");
> +
> +	ret = regulator_enable(st->refin_reg);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(st->dev, ad74413r_regulator_disable,
> +				       st->refin_reg);
> +	if (ret)
> +		return ret;
> +
> +	st->sense_resistor_ohms = 100000000;
> +	device_property_read_u32(st->dev, "shunt-resistor-micro-ohms",
> +				 &st->sense_resistor_ohms);
> +	st->sense_resistor_ohms /= 1000000;
> +
> +	st->trig = devm_iio_trigger_alloc(st->dev, "%s-dev%d",
> +					  st->chip_info->name, iio_device_id(indio_dev));
> +	if (!st->trig)
> +		return -ENOMEM;
> +
> +	st->trig->ops = &ad74413r_trigger_ops;
> +	iio_trigger_set_drvdata(st->trig, st);
> +
> +	ret = devm_iio_trigger_register(st->dev, st->trig);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->name = st->chip_info->name;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &ad74413r_info;
> +	indio_dev->trig = iio_trigger_get(st->trig);
> +
> +	ret = ad74413r_reset(st);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad74413r_parse_channel_configs(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad74413r_setup_channels(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad74413r_setup_gpios(st);
> +	if (ret)
> +		return ret;
> +
> +	if (st->num_gpo_gpios) {
> +		st->gpo_gpiochip.owner = THIS_MODULE;
> +		st->gpo_gpiochip.label = st->chip_info->name;
> +		st->gpo_gpiochip.base = -1;
> +		st->gpo_gpiochip.ngpio = st->num_gpo_gpios;
> +		st->gpo_gpiochip.parent = st->dev;
> +		st->gpo_gpiochip.can_sleep = true;
> +		st->gpo_gpiochip.set = ad74413r_gpio_set;
> +		st->gpo_gpiochip.set_multiple = ad74413r_gpio_set_multiple;
> +		st->gpo_gpiochip.set_config = ad74413r_gpio_set_gpo_config;
> +		st->gpo_gpiochip.get_direction =
> +			ad74413r_gpio_get_gpo_direction;
> +
> +		ret = devm_gpiochip_add_data(st->dev, &st->gpo_gpiochip, st);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (st->num_comparator_gpios) {
> +		st->comp_gpiochip.owner = THIS_MODULE;
> +		st->comp_gpiochip.label = st->chip_info->name;
> +		st->comp_gpiochip.base = -1;
> +		st->comp_gpiochip.ngpio = st->num_comparator_gpios;
> +		st->comp_gpiochip.parent = st->dev;
> +		st->comp_gpiochip.can_sleep = true;
> +		st->comp_gpiochip.get = ad74413r_gpio_get;
> +		st->comp_gpiochip.get_multiple = ad74413r_gpio_get_multiple;
> +		st->comp_gpiochip.set_config = ad74413r_gpio_set_comp_config;
> +		st->comp_gpiochip.get_direction =
> +			ad74413r_gpio_get_comp_direction;
> +
> +		ret = devm_gpiochip_add_data(st->dev, &st->comp_gpiochip, st);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = ad74413r_set_adc_conv_seq(st, AD74413R_CONV_SEQ_OFF);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_request_irq(st->dev, spi->irq, ad74413r_adc_data_interrupt,
> +			       0, st->chip_info->name, indio_dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to request irq\n");
> +
> +	ret = devm_iio_triggered_buffer_setup(st->dev, indio_dev,
> +					      &iio_pollfunc_store_time,
> +					      &ad74413r_trigger_handler,
> +					      &ad74413r_buffer_ops);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(st->dev, indio_dev);
> +}
> +
> +static int ad74413r_unregister_driver(struct spi_driver *spi)
> +{
> +	spi_unregister_driver(spi);
> +
> +	return 0;
> +}
> +
> +static int __init ad74413r_register_driver(struct spi_driver *spi)
> +{
> +	crc8_populate_msb(ad74413r_crc8_table, AD74413R_CRC_POLYNOMIAL);
> +
> +	return spi_register_driver(spi);
> +}
> +
> +static const struct ad74413r_chip_info ad74412r_chip_info_data = {
> +	.hart_support = false,
> +	.name = "ad74412r",
> +};
> +
> +static const struct ad74413r_chip_info ad74413r_chip_info_data = {
> +	.hart_support = true,
> +	.name = "ad74413r",
> +};
> +
> +static const struct of_device_id ad74413r_dt_id[] = {
> +	{
> +		.compatible = "adi,ad74412r",
> +		.data = &ad74412r_chip_info_data,
> +	},
> +	{
> +		.compatible = "adi,ad74413r",
> +		.data = &ad74413r_chip_info_data,
> +	},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, ad74413r_dt_id);
> +
> +static struct spi_driver ad74413r_driver = {
> +	.driver = {
> +		   .name = "ad74413r",
> +		   .of_match_table = ad74413r_dt_id,
> +	},
> +	.probe = ad74413r_probe,
> +};
> +
> +module_driver(ad74413r_driver,
> +	      ad74413r_register_driver,
> +	      ad74413r_unregister_driver);
> +
> +MODULE_AUTHOR("Cosmin Tanislav <cosmin.tanislav@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices AD74413R ADDAC");
> +MODULE_LICENSE("GPL v2");
> 
