Return-Path: <linux-iio+bounces-22718-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B8AB25F10
	for <lists+linux-iio@lfdr.de>; Thu, 14 Aug 2025 10:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAB6818998FA
	for <lists+linux-iio@lfdr.de>; Thu, 14 Aug 2025 08:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC7F2E284F;
	Thu, 14 Aug 2025 08:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDEBCR+N"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B122741CD;
	Thu, 14 Aug 2025 08:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755160534; cv=none; b=aG+3foZl58lDuJSEnYy+7CnvgwMGjrwneciTigIRbOsCcVvneX+hYllYjcSOqX6CXNKNcQqPs3Qv2dMwOqsB059u9CdI8nMBJeAncpdvcRCX8ITn3g8gVABN2wc2s5MD0ixfgxbWfpbjXxcYynKNU4yvr4XkOgaLhiZm4V60Y6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755160534; c=relaxed/simple;
	bh=3ac/Xc7fgF8lfWRT+fk8fetiAfhQTO190DDoUMaBTn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LPUt0vEpgHudTklGjPYcAnDLCVDuVH68jVXYiWQjK2cm1NLk4LIl/4tWpVU6kKXYuCJ6rvr2tT7pu1JuYegyF2Rm+Apt4mwDsN6sP6ijS5rjX8kextKtxBVLXO6IMHnfXq+Nt5daxQaG81Q4VW5omxn2FQbMScdyPPBfxrZv2Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aDEBCR+N; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-55ce508cfe0so639409e87.0;
        Thu, 14 Aug 2025 01:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755160530; x=1755765330; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lR/ews5VHtAWFVxZ89duQ7hHL80jD86WFV+5fPOgMaA=;
        b=aDEBCR+NjBZR5E/5JYipzS/K3IX8TWwoGC+zlbc383ZSMGk2cVzhtaq/tA+Jf4N1i7
         rl9IkCrlX4LIMvtru75aZp6GMG4BnXkjP6LXMFNWmTE+/RucoFQTZyZD1V61k804Q/Uf
         857dxGx8FwrzDRUecTrTWRdwDoANl3epaZRQiDX6y+T8qJs42WjRYCAEYidd9AMwTGTl
         Kek/oFzCMIc1FvvtB+YEz7GuFmy606BDD1tAFDsJGCv3NaOP9kjSJJnpLlJBj5CX+RGy
         qCdZCfo/Cd/I8xmzxdxdbEmixaAEw4/s9rkqUgWb89fN8OdsiiyfBmZTwnYV9ke3jHNO
         LNpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755160530; x=1755765330;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lR/ews5VHtAWFVxZ89duQ7hHL80jD86WFV+5fPOgMaA=;
        b=ulgKPpc7wAlztJY/wCqr+txThYRR0qR7P4yhDDgDXy4w3EJ9Yfte7XB2g3L7ErTawj
         6kyB46cTLT8+Iqgngb7Nhp57CxumDN0r4DZojwT2sG7Z7nc4l7Ln8toch9Q0oSQqQ+CB
         nsnlsmNQedQen6Z1rL8r0RP0hWxiztsq2j6eFajPmb2EYNeTNVbgxNMJ4AjvTVbr6em5
         ZcfgqEpaDBt2QwU7hjnK/ZZoV+fHxtLoQyLHde3n7nLMa9/BoHw5AbkrmxsmzMuAWiaP
         7xzQY1IgVRW8ZYGVQmEGyavchoPo4rS8HxjVddEDvxKPavyfd0nd+HuNib70faldy97b
         dJcA==
