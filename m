Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06DAC4BDF2D
	for <lists+linux-iio@lfdr.de>; Mon, 21 Feb 2022 18:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358285AbiBUMsk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Feb 2022 07:48:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358306AbiBUMsj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Feb 2022 07:48:39 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6101A804;
        Mon, 21 Feb 2022 04:48:15 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id u18so29147060edt.6;
        Mon, 21 Feb 2022 04:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=WVoZZscbEjnNNoIlj1VM/8Hs2mv5BvtpQxaozTKRcQ0=;
        b=lPtVtWT5ymP7i5opMcIt8onnLgAsQqczNjEp2sftjCYXy+HWTf33BxdGSuiTUPRAsP
         Bwx8S8APCDWOVfh1K2nd6VBWtiAvKJsD+VX7gHsalX91mPzxXKLd40NNxb5SKgjsPdxx
         yf7BNQeymSkua2MTnB0072ZSFPwouWA4aYIZpqn2G55vfoP70GXlxdjj56xOsKZdMwZs
         m9aAnvgPulYYciHKTOFDGD1IUp9R/pCUumeTjOYZh7Zvi0O++SSJBKBP4qA3kfezxYFF
         E01uPD0/7D+qtCswvZbeQli+Km54W2z51RCxO3VZua8a2FPcqsqg/xNgsUeFCgV5aDUy
         oZtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=WVoZZscbEjnNNoIlj1VM/8Hs2mv5BvtpQxaozTKRcQ0=;
        b=rD5IbLtASeIdJmzgnwi9zlhL0Bbf12veD0wd/4+j+WMYZwEJa+VGgf6SeE3/RDjxoe
         oiTIoJs9eznUzS1CBZI7Kh/4iH9btu5felMfikNF8ytFQCAojBG2Hnx7d1PxyeSGnf66
         ywYVfCYIaI6B7JVi7B4SBdchwZPNAcGk+ehg1Ji0kAbcHbbcK1xo0Z6/gn/mDeTKzODe
         /ls4RtX2ED62b5fv5u1xeeOT5I/WLPbULyqHp0t+UxBurlaSdPDapdK4EkXhAeWIu0q+
         zIO9GSwVokwFqmRBNc81gW+EgslOmana773IwLE99Xh6cfqR5dDNnVau7DTvBAC+m4hS
         EvmA==
X-Gm-Message-State: AOAM532JhDyXRHQ29Mo8Dl3293BGOEGPW6pYx49qDZwekuhqSlX9HByP
        fc5a+ONQtiVpJK7W7WnvCZc=
X-Google-Smtp-Source: ABdhPJxfq1+POl8Ag1qsImkMI/utm8bYPKmzui4JO69MLfA0ZnmIBRUlyGibAzZO6EU0GQz2VsGtbA==
X-Received: by 2002:a05:6402:5109:b0:412:eb8d:cbd5 with SMTP id m9-20020a056402510900b00412eb8dcbd5mr8712759edd.290.1645447694242;
        Mon, 21 Feb 2022 04:48:14 -0800 (PST)
Received: from ?IPv6:2001:a61:2a07:4a01:d343:1872:4725:7bb9? ([2001:a61:2a07:4a01:d343:1872:4725:7bb9])
        by smtp.gmail.com with ESMTPSA id 24sm5148744ejm.163.2022.02.21.04.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 04:48:13 -0800 (PST)
Message-ID: <3f2523127eb320a9825e272353afea9673e5d003.camel@gmail.com>
Subject: Re: [PATCH v3 1/3] iio: dac: add support for ltc2688
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     "Sa, Nuno" <Nuno.Sa@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>
Date:   Mon, 21 Feb 2022 13:48:12 +0100
In-Reply-To: <YhImsJidUu2fMKgu@smile.fi.intel.com>
References: <20220121142501.151-1-nuno.sa@analog.com>
         <20220121142501.151-2-nuno.sa@analog.com>
         <Yf60A1UkbBtQ68qv@smile.fi.intel.com>
         <PH0PR03MB678628C341A1972BC31F5BBA992B9@PH0PR03MB6786.namprd03.prod.outlook.com>
         <YgD91zg4L1S5KH5k@smile.fi.intel.com>
         <e1bd9f14e63e55f48f804568705a9ab8c1a09f62.camel@gmail.com>
         <Ygpd7pebiuGuB8nT@smile.fi.intel.com>
         <11bd63bc07fd406bfa31bdc38b597011cc9312cc.camel@gmail.com>
         <YhImsJidUu2fMKgu@smile.fi.intel.com>
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

