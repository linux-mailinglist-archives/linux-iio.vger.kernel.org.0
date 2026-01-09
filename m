Return-Path: <linux-iio+bounces-27578-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C8CD0AF85
	for <lists+linux-iio@lfdr.de>; Fri, 09 Jan 2026 16:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A69B3075AD4
	for <lists+linux-iio@lfdr.de>; Fri,  9 Jan 2026 15:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC56316904;
	Fri,  9 Jan 2026 15:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cF2kPg4x"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C60C306486
	for <linux-iio@vger.kernel.org>; Fri,  9 Jan 2026 15:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767972975; cv=none; b=maOtj6/UzTXii7RC5QGo+1oiyNN7HrSx5F7oGrjBsuC2FHmLgpMzFjEMfXTidjJX8uGPYFlPoXM24Z3HjMqvTi3Yp/bmrbOoRMpq8tXSyubbPZFdYMaMISAMl1hS7hakbkve0329j9rLzkg9mmiFKCl3fZDB9prJM9u4CrihJRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767972975; c=relaxed/simple;
	bh=U1EHzfOo6PsJAs+G6mor2VXThNz5Sny7l+HFPc0DBEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uHtLeyykG0jI+jsy0Z7JN2OXtslFJyJEGTlUUdJsPghiTj1wdDn2tryFuTxe0g/V3I30vi0SbhjnJ2k2obsdQqIivIft8gyvxMEZMnXV+by/iHRzedfxpZ4gxxHRsBy5CK0I3ylVj0p+S567yh9V8y9zB4YmAOA9NSfTyPm8WXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cF2kPg4x; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4327778df7fso2716855f8f.3
        for <linux-iio@vger.kernel.org>; Fri, 09 Jan 2026 07:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767972972; x=1768577772; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FaRmVSUZR1PykRlYvu83BjTFxKy1TokRQZFRM7CXPc4=;
        b=cF2kPg4xOd2eLe75SlZAnzC/q62uJ07fHN6/5DVGPtDu7B6XYtg+KRQzDHst/HVqDH
         pdvFgqxqkK8Ijrs9qI8WiSELnOXhqoyuuNsJmpmL5Yki76aJ5s3m+TMd2LMVK2iS0dLe
         v5NOoyNcuNtz6ur0fZ+mq0AdCBsyRmdS0bgz3lnKH4RBN9rO2nT0ssQz8Bn+H9+f5OWp
         Bu/iyDFIXQ5RFst3Sgn99IpQA4oQblMK81QwZ0JHKiWw3Hbg1nQsn6XDjgxfRqjmHdVq
         ni4OsCU3y52/Q6eRKwbZJOLbzrGwmlFieItgdl1cUiQvw5RBzElhHjibZ0AJcy7NJuG4
         CjGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767972972; x=1768577772;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FaRmVSUZR1PykRlYvu83BjTFxKy1TokRQZFRM7CXPc4=;
        b=Qg5FHbQ7bXuUteEvRKhm6xvalsvrHpXq453tH5/EoCmnFRll1nO+RqDxlGmXFDXrBw
         DesfoqhDJ0FlMcBRvmPNgh/76lmXfOa1HntI6lMP7XAORLrh3ps8SnbG2jhhSdj3eSsR
         VmXTIAV/Y10DWPnNrSPYVH5KxrSDWu4srdKTK9ak/URUwb4wlxhwPlr+zfOJC8DQMtP3
         0j1q9W0czJ2fTMSEYWrSPFk1kuXA/9w+C/RlFOisvRhrDFdRjbm9mNyP2itIrS0l6R9+
         pRaBGYGk/7sLYY1aDGjwjjToEsIv5x/C1rjbM+rCNK7uF7FTyf8/RkfN0Iu3KJLeRODl
         JCxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVb6WHM6FQ9MN6rglMGvMgVkrBSo+2BPpfQm+wQiuhwh6cdUjNeSIVJPOnG+/yCS/8iodKrleUhATs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ28jZpZM0TAHDpJmxEhthC7f/HYd1ZKP2U6rIg0sge+gDS4v3
	qK3e+dk2rJltrSJPGBRBGFRE5ezzFMYDu+AOlLf7dtTJT+uVqZ70K9ruKs208zqYSzNJuw==
