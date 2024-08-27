Return-Path: <linux-iio+bounces-8832-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FDA961413
	for <lists+linux-iio@lfdr.de>; Tue, 27 Aug 2024 18:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 328622824BE
	for <lists+linux-iio@lfdr.de>; Tue, 27 Aug 2024 16:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326991CCEEE;
	Tue, 27 Aug 2024 16:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="XQVsRIU2"
X-Original-To: linux-iio@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6953A1C3F1D;
	Tue, 27 Aug 2024 16:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724776229; cv=pass; b=BF1AJ/FphGvw/VIP7F0Fq5LHU30AnoOKucB8AcfxfP5hiNmJQUJN/EC6k5mRDAXOONDdrzKnssnCCwGatalD+ZolsxnS8NxwCVffAg9KLhjUWG9AtSngv1ZI2e+XPHHH/fGmpkEt7swNDABl6kdx9wPG/7JNxWP5Og2btu3DiRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724776229; c=relaxed/simple;
	bh=/kzx1RinYKgOz2UtzB5CMAvZLHO7c3+nz/XEbSShg2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P5lW/Qr+rSOoca3SicQW9X44PuQwyo51VIZJnB9ISGLJg9DscOZhSKaacj3u6m9M0aCIXhY4eyKuzreCK3nnXig1TcpC0m8fmZIhoddznE+6r0o2DDo8iYB0bndw+h9OeN7yuicUSCbMT6IuPZs/7MgFuicR37tS8g9l6BwM4Ps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=XQVsRIU2; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1724776187; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dV4yUuRMtkdlYes9lilFVNqwvEbmoZXh7AQpd/lmRuUyjWd8oo9apnBqjTSFAyMrUWU+fgkCoFX20QihOIER3MuCn19wrdnQIdbAR8ocBpVBB4h2U1BICd1rDO4gIJgEUFrgEVkR3LyPHq2ISoKG0l7pmFJ5GtpjCuik4BmjjYQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724776187; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=yIZ4tokYIs1ihPKr07xclM5JUdjc2mCvibla5fSMoXc=; 
	b=gCdaq9fP/CZclQ5+WAVBOkAf3gS5ADwAvE1BkfygmsgiBeolk5AQieQ4mT2WlcGNO3PG/VRlDmSD6YlBmDkCLvYMV6sMb0Hl3csz71unFMifaCWK31ilC2J5epAiF8I/Yir35NeZxdBhyrP7N6+l6Es6p+Yvgz+/PRcn4RGrqpg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724776187;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=yIZ4tokYIs1ihPKr07xclM5JUdjc2mCvibla5fSMoXc=;
	b=XQVsRIU2208eGNpDbDh5z/5tfN0pYZhYpuzg0qdFyAXuVEph/ODawx3xP+MDZ464
	U9DXYVkywRqb9Jr0JIHTWucJ0S5R7mxJrwFL/VQU5+X9Po3ki0b4NitodbBqRFRt3mp
	fcsgMRES7zn6dgUjME8ZqxrdDzaVpzk/zAjNv12I=
Received: by mx.zohomail.com with SMTPS id 1724776186585449.4642360121936;
	Tue, 27 Aug 2024 09:29:46 -0700 (PDT)
Received: by mercury (Postfix, from userid 1000)
	id 16A8610604BD; Tue, 27 Aug 2024 18:29:41 +0200 (CEST)
Date: Tue, 27 Aug 2024 18:29:40 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lee Jones <lee@kernel.org>, linux-sunxi@lists.linux.dev, 
	Chris Morgan <macroalpha82@gmail.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org, quentin.schulz@free-electrons.com, 
	mripard@kernel.org, tgamblin@baylibre.com, aidanmacdonald.0x0@gmail.com, 
	u.kleine-koenig@pengutronix.de, samuel@sholland.org, jernej.skrabec@gmail.com, wens@csie.org, 
	conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org, lars@metafoo.de, 
	jonathan.cameron@huawei.com, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: (subset) [PATCH V4 11/15] mfd: axp20x: Add ADC, BAT, and USB
 cells for AXP717
