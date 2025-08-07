Return-Path: <linux-iio+bounces-22386-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0192DB1D4D4
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 11:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0B346202B3
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 09:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A2A24A078;
	Thu,  7 Aug 2025 09:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWyrpBTr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57ACC245014;
	Thu,  7 Aug 2025 09:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754559256; cv=none; b=SLlSkd636BtEOQXeNC+0HcO+z2L5YlAAHdX0LZsSQY1qpw6gsG43JTZzgslFcvadMzu6Gu/No3gPNStS4GNpb4/hODANpXYMcfUjWW2cy/PUFQcC3MnWZlRJ8FVElbHLaJ1O8Gcu9h7NbczqN5P02SPN43vVVEWMo1HVs/iMgk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754559256; c=relaxed/simple;
	bh=taUD5WxbSOzi90Hjdo4H+BnAwJLo+wYitJ+fAVWhbPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IXM1IJlxkReDDyq8CkOaW8xZrs5UMsd5ajksI/6N3ejGfS1j6/4GGt49D9Oz3oQQTWm9OdH0ceMf7UPJ1upvrK5Xct7NAjWM1NA2mq5dGEUVLEyRDquSAohY+Dvl7sTW5ofhH4cdlrhz19b7bdUmCPseRjxAEpgajp1PTTfPfb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MWyrpBTr; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-55b9a23d633so832121e87.1;
        Thu, 07 Aug 2025 02:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754559252; x=1755164052; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3PHXy6cl3eFgtfYJ0Pk9tHt2y4LdPMHXj7NvHxv7R1k=;
        b=MWyrpBTrCVoj/WHDTRL04oKOvm5SiUC+vdtpX6mg2cdtWOmyZMlSsUTZkFXSZafYf0
         CvzUhajFd5h7pJKdKh/7KpN6cQPPoU/nVEs3pGPe43orte9eOD37PXmIilRIvb6cZtfH
         Bejgg525G4AEr+xGI5FPJkTM0044mtOxmaRAlG60hVwTDp8f8LWga9uswEeAA0f1fHxu
         CAN3P9Nqi8gjt8SX+wePCyHFqoNBmctX4NiaWHzwcX8LUYajGbIVkkViRLKqq+iyg5kE
         6qth+C0IqFc/yKYirIPT3OPD9P4rubq3O3HpHPxd78NsdDGaORYp1JGMCwdbGT8qyozl
         L27Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754559252; x=1755164052;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3PHXy6cl3eFgtfYJ0Pk9tHt2y4LdPMHXj7NvHxv7R1k=;
        b=WTwpDt0ZjPteiStMsVBXrm/I4tKxkosiHZ8H9iOsV8OgXwCqxL6HFGNSxUEVSOvaXN
         s0kfL442H+taVGYTLIMqgR7h6QCI0Mjw4qyShfEj+N0IUSlZQpsB1M2TWSAX2E2nmAqE
         bcRXoExnvHPhHQYG/rYDu80HSE6lya6MwTRLoDoV0AQr8umC6GP7Q8HfQap86pmxamGK
         mwsDAG8Hm64M8hmmKABc3/Hzm3VaS+5AFlvXotMFrh4uPmD2dWlbFvHbqGbjU1kmKNYO
         1tgdqNT/p6tJgzUQrzi47yhNss40EiFgDnIkSKT1QQa7aLwJ8B5I8n3lHvPBpJ5P8VDn
         AQCA==
X-Forwarded-Encrypted: i=1; AJvYcCVphqJP7xO3m9pgr1Baf4SWLrM+xAnPulHMTbxZ2jQo1BdvZohbOCB2t2HHjhPnHMhxEzTv3jA5jjFL@vger.kernel.org, AJvYcCXNy8O2x5k3o1MLLUCQBSHP/sKziGtD8rWCOxW/aoWuJ1FBbwxYtwNSoZtCec9VTOxvmZrhsq1EKK+awjkQ@vger.kernel.org, AJvYcCXy9N2nR5nUmftT7s8LRhmPQ6Gqx8CjBPGumx6uf8HtV09LbKZv4L3RPm/bFpp/4SYW0DvyhEjJSiNn@vger.kernel.org
X-Gm-Message-State: AOJu0YwvnLO3jKbx2/eyqXv2FyW/+EjWD5VN57QbpubUHthBUG04Th4E
	0pfz/VreXG9RnoOrjuZf2PoZRXAEioKHgzznkyKyfxdazr0y2IIcWLVR
