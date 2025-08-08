Return-Path: <linux-iio+bounces-22470-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D85B1EBF4
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 17:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68D11188FB63
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 15:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCAAD28641D;
	Fri,  8 Aug 2025 15:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cja1U6Xo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993B6286438;
	Fri,  8 Aug 2025 15:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754666616; cv=none; b=XTjs5YsnrXy54DDjEcjLT3jXQa/o4po3rikASMdOL62jPGyoeaKB4EJycpFGSVlLiRuvKRPxCXDEDIfIT2xWN13RY3igZYQp0R5eCbKcU21VfRg5W/bBus4wr2xwq73eKC82Ez2whdrZ4GpcgaPehZyqPJxwE0HBx9Ir+erzCOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754666616; c=relaxed/simple;
	bh=mOjkntssZBIFUck58dkDY/etXumFiz2yDAPlPy2dtEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NTxoZZ449gu5vhfBhHuBTdGXdZh9dGtbqcQVLK/ay/hW0KPWF4nQ8/57nAd5sOqDGtNkJNzASMk6CGMnu4DcisI8ZeK/6tgQBvJvER9KPLuJMAHaiTlkkTZFbQg2DR8bJSX2ruqO9ckjX+Rl+YLyuN7paP2iRUgclWssPQ3dmyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cja1U6Xo; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7e8320abfe0so58104285a.0;
        Fri, 08 Aug 2025 08:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754666612; x=1755271412; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n2qYBXWA8HCyRHyr1FRfOAXV/4PFDG9q87LVL0AJc7U=;
        b=cja1U6XoRPIQAJUVDTfzHCoEfzNeeVEGebLO+1y6/KvEw7h4ssZJQPoxTATklYJoFr
         zzrVdXBjw79BF3xyzo1WpS8HauoeKO3vJUzREHSR3dqIVXXvC9wgioRyxmPsm+5/nGJq
         5kSaddAVVEfwNE29JX/KT2lm3TMK4oFcsEy6+h8VuPCEx60OR9rdwguNrxSpDVBavu8n
         4agTwO2a0Sit5XmP8Af4HgEBZnyh72/ErRLQeQcVWXUDuZB0Tedj8FnAPyK3kDRYjlZs
         0PyGbT8EOgV0le09Yy6gI6rcpSQBFya4DtyGC7B+sjQyn1uUezLVp/U0r/EWWRctxz/f
         7RvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754666612; x=1755271412;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n2qYBXWA8HCyRHyr1FRfOAXV/4PFDG9q87LVL0AJc7U=;
        b=iaM6oc6gplCWIRxkzV5WlgdMG9VXiUMCKkE6LEdSQWOVR5b2gHy57B+q017Eikrqz+
         ErVZmpwRmVSP3zQxaymM+Pl6y89SObrp+zFWpz4YN4ceq4vbL+RgxDV6JfNSaSOhj26a
         2syuH5eVkBZwLCAMzGABrvEHLDTbzSed7RbRkrVAd9NuzUtsdMeI7KGjCwSyjC+jNGBz
         yy/KRmU6RnKoP9QxTbWG4wqCNodNzEmVat+eOnvIY4tq/AEwzkC2aLtfOb/810/2EuuZ
         /NKD2ooFfeOL/0JWohS/nbfbSX2lD1anVwmwPHHVKhgfhcMR3sw1uLa2vyYGbN+KcNs7
         CUVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuwGjoOsjq9nfjWGnv+pvklxUIYwGZeKfTgev+y/YbrGMvEtPiw8bvvihLvDNsGA5Z5mD8dabfWOUnxmKk@vger.kernel.org, AJvYcCVmHhMxtXgaKBO+V704f1eq1cNYU/kidWK2bZgog7mgui1mnBZ0G77/mooc0GhcsyLPWvXLJj2mFFO3@vger.kernel.org, AJvYcCX3xitGKg5xazYr7KRXG//pZXsXS13sBlnJtdWMrn7A3hOpzI+5KkJHpfQCJr7KT86oNX0yzMsTWuHp@vger.kernel.org
X-Gm-Message-State: AOJu0YxEj+sr7Rup7KdlbVA7ShwT39bmgN6Ysfh/zyg43dkA7GxDDSda
	b0T079E2znqodEtc37mIafYwCUVYFJ46XkL1mbExP/dYYqtmy9QOCuBR
X-Gm-Gg: ASbGncsnzLaNG+4/ZBzuTGOB1H9f4aoIteQ7s8rk2RaFyb0oc7lVZtFi6EA8Eun4KIu
	kVWbjrdaMGD/3lGSX3B7uTT8mDZw9zhGDMMSEgZ9DLrAHReavMRtKTQ4SD1H0u1fLVM0QxB7ZEj
	nOmuy0thnPeJnmV+mg42uFOwTALCyuURYuDs2UqzdoUAsh/FXfnReOAnroSa+slNlntMXo5B2dB
	0Is2Ld9y1KDDr2eoYtpLbKkVU59sLzzoaniUSeF8qKMQNqWE+eL2Mh0vFpHf4sZ/M0xug0bt5FT
	gWcVSfICx4Qm1LI9noZpeaDX8nrXQbqHJYqLAo+y3O7yeWJHhmfZnGPy4El2/TREAm49LVoiqC3
	s+MopFLV7O6s+tg==
X-Google-Smtp-Source: AGHT+IHzCyHEG4CLg4J6Qd2lt72XrlcuZH/t0h+mutg72vKXXPy8kVkRMUoWjEGZe5P1rZyI/I9xRA==
X-Received: by 2002:a05:620a:a110:b0:7e1:38c7:d073 with SMTP id af79cd13be357-7e82c64a5c3mr469404785a.14.1754666611799;
        Fri, 08 Aug 2025 08:23:31 -0700 (PDT)
