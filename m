Return-Path: <linux-iio+bounces-22389-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4237CB1D4ED
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 11:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 762BC1895CD1
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 09:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F0C26B2AC;
	Thu,  7 Aug 2025 09:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nccU0hpY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61185269B01;
	Thu,  7 Aug 2025 09:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754559290; cv=none; b=ShQdCSHYg2mmc22PoeScXtpovlWo70mUhs3VK4E0Bt/EoPPFPWOpdy6YR+HeSrVGOvthb0DbCAUbF58c1oYuSxQb6yiuJWmYlvzXkmQwapGKy8aY3N2WxyD7OUCG8dREXjOW0whEVqrlMjNoivbXxV2SRZBcotfcGagDFvHAzUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754559290; c=relaxed/simple;
	bh=qPsfKAkOdwlhmMMYBpBVCtzg2cdLQVNNlgpnEcJ2Xrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HmxWLD40bSgPI20VsY47jcvorTLsuwYXP+oWP8lnmjottxxvWUnxA/fBek32KKslAygiWAHywcgkGuBnukerRfTlQ176mA2SoGqhZI9j9AL26PxKbOfwNeKWJLv2gfADwcphr8C7RhFDX/0/H+iMYBZuF5kcZCNtsSl4XPKivFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nccU0hpY; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-55b733911b3so809425e87.2;
        Thu, 07 Aug 2025 02:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754559286; x=1755164086; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dEdCWZIEU9/qClM35NNTpEudJXJlEAKAMyhURC1S95w=;
        b=nccU0hpYl56J9OifH0ZiJOGpyb2vemHv1wu4CpUj4HFWj85PEMMCeOIti07uWAfQ1o
         TaTI/Qk63HsSHW5IzeP2IJu7HOMSQ0nBO391EfPTnDzlQajgwphJ3s7PBq5SIA/WcJFW
         gL2qFhctpvRPmFHM3WukYWKa9p0cDHlDXw+O7wdEZw6nc0wD89OYw4s0wVGGJP14aLnJ
         J15SSjSlijCXqTWYeiUnyqTJux8Irr2g7TNdeR49SoOIHGfzj3c3Eh53/01gkJrd5mUg
         WRZOLqH2ggtpnod5Hb+bNl6SQpzXSp0lkIG/IK5695F7j7FMgqyq1vhrqNQgWYyALjdt
         2JrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754559286; x=1755164086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dEdCWZIEU9/qClM35NNTpEudJXJlEAKAMyhURC1S95w=;
        b=xIJ417k8x1CRwQiLBzMflATgqcIqvIL6Q1BVkrPrX1AM3+t+hEL6V3rkLZuapDBwQN
         NV+qFDeiRhb/CeUNhxNZWsHHkJ0/3fngSY/BKrlLbltFyRNXGQHpojDrHK68uVirJxAg
         TdMlR7Xdu4MqVSFEeZ4p+YgdLe5Z57M7Sp4si1ycLPC0BuZx3oP6wWBtjVEEpbo4oxBH
         auVBW/nHSN4MMx3VwYw9sVapyroZnkMlPHKX+a6/kIwoaher29qmmpW/Ln1+bfOB3Qzy
         aac66l5S7Y9ftSLiDU/vMGUq00lbOxzlglIe6u+V6nVH7hghQ7g3Hq6rZaQPYPGgzwD7
         UjYw==
X-Forwarded-Encrypted: i=1; AJvYcCVH2SW4Bs85Gc1N9xJ3S/x5VFtmT0YPDcfoIsz1m+Yg+sl5c7nw6z+eLoDvdAhg3CPDTK/hunf1rC+yGGe8@vger.kernel.org, AJvYcCVa2aFWuw12z43PQbSYAkHB+XCnqWuao1P00NPQ6hDZvmp4h3TQI2Tkn3RlWYMuhmGJQC2CItJ1v83R@vger.kernel.org, AJvYcCWPJ/Y9qQI+/5OWuaOnPYseZ42+7HRDjo+ifbLjzVYoAWgMk+0aaQvdidPAgr0aVMilJgRzZamvRjPb@vger.kernel.org
X-Gm-Message-State: AOJu0YwdvGHVe2XZISd2k3RtWdb0wsk0Afn9O17SuQqck8qOX3EX0SHk
	a3XskOY4L7mL8lxb/C57d/MJOHvXaHoD7rOEi52kcnY4MnUiR1r4QuPh
X-Gm-Gg: ASbGncsjpU3/i0a3wlGDg6YSkkK3KMiPZRR0dxlZreBxZpDiqXuWq218zMKshvWkNZY
	JSBS6UUzV3YcuSKjIj3ZSV+mIp2MiSdMLAhfzoTdZqA+KYlNA9/dksMCHzDU2/CMGDkAtQEiagL
	YYojB0xHI9KlTQF1jyfLvO3WJivi/5nCFouKGGZTIh3Vf0jlHvzmq+4CGDH7ZAz76FZg07aYCLV
	6SKCO9OmFMQl5iD+hFDEAiXaUMGJSjt2K7aVXl/zJ+Y30nwTNpzVYi2dADmUa9e1K5QK4C+yS75
	jdJytjybFRnXvk8LfhrQpMuBAMaKcdo/eFzvp9WVZ5CvEl6tF8IvIJZgoe6ehQ6hSjv42/W2Tlp
	hir5lnIjycCj70C93kXqVRAUs5DBu
X-Google-Smtp-Source: AGHT+IGQDjOJ3EWcCO3jjdJTeflvMlvbULMrCmzMM71regQzvLzMOZoVRkX+hCBRm6SWEm3UfTX4bA==
X-Received: by 2002:ac2:4bc1:0:b0:55b:914c:d0dd with SMTP id 2adb3069b0e04-55caf30641emr2157315e87.23.1754559286168;
        Thu, 07 Aug 2025 02:34:46 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b9f90f0c6sm1567613e87.7.2025.08.07.02.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 02:34:45 -0700 (PDT)
