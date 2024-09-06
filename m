Return-Path: <linux-iio+bounces-9225-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F3696E6F7
	for <lists+linux-iio@lfdr.de>; Fri,  6 Sep 2024 02:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5915284C5F
	for <lists+linux-iio@lfdr.de>; Fri,  6 Sep 2024 00:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D1917991;
	Fri,  6 Sep 2024 00:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cFVvEoNM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90792171AA
	for <linux-iio@vger.kernel.org>; Fri,  6 Sep 2024 00:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725583816; cv=none; b=SgSGy38oVpetgAVk2+sUkCRil9X0uvV7MwSyuwbPylRKYMAqk45YNbY0i6NYaqhpDe+eKHQCWCLi4Ip73C/votylYQiqcUGNNF1MqaVPjZ/CFZR3PhJO0lhsw+9yha+j64rqFFVvszFkGPAOFXbzemXONTuv5UvdOkT01VkW4f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725583816; c=relaxed/simple;
	bh=o9SHApsTqM2W+Dxkl47OLZ+nR7LTSa7W5lRlGAeV6RQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kyy853jIofQju6pYWdAwjAZr/YxmDAzVnvk7TooVWQikMwTc+rV1m3BW3xSdzljGdHXyh8vNdzIs50PH66GNysqjRcHMhrEwwegPJkEKz/MaKLpRAZ/Z+Sxkv55deleym1pIcXy7yMYFz7j0g2bGcbcLevcS+wWKjHDNdlEPw1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=cFVvEoNM; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-277e6be2ef6so837162fac.0
        for <linux-iio@vger.kernel.org>; Thu, 05 Sep 2024 17:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725583810; x=1726188610; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XaqRNtigIUGT75o1LisoSh18TcIpLTywiuY2ntQIH90=;
        b=cFVvEoNMbJArPkPCCL/OPXE/15dBvIumQDNg+fTY7MIrdyVYXSt6CMdMBRWuk+Ut+h
         ylQaatohVPIg36UFrQDUmrUqSaGlzZfPt6D20D5mBaTgYoIpCX6WAHsRH0A6wj5mJ9xs
         poeffmk+TQnO9/wCQL4BKu9fd8u2rXTxGlUICLDKC+/V5Ke07CSwFsrUVTSNWVsqv8mo
         5p6YqXyhhl9x54XucMlMJ2q3tl0Hpvfv5s9yRzl9RKIGdTaWz5rMPr5z/WbfF0wyrzsu
         ponewX+roawqqBiipP1dXhplP6b6NGqJ8QVoXyJo6ATDRydwPrImlRBcPHV9LbHacTLF
         1Vog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725583810; x=1726188610;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XaqRNtigIUGT75o1LisoSh18TcIpLTywiuY2ntQIH90=;
        b=fk9H4GFp1kxPtbyz8BZMz+FTygQJXnRlDdPAJxdL2EC6LnLRdVcrNV6F7A2ODNFB6Q
         ifp01XqVjpbL/vCe438MfzAgnUULpwJcQTCMjyWpm5LRxalmV5rQDj8O5cWl7B6kuSeN
         th16tLFVMTKs4TkVVF2YJx8Bio+mJp+02AtHMuCFN3T2jeWMPR5h4qbmrbxEfNzID7he
         kVpvWe0Ez1sujAPGC2bOYHKqAen0jntP9iqC0wNoFDAcKpP7b31eU3VooqT5p90hS3iC
         XGZBIThSU2cqt9m5fSxnqqdg8BVVBQOpq25ceYzpoSf1yUEdxlueGlpTCz1g6P87xD61
         D0dg==
X-Forwarded-Encrypted: i=1; AJvYcCVFkF6hAvpU4n114qyjrhk+VPGZ3EyDfnjlYtGI+QsfGZ0ARYk8l95u1+li2mn6MNgaVbCieiKZ9vw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCQ/kBHF2OrhRpGAwjm+RRGYkozF7soyfwUaCQRYbeIIfCG9Vh
	LgUMiV/rZ+KzzLP0Rnx5bgeqJBl21Dv0XHW5dbp0bxghm+85vpb+43xpN/HJv0Y=
X-Google-Smtp-Source: AGHT+IFu03w5wcVkyGKutk4+2qu0x9vEOAkYMIbE6iMZcxiyYh+URgxrwOHfI/Zct60TYNJpKnnZSQ==
X-Received: by 2002:a05:6870:d1c1:b0:277:c69b:4099 with SMTP id 586e51a60fabf-27b82e879ffmr1312466fac.23.1725583810406;
        Thu, 05 Sep 2024 17:50:10 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-277fb91bff9sm2439130fac.35.2024.09.05.17.50.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 17:50:09 -0700 (PDT)
Message-ID: <e9cbcd85-062c-47ad-861c-229cb2fd6c2c@baylibre.com>
Date: Thu, 5 Sep 2024 19:50:09 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] iio: dac: support the ad8460 Waveform DAC
To: Mariel Tinaco <Mariel.Tinaco@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Conor Dooley <conor+dt@kernel.org>,
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
 Dimitri Fedrau <dima.fedrau@gmail.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <noname.nuno@gmail.com>
References: <20240904023040.23352-1-Mariel.Tinaco@analog.com>
 <20240904023040.23352-3-Mariel.Tinaco@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20240904023040.23352-3-Mariel.Tinaco@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/3/24 9:30 PM, Mariel Tinaco wrote:
