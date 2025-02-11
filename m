Return-Path: <linux-iio+bounces-15324-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FEEA30664
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 09:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E534918868D1
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 08:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921811F1528;
	Tue, 11 Feb 2025 08:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XY8OKnz/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128C41F12F8;
	Tue, 11 Feb 2025 08:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739263980; cv=none; b=ZK4SsU4M3RfrQQGQIY1H0h9u69DUjM0V5ACJu0LrKMBsdCMzYjzWD28iH6y9mqDCM3iUGrjcRVnhqWQPI+8FgMjbTFNcZpehDcfiJFGnr+S0XGyGfDi+5PuJZF1Q4asIjhrCzkPqD5SepWamTR+JFWxglIP8TGW8aMBVgZBuD6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739263980; c=relaxed/simple;
	bh=LOBHjTTFq7ArPf0vkYxir/KiAvthWr+rjv14vCcshjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HUkE/oo7WCPnIrISblxsIIj7BNRzTXBUXRGY7CnLpr79cx2WzuFoYLsZ3h7BzEmrRj7po12XpdiX+z/u7qP0d8+EzHIJYkZOxgPqiKu01N41BCM7eyBnZAzKA/K2WuvsRdQEuelGwc2yq1niv95we1L0+DsiEZrkw6FhKyyxVV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XY8OKnz/; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-545074b88aaso2594158e87.3;
        Tue, 11 Feb 2025 00:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739263976; x=1739868776; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=69HHcj51bRdh+s52pS6GdKrBnWE7+h/4gYtw7nnJHgc=;
        b=XY8OKnz/HMtS9HKJyfeGh5YoJgsbljNpz3msRB79tfvWnbFvnT8jIWwLQIRFTpfEeo
         qOt27ztQlx1VGWWZb4GdEcYFSOf2OiCbRqCisW//UwCLj0WvQ0PXHoQ3xjCQm4LB7TMh
         IFSe0fOTtSI9jo4pTB+WSbDj7FGmVwnizdJx7rdH683vWyQyBw5Sx8c9A3b4R8lJb36s
         2fNOZgv1YRsYOa6WZRI+haZG0bmGmX/j6psDfo4c1+GEOl1iuaeNhtFVqBlUSKK/yIDq
         62F0yZvT6cwhlAXmq9FT85gQfStmtycz2OlFhFGAXNeX8iAYpaJrNEyXJSSO2NnyjbGG
         orDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739263976; x=1739868776;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=69HHcj51bRdh+s52pS6GdKrBnWE7+h/4gYtw7nnJHgc=;
        b=pn99Mh9uN7UZ5IehPQfrGsoe/bnh6+PoNE150vO2k8Xno+cheUOMpU0orSvtbZuEvj
         9BKUczlyD0KIV+ltS+lEeG43XgAS/tL/vfYaN7UHGThHhn4rO1EPLuIotfukJ4xDEdab
         Gv+6yQREin/hMwfXsJWpt7VfGut9X7Qd+/7buSnc5+BWOyp5c0z4xAQIGK+3LaHOnmGr
         SFHvcUMA8pkBQyuF8hOP2pf1A/hFyibql+Dtml6gtKEkmS5A0jbweFtaIoxdzJqEriKh
         lp1KAtTHntdLk4mtxau9htoLTP0WBwf793fUskQ5d8NXqP7TkL9GjjR9jJ45R312Ibp/
         +FVw==
X-Forwarded-Encrypted: i=1; AJvYcCWY0SyU2lC+1GCtALR3zIhPH7BHFdFW7MW960VjA6aoTvKQuD5L9hDxzDE3Ilh7dAFyrkFt3BVnDF53@vger.kernel.org, AJvYcCWcKu4K0Z/GSrc9+Dxg9elAZ4bTUKQdgmmpznK54lGQw9wIVZ+ws+nhYbup1Rb5Z3fkOUTJHsNz2lk8@vger.kernel.org, AJvYcCXMhaai0y27BJNFqRfx8RAG7GT6MqPmN6SOozSoBbCSVePZ+nDtIoqOTjsYi6DqJetMk9OzhZ+TNxj/XquE@vger.kernel.org
X-Gm-Message-State: AOJu0YwhLuuVDhBQH8+W+DnGVRqRuoyxuMh5i6IyaTHih0KQ86m3ymSE
	wx9k27ZG4MxmTqiaBP1gd2amytc4qZsnwakxG74+ft1Ht8PEXmwUsEanlw==
