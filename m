Return-Path: <linux-iio+bounces-17541-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0C8A7884B
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 08:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75B593AAED9
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 06:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F127A23315E;
	Wed,  2 Apr 2025 06:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mM8yFs2r"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9D4233120;
	Wed,  2 Apr 2025 06:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743576414; cv=none; b=s3ibM9mDNVQMHpITAe8gNirZBbFeR+jDrWid/J/I7gdxEb9OojCAb7L4mZgUiXU8YFsbjbIgwr3+9F8/XGGAtOv9MyQW5pRZ9sW5uT8gnZAq2qLsoV7RWDHRdb+J3y9xMIm6OIjMUfmO/OOwg0lvQDQA0Z3++WaTxbUzm15p3jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743576414; c=relaxed/simple;
	bh=nkRavN6buF/gDxrwD8ipXn3zBnd8c92ETh2ZfteLGR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uAJrU92S2KCwKb/waKursCXLPd482FEiaZoEZRRq1Y6U6sCQ58a43aC7+hrnvU4dxTLd4aIABvt2TDzTC4smwGIKPfnspitE5McvRHFTYwXGGKWV8bhHfb+NrDWAcDn5m+6P/n/7lK/aXYQRA+mCAx+5+yWCBe+m7ZgOBeh+fF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mM8yFs2r; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5493b5bc6e8so7368976e87.2;
        Tue, 01 Apr 2025 23:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743576411; x=1744181211; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ayqc2RZYibXbV7INci6LOKqfBRG/lehCl0hQkPSJT3w=;
        b=mM8yFs2rmn4ZVe88nac6UjRD/jRF/94wFRGSYoNlxAnKp8YdI89JqPucd8X2ylCA17
         gw5TeqYgOQhZU42eOUBItFPJZc76HHmkacajuNowU8kT5L6uLSk9XxTMeV+Uycrd4XK3
         2umQaAEEqp3UNgKOEykqEp6xhEwvzNKCXOvJWshIPFNnFgz5rVfDkMpIw6Loqoi9Ktdn
         RFzFfcwlteHlVycGgn8Ei4iTC6iCJggt+zZB7bkTXoHoZ4VVuOZONIZErE2KenOFaOmu
         T8H3Gc187O/j4cwDFmn1tdgtNQmoBKLiFiab8NKp31IRE9J/hm3KCPz6z7RP9tFg8Ck8
         k/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743576411; x=1744181211;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ayqc2RZYibXbV7INci6LOKqfBRG/lehCl0hQkPSJT3w=;
        b=B+90LEJXUPI3NRVgkZtMFjLNMxkwqDs15kHw+rEF1+LJEYibOwuScnKhQjPV8/M2J5
         UzmRI5TQ8id9p6Wqj54VLWwIm3tY6G8IF0xbO28GpHEceK+x4XA6+Wm0hmFuBC0KDHMF
         ixswtW7fEMRBpO+4PTVf2WYSYUM++nqGoErnSKnW+G1PIZV/PeA8sx4Pb/BhoxEylR6T
         BTdGMLLjob6tgHayiAp8+isqNZbvHKGF9JqE4mac0T79MwBd30elBguiZbIfhcRLfO1V
         8f+2sZHnAskwM1VBdQqcvmvQ/Mt2k8hSDU/bIHa/zqGE3f7Bo40wMkC1jEY6amMEMjgu
         luPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZp3E/Rjk/mmD/kBFyZ59Q9FRQLafFDmMjdb5asql9YndISOMJs+75JoaVwtQ6zGYbljY/yjVbI0qVSAIB@vger.kernel.org, AJvYcCUow+I+x9kGVU+PRAxxVUhys/xn+vJSP5yccTqrTu9t4w9hhI9WKlI79eG8AZB+WGu0VijHFPVTXqMG@vger.kernel.org, AJvYcCUvUsvnvTIwKFMrMvUisSxCiRwDXp6uGnhe7PfMOommwvaGaZE7rjDNFu6j4SIjR0ZrAWLjjalalF5M@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1cvQeuICzt1HVywnpTOdYvD9ebfAFsVOSvrO20tlWNdweHWng
	AAtCKK+PQXfUaEyBWCWaDLNGpnz3O/hCcB55LRBLdqjeBhrCruW84BoSzA==
