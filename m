Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2428B262713
	for <lists+linux-iio@lfdr.de>; Wed,  9 Sep 2020 08:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725897AbgIIGSs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Sep 2020 02:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbgIIGSq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Sep 2020 02:18:46 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3A0C061755
        for <linux-iio@vger.kernel.org>; Tue,  8 Sep 2020 23:18:45 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id t14so1295958pgl.10
        for <linux-iio@vger.kernel.org>; Tue, 08 Sep 2020 23:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=f6AJazrS3jP2mlnRASYyxntzBtGLdmqU3AKO+A+Qu1M=;
        b=kUDiJsJ35CWphSckgkIP2s2Oq3VGFCJdPhdwq2AKcjV4G/HgUTGyPno0kVwWgr5Eee
         HCT5rWXZCEfplq3Am3rsa9bMhjQPjlis6G4r763fisDjYrDTlKIGAwGJEWSznHVHtDq5
         7LcxfnQFKLSbmfI70NVLo3xkofOaXN4bhq18U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=f6AJazrS3jP2mlnRASYyxntzBtGLdmqU3AKO+A+Qu1M=;
        b=d6rIbpFSGmn25vy1s7CY27EHgbrkR37C0duq/VVOa1r81SUn+2+kE4PYhLxk3o9ENT
         FebUJwd1TVMfQEmwAgE21a/qc0KhiNoqZm7asxHbC+alyc7PZY0uMIizQ3tMSnqIinc7
         z/Un26LFyp3pP7MyUjUAl++Y0FNnMcD4eIRXwRWCl5NyCVG1rUj47OvmVJyVFAt4To27
         jdbeIdwyc4nRMzyF6+lBV1QyamkQEoJZs6oHV+yCeWOJvI783mAfFvhBF5W3xNL/unQD
         I9wVLlifVKxb+oKNrHRdkK/v4jAZCHF5P8KhH1WNNa43oZ8Dr87QGpMJsgklPDmv6KIG
         EaFA==
X-Gm-Message-State: AOAM532P2D5srmZooMtnGeCBOX9EpyJ2X0tSJ2MCmWr9pl28fuXxKFeT
        xPSvWeJhA4ixstnS6f9OX8LM0g==
X-Google-Smtp-Source: ABdhPJyXeoAJFRBHAy+RXvRqZ1fZjzkEsT/88mJrOrOkcUiXVkM8Sks2mZVsMxdFAUdMj+xQNjhevA==
X-Received: by 2002:a63:700e:: with SMTP id l14mr1830934pgc.22.1599632325320;
        Tue, 08 Sep 2020 23:18:45 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id w6sm1105021pgf.72.2020.09.08.23.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 23:18:44 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200906150247.3aaef3a3@archlinux>
References: <20200903221828.3657250-1-swboyd@chromium.org> <20200906150247.3aaef3a3@archlinux>
Subject: Re: [PATCH] dt-bindings: iio: sx9310: Add various settings as DT properties
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Daniel Campello <campello@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Evan Green <evgreen@chromium.org>
To:     Jonathan Cameron <jic23@kernel.org>
Date:   Tue, 08 Sep 2020 23:18:43 -0700
Message-ID: <159963232334.454335.9794130058200265122@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Jonathan Cameron (2020-09-06 07:02:47)
> On Thu,  3 Sep 2020 15:18:28 -0700
> Stephen Boyd <swboyd@chromium.org> wrote:
>=20
> > We need to set various bits in the hardware registers for this device to
> > operate properly depending on how it is installed. Add a handful of DT
> > properties to configure these things.
> >=20
> > Cc: Daniel Campello <campello@chromium.org>
> > Cc: Lars-Peter Clausen <lars@metafoo.de>
> > Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: <devicetree@vger.kernel.org>
> > Cc: Douglas Anderson <dianders@chromium.org>
> > Cc: Gwendal Grignou <gwendal@chromium.org>
> > Cc: Evan Green <evgreen@chromium.org>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> >=20
> > I haven't written any code to handle these properties yet. I'd rather do
> > that once the binding patch is reviewed. Patch based on iio.git testing
> > branch.
> Makes sense to do docs first for this.  Quite a bit feels like it isn't
> a feature of the device configuration, but rather of the usecase.  That
> stuff should probably be done with a userspace interface, but you may
> be able to argue me around on some of them!=20
>=20
>=20

Thanks for reviewing! I'm not well read on IIO so please bear with my
ignorance.

> >=20
> >  .../iio/proximity/semtech,sx9310.yaml         | 182 ++++++++++++++++++
> >  1 file changed, 182 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/iio/proximity/semtech,sx=
9310.yaml b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.=
yaml
> > index 5739074d3592..e74b81483c14 100644
> > --- a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.ya=
ml
> > +++ b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.ya=
ml
> > @@ -40,6 +40,169 @@ properties:
> >    "#io-channel-cells":
> >      const: 1
> > =20
> > +  semtech,cs0-ground:
> > +    description: Indicates the CS0 sensor is connected to ground.
> > +    type: boolean
>=20
> This one is probably fine. I can't think of a similar interface we need
> to match, but maybe Rob or someone else will have a suggestion.