X-Gm-Gg: ASbGncv97EoDddCxecWp/PI7qVVrQiyAuEJ2GMdRlqFkS0RNYkPhyheank2rsjwyGnG
	DxIqRLlsD8Q7uhxbmWCwAGiMTLinn9jDy6YidpKgTWhpQb29d/1Sopgf6K+1MNFaeEAdRSbVNof
	a2Of5kCVnjSJrHRVVEapPuaqx6TeEkQdTRSlfEyemvXXrcI/2e8lFVec/SKzl2dK1fBoU+lIC9I
	osG27gMjuJHPu1GHEHhf9ZL0k1g9YoZKXQrTU2bOzcXoLks4Jd+dg/dDqNcS4lYOdscYgpf5hyb
	Obvm/qOxpjg1Wk0d40zNMdcudsbu
X-Google-Smtp-Source: AGHT+IF8ItHcOlB0zYKW3S90Wm3OrE5PYDPnCbHLFuDA7Gd/kpCZ2rzZ9qa9aTFgSjE1B7P/njWYdg==
X-Received: by 2002:a05:6512:3b86:b0:545:fc8:e155 with SMTP id 2adb3069b0e04-5450fc8e3cfmr1605864e87.20.1739263975536;
        Tue, 11 Feb 2025 00:52:55 -0800 (PST)
Received: from [172.16.183.207] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54410555a3csm1455714e87.78.2025.02.11.00.52.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 00:52:53 -0800 (PST)
Message-ID: <ed0e43d8-9ab4-4614-9079-8a592ca8b185@gmail.com>
Date: Tue, 11 Feb 2025 10:52:51 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] iio: adc: add helpers for parsing ADC nodes
To: Jonathan Cameron <jic23@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1738761899.git.mazziesaccount@gmail.com>
 <337895af7418a8e4b20b5a9322344b68082508ae.1738761899.git.mazziesaccount@gmail.com>
 <20250208164111.28ec9f2d@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250208164111.28ec9f2d@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jonathan,

Thanks for the review and all the comments!

Just a note that I am currently spending some quality time with 
rebuilding the floor of my house. Leaking floor drain can cause a bit of 
a work... :rolleyes: So, my time with upstream work is a bit limited - 
although writing an occasional bug or two can help one to keep the 
balance ;)

Anyways, my replies and new versions may be slower than usual..

On 08/02/2025 18:41, Jonathan Cameron wrote:
> On Wed, 5 Feb 2025 15:34:51 +0200
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
>> RFC v1 => v2:
>>   - New patch
>>
>> I think it might be nice to have helpers for fetching also the other
>> generic (non vendor specific) ADC properties (as listed in the
>> Documentation/devicetree/bindings/iio/adc/adc.yaml) - but as I don't
>> have use for those in BD79124 driver (at least not for now), I don't
>> imnplement them yet. Anyways, this commit creates a place for such
>> helpers.
> 
> There is often a mix of vendor specific and not in channel nodes.
> Hence I'm not sure how widely this will be and it is driver
> specific which of the standard things make sense.

I definitely agree. Still, in my experience, no written standard 
standardizes use as well as written helpers ;) More we support parsing 
the generic helpers by the (add subsystem here)-core, more the driver 
writes will use the generic properties (instead of brewing vendor 
specific ones).

> So before I'd consider a helper like this I'd want to see it alongside
> a bunch of users including some of the complex ones so that we know
> it generalizes well enough.  It doesn't make sense to introduce
> it otherwise - just keep the code in the specific drivers instead.
> 
> It's an interesting idea, but not a trivial one :)

I agree it's not trivial. But I believe adding helpers one-by-one to 
cover 'normal' use-cases guide the use of the properties. Those who need 
something more exotic can always implement their custom handlers - and 
then a reviewer of such handler can ask "why" ;)


