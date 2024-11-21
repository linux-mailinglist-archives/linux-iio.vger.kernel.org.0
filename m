Return-Path: <linux-iio+bounces-12444-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 805699D48A5
	for <lists+linux-iio@lfdr.de>; Thu, 21 Nov 2024 09:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBE1CB21FBC
	for <lists+linux-iio@lfdr.de>; Thu, 21 Nov 2024 08:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F3E1C9DFE;
	Thu, 21 Nov 2024 08:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6CS8PSs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F65712FB1B;
	Thu, 21 Nov 2024 08:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732177200; cv=none; b=eiMXlvIWejbChgbwUg6JssYj3VLj4/ciV+8TMMbEj0ItDNSXMfRULnrQctk+qQOjtOo+VmQB4hcatV4+fptc3lBZzm+lWxf143Xi+zIlyoqbk/QRg8XmrJu7RHlya1Xk8hdTneme1uEKwPv4gysIyD3Dg06f4vM88y35sG8zik0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732177200; c=relaxed/simple;
	bh=Tss0VRh4bUkpnT4e1pQi/xtE4i7zCt6siIj9oXDm590=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VA3LcNZOZ326KqwPG5yl7d5RMDVKTvtSnrzC5sUFyyGxubrEI4nidh7PYOMwJHAxLw4kpn4yecFTRNfMjtagf23yXgXVQrZbTm9obo5Bc9wQ0lbOK+uThT91AvIHIB8X5NXGyMfBj3VgbVQoov+G0C6JTciZ5RZJqEwJUl8L3V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6CS8PSs; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53c779ef19cso601994e87.3;
        Thu, 21 Nov 2024 00:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732177197; x=1732781997; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OlxAXQkdmtS4BM481s0Fp1t7se/dqFGAYGKKgz2EH/M=;
        b=Z6CS8PSs974sbWHNHK1bt8POU38JN6kJEKDQA3rD4Q5Zw4lBxmfPXHCIATd+F/ogUh
         PTjRvspllNSvW2J2QkNCagokJSvSY6z8C4BUKRYVcyhf4Cr2XwHyqNIpqBVk/imGa6Ql
         GUFw5aoAN+OPtjLSqt10ac0rCzcXkBJB84IJudXv9pl8yZJcUCkW6fbjbX7Y5ON/Elws
         ZpLZLUX0DabpifEZPwnDnYQ4HXdLnQNODE24yU2BS/1CV30zEnW3yBUVCOz7FJ4SB8T6
         lXCxewUXqwpkh/BkCm9Y5vnuH106kA5L9NzcPsar/+JwfigweNYU6matXROho3dWUgq/
         dzDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732177197; x=1732781997;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OlxAXQkdmtS4BM481s0Fp1t7se/dqFGAYGKKgz2EH/M=;
        b=HW1Tuk8wG93twME1CvzKh8AEwv4pcmMdSHDKeOhOaWw1fFAoImposm1qfipLAlLn5p
         t8NFxd0DwA3vO+lj41kEkvWD2nhm+wEeA6qxQ/XhEEylyNpko3kWcUHEwautm4GmvIQI
         Og4tUg1DiBt6AF1p/Ly2hXnt23pDkh5DMuUfMDTW9L6R5gfMgEEIg0pOUTMRmLH70LdI
         2TjunG+I1/mp2bfNOhexchYRJK0WOArxTd/d5DNk5AcWlUlv0SFY+kBLHU3Q/CpxzXqP
         3xOCKnQAX1NyzL2y1Rarp2j3rq3hTgcUnitFBrF9qUtZqvesxQeXdE5QJBoH19FF96ay
         NkvA==
X-Forwarded-Encrypted: i=1; AJvYcCW5DUhwWIPWQn6f00zWGDdo0sJUJFt3cqyL0IrP21iMvbGs9jERccGewvIk5UTBu5gjDPEOxcoHZLgP@vger.kernel.org, AJvYcCWMCoOSQ6yy1eVpqrOGQsL7KaucAHZAmtDzlnndaJaGD3msEjNDr4flpUQnkUqBjGbu+hMhGbNmUzFOtMok@vger.kernel.org, AJvYcCXTqNIqa3Rb1E66ARhiqHwMjK8+0UHoHKx1H/cIgOACA5E9aZpADPjRopdwt8+CZOHk8Cm64Otbr86l@vger.kernel.org
X-Gm-Message-State: AOJu0YxOz6Mwk11/l1Pa5Qh70ge57I33h8RsCRhdeaFH7FBu9c66q44c
	2TMh1ObZKvVU6lR+3eAeBeZxI6o3biZ2fg4FBPYmGKuW4XOI5kVY
X-Google-Smtp-Source: AGHT+IGJpIHKOj5CJVrOfwGtGE4ZDsCzVd9RLKW0rpNvfkRI/vdt9yfJLkLmfW+ioEK13LToXgGydg==
X-Received: by 2002:ac2:4c28:0:b0:53a:97a:a394 with SMTP id 2adb3069b0e04-53dc136d9b2mr2157280e87.57.1732177196343;
        Thu, 21 Nov 2024 00:19:56 -0800 (PST)
Received: from mva-rohm ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dbd3fcd9fsm901063e87.108.2024.11.21.00.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 00:19:54 -0800 (PST)
Date: Thu, 21 Nov 2024 10:19:50 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/8] iio: accel: kx022a: Improve reset delay
Message-ID: <ac1b6705945cded0e79593d64e55522681e00f9a.1732105157.git.mazziesaccount@gmail.com>
References: <cover.1732105157.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XEAJFvXu5iP+3zIm"
Content-Disposition: inline
In-Reply-To: <cover.1732105157.git.mazziesaccount@gmail.com>


--XEAJFvXu5iP+3zIm
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

Revision history:
  v1 =3D> v2:
  - Included in the series of improvements (was a separate patch)
  - rebased on iio/testing to avoid conflicts with queued fixes
---
 drivers/iio/accel/kionix-kx022a.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-k=
x022a.c
index 53261e1d5d1f..b6664299e0d5 100644
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
--=20
2.47.0


--XEAJFvXu5iP+3zIm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmc+7SUACgkQeFA3/03a
ocXccggAvZxoGz08sB2clE/8gndjLGZmorAWt8OYWu2m9Fm8ELsMzZjUtjyTYrnB
p1V0w9XXFWLzQEJXoQKFBZLjJeGk6frBGEUuO75ud10eXhPMmWmSYdHPWQVqAxvi
7sMPowTH+I97rQ/0lDFnVdHm+GNCPyPymF45378Tk1lvyOVM+oUvaQ8o1BogtlSy
nsSK8BIUPdhvt5cFINQhfBiE47ImH+7rjeXyz47/hfH1jqhlxC0Qq3J5Xr2xug2U
3PUOXymJdxkd2yP/eueGENj2suQPA2mOQWRHBtl6f3Zi1v4p/WkjMZjnkmBhpEdK
QtVHRp67oWIXqWV05f8PUs4HubmeeQ==
=lKn8
-----END PGP SIGNATURE-----

--XEAJFvXu5iP+3zIm--

