Return-Path: <linux-iio+bounces-22545-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FA1B20240
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 10:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 270C3189FCAA
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 08:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87EF72DC352;
	Mon, 11 Aug 2025 08:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qg1yv+sf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785BD2DAFB0;
	Mon, 11 Aug 2025 08:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754902264; cv=none; b=LHw7UtrteDMSyjre+qNnwNDbA7TXsuFT0yLf6NeuBe76wP9nYv4dk3PW9pMJaZI5nCUoU2XoVsp0Xsgb6eQ33GXzsduBZo0FwhrNakEg4sH9/4JU+WfsrnVVDHm4qAazkyODRmoYB1Bjr/dZXZVso8CpTKpSNB4nJyfwiNtH5mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754902264; c=relaxed/simple;
	bh=rAm+r1i3b96KhKd168yOqZoJVLKofw933ku1W3c/yaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ak5PdPN9NGbsDXl2/m+uhGBZ4Fu4wqrG91saqjf/zmuEV6K4gXf0DhLfA29l3z+t7UzPwiVKHv9BtTtGlM6H1pzBukHpAD8GTiRCZHXZlvVFJnRY7Xg2xmMvEYQ1wfskbtvryTF50cZW8GoxocsLJEprkIN5KSLTIYkccUDnCHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qg1yv+sf; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3323b99094fso35075671fa.0;
        Mon, 11 Aug 2025 01:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754902260; x=1755507060; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/cq9muy0SHWC2p1ZeTmyROCPYjCYRpVB5xgs+P5dB5U=;
        b=Qg1yv+sfbJbnxVVwNFzv19jfnI7lc7xTZ6Pqx1dr8sd7XkX3F81NxllV5zXxrDwCA4
         cjQT6n9qniPrDnhmQ8eyfKJM6HypaDm8PAaUKs2lMemYugrlKQbbVSZI8umCxdwdNzn2
         He6j5xDmXk/5gwHSKpnm9fVd/gy/YmKaxyIys6Jf4hboKm3SNLtHvtzUTsTYvcJWasa1
         E3Y6dqYXz13YGPfzLmKQC52n0v5OAVdJTnLumTZFZdqmcraQpnVPADocXK1Poq4UsGxK
         3tgGk5FbUrTERbj44n6+7e8b8aXIPY4SEI1P9FC8+aD/6ptLo8jCCu56QVDraCUnqBSo
         T2sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754902260; x=1755507060;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/cq9muy0SHWC2p1ZeTmyROCPYjCYRpVB5xgs+P5dB5U=;
        b=vrN0I1LmXLgcNDVNxlQtdl30aa1poZ6GrykdVIgXLoQuuTLZVp9QxKP+92pxK625nC
         ovZHd97OwDURwSm4OCzdK3PYzcJTD7GznZOIXI99qfOuuKnVMdGaHb6nCVZbMs5NoS8d
         PWeHbfiIrhX0B24lpmoX/lNi6HdoODh/maJFQ/j+V/eOHrBUXAg9AqycLHrZg4xG3mLF
         1ZL8N0nKA5+VoL5i4jHGm32IX4TJxQDrE2gx4a2F1CoEUJDPk0FGqKnwiNeHSr/BrYWU
         rPpCaOhIMmcEApPwsQqANJbobG3x5n6TB0OQJOBnly+tNEEYvanEwuGnJh6mFmUbQXT7
         nGYA==
X-Forwarded-Encrypted: i=1; AJvYcCUncC6wlgHvlM9cE6cy8/uvq5Iz6Irf2NHk+2paVly01OiOV+BrTXdJx4fMqLmQxf4tp1QSdaWVs6JZ@vger.kernel.org, AJvYcCVR+sBgisKFUA6uXlqiiSmZH4csH2U2EKwfAxRk3eKlbM0PHDIdbjZ8HL7wbNGA1hFh6ng3sKs8cJy+@vger.kernel.org, AJvYcCXPMSgmC5Ol1rjnyPdHt2KPUgJ8dUabqgsyMeuY+EhuqBg3vp482eSo3CMnxqy1NMNCS7Y86PBOop5tqSKZ@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxu79AFnc8U3FExDyGjDDL+l8OUnv5ucl/RT0HINM9YmEyRm98
	PKu3LjikOD9g4wc9gM7FSDOyo2h2bHM8DGlEHEcCusMuSp9k9/7SH7OJ
X-Gm-Gg: ASbGncvJhFkDq/VcXWq5kL5Id7HPcFT4CmoBvbg/WrYpqpOQlsiyLhGdYngSgyXb8dW
	nbBUGez0Lgc0uOet2UF503UJSCEf/poe4l5IC8hUQDPbPExcpIBkPVXrFU6kxnoRw1gb9jVx1ak
	7NqVmacztFWr/8WFP8EusfuUlgUO3LkSAjOpiBnuoaEdpL2EO5JafozuobsHjxJj5njFlv7Fmlt
	hW/Z/wvYniJEH59SoGnr6hQKXsxSV0/vN0/MmqBRkDAQUGep3RZGDv4QwWTYjAypBEkRt6O5wUw
	CRAzfslgyvLng5h9lXplHSD/QldozwMARreJQFgo53rCAzpejyC5pM9GvVRaSS/MbITbGic7gCp
	4Gv2L8pliuE/lwHdauhVGYB6T81Dw
