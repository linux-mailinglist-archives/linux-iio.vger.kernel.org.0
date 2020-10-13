Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70F0428DCF3
	for <lists+linux-iio@lfdr.de>; Wed, 14 Oct 2020 11:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730100AbgJNJVa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Oct 2020 05:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731021AbgJNJUl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Oct 2020 05:20:41 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40CB4C0613AD;
        Tue, 13 Oct 2020 14:48:04 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id k18so323188wmj.5;
        Tue, 13 Oct 2020 14:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Cf/2LCRyAMRbcaDzf9AIVU7Z6vJ2ASIscMc2CZHmFAk=;
        b=gEUVPgjnrupJGyV0+mkYMHSJMApDk+kJHMrUJIcXV8tSh0nS4wkYiTYy+aL9lRNWe8
         O1qY+KqCrV0vkxtgaKk22Fm+Wh4jlny2xqVVd/toY8N7cVrt/e0/+ffjkvUNxHtanDoA
         T90NcqNXgwCNIoiqdbVr21EDnJcomYfU95qN2zFw4Z8txbkIySjULcxZzRbez+K/il/H
         JGx2vtJObzbyCQ9SA+Vju0mOx80I+B1mbvqCC264rAWqpXq5i8iU9bAacWG4gUhGUm86
         7PBPZgm8UiVNzUoXqbXVUScz/Lzu2Y17baR1QxYPnPhzXsg4LHTEFlILQe0H+CxLQmls
         /RVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Cf/2LCRyAMRbcaDzf9AIVU7Z6vJ2ASIscMc2CZHmFAk=;
        b=YvumSV/MTtpBAUuZZQtS7C+e0yjwbj6Lxzw2slh9Re7zFTGBlkh07+KPM13DX3+AyU
         7kaDynhDtE/QjMnDWxm4K9iq92vMZKYK0vE8+SXi4Q66FD4WR47j3ftkexgxTaU0RyKb
         uplNsIYnqX9wSwJntnGxD1qbZiiU94MVYG2NTeTGOGCSOlTcY363t8+tuHs0IWc2aEhT
         CEcV1SBUGEoBQP8rcUomluWFr+STW4MdbhtqnZsS2O5b1nz/HnDNE5kS3VAnNggG2WIE
         l6wqjl9wUARnGbkcBlHjM4TnKveYPk0l7o9riP+0+ftZyCMY3FMlXPqRnA8WxG5+U8aQ
         RWKg==
X-Gm-Message-State: AOAM533cxZ+r+QgKTxBLw7x7yllODmnfuiDiQk+xYrSGVU72uQiCMcLh
        em9ULckLMGaGaJBNQSFvhNs=
X-Google-Smtp-Source: ABdhPJzk73YWTNVAYynl3r3EGB3/lf48TNRLXfaXUN45Jx6CQ+8NsolFS+lKsAqhBunf0/pX+MsPQg==
X-Received: by 2002:a1c:2187:: with SMTP id h129mr322311wmh.51.1602625681956;
        Tue, 13 Oct 2020 14:48:01 -0700 (PDT)
Received: from arch-thunder.localdomain (a109-49-46-234.cpe.netcabo.pt. [109.49.46.234])
        by smtp.gmail.com with ESMTPSA id v17sm1371130wrc.23.2020.10.13.14.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 14:48:00 -0700 (PDT)
Date:   Tue, 13 Oct 2020 22:47:58 +0100
From:   Rui Miguel Silva <rmfrfs@gmail.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: fxas21002c: convert bindings to yaml
Message-ID: <20201013214758.imirylgu2p6hc54r@arch-thunder.localdomain>
References: <20201013131545.503434-1-rmfrfs@gmail.com>
 <20201013153431.000052c9@huawei.com>
 <20201013205403.6tni6zi7bfg7ogye@arch-thunder.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013205403.6tni6zi7bfg7ogye@arch-thunder.localdomain>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,
forgot the link bellow...

