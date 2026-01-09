Return-Path: <linux-iio+bounces-27576-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 15250D0A926
	for <lists+linux-iio@lfdr.de>; Fri, 09 Jan 2026 15:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B42D302FA36
	for <lists+linux-iio@lfdr.de>; Fri,  9 Jan 2026 14:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE47D35CBD3;
	Fri,  9 Jan 2026 14:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EmQJVEXa"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4DA35BDAF
	for <linux-iio@vger.kernel.org>; Fri,  9 Jan 2026 14:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767967810; cv=none; b=AnAY4NnICQq7AbL+2eRQYot8fk3/TTrnyoZdpgGZr4LNp59l9k9CHFWGR8dbPDfqKpfX+PDMHb8HxPcsIMFknFsnTOAP5CYpx7JfMyCTAsaxdGgESmHjBoPiB1VpVdG0e7Djln3IgOIUYUAAo2UzAiaT65xJCIa/IZyBm3yB8OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767967810; c=relaxed/simple;
	bh=Hy+yasXnUNhtguiDbq187v7kCbWifjVrnvcgnWTZKL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eIMOPpTC+YqsvO9YSL3e+KUKsVUlnCCHowoojhAEm8xW8CwzAoxH/m8Setb83wAZJ3uTOEbNDQEx3jCC/ZTHbHcgD5pn83MSXH/kBpUJXaY9DzKxcBBopOdBnbpKLPiNHfrP4zKKrBobMQtmoaXAyLnvx2SPoNx6bl9g1DMPt2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EmQJVEXa; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-559f4801609so1680077e0c.0
        for <linux-iio@vger.kernel.org>; Fri, 09 Jan 2026 06:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767967808; x=1768572608; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pdMievW5cTjE795MVhoU32pMeNchY3s9seBk5WuF8JM=;
        b=EmQJVEXa3raqUkgwTc3CRNTWCTK/z7c/KDBMnkFwcM6VaTz3WtGZh2s5y1AkH41uE0
         Y50EESi4ORQYfRQVA5StHVp4vVi9g8CDQIfOpKvB5c0H1qDnZEi3wSY+9Oe5sBn/gtYd
         he7FqDjQs4rr9oc3/fCuT7RahYOwyj265Y352lhcj0grO1rCX+TgHoHVxuKmXHNpSpZP
         YxcHC25CQlyDr9o97rMFcGdOoM23lFWVXnlvqTkdOPaGrkimxeSX8UjeKMocAc8oBJ0d
         cu1PRqZnuKsqQ445ygNLN657F4KLyKm0tzi/7yKyJ01KDcZFgfQEX7Bee4EM3ROOcq82
         xFAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767967808; x=1768572608;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pdMievW5cTjE795MVhoU32pMeNchY3s9seBk5WuF8JM=;
        b=Q5vh5t2PfNx6jboKCfdjWQqg0QW0a74cJE45FnsW82WUFzvfoYn9RZdnISIXMNZqNX
         yml9rTKnvsQkVU44g51jUG8SXPCNwtSeNfh8hzoLEgbVrn90mMHpqzDCwtpVOUTg0jtk
         h5t/tPHej3I0zEMqLhPbjJekCPKz7vBbcthpmZ4WDhwmTT3B769MZzfbRvn/1w9I6PP2
         u8+euk92hRmvbcanuGPnWRjcoMX1D4huwmvgHaSMYpNaSCifIbGmI6Ar02NMK0BafHrv
         MQRUHbzQP82rHLXzj0T1wjTQkQkekH0Wd5fbNoPLs7ZSVn2PbD6TZMwWBL8eYhXWuIWV
         CLGw==
X-Forwarded-Encrypted: i=1; AJvYcCVYB0Lglu0IZmDHiJP2VNR8FhXFg+k6dbJWL3MxChKxLtFLPezF8DUYLWO5pAPP7QXxc/uYOjWfSLc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1gWVjiutniNSrZEzT1kklJD0yxNfqDna+/ZwXSmplvKVAWv7F
	vVmO50PMnwsSD7z5hPIpZ1B6pHF9+73OaOUYdY/4q6lG/07h55RjTL3yCivnYCzB
