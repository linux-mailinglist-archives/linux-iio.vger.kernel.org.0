Return-Path: <linux-iio+bounces-6594-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E86890F4A2
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2024 19:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E980C2824F4
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2024 17:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AF215539D;
	Wed, 19 Jun 2024 17:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pZvKohvy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FE8339A8
	for <linux-iio@vger.kernel.org>; Wed, 19 Jun 2024 17:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718816530; cv=none; b=tMp1BGe8IWbjlQIlAKNKWm5tqrY5OFdtHIkWpL/cSr9bhUG1If0rOJQPE+aE208YUaLjKvrzFw6xf3xRmavRFj2UUONtrF4Bfw0sGA1Cwd40WDAfRgl1Bvh5rJ2rwYm4is7s771+LfHhyKFJOwFI4xrwjXz5NdD6s02d6+GaDFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718816530; c=relaxed/simple;
	bh=EuhZdrGQgGovJo+TM+ofuRMFuXVkDTUCKSa5jvawrL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fwr0kqPU+mJlvr3tiw221QhYbl4P36boV4dmQN5xtAVKtDnrbGnZaijPFRJJTs8ORWoJv1SLsAkb5l0XGaBpQmFG85zPH0VsYLvxXB4ME93EZhOyWF8uzJHGRHTkEUOyoxrmTUoKOOpQKu04y2Mqf0qYKsDKiIho1ccN7sfkTxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=pZvKohvy; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5b9776123a3so3049719eaf.0
        for <linux-iio@vger.kernel.org>; Wed, 19 Jun 2024 10:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718816525; x=1719421325; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DF9osQdP27FDpYW3uBii2KqG15VUxSkGaZAc98gGQgo=;
        b=pZvKohvyNzsqNlmSnIjNkRIqbDysklBfbdQ89xtT8nnU2/DNQiekcXCuBPVklxdQMc
         O/1e6Sbw8uvdPlEy6jCVa50p4/2DbhlJCUH16mbSUr6UI769myqzdEI3Dp0g4LhD24ka
         aWSnxZicWyWKDV+5+P1Bm1GjroDQgjaT3fk6/KBEUlSb5l0XRYjgShAUF5loYR+FgU20
         QdIimUMygYaXeuYPIC+hyjG8pEmaZNI0lG2i2JIeX4VSx6WcoA1rib53DILtgM8r/8YC
         +ETqvZ6RGhPtUtB9iGbWCRFuJqh4f0aPj/5V4pTBDzJeV9H4poXMrVGB9ALGcKJ5RufP
         SngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718816525; x=1719421325;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DF9osQdP27FDpYW3uBii2KqG15VUxSkGaZAc98gGQgo=;
        b=A24XBVbT3rrZfaZ1sFRWVPa8d3S2s2Gv/g4ntvqnFMgYm2TmM1LsXGdYmwpivYpp4n
         Dw1yDTxiZTOt2frklS5Ws2s6kv8qCFr2kyv/jGJEXhJ3YZyv9dNgOCAJa+Y0Wh6F6ywS
         x8cnDxKD3PtKrKgMld6ED25MwSF8hxGZjunQT7UOECWihwdrmUQGZ1QdHaLvjy5cP/3A
         i31NhISDC779k2M0TYatjI34KqHgLqzVMOGjCH2zuXe25ztF+hgqja7xm3TZtlQYlRJL
         47l+5DuLUTElhBgfMFeA8EkY54cJktodaAFQUREx8KlVgdEDLOQqvfvtGTOZlQyp0Y6M
         jXBA==
X-Gm-Message-State: AOJu0YzOUi2Sl7Rnd/H/YAvMo67atF9X6K9fuM7qPuJKZr3E6llbs6mx
	X8fM0sC8D00oKr6yHWQv2iyCsxACemlWSvem4ZsHp81cJhYNcpqFHd0KxoDfDIo=
