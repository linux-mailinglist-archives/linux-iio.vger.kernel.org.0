Return-Path: <linux-iio+bounces-7067-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C0391CED1
	for <lists+linux-iio@lfdr.de>; Sat, 29 Jun 2024 21:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAFB7282C5F
	for <lists+linux-iio@lfdr.de>; Sat, 29 Jun 2024 19:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17B813A24F;
	Sat, 29 Jun 2024 19:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBWzCCzZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4E42032B;
	Sat, 29 Jun 2024 19:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719688813; cv=none; b=eql3/DS4qXJ1yQDFZWhK6uF++JnvZv6GAMXA1add2bDXVvfZhHm4g4PvbxayxYi0o+eWeya9SA0ez5sNDci19rRTmcUNeJO50a/QYtVdj7FKjjEpsVd6GoMf6Zex/LQCPLS3tE0JM8n5hPJdbxlaeBtoyiiu2nbDyhL2UXe+mDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719688813; c=relaxed/simple;
	bh=wRvXwFpjMk49/1hYA902bRfJAPy5fRzdywX1EOjiHaM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RhuL1EbnlFQM76K5WHRVCOMC99cFC7gDjtqpfMjFPeSHy89RfXXKC+6KyGRwkJ5NAfeu4mEfgfZSIEeBTsDFToleV0RM2Gqz8IHt36i5sxMl2eg/0QlCuhnpOhSdkbvP9z1vd3h3ik7F3lk1P/Um1FkjQ+uuG+F0h8+qIxCxx98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBWzCCzZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34E86C2BBFC;
	Sat, 29 Jun 2024 19:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719688813;
	bh=wRvXwFpjMk49/1hYA902bRfJAPy5fRzdywX1EOjiHaM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aBWzCCzZFi7hzL53EZT5AeSL67dxirSJZod2SioZTg/5qTAEuDSZeSitqFOr7xoWC
	 ZSEqK/aCeuWw7WSVGr2t4hSXkVuFF7sHriXnBj0SEuOJQknEENWpOXy3IKqz629W3Q
	 uCxVnbbgqplq9AB+BrIdZZMruDmvb/lti3fGA4OXxDyC6OQYiyRb+E9ZfI3K/fdiEO
	 3FFDXcMJoUNx9a2gfKifBnZeHq13UDlWgNdgUGCTwdhoOfON3HyNH8BTGgoG351XBl
	 pkmClWVzNIW4V8aiy3W182h4ekOxoOWwW+V0+UWJO/zr8FN86x8GKgYG9WxgnWuVY8
	 lcV5RGLFPKpgQ==
Date: Sat, 29 Jun 2024 20:20:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Michael Hennerich
 <michael.hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Ramona Gradinariu <ramona.gradinariu@analog.com>
Subject: Re: [PATCH v3 2/3] iio: adc: ad4695: Add driver for AD4695 and
 similar ADCs
Message-ID: <20240629202003.1b72f0d0@jic23-huawei>
In-Reply-To: <20240624-iio-adc-ad4695-v3-2-a22c302f06bf@baylibre.com>
References: <20240624-iio-adc-ad4695-v3-0-a22c302f06bf@baylibre.com>
	<20240624-iio-adc-ad4695-v3-2-a22c302f06bf@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Jun 2024 17:01:54 -0500
David Lechner <dlechner@baylibre.com> wrote:

> This is a new driver for Analog Devices Inc. AD4695 and similar ADCs.
> The initial driver supports initializing the chip including configuring
> all possible LDO and reference voltage sources as well as any possible
> voltage input channel wiring configuration.
> 
> Only the 4-wire SPI wiring mode where the CNV pin is tied to the CS pin
> is supported at this time. And reading sample data from the ADC can only
> be done in direct mode for now.
> 
> Co-developed-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Some minor bits an pieces from me.

> diff --git a/drivers/iio/adc/ad4695.c b/drivers/iio/adc/ad4695.c
> new file mode 100644
> index 000000000000..72ab5b997f6e
> --- /dev/null
> +++ b/drivers/iio/adc/ad4695.c
> @@ -0,0 +1,730 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * SPI ADC driver for Analog Devices Inc. AD4695 and similar chips
> + *
> + * https://www.analog.com/en/products/ad4695.html
> + * https://www.analog.com/en/products/ad4696.html
> + * https://www.analog.com/en/products/ad4697.html
> + * https://www.analog.com/en/products/ad4698.html
> + *
> + * Copyright 2024 Analog Devices Inc.
> + * Copyright 2024 BayLibre, SAS
> + */
> +
> +#include <dt-bindings/iio/adi,ad4695.h>

Stick driver specific includes after linux ones.
Probably a blank line in between as well.

> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/compiler.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +#include <linux/units.h>
> +

> +
> +/**
> + * ad4695_read_one_sample - Read a single sample using single-cycle mode
> + * @st: The AD4695 state
> + * @address: The address of the channel to read
> + *
> + * Upon return, the sample will be stored in the raw_data field of @st.
> + *
> + * Context: can sleep, must be called with iio_device_claim_direct held
> + * Return: 0 on success, a negative error code on failure
> + */
> +static int ad4695_read_one_sample(struct ad4695_state *st, unsigned int address)
> +{
> +	struct spi_transfer xfer[2] = { };
> +	int ret;
> +
> +	ret = ad4695_set_single_cycle_mode(st, address);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Setting the first channel to the temperature channel isn't supported
> +	 * in single-cycle mode, so we have to do an extra xfer to read the
> +	 * temperature.
> +	 */
> +	if (address == AD4695_CMD_TEMP_CHAN) {
> +		/* We aren't reading, so we can make this a short xfer. */
I'd be tempted to let the compiler figure out it can combine storage for xfer and
do something like
		struct spi_transfer xfer[2] = {
			{
				.bits_per_word = 8,
				.tx_buf = ...

			}, {
			},
		};

		st->cnv_cmd2 = ...
etc

Advantage is that it is clearly structured data.   Up to you though to
decide if this is worth doing. I don't care that much!


> +		st->cnv_cmd2 = AD4695_CMD_TEMP_CHAN << 3;
> +		xfer[0].bits_per_word = 8;
> +		xfer[0].tx_buf = &st->cnv_cmd2;
> +		xfer[0].len = 1;
> +		xfer[0].cs_change = 1;
> +		xfer[0].cs_change_delay.value = AD4695_T_CONVERT_NS;
> +		xfer[0].cs_change_delay.unit = SPI_DELAY_UNIT_NSECS;
> +
> +		/* Then read the result and exit conversion mode. */
> +		st->cnv_cmd = AD4695_CMD_EXIT_CNV_MODE << 11;
> +		xfer[1].bits_per_word = 16;
> +		xfer[1].tx_buf = &st->cnv_cmd;
> +		xfer[1].rx_buf = &st->raw_data;
> +		xfer[1].len = 2;
> +
> +		return spi_sync_transfer(st->spi, xfer, 2);
> +	}

then an else here to reduce the scope of another xfer structure.

> +
> +	/*
> +	 * The conversion has already been done and we just have to read the
> +	 * result and exit conversion mode.
> +	 */
> +	st->cnv_cmd = AD4695_CMD_EXIT_CNV_MODE << 11;
> +	xfer[0].bits_per_word = 16;
> +	xfer[0].tx_buf = &st->cnv_cmd;
> +	xfer[0].rx_buf = &st->raw_data;
> +	xfer[0].len = 2;
> +
> +	return spi_sync_transfer(st->spi, xfer, 1);
> +}

