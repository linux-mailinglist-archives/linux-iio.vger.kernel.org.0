Return-Path: <linux-iio+bounces-22321-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D594AB1C0E3
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 09:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8023418A49E4
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 07:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC51214A9E;
	Wed,  6 Aug 2025 07:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MjYd25ox"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6847821171D;
	Wed,  6 Aug 2025 07:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754463782; cv=none; b=uiQq+yRpUMKZriS/VKYRSfUFKTeeftrFSlo1aqXfeGeF3iuT1Rx5y4/SNNIYLP06z6m1J0i+uW4mSJH/7UBt5DECIwc3GgD1UiOp/Qkr7J1w5ChYHE+dv9AEFH6SWH0sTsusc81fUqEHwcYxEN77ZZlb0DKQGbA+o1z+ynYHpUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754463782; c=relaxed/simple;
	bh=WBKu/DlOEppLaISRB634PujrxXTR18hs2D8KcNSW12k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OgmV2SOFRPKE087bpiaCxoJe8opHk0TEthCfqzWfT8HvmV1zXAvalaSii0Le14gbC+GxgEPh3LQ0RYAYBAS0ZiuG9CB2Isq21qXBl6g31uXJyBh0cpV4WCJ68j1ejEP2iIoIWCi/m+CQOLMyTTMVGWr2HFAoWBhB1ELHXgrj0mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MjYd25ox; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-55ba26abd62so3530158e87.1;
        Wed, 06 Aug 2025 00:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754463778; x=1755068578; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u/meEK/Y7njINUp8qBraoSO5/yoWkElz8XQyCzb8c/M=;
        b=MjYd25oxCiP2q7Afi9ymhgyb9BQWNVlEy4nvs/ymmK7UyfEmkKKU4MzdrDbEdL6UgF
         a2QFMo5weUCjEuUEe7Gj/2MtDuHe/QCrBOzG9xE2+qSptwW9dL1lEXSgaIHWx7ZZ3E/s
         +9Y74jeEEW1DQs9up0IIDflgIyHiUgwWbZ0VSowYeTzx+LWfypFeK7keF3IOzoruT4NN
         nWu+SKYY/Sno5rZglQlPLPNdZUS8inXnnWB35tBZDojusaaWtIwiotCGE7WHV4MU1uWO
         qLS0J/SrsQ7p1QQkrxj+n8XlWkw3VS4dN13qsEWNOVb83Pp97WJ4HcvyaSOia9gshMFO
         kyFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754463778; x=1755068578;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/meEK/Y7njINUp8qBraoSO5/yoWkElz8XQyCzb8c/M=;
        b=bDf3hj6YGMmELJpGo/2XyY47OJynLFnk39fBLfuHfjjweRrvsS3n/eSJ32qxi/7Ri8
         QL/2SIZN9221+9rpFKw3AeRx3ggATT+0kV80nyNLWkKMnqBUqVtRSFG1axRKnLXMkw8O
         fOMvHTc9nwjx256TJP82kW0JeAWksU680+YsoMNeo1rixorKfH/tDXv1xXvAmI92qJtl
         4+uSdPqkArRvJkePivdwYMLbOIOcHnRl1juk1R9es9gpWUdMDiL5YXTYyxnOURFNL4Vx
         OxGIlEL/qo8O8M/PdepSIadwXb/rbmD2feUunHiEwkj2oqGa8sC93uCc1Napq22lkSdY
         voCw==
