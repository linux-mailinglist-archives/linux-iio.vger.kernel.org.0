Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3BF318EA97
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 17:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbgCVQxY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 12:53:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:41044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbgCVQxY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 22 Mar 2020 12:53:24 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6EE2206F8;
        Sun, 22 Mar 2020 16:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584896003;
        bh=PoM6WPokFPax4XCKK0j4sFwE6uYh1cd7prgIs8gJuz0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EKzsfMaq4kI6h0cRWXjPeZaiC9IxTdKZwOalO+Pla+90hFDampCEwfoZExTAtPehS
         G2bswVGJVNjn7Vux+ArgdxMeeW1v4fin1cUhArq9QaGDxsI3pnzKMZYdGN6q9Xr+Jc
         n0ssDvKZuhKgUaLkCJmMiyVT0JUDf4DkudawaMNM=
Date:   Sun, 22 Mar 2020 16:53:17 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Grozav, Andrei" <Andrei.Grozav@analog.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "Nagy, Laszlo" <Laszlo.Nagy@analog.com>,
        "Csomortani, Istvan" <Istvan.Csomortani@analog.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        "Costina, Adrian" <Adrian.Costina@analog.com>
Subject: Re: [PATCH v11 5/8] iio: adc: adi-axi-adc: add support for AXI ADC
 IP core
Message-ID: <20200322165317.0b1f0674@archlinux>
In-Reply-To: <202003220901.880A6DF@keescook>
References: <20200321085315.11030-1-alexandru.ardelean@analog.com>
        <20200321085315.11030-6-alexandru.ardelean@analog.com>
        <CAHp75VecnornqckmG_WgN-V9A1VSQfRT85TxFzwHgaLw9dAHeA@mail.gmail.com>
        <979ef870a4f0935e41e95e7759847eba8bd0407c.camel@analog.com>
        <CAHp75Vdna2+txY=w87n+SWE3x3FYJLeMjYbYa6V-co3z0mYx_g@mail.gmail.com>
        <202003220901.880A6DF@keescook>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 22 Mar 2020 09:16:36 -0700
Kees Cook <keescook@chromium.org> wrote:

> On Sun, Mar 22, 2020 at 12:45:39PM +0200, Andy Shevchenko wrote:
> > +Cc Kees (see below about allocation size checks)
> > 
> > On Sun, Mar 22, 2020 at 11:36 AM Ardelean, Alexandru
> > <alexandru.Ardelean@analog.com> wrote:  
> > > On Sat, 2020-03-21 at 23:38 +0200, Andy Shevchenko wrote:  
> > > > On Sat, Mar 21, 2020 at 10:55 AM Alexandru Ardelean
> > > > <alexandru.ardelean@analog.com> wrote:  
> > 
> > ...
> >   
> > > > > +static struct adi_axi_adc_conv *adi_axi_adc_conv_register(struct device
> > > > > *dev,
> > > > > +                                                         int sizeof_priv)
> > > > > +{
> > > > > +       struct adi_axi_adc_client *cl;
> > > > > +       size_t alloc_size;
> > > > > +
> > > > > +       alloc_size = sizeof(struct adi_axi_adc_client);
> > > > > +       if (sizeof_priv) {
> > > > > +               alloc_size = ALIGN(alloc_size, IIO_ALIGN);
> > > > > +               alloc_size += sizeof_priv;
> > > > > +       }
> > > > > +       alloc_size += IIO_ALIGN - 1;  
> > > >
> > > > Have you looked at linux/overflow.h?  
> > >
> > > i did now;
> > > any hints where i should look closer?  
> > 
> > It seems it lacks of this kind of allocation size checks... Perhaps add one?
> > Kees, what do you think?
> >   
> > > > > +       cl = kzalloc(alloc_size, GFP_KERNEL);
> > > > > +       if (!cl)
> > > > > +               return ERR_PTR(-ENOMEM);  
> 
> My head hurts trying to read this! ;) Okay, so the base size is
> sizeof(struct adi_axi_adc_client). But if sizeof_priv is non-zero
> (this arg should be size_t not int), then we need to make the struct
> size ALIGNed? And then what is the "+= IIO_ALIGN - 1" for?

I'm a bit embarrassed.  I can't remember what the += IIO_ALIGN - 1
was for in the first place and I can't work it out now.

The purpose of the fun here was to end up with a structure that
was either
a) sizeof(struct iio_dev) long,
b) sizeof(struct iio_dev) + padding + sizeof_priv 
where the padding ensured that any __cacheline_aligned elements
in the private structure were cacheline aligned within resulting
allocation.

So why the extra IIO_ALIGN - 1....

The original patch doesn't help much either given it's got a question
in there for why this bit is needed.

https://lore.kernel.org/linux-iio/1302890160-8823-5-git-send-email-jic23@cam.ac.uk/

However, it rang a slight bell.  Seems I lifted the code from netdev.
https://elixir.bootlin.com/linux/latest/source/net/core/dev.c#L9718

I'm fairly sure we don't need that padding here..  What can I say,
I was young and stupid :)

I did add a question mark so clearly meant to come back and
take another look ;)

One vague thought is that it's about ensuring we are big enough to
ensure we are cacheline aligned.  That's obviously not a problem with
current struct iio_dev which is far from small,
but in theory it could have been.  Also, thinking about it we only
need the struct iio_dev to be cacheline aligned if we have
an iio_priv structure.  If we have one of those it will definitely
be big enough anyway.

At somepoint I'd like to look at cleaning it up for iio_device_alloc
but with a lot of testing as who knows what is relying on this behaviour
or if I've missed something.  Crashes around this alignment are
infrequent and nasty to trace at the best of times.

Jonathan

> 
> It's not clear to me what the expect alignment/padding is here.
> 
> I would probably construct this as:
> 
> 	sizeof_self = sizeof(struct adi_axi_adc_client);
> 	if (sizeof_priv)
> 		sizeof_self = ALIGN(sizeof_self, IIO_ALIGN);
> 	if (check_add_overflow(sizeof_self, sizeof_priv, &sizeof_alloc))
> 		return ERR_PTR(-ENOMEM);
> 	if (check_add_overflow(sizeof_alloc, IIO_ALIGN - 1, &sizeof_alloc))
> 		return ERR_PTR(-ENOMEM);
> 
> But I don't understand the "IIO_ALIGN - 1" part, so I assume this could
> be shortened with better use of ALIGN()?
> 
> Also, this feels like a weird driver allocation overall:
> 
> +	struct adi_axi_adc_conv **ptr, *conv;
> +
> +	ptr = devres_alloc(devm_adi_axi_adc_conv_release, sizeof(*ptr),
> +			   GFP_KERNEL);
> +	if (!ptr)
> +		return ERR_PTR(-ENOMEM);
> +
> +	conv = adi_axi_adc_conv_register(dev, sizeof_priv);
> 
> devres_alloc() allocates storage for a _single pointer_. :P That's not
> useful for resource tracking. Why is devres_alloc() being called here
> and not down in adi_axi_adc_conv_register() and just passing the pointer
> back up?
> 