Date: Thu, 7 Aug 2025 12:34:41 +0300
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
Subject: [PATCH v2 05/10] iio: adc: ad7476: Limit the scope of the chip_info
Message-ID: <b23ac0b287926b87c36c74e9057139c18e3f4c91.1754559149.git.mazziesaccount@gmail.com>
References: <cover.1754559149.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nA78UKiSkG7Cylmn"
Content-Disposition: inline
In-Reply-To: <cover.1754559149.git.mazziesaccount@gmail.com>


--nA78UKiSkG7Cylmn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The chip_info structure is not required to be accessed after probe.

Remove the chip_info pointer from the driver data to reduce the scope
and to make driver clearer.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
Revision history:
 v1 =3D> v2:
 - New patch
---
 drivers/iio/adc/ad7476.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
index fc701267358e..e97742912b8e 100644
--- a/drivers/iio/adc/ad7476.c
+++ b/drivers/iio/adc/ad7476.c
@@ -38,7 +38,6 @@ struct ad7476_chip_info {
=20
 struct ad7476_state {
 	struct spi_device		*spi;
-	const struct ad7476_chip_info	*chip_info;
 	struct gpio_desc		*convst_gpio;
 	struct spi_transfer		xfer;
 	struct spi_message		msg;
@@ -280,6 +279,7 @@ static const struct iio_info ad7476_info =3D {
=20
 static int ad7476_probe(struct spi_device *spi)
 {
+	const struct ad7476_chip_info *chip_info;
 	struct ad7476_state *st;
 	struct iio_dev *indio_dev;
 	int ret;
@@ -290,12 +290,12 @@ static int ad7476_probe(struct spi_device *spi)
=20
 	st =3D iio_priv(indio_dev);
=20
-	st->chip_info =3D spi_get_device_match_data(spi);
-	if (!st->chip_info)
+	chip_info =3D spi_get_device_match_data(spi);
+	if (!chip_info)
 		return -ENODEV;
=20
 	/* Use VCC for reference voltage if vref / internal vref aren't used */
-	if (!st->chip_info->int_vref_mv && !st->chip_info->has_vref) {
+	if (!chip_info->int_vref_mv && !chip_info->has_vref) {
 		ret =3D devm_regulator_get_enable_read_voltage(&spi->dev, "vcc");
 		if (ret < 0)
 			return ret;
@@ -306,11 +306,11 @@ static int ad7476_probe(struct spi_device *spi)
 			return ret;
 	}
=20
-	if (st->chip_info->has_vref) {
+	if (chip_info->has_vref) {
 		ret =3D devm_regulator_get_enable_read_voltage(&spi->dev, "vref");
 		if (ret < 0) {
 			/* Vref is optional if a device has an internal reference */
-			if (!st->chip_info->int_vref_mv || ret !=3D -ENODEV)
+			if (!chip_info->int_vref_mv || ret !=3D -ENODEV)
 				return ret;
 		} else {
 			st->scale_mv =3D ret / 1000;
@@ -318,9 +318,9 @@ static int ad7476_probe(struct spi_device *spi)
 	}
=20
 	if (!st->scale_mv)
-		st->scale_mv =3D st->chip_info->int_vref_mv;
+		st->scale_mv =3D chip_info->int_vref_mv;
=20
-	if (st->chip_info->has_vdrive) {
+	if (chip_info->has_vdrive) {
 		ret =3D devm_regulator_get_enable(&spi->dev, "vdrive");
 		if (ret)
 			return ret;
@@ -336,12 +336,12 @@ static int ad7476_probe(struct spi_device *spi)
=20
 	indio_dev->name =3D spi_get_device_id(spi)->name;
 	indio_dev->modes =3D INDIO_DIRECT_MODE;
-	indio_dev->channels =3D st->chip_info->channel;
+	indio_dev->channels =3D chip_info->channel;
 	indio_dev->num_channels =3D 2;
 	indio_dev->info =3D &ad7476_info;
=20
 	if (st->convst_gpio)
-		indio_dev->channels =3D st->chip_info->convst_channel;
+		indio_dev->channels =3D chip_info->convst_channel;
 	/* Setup default message */
=20
 	st->xfer.rx_buf =3D &st->data;
@@ -355,8 +355,8 @@ static int ad7476_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
=20
-	if (st->chip_info->reset)
-		st->chip_info->reset(st);
+	if (chip_info->reset)
+		chip_info->reset(st);
=20
 	return devm_iio_device_register(&spi->dev, indio_dev);
 }
--=20
2.50.1


--nA78UKiSkG7Cylmn
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmiUczEACgkQeFA3/03a
ocU2tgf/Q41tk43emXzWe6VTVSoKP6nwCxzHyfNZ2q18U0UH2cN4R8lUT5OxRW37
rLfebnEmLh+Jf2KXNkxttP3v8QNjJcbWWTMpa2f4HVb606Y+046ujtI2tZ+HaJby
wPnmB3lTTmTW5Zc35tO58mzf701zPhF0vgET1rMXwIVvOcewSLKdIqoJPc85rDlI
3wLatm87rB/scUoMdaTj8zUlFcDsvLFe/YFHFKUUDCz1e/3vAiRylHS7pl+nqT4j
l6EuBLuQL8cduTfLvj1YseLGK23/FRIdmstas1c6H8H9sAxM2qNtNgd/6loTGiUw
0jLa7FfuXftLUBQN/1Lu8HdZ3Akp3w==
=qLDy
-----END PGP SIGNATURE-----

--nA78UKiSkG7Cylmn--

