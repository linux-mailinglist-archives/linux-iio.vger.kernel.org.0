Return-Path: <linux-iio+bounces-22430-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78998B1E4CD
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 10:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0358C7B2F2A
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 08:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE45269D18;
	Fri,  8 Aug 2025 08:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQR5OC6M"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091D826B74A;
	Fri,  8 Aug 2025 08:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754643085; cv=none; b=TGXVyb/LdkvSK4hs5BpFNYbZumV6aMc5op51jOMZe1P8vTVUalUbDje6S75GsyJWLEHTIbD307NuI08GKtWSw3HE30/+rosN4EeUZYiKUtxtBoo9Lb72FicH40a4SBPKjdx+MMtfzPYqBXMOUcK2PcG2plQl1ZCHmQCNICUNwU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754643085; c=relaxed/simple;
	bh=6br5nTgA5maFWMZ6HbJMM8iKHL3+b9FbrzZMETx9ycY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JBG/jNYkg1AMMNzCAzwIjCpzRCyrS2BOduHqJSOczVlFfw9z0vTRNQlvoaBFm7U2me+UxLSNp75q6VdSE7ffCHSsZvHwBpAQjzAEmZWLjFcIw4ep6pDHcorwdT5q+Y7unpq3Q1z+FNRmRCSQEqiqs9LuXsLCOlX9vn0KuCD8Is8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KQR5OC6M; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-55b847a061dso3271590e87.1;
        Fri, 08 Aug 2025 01:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754643073; x=1755247873; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FbRzQcoI5p8Cuon7i7slUApzPry4R+j3QLxr6UFlktk=;
        b=KQR5OC6Md9gAyB0XVtRs2Pe/H6qxAOdjicnndzgIc6wNMvf4NC6Ec+msAPVHIwB+GP
         UWgOFKPVEGI1Z/vMqVwjZMsNFua92kOHmbNJCx5DBhTn1ev1IOzRZFyhTdpYLCLLnpbX
         P5rZOArTrOxa6nbcuREwAo80TSmtzrmtuBvZYPtjKKlTIR1PH9008NaR/Lx7eoT6Okq0
         GNtaiGgSZO0G10r9QLbBspF1XDW6wrbO+esBe8KdFlmu10ATmYmeoXRPsLyzj9WZvfKV
         U4/aDg6cR2s6y8nc3H5/dV0cqcBKXRHJhuMj2hUYzM6AiHcjGVKOJ+dNrKmb/1o2l54m
         7wOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754643073; x=1755247873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FbRzQcoI5p8Cuon7i7slUApzPry4R+j3QLxr6UFlktk=;
        b=pXOVj+eSHioQM3FREfnQtkFO7852E1/Km0xpsx6ZK183aO+BOKPyu/VXzP2B+vxa8U
         UO1tXc22eK05a2jMYKrk/JeXxi6yZmWBTVDvNzvOpVk283Kumb/JzT9n3x4gv+xjt0nX
         MZjz+j44uXO1tcW2ATGNIuOP0MU2OlQFa26l9w8GMrtRNaKnertGPTYGgqQcwY8WHycz
         L/Hof/mIPIx5L1UuzNXxokfd0fu6rU8WAoTRoZAjBdvCInqg2xfUzrPHK8fK+c2s3WWN
         lSV7O/2lYYKy8wyq8D1dAKlalDLxc1e+RhYFmS8o14tnPaXMiHGwoqjZhiRgO/01nQ5Z
         rKYg==
X-Forwarded-Encrypted: i=1; AJvYcCUZY+MsiD6X/1Wlm5ZkOXLbLofAKzesZ+s8C3I0kFKaHwhFKUgDGpCDdJEMmLYKMkm7BdbgWCn2JF3Z@vger.kernel.org, AJvYcCVNIypwG5sFqIHhvXUcEU8etDaB2XDzv/37dxOB6rATHiCzkw+WB0BfKvrboaWiRywDJ5XMaTWWZdSJC8qc@vger.kernel.org, AJvYcCXK20RCitkNxujkRBK/QQrlDGjxqma2Z/vHC71USneIK+EEsFD1ohaGG06jh3hda11gpkPkWRzwHh8t@vger.kernel.org
X-Gm-Message-State: AOJu0YzYkBK0VGsFi9QsTTCtYF/pGJrwYef4Bw1lNJMoYNf19yubf/zL
	U00iGMLvAdRmaW2S33jjkxi3LWv+t3nY/zVvCX2jZNntu/g9FKbPD7/S
