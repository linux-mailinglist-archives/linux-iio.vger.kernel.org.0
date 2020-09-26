Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 572932795ED
	for <lists+linux-iio@lfdr.de>; Sat, 26 Sep 2020 03:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729821AbgIZBR2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 25 Sep 2020 21:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729605AbgIZBR2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 25 Sep 2020 21:17:28 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C78BC0613CE
        for <linux-iio@vger.kernel.org>; Fri, 25 Sep 2020 18:17:28 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id jw11so353229pjb.0
        for <linux-iio@vger.kernel.org>; Fri, 25 Sep 2020 18:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=I6Dtk9mZR92rDJG/J+v/I4660jgxmxD7sJpleXc0eWY=;
        b=j1Nmujra8/KxKXaFKBbJbWHuM1VtCSxXvYsAytzlTCWtgQWHWPtUL0elO8d68ZKLvx
         7fmWCqRq+ZyKTla5tZXPv9kCL7fcX6sKLCVS+ApxDLjb+VAgoab3GeRBS+G/b29Wz7nU
         fEg7CA/lbiQlQBbdOjeC1m+F97upaBIxcRxgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=I6Dtk9mZR92rDJG/J+v/I4660jgxmxD7sJpleXc0eWY=;
        b=rRPgKsAAf4Kw5HBkU8yV5aR88vBabKscM8YRkBZQ3OhCikcuUjBBE3RG7eR57IXuqD
         yKuWdIS2RunFOS9D9I7Qf4nUULQ6BOR6ILxFGNUFEBCgV55t+oWsrdMZnXlSV8yhD4rx
         v/vLvhCOcVeos9wwJ9bQ85d76Q8w9sxEBn1QuuYN8fqCgNGLHHEViw78F5/LtEfa53eJ
         dOEjXRrFZyhSCTjiT50mYGuyPwPMaOhdiuKyTAdMS5HEsXYphvRs2+I/GkJYiFjQTepv
         NX3kIibr/kAJlwUwTUfVpOf90gqj/Q/iPXhso0GhG/HcUwPz1X36ttIWB11Fm2UXwQPN
         PZAg==
X-Gm-Message-State: AOAM533mIq/rzZaG66WoqWBzjauM4xTZ1VZkFVfvglcXtFln4zZ2jnQ3
        3ijVpHaQW4ScK4sikkC2PfErVA==
X-Google-Smtp-Source: ABdhPJx0KGLfWSXqPs2UJAf2busJUPY3sqXAwe8q/nn2WAwxIum0KF5s9NtUCdsY3Ks8hlezaF5yAw==
X-Received: by 2002:a17:90b:693:: with SMTP id m19mr226302pjz.111.1601083047527;
        Fri, 25 Sep 2020 18:17:27 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id c12sm2988144pgd.57.2020.09.25.18.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 18:17:26 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200909121550.00005ede@Huawei.com>
References: <20200903221828.3657250-1-swboyd@chromium.org> <20200906150247.3aaef3a3@archlinux> <159963232334.454335.9794130058200265122@swboyd.mtv.corp.google.com> <20200909121550.00005ede@Huawei.com>
Subject: Re: [PATCH] dt-bindings: iio: sx9310: Add various settings as DT properties
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Daniel Campello <campello@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Evan Green <evgreen@chromium.org>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Date:   Fri, 25 Sep 2020 18:17:25 -0700
Message-ID: <160108304513.310579.9483266115343530431@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Sorry this thread is deep! Good news is I have moved the proximity
thresholds, hysteresis, hardware gain, and debounce to userspace. Now
just to figure out this filter strength.

Quoting Jonathan Cameron (2020-09-09 04:15:50)
> On Tue, 8 Sep 2020 23:18:43 -0700
> Stephen Boyd <swboyd@chromium.org> wrote:
>=20
> > Quoting Jonathan Cameron (2020-09-06 07:02:47)
>=20
> >=20
> > >  =20
> > > > +
> > > > +  semtech,proxraw-strength:
> > > > +    allOf:
> > > > +      - $ref: /schemas/types.yaml#definitions/uint32
> > > > +      - enum: [0, 2, 4, 8]
> > > > +    default: 2
> > > > +    description:
> > > > +      PROXRAW filter strength. A value of 0 represents off, and ot=
her values
> > > > +      represent 1-1/N. =20
> > >=20
> > > Having looked at the datasheet I have little or now idea of what this=
 filter