Ok.

>=20
> > +
> > +  semtech,combined-sensors:
> > +    allOf:
> > +      - $ref: /schemas/types.yaml#definitions/uint32
> > +      - enum: [0, 1, 2, 3]
> > +    default: 0
> > +    description:
> > +      Which sensors are combined. 0 for CS3, 1 for CS0+CS1, 2 for CS1+=
CS2,
> > +      and 3 for all sensors.
>=20
> Make it clear in this description what 'combined' means.
> Also, I think this would be better as a set of values with an anyOf match=
 to say
> <3>
> <0>, <1>=20
> <1>, <2>=20
> <1>, <2>, <3>
>=20
> Fine to insist they are in numeric order.

Ok, sure. I can make it a list of sensor numbers.

>=20
> > +
> > +  semtech,cs0-gain-factor:
> > +    allOf:
> > +      - $ref: /schemas/types.yaml#definitions/uint32
> > +      - enum: [1, 2, 4, 8]
> > +    default: 1
> > +    description:
> > +      Gain factor for CS0 (and combined if any) sensor.
>=20
> Why is this something that should be in DT as opposed to via
> a userspace control?  We have hardwaregain for this purpose (I think)

Thanks I'm not aware of hardwaregain. That looks like it should work.

>=20
> Also we mostly use child nodes to allow us to specify characteristics
> of individual channels.

Got it.

>=20
> > +
> > +  semtech,cs1-gain-factor:
> > +    allOf:
> > +      - $ref: /schemas/types.yaml#definitions/uint32
> > +      - enum: [1, 2, 4, 8]
> > +    default: 1
> > +    description:
> > +      Gain factor for CS1 sensor.
> > +
> > +  semtech,cs2-gain-factor:
> > +    allOf:
> > +      - $ref: /schemas/types.yaml#definitions/uint32
> > +      - enum: [1, 2, 4, 8]
> > +    default: 1
> > +    description:
> > +      Gain factor for CS2 sensor.
> > +
> > +  semtech,resolution:
> > +    description:
> > +      Capacitance measure resolution.
> > +    enum:
> > +      - coarsest
> > +      - very-coarse
> > +      - coarse
> > +      - medium-coarse
> > +      - medium
> > +      - fine
> > +      - very-fine
> > +      - finest
> I'd normally be very against cases like this where we have something that
> feels like it should have a clear definition rather than a random wordy s=
cale
> but these are all the information I can find in the datasheet.
>=20
> I would suggest adding a specific reference to the datasheet for this one.

Are you saying description should say:

Capacitance measure resolution. Refer to datasheet for more details.

?

>=20
> > +
> > +  semtech,startup-sensor:
> > +    allOf:
> > +      - $ref: /schemas/types.yaml#definitions/uint32
> > +      - enum: [0, 1, 2, 3]
> > +    default: 0
> > +    description:
> > +      Sensor used for start-up proximity detection. The combined
> > +      sensor is represented by 3.
>=20
> This feels like it should be a userspace control rather than in DT?

I believe this is used during initial compensation, so it needs to be
set before sx9310_init_compensation() runs at probe time. Probably can't
be moved to userspace.

>=20
> > +
> > +  semtech,proxraw-strength:
> > +    allOf:
> > +      - $ref: /schemas/types.yaml#definitions/uint32
> > +      - enum: [0, 2, 4, 8]
> > +    default: 2
> > +    description:
> > +      PROXRAW filter strength. A value of 0 represents off, and other =
values
> > +      represent 1-1/N.
>=20
> Having looked at the datasheet I have little or now idea of what this fil=
ter
> actually is.  However, what is the argument for it being in DT rather than
> exposing a userspace control of some type.

I only see this equation in the datasheet

F(PROXRAW ; PROXUSEFUL[n-1] ; RAWFILT) =3D (1 - RAWFILT).PROXRAW + RAWFILT.=
PROXUSEFUL[n-1]=20

and it's talking about updating PROXUSEFUL. "PROXUSEFUL update consists
of filtering PROXRAW upfront to remove its high frequencies components".
So presumably this filter is used to make proxraw into proxuseful so
that it is a meaningful number. Is this a new knob in userspace?

>=20
> > +
> > +  semtech,compensate-common:
> > +    description: Any sensor triggers compensation of all channels.
> > +    type: boolean
>=20
> Compensation for what?

This is for RegProxCtrl6 bit 6 AVGCOMPMETHOD.=20

	Defines the average compensation method:

	0: Individual. Each sensor triggers only its own compensation
	1: Common. Any sensor triggers compensation of all channels.=20

I believe this is for the offset compensation.

>=20
> > +
> > +  semtech,avg-pos-strength:
> > +    allOf:
> > +      - $ref: /schemas/types.yaml#definitions/uint32
> > +      - enum: [0, 16, 64, 128, 256, 512, 1024, 4294967295]
> > +    default: 16
> > +    description:
> > +      Average positive filter strength. A value of 0 represents off and
> > +      UINT_MAX (4294967295) represents infinite. Other values
> > +      represent 1-1/N.
>=20
> I'm not sure about using UINT_MAX to represent infinity. Rob any thoughts=
 on
