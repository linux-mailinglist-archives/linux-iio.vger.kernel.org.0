Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B96427646F
	for <lists+linux-iio@lfdr.de>; Thu, 24 Sep 2020 01:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgIWXZr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 23 Sep 2020 19:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgIWXZq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 23 Sep 2020 19:25:46 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53D9C0613CE
        for <linux-iio@vger.kernel.org>; Wed, 23 Sep 2020 16:25:46 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id y17so573539plb.6
        for <linux-iio@vger.kernel.org>; Wed, 23 Sep 2020 16:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=jej2j3HbEv9+DV5XDwTKPs6+9qk76x1EvEsvUZNemPg=;
        b=MrkvPZ9o7umkr4azlxQBm93PA3MRBRl99atwzye0oAA685qBiFnKw9BWEpwaLuwV6w
         A8obO5ONIcAcwd4ZDCzcZRIcriFLi2UYsij/E6cIOIDkTLHZR1NQuy6Sec7gJyO66L+s
         sWsbHKhpqDKjtU3a8Hfq3B3no9Ouj2OTK8wuw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=jej2j3HbEv9+DV5XDwTKPs6+9qk76x1EvEsvUZNemPg=;
        b=VFMXdOLaYi049pqNk/FwGFM7prbo71Wpjmvmzx9P188APZsWoQ90apLlSr7FJSk6HG
         tNTQ8pEeGOeQ5GlLj8X7BAisQy/6vMpMOxqXsGJmG6vi+H+V38PVyQ3DQsFtAgGYHDE1
         YyA8DiXw5C72UgcX0obLF5tcj4PAFO74TNq67ZewMmLB3hNXLOV5rSzT+hkNqRi8NeVe
         VINbTmluApARHYCi9ghfbPbuyYLg2eQAoooATApv+bIURSg81MDCVLbRw9Ie7R3MgT1E
         nDyVjMlKAUFGRAn3ct08W1Ch7vrxxwWKm5VTsp+97O+lNMyq8V/o1FDSvo3oOhD+/SWO
         ZnSg==
X-Gm-Message-State: AOAM5304ZjbTIUsJTPlIcMvfYXwxh+ED6n1kUeNPmS9vz+L+8gifQ3Wy
        kBK6JiootY+oqqxu1EjOCNigvg==
X-Google-Smtp-Source: ABdhPJzJUiilNBs85Rsq9osueNP+y+XrWAg3KNwAkdialiGNyd5FHWcqqi2gdd7YgJBsEuPOZElApg==
X-Received: by 2002:a17:90b:3241:: with SMTP id jy1mr1499433pjb.10.1600903545951;
        Wed, 23 Sep 2020 16:25:45 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id x185sm658908pfc.188.2020.09.23.16.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 16:25:45 -0700 (PDT)
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
Date:   Wed, 23 Sep 2020 16:25:43 -0700
Message-ID: <160090354388.310579.2465697259775252128@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Jonathan Cameron (2020-09-09 04:15:50)
> On Tue, 8 Sep 2020 23:18:43 -0700
> Stephen Boyd <swboyd@chromium.org> wrote:
> > >  =20
> > > > +
> > > > +  semtech,cs0-gain-factor:
> > > > +    allOf:
> > > > +      - $ref: /schemas/types.yaml#definitions/uint32
> > > > +      - enum: [1, 2, 4, 8]
> > > > +    default: 1
> > > > +    description:
> > > > +      Gain factor for CS0 (and combined if any) sensor. =20
> > >=20
> > > Why is this something that should be in DT as opposed to via
> > > a userspace control?  We have hardwaregain for this purpose (I think)=
 =20
> >=20
> > Thanks I'm not aware of hardwaregain. That looks like it should work.

One weird thing I notice is that the channels can share some settings
like this hardware gain factor. Is there support for a subset of
channels sharing the same gain? I see there is mask_separate and
shared_by_all, type, etc. but I don't see how I can make the setting
apply to some subset of channels. I guess just do proper locking and
make sure when one is changed it changes the other channel too?