>> ---
>>   drivers/iio/adc/Kconfig            |   3 +
>>   drivers/iio/adc/Makefile           |   1 +
>>   drivers/iio/adc/industrialio-adc.c | 151 +++++++++++++++++++++++++++++
>>   include/linux/iio/adc-helpers.h    |  22 +++++
>>   4 files changed, 177 insertions(+)
>>   create mode 100644 drivers/iio/adc/industrialio-adc.c
>>   create mode 100644 include/linux/iio/adc-helpers.h
>>
>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>> index 849c90203071..37b70a65da6f 100644
>> --- a/drivers/iio/adc/Kconfig
>> +++ b/drivers/iio/adc/Kconfig
>> @@ -6,6 +6,9 @@
>>   
>>   menu "Analog to digital converters"
>>   
>> +config IIO_ADC_HELPER
>> +	tristate
>> +
>>   config AB8500_GPADC
>>   	bool "ST-Ericsson AB8500 GPADC driver"
>>   	depends on AB8500_CORE && REGULATOR_AB8500
>> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
>> index ee19afba62b7..956c121a7544 100644
>> --- a/drivers/iio/adc/Makefile
>> +++ b/drivers/iio/adc/Makefile
>> @@ -57,6 +57,7 @@ obj-$(CONFIG_FSL_MX25_ADC) += fsl-imx25-gcq.o
>>   obj-$(CONFIG_GEHC_PMC_ADC) += gehc-pmc-adc.o
>>   obj-$(CONFIG_HI8435) += hi8435.o
>>   obj-$(CONFIG_HX711) += hx711.o
>> +obj-$(CONFIG_IIO_ADC_HELPER) += industrialio-adc.o
>>   obj-$(CONFIG_IMX7D_ADC) += imx7d_adc.o
>>   obj-$(CONFIG_IMX8QXP_ADC) += imx8qxp-adc.o
>>   obj-$(CONFIG_IMX93_ADC) += imx93_adc.o
>> diff --git a/drivers/iio/adc/industrialio-adc.c b/drivers/iio/adc/industrialio-adc.c
>> new file mode 100644
>> index 000000000000..366e4c8eb6c7
>> --- /dev/null
>> +++ b/drivers/iio/adc/industrialio-adc.c
>> @@ -0,0 +1,151 @@
> 
> 
>> +
>> +/**
>> + * iio_adc_device_get_channels - get ADC channel IDs
> 
> This sounds far too like the inkern interfaces.  Need to associate it instead
> with the fwnode / properties stuff.

I was juggling between using the 'fwnode' and 'device'. I took the 
'device' approach in order to be consistent with the naming convention 
for the functions in property.h.

For example:
device_property_read_u<N>_array() and
fwnode_property_read_u<N>_array()

depending on if the node is found via device pointer, or if the fwnode 
is passed directly.

> 
>> + *
>> + * Scan the device node for ADC channel information. Return an array of found
>> + * IDs. Caller need to allocate the memory for the array and provide maximum
> 
> Caller needs to provide the memory

Thanks!

> 
>> + * number of IDs the array can store.
>> + *
>> + * @dev:		Pointer to the ADC device
>> + * @channels:		Array where the found IDs will be stored.
>> + * @max_channels:	Number of IDs that fit in the array.
>> + *
>> + * Return:		Number of found channels on succes. Negative value to
>> + *			indicate failure.
>> + */
>> +int iio_adc_device_get_channels(struct device *dev, int *channels,
>> +				int max_channels)
>> +{
>> +	struct fwnode_handle *fwnode, *child;
>> +	int num_chan = 0, ret;
>> +
>> +	fwnode = dev_fwnode(dev);
>> +	if (!fwnode) {
> 
> As before, I'd relax this until we need to do it. We may never do so.

The BD79124 does not require this as I dropped the MFD, so this is 
ultimately your call :) I, however, would like to humbly suggest adding 
it now ;) I have changed some APIs in the regulator subsystem and in the 
clk subsystem to support cases where the device-tree node is in the 
parent (usual MFD device-case), and it has been somewhat scary... (What 
if somewhere in some of the existing device-trees the parent happens to 
have interesting properties - but it actually is not correct node? This 
becomes a potential source of regression when adding support to an 
existing API).

