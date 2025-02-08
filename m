Return-Path: <linux-iio+bounces-15180-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B066CA2D77D
	for <lists+linux-iio@lfdr.de>; Sat,  8 Feb 2025 17:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 354553A0F9D
	for <lists+linux-iio@lfdr.de>; Sat,  8 Feb 2025 16:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2E51F3BB2;
	Sat,  8 Feb 2025 16:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NLXTDyiu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC4F1F1815;
	Sat,  8 Feb 2025 16:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739032881; cv=none; b=LFUA3ijK7M2Ggg7PIbGGIPejkgxdALjVQ9bVUyAo/jmp8ap4eZGOeJhCl5XhH8HA9WlHnSAx7GOYN09PrbHLreujU/vSeVB9/LKF8uCxScEJfHaWnEDh0vEpG/fjkJQcLCVDbJl3iYjuF1wR4qh5mL74VnyshmHfU6eZl+cHLg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739032881; c=relaxed/simple;
	bh=nE2tps/OVvhnykdbqvtmJDT1Kbp5Ql+WK68Y3AyNji0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bR92rK/yTuor378LT7PGWLU549i3a5wLl7T0Q9riXjwyV2CWQV0Uz51nti1mjECddVHk28C4xv+X466Ej8AtKLd0LSE7IdRspAQl6SazcaKrxo7hq1EspVjyTcv7EX7qVfTqhKTpIycNzFMwCum+1UR3yeVk/yvYQXEQola8yiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NLXTDyiu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68F80C4CEDF;
	Sat,  8 Feb 2025 16:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739032880;
	bh=nE2tps/OVvhnykdbqvtmJDT1Kbp5Ql+WK68Y3AyNji0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NLXTDyiuBf4xcEWxy2Xhb4NhDoRuX0waAGg+XFhlqGMaF1jex0ELZ2YWV75lZu7lE
	 MS8PVjDSykTeBMnAj+ZixT38dz8mz3h1b6eKAj0MQRFrrbO3V26Q4SjryBhvZx7oEO
	 R9JF2UhE6V57nC3SFFlTOMlqxS+H4pIYWPg2Qp65C/fVyStJF1nEhdyJu2suhbrYTV
	 1eJeut4uSEwekhYtfEw/3I1OrklYwzQgU6qPryf0qceL+PIiFY2ToABzZ4NcQq1dPm
	 Lm8lorUqCxqOSC06hjqG4tzz3wsgITY8JfzsSrDVUALBXDfUiwNVf58Xy4FhN5+GWR
	 elcTqchIQgFDg==
Date: Sat, 8 Feb 2025 16:41:11 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nuno Sa
 <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] iio: adc: add helpers for parsing ADC nodes
Message-ID: <20250208164111.28ec9f2d@jic23-huawei>
In-Reply-To: <337895af7418a8e4b20b5a9322344b68082508ae.1738761899.git.mazziesaccount@gmail.com>
References: <cover.1738761899.git.mazziesaccount@gmail.com>
	<337895af7418a8e4b20b5a9322344b68082508ae.1738761899.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Feb 2025 15:34:51 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> There are ADC ICs which may have some of the AIN pins usable for other
> functions. These ICs may have some of the AIN pins wired so that they
> should not be used for ADC.
> 
> (Preferred?) way for marking pins which can be used as ADC inputs is to
> add corresponding channels@N nodes in the device tree as described in
> the ADC binding yaml.
> 
> Add couple of helper functions which can be used to retrieve the channel
> information from the device node.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> ---
> Revision history:
> RFC v1 => v2:
>  - New patch
> 
> I think it might be nice to have helpers for fetching also the other
> generic (non vendor specific) ADC properties (as listed in the
> Documentation/devicetree/bindings/iio/adc/adc.yaml) - but as I don't
> have use for those in BD79124 driver (at least not for now), I don't
> imnplement them yet. Anyways, this commit creates a place for such
> helpers.

There is often a mix of vendor specific and not in channel nodes.
Hence I'm not sure how widely this will be and it is driver
specific which of the standard things make sense.

So before I'd consider a helper like this I'd want to see it alongside
a bunch of users including some of the complex ones so that we know
it generalizes well enough.  It doesn't make sense to introduce
it otherwise - just keep the code in the specific drivers instead.

It's an interesting idea, but not a trivial one :)

Jonathan


> ---
>  drivers/iio/adc/Kconfig            |   3 +
>  drivers/iio/adc/Makefile           |   1 +
>  drivers/iio/adc/industrialio-adc.c | 151 +++++++++++++++++++++++++++++
>  include/linux/iio/adc-helpers.h    |  22 +++++
>  4 files changed, 177 insertions(+)
>  create mode 100644 drivers/iio/adc/industrialio-adc.c
>  create mode 100644 include/linux/iio/adc-helpers.h
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 849c90203071..37b70a65da6f 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -6,6 +6,9 @@
>  
>  menu "Analog to digital converters"
>  
> +config IIO_ADC_HELPER
> +	tristate
> +
>  config AB8500_GPADC
>  	bool "ST-Ericsson AB8500 GPADC driver"
>  	depends on AB8500_CORE && REGULATOR_AB8500
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index ee19afba62b7..956c121a7544 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -57,6 +57,7 @@ obj-$(CONFIG_FSL_MX25_ADC) += fsl-imx25-gcq.o
>  obj-$(CONFIG_GEHC_PMC_ADC) += gehc-pmc-adc.o
>  obj-$(CONFIG_HI8435) += hi8435.o
>  obj-$(CONFIG_HX711) += hx711.o
> +obj-$(CONFIG_IIO_ADC_HELPER) += industrialio-adc.o
>  obj-$(CONFIG_IMX7D_ADC) += imx7d_adc.o
>  obj-$(CONFIG_IMX8QXP_ADC) += imx8qxp-adc.o
>  obj-$(CONFIG_IMX93_ADC) += imx93_adc.o
> diff --git a/drivers/iio/adc/industrialio-adc.c b/drivers/iio/adc/industrialio-adc.c
> new file mode 100644
> index 000000000000..366e4c8eb6c7
> --- /dev/null
> +++ b/drivers/iio/adc/industrialio-adc.c
> @@ -0,0 +1,151 @@


