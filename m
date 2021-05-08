Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2163772D8
	for <lists+linux-iio@lfdr.de>; Sat,  8 May 2021 17:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbhEHP7t (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 May 2021 11:59:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:47010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229500AbhEHP7t (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 8 May 2021 11:59:49 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE5C660FE9;
        Sat,  8 May 2021 15:58:45 +0000 (UTC)
Date:   Sat, 8 May 2021 16:59:44 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Peter Rosin <peda@axentia.se>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: afe: current-sense-shunt: add
 io-channel-cells
Message-ID: <20210508165944.2e3d8d91@jic23-huawei>
In-Reply-To: <0e68ca18-7d8c-12ab-59b1-56404b29be77@axentia.se>
References: <20210506150637.35288-1-krzysztof.kozlowski@canonical.com>
        <0e68ca18-7d8c-12ab-59b1-56404b29be77@axentia.se>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 8 May 2021 00:44:58 +0200
Peter Rosin <peda@axentia.se> wrote:

> Hi!
> 
> On 2021-05-06 17:06, Krzysztof Kozlowski wrote:
> > The current-sense-shunt is an IIO provider thus can be referenced by IIO
> > consumers (via "io-channels" property in consumer device node).
> > Such provider is required to describe number of cells used in phandle
> > lookup with "io-channel-cells" property.  This also fixes dtbs_check
> > warnings like:
> > 
> >   arch/arm/boot/dts/s5pv210-fascinate4g.dt.yaml: current-sense-shunt:
> >     '#io-channel-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
> > 
> > Fixes: ce66e52b6c16 ("dt-bindings:iio:afe:current-sense-shunt: txt to yaml conversion.")
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> > ---
> >  .../devicetree/bindings/iio/afe/current-sense-shunt.yaml     | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/afe/current-sense-shunt.yaml b/Documentation/devicetree/bindings/iio/afe/current-sense-shunt.yaml
> > index 90439a8dc785..05166d8a3124 100644
> > --- a/Documentation/devicetree/bindings/iio/afe/current-sense-shunt.yaml
> > +++ b/Documentation/devicetree/bindings/iio/afe/current-sense-shunt.yaml
> > @@ -24,12 +24,16 @@ properties:
> >      description: |
> >        Channel node of a voltage io-channel.
> >  
> > +  "#io-channel-cells":
> > +    const: 0
> > +
> >    shunt-resistor-micro-ohms:
> >      description: The shunt resistance.
> >  
> >  required:
> >    - compatible
> >    - io-channels
> > +  - "#io-channel-cells"
> >    - shunt-resistor-micro-ohms  
> 
> I know I'm listed as maintainer and all, but I have not kept up with the yaml
> conversion. Sorry. So, given that I might very well fundamentally misunderstand
> something, it does not sound correct that #io-channel-cells is now "required".
> I regard it as optional, and only needed if some other in-kernel driver is
> consuming the sensed current. What am I missing?
> 

Agreed. This should be optional and I have deliberately not introduced it
into all the bindings that could in theory support being used as providers.

So far I've not pushed it out in a blanket fashion into existing bindings
even as optional.

> Also, whatever is done in this binding should preferably also be done in the
> two "sister" afe bindings, i.e. current-sense-amplifier and voltage-divider.

This particular case is squashing an error, so whilst I'm happy to have those
gain the binding addition, I would like to see them in a separate patch as
less likely they'd get back ported.

If Kryysztof is fine with me just dropping the required I can pick up this patch.

Thanks,

Jonathan

> 
> Cheers,
> Peter
> 
> >  additionalProperties: false
> > @@ -57,6 +61,7 @@ examples:
> >      sysi {
> >          compatible = "current-sense-shunt";
> >          io-channels = <&tiadc 0>;
> > +        #io-channel-cells = <0>;
> >  
> >          /* Divide the voltage by 3300000/1000000 (or 3.3) for the current. */
> >          shunt-resistor-micro-ohms = <3300000>;
> >   