X-Gm-Gg: ASbGncvKWRRCw9qSp5aaMlfIVb5yf5qbXL+GzBobumI85+7ukkuCVDhh4Yzv4TFV2y6
	rDNRirQLihTnFhVB8+MCOFZ3izhXMKRpD3ci/3Ovwf1vScjN5L0DrrS/7jwxQIaMGTdz8auYGil
	jWiJVWPK94x+xrN2wv12VqVtXOEWqJJbyOdvWffIGvLJGI1xKCquLWHb1641GgUR/K+RimwCoQ9
	Gs4pG/s/Fg9eHosIdhN1Z8ekaw93LZFKTIhUwBx5dpq6krhTn+CXT/mxtXQwKRjvAmEe5Zhyc/d
	idVy5MK51x1RIFX1+FwIAVFjXBWAjelLL5hsGSs/EWwnePSZc9kjV5kfg59YwLtpa5Y56CmX9QH
	uontSrA5TGTwpzd2mt4p56J5qNXHt
X-Google-Smtp-Source: AGHT+IFWULd8THCsKz7LJ3aVH1OOK0FIBZt7VE5cErmpwWhz3fJIpx/Rb8CFrN3cmnE0YT9EAMkH3w==
X-Received: by 2002:a05:6512:239c:b0:556:fb24:6f85 with SMTP id 2adb3069b0e04-55cb61e220cmr2130734e87.22.1754643073163;
        Fri, 08 Aug 2025 01:51:13 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88ca678dsm2900335e87.122.2025.08.08.01.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 01:51:12 -0700 (PDT)
Date: Fri, 8 Aug 2025 11:51:07 +0300
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
Subject: [PATCH v3 01/10] iio: adc: ad7476: Simplify chip type detection
Message-ID: <65f5002c66e5cb25567bc5220fa4d5c717b6892e.1754641960.git.mazziesaccount@gmail.com>
References: <cover.1754641960.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bfui9F+F+8cMYDJr"
Content-Disposition: inline
In-Reply-To: <cover.1754641960.git.mazziesaccount@gmail.com>


--bfui9F+F+8cMYDJr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ad7476 driver uses a table of structures for defining the IC variant
specific data. Table is indexed using enum values, which are picked by
SPI ID.

Having the table and an enum adds extra complexity and may encourage
adding IC specific quircks in the code, instead of centralizing the IC
differences in one place, the chip-info.

Simplify this by dropping the table and using individual structures for
the IC specific data, and storing the IC specific structure's address
directly in the SPI ID data. Finally, switch to the
spi_get_device_match_data() and add a check for the return value.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Reviewed-by: Nuno S=E1 <nuno.sa@analog.com>

---
Revision history:
 v1 =3D>
 - No changes

 This patch was originally sent as an RFC in 2 patch series:
 https://lore.kernel.org/all/cover.1754041258.git.mazziesaccount@gmail.com/
 Changes from the RFC =3D> v1:
 - Use spi_get_device_match_data()
 - Slightly reword commit message
---
 drivers/iio/adc/ad7476.c | 296 +++++++++++++++++++--------------------
 1 file changed, 146 insertions(+), 150 deletions(-)

diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
index aea734aa06bd..9869526c1524 100644
--- a/drivers/iio/adc/ad7476.c
+++ b/drivers/iio/adc/ad7476.c
@@ -52,29 +52,6 @@ struct ad7476_state {
 	unsigned char data[ALIGN(2, sizeof(s64)) + sizeof(s64)] __aligned(IIO_DMA=
_MINALIGN);
 };
