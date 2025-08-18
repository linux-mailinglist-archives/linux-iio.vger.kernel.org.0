Return-Path: <linux-iio+bounces-22906-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AD0B29BCB
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 10:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 265683BCA40
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 08:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9492FB97F;
	Mon, 18 Aug 2025 08:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhdFxWw9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9361029B8E8;
	Mon, 18 Aug 2025 08:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755504793; cv=none; b=NmizGjXSKGZ3743kqUHfZ5VIvfmbBabdrDx6j3kiFe1zVB6rnwKWh4uhFHxKABTj6y8e/lGQj9CKGIKtl2FHHfo/cMTQSh0+Dc7XEYMRSNG7JM1Ytkjwk90hSbQ2gjP3tlG52tRhy7hRAkuX4BtEUPP0RZc9Mp4QQBMmhHy/adU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755504793; c=relaxed/simple;
	bh=cDspve00JkSSRewIpWUs+J183I8NCCc4Mrdww7zgQ8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hTt9lu9EfLTMXSkUTqREitiWkblkMlEz7qssGpp53yY73jq6K6UxgQFH9BEQx+Ox4XssYQswbwlc5vROmTyx8iKRa8nERQPTxDk881cwP1chJQQQqfr5wr3CHmnNG/sD7L2UNWHVvoPqjgrIdHF+GH0oyTRtQvS8Wyy+PAtOru4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bhdFxWw9; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-55ce52658a7so3667858e87.2;
        Mon, 18 Aug 2025 01:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755504790; x=1756109590; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IYRgAQUvxLKNi4PbWgiLV7X80YSaNGAIcr48EAtGXXw=;
        b=bhdFxWw9DmDRElRR8R6thEIWiqdrtAoob3Xl8kbUfkNy64EhZfYzVc+aMr0wb2OGpL
         +oURvotGuIcojub1hl4XEighB71Kn4UuIegHeoAxo48bAWBYPqCLlnArfZC3AmYZJnx8
         rqQEE8eTiPFbsKYZDVuCUD5oOuxWvLDdaoT+t+b62/yyVMZG4Hpbj/8j0zU5MHXER+1v
         dIRsE6KOrv2yRBvc0qLkQPsQbbxIaCTHaCqggigKLGaCy3gugObhjSiuSjvCdNzkQrYA
         SRxIy1YruF+SNmzCj6Z6kYg8gNwYaOsp5Sws807l/y0/t0uMsHZHePJtGBqRwZzEwnu2
         81Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755504790; x=1756109590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IYRgAQUvxLKNi4PbWgiLV7X80YSaNGAIcr48EAtGXXw=;
        b=W/KTGLbDMnQ9Eci4e5PCTK5Gzp4OyeJc3Df+BapxI78A/GtccTRVEIoRi857qyP+NC
         fodCEe2SaMDtfYuCafW1akrxX6yiWEu2kpReeMzMO2dlibbNRrugoF635dQSwBJ0Ui6G
         RAyPgqQiWYkUoUvcFg1QUpKK9u4rf9+TULbmEH50CSWIlRbYRpgj42JYChWe6WT/bDOj
         PLA0VLHLFW1l8nVXAjdMihvAJ0dzttLwcS3RAE5jhaMCjik5dPkrlZstABfuEHsYgNrf
         tIs+poNPrrTTS4pO+p4OSgFYkxytakzefu1HR+gVr/zFSmhavhYbRp+iS1jsiXztAUtI
         xJxA==
X-Forwarded-Encrypted: i=1; AJvYcCUFxIkMbhEs/5VKii7h9ap8xrHtqVWc55skJ4m4zMveb7FISr3DUDxdid4XonlBYxTkPt/sNmgVcrNEFBDO@vger.kernel.org, AJvYcCUPmwzDVPC4SZ5qnIvI5N5YylsoK2nqXdvRBbPEz/B+pOGFKM0LAGActwTsmwblX9BMnwdx5/b8xI3C@vger.kernel.org, AJvYcCWY6vIv0m14zk1NkfGqZiDtHZ3OslXk9MzwwiijsaJHaawmoUcwWCCeIcPwaGWjTH3wil7gqS1BqyM1@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk474x0sTghpPJb2lMFceChGcM9+3Be0Aw2pBor0Bm2PggNC8q
	QB4ndedwrT620WONUJpmk4+bdj7+GPkCjKRu1mArIdGpSHMWhh9I9liw
X-Gm-Gg: ASbGncvv1iVKdJHwJpD3NVwHxxcHJLZLvAQv53Q0wTu83iLC8eXO0RIt6xsxLbwwqZu
	PqhUY84kVACPLvxaN/DQL8exZHzhLYOW8aNsGnC1W6O6RSLJqIJE45rQXzeXZ9DCXAijAmJUxT9
	/9wUUL1/eaBVz7vLhgS64x2oItrVj6ZFthg49FPbHXEEZTSRouv/By29xollpNx2zGJ7VC+mKCL
	lvH+Nh+JMXEMifywcimsetMstVuOVZVt29uZ/LunDu9JL1lZk/73Ulxw+dS0kKOQ0WyuT7M5AXa
	FMJomCBteJZFpltL8MpdVhvd2ShWBlZz++T4iqSPNI/5Ev0oL6iXxQqnwu/NL68/TObV50LEeEo
	kps9y1QpjbBLLkqu0WKRpSQX2LmfidW2l5SpWb4A=
