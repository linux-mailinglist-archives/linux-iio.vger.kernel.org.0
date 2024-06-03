Return-Path: <linux-iio+bounces-5719-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3918D8AFF
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 22:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0961B269E6
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 20:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F9813B58C;
	Mon,  3 Jun 2024 20:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="S6hwUZEM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DB913B582
	for <linux-iio@vger.kernel.org>; Mon,  3 Jun 2024 20:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717447409; cv=none; b=ej5pxSlLjgVTU4th7ONpg8XnFsmqnfeDs4Qawhl1oMtnOVeam9UYx04bnmUuvz+xIy+Bs3eHJnW7qBEnhthEFTG1dLNOwzdQ5akhgyst9v60WzO4Ul/DHBFrqh0nb0Qayl5UOIzpAUxEU+4yDj1zvzRWTBbLRLBYuKdEfl6TWCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717447409; c=relaxed/simple;
	bh=0kKMtjWtE2NLUgn5gRca7zMLQ/UEvK4f3nRt56UgoDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QFiigiXB2UFCGSQHCLQtY1i0ufIW1AbqH23W8yKpArSYAj0UQRMp2ch5N6UwIDuUm5Ct/MLMfyIoA3FLPyO+l+plyH3HclT3SjhgPXY/bVkOKj5Yh3ged70Yujp6eDWFzlL2Rjc51BT0DfraYWDnvRIPDofnollA/SbNvwbTnfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=S6hwUZEM; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6f9398390fcso20614a34.3
        for <linux-iio@vger.kernel.org>; Mon, 03 Jun 2024 13:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717447405; x=1718052205; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/cwjV50dfR/zkXBozkZUzAkugOcOwLQKaMBlPKq2ouI=;
        b=S6hwUZEM/Gh0ooM+X0rf9u8ozP8yhOUIWAAgNO6MS+ANWik4jP31/cR/TVE+wsGjpq
         cHo4V1nEpWQUf5VckTyFcVmVi553OVHYMdskwGbKWVIObLcBq9ovbrddz1juR8GijaNG
         DxFUBr5xSuVqOpJ/5HFtIF3E5D0JOoU5wtRSjrDQal/axKMzf8/fq9GCtaHIg3qj+zju
         zBVvwq0jonV41KVeG3XrbuH02hWk9VutVnzfhhLwS8GOLx+ryGRU7TSSZJoU+oiNWejY
         MUra7Wl1GuGY+TXcRbdJYOcdm404D2KEHh/0Eww401Z+JnNszxhNMTVgT/i5Dtc16zzb
         I2BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717447405; x=1718052205;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/cwjV50dfR/zkXBozkZUzAkugOcOwLQKaMBlPKq2ouI=;
        b=sUdzwsHwvMO2QIP17qWDjpWy/T87wturxPa1OBlwOMtgVMp/EhtLxPVTxfbH773vGd
         q5zjJY01frVUESSDivz0alxIcgpm1X7jdSZoO9JJlRXzpfjhte3QXXk8EVyW/cwuVRv2
         lOkw4faZx6pqcjMD2w7cSjvGneuuvvBrua2kN8Z81iUJ7kynnzki8gEcXNDtTyNvtJCU
         gN3in9p5WtO5mLjFIE0ALl2Xok0Pm7HS1yo8KpdT6SNzxBfetIPot72Ch4cb3wJNK7SZ
         zEh8xZYjS9pDnWGpudvBu7OS7MkKndhgNx4jUT0U9eZv9onsI5dy9lkMthug4rICzmIH
         IDbA==
X-Forwarded-Encrypted: i=1; AJvYcCWWDFewccgOQ0PCIre9Ma9oPzpLy2eDdNctWaYcFkGMkMkmnenVzszqMGum/ZVWbBGf2xu0QZXhgP3fdkBlVZqTZH0632P0/0gy
X-Gm-Message-State: AOJu0YxAS7SYcH2Ho7+E3tc3XJXCmfybySnLihgOQvLbwgTaI8CpnWBX
	VBuCS9f+4vNb65kgaC1PPhCWyRH/3yfAWLRF6cc5l9bC3q15rtR1CgkfCNdNvtE=
X-Google-Smtp-Source: AGHT+IHSALPvOAUUXJZ7eVIeFJ0jt/IGlwJcN415R8U6StWDf6UdDq42/z4w2pNJ/X+2DA46YtRwzQ==
X-Received: by 2002:a9d:6518:0:b0:6f0:6361:37ba with SMTP id 46e09a7af769-6f911fb9d7amr10185057a34.36.1717447404863;
        Mon, 03 Jun 2024 13:43:24 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f9105238aasm1600457a34.7.2024.06.03.13.43.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 13:43:23 -0700 (PDT)