Received: from nsa ([87.249.138.211])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e67f72b045sm1121621685a.60.2025.08.08.08.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 08:23:31 -0700 (PDT)
Date: Fri, 8 Aug 2025 16:23:46 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: jic23@kernel.org, robh@kernel.org, conor+dt@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 3/4] iio: adc: add ade9000 support
Message-ID: <eitzyilsrpmo2oecyrcxur2gttendkpukcpx4qlhlww5ptup4d@7j7cwjlvoi7q>
References: <20250808141020.4384-1-antoniu.miclaus@analog.com>
 <20250808141020.4384-4-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250808141020.4384-4-antoniu.miclaus@analog.com>

On Fri, Aug 08, 2025 at 02:10:15PM +0000, Antoniu Miclaus wrote:
> Add driver support for the ade9000. highly accurate,
> fully integrated, multiphase energy and power quality
> monitoring device.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

Hi Antoniu,

Not an easy one. I guess it will take some iterations. Jumping in v3 so
sorry if I'm asking something that was already discussed in previous
versions.

> changes in v3:
>  - add clk support for external clock input/output with clkout provider
>  - add dready interrupt handler and support
>  - use dev_err_probe for consistent error handling throughout
>  - simplify probe function and remove unnecessary channel setup
>  - update filter type from "sinc4+iir" to "sinc4+lp"
>  - remove dynamic channel setup and use static channel array
>  - simplify waveform buffer configuration (remove wf_mode field)
>  - add minmax.h and clk headers
>  - add waveform buffer configuration enum
>  - major code restructuring and cleanup
>  - remove ade9000_setup_iio_channels function
>  - update regulator handling for vref
>  - simplify SPI driver structure and formatting
>  - numerous register value updates and optimizations
>  drivers/iio/adc/Kconfig   |   19 +
>  drivers/iio/adc/Makefile  |    2 +
>  drivers/iio/adc/ade9000.c | 2033 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 2054 insertions(+)
>  create mode 100644 drivers/iio/adc/ade9000.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 6de2abad0197..53bdd34a5899 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -507,6 +507,25 @@ config AD9467
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called ad9467.
>  
> +config ADE9000
> +	tristate "Analog Devices ADE9000 Multiphase Energy, and Power Quality Monitoring IC Driver"
> +	depends on SPI
> +	select REGMAP_SPI
> +	select IIO_BUFFER
> +	select IIO_KFIFO_BUF
> +	help
> +	  Say yes here to build support for the Analog Devices ADE9000,
> +	  a highly accurate, multiphase energy and power quality monitoring
> +	  integrated circuit.
> +
> +	  The device features high-precision analog-to-digital converters
> +	  and digital signal processing to compute RMS values, power factor,
> +	  frequency, and harmonic analysis. It supports SPI communication
> +	  and provides buffered data output through the IIO framework.
> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called ade9000.
> +
>  config ADI_AXI_ADC
>  	tristate "Analog Devices Generic AXI ADC IP core driver"
>  	depends on MICROBLAZE || NIOS2 || ARCH_ZYNQ || ARCH_ZYNQMP || ARCH_INTEL_SOCFPGA || COMPILE_TEST
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 1c6ca5fd4b6d..98876d1ea8bf 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -20,6 +20,7 @@ obj-$(CONFIG_AD7091R5) += ad7091r5.o
>  obj-$(CONFIG_AD7091R8) += ad7091r8.o
>  obj-$(CONFIG_AD7124) += ad7124.o
>  obj-$(CONFIG_AD7173) += ad7173.o
> +obj-$(CONFIG_ADE9000) += ade9000.o
>  obj-$(CONFIG_AD7191) += ad7191.o
>  obj-$(CONFIG_AD7192) += ad7192.o
>  obj-$(CONFIG_AD7266) += ad7266.o
> @@ -46,6 +47,7 @@ obj-$(CONFIG_AD7944) += ad7944.o
>  obj-$(CONFIG_AD7949) += ad7949.o
>  obj-$(CONFIG_AD799X) += ad799x.o
>  obj-$(CONFIG_AD9467) += ad9467.o
> +obj-$(CONFIG_ADE9000) += ade9000.o
>  obj-$(CONFIG_ADI_AXI_ADC) += adi-axi-adc.o
>  obj-$(CONFIG_ASPEED_ADC) += aspeed_adc.o
>  obj-$(CONFIG_AT91_ADC) += at91_adc.o
> diff --git a/drivers/iio/adc/ade9000.c b/drivers/iio/adc/ade9000.c
> new file mode 100644
> index 000000000000..a05327119128
> --- /dev/null
> +++ b/drivers/iio/adc/ade9000.c
> @@ -0,0 +1,2033 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/**
> + * ADE9000 driver
> + *
> + * Copyright 2025 Analog Devices Inc.
> + */
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/interrupt.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/kfifo_buf.h>
> +#include <linux/iio/events.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/interrupt.h>
> +#include <linux/minmax.h>
> +#include <linux/module.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +#include <linux/unaligned.h>
> +

...

> +static int ade9000_spi_read_reg(void *context, unsigned int reg,
> +				unsigned int *val)
> +{
> +	struct device *dev = context;
> +	struct spi_device *spi = to_spi_device(dev);
> +	struct ade9000_state *st = spi_get_drvdata(spi);
> +

Why the new line? Also, why not having 'struct ade9000_state' as your
context?

> +	u16 addr;
> +	int ret = 0;
> +	struct spi_transfer xfer[] = {
> +		{
> +			.tx_buf = st->tx,
> +			.len = 2,
> +		},
> +		{
> +			.rx_buf = st->rx,
> +		},
> +	};
> +
> +	addr = FIELD_PREP(ADE9000_REG_ADDR_MASK, reg) |
> +	       ADE9000_REG_READ_BIT_MASK;
> +
> +	put_unaligned_be16(addr, st->tx);
> +
> +	if (reg > ADE9000_REG_RUN && reg < ADE9000_REG_VERSION)
> +		xfer[1].len = 4;
> +	else
> +		xfer[1].len = 6;
> +
> +	ret = spi_sync_transfer(st->spi, xfer, ARRAY_SIZE(xfer));
> +	if (ret) {
> +		dev_err(&st->spi->dev, "error reading register 0x%x",
> +			reg);
> +		return ret;
> +	}
> +
> +	if (reg > ADE9000_REG_RUN && reg < ADE9000_REG_VERSION)
> +		*val = get_unaligned_be16(st->rx);
> +	else
> +		*val = get_unaligned_be32(st->rx);
> +
> +	return 0;
> +}

