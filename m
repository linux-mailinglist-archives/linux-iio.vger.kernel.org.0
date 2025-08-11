Return-Path: <linux-iio+bounces-22543-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 086AEB2023B
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 10:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B80CC421640
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 08:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39C62DCBFB;
	Mon, 11 Aug 2025 08:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZG2edA51"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C3E2DC34E;
	Mon, 11 Aug 2025 08:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754902235; cv=none; b=Jd/+MW7uBDYx9Gg7VgckVtwRJGvVSqqXAeGi0wr4c8YdijS6UxRg2vKIRzfy6HdE5QQQu0OH5SFq00n0gIOWCGZ32Q3no9PXvOzqtn3f4NIsOnz2e4/dUVXcq1Suy1mjFuHJ8ZjvemhP2x7yx/KPF59j3mJQmeSl3HUIihcQ6Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754902235; c=relaxed/simple;
	bh=CRLyX10djBX2LlIPSqzIFLgLnG7RLMP19KrZut1w85M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PRuMRLGfcheKej47mHRj4zyloAAQUQ/ECXR5WAQW558dhWReKUqGh8LHSEpnrIklssZa4ShDDEETMTC9HAiDNj1yS2pOkcmSqQQMk5GDocapu4V+LmSY5kN24juAxpL1qeegoLD95nFlzQdE/v+LWxW7tPo5My5Ba14xWXjodfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZG2edA51; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-55b797ad392so4878912e87.3;
        Mon, 11 Aug 2025 01:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754902232; x=1755507032; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oMHBTAnA6PCioxHo6nOWNLMea6tzTl9XJTuSynWWTns=;
        b=ZG2edA517GQQj/Y4AwuPKvC8HjtNPZzLoYc6A47TnD3IHq9u1nr+1mgzyl8jy7kJ3X
         3e4svLVjX/tbuegx57depailuAgI+9CN8ef5iEXppKfrBAZzEbZfTocAIqbxP2eAgu0K
         TtvYohd5oM2Ri6gs23wLnVzCIG/FTbjbk4suXrHTmDK1hydM5gAxS2JjohmNfU15x41A
         pfs65Q6siOTrYa+wloPY9ai4C30hiLyHD5OQM0g035wLgkXv/el/2MJOZH5yle+CDd0q
         RLXWaYK0rWtPQfaf/AMkB79MyCDi7V4OVRthxKE10udF9HdSP3jCKr2CgY4SLJEdiaV8
         mk9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754902232; x=1755507032;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oMHBTAnA6PCioxHo6nOWNLMea6tzTl9XJTuSynWWTns=;
        b=dvihDDIl7m04uGh12GFORQP80LM7m7FMRGLGu2XDc6c7j49qyC651ZTfDLgHJ6XH2v
         OcDlEOOHO1fUlK+gsCXZOclgzfCB3eGDZPiy76CyJghNwknK97lHBwvusklNVovk2r9o
         oaLIRD9OG8YcfQ52HcS8p0xVl1DsOv5Fsxmki1EmzD5zxEARf+3QrHqdwB2qA5oi6vlt
         YX8SP4mqYUC7bXkBcs3WsXzy3wdzABKUhq78z1VoIpEI7dwMHiZ4LEGSO0CGsrrES3DQ
         B04QwewTrfB+4Dav7XPK/oPcqmCqXOYGpBoFsJRHQXZAYcS5acHzZnLbB+S0JXqNkkrz
         Yshw==
X-Forwarded-Encrypted: i=1; AJvYcCUflp1UEariNVPSlOhjdJ61Qb9wRCQ4ho5AbxDRVsS5h5kDeOMW4ReOAzbY7JLk4wZujsbwA8LVVjUw@vger.kernel.org, AJvYcCVX/L2f7WE8rHibS2laSQMBgTbbDAdLlGmtETkXcuYwYyN7wG0lSMiOxYxDWAjfrDh3xtyJOBedJk6tFuAN@vger.kernel.org, AJvYcCXMFIG8svGcqHhbpLpbRjGAyZuZ5meq4kq4tWDruITObkBFioIIAvqf0wzNa60y8GRZ+i259qN1uVSX@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+UI/p6/MyA2KPH4od9f+KjDOrYTFaVc98k67M0akcN0ikEU33
	kU+DRDoSPXBMW+JxNgFtBrN9r9hv5qQcpXcYPp9KSvCXg2UsHcJCuvXt
X-Gm-Gg: ASbGncu8dZU7maDlxiZkW7nk/vvZCIJqrVgPIS+dhl6OuFm5pAcbDd3x3JPaAOpYDGU
	oxTLOc3EoRmxFR3el5Ibi2NtntP9h2Ca8An0QKRMXolJu63Oh2y9+ggFkO/7xVlUIvNSiMsusjG
	HR5OsKcxVTr+RVF9Nbj6bX/uWm4QOzH3FuFNtQVktRc4/VDgm92a1CUhio2Q9p/+UJmNyl2kl2w
	gDeML+wnSmyjQzJfqtdK0xKA+xhbIenU0nYw5Mj3SbowD5CxJLFYsZSiqlO6EUSxM17X6Rec77d
	RUANJwzZNkcB0sovuDIIgozlhKQzTXGquaZeYGXSDqfGOiWYQrwMrk5UpMeMWPDa76FNssggNff
	5vsRBTDuU+MFr5i4Ym6jTeQ11AU/L
X-Google-Smtp-Source: AGHT+IF/WIobNB3A1BgQL4+a8H0lvDQbP5OR4/4Lf/s9ScLduTA2Uqw4P362YUmz5f6oKgwZ3JWLqQ==
X-Received: by 2002:a05:6512:124f:b0:55b:87cc:eea9 with SMTP id 2adb3069b0e04-55cc00987afmr3883157e87.4.1754902231398;
        Mon, 11 Aug 2025 01:50:31 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b8898c158sm4214963e87.14.2025.08.11.01.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 01:50:30 -0700 (PDT)
Date: Mon, 11 Aug 2025 11:50:27 +0300
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
Subject: [PATCH v4 01/11] iio: adc: ad7476: Simplify chip type detection
Message-ID: <9e179bb3ba52303448ae4a559c1f011acd3f2fa6.1754901948.git.mazziesaccount@gmail.com>
References: <cover.1754901948.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="y7WQOdzmi8PUw1JG"
Content-Disposition: inline
In-Reply-To: <cover.1754901948.git.mazziesaccount@gmail.com>


--y7WQOdzmi8PUw1JG
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
Reviewed-by: Andy Shevchenko <andy@kernel.org>

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


--y7WQOdzmi8PUw1JG
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmiZrtIACgkQeFA3/03a
ocUAXAgAyEIZ5+AJhmSWskio5AhkEsGBneEs5wYc9XOd181MVVi8rLK4YMz5vl/0
N12cuXUbmI1zSPYKyXrzBJmZcaH5OkGRkw9rP48zjAQ3ZK4CVafHR1J4HbrMCr33
97gjNBtQ8gmCLzUA3fIRRLuy9e+XvRV7XBKOfg/GKgq2rUHCnRe4yfnHER78UWZ7
HZxaN+JqaygZaMRTmQxK6uMpf95YyAd50NzfWM9jjhymoBsM7pYZzaX6ME33CgMU
HX/HqQwyQeUJENLYPVbQ4JjIolfn1eziAzXOMNzd4gKf97HHDYC5EeEGWBGoiOeS
1CTr6eiWbJGmSCg4wb7R6tN7VgWFWA==
=ZQ1Y
-----END PGP SIGNATURE-----

--y7WQOdzmi8PUw1JG--

