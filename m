Return-Path: <linux-iio+bounces-17532-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E939CA787DF
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 08:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9A8B16E412
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 06:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F183231A21;
	Wed,  2 Apr 2025 06:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqd3OB4a"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BBB230BE1;
	Wed,  2 Apr 2025 06:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743574199; cv=none; b=GiQMTnttPR9d6yp/zlXHKclL8GFGhpVriG3TV6670HR2Rk1Wa8PAgvL7HpMdr1Gy2vzq5TpS6BP1ReMky1J1dHsZx47DOoM8QM2bizk+NSG3dGQbUeRxzio8T/J4ntE8gKu0Ue+NqmJGMM+zsRZFIT/eNDljQGaNocxALkzX+zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743574199; c=relaxed/simple;
	bh=BQoRGCWzAq296gbMwEi/UUiHXdIqaxqujSk/HvkEULs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b0kwc36HMMV0MYc36sENqH1XufvjGcNcS2uedhn9GRUaPGkpj2NUz+tw171THZqGsEWmCGUXO6ZWGVr0qhA3UTA0ITYCpGv9vLuD+BuxoC4jXgWficDKdqonEIyr9yiAoz9Qh2xaQNpSCoEWsgcYH/JuZTN2+nibgD51LjF+KiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqd3OB4a; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30db1bd3bddso60990641fa.3;
        Tue, 01 Apr 2025 23:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743574195; x=1744178995; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=07Ocym/DsABVIGmmaLfkZgr2bxAf8qRSleSQk2RJW10=;
        b=nqd3OB4aMf9GCM0hGZ1fL0vnpLcjaVdqDoml9+AXoHtx53UCCDlJ99PBumclzoV0Di
         ucxIACFvRDsrFRh8HW+egj4IOn/Pg2IPEMr5cjBxF+UZxnwbpmjP4S3MVJuaejvOp7xu
         ZkTPOcMBGF8pGb7RUA0Slz1tdVzLBcFTcdc2fo6Rxb2NeEVyo7wW+Sh5VKTgCvLTL7gj
         NIgoQH8gQv8PDxzde5cRc7Azs6lh9bLonN7wiTmmyGqhDFEHNcSPKCNxN1oWDF3vcsqg
         cgle5qrqRfDVDmE0CW05d80tzis67sJ/66TKTG2DyLoZq7NE1mujeA4THE/MuuXFjeis
         uzgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743574195; x=1744178995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=07Ocym/DsABVIGmmaLfkZgr2bxAf8qRSleSQk2RJW10=;
        b=WqUd0/i+GcmtE7SCAwN9uuqpbe6dIPOEdkDUE8ENv5HH+7s37Ii7n//7F3AvnV3KKo
         XSZvwnhaCrS+L4Woalu1oV4Nc3L3jEn+jba7G+8y43sFxP2DLQ42usHwF1Gn7XHtDUAA
         nmh7RcsVVFepNeAy3ptCw0sR1TZtEZOLPl8rK1SNJko85J2kA1USoN7sY5crxDxLzM4j
         2X/imvZFo+EqnSYgqyoUWJ6c+r3u4q8J3z673DAkvSVlgZTD5aGsfbefSA9K+Dc9xdIP
         fNWtQ8CrqWI5X+NsSDuaGIrqmtvXciTvnd6uPxdJPkmZZAsv+3eyYRe5uYQoPIn9kHNj
         FHvg==
X-Forwarded-Encrypted: i=1; AJvYcCUT/h19+Ft7HGCjJVkQ99NSuR6D3JAjvdbg970M6TxvpE8CFj20k9EmVABfh9OQoTe107ljN/KkSXuo@vger.kernel.org, AJvYcCVkJay75tOvygcUeC+ImX442P/UdReRGtBZ+RSbFSyfGUYgsm13ovP/FWAhnDE5YB6qrGd5D+TqnsxZ@vger.kernel.org, AJvYcCXfCKFDThGLiM7B9lgBj+opax2uQBp3+agU4YMJq/H8oXK36tFkhS5At3QGyysws68EZgAe7RCzO/MRmew1@vger.kernel.org
X-Gm-Message-State: AOJu0YzQgoX7PVDtbCoFtnOopukTo1jVYr2YE9zE8aXYQwQkR19REOPM
	11I0ZYVO7ZzhJ2YfjfACBK4iVqNxirkbuMZIiczjX9DdKH56YLf3