> +
> +/**
> + * iio_adc_device_get_channels - get ADC channel IDs

This sounds far too like the inkern interfaces.  Need to associate it instead
with the fwnode / properties stuff.

> + *
> + * Scan the device node for ADC channel information. Return an array of found
> + * IDs. Caller need to allocate the memory for the array and provide maximum

Caller needs to provide the memory

> + * number of IDs the array can store.
> + *
> + * @dev:		Pointer to the ADC device
> + * @channels:		Array where the found IDs will be stored.
> + * @max_channels:	Number of IDs that fit in the array.
> + *
> + * Return:		Number of found channels on succes. Negative value to
> + *			indicate failure.
> + */
> +int iio_adc_device_get_channels(struct device *dev, int *channels,
> +				int max_channels)
> +{
> +	struct fwnode_handle *fwnode, *child;
> +	int num_chan = 0, ret;
> +
> +	fwnode = dev_fwnode(dev);
> +	if (!fwnode) {

As before, I'd relax this until we need to do it. We may never do so.

> +		fwnode = dev_fwnode(dev->parent);
> +		if (!fwnode)
> +			return -ENODEV;
> +	}
> +	fwnode_for_each_child_node(fwnode, child) {
> +		if (fwnode_name_eq(child, "channel")) {

As below. I'd flip the logic here and use a continue

> +			u32 ch;
> +
> +			if (num_chan == max_channels)
> +				return -EINVAL;
> +
> +			ret = fwnode_property_read_u32(child, "reg", &ch);
> +			if (ret)
> +				return ret;
> +
> +			/*
> +			 * We assume the channel IDs start from 0. If it seems
> +			 * this is not a sane assumption, then we can relax
> +			 * this check or add 'allowed ID range' parameter.
> +			 *
> +			 * Let's just start with this simple assumption.
> +			 */
> +			if (ch > max_channels)
> +				return -ERANGE;
> +
> +			channels[num_chan] = ch;
> +			num_chan++;
			channel[num_chan++] = ch;

So it is clear how the two are coupled.

> +		}
> +	}
> +
> +	return num_chan;
> +
> +}
> +EXPORT_SYMBOL_GPL(iio_adc_device_get_channels);
> +
> +/**
> + * devm_iio_adc_device_alloc_chaninfo - allocate and fill iio_chan_spec for adc
> + *
> + * Scan the device node for ADC channel information. Allocate and populate the
> + * iio_chan_spec structure corresponding to channels that are found. The memory
> + * for iio_chan_spec structure will be freed upon device detach. Try parent
> + * device node if given device has no fwnode associated to cover also MFD
> + * devices.

I'd leave that parent node check until we need it (unless you need it for
this one!).  Feels like infra structure that might never be used.
That would let us for now use the device_for_each_child_node()
handling.

> + *
> + * @dev:	Pointer to the ADC device
> + * @template:	Template iio_chan_spec from which the fields of all found and
> + *		allocated channels are initialized.
> + * @cs:		Location where pointer to allocated iio_chan_spec should be
> + *		stored
> + *
> + * Return:	Number of found channels on succes. Negative value to indicate
> + *		failure.
> + */
> +int devm_iio_adc_device_alloc_chaninfo(struct device *dev,
> +				       const struct iio_chan_spec *template,
> +				       struct iio_chan_spec **cs)
> +{
> +	struct fwnode_handle *fwnode, *child;
> +	struct iio_chan_spec *chan;
> +	int num_chan = 0, ret;
> +
> +	fwnode = dev_fwnode(dev);
> +	if (!fwnode) {
> +		fwnode = dev_fwnode(dev->parent);
> +		if (!fwnode)
> +			return -ENODEV;
> +	}
> +
> +	num_chan = iio_adc_fwnode_num_channels(fwnode);
> +	if (num_chan < 0)
> +		return num_chan;
> +
> +	*cs = devm_kcalloc(dev, num_chan, sizeof(**cs), GFP_KERNEL);
> +	if (!*cs)
> +		return -ENOMEM;
> +
> +	chan = &(*cs)[0];
> +
> +	fwnode_for_each_child_node(fwnode, child) {
> +		if (fwnode_name_eq(child, "channel")) {
Flip logic probably and use a continue to reduce indent of
the next bit (which may well get a lot more complex in future).

> +			u32 ch;
> +
> +			ret = fwnode_property_read_u32(child, "reg", &ch);
> +			if (ret)
> +				return ret;

In general the association between reg and channel is more complex.
We need to deal with a reasonable subset of cases (single-channel, diff-channels
etc) where it isn't the case that chan == chan->channel.

> +
> +			*chan = *template;
> +			chan->channel = ch;
> +
> +			if (num_chan > 1)
> +				chan->indexed = 1;

I think set this whatever, probably in the template.
I don't want to see the interface change just because a given DT says
only one channel is connected.

> +
> +			chan++;
> +		}
> +	}
> +
> +	return num_chan;
> +}
> +EXPORT_SYMBOL_GPL(devm_iio_adc_device_alloc_chaninfo);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Matti Vaittinen <mazziesaccount@gmail.com>");
> +MODULE_DESCRIPTION("IIO ADC fwnode parsing helpers");



