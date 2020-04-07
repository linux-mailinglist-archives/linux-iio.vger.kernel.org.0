Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFFA1A0FB6
	for <lists+linux-iio@lfdr.de>; Tue,  7 Apr 2020 16:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729276AbgDGOzW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 Apr 2020 10:55:22 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:42197 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729268AbgDGOzW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 7 Apr 2020 10:55:22 -0400
Received: from kb-xps (unknown [78.193.40.249])
        (Authenticated sender: kamel.bouhara@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id DE9D2240009;
        Tue,  7 Apr 2020 14:55:11 +0000 (UTC)
Date:   Tue, 7 Apr 2020 16:55:10 +0200
From:   Kamel Bouhara <kamel.bouhara@bootlin.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/3] Input: rotary-encoder-counter: add DT bindings
Message-ID: <20200407145510.GC1489441@kb-xps>
References: <20200406155806.1295169-1-kamel.bouhara@bootlin.com>
 <20200406155806.1295169-3-kamel.bouhara@bootlin.com>
 <20200407094159.xtbhtsxorvs2g22c@gilmour.lan>
 <20200407110339.GA1489441@kb-xps>
 <20200407142238.ik67isetbggn2rh3@gilmour.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407142238.ik67isetbggn2rh3@gilmour.lan>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Apr 07, 2020 at 04:22:38PM +0200, Maxime Ripard wrote:
> On Tue, Apr 07, 2020 at 01:03:39PM +0200, Kamel Bouhara wrote:
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
> > >
> > > Bindings are usually used by other OS's, so you should consider
> > > putting it under a more permissive license, usually that would be GPL2
> > > and the BSD-2-Clause
> >
> > Well to be honest I just looked into an existing binding and I guess
> > the wrong one :).
>
> Not the wrong ones, but the old ones :)
>
> It's painful to change a license on existing files, whereas it's
> pretty easy to mention it during review.
>

Alright.

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
> > >
> > > You shouldn't really describe the action here, but more what the
> > > binding is about. The registration will not depend on the presence of
> > > the node following that binding, but rather on whether or not the OS
> > > that uses it has support for it.
> > >
> >
> > Then shall it be better with just :
> > "A rotary encoder device using a generic counter interface." ?
>
> The generic counter interface is a Linux-only stuff though, some other
> OS might want to implement something else. Something like "based on a
> counter"?
>

Indeed, that's fair enough.

Thanks.

> Maxime



--
Kamel Bouhara, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