...

> +
> +static int ade9000_waveform_buffer_en(struct ade9000_state *st, bool state)
> +{
> +	return regmap_update_bits(st->regmap, ADE9000_REG_WFB_CFG, BIT(4),
> +				  state ? BIT(4) : 0);
> +}

I'm not a big fan of these wrapper helpers.

> +
> +static irqreturn_t ade9000_irq0_thread(int irq, void *data)
> +{
> +	struct iio_dev *indio_dev = data;
> +	struct ade9000_state *st = iio_priv(indio_dev);
> +	s64 timestamp = iio_get_time_ns(indio_dev);
> +	u32 handled_irq = 0;
> +	u32 interrupts;
> +	u32 status;
> +	int ret;
> +
> +	ret = regmap_read(st->regmap, ADE9000_REG_STATUS0, &status);
> +	if (ret) {
> +		dev_err(&st->spi->dev, "IRQ0 read status fail");
> +		return IRQ_HANDLED;
> +	}
> +
> +	ret = regmap_read(st->regmap, ADE9000_REG_MASK0, &interrupts);
> +	if (ret) {
> +		dev_err(&st->spi->dev, "IRQ0 read status fail");
> +		return IRQ_HANDLED;
> +	}
> +
> +	if ((status & ADE9000_ST0_PAGE_FULL_BIT) &&
> +	    (interrupts & ADE9000_ST0_PAGE_FULL_BIT)) {
> +		/* Always use streaming mode */
> +		ret = ade9000_iio_push_streaming(indio_dev);
> +		if (ret) {
> +			dev_err(&st->spi->dev, "IRQ0 IIO push fail");
> +			return IRQ_HANDLED;
> +		}
> +
> +		handled_irq |= ADE9000_ST0_PAGE_FULL_BIT;
> +	}
> +
> +	if ((status & ADE9000_ST0_WFB_TRIG_BIT) &&
> +	    (interrupts & ADE9000_ST0_WFB_TRIG_BIT)) {
> +		ret = ade9000_waveform_buffer_en(st, false);
> +		if (ret) {
> +			dev_err(&st->spi->dev, "IRQ0 WFB fail");
> +			return IRQ_HANDLED;
> +		}
> +
> +		ret = ade9000_iio_push_buffer(indio_dev);

Don't we also need to make sure that buffering is enabled here?

> +		if (ret) {
> +			dev_err(&st->spi->dev, "IRQ0 IIO push fail @ WFB TRIG");
> +			return IRQ_HANDLED;
> +		}
> +
> +		handled_irq |= ADE9000_ST0_WFB_TRIG_BIT;
> +	}
> +
> +	if ((status & ADE9000_ST0_EGYRDY) &&
> +	    (interrupts & ADE9000_ST0_EGYRDY)) {
> +		iio_push_event(indio_dev,
> +			       IIO_UNMOD_EVENT_CODE(IIO_ENERGY,
> +						    ADE9000_ST0_EGYRDY,
> +						    IIO_EV_TYPE_MAG,
> +						    IIO_EV_DIR_NONE),
> +			       timestamp);
> +
> +		handled_irq |= ADE9000_ST0_EGYRDY;
> +	}
> +
> +	ret = regmap_write(st->regmap, ADE9000_REG_STATUS0, handled_irq);
> +	if (ret)
> +		dev_err(&st->spi->dev, "IRQ0 write status fail");
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t ade9000_irq1_thread(int irq, void *data)
> +{
> +	struct iio_dev *indio_dev = data;
> +	struct ade9000_state *st = iio_priv(indio_dev);
> +	unsigned int bit = ADE9000_ST1_CROSSING_FIRST;
> +	s64 timestamp = iio_get_time_ns(indio_dev);
> +	u32 handled_irq = 0;
> +	u32 interrupts;
> +	u32 result;
> +	u32 status;
> +	u32 tmp;
> +	unsigned long interrupt_bits;
> +	int ret;
> +
> +	if (!st->rst_done) {
> +		ret = regmap_read(st->regmap, ADE9000_REG_STATUS1, &result);
> +		if (ret)
> +			return ret;
> +
> +		if (result & ADE9000_ST1_RSTDONE_BIT)
> +			st->rst_done = true;

Might be sensible to use something like complete() instead of the flag
so that you can have some timeout of the reset() API.

> +		else
> +			dev_err(&st->spi->dev, "Error testing reset done");
> +
> +		return IRQ_HANDLED;
> +	}
> +
> +	ret = regmap_read(st->regmap, ADE9000_REG_STATUS1, &status);
> +	if (ret)
> +		return IRQ_HANDLED;
> +
> +	ret = regmap_read(st->regmap, ADE9000_REG_MASK1, &interrupts);
> +	if (ret) {
> +		dev_err(&st->spi->dev, "IRQ1 read status fail");
> +		return IRQ_HANDLED;
> +	}
> +
> +	interrupt_bits = interrupts;
> +	for_each_set_bit_from(bit, &interrupt_bits,
> +			      ADE9000_ST1_CROSSING_DEPTH){
> +		tmp = status & BIT(bit);
> +
> +		switch (tmp) {
> +		case ADE9000_ST1_ZXVA_BIT:
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
> +							    ADE9000_ST1_ZXVA_BIT,
> +							    IIO_EV_TYPE_THRESH,
> +							    IIO_EV_DIR_EITHER),
> +				       timestamp);
> +			handled_irq |= ADE9000_ST1_ZXVA_BIT;
> +			break;
> +		case ADE9000_ST1_ZXTOVA_BIT:
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
> +							    ADE9000_ST1_ZXTOVA_BIT,
> +							    IIO_EV_TYPE_THRESH,
> +							    IIO_EV_DIR_EITHER),
> +				       timestamp);
> +			handled_irq |= ADE9000_ST1_ZXTOVA_BIT;
> +			break;
> +		case ADE9000_ST1_ZXIA_BIT:
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(IIO_CURRENT,
> +							    ADE9000_ST1_ZXIA_BIT,
> +							    IIO_EV_TYPE_THRESH,
> +							    IIO_EV_DIR_EITHER),
> +				       timestamp);
> +			handled_irq |= ADE9000_ST1_ZXIA_BIT;
> +			break;
> +		case ADE9000_ST1_ZXVB_BIT:
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
> +							    ADE9000_ST1_ZXVB_BIT,
> +							    IIO_EV_TYPE_THRESH,
> +							    IIO_EV_DIR_EITHER),
> +				       timestamp);
> +			handled_irq |= ADE9000_ST1_ZXVB_BIT;
> +			break;
> +		case ADE9000_ST1_ZXTOVB_BIT:
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
> +							    ADE9000_ST1_ZXTOVB_BIT,
> +							    IIO_EV_TYPE_THRESH,
> +							    IIO_EV_DIR_EITHER),
> +				       timestamp);
> +			handled_irq |= ADE9000_ST1_ZXTOVB_BIT;
> +			break;
> +		case ADE9000_ST1_ZXIB_BIT:
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(IIO_CURRENT,
> +							    ADE9000_ST1_ZXIB_BIT,
> +							    IIO_EV_TYPE_THRESH,
> +							    IIO_EV_DIR_EITHER),
> +				       timestamp);
> +			handled_irq |= ADE9000_ST1_ZXIB_BIT;
> +			break;
> +		case ADE9000_ST1_ZXVC_BIT:
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
> +							    ADE9000_ST1_ZXVC_BIT,
> +							    IIO_EV_TYPE_THRESH,
> +							    IIO_EV_DIR_EITHER),
> +				       timestamp);
> +			handled_irq |= ADE9000_ST1_ZXVC_BIT;
> +			break;
> +		case ADE9000_ST1_ZXTOVC_BIT:
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
> +							    ADE9000_ST1_ZXTOVC_BIT,
> +							    IIO_EV_TYPE_THRESH,
> +							    IIO_EV_DIR_EITHER),
> +				       timestamp);
> +			handled_irq |= ADE9000_ST1_ZXTOVC_BIT;
> +			break;
> +		case ADE9000_ST1_ZXIC_BIT:
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(IIO_CURRENT,
> +							    ADE9000_ST1_ZXIC_BIT,
> +							    IIO_EV_TYPE_THRESH,
> +							    IIO_EV_DIR_EITHER),
> +				       timestamp);
> +			handled_irq |= ADE9000_ST1_ZXIC_BIT;
> +			break;
> +		case ADE9000_ST1_SWELLA_BIT:
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
> +							    ADE9000_ST1_SWELLA_BIT >> 20,
> +							    IIO_EV_TYPE_THRESH,
> +							    IIO_EV_DIR_RISING),
> +				       timestamp);
> +			handled_irq |= ADE9000_ST1_SWELLA_BIT;
> +			break;
> +		case ADE9000_ST1_SWELLB_BIT:
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
> +							    ADE9000_ST1_SWELLB_BIT >> 20,
> +							    IIO_EV_TYPE_THRESH,
> +							    IIO_EV_DIR_RISING),
> +				       timestamp);
> +			handled_irq |= ADE9000_ST1_SWELLB_BIT;
> +			break;
> +		case ADE9000_ST1_SWELLC_BIT:
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
> +							    ADE9000_ST1_SWELLC_BIT >> 20,
> +							    IIO_EV_TYPE_THRESH,
> +							    IIO_EV_DIR_RISING),
> +				       timestamp);
> +			handled_irq |= ADE9000_ST1_SWELLC_BIT;
> +			break;
> +		case ADE9000_ST1_DIPA_BIT:
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
> +							    ADE9000_ST1_DIPA_BIT >> 20,
> +							    IIO_EV_TYPE_THRESH,
> +							    IIO_EV_DIR_FALLING),
> +				       timestamp);
> +			handled_irq |= ADE9000_ST1_DIPA_BIT;
> +			break;
> +		case ADE9000_ST1_DIPB_BIT:
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
> +							    ADE9000_ST1_DIPB_BIT >> 20,
> +							    IIO_EV_TYPE_THRESH,
> +							    IIO_EV_DIR_FALLING),
> +				       timestamp);
> +			handled_irq |= ADE9000_ST1_DIPB_BIT;
> +			break;
> +		case ADE9000_ST1_DIPC_BIT:
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
> +							    ADE9000_ST1_DIPC_BIT >> 20,
> +							    IIO_EV_TYPE_THRESH,
> +							    IIO_EV_DIR_FALLING),
> +				       timestamp);
> +			handled_irq |= ADE9000_ST1_DIPC_BIT;
> +			break;
> +		case ADE9000_ST1_SEQERR_BIT:
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
> +							    ADE9000_ST1_SEQERR_BIT >> 12,
> +							    IIO_EV_TYPE_CHANGE,
> +							    IIO_EV_DIR_NONE),
> +				       timestamp);
> +			handled_irq |= ADE9000_ST1_SEQERR_BIT;
> +			break;
> +		default:
> +			return IRQ_HANDLED;
> +		}
> +	}
> +
> +	ret = regmap_write(st->regmap, ADE9000_REG_STATUS1, handled_irq);
> +	if (ret)
> +		return ret;
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t ade9000_dready_thread(int irq, void *data)
> +{
> +	struct iio_dev *indio_dev = data;
> +
> +	/* Handle data ready interrupt from C4/EVENT/DREADY pin */
> +	if (iio_buffer_enabled(indio_dev))

I think the above is potentially racy... I see two options:

1) Either you enable/disable the interrupt on the buffer setup ops
(assuming the interrupt does not need to be enabled on normal
operation).
2) Or use iio_device_claim_buffer_mode()