> The AD8460 is a “bits in, power out” high voltage, high-power,
> high-speed driver optimized for large output current (up to ±1 A)
> and high slew rate (up to ±1800 V/μs) at high voltage (up to ±40 V)
> into capacitive loads.
> 
> A digital engine implements user-configurable features: modes for
> digital input, programmable supply current, and fault monitoring
> and programmable protection settings for output current,
> output voltage, and junction temperature. The AD8460 operates on
> high voltage dual supplies up to ±55 V and a single low voltage
> supply of 5 V.
> 
> Signed-off-by: Mariel Tinaco <Mariel.Tinaco@analog.com>
> ---
>  MAINTAINERS              |   1 +
>  drivers/iio/dac/Kconfig  |  13 +
>  drivers/iio/dac/Makefile |   1 +
>  drivers/iio/dac/ad8460.c | 932 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 947 insertions(+)
>  create mode 100644 drivers/iio/dac/ad8460.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e0509c9f5545..30746a3f0bbd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1326,6 +1326,7 @@ L:	linux-iio@vger.kernel.org
>  S:	Supported
>  W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/iio/dac/adi,ad8460.yaml
> +F:	drivers/iio/dac/ad8460.c
>  
>  ANALOG DEVICES INC AD9739a DRIVER
>  M:	Nuno Sa <nuno.sa@analog.com>
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index 1cfd7e2a622f..fa091995d002 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -301,6 +301,19 @@ config AD7303
>  	  To compile this driver as module choose M here: the module will be called
>  	  ad7303.
>  
> +config AD8460
> +	tristate "Analog Devices AD8460 DAC driver"
> +	depends on SPI
> +	select REGMAP_SPI
> +	select IIO_BUFFER
> +	select IIO_BUFFER_DMAENGINE
> +	help
> +	  Say yes here to build support for Analog Devices AD8460 Digital to
> +	  Analog Converters (DAC).
> +
> +	  To compile this driver as a module choose M here: the module will be called
> +	  ad8460.
> +
>  config AD8801
>  	tristate "Analog Devices AD8801/AD8803 DAC driver"
>  	depends on SPI_MASTER
> diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
> index 2cf148f16306..621d553bd6e3 100644
> --- a/drivers/iio/dac/Makefile
> +++ b/drivers/iio/dac/Makefile
> @@ -28,6 +28,7 @@ obj-$(CONFIG_AD5686_SPI) += ad5686-spi.o
>  obj-$(CONFIG_AD5696_I2C) += ad5696-i2c.o
>  obj-$(CONFIG_AD7293) += ad7293.o
>  obj-$(CONFIG_AD7303) += ad7303.o
> +obj-$(CONFIG_AD8460) += ad8460.o
>  obj-$(CONFIG_AD8801) += ad8801.o
>  obj-$(CONFIG_AD9739A) += ad9739a.o
>  obj-$(CONFIG_ADI_AXI_DAC) += adi-axi-dac.o
> diff --git a/drivers/iio/dac/ad8460.c b/drivers/iio/dac/ad8460.c
> new file mode 100644
> index 000000000000..6428bfaf0bd7
> --- /dev/null
> +++ b/drivers/iio/dac/ad8460.c
> @@ -0,0 +1,932 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * AD8460 Waveform generator DAC Driver
> + *
> + * Copyright (C) 2024 Analog Devices, Inc.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/cleanup.h>
> +#include <linux/clk.h>
> +#include <linux/debugfs.h>
> +#include <linux/delay.h>
> +#include <linux/dmaengine.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/buffer-dma.h>
> +#include <linux/iio/buffer-dmaengine.h>
> +#include <linux/iio/consumer.h>
> +#include <linux/iio/events.h>
> +#include <linux/iio/iio.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +
> +#define AD8460_CTRL_REG(x)                      (x)
> +#define AD8460_HVDAC_DATA_WORD_LOW(x)           (0x60 + (2 * (x)))
> +#define AD8460_HVDAC_DATA_WORD_HIGH(x)          (0x61 + (2 * (x)))

I don't see AD8460_HVDAC_DATA_WORD_HIGH() used anywhere, so we
could remove that and rename AD8460_HVDAC_DATA_WORD_LOW() to
AD8460_HVDAC_DATA_WORD().

> +
> +#define AD8460_HV_RESET_MSK                     BIT(7)
> +#define AD8460_HV_SLEEP_MSK                     BIT(4)
> +#define AD8460_WAVE_GEN_MODE_MSK                BIT(0)
> +
> +#define AD8460_HVDAC_SLEEP_MSK                  BIT(3)
> +
> +#define AD8460_FAULT_ARM_MSK			BIT(7)
> +#define AD8460_FAULT_LIMIT_MSK			GENMASK(6, 0)
> +
> +#define AD8460_APG_MODE_ENABLE_MSK              BIT(5)
> +#define AD8460_PATTERN_DEPTH_MSK                GENMASK(3, 0)
> +
> +#define AD8460_QUIESCENT_CURRENT_MSK		GENMASK(7, 0)
> +
> +#define AD8460_SHUTDOWN_FLAG_MSK                BIT(7)
> +
> +#define AD8460_DATA_BYTE_LOW_MSK                GENMASK(7, 0)
> +#define AD8460_DATA_BYTE_HIGH_MSK               GENMASK(5, 0)
> +#define AD8460_DATA_BYTE_FULL_MSK		GENMASK(13, 0)
> +
> +#define AD8460_DEFAULT_FAULT_PROTECT		0x00
> +#define AD8460_DATA_BYTE_WORD_LENGTH		2
> +#define AD8460_NUM_DATA_WORDS			16
> +#define AD8460_NOMINAL_VOLTAGE_SPAN		80
> +#define	AD8460_MIN_EXT_RESISTOR_OHMS		2000
> +#define	AD8460_MAX_EXT_RESISTOR_OHMS		20000
> +#define AD8460_MIN_VREFIO_UV			120000
> +#define AD8460_MAX_VREFIO_UV			1200000
> +#define AD8460_ABS_MAX_OVERVOLTAGE_UV		55000000
> +#define AD8460_ABS_MAX_OVERCURRENT_UA		1000000
> +#define AD8460_MAX_OVERTEMPERATURE_MC		150000
> +#define AD8460_MIN_OVERTEMPERATURE_MC		20000
> +#define AD8460_CURRENT_LIMIT_CONV(x)		((x) / 15625)
> +#define AD8460_VOLTAGE_LIMIT_CONV(x)		((x) / 1953000)
> +#define AD8460_TEMP_LIMIT_CONV(x)		(((x) + 266640) / 6510)

