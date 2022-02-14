Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1384B518F
	for <lists+linux-iio@lfdr.de>; Mon, 14 Feb 2022 14:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344509AbiBNNXP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Feb 2022 08:23:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbiBNNXM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Feb 2022 08:23:12 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED82A48889;
        Mon, 14 Feb 2022 05:23:04 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id b14so2508846ede.9;
        Mon, 14 Feb 2022 05:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=BhW6DuniQsOOPOTJJcCh2RrIzK0dkGAURMG9lYtb3Cw=;
        b=bDv6WCGZfcAOldZF7jDxVf1FxSbw6S6v2LUrgHpPHTRVnsER+nCNLMesS19Vs2f8t3
         V/IEeFIibhJm6O4kmNuYnlceptA0qqxYFykA1/Cl4U4B2aU9S49JfFYJ5ihqTG16hRkr
         xvbgAIfKVOLsa2qOXgOCHHFxU6hhv2V7pcl4oAsY/HR265VDtiRcPZeefjXGNLEw3egl
         F1iAZJJJRdiTqebYYw1YsnNyf8PhTdGHDIpDy6p/9PyXswPXnVIUdLtHdDrHQmz22Cki
         tGL+i9RX0desIBW80KYj0cnh61sWNAma+2IZpRu3RC/eRvc3S9n8Z2WkafwsEgVcG1YS
         14MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=BhW6DuniQsOOPOTJJcCh2RrIzK0dkGAURMG9lYtb3Cw=;
        b=JQz+59GB1mp5keWtOCcGT9rbNdmOlHk02yL/oG0C801lWJnIo4qXb2agmEg/lIE7c7
         EKFsNHU8pzlgvwKasm6joHKM33ZKjsv34P5yhJwctcT/sifdOJOs4sHA+Atl7XV5ZYVw
         3gKm7VpF7129fFpe7mwSbeUBeKEVM/A6PAZdNrogSkQmT2iEk5HtkIPywrRek6MNznRy
         yl7jTvJ0IOmO58jJ3IalImya1w1UodVgWpLKII4eQS3R6Kzq4J6vcK/P8BQV4xmfEjYW
         RGsCDceqDM5w+P5XloKMhs6azDQwkejhFKy6g+96/4EthzARyNkdz1WyTurZN5DDF61X
         XwVg==
X-Gm-Message-State: AOAM531qBkG4mRtbwFV7fPcEVrnJfKyyKDATCV9I9VcTwu4XwUQw4lly
        Vk2tgBg/Bnr0HkIRqzTfHQ0Rm2nL2XlUng==
X-Google-Smtp-Source: ABdhPJwYinlM5owc7DlYYYrxZ3aLLruEHSiwC5C5Qj7z6+wOj9n3H+eOzECq4MBZQsR/YTAEP5+5RA==
X-Received: by 2002:a05:6402:22cf:: with SMTP id dm15mr4665408edb.327.1644844983293;
        Mon, 14 Feb 2022 05:23:03 -0800 (PST)
Received: from ?IPv6:2001:a61:246b:5401:c2b8:aefa:1572:440b? ([2001:a61:246b:5401:c2b8:aefa:1572:440b])
        by smtp.gmail.com with ESMTPSA id y11sm3731612edc.1.2022.02.14.05.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 05:23:02 -0800 (PST)
Message-ID: <0fc9da519df96aaeb3cdcd155fb8aabbdc17fbeb.camel@gmail.com>
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
Date:   Mon, 14 Feb 2022 14:23:01 +0100
In-Reply-To: <e1bd9f14e63e55f48f804568705a9ab8c1a09f62.camel@gmail.com>
References: <20220121142501.151-1-nuno.sa@analog.com>
         <20220121142501.151-2-nuno.sa@analog.com>
         <Yf60A1UkbBtQ68qv@smile.fi.intel.com>
         <PH0PR03MB678628C341A1972BC31F5BBA992B9@PH0PR03MB6786.namprd03.prod.outlook.com>
         <YgD91zg4L1S5KH5k@smile.fi.intel.com>
         <e1bd9f14e63e55f48f804568705a9ab8c1a09f62.camel@gmail.com>
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