I think 1) is preferred (if possible). BTW, can we do it at the device
level? I mean, without having to rely on enable/disable_irq().

> +		ade9000_iio_push_buffer(indio_dev);
> +
> +	return IRQ_HANDLED;
> +}

...

> +static int ade9000_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int val,
> +			     int val2,
> +			     long mask)
> +{
> +	struct ade9000_state *st = iio_priv(indio_dev);
> +	u32 addr;
> +	u32 tmp;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		if (val != 50 && val != 60)
> +			return -EINVAL;
> +		return regmap_write(st->regmap, ADE9000_REG_ACCMODE,
> +				    (val == 60) ? ADE9000_ACCMODE_60HZ : ADE9000_ACCMODE);
> +	case IIO_CHAN_INFO_OFFSET:
> +		switch (chan->type) {
> +		case IIO_CURRENT:
> +			return regmap_write(st->regmap,
> +					    ADE9000_ADDR_ADJUST(ADE9000_REG_AIRMSOS,
> +								chan->channel), val);
> +		case IIO_VOLTAGE:
> +		case IIO_ALTVOLTAGE:
> +			return regmap_write(st->regmap,
> +					    ADE9000_ADDR_ADJUST(ADE9000_REG_AVRMSOS,
> +								chan->channel), val);
> +		case IIO_POWER:
> +			tmp = chan->address;
> +			tmp &= ~ADE9000_PHASE_B_POS_BIT;
> +			tmp &= ~ADE9000_PHASE_C_POS_BIT;
> +
> +			switch (tmp) {
> +			case ADE9000_REG_AWATTOS:
> +				return regmap_write(st->regmap,
> +						    ADE9000_ADDR_ADJUST(ADE9000_REG_AWATTOS,
> +									chan->channel), val);
> +			case ADE9000_REG_AVAR:
> +				return regmap_write(st->regmap,
> +						    ADE9000_ADDR_ADJUST(ADE9000_REG_AVAROS,
> +									chan->channel), val);
> +			case ADE9000_REG_AFVAR:
> +				return regmap_write(st->regmap,
> +						    ADE9000_ADDR_ADJUST(ADE9000_REG_AFVAROS,
> +									chan->channel), val);
> +			default:
> +				return -EINVAL;
> +			}
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_HARDWAREGAIN:
> +		switch (chan->type) {
> +		case IIO_CURRENT:
> +			return regmap_write(st->regmap,
> +					    ADE9000_ADDR_ADJUST(ADE9000_REG_AIGAIN,
> +								chan->channel), val);
> +		case IIO_VOLTAGE:
> +			return regmap_write(st->regmap,
> +					    ADE9000_ADDR_ADJUST(ADE9000_REG_AVGAIN,
> +								chan->channel), val);
> +		case IIO_POWER:
> +			return regmap_write(st->regmap,
> +					    ADE9000_ADDR_ADJUST(ADE9000_REG_APGAIN,
> +								chan->channel), val);
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		if (val > 4 || val < 1 || val == 3)
> +			return -EINVAL;
> +		addr = ADE9000_REG_PGA_GAIN;
> +		val = ilog2(val) << (chan->channel * 2 + 8);
> +		tmp = 0x3 << (chan->channel * 2 + 8);

I guess the above deserves a comment about what's going on.

> +		return regmap_update_bits(st->regmap, addr, tmp, val);
> +	default:
> +		return -EINVAL;
> +	}
> +}

Also have to ask: Will any of the above possible interfere with the
device has events enabled or is buffering? Basically should we use the
iio_claim_direct() functions?

> +
> +static int ade9000_reg_access(struct iio_dev *indio_dev,
> +			      unsigned int reg,
> +			      unsigned int tx_val,
> +			      unsigned int *rx_val)
> +{
> +	struct ade9000_state *st = iio_priv(indio_dev);
> +
> +	if (rx_val)
> +		return regmap_read(st->regmap, reg, rx_val);
> +
> +	return regmap_write(st->regmap, reg, tx_val);
> +}
> +
> +static int ade9000_read_event_config(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir)
> +{
> +	struct ade9000_state *st = iio_priv(indio_dev);
> +	u32 interrupts0, interrupts1, number;
> +	int ret;
> +
> +	ret = regmap_read(st->regmap, ADE9000_REG_MASK0, &interrupts0);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(st->regmap, ADE9000_REG_MASK1, &interrupts1);
> +	if (ret)
> +		return ret;
> +
> +	if (type == IIO_EV_TYPE_MAG)
> +		return (interrupts0 & ADE9000_ST0_EGYRDY);
> +
> +	if (type == IIO_EV_TYPE_CHANGE)
> +		return (interrupts1 & ADE9000_ST1_SEQERR_BIT);
> +
> +	number = chan->channel;

nit: new line

> +	switch (number) {
> +	case ADE9000_PHASE_A_NR:
> +		if (chan->type == IIO_VOLTAGE) {
> +			if (dir == IIO_EV_DIR_EITHER)
> +				return (interrupts1 & ADE9000_ST1_ZXVA_BIT);
> +			if (dir == IIO_EV_DIR_NONE)
> +				return (interrupts1 & ADE9000_ST1_ZXTOVA_BIT);
> +			if (dir == IIO_EV_DIR_RISING)
> +				return (interrupts1 & ADE9000_ST1_SWELLA_BIT);
> +			if (dir == IIO_EV_DIR_FALLING)
> +				return (interrupts1 & ADE9000_ST1_DIPA_BIT);
> +		} else if (chan->type == IIO_CURRENT) {
> +			return (interrupts1 & ADE9000_ST1_ZXIA_BIT);
> +		}
> +		break;
> +	case ADE9000_PHASE_B_NR:
> +		if (chan->type == IIO_VOLTAGE) {
> +			if (dir == IIO_EV_DIR_EITHER)
> +				return (interrupts1 & ADE9000_ST1_ZXVB_BIT);
> +			if (dir == IIO_EV_DIR_NONE)
> +				return (interrupts1 & ADE9000_ST1_ZXTOVB_BIT);
> +			if (dir == IIO_EV_DIR_RISING)
> +				return (interrupts1 & ADE9000_ST1_SWELLB_BIT);
> +			if (dir == IIO_EV_DIR_FALLING)
> +				return (interrupts1 & ADE9000_ST1_DIPB_BIT);
> +		} else if (chan->type == IIO_CURRENT) {
> +			return (interrupts1 & ADE9000_ST1_ZXIB_BIT);
> +		}
> +		break;
> +	case ADE9000_PHASE_C_NR:
> +		if (chan->type == IIO_VOLTAGE) {
> +			if (dir == IIO_EV_DIR_EITHER)
> +				return (interrupts1 & ADE9000_ST1_ZXVC_BIT);
> +			if (dir == IIO_EV_DIR_NONE)
> +				return (interrupts1 & ADE9000_ST1_ZXTOVC_BIT);
> +			if (dir == IIO_EV_DIR_RISING)
> +				return (interrupts1 & ADE9000_ST1_SWELLC_BIT);
> +			if (dir == IIO_EV_DIR_FALLING)
> +				return (interrupts1 & ADE9000_ST1_DIPC_BIT);
> +		} else if (chan->type == IIO_CURRENT) {
> +			return (interrupts1 & ADE9000_ST1_ZXIC_BIT);
> +		}
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ade9000_write_event_config(struct iio_dev *indio_dev,
> +				      const struct iio_chan_spec *chan,
> +				      enum iio_event_type type,
> +				      enum iio_event_direction dir,
> +				      bool state)
> +{
> +	struct ade9000_state *st = iio_priv(indio_dev);
> +	u32 interrupts, tmp;
> +	int ret;
> +	struct irq_wfb_trig {
> +		u32 irq;
> +		u32 wfb_trg;
> +	};
> +
> +	ret = regmap_write(st->regmap, ADE9000_REG_STATUS1, GENMASK(31, 0));
> +	if (ret)
> +		return ret;
> +
> +	if (type == IIO_EV_TYPE_MAG) {
> +		ret = regmap_update_bits(st->regmap, ADE9000_REG_STATUS0,
> +					 ADE9000_ST0_EGYRDY, ADE9000_ST0_EGYRDY);
> +		if (ret)
> +			return ret;
> +		return regmap_update_bits(st->regmap, ADE9000_REG_MASK0,
> +					 ADE9000_ST0_EGYRDY,
> +					 state ? ADE9000_ST1_SEQERR_BIT : 0);
> +	}
> +
> +	if (type == IIO_EV_TYPE_CHANGE)
> +		return regmap_update_bits(st->regmap, ADE9000_REG_MASK1,
> +					 ADE9000_ST1_SEQERR_BIT,
> +					 state ? ADE9000_ST1_SEQERR_BIT : 0);
> +
> +	struct irq_wfb_trig trig_arr[6] = {
> +		{
> +			.irq = ADE9000_ST1_ZXVA_BIT,
> +			.wfb_trg = ADE9000_WFB_TRG_ZXVA_BIT
> +		}, {
> +			.irq = ADE9000_ST1_ZXIA_BIT,
> +			.wfb_trg = ADE9000_WFB_TRG_ZXIA_BIT
> +		}, {
> +			.irq = ADE9000_ST1_ZXVB_BIT,
> +			.wfb_trg = ADE9000_WFB_TRG_ZXVB_BIT
> +		}, {
> +			.irq = ADE9000_ST1_ZXIB_BIT,
> +			.wfb_trg = ADE9000_WFB_TRG_ZXIB_BIT
> +		}, {
> +			.irq = ADE9000_ST1_ZXVC_BIT,
> +			.wfb_trg = ADE9000_WFB_TRG_ZXVC_BIT
> +		}, {
> +			.irq = ADE9000_ST1_ZXIC_BIT,
> +			.wfb_trg = ADE9000_WFB_TRG_ZXIC_BIT
> +		},
> +	};

Not seeing any reason for the mixed code declaration.

> +
> +	if (dir == IIO_EV_DIR_EITHER) {
> +		if (state) {
> +			interrupts |= trig_arr[chan->channel * 2 + chan->type].irq;
> +			st->wfb_trg |= trig_arr[chan->channel * 2 + chan->type].wfb_trg;
> +		} else {
> +			interrupts &= ~trig_arr[chan->channel * 2 + chan->type].irq;
> +			st->wfb_trg &= ~trig_arr[chan->channel * 2 + chan->type].wfb_trg;
> +		}
> +	if (dir == IIO_EV_DIR_NONE) {
> +		switch (chan->channel) {
> +		case ADE9000_PHASE_A_NR:
> +			interrupts |= ADE9000_ST1_ZXTOVA_BIT;
> +			break;
> +		case ADE9000_PHASE_B_NR:
> +			interrupts |= ADE9000_ST1_ZXTOVB_BIT;
> +			break;
> +		case ADE9000_PHASE_C_NR:
> +			interrupts |= ADE9000_ST1_ZXTOVC_BIT;
> +			break;
> +		default:
> +			break;
> +		}
> +
> +		if (state)
> +			interrupts |= tmp;
> +		else
> +			interrupts &= ~tmp;
> +	}

Yeah, something is odd with the above. I guess you missed to indent the
above condition.

> +	} else if (dir == IIO_EV_DIR_RISING) {

ups...

> +		switch (chan->channel) {
> +		case ADE9000_PHASE_A_NR:
> +			tmp |= ADE9000_ST1_SWELLA_BIT;
> +			break;
> +		case ADE9000_PHASE_B_NR:
> +			tmp |= ADE9000_ST1_SWELLB_BIT;
> +			break;
> +		case ADE9000_PHASE_C_NR:
> +			tmp |= ADE9000_ST1_SWELLC_BIT;
> +			break;
> +		default:
> +			break;
> +		}
> +
> +		if (state) {
> +			interrupts |= tmp;
> +			st->wfb_trg |= ADE9000_WFB_TRG_SWELL_BIT;
> +		} else {
> +			interrupts &= ~tmp;
> +			st->wfb_trg &= ~ADE9000_WFB_TRG_SWELL_BIT;
> +		}
> +
> +	} else if (dir == IIO_EV_DIR_FALLING) {
> +		switch (chan->channel) {
> +		case ADE9000_PHASE_A_NR:
> +			tmp |= ADE9000_ST1_DIPA_BIT;
> +			break;
> +		case ADE9000_PHASE_B_NR:
> +			tmp |= ADE9000_ST1_DIPB_BIT;
> +			break;
> +		case ADE9000_PHASE_C_NR:
> +			tmp |= ADE9000_ST1_DIPC_BIT;
> +			break;
> +		default:
> +			break;
> +		}
> +
> +		if (state) {
> +			interrupts |= tmp;
> +			st->wfb_trg |= ADE9000_WFB_TRG_DIP_BIT;
> +		} else {
> +			interrupts &= ~tmp;
> +			st->wfb_trg &= ~ADE9000_WFB_TRG_DIP_BIT;
> +		}
> +	}

nit: new line

> +	return regmap_update_bits(st->regmap, ADE9000_REG_MASK1, interrupts,
> +				  interrupts);
> +}
> +

...

> +
> +static int ade9000_waveform_buffer_interrupt_setup(struct ade9000_state *st)
> +{
> +	int ret;
> +
> +	ret = regmap_write(st->regmap, ADE9000_REG_WFB_TRG_CFG, 0x0);
> +	if (ret)
> +		return ret;
> +
> +	/* Always use streaming mode setup */
> +	ret = regmap_write(st->regmap, ADE9000_REG_WFB_PG_IRQEN,
> +			   ADE9000_MIDDLE_PAGE_BIT);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, ADE9000_REG_STATUS0, GENMASK(31, 0));
> +	if (ret)
> +		return ret;
> +
> +	return regmap_update_bits(st->regmap, ADE9000_REG_MASK0,
> +				  ADE9000_ST0_PAGE_FULL_BIT,
> +				  ADE9000_ST0_PAGE_FULL_BIT);

The above looks like regmap_set_bits()?

> +}
> +
> +static int ade9000_buffer_preenable(struct iio_dev *indio_dev)
> +{
> +	struct ade9000_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = ade9000_waveform_buffer_config(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	st->wfb_nr_samples = ADE9000_WFB_MAX_SAMPLES_CHAN *
> +			     st->wfb_nr_activ_chan;

If not passing the 101 limit, I would do this in one liner. To me this
is one of those cases where readability is hurt.

> +
> +	ret = ade9000_configure_scan(indio_dev, ADE9000_REG_WF_BUFF);
> +	if (ret)
> +		return ret;
> +
> +	ret = ade9000_waveform_buffer_interrupt_setup(st);
> +	if (ret)
> +		return ret;
> +
> +	ret = ade9000_waveform_buffer_en(st, true);
> +	if (ret) {
> +		dev_err(&st->spi->dev, "Post-enable waveform buffer enable fail");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ade9000_buffer_postdisable(struct iio_dev *indio_dev)
> +{
> +	struct ade9000_state *st = iio_priv(indio_dev);
> +	u32 interrupts;
> +	int ret;
> +
> +	ret = ade9000_waveform_buffer_en(st, false);
> +	if (ret) {
> +		dev_err(&st->spi->dev, "Post-disable waveform buffer disable fail");

Again (I started the review from bottom :)), I would log any meaningful
error insinde the helper. Ditto for all other places.

> +		return ret;
> +	}
> +
> +	ret = regmap_write(st->regmap, ADE9000_REG_WFB_TRG_CFG, 0x0);
> +	if (ret)
> +		return ret;
> +
> +	interrupts = ADE9000_ST0_WFB_TRIG_BIT | ADE9000_ST0_PAGE_FULL_BIT;
> +
> +	return regmap_update_bits(st->regmap, ADE9000_REG_MASK0, interrupts, 0);
> +	if (ret) {
> +		dev_err(&st->spi->dev, "Post-disable update maks0 fail");
> +		return ret;
> +	}
> +
> +	return regmap_write(st->regmap, ADE9000_REG_STATUS0, GENMASK(31, 0));
> +}
> +
> +static int ade9000_reset(struct ade9000_state *st)
> +{
> +	struct gpio_desc *gpio_reset;
> +	int ret;
> +
> +	st->rst_done = false;
> +
> +	gpio_reset = devm_gpiod_get_optional(&st->spi->dev, "reset",
> +					     GPIOD_OUT_HIGH);
> +	if (IS_ERR(gpio_reset))
> +		return PTR_ERR(gpio_reset);
> +
> +	if (gpio_reset) {
> +		gpiod_set_value_cansleep(gpio_reset, 1);

No need for the above. You already request the gpio with GPIOD_OUT_HIGH
which means you ask for it in the asserted state. Hence you just need to
bring the device out of reset.

> +		fsleep(10);
> +		gpiod_set_value_cansleep(gpio_reset, 0);
> +		fsleep(50000);
> +	} else {
> +		ret = regmap_update_bits(st->regmap, ADE9000_REG_CONFIG1,
> +					 ADE9000_SWRST_BIT, ADE9000_SWRST_BIT);
> +		if (ret)
> +			return ret;
> +		fsleep(90);
> +	}
> +
> +	if (!st->rst_done)
> +		return -EIO;
> +
> +	return 0;
> +}
> +
> +static int ade9000_setup(struct ade9000_state *st)
> +{
> +	int ret;
> +
> +	ret = regmap_multi_reg_write(st->regmap, ade9000_reg_sequence,
> +				     ARRAY_SIZE(ade9000_reg_sequence));
> +	if (ret)
> +		return ret;
> +
> +	msleep_interruptible(2);

Why interruptible? I would also use fsleep(). 2ms is not really meant
for msleep().

> +
> +	/* Clear all pending status bits by writing 1s */
> +	ret = regmap_write(st->regmap, ADE9000_REG_STATUS0, GENMASK(31, 0));
> +	if (ret)
> +		return ret;
> +
> +	return regmap_write(st->regmap, ADE9000_REG_STATUS1, GENMASK(31, 0));
> +}
> +
> +static const struct iio_buffer_setup_ops ade9000_buffer_ops = {
> +	.preenable = &ade9000_buffer_preenable,
> +	.postdisable = &ade9000_buffer_postdisable,
> +};
> +
> +static const struct iio_info ade9000_info = {
> +	.read_raw = ade9000_read_raw,
> +	.write_raw = ade9000_write_raw,
> +	.debugfs_reg_access = ade9000_reg_access,
> +	.write_event_config = ade9000_write_event_config,
> +	.read_event_config = ade9000_read_event_config,
> +	.write_event_value = ade9000_write_event_value,
> +	.read_event_value = ade9000_read_event_value,
> +};
> +
> +static const struct regmap_config ade9000_regmap_config = {
> +	.reg_bits = 16,
> +	.val_bits = 32,
> +	.zero_flag_mask = true,
> +	.cache_type = REGCACHE_RBTREE,
> +	.reg_read = ade9000_spi_read_reg,
> +	.reg_write = ade9000_spi_write_reg,
> +	.volatile_reg = ade9000_is_volatile_reg,
> +};
> +
> +static int ade9000_probe(struct spi_device *spi)
> +{
> +	struct device *dev = &spi->dev;
> +	struct iio_dev *indio_dev;
> +	struct ade9000_state *st;
> +	struct regmap *regmap;
> +	int irq;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return dev_err_probe(dev, -ENOMEM, "Unable to allocate ADE9000 IIO");

nit: new line

> +	st = iio_priv(indio_dev);
> +
> +	regmap = devm_regmap_init(dev, NULL, spi, &ade9000_regmap_config);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(dev, PTR_ERR(regmap), "Unable to allocate ADE9000 regmap");

nit: new line

> +	spi_set_drvdata(spi, st);
> +
> +	irq = fwnode_irq_get_byname(dev_fwnode(dev), "irq0");
> +	if (irq < 0)
> +		return dev_err_probe(dev, -EINVAL, "Unable to find irq0");
> +
> +	ret = devm_request_threaded_irq(dev, irq, NULL,
> +					ade9000_irq0_thread,
> +					IRQF_ONESHOT,
> +					KBUILD_MODNAME, indio_dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to request threaded irq: %d", ret);
> +
> +	irq = fwnode_irq_get_byname(dev_fwnode(dev), "irq1");
> +	if (irq < 0)
> +		return dev_err_probe(dev, -EINVAL, "Unable to find irq1");
> +
> +	ret = devm_request_threaded_irq(dev, irq, NULL,
> +					ade9000_irq1_thread,
> +					IRQF_ONESHOT,
> +					KBUILD_MODNAME, indio_dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to request threaded irq: %d", ret);
> +
> +	irq = fwnode_irq_get_byname(dev_fwnode(dev), "dready");
> +	if (irq < 0)
> +		return dev_err_probe(dev, -EINVAL, "Unable to find dready");
> +
> +	ret = devm_request_threaded_irq(dev, irq, NULL,
> +					ade9000_dready_thread,
> +					IRQF_ONESHOT,
> +					KBUILD_MODNAME, indio_dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to request threaded irq: %d", ret);

You could likely have an helper function to handle the above. By passing
the IRQ handler and the property string you would not need to do it
three times (If I'm not missing nothing).

> +
> +	st->spi = spi;
> +
> +	/* Optional external clock input */
> +	st->clkin = devm_clk_get_optional_enabled(dev, "clkin");
> +	if (IS_ERR(st->clkin))
> +		return dev_err_probe(dev, PTR_ERR(st->clkin), "Failed to get and enable clkin: %ld", PTR_ERR(st->clkin));
> +
> +	/* Register clock output provider */
> +	if (device_property_present(dev, "#clock-cells")) {
> +		struct clk_init_data clk_init = {};
> +		struct clk *clkout;
> +		unsigned long parent_rate = 24576000; /* Default crystal frequency */
> +
> +		if (st->clkin)
> +			parent_rate = clk_get_rate(st->clkin);
> +
> +		clk_init.name = "clkout";

If we have multiple devices the above might fail. I wooud the same as
in:

https://elixir.bootlin.com/linux/v6.16/source/drivers/iio/frequency/adf4350.c#L467

> +		clk_init.ops = &ade9000_clkout_ops;
> +		clk_init.flags = CLK_GET_RATE_NOCACHE;
> +		clk_init.num_parents = 0;
> +
> +		st->clkout_hw.init = &clk_init;
> +
> +		clkout = devm_clk_register(dev, &st->clkout_hw);
> +		if (IS_ERR(clkout))
> +			return dev_err_probe(dev, PTR_ERR(clkout), "Failed to register clkout: %ld", PTR_ERR(clkout));
> +
> +		ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, &st->clkout_hw);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "Failed to add clock provider: %d", ret);
> +	}

nit: I would move the abov to it's own function.

> +
> +	indio_dev->name = spi_get_device_id(spi)->name;

I tend to prefer a literal string here. And move it to something like
chip_info->name if we add more chips to the driver.

> +	indio_dev->dev.parent = &st->spi->dev;

No need for the above line

> +	indio_dev->info = &ade9000_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
> +	indio_dev->setup_ops = &ade9000_buffer_ops;
> +
> +	st->regmap = regmap;
> +
> +	ret = devm_regulator_get_enable(&spi->dev, "vdd");
> +	if (ret)
> +		return dev_err_probe(&spi->dev, ret,
> +				     "Failed to get and enable vdd regulator\n");
> +
> +	ret = devm_regulator_get_enable_optional(dev, "vref");
> +	if (ret < 0 && ret != -ENODEV)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to get and enable vref regulator\n");
> +
> +	/* Configure reference selection based on vref regulator availability */
> +	if (ret != -ENODEV) {
> +		ret = regmap_update_bits(st->regmap, ADE9000_REG_CONFIG1,
> +					 ADE9000_EXT_REF_MASK,
> +					 ADE9000_EXT_REF_MASK);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	indio_dev->channels = ade9000_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(ade9000_channels);

nit: new line

> +	ret = devm_iio_kfifo_buffer_setup(dev, indio_dev,
> +					  &ade9000_buffer_ops);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to setup IIO buffer");
> +
> +	ret = ade9000_reset(st);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "ADE9000 reset failed");

I would very much prefer to do any logging inside ade9000_reset() and
here just 'return ret'

> +
> +	ret = ade9000_setup(st);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Unable to setup ADE9000");

ditto.

- Nuno Sá

