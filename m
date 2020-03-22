Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C47BF18EA25
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 17:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgCVQQm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 12:16:42 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:35310 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgCVQQj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Mar 2020 12:16:39 -0400
Received: by mail-pj1-f67.google.com with SMTP id g9so804023pjp.0
        for <linux-iio@vger.kernel.org>; Sun, 22 Mar 2020 09:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lPrpjX3DIANTx2/srJAYBr3XZH1bElctL0wHyLULZ6Y=;
        b=WD3m1vYkX0pfhbxJVj6RQoGnfbpuvgEa7hUI61NCROsrtiT8Ue+lqyIyCLZX17Yf7f
         4HqoeW8gMzuXJAUOL2ulkpp+CPjAYO6Y4vWOdfMM4c+y6bZtP2rmq33lzX7H2bMmbrgD
         TkvaX6gs8yldXpQNf2jfu6AfNfAjkWicNsh7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lPrpjX3DIANTx2/srJAYBr3XZH1bElctL0wHyLULZ6Y=;
        b=P0YGueCJEIwQSVzIJnEYgYpjn+pdUIY9EgeriuuLC+P62V/kfbF5NzExlQezG4bTAG
         hvm5lGYuwjnQ2RjXpBIqPhEx2eViKLAXwVvH/9ir+eOm08D2ohsFOd7xMD2EM2A+lyq6
         7QX597al1sxn6zQWdkmUOLR2ltnlTx8x3VcJT9pqOFSKQZFWvELnEsC52RJtVWqB9I6S
         qokTBfwRvMJo2VEyL8BY5mJw9vQm98xFt+LS4uO7Tx4OXdeE2DPDlN2JE8qhrw2H19zD
         ikHWfrjehq4jG2ySCZwwtixzryQMijxiSEN9hOzvUSmC1b7/oyzbWfxDPqMNbdHAWoBf
         i9nA==
X-Gm-Message-State: ANhLgQ3vzlEyJQ8FLuBQOf4bzg0ahX4XifvrE4UJbKVMGlsxzSLNlz5C
        cIMRVlKYreW/t7d9UgDqUdnmDw==
X-Google-Smtp-Source: ADFU+vtp5cYRDmRZyGTSvbeiQHuj7NGAgNa6e4Lbwa7tEggV7tzNrwpzBOvpDq00Q3v84HJgt0kkeQ==
X-Received: by 2002:a17:90a:c583:: with SMTP id l3mr6918945pjt.84.1584893798370;
        Sun, 22 Mar 2020 09:16:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p14sm9723743pgm.49.2020.03.22.09.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2020 09:16:37 -0700 (PDT)
Date:   Sun, 22 Mar 2020 09:16:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Grozav, Andrei" <Andrei.Grozav@analog.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "Nagy, Laszlo" <Laszlo.Nagy@analog.com>,
        "Csomortani, Istvan" <Istvan.Csomortani@analog.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        "Costina, Adrian" <Adrian.Costina@analog.com>
Subject: Re: [PATCH v11 5/8] iio: adc: adi-axi-adc: add support for AXI ADC
 IP core
Message-ID: <202003220901.880A6DF@keescook>
References: <20200321085315.11030-1-alexandru.ardelean@analog.com>
 <20200321085315.11030-6-alexandru.ardelean@analog.com>
 <CAHp75VecnornqckmG_WgN-V9A1VSQfRT85TxFzwHgaLw9dAHeA@mail.gmail.com>
 <979ef870a4f0935e41e95e7759847eba8bd0407c.camel@analog.com>
 <CAHp75Vdna2+txY=w87n+SWE3x3FYJLeMjYbYa6V-co3z0mYx_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vdna2+txY=w87n+SWE3x3FYJLeMjYbYa6V-co3z0mYx_g@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Mar 22, 2020 at 12:45:39PM +0200, Andy Shevchenko wrote:
> +Cc Kees (see below about allocation size checks)
> 
> On Sun, Mar 22, 2020 at 11:36 AM Ardelean, Alexandru
> <alexandru.Ardelean@analog.com> wrote:
> > On Sat, 2020-03-21 at 23:38 +0200, Andy Shevchenko wrote:
> > > On Sat, Mar 21, 2020 at 10:55 AM Alexandru Ardelean
> > > <alexandru.ardelean@analog.com> wrote:
> 
> ...
> 
> > > > +static struct adi_axi_adc_conv *adi_axi_adc_conv_register(struct device
> > > > *dev,
> > > > +                                                         int sizeof_priv)
> > > > +{
> > > > +       struct adi_axi_adc_client *cl;
> > > > +       size_t alloc_size;
> > > > +
> > > > +       alloc_size = sizeof(struct adi_axi_adc_client);
> > > > +       if (sizeof_priv) {
> > > > +               alloc_size = ALIGN(alloc_size, IIO_ALIGN);
> > > > +               alloc_size += sizeof_priv;
> > > > +       }
> > > > +       alloc_size += IIO_ALIGN - 1;
> > >
> > > Have you looked at linux/overflow.h?
> >
> > i did now;
> > any hints where i should look closer?
> 
> It seems it lacks of this kind of allocation size checks... Perhaps add one?
> Kees, what do you think?
> 
> > > > +       cl = kzalloc(alloc_size, GFP_KERNEL);
> > > > +       if (!cl)
> > > > +               return ERR_PTR(-ENOMEM);

My head hurts trying to read this! ;) Okay, so the base size is
sizeof(struct adi_axi_adc_client). But if sizeof_priv is non-zero
(this arg should be size_t not int), then we need to make the struct
size ALIGNed? And then what is the "+= IIO_ALIGN - 1" for?

It's not clear to me what the expect alignment/padding is here.

I would probably construct this as:

	sizeof_self = sizeof(struct adi_axi_adc_client);
	if (sizeof_priv)
		sizeof_self = ALIGN(sizeof_self, IIO_ALIGN);
	if (check_add_overflow(sizeof_self, sizeof_priv, &sizeof_alloc))
		return ERR_PTR(-ENOMEM);
	if (check_add_overflow(sizeof_alloc, IIO_ALIGN - 1, &sizeof_alloc))
		return ERR_PTR(-ENOMEM);

But I don't understand the "IIO_ALIGN - 1" part, so I assume this could
be shortened with better use of ALIGN()?

Also, this feels like a weird driver allocation overall:

+	struct adi_axi_adc_conv **ptr, *conv;
+
+	ptr = devres_alloc(devm_adi_axi_adc_conv_release, sizeof(*ptr),
+			   GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	conv = adi_axi_adc_conv_register(dev, sizeof_priv);

devres_alloc() allocates storage for a _single pointer_. :P That's not
useful for resource tracking. Why is devres_alloc() being called here
and not down in adi_axi_adc_conv_register() and just passing the pointer
back up?

-- 
Kees Cook
