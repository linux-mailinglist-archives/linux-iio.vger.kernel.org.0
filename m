Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 440C6262DF1
	for <lists+linux-iio@lfdr.de>; Wed,  9 Sep 2020 13:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729479AbgIILgr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Sep 2020 07:36:47 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2800 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729719AbgIILgF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 9 Sep 2020 07:36:05 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id C62BCCC8C1AF985AE5FE;
        Wed,  9 Sep 2020 12:17:28 +0100 (IST)
Received: from localhost (10.52.122.51) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Wed, 9 Sep 2020
 12:17:28 +0100
Date:   Wed, 9 Sep 2020 12:15:50 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Stephen Boyd <swboyd@chromium.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        Daniel Campello <campello@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH] dt-bindings: iio: sx9310: Add various settings as DT
 properties
Message-ID: <20200909121550.00005ede@Huawei.com>
In-Reply-To: <159963232334.454335.9794130058200265122@swboyd.mtv.corp.google.com>
References: <20200903221828.3657250-1-swboyd@chromium.org>
        <20200906150247.3aaef3a3@archlinux>
        <159963232334.454335.9794130058200265122@swboyd.mtv.corp.google.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.122.51]
X-ClientProxiedBy: lhreml709-chm.china.huawei.com (10.201.108.58) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 8 Sep 2020 23:18:43 -0700
Stephen Boyd <swboyd@chromium.org> wrote:

> Quoting Jonathan Cameron (2020-09-06 07:02:47)
> > On Thu,  3 Sep 2020 15:18:28 -0700
> > Stephen Boyd <swboyd@chromium.org> wrote:
> >   
> > > We need to set various bits in the hardware registers for this device to
> > > operate properly depending on how it is installed. Add a handful of DT
> > > properties to configure these things.
> > > 
> > > Cc: Daniel Campello <campello@chromium.org>
> > > Cc: Lars-Peter Clausen <lars@metafoo.de>
> > > Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> > > Cc: Rob Herring <robh+dt@kernel.org>
> > > Cc: <devicetree@vger.kernel.org>
> > > Cc: Douglas Anderson <dianders@chromium.org>
> > > Cc: Gwendal Grignou <gwendal@chromium.org>
> > > Cc: Evan Green <evgreen@chromium.org>
> > > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > > ---
> > > 
> > > I haven't written any code to handle these properties yet. I'd rather do
> > > that once the binding patch is reviewed. Patch based on iio.git testing
> > > branch.  
> > Makes sense to do docs first for this.  Quite a bit feels like it isn't
> > a feature of the device configuration, but rather of the usecase.  That
> > stuff should probably be done with a userspace interface, but you may
> > be able to argue me around on some of them! 
> > 
> >   
> 
> Thanks for reviewing! I'm not well read on IIO so please bear with my
> ignorance.
> 
No problem!

