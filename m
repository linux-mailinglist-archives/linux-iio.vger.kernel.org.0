Return-Path: <linux-iio+bounces-16002-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 611DDA421B6
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2025 14:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18A15188DB9A
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2025 13:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B235C221F20;
	Mon, 24 Feb 2025 13:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRM1f+m+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFFD221F36;
	Mon, 24 Feb 2025 13:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740404739; cv=none; b=VvL+i+6zOFGl0hTbGXMT/geT4xhO6JurS/fpZ7RkB8CNEn55jpkQhnAD7L0QdeuU/FQ07T9yR8Mj0qEcqhEiA3yeExXGwhtx77rbjjQvkX8OMPH3dd6ALUMuBf6xmqKtro5RupZ+gzhpLP06p/sX/5QXowNY9uYNw9wIlVnc/dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740404739; c=relaxed/simple;
	bh=ZAcnqIPkDkKpS8P4zR8XUx7S53Lqr6fZHaBJvnEeeI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lMtF6rTZLqJsIN1HJJm79qIxtwfRY+SuEt1lw8Zo1ggR7GurfRmp7IPzV2ohcTRGJhu10FINtsZSHu6kbTiAHf81HSb/aAxWalGq+IvIXIyk4DiDUS4zBWu0hcENq2VVKDTnGQuaVf19JejnLaTF8iC/qv17N+GnkzE8hhBBYP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gRM1f+m+; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5462ea9691cso4908410e87.2;
        Mon, 24 Feb 2025 05:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740404735; x=1741009535; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x5/3eGTFpkAUPXMyT1iu+VhGadH6TXjZ5FDQpikX2Rk=;
        b=gRM1f+m+BwdYOQfbwBcMzC6WSjsaMkEGOo1ENKLKAYt8y7aHytlYRt+RyIbqJzXRys
         URZhbQeNAPocelT26caWbI3vW7VzirmUx9E2w9l2PtMIBIuBwx4Hd9AVCw4vfKpKVM3i
         yAzKn6YhBQPl48r2S6DqF4ie38XYLD4YZ5SMEBfbYbJZYzZjCi9vhHeLa7r8GnYNh1h9
         J5c0acyKYyIUkpR/oSvLunoSZJVJm9CmgVW+F2akShK1kPmBx4vqznuqMjZPsHPVj9eR
         ld7StUjschPNlQq0M1rR9LsmsmyMMnxq7FfOTOujFe3XRYB7++Y4ecn0zfQ9eAx8qiG/
         jRgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740404735; x=1741009535;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x5/3eGTFpkAUPXMyT1iu+VhGadH6TXjZ5FDQpikX2Rk=;
        b=sqh7R7tgiJ6L8GTVWQ9+9E+52NjY7S4sFl0X2Ii3bfY3ScsaqtbpxCps9WjLEXSSIf
         +NIWD+6W67V99BWUMlDGC+tlXBDPCcOt7+/tQU0T+mEZvLQYxyWEviztC3QacVLC6+Ff
         dKbo0SZiWpZbKmWOJ8v0ONumma98TapYmKmskNAKETHg4Fm3am0A8rZbeh5epXVtrYxU
         p2UWgnGvcxBl0G64K3zAtdsSkUIeSuwzxPXcsY6tkEmkBp2x/+wcknX5BZAv8HMoyrke
         +bzp1XoPFob2rzE/yP95TE1bZ5HCgC/YzQP6URvlbP1u1NtEkB3CjyUFZtf8lWs7N67J
         GnqA==
