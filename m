Return-Path: <linux-iio+bounces-8649-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B62AA959777
	for <lists+linux-iio@lfdr.de>; Wed, 21 Aug 2024 12:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 060C6B20B10
	for <lists+linux-iio@lfdr.de>; Wed, 21 Aug 2024 10:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D67192D98;
	Wed, 21 Aug 2024 08:32:00 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from www571.your-server.de (www571.your-server.de [78.46.3.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D5A1CF2BA;
	Wed, 21 Aug 2024 08:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.3.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724229120; cv=none; b=lTaKZYd93g/myqwOJ+nV+0YDBNPlwEkPehGbZ91750bJaRQLVqeSoh13WDi2f24R4HrUmhYQnGl00ccGHT1p33/lO8hdrtQh4tVE52TcIZOhmE/t7/D+ywu/YRiuvBMWCmZ1GwuZx8rnrd4iE7oZzYZ2QKaSiIKefEYD8eMahGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724229120; c=relaxed/simple;
	bh=xrgOSU3+b3RWFVrBSCyrFAwO5C988wPDl/GjFT50as0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OGHBNZx04IjvfrpwEUDlzT9LZE94ZgfxPA10qn1jIFce721mMC/DycW6vZ22Hon9APeBLvJVEyoHgrCknwjsH7Ls9XbpejNLzhI2zY0HZLF1kxLVq2n1OxwZ9Hsn6RaHUq60rr7iOoYiXSuVdeuToJLf07cuofUcHAsn1qGiZs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de; spf=pass smtp.mailfrom=it-klinger.de; arc=none smtp.client-ip=78.46.3.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=it-klinger.de
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www571.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <ak@it-klinger.de>)
	id 1sggAH-000Hka-2y;
	Wed, 21 Aug 2024 09:53:58 +0200
Received: from [31.220.116.25] (helo=mail.your-server.de)
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ak@it-klinger.de>)
	id 1sggAH-0006xC-1A;
	Wed, 21 Aug 2024 09:53:57 +0200
Date: Wed, 21 Aug 2024 09:53:56 +0200
From: Andreas Klinger <ak@it-klinger.de>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Andreas Klinger <ak@it-klinger.de>
Subject: [PATCH] iio: sgp40: retain documentation in driver
Message-ID: <ZsWdFOIkDtEB9WGO@mail.your-server.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hprJgWQtHRwzXpst"
Content-Disposition: inline
X-Authenticated-Sender: ak@it-klinger.de
X-Virus-Scanned: Clear (ClamAV 1.0.5/27373/Tue Aug 20 10:46:09 2024)


--hprJgWQtHRwzXpst
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Retain documentation on how the voc index is actually calculated in
driver code as it'll be removed in Documentation.

This is a follow up on patch "[PATCH] iio: ABI: remove duplicate
in_resistance_calibbias" from David.

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 drivers/iio/chemical/sgp40.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/chemical/sgp40.c b/drivers/iio/chemical/sgp40.c
index 7f0de14a1956..07d8ab830211 100644
--- a/drivers/iio/chemical/sgp40.c
+++ b/drivers/iio/chemical/sgp40.c
@@ -14,11 +14,16 @@
  * 1) read raw logarithmic resistance value from sensor
  *    --> useful to pass it to the algorithm of the sensor vendor for
  *    measuring deteriorations and improvements of air quality.
+ *    It can be read from the attribute in_resistance_raw.
  *
- * 2) calculate an estimated absolute voc index (0 - 500 index points) for
- *    measuring the air quality.
+ * 2) calculate an estimated absolute voc index (in_concentration_input)
+ *    with 0 - 500 index points) for measuring the air quality.
  *    For this purpose the value of the resistance for which the voc index
- *    will be 250 can be set up using calibbias.
+ *    will be 250 can be set up using in_resistance_calibbias (default 300=
00).
+ *
+ *    The voc index is calculated as:
+ *      x =3D (in_resistance_raw - in_resistance_calibbias) * 0.65
+ *      in_concentration_input =3D 500 / (1 + e^x)
  *
  * Compensation values of relative humidity and temperature can be set up
  * by writing to the out values of temp and humidityrelative.
--=20
2.39.2

--hprJgWQtHRwzXpst
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEE7/NrAFtB/Pj7rTUyyHDM+xwPAVEFAmbFnRMACgkQyHDM+xwP
AVH80Av/WNbUTPVXno0Kwd6mTLScGeGUd96+GTDSopmKULPNPfV0j+QqGMTgP5Ql
mqEVNL68KVNYpqmiYDXnRURPjF9zbXYA4n6hTdeozXE9I+qNxr5vFaa9gIJZytFQ
QWGEzySjr1Ffj2F0mBaNrZZQ4gXLZMex4DLstvhtWPR7z3O/tp7IrVX5/NMqzhAX
q7jYmNYsVvDRNUUHlu+bNMTPfmYL7Af1wOs/rmf5AR0OHP/4gQ+DmW5GXEd7s647
7gfBPraso0V3SYLV6NGRkYmQQRjoQbP1g9CLTzLBc3lpKDYEKif+mBofUkfXI/+y
xa48bX8hHcLTzzeqatJhoLBeZhu1u81kQC5U9jq+RZlWis1+DV2StLyeXR3kYRoN
BfZRuq4sBjVNC7U7FVO/0VIGvLgYifBRdqHa5PSTwWYEL9ucwMjANekSpj6pfXKV
QfEAZEPgJx2mOISldfojxP28r66xTBnlubkS2G8PXSorg482MjYnSwHfLkeC1A0W
+UQTeEQp
=DNXR
-----END PGP SIGNATURE-----

--hprJgWQtHRwzXpst--