> > > 
> > >  .../iio/proximity/semtech,sx9310.yaml         | 182 ++++++++++++++++++
> > >  1 file changed, 182 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
> > > index 5739074d3592..e74b81483c14 100644
> > > --- a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
> > > +++ b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
> > > @@ -40,6 +40,169 @@ properties:
> > >    "#io-channel-cells":
> > >      const: 1
> > >  
> > > +  semtech,cs0-ground:
> > > +    description: Indicates the CS0 sensor is connected to ground.
> > > +    type: boolean  
> > 
> > This one is probably fine. I can't think of a similar interface we need
> > to match, but maybe Rob or someone else will have a suggestion.  
> 
> Ok.
> 
> >   
> > > +
> > > +  semtech,combined-sensors:
> > > +    allOf:
> > > +      - $ref: /schemas/types.yaml#definitions/uint32
> > > +      - enum: [0, 1, 2, 3]
> > > +    default: 0
> > > +    description:
> > > +      Which sensors are combined. 0 for CS3, 1 for CS0+CS1, 2 for CS1+CS2,
> > > +      and 3 for all sensors.  
> > 
> > Make it clear in this description what 'combined' means.
> > Also, I think this would be better as a set of values with an anyOf match to say
> > <3>
> > <0>, <1> 
> > <1>, <2> 
> > <1>, <2>, <3>
> > 
> > Fine to insist they are in numeric order.  
> 
> Ok, sure. I can make it a list of sensor numbers.
> 
> >   
> > > +
> > > +  semtech,cs0-gain-factor:
> > > +    allOf:
> > > +      - $ref: /schemas/types.yaml#definitions/uint32
> > > +      - enum: [1, 2, 4, 8]
> > > +    default: 1
> > > +    description:
> > > +      Gain factor for CS0 (and combined if any) sensor.  
> > 
> > Why is this something that should be in DT as opposed to via
> > a userspace control?  We have hardwaregain for this purpose (I think)  
> 
> Thanks I'm not aware of hardwaregain. That looks like it should work.
> 
> > 
> > Also we mostly use child nodes to allow us to specify characteristics
> > of individual channels.  
> 
> Got it.
> 
> >   
> > > +
> > > +  semtech,cs1-gain-factor:
> > > +    allOf:
> > > +      - $ref: /schemas/types.yaml#definitions/uint32
> > > +      - enum: [1, 2, 4, 8]
> > > +    default: 1
> > > +    description:
> > > +      Gain factor for CS1 sensor.
> > > +
> > > +  semtech,cs2-gain-factor:
> > > +    allOf:
> > > +      - $ref: /schemas/types.yaml#definitions/uint32
> > > +      - enum: [1, 2, 4, 8]
> > > +    default: 1
> > > +    description:
> > > +      Gain factor for CS2 sensor.
> > > +
> > > +  semtech,resolution:
> > > +    description:
> > > +      Capacitance measure resolution.
> > > +    enum:
> > > +      - coarsest
> > > +      - very-coarse
> > > +      - coarse
> > > +      - medium-coarse
> > > +      - medium
> > > +      - fine
> > > +      - very-fine
> > > +      - finest  
> > I'd normally be very against cases like this where we have something that
> > feels like it should have a clear definition rather than a random wordy scale
> > but these are all the information I can find in the datasheet.
> > 
> > I would suggest adding a specific reference to the datasheet for this one.  
> 
> Are you saying description should say:
> 
> Capacitance measure resolution. Refer to datasheet for more details.

Yes, basically we are saying we can't provide documentation here that is
sufficiently detailed.  (Mostly because the datasheet doesn't really do so
either) Hence, we aren't going to try.  Normally I hate this sort of
poor local documentation but I can't see what else we can do here given
all we have is those names.

> 
> ?
> 
> >   
> > > +
> > > +  semtech,startup-sensor:
> > > +    allOf:
> > > +      - $ref: /schemas/types.yaml#definitions/uint32
> > > +      - enum: [0, 1, 2, 3]
> > > +    default: 0
> > > +    description:
> > > +      Sensor used for start-up proximity detection. The combined
> > > +      sensor is represented by 3.  
> > 
> > This feels like it should be a userspace control rather than in DT?  
> 
> I believe this is used during initial compensation, so it needs to be
> set before sx9310_init_compensation() runs at probe time. Probably can't
> be moved to userspace.

Add that detail to the description here.

> 
> >   
> > > +
> > > +  semtech,proxraw-strength:
> > > +    allOf:
> > > +      - $ref: /schemas/types.yaml#definitions/uint32
> > > +      - enum: [0, 2, 4, 8]
> > > +    default: 2
> > > +    description:
> > > +      PROXRAW filter strength. A value of 0 represents off, and other values
> > > +      represent 1-1/N.  
> > 
> > Having looked at the datasheet I have little or now idea of what this filter
> > actually is.  However, what is the argument for it being in DT rather than
> > exposing a userspace control of some type.  
> 
> I only see this equation in the datasheet
> 
> F(PROXRAW ; PROXUSEFUL[n-1] ; RAWFILT) = (1 - RAWFILT).PROXRAW + RAWFILT.PROXUSEFUL[n-1] 
> 
> and it's talking about updating PROXUSEFUL. "PROXUSEFUL update consists
> of filtering PROXRAW upfront to remove its high frequencies components".
> So presumably this filter is used to make proxraw into proxuseful so
> that it is a meaningful number. Is this a new knob in userspace?

