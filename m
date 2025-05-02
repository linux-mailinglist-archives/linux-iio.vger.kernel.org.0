Return-Path: <linux-iio+bounces-18983-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9FFAA70CB
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 13:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2B864A5239
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 11:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4335B24633C;
	Fri,  2 May 2025 11:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T05m8mJ4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18A8244686;
	Fri,  2 May 2025 11:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746186202; cv=none; b=lxxeMhkweegTG857KZ2qomPdYbQAIU80Lb2LCeuWbqdEnRZ0KzEJqSjOO7SfpT7kIIJVCWHOXt7zV0OYddaeaPB2yF5F/eSUF0AG526pJ1R/WbEI1D5/esN7p0GOh4CMHR2qsT6zXJa6pUb72DYF4PHdtZPaPC+K7a3jtbELggc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746186202; c=relaxed/simple;
	bh=aWaWeIVruQo2QDXJvl6mXOqBikKY5OkUj65q+GvireU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u3m+PLf6i1rgFtJLluvYJydq8/2YFcxEfIsPwDSko3mSHQUh+izPbG6ly2fCAzuLt+nR03m7GubqY9uQucLf3cyx5cD4tF6AEdXn3Tg1o3Rfx/jCQZOidD9U1P20bJWGcE5DRk0g/kUWL0VrTFEZVwpYtf0zggrUm5LSPhhzD5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T05m8mJ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83F49C4CEEE;
	Fri,  2 May 2025 11:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746186201;
	bh=aWaWeIVruQo2QDXJvl6mXOqBikKY5OkUj65q+GvireU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T05m8mJ4SJEtv3oMaPq8TV3fqx5eklcsotN1dJdEJfIWLL/CQ8x6Q67y5NFRVx/B5
	 R8Oz5Na85YPlNlOViisqv0URkNEbJTFwxLVozQrlFbG7bv1GQbTmb+U1HZBaNRI6ok
	 zKynbiaYDI6FjLAh1P1MaKqqR597LDl9LMyUB+mIRNiCJLaZ7I2c/1QCiehuhbwcQi
	 imLnEXIzzGTKhBXcfYe3McKZmWJevKLE4bwU1MYr7dmBwoSmwRziHK+cCVRVlV4d81
	 FbASYJOIQMla5BBh17ZWI/+Eo31xBdcf5qeirIT1kb2Cz+/iVC/0v8Vz1zbGeNS1jU
	 gsQITn8aI4JNg==
Date: Fri, 2 May 2025 20:43:18 +0900
From: William Breathitt Gray <wbg@kernel.org>
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"o.rempel@pengutronix.de" <o.rempel@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] counter: interrupt-cnt: Protect enable/disable OPs with
 mutex
Message-ID: <aBSv1pJ1mulT78gn@ishi>
References: <20250331163642.2382651-1-alexander.sverdlin@siemens.com>
 <jir0aD7w3brmbPDdhC4xAhaEKCp-g08TBmtdn785u_Z5M77ZHMhsK7UoamaROSznl2WmcUmPSnocgVnCSYmUYg==@protonmail.internalid>
 <8394ef31a75fdf9122331ecb97dd6f986d5026f1.camel@siemens.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2FnaEQLJIxit3zw2"
Content-Disposition: inline
In-Reply-To: <8394ef31a75fdf9122331ecb97dd6f986d5026f1.camel@siemens.com>


--2FnaEQLJIxit3zw2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 02, 2025 at 09:24:20AM +0000, Sverdlin, Alexander wrote:
> Dear maintainers,
>=20
> On Mon, 2025-03-31 at 18:36 +0200, A. Sverdlin wrote:
> > From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> >
> > Enable/disable seems to be racy on SMP, consider the following scenario:
> >
> > CPU0					CPU1
> >
> > interrupt_cnt_enable_write(true)
> > {
> > 	if (priv->enabled =3D=3D enable)
> > 		return 0;
> >
> > 	if (enable) {
> > 		priv->enabled =3D true;
> > 					interrupt_cnt_enable_write(false)
> > 					{
> > 						if (priv->enabled =3D=3D enable)
> > 							return 0;
> >
> > 						if (enable) {
> > 							priv->enabled =3D true;
> > 							enable_irq(priv->irq);
> > 						} else {
> > 							disable_irq(priv->irq)
> > 							priv->enabled =3D false;
> > 						}
> > 		enable_irq(priv->irq);
> > 	} else {
> > 		disable_irq(priv->irq);
> > 		priv->enabled =3D false;
> > 	}
> >
> > The above would result in priv->enabled =3D=3D false, but IRQ left enab=
led.
> > Protect both write (above race) and read (to propagate the value on SMP)
> > callbacks with a mutex.
> >
> > Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
>=20
> I've noticed that the patch has been marked as "Changes Requested" in
> the patchwork, could it be a mistake? Because I never received any
> change request.

Hi Alexander,

I can't comment on the patchwork status because I don't use that
service, but I apologize nonetheless for the delay in responding to your
patch submission. I'm hoping for an Ack from Oleksij, but this is a
pretty straight-forward fix that I'll be happy to pick it up regardless.

Would you provide a Fixes line so the stable trees can pick this up for
the necessary kernel versions?

Thanks,

William Breathitt Gray

--2FnaEQLJIxit3zw2
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCaBSv1QAKCRC1SFbKvhIj
K5AXAQCUKyd24kH3cw/KsWiKcBDbzgF5wILTzRCXBD22B/UhVwD+J7m3fdEqH3uo
oViPsGv5sUsmxgjpIZkyJ+emaNI0DAU=
=oIr1
-----END PGP SIGNATURE-----

--2FnaEQLJIxit3zw2--