X-Google-Smtp-Source: AGHT+IFGPfr9SQPFZB+G55QonwIJAX1krxFzDIx+0BD6Qf1mcJ187Ej4f4KvKZztE5CpSVYaHCtlPQ==
X-Received: by 2002:a05:6512:340a:b0:55c:e594:ff94 with SMTP id 2adb3069b0e04-55ceebb9343mr2488267e87.49.1755504789477;
        Mon, 18 Aug 2025 01:13:09 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef369d83sm1586556e87.67.2025.08.18.01.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 01:13:08 -0700 (PDT)
Date: Mon, 18 Aug 2025 11:13:05 +0300
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
Subject: [PATCH v2 4/4] iio: adc: adc128s052: Support ROHM BD7910[0,1,2,3]
Message-ID: <bb7a775fd1a6135889a72ae63c45e2a4347a2aa5.1755504346.git.mazziesaccount@gmail.com>
References: <cover.1755504346.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="stQVvdqvZQ7uOc1t"
Content-Disposition: inline
In-Reply-To: <cover.1755504346.git.mazziesaccount@gmail.com>


--stQVvdqvZQ7uOc1t
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
Revision history:
 v1 =3D> v2
 - Rename channel structs as discussed in review round 1.

Tested only using the BD79104. The ROHM hardware colleagues swore this
testing should be sufficient...
---
 drivers/iio/adc/ti-adc128s052.c | 36 +++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s05=
2.c
index 9b8ecaca01ed..4ae65793ad9b 100644
--- a/drivers/iio/adc/ti-adc128s052.c
+++ b/drivers/iio/adc/ti-adc128s052.c
@@ -99,6 +99,10 @@ static int adc128_read_raw(struct iio_dev *indio_dev,
 		.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE) \
 	}
=20
+static const struct iio_chan_spec simple_1chan_adc_channels[] =3D {
+	ADC128_VOLTAGE_CHANNEL(0),
+};
+
 static const struct iio_chan_spec simple_2chan_adc_channels[] =3D {
 	ADC128_VOLTAGE_CHANNEL(0),
 	ADC128_VOLTAGE_CHANNEL(1),
@@ -142,6 +146,30 @@ static const struct adc128_configuration adc128s_confi=
g =3D {
 	.refname =3D "vref",
 };
=20
+static const struct adc128_configuration bd79100_config =3D {
+	.channels =3D simple_1chan_adc_channels,
+	.num_channels =3D ARRAY_SIZE(simple_1chan_adc_channels),
+	.refname =3D "vdd",
+	.other_regulators =3D &bd79104_regulators,
+	.num_other_regulators =3D 1,
+};
+
+static const struct adc128_configuration bd79101_config =3D {
+	.channels =3D simple_2chan_adc_channels,
+	.num_channels =3D ARRAY_SIZE(simple_2chan_adc_channels),
+	.refname =3D "vdd",
+	.other_regulators =3D &bd79104_regulators,
+	.num_other_regulators =3D 1,
+};
+
+static const struct adc128_configuration bd79102_config =3D {
+	.channels =3D simple_4chan_adc_channels,
+	.num_channels =3D ARRAY_SIZE(simple_4chan_adc_channels),
+	.refname =3D "vdd",
+	.other_regulators =3D &bd79104_regulators,
+	.num_other_regulators =3D 1,
+};
+
 static const struct adc128_configuration bd79104_config =3D {
 	.channels =3D simple_8chan_adc_channels,
 	.num_channels =3D ARRAY_SIZE(simple_8chan_adc_channels),
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


--stQVvdqvZQ7uOc1t
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmii4JEACgkQeFA3/03a
ocXYcwf/W2Qd3O6/fc/iY1FVO+L23BNP9uJJcySfQqdCsT8UKfu8My3UfkUq6WaV
QmPgfhRmQYcf5A8JTgX4m8E6ll7pRJ/MfbYgXN4ZdgDyPa1Zbz/hf8NbM7rw0f5D
t8KkZ2DY/EVQv5DC5Y/225Y5iCbHEntY/qot8eWGb7C85lPgZLUUgPhEQ8dVubSI
4tQLYfOBeSiGKxA5wJrsStHaGWjbP+zSB8U91NIn/B4D0GPnElcghKdJdjnzfRn2
DymDCyhwFZIqVOb8LrgNSVu0Vgm/mYgIn0w+eCYEp3cQTICVvgARLaKX0mjAE+S3
Efl7JtN3xgB9dtzEM4HKyL6Vi9wt/Q==
=Ngj8
-----END PGP SIGNATURE-----

--stQVvdqvZQ7uOc1t--

