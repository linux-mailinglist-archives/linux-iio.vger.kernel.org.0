Return-Path: <linux-iio+bounces-15353-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 019F0A3149D
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 20:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4186E188A6C5
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 19:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F3526216A;
	Tue, 11 Feb 2025 19:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ccNrwEt3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE61261594;
	Tue, 11 Feb 2025 19:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739300844; cv=none; b=Z+kBCU3UjdlHCMo4644/x3NqpXCwJXvL1r+QHDO/s5Jx8Svh2CmNY81i7c/PqcViKd2szov5bWBpteL9uE7MtPI5FCfrUC4uZR+ibf0VhbCRkEO26Ie/NnN0ZyJX13nGianEI0jWFfKil8o+Wda3eyWNAkeLjP4djWwY6iJjtLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739300844; c=relaxed/simple;
	bh=+fLtFrZUkpPNNMcb/NVSIFiSfCwCxfxqa4Oh9OB41Gw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GqXNVW5JhJTA0y8gbUZTNkaEQHTFsP/J9r+aiNKdf6M8pglUBjKdBsAGSL9CHwPjIjNXvMo2w+PFIWo6NmNvTOekk2oQ2YdITzPzOmkPsyefuMyEwZVEHULyUHXwHVzU9Qe0+TdrgtgGNrgCdoMxWzCtXSOVMzMY/9f9yJH/O1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ccNrwEt3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16308C4CEDD;
	Tue, 11 Feb 2025 19:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739300844;
	bh=+fLtFrZUkpPNNMcb/NVSIFiSfCwCxfxqa4Oh9OB41Gw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ccNrwEt3odF7tPWGlzcBuMxcRwJOziHg1Lh2STRTtK1thrnJDlOXFRKYvEbV74Ei4
	 qNhF7nVzPUkBOKnbhEYmGh/iOlMlOaUt5+j8vlzI5xGem21druTa/f2Ug7JHMCRb/Q
	 +z1mxDr0PtIYIqfB+1CSTPwmC0l+ULSCchRb5jurRq3IpnK/wMWmrtGsfOlVwn5JRk
	 VIl4h+AVAIhsVw4ilKjo06hysU3wd5XFF4K3c7l33cXn/CKF8Opz6IYOYMn7pDc/5C
	 7tIeq8p3zHcQOhCaRWaeTw3oVmRleZwPWOyrofZV+THpjeddr0F8+CMLX8HMHJ37yM
	 QlL2+ntlfFjog==
Date: Tue, 11 Feb 2025 19:07:14 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nuno Sa
 <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] iio: adc: add helpers for parsing ADC nodes
Message-ID: <20250211190714.4db240d2@jic23-huawei>
In-Reply-To: <ed0e43d8-9ab4-4614-9079-8a592ca8b185@gmail.com>
References: <cover.1738761899.git.mazziesaccount@gmail.com>
	<337895af7418a8e4b20b5a9322344b68082508ae.1738761899.git.mazziesaccount@gmail.com>
	<20250208164111.28ec9f2d@jic23-huawei>
	<ed0e43d8-9ab4-4614-9079-8a592ca8b185@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Feb 2025 10:52:51 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Hi Jonathan,
