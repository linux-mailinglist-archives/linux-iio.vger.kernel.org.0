Return-Path: <linux-iio+bounces-25794-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE95C28DEB
	for <lists+linux-iio@lfdr.de>; Sun, 02 Nov 2025 12:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 170E24E48C8
	for <lists+linux-iio@lfdr.de>; Sun,  2 Nov 2025 11:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A831A258CE8;
	Sun,  2 Nov 2025 11:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bEZDxSuM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6732E403;
	Sun,  2 Nov 2025 11:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762081862; cv=none; b=m498/jt0/45WvKvJbyTv6uUek+zAjKthSijsVra/t0/L7OMgrgu8sKBpwBNkp0uQ0kLF9gontrDYlck5Yfd+vae4m8tENTBs20BGFzdCcmMGQgLeA6IwNTGtLdmOcBOu5zRx8BtXUK5vo55ZGEtIgsv8EtmuMhOse0fI4amxL4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762081862; c=relaxed/simple;
	bh=BQfiCYyZFSnaVHV0YyL6ihjuyJsWWGMoG9gKybzWqjA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sBw0JIy9G6dBDKOSynmNPu0GtxEm9OysxRBuihV4mzx9Y+NPSss4ha0CSLn11R9Cod7N/vxLuqouVIyCKpdqfcsoCoLgf6s8FkboQW+FeSuUhtp+iA6I9TzubPas4IBh0f83bh6Pb9tukaUHuu5Zw+MJw+vtm+CGqwN84GL4C+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bEZDxSuM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 991B2C4CEF7;
	Sun,  2 Nov 2025 11:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762081861;
	bh=BQfiCYyZFSnaVHV0YyL6ihjuyJsWWGMoG9gKybzWqjA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bEZDxSuMZnGrHPke2belkYU90SnJdsEmj0NWBbuy70YEAKR1n1cknXqS9vxQTw1+P
	 yKNTslNxwHFQM5d+Bb8t63D52/FwvyoBxoBmeVKHvZ7IIiM2fTkGAPqhfkik/8BNmr
	 uZs7FOTsAluTMRMkYAZmOfwvtoXQvzr1KkdWVoXD2Cvv7U94xGL/D5YxuHa062PwvZ
	 UrGoM1o1YhW9xtJ5kYR7bVD5j/SuJkCSatVzQ2JT7J/iLt3OcFuTYHVY0M0BEAWvO8
	 Y7IARaiXpaPKcK5rDfzq5PQLi2BgWXk2t6Im68kL/hm+/efUpJHTSpEUrtucH1ZIFB
	 m/MiHL/KnQmIw==
Date: Sun, 2 Nov 2025 11:10:44 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <robh@kernel.org>, <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH 2/3] iio: amplifiers: adl8113: add driver support
Message-ID: <20251102111044.65a44c9b@jic23-huawei>
In-Reply-To: <20251031160405.13286-3-antoniu.miclaus@analog.com>
References: <20251031160405.13286-1-antoniu.miclaus@analog.com>
	<20251031160405.13286-3-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Oct 2025 16:04:04 +0000
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add support for adl8113 10MHz to 12GHz Low Noise Amplifier with
> 10MHz to 14GHz bypass switches.

This is an unusual device which makes things interesting
It is kind of a hybrid of a MUX and an amplifier.

As such most of the comments are around how we represent that.
I'd definitely like to get some more opinions on this.

Jonathan

> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

> diff --git a/drivers/iio/amplifiers/adl8113.c b/drivers/iio/amplifiers/adl8113.c
> new file mode 100644
> index 000000000000..4a05c1497913
> --- /dev/null
> +++ b/drivers/iio/amplifiers/adl8113.c
> @@ -0,0 +1,235 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ADL8113 Low Noise Amplifier with integrated bypass switches
> + *
> + * Copyright 2025 Analog Devices Inc.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/kernel.h>

Check closely what you actually use from kernel.h.  Mostly we are moving
to including more specific headers instead.  It is very rare it makes sense
to include this from a driver.

> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/slab.h>
> +#include <linux/sysfs.h>
> +
> +enum adl8113_mode {
> +	ADL8113_INTERNAL_AMPLIFIER,
> +	ADL8113_INTERNAL_BYPASS,
> +	ADL8113_EXTERNAL_BYPASS_A,
> +	ADL8113_EXTERNAL_BYPASS_B

Add a trailing comma.  Whilst there are only 4 modes there is nothing
that absolutely says there will never be more, perhaps in a chip variant.

> +};
> +
> +struct adl8113_state {
> +	struct mutex lock; /* protect sensor state */
Be more specific on what that is.  I think all it actually
protects is current mode read back racing with setting
GPIOS before writing it.  That's not a useful race to protect
as it corresponds to exactly what happens if the read back wins
the mutex race and then the pins are immediately updated.

If you were reading the gpios back it would make more sense as
you might see an intermediate state where one gpio had updated
and not the other..

> +	struct gpio_desc *gpio_va;
> +	struct gpio_desc *gpio_vb;
> +	enum adl8113_mode current_mode;
> +};