Furthermore, when the node is unconditionally taken from the given 
device-pointer, it is tempting for the caller to just pass the parent 
device as argument...

  - If you have done this - please raise your hand. /me raises.
  - If you have only later realized it can cause life-time issues when
    devm is used - please raise your hand. /me raises.
  - If you have tried to kick your own behind when fixing the issues -
    please, raise your hand. /me raises. (and if you succeeded - congraz,
    you aren't as old and clumsy as I am).

> 
>> +		fwnode = dev_fwnode(dev->parent);
>> +		if (!fwnode)
>> +			return -ENODEV;
>> +	}
>> +	fwnode_for_each_child_node(fwnode, child) {
>> +		if (fwnode_name_eq(child, "channel")) {
> 
> As below. I'd flip the logic here and use a continue

Makes sense.

> 
>> +			u32 ch;
>> +
>> +			if (num_chan == max_channels)
>> +				return -EINVAL;
>> +
>> +			ret = fwnode_property_read_u32(child, "reg", &ch);
>> +			if (ret)
>> +				return ret;
>> +
>> +			/*
>> +			 * We assume the channel IDs start from 0. If it seems
>> +			 * this is not a sane assumption, then we can relax
>> +			 * this check or add 'allowed ID range' parameter.
>> +			 *
>> +			 * Let's just start with this simple assumption.
>> +			 */
>> +			if (ch > max_channels)
>> +				return -ERANGE;
>> +
>> +			channels[num_chan] = ch;
>> +			num_chan++;
> 			channel[num_chan++] = ch;
> 
> So it is clear how the two are coupled.

Ouch. I am not fan of this. I have a personal issue as I always need to 
wonder if this was the case where the ++foo and foo++ resulted different 
functionality. I end up doing a test to see in which index the result 
got stored. If you don't feel stronly about this, then I would like to 
keep the index increase and assignment in separate rows. I believe the 
coupling is still quite visible for as long as we keep the assignment 
and increase next to each other. But yeah, if you do feel strongly about 
this, then it can be implemented as you suggest.

> 
>> +		}
>> +	}
>> +
>> +	return num_chan;
>> +
>> +}
>> +EXPORT_SYMBOL_GPL(iio_adc_device_get_channels);
>> +
>> +/**
>> + * devm_iio_adc_device_alloc_chaninfo - allocate and fill iio_chan_spec for adc
>> + *
>> + * Scan the device node for ADC channel information. Allocate and populate the
>> + * iio_chan_spec structure corresponding to channels that are found. The memory
>> + * for iio_chan_spec structure will be freed upon device detach. Try parent
>> + * device node if given device has no fwnode associated to cover also MFD
>> + * devices.
> 
> I'd leave that parent node check until we need it (unless you need it for
> this one!).  Feels like infra structure that might never be used.
> That would let us for now use the device_for_each_child_node()
> handling.

As above, I adviece to implement the parent device use right from the 
beginning - but I can change this as BD79124 dropped MFD.

> 
>> + *
>> + * @dev:	Pointer to the ADC device
>> + * @template:	Template iio_chan_spec from which the fields of all found and
>> + *		allocated channels are initialized.
>> + * @cs:		Location where pointer to allocated iio_chan_spec should be
>> + *		stored
>> + *
>> + * Return:	Number of found channels on succes. Negative value to indicate
>> + *		failure.
>> + */
>> +int devm_iio_adc_device_alloc_chaninfo(struct device *dev,
>> +				       const struct iio_chan_spec *template,
>> +				       struct iio_chan_spec **cs)
>> +{
>> +	struct fwnode_handle *fwnode, *child;
>> +	struct iio_chan_spec *chan;
>> +	int num_chan = 0, ret;
>> +
>> +	fwnode = dev_fwnode(dev);
>> +	if (!fwnode) {
>> +		fwnode = dev_fwnode(dev->parent);
>> +		if (!fwnode)
>> +			return -ENODEV;
>> +	}
>> +
>> +	num_chan = iio_adc_fwnode_num_channels(fwnode);
>> +	if (num_chan < 0)
>> +		return num_chan;
>> +
>> +	*cs = devm_kcalloc(dev, num_chan, sizeof(**cs), GFP_KERNEL);
>> +	if (!*cs)
>> +		return -ENOMEM;
>> +
>> +	chan = &(*cs)[0];
>> +
>> +	fwnode_for_each_child_node(fwnode, child) {
>> +		if (fwnode_name_eq(child, "channel")) {
> Flip logic probably and use a continue to reduce indent of
> the next bit (which may well get a lot more complex in future).
> 

Right, thanks.

>> +			u32 ch;
>> +
>> +			ret = fwnode_property_read_u32(child, "reg", &ch);
>> +			if (ret)
>> +				return ret;
> 
> In general the association between reg and channel is more complex.
> We need to deal with a reasonable subset of cases (single-channel, diff-channels
> etc) where it isn't the case that chan == chan->channel.

I guess this is right. I, however, lacked of knowledge on how the 
differential channels etc. are handled :) Hence I just implemented what 
I believe is "the most common" approach, while leaving the rest to be 
implemented by those who need it.

Still, I agree that a generic looking API which silently produces bad 
results for a few of the use-cases is not nice. By the very minimum we 
should check if single-channel, diff-channels properties are present, 
and then error out with a warning print. That should give a good hint 
for those driver writers who are trying to use API for something 
unsupported.

Also, restrictions should be mentioned in the documentation.

Do you think we should use some more specific function naming, like 
"_simple" - suffix?

> 
>> +
>> +			*chan = *template;
>> +			chan->channel = ch;
>> +
>> +			if (num_chan > 1)
>> +				chan->indexed = 1;
> 
> I think set this whatever, probably in the template.
> I don't want to see the interface change just because a given DT says
> only one channel is connected.

Ah. I didn't think of that! Good point.


Yours,
   -- Matti