X-Gm-Gg: ASbGnctDa1WJ+HG7HjRUrTJPZGmptalXRgQKZunFDemYi2V8PROJCySi7NMNnvjYhY7
	mFyHrDoOwnVzG6s06vZUBG3nW+eAD0xdC80e8U2rLJ1KG5oS0hulFPJJX7P4Uz69k+EvAne99E8
	lytR7xycpDqD6wqcc7RNV5KWr44FasfcLCKMwQFenk7gNT0pZtsu8ayd/RzesWK2I4E1SX5gL6Q
	7uCMn3nVl0ml4fzLP+4tU1PAMPyaoTheobE5HI+GYHO+I2ZOwV/6kClchxoWBJO7dGAZdTfXnj2
	5RnpfCq8+i1UR3AquWglTQYvUKHDs/aG24iHZnxfKA2cUqKJo0c=
X-Google-Smtp-Source: AGHT+IGqqwXwUQo9+umD2a5JwlX8TZq5gYzu2GuBMQ8BWAqaQjjOU92HQC1w9ruhnQnk9ZyUsemLIw==
X-Received: by 2002:a05:651c:144b:b0:30c:d32:aba8 with SMTP id 38308e7fff4ca-30de03294d6mr60042061fa.30.1743574195147;
        Tue, 01 Apr 2025 23:09:55 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30dd2ad61f6sm18602791fa.60.2025.04.01.23.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 23:09:54 -0700 (PDT)
Date: Wed, 2 Apr 2025 09:09:50 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/7] iio: adc: ti-adc128s052: Simplify using guard(mutex)
Message-ID: <37179be88b3ddf2ad4120c281f82d84fe497fb8e.1743573284.git.mazziesaccount@gmail.com>
References: <cover.1743573284.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="poNgYM8TPedi5qIl"
Content-Disposition: inline
In-Reply-To: <cover.1743573284.git.mazziesaccount@gmail.com>


--poNgYM8TPedi5qIl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Error path in ADC reading function can be slighly simplified using the
guard(mutex).

Use guard(mutex) and document the mutex purpose.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
v1 =3D> v2:
 - Protect the shared message data
 - Add message data protection to the mutex doc
 - Reword the commit message
---
 drivers/iio/adc/ti-adc128s052.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s05=
2.c
index bef2d29c06af..a15b75fc067e 100644
--- a/drivers/iio/adc/ti-adc128s052.c
+++ b/drivers/iio/adc/ti-adc128s052.c
@@ -9,6 +9,7 @@
  * https://www.ti.com/lit/ds/symlink/adc124s021.pdf
  */
=20
+#include <linux/cleanup.h>
 #include <linux/err.h>
 #include <linux/iio/iio.h>
 #include <linux/mod_devicetable.h>
@@ -26,6 +27,10 @@ struct adc128 {
 	struct spi_device *spi;
=20
 	struct regulator *reg;
+	/*
+	 * Serialize the SPI 'write-channel + read data' accesses and protect
+	 * the shared buffer.
+	 */
 	struct mutex lock;
=20
 	union {
@@ -39,19 +44,16 @@ static int adc128_adc_conversion(struct adc128 *adc, u8=
 channel)
 	int ret;
 	char *msg =3D &adc->tx_buffer[0];
=20
-	mutex_lock(&adc->lock);
+	guard(mutex)(&adc->lock);
=20
 	msg[0] =3D channel << 3;
 	msg[1] =3D 0;
=20
 	ret =3D spi_write(adc->spi, msg, sizeof(adc->tx_buffer));
-	if (ret < 0) {
-		mutex_unlock(&adc->lock);
+	if (ret < 0)
 		return ret;
-	}
=20
 	ret =3D spi_read(adc->spi, &adc->rx_buffer, 2);
-	mutex_unlock(&adc->lock);
 	if (ret < 0)
 		return ret;
=20
--=20
2.49.0


--poNgYM8TPedi5qIl
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfs1K4ACgkQeFA3/03a
ocWVtwgAn/Lr7PQ7ZdSfK9o6GDWR2ZbRohuFHEhddZZXvcMZYdPWQwhUi0k6p3rB
EZDLAKCgfONrdDxTqQECbtnhGWJAW9vCqzgKkyGHU6i4Wmk1eN9dJHjJzUEE91XZ
QhAR1ptRYoN94s3s31uK/+2AqSxo/8L1th+38j3y31QMTsHCnyATIC5ZpuVDF0Zf
0NFCFj+OgtchUKXKB06+/lgOQjqeoLLCadu0xka1fW5PqaYpEA17g0KmVXChJqYJ
W0Et7Ix4fygyR01cPBRsW7m/FO9ccMxrSo45SzDR/sSpWOoKidmGY3iAV8aw9yaP
405c0jeHbV3uFNnSieHSrhqXAG3ivw==
=L59A
-----END PGP SIGNATURE-----

--poNgYM8TPedi5qIl--

