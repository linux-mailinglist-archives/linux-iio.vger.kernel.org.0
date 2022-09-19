Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90CEF5BD113
	for <lists+linux-iio@lfdr.de>; Mon, 19 Sep 2022 17:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiISPcl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Sep 2022 11:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbiISPcU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Sep 2022 11:32:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F304D39B82;
        Mon, 19 Sep 2022 08:32:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F31761808;
        Mon, 19 Sep 2022 15:32:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46284C433C1;
        Mon, 19 Sep 2022 15:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663601533;
        bh=26t2/UJoemTo819SDeL6VAIlN0aOisBMpR5jKz+eUO0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pbLfLuDRDUKF7RV8BfPDlWNM/0ha0XJKDhgLlA0D/ajjOIFV7+13iFWetvKYwc0th
         BRv9jYLna4CkJx8tDuurAI4PJ2YT4HCqnWSW7Ix0l2zGvR0eICsx/VLyjUzDLHjVzs
         L+6PPuf5xcrIpDCfNweALSzZFNNjlxHIqfzS82gC7K4Yjw1XkRicsDPKnMKxsHH+q9
         7foGR7j+I8DyrzjEl5+GoKNIUCn5rmlUcH5K2gNHsuKLEhH7uetQ6vVYhhogD6vFfO
         MxTSFT6KSSckPxbxX3j3EYPAgOS/jZRVwDDDj9nYjQpBA2pbNAYxZjqoZa/SyiZD9Y
         BSINgVA2v7dNw==
Date:   Mon, 19 Sep 2022 16:32:14 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "nuno.sa@analog.com" <nuno.sa@analog.com>,
        "dragos.bogdan@analog.com" <dragos.bogdan@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>
Subject: Re: [RFT] potential bug with IIO_CONST_ATTR usage with triggered
 buffers
Message-ID: <20220919163214.5b757903@jic23-huawei>
In-Reply-To: <87fbfc8e-fb17-444d-22a2-3738ade77cb5@fi.rohmeurope.com>
References: <20210215104043.91251-1-alexandru.ardelean@analog.com>
        <20210215104043.91251-15-alexandru.ardelean@analog.com>
        <aecd6a19-79a8-d9a6-2dc4-73dcd756c92d@fi.rohmeurope.com>
        <87fbfc8e-fb17-444d-22a2-3738ade77cb5@fi.rohmeurope.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 19 Sep 2022 08:52:38 +0000
"Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com> wrote:

> On 9/9/22 11:12, Vaittinen, Matti wrote:
> > Hi dee Ho peeps!
> > 
> > Disclaimer - I have no HW to test this using real in-tree drivers. If
> > someone has a device with a variant of bmc150 or adxl372 or  - it'd be
> > nice to see if reading hwfifo_watermark_max or hwfifo_watermark_min
> > works with the v6.0-rc4. Maybe I am misreading code and have my own
> > issues - in which case I apologize already now and go to the corner
> > while being deeply ashamed :)  
> 
> I would like to add at least the at91-sama5d2_adc (conditonally 
> registers the IIO_CONST_ATTR for triggered-buffer) to the list of 
> devices that could be potentially tested. I hope some of these devices 
> had a user who could either make us worried and verify my assumption - 
> or make me ashamed but rest of us relieved :) Eg - I second my request 
> for testing this - and add potential owners of at91-sama5d2_adc to the list.
> 
> > On 2/15/21 12:40, Alexandru Ardelean wrote:  
> >> This change wraps all buffer attributes into iio_dev_attr objects, and
> >> assigns a reference to the IIO buffer they belong to.
> >>
> >> With the addition of multiple IIO buffers per one IIO device, we need a way
> >> to know which IIO buffer is being enabled/disabled/controlled.
> >>
> >> We know that all buffer attributes are device_attributes.  
> > 
> > I think this assumption is slightly unsafe. I see few drivers adding
> > IIO_CONST_ATTRs in attribute groups. For example the bmc150 and adxl372
> > add the hwfifo_watermark_min and hwfifo_watermark_max.
> >  
> 
> and at91-sama5d2_adc
> 
> //snip
> 
> >I noticed that using
> > IIO_CONST_ATTRs for triggered buffers seem to cause access to somewhere
> > it shouldn't... Oops.
> > 
> > Reading the code allows me to assume the problem is wrapping the
> > attributes to IIO_DEV_ATTRs.
> > 
> > static struct attribute *iio_buffer_wrap_attr(struct iio_buffer *buffer,
> > +					      struct attribute *attr)
> > +{
> > +	struct device_attribute *dattr = to_dev_attr(attr);
> > +	struct iio_dev_attr *iio_attr;
> > +
> > +	iio_attr = kzalloc(sizeof(*iio_attr), GFP_KERNEL);
> > +	if (!iio_attr)
> > +		return NULL;
> > +
> > +	iio_attr->buffer = buffer;
> > +	memcpy(&iio_attr->dev_attr, dattr, sizeof(iio_attr->dev_attr));
> > 
> > This copy does assume all attributes are device_attrs, and does not take
> > into account that IIO_CONST_ATTRS have the string stored in a struct
> > iio_const_attr which is containing the dev_attr. Eg, copying in the
> > iio_buffer_wrap_attr() does not copy the string - and later invoking the
> > 'show' callback goes reading something else than the mentioned string
> > because the pointer is not copied.  
> 
> Yours,
> 	-- Matti
Hi Matti,

+CC Alexandru on a current email address.

I saw this whilst travelling and completely forgot about when
I was back to normal - so great you sent a follow up!

Anyhow, your reasoning seems correct and it would be easy enough
to add such a case to iio/dummy/iio_simple_dummy_buffer.c and
provide a clear test for the problem.

As to solutions. The quickest is probably to switch these const attrs
over to a non const form and add a comment to the header to say they are
unsuitable for use with buffers.

An alternative would be to make it 'safe' by making the data layouts
match up.

struct iio_attr {
	struct device_attribute dev_attr;
	union {
		u64 address;
		const char *string;
	};
	struct list_head l;
	struct iio_chan_spec const *c;
	struct iio_buffer *buffer;
};

#define iio_dev_attr iio_attr
#define iio_const_attr iio_attr

Looking at this raises another potential problem.
Where is the address copied over for attributes using IIO_DEVICE_ATTR()?
Maybe I'm just missing it somewhere.  Grepping suggests we've been
lucky and there are no users of that field in buffer attributes.

Detecting the problem you found is going to be inherently tricky - though maybe
could rely on the naming of the attributes passed in (iio_const...)
and some scripting magic. 

Longer term, it's this sort of thing that motivates protections / runnable
CI self tests with, for example, the roadtest framework that I'm hoping
will be available upstream soonish!

Would you like to send patches given you identified the problem?

If not I'm happy to fix these up. My grepping identified the same 3 cases
you found.

Jonathan

