Return-Path: <linux-iio+bounces-22904-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D365B29BC5
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 10:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38CAC3B3D71
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 08:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8C629B8E8;
	Mon, 18 Aug 2025 08:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mn4RabAY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA232EA74F;
	Mon, 18 Aug 2025 08:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755504768; cv=none; b=iJe4atMHPdpjGlam4vn6+OXmPrMQ8IcC7e7sbxGPZOCMpYp7ERZaw9kcBckwwf83aGfWuF+kG4QMLFsILDKmkUtF2yCCMC9LWUqMIKqjUSPSEEEWub+yOV9WsemU9BJzLBPAtgQ4mTzmejcKUgdFhVwfCh8hSMCZqvSvj4nebkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755504768; c=relaxed/simple;
	bh=D05oO0fD74hI+WlMh1LMrTI4BUEhezUuJab60OrX3mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YB3tYZVhWoeXBKl18OUsGrNYQaijBEvRmdJXiGLhgEdEX2oo9f82w3WG61MwB+5eD+0di+ZTQnY9Y9iC0y5aD72X8JZAKnX1V4ZzT5F21HoX5+jziYMHbeBFDqpVtzxOFgVI0uHiUQMH/BRHXC36DGqJqSUNcokS7v+FjJecJjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mn4RabAY; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-333f8f9ace5so28998751fa.1;
        Mon, 18 Aug 2025 01:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755504764; x=1756109564; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S8yswSF7jRcfzb2zJvzxPF4kutDoBtkeZJQha1Cg7kw=;
        b=Mn4RabAYjEgiSKmIL/gEHL58EN9AYHKzhQP5qhkUONJnlj03wtewEyKBfuRqChMIrW
         tWtni74+p7wTXxSL/6IchNSi782N+iEdNh1Jw91DUbg0ZVftIkEFkvLIrJ7VnykuU338
         6YiEVtsRTxcUQO9GZAEPCqxNFK+OVhOzhOrsEv8RPRKPw0ZET+LonM3GJleKcgQy7aV6
         Sb13rajRXYGmGIquHSQYy5hk0ye4KSNA7tJ0PnZX7ZVYlKZAC32eD5P1GNR6wQ2OwnN6
         zqsAm1MFl21dhMKmYg1/QJl5xNjjuMPQQRSlBCUwX6llXt8fj5xAH3OFa6lWlT4b6rcJ
         O1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755504764; x=1756109564;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S8yswSF7jRcfzb2zJvzxPF4kutDoBtkeZJQha1Cg7kw=;
        b=rNPertV+bMeON22l1JWR0cLGerDaNjazCrBxs9cSCWuJRKT6A1hyOTcBDHKKzH6Hbg
         GDuwJH8xPxKAlh6ivJT2p6jEFNhV6i1yRkFQMgGHASegyOpBdCqg5SLEfttkdCgXvCAu
         oKM5Bg3XPL255MpCcmblQKa7LBzMkEto79KgPMYUAKWZ9ohyfI307+2JdhDzvPJ0F8fI
         8ep2dsrvxhKguu1V9Ym9R3eknqkaHzL1n020KPhiEGVSI7Pc9PK0kBGgi7ur1C65KWSh
         g3cxwFKClqm+spifLkuewTzc7SSgggo4Y4m/RTFf396sv34vNL8uvY8C2+ayls9baGtH
         nhGQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7a4C4mLeENPfnoE05JevGREMX7n63dtSRCJnzEfu4V4Lmn4Vl23sIePsiiQLneAlV/BJqmy1yMTjM@vger.kernel.org, AJvYcCVqEp/kewqi4fRcgIPo/XMPVU/zAaOp5id70HZ167iTDj530IPExwIvaurDlFVHzbrp9gMZSmQ9HHOhAYxF@vger.kernel.org, AJvYcCWJNQUMYVp9eIE7b/3Sb9YH0TWz5wJMhH6lmkNwpomaXs8o4ylgbkLoudDzRic7Ek2P7O+E4B89EIuS@vger.kernel.org
X-Gm-Message-State: AOJu0YyXz8S2o1hce/qux/DR/90ln6lTkL50vg9auS6RVDgWfEuDBCYi
	AB2wSr7A6JrcxDX/owvFORUQKVKc1w1La9bh8aFruUTZz8zozfU9NwmW
