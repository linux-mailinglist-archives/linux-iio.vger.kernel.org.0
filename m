Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91D393C748D
	for <lists+linux-iio@lfdr.de>; Tue, 13 Jul 2021 18:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbhGMQfP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Jul 2021 12:35:15 -0400
Received: from mail-vs1-f53.google.com ([209.85.217.53]:40865 "EHLO
        mail-vs1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhGMQfP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Jul 2021 12:35:15 -0400
Received: by mail-vs1-f53.google.com with SMTP id z7so927062vsn.7;
        Tue, 13 Jul 2021 09:32:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wEFTIvfldYQdWbU0+dVTlFsldmIwtOaNGFmep4ASxsw=;
        b=WKCBz66ADoc5oeZPvxZrFzzIPkQaPxaFCNknC9Jy4WXvZlv82z43xH7koz1PXZ3F/F
         NdWp0sek2lTm/hIlvcQkp4FWirGqMe0yJY/Pvwu6z9Kgglga8dkTpIQNr5c7xGLAMqvf
         Cw98khs7l41aYbiAk6dtdX17j9kX+qOY5arLnmn/dAc1yau7EiDh5x0Qj+w9iglcFd2x
         9K73LPMDk64QnrrG/QMG/Ifc/z2hFhvd4pssgZFRkDPKV2nAd+J8tGvPMPqs8+PNamee
         xIIvrc3vvXrZqu10m9sJUTrDDC3RxlUjtcCQOVUHXykrOVzwN9fKd8pl3S0vTKWE0x55
         e7XA==
X-Gm-Message-State: AOAM531G26l2grUrL6Aq4c17u7IwOQNWcIc2QaC/L2W6hYKRgALr72ei
        3VOItlVDCqXMcJgRoVy6WkYKn8wYS8mPXkOfqAg=
X-Google-Smtp-Source: ABdhPJxgGxKbu2+X0LPxRNPOhDg6pRFwCAZKuV6SHtapVvue/ES1G10rouYV5IkbldkxmkDs9aYQXDupBEil3x963kk=
X-Received: by 2002:a67:8702:: with SMTP id j2mr7454255vsd.3.1626193944361;
 Tue, 13 Jul 2021 09:32:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210629220328.13366-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20210629220328.13366-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20210701202141.GA2859816@robh.at.kernel.org> <CA+V-a8sAvEQesjdKX8WzPZvPtt70pfm7qk-AGdy5QFrwXSKZrw@mail.gmail.com>
In-Reply-To: <CA+V-a8sAvEQesjdKX8WzPZvPtt70pfm7qk-AGdy5QFrwXSKZrw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 13 Jul 2021 18:32:13 +0200
Message-ID: <CAMuHMdUoX5NyM7bN4c+JtO=n2v6HsxTaCqkeRrKBz8wmRu-ruw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: Add binding documentation for
 Renesas RZ/G2L A/D converter
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
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

Hi Prabhakar,

On Tue, Jul 13, 2021 at 6:01 PM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Thu, Jul 1, 2021 at 9:21 PM Rob Herring <robh@kernel.org> wrote:
> > On Tue, Jun 29, 2021 at 11:03:27PM +0100, Lad Prabhakar wrote:
> > > Add binding documentation for Renesas RZ/G2L A/D converter block.
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > ---
> > >  .../bindings/iio/adc/renesas,rzg2l-adc.yaml   | 121 ++++++++++++++++++
> > >  1 file changed, 121 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml b/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
> > > new file mode 100644
> > > index 000000000000..db935d6d59eb
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
> > > @@ -0,0 +1,121 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/iio/adc/renesas,rzg2l-adc.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Renesas RZ/G2L ADC
> > > +
> > > +maintainers:
> > > +  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > +
> > > +description: |
> > > +  A/D Converter block is a successive approximation analog-to-digital converter
> > > +  with a 12-bit accuracy. Up to eight analog input channels can be selected.
> > > +  Conversions can be performed in single or repeat mode. Result of the ADC is
> > > +  stored in a 32-bit data register corresponding to each channel.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    oneOf:
> >
> > You can drop oneOf here.
> >
> Dropping oneOf from here dt_binding_check complains with below report,
> Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml:
> properties:compatible: [{'items': [{'enum':
> ['renesas,r9a07g044-adc']}, {'const': 'renesas,rzg2l-adc'}]}] is not
> of type 'object', 'boolean'
> from schema $id: http://json-schema.org/draft-07/schema#

You forgot to drop the dash in front of the items, right?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
