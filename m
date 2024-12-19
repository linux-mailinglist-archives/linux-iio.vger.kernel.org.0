Return-Path: <linux-iio+bounces-13681-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAA99F8329
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 19:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1182C163301
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 18:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE51D1A08CA;
	Thu, 19 Dec 2024 18:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1+a+rDN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826E1194C96;
	Thu, 19 Dec 2024 18:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734632475; cv=none; b=E2cqs4BWhQzKk5nnROJdAqhcoULPgINhIkPImVniFhEKM0H14z8c/uPq/xoARWy7BGDUvWdjwqtIL6x/9g/Eq1Fq1Hd++4QwrXMs4fFwnXQGz3UcKuZB/74TScBaU4NcAOe/4QINZ5xecaT9pOG+hs+seC21jVc/qIQzsfGluM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734632475; c=relaxed/simple;
	bh=KStSTCaoxijgxnmT/IjZ7gGMW3smHpzDkQnOb89b6i0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bDEB3jy6l99roie5+XnXmWfYtFncRUgUG+2ofoAhAsYyDNaTl9165x0kCgff+HhQQeX9zccRiceafxDc8IDRfoHQoUnSkjAnk5mHXPGgxXqffYS8+2VWVf5tQ/sD6MMOjli0p8N7L9jOVCX1EReIjYjX/l4iGKP5GCGUgLHwbE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1+a+rDN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14EA1C4CECE;
	Thu, 19 Dec 2024 18:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734632475;
	bh=KStSTCaoxijgxnmT/IjZ7gGMW3smHpzDkQnOb89b6i0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U1+a+rDNdPPFd17PozQFKvDn1JVERFr700oXiyhtVQBtrNRTB3o3aGEETqIfq2J7L
	 p6t6wy6g3r2xsQKdpdB/LakxkI69sWP2WYcoVxJ0rabLooMfBimAWspElW9sRA1lJh
	 DfQzjThwG3HkG9fD5X44xh2kOP7Q0MTw1iItaa40JyoQytlPVXLCy2foh0U+F8ov55
	 9PyYLkQHhWfeIP9FEtNpg/QBiX1YrTJVQxg0t/wDw8RGcS6PkpHOQNlV8q4lV0AEZN
	 Lln1aisCPVbx4SKKfD0NEVEiXBTOkYjtLgJzB+wYzY+pw15/b+TdYZZOa+8bNEAupR
	 iOOKQVnDAJOvg==
Date: Thu, 19 Dec 2024 18:21:10 +0000
From: Conor Dooley <conor@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lothar Rubusch <l.rubusch@gmail.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	eraretuya@gmail.com
Subject: Re: [PATCH v7 3/7] dt-bindings: iio: accel: adxl345: add
 interrupt-names
Message-ID: <20241219-pregame-blot-e15ff0fbfe45@spud>
References: <20241213211909.40896-1-l.rubusch@gmail.com>
 <20241213211909.40896-4-l.rubusch@gmail.com>
 <20241214121057.5b12a236@jic23-huawei>
 <20241215-satisfied-expiring-9200ec935768@spud>
 <20241219175815.797b376a@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JWhiqjxceXA0OMS3"
Content-Disposition: inline
In-Reply-To: <20241219175815.797b376a@jic23-huawei>


--JWhiqjxceXA0OMS3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 05:58:15PM +0000, Jonathan Cameron wrote:
> On Sun, 15 Dec 2024 14:56:58 +0000
> Conor Dooley <conor@kernel.org> wrote:
>=20
> > On Sat, Dec 14, 2024 at 12:10:57PM +0000, Jonathan Cameron wrote:
> > > On Fri, 13 Dec 2024 21:19:05 +0000
> > > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > >  =20
> > > > Add interrupt-names INT1 and INT2 for the two interrupt lines of the
> > > > sensor.
> > > >=20
> > > > When one of the two interrupt lines is connected, the interrupt as =
its
> > > > interrupt-name, need to be declared in the devicetree. The driver t=
hen
> > > > configures the sensor to indicate its events on either INT1 or INT2.
> > > >=20
> > > > If no interrupt is configured, then no interrupt-name should be
> > > > configured, and vice versa. In this case the sensor runs in FIFO BY=
PASS
> > > > mode. This allows sensor measurements, but none of the sensor event=
s.
> > > >=20
> > > > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com> =20
> > >=20
> > > Just to repeat what I sent in reply to v6 (well after you'd posted th=
is).
> > > Maybe we can maintain compatibility with the binding before this by a=
dding
> > > a default of INT1. =20
> >=20
> > But can you make that assumption? If we did, and it's not universally
> > true, we break systems that had INT2 connected that previously worked.
>=20
> I guess there is a possibility of a driver in some other OS assuming INT2=
, but
> seems an odd 'default' choice.

Ye, I think that it is unlikely a driver author would think that way.

> Also odd for a writer of DT for a platform
> to assume it.

I agree, I think it is unlikely that someone would assume it'd work like
this. I think a lack of attention paid to the schematic of the board is
a more likely culprit.

> There is a thing that comes up in spec orgs when discussing whether to
> rush out an errata.  "Is this bug something people would get wrong
> thinking the answer was clear, or something where the would ask a questio=
n?"
> Anyone who thinks INT2 is the obvious choice for me falls into the would
> ask category.
>=20
> However, in the linux driver we would would go from assuming no interrupts
> to assuming the wrong one.  That's indeed bad.  So I guess this doesn't w=
ork.
> Oh well no default it is.

I don't think you really lose anything from having no default. The
driver works just fine without the interrupt, so the albeit small risk
just doesn't seem worth it.

--JWhiqjxceXA0OMS3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ2RkFgAKCRB4tDGHoIJi
0itwAQDSa7yw1vcG8HpgCMxnNfO/VCkpSZkMU5pnA+ct4zwKMQEAmtAhKFrDlBGr
60dRHpzdMx56ysbv9mFYdMWKjW35nAA=
=eOyI
-----END PGP SIGNATURE-----

--JWhiqjxceXA0OMS3--

