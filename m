Return-Path: <linux-iio+bounces-7273-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7129268FE
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 21:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3AA91F24F4B
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 19:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF5E178374;
	Wed,  3 Jul 2024 19:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JBodifq/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5741DA316;
	Wed,  3 Jul 2024 19:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720035060; cv=none; b=LDNrhw8+8jpoCQtXdbc6cdXHmQF7JEF038biC70Pq2yCpHXmc+MohksY9BZCAW5rL7MO5llSKWL4OtyrbNtS+ySEx0zbVrEawC9jcu+5v6VCnyoT6nI5FlW4HMwPWw8dY4ygK1B8flQUkNHklPrmy84XuYzzHzb190QGyZRN4TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720035060; c=relaxed/simple;
	bh=rjSNY4RzMSTu2IXIMmyahTWYDKALhy9Ek5em1QaT9qE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B7BNa52hMuuSkrSrl7/tohMfixq6mi87eKg0FWJ9fHkZeJzfZbDBFN+RgqNYWIZrBg6RJR+gUbXD98dCVNkJK8iUTViSkgMGj116fMdPUuqHAFdQwfp9WUmJlE1+b3o22H7Lmljpgnqug8jLf83NeX0G+025BHodSz/VNMszK0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JBodifq/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA4CC2BD10;
	Wed,  3 Jul 2024 19:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720035060;
	bh=rjSNY4RzMSTu2IXIMmyahTWYDKALhy9Ek5em1QaT9qE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JBodifq/72I9fjll1WZ9sCereaY1jK1EC4FhyvG11yiufCD36FboXhBWhgBgQS+Sg
	 O+dEFokelHN48jfsn3iEzdO5JC8DtnP6Eo77JFM1anC8JiBYKGZUeH2FS+WdRhHPgA
	 YoaOtjIo5EakccA5QvUA6dj+e2rmN4rAfnFRxbJ1JBLG374L1ikfW7dbvFSXaVKeHX
	 iyRDi7kJ3vk9ht0rNkBx3jhb93NSYRlackc4AV/OuHQ3VslRLgxZWZXD07amve8Od/
	 RsxEeP7ATSfsrw0YLmPnOSorie7o2EJ1QtwjoY9WQDUdnGeUIQc0/n1JF29YBBbgxw
	 q4Tt+KrdOd6/g==
Date: Wed, 3 Jul 2024 20:30:56 +0100
From: Conor Dooley <conor@kernel.org>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, devicetree@vger.kernel.org,
	conor+dt@kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: iio: light: stk33xx: add compatible for
 stk3013
Message-ID: <20240703-velvet-badly-904e7afc7cf8@spud>
References: <20240625165122.231182-1-kauschluss@disroot.org>
 <20240625165122.231182-2-kauschluss@disroot.org>
 <20240626-junior-tag-cd3e27c4b140@spud>
 <7f99d77c65bc347bf8b7935220520fdb@disroot.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="F/qmWKmvLM9G6g+N"
Content-Disposition: inline
In-Reply-To: <7f99d77c65bc347bf8b7935220520fdb@disroot.org>


--F/qmWKmvLM9G6g+N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 03, 2024 at 06:31:13PM +0000, Kaustabh Chakraborty wrote:
> On 2024-06-26 16:06, Conor Dooley wrote:
> > On Tue, Jun 25, 2024 at 10:21:06PM +0530, Kaustabh Chakraborty wrote:
> >> Add the compatible string of stk3013 to the existing list.
> >>=20
> >> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> >> ---
> >>  Documentation/devicetree/bindings/iio/light/stk33xx.yaml | 1 +
> >>  1 file changed, 1 insertion(+)
> >>=20
> >> diff --git a/Documentation/devicetree/bindings/iio/light/stk33xx.yaml =
b/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
> >> index f6e22dc9814a..6003da66a7e6 100644
> >> --- a/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
> >> +++ b/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
> >> @@ -19,6 +19,7 @@ allOf:
> >>  properties:
> >>    compatible:
> >>      enum:
> >> +      - sensortek,stk3013
> >=20
> > The driver change suggests that this device is compatible with the
> > existing sensors.
> > Jonathan, could we relax the warning during init
>=20
> What does 'relax' mean here? Earlier there used to be a probing error,
> and now it's just a warning. Is that not relaxed enough?

If it is something intentionally, I don't think a warning is suitable.
It makes the user thing something is wrong.

>=20
> > 	ret =3D stk3310_check_chip_id(chipid);
> > 	if (ret < 0)
> > 		dev_warn(&client->dev, "unknown chip id: 0x%x\n", chipid);
> > and allow fallback compatibles here please?
>=20
> So, you mean something like this in devicetree?
>=20
>   compatible =3D "sensortek,stk3013", "sensortek,stk3310";
>=20
> I mean that's fine, but we also need to change devicetree sources for
> other devices. If that's what we're doing, please let me know how do
> I frame the commits.

Why would you need to change the dts for other devices to add a fallback
for this new compatible that is being added?

> >>        - sensortek,stk3310
> >>        - sensortek,stk3311
> >>        - sensortek,stk3335
> >> --=20
> >> 2.45.2
> >>
>=20
> Thank you.

--F/qmWKmvLM9G6g+N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZoWm8AAKCRB4tDGHoIJi
0hgCAP44DZOsGakqPXYNYBKQh+pKzx3/pNO8U7HF4HNASYw3nAEAzrY9FfTakUaK
tQY1E6ASe+UeCzFYNqI3eG/cTQzVmwo=
=7SuH
-----END PGP SIGNATURE-----

--F/qmWKmvLM9G6g+N--

