Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7C4C1299AE
	for <lists+linux-iio@lfdr.de>; Mon, 23 Dec 2019 18:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfLWR7D (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Dec 2019 12:59:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:35794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726821AbfLWR7A (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Dec 2019 12:59:00 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8A6820643;
        Mon, 23 Dec 2019 17:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577123939;
        bh=WDqjT+YtE+Wo+JuMu1GzKuJojCfXUOurRzYLLDjl+fk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=V8jLtzGq3fCk6dsOWYtDeI0b7gHsLlbtcEf4u/uwviPB7/G1TIET9udfkOtomfBwg
         ROOV/zhNUyj8FgivdF782xpdSc/chzKfxL43Ov8BjcVXFKEG+gZFXlE5KiZ7vDtwtd
         KrxkTxY4cNNgTZ2E/EtKfa/sUnf1euiY/qPP2n+w=
Date:   Mon, 23 Dec 2019 17:58:54 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Stefan Popa <stefan.popa@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Alexandru Ardelean <alexandru.Ardelean@analog.com>,
        kernel@pengutronix.de
Subject: Re: [PATCH v4 1/3] iio: adc: ltc2496: provide device tree binding
 document
Message-ID: <20191223175854.600c7254@archlinux>
In-Reply-To: <20191216083736.lzmborv33w6odlaj@pengutronix.de>
References: <20191209203248.21555-1-u.kleine-koenig@pengutronix.de>
        <20191209203248.21555-2-u.kleine-koenig@pengutronix.de>
        <20191215114958.6ad37d19@archlinux>
        <20191216083736.lzmborv33w6odlaj@pengutronix.de>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 16 Dec 2019 09:37:36 +0100
Uwe Kleine-K=C3=B6nig         <u.kleine-koenig@pengutronix.de> wrote:

> Hello Jonathan,
>=20
> On Sun, Dec 15, 2019 at 11:49:58AM +0000, Jonathan Cameron wrote:
> > On Mon,  9 Dec 2019 21:32:46 +0100
> > Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:
> >  =20
> > > The ADC only requires the standard stuff for spi devices and a refere=
nce
> > > voltage.
> > >=20
> > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>=
 =20
> > Thanks for figuring out what was wrong and fixing it up. =20
>=20
> It wasn't done primarily to do you a favour :-)
>=20
> > > +  spi-max-frequency:
> > > +    description: maximal spi bus frequency supported by the chip =20
> >=20
> > dropped the "by the chip" as this is also about the wiring on the board=
.  If it
> > were just the chip, it could be put in the driver.  The unknown bit is
> > if there is some other reason why it might need to be set lower than th=
e maximum. =20
>=20
> fine for me.
>=20
> > > +required:
> > > +  - compatible
> > > +  - vref-supply
> > > +  - reg
> > > +
> > > +examples:
> > > +  - |
> > > +    spi {
> > > +        #address-cells =3D <1>;
> > > +        #size-cells =3D <0>;
> > > +
> > > +        adc@0 {
> > > +        	compatible =3D "lltc,ltc2496"; =20
> > You can't easily see it here, but this is a mixture of spaces
> > and tabs.  Should be all spaces.  I've tidied that up. =20
>=20
> I did that on purpose, spaces to have the needed indention for the yaml
> syntax and then tabs for dts indention (as done in the dts itself, too).
> I thought this to be the right mix, but this was my first yaml binding,
> so you're probably right.

I'll be honest, I'm far from sure on this.

I usually rely on Rob moaning about it if it's wrong :)

Oh well. What's there builds. If we get a 'fix' later then so be it.

Thanks,

Jonathan

>=20
> Best regards and thanks
> Uwe
>=20

