Return-Path: <linux-iio+bounces-20365-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AD2AD3CBF
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jun 2025 17:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69BE917DB3E
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jun 2025 15:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EAC23BCF1;
	Tue, 10 Jun 2025 15:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JautMI9p"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A1D22E3FF;
	Tue, 10 Jun 2025 15:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749568637; cv=none; b=t2mtXM+ZxnguWaMrGMB36D6f/ztn6setUsCEsOnfCXTTq8VK3ZlNZnLRV2/r1aPypWQvPOMf5myNqURYxLkxsIzq7su1k+yunQFtFVTmZWGbaaZApfFH+yz4q7bo1+qU53pto2aDQD0OnenCv7CovK36qmANX9c5faBTcoKfoxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749568637; c=relaxed/simple;
	bh=GANCpbbjp1dEyMei37sYfj7Nawi1r4Qtwq/RVj9ktGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJ06P6KJSLrcR4WkNAtB8vQ/Trb1acec5eSj3R0GiZWtEazqYAdT1YxTdtsHwThrlMr3Tv+Fe3wvCQyC7ctM1eKYotY6aivqBrgkf5sDXgHi43vr/XBa/4FXZtcS1WAH0JLRlsODt2F0g9GiJFSNq88Heqhrd9aM/l/3HvfHhWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JautMI9p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 100A8C4CEED;
	Tue, 10 Jun 2025 15:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749568636;
	bh=GANCpbbjp1dEyMei37sYfj7Nawi1r4Qtwq/RVj9ktGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JautMI9p9ONh4STBnvMad/8IOkXxrGXSRniQtStJW5TppexAFWjuo8+6LUw+fzbRD
	 PV/4ZH5VkK2I/fjGrlBbqsGqa7koGjDPpcI1hN/aPzqCzEs+P5gFgyXnUKnKDwWA5+
	 qavNk3G10CCqFrsaeaf4++xDYJE9g3WyR7Lnd2slSa54Dnt+2iQ+KKkk7CFWlxXIjX
	 WqQKFUku/h1+qPQPmLlgPb6L3vZU5gg5D5VBxn8VZWllIOl2OVE0st4B5e381AY3UT
	 eeH2/uTk8n579lEphACBsROfnbxsP78fZ/wI9fQSL9q7cgO2CNbxXCX87tGRa6YrYj
	 OhJJj9w1A3Aww==
Date: Tue, 10 Jun 2025 16:17:11 +0100
From: Conor Dooley <conor@kernel.org>
To: Victor.Duicu@microchip.com
Cc: dlechner@baylibre.com, nuno.sa@analog.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, robh@kernel.org, jic23@kernel.org,
	krzk+dt@kernel.org, andy@kernel.org, linux-kernel@vger.kernel.org,
	Marius.Cristea@microchip.com, conor+dt@kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: temperature: add support for
 MCP998X
Message-ID: <20250610-thong-trump-f131522201c4@spud>
References: <20250529093628.15042-1-victor.duicu@microchip.com>
 <20250529093628.15042-2-victor.duicu@microchip.com>
 <0f68e3f9-cba5-4df3-8e56-2cccbccf35ce@baylibre.com>
 <20250530-dramatize-camisole-0a1aa9a38281@spud>
 <91c1d757a4ac051c115a821779a8c1fba764ea05.camel@microchip.com>
 <20250606-unfeeling-legacy-c7eab453b062@spud>
 <c5de1b615c40cd4d4380cf5f340bda3da23f4069.camel@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TMB2KrwSJzB3PpjT"
Content-Disposition: inline
In-Reply-To: <c5de1b615c40cd4d4380cf5f340bda3da23f4069.camel@microchip.com>


