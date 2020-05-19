Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBA5D1D98D1
	for <lists+linux-iio@lfdr.de>; Tue, 19 May 2020 16:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729023AbgESOEB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 May 2020 10:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbgESOD7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 May 2020 10:03:59 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33403C08C5C0;
        Tue, 19 May 2020 07:03:59 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f13so3185483wmc.5;
        Tue, 19 May 2020 07:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9lcDor5zuXnF4Gt5fUGc93VK7uajZuFqXauDYxh+xvU=;
        b=vcdjK3k2Yu31tWyCb0XlH/8mWbhzY5PQqQUHeh74Dy/Rgz3kajkNV2d3f+RoLBjYEi
         HBhV5aM2mnBAO41vaMjjrXYexsuMlOsrjocWbhn/4JdUPVQahhLN95xZqT9KBi1qIW25
         Wj1DLLN86c8rlyjqh57jmJei8A1EelaLd4aezCXAkXZnCJYZnDhxVXJI5EP8+qusF3K2
         5JDCKqhuNmE1TEzCRLWA/O4UUMCs2ZWXccwteKzTdEcGcZ0OykESBbybVn7QN78M2soF
         yX1pG6UaCTWggVEahvtjNGJfcTqOeYn5hdDqgIEwZnhQ6B6vmyS2ugUHjp+CbcelVDmM
         3JMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9lcDor5zuXnF4Gt5fUGc93VK7uajZuFqXauDYxh+xvU=;
        b=cJ4HlI8XSHYYDBZFATHKP0/1twpw/E1uPlkZrXzohQvHwP/G/6YTlIjMlkrwWzaEId
         6CBJCquuPEsSVi8IU6ZBA4zjWaKrYg4uqVueo2OChNjwJvSsJ8e/trhOp+Vil2tN6q4a
         eiCcXO2tWYSate49nwrfq3jler8ivkmIV5U7eSiJYpTym4Byu+PNtT5dbzRsSqfCgY2q
         br9kdA+GGm67HAHm6XNV7Vq72g3+Zl2oWulQ2O9rRuN48T2WH9qaNFd0sBwM5avyFAF3
         m/qVGXqeKJRXHFNWKi78R74iCnymD8l/t/iGEZ79fB49hXXqNAidkbdCb6TzdZWOw+c3
         QXMA==
X-Gm-Message-State: AOAM533UIspogt6buiVPpq8cxtbhBMfJrVYwybqa/ysXI0fNYk7Dswbj
        V7p8HszvjQUcNpwLBiR5VZw=
X-Google-Smtp-Source: ABdhPJx6COI7v3FsV9jidXB6O2MZaPIvFJj9puOeFvnRZtYjlOw6pqgRPvc7JFgkqtUXy/nsSkBcSQ==
X-Received: by 2002:a05:600c:34c:: with SMTP id u12mr5657663wmd.4.1589897037683;
        Tue, 19 May 2020 07:03:57 -0700 (PDT)
Received: from ict14-OptiPlex-980 ([178.23.248.46])
        by smtp.gmail.com with ESMTPSA id r2sm21424457wrg.84.2020.05.19.07.03.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 May 2020 07:03:56 -0700 (PDT)
Date:   Tue, 19 May 2020 16:03:54 +0200
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jilayne Lovejoy <opensource@jilayne.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Steve Winslow <swinslow@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 1/4] dt-bindings: iio: magnetometer: ak8975: convert
 txt format to yaml
Message-ID: <20200519140354.GB30573@ict14-OptiPlex-980>
References: <20200519124402.26076-1-jonathan.albrieux@gmail.com>
 <20200519124402.26076-2-jonathan.albrieux@gmail.com>
 <20200519132207.GA4623@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519132207.GA4623@gerhold.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, May 19, 2020 at 03:22:07PM +0200, Stephan Gerhold wrote:
