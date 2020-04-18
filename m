Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6EA61AF32C
	for <lists+linux-iio@lfdr.de>; Sat, 18 Apr 2020 20:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbgDRSYt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Apr 2020 14:24:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:50250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725824AbgDRSYt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Apr 2020 14:24:49 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD51221BE5;
        Sat, 18 Apr 2020 18:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587234288;
        bh=Eiw2FcEguTRJkOBXYe2RiFR5T2mMDxr5J0RGwGhG6fc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oIG38DGXDITaJxY5mhXfozPYjDp5qVgzxBz2FaEUDhDUIDtJ8/LXkYtm0DCH2A5hi
         oAqP0Lp7VtDQ92aeu9gmRxu7OyTQ6xhEWpeP1bBkthsCRnau6P7qayITlHJtAYNSF4
         IVvwF00aGUuThd3pXs7B1gION9uSlHW8WhJ9oBAk=
Date:   Sat, 18 Apr 2020 19:24:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Kamel Bouhara <kamel.bouhara@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: counter: microchip-tcb-capture
 counter
Message-ID: <20200418192443.47322236@archlinux>
In-Reply-To: <20200417135820.GB94725@icarus>
References: <20200415130455.2222019-1-kamel.bouhara@bootlin.com>
        <20200415130455.2222019-3-kamel.bouhara@bootlin.com>
        <20200417135820.GB94725@icarus>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 17 Apr 2020 09:58:20 -0400
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> On Wed, Apr 15, 2020 at 03:04:54PM +0200, Kamel Bouhara wrote:
> > Describe the devicetree binding for the Microchip TCB module.
> > Each counter blocks exposes three independent counters.
> > 
> > However, when configured in quadrature decoder, both channel <0> and <1>
> > are required for speed/position and rotation capture (yet only the
> > position is captured).
> > 
> > Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>  
> 
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
Will let this sit a bit longer to let the DT maintainers have an opportunity
to take a look.

Thanks,

Jonathan

> 
> > ---
> > Changes from v3:
> >  - Updated the brand name: s/atmel/microchip/.
> > 
> > Changes from v2:
> >  - Fixed errors reported by dt_binding_check
> > 
> >  .../counter/microchip-tcb-capture.yaml        | 33 +++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/counter/microchip-tcb-capture.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/counter/microchip-tcb-capture.yaml b/Documentation/devicetree/bindings/counter/microchip-tcb-capture.yaml
> > new file mode 100644
> > index 000000000000..183e9ee4c049
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/counter/microchip-tcb-capture.yaml
> > @@ -0,0 +1,33 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/counter/microchip-tcb-capture.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Microchip TCB Counter
> > +
> > +maintainers:
> > +  - Kamel Bouhara <kamel.bouhara@bootlin.com>
> > +
> > +properties:
> > +  compatible:
> > +    const: "microchip,tcb-capture"
> > +
> > +  reg:
> > +    description: TCB capture channel to register as counter device.
> > +      Each channel is independent therefore only one channel is
> > +      registered by default execpt for the QDEC mode where both TCB0's
> > +      channels <0> and  <1> are required.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    tcb0: timer@f800c000 {
> > +        compatible = "microchip,tcb-capture";
> > +        reg = <0>, <1>;
> > +    };
> > -- 
> > 2.25.0
> >   