X-Google-Smtp-Source: AGHT+IHRYD8MTVC0H0tqdmrzs5H7rsNx6wCNPZr7NrL9Vf4vfguDUxRxCg6z1cgv3uIEAJ4O/hGMXw==
X-Received: by 2002:a4a:6251:0:b0:5bf:aa53:2de7 with SMTP id 006d021491bc7-5c1adbca083mr3162443eaf.5.1718816524963;
        Wed, 19 Jun 2024 10:02:04 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5bd5de71d66sm1623270eaf.1.2024.06.19.10.02.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 10:02:04 -0700 (PDT)
Message-ID: <f877b9a1-6cd7-41c2-ac26-46516e0340da@baylibre.com>
Date: Wed, 19 Jun 2024 12:02:03 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] iio: adc: Add support for AD4000
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, broonie@kernel.org,
 lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 nuno.sa@analog.com, marcelo.schmitt1@gmail.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1718749981.git.marcelo.schmitt@analog.com>
 <e77a00d1020baa178cb6a0201053b66cb27c39a9.1718749981.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <e77a00d1020baa178cb6a0201053b66cb27c39a9.1718749981.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/18/24 6:12 PM, Marcelo Schmitt wrote:
> Add support for AD4000 series of low noise, low power, high speed,
> successive aproximation register (SAR) ADCs.

spelling: approximation

Probably also worth mentioning ADAQ here too.

> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---

...

> diff --git a/drivers/iio/adc/ad4000.c b/drivers/iio/adc/ad4000.c
> new file mode 100644
> index 000000000000..310f81a2a1d9
> --- /dev/null
> +++ b/drivers/iio/adc/ad4000.c
> @@ -0,0 +1,715 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * AD4000 SPI ADC driver
> + *
> + * Copyright 2024 Analog Devices Inc.

Would be handy to have links to the datasheets here too.

> + */
> +#include <asm/unaligned.h>

Doesn't look like this header is needed.

> +#include <linux/bits.h>
> +#include <linux/bitfield.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/kernel.h>

Or this one.

> +#include <linux/math.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +#include <linux/sysfs.h>

Or this one.

> +#include <linux/units.h>
> +#include <linux/util_macros.h>

I would put a blank line here or keep iio/*
in alphabetical order with the rest.

> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>

Not used?

> +#include <linux/iio/buffer.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> +
> +#define AD4000_READ_COMMAND	0x54
> +#define AD4000_WRITE_COMMAND	0x14
> +
> +#define AD4000_CONFIG_REG_DEFAULT	0xE1
> +
> +/* AD4000 Configuration Register programmable bits */
> +#define AD4000_CFG_STATUS		BIT(4) /* Status bits output */
> +#define AD4000_CFG_SPAN_COMP		BIT(3) /* Input span compression  */
> +#define AD4000_CFG_HIGHZ		BIT(2) /* High impedance mode  */
> +#define AD4000_CFG_TURBO		BIT(1) /* Turbo mode */> +
> +#define AD4000_TQUIET1_NS		190
> +#define AD4000_TQUIET2_NS		60
> +#define AD4000_TCONV_NS			320
> +
> +#define AD4000_18BIT_MSK	GENMASK(31, 14)
> +#define AD4000_20BIT_MSK	GENMASK(31, 12)
> +
> +#define AD4000_DIFF_CHANNEL(_sign, _real_bits, _3wire)				\

_3wire isn't very clear what the intention is. _can_write_reg is what we
really mean, right?

It is still technically possible to have a 3-wire mode where we can't write
registers because the SPI controller doesn't support MOSI idle high or MOSI
isn't wired up at all. So even if the driver doesn't currently support this,
saying that _3wire implies that we can write registers still seems misleading.


