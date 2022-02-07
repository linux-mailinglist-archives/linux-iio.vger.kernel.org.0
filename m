Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A784ACA50
	for <lists+linux-iio@lfdr.de>; Mon,  7 Feb 2022 21:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiBGUV3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Feb 2022 15:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242846AbiBGUTu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Feb 2022 15:19:50 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB406C0401DA;
        Mon,  7 Feb 2022 12:19:49 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id cz16so14383597edb.8;
        Mon, 07 Feb 2022 12:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=IDkmk4nxAZMi9AB0d9QdVlb7s1nJ/KhJUBV2CQOygAk=;
        b=Xrgn0Ouzb291FBmu79ACBzrfa02nR6/x6D5leHPuwwq02lVGBT39hDCxWa09gMRDa6
         /uU7Z9TRMtvISbPyp8XruDvOHFpn57OeCqqwi39eVjVaSbc1oLrwpyKzB9hmyItJzu3r
         R83SE0Duu6GQugd3LVd2so4G/ENS83bHQzTHCKTv4pZ2YMDPStKIXUc6ZG0EpXPXNnp1
         uPdRQOyaHSpOE9Vi3NZB4wqMiG78vOawMSiEPNfw556ihzSUhVvRQu+iHE/8tcyZ+nAs
         haGoOMLVtyZhvMev0ediM7xjMlVxSdKc0yXa7l6EYQyZnQyoBkyGpOjR15UfGL11cEmW
         fkwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=IDkmk4nxAZMi9AB0d9QdVlb7s1nJ/KhJUBV2CQOygAk=;
        b=hpCwlKHiOCH/QL/TKMGoGKz1+FSK8ogF/iXQnu5l9w/MX6YyJmIDFEaD8k1XRwwSx0
         KyodZ1nK5NYbZjvqtzFyaQunlwR/O8NyEttS3UFmPNVTrdYzhx6bMfCi9RFnHyF1d3UG
         cg8urWgTlf8qxIMqE+kTunjymB9eyj/9c5LM/JFkiz/wOZJB4YUNnj1h/76SB11v8F+v
         BfX0bzoE5EikbL0dkQ79UtkKplc9cQDBMuudfmoBvtTpEVaPNIAsNa2sGMXU8PPAfW8P
         iJB0t62FxQPkXNSl7rcytvQ+B22anKYiw7wN9UKwBGt93VXdyKEZw0nlvf+0QPbeEm5U
         kt2w==
X-Gm-Message-State: AOAM531r/F/L6ObnY4CE4XwR1PS/5qtcnPUxAdYz7Xv/ZNHsnYbsAiO4
        XVbZox5RSSak7ou+llpEl50=
X-Google-Smtp-Source: ABdhPJwq4JfiOXm5lrLWccaaI4bBJ/tvYxxmgL6hCIPYICIkJKW9D7k93kU0sukuL6zMPQ6HAwOhPA==
X-Received: by 2002:a05:6402:b1c:: with SMTP id bm28mr1133526edb.299.1644265188137;
        Mon, 07 Feb 2022 12:19:48 -0800 (PST)
Received: from ?IPv6:2001:a61:24f7:5701:1b0:e3f1:2182:d29c? ([2001:a61:24f7:5701:1b0:e3f1:2182:d29c])
        by smtp.gmail.com with ESMTPSA id ko9sm1754218ejc.60.2022.02.07.12.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 12:19:47 -0800 (PST)
Message-ID: <e1bd9f14e63e55f48f804568705a9ab8c1a09f62.camel@gmail.com>
Subject: Re: [PATCH v3 1/3] iio: dac: add support for ltc2688
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>
Date:   Mon, 07 Feb 2022 21:19:46 +0100
In-Reply-To: <YgD91zg4L1S5KH5k@smile.fi.intel.com>
References: <20220121142501.151-1-nuno.sa@analog.com>
         <20220121142501.151-2-nuno.sa@analog.com>
         <Yf60A1UkbBtQ68qv@smile.fi.intel.com>
         <PH0PR03MB678628C341A1972BC31F5BBA992B9@PH0PR03MB6786.namprd03.prod.outlook.com>
         <YgD91zg4L1S5KH5k@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 2022-02-07 at 13:09 +0200, Andy Shevchenko wrote:
> On Sun, Feb 06, 2022 at 01:19:59PM +0000, Sa, Nuno wrote:
> > > From: Andy Shevchenko <andriy.shevchenko@intel.com>
> > > Sent: Saturday, February 5, 2022 6:30 PM
> > > On Fri, Jan 21, 2022 at 03:24:59PM +0100, Nuno Sá wrote:
> 
> ...
> 
> > > > +#include <linux/of.h>
> > > 
> > > property.h please/
> > 
> > That probably means property and of both included. See below in the
> > clock_get comments...
> 
> Why? OF won't be used at all.
> 
see below on the clock function...
> 
> ...
> 
> > > > +       memcpy(st->tx_data, reg, reg_size);
> > > > +
> > > > +       ret = spi_sync_transfer(st->spi, xfers,
> > > > ARRAY_SIZE(xfers));
> > > > +       if (ret)
> > > > +               return ret;
> > > > +
> > > > +       memcpy(val, &st->rx_data[1], val_size);
> > > > +
> > > > +       return 0;
> > > > +}
> > > 
> > > First of all, yuo have fixed len in transfer sizes, so what the
> > > purpose of
> > > the reg_size / val_size?
> > 
> > Well, reg_size is 1 byte and val_size is 2 as defined in the
> > regmap_bus
> > struct. And that is what it must be used for the transfer to work.
> > I 
> > could also hardcode 1 and 2 but I preferred to use the parameters.
> > I guess
> > you can argue (and probably this is why you are complaining about
> > this)
> > for me to use reg_size + val_size in the transfer length for
> > consistency.
> > That's fair but I do not think this is __that__ bad...
> 
> It's not bad, but I think that division between register and value is
> a good
> thing to have.
> 
> > Can make that change though.
> 
> Would be nice!
> 
> ...
> 
> > > Second, why do you need this specific function instead of regmap
> > > bulk
> > > ops against be24/le24?
> > 
> > Not sure I'm following this one... If you mean why am I using a
> > custom 
> > regmap_bus implementation, that was already explained in the RFC
> > patch.
> > And IIRC, you were the one already asking 😉.
> 
> Hmm... It was some time I have looked there. Any message ID to share,
> so
> I can find it quickly?
> 

https://lore.kernel.org/all/20211112152235.12fdcc49@jic23-huawei/

> ...
> 
> > > > +       ret = kstrtou16(buf, 10, &val);
> > > 
> > > In other function you have long, here u16. I would expect that
> > > the
> > > types are of
> > > the same class, e.g. if here you have u16, then there something
> > > like
> > > s32 / s64.
> > > Or here something like unsigned short.
> > > 
> > > A bit of elaboration why u16 is chosen here?
> > 
> > Well, I never really saw any enforcement here to be honest (rather
> > than using
> > stdint types...). So I pretty much just use these in unsigned types
> > because
> > I'm lazy and u16 is faster to type than unsigned short... In this
> > case, unless Jonathan
> > really asks for it, I prefer not to go all over the driver and
> > change this...
> 
> This is about consistency. It may work as is, but it feels not good
> when for
> int (or unsigned int) one uses fixed-width types. Also it's non-
> written advice
> to use fixed-width variables when it's about programming registers or
> so, for
> the rest, use POD types.
> 
> ...

I can understand your reasoning but again this is something that
I never really saw being enforced. So, I'm more than ok to change it
if it really becomes something that we will try to "enforce" in IIO.
Otherwise it just feels as a random nitpick :).

> 
> > > > +static int ltc2688_tgp_clk_setup(struct ltc2688_state *st,
> > > > +                                struct ltc2688_chan *chan,
> > > > +                                struct device_node *np, int
> > > > tgp)
> > > > +{
> > > > +       unsigned long rate;
> > > > +       struct clk *clk;
> > > > +       int ret, f;
> > > > +
> > > > +       clk = devm_get_clk_from_child(&st->spi->dev, np, NULL);
> > > > +       if (IS_ERR(clk))
> > > 
> > > Make it optional for non-OF, can be done as easy as
> > > 
> > >         if (IS_ERR(clk)) {
> > >                 if (PTR_ERR(clk) == -ENOENT)
> > >                         clk = NULL;
> > >                 else
> > >                         return dev_err_probe(...);
> > >         }
> > > 
> > > > +               return dev_err_probe(&st->spi->dev,
> > > > PTR_ERR(clk),
> > > > +                                    "failed to get tgp
> > > > clk.\n");
> > 
> > Well, I might be missing the point but I think this is not so
> > straight....
> > We will only get here if the property " adi,toggle-dither-input" is
> > given
> > in which case having the associated clocks is __mandatory__.
> 
> Ah, okay, would be a limitation for non-OF platforms.
> 
> > Hence,
> > once we are here, this can never be optional. That said, we need
> > device_node 
> 
> That's fine, since CCF is OF-centric API.
> 
> > and hence of.h
> 
> Why? This header doesn't bring anything you will use here.

Correct me if Im missing something. AFAIU, the idea is to use
'device_for_each_child_node()' which returns a fwnode_handle. That
means, that we will have to pass that to this function and use
'to_of_node()' to pass a device_node to 'devm_get_clk_from_child()'.

This means, we need of.h for 'to_of_node()'...


- Nuno Sá

