Return-Path: <linux-iio+bounces-12232-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9A79C8376
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 07:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9474A1F23E6A
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 06:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871891F4718;
	Thu, 14 Nov 2024 06:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SbtgU/Mi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4AE1F26FA;
	Thu, 14 Nov 2024 06:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731567482; cv=none; b=kldY39rm0HDBNw9KLnJwsUvMTOhgBJkcRplKt2gpMjmGjYcDwE9IKPvWOuw0nVmZWXo2N5Z69EyC6x50b7u8Vv8z0tuq+iiPICZLItpBdjuLEGEeoeBXV+eKrTSaKXv/aOTC5XAqCYiMDo90RXJzsmfFyYw+vDGmngjWu0pHTZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731567482; c=relaxed/simple;
	bh=Zv9uCZDUG9YPSYSHdZchnYQgyUHvMZfsNI407pdWflA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NQ1Z3NJ4sp0OZreyH6cb0VaF10Ubp12J0hosbvuaxrSvYAviEzYOqZ+Q545KwQzlq8zexylo2E0fP1v9VF92AMppzFbAM9eG9rB0z5AJYQiE9G3mGG/pdLyHTPWT6Io1k0HfkCMXPsA3vm6l0+Xf7nk+d6WinIQqa/kR1bSZ/FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SbtgU/Mi; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53da2140769so229652e87.3;
        Wed, 13 Nov 2024 22:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731567479; x=1732172279; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HQvu8qpkTuOmaCDLs3K7wp8azv2ggugqL4tMIcW8k+0=;
        b=SbtgU/MiKOOjgY+ShdX4bVYsD4isAnDqTe+2Dc9oe6ZE2wAyQXj0yEx56R7aGmsbs0
         z0sV00Zh66JX7KQvghVm6P21ZVzUAptBt+IL1syB6jsbGQGdNKwpplSstyS705qRqTZb
         sR9tzBY8oIu2Ut57TKeBWFuV55ANuFvQk19cFRnKSBzGCz6FLt+Q7FlbfN091ZT5Q+k8
         exZ5Xek44nTbC9G/PBqRfXOrTtH/p2tbyh5sCWMogojafICRVvMXHizgvxebfYDq1Gb9
         ZKsDBxuTxsB46dcjazA6XwsXQY4XbOzrx5gUzpLKqxk+6e/ErNTgb31pq5DM23Hs3+jH
         FPPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731567479; x=1732172279;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HQvu8qpkTuOmaCDLs3K7wp8azv2ggugqL4tMIcW8k+0=;
        b=i3LCW9Cw9FKufr01KGeLFLrULVSzX0bMvLjqYj72YNkn60f1u1ZogHX/BQ8ALq7l4B
         nFvuziJ/S/mKgku1DAx+8VjtsSLoUfiEuc/CV1S9gXFAm6L9fvpZY7aDwmlo7rGWXVvd
         J5JyVCZvXlObBfCfZaNKOdrJMnLTVX51pIAVjPuVZ9M31e9zaTaLiaDVviZKMj7FDjVj
         QPgIrFiSPv+hTRpl15X7Xxz89YdYZSsCwjlU5lI+7/0QVjAFyHyRoytrifWaxID8D8e9
         kIbdu4eSY/DcyRRyi3Tp5J3fC0DAi3cvOl4Ah9yE7/d1VT3gzDiSI/YdOM5JPfxClGDi
         RAOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWcNbEFoV85iBGTQVn7d3nLcYKqsuGGrPM58iW5JBUIgKRAyFUUB76ut+Z9Q6GpomHblUVnxgWPgiToLio@vger.kernel.org, AJvYcCW8Ge6+VeW++udL9GZufanhDrY2bsxtRlZgFeBdT3bg0rD1eSqePcMrcPt2oVX+M7HZySgO7wk6gVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvgYQB454RgH8l2qzsB5UJ5ELzB6LErNv3SKdBwAcNVBTMrwoD
	braMTPRuxKPNZveY6FMjfkVfYI7cZmJ4lM8ZrpyRcxJdx6jOo1qb
X-Google-Smtp-Source: AGHT+IEd+tK0d2d+aoGBzvmNBm1iUBElUQdEeHOWSbiPuZPC1DOytBUgVHs/Px+4M0rw6ss/PNJhyw==
X-Received: by 2002:a05:6512:3082:b0:535:66ff:c681 with SMTP id 2adb3069b0e04-53da5c8253bmr431535e87.48.1731567478223;
        Wed, 13 Nov 2024 22:57:58 -0800 (PST)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53da6530f4csm82680e87.121.2024.11.13.22.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 22:57:56 -0800 (PST)
