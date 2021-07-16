Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8C9D3CBA0D
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jul 2021 17:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233725AbhGPPsi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 16 Jul 2021 11:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233204AbhGPPsh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 16 Jul 2021 11:48:37 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F340AC06175F;
        Fri, 16 Jul 2021 08:45:41 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id v189so15548518ybg.3;
        Fri, 16 Jul 2021 08:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TmGtfXcEfmcsiInayOUzlaiGBIdzTctRIERqciUlYfQ=;
        b=UYcObK6xebXx84OK9OBDF+mSaXR0uEj7xkWvn/A2OdPkTN9rvA46hyJuUXmKajH2P2
         uCPT5QmgXQmctAJZcYefcni/UK0ygJzUFdbNjDl4UDll7tyrJTyk7xBP4ZrgyWEeIk0p
         Yc6IYrT1EQFmXyVLPMnO1IFdptb/9x9VqtQmHjMTjLRYdRiCJTKAWKXrPSx6TsJOVtmW
         969cykFUf33yVYzxehT+9wtOeHqcb517N/Au/66SZfrl3lb+mmylkDqzlgCBpGoSUBuH
         O06XzApUdzrwl/ahV7lO3IPw74A1qlXn8UYX63GbkyavCanuj0I5A/FfS0hyuSMQKFG/
         +YOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TmGtfXcEfmcsiInayOUzlaiGBIdzTctRIERqciUlYfQ=;
        b=ffqPJTDzG8feIgKjHdqjUsSOjGJ6/pv/iTv31p7qpNNqhxgv8mgYe2PgxQuHO/cFeR
         c/iwdnUG8ZSwqfVzUc7Qrm4XiO80qKvV4uuxqiXIgAOONHzebwPVvg+18Qk3nu/zAeDg
         vwmp+IPxTK8+H/SV4sho2+scbC2UZZr4kDzvHDFqYqbgGfBC0siFOqp4hMzM4N8Z7e2P
         RInKkI+OtnbvMw7vB53CgyZppM1zHM/NEONahXJIMfteNtRsWB6cLhDoGMkzaPZDtP9o
         G+mq3ZeC7Nb71HFeTKm/zLAJ5wxWTdAOA3Qo0LNqrBTFYGkXpg2Ng1LYZ1vm09azvPev
         wLFA==
X-Gm-Message-State: AOAM533rwMSw60X+HrHiEHQHI+KOQ8QcrpfVhnfZEMwqywMdGy0n4cHo
        JMGi1y0piJB7Qu2f4YtOrAUewdRyVVureiQ4j7s=
X-Google-Smtp-Source: ABdhPJzyn+hl0ew3lgHkxm3zSEBg9oc36NeD+Kvi8UXGU3WZM9dFhT2w2do1eHSIqBugU5+hKZR5C9DfxJAfOZ8aSxc=
X-Received: by 2002:a5b:94d:: with SMTP id x13mr12700690ybq.47.1626450341186;
 Fri, 16 Jul 2021 08:45:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210629220328.13366-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20210629220328.13366-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20210703181937.510ec0fa@jic23-huawei> <CA+V-a8uzeepfd+8Wfd2n2EXeXQ9QJZhR+X8j29Y7DGNu8+aH+g@mail.gmail.com>
 <20210714133913.000075a6@Huawei.com> <CA+V-a8spDa5PiGzp6-4mHTEMfQYJ5NnQ44vwgdtu_sfVG5OO5Q@mail.gmail.com>
 <20210715140232.0000408c@Huawei.com>
In-Reply-To: <20210715140232.0000408c@Huawei.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 16 Jul 2021 16:45:14 +0100
Message-ID: <CA+V-a8s8MGg1k0-v_3iMi-uCq4JO=j2bUTeQQ4T1qwaYz2VrAw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: Add binding documentation for
 Renesas RZ/G2L A/D converter
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

