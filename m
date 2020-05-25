Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D74FB1E0855
	for <lists+linux-iio@lfdr.de>; Mon, 25 May 2020 10:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbgEYIAJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 May 2020 04:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgEYIAI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 May 2020 04:00:08 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695A7C061A0E;
        Mon, 25 May 2020 01:00:08 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id o19so13227725qtr.10;
        Mon, 25 May 2020 01:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NJ+47DGF4F7WkxRuE7XbnET8amEXakvg2qvuPXqV+bc=;
        b=IYONpDTKettYmDhqMJhb7Ox5XeVZb1uAKYiuqqsqEUmfQ+dUaquV1srNl6SpRlgOQD
         WgDdFTMZXwenxvFX5oSAJtGZVejLes46s8WcT9F6qePaAaV1Z6SktriPZUMHFAFoToFr
         2U2CdaYm3GuDeTcpj7ZgbjiO1aNV5P/mq4fZCfX05c666wAiaPQ3M5Hsj9qRO1VFKwD0
         oNfbABfmtu0u5Fq7J6gJSzZkzpU0svIj6AFs7N0gGMeXD5m9sRvClm9kKOMlHa1caxqm
         UfPsR4TEL966UCUG1UFtR+fXkFj/0mpnmUqtxQvNJtBPTlOOp3JUoTKgk+5MpuYheoW7
         BkBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NJ+47DGF4F7WkxRuE7XbnET8amEXakvg2qvuPXqV+bc=;
        b=g1ACOBhpgNGerOsQE2Z/PsvYN5TPZxdLwsw8Sw9o4SuSWqx8ivFlPT39n/m2RvqIcn
         sxj619aXkQFb+FH8L/Asyh1MpNa5vL6+eGhXDvOg9ftCAHyMMNsmaL+nnZ3tncCyfzwy
         OvC6kJPIgIq8YOST0oaqGedww+UvINRb6CoybGFummnL2ZKHzY72yhQF0Ft8PoyR57s6
         sZEE7IhDJTVhpgYNyt5HDJua6/F4IR74Xb+nmnk52nQvb4mXsRGw7+hJVmza7tEimUSO
         ImAFq2O9ntWyjERoIYPuqGlmLv0Fd50i8xBjdRDBiTbeotvYIThzuHZhWZy/6UR0LP5R
         zepA==
X-Gm-Message-State: AOAM5322NSktahj7W2wAPXxXHF3xSFwdLkPXZEGIOWlnM9LlmTyg4YKd
        5AfIG1zORc2P3B7Rl1wU+fE=
X-Google-Smtp-Source: ABdhPJxY8rGTlDu2XF5c4RFmtUcFN65rMM+uRtE79oNS5H4P0S0EKyJa2Mc+uwX8b2Aw5ZHD7z4mOw==
X-Received: by 2002:ac8:7383:: with SMTP id t3mr604816qtp.221.1590393607166;
        Mon, 25 May 2020 01:00:07 -0700 (PDT)
Received: from ict14-OptiPlex-980 ([178.23.248.46])
        by smtp.gmail.com with ESMTPSA id c3sm14271395qtp.24.2020.05.25.01.00.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 May 2020 01:00:06 -0700 (PDT)
Date:   Mon, 25 May 2020 10:00:01 +0200
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
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
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v5 1/4] dt-bindings: iio: magnetometer: ak8975: convert
 format to yaml, add maintainer
Message-ID: <20200525080001.GC18690@ict14-OptiPlex-980>
References: <20200520163417.27805-1-jonathan.albrieux@gmail.com>
 <20200520163417.27805-2-jonathan.albrieux@gmail.com>
 <20200524155745.3b9320db@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200524155745.3b9320db@archlinux>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, May 24, 2020 at 03:57:45PM +0100, Jonathan Cameron wrote:
> On Wed, 20 May 2020 18:34:06 +0200
> Jonathan Albrieux <jonathan.albrieux@gmail.com> wrote:
> 
> > Converts documentation from txt format to yaml.
> > 
> > Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
> 
> An additional request inline.  Doesn't effect this patch 'as such'.
> 
> Also the file name thing just below here.
> 
> > ---
> >  .../bindings/iio/magnetometer/ak8975.txt      | 30 --------
> >  .../bindings/iio/magnetometer/ak8975.yaml     | 71 +++++++++++++++++++
> File naming should match the compatible.
> 
> ashahi-kasei,ak8975.yaml
>

Ok, I'll take this as general rule then :-)
 
> >  2 files changed, 71 insertions(+), 30 deletions(-)
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
> > index 000000000000..8bde423a2ffa
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/magnetometer/ak8975.yaml
> > @@ -0,0 +1,71 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/magnetometer/ak8975.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: AsahiKASEI AK8975 magnetometer sensor
> > +
> > +maintainers:
> > +  - Jonathan Albrieux <jonathan.albrieux@gmail.com>
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - const: asahi-kasei,ak8975
> > +      - const: asahi-kasei,ak8963
> > +      - const: asahi-kasei,ak09911
> > +      - const: asahi-kasei,ak09912
> > +      - const: ak8975
> > +        deprecated: true
> > +      - const: ak8963
> > +        deprecated: true
> > +      - const: ak09911
> > +        deprecated: true
> > +      - const: ak09912
> > +        deprecated: true
> > +
> > +  reg:
> > +    maxItems: 1
> > +    description: the I2C address of the magnetometer
> > +
> > +  gpios:
> > +    description: should be device tree identifier of the magnetometer DRDY pin
> 
> Nothing to do with your patch obviously but this is horrible...
> + the driver will quite happily take an interrupt instead.
> 
> Do you mind documenting the interrupt here as well?
> 
> Should be a separate patch though.  So a follow up one to
> this one.  The 
> arch/arm/boot/dts/motorola-mapphone-common.dtsi
> does it that way, unlike the samsung s3 which uses the gpio
> binding (I think it's the only one against quite a few
> using interrupts).
> 
> Also switch the example to an interrupts one so we don't
> encourage anyone to go the gpios route.
> 
> Note can be a follow up if this series is otherwise ready to go.
> 

Oh ok, will add a new patch for that in this series if you don't
mind. It may even be better to split this series in two given
the amount of changes to the documentation outnumbered the changes
related to the driver itself, the first one regarding just the
conversion to yaml and clean-up-related changes to documentation
and the second one, depending on the first one, with the
reset-related changes.

Do you have advices on which of the two should be the best strategy?

I'll prepare both the versions today in order to choose the right
one once the path to follow has been decided,

Thank you,

Best regards,
Jonathan Albrieux

> 
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
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    i2c@78b7000 {
> > +        reg = <0x78b6000 0x600>;
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        magnetometer@c {
> > +            compatible = "asahi-kasei,ak8975";
> > +            reg = <0x0c>;
> > +            gpios = <&gpj0 7 GPIO_ACTIVE_HIGH>;
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
> 
