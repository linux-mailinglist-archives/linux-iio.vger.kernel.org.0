Return-Path: <linux-iio+bounces-27256-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0823CCD29F3
	for <lists+linux-iio@lfdr.de>; Sat, 20 Dec 2025 08:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B97C0301517B
	for <lists+linux-iio@lfdr.de>; Sat, 20 Dec 2025 07:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D917322A80D;
	Sat, 20 Dec 2025 07:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="DKYLKRQG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D94A16D9C2;
	Sat, 20 Dec 2025 07:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766216911; cv=none; b=aj7S7iZ4djBn5BM9NLvuzvbBw3vtYcVgU10c7Bn0H27a9FEgaBT6WdVpuH5Zeg25RVYSpij/2BhlhTFSlNTfZzRotfuSSDmimy9hI0RHVR63005xQ5W0nzvn+GUzvxR1Ju1tFoEzi+GwlZh2BOHl1Ce0Bf0/sB2GkXwRKZ5Gugg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766216911; c=relaxed/simple;
	bh=e2exq6MuZYCI+PNAxpQgmc2AwDDAiM2U1h4yZSKjZVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P/7NBTaHr666G8lkCeugn5hThO3CdbZpvUPQWdO+5qO4jIR1uMldcokUKw3x/Nd8VIbTNGv+B/BP+5bGkJIZHLPk3WUFiUWpADGhBNvtOX4CmugGV4v7GchygT6Qut+jhilp6MQjIjsHEgy4N+6BKDw7MCW8of/g8S2V00p5c3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=DKYLKRQG; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire.home.arpa (unknown [IPv6:2a02:2f0e:3804:ac00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 45884160209;
	Sat, 20 Dec 2025 09:48:19 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1766216899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I5aI/a59+/zfoSGcA6VMl5hE0kY4bPRj57TMB6LZi0A=;
	b=DKYLKRQGu4qkL4ttG7SoUxTgabS2E2mxFNz5cVNcVc/4Y2sAncuwBMxGM3vvPLJ/kqbTAa
	1zbOgVz88cAUb945CqcL5TikYHNC2XCA1Gvc3nORwh5h8GD1lBin4zLnqbkSBodq43EaWK
	GdYGks1nuUP/9QajYbzCyR3ChoKuq+H0xyyitRe8SPK2RGQqlgIqsxNEmZMxofLHXmyiSE
	2+GI73GUfv74jhu+hwk7BPS0mwmY+nFLCpIYa8u5EX/6g0ysQueok2cqSwqi4FXSiKa7e6
	rvMb4Msb6hWap34YutD11ZruKYi4nZ2F8puHl48NBNRokebUuiQpJ/dnkg1qfQ==
Date: Sat, 20 Dec 2025 09:48:16 +0200
From: Petre Rodan <petre.rodan@subdimension.ro>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andreas Klinger <ak@it-klinger.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 09/14] iio: pressure: mprls0025pa: mitigate SPI CS delay
 violation
Message-ID: <aUZUwL2fHQ6Q4zOI@sunspire.home.arpa>
References: <20251218-mprls_cleanup-v1-0-b36a170f1a5c@subdimension.ro>
 <20251218-mprls_cleanup-v1-9-b36a170f1a5c@subdimension.ro>
 <aUYrXpyaM6YdMfUd@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dvUUV6grbHkU+nRV"
Content-Disposition: inline
In-Reply-To: <aUYrXpyaM6YdMfUd@debian-BULLSEYE-live-builder-AMD64>


--dvUUV6grbHkU+nRV
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hello Marcelo,

thank you for the pointers.

On Sat, Dec 20, 2025 at 01:51:42AM -0300, Marcelo Schmitt wrote:
> On 12/18, Petre Rodan wrote:
> > Based on the sensor datasheet in chapter 7.6 SPI timing, Table 20,
> > during the SPI transfer there is a minimum time interval between the
> > CS being asserted and the first clock edge (tHDSS).
> > This minimum interval of 2.5us is being violated if two consecutive SPI
> > transfers are queued up, at least on my SPI controller (omap2_mcspi) [1]
> > As you can see in the first package that only contains a NOP the interv=
al
> > is 0.75us (half a 800kHz clock cycle).
> >=20
> > This patch mitigates the problem by implementing a different measurement
> > technique that does not involve checking for the EOC indicator before
> > reading the conversion, thus making sure SPI transfers are not queued u=
p.
> The correct way of fixing that is with protocol specific delay. Generic d=
elays
> like fsleep won't guarantee any delay between CS drop and fist SCLK edge.

sorry for the lack of detail in the commit log, I forgot to add it.

this patch changes the measurement sequence and as a consequence it also mi=
tigates a problem where protocol-specific delays are not implemented in the=
 SPI controller (for the corner case when multiple SPI transfers are queued=
 up).

as per the datasheet pages 36 and 41, the measurement sequence can follow o=
ne of these two scenarios, for both bus implementations:

a) send measurement command and wait for the status byte to lose the busy f=
lag.
this means that we would need to keep sending NOP commands and read the fir=
st (status) byte in a loop until the busy flag goes away. this is how the d=
river was designed before this series of patches.