X-Forwarded-Encrypted: i=1; AJvYcCUn0v5Eud+8v7STUZsxtnlEFswyX7ykpzxwdm+uycUw9MYz7qK9mhBuN+nulO8YTW4QaAoj1p6E3pH9@vger.kernel.org, AJvYcCUyf8Jf7xd9fagN6hqi/hp8Hg0bX7Zu+WetS0h+u9CtRhCpLb5WcGxO+Zl4mf+RK1YBj2nKpkwlpo6q@vger.kernel.org, AJvYcCV4StavNg9pcO03bIipy1dP0mjxLvNOXIaZx+ghNQFHGJ6OzPyi40ZZ9oiJ2rP27w/wNzzC/r1Jzaw5r4LDE3CVMls=@vger.kernel.org, AJvYcCXtq+ZMn90KW0WU7VToWf8ufOhEi97euPyema0NveVuWvuS0Z5dLJ6noqf9ZADghkDajLkG+2CpNPW18P65@vger.kernel.org
X-Gm-Message-State: AOJu0YyAEZGiHNY6cu0PVDGr6oIXTAdYMe9qLDSxkopMOvU5SK3LOqAM
	LoD6gXuUOvm7g2VfOhBFVzrD8dMHN/bHJLM5RkMSnDK3cW5zAaF/
X-Gm-Gg: ASbGncujNPuCV2c+pKELwR7dKTa0lDZEBEoMN6z/wIM8q1Y3ANUfoIUGjBFgSBCTVzp
	vF4vkL5Oh1qCjMXySBKvK83ZOIvK5dBVIUxF7Io7cSs92tKSM6uKVKvot3acx9WbTwn5UoczH5/
	Wb08IgKpPSIbMge2CRA3BenzA+nsSAJY3mUtlSBZFmg9ix+Db6WtiEtR+In0WQmFBQafb3Cg0Zi
	S+G2rV/YsZ/BbbAYnVT10BcsvrkGUJyrkEs1t6aOcf0cRvVdV7IVPpt1vplM/whMm4uTVzJiSzk
	cwNgcun0k22HY7c2G50wnqxCt50L2A+JcmQvE68Cp0cv1mi5fjWaiQMt6JTy6mF69U+46fxahuJ
	nPIqBrkw=
X-Google-Smtp-Source: AGHT+IFOoS5nfpYZJ3vpou2JCdHFkbmx50ZLluz+et52LkYb/GOEbwao1HkEVqsBaBiBgaG+Ux663Q==
X-Received: by 2002:a05:6512:3d28:b0:545:1104:616a with SMTP id 2adb3069b0e04-54838edda38mr4499653e87.2.1740404734660;
        Mon, 24 Feb 2025 05:45:34 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-545d1b9c30fsm2708844e87.15.2025.02.24.05.45.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 05:45:32 -0800 (PST)
Message-ID: <7435fb1f-1ecc-4806-b11e-1ec8e83a22a2@gmail.com>
Date: Mon, 24 Feb 2025 15:45:31 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/9] iio: adc: add helpers for parsing ADC nodes
To: Jonathan Cameron <jic23@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, Nuno Sa <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
References: <cover.1739967040.git.mazziesaccount@gmail.com>
 <6c5b678526e227488592d004c315a967b9809701.1739967040.git.mazziesaccount@gmail.com>
 <20250223161338.5c896280@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250223161338.5c896280@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/02/2025 18:13, Jonathan Cameron wrote:
> On Wed, 19 Feb 2025 14:30:27 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> There are ADC ICs which may have some of the AIN pins usable for other
>> functions. These ICs may have some of the AIN pins wired so that they
>> should not be used for ADC.
>>
>> (Preferred?) way for marking pins which can be used as ADC inputs is to
>> add corresponding channels@N nodes in the device tree as described in
>> the ADC binding yaml.
>>
>> Add couple of helper functions which can be used to retrieve the channel
>> information from the device node.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>
>> ---
>> Revision history:
>> v2 => v3: Mostly based on review comments by Jonathan
>>   - Support differential and single-ended channels(*)
>>   - Rename iio_adc_device_get_channels() as
>>   - Improve spelling
>>   - Drop support for cases where DT comes from parent device's node
>>   - Decrease loop indent by reverting node name check conditions
>>   - Don't set 'chan->indexed' by number of channels to keep the
>>     interface consistent no matter how many channels are connected.
>>   - Fix ID range check and related comment
>> RFC v1 => v2:
>>   - New patch
>>
>> (*) The support for single-ended and differential channels is 100%
>> untested. I am not convinced it is actually an improvement over the
>> *_simple() helpers which only supported getting the ID from the "reg
> 
> Currently it definitely feels too complex.  Partly, whilst I haven't
> tried fleshing out the alternative, it feels like you've tried to make
> it too general.  I really don't like the allowed bitmap as those
> relationships are complex.
> 
>> In theory they could be used. In practice, while I skimmed through the
>> in-tree ADC drivers which used the for_each_child_node() construct - it
>> seemed that most of those which supported differential inputs had also
>> some other per-channel properties to read. Those users would in any case
>> need to loop through the nodes to get those other properties.
> That doesn't surprise me that much. I'm still not sure there are enough
> 'simple' cases (i.e. more than maybe 3) to justify this being shared.
> 
>>
>> If I am once more allowed to go back to proposing the _simple() variant
>> which only covers the case: "chan ID in 'reg' property"... Dropping
>> support for differential and single-ended channels would simplify this
>> helper a lot. It'd allow dropping the sanity check as well as the extra
>> parameters callers need to pass to tell what kind of properties they
>> expect. That'd (in my opinion) made the last patches (to actual ADC
>> drivers) in this series a much more lean and worthy ;)
> 
> If you do, call it _se() or something like that.

