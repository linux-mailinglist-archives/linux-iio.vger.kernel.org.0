Return-Path: <linux-iio+bounces-15986-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BDCA40FAD
	for <lists+linux-iio@lfdr.de>; Sun, 23 Feb 2025 17:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52CD41894766
	for <lists+linux-iio@lfdr.de>; Sun, 23 Feb 2025 16:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460B077F11;
	Sun, 23 Feb 2025 16:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rtQ7qqK7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D835315D1;
	Sun, 23 Feb 2025 16:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740327238; cv=none; b=Mpcd3A7yCwvNsvysUG1P5+X9LozU57GotOMb5hVSsc3PphO+uArFNVajVcgEaHlx0YovhoyfjXLBAZI9t8WdF3P2X2MBIqgs83QG8LTc3RAXrmWsNHlV11ffGyZ8f+NrxhPc98IhdpHXTGTGiovFp87u+qTFTxC7imgTv9qM6+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740327238; c=relaxed/simple;
	bh=sDkNg7EsIX+yFBaP6hmeYuV+cRir/F4DdwT8FyBvT+4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=abduxdiRfsjmcQB/aWx3CInVUZGwqqb6lNTJl9CNwkfEouVUMHaF1zryzDCqQGzXBSCsL6zHNDTg+WyX9J+GCZ/mFNu/9ZzQyZFK8KxdJNS1bUtDSMyHDWu76T3e23MuA7TvItNCLd3toesB6A/wURVT2aLm6IIymzGRJ3C0O/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rtQ7qqK7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC9D1C4CEDD;
	Sun, 23 Feb 2025 16:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740327236;
	bh=sDkNg7EsIX+yFBaP6hmeYuV+cRir/F4DdwT8FyBvT+4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rtQ7qqK78gSBGWcm35497glQNbZaUgh9WYNIAgzDdEzRPmBaASPmBgT0yb9hdU5Nc
	 BYxGnnDyBdaddfZA/LcdEHFBNJWfIwXeQaUnx0xjn6MJnke1CIDzh7aUt+sTEK69C6
	 i/JDcufAr6KNHPkQUEI4U7qU74w0uRkiwvLsQIgnew9g1yW80+6TbGIhpa70iDS84B
	 PjmsXRoQa3DLY+iEfSiiygyX0mCoJ/KNUH2kvaa2I90khny3zWUWfOcgdKm90ImpDW
	 obRQvNl1eMGK8MLfT7syymWfw3MujmDpEEe9B/zb6Nvw2TpRRtR60HFsUoThZpeZlz
	 IKZufSF37SyQA==
Date: Sun, 23 Feb 2025 16:13:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
 <samuel@sholland.org>, Hugo Villeneuve <hvilleneuve@dimonoff.com>, Nuno Sa
 <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>, Javier
 Carrasco <javier.carrasco.cruz@gmail.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v3 2/9] iio: adc: add helpers for parsing ADC nodes
Message-ID: <20250223161338.5c896280@jic23-huawei>
In-Reply-To: <6c5b678526e227488592d004c315a967b9809701.1739967040.git.mazziesaccount@gmail.com>
References: <cover.1739967040.git.mazziesaccount@gmail.com>
	<6c5b678526e227488592d004c315a967b9809701.1739967040.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Feb 2025 14:30:27 +0200
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
> v2 => v3: Mostly based on review comments by Jonathan
>  - Support differential and single-ended channels(*)
>  - Rename iio_adc_device_get_channels() as
>  - Improve spelling
>  - Drop support for cases where DT comes from parent device's node
>  - Decrease loop indent by reverting node name check conditions
>  - Don't set 'chan->indexed' by number of channels to keep the
>    interface consistent no matter how many channels are connected.
>  - Fix ID range check and related comment
> RFC v1 => v2:
>  - New patch
> 
> (*) The support for single-ended and differential channels is 100%
> untested. I am not convinced it is actually an improvement over the
> *_simple() helpers which only supported getting the ID from the "reg