> >=20
> > >  =20
> > >  =20
> > > > +
> > > > +  semtech,compensate-common:
> > > > +    description: Any sensor triggers compensation of all channels.
> > > > +    type: boolean =20
> > >=20
> > > Compensation for what? =20
> >=20
> > This is for RegProxCtrl6 bit 6 AVGCOMPMETHOD.=20
> >=20
> >       Defines the average compensation method:
> >=20
> >       0: Individual. Each sensor triggers only its own compensation
> >       1: Common. Any sensor triggers compensation of all channels.=20
> >=20
> > I believe this is for the offset compensation.
>=20
> I wonder if anyone will actually care which choice we make on that?
> Perhaps just pick one and don't make it controllable?
>=20
> Reading that it sounds like a control that is there because it was easy
> to do in hardware rather than necessarily making any sense from
> a usecase point of view.  Do we have any info on how it is used?

Fair enough. I will try to contact Semtech to understand how it is used.
This bit is different between two products I'm aware of but for all I
know it doesn't actually matter. Given that we detect proximity of each
channel individually it feels like we should leave this as 0. I'll try
that out and see how it works.

>=20
> >=20
> > >  =20
> > > > +
> > > > +  semtech,avg-pos-strength:
> > > > +    allOf:
> > > > +      - $ref: /schemas/types.yaml#definitions/uint32
> > > > +      - enum: [0, 16, 64, 128, 256, 512, 1024, 4294967295]
> > > > +    default: 16
> > > > +    description:
> > > > +      Average positive filter strength. A value of 0 represents of=
f and
> > > > +      UINT_MAX (4294967295) represents infinite. Other values
> > > > +      represent 1-1/N. =20
> > >=20
> > > I'm not sure about using UINT_MAX to represent infinity. Rob any thou=
ghts on
> > > this?
> > >=20
> > > Again, why does it make sense to have the filter controls in DT? =20
> >=20
> > Is there an IIO property for this? Seems OK to move it to userspace.
>=20
> I'm not sure enough of what it means, but we have filter controls in
> terms of 3db point and oversampling. If you can figure out a match to
> those or something that seems more generic than the above to propose
> as new ABI that would be great.

Ok let me see what I can do.

> >=20
> > >  =20
> > > > +
> > > > +  semtech,cs1-prox-threshold:
> > > > +    allOf:
> > > > +      - $ref: /schemas/types.yaml#definitions/uint32
> > > > +      - enum: [2, 4, 6, 8, 12, 16, 20, 24, 28, 32, 40,
> > > > +               48, 56, 64, 72, 80, 88, 96, 112, 128, 144,
> > > > +               160, 192, 224, 256, 320, 384, 512, 640,
> > > > +               768, 1024, 1536]
> > > > +    default: 12
> > > > +    description:
> > > > +      Proximity detection threshold for CS1 sensor.
> > > > +
> > > > +  semtech,cs2-prox-threshold:
> > > > +    allOf:
> > > > +      - $ref: /schemas/types.yaml#definitions/uint32
> > > > +      - enum: [2, 4, 6, 8, 12, 16, 20, 24, 28, 32, 40,
> > > > +               48, 56, 64, 72, 80, 88, 96, 112, 128, 144,
> > > > +               160, 192, 224, 256, 320, 384, 512, 640,
> > > > +               768, 1024, 1536]
> > > > +    default: 12
> > > > +    description:
> > > > +      Proximity detection threshold for CS2 sensor.
> > > > +
> > > > +  semtech,cs0-body-threshold:
> > > > +    allOf:
> > > > +      - $ref: /schemas/types.yaml#definitions/uint32
> > > > +      - enum: [0, 300, 600, 900, 1200, 1500, 1800, 30000]
> > > > +    default: 1800
> > > > +    description:
> > > > +      Body detection threshold for CS0 (and combined if any) senso=
r. =20
> > >=20
> > > As before, why DT plus child nodes =20
> >=20
> > How should I differentiate body vs. proximity thresholds in userspace?
> > Or should I make it /sys/.../events/in_proximity0_thresh_falling_value
> > vs. /sys/.../events/in_proximity0_thresh_rising_value?
>=20
> I'm not sure what they actually are. A problem with IIO that may be relev=
ant
> is that we have never supported multiple events of the same type for a ch=
annel.
> Unfortunately that is hard to change now as we'd have to redefine the eve=
nt
> codes.
>=20
> It feels like these are potentially a bit smarter however. If they are we
> could handle them as a different event type.  Or potentially an event
> on a different channel (arguably they are some result of some sort of
> processing of more than a simple single value).  There is a patent but I'=
ve
> not read it in detail.

