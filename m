Return-Path: <linux-iio+bounces-7558-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C91E792FF19
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 19:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 145D7B24D53
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 17:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B64178397;
	Fri, 12 Jul 2024 17:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L7irPire"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1745C176AC8;
	Fri, 12 Jul 2024 17:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720803779; cv=none; b=RmhzZwx8RB+wyVDXCLkOozR9bV5hi39r6tmBSiYAtSSlXtOf0kIvpLvX4WhvsTjGl9LbsrU4k/+3N3yQ81kuaPBKE85DNCBrNl2fSZx9kg+8X3kBe82yu4Qkcd72QQNdxI2oB9j3/ZsTUUs9ijfmBDydYZHh+hKWm+qRe2il31o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720803779; c=relaxed/simple;
	bh=dlPqmeE8Q4QGZcuhPcklfXhhOofyZPKEXZiy9NXGSEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EKpevkf7PH/NoNk6Yc+16VxjZrBu4xVNQIp7nhTXbJL0n3iVAfll6wRUYL3YEKUf8Z8ltrHhOM6KJ09A3mYwzUHCbdmoFLO776H4qmfFHdy1C1I+h8EUPOQKD5cf7hTNfoLXIjH4tYCUlzo3zQJMYTJ3iG3CHbaVr8syKj8T1WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L7irPire; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8008BC32782;
	Fri, 12 Jul 2024 17:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720803778;
	bh=dlPqmeE8Q4QGZcuhPcklfXhhOofyZPKEXZiy9NXGSEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L7irPireP2nHd3Z0epS3S4z5qFm76PsDU3wCz8KAdQ0iuO/MUTGWnXYd7D+d6+R/u
	 9biOqcuyYkTbWTKm3X//HlaURIT0RpLHx8uHHmNjpRkRkQGKjeOgkKAiVxWIwXHieO
	 isSp2t820qeCcVoiPiewwHcKvEYAjLyDpnopd0fi6gdH7XOr+VBxq6Qrkt9MkKVv/T
	 HuCHpNLJg1yeaSePu8f9qBzm6gfFIRjPxN95kDnrwlu6vuSsLNYW6n0cirTP+7Xpgf
	 svhG+7R+m/5O+8m/mKz7BJJ+jNfvSeZb3izMYWiiLjGMfeWDPC0SHTiEZy2bLwdJJN
	 hAL8+VTe0IYog==
Date: Fri, 12 Jul 2024 18:02:54 +0100
From: Conor Dooley <conor@kernel.org>
To: Marius.Cristea@microchip.com
Cc: jic23@kernel.org, matteomartelli3@gmail.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
	lars@metafoo.de, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: add support for pac1921
Message-ID: <20240712-octopus-coerce-52c52e9cfb41@spud>
References: <20240704-iio-pac1921-v2-0-0deb95a48409@gmail.com>
 <20240704-iio-pac1921-v2-2-0deb95a48409@gmail.com>
 <20240707160442.6bab64c9@jic23-huawei>
 <668bec2a8b23a_6e037017@njaxe.notmuch>
 <88a54c736e0c39ead34dbde53c813526484d767d.camel@microchip.com>
 <668f84e2f3e10_2b423707a@njaxe.notmuch>
 <ea72561a1ab953d3f2a99272c24cf5124c0c72ec.camel@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nR8aezpUfA6LYt7E"
Content-Disposition: inline
In-Reply-To: <ea72561a1ab953d3f2a99272c24cf5124c0c72ec.camel@microchip.com>


--nR8aezpUfA6LYt7E
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 02:41:51PM +0000, Marius.Cristea@microchip.com wrot=
e:
> Hi Matteo,
>=20
>=20
> On Thu, 2024-07-11 at 09:08 +0200, Matteo Martelli wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you
> > know the content is safe
> >=20
> > Hi Marius,
> >=20
> > Marius.Cristea@ wrote:
> > > > I think that the OUT pin might not be used at all in many use
> > > > cases
> > > > so I would
> > > > leave the OUT pin setting as fixed for now and maybe extend it in
> > > > the
> > > > future
> > > > when more use cases arise. I am open to reconsider this though.
> > > >=20
> > >=20
> > > The OUT functionality could be set from the device tree.
> >=20
> > I think this should to be controlled during runtime since it's a
> > configuration
> > that changes the device operation mode and so also what measurements
> > are
> > exposed to the user. An additional DT property could be useful but I
> > am not
> > sure it would fit in the DT scope.
> > Anyway I will leave this for future extensions.
> >=20
>=20
> I think there are 2 different things here. Setting the configuration at
> startup by hard-coding things at probe time or taken those from device
> tree (we can add multiple properties here, as long those properties are
> documented into the dt-binding file) and the user controlled part at
> runtime.
> Because there is no standard interface to change the functionality, it
> will be easy to startup from the device tree and let the user to do
> some minor adjustments and not hardcode configuration.
>=20
>=20
> > ...
> > > > > > ---
> > > > > > =A0.../ABI/testing/sysfs-bus-iio-adc-pac1921=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 |=A0=A0 45 +
> > > > > > =A0MAINTAINERS=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=
=A0=A0 7 +
> > > > > > =A0drivers/iio/adc/Kconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 10 +
> > > > > > =A0drivers/iio/adc/Makefile=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0 1 +
> > > > > > =A0drivers/iio/adc/pac1921.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 1038
> > > > > > ++++++++++++++++++++
> > > > > > =A05 files changed, 1101 insertions(+)
> > > > > >=20
> > > > > > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-
> > > > > > pac1921
> > > > > > b/Documentation/ABI/testing/sysfs-bus-iio-adc-pac1921
> > > > > > new file mode 100644
> > > > > > index 000000000000..4a32e2d4207b
> > > > > > --- /dev/null
> > > > > > +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-pac1921
> > > > > Quite a bit of custom ABI in here.
> > > > >=20
> > > > > Rule of thumb is that custom ABI is more or less pointless ABI
> > > > > for
> > > > > 99% of users
> > > > > because standard userspace won't use it.=A0 So keep that in mind
> > > > > when
> > > > > defining it.
> > > > >=20
> > > > > > @@ -0,0 +1,45 @@
> > > > > > +What:
> > > > > > /sys/bus/iio/devices/iio:deviceX/resolution_bits
> > > > > > +KernelVersion:=A0=A0=A0=A0 6.10
> > > > > > +Contact:=A0=A0 linux-iio@vger.kernel.org
> > > > > > +Description:
> > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ADC measurement resolution. Can=
 be either 11 bits