It looks like there are issues with mixed tabs and spaces in
the macros above that should be cleaned up.

> +
> +enum ad8460_fault_type {
> +	AD8460_OVERCURRENT_SRC,
> +	AD8460_OVERCURRENT_SNK,
> +	AD8460_OVERVOLTAGE_POS,
> +	AD8460_OVERVOLTAGE_NEG,
> +	AD8460_OVERTEMPERATURE,
> +};
> +
> +struct ad8460_state {
> +	struct spi_device *spi;
> +	struct regmap *regmap;
> +	struct iio_channel *tmp_adc_channel;
> +	struct clk *sync_clk;
> +	/* lock to protect against multiple access to the device and shared data */
> +	struct mutex lock;
> +	int refio_1p2v_mv;
> +	u32 ext_resistor_ohms;
> +	/*
> +	 * DMA (thus cache coherency maintenance) requires the
> +	 * transfer buffers to live in their own cache lines.
> +	 */
> +	u8 spi_tx_buf[2] __aligned(IIO_DMA_MINALIGN);

If we make this `__le16 spi_tx_buf` instead of `u8 spi_tx_buf[2]`,
then we don't need the unaligned access functions.

> +};
> +
> +static int ad8460_hv_reset(struct ad8460_state *state)
> +{
> +	int ret;
> +
> +	ret = regmap_update_bits(state->regmap,	AD8460_CTRL_REG(0x00),
> +				 AD8460_HV_RESET_MSK,
> +				 FIELD_PREP(AD8460_HV_RESET_MSK, 1));

Can be simplified with regmap_set_bits().

> +	if (ret)
> +		return ret;
> +
> +	fsleep(20);
> +
> +	return regmap_update_bits(state->regmap, AD8460_CTRL_REG(0x00),
> +				  AD8460_HV_RESET_MSK,
> +				  FIELD_PREP(AD8460_HV_RESET_MSK, 0));

and regmap_clear_bits().

> +}
> +
> +static int ad8460_reset(const struct ad8460_state *state)
> +{
> +	struct device *dev = &state->spi->dev;
> +	struct gpio_desc *reset;
> +
> +	reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
> +	if (IS_ERR(reset))
> +		return dev_err_probe(dev, PTR_ERR(reset),
> +				     "Failed to get reset gpio");
> +	if (reset) {
> +		/* minimum duration of 10ns */
> +		ndelay(10);
> +		gpiod_set_value_cansleep(reset, 1);
> +		return 0;
> +	}
> +
> +	/* bring all registers to their default state */
> +	return regmap_write(state->regmap, AD8460_CTRL_REG(0x03), 1);
> +}
> +
> +static int ad8460_enable_apg_mode(struct ad8460_state *state, int val)
> +{
> +	int ret;
> +
> +	ret = regmap_update_bits(state->regmap, AD8460_CTRL_REG(0x02),
> +				 AD8460_APG_MODE_ENABLE_MSK,
> +				 FIELD_PREP(AD8460_APG_MODE_ENABLE_MSK, val));
> +	if (ret)
> +		return ret;
> +
> +	return regmap_update_bits(state->regmap, AD8460_CTRL_REG(0x00),
> +				  AD8460_WAVE_GEN_MODE_MSK,
> +				  FIELD_PREP(AD8460_WAVE_GEN_MODE_MSK, val));
> +}
> +
> +static int ad8460_read_shutdown_flag(struct ad8460_state *state, u64 *flag)
> +{
> +	int ret, val;
> +
> +	ret = regmap_read(state->regmap, AD8460_CTRL_REG(0x0E), &val);
> +	if (ret)
> +		return ret;
> +
> +	*flag = FIELD_GET(AD8460_SHUTDOWN_FLAG_MSK, val);
> +	return 0;
> +}
> +
> +static int ad8460_get_hvdac_word(struct ad8460_state *state, int index, int *val)
> +{
> +	int ret;
> +
> +	ret = regmap_bulk_read(state->regmap, AD8460_HVDAC_DATA_WORD_LOW(index),
> +			       &state->spi_tx_buf, AD8460_DATA_BYTE_WORD_LENGTH);
> +	if (ret)
> +		return ret;
> +
> +	*val = get_unaligned_le16(state->spi_tx_buf);

With spi_tx_buf changed to __le16, this can use le16_to_cpu()
instead of get_unaligned_le16().

> +
> +	return ret;
> +}
> +
> +static int ad8460_set_hvdac_word(struct ad8460_state *state, int index, int val)
> +{
> +	put_unaligned_le16(FIELD_PREP(AD8460_DATA_BYTE_FULL_MSK, val),
> +				     &state->spi_tx_buf);
> +
> +	return regmap_bulk_write(state->regmap, AD8460_HVDAC_DATA_WORD_LOW(index),
> +				 state->spi_tx_buf, AD8460_DATA_BYTE_WORD_LENGTH);
> +}
> +
> +static ssize_t ad8460_dac_input_read(struct iio_dev *indio_dev, uintptr_t private,
> +				     const struct iio_chan_spec *chan, char *buf)
> +{
> +	struct ad8460_state *state = iio_priv(indio_dev);
> +	unsigned int reg;
> +	int ret;
> +
> +	ret = ad8460_get_hvdac_word(state, private, &reg);
> +	if (ret)
> +		return ret;
> +
> +	return sysfs_emit(buf, "%d\n", reg);

%u instead of %d since reg is unsigned

> +}
> +
> +static ssize_t ad8460_dac_input_write(struct iio_dev *indio_dev, uintptr_t private,
> +				      const struct iio_chan_spec *chan,
> +				      const char *buf, size_t len)
> +{
> +	struct ad8460_state *state = iio_priv(indio_dev);
> +	unsigned int reg;
> +	int ret;
> +
> +	ret = kstrtou32(buf, 10, &reg);
> +	if (ret)
> +		return ret;
> +
> +	guard(mutex)(&state->lock);
> +
> +	return ad8460_set_hvdac_word(state, private, reg);
> +}
> +
> +static ssize_t ad8460_read_symbol(struct iio_dev *indio_dev, uintptr_t private,
> +				  const struct iio_chan_spec *chan, char *buf)
> +{
> +	struct ad8460_state *state = iio_priv(indio_dev);
> +	unsigned int reg;
> +	int ret;
> +
> +	ret = regmap_read(state->regmap, AD8460_CTRL_REG(0x02), &reg);
> +	if (ret)
> +		return ret;
> +
> +	return sysfs_emit(buf, "%ld\n", FIELD_GET(AD8460_PATTERN_DEPTH_MSK, reg));
> +}

