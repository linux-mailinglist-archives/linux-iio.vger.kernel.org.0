Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B55B16540
	for <lists+linux-iio@lfdr.de>; Tue,  7 May 2019 15:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfEGN7S (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 May 2019 09:59:18 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:50871 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbfEGN7S (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 7 May 2019 09:59:18 -0400
X-Originating-IP: 90.88.28.253
Received: from localhost (aaubervilliers-681-1-86-253.w90-88.abo.wanadoo.fr [90.88.28.253])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id D76541C0017;
        Tue,  7 May 2019 13:59:12 +0000 (UTC)
Date:   Tue, 7 May 2019 15:59:12 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Frank Lee <tiny.windzz@gmail.com>, Icenowy Zheng <icenowy@aosc.io>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, lars@metafoo.de,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        robh+dt@kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        pmeerw@pmeerw.net, knaack.h@gmx.de,
        Lee Jones <lee.jones@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 1/7] iio: adc: sun4i-gpadc: rework for support multiple
 thermal sensor
Message-ID: <20190507135912.4lev7ly2w4drlt7s@flea>
References: <20190503072813.2719-1-tiny.windzz@gmail.com>
 <20190503072813.2719-2-tiny.windzz@gmail.com>
 <20190505162215.3594f77d@archlinux>
 <20190506122807.4u323iys74jddcet@flea>
 <282ccf0979e6c58effd0e177917bdf824c32f64e.camel@aosc.io>
 <CAEExFWusPoxtkGCoA+3gXq69cXZEfjZW+UpHW_0UfrcjpLmaXg@mail.gmail.com>
 <20190506175525.swc5u7j6ntry7v3g@core.my.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bydgprfj47ik7yub"
Content-Disposition: inline
In-Reply-To: <20190506175525.swc5u7j6ntry7v3g@core.my.home>
User-Agent: NeoMutt/20180716
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--bydgprfj47ik7yub
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 06, 2019 at 07:55:25PM +0200, Ond=C5=99ej Jirman wrote:
> On Tue, May 07, 2019 at 01:08:39AM +0800, Frank Lee wrote:
> > On Tue, May 7, 2019 at 12:52 AM Icenowy Zheng <icenowy@aosc.io> wrote:
> > >
> > > =E5=9C=A8 2019-05-06=E4=B8=80=E7=9A=84 14:28 +0200=EF=BC=8CMaxime Rip=
ard=E5=86=99=E9=81=93=EF=BC=9A
> > > > Hi,
> > > >
> > > > On Sun, May 05, 2019 at 04:22:15PM +0100, Jonathan Cameron wrote:
> > > > > On Fri,  3 May 2019 03:28:07 -0400
> > > > > Yangtao Li <tiny.windzz@gmail.com> wrote:
> > > > >
> > > > > > For some SOCs, there are more than one thermal sensor, and there
> > > > > > are
> > > > > > currently four sensors on the A80. So we need to do some work in
> > > > > > order
> > > > > > to support multiple thermal sensors:
> > > > > >
> > > > > >   1) add sensor_count in gpadc_data.
> > > > > >   2) introduce sun4i_sensor_tzd in sun4i_gpadc_iio, to support
> > > > > > multiple
> > > > > >      thermal_zone_device and distinguish between different
> > > > > > sensors.
> > > > > >   3) modify read temperature and initialization function.
> > > > >
> > > > > This comment doesn't mention the devm change. If it had it would
> > > > > have
> > > > > raised immediate alarm bells.
> > > > >
> > > > > I'm also not keen on the web of pointers that this driver is
> > > > > steadily
> > > > > evolving.  I can't immediately see how to reduce that complexity
> > > > > however.
> > > >
> > > > So I might be responsible for that, and looking back, this has been=
 a
