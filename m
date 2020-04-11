Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 984B11A4F6B
	for <lists+linux-iio@lfdr.de>; Sat, 11 Apr 2020 12:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbgDKKn6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 Apr 2020 06:43:58 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:40009 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbgDKKn5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Apr 2020 06:43:57 -0400
Received: from kb-xps (unknown [78.193.40.249])
        (Authenticated sender: kamel.bouhara@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id AD555200008;
        Sat, 11 Apr 2020 10:43:54 +0000 (UTC)
Date:   Sat, 11 Apr 2020 12:43:53 +0200
From:   Kamel Bouhara <kamel.bouhara@bootlin.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/3] Input: rotary-encoder-counter: add DT bindings
Message-ID: <20200411104353.GB161090@kb-xps>
References: <20200406155806.1295169-1-kamel.bouhara@bootlin.com>
 <20200406155806.1295169-3-kamel.bouhara@bootlin.com>
 <20200409222115.GT75430@dtor-ws>
 <20200409223907.GW3628@piout.net>
 <20200409234623.GU75430@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409234623.GU75430@dtor-ws>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Apr 09, 2020 at 04:46:23PM -0700, Dmitry Torokhov wrote:
> On Fri, Apr 10, 2020 at 12:39:07AM +0200, Alexandre Belloni wrote:
> > Hi Dmitry,
> >
> > On 09/04/2020 15:21:15-0700, Dmitry Torokhov wrote:
> > > On Mon, Apr 06, 2020 at 05:58:05PM +0200, Kamel Bouhara wrote:
> > > > Add dt binding for the counter variant of the rotary encoder driver.
> > > >
> > > > Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
> > > > ---
> > > >  .../input/rotary-encoder-counter.yaml         | 67 +++++++++++++++++++
> > > >  1 file changed, 67 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/input/rotary-encoder-counter.yaml
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/input/rotary-encoder-counter.yaml b/Documentation/devicetree/bindings/input/rotary-encoder-counter.yaml
> > > > new file mode 100644
> > > > index 000000000000..a59f7c1faf0c
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/input/rotary-encoder-counter.yaml
> > > > @@ -0,0 +1,67 @@
> > > > +# SPDX-License-Identifier: GPL-2.0
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/input/rotary-encoder-counter.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Rotary Encoder Counter
> > > > +
> > > > +maintainers:
> > > > +  - Kamel Bouhara <kamel.bouhara@bootlin.com>
> > > > +
> > > > +description:
> > > > +  Registers a Rotary encoder connected through a counter device.
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    const: rotary-encoder-counter
> > >
> > > I wonder if a separate driver is really needed. The original driver be
> > > taught to use counter device when available?
> > >
> >
> > By the original driver, do you mean drivers/input/misc/rotary_encoder.c
> > that is using gpios ?
>
> Yes.
>

Well, it could be the case if the counter device could provide such a
way to signal interrupts.

> >
> > > > +
> > > > +  counter:
> > > > +    description: Phandle for the counter device providing rotary position.
> > > > +
> > > > +  linux-axis:
> > > > +    description: The input subsystem axis to map to this rotary encoder.
> > > > +    type: boolean
> > > > +
> > > > +  qdec-mode:
> > > > +    description: |
> > > > +      Quadrature decoder function to set in the counter device.
> > > > +      3: x1-PHA
> > > > +      4: x1-PHB
> > > > +      5: x2-PHA
> > > > +      6: x2-PHB
> > > > +      7: x4-PHA and PHB
> > >
> > > Is it really property of the rotary encoder itself or property of the
> > > counter device?
> > >
> >
> > The mode the quadrature decoder has to be put in depends on both the
> > rotary encoder and the qdec.
>
> OK.
>
> >
> > > > +
> > > > +  steps:
> > > > +    description: Number of steps in a full turnaround of the encoder.
> > > > +      Only relevant for absolute axis. Defaults to 24 which is a typical
> > > > +      value for such devices.
> > > > +
> > > > +  relative-axis:
> > > > +    description: Register a relative axis rather than an absolute one.
> > > > +    type: boolean
> > > > +
> > > > +  rollover:
> > > > +    description: Automatic rollover when the rotary value becomes greater
> > > > +      than the specified steps or smaller than 0. For absolute axis only.
> > > > +    type: boolean
> > > > +
> > > > +  poll-interval:
> > > > +    description: Poll interval at which the position is read from the counter
> > > > +      device (default 500ms).
> > >
> > > Is there a way found counters to signal an interrupt?
> > >
> >
> > For some counters, there are interrupts available, this is not trivial
> > with the counter that is the target of this work but this is on the TODO
> > list. Of course, this will also require adding a bit more to the
> > in-kernel counter API to allow registering a callback that would be
> > called when an interrupt happens.
>
> Should it be a callback, or can counter create an irqchip so that users
> do not need to know how exactly it is wired up?
>

Maybe for some of them yes but for others the polling is still required.

> Thanks.
>
> --
> Dmitry

--
Kamel Bouhara, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