I guess FIELD_GET() makes it long? but probalby should be %lu.

> +
> +static ssize_t ad8460_write_symbol(struct iio_dev *indio_dev, uintptr_t private,
> +				   const struct iio_chan_spec *chan,
> +				   const char *buf, size_t len)
> +{
> +	struct ad8460_state *state = iio_priv(indio_dev);
> +	uint16_t sym;
> +	int ret;
> +
> +	ret = kstrtou16(buf, 10, &sym);
> +	if (ret)
> +		return ret;
> +
> +	guard(mutex)(&state->lock);
> +
> +	return regmap_update_bits(state->regmap,
> +				  AD8460_CTRL_REG(0x02),
> +				  AD8460_PATTERN_DEPTH_MSK,
> +				  FIELD_PREP(AD8460_PATTERN_DEPTH_MSK, sym));
> +}
> +
> +static ssize_t ad8460_read_toggle_en(struct iio_dev *indio_dev, uintptr_t private,
> +				     const struct iio_chan_spec *chan, char *buf)
> +{
> +	struct ad8460_state *state = iio_priv(indio_dev);
> +	unsigned int reg;
> +	int ret;
> +
> +	ret = regmap_read(state->regmap, AD8460_CTRL_REG(0x02), &reg);
> +	if (ret)
> +		return ret;
> +
> +	return sysfs_emit(buf, "%ld\n", FIELD_GET(AD8460_APG_MODE_ENABLE_MSK, reg));
> +}
> +
> +static ssize_t ad8460_write_toggle_en(struct iio_dev *indio_dev, uintptr_t private,
> +				      const struct iio_chan_spec *chan,
> +				      const char *buf, size_t len)
> +{
> +	struct ad8460_state *state = iio_priv(indio_dev);
> +	bool toggle_en;
> +	int ret;
> +
> +	ret = kstrtobool(buf, &toggle_en);
> +	if (ret)
> +		return ret;
> +
> +	iio_device_claim_direct_scoped(return -EBUSY, indio_dev)
> +		return ad8460_enable_apg_mode(state, toggle_en);
> +	unreachable();

Hmm... do we need to make an unscoped version of iio_device_claim_direct_scoped()?

> +}
> +
> +static ssize_t ad8460_read_powerdown(struct iio_dev *indio_dev, uintptr_t private,
> +				     const struct iio_chan_spec *chan, char *buf)
> +{
> +	struct ad8460_state *state = iio_priv(indio_dev);
> +	unsigned int reg;
> +	int ret;
> +
> +	ret = regmap_read(state->regmap, AD8460_CTRL_REG(0x01), &reg);
> +	if (ret)
> +		return ret;
> +
> +	return sysfs_emit(buf, "%ld\n", FIELD_GET(AD8460_HVDAC_SLEEP_MSK, reg));
> +}
> +
> +static ssize_t ad8460_write_powerdown(struct iio_dev *indio_dev, uintptr_t private,
> +				      const struct iio_chan_spec *chan,
> +				      const char *buf, size_t len)
> +{
> +	struct ad8460_state *state = iio_priv(indio_dev);
> +	bool pwr_down;
> +	u64 sdn_flag;
> +	int ret;
> +
> +	ret = kstrtobool(buf, &pwr_down);
> +	if (ret)
> +		return ret;
> +
> +	guard(mutex)(&state->lock);
> +
> +	ret = regmap_update_bits(state->regmap, AD8460_CTRL_REG(0x01),
> +				 AD8460_HVDAC_SLEEP_MSK,
> +				 FIELD_PREP(AD8460_HVDAC_SLEEP_MSK, pwr_down));
> +	if (ret)
> +		return ret;
> +
> +	if (!pwr_down) {
> +		ret = ad8460_read_shutdown_flag(state, &sdn_flag);
> +		if (ret)
> +			return ret;
> +
> +		if (sdn_flag) {
> +			ret = ad8460_hv_reset(state);
> +			if (ret)
> +				return ret;
> +		}
> +	}
> +
> +	ret = regmap_update_bits(state->regmap, AD8460_CTRL_REG(0x00),
> +				 AD8460_HV_SLEEP_MSK,
> +				 FIELD_PREP(AD8460_HV_SLEEP_MSK, !pwr_down));
> +	if (ret)
> +		return ret;

Some comments explaining the logic in this function would be helpful.
Without reading the datasheet, it looks like this puts it in powerdown
mode and takes it right back out before returning.

> +
> +	return len;
> +}
> +
> +static const char * const ad8460_powerdown_modes[] = {
> +	"three_state",
> +};
> +
> +static int ad8460_get_powerdown_mode(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan)
> +{
> +	return 0;
> +}
> +
> +static int ad8460_set_powerdown_mode(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     unsigned int type)
> +{
> +	return 0;
> +}
> +
> +static int ad8460_set_sample(struct ad8460_state *state, int val)
> +{
> +	int ret;
> +
> +	ret = ad8460_enable_apg_mode(state, 1);
> +	if (ret)
> +		return ret;
> +
> +	guard(mutex)(&state->lock);
> +	ret = ad8460_set_hvdac_word(state, 0, val);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_update_bits(state->regmap,
> +				  AD8460_CTRL_REG(0x02),
> +				  AD8460_PATTERN_DEPTH_MSK,
> +				  FIELD_PREP(AD8460_PATTERN_DEPTH_MSK, 0));
> +}
> +
> +static int ad8460_set_fault_threshold(struct ad8460_state *state,
> +				      enum ad8460_fault_type fault,
> +				      unsigned int threshold)
> +{
> +	return regmap_update_bits(state->regmap, AD8460_CTRL_REG(0x08 + fault),
> +				  AD8460_FAULT_LIMIT_MSK,
> +				  FIELD_PREP(AD8460_FAULT_LIMIT_MSK, threshold));
> +}
> +
> +static int ad8460_get_fault_threshold(struct ad8460_state *state,
> +				      enum ad8460_fault_type fault,
> +				      unsigned int *threshold)
> +{
> +	unsigned int val;
> +	int ret;
> +
> +	ret = regmap_read(state->regmap, AD8460_CTRL_REG(0x08 + fault), &val);
> +	if (ret)
> +		return ret;
> +
> +	*threshold = FIELD_GET(AD8460_FAULT_LIMIT_MSK, val);
> +
> +	return ret;
> +}
> +
> +static int ad8460_set_fault_threshold_en(struct ad8460_state *state,
> +					 enum ad8460_fault_type fault, bool en)
> +{
> +	return regmap_update_bits(state->regmap, AD8460_CTRL_REG(0x08 + fault),
> +				  AD8460_FAULT_ARM_MSK,
> +				  FIELD_PREP(AD8460_FAULT_ARM_MSK, en));
> +}
> +
> +static int ad8460_get_fault_threshold_en(struct ad8460_state *state,
> +					 enum ad8460_fault_type fault, bool *en)
> +{
> +	unsigned int val;
> +	int ret;
> +
> +	ret = regmap_read(state->regmap, AD8460_CTRL_REG(0x08 + fault), &val);
> +	if (ret)
> +		return ret;
> +
> +	*en = FIELD_GET(AD8460_FAULT_ARM_MSK, val);
> +
> +	return 0;
> +}
> +
> +static int ad8460_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan, int val, int val2,
> +			    long mask)
> +{
> +	struct ad8460_state *state = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			iio_device_claim_direct_scoped(return -EBUSY, indio_dev)
> +				return ad8460_set_sample(state, val);
> +			unreachable();
> +		case IIO_CURRENT:
> +			return regmap_write(state->regmap, AD8460_CTRL_REG(0x04),
> +					    FIELD_PREP(AD8460_QUIESCENT_CURRENT_MSK, val));
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad8460_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
> +			   int *val, int *val2, long mask)
> +{
> +	struct ad8460_state *state = iio_priv(indio_dev);
> +	int data, ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			scoped_guard(mutex, &state->lock) {
> +				ret = ad8460_get_hvdac_word(state, 0, &data);
> +				if (ret)
> +					return ret;
> +			}
> +			*val = data;
> +			return IIO_VAL_INT;
> +		case IIO_CURRENT:
> +			ret = regmap_read(state->regmap, AD8460_CTRL_REG(0x04),
> +					  &data);
> +			if (ret)
> +				return ret;
> +			*val = data;
> +			return IIO_VAL_INT;
> +		case IIO_TEMP:
> +			ret = iio_read_channel_raw(state->tmp_adc_channel, &data);
> +			if (ret)
> +				return ret;
> +			*val = data;
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val = clk_get_rate(state->sync_clk);
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		/*
> +		 * vCONV = vNOMINAL_SPAN * (DAC_CODE / 2**14) - 40V
> +		 * vMAX  = vNOMINAL_SPAN * (2**14 / 2**14) - 40V
> +		 * vMIN  = vNOMINAL_SPAN * (0 / 2**14) - 40V
> +		 * vADJ  = vCONV * (2000 / rSET) * (vREF / 1.2)
> +		 * vSPAN = vADJ_MAX - vADJ_MIN
> +		 * See datasheet page 49, section FULL-SCALE REDUCTION
> +		 */
> +		*val = AD8460_NOMINAL_VOLTAGE_SPAN * 2000 * state->refio_1p2v_mv;
> +		*val2 = state->ext_resistor_ohms * 1200;
> +		return IIO_VAL_FRACTIONAL;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad8460_select_fault_type(int chan_type, enum iio_event_direction dir)
> +{
> +	switch (chan_type) {
> +	case IIO_VOLTAGE:
> +		switch (dir) {
> +		case IIO_EV_DIR_RISING:
> +			return AD8460_OVERVOLTAGE_POS;
> +		case IIO_EV_DIR_FALLING:
> +			return AD8460_OVERVOLTAGE_NEG;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CURRENT:
> +		switch (dir) {
> +		case IIO_EV_DIR_RISING:
> +			return AD8460_OVERCURRENT_SRC;
> +		case IIO_EV_DIR_FALLING:
> +			return AD8460_OVERCURRENT_SNK;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_TEMP:
> +		switch (dir) {
> +		case IIO_EV_DIR_RISING:
> +			return AD8460_OVERTEMPERATURE;
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad8460_write_event_value(struct iio_dev *indio_dev,
> +				    const struct iio_chan_spec *chan,
> +				    enum iio_event_type type,
> +				    enum iio_event_direction dir,
> +				    enum iio_event_info info, int val, int val2)
> +{
> +	struct ad8460_state *state = iio_priv(indio_dev);
> +	unsigned int fault;
> +
> +	if (type != IIO_EV_TYPE_THRESH)
> +		return -EINVAL;
> +
> +	if (info != IIO_EV_INFO_VALUE)
> +		return -EINVAL;
> +
> +	fault = ad8460_select_fault_type(chan->type, dir);
> +	if (fault < 0)
> +		return fault;
> +
> +	return ad8460_set_fault_threshold(state, fault, val);
> +}
> +
> +static int ad8460_read_event_value(struct iio_dev *indio_dev,
> +				   const struct iio_chan_spec *chan,
> +				   enum iio_event_type type,
> +				   enum iio_event_direction dir,
> +				   enum iio_event_info info, int *val, int *val2)
> +{
> +	struct ad8460_state *state = iio_priv(indio_dev);
> +	unsigned int fault;
> +
> +	if (type != IIO_EV_TYPE_THRESH)
> +		return -EINVAL;
> +
> +	if (info != IIO_EV_INFO_VALUE)
> +		return -EINVAL;
> +
> +	fault = ad8460_select_fault_type(chan->type, dir);
> +	if (fault < 0)
> +		return fault;
> +
> +	return ad8460_get_fault_threshold(state, fault, val);
> +}
> +
> +static int ad8460_write_event_config(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir, int val)
> +{
> +	struct ad8460_state *state = iio_priv(indio_dev);
> +	unsigned int fault;
> +
> +	if (type != IIO_EV_TYPE_THRESH)
> +		return -EINVAL;
> +
> +	fault = ad8460_select_fault_type(chan->type, dir);
> +	if (fault < 0)
> +		return fault;
> +
> +	return ad8460_set_fault_threshold_en(state, fault, val);
> +}
> +
> +static int ad8460_read_event_config(struct iio_dev *indio_dev,
> +				    const struct iio_chan_spec *chan,
> +				    enum iio_event_type type,
> +				    enum iio_event_direction dir)
> +{
> +	struct ad8460_state *state = iio_priv(indio_dev);
> +	unsigned int fault;
> +	bool en;
> +	int ret;
> +
> +	if (type != IIO_EV_TYPE_THRESH)
> +		return -EINVAL;
> +
> +	fault = ad8460_select_fault_type(chan->type, dir);
> +	if (fault < 0)
> +		return fault;
> +
> +	ret = ad8460_get_fault_threshold_en(state, fault, &en);
> +	if (ret)
> +		return ret;
> +
> +	return en;
> +}
> +
> +static int ad8460_reg_access(struct iio_dev *indio_dev, unsigned int reg,
> +			     unsigned int writeval, unsigned int *readval)
> +{
> +	struct ad8460_state *state = iio_priv(indio_dev);
> +
> +	if (readval)
> +		return regmap_read(state->regmap, reg, readval);
> +
> +	return regmap_write(state->regmap, reg, writeval);
> +}
> +
> +static int ad8460_buffer_preenable(struct iio_dev *indio_dev)
> +{
> +	struct ad8460_state *state = iio_priv(indio_dev);
> +
> +	return ad8460_enable_apg_mode(state, 0);
> +}
> +
> +static int ad8460_buffer_postdisable(struct iio_dev *indio_dev)
> +{
> +	struct ad8460_state *state = iio_priv(indio_dev);
> +
> +	return ad8460_enable_apg_mode(state, 1);
> +}
> +
> +static const struct iio_buffer_setup_ops ad8460_buffer_setup_ops = {
> +	.preenable = &ad8460_buffer_preenable,
> +	.postdisable = &ad8460_buffer_postdisable,
> +};
> +
> +static const struct iio_info ad8460_info = {
> +	.read_raw = &ad8460_read_raw,
> +	.write_raw = &ad8460_write_raw,
> +	.write_event_value = &ad8460_write_event_value,
> +	.read_event_value = &ad8460_read_event_value,
> +	.write_event_config = &ad8460_write_event_config,
> +	.read_event_config = &ad8460_read_event_config,
> +	.debugfs_reg_access = &ad8460_reg_access,
> +};
> +
> +static const struct iio_enum ad8460_powerdown_mode_enum = {
> +	.items = ad8460_powerdown_modes,
> +	.num_items = ARRAY_SIZE(ad8460_powerdown_modes),
> +	.get = ad8460_get_powerdown_mode,
> +	.set = ad8460_set_powerdown_mode,
> +};
> +
> +#define AD8460_CHAN_EXT_INFO(_name, _what, _shared, _read, _write) {	\

Looks like _shared is always IIO_SEPARATE, so we could omit that parameter.

> +	.name = _name,							\
> +	.read = (_read),						\
> +	.write = (_write),						\
> +	.private = (_what),						\
> +	.shared = (_shared),						\
> +}
> +
> +static struct iio_chan_spec_ext_info ad8460_ext_info[] = {
> +	AD8460_CHAN_EXT_INFO("raw0", 0, IIO_SEPARATE, ad8460_dac_input_read,
> +			     ad8460_dac_input_write),
> +	AD8460_CHAN_EXT_INFO("raw1", 1, IIO_SEPARATE, ad8460_dac_input_read,
> +			     ad8460_dac_input_write),
> +	AD8460_CHAN_EXT_INFO("raw2", 2, IIO_SEPARATE, ad8460_dac_input_read,
> +			     ad8460_dac_input_write),
> +	AD8460_CHAN_EXT_INFO("raw3", 3, IIO_SEPARATE, ad8460_dac_input_read,
> +			     ad8460_dac_input_write),
> +	AD8460_CHAN_EXT_INFO("raw4", 4, IIO_SEPARATE, ad8460_dac_input_read,
> +			     ad8460_dac_input_write),
> +	AD8460_CHAN_EXT_INFO("raw5", 5, IIO_SEPARATE, ad8460_dac_input_read,
> +			     ad8460_dac_input_write),
> +	AD8460_CHAN_EXT_INFO("raw6", 6, IIO_SEPARATE, ad8460_dac_input_read,
> +			     ad8460_dac_input_write),
> +	AD8460_CHAN_EXT_INFO("raw7", 7, IIO_SEPARATE, ad8460_dac_input_read,
> +			     ad8460_dac_input_write),
> +	AD8460_CHAN_EXT_INFO("raw8", 8, IIO_SEPARATE, ad8460_dac_input_read,
> +			     ad8460_dac_input_write),
> +	AD8460_CHAN_EXT_INFO("raw9", 9, IIO_SEPARATE, ad8460_dac_input_read,
> +			     ad8460_dac_input_write),
> +	AD8460_CHAN_EXT_INFO("raw10", 10, IIO_SEPARATE, ad8460_dac_input_read,
> +			     ad8460_dac_input_write),
> +	AD8460_CHAN_EXT_INFO("raw11", 11, IIO_SEPARATE, ad8460_dac_input_read,
> +			     ad8460_dac_input_write),
> +	AD8460_CHAN_EXT_INFO("raw12", 12, IIO_SEPARATE, ad8460_dac_input_read,
> +			     ad8460_dac_input_write),
> +	AD8460_CHAN_EXT_INFO("raw13", 13, IIO_SEPARATE, ad8460_dac_input_read,
> +			     ad8460_dac_input_write),
> +	AD8460_CHAN_EXT_INFO("raw14", 14, IIO_SEPARATE, ad8460_dac_input_read,
> +			     ad8460_dac_input_write),
> +	AD8460_CHAN_EXT_INFO("raw15", 15, IIO_SEPARATE, ad8460_dac_input_read,
> +			     ad8460_dac_input_write),
> +	AD8460_CHAN_EXT_INFO("toggle_en", 0, IIO_SEPARATE, ad8460_read_toggle_en,
> +			     ad8460_write_toggle_en),
> +	AD8460_CHAN_EXT_INFO("symbol", 0, IIO_SEPARATE, ad8460_read_symbol,
> +			     ad8460_write_symbol),
> +	AD8460_CHAN_EXT_INFO("powerdown", 0, IIO_SEPARATE, ad8460_read_powerdown,
> +			     ad8460_write_powerdown),
> +	IIO_ENUM("powerdown_mode", IIO_SEPARATE, &ad8460_powerdown_mode_enum),
> +	IIO_ENUM_AVAILABLE("powerdown_mode", IIO_SHARED_BY_TYPE,
> +			   &ad8460_powerdown_mode_enum),
> +	{}
> +};
> +
> +static const struct iio_event_spec ad8460_events[] = {
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_RISING,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
> +				 BIT(IIO_EV_INFO_ENABLE),
> +	},
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_FALLING,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
> +				 BIT(IIO_EV_INFO_ENABLE),
> +	},
> +};
> +
> +#define AD8460_VOLTAGE_CHAN {					\
> +	.type = IIO_VOLTAGE,					\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_SAMP_FREQ) |	\
> +			      BIT(IIO_CHAN_INFO_RAW) |		\
> +			      BIT(IIO_CHAN_INFO_SCALE),		\
> +	.output = 1,						\
> +	.indexed = 1,						\
> +	.channel = 0,						\
> +	.scan_index = 0,					\
> +	.scan_type = {						\
> +		.sign = 'u',					\
> +		.realbits = 14,					\
> +		.storagebits = 16,				\
> +		.endianness = IIO_LE,				\

Data is going over DMA, so should this be IIO_CPU?

> +	},                                                      \
> +	.ext_info = ad8460_ext_info,                            \
> +	.event_spec = ad8460_events,				\
> +	.num_event_specs = ARRAY_SIZE(ad8460_events),		\
> +}
> +
> +#define AD8460_CURRENT_CHAN {					\
> +	.type = IIO_CURRENT,					\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +	.output = 0,						\

Since this is writeable, I assume this is an output? (so = 1, not 0)

> +	.indexed = 1,						\
> +	.channel = 0,						\
> +	.scan_index = -1,					\
> +	.event_spec = ad8460_events,				\
> +	.num_event_specs = ARRAY_SIZE(ad8460_events),		\
> +}
> +
> +#define AD8460_TEMP_CHAN {					\
> +	.type = IIO_TEMP,					\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +	.output = 1,						\
> +	.indexed = 1,						\
> +	.channel = 0,						\
> +	.scan_index = -1,					\
> +	.event_spec = ad8460_events,				\
> +	.num_event_specs = 1,					\
> +}
> +
> +static const struct iio_chan_spec ad8460_channels[] = {
> +	AD8460_VOLTAGE_CHAN,
> +	AD8460_CURRENT_CHAN,
> +};
> +
> +static const struct iio_chan_spec ad8460_channels_with_tmp_adc[] = {
> +	AD8460_VOLTAGE_CHAN,
> +	AD8460_CURRENT_CHAN,
> +	AD8460_TEMP_CHAN,
> +};
> +
> +static const struct regmap_config ad8460_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = 0x7F,
> +};
> +
> +static int ad8460_probe(struct spi_device *spi)
> +{
> +	struct ad8460_state *state;
> +	struct iio_dev *indio_dev;
> +	struct device *dev;
> +	u32 tmp[2], temp;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*state));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	state = iio_priv(indio_dev);
> +	mutex_init(&state->lock);
> +
> +	indio_dev->name = "ad8460";
> +	indio_dev->info = &ad8460_info;
> +
> +	state->spi = spi;
> +	dev = &spi->dev;
> +
> +	state->regmap = devm_regmap_init_spi(spi, &ad8460_regmap_config);
> +	if (IS_ERR(state->regmap))
> +		return dev_err_probe(dev, PTR_ERR(state->regmap),
> +				     "Failed to initialize regmap");
> +
> +	state->sync_clk = devm_clk_get_enabled(dev, NULL);
> +	if (IS_ERR(state->sync_clk))
> +		return dev_err_probe(dev, PTR_ERR(state->sync_clk),
> +				     "Failed to get sync clk\n");
> +
> +	state->tmp_adc_channel = devm_iio_channel_get(dev, "ad8460-tmp");