> > > > mistake.
> > > >
> > > > This driver was initally put together to support a controller found
> > > > in
> > > > older (A10 up to A31) Allwinner SoCs. This controller had an ADC
> > > > driver that could be operated as a touchscreen controller, and was
> > > > providing a CPU temperature sensor and a general purpose ADC.
> > > >
> > > > However, we already had a driver for that controller in drivers/inp=
ut
> > > > to report the CPU temperature, and the one in IIO was introduced to
> > > > support the general purpose ADC (and the CPU temperature). The long
> > > > term goal was to add the touchscreen feature as well eventually so
> > > > that we could remove the one in drivers/input. That didn't happen.
> > > >
> > > > At the same time, the Allwinner hardware slowly evolved to remove t=
he
> > > > touchscreen and ADC features, and only keep the CPU temperature
> > > > readout. It then evolved further on to support multiple temperatures
> > > > (for different clusters, the GPU, and so on).
> > > >
> > > > So, today, we're in a situation where I was pushing everything into
> > > > that IIO drivers since there was similiraties between all the
> > > > generations, but the fact that we have to support so many odd cases
> > > > (DT bindings compatibility, controllers with and without ADC, etc)
> > > > that it becomes a real mess.
> > > >
> > > > And that mess isn't really used by anybody, since we want to have t=
he
> > > > touchscreen.
> > > >
> > > > There's only one SoC that is supported only by that driver, which is
> > > > the A33 that only had a CPU temperature readout, and is still pretty
> > > > similar to the latest SoC from Allwinner (that is supported by this
> > > > series).
> > > >
> > > > I guess, for everyone's sanity and in order to not stall this
> > > > further,
> > > > it would just be better to create an hwmon driver for the A33 (and
> > > > onwards, including the H6) for the SoC that just have the temperatu=
re
> > > > readout feature. And for the older SoC, we just keep the older driv=
er
> > > > under input/. Once the A33 is supported, we'll remove the driver in
> > > > IIO (and the related bits in drivers/mfd).
> >
> > a hwmon driver or a thermal driver=EF=BC=9F
> >
> > >
> > > I think a thermal driver is better.
> >
> > This is what I hope to see a few months ago.
> >
> > >
> > > Other SoCs' thermal sensor drivers are all thermal drivers.
> > >
> > > >
> > > > Armbian already has a driver for that they never upstreamed iirc, so
> > > > it might be a good starting point, and we would add the support for
> > > > the H6. How does that sound?
> > >
> > > I think the developer abandoned to upstream it because of the previous
> > > problem ;-)
> > >
> > > Maybe it can be taken and add A33&H6 support.
> >
> > If OK, I am going to start some thermal driver work this weekend.  : )
>
> There are plenty of thermal drivers flying around, with varying levels
> of support for various SoCs:
>
> - H3/H5: https://megous.com/git/linux/commit/?h=3Dths-5.1&id=3Db8e20c5da7=
a00b3a3fa1b274fc8d5bea95872b0a
> - A83T: https://megous.com/git/linux/commit/?h=3Dths-5.1&id=3D796dff9a946=
fd475cc1e4bb948a723ea841c640c
> - H6: https://megous.com/git/linux/commit/?h=3Dopi3-5.1&id=3Daeab762c19b4=
aa228a295258c9d6b2e1f143bf86
>
> For H3/H5 Icenowy also tried to upstream some variant of my THS driver, w=
ith
> better SID/calibration data reading support.
>
> I'd suggest starting with the H6 driver above (as that implements the
> calibration data readout correctly), and make it so that it can support m=
ultiple
> SoCs.

Yeah, that seems like a good plan

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--bydgprfj47ik7yub
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXNGPMAAKCRDj7w1vZxhR
xS2VAQDOVlzfYshYqB3RzzDSqFMZPH8If+sem/QedfMd4Lyj7AD+KkQ+2ms4+Ca9
JJceZmhL6UGhaXOTV4RQUMJQA+c6zgU=
=DXHT
-----END PGP SIGNATURE-----

--bydgprfj47ik7yub--
