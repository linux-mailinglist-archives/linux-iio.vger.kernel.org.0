Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A45D467EEE
	for <lists+linux-iio@lfdr.de>; Fri,  3 Dec 2021 21:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383119AbhLCUvX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 Dec 2021 15:51:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239909AbhLCUvW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Dec 2021 15:51:22 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B24CC061751;
        Fri,  3 Dec 2021 12:47:58 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id D33A61F4737E
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1638564476; bh=rj1VxQi2dWb+NHaEWofff8PIL6ybOwxjGYXKpXTihKE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SMngz7WPwURRIp5At6Ewio/ZfNIHL8KUqfxuul/DamsKWXoXpO5oC6pU1G+xvdw1F
         5bBURAFkwPsm3M2JItq9uaSvq/N3up2nCalO33UkTmFBCv/Lnr5jORf4hWlPmLJsqu
         eGxGPSGe4CTelp437aqrebPPLJx5oyzWY26AyPUlaICM1bUpxhSB5Scq3pzQYCu5by
         22cETcPAFa8zGwukQMuySB58vQKbaKeb/efauQTnSwU0yMjiE5ajoxc41uOaaDKRyB
         rbojkLjvRPnjqlaADAbL6MdQefXm84iXxSUpDILWQB5e/NUo7q5ym7GxuDcWn4u0zv
         bB5jTMzJxonfQ==
Received: by earth.universe (Postfix, from userid 1000)
        id 19C7B3C0CA8; Fri,  3 Dec 2021 21:47:54 +0100 (CET)
Date:   Fri, 3 Dec 2021 21:47:54 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Evgeny Boger <boger@wirenboard.com>
Cc:     Quentin Schulz <foss+kernel@0leil.net>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <maxime@cerno.tech>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, linux-pm@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/2] dt-bindings: iio: adc: document TS voltage in AXP
 PMICs
Message-ID: <20211203204754.2ucaiiwyrvbtwgbz@earth.universe>
References: <20211118141233.247907-1-boger@wirenboard.com>
 <20211118141233.247907-3-boger@wirenboard.com>
 <20211122104915.zism6uadgwxjz5d2@gilmour>
 <d1a18116-e198-1b26-d73a-36fbf31aaa81@wirenboard.com>
 <35630e89-4988-a6a9-b801-0e9e44419684@sholland.org>
 <206c2a66-42b9-7e07-66c3-6007b010c996@wirenboard.com>
 <20211201110241.kts5caycdmzqtp3i@fiqs>
 <4fd167ed-d5dc-358a-00f5-6590f4c20a68@wirenboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jv2resdmlukfd3qt"
Content-Disposition: inline
In-Reply-To: <4fd167ed-d5dc-358a-00f5-6590f4c20a68@wirenboard.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--jv2resdmlukfd3qt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Dec 01, 2021 at 06:45:44PM +0300, Evgeny Boger wrote:
> Hi Quentin,
>=20
> thank you for the feedback!
>=20
> 01.12.2021 14:02, Quentin Schulz =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > Hi all,
> >=20
> > On Tue, Nov 30, 2021 at 02:58:23AM +0300, Evgeny Boger wrote:
> > > (added linux-pm@ list and maintainers)
> > >=20
> > >=20
> > > Actually, on second though, I think it might be doable to add voltage=
 to
> > > temperature conversion to this driver.
> > >=20
> > > I think since the NTC thermistor belongs to the battery, not charger,=
 the