Message-ID: <fv4ukscke4hoyso4vprtrx2pzqy5lkwkuhnd5wywfxe4burlr4@2dgxbhqpol7t>
References: <20240821215456.962564-1-macroalpha82@gmail.com>
 <20240821215456.962564-12-macroalpha82@gmail.com>
 <172433485381.1334876.7027428905035727559.b4-ty@kernel.org>
 <20240826120342.503bef41@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="72vwrvvbohscblme"
Content-Disposition: inline
In-Reply-To: <20240826120342.503bef41@jic23-huawei>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.3.1/224.285.20
X-ZohoMailClient: External


--72vwrvvbohscblme
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 26, 2024 at 12:03:42PM GMT, Jonathan Cameron wrote:
> On Thu, 22 Aug 2024 14:54:13 +0100
> Lee Jones <lee@kernel.org> wrote:
>=20
> > On Wed, 21 Aug 2024 16:54:52 -0500, Chris Morgan wrote:
> > > Add support for the AXP717 PMIC to utilize the ADC (for reading
> > > voltage, current, and temperature information from the PMIC) as well
> > > as the USB charger and battery.
> > >=20
> > >  =20
> >=20
> > Applied, thanks!
> >=20
> > [11/15] mfd: axp20x: Add ADC, BAT, and USB cells for AXP717
> >         commit: e1043ad46060c181ffb8f981ccb25d9f698b2f09
> >=20
> Hi Lee, patch 12 is dependent on this because of the header
> additions.
>=20
> If you don't mind can you pick up 1, 8 and 12
> (all the IIO ones)?  Otherwise they'll have to wait for next
> cycle. Guessing too late to ask for an IB?
>=20
> I haven't checked but the later power supply ones may have
> the same block.

Yes, patches 13 + 14 are also blocked by the MFD patch adding
register defines. I merged the other power-supply patches before
noticing this, so patches 13 + 14 need to wait a cycle without
an immutable branch.

Greetings,

-- Sebastian

--72vwrvvbohscblme
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmbN/vQACgkQ2O7X88g7
+pr/qA//Z47zpsYNHymEJyhzZ0+KvDR6LxviBoQRMkhNZNmbjQVA1OEZOXbMm6Np
AP3B6ifwXDdRGV0dv4wUSYbL95QnZ3BW2tWBrblZOSPzy6fs2p3yKvGamIlxaWUf
0VQSsV+j5sZjeF2NCv6NiP+y4mpMI02VOphcXjX3b9Qb/9E6JXlEK8rS6ONHxjsh
+czXqGougXwybTW2pDeIHmmjA9YPjd/NL1FJ9wTDxbcNLieuuU06yh29YRVQhAVi
fqRL262HNQv6zBJzSqusggdpMY01u2Dm2i5ySUXNG0KOXEkC5In5t+o9SjC5Ft6f
poQC8NRXUR/h4nIOo8v9jFBEE3zxO2cR2fgn2EGv9TH9QeBGQ3343vqCu+nsDR0P
KGexs6RFiDxTJEigSlQ/oPEoV7MCims5vAR/SyEzCLerDN+pHDmc3Bi3zKjcmq3B
g3PqyPhD8uh4rB0Jr9rYyWg4G/7DfvIwKFwqAzqvx4L76v1C5dtqgziYkjTCc9r7
2hZWU7L6oGxgEgkRdtQy26a6JB8NBNvIR5Xn12zirVsaIk5kLl2SLftTXJPp4md3
uRFWJOnLjnZnhDt0F+Me7TXOdNzfftWjK2BZ71EYCs8rDUmrNHMZRe92D0d5OduS
JpgeBYL91p04T3HPOiQX4FQ75/jLmWL15fvgnJKgIZV2x7OYgDo=
=uRJ7
-----END PGP SIGNATURE-----

--72vwrvvbohscblme--

