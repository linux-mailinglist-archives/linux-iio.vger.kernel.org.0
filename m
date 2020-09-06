Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1392125EE06
	for <lists+linux-iio@lfdr.de>; Sun,  6 Sep 2020 16:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbgIFOC7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Sep 2020 10:02:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:51220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725803AbgIFOCy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 Sep 2020 10:02:54 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 121A320714;
        Sun,  6 Sep 2020 14:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599400972;
        bh=ZKHR3/YoCbtZkxot3BgUVVfjLR+YJMCjyIihTwxvW0g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fykDEtkgu2b6/BJMgS0xmiRVI97T34ZxRKxlk48OWHfchiQSUr4F0F7hdHS4jR/AJ
         Zw3lDWigCNN5pqAx+MdYB6PO2zl82kQAQ2X/IcJhDJJnbh42Txixfo/R+t796glPNj
         peErsYfLrsSSb4RwQMCchyL4F5oMa3vEvGf3P3dQ=
Date:   Sun, 6 Sep 2020 15:02:47 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Daniel Campello <campello@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH] dt-bindings: iio: sx9310: Add various settings as DT
 properties
Message-ID: <20200906150247.3aaef3a3@archlinux>
In-Reply-To: <20200903221828.3657250-1-swboyd@chromium.org>
References: <20200903221828.3657250-1-swboyd@chromium.org>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  3 Sep 2020 15:18:28 -0700
Stephen Boyd <swboyd@chromium.org> wrote:

> We need to set various bits in the hardware registers for this device to
> operate properly depending on how it is installed. Add a handful of DT
> properties to configure these things.
> 
> Cc: Daniel Campello <campello@chromium.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: <devicetree@vger.kernel.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Gwendal Grignou <gwendal@chromium.org>
> Cc: Evan Green <evgreen@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
> 
> I haven't written any code to handle these properties yet. I'd rather do
> that once the binding patch is reviewed. Patch based on iio.git testing
> branch.
Makes sense to do docs first for this.  Quite a bit feels like it isn't
a feature of the device configuration, but rather of the usecase.  That
stuff should probably be done with a userspace interface, but you may
be able to argue me around on some of them! 

Jonathan

> 
>  .../iio/proximity/semtech,sx9310.yaml         | 182 ++++++++++++++++++
>  1 file changed, 182 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
> index 5739074d3592..e74b81483c14 100644
> --- a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
> +++ b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
> @@ -40,6 +40,169 @@ properties:
>    "#io-channel-cells":
>      const: 1
>  
> +  semtech,cs0-ground:
> +    description: Indicates the CS0 sensor is connected to ground.
> +    type: boolean

This one is probably fine. I can't think of a similar interface we need
to match, but maybe Rob or someone else will have a suggestion.

> +
> +  semtech,combined-sensors:
> +    allOf:
> +      - $ref: /schemas/types.yaml#definitions/uint32
> +      - enum: [0, 1, 2, 3]
> +    default: 0
> +    description:
> +      Which sensors are combined. 0 for CS3, 1 for CS0+CS1, 2 for CS1+CS2,
> +      and 3 for all sensors.

Make it clear in this description what 'combined' means.
Also, I think this would be better as a set of values with an anyOf match to say
<3>
<0>, <1> 
<1>, <2> 
<1>, <2>, <3>

Fine to insist they are in numeric order.

> +
> +  semtech,cs0-gain-factor:
> +    allOf:
> +      - $ref: /schemas/types.yaml#definitions/uint32
> +      - enum: [1, 2, 4, 8]
> +    default: 1
> +    description:
> +      Gain factor for CS0 (and combined if any) sensor.

Why is this something that should be in DT as opposed to via
a userspace control?  We have hardwaregain for this purpose (I think)

Also we mostly use child nodes to allow us to specify characteristics
of individual channels.

> +
> +  semtech,cs1-gain-factor:
> +    allOf:
> +      - $ref: /schemas/types.yaml#definitions/uint32
> +      - enum: [1, 2, 4, 8]
> +    default: 1
> +    description:
> +      Gain factor for CS1 sensor.
> +
> +  semtech,cs2-gain-factor:
> +    allOf:
> +      - $ref: /schemas/types.yaml#definitions/uint32
> +      - enum: [1, 2, 4, 8]
> +    default: 1
> +    description:
> +      Gain factor for CS2 sensor.
> +
> +  semtech,resolution:
> +    description:
> +      Capacitance measure resolution.
> +    enum:
> +      - coarsest
> +      - very-coarse
> +      - coarse
> +      - medium-coarse
> +      - medium
> +      - fine
> +      - very-fine
> +      - finest
I'd normally be very against cases like this where we have something that
feels like it should have a clear definition rather than a random wordy scale
but these are all the information I can find in the datasheet.

I would suggest adding a specific reference to the datasheet for this one.

> +
> +  semtech,startup-sensor:
> +    allOf:
> +      - $ref: /schemas/types.yaml#definitions/uint32
> +      - enum: [0, 1, 2, 3]
> +    default: 0
> +    description:
> +      Sensor used for start-up proximity detection. The combined
> +      sensor is represented by 3.

This feels like it should be a userspace control rather than in DT?

> +
> +  semtech,proxraw-strength:
> +    allOf:
> +      - $ref: /schemas/types.yaml#definitions/uint32
> +      - enum: [0, 2, 4, 8]
> +    default: 2
> +    description:
> +      PROXRAW filter strength. A value of 0 represents off, and other values
> +      represent 1-1/N.

Having looked at the datasheet I have little or now idea of what this filter
actually is.  However, what is the argument for it being in DT rather than
exposing a userspace control of some type.

> +
> +  semtech,compensate-common:
> +    description: Any sensor triggers compensation of all channels.
> +    type: boolean

