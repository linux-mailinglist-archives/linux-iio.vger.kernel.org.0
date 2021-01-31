Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4C23309C4B
	for <lists+linux-iio@lfdr.de>; Sun, 31 Jan 2021 14:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbhAaNBN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 Jan 2021 08:01:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:56066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230094AbhAaMm2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 31 Jan 2021 07:42:28 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 246C464DDF;
        Sun, 31 Jan 2021 12:41:42 +0000 (UTC)
Date:   Sun, 31 Jan 2021 12:41:38 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Enric Balletbo Serra <eballetbo@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 2/3] dt-bindings: iio: Add cros ec proximity yaml doc
Message-ID: <20210131124138.740d4f7f@archlinux>
In-Reply-To: <161185389256.76967.5895202960837001560@swboyd.mtv.corp.google.com>
References: <20210128084011.3270281-1-swboyd@chromium.org>
        <20210128084011.3270281-3-swboyd@chromium.org>
        <CAFqH_53aRCVfRqHCgPoqUvmydybCiVeQdw5bHOAQ6pZr03irwg@mail.gmail.com>
        <161185389256.76967.5895202960837001560@swboyd.mtv.corp.google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 28 Jan 2021 09:11:32 -0800
Stephen Boyd <swboyd@chromium.org> wrote:

> Quoting Enric Balletbo Serra (2021-01-28 01:44:23)
> > Missatge de Stephen Boyd <swboyd@chromium.org> del dia dj., 28 de gen.
> > 2021 a les 9:45:  
> > > +
> > > +  label:
> > > +    description: Name for proximity sensor
> > > +
> > > +required:
> > > +  - compatible
> > > +
> > > +unevaluatedProperties: false
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |  
> > 
> > For this kind of devices it is preferred to see a complete example
> > rather than pieces spread around different yaml. This helps proper
> > binding parsing.
> > 
> >     spi0 {
> >       #address-cells = <1>;
> >       #size-cells = <0>;
> > 
> >       cros_ec: ec@0 {
> >         compatible = "google,cros-ec-spi";
> >         reg = <0>;  
> 
> What if it isn't on spi bus though? I'd rather leave it as is and let
> the google,cros-ec.yaml binding indicate that it is a child of the EC
> node.
It's an example. So definitely doesn't rule out other options than spi.

I think I'd also prefer to see the full example here to exercise more
of the relevant bindings when doing tests.

Mind you this is Rob's area, so I'll defer to Rob for preference.
@Rob?
> 
> >   
> > > +    proximity {
> > > +        compatible = "google,cros-ec-mkbp-proximity";
> > > +        label = "proximity-wifi-lte";
> > > +    };
> > > diff --git a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> > > index 76bf16ee27ec..479a9f15de32 100644
> > > --- a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> > > +++ b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> > > @@ -94,6 +94,9 @@ properties:
> > >    keyboard-controller:
> > >      $ref: "/schemas/input/google,cros-ec-keyb.yaml#"
> > >
> > > +  proximity:
> > > +    $ref: "/schemas/iio/proximity/google,cros-ec-mkbp-proximity.yaml#"
> > > +
> > >    codecs:
> > >      type: object
> > >      additionalProperties: false  