> this?
>=20
> Again, why does it make sense to have the filter controls in DT?

Is there an IIO property for this? Seems OK to move it to userspace.

>=20
>=20
> > +
> > +  semtech,cs0-prox-threshold:
> > +    allOf:
> > +      - $ref: /schemas/types.yaml#definitions/uint32
> > +      - enum: [2, 4, 6, 8, 12, 16, 20, 24, 28, 32, 40,
> > +               48, 56, 64, 72, 80, 88, 96, 112, 128, 144,
> > +               160, 192, 224, 256, 320, 384, 512, 640,
> > +               768, 1024, 1536]
> > +    default: 12
> > +    description:
> > +      Proximity detection threshold for CS0 (and combined if any) sens=
or.
>=20
> That is definitely a userspace thing. Why would you put it in DT?
> Also same comment as above for channels as child nodes

Alright. Presumably this is IIO_EV_TYPE_THRESH?

>=20
> > +
> > +  semtech,cs1-prox-threshold:
> > +    allOf:
> > +      - $ref: /schemas/types.yaml#definitions/uint32
> > +      - enum: [2, 4, 6, 8, 12, 16, 20, 24, 28, 32, 40,
> > +               48, 56, 64, 72, 80, 88, 96, 112, 128, 144,
> > +               160, 192, 224, 256, 320, 384, 512, 640,
> > +               768, 1024, 1536]
> > +    default: 12
> > +    description:
> > +      Proximity detection threshold for CS1 sensor.
> > +
> > +  semtech,cs2-prox-threshold:
> > +    allOf:
> > +      - $ref: /schemas/types.yaml#definitions/uint32
> > +      - enum: [2, 4, 6, 8, 12, 16, 20, 24, 28, 32, 40,
> > +               48, 56, 64, 72, 80, 88, 96, 112, 128, 144,
> > +               160, 192, 224, 256, 320, 384, 512, 640,
> > +               768, 1024, 1536]
> > +    default: 12
> > +    description:
> > +      Proximity detection threshold for CS2 sensor.
> > +
> > +  semtech,cs0-body-threshold:
> > +    allOf:
> > +      - $ref: /schemas/types.yaml#definitions/uint32
> > +      - enum: [0, 300, 600, 900, 1200, 1500, 1800, 30000]
> > +    default: 1800
> > +    description:
> > +      Body detection threshold for CS0 (and combined if any) sensor.
>=20
> As before, why DT plus child nodes

How should I differentiate body vs. proximity thresholds in userspace?
Or should I make it /sys/.../events/in_proximity0_thresh_falling_value
vs. /sys/.../events/in_proximity0_thresh_rising_value?

>=20
> > +
> > +  semtech,cs1-body-threshold:
> > +    allOf:
> > +      - $ref: /schemas/types.yaml#definitions/uint32
> > +      - enum: [0, 300, 600, 900, 1200, 1500, 1800, 30000]
> > +    default: 12
> > +    description:
> > +      Body detection threshold for CS1 sensor.
> > +
> > +  semtech,cs2-body-threshold:
> > +    allOf:
> > +      - $ref: /schemas/types.yaml#definitions/uint32
> > +      - enum: [0, 300, 600, 900, 1200, 1500, 1800, 30000]
> > +    default: 12
> > +    description:
> > +      Body detection threshold for CS2 sensor.
> > +
> > +  semtech,hysteresis:
> > +    allOf:
> > +      - $ref: /schemas/types.yaml#definitions/uint32
> > +      - enum: [0, 6, 12, 25]
> > +    default: 0
> > +    description:
> > +      The percentage of hysteresis +/- applied to proximity/body sampl=
es.
>=20
> Is this hysteresis on an event?  If so we have defined ABI to control that
> from userspace, though as an absolute value rather than a precentage so s=
ome
> magic will be needed.  Hysteresis is usually defined only the 'not event'
> direction rather than +/-

Is this IIO_EV_INFO_HYSTERESIS? It looks like it is applied to the
threshold by shifting it right by 4, 3, or 2. I think the +/- is
actually dependent on the RegProxCtrl10 bit 6 FARCOND value, so maybe
that isn't a problem. We could make another value like hysteresis shift
or hysteresis percentage?

>=20
> > +
> > +  semtech,close-debounce-samples:
> > +    allOf:
> > +      - $ref: /schemas/types.yaml#definitions/uint32
> > +      - enum: [0, 2, 4, 8]
> > +    default: 0
> > +    description:
> > +      The number of close samples debounced for proximity/body thresho=
lds.
>=20
> This feels like something that has more to do with the object motion than
> the sensor setup, so perhaps should be controlled from userspace?

Sure. Is there an IIO sample property? Or I should make a custom
knob for this?

>=20
> > +
> > +  semtech,far-debounce-samples:
> > +    allOf:
> > +      - $ref: /schemas/types.yaml#definitions/uint32
> > +      - enum: [0, 2, 4, 8]
> > +    default: 0
> > +    description:
> > +      The number of far samples debounced for proximity/body threshold=
s.
> > +
> >  required:
> >    - compatible
> >    - reg