--TMB2KrwSJzB3PpjT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 01:29:01PM +0000, Victor.Duicu@microchip.com wrote:
> On Fri, 2025-06-06 at 16:15 +0100, Conor Dooley wrote:
> > Jonathan,
> >=20
> > On Mon, Jun 02, 2025 at 02:48:52PM +0000,
> > Victor.Duicu@microchip.com=A0wrote:
> > > On Fri, 2025-05-30 at 16:55 +0100, Conor Dooley wrote:
> > > > On Thu, May 29, 2025 at 01:13:38PM -0500, David Lechner wrote:
> > > > > On 5/29/25 4:36 AM, victor.duicu@microchip.com=A0wrote:
> > > > > > From: Victor Duicu <victor.duicu@microchip.com>
> > > > > > +=A0 microchip,recd12:
> > > > > > +=A0=A0=A0 description:
> > > > > > +=A0=A0=A0=A0=A0 Enable resistance error correction for external
> > > > > > channels 1
> > > > > > and 2.
> > > > > > +=A0=A0=A0=A0=A0 Omit this tag to disable REC for channels 1 an=
d 2.
> > > > > > +=A0=A0=A0 type: boolean
> > > > > > +
> > > > > > +=A0 microchip,recd34:
> > > > > > +=A0=A0=A0 description:
> > > > > > +=A0=A0=A0=A0=A0 Enable resistance error correction for external
> > > > > > channels 3
> > > > > > and 4.
> > > > > > +=A0=A0=A0=A0=A0 Omit this tag to disable REC for channels 3 an=
d 4.
> > > >=20
> > > > Why are these two devicetree properties, rather than runtime
> > > > controls?
> > >=20
> > > The parasitic resistance added to the series resistance is
> > > dependent
> > > only on the circuit.=A0
> > > It is possible for the chip and the transistor to be at some
> > > distance
> > > from each other. The manufacturer can approximate the error added
> > > and
> > > decide if resistance error correction should be applied.
> >=20
> > I don't think I buy this line of argument. The property is not
> > describing the hardware, it's literally being used as a toggle for
> > some
> > software feature. It'd be more acceptable if it indicated that the
> > chip
> > and transistor were distant, leaving software to make a decision on
> > what
> > that meant. One user (say bsd) might want decide that the driver
> > should
> > always enable it, but another (say linux) might expose it as a
> > control
> > to userspace defaulting based the dt property.
> > Additionally, the name of the property is pretty awful, and does not
> > even hint at what it's doing - and there's no mention of why channel
> > 1/2
> > and 3/4 are bound together.
> >=20
> You are correct that the parameters recd12 and recd34 do not directly
> describe the hardware, but they control a software feature of the chip
> itself. Resistance error correction is capable of counterbalancing
> the parasitic resistance added to the external diodes, which can be
> significant.

> The manufacturer knows where the chip and diode are and can decide if
> correction is necessary. The user does not have that insight.

The user _may_ not have it. The properties should not be written such
that they exclude the control of these things from userspace, and just
indicate that the hardware configuration has the chip and diode
sufficiently far apart that the feature can help.


> I can change the name of the parameter to something like
> resistance_err_correction and mention in the description which channels
> are affected.

No _s are allowed in properties, so bear that in mind. Again, I don't
think the property should be responsible for turning it on, just
indicate that there is a parasitic resistance, so and the name should
really be something that indicates a parasitic resistance. E.g.
microchip,parasitic-res-on-channel1. Software (be it userspace or
driver) can then made a decision about turning on the error correction
with that information.

> > > The user cannot influence the parasitic resistance nor calculate
> > > it.
> >=20
> > I don't think that's super relevant here, since the property has
> > nothing
> > to do with influencing or calculating the value. I meant deciding
> > whether
> > or not the correction is applied, just as the dt property you propose
> > does now.
> >=20
> > Cheers,
> > Conor.
>=20
> Kind Regards,
> Victor Duicu

--TMB2KrwSJzB3PpjT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaEhMdwAKCRB4tDGHoIJi
0knNAQD3eZV0z01TD2z03LI5AOH9ZO9lIwOXo6GAjoCVVJhMGwEA1psJeGy8ijEA
ueWlKRe/8keetXzAuYBeRsXWYOJAAQo=
=Gp4g
-----END PGP SIGNATURE-----

--TMB2KrwSJzB3PpjT--