On Tue, Oct 13, 2020 at 09:54:06PM +0100, Rui Miguel Silva wrote:
> Hi Jonathan,
> On Tue, Oct 13, 2020 at 04:34:31PM +0100, Jonathan Cameron wrote:
> > On Tue, 13 Oct 2020 14:15:45 +0100
> > Rui Miguel Silva <rui.silva@linaro.org> wrote:
> > 
> > > Convert fxas21002c gyroscope sensor bindings documentation to
> > > yaml schema and remove the textual bindings document.
> > > 
> > > Signed-off-by: Rui Miguel Silva <rmfrfs@gmail.com>
> > 
> > Hi Rui,
> > 
> > Always good to see a yaml conversion.
> > 
> > Comments inline...
> 
> Thanks for the review, I will address all your comments, just a small
> note bellow regarding the unevaluatedProperties.
> 
> > 
> > > ---
> > >  .../bindings/iio/gyroscope/nxp,fxas21002c.txt | 31 --------
> > >  .../iio/gyroscope/nxp,fxas21002c.yaml         | 77 +++++++++++++++++++
> > >  MAINTAINERS                                   |  2 +-
> > >  3 files changed, 78 insertions(+), 32 deletions(-)
> > >  delete mode 100644 Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.txt
> > >  create mode 100644 Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.txt b/Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.txt
> > > deleted file mode 100644
> > > index 465e104bbf14..000000000000
> > > --- a/Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.txt
> > > +++ /dev/null
> > > @@ -1,31 +0,0 @@
> > > -* NXP FXAS21002C Gyroscope device tree bindings
> > > -
> > > -http://www.nxp.com/products/sensors/gyroscopes/3-axis-digital-gyroscope:FXAS21002C
> > > -
> > > -Required properties:
> > > -  - compatible : should be "nxp,fxas21002c"
> > > -  - reg : the I2C address of the sensor or SPI chip select number for the
> > > -          device.
> > > -  - vdd-supply: phandle to the regulator that provides power to the sensor.
> > > -  - vddio-supply: phandle to the regulator that provides power to the bus.
> > > -
> > > -Optional properties:
> > > -  - reset-gpios : gpio used to reset the device, see gpio/gpio.txt
> > > -  - interrupts : device support 2 interrupts, INT1 and INT2,
> > > -                 the interrupts can be triggered on rising or falling edges.
> > > -                 See interrupt-controller/interrupts.txt
> > > -  - interrupt-names: should contain "INT1" or "INT2", the gyroscope interrupt
> > > -                     line in use.
> > > -  - drive-open-drain: the interrupt/data ready line will be configured
> > > -                      as open drain, which is useful if several sensors share
> > > -                      the same interrupt line. This is a boolean property.
> > > -                      (This binding is taken from pinctrl/pinctrl-bindings.txt)
> > > -
> > > -Example:
> > > -
> > > -gyroscope@20 {
> > > -	compatible = "nxp,fxas21002c";
> > > -	reg = <0x20>;
> > > -	vdd-supply = <&reg_peri_3p15v>;
> > > -	vddio-supply = <&reg_peri_3p15v>;
> > > -};
> > > diff --git a/Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.yaml b/Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.yaml
> > > new file mode 100644
> > > index 000000000000..7680e97cf1d9
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.yaml
> > > @@ -0,0 +1,77 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/iio/gyroscope/nxp,fxas21002c.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: NXP FXAS21002C Gyroscope Unit
> > 
> > Why Unit? Gyroscope seems fine to me.
> > 
> > > +
> > > +maintainers:
> > > +  - Rui Miguel Silva <rmfrfs@gmail.com>
> > > +
> > > +description: |
> > > +  3 axis digital gyroscope device with an I2C and SPI interface.
> > 
> > Can we document the SPI binding as well?  With an example.
> > 
> > > +  http://www.nxp.com/products/sensors/gyroscopes/3-axis-digital-gyroscope:FXAS21002C
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - nxp,fxas21002c
> > 
> > Unless we think it likely this binding is going to shortly include other options,
> >        const: nxp... 
> > (doesn't matter that much though!)
> > 
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +    description: base address of the device
> > 
> > No it isn't. It is the i2c address. Also this is standard so no description needed.
> > 
> > 
> > > +
> > > +  vdd-supply:
> > > +    description: Regulator that provides power to the sensor
> > > +
> > > +  vddio-supply:
> > > +    description: Regulator that provides power to the bus
> > > +
> > > +  reset-gpios:
> > > +    maxItems: 1
> > > +    description: GPIO connected to reset
> > > +
> > > +  interrupts:
> > > +    minItems: 1
> > > +    maxItems: 2
> > > +    description: device support 2 interrupts,
> > I'd argue that's obvious from the maxItems. So no need to repeat it.
> > 
> > 
> >  INT1 and INT2,
> > This part is clear form interrupt-names so again, I wouldn't say it again.
> > 
> >  the interrupts can
> > > +                 be triggered on rising or falling edges.
> > This last bit is useful so I would have just this or something like
> > 
> > Either interrupt may be triggered on rising or falling edges.
> > 
> > > +
> > > +  interrupt-names:
> > > +    minItems: 1
> > > +    maxItems: 2
> > > +    items:
> > > +      enum:
> > > +        - INT1
> > > +        - INT2
> > > +    description: gyroscope interrupt line in use.
> > 
> > Singular with 2 interrupts.  Personally I'd just drop the description as not
> > adding anything.
> > 
> > > +
> > > +  drive-open-drain:
> > > +    type: boolean
> > > +    description: the interrupt/data ready line will be configured as open drain,
> > > +                 which is useful if several sensors share the same interrupt
> > > +                 line.
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - vdd-supply
> > 
> > Why required?  If it's hard wired on will a stub regulator not work fine
> > with this device.  Do we need to read it's voltage or similar?
> > 
> > > +  - vddio-supply
> > > +
> > > +unevaluatedProperties: false
> > 
> > Why unevalutatedProperties rather than additionalProperties?
> > I'll confess I don't really understand when to use unevaluatedProperties.
> 
> Yeah, it is not very clear also to me, I was just following this
> clean up series from Rob, and from my understanding here is a case for

here is the missing link to the clean up series:
https://lkml.kernel.org/lkml/20201006100036.00007ec7@Huawei.com/T/

Cheers,
   Rui

> unevaluatedProperties. But maybe I got it all wrong.
> 
> Cheers,
>    Rui
> 
> > I'm guessing issue here is we don't have the SPI bindings stuff?
> > 
> > > +
> > > +examples:
> > > +  - |
> > > +    i2c0 {
> > > +        #address-cells = <1>;
> > > +        #size-cells = <0>;
> > > +
> > > +        gyroscope@20 {
> > > +          compatible = "nxp,fxas21002c";
> > > +          reg = <0x20>;
> > > +
> > > +          vdd-supply = <&reg_peri_3p15v>;
> > > +          vddio-supply = <&reg_peri_3p15v>;
> > > +        };
> > > +    };
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 6594f0966716..2e85e114c9c3 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -12469,7 +12469,7 @@ NXP FXAS21002C DRIVER
> > >  M:	Rui Miguel Silva <rmfrfs@gmail.com>
> > >  L:	linux-iio@vger.kernel.org
> > >  S:	Maintained
> > > -F:	Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.txt
> > > +F:	Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.yaml
> > >  F:	drivers/iio/gyro/fxas21002c.h
> > >  F:	drivers/iio/gyro/fxas21002c_core.c
> > >  F:	drivers/iio/gyro/fxas21002c_i2c.c
> > 
