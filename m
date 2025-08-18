Return-Path: <linux-iio+bounces-22905-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D33D5B29BC9
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 10:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EBFD3B8821
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 08:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D934D2FC880;
	Mon, 18 Aug 2025 08:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ga/HiIgT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9BC2FC883;
	Mon, 18 Aug 2025 08:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755504780; cv=none; b=Tmajj3WJNlEBdiAWw/pWERxfIdBp6+YCzy8+WAYzCA9H72tFHwRboMcQC0gqYEh60AgzBrIC9R551S4PHQDm9fICCSxhf1hNUQZ09i/ra+djpQlP4ZV8JG4rC0cJyNJbPlE40d3aFENPBdPth0BYTYKqqeyfp4WrWip3+5Kqgnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755504780; c=relaxed/simple;
	bh=+3fux5TYQMl0CnfslHMRzzKpPDbHdLeNW4ibcyerxjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QOG82HUoy/3StQQSzaj7M9IFJeIKwJkv2eyExaT0DtC17oKzZDri3gGq5/DAK2zKc8LCfSxd388ibGizDPz2bGV5DWv2HYIcE+3nHQHOK9inaPfMJQ0O2RN4Mhw8hCUQzh6xEHtTOhFlRtaAolgdXxweKVSCWnGxGZ10u5zMJ68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ga/HiIgT; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-33418dde187so9486711fa.3;
        Mon, 18 Aug 2025 01:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755504777; x=1756109577; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oytV71oYo3Ji3+fsVU3mYtfEMJVu7iWh8Nkyt2wLFOM=;
        b=ga/HiIgTOYzEX+j70nmB6CvrokvDhKRDDmV2+O5aB+JFhmm0OsSb5bYJkSeVq+YcOs
         YZazaRUHf+pxMN8Q3qwt64Imgpi9iqTK6+/drqmDVXOJsA+i97Po5qS6E8NKvK0/2QCO
         rpvKIO23UcH/56P6NWSqpf4OCAVOJzy3eERQHyjmHAyXZ5AZoWipkf2kn9+r4aCZIykl
         PkvAm68YbXSfxmSswFBzumACCOuf2tO209pBFJ8mBtBAbM2bLXaM07Vv9wBpVD0i7u1L
         dwxKbWA0q/IBJJKtMfgkcZoJTZrHYPJ05rJYX3OOkPIRVetfxW70V1z3A3uGOqGvlNb/
         gKoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755504777; x=1756109577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oytV71oYo3Ji3+fsVU3mYtfEMJVu7iWh8Nkyt2wLFOM=;
        b=FU/osMSDQjNWfzS9zJt5J5M2B/Nk+u6iAvoZtfcOUWBt48WwJhUBSC0b2EggvongPp
         Kjq+YiOQbFEau25plCwflyCwyosssQaj5S0DV0QJptZPzYaK1xWI4t1UeEGEMD0Ac40I
         FBYzeuhKRJm57q1AFF5nMMg2v9Goo2uVg4aaLBWVX5thBKz7B8pvYPchv34g6e60u5Oj
         qrmgVjU0gB7W9LK/kJTg3AiXt10EOk/rWoLZ+eVOsjNsKdUsRMGiyjLN1RdjnHTJe9z2
         MBkGsU6fiLoh6cuKd6Yk93ehVa0LuRlph3nGBeTWuTucA/MyihYmRpfb4frPK0DKXTu8
         sIIA==
X-Forwarded-Encrypted: i=1; AJvYcCUd7nD7SanGhP4sk74pHPgw9eHNzIYFSs0Lpc6aeC4WCgPwk30+eAkfkEs8YVEPwmFKZwRwWQyd3vQc@vger.kernel.org, AJvYcCV8o4m6Bc2W1n5Ln8NYAN4hPaWakZ2XhJotug/Xw1GdTEZ1uifK7o6fKeIyxmceD078JfE2XGgORTLm@vger.kernel.org, AJvYcCWyJ+FW8a44MxjWKMBIDTcyuHkGHj7zoj2DyOm9nj3pf+GVFbR6jpYUU4FOiWQ3+vzEPpgljos/sFxi254Q@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp96qRn78+OjxmNz3W5fNbRy2eAIEmdPJZAWsiHyoSJjguMgJ2
	rcJ1/uyBrIK/NPeV8MFyKCiGFXDFZANvOV6ZPYDLM4q0Rqwi1YinKbK2
