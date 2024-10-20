Return-Path: <linux-iio+bounces-10815-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0B99A53E7
	for <lists+linux-iio@lfdr.de>; Sun, 20 Oct 2024 13:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 842321C2098F
	for <lists+linux-iio@lfdr.de>; Sun, 20 Oct 2024 11:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B5F191F7C;
	Sun, 20 Oct 2024 11:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8XqYg1O"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72E2158218;
	Sun, 20 Oct 2024 11:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729425284; cv=none; b=DEzk/ZPfSWPAhSuouyP7brBhlYkk8RTWIKveBeMhXFSMYuHODWdgWzPBzo9twN+UFs9f5e7ffhLFcEkD2b8OcYtgu8Sy1MITW51zexDsbfpqHahSHOqso8oURxUtNbmHZYZ6yeV2FiU+qifK7NZOo2yxacaMaCrKoZLj9lD8n6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729425284; c=relaxed/simple;
	bh=9OsH+p90AXrfDXBV285K5elUYwwAbWh750l1tDLivtI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=acVtIWrs6j4WJsClkji2h5AML2cRsHYhzPru1FrubrB+zJ9jvLuY/LsaE/7y0XvOsmvsw3IXziROLrh6rRY7/B/Spquy3ehBeiKjM2D0Y9+xWgRGarQXzNG0EhB3t1xCllW/wBFNn6GcldxDOXhG7wazzjz52PgLzNXO8/dI91M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8XqYg1O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0063C4CEC6;
	Sun, 20 Oct 2024 11:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729425284;
	bh=9OsH+p90AXrfDXBV285K5elUYwwAbWh750l1tDLivtI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b8XqYg1O+w+dI7v7R/UKyONeoCUFdXLlEpxWmSmJdAcY0JAuzdOkMc5MHA1VplHPx
	 K893/FkNPedNRHD/jFDqJsIbKL/7xfdMuY+sS6gEnoTvZVHE8xuPghw0jQgn6MBJFn
	 1YZxUGYrlycXIvAIuFfx0kLRr8Aiegw3vbLWubZ8Iplml0hYdSRuTxODn/AjyKMad2
	 9P7P1UO3Gxg54SxCIJSSlOFDoDy4iZ4gwOO+7zVF93/1qgzhRSOKkLe4uSFFJqjZ6O
	 AEHv7H85emIpifUb+KAyyceZ78iMbI5uow9ArPTW2rsPO5LjgXs+sZg7dnqPNzp2TA
	 eemgC9mjb4otA==
Date: Sun, 20 Oct 2024 12:54:37 +0100
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

