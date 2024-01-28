Return-Path: <linux-iio+bounces-1979-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 213C983F5AE
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jan 2024 14:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D38781F22D09
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jan 2024 13:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B2D2376A;
	Sun, 28 Jan 2024 13:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c8fBA1a4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58B22375A;
	Sun, 28 Jan 2024 13:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706450235; cv=none; b=MaXte7Uhmgk3Ym3d6radNXV1tO1BgSO70N0N3Tzlr5iwqpWx7Pz7E91ubMVsdDQzP5nFyLT26x7IEUgchyARppC0qUlOjX6ec3KW7oyfA6nxk8Od6/wDOyP2iOQJAfyQYwUM4/z6JrimNamDt5lP/yurNRP/K0CQW+W2xQYIbk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706450235; c=relaxed/simple;
	bh=0iclYHlQ7+8gDvQeikde5z0ZE7mEbXDlk0AjyQfxYf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HhGN3ZW7Gq8jva9CCoaihO7XPAcCBFb2PTMbN+f+7zBtPKwJcqHbvAC7D+fAeZXmlmsu8bbpPLYRn4+V1aBSrvqfx8oAyU+BxwRRdnhDmaRjTAWdsGCYIezfi5WFq+LwPAJ4fbRCf6iJlxGCPQ9iCgnt2FfNGdID9ROwsc4Qj4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c8fBA1a4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4EAAC433C7;
	Sun, 28 Jan 2024 13:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706450234;
	bh=0iclYHlQ7+8gDvQeikde5z0ZE7mEbXDlk0AjyQfxYf0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c8fBA1a4y68+n9cv/GlMz9NFhIBA1A4yKckENlkH3A69qAqlEZv7lz1BwPz/WS9Nj
	 Az+yQovZOqOBf/TtYsjNnweVcPHLML2X0bMotGsf9HRNXWUr0Mja2j6aFfoA6eIQXE
	 Ebahfv4iu3MVGCpTQpXgnYRjZ6Ms9BUXyd3dOUVWnEiBKqLwPw+U4ZdIU8LkqSTgFz
	 mxyQXcl2CcZR0sx43QDs9wkHq9HTE2RagGVZNukb+50wlLJ6vrEQDtWZqP6f5RlJIp
	 J67C8FR5fVJ7yFm/VfnvNHeSNg6WBK1s0IW5jqMVu0Go4aii8W/dDS8hBbxxgnS0+y
	 y50WhJOJc1rsQ==
Date: Sun, 28 Jan 2024 14:57:10 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, lorenzo.bianconi@redhat.com,
	devicetree@vger.kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH v2 3/3] dt-bindings: iio: imu: st_lsm6dsx: add
 asm330lhhxg1
Message-ID: <ZbZdNjauGPDfeKTk@lore-desk>
References: <cover.1706441008.git.lorenzo@kernel.org>
 <189b903e939e15d98d198db60e2ca0619b116870.1706441008.git.lorenzo@kernel.org>
 <20240128134542.56e5a08d@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EcDOQuaSrcr7EBMj"
Content-Disposition: inline
In-Reply-To: <20240128134542.56e5a08d@jic23-huawei>


--EcDOQuaSrcr7EBMj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Sun, 28 Jan 2024 12:25:45 +0100
> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>=20
> > Add device bindings for asm330lhhxg1 IMU sensor.
> > Use asm330lhhx as fallback device for asm330lhhxg1 since it implements
> > all the features currently supported by asm330lhhxg1.
>=20
> If there are no other changes, I can amend this text whilst applying.
> Something lie:
>=20
> The asm330lhhx supports a subset of the features and functionality
> provided by the asm330lhhxg1 via identical interfaces and so is a
> suitable fallback compatible.

I think it is fine, thx Jonathan.

Regards,
Lorenzo

>=20
> As normal for bindings we shouldn't talk about the driver though
> what we really care about here is that the driver will never support
> functionality for the fallback part that doesn't apply for the
> more advanced part (because there isn't any!)
>=20
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

--EcDOQuaSrcr7EBMj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZbZdNgAKCRA6cBh0uS2t
rPXQAP44ljSykByNlsBpF2VQv52ERobDNBYbT55+fISDWct1mwEA14WK2NOv0Msh
saMq0/S84qZ/PAYvUdL4oKq2xcQSbwM=
=H75H
-----END PGP SIGNATURE-----

--EcDOQuaSrcr7EBMj--