X-Gm-Gg: ASbGncssVBABde2ym0fm2tQ4dVi95JtuNB/EXUpB8AxcPVSErCxDtOc8X351LfigFad
	es78NQTt3o6iLFhGL6PiOx4COzg70ACUW32XeQh9pPnph5PaZYZuI7kNnJwa+7k0wNTatP6kdel
	IuO/D+zwA2cCdycEHyWOJ/S52WSXxZ1tw4XcIutbMF7INNabdqfxJKc0K0RWeQGg8hQu2EJjJWa
	93VIhhVtFhQxqxdz3yXW68Abk3525VQIEDYjmpA+wt5/y0bObSPSdcb/WrUHPNxjZid77uf/+hG
	B7vduE9d/NLXQBYtd/ONmNE9DavYjt1Ug3IV3W2ZN9Yd2emDqaQ=
X-Google-Smtp-Source: AGHT+IFR9Ck0yqG+KnntspR+Gy2gkKn6NFQkQkePv1P78O/icStSCVvG66ZUA06QNn200dki2vpisw==
X-Received: by 2002:a05:6512:3d89:b0:548:526c:fb99 with SMTP id 2adb3069b0e04-54b10dc8aaemr4923042e87.18.1743576410838;
        Tue, 01 Apr 2025 23:46:50 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54b095a20b1sm1552549e87.246.2025.04.01.23.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 23:46:49 -0700 (PDT)
Date: Wed, 2 Apr 2025 09:46:44 +0300
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
Subject: [PATCH 5/5] iio: dac: bd79703: Support ROHM BD79702
Message-ID: <0ba243a63115dd4af03ebf9656c65b8c259a3e34.1743576022.git.mazziesaccount@gmail.com>
References: <cover.1743576022.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dpnicPI7H1IrQ5f0"
Content-Disposition: inline
In-Reply-To: <cover.1743576022.git.mazziesaccount@gmail.com>


--dpnicPI7H1IrQ5f0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ROHM BD79702 is similar to the BD79703, except that it has only 4
channels whereas BD79703 has 6 channels. The channel 'addresses' of the
first two channels (used to identify the channel when data is read over
SPI) are same for both ICs. The next two channels of the BD79702 have
same addresses as the last two channels of the BD79703. This means the
BD79702 channel addresses do not follow the channel numbers with a
constant offset. Thus, we need to specify the addresses separately,
instead of directly deriving them from the channel number with a
constant offset.

It's worth noting that the data-sheet describes the BD79702 as a device
having channels 1,2,5 and 6. The driver however represents channels
0,1,2,3 to the users - with no gaps in the numbering - which may be more
familiar view for the application software.

Support ROHM BD79702 DAC.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 drivers/iio/dac/rohm-bd79703.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/rohm-bd79703.c b/drivers/iio/dac/rohm-bd79703.c
index 63a70fbd7e0e..a35c37d2261d 100644
--- a/drivers/iio/dac/rohm-bd79703.c
+++ b/drivers/iio/dac/rohm-bd79703.c
@@ -84,16 +84,18 @@ static const struct iio_info bd79703_info =3D {
 	.write_raw =3D bd79703_write_raw,
 };
=20
-#define BD79703_CHAN(_chan) {					\
+#define BD79703_CHAN_ADDR(_chan, _addr) {			\
 	.type =3D IIO_VOLTAGE,					\
 	.indexed =3D 1,						\
 	.output =3D 1,						\
 	.channel =3D (_chan),					\
 	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),		\
 	.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE),	\
-	.address =3D (_chan + 1),					\
+	.address =3D (_addr),					\
 }
