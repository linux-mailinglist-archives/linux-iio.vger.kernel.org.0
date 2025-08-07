Return-Path: <linux-iio+bounces-22385-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD916B1D4CB
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 11:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C839717CC7E
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 09:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988FA23BCF8;
	Thu,  7 Aug 2025 09:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBmxRKNT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466C9224896;
	Thu,  7 Aug 2025 09:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754559245; cv=none; b=AGUPma5tvxrBrg2MA6I3SvZ/nvfexf4fKnUnXtz5qPizaYu8HcVxelZ/6x/o7p5kDa3bVu5J2UoNdOee7/B8tkjlyJ7xyytj0lDR3feP4K4NPH4CjOJzF7qK73vE/ezK1iUmhmgDWpOYiP7n4hHmgEIDpu/8PHhdwBH4war5rbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754559245; c=relaxed/simple;
	bh=rWnknOtL43q/mS0uhWPUP9DlEnZ/SBpnwbM84S2iMjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZJYS4A8/8bncyVTbYfbnp51Ctsbz8zeAJ70+NPoxuURskFaUZ1XgflVTy4OFv2upJIGIPoKdKTkZfQuLTHUrySySJ6AcCJc1gMd5odlOZYX40V0qcj5ZZilko/bFZEKAQcTf7BIArMxhIiPRqBI14tk5AEUYfwghlbjAD6oyKm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RBmxRKNT; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-55b9375d703so789212e87.3;
        Thu, 07 Aug 2025 02:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754559241; x=1755164041; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ycotkfQEbTeWDd7oVq40Q4Yr0gPz9YFQgZznBnGWiFo=;
        b=RBmxRKNTMtGS+X2jRPI7xjTMmvbv7E+4I0E8qAqUblZeL/+tNXGeXajnZ/DSQonDWn
         VMAbTeFEI+JFRj/yU2qdn2x2uBM2XY+USKe3AoSY3C51ddz+yYPAroaYYeR4PsB4l3IT
         lLFGGFoE3cLJlGp86bIaW79OAj+aD36BZUrKetnYCnwLr8eZlRAF9AkGR/ovCVCuoKxB
         x8QSThdhdJ54pzCR6XwWgeY68vzBedHd8ort/vh1mfNkSu0c8pwQLCLd1ipkjfV/ImtB
         o+P0aLeatMCfSNCpxWSSXVdZpyhiM9lMEl7XUmrVLAYvfK9jXA5OQllPETV4y7X/2f3/
         dw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754559241; x=1755164041;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ycotkfQEbTeWDd7oVq40Q4Yr0gPz9YFQgZznBnGWiFo=;
        b=S2K5VspG34QZVeLSF75AD73P0EJDOY1NGYXhSv0fprgOGLRYKqbHTbUVM3PAE/zDWE
         dAopXMVgdzR9pOh5ivnHeVCMfra04MhA722QCeDn7t9SA0tZe6Gtz54NamuWQOWyxN1s
         3C7yyd1E+8GapdbOp0c/QYOeqMsJoBaD8cT+SMTKTbhFQpDkqhXq1l7s42ims5kosSZb
         65Tw+OCpb5WBetrRfq8vVTWI+hp1qE2vl5CkWPWRudychB0/JkgkwBkkJeq4/p+Tqdxm
         mgjsBVOD3WoviA0os2wpOCcCglsYSNFw7oMtSMLSG0X75SFM8VDmCKsykjuwZYyB149y
         SQSg==
X-Forwarded-Encrypted: i=1; AJvYcCUUah+Otg6owW20iXrZITN42igXf5r2IMF0+sVwKwTz5+Tp4ESvTHe2TEumVc/mLJHjyL1U7t8oF6cs@vger.kernel.org, AJvYcCUfuvNIGGunnCHtYF+/LvQ8mH9LKgDMK5zZluQ3b6V+mLEG7mGVNFRhWzLvv0iaBrg+xtCK1x0l6eHB@vger.kernel.org, AJvYcCWgT7v6mCw9lQDwZHf0+rILwLT7Rg5aKlr2RkDISL+58Dh1zFh4UgqzL0Uy9pE5ZnepHBMC2YXKEUKD2pc9@vger.kernel.org
X-Gm-Message-State: AOJu0YwuZENeb9piaxt6fNVjJcXgqVKAGONZGptn5m8VsLj+t4OPTW/g
	dBK8s1dKYFXimg5UnJNYKTlKyyQi3p3Gi0nhW9nQpvZHu1lrZYHVu7/b
X-Gm-Gg: ASbGncsiXcQjioTj9l3O87jzbVoLe5N933NAB/oiEULU94/y76Y8Ppax4I37qpiVoHo
	3YYi47j2ddH3Fjkg1511CTfYCfAdIMuaRzmWZ5KdsaSD23etWmBOMZHNlv87sBUVmkcOODTvJBv
	PJSxuaXFuUM5gAH4S09TQ473t3n6Dx0hayPvIyPDu8VME7xCZpZsowew0FoQZWgfbL/d0NIewlm
	pxb/hEE6ZoKdROMjXxmo16uL7ijtprEzOdabu6YPVIAQYf/gcVacIYrrSbyAeOl21GsSywvFdXP
	UUYCBN2ZLSvlpOCgapC8Djy2H3xfyGIQK1aoaV/HDrt7gAIOUgxlkPr5ceUJrge8qQ1Z4ahTyCX
	K5Xo1GiETHBUxbWcGc72zMprd4w8i
X-Google-Smtp-Source: AGHT+IFoPL617d5O3vLjXUcoI0UlVgqOrWU8+3iDZrjgNHUAVrqNgRZ5nlQbmXnBFTeEyxLSsl+WCQ==
X-Received: by 2002:a05:6512:b24:b0:55c:adae:37b2 with SMTP id 2adb3069b0e04-55caf3eac20mr1671083e87.49.1754559240901;
        Thu, 07 Aug 2025 02:34:00 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b8898c158sm2575423e87.14.2025.08.07.02.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 02:34:00 -0700 (PDT)
Date: Thu, 7 Aug 2025 12:33:56 +0300
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
Subject: [PATCH v2 01/10] iio: adc: ad7476: Simplify chip type detection
Message-ID: <87c72ad221c027f3cc678839c1605eaedf0e6a0d.1754559149.git.mazziesaccount@gmail.com>
References: <cover.1754559149.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Iqt5B/khuJyPDe6R"
Content-Disposition: inline
In-Reply-To: <cover.1754559149.git.mazziesaccount@gmail.com>


--Iqt5B/khuJyPDe6R
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


--Iqt5B/khuJyPDe6R
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmiUcwQACgkQeFA3/03a
ocUdDwf/QoWkHnZDTIZLfj1/BpaE4yeir1fGLD4WIQzBJw2GrJWGvpDufxzWpXkL
vuSMxELgACbdF4G2kezhL2iDZbb0GxGQOnPjiuUZ3VKvzgIlYK9FtZ8WUCQkJC4e
suVth/vadDfI64HDPTL4/FQ3Y37l4Z+j7OZexQhU6IbcusmMO2AmCsZfWNNBt/fF
wjwOIp1w+znK9ItImSIRwQS+/yu3FTXqMlDdg+9srumeCyT4FUZku4pVA2CQZZLA
SmaK0icm3Lz2dxEEBLREQ7455xL4RwQ/k8e7aEPb8+K3wex3ZNtpvWOGr9Tw/H9B
J6rNuHmr1ayEdWp+pnrBXnTQHLhoGg==
=Mlvf
-----END PGP SIGNATURE-----

--Iqt5B/khuJyPDe6R--