> +
> +static int adl8113_get_mode(struct iio_dev *indio_dev,
> +			    const struct iio_chan_spec *chan)
> +{
> +	struct adl8113_state *st = iio_priv(indio_dev);
> +
> +	return st->current_mode;
> +}
> +
> +static int adl8113_set_mode_enum(struct iio_dev *indio_dev,
> +				 const struct iio_chan_spec *chan,
> +				 unsigned int mode)
> +{
> +	struct adl8113_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (mode >= ARRAY_SIZE(adl8113_mode_names))
> +		return -EINVAL;
> +
> +	mutex_lock(&st->lock);
	guard(mutex)(&st->lock);
	return adl...

> +	ret = adl8113_set_mode(st, mode);
> +	mutex_unlock(&st->lock);
> +
> +	return ret;
> +}

> +
> +static int adl8113_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct adl8113_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_HARDWAREGAIN:
> +		mutex_lock(&st->lock);

Add scope with {} and use guard so you can do early returns rather
than having to manually unlock.



> +		switch (st->current_mode) {
> +		case ADL8113_INTERNAL_AMPLIFIER:
> +			*val = 14;
> +			*val2 = 0;
> +			ret = IIO_VAL_INT_PLUS_MICRO_DB;
> +			break;
> +		case ADL8113_INTERNAL_BYPASS:
> +		case ADL8113_EXTERNAL_BYPASS_A:
> +		case ADL8113_EXTERNAL_BYPASS_B:
> +			*val = 0;
> +			*val2 = 0;
> +			ret = IIO_VAL_INT_PLUS_MICRO_DB;

Internal bypass is fine, but not the other two. We currently have no way
to know anything about those paths.

> +			break;
> +		default:
> +			ret = -EINVAL;
> +		}
> +		mutex_unlock(&st->lock);
> +		return ret;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info adl8113_info = {
> +	.read_raw = adl8113_read_raw,
> +};
> +
> +static int adl8113_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct adl8113_state *st;
> +	struct iio_dev *indio_dev;
> +	u32 initial_mode = ADL8113_INTERNAL_AMPLIFIER;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	mutex_init(&st->lock);

For new code, prefer
	ret = devm_mutex_init(dev, &st->lock);
	if (ret)
		return ret;
It's cheap to add and maybe is useful to someone debugging locks.

> +
> +	st->gpio_va = devm_gpiod_get(dev, "va", GPIOD_OUT_LOW);
> +	if (IS_ERR(st->gpio_va))
> +		return dev_err_probe(dev, PTR_ERR(st->gpio_va),
> +				     "failed to get VA GPIO\n");
> +
> +	st->gpio_vb = devm_gpiod_get(dev, "vb", GPIOD_OUT_LOW);
> +	if (IS_ERR(st->gpio_vb))
> +		return dev_err_probe(dev, PTR_ERR(st->gpio_vb),
> +				     "failed to get VB GPIO\n");

I'm not keen on the initial mode thing below, but if we are going to do that
then we definitely should not transition through another mode on the way there.
With that gone though this default setting when getting the pins is fine. 
Or leave them to whatever some earlier setting was by using GPIOD_ASIS
and querying what that is.


> +
> +	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(adl8113_supply_names),
> +					     adl8113_supply_names);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "failed to get and enable supplies\n");
> +
> +	device_property_read_u32(dev, "adi,initial-mode", &initial_mode);
> +	if (initial_mode >= ARRAY_SIZE(adl8113_mode_names))
> +		return -EINVAL;
> +
> +	ret = adl8113_set_mode(st, initial_mode);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->info = &adl8113_info;
> +	indio_dev->name = "adl8113";
> +	indio_dev->channels = adl8113_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(adl8113_channels);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	dev_info(dev, "ADL8113 registered, initial mode: %s\n",
> +		 adl8113_mode_names[initial_mode]);

As per the binding patch, I'm not seeing the reason for a default
mode.  It wasn't true prior to driver load, so might as well make
it a userspace problem to set after driver load.

With that gone I'd drop this print to dev_dbg() at most as it's
noise we don't need.


> +
> +	return 0;
> +}
> +
> +static const struct of_device_id adl8113_of_match[] = {
> +	{ .compatible = "adi,adl8113" },
> +	{}
Trivial but for IIO I'm trying to get consistent style where possible and
that for this stuff is
	{ }

> +};
> +MODULE_DEVICE_TABLE(of, adl8113_of_match);