X-Gm-Gg: ASbGncuw/kvvma2X4yxUZBSBoi0DYkZZ4CoLi+21MAn9CWVMfln/nu7qDcwG9KtRR1v
	HncstpLybfSFtLLJe0XDHAyH1kN8KdcsQD9rgdA2b5SIHsKhYVSzMfehzECbtkV+DwhuV3aV/P5
	Cc/7W85qFhaBd5HI29rkN7InFtaClkdkxUR086HnQxR2WwhvdrBEAQVeiQvrnc6K/T+rMgHQTpu
	tUdjcQnxk20Diy0FkVcTpB7nQA04ORGgOMZvRo2SyS3eAzGX+yo/1GIP12Pl7ZS3kjP/AcRT++R
	at6Yvw9j/ajYFsT6l3UuQBloCUSOwR/tMWbxxHvVyGbPtBVCKDHWKDEhfGPY9lOZD5UvmgEuND1
	RYOBGREGvNp+wUhnshWhKtqmEBtHCQJMTxsmKKeU=
X-Google-Smtp-Source: AGHT+IH+cVsZNQWFcKlY/YTpFPVpjWGxEEGxcui3zaLcdcDAOoSUAYyAYDNOyCJzQzKZrD7aQxMP/g==
X-Received: by 2002:a05:6512:138d:b0:550:e692:611b with SMTP id 2adb3069b0e04-55cb6209e7amr900816e87.16.1754559252113;
        Thu, 07 Aug 2025 02:34:12 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88c99057sm2562292e87.91.2025.08.07.02.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 02:34:11 -0700 (PDT)
Date: Thu, 7 Aug 2025 12:34:07 +0300
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
Subject: [PATCH v2 02/10] iio: adc: ad7476: Simplify scale handling
Message-ID: <72ee22907f2bb21a820bc6080a7cb6635294d5aa.1754559149.git.mazziesaccount@gmail.com>
References: <cover.1754559149.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5xvKAZ0hjovuugsC"
Content-Disposition: inline
In-Reply-To: <cover.1754559149.git.mazziesaccount@gmail.com>


--5xvKAZ0hjovuugsC
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ad7476 driver supports variants with different amount of supply
regulators. On some variants there is only VCC, which is used as a
reference voltage. Others have separate VREF regulator, and some rely on
internal VREF. Some have both internal VREF and option to connect
external one.

The ad7476 driver reads the regulator voltage only when the user asks to
get the scale. This means the driver needs to do some dancing while
picking the correct reference regulator (or internal reference), and
store it for the later use.

According to the discussion [1] variable voltage references are rare,
making it hard to justify the added complexity for supporting those.

Drop the support for the variable voltage references and simplify things
by using the managed regulator get and enable interfaces.

Link: https://lore.kernel.org/linux-iio/20250331122247.05c6b09d@jic23-huawe=
i/ #1
Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Reviewed-by: Nuno S=E1 <nuno.sa@analog.com>

---
Revision history:
 v1 =3D> v2:
 - use link-tag

 This patch was originally sent as an RFC in 2 patch series:
 https://lore.kernel.org/all/cover.1754041258.git.mazziesaccount@gmail.com/
 Changes from the RFC:
 - Fix the faulty conversion from  uV to mV as pointed out by David.
---
 drivers/iio/adc/ad7476.c | 84 ++++++++++------------------------------
 1 file changed, 21 insertions(+), 63 deletions(-)

diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
index 9869526c1524..f117aafd8fad 100644
--- a/drivers/iio/adc/ad7476.c
+++ b/drivers/iio/adc/ad7476.c
@@ -39,10 +39,10 @@ struct ad7476_chip_info {
 struct ad7476_state {
 	struct spi_device		*spi;
 	const struct ad7476_chip_info	*chip_info;
-	struct regulator		*ref_reg;
 	struct gpio_desc		*convst_gpio;
 	struct spi_transfer		xfer;
 	struct spi_message		msg;
+	int				scale_mv;
 	/*
 	 * DMA (thus cache coherency maintenance) may require the
 	 * transfer buffers to live in their own cache lines.
@@ -111,7 +111,6 @@ static int ad7476_read_raw(struct iio_dev *indio_dev,
 {
 	int ret;
 	struct ad7476_state *st =3D iio_priv(indio_dev);
-	int scale_uv;
=20
 	switch (m) {
 	case IIO_CHAN_INFO_RAW:
@@ -126,14 +125,7 @@ static int ad7476_read_raw(struct iio_dev *indio_dev,
 			GENMASK(st->chip_info->channel[0].scan_type.realbits - 1, 0);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		if (st->ref_reg) {
-			scale_uv =3D regulator_get_voltage(st->ref_reg);
-			if (scale_uv < 0)
-				return scale_uv;
-		} else {
-			scale_uv =3D st->chip_info->int_vref_uv;
-		}
-		*val =3D scale_uv / 1000;
+		*val =3D st->scale_mv;
 		*val2 =3D chan->scan_type.realbits;
 		return IIO_VAL_FRACTIONAL_LOG2;
 	}
@@ -286,18 +278,10 @@ static const struct iio_info ad7476_info =3D {
 	.read_raw =3D &ad7476_read_raw,
 };
=20
-static void ad7476_reg_disable(void *data)
-{
-	struct regulator *reg =3D data;
-
-	regulator_disable(reg);
-}
-
 static int ad7476_probe(struct spi_device *spi)
 {
 	struct ad7476_state *st;
 	struct iio_dev *indio_dev;
-	struct regulator *reg;
 	int ret;
=20
 	indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*st));
@@ -310,58 +294,32 @@ static int ad7476_probe(struct spi_device *spi)
 	if (!st->chip_info)
 		return -ENODEV;
=20
-	reg =3D devm_regulator_get(&spi->dev, "vcc");
-	if (IS_ERR(reg))
-		return PTR_ERR(reg);
-
-	ret =3D regulator_enable(reg);
-	if (ret)
-		return ret;
-
-	ret =3D devm_add_action_or_reset(&spi->dev, ad7476_reg_disable, reg);
-	if (ret)
-		return ret;
-
-	/* Either vcc or vref (below) as appropriate */
-	if (!st->chip_info->int_vref_uv)
-		st->ref_reg =3D reg;
+	/* Use VCC for reference voltage if vref / internal vref aren't used */
+	if (!st->chip_info->int_vref_uv && !st->chip_info->has_vref) {
+		ret =3D devm_regulator_get_enable_read_voltage(&spi->dev, "vcc");
+		if (ret < 0)
+			return ret;
+		st->scale_mv =3D ret / 1000;
+	} else {
+		ret =3D devm_regulator_get_enable(&spi->dev, "vcc");
+		if (ret < 0)
+			return ret;
+	}
=20
 	if (st->chip_info->has_vref) {
-
-		/* If a device has an internal reference vref is optional */
-		if (st->chip_info->int_vref_uv) {
-			reg =3D devm_regulator_get_optional(&spi->dev, "vref");
-			if (IS_ERR(reg) && (PTR_ERR(reg) !=3D -ENODEV))
-				return PTR_ERR(reg);
-		} else {
-			reg =3D devm_regulator_get(&spi->dev, "vref");
-			if (IS_ERR(reg))
-				return PTR_ERR(reg);
-		}
-
-		if (!IS_ERR(reg)) {
-			ret =3D regulator_enable(reg);
-			if (ret)
+		ret =3D devm_regulator_get_enable_read_voltage(&spi->dev, "vref");
+		if (ret < 0) {
+			/* Vref is optional if a device has an internal reference */
+			if (!st->chip_info->int_vref_uv || ret !=3D -ENODEV)
 				return ret;
-
-			ret =3D devm_add_action_or_reset(&spi->dev,
-						       ad7476_reg_disable,
-						       reg);
-			if (ret)
-				return ret;
-			st->ref_reg =3D reg;
 		} else {
-			/*
-			 * Can only get here if device supports both internal
-			 * and external reference, but the regulator connected
-			 * to the external reference is not connected.
-			 * Set the reference regulator pointer to NULL to
-			 * indicate this.
-			 */
-			st->ref_reg =3D NULL;
+			st->scale_mv =3D ret / 1000;
 		}
 	}
=20
+	if (!st->scale_mv)
+		st->scale_mv =3D st->chip_info->int_vref_uv / 1000;
+
 	if (st->chip_info->has_vdrive) {
 		ret =3D devm_regulator_get_enable(&spi->dev, "vdrive");
 		if (ret)
--=20
2.50.1


--5xvKAZ0hjovuugsC
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmiUcw8ACgkQeFA3/03a
ocX9UQgAqICD1NQXdC5ZFoR5lUHdgn2UxZRzQxj/fzg43DF0tfQ+e1TZUa2GtdJV
N4z8TNpbO61dYciR5Z/4Xj1UAokV6ChvOqRxyBuT0w32iyRtxgefErTyp6doW2WS
dzI6HOwj5enGb0NljDS4z2+QWawB/N2N35UpkZO4C6Kd+YGeeLel1ZBZCa7/SlhP
tGB8YqHMMzk8uSrGs/TL+Vg/FKSeX+KAqYSs+HNqh9zubKTCWmORob0tGoe4lvZM
cQTRzhqwXr4QEnprsv3Xl5E5D2SXClowFkzfERmQUbM5fJp3H5lFv7JAhELnCH6M
EsxXQ5nzl8A3N3nUKVd/YfJzSifccA==
=7wrE
-----END PGP SIGNATURE-----

--5xvKAZ0hjovuugsC--