X-Gm-Gg: ASbGncsxaqce+cqzfYZ0FRLRZPnIH2/hMjxO2FRV0rPjT38+mTaDfPRWYc/lIuUrMfw
	yKFr/1NgUvP3B/wpFJiq3fCUqzU2Vimn4nqwxuETEjDrCfL2c72mwhiMOzv6TO0F0+eCVoDEyf8
	je5MM8T9SdX7NyKzv2qpMJG44LUrYSXj7nAWn41AmzBc9N3vVvEVU3eaRT4pdYdT/6CR2cc7wUt
	dcbJ0tzcRiJGEWoIVNz5q8fLDcjy/oiGAOEH2/WjYZYfIXch8V1dtYcNJrek6IJQHncxcEg0moe
	DmEyrx77R3kFJ0VdTF0qtFpOXoIPR+jslriaWBdxgRkEtqBxAGm5IbscaTUv6WbIXhUBaHup+F/
	sTTu6zl8zeO7/YSZFWZJfWcvb3yzrRoo9Wny+zL4=
X-Google-Smtp-Source: AGHT+IGduwXuRAIwSfNnUB0OdjGQv3E/HKE4y++8Bp7Idp8Gd6xwmW2Ug+5wzpFtBlqj8NbWJQ6FtA==
X-Received: by 2002:a05:651c:1509:b0:333:bab4:aa73 with SMTP id 38308e7fff4ca-334099d6b3dmr29626991fa.37.1755504764107;
        Mon, 18 Aug 2025 01:12:44 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3340a41e3b8sm16493891fa.14.2025.08.18.01.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 01:12:43 -0700 (PDT)
Date: Mon, 18 Aug 2025 11:12:39 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	David Heidelberg <david@ixit.cz>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] iio: adc: adc128s052: Simplify matching chip_data
Message-ID: <943b6f4852ff0944eeaa0366cbe3b5aaf440cf23.1755504346.git.mazziesaccount@gmail.com>
References: <cover.1755504346.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZPR6NG/dRz/5kmSD"
Content-Disposition: inline
In-Reply-To: <cover.1755504346.git.mazziesaccount@gmail.com>


--ZPR6NG/dRz/5kmSD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The adc128s052 driver supports a few different ICs. IC specific
configuration data is stored in an array. IC data, residing in a
specific point of the array, is pointed from the SPI device match data.

There is no need to have the chip config data structures in an array
and splitting them out of an array has at least following benefits:

- Chip-specific structures can be named after the chips they support.
  This makes referring them a tad cleaner, compared to using a generic
  array name with a numerical index.

- Avoid all potential 'out of bounds' errors which can result if the
  array is changed.

Split the chip configuration data array to individual structures.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>

---
Revision history:
 v1 =3D>
 - No changes

There are couple of other series[1][2] changing this driver ongoing. I
haven't heard of those latelty (after JUN?) so those changes haven't
been taken into account and will conflict if those serieses are re-spun.
Please, let me know if I should rebase my changes.

[1]: https://lore.kernel.org/all/20250614091504.575685-1-sbellary@baylibre.=
com/
[2]: https://lore.kernel.org/all/20250625170218.545654-2-l.rubusch@gmail.co=
m/
---
 drivers/iio/adc/ti-adc128s052.c | 78 +++++++++++++++++----------------
 1 file changed, 41 insertions(+), 37 deletions(-)

diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s05=
2.c
index 1b46a8155803..81153253529e 100644
--- a/drivers/iio/adc/ti-adc128s052.c
+++ b/drivers/iio/adc/ti-adc128s052.c
@@ -124,26 +124,30 @@ static const struct iio_chan_spec adc124s021_channels=
[] =3D {
=20
 static const char * const bd79104_regulators[] =3D { "iovdd" };
=20
-static const struct adc128_configuration adc128_config[] =3D {
-	{
-		.channels =3D adc128s052_channels,
-		.num_channels =3D ARRAY_SIZE(adc128s052_channels),
-		.refname =3D "vref",
-	}, {
-		.channels =3D adc122s021_channels,
-		.num_channels =3D ARRAY_SIZE(adc122s021_channels),
-		.refname =3D "vref",
-	}, {
-		.channels =3D adc124s021_channels,
-		.num_channels =3D ARRAY_SIZE(adc124s021_channels),
-		.refname =3D "vref",
-	}, {
-		.channels =3D adc128s052_channels,
-		.num_channels =3D ARRAY_SIZE(adc128s052_channels),
-		.refname =3D "vdd",
-		.other_regulators =3D &bd79104_regulators,
-		.num_other_regulators =3D 1,
-	},
+static const struct adc128_configuration adc122s_config =3D {
+	.channels =3D adc122s021_channels,
+	.num_channels =3D ARRAY_SIZE(adc122s021_channels),
+	.refname =3D "vref",
+};
+
+static const struct adc128_configuration adc124s_config =3D {
+	.channels =3D adc124s021_channels,
+	.num_channels =3D ARRAY_SIZE(adc124s021_channels),
+	.refname =3D "vref",
+};
+
+static const struct adc128_configuration adc128s_config =3D {
+	.channels =3D adc128s052_channels,
+	.num_channels =3D ARRAY_SIZE(adc128s052_channels),
+	.refname =3D "vref",
+};
+
+static const struct adc128_configuration bd79104_config =3D {
+	.channels =3D adc128s052_channels,
+	.num_channels =3D ARRAY_SIZE(adc128s052_channels),
+	.refname =3D "vdd",
+	.other_regulators =3D &bd79104_regulators,
+	.num_other_regulators =3D 1,
 };
=20
 static const struct iio_info adc128_info =3D {
@@ -199,33 +203,33 @@ static int adc128_probe(struct spi_device *spi)
 }
=20
 static const struct of_device_id adc128_of_match[] =3D {
-	{ .compatible =3D "ti,adc128s052", .data =3D &adc128_config[0] },
-	{ .compatible =3D "ti,adc122s021", .data =3D &adc128_config[1] },
-	{ .compatible =3D "ti,adc122s051", .data =3D &adc128_config[1] },
-	{ .compatible =3D "ti,adc122s101", .data =3D &adc128_config[1] },
-	{ .compatible =3D "ti,adc124s021", .data =3D &adc128_config[2] },
-	{ .compatible =3D "ti,adc124s051", .data =3D &adc128_config[2] },
-	{ .compatible =3D "ti,adc124s101", .data =3D &adc128_config[2] },
-	{ .compatible =3D "rohm,bd79104", .data =3D &adc128_config[3] },
+	{ .compatible =3D "ti,adc128s052", .data =3D &adc128s_config },
+	{ .compatible =3D "ti,adc122s021", .data =3D &adc122s_config },
+	{ .compatible =3D "ti,adc122s051", .data =3D &adc122s_config },
+	{ .compatible =3D "ti,adc122s101", .data =3D &adc122s_config },
+	{ .compatible =3D "ti,adc124s021", .data =3D &adc124s_config },
+	{ .compatible =3D "ti,adc124s051", .data =3D &adc124s_config },
+	{ .compatible =3D "ti,adc124s101", .data =3D &adc124s_config },
+	{ .compatible =3D "rohm,bd79104", .data =3D &bd79104_config },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, adc128_of_match);
=20
 static const struct spi_device_id adc128_id[] =3D {
-	{ "adc128s052", (kernel_ulong_t)&adc128_config[0] },
-	{ "adc122s021",	(kernel_ulong_t)&adc128_config[1] },
-	{ "adc122s051",	(kernel_ulong_t)&adc128_config[1] },
-	{ "adc122s101",	(kernel_ulong_t)&adc128_config[1] },
-	{ "adc124s021", (kernel_ulong_t)&adc128_config[2] },
-	{ "adc124s051", (kernel_ulong_t)&adc128_config[2] },
-	{ "adc124s101", (kernel_ulong_t)&adc128_config[2] },
-	{ "bd79104", (kernel_ulong_t)&adc128_config[3] },
+	{ "adc128s052", (kernel_ulong_t)&adc128s_config },
+	{ "adc122s021",	(kernel_ulong_t)&adc122s_config },
+	{ "adc122s051",	(kernel_ulong_t)&adc122s_config },
+	{ "adc122s101",	(kernel_ulong_t)&adc122s_config },
+	{ "adc124s021", (kernel_ulong_t)&adc124s_config },
+	{ "adc124s051", (kernel_ulong_t)&adc124s_config },
+	{ "adc124s101", (kernel_ulong_t)&adc124s_config },
+	{ "bd79104", (kernel_ulong_t)&bd79104_config },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, adc128_id);
=20
 static const struct acpi_device_id adc128_acpi_match[] =3D {
-	{ "AANT1280", (kernel_ulong_t)&adc128_config[2] },
+	{ "AANT1280", (kernel_ulong_t)&adc124s_config },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, adc128_acpi_match);
--=20
2.50.1


--ZPR6NG/dRz/5kmSD
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmii4HcACgkQeFA3/03a
ocWb+wf7BW6eyO/+ScpdGlorOrBB1wo03ZrkhqgJpP9b/RiPjld5P7mcFtweiy7D
d4Wx2cJ8+wytCN1D5V+5qZ4onzql+JyObFCussh0TeUcNHZiUhwRjczxh7mio3q6
chiePY7TGXNwxQITHyLXOY6HJirB5uKkSfxnJ2+dwHGETbB0TSV29zPywbf8OPf1
h04MsGDmHM4VbTI30Z5iczBKbZY7e36vOJx4CEv5HsXQxflgJ2vy0+bfd5HlyVNN
YJ8sbgr9ThGgHOM9PuhMBER8g2xXbevdW1vAPM20R7iJvIKJXi82ZqHebJ0EXjAw
MbrgFrGUjqKxcWFRp2iZwfZmToKXkA==
=5Q8x
-----END PGP SIGNATURE-----

--ZPR6NG/dRz/5kmSD--