> On Tue, May 19, 2020 at 02:43:51PM +0200, Jonathan Albrieux wrote:
> > Converts documentation from txt format to yaml.
> > 
> > Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
> > ---
> >  .../bindings/iio/magnetometer/ak8975.txt      | 30 ---------
> >  .../bindings/iio/magnetometer/ak8975.yaml     | 66 +++++++++++++++++++
> >  2 files changed, 66 insertions(+), 30 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt
> >  create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/ak8975.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt b/Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt
> > deleted file mode 100644
> > index aa67ceb0d4e0..000000000000
> > --- a/Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt
> > +++ /dev/null
> > @@ -1,30 +0,0 @@
> > -* AsahiKASEI AK8975 magnetometer sensor
> > -
> > -Required properties:
> > -
> > -  - compatible : should be "asahi-kasei,ak8975"
> > -  - reg : the I2C address of the magnetometer
> > -
> > -Optional properties:
> > -
> > -  - gpios : should be device tree identifier of the magnetometer DRDY pin
> > -  - vdd-supply: an optional regulator that needs to be on to provide VDD
> > -  - mount-matrix: an optional 3x3 mounting rotation matrix
> > -
> > -Example:
> > -
> > -ak8975@c {
> > -        compatible = "asahi-kasei,ak8975";
> > -        reg = <0x0c>;
> > -        gpios = <&gpj0 7 0>;
> > -        vdd-supply = <&ldo_3v3_gnss>;
> > -        mount-matrix = "-0.984807753012208",  /* x0 */
> > -                       "0",                   /* y0 */
> > -                       "-0.173648177666930",  /* z0 */
> > -                       "0",                   /* x1 */
> > -                       "-1",                  /* y1 */
> > -                       "0",                   /* z1 */
> > -                       "-0.173648177666930",  /* x2 */
> > -                       "0",                   /* y2 */
> > -                       "0.984807753012208";   /* z2 */
> > -};
> > diff --git a/Documentation/devicetree/bindings/iio/magnetometer/ak8975.yaml b/Documentation/devicetree/bindings/iio/magnetometer/ak8975.yaml
> > new file mode 100644
> > index 000000000000..86e3efa693a8
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/magnetometer/ak8975.yaml
> > @@ -0,0 +1,66 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/magnetometer/ak8975.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: AsahiKASEI AK8975 magnetometer sensor
> > +
> > +maintainers:
> > +  - can't find a mantainer, author is Laxman Dewangan <ldewangan@nvidia.com>
> 
> Should probably add someone here, although I'm not sure who either.
> 

Yep I couldn't find a maintainer for that driver..what to do in this case?

> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - "asahi-kasei,ak8975"
> > +      - "ak8975"
> > +      - "asahi-kasei,ak8963"
> > +      - "ak8963"
> > +      - "asahi-kasei,ak09911"
> > +      - "ak09911"
> > +      - "asahi-kasei,ak09912"
> > +      - "ak09912"
> > +
> 
> I wonder if the ones without vendor prefix (asahi-kasei,) should be
> marked as deprecated somehow?
> 
> Looking at some other schemas I see either a "# deprecated" comment, or:
> 
> properties:
>   compatible:
>     oneOf:
>       - const: asahi-kasei,ak8975
>       - const: asahi-kasei,ak8963
>       - const: asahi-kasei,ak09911
>       - const: asahi-kasei,ak09912
>       - const: ak8975
>         deprecated: true
>       - const: ak8963
>         deprecated: true
>       - const: ak09911
>         deprecated: true
>       - const: ak09912
>         deprecated: true
> 
> (e.g. in Documentation/devicetree/bindings/sound/samsung,odroid.yaml)
> I guess this one is preferred since it allows parsing those
> compatibles as deprecated?
> 

Ok I'll work on it

> > +  reg:
> > +    maxItems: 1
> > +    description: the I2C address of the magnetometer
> > +
> > +  gpios:
> > +    description: should be device tree identifier of the magnetometer DRDY pin
> > +
> > +  vdd-supply:
> > +    maxItems: 1
> > +    description: |
> > +      an optional regulator that needs to be on to provide VDD power to
> > +      the sensor.
> > +
> > +  mount-matrix:
> > +    description: an optional 3x3 mounting rotation matrix
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +examples:
> > +  - |
> > +    i2c@78b7000 {
> > +        reg = <0x78b6000 0x600>;
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        ak8975@c {
> 
> Per device tree specification this should preferably use a generic name
> describing the function of the device, i.e. magnetometer@c.
> 
> > +            compatible = "asahi-kasei,ak8975";
> > +            reg = <0x0c>;
> > +            gpios = <&gpj0 7 0>;
>

Yes it would be better, I'll work on that too
 
> I think using the dt-bindings constants for the GPIO flags is preferred
> now, i.e. gpios = <&gpj0 7 GPIO_ACTIVE_HIGH>.
> 
> > +            vdd-supply = <&ldo_3v3_gnss>;
> > +            mount-matrix = "-0.984807753012208",  /* x0 */
> > +                           "0",                   /* y0 */
> > +                           "-0.173648177666930",  /* z0 */
> > +                           "0",                   /* x1 */
> > +                           "-1",                  /* y1 */
> > +                           "0",                   /* z1 */
> > +                           "-0.173648177666930",  /* x2 */
> > +                           "0",                   /* y2 */
> > +                           "0.984807753012208";   /* z2 */
> > +        };
> > +    };
> > -- 
> > 2.17.1

Thank you for having took the time to review, will work on edits right now.
I just have a question: by creating the new patchset how can I deal with
the "Reviewed by"? It's the first patch I submit and still haven't dealt
with the full process,

Best regards,
Jonathan Albrieux
