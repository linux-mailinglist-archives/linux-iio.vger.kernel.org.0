Return-Path: <linux-iio+bounces-6145-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF93901EB4
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 12:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99898281DE9
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 10:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D705E762EB;
	Mon, 10 Jun 2024 10:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxIQTRo8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11442757EB;
	Mon, 10 Jun 2024 10:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718013708; cv=none; b=N8GVKrA1ZkWCyEcDPDUheZlrfmPLNuKZ47lhvGgrmqmaoG2h4S3at+AjmhK7GacuppS+NxkM/3jO8z+TfXfxeb76cc6v1uw4G20p0gLl6hF9hQ9yc8FDu62FqhYzjbVpJBIrTKZo2ljT2aU0y6RSKYiYWvgIWYY0z1+OH4xUuVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718013708; c=relaxed/simple;
	bh=BxipS2sVOlOSgud929WxO3vqVZv5jJwh4OmuTyrw3tM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e4cXXYwshoFM3btAkiqPAqSy1muvrKFCLrX/y+A8BmNYhN7hTZ6YhpAbIKBEWU/qlKsbLBZ04m9rc0lR/3A6sCSbxaiqyk8qQbVdttftve2rx2i/qkxxiCMxNfAHGxODup9/xpd1UevhoVxfmJWK4chXCq0vnjZ34QnW36Gionw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YxIQTRo8; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52bc3130ae6so2588562e87.3;
        Mon, 10 Jun 2024 03:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718013705; x=1718618505; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mOrHLjqgcxbz8NYG7mUAQjN2jwxJmjYHP8Kf/zATkkg=;
        b=YxIQTRo8/EP47Xsrg+n8W/jbeR/DW9KvAIaEcBnyDNezQRNxaWyyn+mvs9bSCvMLeu
         PwQBETeFtR5SnW+eLbdwJ+qYKMf89zomKpbE8WS+gRuV0B1gwnnuSsgRDtrxKwELQ9cl
         2yZV/yMx3YghS/TtFV3YPG/aQDNz+j6hTYXxjgw+iSkEfBZ1N8fehtH1Zg2hGb5HWJcx
         sg7xXP+U5dGejIPIl4KnO7Vs7u8fBpj1QYc+8pJVjZoB9spqGtFOMcrPGIcB4iE+MsHQ
         R5Wf/urhFhWjql2djRIuubzC2Qx7/+rIcITqVRmLbQAzynrzsCviy+5iZAKIeB9xVGFI
         2jFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718013705; x=1718618505;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mOrHLjqgcxbz8NYG7mUAQjN2jwxJmjYHP8Kf/zATkkg=;
        b=TjimaRjcvzzH2OHIu55wrU3Vp/CE1RHawg3bCcVeyXpcco2XZeAubZfwyXhuNAiZoQ
         QVIkoGEO3Liqc3z6Zqf3XADHhkscNAFBaFBRXu5VP3Vz8YWywVgnf4WJgXJbKfSz0vbd
         yjXtil54I3kPBvUAsQDlzPVBro1pfkn1bsGpMtG0yHMwL54ixZW+1OU6TbBTuSRN9nVK
         hS1fr/eH1sumHT3zQq1CwyjWKUabn6qgjnpE/RpbZ12Itk7KPIaGUgh8uYUzbBum6OlA
         K7Gtj9LLQmRCNXCuEffIZFjBa8VOQY+KIHKAEcPnb+L2JtTN8L4uMX742I1s9kP/n5Fp
         q61w==
X-Forwarded-Encrypted: i=1; AJvYcCUNTFAWj1VxED9sdb+tdBN5Y2BhqZGtoNiZtj+HNRkWKIvJ+Zm888ezTaqPNohnuoayGgw3tScs3Cuxy5ooN8il+t7b3JD63fCPT0xvFbhDM5xDC7MBCvhDBNpUOoQSHlOYYxOHKoGp
X-Gm-Message-State: AOJu0YzUbhEZVH9bTiN24jOC7Pmy6HgfJ26kkBeuaoZ0ZVVf4/uPffpY
	1IiPMb3A6w8QE/OV5YaXRhkd3wiTbI/PEhgdvdp/kPQQSpOU3kz6
X-Google-Smtp-Source: AGHT+IFPwLue4GNpl6jOJWmWbL5SwNG3FadCZj3G1/MvjuNOFPOrut2PmQYEcmUTouoL3lufH1CMjw==
X-Received: by 2002:a05:6512:2023:b0:52b:c192:c19c with SMTP id 2adb3069b0e04-52bc192c224mr4464748e87.21.1718013704920;
        Mon, 10 Jun 2024 03:01:44 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52be8000343sm997863e87.83.2024.06.10.03.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 03:01:43 -0700 (PDT)
Date: Mon, 10 Jun 2024 13:01:40 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] iio: bu27034: Add a read only HWARDWAREGAIN
Message-ID: <5e88c7b7b0389c6c011f15e05e065791f7561cf5.1718013518.git.mazziesaccount@gmail.com>
References: <cover.1718013518.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GRDaP5Vh04W+8BOG"
Content-Disposition: inline
In-Reply-To: <cover.1718013518.git.mazziesaccount@gmail.com>


--GRDaP5Vh04W+8BOG
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
 drivers/iio/light/rohm-bu27034.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/light/rohm-bu27034.c b/drivers/iio/light/rohm-bu27=
034.c
index 51acad2cafbd..b299ff2aacce 100644
--- a/drivers/iio/light/rohm-bu27034.c
+++ b/drivers/iio/light/rohm-bu27034.c
@@ -149,7 +149,8 @@ static const struct iio_itime_sel_mul bu27034_itimes[] =
=3D {
 	.channel =3D BU27034_CHAN_##_name,				\
 	.channel2 =3D IIO_MOD_LIGHT_CLEAR,				\
 	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |			\
-			      BIT(IIO_CHAN_INFO_SCALE),			\
+			      BIT(IIO_CHAN_INFO_SCALE) |		\
+			      BIT(IIO_CHAN_INFO_HARDWAREGAIN),		\
 	.info_mask_separate_available =3D BIT(IIO_CHAN_INFO_SCALE),	\
 	.info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_INT_TIME),		\
 	.info_mask_shared_by_all_available =3D				\
@@ -992,6 +993,13 @@ static int bu27034_read_raw(struct iio_dev *idev,
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
@@ -1036,12 +1044,16 @@ static int bu27034_write_raw_get_fmt(struct iio_dev=
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

--GRDaP5Vh04W+8BOG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmZmzwMACgkQeFA3/03a
ocWj8Af+P5P4meb5MBnUNFARLI4A0JAwzjcBM6FCEfefSdxqt0D3PuXemQ++vZDM
TwCeYe3Mg3408uZPPowytK0grlrA/F/MRnYZYmNHqaCGBewdRyKdYYbmjdMaZkRW
2llWSBOYBE7vhF0RRQGw8bLzitN3BBPc0fxGxob5gw7k/bZH9zti6MwIZEYC60+K
XNvtGe0Ufs0WEA2/esbcRv6tg9qDZbFNSt5MVTX7PzYo+6kOLEj+Pnevl5ahSxsY
pB246WrAEpYC+OVJuiEOE8N2inUYhdftJfdp6DxEhRz2RWfM0ggVpP0TJh+U1Coh
c851m5OVVaH0WGOhr8t/obAQ7Zzcrw==
=qQHl
-----END PGP SIGNATURE-----

--GRDaP5Vh04W+8BOG--