> +{										\
> +	.type = IIO_VOLTAGE,							\
> +	.indexed = 1,								\
> +	.differential = 1,							\
> +	.channel = 0,								\
> +	.channel2 = 1,								\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |				\
> +			      BIT(IIO_CHAN_INFO_SCALE),				\> +	.info_mask_separate_available = _3wire ? BIT(IIO_CHAN_INFO_SCALE) : 0,	\
> +	.scan_type = {								\
> +		.sign = _sign,							\
> +		.realbits = _real_bits,						\
> +		.storagebits = _real_bits > 16 ? 32 : 16,			\
> +		.shift = _real_bits > 16 ? 32 - _real_bits : 0,			\
> +		.endianness = IIO_BE,						\
> +	},									\
> +}
> +
> +#define AD4000_PSEUDO_DIFF_CHANNEL(_sign, _real_bits, _3wire)			\
> +{										\
> +	.type = IIO_VOLTAGE,							\
> +	.indexed = 1,								\
> +	.channel = 0,								\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |				\
> +			      BIT(IIO_CHAN_INFO_SCALE) |			\
> +			      BIT(IIO_CHAN_INFO_OFFSET),			\> +	.info_mask_separate_available = _3wire ? BIT(IIO_CHAN_INFO_SCALE) : 0,	\
> +	.scan_type = {								\
> +		.sign = _sign,							\
> +		.realbits = _real_bits,						\
> +		.storagebits = _real_bits > 16 ? 32 : 16,			\
> +		.shift = _real_bits > 16 ? 32 - _real_bits : 0,			\
> +		.endianness = IIO_BE,						\
> +	},									\
> +}
> +
> +enum ad4000_spi_mode {
> +	/* datasheet calls this "4-wire mode" (controller CS goes to ADC SDI!) */
> +	AD4000_SPI_MODE_DEFAULT,
> +	/* datasheet calls this "3-wire mode" (not related to SPI_3WIRE!) */
> +	AD4000_SPI_MODE_SINGLE,> +};
> +
> +/* maps adi,spi-mode property value to enum */
> +static const char * const ad4000_spi_modes[] = {
> +	[AD4000_SPI_MODE_DEFAULT] = "",
> +	[AD4000_SPI_MODE_SINGLE] = "single",
> +};
> +
> +struct ad4000_chip_info {
> +	const char *dev_name;
> +	struct iio_chan_spec chan_spec;
> +	struct iio_chan_spec three_w_chan_spec;
> +};

I understand the reason for doing this, but it still seems a bit weird
to me to have two different sets of specs for the same chip. I guess
we'll see what Jonathan has to say about this.

