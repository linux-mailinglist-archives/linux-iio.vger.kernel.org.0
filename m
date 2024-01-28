Return-Path: <linux-iio+bounces-1969-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FDF83F4FC
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jan 2024 11:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EED50282663
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jan 2024 10:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997C81B286;
	Sun, 28 Jan 2024 10:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T5w1lasS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DA2DF5C;
	Sun, 28 Jan 2024 10:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706438127; cv=none; b=Taehd8PHrtSWM2j1wwAw+GEm2FmTDSt0ug1oOLxwSkkl+2O1kc7b2BelkmXxQqWnnYJ7oYMphjA2+RzKgXbK8KJPoVGxKe1XessJc3tFN9dn6C4NUDwJnOxJoxm8or4nKkWCeYU0x9C6wH7RJrtV0OGdjoWarbmWxnopzsyVpBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706438127; c=relaxed/simple;
	bh=wCBfczLYWZi23Ma8LOhL+q4Ee7XSMSK0TMBtXro6oJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZBr9xccRdCdsNleiMUWifmYW8OXuB/8bvdzILYAgzNCOAB/dkjv0a38d0r5Nz8jCMCJKdJUMcHM081e4MkRLxIpCiGBi7STqOotWpxuJUN7AC622TYk5irVaJG6VFrGAB/+CQ3lxgj+POl+FhlB4FTqX66rFpDpjUFNNyMy9+kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T5w1lasS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43FC0C433F1;
	Sun, 28 Jan 2024 10:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706438126;
	bh=wCBfczLYWZi23Ma8LOhL+q4Ee7XSMSK0TMBtXro6oJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T5w1lasSzVTLVgcoO0ySnFhN1L2nvWJUZVHjR2rlDh02I5E9A6hM4QPkZVf85bp5u
	 glHg7vwWYA6j1GUdRpCECNIS16JJGuI8D2utPQQjSQwuOQn7DV3jgJKSUeA3cmpecP
	 xs4pGdfI9v4MyVVBUBcWXV3dWo9v48BmE2qkJkDemtz86D8TflDZDuGXxTDlgpt80n
	 htOp74cwYfXuPKBLBdXZoDy/viNw3/wK23uWuDXr4fkh0Gtw9KVmSMg8lRS1Wfuoyn
	 1F2JeWwlmWofgcaXzHK8yI7B2FbcvJCJIQehTnW89sJ/7oGwsVGXhdKNRsi9VXNmVg
	 PmQVSYct2zhDQ==
Date: Sun, 28 Jan 2024 11:35:23 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, lorenzo.bianconi@redhat.com,
	devicetree@vger.kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, mario.tesi@st.com,
	armando.visconti@st.com
Subject: Re: [PATCH 2/2] dt-bindings: iio: imu: st_lsm6dsx: add asm330lhhxg1
Message-ID: <ZbYt673vc-Cg0s6A@lore-desk>
References: <cover.1706093274.git.lorenzo@kernel.org>
 <90d675537e58c9c339545a895e8164a843821682.1706093274.git.lorenzo@kernel.org>
 <20240127150426.4994a6a0@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4+CyQ+1/XLnFqDWJ"
Content-Disposition: inline
In-Reply-To: <20240127150426.4994a6a0@jic23-huawei>


--4+CyQ+1/XLnFqDWJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Wed, 24 Jan 2024 11:52:34 +0100
> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>=20
> > Add device bindings for asm330lhhxg1 IMU sensor.
> > Use asm330lhhx as fallback device for asm330lhhxg1 since it implements
> > all the features currently supported by asm330lhhxg1.
>=20
> Can we clarify if the hardware of the asm330lhhxg1 supports
> 1) Exactly the same features as the asm330lhhx
>    (Valid use for a fallback compatible, because we might find
>     bugs etc in future).
> 2) More features, but the asm330lhhx features set is a subset.
>    (Most valid use for a fallback compatible)

Hi Jonathan,

afaik asm330lhhx supports a subset of asm330lhhxg1 features (adding st folk=
s in
cc for some clarification here) but they are not implemented in st_lsm6dsx.

Regards,
Lorenzo

> 3) Different features from the asm330llhhx but driver only supports
>    a set both support? (this is a problem)
>=20
> I 'think' it is 2 from your text, but I'm not 100% sure I've understood
> correctly.
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
> > =20
> >    reg:
> >      maxItems: 1
>=20

--4+CyQ+1/XLnFqDWJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZbYt6gAKCRA6cBh0uS2t
rNXKAP9rhE2MrTI0D/RyJD4gtcyJBO/ZwVDJHebaZz62sfImRAEA0zs0JmMq+hmX
6dZTDABm6PGxch6zZCLOewTvMriS6A8=
=BHL/
-----END PGP SIGNATURE-----

--4+CyQ+1/XLnFqDWJ--