X-Gm-Gg: ASbGnctNX2D6Etj9lZmApSMYvkmGqA6hnqMxiXTkTRadkjfI8+/BwK90tVFWVVosRnt
	V8CCApWGBVTP+Mj3oPoszVwO5/YT+TMlo789Y6uYlnTgkZ12v4q45Es01Uw9i4mNigslJUZ8f5W
	rp5vRwV57oVKOtHwzve5YQTF6qpA++MS5P8DX7hJi/gkNSgWjjTvoUNwTxlJOpGNdoVIWaKFMBu
	NOigD8thvApDhsTSF9Bp03vnX29eNrqai231sy6/z5cCUJ/T9wth5P93TBcxQKcNOX7doycjlHY
	qsXvySijK2mEL5Y/hV4Zhje7nfX4wBRZMewfo3gkwdx5I4GmQ90YcPqo7m9th+ttA4KKHdXhT8l
	Wc+zFbGOj/Sn6Rnsur3Wl+pSLdTobXVhkJrouuB4=
X-Google-Smtp-Source: AGHT+IE/k4pDMCkWaKA/2pcYu00B4xTZ6Y1FA+RB+3ptMRKE/YqtkKu6pcQq8KEeFMNSe4Vm3cgJEw==
X-Received: by 2002:a05:651c:41c5:20b0:332:1de5:c516 with SMTP id 38308e7fff4ca-33409869ed5mr18304371fa.8.1755504776768;
        Mon, 18 Aug 2025 01:12:56 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3340a645fcbsm17184091fa.69.2025.08.18.01.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 01:12:55 -0700 (PDT)
Date: Mon, 18 Aug 2025 11:12:52 +0300
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
Subject: [PATCH v2 3/4] iio: adc: adc128s052: Rename channel structs
Message-ID: <e737f2b416e25d8e4e734e2765b0e21a3f0ae0bb.1755504346.git.mazziesaccount@gmail.com>
References: <cover.1755504346.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2kzuUwWZROA1J8BY"
Content-Disposition: inline
In-Reply-To: <cover.1755504346.git.mazziesaccount@gmail.com>


--2kzuUwWZROA1J8BY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The adc128s052 can be used to drive a few other ADCs but the TI's ADCs
it was originally intended for. The TI's IC variants model numbers don't
(trivially) explain the channel configuration (for a reader working with
other than TI's ICs).

Rename the channel configuration structures to explicitly explain they
are used for simple ADCs, having 2, 4 or 8 channels.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
 v1 =3D> v2:
 - Rename channel configuration structs as discussed during review round
   1.
---
 drivers/iio/adc/ti-adc128s052.c | 34 ++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s05=
2.c
index 81153253529e..9b8ecaca01ed 100644
--- a/drivers/iio/adc/ti-adc128s052.c
+++ b/drivers/iio/adc/ti-adc128s052.c
@@ -99,52 +99,52 @@ static int adc128_read_raw(struct iio_dev *indio_dev,
 		.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE) \
 	}