> +
> +static const struct ad4000_chip_info ad4000_chip_info = {
> +	.dev_name = "ad4000",
> +	.chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 16, 0),
> +	.three_w_chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 16, 1),
> +};
> +
> +static const struct ad4000_chip_info ad4001_chip_info = {
> +	.dev_name = "ad4001",
> +	.chan_spec = AD4000_DIFF_CHANNEL('s', 16, 0),
> +	.three_w_chan_spec = AD4000_DIFF_CHANNEL('s', 16, 1),
> +};
> +
> +static const struct ad4000_chip_info ad4002_chip_info = {
> +	.dev_name = "ad4002",
> +	.chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 18, 0),
> +	.three_w_chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 18, 1),
> +};
> +
> +static const struct ad4000_chip_info ad4003_chip_info = {
> +	.dev_name = "ad4003",
> +	.chan_spec = AD4000_DIFF_CHANNEL('s', 18, 0),
> +	.three_w_chan_spec = AD4000_DIFF_CHANNEL('s', 18, 1),
> +};
> +
> +static const struct ad4000_chip_info ad4004_chip_info = {
> +	.dev_name = "ad4004",
> +	.chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 16, 0),
> +	.three_w_chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 16, 1),
> +};
> +
> +static const struct ad4000_chip_info ad4005_chip_info = {
> +	.dev_name = "ad4005",
> +	.chan_spec = AD4000_DIFF_CHANNEL('s', 16, 0),
> +	.three_w_chan_spec = AD4000_DIFF_CHANNEL('s', 16, 1),
> +};
> +
> +static const struct ad4000_chip_info ad4006_chip_info = {
> +	.dev_name = "ad4006",
> +	.chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 18, 0),
> +	.three_w_chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 18, 1),
> +};
> +
> +static const struct ad4000_chip_info ad4007_chip_info = {
> +	.dev_name = "ad4007",
> +	.chan_spec = AD4000_DIFF_CHANNEL('s', 18, 0),
> +	.three_w_chan_spec = AD4000_DIFF_CHANNEL('s', 18, 1),
> +};
> +
> +static const struct ad4000_chip_info ad4008_chip_info = {
> +	.dev_name = "ad4008",
> +	.chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 16, 0),
> +	.three_w_chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 16, 1),
> +};
> +
> +static const struct ad4000_chip_info ad4010_chip_info = {
> +	.dev_name = "ad4010",
> +	.chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 18, 0),
> +	.three_w_chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 18, 1),
> +};
> +
> +static const struct ad4000_chip_info ad4011_chip_info = {
> +	.dev_name = "ad4011",
> +	.chan_spec = AD4000_DIFF_CHANNEL('s', 18, 0),
> +	.three_w_chan_spec = AD4000_DIFF_CHANNEL('s', 18, 1),
> +};
> +
> +static const struct ad4000_chip_info ad4020_chip_info = {
> +	.dev_name = "ad4020",
> +	.chan_spec = AD4000_DIFF_CHANNEL('s', 20, 0),
> +	.three_w_chan_spec = AD4000_DIFF_CHANNEL('s', 20, 1),
> +};
> +
> +static const struct ad4000_chip_info ad4021_chip_info = {
> +	.dev_name = "ad4021",
> +	.chan_spec = AD4000_DIFF_CHANNEL('s', 20, 0),
> +	.three_w_chan_spec = AD4000_DIFF_CHANNEL('s', 20, 1),
> +};
> +
> +static const struct ad4000_chip_info ad4022_chip_info = {
> +	.dev_name = "ad4022",
> +	.chan_spec = AD4000_DIFF_CHANNEL('s', 20, 0),
> +	.three_w_chan_spec = AD4000_DIFF_CHANNEL('s', 20, 1),
> +};
> +
> +static const struct ad4000_chip_info adaq4001_chip_info = {
> +	.dev_name = "adaq4001",
> +	.chan_spec = AD4000_DIFF_CHANNEL('s', 16, 0),
> +	.three_w_chan_spec = AD4000_DIFF_CHANNEL('s', 16, 1),
> +};
> +
> +static const struct ad4000_chip_info adaq4003_chip_info = {
> +	.dev_name = "adaq4003",
> +	.chan_spec = AD4000_DIFF_CHANNEL('s', 18, 0),
> +	.three_w_chan_spec = AD4000_DIFF_CHANNEL('s', 18, 1),
> +};
> +
> +struct ad4000_state {
> +	struct spi_device *spi;
> +	struct gpio_desc *cnv_gpio;
> +	struct spi_transfer xfers[2];
> +	struct spi_message msg;
> +	int vref_mv;
> +	enum ad4000_spi_mode spi_mode;
> +	bool span_comp;
> +	bool turbo_mode;
> +	u16 gain_milli;
> +	int scale_tbl[2][2];
> +
> +	/*
> +	 * DMA (thus cache coherency maintenance) requires the
> +	 * transfer buffers to live in their own cache lines.
> +	 */
> +	struct {
> +		union {
> +			__be16 sample_buf16;
> +			__be32 sample_buf32;
> +		} data;
> +		s64 timestamp __aligned(8);
> +	} scan __aligned(IIO_DMA_MINALIGN);
> +	__be16 tx_buf;
> +	__be16 rx_buf;
> +};
> +
> +static void ad4000_fill_scale_tbl(struct ad4000_state *st,
> +				  struct iio_chan_spec const *chan)
> +{
> +	int val, tmp0, tmp1;
> +	int scale_bits;
> +	u64 tmp2;
> +
> +	/*
> +	 * ADCs that output two's complement code have one less bit to express
> +	 * voltage magnitude.
> +	 */
> +	if (chan->scan_type.sign == 's')
> +		scale_bits = chan->scan_type.realbits - 1;
> +	else
> +		scale_bits = chan->scan_type.realbits;
> +
> +	/*
> +	 * The gain is stored as a fraction of 1000 and, as we need to
> +	 * divide vref_mv by the gain, we invert the gain/1000 fraction.
> +	 * Also multiply by an extra MILLI to preserve precision.
> +	 * Thus, we have MILLI * MILLI equals MICRO as fraction numerator.
> +	 */
> +	val = mult_frac(st->vref_mv, MICRO, st->gain_milli);
> +	/* Would multiply by NANO here but we multiplied by extra MILLI */
> +	tmp2 = shift_right((u64)val * MICRO, scale_bits);
> +	tmp0 = div_s64_rem(tmp2, NANO, &tmp1);
> +	/* Store scale for when span compression is disabled */
> +	st->scale_tbl[0][0] = tmp0; /* Integer part */
> +	st->scale_tbl[0][1] = abs(tmp1); /* Fractional part */
> +	/* Store scale for when span compression is enabled */
> +	st->scale_tbl[1][0] = tmp0;
> +	/* The integer part is always zero so don't bother to divide it. */
> +	if (chan->differential)
> +		st->scale_tbl[1][1] = DIV_ROUND_CLOSEST(abs(tmp1) * 4, 5);
> +	else
> +		st->scale_tbl[1][1] = DIV_ROUND_CLOSEST(abs(tmp1) * 9, 10);
> +}
> +
> +static int ad4000_write_reg(struct ad4000_state *st, uint8_t val)
> +{
> +	st->tx_buf = cpu_to_be16(AD4000_WRITE_COMMAND << BITS_PER_BYTE | val);

Seems like a complicated way of writing:

	st->tx_buf[0] = AD4000_WRITE_COMMAND;
	st->tx_buf[1] = val;

(tx_buf would of course have to be changed to `u8 tx_buf[2]`)

> +	return spi_write(st->spi, &st->tx_buf, sizeof(st->tx_buf));
> +}
> +
> +static int ad4000_read_reg(struct ad4000_state *st, unsigned int *val)
> +{
> +	struct spi_transfer t[] = {
> +		{
> +			.tx_buf = &st->tx_buf,
> +			.rx_buf = &st->rx_buf,
> +			.len = 2,
> +		},
> +	};

Don't need array for one item.

> +	int ret;
> +
> +	st->tx_buf = cpu_to_be16(AD4000_READ_COMMAND << BITS_PER_BYTE);
> +	ret = spi_sync_transfer(st->spi, t, ARRAY_SIZE(t));
> +	if (ret < 0)
> +		return ret;
> +
> +	*val = be16_to_cpu(st->rx_buf);

This doesn't mask out the "don't care" bits. This could just be:

	*val = st->rx_buf[1];

(rx_buf would of course have to be changed to `u8 rx_buf[2]`)

...

or could just replace all of this this will spi_w8r8() and have
a one-line function.

> +
> +	return ret;
> +}
> +
> +static void ad4000_unoptimize_msg(void *msg)
> +{
> +	spi_unoptimize_message(msg);
> +}
> +
> +/*
> + * This executes a data sample transfer for when the device connections are
> + * in "3-wire" mode, selected by setting the adi,spi-mode device tree property
> + * to "single". In this connection mode, the ADC SDI pin is connected to MOSI or
> + * to VIO and ADC CNV pin is connected either to a SPI controller CS or to a GPIO.
> + * AD4000 series of devices initiate conversions on the rising edge of CNV pin.
> + *
> + * If the CNV pin is connected to an SPI controller CS line (which is by default
> + * active low), the ADC readings would have a latency (delay) of one read.
> + * Moreover, since we also do ADC sampling for filling the buffer on triggered
> + * buffer mode, the timestamps of buffer readings would be disarranged.
> + * To prevent the read latency and reduce the time discrepancy between the
> + * sample read request and the time of actual sampling by the ADC, do a
> + * preparatory transfer to pulse the CS/CNV line.
> + */
> +static int ad4000_prepare_3wire_mode_message(struct ad4000_state *st,
> +					     const struct iio_chan_spec *chan)
> +{
> +	unsigned int cnv_pulse_time = st->turbo_mode ? AD4000_TQUIET1_NS
> +						     : AD4000_TCONV_NS;
> +	struct spi_transfer *xfers = st->xfers;
> +	int ret;
> +
> +	xfers[0].cs_change = 1;> +	xfers[0].cs_change_delay.value = cnv_pulse_time;
> +	xfers[0].cs_change_delay.unit = SPI_DELAY_UNIT_NSECS;
> +
> +	xfers[1].rx_buf = &st->scan.data;
> +	xfers[1].len = BITS_TO_BYTES(chan->scan_type.storagebits);

Do we really need to read 32-bits for 18-bit data? It seems like we could
get away with reading 3 bytes.

> +	xfers[1].delay.value = AD4000_TQUIET2_NS;
> +	xfers[1].delay.unit = SPI_DELAY_UNIT_NSECS;
> +
> +	spi_message_init_with_transfers(&st->msg, st->xfers, 2);
> +
> +	ret = spi_optimize_message(st->spi, &st->msg);
> +	if (ret)
> +		return ret;
> +
> +	return devm_add_action_or_reset(&st->spi->dev, ad4000_unoptimize_msg,
> +					&st->msg);
> +}
> +
> +/*
> + * This executes a data sample transfer for when the device connections are
> + * in "4-wire" mode, selected when the adi,spi-mode device tree
> + * property is absent or empty. In this connection mode, the controller CS pin
> + * is connected to ADC SDI pin and a GPIO is connected to ADC CNV pin.
> + * The GPIO connected to ADC CNV pin is set outside of the SPI transfer.
> + */
> +static int ad4000_prepare_4wire_mode_message(struct ad4000_state *st,
> +					     const struct iio_chan_spec *chan)
> +{
> +	unsigned int cnv_to_sdi_time = st->turbo_mode ? AD4000_TQUIET1_NS
> +						      : AD4000_TCONV_NS;
> +	struct spi_transfer *xfers = st->xfers;
> +	int ret;
> +
> +	/*
> +	 * Dummy transfer to cause enough delay between CNV going high and SDI
> +	 * going low.
> +	 */
> +	xfers[0].cs_off = 1;
> +	xfers[0].delay.value = cnv_to_sdi_time;
> +	xfers[0].delay.unit = SPI_DELAY_UNIT_NSECS;
> +
> +	xfers[1].rx_buf = &st->scan.data;
> +	xfers[1].len = BITS_TO_BYTES(chan->scan_type.storagebits);
> +
> +	spi_message_init_with_transfers(&st->msg, st->xfers, 2);
> +
> +	ret = spi_optimize_message(st->spi, &st->msg);
> +	if (ret)
> +		return ret;
> +
> +	return devm_add_action_or_reset(&st->spi->dev, ad4000_unoptimize_msg,
> +					&st->msg);
> +}
> +
> +static int ad4000_convert_and_acquire(struct ad4000_state *st)
> +{
> +	int ret;
> +
> +	/*
> +	 * In 4-wire mode, the CNV line is held high for the entire conversion
> +	 * and acquisition process. In other modes, the CNV GPIO is optional
> +	 * and, if provided, replaces controller CS. If CNV GPIO is not defined
> +	 * gpiod_set_value_cansleep() has no effect.
> +	 */
> +	gpiod_set_value_cansleep(st->cnv_gpio, 1);
> +	ret = spi_sync(st->spi, &st->msg);
> +	gpiod_set_value_cansleep(st->cnv_gpio, 0);
> +
> +	return ret;
> +}
> +
> +static int ad4000_single_conversion(struct iio_dev *indio_dev,
> +				    const struct iio_chan_spec *chan, int *val)
> +{
> +	struct ad4000_state *st = iio_priv(indio_dev);
> +	u32 sample;
> +	int ret;
> +
> +	ret = ad4000_convert_and_acquire(st);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (chan->scan_type.storagebits > 16)
> +		sample = be32_to_cpu(st->scan.data.sample_buf32);
> +	else
> +		sample = be16_to_cpu(st->scan.data.sample_buf16);
> +
> +	switch (chan->scan_type.realbits) {
> +	case 16:
> +		break;
> +	case 18:
> +		sample = FIELD_GET(AD4000_18BIT_MSK, sample);
> +		break;
> +	case 20:
> +		sample = FIELD_GET(AD4000_20BIT_MSK, sample);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}

Could we use scan_type.shift here instead of the switch statement?

> +
> +	if (chan->scan_type.sign == 's')
> +		*val = sign_extend32(sample, chan->scan_type.realbits - 1);
> +
> +	return IIO_VAL_INT;
> +}
> +
> +static int ad4000_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan, int *val,
> +			   int *val2, long info)
> +{
> +	struct ad4000_state *st = iio_priv(indio_dev);
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_RAW:
> +		iio_device_claim_direct_scoped(return -EBUSY, indio_dev)
> +			return ad4000_single_conversion(indio_dev, chan, val);
> +		unreachable();
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = st->scale_tbl[st->span_comp][0];
> +		*val2 = st->scale_tbl[st->span_comp][1];
> +		return IIO_VAL_INT_PLUS_NANO;
> +	case IIO_CHAN_INFO_OFFSET:
> +		*val = 0;
> +		if (st->span_comp)
> +			*val = mult_frac(st->vref_mv, 1, 10);
> +
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad4000_read_avail(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     const int **vals, int *type, int *length,
> +			     long info)
> +{
> +	struct ad4000_state *st = iio_priv(indio_dev);
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_SCALE:
> +		*vals = (int *)st->scale_tbl;
> +		*length = 2 * 2;
> +		*type = IIO_VAL_INT_PLUS_NANO;
> +		return IIO_AVAIL_LIST;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad4000_write_raw_get_fmt(struct iio_dev *indio_dev,
> +				    struct iio_chan_spec const *chan, long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		return IIO_VAL_INT_PLUS_NANO;
> +	default:
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	}
> +}
> +
> +static int ad4000_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan, int val, int val2,
> +			    long mask)
> +{
> +	struct ad4000_state *st = iio_priv(indio_dev);
> +	unsigned int reg_val;
> +	bool span_comp_en;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:> +		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> +			ret = ad4000_read_reg(st, &reg_val);
> +			if (ret < 0)
> +				return ret;
> +
> +			span_comp_en = val2 == st->scale_tbl[1][1];
> +			reg_val &= ~AD4000_CFG_SPAN_COMP;
> +			reg_val |= FIELD_PREP(AD4000_CFG_SPAN_COMP, span_comp_en);
> +
> +			ret = ad4000_write_reg(st, reg_val);
> +			if (ret < 0)
> +				return ret;
> +
> +			st->span_comp = span_comp_en;
> +			return 0;
> +		}
> +		unreachable();
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static irqreturn_t ad4000_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct ad4000_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = ad4000_convert_and_acquire(st);
> +	if (ret < 0)
> +		goto err_out;
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, &st->scan,
> +					   iio_get_time_ns(indio_dev));