X-Google-Smtp-Source: AGHT+IFHTmY2k2BwC3lJui/VHCDIA7U6iMp5Q0b1Sh6W7gzZPHX0bNOfOBTy3kxkck3bdfMHtlb95g==
X-Received: by 2002:a2e:a26f:0:b0:332:6f51:951d with SMTP id 38308e7fff4ca-333a213e011mr20627061fa.5.1754902259469;
        Mon, 11 Aug 2025 01:50:59 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-33238911615sm39070741fa.72.2025.08.11.01.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 01:50:58 -0700 (PDT)
Date: Mon, 11 Aug 2025 11:50:55 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 03/11] iio: adc: ad7476: Use mV for internal reference
Message-ID: <1c26529fcc039a3ce8b5a336948229ec727ee281.1754901948.git.mazziesaccount@gmail.com>
References: <cover.1754901948.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/+QrcToVZaXPTnln"
Content-Disposition: inline
In-Reply-To: <cover.1754901948.git.mazziesaccount@gmail.com>


--/+QrcToVZaXPTnln
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ad7476 supports some ICs with an internal reference voltage. For
those ICs the reference voltage has been hard-coded as micro volts, but
the value which is later used in code needs to be milli volts. This
results the need to divide hard coded voltage by 1000 before using it.

Simplify code by changing the hard-coded voltage to millivolts and by
dropping the division.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Reviewed-by: Nuno S=E1 <nuno.sa@analog.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>

---
Revision history:
 v1 =3D> :
 - No changes
---
 drivers/iio/adc/ad7476.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
index f117aafd8fad..7b6d36999afc 100644
--- a/drivers/iio/adc/ad7476.c
+++ b/drivers/iio/adc/ad7476.c
@@ -27,7 +27,7 @@
 struct ad7476_state;
=20
 struct ad7476_chip_info {
-	unsigned int			int_vref_uv;
+	unsigned int			int_vref_mv;
 	struct iio_chan_spec		channel[2];
 	/* channels used when convst gpio is defined */
 	struct iio_chan_spec		convst_channel[2];
@@ -172,7 +172,7 @@ static const struct ad7476_chip_info ad7091r_chip_info =
=3D {
 	.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
 	.convst_channel[0] =3D AD7091R_CONVST_CHAN(12),
 	.convst_channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
-	.int_vref_uv =3D 2500000,
+	.int_vref_mv =3D 2500,
 	.has_vref =3D true,
 	.reset =3D ad7091_reset,
 };
@@ -229,7 +229,7 @@ static const struct ad7476_chip_info ad7475_chip_info =
=3D {
 static const struct ad7476_chip_info ad7495_chip_info =3D {
 	.channel[0] =3D AD7476_CHAN(12),
 	.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
-	.int_vref_uv =3D 2500000,
+	.int_vref_mv =3D 2500,
 	.has_vdrive =3D true,
 };
=20
@@ -295,7 +295,7 @@ static int ad7476_probe(struct spi_device *spi)
 		return -ENODEV;
=20
 	/* Use VCC for reference voltage if vref / internal vref aren't used */
-	if (!st->chip_info->int_vref_uv && !st->chip_info->has_vref) {
+	if (!st->chip_info->int_vref_mv && !st->chip_info->has_vref) {
 		ret =3D devm_regulator_get_enable_read_voltage(&spi->dev, "vcc");
 		if (ret < 0)
 			return ret;
@@ -310,7 +310,7 @@ static int ad7476_probe(struct spi_device *spi)
 		ret =3D devm_regulator_get_enable_read_voltage(&spi->dev, "vref");
 		if (ret < 0) {
 			/* Vref is optional if a device has an internal reference */
-			if (!st->chip_info->int_vref_uv || ret !=3D -ENODEV)
+			if (!st->chip_info->int_vref_mv || ret !=3D -ENODEV)
 				return ret;
 		} else {
 			st->scale_mv =3D ret / 1000;
@@ -318,7 +318,7 @@ static int ad7476_probe(struct spi_device *spi)
 	}
=20
 	if (!st->scale_mv)
-		st->scale_mv =3D st->chip_info->int_vref_uv / 1000;
+		st->scale_mv =3D st->chip_info->int_vref_mv;
=20
 	if (st->chip_info->has_vdrive) {
 		ret =3D devm_regulator_get_enable(&spi->dev, "vdrive");
--=20
2.50.1


--/+QrcToVZaXPTnln
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmiZru8ACgkQeFA3/03a
ocWWGwf/XKgwpuD/gCiceFRvBq+6LP8CgUENnJKdiKRtZl3YeeyHY8Ym00e93ro3
MVS0LgVxnvOsD4FL39lCKbT7b9N7s7t94wthSXC7KVtisrHL/rv5Y7fj6kOn2Fea
agXWpusr6UfKvzo6TEUKKb6jYJAf7hMx/hX8HJBv/nhpxxs3wx/V32gjIW7SfqSF
LeTSh7xWH+YJFIM609hwWGAdA6MWP2hIVTU92wPV6YjXp8w31iHSxznxtYFHNbPr
9lXM+k3FjDQwvdI9Ts71xkqpJfThjvljAzI/491nJnbuGAGZo5jHHyCa6e6eJX5D
QhiWMUMIF/Aiv7tPtzHlo1eKkAHtqg==
=Eg9c
-----END PGP SIGNATURE-----

--/+QrcToVZaXPTnln--