On Mon, 2022-02-07 at 21:19 +0100, Nuno Sá wrote:
> On Mon, 2022-02-07 at 13:09 +0200, Andy Shevchenko wrote:
> > On Sun, Feb 06, 2022 at 01:19:59PM +0000, Sa, Nuno wrote:
> > > > From: Andy Shevchenko <andriy.shevchenko@intel.com>
> > > > Sent: Saturday, February 5, 2022 6:30 PM
> > > > On Fri, Jan 21, 2022 at 03:24:59PM +0100, Nuno Sá wrote:
> > 
> > ...
> > 
> > > > > +#include <linux/of.h>
> > > > 
> > > > property.h please/
> > > 
> > > That probably means property and of both included. See below in
> > > the
> > > clock_get comments...
> > 
> > Why? OF won't be used at all.
> > 
> see below on the clock function...
> > 
> > ...
> > 
> > > > > +       memcpy(st->tx_data, reg, reg_size);
> > > > > +
> > > > > +       ret = spi_sync_transfer(st->spi, xfers,
> > > > > ARRAY_SIZE(xfers));
> > > > > +       if (ret)
> > > > > +               return ret;
> > > > > +
> > > > > +       memcpy(val, &st->rx_data[1], val_size);
> > > > > +
> > > > > +       return 0;
> > > > > +}
> > > > 
> > > > First of all, yuo have fixed len in transfer sizes, so what the
> > > > purpose of
> > > > the reg_size / val_size?
> > > 
> > > Well, reg_size is 1 byte and val_size is 2 as defined in the
> > > regmap_bus
> > > struct. And that is what it must be used for the transfer to
> > > work.
> > > I 
> > > could also hardcode 1 and 2 but I preferred to use the
> > > parameters.
> > > I guess
> > > you can argue (and probably this is why you are complaining about
> > > this)
> > > for me to use reg_size + val_size in the transfer length for
> > > consistency.
> > > That's fair but I do not think this is __that__ bad...
> > 
> > It's not bad, but I think that division between register and value
> > is
> > a good
> > thing to have.
> > 
> > > Can make that change though.
> > 
> > Would be nice!
> > 
> > ...
> > 
> > > > Second, why do you need this specific function instead of
> > > > regmap
> > > > bulk
> > > > ops against be24/le24?
> > > 
> > > Not sure I'm following this one... If you mean why am I using a
> > > custom 
> > > regmap_bus implementation, that was already explained in the RFC
> > > patch.
> > > And IIRC, you were the one already asking 😉.
> > 
> > Hmm... It was some time I have looked there. Any message ID to
> > share,
> > so
> > I can find it quickly?
> > 
> 
> https://lore.kernel.org/all/20211112152235.12fdcc49@jic23-huawei/
> 
> > ...
> > 
> > > > > +       ret = kstrtou16(buf, 10, &val);
> > > > 
> > > > In other function you have long, here u16. I would expect that
> > > > the
> > > > types are of
> > > > the same class, e.g. if here you have u16, then there something
> > > > like
> > > > s32 / s64.
> > > > Or here something like unsigned short.
> > > > 
> > > > A bit of elaboration why u16 is chosen here?
> > > 
> > > Well, I never really saw any enforcement here to be honest
> > > (rather
> > > than using
> > > stdint types...). So I pretty much just use these in unsigned
> > > types
> > > because
> > > I'm lazy and u16 is faster to type than unsigned short... In this
> > > case, unless Jonathan
> > > really asks for it, I prefer not to go all over the driver and
> > > change this...
> > 
> > This is about consistency. It may work as is, but it feels not good
> > when for
> > int (or unsigned int) one uses fixed-width types. Also it's non-
> > written advice
> > to use fixed-width variables when it's about programming registers
> > or
> > so, for
> > the rest, use POD types.
> > 
> > ...
> 
> I can understand your reasoning but again this is something that
> I never really saw being enforced. So, I'm more than ok to change it
> if it really becomes something that we will try to "enforce" in IIO.
> Otherwise it just feels as a random nitpick :).
> 
> > 
> > > > > +static int ltc2688_tgp_clk_setup(struct ltc2688_state *st,
> > > > > +                                struct ltc2688_chan *chan,
> > > > > +                                struct device_node *np, int
> > > > > tgp)
> > > > > +{
> > > > > +       unsigned long rate;
> > > > > +       struct clk *clk;
> > > > > +       int ret, f;
> > > > > +
> > > > > +       clk = devm_get_clk_from_child(&st->spi->dev, np,
> > > > > NULL);
> > > > > +       if (IS_ERR(clk))
> > > > 
> > > > Make it optional for non-OF, can be done as easy as
> > > > 
> > > >         if (IS_ERR(clk)) {
> > > >                 if (PTR_ERR(clk) == -ENOENT)
> > > >                         clk = NULL;
> > > >                 else
> > > >                         return dev_err_probe(...);
> > > >         }
> > > > 
> > > > > +               return dev_err_probe(&st->spi->dev,
> > > > > PTR_ERR(clk),
> > > > > +                                    "failed to get tgp
> > > > > clk.\n");
> > > 
> > > Well, I might be missing the point but I think this is not so
> > > straight....
> > > We will only get here if the property " adi,toggle-dither-input"
> > > is
> > > given
> > > in which case having the associated clocks is __mandatory__.
> > 
> > Ah, okay, would be a limitation for non-OF platforms.
> > 
> > > Hence,
> > > once we are here, this can never be optional. That said, we need
> > > device_node 
> > 
> > That's fine, since CCF is OF-centric API.
> > 
> > > and hence of.h
> > 
> > Why? This header doesn't bring anything you will use here.
> 
> Correct me if Im missing something. AFAIU, the idea is to use
> 'device_for_each_child_node()' which returns a fwnode_handle. That
> means, that we will have to pass that to this function and use
> 'to_of_node()' to pass a device_node to 'devm_get_clk_from_child()'.
> 
> This means, we need of.h for 'to_of_node()'...
> 
> 

Andy, Jonathan,

I would definetly like to have some settlement on the above (before
sending a v4). It kind of was discussed a bit already in [1] where I
felt we had to live with OF for this driver (that is why I kept OF in
v3. With the above, I cannot
really see how we can have device API with also including OF... If I
missing something please let me know :)


[1]: https://lore.kernel.org/all/CAHp75VczFs8QpsY7tuB-h4X=H54nyjABA4qDSmpQ+FRYAHZdrA@mail.gmail.com/
- Nuno Sá