Hmm.. ok. It looks like the driver doesn't enable the "smart sensor"
mode where the body threshold would matter. If I'm reading the datasheet
properly, the only threshold we need to configure is the proximity one.
If/when the driver supports the body threshold we can look into adding
the second threshold. So, let's punt this one? I'll implement a
threshold for the proximity in userspace via the IIO_EV_TYPE_THRESH.

>=20
> >=20
> > >  =20
> > > > +
> > > > +  semtech,cs1-body-threshold:
> > > > +    allOf:
> > > > +      - $ref: /schemas/types.yaml#definitions/uint32
> > > > +      - enum: [0, 300, 600, 900, 1200, 1500, 1800, 30000]
> > > > +    default: 12
> > > > +    description:
> > > > +      Body detection threshold for CS1 sensor.
> > > > +
> > > > +  semtech,cs2-body-threshold:
> > > > +    allOf:
> > > > +      - $ref: /schemas/types.yaml#definitions/uint32
> > > > +      - enum: [0, 300, 600, 900, 1200, 1500, 1800, 30000]
> > > > +    default: 12
> > > > +    description:
> > > > +      Body detection threshold for CS2 sensor.
> > > > +
> > > > +  semtech,hysteresis:
> > > > +    allOf:
> > > > +      - $ref: /schemas/types.yaml#definitions/uint32
> > > > +      - enum: [0, 6, 12, 25]
> > > > +    default: 0
> > > > +    description:
> > > > +      The percentage of hysteresis +/- applied to proximity/body s=
amples. =20
> > >=20
> > > Is this hysteresis on an event?  If so we have defined ABI to control=
 that
> > > from userspace, though as an absolute value rather than a precentage =
so some
> > > magic will be needed.  Hysteresis is usually defined only the 'not ev=
ent'
> > > direction rather than +/- =20
> >=20
> > Is this IIO_EV_INFO_HYSTERESIS? It looks like it is applied to the
> > threshold by shifting it right by 4, 3, or 2. I think the +/- is
> > actually dependent on the RegProxCtrl10 bit 6 FARCOND value, so maybe
> > that isn't a problem. We could make another value like hysteresis shift
> > or hysteresis percentage?
>=20
> I'd rather avoid extra ABI if we can make it work as it stands, even if it
> is a little involved to do so.  Extra ABI just means we end up with more
> incompatible userspace code over time.

Alright. I will attempt to make this work with the
IIO_EV_INFO_HYSTERESIS knob.

>=20
> >=20
> > >  =20
> > > > +
> > > > +  semtech,close-debounce-samples:
> > > > +    allOf:
> > > > +      - $ref: /schemas/types.yaml#definitions/uint32
> > > > +      - enum: [0, 2, 4, 8]
> > > > +    default: 0
> > > > +    description:
> > > > +      The number of close samples debounced for proximity/body thr=
esholds. =20
> > >=20
> > > This feels like something that has more to do with the object motion =
than
> > > the sensor setup, so perhaps should be controlled from userspace? =20
> >=20
> > Sure. Is there an IIO sample property? Or I should make a custom
> > knob for this?
>=20
> It's kind of close to in_proximity0_thresh_period and that may be how they
> have implemented it.
>=20
> That control specifies a number of samples for which a condition should b=
e true
> before it is reported.

Sounds good. I can do that. It looks like the driver reports close/far
via an event and these debounce values are the same for me so I can
write both fields (close and far) with the same thresh_period value from
userspace. If they need to be different between the two then this can be
reevaluated?

>=20
> >=20
> > >  =20
> > > > +
> > > > +  semtech,far-debounce-samples:
> > > > +    allOf:
> > > > +      - $ref: /schemas/types.yaml#definitions/uint32
> > > > +      - enum: [0, 2, 4, 8]
> > > > +    default: 0
> > > > +    description:
> > > > +      The number of far samples debounced for proximity/body thres=
holds.
> > > > +
> > > >  required:
> > > >    - compatible