b) send measurement command and wait for 5ms for the data conversion to occ=
ur.
same as a, but instead of polling the sensor for the status byte there's ju=
st a 5ms+ delay after which only one NOP command is sent.
the read that follows will get the conversion data plus the status byte.
depending on the status byte flags, either error out or pass the conversion=
 along.

my patch replaces the measurement sequence defined by scenario a with scena=
rio b and it only affects users that did not define the EoC interrupt pin i=
n the device tree overlay.
the datasheet contains sample code (pages 38 and 43) and they also happen t=
o use scenario b, so no polling.
in my testing the sensor always performed as expected (the busy flag was ne=
ver set after the 5ms fsleep()).

> For SPI, we unfortunately we don't have any interface to set a pre-SCLK d=
elay
> so I suggest to make an spi_message with a dummy transfer to cause the in=
itial
> 2.5 =B5s delay. E.g.

for normal (non-queued) SPI messages the delay that exist between the CS as=
sert and the first clock is ~4us, well above the 2.5us minimum.
the problem only appears when the SPI controller gets multiple xfers withou=
t any delays between them - which happens in scenario a when two transfers =
get queued up (NOP that reads the status byte and the NOP that reads the st=
atus + conversions).

this is just a hunch but I think that the CS timing is directly controlled =
by hardware when the issue happens.
see chapter 24.3.2.8 page 4903 in the AM335x technical reference manual [1].
I'm measuring exactly 0.5 clock cycles CS lead times which is the default f=
or the TCS bit of the register MCSPI_CH(i)CONF.

[1] https://www.ti.com/lit/ug/spruh73q/spruh73q.pdf?ts=3D1766215152875

> /* dummy transfer with no data, just cause the delay */
> xfers[0].delay.value =3D 2500 * NSEC_PER_SEC;
> xfers[0].delay.unit =3D SPI_DELAY_UNIT_NSECS;
>=20
> /* normal data transfer  */
> xfer[1].tx_buf =3D data->tx_buf;
> xfer[1].rx_buf =3D data->rx_buf;
> ...
>=20
> Also, I don't see how the proposed change is 'implementing a different
> measurement technique'. Consider updating the commit description or provi=
ding
> better explanation.

I feel that using scenario b defined above we cure the problem before it ha=
ppens.
my patch provides a less complex implementation, it's recommended by the ma=
nufacturer in their sample code and provides less code duplication (status =
byte parsing) with no downsides afaict.

> > see Option 2 in Table 19 SPI output measurement command.
> > Note that Honeywell's example code also follows this technique for both=
 i2c
> > and SPI.
> >=20
> > This change only affects users that do not define the EOC interrupt in =
the
> > device tree.
> >=20
> > Remove defines that are no longer used.
> >=20
> > [1] https://pasteboard.co/66WN38MRI1wc.png
> >=20
> > Datasheet: https://prod-edam.honeywell.com/content/dam/honeywell-edam/s=
ps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensor=
s/micropressure-mpr-series/documents/sps-siot-mpr-series-datasheet-32332628=
-ciid-172626.pdf?download=3Dfalse
> > Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>

best regards,
peter

--=20
petre rodan

--dvUUV6grbHkU+nRV
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEGiKYHD4NvFCkTqJ3dCsnp2M6SWMFAmlGVLkACgkQdCsnp2M6
SWNqrQ//U+x7GG0lj87y0jK80z/j2ERzdHsrzjsthPvcIQXVIA7kKdKK1aeAGS+6
otrmuulgORhjUnk3H3QyUt+P4FfBIR+4dG6nqPyZHoT2YTiC7xFADr234FE2Q2Wk
Pk0OUN4twBIaHKP4Zm1pGOm6uyWh3GqAgnWdWCjyA91nvH0yf1RUUDaT01DNaBKk
737Qs6SXlEf0faZDpmL0az1qNYuBvJHFveX+Q8q7LiEX5i24ZyBzP0wQDo811ZLM
Q9k2tCPPYUtKbdtMxBEPGhsgMhKhjrrtnSoG46Dv/eLOhpQNzCDun9+7PGfiwxeQ
5/kMvSHlatCUuI5o6CFKZyrnw6eRPxaviIDruEwGXfsL37JcnSD4Nsxkq0DkJYJG
tinmD0oQf4FSwYzyaKRpPlMwF242MskZVMkfZmLBA6PF17IgiceLj4Oxq71cpa88
SLyUEH+TO2avH14FmCiIQDFuGFRYaBN48EHSReMRmnlHGECxCfY0HmNBnEzR8+12
qXgVSu2gBvKf1r+l/jx5gcbM8yaaWhQyTZLfT2NMua52Y8P/Rsg3AX8oaLX7tPmQ
C3TeLC7eQLRjBCWSxGjy3fffsBc9CadaJ6rHXMpM7PSWPhTcFea4nO4Z9x38YiXH
LGf4UEyDOw/OMT7LE4rSUSqTCzTb2yQZmmpCHq3TqGMlcOGALOM=
=Soux
-----END PGP SIGNATURE-----

--dvUUV6grbHkU+nRV--

