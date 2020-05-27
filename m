Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9E011E4758
	for <lists+linux-iio@lfdr.de>; Wed, 27 May 2020 17:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729448AbgE0PaL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 27 May 2020 11:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729416AbgE0PaL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 27 May 2020 11:30:11 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0968AC05BD1E;
        Wed, 27 May 2020 08:30:11 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id h9so9256963qtj.7;
        Wed, 27 May 2020 08:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zkunrZ0oeTCMztxG/OegBl2pml7XGAS8duP4C52EX6I=;
        b=Oap9h53IlxWOHi0RDCE66AdYN29wfAsbfyk1QJ8LaluzX9rvKMepwlSxjc73mIDafz
         70p2spgj38vRS+A7COVFSdEnfquX4eT2K1O+d9J5DHQsDd42rCDKqkvBpPZJoPL0oM+8
         eFsL1Kuklf2RdebuF6n8QOK76x6Rx5oQn7ITcZdgt7v7vLgXQIJalvgup7hOwdVPebRK
         jWpSbb7AFjdj5pA9koQuF6Umyp3MisLlDy4qw5QuUd4AcckwSIGvuy6ssY/Rf4R/zg1L
         SGO4P/6OFpvNxXznbm4ydRYLwBTlnzyO4qmfpQNj5y8gUsXVOP02M7EzPkZweaDWwjb/
         Cz3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zkunrZ0oeTCMztxG/OegBl2pml7XGAS8duP4C52EX6I=;
        b=qszY34hWm1gjn1UrBD5YFVOkqDj+V0DG1zT64cXbREbKsoILhdiQ1EchoyYi4T88Ao
         zAuZ5egL9Q1xrvlU6mLtp3PUbD6AVjy55S9JUUz5OLe+cnMHXmCYscXLSPAbSBVvXOyv
         3D064SUZ46cSRy95fI558GEh/FZwPAEOaMxl1tMBzrZos3TzOARn1Sn2ITh8K50mAwSt
         O6Sl8xXjjrv/S9vwEAok/YJ2L9yUoxBZRL/I3CHGF7ku1YA5eJAsgKbDTuxK0LiEy+go
         GT456IPNFzxb6gQ+3shU/emu2asHxNaT9CB5lK1WnngHmsHAEdG0SzPXrMC6RQI6lLdu
         JTvw==
X-Gm-Message-State: AOAM532A0jhEat4upnDmOLJsNcCB/p+PTsO8Y6KrMGWqjMyKyBsxync8
        Kc9wUxcF+pIxmasuf43tpFg=
X-Google-Smtp-Source: ABdhPJy7Aid9jgwaunjEzd/i0WniQ3PXIiToFKc9WwZdimCPt06wxXiwafiDs+QXwN+BKXf7pwycGA==
X-Received: by 2002:ac8:710f:: with SMTP id z15mr4782320qto.71.1590593409980;
        Wed, 27 May 2020 08:30:09 -0700 (PDT)
Received: from ict14-OptiPlex-980 ([178.23.248.46])
        by smtp.gmail.com with ESMTPSA id c186sm1744441qkd.102.2020.05.27.08.30.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 May 2020 08:30:09 -0700 (PDT)
Date:   Wed, 27 May 2020 17:29:58 +0200
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v6 2/5] dt-bindings: iio: magnetometer: ak8975: convert
 format to yaml, add maintainer
Message-ID: <20200527152958.GA21548@ict14-OptiPlex-980>
References: <20200525151117.32540-1-jonathan.albrieux@gmail.com>
 <20200525151117.32540-3-jonathan.albrieux@gmail.com>
 <20200526222847.GA492828@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526222847.GA492828@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, May 26, 2020 at 04:28:47PM -0600, Rob Herring wrote:
> On Mon, May 25, 2020 at 05:10:36PM +0200, Jonathan Albrieux wrote:
> > Converts documentation from txt format to yaml.
> 
> I would have converted to yaml and do any re-formatting/wording, then 
> added 'interrupts', but this is fine.
>

Thank you, I'll keep that in mind for future works like this one
 
> 
> > Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
> > ---
> >  .../bindings/iio/magnetometer/ak8975.txt      | 37 ---------
> >  .../iio/magnetometer/asahi-kasei,ak8975.yaml  | 78 +++++++++++++++++++
> >  2 files changed, 78 insertions(+), 37 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt
> >  create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt b/Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt
> > deleted file mode 100644
> > index 0576b9df0bf2..000000000000
> > --- a/Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt
> > +++ /dev/null
> > @@ -1,37 +0,0 @@
> > -* AsahiKASEI AK8975 magnetometer sensor
> > -
> > -Required properties:
> > -
> > -  - compatible : should be "asahi-kasei,ak8975".
> > -  - reg : the I2C address of the magnetometer.
> > -
> > -Optional properties:
> > -
> > -  - gpios : AK8975 has a "Data ready" pin (DRDY) which informs that data
> > -      is ready to be read and is possible to listen on it. If used,
> > -      this should be active high. Prefer interrupt over this.
> > -
> > -  - interrupts : interrupt for DRDY pin. Triggered on rising edge.
> > -
> > -  - vdd-supply: an optional regulator that needs to be on to provide VDD.
> > -
> > -  - mount-matrix: an optional 3x3 mounting rotation matrix.
> > -
> > -Example:
> > -
> > -ak8975@c {
> > -        compatible = "asahi-kasei,ak8975";
> > -        reg = <0x0c>;
> > -        interrupt-parent = <&gpio6>;
> > -        interrupts = <15 IRQ_TYPE_EDGE_RISING>;
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
> > diff --git a/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml b/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml
> > new file mode 100644
> > index 000000000000..a603659d5fa5
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml
> > @@ -0,0 +1,78 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/magnetometer/asahi-kasei,ak8975.yaml#
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
> 
> These 4 can be an enum.
> 
> > +      - const: ak8975
> > +        deprecated: true
> > +      - const: ak8963
> > +        deprecated: true
> > +      - const: ak09911
> > +        deprecated: true
> > +      - const: ak09912
> > +        deprecated: true
> 
> And these 4 can be an enum+deprecated.
> 
> > +
> > +  reg:
> > +    maxItems: 1
> > +    description: the I2C address of the magnetometer.
> 
> Don't need a description.
> 
> > +
> > +  gpios:
> > +    description: |
> > +      AK8975 has a "Data ready" pin (DRDY) which informs that data
> > +      is ready to be read and is possible to listen on it. If used,
> > +      this should be active high. Prefer interrupt over this.
> 
> Need to define how many GPIOs (maxItems: 1).
> 

Ok, I'll edit those fields as soon as possible, thank you,

Best regards,
Jonathan Albrieux

> > +
> > +  interrupts:
> > +    maxItems: 1
> > +    description: interrupt for DRDY pin. Triggered on rising edge.
> > +
> > +  vdd-supply:
> > +    maxItems: 1
> > +    description: |
> > +      an optional regulator that needs to be on to provide VDD power to
> > +      the sensor.
> > +
> > +  mount-matrix:
> > +    description: an optional 3x3 mounting rotation matrix.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    i2c {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        magnetometer@c {
> > +            compatible = "asahi-kasei,ak8975";
> > +            reg = <0x0c>;
> > +            interrupt-parent = <&gpio6>;
> > +            interrupts = <15 IRQ_TYPE_EDGE_RISING>;
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
> > 
