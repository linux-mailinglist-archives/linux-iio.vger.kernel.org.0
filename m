Return-Path: <linux-iio+bounces-7356-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BAB928747
	for <lists+linux-iio@lfdr.de>; Fri,  5 Jul 2024 12:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2062D1F27238
	for <lists+linux-iio@lfdr.de>; Fri,  5 Jul 2024 10:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6BB14A4EB;
	Fri,  5 Jul 2024 10:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJJgLAml"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A50F148823;
	Fri,  5 Jul 2024 10:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720176958; cv=none; b=o5v72FKXUweSJbQF+Ig7GjOQ6BAU+GX+YTn6zE6DL/TrEyKtt6bSIwXUZuyLKhyw4PmpCDJSP8dfY+UchUbqM6qSfowUovRVVZZt9EKpu1/Ph22aftA33+H8O3BFyME4ZCQOHB9dldss37ute3WNG6PmzZzIsg+yngwdNUV4rb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720176958; c=relaxed/simple;
	bh=bI2hjWVgdl/diApvpjFZCaQlbk4hRekxYDSv0DqE3K8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qWXKHwhiDln/Hl9U1K4oXnbvzXPB4b8Jb7AJJTs3MtEv369hBZJ6OP/+YxX4Ytxu16nU5MzjH/fDxPFK1LPWZWHunO5GJ5d4l1MF5aNQ9IzOg5ePOHAj7PwMk81+cKSRxubOK2ZJtZBhesz+yVOE2WGl+nMcQFjPJoN/3UenWl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJJgLAml; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ec3f875e68so18353861fa.0;
        Fri, 05 Jul 2024 03:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720176955; x=1720781755; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AhGmMPt1lObSup2GfRLJaEn/G3ib3X+5BiBDXfkwc6Y=;
        b=IJJgLAmlnOK+tODSrYY1lDccBN5swiAfRCIId06PpANrIb9fuYGFjsugt40/rqco2p
         glUPlmH/8bw4MfLoiNZLHiG9ZvpKZ0EzH26fGr7sgtRCdajonMJomrrm+VdC8BMoL5Ms
         iLTXNV+s6MWJhmv6rzAcSIxZjUYYUG9pNcfqloWwnW3yk6G+tXqMDsbNFExUNbksLVDI
         LZz2dKfytY/Jq5pnFiJgXetn3TODD6w503FDqP7PcLAeRI9szec1O6oS9PL9QG4UIK7C
         wkkbKZyngd+pVGwBYJqrfXJmfhe1pqfcers4j8opAWqE2n+roFpR99YQuTaflQBwRvfs
         s5SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720176955; x=1720781755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AhGmMPt1lObSup2GfRLJaEn/G3ib3X+5BiBDXfkwc6Y=;
        b=qGnKow8Gb+0M8qnY4NEpvq5MmkoTAY9LHpKrCpE9uqvXqraYLgsVR1nOL9GkMXB78C
         IhYoe8I90zheDMCZ+jWAiu3+59O1yX0rZqor2GtI7+1CdG/wQn9EsMwCFMNCzfTImDdX
         qAyCys1t0BjbI5aRId9ydOThoX2U72XUKE6OY9tMqg/E2Kmdi7w7IHn9gqIddkFqrjid
         aYpeLdUdsij7xH6lUEOl6wRSvm4mss59DcVC/czr2dXI/NAnNVoEMtstOvR9nc5gw5oS
         MHUKv7cQyYnrNHHc7wZI1w9ArBTPOQROK1bOgsBRQUEbaJQmERSFM7S5OT8iJ+AAUdLW
         cydA==
X-Forwarded-Encrypted: i=1; AJvYcCVwCS8yY6qFkjAN5VjRYnvwet80a1in2SOshaEU99fhEFWwrlG1i0LDiM145Db9Zqlc2FJeEvhOuL6CupjVxE8y1GGtS+JqNrDLAqpDKkmgkE7FLz2SMQsGk593O5ByBKybz1BqReJXaWRXKmfl0FYbKJQPgT1gfH/QY+zBKNU5DnxYgg==
X-Gm-Message-State: AOJu0YwrQTB4yay3Q8KyRR1Wdb9OgB7k86RkEXPbsscrv412yrWMXueN
	1DeF3xn/5/y3Nog5sqjtE/Ryl50CfrCT/BLzau/oFK+lx51T7zWc
X-Google-Smtp-Source: AGHT+IHcU4cGkUjrgtXjRt1PrXQ4b4FmjO1xQSJdylbp2isgPfBuBM0XvqRep2ss7UrEZ0oQwd3XtA==
X-Received: by 2002:a05:6512:1096:b0:52e:a60e:3a08 with SMTP id 2adb3069b0e04-52ea60e3bfcmr1323370e87.11.1720176954368;
        Fri, 05 Jul 2024 03:55:54 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ea2f3f8c2sm321184e87.171.2024.07.05.03.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 03:55:53 -0700 (PDT)
