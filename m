Return-Path: <linux-iio+bounces-10816-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D389A53EA
	for <lists+linux-iio@lfdr.de>; Sun, 20 Oct 2024 13:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4588E1C20971
	for <lists+linux-iio@lfdr.de>; Sun, 20 Oct 2024 11:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537D9192584;
	Sun, 20 Oct 2024 11:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rCPRz0/i"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1455EEC5;
	Sun, 20 Oct 2024 11:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729425383; cv=none; b=uoTJdPg92r1ZLY/QtW+GJYVWm6GRvJjmtUom+m1LRuPL2Bhie5LmIMHP8pvaOqfnaMebte319l/l/uPbLs8D+lK0P1xb6myWqlecDGEuLxWX/enLkBLgVvirT/oGdd6i4XEXlMsZSBra49xuG90H8XS9WRwdxfY0DvPZee45dog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729425383; c=relaxed/simple;
	bh=+0p5NkerOmvHfi35QPuQhFjpevnJp/owSssWdYHgSGM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JRJ0QhRgG+LmkLdDePuT5AY0Z8dCjfQDOhllFwq+3BIwzVHqaY+2IOHE4dFtyk3LtHJIB3zqu80IYZ4GXI3gGV3p6DGYnlnVbs3WfIqzhwAdHxaSXHGYowpdHwlwTGTNn/ufCPUTFyRDXLT2C9G61/Mtknlpf1BlUoiPRkaS0U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rCPRz0/i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB26BC4CEC6;
	Sun, 20 Oct 2024 11:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729425382;
	bh=+0p5NkerOmvHfi35QPuQhFjpevnJp/owSssWdYHgSGM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rCPRz0/iXnI9k/4NroLOaILStRwtaHc60W60TVkQczROmUVPGfyvETOQDxNMvIYbD
	 yTLEJi0vX7vSD/ooet7e59kMrwLprqFUEiTO+/yOBMCP1HoYdZKnTEKcE/nacAcj+0
	 87l/o84GdkwxNNitIK+yX9XQyNgJAglKm1mfLZCEmQ5qr6FjLya4PMgfGGJxEgA9Z9
	 GI8hniQwmdREMyohHrDxNsbDIZyBiCOk+jVvKRPzJsmX7Rsh4jKx+GIplVWdsjZc+m
	 Rtt2k0p2kmK/yBiyALS2AjVD4mgcU7c4mXyskAV65yjr44XBARCT56mgw19oUAKYeV
	 rXObioLHHMdkw==
Date: Sun, 20 Oct 2024 12:56:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ramona Alexandra Nechita <ramona.nechita@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Cosmin Tanislav
 <cosmin.tanislav@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Alexandru Ardelean
 <alexandru.ardelean@analog.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Nuno Sa
 <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>, George Mois
 <george.mois@analog.com>, Ana-Maria Cusco <ana-maria.cusco@analog.com>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>
Subject: Re: [PATCH v7 3/3] drivers: iio: adc: add support for ad777x family
Message-ID: <20241020125437.72c1de38@jic23-huawei>
In-Reply-To: <20241014143204.30195-4-ramona.nechita@analog.com>
References: <20241014143204.30195-1-ramona.nechita@analog.com>
	<20241014143204.30195-4-ramona.nechita@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Oct 2024 17:32:00 +0300
Ramona Alexandra Nechita <ramona.nechita@analog.com> wrote:

> Add support for AD7770, AD7771, AD7779 ADCs. The device is capable of
> sending out data both on DOUT lines interface,as on the SDO line.
> The driver currently implements only the SDO data streaming mode. SPI
> communication is used alternatively for accessing registers and streaming
> data. Register accesses are protected by crc8.
> 
> Signed-off-by: Ramona Alexandra Nechita <ramona.nechita@analog.com>

A few comments inline.  I also tweaked white space in a few places
whilst applying.  Target in IIO is still sub 80 chars whenever it
doesn't hurt readability.

Also, you had unusual formatting for some of the macros. Avoid mixing
tabs then spaces for indentation of the \ 

series applied to the togreg branch of iio.git and initially pushed
out as testing so 0-day can take a look.

One missing return in the debugfs register access as well. Please
check I fixed that up correctly.

Thanks,

Jonathan

> diff --git a/drivers/iio/adc/ad7779.c b/drivers/iio/adc/ad7779.c
> new file mode 100644
> index 000000000000..5904cc669f3a
> --- /dev/null
> +++ b/drivers/iio/adc/ad7779.c
> @@ -0,0 +1,909 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * AD7770, AD7771, AD7779 ADC
> + *
> + * Copyright 2023-2024 Analog Devices Inc.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bitmap.h>
> +#include <linux/clk.h>
> +#include <linux/crc8.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/math.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +#include <linux/string.h>
> +#include <linux/types.h>
> +#include <linux/units.h>
> +
> +#include <asm/unaligned.h>

This moved, I'll fix up.

> +	{								       \
> +		.type = IIO_VOLTAGE,					       \
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_CALIBSCALE)  |	       \
> +				      BIT(IIO_CHAN_INFO_CALIBBIAS),	       \
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),       \

It's not technically an ABI issue, but ususual to have an ADC driver that provides
no direct readings via sysfs and also provides no indication of channel scaling.

A quick glance at the datasheet suggests there is a PGA in the path, so perhaps
you plan to add scaling later.  Raw reads of single channels would I think
have to just select from the bulk channel read back so not that trivial to implement.
Maybe worth doing longer term though as that is a useful debug interface if nothing
else.

Anyhow, I'm fine with taking the driver with the current feature set
I was just a bit surprised at which features were implemented.

> +		.address = (index),					       \
> +		.indexed = 1,						       \
> +		.channel = (index),					       \
> +		.scan_index = (index),					       \
> +		.ext_info = (_ext_info),				       \
> +		.scan_type = {						       \
> +			.sign = 's',					       \
> +			.realbits = 24,					       \
> +			.storagebits = 32,				       \
> +			.endianness = IIO_BE,				   \
> +		},								\
> +	}
> +
> +#define AD777x_CHAN_NO_FILTER_S(index)					       \
> +	AD777x_CHAN_S(index, NULL)
> +
> +#define AD777x_CHAN_FILTER_S(index)					       \
> +	AD777x_CHAN_S(index, ad7779_ext_filter)
> +static const struct iio_chan_spec ad7779_channels[] = {
> +	AD777x_CHAN_NO_FILTER_S(0),
> +	AD777x_CHAN_NO_FILTER_S(1),
> +	AD777x_CHAN_NO_FILTER_S(2),
> +	AD777x_CHAN_NO_FILTER_S(3),
> +	AD777x_CHAN_NO_FILTER_S(4),
> +	AD777x_CHAN_NO_FILTER_S(5),
> +	AD777x_CHAN_NO_FILTER_S(6),
> +	AD777x_CHAN_NO_FILTER_S(7),
> +	IIO_CHAN_SOFT_TIMESTAMP(8),
> +};
> +
> +static const struct iio_chan_spec ad7779_channels_filter[] = {
> +	AD777x_CHAN_FILTER_S(0),
> +	AD777x_CHAN_FILTER_S(1),
> +	AD777x_CHAN_FILTER_S(2),
> +	AD777x_CHAN_FILTER_S(3),
> +	AD777x_CHAN_FILTER_S(4),
> +	AD777x_CHAN_FILTER_S(5),
> +	AD777x_CHAN_FILTER_S(6),
> +	AD777x_CHAN_FILTER_S(7),
> +	IIO_CHAN_SOFT_TIMESTAMP(8),
> +};