X-Gm-Gg: AY/fxX4ihaPWMRYo1LjxZ25T3w46agor7xHix8x8e1lfvQTkFsPQAeaI/zj7Ggfo6xk
	mtW04XkKAHJZtR5n3SpUuAg61lvI/QBCxBHhnxzOCJtjvCXUv4vY4ubqO7+AnjBWc2SXV9NgdfW
	5xygvy7aiK7Pif46ittLZpmD3EG2ZiTgdqcN6zhywcOlJFk3BuA3ypY9xOWfSTEvI17KOZa3Ykh
	uwZ70SnuZqPf1w+DAIB3DHFZa42ng8Yc0eq+LsfOscI8WF+hfrfm+7cGJlk9+A0zNd+Z1GxlqiQ
	OM+yzPaavGezZEAYMH1hdYz2OOWG4wMYadSKAKCyZUoz4fMDJkWgHT7sLfxbqpsd5KRcERLK2OB
	PLGo0hezdOqn9lOjt9WZJG1vbUS9o24CLDhDtB5mCZ6ckxlEXHE7zwyR4vhoGl7eActANTkEL6C
	nuB7GF0WevvSNIJXicJeM=
X-Google-Smtp-Source: AGHT+IH9zq1TvBObfr8L/l4hxj/+4UEMPMnCDSqayy1ReklUEHwU4khHvPfenItGb/pstkqcKUBuug==
X-Received: by 2002:a05:6122:1d4d:b0:559:7acd:1d3a with SMTP id 71dfb90a1353d-56347d49792mr3349397e0c.2.1767967807664;
        Fri, 09 Jan 2026 06:10:07 -0800 (PST)
Received: from localhost ([2804:30c:2766:a500:b70:8c42:f792:bef6])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5636dc36a20sm644456e0c.13.2026.01.09.06.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 06:10:06 -0800 (PST)
Date: Fri, 9 Jan 2026 11:11:53 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Janani Sunil <janani.sunil@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Alexandru Ardelean <alexandru.ardelean@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, jan.sun97@gmail.com
Subject: Re: [PATCH v2 2/2] iio: dac: Add MAX22007 DAC driver support
Message-ID: <aWEMqQed7OXZBLp3@debian-BULLSEYE-live-builder-AMD64>
References: <20260108-max22007-dev-v2-0-2506c738784f@analog.com>
 <20260108-max22007-dev-v2-2-2506c738784f@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108-max22007-dev-v2-2-2506c738784f@analog.com>

Overall, this is looking much better than previous versions.
Here comes another round of review for this.

On 01/08, Janani Sunil wrote:
> Add support for the MAX22007, a 4-channel 12-bit DAC that drives
> voltage or current output on each channel.
> 
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
> ---
>  MAINTAINERS                |   1 +
>  drivers/iio/dac/Kconfig    |  13 ++
>  drivers/iio/dac/Makefile   |   1 +
>  drivers/iio/dac/max22007.c | 507 +++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 522 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e1addbd21562..99dd3c947629 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1599,6 +1599,7 @@ L:	linux-iio@vger.kernel.org
>  S:	Supported
>  W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/iio/dac/adi,max22007.yaml
> +F:	drivers/iio/dac/max22007.c
>  
>  ANALOG DEVICES INC ADA4250 DRIVER
>  M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index 7cd3caec1262..4a31993f5b14 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -482,6 +482,19 @@ config MAX517
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called max517.
>  
> +config MAX22007
> +	tristate "Analog Devices MAX22007 DAC Driver"
> +	depends on SPI
> +	select REGMAP_SPI
> +	select CRC8
> +	help
> +	  Say Y here if you want to build a driver for Analog Devices MAX22007.
> +
> +	  MAX22007 is a quad-channel, 12-bit, voltage-output digital to
> +	  analog converter (DAC) with SPI interface.
> +
> +	  If compiled as a module, it will be called max22007.
> +
>  config MAX5522
>  	tristate "Maxim MAX5522 DAC driver"
>  	depends on SPI_MASTER
> diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
> index e6ac4c67e337..0bbc6d09d22c 100644
> --- a/drivers/iio/dac/Makefile
> +++ b/drivers/iio/dac/Makefile
> @@ -48,6 +48,7 @@ obj-$(CONFIG_LTC2664) += ltc2664.o
>  obj-$(CONFIG_LTC2688) += ltc2688.o
>  obj-$(CONFIG_M62332) += m62332.o
>  obj-$(CONFIG_MAX517) += max517.o
> +obj-$(CONFIG_MAX22007) += max22007.o
>  obj-$(CONFIG_MAX5522) += max5522.o
>  obj-$(CONFIG_MAX5821) += max5821.o
>  obj-$(CONFIG_MCP4725) += mcp4725.o
> diff --git a/drivers/iio/dac/max22007.c b/drivers/iio/dac/max22007.c
> new file mode 100644
> index 000000000000..19557c008554
> --- /dev/null
> +++ b/drivers/iio/dac/max22007.c
> @@ -0,0 +1,507 @@
...
> +static u8 max22007_crc8_table[256];
Can use CRC8_TABLE_SIZE to define the table size.