X-Gm-Gg: AY/fxX7SY04C4V5mJarBZZQuuxz7UNTXfvPSlFqXp54u/8k0dQsW91V2dXmPfYW+Sc+
	NmQxq8w2SSfu2rL+hYP32rt6eU7dz+sE041l3yzz7TTt9Iac27SuVI4lq/VPrtefTc1kTQ7LXJz
	LmiGVn/TIJaB1aI4lneQcAE9tkOuNl5wqroXmDIRx9tPDKErHRPn7JpR8NnZY+HSwAP4niABohS
	Nnhwsgj9cjFBW9ZfKhhR6cWxSPoJczoklHboDJOogsMogk7boax2UBwoB32NVvf19RtvJQLPpCm
	cyshqCAEzf1gv1B9juDaabVfv2KbBTqL/IHZ88yNnLrOJ1lBzwST0SPwe7qm93cx+moMY5WaMPR
	nMCovWLkBjEiE17+q6rtIRjrA4XkkBG2jUwi/4y3jekHNGy3sb37jH+J5CzxCf4rHIoatkiHIX6
	HAhALg6VFDcMz8fDQ=
X-Google-Smtp-Source: AGHT+IGJC44MxKHtqp+9FLRQZine3KFe8r8N72OmkQFF6HPa8SEa2Jqjiu0Na4juBVZ0oZtNmB2aXQ==
X-Received: by 2002:a05:6000:1ac7:b0:432:5c43:5f with SMTP id ffacd0b85a97d-432c375b612mr13176663f8f.40.1767972971637;
        Fri, 09 Jan 2026 07:36:11 -0800 (PST)
Received: from [172.24.138.145] ([137.71.226.102])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e16d2sm23969126f8f.13.2026.01.09.07.36.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jan 2026 07:36:10 -0800 (PST)
Message-ID: <098d6f0e-95f0-4a25-938b-eee3bb35c77a@gmail.com>
Date: Fri, 9 Jan 2026 16:36:08 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: dac: Add MAX22007 DAC driver support
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
 Janani Sunil <janani.sunil@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Alexandru Ardelean <alexandru.ardelean@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20260108-max22007-dev-v2-0-2506c738784f@analog.com>
 <20260108-max22007-dev-v2-2-2506c738784f@analog.com>
 <aWEMqQed7OXZBLp3@debian-BULLSEYE-live-builder-AMD64>
Content-Language: en-US
From: Janani Sunil <jan.sun97@gmail.com>
In-Reply-To: <aWEMqQed7OXZBLp3@debian-BULLSEYE-live-builder-AMD64>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marcelo,

Thank you for reviewing the patch.