Date: Thu, 14 Nov 2024 08:57:33 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: accel: kx022a: Improve reset delay
Message-ID: <ZzWfXbjaDkFnu_Jg@mva-rohm>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sgl4xp2O5KP6tcvY"
Content-Disposition: inline


--sgl4xp2O5KP6tcvY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

All the sensors supported by kx022a driver seemed to require some delay
after software reset to be operational again. More or less a random
msleep(1) was added to cause the driver to go to sleep so the sensor has
time to become operational again.

Now we have official docuumentation available:
https://fscdn.rohm.com/kionix/en/document/AN010_KX022ACR-Z_Power-on_Procedu=
re_E.pdf
https://fscdn.rohm.com/kionix/en/document/TN027-Power-On-Procedure.pdf
https://fscdn.rohm.com/kionix/en/document/AN011_KX134ACR-LBZ_Power-on_Proce=
dure_E.pdf

stating the required time is 2 ms.

Due to the nature of the current msleep implementation, the msleep(1) is
likely to be sleeping more than 2ms already - but the value "1" is
misleading in case someone needs to optimize the start time and change
the msleep to a more accurate delay. Hence it is better for
"documentation" purposes to use value which actually reflects the
specified 2ms wait time.

Change the value of delay after software reset to match the
specifications and add links to the power-on procedure specifications.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
Sorry for not including this to the KX134ACR-LBZ series I sent
yesterday. It was only half an hour after I had sent the KX134ACR-LBZ
support when I was notified about the existence of the KX022ACR-Z
start-up procedure specification... Hence this lone patch to code which
I just sent a miscallaneous series for before.

 drivers/iio/accel/kionix-kx022a.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-k=
x022a.c
index 32387819995d..ccabe2e3b130 100644
--- a/drivers/iio/accel/kionix-kx022a.c
+++ b/drivers/iio/accel/kionix-kx022a.c
@@ -1121,10 +1121,15 @@ static int kx022a_chip_init(struct kx022a_data *dat=
a)
 		return ret;
=20
 	/*
-	 * I've seen I2C read failures if we poll too fast after the sensor
-	 * reset. Slight delay gives I2C block the time to recover.
+	 * According to the power-on procedure documents, there is (at least)
+	 * 2ms delay required after the software reset. This should be same for
+	 * all, KX022ACR-Z, KX132-1211, KX132ACR-LBZ and KX134ACR-LBZ.
+	 *
+	 * https://fscdn.rohm.com/kionix/en/document/AN010_KX022ACR-Z_Power-on_Pr=
ocedure_E.pdf
+	 * https://fscdn.rohm.com/kionix/en/document/TN027-Power-On-Procedure.pdf
+	 * https://fscdn.rohm.com/kionix/en/document/AN011_KX134ACR-LBZ_Power-on_=
Procedure_E.pdf
 	 */
-	msleep(1);
+	msleep(2);
=20
 	ret =3D regmap_read_poll_timeout(data->regmap, data->chip_info->cntl2, va=
l,
 				       !(val & KX022A_MASK_SRST),

base-commit: 20fd1383cd616d61b2a79967da1221dc6cfb8430
--=20
2.47.0


--sgl4xp2O5KP6tcvY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmc1n1gACgkQeFA3/03a
ocVbVgf/T+Zsndk2gbycuXLY8HPITdayiKuAnKym9glsbYywQ2uMLkgLRJIpOT8W
MH4a624wHDZowhkDSx7EmrF2jqh3CJbD5ruOTVCLyNS9f47rKPp6OZwV/88TeDZo
8cGGyuosv/QgeMGDk5blVzLaX+M7PTZnel1jGz536b+2BW8yzZ/p/Dv0IgTiHJ52
CgKAJtOusCPvf0fzUPaZlawGYV4k6nMF7KdvfcRooZAAhwwKIBPch+ETSDhE4hsK
Y20mG1SAmvEPxiykRvXeuGb1nmJuPWZP9ZhpYVUgsj6/ksCBoZVDwC0ohvgmNFEj
rQsI5cKP4+/BjCS3xZJek+5Y2M8Zpg==
=0QC0
-----END PGP SIGNATURE-----

--sgl4xp2O5KP6tcvY--