> 
> Thanks for the review and all the comments!
> 
> Just a note that I am currently spending some quality time with 
> rebuilding the floor of my house. Leaking floor drain can cause a bit of 
> a work... :rolleyes: So, my time with upstream work is a bit limited - 
> although writing an occasional bug or two can help one to keep the 
> balance ;)
> 
> Anyways, my replies and new versions may be slower than usual..
> 
> On 08/02/2025 18:41, Jonathan Cameron wrote:
> > On Wed, 5 Feb 2025 15:34:51 +0200
> > Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> >   
> >> There are ADC ICs which may have some of the AIN pins usable for other
> >> functions. These ICs may have some of the AIN pins wired so that they
> >> should not be used for ADC.
> >>
> >> (Preferred?) way for marking pins which can be used as ADC inputs is to
> >> add corresponding channels@N nodes in the device tree as described in
> >> the ADC binding yaml.
> >>
> >> Add couple of helper functions which can be used to retrieve the channel
> >> information from the device node.
> >>
> >> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> >>
> >> ---
> >> Revision history:
> >> RFC v1 => v2:
> >>   - New patch
> >>
> >> I think it might be nice to have helpers for fetching also the other
> >> generic (non vendor specific) ADC properties (as listed in the
> >> Documentation/devicetree/bindings/iio/adc/adc.yaml) - but as I don't
> >> have use for those in BD79124 driver (at least not for now), I don't
> >> imnplement them yet. Anyways, this commit creates a place for such
> >> helpers.  
> > 
> > There is often a mix of vendor specific and not in channel nodes.
> > Hence I'm not sure how widely this will be and it is driver
> > specific which of the standard things make sense.  
> 
> I definitely agree. Still, in my experience, no written standard 
> standardizes use as well as written helpers ;) More we support parsing 
> the generic helpers by the (add subsystem here)-core, more the driver 
> writes will use the generic properties (instead of brewing vendor 
> specific ones).
> 
> > So before I'd consider a helper like this I'd want to see it alongside
> > a bunch of users including some of the complex ones so that we know
> > it generalizes well enough.  It doesn't make sense to introduce
> > it otherwise - just keep the code in the specific drivers instead.
> > 
> > It's an interesting idea, but not a trivial one :)  
> 
> I agree it's not trivial. But I believe adding helpers one-by-one to 
> cover 'normal' use-cases guide the use of the properties. Those who need 
> something more exotic can always implement their custom handlers - and 
> then a reviewer of such handler can ask "why" ;)
I'd be fine with a series taking on the task of converting handling of
all the documented properties in adc.yaml

If we do less than that it may never get wide adoption and we end
up with a bit of generic looking infrastructure that isn't generic.