X-Forwarded-Encrypted: i=1; AJvYcCV8u1Gm36K+96ACQO+zpWFHFbYd9gy98Io9+tedaTeaOHSjm5SLZYl1gMHWYpzdENIJngL1g4kx4ZwWlBcs@vger.kernel.org, AJvYcCWDaqkqAJWHQZQ00e+ICPgybFnfn0SSq/iV4AUtyA/ovbWIVtbwC+M3eB0mqiYrCqdH+ScC9ymss7aC@vger.kernel.org, AJvYcCXhqpAs/nSXYtyhcuAURfJ+O9Szf1J/rIowB5Cjm80egdFV4SFe/uwntxtmrZEjCuN5k7YKgKnwKaGH@vger.kernel.org
X-Gm-Message-State: AOJu0YwUkMmATFX/F05+f07WmIwQV5th4DNpmtc7bE3pAcFHH2P4VFrf
	QkIOzVFr5aWJdaQDEumQIuuSCmC3qtGTJwhvZQFsKs9/VKs18GIQVgO7
X-Gm-Gg: ASbGncvCtWTFe3FzgxT9NQ81qynbQDtqNT6UGvRjEUsrqsCZDRCl7JUS06tZCC9LYWc
	Xoef2Cyscjd882BAlR4rs2iJVKqHZJTaE59DEt4tqYfPJvlTbcbu8vX4Vi94OfyohAw1b3EJOka
	x+sRMk/uSBGn0XYQXPq0tDJ8vmhS2AfF86lF023RUp3bI0KnfXD4YMegdfTgl6ENI227dY5bkxs
	HPKMdTV9LoeXoN2U4/BfZvofmBD4aVwpjAuAvPqHLaHCQ9BWEf1tziFEKP8Bhn+lmWwgZRu9EF/
	nOCdRdx8wpHsA4X0W1me1+rug8h1fAC0cMl8sG2E5V09RYR2drOs7caKu+xTsegCy1F74iVMiSv
	ba4bL2n8bm+QRYbCfAMit5DgY4J5h
X-Google-Smtp-Source: AGHT+IGMQEkJ7QuYlOZ56KCsuEVNB6/jCTF/qo2pO1XqCHJdr4QhjQHFWCH+HkpqN9M6C2TTdjez3g==
X-Received: by 2002:a05:6512:238d:b0:55b:8200:884d with SMTP id 2adb3069b0e04-55caf2dc101mr572602e87.17.1754463778079;
        Wed, 06 Aug 2025 00:02:58 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b8899ebf9sm2196573e87.43.2025.08.06.00.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 00:02:57 -0700 (PDT)
Date: Wed, 6 Aug 2025 10:02:53 +0300
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
Subject: [PATCH 1/8] iio: adc: ad7476: Simplify chip type detection
Message-ID: <4e9aaa826d152e80ff317413f961818ef0afe8da.1754463393.git.mazziesaccount@gmail.com>
References: <cover.1754463393.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="r2W1TOD/KtAd1uwi"
Content-Disposition: inline
In-Reply-To: <cover.1754463393.git.mazziesaccount@gmail.com>


--r2W1TOD/KtAd1uwi
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
 This patch was originally sent as an RFC in 2 patch series:
 https://lore.kernel.org/all/cover.1754041258.git.mazziesaccount@gmail.com/
 Changes from the RFC:
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


--r2W1TOD/KtAd1uwi
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmiS/h0ACgkQeFA3/03a
ocUsiQf/WA8pb6vZUV+HwMvGDJ+E9ZL95/N1HfKzmAbcqH7qjt8BvYc3ORLyJxte
DnOXb6ik6n/3Ihsw5PQ12DWbVZq8VKT+5QQm4qP1BXj9YQr8CJy+CqIq7Vg1bTmy
zgQflHGXIgBxMExhFeAPZMS3hPxedNeSo7DWbAuZ4J0ay18FLhp5j2xEJv5XoE4q
NEDVycw3wQRChXUgvktcjFoQh2/nALXqkEc/yeMU+HcmmOdUj3JVS5LBt3a0maNl
NZypLwTbRzzw2ge7WY7ByBHs2hNGnZTkpwHnLdTDzG9OiCr7c2Z7KdavSezMIcLm
B1qIbynJ+MHZJk2Mr3/d6seazX4KrQ==
=Q9xB
-----END PGP SIGNATURE-----

--r2W1TOD/KtAd1uwi--

