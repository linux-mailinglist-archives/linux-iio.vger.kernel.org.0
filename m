Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAF128D606
	for <lists+linux-iio@lfdr.de>; Tue, 13 Oct 2020 22:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgJMUyI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Oct 2020 16:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727670AbgJMUyI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Oct 2020 16:54:08 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DBEC061755
        for <linux-iio@vger.kernel.org>; Tue, 13 Oct 2020 13:54:08 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id a72so148717wme.5
        for <linux-iio@vger.kernel.org>; Tue, 13 Oct 2020 13:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=k9ZSv95uCNlDTzfBcTf35pyuN5lVPEpze8CwFBPDxfc=;
        b=kxOhvfsXj1ADZxQHO6RSkT/SYBIiqBX5bUX1YKaEN0LYN4aFxAWxTDFsWR9ajJCxvk
         An8sPFYUJ9OMmXzxWKQyzVCpmjU0Hz7/hpKSoUmt973jhREwNIpFVpbOvu3cjiFhJoeS
         Dn+yNQIG/hOiyKltOmbH5q9Sgie/aBAjsvqC8TPhmAPCi6roH/ms68LJ6wPhQ/3SxSLw
         1/bdSRSgAbKVX7w8CoecdI8kgbo42xQvWWKjkDHIJ59HRPxdjhlneFZHEUkFIvtmI3pX
         Sy4j+JEDRzlkVVfWHZXXsNIYGED+BinYJmdBZdEdV83eWi6vVYx02K1P6cJuTUnF3AhZ
         MY/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k9ZSv95uCNlDTzfBcTf35pyuN5lVPEpze8CwFBPDxfc=;
        b=RJqqKXwv1Nw/KSGwQ8FUPg1Y2LIAbhT//NCMxW0fLFB3xa3Aii2X0kq9gayzWCg3y2
         Iv0j8StKvCK69D9R5IDV4Xx0dYZePJxQJ5OU69jAKr33+oGcZ3XPA5RKasqhAHsia1+n
         dJhBoGik14Musb5onvu75nzwXz/q+P91mYJPrAvv1eAy5fCPy8fB9Ei6I3XCJhOogof/
         yPcKA9wKCYcmkpKev824LX8etYBgmmaI7xPvVMy11amzlDSJd70xZGwDNQ4vuY/YYXjW
         9zDd74Q/c1RMmXV3zhZhWHHWoDybrVaYW3Q+zfPGd7W0Q+iIU+J6EvWTz9776skNqYgJ
         LQyg==
X-Gm-Message-State: AOAM531Ds5ZeODBB+v5/I0IsLB5h1yQ9Gb1ph76yldQDXfd4BdGf4/kr
        aQ3+T2BTZpeoPa1enqZGTZnoUw==
X-Google-Smtp-Source: ABdhPJxOjz6SdPRf2pHq+DdR8VQ2tyf3YlhaDZdWjk0JwedGTURi24epEmlqDdn79mhPbM/6hDCEhw==
X-Received: by 2002:a1c:9a93:: with SMTP id c141mr182157wme.168.1602622446626;
        Tue, 13 Oct 2020 13:54:06 -0700 (PDT)
Received: from arch-thunder.localdomain (a109-49-46-234.cpe.netcabo.pt. [109.49.46.234])
        by smtp.gmail.com with ESMTPSA id z191sm206861wme.30.2020.10.13.13.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 13:54:05 -0700 (PDT)
Date:   Tue, 13 Oct 2020 21:54:03 +0100
From:   Rui Miguel Silva <rui.silva@linaro.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: fxas21002c: convert bindings to yaml
Message-ID: <20201013205403.6tni6zi7bfg7ogye@arch-thunder.localdomain>
References: <20201013131545.503434-1-rmfrfs@gmail.com>
 <20201013153431.000052c9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013153431.000052c9@huawei.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,
On Tue, Oct 13, 2020 at 04:34:31PM +0100, Jonathan Cameron wrote:
> On Tue, 13 Oct 2020 14:15:45 +0100
> Rui Miguel Silva <rui.silva@linaro.org> wrote:
> 
> > Convert fxas21002c gyroscope sensor bindings documentation to
> > yaml schema and remove the textual bindings document.
> > 
> > Signed-off-by: Rui Miguel Silva <rmfrfs@gmail.com>
> 
> Hi Rui,
> 
> Always good to see a yaml conversion.
> 
> Comments inline...

Thanks for the review, I will address all your comments, just a small
note bellow regarding the unevaluatedProperties.