=20
+#define BD79703_CHAN(_chan) BD79703_CHAN_ADDR((_chan), (_chan) + 1)
+
 static const struct iio_chan_spec bd79700_channels[] =3D {
 	BD79703_CHAN(0),
 	BD79703_CHAN(1),
@@ -105,6 +107,19 @@ static const struct iio_chan_spec bd79701_channels[] =
=3D {
 	BD79703_CHAN(2),
 };
=20
+/*
+ * The BD79702 has 4 channels. They aren't mapped to BD79703 channels 0, 1=
, 2
+ * and 3, but to the channels 0, 1, 4, 5. So the addressing used with SPI
+ * accesses is 1, 2, 5 and 6 for them. Thus, they're not constant offset to
+ * the channel number as with other IC variants.
+ */
+static const struct iio_chan_spec bd79702_channels[] =3D {
+	BD79703_CHAN_ADDR(0, 1),
+	BD79703_CHAN_ADDR(1, 2),
+	BD79703_CHAN_ADDR(2, 5),
+	BD79703_CHAN_ADDR(3, 6),
+};
+
 static const struct iio_chan_spec bd79703_channels[] =3D {
 	BD79703_CHAN(0),
 	BD79703_CHAN(1),
@@ -128,6 +143,13 @@ static const struct bd7970x_chip_data bd79701_chip_dat=
a =3D {
 	.has_vfs =3D false,
 };
=20
+static const struct bd7970x_chip_data bd79702_chip_data =3D {
+	.name =3D "bd79702",
+	.channels =3D bd79702_channels,
+	.num_channels =3D ARRAY_SIZE(bd79702_channels),
+	.has_vfs =3D true,
+};
+
 static const struct bd7970x_chip_data bd79703_chip_data =3D {
 	.name =3D "bd79703",
 	.channels =3D bd79703_channels,
@@ -194,6 +216,7 @@ static int bd79703_probe(struct spi_device *spi)
 static const struct spi_device_id bd79703_id[] =3D {
 	{ "bd79700", (kernel_ulong_t)&bd79700_chip_data },
 	{ "bd79701", (kernel_ulong_t)&bd79701_chip_data },
+	{ "bd79702", (kernel_ulong_t)&bd79702_chip_data },
 	{ "bd79703", (kernel_ulong_t)&bd79703_chip_data },
 	{ }
 };
@@ -202,6 +225,7 @@ MODULE_DEVICE_TABLE(spi, bd79703_id);
 static const struct of_device_id bd79703_of_match[] =3D {
 	{ .compatible =3D "rohm,bd79700", .data =3D &bd79700_chip_data },
 	{ .compatible =3D "rohm,bd79701", .data =3D &bd79701_chip_data },
+	{ .compatible =3D "rohm,bd79702", .data =3D &bd79702_chip_data },
 	{ .compatible =3D "rohm,bd79703", .data =3D &bd79703_chip_data },
 	{ }
 };
--=20
2.49.0


--dpnicPI7H1IrQ5f0
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfs3VQACgkQeFA3/03a
ocWnzggAl1pmpYYPBpPn9Ywnsmf3dzAkbq5CyQK6teKXaGoS2JdPYvcRAx7q3MLt
yJ3EbJ90f3ZaBJMXL8mOBk2RDPbQ81AM7AvRG/pvbx8163mL/K1f4ff815hc/LBM
5JaK5LLNXMNPS8xka/4345FfPWcJEdK3Oo87Tpcsshz6rka3T8DLvWuBcLvPd59k
rlywgJr0MUKltbJC8+3K3WFBbJC+QixuUWqCwHj+uuPvwKvEmdF5+UXe4tT0TdHV
xlP8mOV4FXKRdtyKScn3xG+9GMcR/ANqjmyh+X9/UW6I+2K4YtjYUa0Jpqgt99oY
0RWS8k5A9P04NZtOGyXyhT0tXu58pQ==
=+5c0
-----END PGP SIGNATURE-----

--dpnicPI7H1IrQ5f0--