=20
-static const struct iio_chan_spec adc128s052_channels[] =3D {
+static const struct iio_chan_spec simple_2chan_adc_channels[] =3D {
 	ADC128_VOLTAGE_CHANNEL(0),
 	ADC128_VOLTAGE_CHANNEL(1),
-	ADC128_VOLTAGE_CHANNEL(2),
-	ADC128_VOLTAGE_CHANNEL(3),
-	ADC128_VOLTAGE_CHANNEL(4),
-	ADC128_VOLTAGE_CHANNEL(5),
-	ADC128_VOLTAGE_CHANNEL(6),
-	ADC128_VOLTAGE_CHANNEL(7),
 };
=20
-static const struct iio_chan_spec adc122s021_channels[] =3D {
+static const struct iio_chan_spec simple_4chan_adc_channels[] =3D {
 	ADC128_VOLTAGE_CHANNEL(0),
 	ADC128_VOLTAGE_CHANNEL(1),
+	ADC128_VOLTAGE_CHANNEL(2),
+	ADC128_VOLTAGE_CHANNEL(3),
 };
=20
-static const struct iio_chan_spec adc124s021_channels[] =3D {
+static const struct iio_chan_spec simple_8chan_adc_channels[] =3D {
 	ADC128_VOLTAGE_CHANNEL(0),
 	ADC128_VOLTAGE_CHANNEL(1),
 	ADC128_VOLTAGE_CHANNEL(2),
 	ADC128_VOLTAGE_CHANNEL(3),
+	ADC128_VOLTAGE_CHANNEL(4),
+	ADC128_VOLTAGE_CHANNEL(5),
+	ADC128_VOLTAGE_CHANNEL(6),
+	ADC128_VOLTAGE_CHANNEL(7),
 };
=20
 static const char * const bd79104_regulators[] =3D { "iovdd" };
=20
 static const struct adc128_configuration adc122s_config =3D {
-	.channels =3D adc122s021_channels,
-	.num_channels =3D ARRAY_SIZE(adc122s021_channels),
+	.channels =3D simple_2chan_adc_channels,
+	.num_channels =3D ARRAY_SIZE(simple_2chan_adc_channels),
 	.refname =3D "vref",
 };
=20
 static const struct adc128_configuration adc124s_config =3D {
-	.channels =3D adc124s021_channels,
-	.num_channels =3D ARRAY_SIZE(adc124s021_channels),
+	.channels =3D simple_4chan_adc_channels,
+	.num_channels =3D ARRAY_SIZE(simple_4chan_adc_channels),
 	.refname =3D "vref",
 };
=20
 static const struct adc128_configuration adc128s_config =3D {
-	.channels =3D adc128s052_channels,
-	.num_channels =3D ARRAY_SIZE(adc128s052_channels),
+	.channels =3D simple_8chan_adc_channels,
+	.num_channels =3D ARRAY_SIZE(simple_8chan_adc_channels),
 	.refname =3D "vref",
 };
=20
 static const struct adc128_configuration bd79104_config =3D {
-	.channels =3D adc128s052_channels,
-	.num_channels =3D ARRAY_SIZE(adc128s052_channels),
+	.channels =3D simple_8chan_adc_channels,
+	.num_channels =3D ARRAY_SIZE(simple_8chan_adc_channels),
 	.refname =3D "vdd",
 	.other_regulators =3D &bd79104_regulators,
 	.num_other_regulators =3D 1,
--=20
2.50.1


--2kzuUwWZROA1J8BY
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmii4IQACgkQeFA3/03a
ocW8TQf/bE/y8Ej3kipfPZsIVwsakqFZqPDEV+nrSGF6AhhWdj2Uynh7e31L1H55
16udmRK+4xPsB06OaxM3APmHc6rEgC4F9FZqYgZQn3yFxu/PTUjpmY18z11sIR1C
V5OGul+z78w1ZSTYiRd7Lm/nt1kDEV3333JiyfjddK8MTRAWRhireEDEbj7Vf9Qu
2LaGqmhWe5mZUOO+VnI6wihWAOs2jJqYb7t35+xDYkSbOuC3PqZGJ41hpb0di+MY
aw7mrQs8R77rEZXc3TAW6md7PMN7gvtT456zHQf1rQJEead5dpykg4/R1i/gs67l
f3dIvAa6IzEK9OKkL7GqVXvA1HQkgQ==
=0O3D
-----END PGP SIGNATURE-----

--2kzuUwWZROA1J8BY--