Due to the all above - I'll drop the differential channel support and 
used the _se() suffix while always accepting the single-ended property. 
This is a functional change to the existing callers later in the series 
though, but I doubt it causes problems.

>> +
>> +#include <linux/device.h>
>> +#include <linux/errno.h>
>> +#include <linux/property.h>
>> +
>> +#include <linux/iio/adc-helpers.h>
>> +
>> +int iio_adc_device_num_channels(struct device *dev)
>> +{
>> +	int num_chan = 0;
>> +
>> +	device_for_each_child_node_scoped(dev, child)
>> +		if (fwnode_name_eq(child, "channel"))
>> +			num_chan++;
>> +
>> +	return num_chan;
> 
> This function seems easy to generalize to count nodes of particular
> name.  So I'd promote this as a generic property.h helper and
> just use that in here.

I didn't think of that but now that you said it, I agree.

Oh well, that means another area impacted - let's see what the fwnode 
peeps say about adding it.

>> +}
>> +EXPORT_SYMBOL_GPL(iio_adc_device_num_channels);
>> +
>> +static const char *iio_adc_type2prop(int type)
>> +{
>> +	switch (type) {
>> +	case IIO_ADC_CHAN_PROP_TYPE_REG:
>> +		return "reg";
>> +	case IIO_ADC_CHAN_PROP_TYPE_SINGLE_ENDED:
>> +		return "single-channel";
>> +	case IIO_ADC_CHAN_PROP_TYPE_DIFF:
>> +		return "diff-channels";
>> +	case IIO_ADC_CHAN_PROP_COMMON:
>> +		return "common-mode-channel";
>> +	default:
>> +		return "unknown";
>> +	}
>> +}
>> +
>> +/*
>> + * Sanity check. Ensure that:
>> + * - At least some type(s) are allowed
>> + * - All types found are also expected
>> + * - If plain "reg" is not allowed, either single-ended or differential
>> + *   properties are found.
> 
> I'd worry this is a combination of fragile and overly separate from
> the parser.  I'd just encode this stuff down there based on accepted type
> of channels.  Two flags, differential and single ended may be enough.
> If single only then reg is expected solution but I don't see a reason to
> ignore single-channel even then as meaning is well defined.

I could accept both the single-channel and reg - but I think the binding 
is super clear telling that 'reg' is required and must match the channel 
ID. So, I feel supporting the single-channel withoout the 
common-mode-channel or diff-channels is kind of pointless?

Besides, reading both reg and single-channel leaves a question: "What if 
reg and single-channel have different values?" Should we error out? And, 
if they don't have different values, why bother checking the 
single-channel at all as reg is anyways required?

This sanity-check becomes obsolete when we only read the 'reg', and 
ignore everything which does not have (a valid) one.

>> +/**
>> + * iio_adc_device_channels_by_property - get ADC channel IDs
>> + *
>> + * Scan the device node for ADC channel information. Return an array of found
>> + * IDs. Caller needs to provide the memory for the array and provide maximum
>> + * number of IDs the array can store.
> 
> I'm somewhat confused by this. Feels like you can get same info from the
> iio_chan_spec array generated by the next function.

I used this in bd79124 for two purposes. First was setting the mux (ADC 
/ GPO) in the ADC portion of the code. This can indeed be done also by 
just iterating throuh the iio_chan_spec.

Second use-case was a call from the GPIO driver's valid_mask function. 
There I used this to detect which channels were reserved for ADC so I 
was able to build the valid-mask for GPIO core. Using the iio_chan_spec 
in GPIO code felt like a "no no" to me :) Having this available was 
quite handy - and I thought there might be other users as well.

Well, the ADC and GPIO now share the same private data (which is a bit 
ugly in my eyes, but maybe the simplest way to go) - so I can just build 
the valid-mask for the GPIOs in the ADC initialization where it reads 
the channels for the mux. That way I can avoid calling the GPIO's 
valid_mask callback and populate the info before registering the GPIO 
driver.

Long story short - I'll probably just drop this function.

>> + *
>> + * @dev:		Pointer to the ADC device
>> + * @channels:		Array where the found IDs will be stored.
>> + * @max_channels:	Number of IDs that fit in the array.
>> + * @expected_props:	Bitmaps of channel property types (for checking).
>> + *
>> + * Return:		Number of found channels on succes. 0 if no channels
>> + *			was found. Negative value to indicate failure.
>> + */
>> +int iio_adc_device_channels_by_property(struct device *dev, int *channels,
>> +		int max_channels, const struct iio_adc_props *expected_props)
>> +{
>> +	int num_chan = 0, ret;
>> +
>> +	device_for_each_child_node_scoped(dev, child) {
>> +		u32 ch, diff[2], se;
>> +		struct iio_adc_props tmp;
>> +		int chtypes_found = 0;
>> +
>> +		if (!fwnode_name_eq(child, "channel"))
>> +			continue;
>> +
>> +		if (num_chan == max_channels)
>> +			return -EINVAL;
>> +
>> +		ret = fwnode_property_read_u32(child, "reg", &ch);
>> +		if (ret)
>> +			return ret;
>> +
>> +		ret = fwnode_property_read_u32_array(child, "diff-channels",
>> +						     &diff[0], 2);
>> +		if (!ret)
>> +			chtypes_found |= IIO_ADC_CHAN_PROP_TYPE_DIFF;
>> +
>> +		ret = fwnode_property_read_u32(child, "single-channel", &se);
>> +		if (!ret)
>> +			chtypes_found |= IIO_ADC_CHAN_PROP_TYPE_SINGLE_ENDED;
>> +
>> +		tmp = *expected_props;
>> +		/*
>> +		 * We don't bother reading the "common-mode-channel" here as it
>> +		 * doesn't really affect on the primary channel ID. We remove
>> +		 * it from the required properties to allow the sanity check
>> +		 * pass here  also for drivers which require it.
>> +		 */
>> +		tmp.required &= (~BIT(IIO_ADC_CHAN_PROP_COMMON));
>> +
>> +		ret = iio_adc_prop_type_check_sanity(dev, &tmp, chtypes_found);
>> +		if (ret)
>> +			return ret;
>> +
>> +		if (chtypes_found & IIO_ADC_CHAN_PROP_TYPE_DIFF)
>> +			ch = diff[0];
>> +		else if (chtypes_found & IIO_ADC_CHAN_PROP_TYPE_SINGLE_ENDED)
>> +			ch = se;
>> +
>> +		/*
>> +		 * We assume the channel IDs start from 0. If it seems this is
>> +		 * not a sane assumption, then we can relax this check or add
>> +		 * 'allowed ID range' parameter.
>> +		 *
>> +		 * Let's just start with this simple assumption.
>> +		 */
>> +		if (ch >= max_channels)
>> +			return -ERANGE;
>> +
>> +		channels[num_chan] = ch;
>> +		num_chan++;
>> +	}
>> +
>> +	return num_chan;
>> +
>> +}
>> +EXPORT_SYMBOL_GPL(iio_adc_device_channels_by_property);
>> +
>> +/**
>> + * devm_iio_adc_device_alloc_chaninfo - allocate and fill iio_chan_spec for adc
> 
> ADC
> 
>> + *
>> + * Scan the device node for ADC channel information. Allocate and populate the
>> + * iio_chan_spec structure corresponding to channels that are found. The memory
>> + * for iio_chan_spec structure will be freed upon device detach. Try parent
>> + * device node if given device has no fwnode associated to cover also MFD
>> + * devices.
>> + *
>> + * @dev:		Pointer to the ADC device.
>> + * @template:		Template iio_chan_spec from which the fields of all
>> + *			found and allocated channels are initialized.
>> + * @cs:			Location where pointer to allocated iio_chan_spec
>> + *			should be stored
>> + * @expected_props:	Bitmaps of channel property types (for checking).
> Input parameter so should be after template.
> 
>> + *
>> + * Return:	Number of found channels on succes. Negative value to indicate
>> + *		failure.
> 
> I wonder if an alloc function would be better returning the pointer and
> providing num_chans via a parameter.

I personally dislike returning pointer for anything which may fail other 
than by -ENOMEM. I dislike having to add all the the IS_ERR(), 
PTR_ERR(), ERR_PTR() - boilerplate when handling the errors. So, I'd 
rather kept the return value as is here if this is not a show stopper 
for you.

> 
>> + */
>> +int devm_iio_adc_device_alloc_chaninfo(struct device *dev,
>> +				const struct iio_chan_spec *template,
>> +				struct iio_chan_spec **cs,
>> +				const struct iio_adc_props *expected_props)
> 
> I'm not sure this expected props thing works as often it's a case
> of complex relationships