Should we check for specific errors here? For example what if we get
-EPROBE_DEFER? Also, it doesn't like we could ever get NULL, so IS_ERR()
should be sufficient.

> +	if (IS_ERR_OR_NULL(state->tmp_adc_channel)) {
> +		indio_dev->channels = ad8460_channels;
> +		indio_dev->num_channels = ARRAY_SIZE(ad8460_channels);
> +	} else {
> +		indio_dev->channels = ad8460_channels_with_tmp_adc;
> +		indio_dev->num_channels = ARRAY_SIZE(ad8460_channels_with_tmp_adc);
> +	}
> +
> +	ret = devm_regulator_get_enable_read_voltage(dev, "refio_1p2v");
> +	if (ret == -ENODEV)
> +		state->refio_1p2v_mv = 1200;
> +	else if (ret >= 0)
> +		state->refio_1p2v_mv = ret / 1000;
> +	else
> +		return dev_err_probe(dev, ret, "Failed to get reference voltage\n");

The pattern we have been using in other drivers is:

	ret = devm_regulator_get_enable_read_voltage(dev, "refio_1p2v");
	if (ret < 0 && ret != -ENODEV)
		return dev_err_probe(dev, ret, "Failed to get reference voltage\n");

	state->refio_1p2v_mv = ret == -ENODEV ? 1200 : ret / 1000;

