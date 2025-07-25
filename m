Return-Path: <linux-iio+bounces-22012-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 104FFB11975
	for <lists+linux-iio@lfdr.de>; Fri, 25 Jul 2025 10:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C02561CC5F1C
	for <lists+linux-iio@lfdr.de>; Fri, 25 Jul 2025 08:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C415F2BD5BC;
	Fri, 25 Jul 2025 08:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=it-klinger.de header.i=@it-klinger.de header.b="OJ4MGAsi"
X-Original-To: linux-iio@vger.kernel.org
Received: from www571.your-server.de (www571.your-server.de [78.46.3.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805072BF000;
	Fri, 25 Jul 2025 08:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.3.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753430414; cv=none; b=G6t1pm8XZKnH4px169pQUxD+NhGHYHxPitp0KuOrnwU5b9Ylk/zMCcHHQwFgPtSWR9p6ixZiYCTht7JCazrzgnZUkj3xJaHxjiKtCCOzXvQCCjFWTLdw6F4OmZP+Sgjb6z6n0OXUUOkyHJ0IHdtBKXBpF4n7Ga2LIar19RZCYfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753430414; c=relaxed/simple;
	bh=fJrnu7NHG3y3u91nx9CIzDrr7WItx4fMYcF3H7U3WeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D6Y5/eoQJ04aTIipDug0yPQJgGlB5yWcuYzumGlfmjqjvohBdKWgbOyBSAQ2JQOcaQvgf3fDxL2xq5DPdeFebUEeO5GCr9WYMKYTeMEjsX6PZXZZGGRcq2pqhKUzME1or9xybO8H13Mta59fh5eMshGd6UbkBRD+q4s1niaDokE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de; spf=pass smtp.mailfrom=it-klinger.de; dkim=pass (2048-bit key) header.d=it-klinger.de header.i=@it-klinger.de header.b=OJ4MGAsi; arc=none smtp.client-ip=78.46.3.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=it-klinger.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=it-klinger.de; s=default2502; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=o+EP3Do08PQClXT7GYUtMCIwfhK/g0y4AnYJ4Vvgafg=; b=OJ4MGAsih65d3KdHgEjNfEeOvo
	5njU05g94/vGd9bZ7N2rN5p7/I20XFjR88HQHDfN7aNPHjnDpDArsh9YzKzPNUqhBJjncOv/FggqQ
	H2waoulHyAeHV43A+/tdHn5dzEAnGiE4zIwNe1nmOYsCbfU6lA2zcW0oyihmCuYVRmPadTS9Z/OJl
	Ocrv0uCGxmTPGjNvozscMQ6uipHZaYc3jwDf4NSpu3HFmCVuQgUFTpXI45kUO6FgUiH6GAslG7QyT
	U+SeTYnPzjXLaVo4++TA/lpDOH8UPCiNrEssK9rpsB3pubu4uSiyU6v6M076TKpMcmE+ouucnS9eB
	K7mhoo9w==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www571.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <ak@it-klinger.de>)
	id 1ufCuc-000FK8-2n;
	Fri, 25 Jul 2025 09:32:14 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ak@it-klinger.de>)
	id 1ufCuc-000MgP-0K;
	Fri, 25 Jul 2025 09:32:14 +0200
Date: Fri, 25 Jul 2025 09:32:12 +0200
From: Andreas Klinger <ak@it-klinger.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, lars@metafoo.de,
	javier.carrasco.cruz@gmail.com, mazziesaccount@gmail.com,
	arthur.becker@sentec.com, perdaniel.olsson@axis.com,
	mgonellabolduc@dimonoff.com, muditsharma.info@gmail.com,
	clamor95@gmail.com, emil.gedenryd@axis.com,
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/3] iio: light: add support for veml6046x00 RGBIR
 color sensor
Message-ID: <aIMy_BHJYNA20k-x@mail.your-server.de>
References: <20250715085810.7679-1-ak@it-klinger.de>
 <20250715085810.7679-3-ak@it-klinger.de>
 <aHdWAUMMH43tIqV4@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4Q/B+VBomn8MKafC"
Content-Disposition: inline
In-Reply-To: <aHdWAUMMH43tIqV4@smile.fi.intel.com>
X-Virus-Scanned: Clear (ClamAV 1.0.7/27709/Thu Jul 24 10:35:45 2025)


--4Q/B+VBomn8MKafC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andy,

thanks for the detailed review again. Some comments below.

Andy Shevchenko <andriy.shevchenko@linux.intel.com> schrieb am Mi, 16. Jul =
10:34:
> > +#define	VEML6046X00_GAIN_1          0x0
> > +#define	VEML6046X00_GAIN_2          0x1
> > +#define	VEML6046X00_GAIN_0_66       0x2
> > +#define	VEML6046X00_GAIN_0_5        0x3
>=20
> Is it defined as hexadecimal in the datasheet? Otherwise use plain decimal
> numbers.

It's in the datasheet defined exactly the way i did.

> > +static int veml6046x00_validate_part_id(struct veml6046x00_data *data)
> > +{
> > +	struct device *dev =3D regmap_get_device(data->regmap);
> > +	unsigned int part_id;
> > +	int ret;
> > +	__le16 reg;
> > +
> > +	ret =3D regmap_bulk_read(data->regmap, VEML6046X00_REG_ID,
> > +			       &reg, sizeof(reg));
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Failed to read ID\n");
> > +
> > +	part_id =3D le16_to_cpu(reg);
> > +	if (part_id !=3D 0x0001)
> > +		dev_info(dev, "Unknown ID %#04x\n", part_id);
>=20
> For 0 it will print 0 and not 0x0000. Is it okay?

I just tried and it prints 0x00 if the part_id is 0.

Best regards,

Andreas


--4Q/B+VBomn8MKafC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEE7/NrAFtB/Pj7rTUyyHDM+xwPAVEFAmiDMvwACgkQyHDM+xwP
AVE3nQwAn6dBiOP/mFu9UJRXKjUpOTi1hawG/b4j5nlhW+rvpvu1YH/cuM9keq9k
yogxPgs2XsUqE2OlHyS3PnHBJJ26gdegu2ezMudU8mzZQugIRdoEe7JbAvx8q1A6
6nMU6vBEB9iUPCGMtFOz+e2E5CxHjkdmcuSlHh3LvkplQxmmbrv2dInH2JIBfyL+
Nrn105vDeaL9V8WtxqDfAKhVzRZizMRANFVxmtjKW9ZKk5423K1qXvFsboqZsnqw
85iPV4WcDJe5J13dVSZjMPJ/rrp2mlG5au0kBqGpnqbfvV5tWR5s9lhEKtJzx4ia
t7jwoe9l9er9C2DCz08x6AvVMzUqParTNfPLdsTwpJhARD0ugimewBXN1A+IjQh5
SXoWLizj3nwbzGAwE9MAiKdDdFDGeWLVWj3j02EUGBePQEf80xJ1zZgdnkMOP+mH
gQcVe9jRLfk/vbWUTSYSY/7XY6Rwt+A0+wsH4dK9pVxaL5I4X71WdH4DUCKx7CdH
yjl9L1hB
=9+VA
-----END PGP SIGNATURE-----

--4Q/B+VBomn8MKafC--