It might fit with the various filter definitions, but there is so little info
it is hard to map it across.   Perhaps DT is the best we can do here even
though it would ideally be controlled from userspace.

> 
> >   
> > > +
> > > +  semtech,compensate-common:
> > > +    description: Any sensor triggers compensation of all channels.
> > > +    type: boolean  
> > 
> > Compensation for what?  
> 
> This is for RegProxCtrl6 bit 6 AVGCOMPMETHOD. 
> 
> 	Defines the average compensation method:
> 
> 	0: Individual. Each sensor triggers only its own compensation
> 	1: Common. Any sensor triggers compensation of all channels. 
> 
> I believe this is for the offset compensation.

I wonder if anyone will actually care which choice we make on that?
Perhaps just pick one and don't make it controllable?

Reading that it sounds like a control that is there because it was easy
to do in hardware rather than necessarily making any sense from
a usecase point of view.  Do we have any info on how it is used?

> 
> >   
> > > +
> > > +  semtech,avg-pos-strength:
> > > +    allOf:
> > > +      - $ref: /schemas/types.yaml#definitions/uint32
> > > +      - enum: [0, 16, 64, 128, 256, 512, 1024, 4294967295]
> > > +    default: 16
> > > +    description:
> > > +      Average positive filter strength. A value of 0 represents off and
> > > +      UINT_MAX (4294967295) represents infinite. Other values
> > > +      represent 1-1/N.  
> > 
> > I'm not sure about using UINT_MAX to represent infinity. Rob any thoughts on
> > this?
> > 
> > Again, why does it make sense to have the filter controls in DT?  
> 
> Is there an IIO property for this? Seems OK to move it to userspace.

I'm not sure enough of what it means, but we have filter controls in
terms of 3db point and oversampling. If you can figure out a match to
those or something that seems more generic than the above to propose
as new ABI that would be great.

> 
> > 
> >   
> > > +
> > > +  semtech,cs0-prox-threshold:
> > > +    allOf:
> > > +      - $ref: /schemas/types.yaml#definitions/uint32
> > > +      - enum: [2, 4, 6, 8, 12, 16, 20, 24, 28, 32, 40,
> > > +               48, 56, 64, 72, 80, 88, 96, 112, 128, 144,
> > > +               160, 192, 224, 256, 320, 384, 512, 640,
> > > +               768, 1024, 1536]
> > > +    default: 12
> > > +    description:
> > > +      Proximity detection threshold for CS0 (and combined if any) sensor.  
> > 
> > That is definitely a userspace thing. Why would you put it in DT?
> > Also same comment as above for channels as child nodes  
> 
> Alright. Presumably this is IIO_EV_TYPE_THRESH?

Yes.

> 
> >   
> > > +
> > > +  semtech,cs1-prox-threshold:
> > > +    allOf:
> > > +      - $ref: /schemas/types.yaml#definitions/uint32
> > > +      - enum: [2, 4, 6, 8, 12, 16, 20, 24, 28, 32, 40,
> > > +               48, 56, 64, 72, 80, 88, 96, 112, 128, 144,
> > > +               160, 192, 224, 256, 320, 384, 512, 640,
> > > +               768, 1024, 1536]
> > > +    default: 12
> > > +    description:
> > > +      Proximity detection threshold for CS1 sensor.
> > > +
> > > +  semtech,cs2-prox-threshold:
> > > +    allOf:
> > > +      - $ref: /schemas/types.yaml#definitions/uint32
> > > +      - enum: [2, 4, 6, 8, 12, 16, 20, 24, 28, 32, 40,
> > > +               48, 56, 64, 72, 80, 88, 96, 112, 128, 144,
> > > +               160, 192, 224, 256, 320, 384, 512, 640,
> > > +               768, 1024, 1536]
> > > +    default: 12
> > > +    description:
> > > +      Proximity detection threshold for CS2 sensor.
> > > +
> > > +  semtech,cs0-body-threshold:
> > > +    allOf:
> > > +      - $ref: /schemas/types.yaml#definitions/uint32
> > > +      - enum: [0, 300, 600, 900, 1200, 1500, 1800, 30000]
> > > +    default: 1800
> > > +    description:
> > > +      Body detection threshold for CS0 (and combined if any) sensor.  
> > 
> > As before, why DT plus child nodes  
> 
> How should I differentiate body vs. proximity thresholds in userspace?
> Or should I make it /sys/.../events/in_proximity0_thresh_falling_value
> vs. /sys/.../events/in_proximity0_thresh_rising_value?