On Thu, Jul 15, 2021 at 2:02 PM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Wed, 14 Jul 2021 19:24:27 +0100
> "Lad, Prabhakar" <prabhakar.csengg@gmail.com> wrote:
>
> > Hi Jonathan,
> >
> > On Wed, Jul 14, 2021 at 1:39 PM Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:
> > >
> > > On Wed, 14 Jul 2021 10:11:49 +0100
> > > "Lad, Prabhakar" <prabhakar.csengg@gmail.com> wrote:
> > >
> > > > Hi Jonathan,
> > > >
> > > > Thank you for the review.
> > > >
> > > > On Sat, Jul 3, 2021 at 6:17 PM Jonathan Cameron <jic23@kernel.org> wrote:
> > > > >
> > > > > On Tue, 29 Jun 2021 23:03:27 +0100
> > > > > Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > > > >
> > > > > > Add binding documentation for Renesas RZ/G2L A/D converter block.
> > > > > >
> > > > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > > > Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > > > Hi,
> > > > >
> > > > > See inline
> > > > >
> > > > > Jonathan
> > > > >
> > > > > > ---
> > > > > >  .../bindings/iio/adc/renesas,rzg2l-adc.yaml   | 121 ++++++++++++++++++
> > > > > >  1 file changed, 121 insertions(+)
> > > > > >  create mode 100644 Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
> > > > > >
> > > > > > diff --git a/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml b/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
> > > > > > new file mode 100644
> > > > > > index 000000000000..db935d6d59eb
> > > > > > --- /dev/null
> > > > > > +++ b/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
> > > > > > @@ -0,0 +1,121 @@
> > > > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > > > +%YAML 1.2
> > > > > > +---
> > > > > > +$id: http://devicetree.org/schemas/iio/adc/renesas,rzg2l-adc.yaml#
> > > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > > +
> > > > > > +title: Renesas RZ/G2L ADC
> > > > > > +
> > > > > > +maintainers:
> > > > > > +  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > > > +
> > > > > > +description: |
> > > > > > +  A/D Converter block is a successive approximation analog-to-digital converter
> > > > > > +  with a 12-bit accuracy. Up to eight analog input channels can be selected.
> > > > > > +  Conversions can be performed in single or repeat mode. Result of the ADC is
> > > > > > +  stored in a 32-bit data register corresponding to each channel.
> > > > > > +
> > > > > > +properties:
> > > > > > +  compatible:
> > > > > > +    oneOf:
> > > > > > +      - items:
> > > > > > +          - enum:
> > > > > > +              - renesas,r9a07g044-adc   # RZ/G2{L,LC}
> > > > > > +          - const: renesas,rzg2l-adc
> > > > > > +
> > > > > > +  reg:
> > > > > > +    maxItems: 1
> > > > > > +
> > > > > > +  interrupts:
> > > > > > +    maxItems: 1
> > > > > > +
> > > > > > +  clocks:
> > > > > > +    items:
> > > > > > +      - description: converter clock
> > > > > > +      - description: peripheral clock
> > > > > > +
> > > > > > +  clock-names:
> > > > > > +    items:
> > > > > > +      - const: adclk
> > > > > > +      - const: pclk
> > > > > > +
> > > > > > +  power-domains:
> > > > > > +    maxItems: 1
> > > > > > +
> > > > > > +  resets:
> > > > > > +    maxItems: 2
> > > > > > +
> > > > > > +  reset-names:
> > > > > > +    items:
> > > > > > +      - const: presetn
> > > > > > +      - const: adrst-n
> > > > > > +
> > > > > > +  renesas-rzg2l,adc-trigger-mode:
> > > > > > +    $ref: /schemas/types.yaml#/definitions/uint8
> > > > > > +    description: Trigger mode for A/D converter
> > > > > > +    enum:
> > > > > > +      - 0 # Software trigger mode (Defaults)
> > > > > > +      - 1 # Asynchronous trigger using ADC_TRG trigger input pin
> > > > > > +      - 2 # Synchronous trigger (Trigger from MTU3a/GPT)
> > > > >
> > > > > Is this a function of the board in some fashion?  If not it sounds like
> > > > > something that should be in control of userspace.  Normally we'd
> > > > > do that by having the driver register some iio_triggers and depending
> > > > > on which one is selected do the equivalent of what you have here.
> > > > >
> > > > Agreed for Asynchronous and Synchronous triggers. WRT Software trigger
> > > > should this be registered as a  iio_triggers too or read_raw()
> > > > callback (with IIO_CHAN_INFO_RAW case)  should be treated as Software
> > > > trigger?
> > > >
> > >
> > > Normally we'd use an external trigger to provide the software trigger
> > > (plus as you say sysfs reads will map to this functionality).
> > >
> > > Something like the sysfs trigger or the hrtimer one would get used, though
> > > also fine to use the dataready trigger from a different device (if you want
> > > approximately synced dta.
> > >
> > We can live with syfs reads for now for SW triggers. Coming back to HW
> > triggers I responded too quickly!. I am now trying to implement a gpio
> > based HW trigger i.e. to kick adc conversion start but I couldn't find
> > any drivers doing that. I looked at iio-trig-interrupt.c which
> > registers irq based triggers, so something similar needs to be
> > implemented in the adc driver? If that is the case the gpio has to be
> > passed via to DT and use gpio_to_irq to register the handler. Or is it
> > that I am missing something here ?
>
> Ok, I'm not really following the usecase for this. Is the thought that you'll
> get lower latency / jitter triggering via a gpio rather than using a
> bus write to the device (though on an integrated ADC I can't see why that would
> be the case)?
>
Sorry for the confusion. ADC_TRIG I was referring to automatically
triggers  ADC conversion depending on the edges (whatever its is
configured to). The external triggers can be handled by iio_trigger as
you pointed out earlier!

> If so, then what is actually setting the gpio?  Something is ultimately
> acting as the real trigger.  A common model would be an hrtimer trigger
> for example.   If you then want to wire the driver up to capture on demand
> using the gpio (to reduce latency) that's fine, but the gpio itself is
> never a trigger in the sense of an IIO trigger (rather than a trigger
> to the ADC itself).  In that case, have the trigger handler set the
> the gpio and wait for data capture to finish.  Quite a few drivers
> do this as some devices can only start sampling on an external pin being
> set.  E.g. adc/ad7606.c
>
> The iio-trig-interrupt is about using an external interrupt to trigger
> a capture initialized by a register write or similar, it's not a direct
> hardware capture signal.
>
thanks for the explanation, I realized it now.

Cheers,
Prabhakar