It saves a bit of reading.

> +
> +	if (!in_range(state->refio_1p2v_mv, AD8460_MIN_VREFIO_UV,
> +		      AD8460_MAX_VREFIO_UV))

It looks like millivolts is being compared to microvolts here.

> +		return dev_err_probe(dev, -EINVAL,
> +				     "Invalid ref voltage range(%u mV) [%u mV, %u mV]\n",
> +				     state->refio_1p2v_mv,
> +				     AD8460_MIN_VREFIO_UV / 1000,
> +				     AD8460_MAX_VREFIO_UV / 1000);
> +
> +	ret = device_property_read_u32(dev, "adi,external-resistor-ohms",
> +				       &state->ext_resistor_ohms);
> +	if (ret)
> +		state->ext_resistor_ohms = 2000;
> +	else if (!in_range(state->ext_resistor_ohms, AD8460_MIN_EXT_RESISTOR_OHMS,
> +			   AD8460_MAX_EXT_RESISTOR_OHMS))
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Invalid resistor set range(%u) [%u, %u]\n",
> +				     state->ext_resistor_ohms,
> +				     AD8460_MIN_EXT_RESISTOR_OHMS,
> +				     AD8460_MAX_EXT_RESISTOR_OHMS);
> +
> +	/* Arm the device by default */