> 
> > ---
> >  .../bindings/iio/gyroscope/nxp,fxas21002c.txt | 31 --------
> >  .../iio/gyroscope/nxp,fxas21002c.yaml         | 77 +++++++++++++++++++
> >  MAINTAINERS                                   |  2 +-
> >  3 files changed, 78 insertions(+), 32 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.txt
> >  create mode 100644 Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.txt b/Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.txt
> > deleted file mode 100644
> > index 465e104bbf14..000000000000
> > --- a/Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.txt
> > +++ /dev/null
> > @@ -1,31 +0,0 @@
> > -* NXP FXAS21002C Gyroscope device tree bindings
> > -
> > -http://www.nxp.com/products/sensors/gyroscopes/3-axis-digital-gyroscope:FXAS21002C
> > -
> > -Required properties:
> > -  - compatible : should be "nxp,fxas21002c"
> > -  - reg : the I2C address of the sensor or SPI chip select number for the
> > -          device.
> > -  - vdd-supply: phandle to the regulator that provides power to the sensor.
> > -  - vddio-supply: phandle to the regulator that provides power to the bus.
> > -
> > -Optional properties:
> > -  - reset-gpios : gpio used to reset the device, see gpio/gpio.txt
> > -  - interrupts : device support 2 interrupts, INT1 and INT2,
> > -                 the interrupts can be triggered on rising or falling edges.
> > -                 See interrupt-controller/interrupts.txt
> > -  - interrupt-names: should contain "INT1" or "INT2", the gyroscope interrupt
> > -                     line in use.
> > -  - drive-open-drain: the interrupt/data ready line will be configured
> > -                      as open drain, which is useful if several sensors share
> > -                      the same interrupt line. This is a boolean property.
> > -                      (This binding is taken from pinctrl/pinctrl-bindings.txt)
> > -
> > -Example:
> > -
> > -gyroscope@20 {
> > -	compatible = "nxp,fxas21002c";
> > -	reg = <0x20>;
> > -	vdd-supply = <&reg_peri_3p15v>;
> > -	vddio-supply = <&reg_peri_3p15v>;
> > -};
> > diff --git a/Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.yaml b/Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.yaml
> > new file mode 100644
> > index 000000000000..7680e97cf1d9
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.yaml
> > @@ -0,0 +1,77 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/gyroscope/nxp,fxas21002c.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: NXP FXAS21002C Gyroscope Unit
> 
> Why Unit? Gyroscope seems fine to me.
> 
> > +
> > +maintainers:
> > +  - Rui Miguel Silva <rmfrfs@gmail.com>
> > +
> > +description: |
> > +  3 axis digital gyroscope device with an I2C and SPI interface.
> 
> Can we document the SPI binding as well?  With an example.
> 
> > +  http://www.nxp.com/products/sensors/gyroscopes/3-axis-digital-gyroscope:FXAS21002C
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - nxp,fxas21002c
> 
> Unless we think it likely this binding is going to shortly include other options,
>        const: nxp... 
> (doesn't matter that much though!)
> 
> > +
> > +  reg:
> > +    maxItems: 1
> > +    description: base address of the device
> 
> No it isn't. It is the i2c address. Also this is standard so no description needed.
> 
> 
> > +
> > +  vdd-supply:
> > +    description: Regulator that provides power to the sensor
> > +
> > +  vddio-supply:
> > +    description: Regulator that provides power to the bus
> > +
> > +  reset-gpios:
> > +    maxItems: 1
> > +    description: GPIO connected to reset
> > +
> > +  interrupts:
> > +    minItems: 1
> > +    maxItems: 2
> > +    description: device support 2 interrupts,
> I'd argue that's obvious from the maxItems. So no need to repeat it.
> 
> 
>  INT1 and INT2,
> This part is clear form interrupt-names so again, I wouldn't say it again.
> 
>  the interrupts can
> > +                 be triggered on rising or falling edges.
> This last bit is useful so I would have just this or something like
> 
> Either interrupt may be triggered on rising or falling edges.
> 
> > +
> > +  interrupt-names:
> > +    minItems: 1
> > +    maxItems: 2
> > +    items:
> > +      enum:
> > +        - INT1
> > +        - INT2
> > +    description: gyroscope interrupt line in use.
> 
> Singular with 2 interrupts.  Personally I'd just drop the description as not
> adding anything.
> 
> > +
> > +  drive-open-drain:
> > +    type: boolean
> > +    description: the interrupt/data ready line will be configured as open drain,
> > +                 which is useful if several sensors share the same interrupt
> > +                 line.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - vdd-supply
> 
> Why required?  If it's hard wired on will a stub regulator not work fine
> with this device.  Do we need to read it's voltage or similar?
> 
> > +  - vddio-supply
> > +
> > +unevaluatedProperties: false
> 
> Why unevalutatedProperties rather than additionalProperties?
> I'll confess I don't really understand when to use unevaluatedProperties.

Yeah, it is not very clear also to me, I was just following this
clean up series from Rob, and from my understanding here is a case for
unevaluatedProperties. But maybe I got it all wrong.

Cheers,
   Rui

> I'm guessing issue here is we don't have the SPI bindings stuff?
> 
> > +
> > +examples:
> > +  - |
> > +    i2c0 {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        gyroscope@20 {
> > +          compatible = "nxp,fxas21002c";
> > +          reg = <0x20>;
> > +
> > +          vdd-supply = <&reg_peri_3p15v>;
> > +          vddio-supply = <&reg_peri_3p15v>;
> > +        };
> > +    };
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 6594f0966716..2e85e114c9c3 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -12469,7 +12469,7 @@ NXP FXAS21002C DRIVER
> >  M:	Rui Miguel Silva <rmfrfs@gmail.com>
> >  L:	linux-iio@vger.kernel.org
> >  S:	Maintained
> > -F:	Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.txt
> > +F:	Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.yaml
> >  F:	drivers/iio/gyro/fxas21002c.h
> >  F:	drivers/iio/gyro/fxas21002c_core.c
> >  F:	drivers/iio/gyro/fxas21002c_i2c.c
> 
