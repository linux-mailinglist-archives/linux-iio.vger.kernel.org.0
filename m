Return-Path: <linux-iio+bounces-20272-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA84AD04F9
	for <lists+linux-iio@lfdr.de>; Fri,  6 Jun 2025 17:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB1FB17186F
	for <lists+linux-iio@lfdr.de>; Fri,  6 Jun 2025 15:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B641B040D;
	Fri,  6 Jun 2025 15:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O9GYbl9q"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EEA14C5B0;
	Fri,  6 Jun 2025 15:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749222924; cv=none; b=asspCn5MHpQyF/PlceiEy2n1mhwLLUjlKKKyOehDdKPnZ07GjIXPJ1IZBGuvQmp3hOPTK5ZasOUbGVjtBZsEJBX304L7cGQ1R2+/JT9hCQT753sg41kyYFGdv+0rMx2A8Q8+PQZvBL7aOoAd2aVccHCxC1UUj7oBMR1CcNL1hJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749222924; c=relaxed/simple;
	bh=HpLZ1rPClxi7MC6tDS7NrB9TQE+s3gTEHmZEc2dNsRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=diYEXzERd8oS7cYhSuGBW8dsAq46jKJ0OF8HX6rnwlnFF5x5K9vg9UZMW+dbN9Bt5zNFF5XDm1ijsrPyKfUBL6lUiX40JcpfNMgKGr2yMXyfzJhkktA18VN3XzsaPA3NF3fxmZSETByC5/x+gAdbmkOP47N8i5HLuWHcoFu2Gmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O9GYbl9q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBAF6C4CEEB;
	Fri,  6 Jun 2025 15:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749222924;
	bh=HpLZ1rPClxi7MC6tDS7NrB9TQE+s3gTEHmZEc2dNsRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O9GYbl9qwgykRIFjSKYPk4F/tbiiyI2s25RztmlY5I8KfxA9mv0MV17oTpL9v+AG6
	 i9OG06zP0svvVex+7zeLRRY1QZ+ssd44RFn5y942ceUuU8ydMOTYFU7GNS63zMujUh
	 QRcCmgEZEaO8rQ34q3EkDJ3VgVzDQB2zmr1lQYfFMV4k/SHkVUcKChsd5cGg1bFrqy
	 qssB/YNHGL0VVyQVcGXvCPRY/eu1vLGV75EH6Pu+DNyRmEB4vri669WOmp/5L3NJcJ
	 u3EQ0HQgNYQD/U3MBP++4/BUW8iwaMmPMrFOLi5RdhRwqnYdwNnEjtUKJwnioviDG1
	 edESQmeIyeKGg==
Date: Fri, 6 Jun 2025 16:15:19 +0100
From: Conor Dooley <conor@kernel.org>
To: Victor.Duicu@microchip.com
Cc: dlechner@baylibre.com, nuno.sa@analog.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, robh@kernel.org, jic23@kernel.org,
	krzk+dt@kernel.org, andy@kernel.org, linux-kernel@vger.kernel.org,
	Marius.Cristea@microchip.com, conor+dt@kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: temperature: add support for
 MCP998X
Message-ID: <20250606-unfeeling-legacy-c7eab453b062@spud>
References: <20250529093628.15042-1-victor.duicu@microchip.com>
 <20250529093628.15042-2-victor.duicu@microchip.com>
 <0f68e3f9-cba5-4df3-8e56-2cccbccf35ce@baylibre.com>
 <20250530-dramatize-camisole-0a1aa9a38281@spud>
 <91c1d757a4ac051c115a821779a8c1fba764ea05.camel@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rOBXgDHc5asVEnsI"
Content-Disposition: inline
In-Reply-To: <91c1d757a4ac051c115a821779a8c1fba764ea05.camel@microchip.com>


--rOBXgDHc5asVEnsI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Jonathan,

On Mon, Jun 02, 2025 at 02:48:52PM +0000, Victor.Duicu@microchip.com wrote:
> On Fri, 2025-05-30 at 16:55 +0100, Conor Dooley wrote:
> > On Thu, May 29, 2025 at 01:13:38PM -0500, David Lechner wrote:
> > > On 5/29/25 4:36 AM, victor.duicu@microchip.com=A0wrote:
> > > > From: Victor Duicu <victor.duicu@microchip.com>
> > > > +=A0 microchip,recd12:
> > > > +=A0=A0=A0 description:
> > > > +=A0=A0=A0=A0=A0 Enable resistance error correction for external ch=
annels 1
> > > > and 2.
> > > > +=A0=A0=A0=A0=A0 Omit this tag to disable REC for channels 1 and 2.
> > > > +=A0=A0=A0 type: boolean
> > > > +
> > > > +=A0 microchip,recd34:
> > > > +=A0=A0=A0 description:
> > > > +=A0=A0=A0=A0=A0 Enable resistance error correction for external ch=
annels 3
> > > > and 4.
> > > > +=A0=A0=A0=A0=A0 Omit this tag to disable REC for channels 3 and 4.
> >=20
> > Why are these two devicetree properties, rather than runtime
> > controls?
>=20
> The parasitic resistance added to the series resistance is dependent
> only on the circuit.=A0
> It is possible for the chip and the transistor to be at some distance
> from each other. The manufacturer can approximate the error added and
> decide if resistance error correction should be applied.

I don't think I buy this line of argument. The property is not
describing the hardware, it's literally being used as a toggle for some
software feature. It'd be more acceptable if it indicated that the chip
and transistor were distant, leaving software to make a decision on what
that meant. One user (say bsd) might want decide that the driver should
always enable it, but another (say linux) might expose it as a control
to userspace defaulting based the dt property.
Additionally, the name of the property is pretty awful, and does not
even hint at what it's doing - and there's no mention of why channel 1/2
and 3/4 are bound together.

> The user cannot influence the parasitic resistance nor calculate it.

I don't think that's super relevant here, since the property has nothing
to do with influencing or calculating the value. I meant deciding whether
or not the correction is applied, just as the dt property you propose
does now.

Cheers,
Conor.

--rOBXgDHc5asVEnsI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaEMGBwAKCRB4tDGHoIJi
0pxQAP9tTTrVpJUEVSo8w2luowpdXWHkIwEmzGJRQxsvWHLAqQEA7cPYTT2cxcpC
2oWW2XnwxZ6f/4UpPGb81sV59m7imwg=
=SSGP
-----END PGP SIGNATURE-----

--rOBXgDHc5asVEnsI--

