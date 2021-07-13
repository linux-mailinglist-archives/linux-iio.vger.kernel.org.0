Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 309A53C751A
	for <lists+linux-iio@lfdr.de>; Tue, 13 Jul 2021 18:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbhGMQnR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Jul 2021 12:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbhGMQnQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Jul 2021 12:43:16 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FB2C0613DD;
        Tue, 13 Jul 2021 09:40:25 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id t186so16890302ybf.2;
        Tue, 13 Jul 2021 09:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cGx2PgNq8PmZD48ImunZ3KRTZpZb2zH2hlnbWdeKtuc=;
        b=uzb6udw8NThXGBc4rVlsnx6aOtuiNlEfn44YvN58Elk2y+nJN9ZBSNzUMMyEH5jNMY
         0roO2gzrH2SG96gpWas2HeVNPKK3AkPBAHoJa2btGQU3Bz6cPLgmEib0YV6GzIyKuGJk
         oqE++t9ec0aKvQPO8M+3hl5ji/5u0zZMn6EdxmHsK1WsWeiPrEqQYOCy+cbdAGU0LZf8
         dbL3B73wQJ9nM1eT/tEtPgwIiKHyHcNnSpl52cm70vM9+POK/rSheExtth3hnD6u3A1H
         /8HGp458k2XOrzeUrei7+rB5vc65TXC6kiiSM6aD/gkIJCvZs7Xo7aJHlwmOevSr81S3
         IWRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cGx2PgNq8PmZD48ImunZ3KRTZpZb2zH2hlnbWdeKtuc=;
        b=nKQOwOCGbRFBrJDGpaVCgYfTt4OP+nta4RsWozMJIJVHOnDLkIhHqlc6kEXRAkt/uX
         pegU7JT0AHX9FWh8KP0dgLa7hGX4hAfmR1Mt6smUIXWHUAG0UW60CHAurjBLKLPiNIYb
         hscg68Hk5kO2mEoyXbtQNVFla28qUk3hQQG2BKVRq0Zh5Iw+zN4GJkEy2qH+Z+nOC/P6
         5gRP4zeF1KXkKtDLwXpq42cUZFNU0KunMsFDMlrtCFDWW2syTD+IkfJjEMR3PBmUt+mm
         Yh1DnCsF/8F7pw4bR3saUtNcJq69rYmVmu9lK3XtQM5bWhYCfuw9L/2hr2+gOcE+KHFw
         bu0A==
X-Gm-Message-State: AOAM531+SqTgLnAaxYhikaQSCBHAEfzdvFg8omKSjQrenvgQwsKQLiR8
        VYaCbhjuRXSwtjapPd3LeLJ0uk1q9gbuArXkEuQ=
X-Google-Smtp-Source: ABdhPJyRP/HFJGDXBjl7ulbqvhUq2mbefiMANFuWhZ+AqE7gZRycWyhKT8t0wOJHaQ8kL2/Q/id9y32EB88YTO9wMHo=
X-Received: by 2002:a25:cc52:: with SMTP id l79mr6892936ybf.476.1626194424862;
 Tue, 13 Jul 2021 09:40:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210629220328.13366-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20210629220328.13366-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20210701202141.GA2859816@robh.at.kernel.org> <CA+V-a8sAvEQesjdKX8WzPZvPtt70pfm7qk-AGdy5QFrwXSKZrw@mail.gmail.com>
 <CAMuHMdUoX5NyM7bN4c+JtO=n2v6HsxTaCqkeRrKBz8wmRu-ruw@mail.gmail.com>
In-Reply-To: <CAMuHMdUoX5NyM7bN4c+JtO=n2v6HsxTaCqkeRrKBz8wmRu-ruw@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 13 Jul 2021 17:39:58 +0100
Message-ID: <CA+V-a8uK=LWdkM0Ma22krAe8fo4Kp2epmgCYQFezGimaqXYrZQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: Add binding documentation for
 Renesas RZ/G2L A/D converter
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Rob Herring <robh@kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-iio@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Geert,

On Tue, Jul 13, 2021 at 5:32 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Tue, Jul 13, 2021 at 6:01 PM Lad, Prabhakar
> <prabhakar.csengg@gmail.com> wrote:
> > On Thu, Jul 1, 2021 at 9:21 PM Rob Herring <robh@kernel.org> wrote:
> > > On Tue, Jun 29, 2021 at 11:03:27PM +0100, Lad Prabhakar wrote:
> > > > Add binding documentation for Renesas RZ/G2L A/D converter block.
> > > >
> > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > > ---
> > > >  .../bindings/iio/adc/renesas,rzg2l-adc.yaml   | 121 ++++++++++++++++++
> > > >  1 file changed, 121 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml b/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
> > > > new file mode 100644
> > > > index 000000000000..db935d6d59eb
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
> > > > @@ -0,0 +1,121 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/iio/adc/renesas,rzg2l-adc.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Renesas RZ/G2L ADC
> > > > +
> > > > +maintainers:
> > > > +  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > +
> > > > +description: |
> > > > +  A/D Converter block is a successive approximation analog-to-digital converter
> > > > +  with a 12-bit accuracy. Up to eight analog input channels can be selected.
> > > > +  Conversions can be performed in single or repeat mode. Result of the ADC is
> > > > +  stored in a 32-bit data register corresponding to each channel.
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    oneOf:
> > >
> > > You can drop oneOf here.
> > >
> > Dropping oneOf from here dt_binding_check complains with below report,
> > Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml:
> > properties:compatible: [{'items': [{'enum':
> > ['renesas,r9a07g044-adc']}, {'const': 'renesas,rzg2l-adc'}]}] is not
> > of type 'object', 'boolean'
> > from schema $id: http://json-schema.org/draft-07/schema#
>
> You forgot to drop the dash in front of the items, right?
>
Argh! Thanks for the pointer.

Cheers,
Prabhakar

> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