We specified iio_pollfunc_store_time, so we should use pf->timestamp here.

> +
> +err_out:
> +	iio_trigger_notify_done(indio_dev->trig);
> +	return IRQ_HANDLED;
> +}
> +
> +static const struct iio_info ad4000_3wire_info = {
> +	.read_raw = &ad4000_read_raw,
> +	.read_avail = &ad4000_read_avail,
> +	.write_raw = &ad4000_write_raw,
> +	.write_raw_get_fmt = &ad4000_write_raw_get_fmt,
> +
> +};
> +
> +static const struct iio_info ad4000_info = {
> +	.read_raw = &ad4000_read_raw,
> +};
> +
> +static int ad4000_config(struct ad4000_state *st)
> +{> +	unsigned int reg_val = AD4000_CONFIG_REG_DEFAULT;
> +
> +	if (device_property_present(&st->spi->dev, "adi,high-z-input"))
> +		reg_val |= FIELD_PREP(AD4000_CFG_HIGHZ, 1);> +
> +	return ad4000_write_reg(st, reg_val);
> +}
> +
> +static int ad4000_probe(struct spi_device *spi)
> +{
> +	const struct ad4000_chip_info *chip;
> +	struct iio_dev *indio_dev;
> +	struct ad4000_state *st;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	chip = spi_get_device_match_data(spi);
> +	if (!chip)
> +		return -EINVAL;
> +
> +	st = iio_priv(indio_dev);
> +	st->spi = spi;
> +
> +	ret = devm_regulator_get_enable(&spi->dev, "vdd");
> +	if (ret)
> +		return dev_err_probe(&spi->dev, ret, "Failed to enable VDD supply\n");
> +
> +	ret = devm_regulator_get_enable(&spi->dev, "vio");
> +	if (ret)
> +		return dev_err_probe(&spi->dev, ret, "Failed to enable VIO supply\n");
> +
> +	st->vref_mv = devm_regulator_get_enable_read_voltage(&spi->dev, "ref");

	ret = devm_regulator_get_enable_read_voltage(&spi->dev, "ref");

> +	if (ret < 0)
> +		return dev_err_probe(&spi->dev, st->vref_mv,

		return dev_err_probe(&spi->dev, ret,

> +				     "Failed to get ref regulator reference\n");
> +	st->vref_mv = st->vref_mv / 1000;

	st->vref_mv = ret / 1000;

> +
> +	st->cnv_gpio = devm_gpiod_get_optional(&spi->dev, "cnv", GPIOD_OUT_HIGH);
> +	if (IS_ERR(st->cnv_gpio))
> +		return dev_err_probe(&spi->dev, PTR_ERR(st->cnv_gpio),
> +				     "Failed to get CNV GPIO");
> +
> +	ret = device_property_match_property_string(&spi->dev, "adi,spi-mode",
> +						    ad4000_spi_modes,
> +						    ARRAY_SIZE(ad4000_spi_modes));
> +	/* Default to 4-wire mode if adi,spi-mode property is not present */
> +	if (ret == -EINVAL)
> +		st->spi_mode = AD4000_SPI_MODE_DEFAULT;
> +	else if (ret < 0)
> +		return dev_err_probe(&spi->dev, ret,
> +				     "getting adi,spi-mode property failed\n");
> +	else
> +		st->spi_mode = ret;

Could save a few lines and avoid checkpatch warning like this:

	if (ret < 0 && ret != -EINVAL)
		return dev_err_probe(&spi->dev, ret,
				     "getting adi,spi-mode property failed\n");

	st->spi_mode = ret == -EINVAL ? AD4000_SPI_MODE_DEFAULT : ret;

> +
> +	switch (st->spi_mode) {
> +	case AD4000_SPI_MODE_DEFAULT:
> +		indio_dev->info = &ad4000_info;
> +		indio_dev->channels = &chip->chan_spec;
> +		ret = ad4000_prepare_4wire_mode_message(st, indio_dev->channels);
> +		if (ret)
> +			return ret;
> +
> +		break;
> +	case AD4000_SPI_MODE_SINGLE:
> +		indio_dev->info = &ad4000_3wire_info;
> +		indio_dev->channels = &chip->three_w_chan_spec;
> +
> +		/*
> +		 * In "3-wire mode", the ADC SDI line must be kept high when
> +		 * data is not being clocked out of the controller.
> +		 * Request the SPI controller to make MOSI idle high.
> +		 */
> +		spi->mode = SPI_MODE_0 | SPI_MOSI_IDLE_HIGH;

Maybe better to make this 

	spi->mode |= SPI_MOSI_IDLE_HIGH;

and let the DT determine the other flags?

> +		ret = spi_setup(spi);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = ad4000_prepare_3wire_mode_message(st, indio_dev->channels);
> +		if (ret)
> +			return ret;
> +
> +		ret = ad4000_config(st);
> +		if (ret < 0)
> +			dev_warn(&st->spi->dev, "Failed to config device\n");
> +
> +		break;

Need a default:? Especially since chain mode is not supported.

> +	}
> +
> +	indio_dev->name = chip->dev_name;
> +	indio_dev->num_channels = 1;
> +
> +	/* Hardware gain only applies to ADAQ devices */
> +	st->gain_milli = 1000;
> +	if (device_property_present(&spi->dev, "adi,gain-milli")) {
> +		ret = device_property_read_u16(&spi->dev, "adi,gain-milli",
> +					       &st->gain_milli);
> +		if (ret)
> +			return dev_err_probe(&spi->dev, ret,
> +					     "Failed to read gain property\n");
> +	}
> +
> +	ad4000_fill_scale_tbl(st, indio_dev->channels);
> +
> +	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
> +					      &iio_pollfunc_store_time,
> +					      &ad4000_trigger_handler, NULL);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(&spi->dev, indio_dev);
> +}
> +