I'm not sure what they actually are. A problem with IIO that may be relevant
is that we have never supported multiple events of the same type for a channel.
Unfortunately that is hard to change now as we'd have to redefine the event
codes.

It feels like these are potentially a bit smarter however. If they are we
could handle them as a different event type.  Or potentially an event
on a different channel (arguably they are some result of some sort of
processing of more than a simple single value).  There is a patent but I've
not read it in detail.

> 
> >   
> > > +
> > > +  semtech,cs1-body-threshold:
> > > +    allOf:
> > > +      - $ref: /schemas/types.yaml#definitions/uint32
> > > +      - enum: [0, 300, 600, 900, 1200, 1500, 1800, 30000]
> > > +    default: 12
> > > +    description:
> > > +      Body detection threshold for CS1 sensor.
> > > +
> > > +  semtech,cs2-body-threshold:
> > > +    allOf:
> > > +      - $ref: /schemas/types.yaml#definitions/uint32
> > > +      - enum: [0, 300, 600, 900, 1200, 1500, 1800, 30000]
> > > +    default: 12
> > > +    description:
> > > +      Body detection threshold for CS2 sensor.
> > > +
> > > +  semtech,hysteresis:
> > > +    allOf:
> > > +      - $ref: /schemas/types.yaml#definitions/uint32
> > > +      - enum: [0, 6, 12, 25]
> > > +    default: 0
> > > +    description:
> > > +      The percentage of hysteresis +/- applied to proximity/body samples.  
> > 
> > Is this hysteresis on an event?  If so we have defined ABI to control that
> > from userspace, though as an absolute value rather than a precentage so some
> > magic will be needed.  Hysteresis is usually defined only the 'not event'
> > direction rather than +/-  
> 
> Is this IIO_EV_INFO_HYSTERESIS? It looks like it is applied to the
> threshold by shifting it right by 4, 3, or 2. I think the +/- is
> actually dependent on the RegProxCtrl10 bit 6 FARCOND value, so maybe
> that isn't a problem. We could make another value like hysteresis shift
> or hysteresis percentage?

I'd rather avoid extra ABI if we can make it work as it stands, even if it
is a little involved to do so.  Extra ABI just means we end up with more
incompatible userspace code over time.

> 
> >   
> > > +
> > > +  semtech,close-debounce-samples:
> > > +    allOf:
> > > +      - $ref: /schemas/types.yaml#definitions/uint32
> > > +      - enum: [0, 2, 4, 8]
> > > +    default: 0
> > > +    description:
> > > +      The number of close samples debounced for proximity/body thresholds.  
> > 
> > This feels like something that has more to do with the object motion than
> > the sensor setup, so perhaps should be controlled from userspace?  
> 
> Sure. Is there an IIO sample property? Or I should make a custom
> knob for this?

It's kind of close to in_proximity0_thresh_period and that may be how they
have implemented it.

That control specifies a number of samples for which a condition should be true
before it is reported.

> 
> >   
> > > +
> > > +  semtech,far-debounce-samples:
> > > +    allOf:
> > > +      - $ref: /schemas/types.yaml#definitions/uint32
> > > +      - enum: [0, 2, 4, 8]
> > > +    default: 0
> > > +    description:
> > > +      The number of far samples debounced for proximity/body thresholds.
> > > +
> > >  required:
> > >    - compatible
> > >    - reg  