Message-ID: <408aa030-23df-418d-a04d-a5551119624b@baylibre.com>
Date: Mon, 3 Jun 2024 15:43:23 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] iio: dac: ltc2664: Add driver for LTC2664 and
 LTC2672
To: Kim Seer Paller <kimseer.paller@analog.com>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 kernel test robot <lkp@intel.com>
References: <20240603012200.16589-1-kimseer.paller@analog.com>
 <20240603012200.16589-6-kimseer.paller@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20240603012200.16589-6-kimseer.paller@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/2/24 8:22 PM, Kim Seer Paller wrote:
> LTC2664 4 channel, 16 bit Voltage Output SoftSpan DAC
> LTC2672 5 channel, 16 bit Current Output Softspan DAC
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202405241141.kYcxrSem-lkp@intel.com/
> Co-developed-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> ---
>  MAINTAINERS               |   1 +
>  drivers/iio/dac/Kconfig   |  11 +
>  drivers/iio/dac/Makefile  |   1 +
>  drivers/iio/dac/ltc2664.c | 806 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 819 insertions(+)
>  create mode 100644 drivers/iio/dac/ltc2664.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ac1e29e26f31..1262e1231923 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13071,6 +13071,7 @@ S:	Supported
>  W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml
>  F:	Documentation/devicetree/bindings/iio/dac/adi,ltc2672.yaml
> +F:	drivers/iio/dac/ltc2664.c
>  
>  LTC2688 IIO DAC DRIVER
>  M:	Nuno Sá <nuno.sa@analog.com>
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index 3c2bf620f00f..3d065c157605 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -370,6 +370,17 @@ config LTC2632
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called ltc2632.
>  
> +config LTC2664
> +	tristate "Analog Devices LTC2664 and LTC2672 DAC SPI driver"
> +	depends on SPI
> +	select REGMAP
> +	help
> +	  Say yes here to build support for Analog Devices
> +	  LTC2664 and LTC2672 converters (DAC).
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called ltc2664.
> +
>  config M62332
>  	tristate "Mitsubishi M62332 DAC driver"
>  	depends on I2C
> diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
> index 8432a81a19dc..2cf148f16306 100644
> --- a/drivers/iio/dac/Makefile
> +++ b/drivers/iio/dac/Makefile
> @@ -37,6 +37,7 @@ obj-$(CONFIG_DS4424) += ds4424.o
>  obj-$(CONFIG_LPC18XX_DAC) += lpc18xx_dac.o
>  obj-$(CONFIG_LTC1660) += ltc1660.o
>  obj-$(CONFIG_LTC2632) += ltc2632.o
> +obj-$(CONFIG_LTC2664) += ltc2664.o
>  obj-$(CONFIG_LTC2688) += ltc2688.o
>  obj-$(CONFIG_M62332) += m62332.o
>  obj-$(CONFIG_MAX517) += max517.o
> diff --git a/drivers/iio/dac/ltc2664.c b/drivers/iio/dac/ltc2664.c
> new file mode 100644
> index 000000000000..ef5d7d6fec5a
> --- /dev/null
> +++ b/drivers/iio/dac/ltc2664.c
> @@ -0,0 +1,806 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * LTC2664 4 channel, 16 bit Voltage Output SoftSpan DAC driver
> + * LTC2672 5 channel, 16 bit Current Output Softspan DAC driver
> + *
> + * Copyright 2024 Analog Devices Inc.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/cleanup.h>
> +#include <linux/device.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/mutex.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +
> +#define LTC2664_CMD_WRITE_N(n)		(0x00 + (n))
> +#define LTC2664_CMD_UPDATE_N(n)		(0x10 + (n))
> +#define LTC2664_CMD_WRITE_N_UPDATE_ALL	0x20
> +#define LTC2664_CMD_WRITE_N_UPDATE_N(n)	(0x30 + (n))
> +#define LTC2664_CMD_POWER_DOWN_N(n)	(0x40 + (n))
> +#define LTC2664_CMD_POWER_DOWN_ALL	0x50
> +#define LTC2664_CMD_SPAN_N(n)		(0x60 + (n))
> +#define LTC2664_CMD_CONFIG		0x70
> +#define LTC2664_CMD_MUX			0xB0
> +#define LTC2664_CMD_TOGGLE_SEL		0xC0
> +#define LTC2664_CMD_GLOBAL_TOGGLE	0xD0
> +#define LTC2664_CMD_NO_OPERATION	0xF0
> +#define LTC2664_REF_DISABLE		0x0001
> +#define LTC2664_MSPAN_SOFTSPAN		7
> +
> +#define LTC2672_MAX_CHANNEL		5
> +#define LTC2672_MAX_SPAN		7
> +#define LTC2672_SCALE_MULTIPLIER(n)	(50 * BIT(n))
> +
> +enum ltc2664_ids {
> +	LTC2664,
> +	LTC2672,
> +};
> +
> +enum {
> +	LTC2664_SPAN_RANGE_0V_5V,
> +	LTC2664_SPAN_RANGE_0V_10V,
> +	LTC2664_SPAN_RANGE_M5V_5V,
> +	LTC2664_SPAN_RANGE_M10V_10V,
> +	LTC2664_SPAN_RANGE_M2V5_2V5,
> +};
> +
> +enum {
> +	LTC2664_INPUT_A,
> +	LTC2664_INPUT_B,
> +	LTC2664_INPUT_B_AVAIL,
> +	LTC2664_POWERDOWN,
> +	LTC2664_POWERDOWN_MODE,
> +	LTC2664_TOGGLE_EN,
> +	LTC2664_GLOBAL_TOGGLE,
> +};
> +
> +static const u16 ltc2664_mspan_lut[8][2] = {
> +	{ LTC2664_SPAN_RANGE_M10V_10V, 32768 }, /* MPS2=0, MPS1=0, MSP0=0 (0)*/
> +	{ LTC2664_SPAN_RANGE_M5V_5V, 32768 }, /* MPS2=0, MPS1=0, MSP0=1 (1)*/
> +	{ LTC2664_SPAN_RANGE_M2V5_2V5, 32768 }, /* MPS2=0, MPS1=1, MSP0=0 (2)*/
> +	{ LTC2664_SPAN_RANGE_0V_10V, 0 }, /* MPS2=0, MPS1=1, MSP0=1 (3)*/
> +	{ LTC2664_SPAN_RANGE_0V_10V, 32768 }, /* MPS2=1, MPS1=0, MSP0=0 (4)*/
> +	{ LTC2664_SPAN_RANGE_0V_5V, 0 }, /* MPS2=1, MPS1=0, MSP0=1 (5)*/
> +	{ LTC2664_SPAN_RANGE_0V_5V, 32768 }, /* MPS2=1, MPS1=1, MSP0=0 (6)*/
> +	{ LTC2664_SPAN_RANGE_0V_5V, 0 } /* MPS2=1, MPS1=1, MSP0=1 (7)*/
> +};
> +
> +struct ltc2664_state;
> +
> +struct ltc2664_chip_info {
> +	enum ltc2664_ids id;
> +	const char *name;
> +	int (*scale_get)(const struct ltc2664_state *st, int c);
> +	int (*offset_get)(const struct ltc2664_state *st, int c);
> +	int measurement_type;
> +	unsigned int num_channels;
> +	const struct iio_chan_spec *iio_chan;
> +	const int (*span_helper)[2];
> +	unsigned int num_span;
> +	unsigned int internal_vref;
> +	bool manual_span_support;
> +	bool rfsadj_support;
> +};
> +
> +struct ltc2664_chan {
> +	bool toggle_chan;
> +	bool powerdown;
> +	u8 span;
> +	u16 raw[2]; /* A/B */
> +};

