Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCCB1A0F0F
	for <lists+linux-iio@lfdr.de>; Tue,  7 Apr 2020 16:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbgDGOWq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 Apr 2020 10:22:46 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:57187 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728776AbgDGOWq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 7 Apr 2020 10:22:46 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id E14165800FB;
        Tue,  7 Apr 2020 10:22:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 07 Apr 2020 10:22:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=WZZOGhHApCSV1L4UtRpjl8cMVms
        LTISqTdlhGk83/tE=; b=wdop+RypTY1L95rFhllqkRhtWYgEAFYClfhAPgL7V8o
        qMlLR5SE6GWLIa1ZSoQ79+Z0W44kt9OiHmZ3CvUvzPb9jnW8UTnki0vTUO07qO/M
        IH6Du1/ArFs7vqpgdxcGBcasaf/y7tUY/Qy7R0LaqaiV+vdq3gWWG69cu1/Db2d2
        tSYjGHL62GfQ854q3eGFOokJ2aVePEbHQyaKzerNy29ZfdIMewn63SjOEecLL7SC
        keWTudwlRGyEJlyAtfcF1aiupSS+Bt6ZxO/lAXvD3cJrOSGcwc7fHwYCw97oo/XP
        B09l3Pen7zFk/wx6bMLUR9LR0LM1186/fRdBfVdHAjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=WZZOGh
        HApCSV1L4UtRpjl8cMVmsLTISqTdlhGk83/tE=; b=u7Ar+N/LF2C6DeXvp3SLmb
        v1Aty03403E8GzS/l7ZKt6hE1iFd1OjUSMadk8vZhO0FHQa5CTGzPnz2qMBxScGh
        VM3E1KLQdyBaBxleBRWqGLabrDiHLEfgPjVNddjZEVwztIaWE4P5pY5cKXNJff1G
        m4v7B7IbDgM7MLt99bro9rRdWjB2MqQrm0rgPulYrJ6qwW00bE6wZ8PNYhUPXcpA
        NpZlR0RsXbdqFhNsP68Mf/Bl8eF9YLBED3W7NW8d0Dgna7s6UMubPnxtj7zz17PK
        db20zhWWFiQbOMl2mISNojJH+Obdtsrx2/DuH48sMTHeAJRm9Yrwpn1QMT9SoKvA
        ==
X-ME-Sender: <xms:sIyMXlTiXSiRI3WvCdI1mm-Jzir6hQXM5vePtj5cXsapk4tU1rNmag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudehgdejgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucffohhmrghinh
    epuggvvhhitggvthhrvggvrdhorhhgnecukfhppeeltddrkeelrdeikedrjeeinecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvse
    gtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:sIyMXgXSx8_2lL0owyyT9Y357BIRf8xmDBvgz7I_14l90OfeLLKC5w>
    <xmx:sIyMXhLRLGm4H2wIpXCkhFto8ChkzLs0j1QJICpClPHUiGd0LFxaYA>
    <xmx:sIyMXo1pKdgnUJ6tomalMQBcN1-ucn-9h8KxFx-8TrBFAflFemlHRg>
    <xmx:tIyMXlK4-tLy7Ok2qgPryQ3kFTA8t51d5wIiKn3KRdcyZJ25Z25gwQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0064F3280066;
        Tue,  7 Apr 2020 10:22:39 -0400 (EDT)
Date:   Tue, 7 Apr 2020 16:22:38 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Kamel Bouhara <kamel.bouhara@bootlin.com>
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
Message-ID: <20200407142238.ik67isetbggn2rh3@gilmour.lan>
References: <20200406155806.1295169-1-kamel.bouhara@bootlin.com>
 <20200406155806.1295169-3-kamel.bouhara@bootlin.com>
 <20200407094159.xtbhtsxorvs2g22c@gilmour.lan>
 <20200407110339.GA1489441@kb-xps>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cmea35pc2hxci5l3"
Content-Disposition: inline
In-Reply-To: <20200407110339.GA1489441@kb-xps>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--cmea35pc2hxci5l3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 07, 2020 at 01:03:39PM +0200, Kamel Bouhara wrote:
> > On Mon, Apr 06, 2020 at 05:58:05PM +0200, Kamel Bouhara wrote:
> > > Add dt binding for the counter variant of the rotary encoder driver.
> > >
> > > Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
> > > ---
> > >  .../input/rotary-encoder-counter.yaml         | 67 +++++++++++++++++++
> > >  1 file changed, 67 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/input/rotary-encoder-counter.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/input/rotary-encoder-counter.yaml b/Documentation/devicetree/bindings/input/rotary-encoder-counter.yaml
> > > new file mode 100644
> > > index 000000000000..a59f7c1faf0c
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/input/rotary-encoder-counter.yaml
> > > @@ -0,0 +1,67 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> >
> > Bindings are usually used by other OS's, so you should consider
> > putting it under a more permissive license, usually that would be GPL2
> > and the BSD-2-Clause
>
> Well to be honest I just looked into an existing binding and I guess
> the wrong one :).

Not the wrong ones, but the old ones :)

It's painful to change a license on existing files, whereas it's
pretty easy to mention it during review.

> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/input/rotary-encoder-counter.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Rotary Encoder Counter
> > > +
> > > +maintainers:
> > > +  - Kamel Bouhara <kamel.bouhara@bootlin.com>
> > > +
> > > +description:
> > > +  Registers a Rotary encoder connected through a counter device.
> >
> > You shouldn't really describe the action here, but more what the
> > binding is about. The registration will not depend on the presence of
> > the node following that binding, but rather on whether or not the OS
> > that uses it has support for it.
> >
>
> Then shall it be better with just :
> "A rotary encoder device using a generic counter interface." ?

The generic counter interface is a Linux-only stuff though, some other
OS might want to implement something else. Something like "based on a
counter"?

Maxime

--cmea35pc2hxci5l3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXoyMrgAKCRDj7w1vZxhR
xaGoAP0Rk4zze3+M3tv+xBVv0PmMPLNoqDCmIQF259PcWDF2FQEAovMUQKsz/fRB
40V3ClfoNka1Z3kbhlkiwiHDy75R/Q0=
=HdTF
-----END PGP SIGNATURE-----

--cmea35pc2hxci5l3--