On 1/9/26 15:11, Marcelo Schmitt wrote:
> Overall, this is looking much better than previous versions.
> Here comes another round of review for this.
>
> On 01/08, Janani Sunil wrote:
>> Add support for the MAX22007, a 4-channel 12-bit DAC that drives
>> voltage or current output on each channel.
>>
>> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
>> ---
>>   MAINTAINERS                |   1 +
>>   drivers/iio/dac/Kconfig    |  13 ++
>>   drivers/iio/dac/Makefile   |   1 +
>>   drivers/iio/dac/max22007.c | 507 +++++++++++++++++++++++++++++++++++++++++++++
>>   4 files changed, 522 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index e1addbd21562..99dd3c947629 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1599,6 +1599,7 @@ L:	linux-iio@vger.kernel.org
>>   S:	Supported
>>   W:	https://ez.analog.com/linux-software-drivers
>>   F:	Documentation/devicetree/bindings/iio/dac/adi,max22007.yaml
>> +F:	drivers/iio/dac/max22007.c
>>   
>>   ANALOG DEVICES INC ADA4250 DRIVER
>>   M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
>> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
>> index 7cd3caec1262..4a31993f5b14 100644
>> --- a/drivers/iio/dac/Kconfig
>> +++ b/drivers/iio/dac/Kconfig
>> @@ -482,6 +482,19 @@ config MAX517
>>   	  This driver can also be built as a module.  If so, the module
>>   	  will be called max517.
>>   
>> +config MAX22007
>> +	tristate "Analog Devices MAX22007 DAC Driver"
>> +	depends on SPI
>> +	select REGMAP_SPI
>> +	select CRC8
>> +	help
>> +	  Say Y here if you want to build a driver for Analog Devices MAX22007.
>> +
>> +	  MAX22007 is a quad-channel, 12-bit, voltage-output digital to
>> +	  analog converter (DAC) with SPI interface.
>> +
>> +	  If compiled as a module, it will be called max22007.
>> +
>>   config MAX5522
>>   	tristate "Maxim MAX5522 DAC driver"
>>   	depends on SPI_MASTER
>> diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
>> index e6ac4c67e337..0bbc6d09d22c 100644
>> --- a/drivers/iio/dac/Makefile
>> +++ b/drivers/iio/dac/Makefile
>> @@ -48,6 +48,7 @@ obj-$(CONFIG_LTC2664) += ltc2664.o
>>   obj-$(CONFIG_LTC2688) += ltc2688.o
>>   obj-$(CONFIG_M62332) += m62332.o
>>   obj-$(CONFIG_MAX517) += max517.o
>> +obj-$(CONFIG_MAX22007) += max22007.o
>>   obj-$(CONFIG_MAX5522) += max5522.o
>>   obj-$(CONFIG_MAX5821) += max5821.o
>>   obj-$(CONFIG_MCP4725) += mcp4725.o
>> diff --git a/drivers/iio/dac/max22007.c b/drivers/iio/dac/max22007.c
>> new file mode 100644
>> index 000000000000..19557c008554
>> --- /dev/null
>> +++ b/drivers/iio/dac/max22007.c
>> @@ -0,0 +1,507 @@
> ...
>> +static u8 max22007_crc8_table[256];
> Can use CRC8_TABLE_SIZE to define the table size.

Will take this up.