> 
> 
> >> ---
> >>   drivers/iio/adc/Kconfig            |   3 +
> >>   drivers/iio/adc/Makefile           |   1 +
> >>   drivers/iio/adc/industrialio-adc.c | 151 +++++++++++++++++++++++++++++
> >>   include/linux/iio/adc-helpers.h    |  22 +++++
> >>   4 files changed, 177 insertions(+)
> >>   create mode 100644 drivers/iio/adc/industrialio-adc.c
> >>   create mode 100644 include/linux/iio/adc-helpers.h
> >>
> >> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> >> index 849c90203071..37b70a65da6f 100644
> >> --- a/drivers/iio/adc/Kconfig
> >> +++ b/drivers/iio/adc/Kconfig
> >> @@ -6,6 +6,9 @@
> >>   
> >>   menu "Analog to digital converters"
> >>   
> >> +config IIO_ADC_HELPER
> >> +	tristate
> >> +
> >>   config AB8500_GPADC
> >>   	bool "ST-Ericsson AB8500 GPADC driver"
> >>   	depends on AB8500_CORE && REGULATOR_AB8500
> >> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> >> index ee19afba62b7..956c121a7544 100644
> >> --- a/drivers/iio/adc/Makefile
> >> +++ b/drivers/iio/adc/Makefile
> >> @@ -57,6 +57,7 @@ obj-$(CONFIG_FSL_MX25_ADC) += fsl-imx25-gcq.o
> >>   obj-$(CONFIG_GEHC_PMC_ADC) += gehc-pmc-adc.o
> >>   obj-$(CONFIG_HI8435) += hi8435.o
> >>   obj-$(CONFIG_HX711) += hx711.o
> >> +obj-$(CONFIG_IIO_ADC_HELPER) += industrialio-adc.o
> >>   obj-$(CONFIG_IMX7D_ADC) += imx7d_adc.o
> >>   obj-$(CONFIG_IMX8QXP_ADC) += imx8qxp-adc.o
> >>   obj-$(CONFIG_IMX93_ADC) += imx93_adc.o
> >> diff --git a/drivers/iio/adc/industrialio-adc.c b/drivers/iio/adc/industrialio-adc.c
> >> new file mode 100644
> >> index 000000000000..366e4c8eb6c7
> >> --- /dev/null
> >> +++ b/drivers/iio/adc/industrialio-adc.c
> >> @@ -0,0 +1,151 @@  
> > 
> >   
> >> +
> >> +/**
> >> + * iio_adc_device_get_channels - get ADC channel IDs  
> > 
> > This sounds far too like the inkern interfaces.  Need to associate it instead
> > with the fwnode / properties stuff.  
> 
> I was juggling between using the 'fwnode' and 'device'. I took the 
> 'device' approach in order to be consistent with the naming convention 
> for the functions in property.h.
> 
> For example:
> device_property_read_u<N>_array() and
> fwnode_property_read_u<N>_array()
> 
> depending on if the node is found via device pointer, or if the fwnode 
> is passed directly.
hmm.  The bit to avoid is 'get'.  

iio_adc_device_channels_from_properties() maybe?

> 
> >   
> >> + *
> >> + * Scan the device node for ADC channel information. Return an array of found
> >> + * IDs. Caller need to allocate the memory for the array and provide maximum  
> > 
> > Caller needs to provide the memory  
> 
> Thanks!
> 
> >   
> >> + * number of IDs the array can store.
> >> + *
> >> + * @dev:		Pointer to the ADC device
> >> + * @channels:		Array where the found IDs will be stored.
> >> + * @max_channels:	Number of IDs that fit in the array.
> >> + *
> >> + * Return:		Number of found channels on succes. Negative value to
> >> + *			indicate failure.
> >> + */
> >> +int iio_adc_device_get_channels(struct device *dev, int *channels,
> >> +				int max_channels)
> >> +{
> >> +	struct fwnode_handle *fwnode, *child;
> >> +	int num_chan = 0, ret;
> >> +
> >> +	fwnode = dev_fwnode(dev);
> >> +	if (!fwnode) {  
> > 
> > As before, I'd relax this until we need to do it. We may never do so.  
> 
> The BD79124 does not require this as I dropped the MFD, so this is 
> ultimately your call :) I, however, would like to humbly suggest adding 
> it now ;) I have changed some APIs in the regulator subsystem and in the 
> clk subsystem to support cases where the device-tree node is in the 
> parent (usual MFD device-case), and it has been somewhat scary... (What 
> if somewhere in some of the existing device-trees the parent happens to 
> have interesting properties - but it actually is not correct node? This 
> becomes a potential source of regression when adding support to an 
> existing API).
> 
> Furthermore, when the node is unconditionally taken from the given 
> device-pointer, it is tempting for the caller to just pass the parent 
> device as argument...
> 
>   - If you have done this - please raise your hand. /me raises.
>   - If you have only later realized it can cause life-time issues when
>     devm is used - please raise your hand. /me raises.
>   - If you have tried to kick your own behind when fixing the issues -
>     please, raise your hand. /me raises. (and if you succeeded - congraz,
>     you aren't as old and clumsy as I am).

Maybe. I'd be happier if there was a single user included
with a patch set doing this.  I'm not sure this applies to
any of the SoC ADCs which are MFD hosted but maybe it does.

> 
> >   
> >> +		fwnode = dev_fwnode(dev->parent);
> >> +		if (!fwnode)
> >> +			return -ENODEV;
> >> +	}
> >> +	fwnode_for_each_child_node(fwnode, child) {
> >> +		if (fwnode_name_eq(child, "channel")) {  
> > 
> > As below. I'd flip the logic here and use a continue  
> 
> Makes sense.
> 
> >   
> >> +			u32 ch;
> >> +
> >> +			if (num_chan == max_channels)
> >> +				return -EINVAL;
> >> +
> >> +			ret = fwnode_property_read_u32(child, "reg", &ch);
> >> +			if (ret)
> >> +				return ret;
> >> +
> >> +			/*
> >> +			 * We assume the channel IDs start from 0. If it seems
> >> +			 * this is not a sane assumption, then we can relax
> >> +			 * this check or add 'allowed ID range' parameter.
> >> +			 *
> >> +			 * Let's just start with this simple assumption.
> >> +			 */
> >> +			if (ch > max_channels)
> >> +				return -ERANGE;
> >> +
> >> +			channels[num_chan] = ch;
> >> +			num_chan++;  
> > 			channel[num_chan++] = ch;
> > 
> > So it is clear how the two are coupled.  
> 
> Ouch. I am not fan of this. I have a personal issue as I always need to 
> wonder if this was the case where the ++foo and foo++ resulted different 
> functionality. I end up doing a test to see in which index the result 
> got stored. If you don't feel stronly about this, then I would like to 
> keep the index increase and assignment in separate rows. I believe the 
> coupling is still quite visible for as long as we keep the assignment 
> and increase next to each other. But yeah, if you do feel strongly about 
> this, then it can be implemented as you suggest.

It's that question of them staying next to each other that is where
the included increment helps.  I don't mind that much on this.

> 
> >   
> >> +		}
> >> +	}
> >> +
> >> +	return num_chan;
> >> +
> >> +}
> >> +EXPORT_SYMBOL_GPL(iio_adc_device_get_channels);
> >> +
> >> +/**
> >> + * devm_iio_adc_device_alloc_chaninfo - allocate and fill iio_chan_spec for adc
> >> + *
> >> + * Scan the device node for ADC channel information. Allocate and populate the
> >> + * iio_chan_spec structure corresponding to channels that are found. The memory
> >> + * for iio_chan_spec structure will be freed upon device detach. Try parent
> >> + * device node if given device has no fwnode associated to cover also MFD
> >> + * devices.  
> > 
> > I'd leave that parent node check until we need it (unless you need it for
> > this one!).  Feels like infra structure that might never be used.
> > That would let us for now use the device_for_each_child_node()
> > handling.  
> 
> As above, I adviece to implement the parent device use right from the 
> beginning - but I can change this as BD79124 dropped MFD.
> 
> >   
> >> + *
> >> + * @dev:	Pointer to the ADC device
> >> + * @template:	Template iio_chan_spec from which the fields of all found and
> >> + *		allocated channels are initialized.
> >> + * @cs:		Location where pointer to allocated iio_chan_spec should be
> >> + *		stored
> >> + *
> >> + * Return:	Number of found channels on succes. Negative value to indicate
> >> + *		failure.
> >> + */
> >> +int devm_iio_adc_device_alloc_chaninfo(struct device *dev,
> >> +				       const struct iio_chan_spec *template,
> >> +				       struct iio_chan_spec **cs)
> >> +{
> >> +	struct fwnode_handle *fwnode, *child;
> >> +	struct iio_chan_spec *chan;
> >> +	int num_chan = 0, ret;
> >> +
> >> +	fwnode = dev_fwnode(dev);
> >> +	if (!fwnode) {
> >> +		fwnode = dev_fwnode(dev->parent);
> >> +		if (!fwnode)
> >> +			return -ENODEV;
> >> +	}
> >> +
> >> +	num_chan = iio_adc_fwnode_num_channels(fwnode);
> >> +	if (num_chan < 0)
> >> +		return num_chan;
> >> +
> >> +	*cs = devm_kcalloc(dev, num_chan, sizeof(**cs), GFP_KERNEL);
> >> +	if (!*cs)
> >> +		return -ENOMEM;
> >> +
> >> +	chan = &(*cs)[0];
> >> +
> >> +	fwnode_for_each_child_node(fwnode, child) {
> >> +		if (fwnode_name_eq(child, "channel")) {  
> > Flip logic probably and use a continue to reduce indent of
> > the next bit (which may well get a lot more complex in future).
> >   
> 
> Right, thanks.
> 
> >> +			u32 ch;
> >> +
> >> +			ret = fwnode_property_read_u32(child, "reg", &ch);
> >> +			if (ret)
> >> +				return ret;  
> > 
> > In general the association between reg and channel is more complex.
> > We need to deal with a reasonable subset of cases (single-channel, diff-channels
> > etc) where it isn't the case that chan == chan->channel.  
> 
> I guess this is right. I, however, lacked of knowledge on how the 
> differential channels etc. are handled :) Hence I just implemented what 
> I believe is "the most common" approach, while leaving the rest to be 
> implemented by those who need it.
> 
> Still, I agree that a generic looking API which silently produces bad 
> results for a few of the use-cases is not nice. By the very minimum we 
> should check if single-channel, diff-channels properties are present, 
> and then error out with a warning print. That should give a good hint 
> for those driver writers who are trying to use API for something 
> unsupported.
> 
> Also, restrictions should be mentioned in the documentation.
> 
> Do you think we should use some more specific function naming, like 
> "_simple" - suffix?

No to _simple. I think this needs to handle those cases before we
take it at all  They should all have enough docs in adc.yaml to
work out what happens.

The most complex cases are all Analog Devices parts and those
folk are very active on linux-iio so it should be easy to get
them to review a series using it.

I don't think it is going to be particularly hard to generalise
this.

We may end up with a variant that takes a 'per channel' callback
to fill in more data + a private pointer of some type as often
those are putting data in a parallel array of extra info about
the channels.  Let's see what it looks like.

Jonathan

> 
> >   
> >> +
> >> +			*chan = *template;
> >> +			chan->channel = ch;
> >> +
> >> +			if (num_chan > 1)
> >> +				chan->indexed = 1;  
> > 
> > I think set this whatever, probably in the template.
> > I don't want to see the interface change just because a given DT says
> > only one channel is connected.  
> 
> Ah. I didn't think of that! Good point.
> 
> 
> Yours,
>    -- Matti
> 