Currently it definitely feels too complex.  Partly, whilst I haven't
tried fleshing out the alternative, it feels like you've tried to make
it too general.  I really don't like the allowed bitmap as those
relationships are complex.

> In theory they could be used. In practice, while I skimmed through the
> in-tree ADC drivers which used the for_each_child_node() construct - it
> seemed that most of those which supported differential inputs had also
> some other per-channel properties to read. Those users would in any case
> need to loop through the nodes to get those other properties.
That doesn't surprise me that much. I'm still not sure there are enough
'simple' cases (i.e. more than maybe 3) to justify this being shared.

> 
> If I am once more allowed to go back to proposing the _simple() variant
> which only covers the case: "chan ID in 'reg' property"... Dropping
> support for differential and single-ended channels would simplify this
> helper a lot. It'd allow dropping the sanity check as well as the extra
> parameters callers need to pass to tell what kind of properties they
> expect. That'd (in my opinion) made the last patches (to actual ADC
> drivers) in this series a much more lean and worthy ;)

If you do, call it _se() or something like that.

> 
> Finally, we could add own functions for differential/single-ended/all
> channels when the next driver which uses differential or single-ended
> channels - and which does not need other per-channel properties - lands
> in tree. That would still simplify the helper API usage for those
> drivers touched at the end of this series.

This sounds reasonable approach but I still want more than one before
we bother.

> 
> I (still) think it might be nice to have helpers for fetching also the
> other generic (non vendor specific) ADC properties (as listed in the
> Documentation/devicetree/bindings/iio/adc/adc.yaml) - but as I don't
> have use for those in BD79124 driver (at least not for now), I don't
> imnplement them yet. Anyways, this commit creates a place for such
> helpers.
Definitely need usecases.

So my current feeling is if you can find a second case that a
_se() variant works for then I don't mind this being a separate module.
If not put just what you need in your driver.