Comment doesn't match the code.

> +	ret = device_property_read_u32_array(dev, "adi,range-microamp",
> +					     tmp, ARRAY_SIZE(tmp));
> +	if (!ret) {
> +		if (in_range(tmp[1], 0, AD8460_ABS_MAX_OVERCURRENT_UA))
> +			regmap_write(state->regmap, AD8460_CTRL_REG(0x08),
> +				     FIELD_PREP(AD8460_FAULT_ARM_MSK, 1) |
> +				     AD8460_CURRENT_LIMIT_CONV(tmp[1]));
> +
> +		if (in_range(tmp[0], -AD8460_ABS_MAX_OVERCURRENT_UA, 0))
> +			regmap_write(state->regmap, AD8460_CTRL_REG(0x09),
> +				     FIELD_PREP(AD8460_FAULT_ARM_MSK, 1) |
> +				     AD8460_CURRENT_LIMIT_CONV(abs(tmp[0])));
> +	}
> +
> +	ret = device_property_read_u32_array(dev, "adi,range-microvolt",
> +					     tmp, ARRAY_SIZE(tmp));
> +	if (!ret) {
> +		if (in_range(tmp[1], 0, AD8460_ABS_MAX_OVERVOLTAGE_UV))
> +			regmap_write(state->regmap, AD8460_CTRL_REG(0x0A),
> +				     FIELD_PREP(AD8460_FAULT_ARM_MSK, 1) |
> +				     AD8460_VOLTAGE_LIMIT_CONV(tmp[1]));
> +
> +		if (in_range(tmp[0], -AD8460_ABS_MAX_OVERVOLTAGE_UV, 0))
> +			regmap_write(state->regmap, AD8460_CTRL_REG(0x0B),
> +				     FIELD_PREP(AD8460_FAULT_ARM_MSK, 1) |
> +				     AD8460_VOLTAGE_LIMIT_CONV(abs(tmp[0])));
> +	}
> +
> +	ret = device_property_read_u32(dev, "adi,max-millicelsius", &temp);
> +	if (!ret) {
> +		if (in_range(temp, AD8460_MIN_OVERTEMPERATURE_MC,
> +			     AD8460_MAX_OVERTEMPERATURE_MC))
> +			regmap_write(state->regmap, AD8460_CTRL_REG(0x0C),
> +				     FIELD_PREP(AD8460_FAULT_ARM_MSK, 1) |
> +				     AD8460_TEMP_LIMIT_CONV(abs(temp)));
> +	}
> +
> +	ret = ad8460_reset(state);
> +	if (ret)
> +		return ret;
> +
> +	/* Enables DAC by default */
> +	ret = regmap_update_bits(state->regmap, AD8460_CTRL_REG(0x01),
> +				 AD8460_HVDAC_SLEEP_MSK,
> +				 FIELD_PREP(AD8460_HVDAC_SLEEP_MSK, 0));
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->setup_ops = &ad8460_buffer_setup_ops;
> +
> +	ret = devm_iio_dmaengine_buffer_setup_ext(dev, indio_dev, "tx",
> +						  IIO_BUFFER_DIRECTION_OUT);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to get DMA buffer\n");
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static const struct of_device_id ad8460_of_match[] = {
> +	{ .compatible = "adi, ad8460" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ad8460_of_match);
> +
> +static struct spi_driver ad8460_driver = {
> +	.driver = {
> +		.name = "ad8460",
> +		.of_match_table = ad8460_of_match,
> +	},
> +	.probe = ad8460_probe,
> +};
> +module_spi_driver(ad8460_driver);
> +
> +MODULE_AUTHOR("Mariel Tinaco <mariel.tinaco@analog.com");
> +MODULE_DESCRIPTION("AD8460 DAC driver");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(IIO_DMAENGINE_BUFFER);