I would find it helpful to have more comments explainging what the various
fields are for. For example, raw to be used to supply data to a SPI xfer
but actually it is just a shadow copy of the current state of the chip
registers.

> +
> +struct ltc2664_state {
> +	struct spi_device *spi;
> +	struct regmap *regmap;
> +	struct ltc2664_chan channels[LTC2672_MAX_CHANNEL];
> +	/* lock to protect against multiple access to the device and shared data */
> +	struct mutex lock;
> +	const struct ltc2664_chip_info *chip_info;
> +	struct iio_chan_spec *iio_channels;
> +	int vref;

	vref_mv

Always nice to have the units since regulators use µV and IIO uses mV.
Otherwise we have to guess.

> +	u32 toggle_sel;
> +	u32 global_toggle;

Should this be bool?

> +	u32 rfsadj;

	rfsadj_ohms

> +};
> +
> +static const int ltc2664_span_helper[][2] = {
> +	{ 0, 5000 },
> +	{ 0, 10000 },
> +	{ -5000, 5000 },
> +	{ -10000, 10000 },
> +	{ -2500, 2500 },
> +};
> +
> +static const int ltc2672_span_helper[][2] = {
> +	{ 0, 3125 },
> +	{ 0, 6250 },
> +	{ 0, 12500 },
> +	{ 0, 25000 },
> +	{ 0, 50000 },
> +	{ 0, 100000 },
> +	{ 0, 200000 },
> +	{ 0, 300000 },
> +};
> +
> +static int ltc2664_scale_get(const struct ltc2664_state *st, int c)
> +{
> +	const struct ltc2664_chan *chan = &st->channels[c];
> +	const int (*span_helper)[2] = st->chip_info->span_helper;
> +	int span, fs;
> +
> +	span = chan->span;
> +	if (span < 0)
> +		return span;
> +
> +	fs = span_helper[span][1] - span_helper[span][0];
> +
> +	return (fs / 2500) * st->vref;

Should we multiply first and then divide? 3125 isn't divisible by 2500
so there may be unwanted rounding otherwise.

> +}
> +
> +static int ltc2672_scale_get(const struct ltc2664_state *st, int c)
> +{
> +	const struct ltc2664_chan *chan = &st->channels[c];
> +	int span, fs;
> +
> +	span = chan->span;
> +	if (span < 0)
> +		return span;
> +
> +	fs = 1000 * st->vref / st->rfsadj;
> +
> +	if (span == LTC2672_MAX_SPAN)
> +		return 4800 * fs;
> +
> +	return LTC2672_SCALE_MULTIPLIER(span) * fs;

Are we losing accuracy by multiplying after dividing here as well?

> +}
> +
> +static int ltc2664_offset_get(const struct ltc2664_state *st, int c)
> +{
> +	const struct ltc2664_chan *chan = &st->channels[c];
> +	int span;
> +
> +	span = chan->span;
> +	if (span < 0)
> +		return span;
> +
> +	if (st->chip_info->span_helper[span][0] < 0)
> +		return -32768;
> +
> +	return 0;
> +}
> +
> +static int ltc2672_offset_get(const struct ltc2664_state *st, int c)
> +{
> +	const struct ltc2664_chan *chan = &st->channels[c];
> +	int span;
> +
> +	span = chan->span;
> +	if (span < 0)
> +		return span;
> +
> +	if (st->chip_info->span_helper[span][1] < 0)

Should this be span_helper[span][0]? [span][1] is always > 0.

And for that matter, [span][0] is always 0 for ltc2672, so
maybe we don't need this check at all?

> +		return -32768;
> +
> +	return st->chip_info->span_helper[span][1] / 250;

Why is this one not return 0 like the other chip?

Figure 24 and 25 in the datasheet don't show an offset in
the tranfer function.

> +}
> +
> +static int ltc2664_dac_code_write(struct ltc2664_state *st, u32 chan, u32 input,
> +				  u16 code)
> +{
> +	struct ltc2664_chan *c = &st->channels[chan];
> +	int ret, reg;
> +
> +	guard(mutex)(&st->lock);
> +	/* select the correct input register to write to */
> +	if (c->toggle_chan) {
> +		ret = regmap_write(st->regmap, LTC2664_CMD_TOGGLE_SEL,
> +				   input << chan);
> +		if (ret)
> +			return ret;
> +	}
> +	/*
> +	 * If in toggle mode the dac should be updated by an
> +	 * external signal (or sw toggle) and not here.
> +	 */
> +	if (st->toggle_sel & BIT(chan))
> +		reg = LTC2664_CMD_WRITE_N(chan);
> +	else
> +		reg = LTC2664_CMD_WRITE_N_UPDATE_N(chan);
> +
> +	ret = regmap_write(st->regmap, reg, code);
> +	if (ret)
> +		return ret;
> +
> +	c->raw[input] = code;
> +
> +	if (c->toggle_chan) {
> +		ret = regmap_write(st->regmap, LTC2664_CMD_TOGGLE_SEL,
> +				   st->toggle_sel);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +static int ltc2664_dac_code_read(struct ltc2664_state *st, u32 chan, u32 input,
> +				 u32 *code)
> +{
> +	guard(mutex)(&st->lock);
> +	*code = st->channels[chan].raw[input];
> +
> +	return 0;
> +}
> +
> +static const int ltc2664_raw_range[] = {0, 1, U16_MAX};
> +
> +static int ltc2664_read_avail(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      const int **vals, int *type, int *length,
> +			      long info)
> +{
> +	switch (info) {
> +	case IIO_CHAN_INFO_RAW:
> +		*vals = ltc2664_raw_range;
> +		*type = IIO_VAL_INT;
> +
> +		return IIO_AVAIL_RANGE;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ltc2664_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan, int *val,
> +			    int *val2, long info)
> +{
> +	struct ltc2664_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = ltc2664_dac_code_read(st, chan->channel,
> +					    LTC2664_INPUT_A, val);
> +		if (ret)
> +			return ret;
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_OFFSET:
> +		*val = st->chip_info->offset_get(st, chan->channel);
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = st->chip_info->scale_get(st, chan->channel);
> +
> +		*val2 = 16;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ltc2664_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan, int val,
> +			     int val2, long info)
> +{
> +	struct ltc2664_state *st = iio_priv(indio_dev);
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (val > U16_MAX || val < 0)
> +			return -EINVAL;
> +
> +		return ltc2664_dac_code_write(st, chan->channel,
> +					      LTC2664_INPUT_A, val);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static ssize_t ltc2664_reg_bool_get(struct iio_dev *indio_dev,
> +				    uintptr_t private,
> +				    const struct iio_chan_spec *chan,
> +				    char *buf)
> +{
> +	struct ltc2664_state *st = iio_priv(indio_dev);
> +	u32 val;
> +
> +	guard(mutex)(&st->lock);
> +	switch (private) {
> +	case LTC2664_POWERDOWN:
> +		val = st->channels[chan->channel].powerdown;
> +
> +		return sysfs_emit(buf, "%u\n", val);
> +	case LTC2664_POWERDOWN_MODE:
> +		return sysfs_emit(buf, "42kohm_to_gnd\n");> +	case LTC2664_TOGGLE_EN:
> +		val = !!(st->toggle_sel & BIT(chan->channel));
> +
> +		return sysfs_emit(buf, "%u\n", val);
> +	case LTC2664_GLOBAL_TOGGLE:
> +		val = st->global_toggle;
> +
> +		return sysfs_emit(buf, "%u\n", val);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static ssize_t ltc2664_reg_bool_set(struct iio_dev *indio_dev,
> +				    uintptr_t private,
> +				    const struct iio_chan_spec *chan,
> +				    const char *buf, size_t len)
> +{
> +	struct ltc2664_state *st = iio_priv(indio_dev);
> +	int ret;
> +	bool en;
> +
> +	ret = kstrtobool(buf, &en);
> +	if (ret)
> +		return ret;
> +
> +	guard(mutex)(&st->lock);
> +	switch (private) {
> +	case LTC2664_POWERDOWN:
> +		ret = regmap_write(st->regmap,
> +				   en ? LTC2664_CMD_POWER_DOWN_N(chan->channel) :
> +				   LTC2664_CMD_UPDATE_N(chan->channel), en);
> +		if (ret)
> +			return ret;
> +
> +		st->channels[chan->channel].powerdown = en;
> +
> +		return len;
> +	case LTC2664_TOGGLE_EN:
> +		if (en)
> +			st->toggle_sel |= BIT(chan->channel);
> +		else
> +			st->toggle_sel &= ~BIT(chan->channel);
> +
> +		ret = regmap_write(st->regmap, LTC2664_CMD_TOGGLE_SEL,
> +				   st->toggle_sel);
> +		if (ret)
> +			return ret;
> +
> +		return len;
> +	case LTC2664_GLOBAL_TOGGLE:
> +		ret = regmap_write(st->regmap, LTC2664_CMD_GLOBAL_TOGGLE, en);
> +		if (ret)
> +			return ret;
> +
> +		st->global_toggle = en;
> +
> +		return len;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static ssize_t ltc2664_dac_input_read(struct iio_dev *indio_dev,
> +				      uintptr_t private,
> +				      const struct iio_chan_spec *chan,
> +				      char *buf)
> +{
> +	struct ltc2664_state *st = iio_priv(indio_dev);
> +	int ret;
> +	u32 val;
> +
> +	if (private == LTC2664_INPUT_B_AVAIL)
> +		return sysfs_emit(buf, "[%u %u %u]\n", ltc2664_raw_range[0],
> +				  ltc2664_raw_range[1],
> +				  ltc2664_raw_range[2] / 4);
> +
> +	ret = ltc2664_dac_code_read(st, chan->channel, private, &val);
> +	if (ret)
> +		return ret;
> +
> +	return sysfs_emit(buf, "%u\n", val);
> +}
> +
> +static ssize_t ltc2664_dac_input_write(struct iio_dev *indio_dev,
> +				       uintptr_t private,
> +				       const struct iio_chan_spec *chan,
> +				       const char *buf, size_t len)
> +{
> +	struct ltc2664_state *st = iio_priv(indio_dev);
> +	int ret;
> +	u16 val;
> +
> +	if (private == LTC2664_INPUT_B_AVAIL)
> +		return -EINVAL;
> +
> +	ret = kstrtou16(buf, 10, &val);
> +	if (ret)
> +		return ret;
> +
> +	ret = ltc2664_dac_code_write(st, chan->channel, private, val);
> +	if (ret)
> +		return ret;
> +
> +	return len;
> +}
> +
> +static int ltc2664_reg_access(struct iio_dev *indio_dev,
> +			      unsigned int reg,
> +			      unsigned int writeval,
> +			      unsigned int *readval)
> +{
> +	struct ltc2664_state *st = iio_priv(indio_dev);
> +
> +	if (readval)
> +		return -EOPNOTSUPP;
> +
> +	return regmap_write(st->regmap, reg, writeval);
> +}
> +
> +#define LTC2664_CHAN_EXT_INFO(_name, _what, _shared, _read, _write) {	\
> +	.name = _name,							\
> +	.read = (_read),						\
> +	.write = (_write),						\
> +	.private = (_what),						\
> +	.shared = (_shared),						\
> +}
> +
> +/*
> + * For toggle mode we only expose the symbol attr (sw_toggle) in case a TGPx is
> + * not provided in dts.
> + */
> +static const struct iio_chan_spec_ext_info ltc2664_toggle_sym_ext_info[] = {
> +	LTC2664_CHAN_EXT_INFO("raw0", LTC2664_INPUT_A, IIO_SEPARATE,
> +			      ltc2664_dac_input_read, ltc2664_dac_input_write),
> +	LTC2664_CHAN_EXT_INFO("raw1", LTC2664_INPUT_B, IIO_SEPARATE,
> +			      ltc2664_dac_input_read, ltc2664_dac_input_write),
> +	LTC2664_CHAN_EXT_INFO("powerdown", LTC2664_POWERDOWN, IIO_SEPARATE,
> +			      ltc2664_reg_bool_get, ltc2664_reg_bool_set),
> +	LTC2664_CHAN_EXT_INFO("powerdown_mode", LTC2664_POWERDOWN_MODE,
> +			      IIO_SEPARATE, ltc2664_reg_bool_get, NULL),
> +	LTC2664_CHAN_EXT_INFO("symbol", LTC2664_GLOBAL_TOGGLE, IIO_SEPARATE,
> +			      ltc2664_reg_bool_get, ltc2664_reg_bool_set),
> +	LTC2664_CHAN_EXT_INFO("toggle_en", LTC2664_TOGGLE_EN,
> +			      IIO_SEPARATE, ltc2664_reg_bool_get,
> +			      ltc2664_reg_bool_set),
> +	{ }
> +};
> +
> +static const struct iio_chan_spec_ext_info ltc2664_ext_info[] = {
> +	LTC2664_CHAN_EXT_INFO("powerdown", LTC2664_POWERDOWN, IIO_SEPARATE,
> +			      ltc2664_reg_bool_get, ltc2664_reg_bool_set),
> +	LTC2664_CHAN_EXT_INFO("powerdown_mode", LTC2664_POWERDOWN_MODE,
> +			      IIO_SEPARATE, ltc2664_reg_bool_get, NULL),
> +	{ }
> +};
> +
> +#define LTC2664_CHANNEL(_chan) {					\
> +	.indexed = 1,							\
> +	.output = 1,							\
> +	.channel = (_chan),						\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_SCALE) |		\
> +		BIT(IIO_CHAN_INFO_OFFSET) | BIT(IIO_CHAN_INFO_RAW),	\
> +	.info_mask_separate_available = BIT(IIO_CHAN_INFO_RAW),		\
> +	.ext_info = ltc2664_ext_info,					\
> +}
> +
> +static const struct iio_chan_spec ltc2664_channels[] = {
> +	LTC2664_CHANNEL(0),
> +	LTC2664_CHANNEL(1),
> +	LTC2664_CHANNEL(2),
> +	LTC2664_CHANNEL(3),
> +};
> +
> +static const struct iio_chan_spec ltc2672_channels[] = {
> +	LTC2664_CHANNEL(0),
> +	LTC2664_CHANNEL(1),
> +	LTC2664_CHANNEL(2),
> +	LTC2664_CHANNEL(3),
> +	LTC2664_CHANNEL(4),
> +};

Do we really need these since they are only used as a template anyway?
We could just have a single template for one channel and copy it as
manay times as needed.

> +
> +static const struct ltc2664_chip_info ltc2664_chip = {
> +	.id = LTC2664,
> +	.name = "ltc2664",
> +	.scale_get = ltc2664_scale_get,
> +	.offset_get = ltc2664_offset_get,
> +	.measurement_type = IIO_VOLTAGE,
> +	.num_channels = ARRAY_SIZE(ltc2664_channels),
> +	.iio_chan = ltc2664_channels,
> +	.span_helper = ltc2664_span_helper,
> +	.num_span = ARRAY_SIZE(ltc2664_span_helper),
> +	.internal_vref = 2500,
> +	.manual_span_support = true,
> +	.rfsadj_support = false,
> +};
> +
> +static const struct ltc2664_chip_info ltc2672_chip = {
> +	.id = LTC2672,
> +	.name = "ltc2672",
> +	.scale_get = ltc2672_scale_get,
> +	.offset_get = ltc2672_offset_get,
> +	.measurement_type = IIO_CURRENT,
> +	.num_channels = ARRAY_SIZE(ltc2672_channels),
> +	.iio_chan = ltc2672_channels,
> +	.span_helper = ltc2672_span_helper,
> +	.num_span = ARRAY_SIZE(ltc2672_span_helper),
> +	.internal_vref = 1250,
> +	.manual_span_support = false,
> +	.rfsadj_support = true,
> +};
> +
> +static int ltc2664_set_span(const struct ltc2664_state *st, int min, int max,
> +			    int chan)
> +{
> +	const struct ltc2664_chip_info *chip_info = st->chip_info;
> +	const int (*span_helper)[2] = chip_info->span_helper;
> +	int span, ret;
> +
> +	st->iio_channels[chan].type = chip_info->measurement_type;
> +
> +	for (span = 0; span < chip_info->num_span; span++) {
> +		if (min == span_helper[span][0] && max == span_helper[span][1])
> +			break;
> +	}
> +
> +	if (span == chip_info->num_span)
> +		return -EINVAL;
> +
> +	ret = regmap_write(st->regmap, LTC2664_CMD_SPAN_N(chan),
> +			   (chip_info->id == LTC2672) ? span + 1 : span);
> +	if (ret)
> +		return ret;
> +
> +	return span;
> +}
> +
> +static int ltc2664_channel_config(struct ltc2664_state *st)
> +{
> +	const struct ltc2664_chip_info *chip_info = st->chip_info;
> +	struct device *dev = &st->spi->dev;
> +	u32 reg, tmp[2], mspan;
> +	int ret, span = 0;
> +
> +	mspan = LTC2664_MSPAN_SOFTSPAN;
> +	ret = device_property_read_u32(dev, "adi,manual-span-operation-config",
> +				       &mspan);
> +	if (!ret) {
> +		if (!chip_info->manual_span_support)
> +			return dev_err_probe(dev, -EINVAL,
> +			       "adi,manual-span-operation-config not supported\n");
> +
> +		if (mspan > ARRAY_SIZE(ltc2664_mspan_lut))
> +			return dev_err_probe(dev, -EINVAL,
> +			       "adi,manual-span-operation-config not in range\n");
> +	}
> +
> +	st->rfsadj = 20000;
> +	ret = device_property_read_u32(dev, "adi,rfsadj-ohms", &st->rfsadj);
> +	if (!ret) {
> +		if (!chip_info->rfsadj_support)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "adi,rfsadj-ohms not supported\n");
> +
> +		if (st->rfsadj < 19000 || st->rfsadj > 41000)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "adi,rfsadj-ohms not in range\n");
> +	}
> +
> +	device_for_each_child_node_scoped(dev, child) {
> +		struct ltc2664_chan *chan;
> +
> +		ret = fwnode_property_read_u32(child, "reg", &reg);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to get reg property\n");
> +
> +		if (reg >= chip_info->num_channels)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "reg bigger than: %d\n",
> +					     chip_info->num_channels);
> +
> +		chan = &st->channels[reg];
> +
> +		if (fwnode_property_read_bool(child, "adi,toggle-mode")) {
> +			chan->toggle_chan = true;
> +			/* assume sw toggle ABI */
> +			st->iio_channels[reg].ext_info = ltc2664_toggle_sym_ext_info;
> +
> +			/*
> +			 * Clear IIO_CHAN_INFO_RAW bit as toggle channels expose
> +			 * out_voltage/current_raw{0|1} files.
> +			 */
> +			__clear_bit(IIO_CHAN_INFO_RAW,
> +				    &st->iio_channels[reg].info_mask_separate);
> +		}
> +
> +		chan->raw[0] = ltc2664_mspan_lut[mspan][1];
> +		chan->raw[1] = ltc2664_mspan_lut[mspan][1];
> +
> +		chan->span = ltc2664_mspan_lut[mspan][0];
> +
> +		ret = fwnode_property_read_u32_array(child, "adi,output-range-microvolt",
> +						     tmp, ARRAY_SIZE(tmp));
> +		if (!ret && mspan == LTC2664_MSPAN_SOFTSPAN) {
> +			chan->span = ltc2664_set_span(st, tmp[0] / 1000,
> +						      tmp[1] / 1000, reg);
> +			if (span < 0)
> +				return dev_err_probe(dev, span,
> +						     "Failed to set span\n");
> +
> +		}
> +
> +		ret = fwnode_property_read_u32(child,
> +					       "adi,output-range-microamp",
> +					       &tmp[0]);
> +		if (!ret) {
> +			chan->span = ltc2664_set_span(st, 0, tmp[0] / 1000, reg);
> +			if (span < 0)
> +				return dev_err_probe(dev, span,
> +						     "Failed to set span\n");
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int ltc2664_setup(struct ltc2664_state *st, struct regulator *vref)
> +{
> +	const struct ltc2664_chip_info *chip_info = st->chip_info;
> +	struct gpio_desc *gpio;
> +	int ret;
> +
> +	/* If we have a clr/reset pin, use that to reset the chip. */
> +	gpio = devm_gpiod_get_optional(&st->spi->dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(gpio))
> +		return dev_err_probe(&st->spi->dev, PTR_ERR(gpio),
> +				     "Failed to get reset gpio");
> +	if (gpio) {
> +		usleep_range(1000, 1200);

		fsleep(1000)

> +		gpiod_set_value_cansleep(gpio, 0);
> +	}
> +
> +	/*
> +	 * Duplicate the default channel configuration as it can change during
> +	 * @ltc2664_channel_config()
> +	 */
> +	st->iio_channels = devm_kmemdup(&st->spi->dev, chip_info->iio_chan,
> +					(chip_info->num_channels + 1) *
> +					sizeof(*chip_info->iio_chan),
> +					GFP_KERNEL);
> +
> +	ret = ltc2664_channel_config(st);
> +	if (ret)
> +		return ret;
> +
> +	if (!vref)
> +		return 0;
> +
> +	return regmap_set_bits(st->regmap, LTC2664_CMD_CONFIG, LTC2664_REF_DISABLE);
> +}
> +
> +static void ltc2664_disable_regulator(void *regulator)
> +{
> +	regulator_disable(regulator);
> +}
> +
> +static const struct regmap_config ltc2664_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 16,
> +	.max_register = LTC2664_CMD_NO_OPERATION,
> +};
> +
> +static const struct iio_info ltc2664_info = {
> +	.write_raw = ltc2664_write_raw,
> +	.read_raw = ltc2664_read_raw,
> +	.read_avail = ltc2664_read_avail,
> +	.debugfs_reg_access = ltc2664_reg_access,
> +};
> +
> +static int ltc2664_probe(struct spi_device *spi)
> +{
> +	static const char * const regulators[] = { "vcc", "iovcc", "v-neg" };
> +	const struct ltc2664_chip_info *chip_info;
> +	struct device *dev = &spi->dev;
> +	struct regulator *vref_reg;
> +	struct iio_dev *indio_dev;
> +	struct ltc2664_state *st;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	st->spi = spi;
> +
> +	chip_info = spi_get_device_match_data(spi);
> +	if (!chip_info)
> +		return -ENOMEM;

ENOMEM? Usually, this is EINVAL and sometimes ENODEV. Not sure what
should be preferred.

> +
> +	st->chip_info = chip_info;
> +
> +	mutex_init(&st->lock);
> +
> +	st->regmap = devm_regmap_init_spi(spi, &ltc2664_regmap_config);
> +	if (IS_ERR(st->regmap))
> +		return dev_err_probe(dev, PTR_ERR(st->regmap),
> +				     "Failed to init regmap");
> +
> +	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(regulators),
> +					     regulators);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable regulators\n");
> +


> +	vref_reg = devm_regulator_get_optional(dev, "ref");
> +	if (IS_ERR(vref_reg)) {
> +		if (PTR_ERR(vref_reg) != -ENODEV)
> +			return dev_err_probe(dev, PTR_ERR(vref_reg),
> +					     "Failed to get ref regulator");
> +
> +		vref_reg = NULL;
> +
> +		st->vref = chip_info->internal_vref;
> +	} else {
> +		ret = regulator_enable(vref_reg);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to enable ref regulators\n");
> +
> +		ret = devm_add_action_or_reset(dev, ltc2664_disable_regulator,
> +					       vref_reg);
> +		if (ret)
> +			return ret;
> +
> +		ret = regulator_get_voltage(vref_reg);
> +		if (ret < 0)
> +			return dev_err_probe(dev, ret, "Failed to get ref\n");
> +
> +		st->vref = ret / 1000;
> +	}

There is a new API to allow simplifying this:

	ret = devm_regulator_get_enable_read_voltage(dev, "ref");
	if (ret == -ENODEV)
		st->vref_mv = chip_info->internal_vref_mv;
	else if (ret < 0)
		return dev_err_probe(dev, ret, "Failed to get vref voltage\n");
	else
		st->vref_mv = ret / 1000;

And ltc2664_disable_regulator and vref_reg are removed too.

> +
> +	ret = ltc2664_setup(st, vref_reg);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->name = chip_info->name;
> +	indio_dev->info = &ltc2664_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = st->iio_channels;
> +	indio_dev->num_channels = chip_info->num_channels;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static const struct spi_device_id ltc2664_id[] = {
> +	{ "ltc2664", (kernel_ulong_t)&ltc2664_chip },
> +	{ "ltc2672", (kernel_ulong_t)&ltc2672_chip },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, ltc2664_id);
> +
> +static const struct of_device_id ltc2664_of_id[] = {
> +	{ .compatible = "adi,ltc2664", .data = &ltc2664_chip },
> +	{ .compatible = "adi,ltc2672", .data = &ltc2672_chip },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ltc2664_of_id);
> +
> +static struct spi_driver ltc2664_driver = {
> +	.driver = {
> +		.name = "ltc2664",
> +		.of_match_table = ltc2664_of_id,
> +	},
> +	.probe = ltc2664_probe,
> +	.id_table = ltc2664_id,
> +};
> +module_spi_driver(ltc2664_driver);
> +
> +MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
> +MODULE_AUTHOR("Kim Seer Paller <kimseer.paller@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices LTC2664 and LTC2672 DAC");
> +MODULE_LICENSE("GPL");


