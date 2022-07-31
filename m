Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A53D58611A
	for <lists+linux-iio@lfdr.de>; Sun, 31 Jul 2022 21:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbiGaTtg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 Jul 2022 15:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiGaTtf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 31 Jul 2022 15:49:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31449590
        for <linux-iio@vger.kernel.org>; Sun, 31 Jul 2022 12:49:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 51446B80D18
        for <linux-iio@vger.kernel.org>; Sun, 31 Jul 2022 19:49:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9435BC433C1;
        Sun, 31 Jul 2022 19:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659296971;
        bh=RcomJv9S9Fr3N8YAEgiOLgwzuohm3hnEu/UlcyncnPc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rfrDKVlwhmfOXw13doCoAIumcBlI0sTkUl92rp+0fFIV2ct1kwzt3WPsEOIKrn22G
         k0HRy7ellcqq3Whtl5iAZ5VgQJ2vbT/RbcKrs4OxqgBS5xpN8l0Jp/cUS0M7WABCfj
         zqP2bYLeCHBJGhzcLzbDdPUhnrpFw5HIH8mbtMCpk7gJfemsycU/B2yNUmjI/YyIdB
         tzHPFvCr898I9mJFRdyNKW3rmEdzphjUtuDDNIZixzOBxqtYHpYaLMd2W2Zpo9cjph
         Z9C3kaWVfIKiFaTKYM2wYFzpScZ4wN/zYA9WTcVQEYj8Gwz+v15oEs+nkBKEcKa2Im
         nAwAO8O5Yy5/A==
Date:   Sun, 31 Jul 2022 20:59:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ibrahim Tilki <Ibrahim.Tilki@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <Nuno.Sa@analog.com>,
        <Nurettin.Bolucu@analog.com>, <andy.shevchenko@gmail.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: Re: [PATCH v2 1/3] iio: adc: add max11410 adc driver
Message-ID: <20220731205943.0fb5c8cc@jic23-huawei>
In-Reply-To: <20220719145932.96-2-Ibrahim.Tilki@analog.com>
References: <20220707174739.21fe67ea@jic23-huawei>
        <20220719145932.96-2-Ibrahim.Tilki@analog.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 19 Jul 2022 14:59:31 +0000
Ibrahim Tilki <Ibrahim.Tilki@analog.com> wrote:

> > On Thu, 7 Jul 2022 08:31:24 +0000
> > Ibrahim Tilki <Ibrahim.Tilki@analog.com> wrote:
> >   
> > > Adding support for max11410 24-bit, 1.9ksps delta-sigma adc which
> > > has 3 differential reference and 10 differential channel inputs.
> > > Inputs and references can be buffered internally. Inputs can also
> > > be amplified with internal PGA.
> > > 
> > > Device has a digital filter that is controlled by a custom sysfs attribute.
> > > User has four options to choose from: fir50/60, fir50, fir60 and sinc4.
> > > Digital filter selection affects sampling frequency range so driver
> > > has to consider the configured filter when configuring sampling frequency.
> > > 
> > > Signed-off-by: Ibrahim Tilki <Ibrahim.Tilki@analog.com>
> > > Reviewed-by: Nurettin Bolucu <Nurettin.Bolucu@analog.com>  
> > 
> > Hi Ibrahim,
> > 
> > As you probably expect, quite a bit of the feedback inline is about the
> > custom sysfs attribute. I think we need to fit that more closely to the current
> > filter ABI.  It's not a perfect fit however, but I make some suggestions inline.
> > 
> > thanks,
> > 
> > Jonathan
> >   
> 
> Hi Jonathan,
> 
> Thanks for the review, I've resolved most of the items and will send v3 soon after
> I perform some more tests with the hardware. In the meantime I have some questions inline.
> 
> Regards,
> Ibrahim
> 
> ...
> 
> > > +static int max11410_read_reg(struct max11410_state *st,
> > > +			     unsigned int reg,
> > > +			     int *val)
> > > +{
> > > +	u8 data[3];
> > > +	int ret;
> > > +
> > > +	if (max11410_reg_size(reg) == 3) {
> > > +		ret = regmap_bulk_read(st->regmap, reg, data, 3);  
> > 
> > Ah. There is a fun corner here.  SPI bulk reads in general
> > require DMA safe buffers (basically they need to be on the heap, not the
> > stack and we need to enforce that nothing else shares a cacheline with them).
> > Now, last time I checked regmap happens to always end up using a safe bounce
> > buffer, but it's not documented as such and there is no guarantee it will continue
> > to do so.  We checked this with the maintainer a while back and the answer
> > was to always use DMA safe buffers with bulk accesses.
> > Whilst that might have changed, I've not heard anything about it doing so.
> >   
> 
> So I guess having this would solve dma alignment and the leak issue in max11410_trigger_handler
> and the data field can be shared between?
> 
> struct max11410_state {
> 	// ...
> 	struct {
> 		int data ____cacheline_aligned;
> 		s64 ts __aligned(8);
> 	} scan;
> };
> 
> ...
> 
> > > +static const char * const config_filter[] = {"fir50/60", "fir50", "fir60", "sinc4"};  
> > 
> > Hmm.  Named filters are a pain because userspace can rarely figure out what
> > to do with them.  Here we have some notch filters (and we have ABI defined for those)
> > but the fir50/60 is unusual as it's some sort of double notch.  I think the
> > sinc4 is a higher frequency notch filter..
> > 
> > We need to be very careful with naming this attribute though as the ABI
> > documentation system will only allow us one iio:deviceX/filter entry.
> > We can't have it different across different drivers.
> > 
> > Hence, let's try and fit this in (more or less) current ABI.
> > 
> > in_voltageX_filter_notch_centre - (50 or 60 or whatever the SPS rate is)
> > 
> > That just leaves us with the double notch.  I'm a bit stuck on that
> > one so we may need to add new ABI for it which also means adding
> > enable attributes for the filters which we've so far not done.
> > 
> > If anyone has a suggestion for a good solution to this then let us know.
> > Maybe something like
> > 
> > in_voltageX_filter0_notch_centre
> > in_voltageX_filter0_notch_en
> > in_votlageX_filter1_notch_centre
> > in_voltageX_filter1_notch_en
> > 
> > If filter0_notch_en is set and the value is 50 or 60 then
> > filter1_notch_centre_available has the other value.
> > To enable double notch filtering both enables have to be set.
> > 
> > The side effect will be that no existing userspace will understand
> > this.
> >   
> 
> The thing is sinc4 filter has no fixed notch frequency, it is a function of sampling rate.

True, but that's not a problem as an ABI in IIO is allowed to change any other ABI.  The
semantics would be a bit fiddly here but not too bad.

> So even if we somehow do it this way, sinc4 rejection frequency can be 60Hz when sampling
> rate is 60sps. This can create ambiguity between sinc4 and fir60. 
True enough, though I'm not sure that it would be particularly critical if it did..
I'd assume rejection for the fixed filters is no worse than that for the variable one...
Also, a quick glance at page 8 of the datasheet suggests that the fir filters are only
useable with data rates below 60Hz.  Tables 9a,b,c,d seem to match this.

> I think the filter of
> the device has a unique characteristic to be fit into standard ABI.
> 
> Would it be a good idea to add ABI for filter type?
> in_voltageX_filter_type

I'm not particularly keen on it. There are far too many types of filters out there
on devices.  However, if we really can't make it work otherwise, then I guess we
may have to.

The closest precedence I could come up with in a quick grep is ad7124 which has
sinc3 and sinc4 types available. It picks on the basis of which filter happens to
correspond to the highest output data rate (I'm not immediately sure why!)
+CC Alexandru for any info that can be shared on that.

> 
> ...
> 
> > > +
> > > +static int max11410_read_avail(struct iio_dev *indio_dev,
> > > +			       struct iio_chan_spec const *chan,
> > > +			       const int **vals, int *type, int *length,
> > > +			       long info)
> > > +{
> > > +	int ret, reg_val, filter;
> > > +	struct max11410_state *st = iio_priv(indio_dev);
> > > +
> > > +	switch (info) {
> > > +	case IIO_CHAN_INFO_HARDWAREGAIN:  
> > 
> > Hardware gain is rarely what you actually want for an ADC.
> > It is used to describe gain for things not directly related
> > to the actual measurement made.
> > 
> > If this affects the multiplier that should be applied to _raw
> > then it is _SCALE;  In this case you will need to take
> > into account the combination of this PGA and the reference
> > voltages to compute the available values for SCALE
> >   
> 
> This controls the gain of internal PGA which amplifies the input signal right before the ADC
> conversion takes place. From this I understand that I need to divide _SCALE by hardware gain
> to compensate PGA effect.
Yes if I also understand this correctly.   At the end of the day check that whatever the
settings

(_raw + _offset) * _scale == value of voltage at the input
if _offset is missing assume it is 0.

> 
> ...
> 
> > > +		cfg = &st->channels[chan_idx];
> > > +		ret = fwnode_property_read_u32(child, "adi,reference", &reference);
> > > +		if (ret) {
> > > +			cfg->refsel = REFSEL_AVDD_AGND;
> > > +		} else {
> > > +			if (reference > REFSEL_MAX)
> > > +				return dev_err_probe(&indio_dev->dev,
> > > +						     -EINVAL,
> > > +						     "Invalid adi,reference value for %s, should be less than %d.\n",
> > > +						     fwnode_get_name(child),
> > > +						     REFSEL_MAX + 1);
> > > +
> > > +			cfg->refsel = reference;
> > > +		}  
> > 
> > Simplified if you rely on fwnode_property_read_u32 not setting reference unless it succeeds.
> > 
> > 		cfg->refsel = REFSEL_AVDD_AGND;
> > 		fwnode_property_read_u32(child, "adi,reference", &reference);
> > 		if (reference > REFSEL_MAX)
> > 			return dev_err_probe(...);
> > 
> > However, this DT binding is non obvious as 0-2 are nicely labeled pins, but
> > 3 is 'magic' and corresponds to AVDD.
> > 
> > Perhaps we want the binding to not include setting it to AVDD.  The absense
> > of the property resulting in that fallback?
> > I'm also a bit confused why we don't have an issue if differential channel
> > and vrefn isn't supplied (but vrefp is)?
> >   
> 
> Driver assumes vrefn input is connected to GND if not specified in DT.
> Should we force the user to specify vrefn regulator even if the applied voltage is zero?
> If so, I can also add a check for vrefn.

Interesting corner case.  I think yes, we should require the binding to specify vrefn in either
case as it simplifies what we need describe in the binding doc.  Having to supply a fixed regulator
definition with voltage 0 shouldn't be large a burden.

> 
> > > +		if (!max11410_get_vrefp(st, cfg->refsel))
> > > +			return dev_err_probe(&indio_dev->dev,
> > > +					     -EINVAL,
> > > +					     "Invalid VREF configuration for %s, either specify corresponding VREFP regulator or change adi,reference property.\n",
> > > +					     fwnode_get_name(child));
> > > +
> > > +		ret = fwnode_property_read_u32(child, "adi,input-mode", &sig_path);  
> 
> ...
> 
> >   
> > > +MODULE_AUTHOR("David Jung <david.jung@analog.com>");  
> > 
> > Why no sign-off / co-developed by tags for David?
> >   
> 
> This driver is based on David's work which took place some time ago.
> I've introduced a lot of changes/features and contacted him before sending the patch but
> unfortunately didn't hear from him within a resonable time frame. Thus I thought it would
> not be okay to add sign-off tag.
Ok. That's fine.  Perhaps add a comment to that affect to the patch description because
I have a memory like a goldfish (and others may be curious ;)

> 
> > > +MODULE_AUTHOR("Ibrahim Tilki <ibrahim.tilki@analog.com>");
> > > +MODULE_DESCRIPTION("Analog Devices MAX11410 ADC");
> > > +MODULE_LICENSE("GPL v2");  