Various comments inline.
> ---
>  drivers/iio/adc/Kconfig            |   3 +
>  drivers/iio/adc/Makefile           |   1 +
>  drivers/iio/adc/industrialio-adc.c | 304 +++++++++++++++++++++++++++++
>  include/linux/iio/adc-helpers.h    |  56 ++++++
>  4 files changed, 364 insertions(+)
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
As per other discussion. Move this to new block at the top.
>  obj-$(CONFIG_IMX7D_ADC) += imx7d_adc.o
>  obj-$(CONFIG_IMX8QXP_ADC) += imx8qxp-adc.o
>  obj-$(CONFIG_IMX93_ADC) += imx93_adc.o
> diff --git a/drivers/iio/adc/industrialio-adc.c b/drivers/iio/adc/industrialio-adc.c
> new file mode 100644
> index 000000000000..0281d64ae112
> --- /dev/null
> +++ b/drivers/iio/adc/industrialio-adc.c
> @@ -0,0 +1,304 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Helpers for parsing common ADC information from a firmware node.
> + *
> + * Copyright (c) 2025 Matti Vaittinen <mazziesaccount@gmail.com>
> + */
> +
> +#include <linux/device.h>
> +#include <linux/errno.h>
> +#include <linux/property.h>
> +
> +#include <linux/iio/adc-helpers.h>
> +
> +int iio_adc_device_num_channels(struct device *dev)
> +{
> +	int num_chan = 0;
> +
> +	device_for_each_child_node_scoped(dev, child)
> +		if (fwnode_name_eq(child, "channel"))
> +			num_chan++;
> +
> +	return num_chan;

This function seems easy to generalize to count nodes of particular
name.  So I'd promote this as a generic property.h helper and
just use that in here.


> +}
> +EXPORT_SYMBOL_GPL(iio_adc_device_num_channels);
> +
> +static const char *iio_adc_type2prop(int type)
> +{
> +	switch (type) {
> +	case IIO_ADC_CHAN_PROP_TYPE_REG:
> +		return "reg";
> +	case IIO_ADC_CHAN_PROP_TYPE_SINGLE_ENDED:
> +		return "single-channel";
> +	case IIO_ADC_CHAN_PROP_TYPE_DIFF:
> +		return "diff-channels";
> +	case IIO_ADC_CHAN_PROP_COMMON:
> +		return "common-mode-channel";
> +	default:
> +		return "unknown";
> +	}
> +}
> +
> +/*
> + * Sanity check. Ensure that:
> + * - At least some type(s) are allowed
> + * - All types found are also expected
> + * - If plain "reg" is not allowed, either single-ended or differential
> + *   properties are found.

I'd worry this is a combination of fragile and overly separate from
the parser.  I'd just encode this stuff down there based on accepted type
of channels.  Two flags, differential and single ended may be enough.
If single only then reg is expected solution but I don't see a reason to
ignore single-channel even then as meaning is well defined.
If differential only - then that property must be present for all channels.
If both single and differential then need either differential or single-channel.

> + */
> +static int iio_adc_prop_type_check_sanity(struct device *dev,
> +		const struct iio_adc_props *expected_props, int found_types)
> +{
> +	unsigned long allowed_types = expected_props->allowed |
> +				      expected_props->required;
> +
> +	if (!allowed_types || allowed_types & (~IIO_ADC_CHAN_PROP_TYPE_ALL)) {
> +		dev_dbg(dev, "Invalid adc allowed prop types 0x%lx\n",
> +			allowed_types);
> +
> +		return -EINVAL;
> +	}
> +	if (found_types & (~allowed_types)) {
> +		long unknown_types = found_types & (~allowed_types);
> +		int type;
> +
> +		for_each_set_bit(type, &unknown_types,
> +				 IIO_ADC_CHAN_NUM_PROP_TYPES - 1) {
> +			dev_err(dev, "Unsupported channel property %s\n",
> +				iio_adc_type2prop(type));
> +		}
> +
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * The IIO_ADC_CHAN_PROP_TYPE_REG is special. We always require it to
> +	 * be found in the dt. (If not, we'll error out before calling this
> +	 * function.) However, listing it in 'allowed' types means the "reg"
> +	 * alone can be used to indicate the channel ID.
> +	 *
> +	 * Thus, we don't add it in the found properties either - so check for
> +	 * found and allowed properties passes even if user hasn't explicitly
> +	 * added the 'IIO_ADC_CHAN_PROP_TYPE_REG' to be allowed. (This is the
> +	 * case if either differential or single-ended property is required).
> +	 *
> +	 * Hence, for this check we need to explicitly add the
> +	 * IIO_ADC_CHAN_PROP_TYPE_REG to 'found' properties to make the check
> +	 * pass when "reg" is the property which is required to have the
> +	 * channel ID.
> +	 *
> +	 * We could of course always add the IIO_ADC_CHAN_PROP_TYPE_REG in
> +	 * allowed types and found types - but then we wouldn't catch the case
> +	 * where user says the "reg" alone is not sufficient.
> +	 */
> +	if ((~(found_types | IIO_ADC_CHAN_PROP_TYPE_REG)) & expected_props->required) {
> +		long missing_types;
> +		int type;
> +
> +		missing_types = (~found_types) & expected_props->required;
> +
> +		for_each_set_bit(type, &missing_types,
> +				 IIO_ADC_CHAN_NUM_PROP_TYPES - 1) {
> +			dev_err(dev, "required channel specifier '%s' not found\n",
> +				iio_adc_type2prop(type));
> +		}
> +
> +		return -EINVAL;
> +	}
> +
> +	/* Check if we require something else but the "reg" property */
> +	if (!(allowed_types & IIO_ADC_CHAN_PROP_TYPE_REG)) {
> +		if (found_types & IIO_ADC_CHAN_PROP_TYPE_SINGLE_ENDED ||
> +				found_types & IIO_ADC_CHAN_PROP_TYPE_DIFF)
> +			return 0;
> +
> +		dev_err(dev, "channel specifier not found\n");
> +
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * iio_adc_device_channels_by_property - get ADC channel IDs
> + *
> + * Scan the device node for ADC channel information. Return an array of found
> + * IDs. Caller needs to provide the memory for the array and provide maximum
> + * number of IDs the array can store.

I'm somewhat confused by this. Feels like you can get same info from the
iio_chan_spec array generated by the next function.

> + *
> + * @dev:		Pointer to the ADC device
> + * @channels:		Array where the found IDs will be stored.
> + * @max_channels:	Number of IDs that fit in the array.
> + * @expected_props:	Bitmaps of channel property types (for checking).
> + *
> + * Return:		Number of found channels on succes. 0 if no channels
> + *			was found. Negative value to indicate failure.
> + */
> +int iio_adc_device_channels_by_property(struct device *dev, int *channels,
> +		int max_channels, const struct iio_adc_props *expected_props)
> +{
> +	int num_chan = 0, ret;
> +
> +	device_for_each_child_node_scoped(dev, child) {
> +		u32 ch, diff[2], se;
> +		struct iio_adc_props tmp;
> +		int chtypes_found = 0;
> +
> +		if (!fwnode_name_eq(child, "channel"))
> +			continue;
> +
> +		if (num_chan == max_channels)
> +			return -EINVAL;
> +
> +		ret = fwnode_property_read_u32(child, "reg", &ch);
> +		if (ret)
> +			return ret;
> +
> +		ret = fwnode_property_read_u32_array(child, "diff-channels",
> +						     &diff[0], 2);
> +		if (!ret)
> +			chtypes_found |= IIO_ADC_CHAN_PROP_TYPE_DIFF;
> +
> +		ret = fwnode_property_read_u32(child, "single-channel", &se);
> +		if (!ret)
> +			chtypes_found |= IIO_ADC_CHAN_PROP_TYPE_SINGLE_ENDED;
> +
> +		tmp = *expected_props;
> +		/*
> +		 * We don't bother reading the "common-mode-channel" here as it
> +		 * doesn't really affect on the primary channel ID. We remove
> +		 * it from the required properties to allow the sanity check
> +		 * pass here  also for drivers which require it.
> +		 */
> +		tmp.required &= (~BIT(IIO_ADC_CHAN_PROP_COMMON));
> +
> +		ret = iio_adc_prop_type_check_sanity(dev, &tmp, chtypes_found);
> +		if (ret)
> +			return ret;
> +
> +		if (chtypes_found & IIO_ADC_CHAN_PROP_TYPE_DIFF)
> +			ch = diff[0];
> +		else if (chtypes_found & IIO_ADC_CHAN_PROP_TYPE_SINGLE_ENDED)
> +			ch = se;
> +
> +		/*
> +		 * We assume the channel IDs start from 0. If it seems this is
> +		 * not a sane assumption, then we can relax this check or add
> +		 * 'allowed ID range' parameter.
> +		 *
> +		 * Let's just start with this simple assumption.
> +		 */
> +		if (ch >= max_channels)
> +			return -ERANGE;
> +
> +		channels[num_chan] = ch;
> +		num_chan++;
> +	}
> +
> +	return num_chan;
> +
> +}
> +EXPORT_SYMBOL_GPL(iio_adc_device_channels_by_property);
> +
> +/**
> + * devm_iio_adc_device_alloc_chaninfo - allocate and fill iio_chan_spec for adc

ADC

> + *
> + * Scan the device node for ADC channel information. Allocate and populate the
> + * iio_chan_spec structure corresponding to channels that are found. The memory
> + * for iio_chan_spec structure will be freed upon device detach. Try parent
> + * device node if given device has no fwnode associated to cover also MFD
> + * devices.
> + *
> + * @dev:		Pointer to the ADC device.
> + * @template:		Template iio_chan_spec from which the fields of all
> + *			found and allocated channels are initialized.
> + * @cs:			Location where pointer to allocated iio_chan_spec
> + *			should be stored
> + * @expected_props:	Bitmaps of channel property types (for checking).
Input parameter so should be after template.

> + *
> + * Return:	Number of found channels on succes. Negative value to indicate
> + *		failure.

I wonder if an alloc function would be better returning the pointer and
providing num_chans via a parameter.

> + */
> +int devm_iio_adc_device_alloc_chaninfo(struct device *dev,
> +				const struct iio_chan_spec *template,
> +				struct iio_chan_spec **cs,
> +				const struct iio_adc_props *expected_props)

I'm not sure this expected props thing works as often it's a case
of complex relationships 

> +{
> +	struct iio_chan_spec *chan;
> +	int num_chan = 0, ret;
Initialized just after this so don't set num_chan = 0.

> +
> +	num_chan = iio_adc_device_num_channels(dev);
> +	if (num_chan < 1)
> +		return num_chan;
> +
> +	*cs = devm_kcalloc(dev, num_chan, sizeof(**cs), GFP_KERNEL);
> +	if (!*cs)
> +		return -ENOMEM;
> +
> +	chan = &(*cs)[0];
> +
> +	device_for_each_child_node_scoped(dev, child) {
> +		u32 ch, diff[2], se, common;
> +		int chtypes_found = 0;
> +
> +		if (!fwnode_name_eq(child, "channel"))
> +			continue;
> +
> +		ret = fwnode_property_read_u32(child, "reg", &ch);
> +		if (ret)
> +			return ret;
> +

diff channels and single channel take precedence over reg, so check them
first. If present no need to look for reg can also read it then throw
it away giving simpler.

		*chan = *template;

		// reg should exist either way.
		ret = fwnode_property_read_u32(child, "reg", &reg);
		if (ret)
			return -EINVAL; //should be a reg whatever.

		ret = fwnode_property_read_u32_array(child, "diff-channels",
						     diff, ARRAY_SIZE(diff));
		if (ret == 0) {
			chan->differential = 1;
			chan->channel = diff[0];
			chan->channel2 = diff[1];
		} else {
			ret = fwnode_property_read_u32(child, "single-channel", &se);
			if (ret)
				se = reg;

			chan->channel = se;
			//IIRC common mode channel is rare. I'd skip it. That
			//also makes it a differential channel be it a weird one.
		}
					

> +		ret = fwnode_property_read_u32_array(child, "diff-channels",
> +						     &diff[0], 2);
> +		if (!ret)
> +			chtypes_found |= IIO_ADC_CHAN_PROP_TYPE_DIFF;
> +
> +		ret = fwnode_property_read_u32(child, "single-channel", &se);
> +		if (!ret)
> +			chtypes_found |= IIO_ADC_CHAN_PROP_TYPE_SINGLE_ENDED;
> +
> +		ret = fwnode_property_read_u32(child, "common-mode-channel",
> +					       &common);
> +		if (!ret)
> +			chtypes_found |= BIT(IIO_ADC_CHAN_PROP_COMMON);
> +
> +		ret = iio_adc_prop_type_check_sanity(dev, expected_props,
> +						     chtypes_found);

If we want to verify this (I'm not yet sure) then do it as you parse the
properties, not separately.

> +		if (ret)
> +			return ret;
> +
> +		*chan = *template;
> +		chan->channel = ch;
> +
> +		if (chtypes_found & IIO_ADC_CHAN_PROP_TYPE_DIFF) {
> +			chan->differential = 1;
> +			chan->channel = diff[0];
> +			chan->channel2 = diff[1];
> +
> +		} else if (chtypes_found & IIO_ADC_CHAN_PROP_TYPE_SINGLE_ENDED) {
> +			chan->channel = se;
> +			if (chtypes_found & BIT(IIO_ADC_CHAN_PROP_COMMON))
> +				chan->channel2 = common;
> +		}
> +
> +		/*
> +		 * We assume the channel IDs start from 0. If it seems this is
> +		 * not a sane assumption, then we have to add 'allowed ID ranges'
> +		 * to the struct iio_adc_props because some of the callers may
> +		 * rely on the IDs being in this range - and have arrays indexed
> +		 * by the ID.

Not a requirement in general.  It is more than possible to have a single channel
provided that is number 7.

> +		 */
> +		if (chan->channel >= num_chan)
> +			return -ERANGE;
> +
> +		chan++;
> +	}
> +
> +	return num_chan;
> +}
> +EXPORT_SYMBOL_GPL(devm_iio_adc_device_alloc_chaninfo);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Matti Vaittinen <mazziesaccount@gmail.com>");
> +MODULE_DESCRIPTION("IIO ADC fwnode parsing helpers");
> diff --git a/include/linux/iio/adc-helpers.h b/include/linux/iio/adc-helpers.h
> new file mode 100644
> index 000000000000..f7791d45dbd2
> --- /dev/null
> +++ b/include/linux/iio/adc-helpers.h
> @@ -0,0 +1,56 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +/* The industrial I/O ADC helpers
Comment syntax and make it more obvious that while this might be useful
it isn't something we necessarily expect to be useful to every driver.
/*
 * Industrial I/O ADC firmware property passing helpers.
 *

> + *
> + * Copyright (c) 2025 Matti Vaittinen <mazziesaccount@gmail.com>
> + */
> +
> +#ifndef _INDUSTRIAL_IO_ADC_HELPERS_H_
> +#define _INDUSTRIAL_IO_ADC_HELPERS_H_
> +
> +#include <linux/iio/iio.h>
> +
> +struct device;
> +struct fwnode_handle;
> +
> +enum {
> +	IIO_ADC_CHAN_PROP_REG,
> +	IIO_ADC_CHAN_PROP_SINGLE_ENDED,
> +	IIO_ADC_CHAN_PROP_DIFF,
> +	IIO_ADC_CHAN_PROP_COMMON,
> +	IIO_ADC_CHAN_NUM_PROP_TYPES
> +};
> +
> +/*
> + * Channel property types to be used with iio_adc_device_get_channels,
> + * devm_iio_adc_device_alloc_chaninfo, ...
> + */
> +#define IIO_ADC_CHAN_PROP_TYPE_REG BIT(IIO_ADC_CHAN_PROP_REG)
> +#define IIO_ADC_CHAN_PROP_TYPE_SINGLE_ENDED BIT(IIO_ADC_CHAN_PROP_SINGLE_ENDED)
> +#define IIO_ADC_CHAN_PROP_TYPE_SINGLE_COMMON					\
> +	(BIT(IIO_ADC_CHAN_PROP_SINGLE_ENDED) | BIT(IIO_ADC_CHAN_PROP_COMMON))
> +#define IIO_ADC_CHAN_PROP_TYPE_DIFF BIT(IIO_ADC_CHAN_PROP_DIFF)
> +#define IIO_ADC_CHAN_PROP_TYPE_ALL GENMASK(IIO_ADC_CHAN_NUM_PROP_TYPES - 1, 0)
> +
> +/**
> + * iio_adc_chan_props - information of expected device-tree channel properties
> + *
> + * @required:	Bitmask of property definitions of required channel properties
> + * @allowed:	Bitmask of property definitions of optional channel properties.
> + *		Listing of required properties is not needed here.
> + */
> +struct iio_adc_props {
> +	unsigned long required;
> +	unsigned long allowed;
> +};
> +
> +int iio_adc_device_num_channels(struct device *dev);
> +int devm_iio_adc_device_alloc_chaninfo(struct device *dev,
> +				const struct iio_chan_spec *template,
> +				struct iio_chan_spec **cs,
> +				const struct iio_adc_props *expected_props);
> +
> +int iio_adc_device_channels_by_property(struct device *dev, int *channels,
> +				int max_channels,
> +				const struct iio_adc_props *expected_props);
> +#endif /* _INDUSTRIAL_IO_ADC_HELPERS_H_ */


