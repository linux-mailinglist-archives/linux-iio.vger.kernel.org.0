Return-Path: <linux-iio+bounces-22719-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72025B25F13
	for <lists+linux-iio@lfdr.de>; Thu, 14 Aug 2025 10:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92B831C828C2
	for <lists+linux-iio@lfdr.de>; Thu, 14 Aug 2025 08:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B6D2E11BF;
	Thu, 14 Aug 2025 08:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TH3QWULM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67ACA2580D7;
	Thu, 14 Aug 2025 08:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755160546; cv=none; b=kyJxr+vEneqVM0pvcxLft9fTvASTwOyao02TftHWJD7Mb3E2jv8yTNg6KK6OErYxr0jgmujC6ck4xCYat44EPrjzYzB+zZ8IOzrALGwDqVwxbGmcIE0g2sHXTiwGahNWZALPLPmymvqoAF+JL+Jm/XfsAxfKfcTgK42UTczwtR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755160546; c=relaxed/simple;
	bh=WaOHZZiP2R3EwHbR/iA9SjuRqyg+X3URHBMmj281Ryg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lDMFd9CEabDVemU7LBgQEEi4LWdvKUWiUXxXEpg0qaTpJt5XOuaeTOioI6WnYhFP2StRvji3ut/vEnZ5Rpn9kLD3mH3xU1Cs3jJqEk+KXlOWP+/JY9OXEU8xYWlFSLoMmTlGbF5PxjITUHZwSvKzvU6emR22qCfQhi8JYgn0MGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TH3QWULM; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-55ce509127bso529666e87.0;
        Thu, 14 Aug 2025 01:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755160542; x=1755765342; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ht4+WuCclIjF62P/XUWWfv84cD1c1L3az5bzoDE1sSQ=;
        b=TH3QWULMb9/YnJVO0uUes49sjhm9sAF6Zc0Qpk4t9U+xpANzzOF3vi9T6+BH5bsEUQ
         e6b+Op9mhBFUoFiKhDXiDGQKdfbe5Kz1zk/2dCHBilHCUUwb0LK0pcunM4e4KOvHRj0+
         Np2ScB0X8XhsV/jhnEmFCCvXScwNTj8I1qZfyOJlH+sQtcO2UDyHZTBEroyos0+avVl+
         DylvWZXVpbKP19VBSK8p9ylV6hnS+8kyTRXqEgf0yVz0eoV5AqLy4odk8XGodEsmQ6rU
         YjCe3sJYKJLw4mzRBvdO9s6eANWH1EA3q8mgMFcBQb5jtX+jDvpju+0ptf66Hztt3zUB
         f0Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755160542; x=1755765342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ht4+WuCclIjF62P/XUWWfv84cD1c1L3az5bzoDE1sSQ=;
        b=UNkB1eJDlVUgKe95fz6yfjBztpSe+KOgKpJCdH0Ox4W/9iItFI2JaRXkt1rQ2Xqsws
         TbBGR8hKTgqlDNfZ2sdEevB4PaRC1d0E+wutPw5zDq4NchnOT4KBcKY6XxZVTGf1T/9I
         ExXZIQmnjGXsc9IjkFUvOYeATkifnALoo2/lryOKPvu/FaBTbDWoAflmaFS+X4lW+jKP
         +31T4b2jaj8rM8ELLVTIlMuFeJdhnXLcJ6EPz+p3bfXK9Frmwm1wmXahP9eZ0WVX9ySS
         GUXIFo9cXozmiFUP5s4yfTLI9yCGUdXsJIOgza2DE6cEdp3zYIvlcJXNROzPK26mOZHD
         clqA==