On Sun, 2022-02-20 at 13:32 +0200, Andy Shevchenko wrote:
> On Fri, Feb 18, 2022 at 02:51:28PM +0100, Nuno Sá wrote:
> > On Mon, 2022-02-14 at 15:49 +0200, Andy Shevchenko wrote:
> > > On Mon, Feb 07, 2022 at 09:19:46PM +0100, Nuno Sá wrote:
> > > > On Mon, 2022-02-07 at 13:09 +0200, Andy Shevchenko wrote:
> > > > > On Sun, Feb 06, 2022 at 01:19:59PM +0000, Sa, Nuno wrote:
> > > > > > > From: Andy Shevchenko <andriy.shevchenko@intel.com>
> > > > > > > Sent: Saturday, February 5, 2022 6:30 PM
> > > > > > > On Fri, Jan 21, 2022 at 03:24:59PM +0100, Nuno Sá wrote:
> 
> ...
> 
> > > > > > > Second, why do you need this specific function instead of
> > > > > > > regmap
> > > > > > > bulk
> > > > > > > ops against be24/le24?
> > > > > > 
> > > > > > Not sure I'm following this one... If you mean why am I
> > > > > > using a
> > > > > > custom 
> > > > > > regmap_bus implementation, that was already explained in
> > > > > > the
> > > > > > RFC
> > > > > > patch.
> > > > > > And IIRC, you were the one already asking 😉.
> > > > > 
> > > > > Hmm... It was some time I have looked there. Any message ID
> > > > > to
> > > > > share,
> > > > > so
> > > > > I can find it quickly?
> > > 
> > > > https://lore.kernel.org/all/20211112152235.12fdcc49@jic23-huawei/
> > > 
> > > Thanks!
> > > 
> > > So, it's all about cs_change, right?
> > > But doesn't bulk operation work exactly as we need here?
> > > 
> > 
> > Yes... that and we need to send the NOOP command in the second TX
> > transfer.
> > 
> > > Looking again to the RFC code, it seems like we can still do it
> > > 
> > > First, you call _gather_write() followed by _read(). It will show
> > > exactly what
> > > you do, i.e. you send command first with the value 0x0000,
> > > followed
> > > by sending
> > > command and reading back the value at the same time.
> > > 
> > > Would it work?
> > 
> > Well, _gather_write() are 2 spi transfers only with TX set. That
> > means
> > that only on the _read() (which will be another spi_message) we
> > will
> > ask for the data. Im not really sure this would work being it on a
> > different message. This would also mean, one extra dummy transfer.
> > To
> > me that already feels that a custom bus implementation is not a bad
> > idea...
> 
> I see, okay, what Jonothan decides then. Still I'm not convinced.
> 
> ...
> 
> > > > > > > > +       ret = kstrtou16(buf, 10, &val);
> > > > > > > 
> > > > > > > In other function you have long, here u16. I would expect
> > > > > > > that
> > > > > > > the
> > > > > > > types are of
> > > > > > > the same class, e.g. if here you have u16, then there
> > > > > > > something
> > > > > > > like
> > > > > > > s32 / s64.
> > > > > > > Or here something like unsigned short.
> > > > > > > 
> > > > > > > A bit of elaboration why u16 is chosen here?
> > > > > > 
> > > > > > Well, I never really saw any enforcement here to be honest
> > > > > > (rather
> > > > > > than using
> > > > > > stdint types...). So I pretty much just use these in
> > > > > > unsigned
> > > > > > types
> > > > > > because
> > > > > > I'm lazy and u16 is faster to type than unsigned short...
> > > > > > In
> > > > > > this
> > > > > > case, unless Jonathan
> > > > > > really asks for it, I prefer not to go all over the driver
> > > > > > and
> > > > > > change this...
> > > > > 
> > > > > This is about consistency. It may work as is, but it feels
> > > > > not
> > > > > good
> > > > > when for
> > > > > int (or unsigned int) one uses fixed-width types. Also it's
> > > > > non-
> > > > > written advice
> > > > > to use fixed-width variables when it's about programming
> > > > > registers or
> > > > > so, for
> > > > > the rest, use POD types.
> > 
> > Ok, going a bit back in the discussion, you argued that in one
> > place I
> > was using long while here u16. Well, in the place I'm using long,
> > that
> > was on purpose because that value is to be compared against an
> > array of
> > longs (which has to be long because it depends on CCF rates). I
> > guess I
> > can als0 use s64, but there is also a reason why long was used.
> > 
> > In the u16 case, we really want to have 2 bytes because I'm going
> > to
> > use that value to write the dac code which is 2 bytes.
> 
> Okay, that's what I want to hear. If it's indeed goes to be a value
> to the
> register, then it's fine.
> 
> Perhaps a comment?
> 

