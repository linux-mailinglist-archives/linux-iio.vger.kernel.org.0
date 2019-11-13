Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC067FB5F0
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2019 18:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbfKMRG7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 13 Nov 2019 12:06:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:35934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727638AbfKMRG7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 13 Nov 2019 12:06:59 -0500
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30DCB206D9;
        Wed, 13 Nov 2019 17:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573664817;
        bh=3pA/KHI5sE+m79lcOcQ98rIbIxyybLCXDOI9joKhQfs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TwOWVIvSoknGvfV8g68WQy7A/iminy0BlIzADGjPqtO1Wy1PopzGyTjMWGo2UpuPM
         TmbRo1ddgr08OXsgScXLTJZm3P5bLeFm7O32ywjUErxrEelMmpfSUUFMP+nK6X2uif
         I8SQPZP3KOwo2gSIb2hB/R9g7ZcEK5w1uwOSy4Eg=
Received: by mail-qk1-f171.google.com with SMTP id e2so2386357qkn.5;
        Wed, 13 Nov 2019 09:06:58 -0800 (PST)
X-Gm-Message-State: APjAAAVkYNLmGOdLwtjxADfDqE9uMU6ay53VbYXg/23x+gR5R9F6qfgd
        q8NmJ7xyd18ivHuNKFIfDrAep9Ky7j99CvxlzA==
X-Google-Smtp-Source: APXvYqzRlmF9TeJ9hDMYOQGNIdfY5VhEdyxfYQraKHmCjaj33WSKpBhDL2bHJvGdOc3QzkjC5v8NL/rqmH6i8piI88A=
X-Received: by 2002:a37:4904:: with SMTP id w4mr3196213qka.119.1573664817154;
 Wed, 13 Nov 2019 09:06:57 -0800 (PST)
MIME-Version: 1.0
References: <cover.1573145089.git.marcelo.schmitt1@gmail.com>
 <a8c614894252bb139a213b8c0219f3f46210b136.1573145089.git.marcelo.schmitt1@gmail.com>
 <20191112193942.GA27334@bogus> <20191113145159.vw7icflfve7dnefm@smtp.gmail.com>
In-Reply-To: <20191113145159.vw7icflfve7dnefm@smtp.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 13 Nov 2019 11:06:45 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJY6YMC2ba4DNFnsq=XESOoUTDA6Q+Y7gutMT0VN--DNw@mail.gmail.com>
Message-ID: <CAL_JsqJY6YMC2ba4DNFnsq=XESOoUTDA6Q+Y7gutMT0VN--DNw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: adc: Add dt-schema for AD7292
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Dragos Bogdan <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org, kernel-usp@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Nov 13, 2019 at 8:52 AM Marcelo Schmitt
<marcelo.schmitt1@gmail.com> wrote:
>
> Hi Rob,
>
> Thanks for reviewing the binding doc again.
> Aparently, this patch was added to Greg KH's staging tree.
> What is the right procedure in this case? Should I send a v5 patchset or
> just send a patch for this doc?

You need to do an incremental patch. Greg doesn't rebase.

> In any case, I still have some doubts about the maximum constraint of
> the channel property. Comments inline.
>
>
> Thanks
>
> Marcelo
>
> On 11/12, Rob Herring wrote:
> > On Fri, Nov 08, 2019 at 10:56:09AM -0300, Marcelo Schmitt wrote:
> > > Add a devicetree schema for AD7292 monitor and control system.
> > >
> > > Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> > > ---
> > > Changelog V3 -> V4:
> > > - updated SPDX identifier to GPL-2.0-only
> > > - changed maxitems constraint on channel property
> > >
> > >  .../bindings/iio/adc/adi,ad7292.yaml          | 104 ++++++++++++++++++
> > >  MAINTAINERS                                   |   7 ++
> > >  2 files changed, 111 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
> > > new file mode 100644
> > > index 000000000000..b68be3aaf587
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
> > > @@ -0,0 +1,104 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only
> >
> > Sigh, I gave you the exact line to use:
> >
> > # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >
> > I've said to dual license with (GPL-2.0-only OR BSD-2-Clause) and people
> > think I mean to pick one. So now I just give the whole line. I don't
> > know how to be clearer.
>
> I thought I could use just GPL-2.0 since the driver code is GPL-2.0.
> Anyway, I'll use the above line to specify the dt-binding license.
>
> >
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/iio/adc/adi,ad7292.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Analog Devices AD7292 10-Bit Monitor and Control System
> > > +
> > > +maintainers:
> > > +  - Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> > > +
> > > +description: |
> > > +  Analog Devices AD7292 10-Bit Monitor and Control System with ADC, DACs,
> > > +  Temperature Sensor, and GPIOs
> > > +
> > > +  Specifications about the part can be found at:
> > > +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7292.pdf
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - adi,ad7292
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  vref-supply:
> > > +    description: |
> > > +      The regulator supply for ADC and DAC reference voltage.
> > > +
> > > +  spi-cpha: true
> > > +
> > > +  '#address-cells':
> > > +    const: 1
> > > +
> > > +  '#size-cells':
> > > +    const: 0
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - spi-cpha
> > > +
> > > +patternProperties:
> > > +  "^channel@[0-7]$":
> > > +    type: object
> > > +    description: |
> > > +      Represents the external channels which are connected to the ADC.
> > > +      See Documentation/devicetree/bindings/iio/adc/adc.txt.
> > > +
> > > +    properties:
> > > +      reg:
> > > +        description: |
> > > +          The channel number. It can have up to 8 channels numbered from 0 to 7.
> > > +        items:
> > > +          maximum: 7
> >
> > Not what I said either. A slight but important difference in that you
> > are missing a '-' to make 'items' a list rather than a schema/dict.
> >
> > Update dt-schema. This should give a warning now.
>
> I'm confused, I don't know how to make this doc the way you want.
> I pulled the updates from the master branch of dt-schema repo and
> reinstalled it.
> Then I tried
>         items:
>           - maximum: 7
> I've tried
>         - items:
>             maximum: 7
> I also tried
>         - items:
>           maximum: 7
> all gave me parsing errors when processing the ad7292 schema with
> 'make dt_binding_check' and also with 'make -k dt_binding_check'.
> Am I using the right branch? Should I pull from a branch other than the
> master?

Sorry, my fault there. The meta-schema requires 'minimum' if you give
'maximum'. So:

        items:
          - minimum: 0
            maximum: 7

The error message was less than useful, but I think I have a fix for that too.

Rob