Luckily we can drop it altogether by having separate functions for cases 
where the channel ID is expected to be in "reg", "diff-channels" or 
"single-channel" [+ "common-mode-channel"].

And, we can introduce the more complex variants only if they are some 
day needed/usefull.

>> +{
>> +	struct iio_chan_spec *chan;
>> +	int num_chan = 0, ret;
> Initialized just after this so don't set num_chan = 0.
> 
>> +
>> +	num_chan = iio_adc_device_num_channels(dev);
>> +	if (num_chan < 1)
>> +		return num_chan;
>> +
>> +	*cs = devm_kcalloc(dev, num_chan, sizeof(**cs), GFP_KERNEL);
>> +	if (!*cs)
>> +		return -ENOMEM;
>> +
>> +	chan = &(*cs)[0];
>> +
>> +	device_for_each_child_node_scoped(dev, child) {
>> +		u32 ch, diff[2], se, common;
>> +		int chtypes_found = 0;
>> +
>> +		if (!fwnode_name_eq(child, "channel"))
>> +			continue;
>> +
>> +		ret = fwnode_property_read_u32(child, "reg", &ch);
>> +		if (ret)
>> +			return ret;
>> +
> 
> diff channels and single channel take precedence over reg, so check them
> first. If present no need to look for reg can also read it then throw
> it away giving simpler.

I liked to always read the "reg" because (AFAIR) it was marked as 
required in the binding doc.

> 
> 		*chan = *template;
> 
> 		// reg should exist either way.
> 		ret = fwnode_property_read_u32(child, "reg", &reg);
> 		if (ret)
> 			return -EINVAL; //should be a reg whatever.
> 
> 		ret = fwnode_property_read_u32_array(child, "diff-channels",
> 						     diff, ARRAY_SIZE(diff));
> 		if (ret == 0) {
> 			chan->differential = 1;
> 			chan->channel = diff[0];
> 			chan->channel2 = diff[1];
> 		} else {
> 			ret = fwnode_property_read_u32(child, "single-channel", &se);
> 			if (ret)
> 				se = reg;
> 
> 			chan->channel = se;
> 			//IIRC common mode channel is rare. I'd skip it. That
> 			//also makes it a differential channel be it a weird one.

Yes. There weren't many drivers I found using this. But I have a feeling 
that those which I checked and which did, didn't set the "differential" 
-flag in iio_chan_spec for single-ended + common - case.

***
Out of the curiosity (which means there is no need to reply if you're 
busy - I assume I can go and look the code to see what the 
'differential' and 'channel2' modifiers are used for)

What role does the "differential" Vs "single-ended" play for the users? 
I suppose it sure affects to what channels are reserved/free - but I 
would assume users were just interested to get the measurement result 
without caring about whether the signal is measured over differential 
pair or single-ended to gnd(?).
***

> 		}
> 					
> 
>> +		ret = fwnode_property_read_u32_array(child, "diff-channels",
>> +						     &diff[0], 2);
>> +		if (!ret)
>> +			chtypes_found |= IIO_ADC_CHAN_PROP_TYPE_DIFF;
>> +
>> +		ret = fwnode_property_read_u32(child, "single-channel", &se);
>> +		if (!ret)
>> +			chtypes_found |= IIO_ADC_CHAN_PROP_TYPE_SINGLE_ENDED;
>> +
>> +		ret = fwnode_property_read_u32(child, "common-mode-channel",
>> +					       &common);
>> +		if (!ret)
>> +			chtypes_found |= BIT(IIO_ADC_CHAN_PROP_COMMON);
>> +
>> +		ret = iio_adc_prop_type_check_sanity(dev, expected_props,
>> +						     chtypes_found);
> 
> If we want to verify this (I'm not yet sure) then do it as you parse the
> properties, not separately.
> 
>> +		if (ret)
>> +			return ret;
>> +
>> +		*chan = *template;
>> +		chan->channel = ch;
>> +
>> +		if (chtypes_found & IIO_ADC_CHAN_PROP_TYPE_DIFF) {
>> +			chan->differential = 1;
>> +			chan->channel = diff[0];
>> +			chan->channel2 = diff[1];
>> +
>> +		} else if (chtypes_found & IIO_ADC_CHAN_PROP_TYPE_SINGLE_ENDED) {
>> +			chan->channel = se;
>> +			if (chtypes_found & BIT(IIO_ADC_CHAN_PROP_COMMON))
>> +				chan->channel2 = common;
>> +		}
>> +
>> +		/*
>> +		 * We assume the channel IDs start from 0. If it seems this is
>> +		 * not a sane assumption, then we have to add 'allowed ID ranges'
>> +		 * to the struct iio_adc_props because some of the callers may
>> +		 * rely on the IDs being in this range - and have arrays indexed
>> +		 * by the ID.
> 
> Not a requirement in general.  It is more than possible to have a single channel
> provided that is number 7.

I think a few of the drivers did assume that the channel indexes start 
from zero, and go to num_channels - 1. It seemed quite usual that the 
channel IDs were used to index arrays with NUM_CHANNELS elements. A few 
did also check that the IDs were in a valid range.

I will add a max_id parameter to the API (and drop the 
'expected_props'). This should be useful for majority of the callers and 
help them to omit open-coding this particular check. It should also 
remind the driver to check the size of found IDs to avoid overflow bugs. 
As far as I remember at least one of the drivers which I encountered 
just trusted the DT channel IDs to be within valid range.

I'll allow omitting the check by setting the max_id to -1.

> 
>> +		 */
>> +		if (chan->channel >= num_chan)
>> +			return -ERANGE;
>> +
>> +		chan++;
>> +	}
>> +
>> +	return num_chan;
>> +}
>> +EXPORT_SYMBOL_GPL(devm_iio_adc_device_alloc_chaninfo);
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_AUTHOR("Matti Vaittinen <mazziesaccount@gmail.com>");
>> +MODULE_DESCRIPTION("IIO ADC fwnode parsing helpers");
>> diff --git a/include/linux/iio/adc-helpers.h b/include/linux/iio/adc-helpers.h
>> new file mode 100644
>> index 000000000000..f7791d45dbd2
>> --- /dev/null
>> +++ b/include/linux/iio/adc-helpers.h
>> @@ -0,0 +1,56 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +
>> +/* The industrial I/O ADC helpers
> Comment syntax and make it more obvious that while this might be useful
> it isn't something we necessarily expect to be useful to every driver.
> /*
>   * Industrial I/O ADC firmware property passing helpers.
>   *
> 

Thanks :)

Yours,
	-- Matti