X-Forwarded-Encrypted: i=1; AJvYcCVj+5372a/Vn1FXU2DAb2ScpD3e59p3hON/9x8jhIY5UzFiShWsHQC2MfNlPClNjnzQBm2B8ZuDQWSz@vger.kernel.org, AJvYcCWM4dFGc+N51iNHRtgG+HTZz57NrKTUryRzt3kIOaPG9XD0P5dPFxArfr/zWaWmx6Aku3RHVujiFENWVq2q@vger.kernel.org, AJvYcCWvieeMaOo4UJXyC2ZEL3Sf2hASAKY4HlJpRjb+CYBzqrJRUUgIURx1UW6b3lOymVUdzrMieh9yCAL9@vger.kernel.org
X-Gm-Message-State: AOJu0YydRGJDoiODtTD3a7ZbWwdsk+vx3eqcyJxLogTlMnIoE6T96qDk
	Q1B/OkHFg4YbmGwCbfA/YS7Im2k6aS5YeABbUHslCjW2OdWQ+jKpKF/I9Wtmqw==
X-Gm-Gg: ASbGncuU0mCubIjhmchG8hYQ0jGscKvdMhJtZrQr7BnoqQLWJnSE6E268RbigruvtJX
	JdsChkALYtJyYbVKhTtQ09jt9CYbQ9FLLzKIyZQ4i5Qx7ppOM7nVFvLxjiBMODqS8BoevROxJQt
	xW+GdD2F9QKMCJEpy2hIQsF6V4JU2EoybgWq/OpmlhsDLtAomukcZYW2AFypKKsZBw8uGVJdpqC
	TgqxYaUYV23bGrlotsT56jp0jsDlxInjm7QpJzRaGRL9roFZayNZQGrAC1wD9TTE9axujWZYdjz
	FglM/ECQIGZgZO2tao5xT3oWahiQZRRQCtnSPezlht6qowtP1jbfGXlxAfZ9WIj6bpvgqFr1hQH
	qxFbxut75AtwwMahLXvFNF4yM
X-Google-Smtp-Source: AGHT+IFx5zwb/Nodxv8hOdTbdKr/qi9nYS9WK66oxmazbUzRaJePPvUXSXJSUnrthUlk4i5mLboKhg==
X-Received: by 2002:a05:6512:1302:b0:55b:885b:390d with SMTP id 2adb3069b0e04-55ce4fd6963mr852944e87.0.1755160542169;
        Thu, 14 Aug 2025 01:35:42 -0700 (PDT)
Received: from mva-rohm ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88c99057sm5572085e87.91.2025.08.14.01.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 01:35:41 -0700 (PDT)
Date: Thu, 14 Aug 2025 11:35:37 +0300
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
Subject: [PATCH 3/3] iio: adc: adc128s052: Support ROHM BD7910[0,1,2,3]
Message-ID: <e43c184fc6aa5c768045fc772b64d812fdb06254.1755159847.git.mazziesaccount@gmail.com>
References: <cover.1755159847.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RBe/8Sbrp2Y9Vhm6"
Content-Disposition: inline
In-Reply-To: <cover.1755159847.git.mazziesaccount@gmail.com>


--RBe/8Sbrp2Y9Vhm6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ROHM BD79100, BD79101, BD79102, BD79103 are very similar ADCs as the
ROHM BD79104. The BD79100 has only 1 channel. BD79101 has 2 channels and
the BD79102 has 4 channels. Both BD79103 and BD79104 have 4 channels,
and, based on the data sheets, they seem identical from the software
point-of-view.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Tested only using the BD79104. The ROHM hardware colleagues swore this
testing should be sufficient...
---
 drivers/iio/adc/ti-adc128s052.c | 36 +++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s05=
2.c
index 81153253529e..2f2ed438cf4e 100644
--- a/drivers/iio/adc/ti-adc128s052.c
+++ b/drivers/iio/adc/ti-adc128s052.c
@@ -122,6 +122,10 @@ static const struct iio_chan_spec adc124s021_channels[=
] =3D {
 	ADC128_VOLTAGE_CHANNEL(3),
 };
=20
+static const struct iio_chan_spec bd79100_channels[] =3D {
+	ADC128_VOLTAGE_CHANNEL(0),
+};
+
 static const char * const bd79104_regulators[] =3D { "iovdd" };