>
> ...
>> +
>> +static int max22007_spi_read(void *context, const void *reg, size_t reg_size,
>> +			     void *val, size_t val_size)
>> +{
>> +	struct max22007_state *st = context;
>> +	u8 reg_byte = *(u8 *)reg;
> Odd casting. Not sure the const qualifier is needed for the reg parameter.
> See how other IIO drivers implement regmap_bus. ad7091r8 is one I recall from
> the top of my mind.

Noted. Will update this.

>> +	u8 calculated_crc, received_crc;
>> +	u8 crc_data[3];
>> +	u8 rx_buf[4];
>> +	int ret;
>> +
>> +	if (reg_size != 1)
>> +		return -EINVAL;
>> +
>> +	ret = spi_write_then_read(st->spi, &reg_byte, 1, rx_buf,
>> +				  val_size + MAX22007_CRC_OVERHEAD);
>> +	if (ret) {
>> +		dev_err(&st->spi->dev, "SPI transfer failed: %d\n", ret);
>> +		return ret;
>> +	}
> ...
>
>> +static int max22007_read_channel_data(struct max22007_state *state,
>> +				      unsigned int channel, int *data)
>> +{
>> +	int ret;
>> +	unsigned int reg_val;
> nitpicking: why not following reverse xmas tree convection here too?
>
> unsigned int reg_val;
> int ret;

Shall follow this format.

>
>> +
>> +	ret = regmap_read(state->regmap, MAX22007_DAC_CHANNEL_REG(channel), &reg_val);
>> +	if (ret)
>> +		return ret;
>> +
>> +	*data = FIELD_GET(MAX22007_DAC_DATA_MASK, reg_val);
>> +
>> +	return 0;
>> +}
>> +
>> +static int max22007_read_raw(struct iio_dev *indio_dev,
>> +			     struct iio_chan_spec const *chan,
>> +			     int *val, int *val2, long mask)
>> +{
>> +	struct max22007_state *st = iio_priv(indio_dev);
>> +	int ret;
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_RAW:
>> +		ret = max22007_read_channel_data(st, chan->channel, val);
>> +		if (ret)
>> +			return ret;
>> +		return IIO_VAL_INT;
>> +	case IIO_CHAN_INFO_SCALE:
>> +		if (chan->type == IIO_VOLTAGE)
>> +			*val = 5 * 2500;  /* 5 * Vref(2.5V) in mV */
> Interesting that the external reference (if provided) is also expected to be 2.5 V.
> I'd set a define for that, e.g.
> #define MAX22007_REF_mV		2500
> Btw, what is that 5 in '5 * 2500'

Will add a macro for the reference voltage.
5 is the gain coefficient in the output stage (driver).

>
>> +		else
>> +			*val = 25;  /* Vref / (2 * Rsense) = 2500mV / 100 */
>> +		*val2 = 12;  /* 12-bit DAC resolution */
>> +		return IIO_VAL_FRACTIONAL_LOG2;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
> ...
>> +
>> +static int max22007_parse_channel_cfg(struct max22007_state *st, u8 *num_channels)
>> +{
>> +	struct device *dev = &st->spi->dev;
>> +	int ret, num_chan;
>> +	int i = 0;
>> +	u32 reg;
>> +
>> +	num_chan = device_get_child_node_count(dev);
>> +	if (!num_chan)
>> +		return dev_err_probe(dev, -ENODEV, "no channels configured\n");
>> +
>> +	st->iio_chans = devm_kcalloc(dev, num_chan, sizeof(*st->iio_chans), GFP_KERNEL);
>> +	if (!st->iio_chans)
>> +		return -ENOMEM;
>> +
>> +	device_for_each_child_node_scoped(dev, child) {
>> +		u32 ch_func;
>> +		enum max22007_channel_mode mode;
>> +		enum iio_chan_type chan_type;
>> +
>> +		ret = fwnode_property_read_u32(child, "reg", &reg);
>> +		if (ret)
>> +			return dev_err_probe(dev, ret,
>> +					     "failed to read reg property of %pfwP\n", child);
>> +
>> +		if (reg >= MAX22007_NUM_CHANNELS)
>> +			return dev_err_probe(dev, -EINVAL,
>> +					     "reg out of range in %pfwP\n", child);
>> +
>> +		ret = fwnode_property_read_u32(child, "adi,ch-func", &ch_func);
>> +		if (ret)
>> +			return dev_err_probe(dev, ret,
>> +					     "missing adi,ch-func property for %pfwP\n", child);
>> +
>> +		if (ch_func == 1) {
>> +			mode = MAX22007_VOLTAGE_MODE;
>> +			chan_type = IIO_VOLTAGE;
>> +		} else if (ch_func == 2) {
>> +			mode = MAX22007_CURRENT_MODE;
>> +			chan_type = IIO_CURRENT;
>> +		} else {
>> +			return dev_err_probe(dev, -EINVAL,
>> +					     "invalid adi,ch-func %u for %pfwP\n",
>> +					     ch_func, child);
>> +		}
>> +
>> +		st->iio_chans[i++] = (struct iio_chan_spec) {
>> +			.output = 1,
>> +			.indexed = 1,
>> +			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>> +					      BIT(IIO_CHAN_INFO_SCALE),
>> +			.ext_info = max22007_ext_info,
>> +			.channel = reg,
>> +			.type = chan_type,
>> +		};
> IMHO, this would look cleaner with a channel template. See ad7124, ad4130,
> ad4170 for examples.

A channel template approach was followed initially and this approach was taken up based on the latest suggestions from the reviewers, since the template is not being reused elsewhere.

>
>> +
>> +		ret = regmap_update_bits(st->regmap, MAX22007_CHANNEL_MODE_REG,
>> +					 MAX22007_CH_MODE_CH_MASK(reg),
>> +					 MAX22007_CH_MODE_VAL(reg, mode));
>> +		if (ret)
>> +			return ret;
>> +
>> +		/* Set DAC to transparent mode (immediate update) */
>> +		ret = regmap_update_bits(st->regmap, MAX22007_CONFIG_REG,
>> +					 MAX22007_DAC_LATCH_MODE_MASK(reg),
>> +					 MAX22007_DAC_LATCH_MODE_VAL(reg, 1));
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	*num_channels = num_chan;
>> +
>> +	return 0;
>> +}
>> +
> ...
>> +static int max22007_probe(struct spi_device *spi)
>> +{
>> +	struct device *dev = &spi->dev;
>> +	struct iio_dev *indio_dev;
>> +	struct max22007_state *state;
>> +	struct gpio_desc *reset_gpio;
>> +	u8 num_channels;
>> +	int ret, i;
>> +
>> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*state));
>> +	if (!indio_dev)
>> +		return -ENOMEM;
>> +
>> +	state = iio_priv(indio_dev);
>> +	state->spi = spi;
>> +
>> +	crc8_populate_lsb(max22007_crc8_table, MAX22007_CRC8_POLYNOMIAL);
>> +
>> +	state->regmap = devm_regmap_init(dev, &max22007_regmap_bus, state,
>> +					 &max22007_regmap_config);
>> +	if (IS_ERR(state->regmap))
>> +		return dev_err_probe(dev, PTR_ERR(state->regmap),
>> +				     "Failed to initialize regmap\n");
>> +
>> +	for (i = 0; i < MAX22007_NUM_SUPPLIES; i++)
>> +		state->supplies[i].supply = max22007_supply_names[i];
>> +
>> +	ret = devm_regulator_bulk_get(dev, MAX22007_NUM_SUPPLIES, state->supplies);
> devm_regulator_bulk_get_enable(), so max22007_regulator_disable() and
> state->supplies won't be needed anymore.

Will update the same.

>
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "Failed to get regulators\n");
>> +
>> +	ret = regulator_bulk_enable(MAX22007_NUM_SUPPLIES, state->supplies);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "Failed to enable regulators\n");
>> +
>> +	ret = devm_add_action_or_reset(dev, max22007_regulator_disable, state);
>> +	if (ret)
>> +		return ret;
>> +
>> +	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
>> +	if (IS_ERR(reset_gpio))
>> +		return dev_err_probe(dev, PTR_ERR(reset_gpio),
>> +				     "Failed to get reset GPIO\n");
> I'm not against the conventional way we've been getting and using reset
> GPIOs but, if other reviewers request to use the reset framework, you may do so
> with devm_reset_control_get_optional_exclusive_deasserted(dev, NULL).
> See [1] for an example (if needed).
>
> [1]: https://lore.kernel.org/linux-iio/6ae8e203f6fb6e9718271132bd35daef790ab574.1767795849.git.marcelo.schmitt@analog.com/

Sure.

>
>> +
>> +	if (reset_gpio) {
>> +		usleep_range(1000, 5000);
>> +		gpiod_set_value_cansleep(reset_gpio, 1);
>> +		usleep_range(1000, 5000);
>> +	} else {
>> +		ret = regmap_write(state->regmap, MAX22007_SOFT_RESET_REG,
>> +				   MAX22007_SOFT_RESET_BITS_MASK);
>> +		if (ret)
>> +			return ret;
>> +	}


Best Regards,
Janani Sunil


