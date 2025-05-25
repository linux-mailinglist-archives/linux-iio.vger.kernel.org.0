Return-Path: <linux-iio+bounces-19853-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD499AC32BB
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 09:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 828E4177AA7
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 07:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018BE1E493C;
	Sun, 25 May 2025 07:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=it-klinger.de header.i=@it-klinger.de header.b="uObr2CJ/"
X-Original-To: linux-iio@vger.kernel.org
Received: from www571.your-server.de (www571.your-server.de [78.46.3.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2AF18DB0D;
	Sun, 25 May 2025 07:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.3.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748158508; cv=none; b=qyYIq85pD/QxcHKDuJXU4FfWrjQtrQaJLKFlVwL7XYEnK+44b9Ho0D76+fzbT54YLTEpNGOXI/vKhJAHP8RuaVnatM8rsOMcc2rbRWZ3X4I3QxnZT4JWZowr590YNfKlGjbbmoy3L3MfV0TGyYt8h/Y4RbwUC3uS/UonU4kc0MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748158508; c=relaxed/simple;
	bh=mMu67Ud9w4LRVdNAVeeRi2tiVfqaGBfScHnTBYfhtPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sC053xy1gtLXpGq0tnDTCYSbES0eKGRnWM3zscS4we/1N8x3eh4/1/rty9MFaVaWymG6ReYoZZ7ghdyIM4JxQwy228fKVpfmrvA7kcCLheh5xSSiGFSeGG1z8sUVbE0/6JoL21mwR2V/yH6hTWr5Kw9ls3l+w6R0bw4DTvG+UUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de; spf=pass smtp.mailfrom=it-klinger.de; dkim=pass (2048-bit key) header.d=it-klinger.de header.i=@it-klinger.de header.b=uObr2CJ/; arc=none smtp.client-ip=78.46.3.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=it-klinger.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=it-klinger.de; s=default2502; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=rjNuVY7Zq4l4Qpw6Ak1J6G7FtcipVqJJf74Nk2EbkhQ=; b=uObr2CJ/aV/OxtLJFDTjtUknMJ
	QyvtTFnhv/JUpPbdWUNXiRf/ecjff7STnPfpazJmXlUtOpLwBQZoWUX6bgIMSSvXBqpMnegq2ouoR
	EFvkk4vncorYety/X5AhHQm/Av+KT914E/GmYrtTBQzZrvwZwkRONuwepBvH5zbjzL/v3lzjF75gr
	WII9AbWGQWiNNJ03SV3XWzXPNw51KlBenqu/VQf9rmpdiI22rOQ0njqt1pP3HXamD+ELpED6GQT3I
	qctKGNhEscGAB6hxsys7lIR+KoSIamzIJyIaEt3zHE6nxutZX9V/2IC7U4e2/QoDIbRLd+ja5cExA
	cX10ZipQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www571.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <ak@it-klinger.de>)
	id 1uJ5sk-000Gre-1c;
	Sun, 25 May 2025 09:34:54 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ak@it-klinger.de>)
	id 1uJ5sk-000AvQ-01;
	Sun, 25 May 2025 09:34:54 +0200
Date: Sun, 25 May 2025 09:34:52 +0200
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
Subject: Re: [PATCH v4 2/3] iio: light: add support for veml6046x00 RGBIR
 color sensor
Message-ID: <aDLIHEj4lqlgargJ@mail.your-server.de>
References: <20250519060804.80464-1-ak@it-klinger.de>
 <20250519060804.80464-3-ak@it-klinger.de>
 <aCsQKUwGeq4Ed4ai@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o+cMHJOAAGa7G8wa"
Content-Disposition: inline
In-Reply-To: <aCsQKUwGeq4Ed4ai@smile.fi.intel.com>
X-Authenticated-Sender: ak@it-klinger.de
X-Virus-Scanned: Clear (ClamAV 1.0.7/27647/Sat May 24 10:30:52 2025)


--o+cMHJOAAGa7G8wa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andy,

thanks for the review. I have a question and a comment below.

Andy Shevchenko <andriy.shevchenko@linux.intel.com> schrieb am Mo, 19. Mai =
14:04:
> > +/*
> > + * veml6046x00_gain_pd - translation from gain index (used in the driv=
er) to
> > + * gain (sensor) and PD
> > + * @gain_sen:	Gain used in the sensor as described in the datasheet of=
 the
> > + *		sensor
> > + * @pd:		Photodiode size in the sensor
>=20
> This is made to look like kernel-doc, but it's not marked as a such, why?

I'll remove the '@'

=2E..

> > +	ret =3D regmap_clear_bits(data->regmap, VEML6046X00_REG_CONF0,
> > +							VEML6046X00_CONF0_ON_0);
>=20
> Something wrong with the indentation. Please, fix all places like this...
>=20
> > +	if (ret) {
> > +		dev_err(dev, "Failed to set bit for power on %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	return regmap_clear_bits(data->regmap, VEML6046X00_REG_CONF1,
> > +							VEML6046X00_CONF1_ON_1);
>=20
> ...or like this.
>=20
> > +}

I don't get the point what is wrong with the indentation. In the coding-sty=
le it
says the decendant line should be placed to the right.
Did i miss something?

Best regards,

Andreas


--o+cMHJOAAGa7G8wa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEE7/NrAFtB/Pj7rTUyyHDM+xwPAVEFAmgyyBsACgkQyHDM+xwP
AVE9uAv9FAsOdICiVxcMeS2lQBnbog/ke6YBclqe2ny0NeHs5cClnnV/04GVIpoP
3rHVqxwU7W/9PSV39hlcOUB38Kj+/WhFuqf3RFDFK30SMBuhB/Mc6f6PU6T6m4px
dyQdfF3LENDNARbhiwV3k3X7+hSLN7+5wW9RaGhwE383vBpFJcr25xzg7gPbSsuH
sGkHEA3afVPd+0n2uq/ASB0yL2F4dbxsxH74Kp1j0fem8YXqf4EvZJKOzLulu4jF
SrYt8NRJQ2WGu9eGTBogbYUlH79PZIvGyM1Yd5Q0kskmWo+F9676iQdrrIJXy+8w
PHM4hIz5brlTDC46xga9sG75W+t14z/n8iZCIbd5UziSTvcisVjLo02oC/3L/SI9
WqMmQHpE5VZ3xfoKAOaJdXG4oMot57a7J4v8LvJj7Y+YKEfrKoqzTEbh+KQSq5Vu
V2Rx21m9pQRlpVH9p2MrHcczxibsJns0kRL4ewlW20YW+pq8FJF9aRAUSNhj9p+b
+QKFaCvi
=goN0
-----END PGP SIGNATURE-----

--o+cMHJOAAGa7G8wa--