=20
-enum ad7476_supported_device_ids {
-	ID_AD7091,
-	ID_AD7091R,
-	ID_AD7273,
-	ID_AD7274,
-	ID_AD7276,
-	ID_AD7277,
-	ID_AD7278,
-	ID_AD7466,
-	ID_AD7467,
-	ID_AD7468,
-	ID_AD7475,
-	ID_AD7495,
-	ID_AD7940,
-	ID_ADC081S,
-	ID_ADC101S,
-	ID_ADC121S,
-	ID_ADS7866,
-	ID_ADS7867,
-	ID_ADS7868,
-	ID_LTC2314_14,
-};
-
 static void ad7091_convst(struct ad7476_state *st)
 {
 	if (!st->convst_gpio)
@@ -190,102 +167,119 @@ static int ad7476_read_raw(struct iio_dev *indio_de=
v,
 #define ADS786X_CHAN(bits) _AD7476_CHAN((bits), 12 - (bits), \
 		BIT(IIO_CHAN_INFO_RAW))
=20
-static const struct ad7476_chip_info ad7476_chip_info_tbl[] =3D {
-	[ID_AD7091] =3D {
-		.channel[0] =3D AD7091R_CHAN(12),
-		.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
-		.convst_channel[0] =3D AD7091R_CONVST_CHAN(12),
-		.convst_channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
-		.reset =3D ad7091_reset,
-	},
-	[ID_AD7091R] =3D {
-		.channel[0] =3D AD7091R_CHAN(12),
-		.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
-		.convst_channel[0] =3D AD7091R_CONVST_CHAN(12),
-		.convst_channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
-		.int_vref_uv =3D 2500000,
-		.has_vref =3D true,
-		.reset =3D ad7091_reset,
-	},
-	[ID_AD7273] =3D {
-		.channel[0] =3D AD7940_CHAN(10),
-		.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
-		.has_vref =3D true,
-	},
-	[ID_AD7274] =3D {
-		.channel[0] =3D AD7940_CHAN(12),
-		.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
-		.has_vref =3D true,
-	},
-	[ID_AD7276] =3D {
-		.channel[0] =3D AD7940_CHAN(12),
-		.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
-	},
-	[ID_AD7277] =3D {
-		.channel[0] =3D AD7940_CHAN(10),
-		.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
-	},
-	[ID_AD7278] =3D {
-		.channel[0] =3D AD7940_CHAN(8),
-		.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
-	},
-	[ID_AD7466] =3D {
-		.channel[0] =3D AD7476_CHAN(12),
-		.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
-	},
-	[ID_AD7467] =3D {
-		.channel[0] =3D AD7476_CHAN(10),
-		.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
-	},
-	[ID_AD7468] =3D {
-		.channel[0] =3D AD7476_CHAN(8),
-		.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
-	},
-	[ID_AD7475] =3D {
-		.channel[0] =3D AD7476_CHAN(12),
-		.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
-		.has_vref =3D true,
-		.has_vdrive =3D true,
-	},
-	[ID_AD7495] =3D {
-		.channel[0] =3D AD7476_CHAN(12),
-		.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
-		.int_vref_uv =3D 2500000,
-		.has_vdrive =3D true,
-	},
-	[ID_AD7940] =3D {
-		.channel[0] =3D AD7940_CHAN(14),
-		.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
-	},
-	[ID_ADC081S] =3D {
-		.channel[0] =3D ADC081S_CHAN(8),
-		.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
-	},
-	[ID_ADC101S] =3D {
-		.channel[0] =3D ADC081S_CHAN(10),
-		.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
-	},
-	[ID_ADC121S] =3D {
-		.channel[0] =3D ADC081S_CHAN(12),
-		.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
-	},
-	[ID_ADS7866] =3D {
-		.channel[0] =3D ADS786X_CHAN(12),
-		.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
-	},
-	[ID_ADS7867] =3D {
-		.channel[0] =3D ADS786X_CHAN(10),
-		.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
-	},
-	[ID_ADS7868] =3D {
-		.channel[0] =3D ADS786X_CHAN(8),
-		.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
-	},
-	[ID_LTC2314_14] =3D {
-		.channel[0] =3D AD7940_CHAN(14),
-		.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
-		.has_vref =3D true,
-	},
+static const struct ad7476_chip_info ad7091_chip_info =3D {
+	.channel[0] =3D AD7091R_CHAN(12),
+	.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
+	.convst_channel[0] =3D AD7091R_CONVST_CHAN(12),
+	.convst_channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
+	.reset =3D ad7091_reset,
+};
+
+static const struct ad7476_chip_info ad7091r_chip_info =3D {
+	.channel[0] =3D AD7091R_CHAN(12),
+	.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
+	.convst_channel[0] =3D AD7091R_CONVST_CHAN(12),
+	.convst_channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
+	.int_vref_uv =3D 2500000,
+	.has_vref =3D true,
+	.reset =3D ad7091_reset,
+};
+
+static const struct ad7476_chip_info ad7273_chip_info =3D {
+	.channel[0] =3D AD7940_CHAN(10),
+	.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
+	.has_vref =3D true,
+};
+
+static const struct ad7476_chip_info ad7274_chip_info =3D {
+	.channel[0] =3D AD7940_CHAN(12),
+	.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
+	.has_vref =3D true,
+};
+
+static const struct ad7476_chip_info ad7276_chip_info =3D {
+	.channel[0] =3D AD7940_CHAN(12),
+	.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
+};
+
+static const struct ad7476_chip_info ad7277_chip_info =3D {
+	.channel[0] =3D AD7940_CHAN(10),
+	.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
+};
+
+static const struct ad7476_chip_info ad7278_chip_info =3D {
+	.channel[0] =3D AD7940_CHAN(8),
+	.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
+};
+
+static const struct ad7476_chip_info ad7466_chip_info =3D {
+	.channel[0] =3D AD7476_CHAN(12),
+	.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
+};
+
+static const struct ad7476_chip_info ad7467_chip_info =3D {
+	.channel[0] =3D AD7476_CHAN(10),
+	.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
+};
+
+static const struct ad7476_chip_info ad7468_chip_info =3D {
+	.channel[0] =3D AD7476_CHAN(8),
+	.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
+};
+
+static const struct ad7476_chip_info ad7475_chip_info =3D {
+	.channel[0] =3D AD7476_CHAN(12),
+	.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
+	.has_vref =3D true,
+	.has_vdrive =3D true,
+};
+
+static const struct ad7476_chip_info ad7495_chip_info =3D {
+	.channel[0] =3D AD7476_CHAN(12),
+	.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
+	.int_vref_uv =3D 2500000,
+	.has_vdrive =3D true,
+};
+
+static const struct ad7476_chip_info ad7940_chip_info =3D {
+	.channel[0] =3D AD7940_CHAN(14),
+	.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
+};
+
+static const struct ad7476_chip_info adc081s_chip_info =3D {
+	.channel[0] =3D ADC081S_CHAN(8),
+	.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
+};
+
+static const struct ad7476_chip_info adc101s_chip_info =3D {
+	.channel[0] =3D ADC081S_CHAN(10),
+	.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
+};
+
+static const struct ad7476_chip_info adc121s_chip_info =3D {
+	.channel[0] =3D ADC081S_CHAN(12),
+	.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
+};
+
+static const struct ad7476_chip_info ads7866_chip_info =3D {
+	.channel[0] =3D ADS786X_CHAN(12),
+	.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
+};
+
+static const struct ad7476_chip_info ads7867_chip_info =3D {
+	.channel[0] =3D ADS786X_CHAN(10),
+	.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
+};
+
+static const struct ad7476_chip_info ads7868_chip_info =3D {
+	.channel[0] =3D ADS786X_CHAN(8),
+	.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
+};
+
+static const struct ad7476_chip_info ltc2314_14_chip_info =3D {
+	.channel[0] =3D AD7940_CHAN(14),
+	.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
+	.has_vref =3D true,
 };
=20
 static const struct iio_info ad7476_info =3D {
@@ -311,8 +305,10 @@ static int ad7476_probe(struct spi_device *spi)
 		return -ENOMEM;
=20
 	st =3D iio_priv(indio_dev);
-	st->chip_info =3D
-		&ad7476_chip_info_tbl[spi_get_device_id(spi)->driver_data];
+
+	st->chip_info =3D spi_get_device_match_data(spi);
+	if (!st->chip_info)
+		return -ENODEV;
=20
 	reg =3D devm_regulator_get(&spi->dev, "vcc");
 	if (IS_ERR(reg))
@@ -408,41 +404,41 @@ static int ad7476_probe(struct spi_device *spi)
 }
=20
 static const struct spi_device_id ad7476_id[] =3D {
-	{ "ad7091", ID_AD7091 },
-	{ "ad7091r", ID_AD7091R },
-	{ "ad7273", ID_AD7273 },
-	{ "ad7274", ID_AD7274 },
-	{ "ad7276", ID_AD7276},
-	{ "ad7277", ID_AD7277 },
-	{ "ad7278", ID_AD7278 },
-	{ "ad7466", ID_AD7466 },
-	{ "ad7467", ID_AD7467 },
-	{ "ad7468", ID_AD7468 },
-	{ "ad7475", ID_AD7475 },
-	{ "ad7476", ID_AD7466 },
-	{ "ad7476a", ID_AD7466 },
-	{ "ad7477", ID_AD7467 },
-	{ "ad7477a", ID_AD7467 },
-	{ "ad7478", ID_AD7468 },
-	{ "ad7478a", ID_AD7468 },
-	{ "ad7495", ID_AD7495 },
-	{ "ad7910", ID_AD7467 },
-	{ "ad7920", ID_AD7466 },
-	{ "ad7940", ID_AD7940 },
-	{ "adc081s", ID_ADC081S },
-	{ "adc101s", ID_ADC101S },
-	{ "adc121s", ID_ADC121S },
-	{ "ads7866", ID_ADS7866 },
-	{ "ads7867", ID_ADS7867 },
-	{ "ads7868", ID_ADS7868 },
+	{ "ad7091", (kernel_ulong_t)&ad7091_chip_info },
+	{ "ad7091r", (kernel_ulong_t)&ad7091r_chip_info },
+	{ "ad7273", (kernel_ulong_t)&ad7273_chip_info },
+	{ "ad7274", (kernel_ulong_t)&ad7274_chip_info },
+	{ "ad7276", (kernel_ulong_t)&ad7276_chip_info },
+	{ "ad7277", (kernel_ulong_t)&ad7277_chip_info },
+	{ "ad7278", (kernel_ulong_t)&ad7278_chip_info },
+	{ "ad7466", (kernel_ulong_t)&ad7466_chip_info },
+	{ "ad7467", (kernel_ulong_t)&ad7467_chip_info },
+	{ "ad7468", (kernel_ulong_t)&ad7468_chip_info },
+	{ "ad7475", (kernel_ulong_t)&ad7475_chip_info },
+	{ "ad7476", (kernel_ulong_t)&ad7466_chip_info },
+	{ "ad7476a", (kernel_ulong_t)&ad7466_chip_info },
+	{ "ad7477", (kernel_ulong_t)&ad7467_chip_info },
+	{ "ad7477a", (kernel_ulong_t)&ad7467_chip_info },
+	{ "ad7478", (kernel_ulong_t)&ad7468_chip_info },
+	{ "ad7478a", (kernel_ulong_t)&ad7468_chip_info },
+	{ "ad7495", (kernel_ulong_t)&ad7495_chip_info },
+	{ "ad7910", (kernel_ulong_t)&ad7467_chip_info },
+	{ "ad7920", (kernel_ulong_t)&ad7466_chip_info },
+	{ "ad7940", (kernel_ulong_t)&ad7940_chip_info },
+	{ "adc081s", (kernel_ulong_t)&adc081s_chip_info },
+	{ "adc101s", (kernel_ulong_t)&adc101s_chip_info },
+	{ "adc121s", (kernel_ulong_t)&adc121s_chip_info },
+	{ "ads7866", (kernel_ulong_t)&ads7866_chip_info },
+	{ "ads7867", (kernel_ulong_t)&ads7867_chip_info },
+	{ "ads7868", (kernel_ulong_t)&ads7868_chip_info },
 	/*
 	 * The ROHM BU79100G is identical to the TI's ADS7866 from the software
 	 * point of view. The binding document mandates the ADS7866 to be
 	 * marked as a fallback for the BU79100G, but we still need the SPI ID
 	 * here to make the module loading work.
 	 */
-	{ "bu79100g", ID_ADS7866 },
-	{ "ltc2314-14", ID_LTC2314_14 },
+	{ "bu79100g", (kernel_ulong_t)&ads7866_chip_info },
+	{ "ltc2314-14", (kernel_ulong_t)&ltc2314_14_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad7476_id);
--=20
2.50.1


--bfui9F+F+8cMYDJr
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmiVunsACgkQeFA3/03a
ocWAHQf/UPYCz4EIKH6Z/bBSSUaLOpzX3I57yIuDDfT1W7SqyzOWci34ksdlbB2k
/Silv6Du17kY1eWzijIlGZoQRRbNe72ZdZsh04CdGdIExoExYl2di72J5Ictk7r5
LiHWpOuWWkjkV9dBGX2Vp3KKvzbzpB7Kbj3f54ceaXkgnn6I7MfIY/fyMGml723A
0G994cHQMKBD4HvC75x3UHfKX2GtCgQGezZaOqQCkIVXbO9KE4t7O8XHlNuqUR0E
cKZuQ/BaRIw5KQXJItEer0T1v3BqHW8uFBOCcKlwLW5uUm4RhUR3WX32pGxAovl8
K/kDqRhCmk3UQWR78FPdFhSHCTJPBQ==
=zDPB
-----END PGP SIGNATURE-----

--bfui9F+F+8cMYDJr--

