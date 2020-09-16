Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54FFA26C8C8
	for <lists+linux-iio@lfdr.de>; Wed, 16 Sep 2020 20:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbgIPS4c (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Sep 2020 14:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727659AbgIPRyS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Sep 2020 13:54:18 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5994DC0A8885;
        Wed, 16 Sep 2020 05:39:50 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id lo4so10107624ejb.8;
        Wed, 16 Sep 2020 05:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I1cFEJyq7aWtTpGijIftYdHoOlrdR3OREnEePj95ylM=;
        b=APvHQtV42oDcvvxsC50ckX33r8XotGFDE9NjqI1448hod2JhlaAF/GMJVFpkCDoVb2
         kVBhUfrVrc5WemMXInUtCZlgBoYobDUOAidkcxPS1crEHg4XpuSDlPdUaB1oE6sdYE8d
         IT7hUouxai0VXiuESQXq840dfgoW6cFfCDQ3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I1cFEJyq7aWtTpGijIftYdHoOlrdR3OREnEePj95ylM=;
        b=TDMMZU1R+IQm2DzRbBSBrj3KA2HsDYCJzkzWgBqRuzhirCkyC3OHQ+9SNggiNhEAw8
         eC0aZnfRt4QUlUX6NUDtCEXLszojb8DVlb0IkhdfRYQNZQBf1Tu9Rr0joDX2JDcxJuAF
         D4MReyFI2movFIVL9Q6jFNWmT9J0GifZLXyqVsaZuTsyeDFwSewUJDG/vHiI/fsr/dND
         Jm3n8RpIdPLVqJGKvdm1lJaQTFCohgxWCVjokSz6/SueYcovf/03KATcpxIv6vAq6yhf
         mNUxl05qB60wPZwrt6g4PL64G/RNpKdLnT5y07wvM71h6L+6tNb7P9RIqv+6hCVzcGdV
         6uvA==
X-Gm-Message-State: AOAM532SlY7No2O5yfCRom/0VUWB4VZrtf6VYkX9dw/Oz5rhmLlAN++v
        tV8giqtEcxTmLALjoav/Mklnc8RrX0qBBQIiMYM=
X-Google-Smtp-Source: ABdhPJyJUdR1phUt4Z2aWUTlQ/9LFQhNTVdlh+azbLJjNikSb18UjVpmtluJLDsc3NTZBbHlpPnUIwhbkhOl5eJjepI=
X-Received: by 2002:a17:906:8401:: with SMTP id n1mr24459464ejx.215.1600259988623;
 Wed, 16 Sep 2020 05:39:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200909175946.395313-1-jic23@kernel.org> <20200909175946.395313-5-jic23@kernel.org>
 <CACPK8Xc+GpVVLvBdz5zHTndBeP0bd7SKLDZq7H6rDUDsd0kMdA@mail.gmail.com> <20200916113625.0000641e@Huawei.com>
In-Reply-To: <20200916113625.0000641e@Huawei.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 16 Sep 2020 12:39:36 +0000
Message-ID: <CACPK8Xdb2um+DN9q9P7o2AppYHenYoZ607r-s36BvZET=QCwiw@mail.gmail.com>
Subject: Re: [PATCH v2 04/20] dt-bindings:iio:adc: aspeed,ast2400 yaml conversion
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rick Altherr <raltherr@google.com>,
        Andrew Jeffery <andrew@aj.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 16 Sep 2020 at 10:38, Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Thu, 10 Sep 2020 02:32:19 +0000
> Joel Stanley <joel@jms.id.au> wrote:
>
> > On Wed, 9 Sep 2020 at 18:02, Jonathan Cameron <jic23@kernel.org> wrote:
> > >
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > >
> > > Simple txt to yaml conversion. Part of a general move to convert
> > > all the IIO bindings over to yaml.
> > >
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Cc: Rick Altherr <raltherr@google.com>
> > > Cc: Joel Stanley <joel@jms.id.au>
> > > Cc: Andrew Jeffery <andrew@aj.id.au>
> >
> > Acked-by: Joel Stanley <joel@jms.id.au>
> >
> >
> > > ---
> > >  .../bindings/iio/adc/aspeed,ast2400-adc.yaml  | 54 +++++++++++++++++++
> > >  .../bindings/iio/adc/aspeed_adc.txt           | 22 --------
> > >  2 files changed, 54 insertions(+), 22 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/iio/adc/aspeed,ast2400-adc.yaml b/Documentation/devicetree/bindings/iio/adc/aspeed,ast2400-adc.yaml
> > > new file mode 100644
> > > index 000000000000..09018487d690
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/adc/aspeed,ast2400-adc.yaml
> >
> > This naming doesn't make sense, as the bindings are for the ast2500
> > too (and they also apply for the ast2600).
>
> Convention is to name after a supported device and not use
> wild cards or generic names because the chances of it going
> wrong in future is far too high. Will every aspeed adc look the same?
> Seems impossible to predict so best we can do safely is to pick a
> part number.

It already supports three different generations of SoC, which I was
bringing to your attention. Therefore having the name '2400' is
already incorrect.

>
> There are enormous numbers of examples of this in dt bindings and
> for that matter driver naming.
>
> Thanks,
>
> Jonathan
>
>
> >
> > > @@ -0,0 +1,54 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/iio/adc/aspeed,ast2400-adc.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: ADC that forms part of an ASPEED server management processor.
> > > +
> > > +maintainers:
> > > +  - Rick Altherr <raltherr@google.com>
> > > +
> > > +description:
> > > +  This device is a 10-bit converter for 16 voltage channels.  All inputs are
> > > +  single ended.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - aspeed,ast2400-adc
> > > +      - aspeed,ast2500-adc
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  clocks:
> > > +    description:
> > > +      Input clock used to derive the sample clock. Expected to be the
> > > +      SoC's APB clock.
> > > +
> > > +  resets: true
> > > +
> > > +  "#io-channel-cells":
> > > +    const: 1
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - clocks
> > > +  - resets
> > > +  - "#io-channel-cells"
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/clock/aspeed-clock.h>
> > > +    adc@1e6e9000 {
> > > +        compatible = "aspeed,ast2400-adc";
> > > +        reg = <0x1e6e9000 0xb0>;
> > > +        clocks = <&syscon ASPEED_CLK_APB>;
> > > +        resets = <&syscon ASPEED_RESET_ADC>;
> > > +        #io-channel-cells = <1>;
> > > +    };
> > > +...
> > > diff --git a/Documentation/devicetree/bindings/iio/adc/aspeed_adc.txt b/Documentation/devicetree/bindings/iio/adc/aspeed_adc.txt
> > > deleted file mode 100644
> > > index 034fc2ba100e..000000000000
> > > --- a/Documentation/devicetree/bindings/iio/adc/aspeed_adc.txt
> > > +++ /dev/null
> > > @@ -1,22 +0,0 @@
> > > -Aspeed ADC
> > > -
> > > -This device is a 10-bit converter for 16 voltage channels.  All inputs are
> > > -single ended.
> > > -
> > > -Required properties:
> > > -- compatible: Should be "aspeed,ast2400-adc" or "aspeed,ast2500-adc"
> > > -- reg: memory window mapping address and length
> > > -- clocks: Input clock used to derive the sample clock. Expected to be the
> > > -          SoC's APB clock.
> > > -- resets: Reset controller phandle
> > > -- #io-channel-cells: Must be set to <1> to indicate channels are selected
> > > -                     by index.
> > > -
> > > -Example:
> > > -       adc@1e6e9000 {
> > > -               compatible = "aspeed,ast2400-adc";
> > > -               reg = <0x1e6e9000 0xb0>;
> > > -               clocks = <&syscon ASPEED_CLK_APB>;
> > > -               resets = <&syscon ASPEED_RESET_ADC>;
> > > -               #io-channel-cells = <1>;
> > > -       };
> > > --
> > > 2.28.0
> > >
>
>