I guess you mean to have a comment to state that here we have fixed
size type (as opposed to long, used in another place), because we
directly use the value on a register write?

Asking it because I'm not planning to add comments in all the places
where I have fixed size types for register read/writes...

> > > > I can understand your reasoning but again this is something
> > > > that
> > > > I never really saw being enforced. So, I'm more than ok to
> > > > change
> > > > it
> > > > if it really becomes something that we will try to "enforce" in
> > > > IIO.
> > > > Otherwise it just feels as a random nitpick :).
> > > 
> > > No, this is about consistency and common sense. If you define
> > > type
> > > uXX,
> > > we have an API for that exact type. It's confusing why POD type
> > > APIs
> > > are used with fixed-width types or vise versa.
> > > 
> > > Moreover (which is pure theoretical, though) some architectures
> > > might
> > > have no (mutual) equivalency between these types.
> 
> ...
> 
> > > > > > > > +static int ltc2688_tgp_clk_setup(struct ltc2688_state
> > > > > > > > *st,
> > > > > > > > +                                struct ltc2688_chan
> > > > > > > > *chan,
> > > > > > > > +                                struct device_node
> > > > > > > > *np,
> > > > > > > > int
> > > > > > > > tgp)
> > > > > > > > +{
> > > > > > > > +       unsigned long rate;
> > > > > > > > +       struct clk *clk;
> > > > > > > > +       int ret, f;
> > > > > > > > +
> > > > > > > > +       clk = devm_get_clk_from_child(&st->spi->dev,
> > > > > > > > np,
> > > > > > > > NULL);
> > > > > > > > +       if (IS_ERR(clk))
> > > > > > > 
> > > > > > > Make it optional for non-OF, can be done as easy as
> > > > > > > 
> > > > > > >         if (IS_ERR(clk)) {
> > > > > > >                 if (PTR_ERR(clk) == -ENOENT)
> > > > > > >                         clk = NULL;
> > > > > > >                 else
> > > > > > >                         return dev_err_probe(...);
> > > > > > >         }
> > > > > > > 
> > > > > > > > +               return dev_err_probe(&st->spi->dev,
> > > > > > > > PTR_ERR(clk),
> > > > > > > > +                                    "failed to get tgp
> > > > > > > > clk.\n");
> > > > > > 
> > > > > > Well, I might be missing the point but I think this is not
> > > > > > so
> > > > > > straight....
> > > > > > We will only get here if the property " adi,toggle-dither-
> > > > > > input" is
> > > > > > given
> > > > > > in which case having the associated clocks is
> > > > > > __mandatory__.
> > > > > 
> > > > > Ah, okay, would be a limitation for non-OF platforms.
> > > > > 
> > > > > > Hence,
> > > > > > once we are here, this can never be optional. That said, we
> > > > > > need
> > > > > > device_node 
> > > > > 
> > > > > That's fine, since CCF is OF-centric API.
> > > > > 
> > > > > > and hence of.h
> > > > > 
> > > > > Why? This header doesn't bring anything you will use here.
> > > > 
> > > > Correct me if Im missing something. AFAIU, the idea is to use
> > > > 'device_for_each_child_node()' which returns a fwnode_handle.
> > > > That
> > > > means, that we will have to pass that to this function and use
> > > > 'to_of_node()' to pass a device_node to
> > > > 'devm_get_clk_from_child()'.
> > > > 
> > > > This means, we need of.h for 'to_of_node()'...
> > > 
> > > Yeah, you are right, but it would be still better since it
> > > narrows
> > > the problem to the CCF calls only.
> > 
> > So, to clear....
> > 
> > In your opinion, you are fine whith using device properties and
> > just
> > have 'to_of_node()' in this CCF call? I'm fine with it, so if
> > Jonathan
> > does not have any complain about it, will do like this in v4,
> 
> Yes, that will show that only CCF is missing the fwnode APIs.
> 

Ok, it's settled then...

- Nuno Sá

