Return-Path: <linux-iio+bounces-23978-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FAEB5326F
	for <lists+linux-iio@lfdr.de>; Thu, 11 Sep 2025 14:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 409B43AFA51
	for <lists+linux-iio@lfdr.de>; Thu, 11 Sep 2025 12:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6531B321F31;
	Thu, 11 Sep 2025 12:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="s1/ILfAQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED1E23CEF9;
	Thu, 11 Sep 2025 12:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757594209; cv=none; b=DbeprVBItCIKVbCMmNhbxzGFMOcPUBLthiefTZRPoEhKQTBKEX6Mcm4G4PnbAFMtRlLxTOjFDCyXWM1I+qd0s7kSa/7bjeJH1LBhbgOXlzjkl6Nrk7XOOgdxOjnJXxaeaw3IVkxzd7HVFDWvctUk/735nC/8l7bCD9v5fHW2tuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757594209; c=relaxed/simple;
	bh=QkQdBI8anUDvfOf9RgkkrxdhKfPTw8O5oRJZTgWZeG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r1JIFhpc6Q8zlrE1Aw87rNiY9o0u9uzRJhekNSVj6W4JS43qK7EiBMY/Y3L8sOJMegbFfGAUsG5m8EQa79fkWCMpaSsyqx6d6QXpE0ZIMZee5PHgwCr7i8j52Pm172EL4AZ8fZj7m6AC4sJLOxf5CUCu1YS8r6VlM5GAjMgmg9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=s1/ILfAQ; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire (unknown [IPv6:2a02:2f0e:3e0c:5b00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 18889173BE2;
	Thu, 11 Sep 2025 15:36:43 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1757594203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6gEyFK0DSqrZL6C1lK+mBxeLuPQap3TA12mpV61nNXA=;
	b=s1/ILfAQuLX1I6zZS9VzGx6qDFb0T2qEOhGnwDJb2nC14h6TafGjhBeXuOEq/lcjppdy3d
	jpg2eWccIogbvJbu2ccUNa8ZVUCU/0RyhHzYknVV30q/sI2Vt8tvAEIPR8B+LJTnaKVPhz
	9fZHJIml0QkKtp467TlxL3S5277cy0NX0ReYa55gVX1jp8/JbYaZiQe02sBtlpvU8VHFzo
	Nsu7imStmQB32cd6JZA8gzs0WmJAri82OMDVXnzFQe0JfGvykXNLyIuvQGa+kVmV7cZ4HK
	LYhgqBYzme5pE+6H7sTJgRQt46I13oaaaIqv9V/HB4GVcqIytqZGDLJr9EOiHQ==
Date: Thu, 11 Sep 2025 15:36:40 +0300
From: Petre Rodan <petre.rodan@subdimension.ro>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno S?? <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/14] iio: accel: bma220: reset registers during init
 stage
Message-ID: <aMLCWFatVkePTxCa@sunspire>
References: <20250910-bma220_improvements-v2-0-e23f4f2b9745@subdimension.ro>
 <20250910-bma220_improvements-v2-7-e23f4f2b9745@subdimension.ro>
 <a10a2f6d-6cb7-4922-b505-dc6994f0415f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NNBeZRJGrv3j1F1i"
Content-Disposition: inline
In-Reply-To: <a10a2f6d-6cb7-4922-b505-dc6994f0415f@kernel.org>


--NNBeZRJGrv3j1F1i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi Krzysztof,

On Thu, Sep 11, 2025 at 09:35:52AM +0200, Krzysztof Kozlowski wrote:
> On 10/09/2025 09:57, Petre Rodan wrote:
> > Bring all configuration registers to default values during device probe=
().
> >=20
> > Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
> > ---
> >  drivers/iio/accel/bma220_core.c | 71 ++++++++++++++++++++++++++++-----=
--------
> >  1 file changed, 49 insertions(+), 22 deletions(-)
> >=20
> > diff --git a/drivers/iio/accel/bma220_core.c b/drivers/iio/accel/bma220=
_core.c
> > index b6f1374a9cca52966c1055113710061a7284cf5a..322df516c90a7c645eeca57=
9cae9803eb31caad1 100644
> > --- a/drivers/iio/accel/bma220_core.c
> > -static int bma220_init(struct spi_device *spi)
> > +static int bma220_reset(struct spi_device *spi, bool up)
> >  {
> > -	int ret;
> > -	static const char * const regulator_names[] =3D { "vddd", "vddio", "v=
dda" };
> > +	int i, ret;
> > =20
> > -	ret =3D devm_regulator_bulk_get_enable(&spi->dev,
>=20
>=20
> You just added this code in patch 6. Don't add code which immediately
> you remove. I understand you re-add this later, so basically it is a
> move, but such patch diff is still confusing.

sorry, but this is an artefact of 'git diff' I don't think I have no contro=
l of.

the bma220_reset() function was added to bma220_core.c with this patch and =
the
diff process merged lines from this new function with lines from bma220_ini=
t()
causing the apparent removal of the lines added in the previous patch.
if you look a few lines below your cut, the bma220_init() function contains=
 the
code:

+static int bma220_init(struct spi_device *spi)
+{
+	int ret;
+	static const char * const regulator_names[] =3D { "vddd", "vddio", "vdda"=
 };
+
+	ret =3D devm_regulator_bulk_get_enable(&spi->dev,
+					     ARRAY_SIZE(regulator_names),
+					     regulator_names);
+	if (ret)
+		return dev_err_probe(&spi->dev, ret, "Failed to get regulators\n");
[..]

Just for my curiosity, do reviewers apply the patches one by one to (a bran=
ch of)
the tree itself or do they provide feedback directly based on the diffs?

best regards,
peter

--NNBeZRJGrv3j1F1i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE2Ap/wXYVGTXsPl+pzyaZmYROfzAFAmjCwlgACgkQzyaZmYRO
fzBX3Q//bhgiqNrozUCco7QKapysnP4QMmkVJoHXuwQTjOCQlIbzO2yh3AV9RAJ+
Fb23RjjRJcjVn5OpWnRY5pYiQAXwccNi0E6rZPozAJaGpX+I1sNqHxmfPJqh49GF
YlZImOdM9rrYOdYyv2xUR3WfdxDCCCsfOu3R1Gj6X7oGm2X/JoA3wQ25+QUQ869X
lCbW4I4qSWoXE7XlIUw6iVNGrllT8hmThKCZnqLCk/vshf46iBG8XfWGsjIjAuGb
3T7tm0mqQjpoU+5VKf4rPMM7Pidze6kSYGNfJtNG2ASCY/3DL3N34L3Av7fpD2ce
CtxWpHnpfYP4F5XmtOgYnZjj96UGI74QuaKNIFrfhBquvMtixkzxt2zVVgkesBvy
8qH0AB/+a6CYb7S/aniZG8/BYtT22gpnKFPtAFq7zKM3JcFWygMr2HYRZCwniB2Q
A4xJwf5444UOMPiO5U/hwGn+oqS+otR3YcFmSzYjmxz9TdTVaK4Ur+DAHhLnWa7/
RWr5y5d05AcUJ9gy1Ardc0yItofdbFNSARIcxPjsWI9aZiT0HUQG805ilxiGf0Oz
o8mXmMo+p8G0nEJauw0RhfkLepRQbQddWEKTynfw4EEL5kD102MMEqo+tKj5bDYz
xImuNYWpK9RrQQPIb5XiuowtQBMwbSZ+eh2AllxnzbI+EBBll9A=
=B4BN
-----END PGP SIGNATURE-----

--NNBeZRJGrv3j1F1i--