> > > actually is.  However, what is the argument for it being in DT rather=
 than
> > > exposing a userspace control of some type. =20
> >=20
> > I only see this equation in the datasheet
> >=20
> > F(PROXRAW ; PROXUSEFUL[n-1] ; RAWFILT) =3D (1 - RAWFILT).PROXRAW + RAWF=
ILT.PROXUSEFUL[n-1]=20
> >=20
> > and it's talking about updating PROXUSEFUL. "PROXUSEFUL update consists
> > of filtering PROXRAW upfront to remove its high frequencies components".
> > So presumably this filter is used to make proxraw into proxuseful so
> > that it is a meaningful number. Is this a new knob in userspace?
>=20
> It might fit with the various filter definitions, but there is so little =
info
> it is hard to map it across.   Perhaps DT is the best we can do here even
> though it would ideally be controlled from userspace.
>=20

Ok I read the datasheet a couple more times :)

This sensor seems to have multiple levels of processing on the signal.
First the raw signal is there as PROXRAW. That gets turned into
PROXUSEFUL with this calculation:

 F(PROXRAW ; PROXUSEFUL[n-1] ; RAWFILT) =3D (1 - RAWFILT) * PROXRAW + RAWFI=
LT * PROXUSEFUL[n-1]

This semtech,proxraw-strength property is trying to set that RAWFILT
variable to something like 2, 4, or 8. Or 0 for "off". Is that in terms
of 3db? A bigger question, does the useful value need to be a different
channel so it can be configured from userspace? We don't get an
interrupt when this changes but at least the value can be read out of
the hardware from what I can tell.

The PROXUSEFUL value is turned into PROXAVG. There is a positive filter
strength and a negative filter strength that is used to filter the
PROXAVG value. I need to set the positive filter strength to be
different than the default. That's what I'm trying to do with
semtech,avg-pos-strength. It factors into this equation for PROXUSEFUL:

if (PROXUSEFUL - PROXAVG[n-1] >=3D 0)
  F(PROXUSEFUL ; PROXAVG[n-1] ; AVGPOSFILT) =3D (1 - AVGPOSFILT) * PROXUSEF=
UL + AVGPOSFILT * PROXAVG[n-1]=20
else
  F(PROXUSEFUL ; PROXAVG[n-1] ; AVGNEGFILT) =3D (1 - AVGNEGFILT) * PROXUSEF=
UL + AVGNEGFILT * PROXAVG[n-1]=20

so depending on how the historical average value is going we filter
differently. Again, is this in 3db? This register has a setting of
"infinite" which I guess is used to make the above equation come out to
be just PROXAVG[n - 1]? Otherwise 0 is "off" which seems to make the
above equation boil down to:

  PROXAVG =3D PROXUSEFUL

when you do substitution.

I agree it looks like some sort of filter, so maybe I need to introduce
some proximity.*filter ABI? I don't know the units though.

To complete the story, the PROXAVG value gets compared to a threshold
AVGTHRESH (settable in a register) and that can be debounced with
another register setting (AVGDEB). That results in PROXUSEFUL which goes
into this PROXDIFF equation:

 PROXDIFF =3D (PROXUSEFUL - PROXAVG) >> 4

The PROXDIFF value is compared to the proximity threshold register
setting (PROXTHRESH, i.e. bits 3:7 in register RegProxCtrl8/9) plus or
minus the hysteresis (RegProxCtrl10 bits 5:4) and then debounced
(RegProxCtrl10 bits 3:2 (for close) and 1:0 (for far)).

if (PROXDIFF > PROXTHRESH + HYST)
  // close event, i.e. DIR_FALLING
  PROXSTAT =3D debounce() ? 1 : 0;
else if (PROXDIFF < PROXTHRESH - HYST)
  // far event, i.e. DIR_RISING
  PROXSTAT =3D debounce() ? 0 : 1;

If that all passes then PROXSTAT is set to 1 for the close condition and
0 for the far condition. An irq is raised and eventually this driver
will signal a new event indicating rising or falling.

I see that the driver implements sx9310_read_prox_data() as a read on
the PROXDIFF value. That looks good for reading the processed signal for
a channel after all that raw/avg/useful debouncing and filtering.