Date: Fri, 5 Jul 2024 13:55:49 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/7] iio: bu27034: Add a read only HWARDWAREGAIN
Message-ID: <ec349847cc994f3bd632e99b408a31e7c70581d0.1720176341.git.mazziesaccount@gmail.com>
References: <cover.1720176341.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BjdW22BiUbYCtq3g"
Content-Disposition: inline
In-Reply-To: <cover.1720176341.git.mazziesaccount@gmail.com>


--BjdW22BiUbYCtq3g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ROHM BU27034 light sensor has two data channels for measuring
different frequencies of light. The result from these channels is
combined into Lux value while the raw channel values are reported via
intensity channels.

Both of the intensity channels have adjustable gain setting which
impacts the scale of the raw channels. Eg, doubling the gain will double
the values read from the raw channels, which halves the scale value. The
integration time can also be set for the sensor. This does also have an
impact to the scale of the intensity channels because increasing the
integration time will also increase the values reported via the raw
channels.

Impact of integration time to the scale and the fact that the scale value
does not start from '1', can make it hard for a human reader to compute the
gain values based on the scale.

Add read-only HARDWAREGAIN to help debugging.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
v1 =3D> v2:
 - fix switch case fallthrough warning by adding explicit return
---
 drivers/iio/light/rohm-bu27034.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/light/rohm-bu27034.c b/drivers/iio/light/rohm-bu27=
034.c
index ec4f9bef83f8..76711c3cdf7c 100644
--- a/drivers/iio/light/rohm-bu27034.c
+++ b/drivers/iio/light/rohm-bu27034.c
@@ -148,7 +148,8 @@ static const struct iio_itime_sel_mul bu27034_itimes[] =
=3D {
 	.type =3D IIO_INTENSITY,						\
 	.channel =3D BU27034_CHAN_##_name,				\
 	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |			\
-			      BIT(IIO_CHAN_INFO_SCALE),			\
+			      BIT(IIO_CHAN_INFO_SCALE) |		\
+			      BIT(IIO_CHAN_INFO_HARDWAREGAIN),		\
 	.info_mask_separate_available =3D BIT(IIO_CHAN_INFO_SCALE),	\
 	.info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_INT_TIME),		\
 	.info_mask_shared_by_all_available =3D				\
@@ -989,6 +990,13 @@ static int bu27034_read_raw(struct iio_dev *idev,
=20
 		return IIO_VAL_INT_PLUS_MICRO;
=20
+	case IIO_CHAN_INFO_HARDWAREGAIN:
+		ret =3D bu27034_get_gain(data, chan->channel, val);
+		if (ret)
+			return ret;
+
+		return IIO_VAL_INT;
+
 	case IIO_CHAN_INFO_SCALE:
 		return bu27034_get_scale(data, chan->channel, val, val2);
=20
@@ -1033,12 +1041,17 @@ static int bu27034_write_raw_get_fmt(struct iio_dev=
 *indio_dev,
 				     struct iio_chan_spec const *chan,
 				     long mask)
 {
+	struct bu27034_data *data =3D iio_priv(indio_dev);
=20
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
 		return IIO_VAL_INT_PLUS_NANO;
 	case IIO_CHAN_INFO_INT_TIME:
 		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_HARDWAREGAIN:
+		dev_dbg(data->dev,
+			"HARDWAREGAIN is read-only, use scale to set\n");
+		return -EINVAL;
 	default:
 		return -EINVAL;
 	}
--=20
2.45.1


--=20
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =3D]=20

--BjdW22BiUbYCtq3g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmaH0TUACgkQeFA3/03a
ocWZpwgArJ8QQDvayWBHLF3xLsRdkl31zAoulYAISqhw513FAG0EOH0kdPfoC8Ij
IrVAIlu2hSby/uGv5sJaakuVGkiiuCBlTKfdXGug5CUr5bxJhfpKRBtodpmh18oz
nv3I7eFnrc8IUaOw3O/hYBDdtCDi021qDWwhuuyOfXG1gcM7Lv4+/0nrnuGDLsNn
HU0FZ7zwI6sCjcS8t2sWd9w9C6LS7AEs1GHVnB+dwnJBwz4Xls7i55RBzzJv9Xk8
l+uC+B1zz2p4QsJ46QQZmUlNTZTBLGc1ePzPxbuodS6Ym7BiKPRvkxvCeuC5K99f
ztYXBBJndM0vQcxClEBVIq8KlqlHKQ==
=+U31
-----END PGP SIGNATURE-----

--BjdW22BiUbYCtq3g--

