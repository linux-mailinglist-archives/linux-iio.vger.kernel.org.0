Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 263E9FECE2
	for <lists+linux-iio@lfdr.de>; Sat, 16 Nov 2019 16:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbfKPPZL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 Nov 2019 10:25:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:58238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727754AbfKPPZL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 Nov 2019 10:25:11 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 401FA20700;
        Sat, 16 Nov 2019 15:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573917910;
        bh=rRnti0BrmIf79tbc/YpCsyMOtR8FyK78b/mO62ih4OM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=h8Jdnw1v+fE7ZDPqn+HAktivWUMAULqEbrNuZH1p9NBKjRHGl7HnLTaKDovUH+o6+
         vazqx563Z0UZGzzLUMmLuU4dv9H2Zws0SoadsvwtjdyY5xS+63wUIG8lVfWX234z1O
         zbZ57toUvVg77isZ5AyujbeaW+pyWh867A32tKXs=
Date:   Sat, 16 Nov 2019 15:25:04 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [PATCH 1/3] iio: adc: ltc2496: provide device tree binding
 document
Message-ID: <20191116152504.499e2a54@archlinux>
In-Reply-To: <1e1a148095d2ea6c49c62e5fb2e5e741faa9d5f4.camel@analog.com>
References: <20191111214025.18310-1-u.kleine-koenig@pengutronix.de>
        <b6ed43afbfb0128301f11198eb83a8f72b7661e9.camel@analog.com>
        <20191112070405.zinuqnfb3wqbehvw@pengutronix.de>
        <1e1a148095d2ea6c49c62e5fb2e5e741faa9d5f4.camel@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 12 Nov 2019 11:56:52 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Tue, 2019-11-12 at 08:04 +0100, Uwe Kleine-K=C3=B6nig wrote:
> > [External]
> >=20
> > Hello Alexandru,
> >=20
> > On Tue, Nov 12, 2019 at 06:57:49AM +0000, Ardelean, Alexandru wrote: =20
> > > On Mon, 2019-11-11 at 22:40 +0100, Uwe Kleine-K=C3=B6nig wrote: =20
> > > > The ADC only requires the standard stuff for spi devices and a
> > > > reference
> > > > voltage. =20
> > >=20
> > > DT bindings must be in YAML format. =20
> >=20
> > Yeah, I noticed this trend. But given that I only saw .txt files for
> > iio, I thought I'd stick to that.
> >  =20
> > > But in this case, you can probably extend the existing
> > > "Documentation/devicetree/bindings/iio/adc/ltc2497.txt". =20
> >=20
> > I considered that shortly, but as the ltc2497 is an i2c device and the
> > ltc2496 uses spi I chose to create another simple document instead of
> > complicating the existing one by describing two nearly orthogonal sets
> > of properties. =20
>=20
> There are dt-bindings that cover both SPI & I2C.
> I think ADXL372 does that too.
True, but in that case no real choice as the same part does both
bus types.  Here it's probably cleaner to just have a second document.

Thanks,

Jonathan

>=20
>=20
> >=20
> > Best regards
> > Uwe
> >  =20