> > > thermistor should be described in monitored battery node.
> > > So I propose to extend battery node (power/supply/battery.yaml) by ad=
ding
> > > something like:
> > >=20
> > > thermistor-resistance-temp-table =3D <25 10000>, <35 6530>, ...;
> > >=20
> > > This driver will then interpolate between points to report temperatur=
e.
> > >=20
> > I disagree, I think it does not make much sense. This is already done by
> > the NTC thermistor driver.
> > The battery "subsystem" already provides operating-range-celsius and
> > alert-celsius properties for that.
> > Since the battery is linked to the AXP, all we need is to be able to ask
> > the NTC thermistor driver to do the conversion from temperature to
> > voltage of the two voltage values we get from the battery and use the
> > result as threshold in the AXP registers.
> > I wouldn't want to have the extrapolation done in two different places.
> >=20
> > I can see two ways of specifying that interation:
> >=20
> > battery -------------------> axp --------------------> ntc
> > 	min/max =C2=B0C			request =C2=B0C to V
> > 				 <--------------------
> > 					response V
> >=20
> > This however would require a phandle in the AXP to the NTC thermistor
> > driver and I don't feel like it's that good of an idea?
> >=20
> > Another way would be to use the battery as a proxy for the voltage
> > request to ntc.
> >=20
> > 		     battery --------------------> axp
> > 				min/max =C2=B0C
> > ntc <--------------- 	     <--------------------
> > 	request =C2=B0C to V		request =C2=B0C to V
> >      --------------->	     --------------------->
> > 	response V		response V
> >=20
> > This would require a phandle to the ntc thermistor in the battery node,
> > which kind of makes sense to me. And since the AXP already has knowledge
> > of the battery, it can request the appropriate value to the battery
> > which then proxies it to and back from the ntc.
> >=20
> > Forgive me for my poor ASCII drawing skills :) hopefully it's good
> > enough to convey my thoughts.
> I see quite a few problems with NTC driver approach.
>=20
> The problem is, I don't know any suitable subsystem for that. NTC
> is not a subsystem, NTC in kernel is a mere hwmon driver, and also
> is quite an old one.
>=20
> Also, we already have iio-afe, which, in a sense, already does pretty much
> the same as NTC
> hwmon driver. Maybe using iio-afe is the better idea?
> But then, I think that's a very complicated interaction for a simple
> interpolation between points.
>=20
> Another thing is, in our design we ended up using not a simple 10k NTC
> thermistor, but a 10k NTC is series with fixed 2.2k.
> The reason why it's needed is that AXP NTC voltage thresholds are fixed at
> startup time, and if we somehow have to deal
> with default thresholds to get different behaviour.=C2=A0 So the
> resistance-temperature curve in our case is different from any standard
> NTC. Speaking of "standard" NTC, our supplier has like 15 different models
> for *each* resistance, which slightly differ in
> resistance-temperature curve. Adding them all into a driver would be
> strange.
>=20
> Personally, I think better approach with NTCs is to place the
> resistance-temperature tables for bunch of models to .dtsi
> files, describe the thermistor node in DT and then make all drivers (hwmon
> NTC, iio-afe, this one) to use this data in the same way
> it's done with monitored-battery node.
>=20
> > > We can also adjust PMIC voltage thresholds based on this table and
> > > "alert-celsius" property already described in battery.yaml.
> > >=20
> > > I think the driver should report raw TS voltage as well, because the =
TS pin
> > > can also be used as general-purpose ADC pin.
> > >=20
> > Since the ntc anyway needs this raw TS voltage and that patch does that,
> > I think it's fine. Specifically, re-using this pin as a general-purpose
> > ADC won't impact the current patchset.
> >=20
> > What we'll need is to have a pinctrl driver for the few pins in the AXP
> > which have multiple functions. But that's outside of the scope of this
> > patchset.
> Should it really be pinctrl, though? Unfortunately the choice will alter
> other
> functions as well. Say, if we use TS pin in GPADC mode, we'll have to
> disable
> temperature thresholds and current injection.
> >=20
> > Regarding the injected current, I don't have enough knowledge in
> > electronics to understand how this will change things in the thermistor
> > since in the NTC thermistor driver there's no logic related to the
> > actual current being injected. Maybe it is related to some operating
> > value required by the NTC? I can't say unfortunately.
> It's basically Ohm's law, so it's not related to the NTC thermistor itsel=
f,
> but more to the voltage across NTC that the AXP can measure.
> Say, if maximum measurable voltage is 3.3V, than the maximum measurable
> resistance
> at the given current would be 3.3V/80uA =3D 41 kOhm. In case of 10k NTC i=
t's
> about -5C or so.
>=20
> But again, one can't really alter startup voltage thresholds of the AXP. =
And
> also, regardless of
> settings, at least AXP221s will completely disable TS-based protection if
> voltage on TS pin is below 0.2V.
> So at the end, unfortunately, there are not so many options when it comes=
 to
> the thermistor and the injection current.

Linus W. recently sent a series for NTC support in power-supply
core, please synchronize with him (added to Cc):

https://lore.kernel.org/linux-pm/20211122234141.3356340-1-linus.walleij@lin=
aro.org/

(FWIW I don't have any strong opinion about any solution)

-- Sebastian

--jv2resdmlukfd3qt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmGqgnIACgkQ2O7X88g7
+prZ/g//a2qPyKtdJ+uEKmjaFcSzXLu0fHssW1T0VP7vFUb+ZxIsNM2cL1PiUtKi
kCjsE5EOP/JLFI7mzXuYTI4uDFOe3d4DThMGj2pzt69Jv8n3b+jOH5W9ypAIfQPZ
OQ2E13l7wQi1YFLDdjMnB8YZHEeqK6sxGEtSQs3f0nNnC+QMZ9Y025k+YfXe8VvW
qqz4veJidfOHAC7bbFVsTBRWq57rB34YC0OcUDoVtN5zHf2rs6IWjeYQNRb4y6qw
AlELWL3fMxMtt6s8IB7RRhAFMN0JAu6VS6EBTEYqPyemdgwWMb4doKyPlCr8eT/y
+TeypMnmzw95ZLLawgqGriyx0VjEFb5HxEYT/O2zlnQX+5bVOO/hFPpaMDtvjn+8
xd4l2zKH5mJwez+RjrJ8WpPZFCavk/1z3b7Pcm1f3TBcXhsKEZ63mBq44/LPC2sk
sXof43zI6haBl00N0YSoZO5CqXS8uMG0PMybJWhXiivnkh/XujlIjm2nYWvMoPvp
YHD+T7xAlcxL8RHe2Xk/qDTjWi1Mz/EvP/mS5h4V1Sdpma00JXsp3nPGpWMKe/ed
jBFU9AT/kpuvFL8iTGTSCO3CVan8myU3GwODl7xL0pimBhYqIqQDm2xXdyM+AKaK
d1y9Uumzcq+3mZug+zle2/kYQZHUQFW9wkjqgEyvZagA1hEmt/U=
=kU2b
-----END PGP SIGNATURE-----

--jv2resdmlukfd3qt--