X-Forwarded-Encrypted: i=1; AJvYcCVceXOtUGLjJG9/Krl8s7FsQfuqfe4m5Cze4Sn2jFphNMCMkppTzwAcRNJU9tumawAI/fwY+7aBEC6grqV6@vger.kernel.org, AJvYcCWYffuYstJgrSx+Re8MCuPsTiT7mUibUL66seAN4sJXP63jqrI8kzXS/etBBiYdz8bKBD5T0rejlB+T@vger.kernel.org, AJvYcCXpXwMt2W1jHRRSKgK8SdY/mL9/KhtBczrt4Z0TWbmqdlmjtk4Ah2v+QSyCQSIPSAekiYx0qtziqyPY@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw5vn9aJRizJOV9pwYsYJ4PQwxZjEeKPM7LCJK6cxXnVWVTzaE
	/4bQfVee1X0zDyq0ct7lWzEwT22UEUi2Fy4jE0dBTcsSM5iOgLdXAoot
X-Gm-Gg: ASbGncuMVqd5U2yWiNCyOfJ6fQcko+/CbapNXdmxOaqOQHj9VIjgiztWtaJjE9lIpaQ
	nR81ew//0vzZxcgGv1/9zlGnSdag5eyyuLv2finf7zepq2lDBJ3nO+9WCp7grGO36yZwa7zSSrO
	sooHsRcAyMI3qigCjbrQauLurHuicS1uI+z3v+I1RCFA17L+6FjSAGIMHQw522VjGshCS6jGjF0
	KknjVCSzx+PhuzPxNd+ykUbnUxU116Tjs/fWCti4kpeF+ne0LYV8JBZh3ztxoxEaBd4FehLIRf7
	rfCxchF/TqI9NhZM1tqSUqkqCSyrG2Xyh/uhkBieXoVzzHk+dZiA88FYLWmgC2g0rS4DhY06Tcg
	Dbkzdc5j4SqQ6AIt/QtFieQgr4T7MzCqeL0s=
X-Google-Smtp-Source: AGHT+IG2h+7SdsbtVCD6DTB8rXVF5r4gZczfVqNOhwZriAoODQYuFbiEbcRU3VHUOtbrbAg7rLU8Lg==
X-Received: by 2002:a05:651c:20cd:10b0:334:97:1105 with SMTP id 38308e7fff4ca-334009728admr892441fa.32.1755160530198;
        Thu, 14 Aug 2025 01:35:30 -0700 (PDT)
Received: from mva-rohm ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-333f8ce95c7sm1954091fa.18.2025.08.14.01.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 01:35:29 -0700 (PDT)
Date: Thu, 14 Aug 2025 11:35:23 +0300
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
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sukrut Bellary <sbellary@baylibre.com>,
	Lothar Rubusch <l.rubusch@gmail.com>
Subject: [PATCH 2/3] iio: adc: adc128s052: Simplify matching chip_data
Message-ID: <b91ca4c576aac225525bbd7cd904bf684e796987.1755159847.git.mazziesaccount@gmail.com>
References: <cover.1755159847.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="H3ro3QwRYAEPiWV/"
Content-Disposition: inline
In-Reply-To: <cover.1755159847.git.mazziesaccount@gmail.com>


--H3ro3QwRYAEPiWV/
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

---
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


--H3ro3QwRYAEPiWV/
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmidn8sACgkQeFA3/03a
ocWO3wf/ewNxDu+hf/K63Wzs8O9XONoiXTRgpNc/JLm4TUudAxIovXY0QVbveDlU
M2YpALH+GXvpZ3w97AtCGDedVh2u2/tFpGjtS10A/Khonbn2gUu8dSHieKMZsKh6
w3nkZlpSnemQUY93InTOS1p/FhzQyLKZ2o34eJswNaXrB058PsbixZh7+kVlrHLh
Z3GzLxMhv2w9sSJkgL1142tdwwbkRp/O4EJsNlsUMEixBDWvBabbZ8t1GIpGrvrO
a66q6GuR60YWP9TX3m5v4rtDWdNCWWkTGFHq3FjOicrGgYkWBRp96rRmg3sEQYpv
I7j262J2hNW5qcrQ22wlxqm45wU0jQ==
=TDT9
-----END PGP SIGNATURE-----

--H3ro3QwRYAEPiWV/--