=20
 static const struct adc128_configuration adc122s_config =3D {
@@ -142,6 +146,30 @@ static const struct adc128_configuration adc128s_confi=
g =3D {
 	.refname =3D "vref",
 };
=20
+static const struct adc128_configuration bd79100_config =3D {
+	.channels =3D bd79100_channels,
+	.num_channels =3D ARRAY_SIZE(bd79100_channels),
+	.refname =3D "vdd",
+	.other_regulators =3D &bd79104_regulators,
+	.num_other_regulators =3D 1,
+};
+
+static const struct adc128_configuration bd79101_config =3D {
+	.channels =3D adc122s021_channels,
+	.num_channels =3D ARRAY_SIZE(adc122s021_channels),
+	.refname =3D "vdd",
+	.other_regulators =3D &bd79104_regulators,
+	.num_other_regulators =3D 1,
+};
+
+static const struct adc128_configuration bd79102_config =3D {
+	.channels =3D adc124s021_channels,
+	.num_channels =3D ARRAY_SIZE(adc124s021_channels),
+	.refname =3D "vdd",
+	.other_regulators =3D &bd79104_regulators,
+	.num_other_regulators =3D 1,
+};
+
 static const struct adc128_configuration bd79104_config =3D {
 	.channels =3D adc128s052_channels,
 	.num_channels =3D ARRAY_SIZE(adc128s052_channels),
@@ -210,6 +238,10 @@ static const struct of_device_id adc128_of_match[] =3D=
 {
 	{ .compatible =3D "ti,adc124s021", .data =3D &adc124s_config },
 	{ .compatible =3D "ti,adc124s051", .data =3D &adc124s_config },
 	{ .compatible =3D "ti,adc124s101", .data =3D &adc124s_config },
+	{ .compatible =3D "rohm,bd79100", .data =3D &bd79100_config },
+	{ .compatible =3D "rohm,bd79101", .data =3D &bd79101_config },
+	{ .compatible =3D "rohm,bd79102", .data =3D &bd79102_config },
+	{ .compatible =3D "rohm,bd79103", .data =3D &bd79104_config },
 	{ .compatible =3D "rohm,bd79104", .data =3D &bd79104_config },
 	{ }
 };
@@ -223,6 +255,10 @@ static const struct spi_device_id adc128_id[] =3D {
 	{ "adc124s021", (kernel_ulong_t)&adc124s_config },
 	{ "adc124s051", (kernel_ulong_t)&adc124s_config },
 	{ "adc124s101", (kernel_ulong_t)&adc124s_config },
+	{ "bd79100", (kernel_ulong_t)&bd79100_config },
+	{ "bd79101", (kernel_ulong_t)&bd79101_config },
+	{ "bd79102", (kernel_ulong_t)&bd79102_config },
+	{ "bd79103", (kernel_ulong_t)&bd79104_config },
 	{ "bd79104", (kernel_ulong_t)&bd79104_config },
 	{ }
 };
--=20
2.50.1


--RBe/8Sbrp2Y9Vhm6
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmidn9kACgkQeFA3/03a
ocUznwgAvCP4xHU3F2/KzfDwqTy7VJckfUH9qjtfncnPla8SWorSvSeEIBCiCQB/
z/L1l11/heB2OlnaheXWfhRQv06+vaq14/fDePG4qvgf4MgiLrkwVEtg6z5EYd+a
rCfQw7dr3cfuyknLS/Um5GKtEq1vvMXF04Xh16JhVVANGQZEeKNNl/ck7z/Edtls
aFoQWyLxYjAB8OrICcvjJDqMiY1B2twKROzoUJH37toOd8EfgJDUQyoCdU5dWeos
UJ+rAc4Jy8URpb5FUi/TMmtHvIVVDunj+hfJOuaP+3hDC9Iw4uKTlU+Q3+9sFJq8
Zr95OOhqnCqzvs1HQJXb6prGjIldCA==
=pioM
-----END PGP SIGNATURE-----

--RBe/8Sbrp2Y9Vhm6--