Compensation for what?

> +
> +  semtech,avg-pos-strength:
> +    allOf:
> +      - $ref: /schemas/types.yaml#definitions/uint32
> +      - enum: [0, 16, 64, 128, 256, 512, 1024, 4294967295]
> +    default: 16
> +    description:
> +      Average positive filter strength. A value of 0 represents off and
> +      UINT_MAX (4294967295) represents infinite. Other values
> +      represent 1-1/N.

I'm not sure about using UINT_MAX to represent infinity. Rob any thoughts on
this?

Again, why does it make sense to have the filter controls in DT?


> +
> +  semtech,cs0-prox-threshold:
> +    allOf:
> +      - $ref: /schemas/types.yaml#definitions/uint32
> +      - enum: [2, 4, 6, 8, 12, 16, 20, 24, 28, 32, 40,
> +               48, 56, 64, 72, 80, 88, 96, 112, 128, 144,
> +               160, 192, 224, 256, 320, 384, 512, 640,
> +               768, 1024, 1536]
> +    default: 12
> +    description:
> +      Proximity detection threshold for CS0 (and combined if any) sensor.

That is definitely a userspace thing. Why would you put it in DT?
Also same comment as above for channels as child nodes

> +
> +  semtech,cs1-prox-threshold:
> +    allOf:
> +      - $ref: /schemas/types.yaml#definitions/uint32
> +      - enum: [2, 4, 6, 8, 12, 16, 20, 24, 28, 32, 40,
> +               48, 56, 64, 72, 80, 88, 96, 112, 128, 144,
> +               160, 192, 224, 256, 320, 384, 512, 640,
> +               768, 1024, 1536]
> +    default: 12
> +    description:
> +      Proximity detection threshold for CS1 sensor.
> +
> +  semtech,cs2-prox-threshold:
> +    allOf:
> +      - $ref: /schemas/types.yaml#definitions/uint32
> +      - enum: [2, 4, 6, 8, 12, 16, 20, 24, 28, 32, 40,
> +               48, 56, 64, 72, 80, 88, 96, 112, 128, 144,
> +               160, 192, 224, 256, 320, 384, 512, 640,
> +               768, 1024, 1536]
> +    default: 12
> +    description:
> +      Proximity detection threshold for CS2 sensor.
> +
> +  semtech,cs0-body-threshold:
> +    allOf:
> +      - $ref: /schemas/types.yaml#definitions/uint32
> +      - enum: [0, 300, 600, 900, 1200, 1500, 1800, 30000]
> +    default: 1800
> +    description:
> +      Body detection threshold for CS0 (and combined if any) sensor.

As before, why DT plus child nodes

> +
> +  semtech,cs1-body-threshold:
> +    allOf:
> +      - $ref: /schemas/types.yaml#definitions/uint32
> +      - enum: [0, 300, 600, 900, 1200, 1500, 1800, 30000]
> +    default: 12
> +    description:
> +      Body detection threshold for CS1 sensor.
> +
> +  semtech,cs2-body-threshold:
> +    allOf:
> +      - $ref: /schemas/types.yaml#definitions/uint32
> +      - enum: [0, 300, 600, 900, 1200, 1500, 1800, 30000]
> +    default: 12
> +    description:
> +      Body detection threshold for CS2 sensor.
> +
> +  semtech,hysteresis:
> +    allOf:
> +      - $ref: /schemas/types.yaml#definitions/uint32
> +      - enum: [0, 6, 12, 25]
> +    default: 0
> +    description:
> +      The percentage of hysteresis +/- applied to proximity/body samples.

Is this hysteresis on an event?  If so we have defined ABI to control that
from userspace, though as an absolute value rather than a precentage so some
magic will be needed.  Hysteresis is usually defined only the 'not event'
direction rather than +/-

> +
> +  semtech,close-debounce-samples:
> +    allOf:
> +      - $ref: /schemas/types.yaml#definitions/uint32
> +      - enum: [0, 2, 4, 8]
> +    default: 0
> +    description:
> +      The number of close samples debounced for proximity/body thresholds.

This feels like something that has more to do with the object motion than
the sensor setup, so perhaps should be controlled from userspace?

> +
> +  semtech,far-debounce-samples:
> +    allOf:
> +      - $ref: /schemas/types.yaml#definitions/uint32
> +      - enum: [0, 2, 4, 8]
> +    default: 0
> +    description:
> +      The number of far samples debounced for proximity/body thresholds.
> +
>  required:
>    - compatible
>    - reg
> @@ -61,5 +224,24 @@ examples:
>          vdd-supply = <&pp3300_a>;
>          svdd-supply = <&pp1800_prox>;
>          #io-channel-cells = <1>;
> +        semtech,cs0-ground;
> +        semtech,combined-sensors = <0>;
> +        semtech,cs0-gain-factor = <8>;
> +        semtech,cs1-gain-factor = <8>;
> +        semtech,cs2-gain-factor = <8>;
> +        semtech,resolution = "fine";
> +        semtech,startup-sensor = <1>;
> +        semtech,proxraw-strength = <2>;
> +        semtech,compensate-common;
> +        semtech,avg-pos-strength = <64>;
> +        semtech,cs0-prox-threshold = <96>;
> +        semtech,cs1-prox-threshold = <112>;
> +        semtech,cs2-prox-threshold = <96>;
> +        semtech,cs0-body-threshold = <300>;
> +        semtech,cs1-body-threshold = <300>;
> +        semtech,cs2-body-threshold = <300>;
> +        semtech,hysteresis = <0>;
> +        semtech,close-debounce-samples = <2>;
> +        semtech,far-debounce-samples = <2>;
>        };
>      };
> 
> base-commit: 1bebdcb928eba880f3a119bacb8149216206958a

