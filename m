Return-Path: <linux-iio+bounces-2013-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC418406FE
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jan 2024 14:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CF79B26907
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jan 2024 13:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DD36312A;
	Mon, 29 Jan 2024 13:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JL4uGeLc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD97634EF;
	Mon, 29 Jan 2024 13:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706535031; cv=none; b=jLiPrtUo7wPd4SPemzluEFOGt4pg5kjOIv5CjIHjxMEP4QxlxJoXGmiIprSDWdDTzAA6nDdBAE6bo6JHr/4m7hPVAoIuAmp8WdGnngRXqLkn/MZURNXOwEhdO8QhDLyk4F3IJ8vaLCbgAtY85q4GyRgnbQS6/4RzNL904dquQs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706535031; c=relaxed/simple;
	bh=4Lb0i25yzp7HX7H/A2qgGY5TWZmbLFOQfXMyvqJgC0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZXyhrA3QZE5mJzpiDg1pCQMDV1H0Tf0cE2waU2CO+zpMffrqhpow0Pn4HfnHOE/rHMpN9iv2rOZVyTU/3htt2lfBT7KX9IMK17cxZwX3JY2rLTb9w6GyB+SJPhm+ag515je6slRWJm2/U4ekVxDuWbvBivMGYg+dc8p1xLHgdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JL4uGeLc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 690C6C433F1;
	Mon, 29 Jan 2024 13:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706535030;
	bh=4Lb0i25yzp7HX7H/A2qgGY5TWZmbLFOQfXMyvqJgC0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JL4uGeLc4NRjb/5QBU/SVnEubW3h3wslwF1eajyydu2zdO7nuh6FGLmlVi0k0f6c7
	 +S5HH/0WaQieVffE0MWqRTicUqvtX7F2QtKMQNnumUidRkRpXs9h5VhpZaoIuNIQi6
	 KMUjCwGNstwGvjGGUHF4AmQzokujihXR0zCnzxB7NoyTWrF3I7KGoIjSZm3hcPN70P
	 shIWkHgbKPDTy5p1rdkGwx5btlKz5VcMRXLTl2RUjlzHOPIxugkasoZFEIM/KWYsBu
	 sNnkwWKkF3EV7Wccrf0+Rx2U1GvizDC+NNOoRRhieMOumT2/ix6iizCYGVxcGczOAZ
	 6PSytpjYT3zEw==
Date: Mon, 29 Jan 2024 14:30:27 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org,
	lorenzo.bianconi@redhat.com, devicetree@vger.kernel.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH v2 3/3] dt-bindings: iio: imu: st_lsm6dsx: add
 asm330lhhxg1
Message-ID: <ZbeoczLjkGG8pogL@lore-desk>
References: <cover.1706441008.git.lorenzo@kernel.org>
 <189b903e939e15d98d198db60e2ca0619b116870.1706441008.git.lorenzo@kernel.org>
 <51f4782f-09d8-448f-a693-e0c711bee18d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PVQORnGgn4VHpHAU"
Content-Disposition: inline
In-Reply-To: <51f4782f-09d8-448f-a693-e0c711bee18d@linaro.org>


--PVQORnGgn4VHpHAU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 28/01/2024 12:25, Lorenzo Bianconi wrote:
> > Add device bindings for asm330lhhxg1 IMU sensor.
> > Use asm330lhhx as fallback device for asm330lhhxg1 since it implements
> > all the features currently supported by asm330lhhxg1.
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml | 3 +++
> >  1 file changed, 3 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml =
b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
> > index 28b667a9cb76..7ba3de66a2e1 100644
> > --- a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
> > +++ b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
> > @@ -49,6 +49,9 @@ properties:
> >        - items:
> >            - const: st,asm330lhb
> >            - const: st,asm330lhh
> > +      - items:
> > +          - const: st,asm330lhhxg1
> > +          - const: st,asm330lhhx
>=20
> lhhx is compatible with st,lsm6dsr, so some explanation would be useful
> why it is not included here.
>=20
> Best regards,
> Krzysztof
>=20

Do you mean something like:

diff --git a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml b/Do=
cumentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
index 7ba3de66a2e1..92feba6e2427 100644
--- a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
@@ -35,6 +35,7 @@ properties:
           - st,lsm6dsv
           - st,lsm6dso16is
       - items:
+          - const: st,asm330lhhxg1
           - const: st,asm330lhhx
           - const: st,lsm6dsr
       - items:

Regards,
Lorenzo

--PVQORnGgn4VHpHAU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZbeocwAKCRA6cBh0uS2t
rHkrAQCECqeDQAbJzZYojDvuVMR3R02ujruwuVyJYCEQAaOM8gEA3qPi9uaW9crf
r+CJLacKPG+Z1xnlFjRlYVxeDQBUBQE=
=16Bx
-----END PGP SIGNATURE-----

--PVQORnGgn4VHpHAU--