...
> +
> +static int max22007_spi_read(void *context, const void *reg, size_t reg_size,
> +			     void *val, size_t val_size)
> +{
> +	struct max22007_state *st = context;
> +	u8 reg_byte = *(u8 *)reg;
Odd casting. Not sure the const qualifier is needed for the reg parameter.
See how other IIO drivers implement regmap_bus. ad7091r8 is one I recall from
the top of my mind.

> +	u8 calculated_crc, received_crc;
> +	u8 crc_data[3];
> +	u8 rx_buf[4];
> +	int ret;
> +
> +	if (reg_size != 1)
> +		return -EINVAL;
> +
> +	ret = spi_write_then_read(st->spi, &reg_byte, 1, rx_buf,
> +				  val_size + MAX22007_CRC_OVERHEAD);
> +	if (ret) {
> +		dev_err(&st->spi->dev, "SPI transfer failed: %d\n", ret);
> +		return ret;
> +	}

...

> +static int max22007_read_channel_data(struct max22007_state *state,
> +				      unsigned int channel, int *data)
> +{
> +	int ret;
> +	unsigned int reg_val;
nitpicking: why not following reverse xmas tree convection here too?

unsigned int reg_val;
int ret;

> +
> +	ret = regmap_read(state->regmap, MAX22007_DAC_CHANNEL_REG(channel), &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	*data = FIELD_GET(MAX22007_DAC_DATA_MASK, reg_val);
> +
> +	return 0;
> +}
> +
> +static int max22007_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int *val, int *val2, long mask)
> +{
> +	struct max22007_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = max22007_read_channel_data(st, chan->channel, val);
> +		if (ret)
> +			return ret;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		if (chan->type == IIO_VOLTAGE)
> +			*val = 5 * 2500;  /* 5 * Vref(2.5V) in mV */
Interesting that the external reference (if provided) is also expected to be 2.5 V.
I'd set a define for that, e.g.
#define MAX22007_REF_mV		2500
Btw, what is that 5 in '5 * 2500'?

> +		else
> +			*val = 25;  /* Vref / (2 * Rsense) = 2500mV / 100 */
> +		*val2 = 12;  /* 12-bit DAC resolution */
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
...
> +
> +static int max22007_parse_channel_cfg(struct max22007_state *st, u8 *num_channels)
> +{
> +	struct device *dev = &st->spi->dev;
> +	int ret, num_chan;
> +	int i = 0;
> +	u32 reg;
> +
> +	num_chan = device_get_child_node_count(dev);
> +	if (!num_chan)
> +		return dev_err_probe(dev, -ENODEV, "no channels configured\n");
> +
> +	st->iio_chans = devm_kcalloc(dev, num_chan, sizeof(*st->iio_chans), GFP_KERNEL);
> +	if (!st->iio_chans)
> +		return -ENOMEM;
> +
> +	device_for_each_child_node_scoped(dev, child) {
> +		u32 ch_func;
> +		enum max22007_channel_mode mode;
> +		enum iio_chan_type chan_type;
> +
> +		ret = fwnode_property_read_u32(child, "reg", &reg);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "failed to read reg property of %pfwP\n", child);
> +
> +		if (reg >= MAX22007_NUM_CHANNELS)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "reg out of range in %pfwP\n", child);
> +
> +		ret = fwnode_property_read_u32(child, "adi,ch-func", &ch_func);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "missing adi,ch-func property for %pfwP\n", child);
> +
> +		if (ch_func == 1) {
> +			mode = MAX22007_VOLTAGE_MODE;
> +			chan_type = IIO_VOLTAGE;
> +		} else if (ch_func == 2) {
> +			mode = MAX22007_CURRENT_MODE;
> +			chan_type = IIO_CURRENT;
> +		} else {
> +			return dev_err_probe(dev, -EINVAL,
> +					     "invalid adi,ch-func %u for %pfwP\n",
> +					     ch_func, child);
> +		}
> +
> +		st->iio_chans[i++] = (struct iio_chan_spec) {
> +			.output = 1,
> +			.indexed = 1,
> +			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +					      BIT(IIO_CHAN_INFO_SCALE),
> +			.ext_info = max22007_ext_info,
> +			.channel = reg,
> +			.type = chan_type,
> +		};
IMHO, this would look cleaner with a channel template. See ad7124, ad4130,
ad4170 for examples.

> +
> +		ret = regmap_update_bits(st->regmap, MAX22007_CHANNEL_MODE_REG,
> +					 MAX22007_CH_MODE_CH_MASK(reg),
> +					 MAX22007_CH_MODE_VAL(reg, mode));
> +		if (ret)
> +			return ret;
> +
> +		/* Set DAC to transparent mode (immediate update) */
> +		ret = regmap_update_bits(st->regmap, MAX22007_CONFIG_REG,
> +					 MAX22007_DAC_LATCH_MODE_MASK(reg),
> +					 MAX22007_DAC_LATCH_MODE_VAL(reg, 1));
> +		if (ret)
> +			return ret;
> +	}
> +
> +	*num_channels = num_chan;
> +
> +	return 0;
> +}
> +
...
> +static int max22007_probe(struct spi_device *spi)
> +{
> +	struct device *dev = &spi->dev;
> +	struct iio_dev *indio_dev;
> +	struct max22007_state *state;
> +	struct gpio_desc *reset_gpio;
> +	u8 num_channels;
> +	int ret, i;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*state));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	state = iio_priv(indio_dev);
> +	state->spi = spi;
> +
> +	crc8_populate_lsb(max22007_crc8_table, MAX22007_CRC8_POLYNOMIAL);
> +
> +	state->regmap = devm_regmap_init(dev, &max22007_regmap_bus, state,
> +					 &max22007_regmap_config);
> +	if (IS_ERR(state->regmap))
> +		return dev_err_probe(dev, PTR_ERR(state->regmap),
> +				     "Failed to initialize regmap\n");
> +
> +	for (i = 0; i < MAX22007_NUM_SUPPLIES; i++)
> +		state->supplies[i].supply = max22007_supply_names[i];
> +
> +	ret = devm_regulator_bulk_get(dev, MAX22007_NUM_SUPPLIES, state->supplies);
devm_regulator_bulk_get_enable(), so max22007_regulator_disable() and
state->supplies won't be needed anymore.

> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get regulators\n");
> +
> +	ret = regulator_bulk_enable(MAX22007_NUM_SUPPLIES, state->supplies);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable regulators\n");
> +
> +	ret = devm_add_action_or_reset(dev, max22007_regulator_disable, state);
> +	if (ret)
> +		return ret;
> +
> +	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
> +	if (IS_ERR(reset_gpio))
> +		return dev_err_probe(dev, PTR_ERR(reset_gpio),
> +				     "Failed to get reset GPIO\n");

I'm not against the conventional way we've been getting and using reset
GPIOs but, if other reviewers request to use the reset framework, you may do so
with devm_reset_control_get_optional_exclusive_deasserted(dev, NULL).
See [1] for an example (if needed).

[1]: https://lore.kernel.org/linux-iio/6ae8e203f6fb6e9718271132bd35daef790ab574.1767795849.git.marcelo.schmitt@analog.com/

> +
> +	if (reset_gpio) {
> +		usleep_range(1000, 5000);
> +		gpiod_set_value_cansleep(reset_gpio, 1);
> +		usleep_range(1000, 5000);
> +	} else {
> +		ret = regmap_write(state->regmap, MAX22007_SOFT_RESET_REG,
> +				   MAX22007_SOFT_RESET_BITS_MASK);
> +		if (ret)
> +			return ret;
> +	}