> > > > > > or
> > > > > > 14 bits
> > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (default). The driver sets the =
same resolution
> > > > > > for
> > > > > > both VBUS and
> > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 VSENSE measurements even if the=
 hardware could be
> > > > > > configured to
> > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 measure VBUS and VSENSE with di=
fferent
> > > > > > resolutions.
> > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 This attribute affects the inte=
gration time: with
> > > > > > 14
> > > > > > bits
> > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 resolution the integration time=
 is increased by a
> > > > > > factor of
> > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1.9 (the driver considers a fac=
tor of 2). See
> > > > > > Table
> > > > > > 4-5 in
> > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 device datasheet for details.
> > > > >=20
> > > > > Is the integration time ever high enough that it matters?
> > > > > People tend not to do power measurement 'quickly'.
> > > > >=20
> > > > > If we are doing it quickly then you'll probably want to be
> > > > > providing buffered
> > > > > support and that does allow you to 'read' the resolution for a
> > > > > part
> > > > > where
> > > > > it changes for some other reason.=A0=A0 I haven't yet understood
> > > > > this
> > > > > case.
> > > >=20
> > > > I will remove this control and fix the resolution bits to 14
> > > > (highest
> > > > value),
> > > > same as the HW default.
> > >=20
> > > The resolution could be set from the device tree. As default it
> > > could
> > > be 14 bits like into the hardware. The user could add
> > > "microchip,low_resolution_voltage" into the device tree in order to
> > > use
> > > only 11 bits for voltage samples.
> >=20
> > I think this should be controlled during runtime since it does not
> > depend on
> > the HW design but more on the user preferences about measurements
> > precision.
> > As Jonathan pointed out, since custom ABIs should be avoided when
> > possible, I
> > will leave it out from now until it becomes necessary and fix the
> > resolution to
> > 14 bits, as the HW default.
> >=20
>=20
> Set the configuration from the device tree, will avoid custom ABI. The
> device tree could be changed also at runtime.

Custom ABI in devicetree is not a replacement for custom ABI in userspace.
If things are fixed by the hardware and non-discoverable, then sure add
devicetree properties - but if it is things like "the user wants 11-bit
mode", then that does not sound suitable for a devicetree property at
all.
And no, you can't just change the devicetree at runtime like that either
as far as I understand - that's gonna cause memory leaks etc and I don't
think can be done from userspace without out-of-tree patches anyway.

Cheers,
Conor.

>=20
> > ...
> > > > > > +What:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
> > > > > > /sys/bus/iio/devices/iio:devices/filters_en
> > > > > > +KernelVersion:=A0=A0=A0=A0 6.10
> > > > > > +Contact:=A0=A0 linux-iio@vger.kernel.org
> > > > > > +Description:
> > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Attribute to enable/disable ADC=
 post filters.
> > > > > > Enabled
> > > > > > by
> > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 default.
> > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 This attribute affects the inte=
gration time: with
> > > > > > filters
> > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 enabled the integration time is=
 increased by 50%.
> > > > > > See
> > > > > > Table 4-5
> > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 in device datasheet for details.
> > > > >=20
> > > > > Do we have any idea what this filter is? Datasheet seems very
> > > > > vague
> > > > > indeed and from
> > > > > a control point of view that makes this largely useless. How
> > > > > does
> > > > > userspace know
> > > > > whether to turn it on?
> > > > >=20
> > > > > We have an existing filter ABI but with so little information
> > > > > no
> > > > > way to fit this in.
> > > > > Gut feeling, leave it on all the time and drop the control
> > > > > interface.
> > > >=20
> > > > I will remove this control and leave it on all the time as the HW
> > > > default.
> > > >=20
> > >=20
> > > The filters could be enabled from the device tree. As default it
> > > could
> > > be disabled.
> > > As a small detail here this is a post processing digital filter
> > > that
> > > could be enabled/disabled inside the PAC module.
> > >=20
> >=20
> > Same reasoning of the resolution_bits parameter applies here. I will
> > fix the
> > filters to enabled, as the HW default. If there is any particular
> > reason to
> > prefer the filters fixed as disabled I will change that.
> >=20
> If the user can change the on/off for the filters it doesn't matter
> what will be the default behavior. Being a single channel device, the
> probability for the user to change the filter behavior during runtime
> is minimal, that was the main reason for letting the user to change the
> configuration from the device tree and not hardcode it.
>=20
> > ...
> > > Thanks,
> > > Marius
> >=20
> > Thanks,
> > Matteo
>=20
> Thanks,
> Marius

--nR8aezpUfA6LYt7E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZpFhvgAKCRB4tDGHoIJi
0hjUAQDW3W3K3mXk5S0YBMh2tS818oJfGzXzfglKonPqGzk6pAD/QCNS3GlZ3wxK
9gKlK64XgLXQWOh9KsMoVlHm4zbJhQA=
=Fi4N
-----END PGP SIGNATURE-----

--nR8aezpUfA6LYt7E--

