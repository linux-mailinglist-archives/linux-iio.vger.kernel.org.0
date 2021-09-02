Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2951A3FF263
	for <lists+linux-iio@lfdr.de>; Thu,  2 Sep 2021 19:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346686AbhIBRgg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Thu, 2 Sep 2021 13:36:36 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:47369 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234580AbhIBRgg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Sep 2021 13:36:36 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 256C21BF207;
        Thu,  2 Sep 2021 17:35:32 +0000 (UTC)
Date:   Thu, 2 Sep 2021 19:35:32 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, bcousson@baylibre.com,
        Tony Lindgren <tony@atomide.com>,
        Tero Kristo <t-kristo@ti.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "Ryan J . Barnett" <ryan.barnett@collins.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH 02/40] dt-bindings: mfd: ti,am3359-tscadc: Add a yaml
 description for this MFD
Message-ID: <20210902193532.004715f7@xps13>
In-Reply-To: <20210830134714.133cbb65@jic23-huawei>
References: <20210825152518.379386-1-miquel.raynal@bootlin.com>
        <20210825152518.379386-3-miquel.raynal@bootlin.com>
        <20210830134714.133cbb65@jic23-huawei>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

Jonathan Cameron <jic23@kernel.org> wrote on Mon, 30 Aug 2021 13:47:14
+0100:

> On Wed, 25 Aug 2021 17:24:40 +0200
> Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> 
> > There is a very light description of this MFD in a text file dedicated
> > to a touchscreen controller (which is one of the two children of the
> > MFD). Here is now a complete yaml description.  
> 
> Make sure to call out places where you are filling in gaps in the
> txt file description.  Looks like we forgot to keep that up to date as the driver
> evolved. oops.

Right, I always forget these links, will update them.

> 
> > 
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  .../bindings/mfd/ti,am3359-tscadc.yaml        | 75 +++++++++++++++++++
> >  1 file changed, 75 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml b/Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml
> > new file mode 100644
> > index 000000000000..96b329508d8a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml
> > @@ -0,0 +1,75 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mfd/ti,am3359-tscadc.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: TI AM3359 Touchscreen controller/ADC
> > +
> > +maintainers:
> > +  - Miquel Raynal <miquel.raynal@bootlin.com>
> > +
> > +properties:
> > +  compatible:
> > +    const: ti,am3359-tscadc  
> 
> text documents the more specific ti,am654-tscadc as well.

Oops, I saw it and then forgot. Thanks for checking!

> Something like
> 
>    properties:
>      compatible:
>        oneof:
>          - const: ti,am3359-tscadc
>          - items:
>              - const: ti,am654-tscadc
>              - const: ti,am3359-tscadc
> 
> Note this superceeds my comment on later patches about changing to enum when
> introducing the new compatible. Ah well.

No problem (and thanks for the 50+ reviews btw ;) )

Thanks,
Miquèl
