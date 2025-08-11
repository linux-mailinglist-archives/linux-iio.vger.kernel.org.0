Return-Path: <linux-iio+bounces-22546-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9AD6B20243
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 10:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F34D2189FF85
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 08:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21042DCBF2;
	Mon, 11 Aug 2025 08:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fVSH+wa7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082AA1991DD;
	Mon, 11 Aug 2025 08:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754902274; cv=none; b=Lv8KAIRWP2258hnNxItAUhvjlGaGDMyiGDdreKNDTRvLm3HV3Ifv6XuSmlJ/ci5Q/l6G8dv4Vou8jVEWlYhEieWF5W7dVLgKeG2Tvi+1XFMvf6iyEpd7oaG+MlAWW09Sh5nZuORT8mIm+kbYm7Hxxo2H2YbbOYbB/uvPmPeIKI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754902274; c=relaxed/simple;
	bh=WjhHEo620Lo/k6ZuL8xyE8IX3r3JuRsgOfEgubkfN80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rBYyPoPn+AYndiwUPD7SCgI01lf5o+4ru/m+BUZBb73a9uOjq2xsgLpk4KMhlHD37iOxawtzQH7Ebx1Y2MO+pgg/Z9Y9o9i8hf3+fN5FKnhFxYUHmOpbVTVVQWH1bOetOk8345fZ0cep0wzp5KPBAI1T5TZryyR2xCfJeUvjIls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fVSH+wa7; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-32f1df5b089so39470491fa.3;
        Mon, 11 Aug 2025 01:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754902271; x=1755507071; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+GsgVEtXAH+An9m6SgSjTahsKgzNaFQhX0QtevPtRLc=;
        b=fVSH+wa7/8iICZnXfMhBKFjzJcFTLCJTBDFhtm7CBE++p5UL5TIb5aK0b0W9HjNYdC
         Mb+WhB8RyiR8ptQddpQZhUT+915cGYrwj1DoiqrGbwkzhPpjzShL2ZA/KUPZkuqcvY01
         R70WmiP1kOeKuBiuXHeuX1g1G99BPFThE1GoeUeB21Mobo/ywGCAVvPA6sZc4+oelI1R
         2NJD0US3yaIBwtZhtJkK7VMFi7T1wVaYwdXaZUt7Cf1G6DZEsfjYsFrseGE7BufQasPG
         UqnjRZp1Vg/5b+Q1lYAnCA2t4swMrxZA7GmSF9eTF3gJbLju7chB0kgBi9HwJc8HtBW5
         3l+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754902271; x=1755507071;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+GsgVEtXAH+An9m6SgSjTahsKgzNaFQhX0QtevPtRLc=;
        b=b2EMSgpwaQy5ayZDSm5i+BaFrW2QPMiaxZI1399s5Til+fkBeuPUXOlK6NY8t6EjQm
         5ZjW+M//X1LPKyiess5Chrr4iEYUPknv2ddgpc0WfywETds3D7Kwtg80X388jIqaxGAr
         hEfk43lPy/+tR0ULzD2aheIfiyPdOrrnEw5noM+KQLEYdP4v2y1s1YR1zZXND4P0Y0R+
         BSje5dRgXypxjKSZzpFTZNywjOqs5KGdtP2A/4uZxno2V8uGBdK27WusmDTsg2ppODSR
         X02iyTmJQ41iqUrl88HsDKWCRJF7y2yfdV1soV196r0+N/fwgT4nSlNX6kHyU77s6Uys
         a3MA==
X-Forwarded-Encrypted: i=1; AJvYcCUFtzIvKFy1hTmwf/Od4x7XYd5UVlH35KieKDr7OOiNHZE8DhIdhHTCpv3MNDoKcLVahBLdM1VGtulN@vger.kernel.org, AJvYcCVUfBTrqp9d72iHZn/LLdEHI0rMrdVcSk7Myu4Qbpx8Ry9SI4VNXbxLihbd3tPUn2EsxegjlZ1yv9uj@vger.kernel.org, AJvYcCXYgJEwxjEmp+2I+PXkMYoo5ssyH39maE/lL88jwdaCGqjrbMg8j0NGsrNy8XDZi+1qEhVJ3WExDsgpMUnE@vger.kernel.org
X-Gm-Message-State: AOJu0Yyml49vRUpv06tLxxZUhazd+S6cYtXyNnQkBenLw4MEy5JwP1A9
	ZGedyTzj9WY/Z/je9QcxvHMe9dcU9AZmaSjksmiU0JNG8Dc5CYRIX9qvcJV0s6cQ
X-Gm-Gg: ASbGncsMl0cflKCTOdhStI5Vlhe+VW4CedI4R8Hqv6ifBuC0h9tyYFPYvvRXUW1mOX/
	6nLN8iWoTVlwpt8RKOzMkDA3waoH5mXvL2EMFawDk/vTfax6yFB+fuouagau8hGMEqCklCPQa3v
	922swVexvH0eYN4VTFSPUJ/V24VG8wlK7BEtj4y5XC69LNUHK/owp0EYDSSFAFClq7EYbp2lXaH
	H5kc6V0zds7UpeiK18cb+zh59mgSUUhoTI6Al+OzyHGgTMQAAfwXOLJGld+x8vwBqfiZyNYqK+/
	N8oOJOPY7MdpxtQ6ehX7E3GRaFQbmn9iALM0NgVYVxs5WPQpgMJ4p007fBKYJyHANXf6jNreveU
	05BPLtSGUec+LZ6CbIRWQBmQWAAZH
X-Google-Smtp-Source: AGHT+IHgd6XFJ1YvZ68Xy5D1lIedWnfbLd9JmUVEamgOUR02B3EZFz34fug0sZFwWK8oozcXxScibA==
X-Received: by 2002:a05:651c:40d8:b0:32b:50c5:2593 with SMTP id 38308e7fff4ca-333a215c774mr18222761fa.18.1754902270933;
        Mon, 11 Aug 2025 01:51:10 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-332385b247csm43054671fa.39.2025.08.11.01.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 01:51:10 -0700 (PDT)
Date: Mon, 11 Aug 2025 11:51:06 +0300
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
Subject: [PATCH v4 04/11] iio: adc: ad7476: Use correct channel for bit info
Message-ID: <70619e39023bc497ef68cc1eff11943ab68cbdf8.1754901948.git.mazziesaccount@gmail.com>
References: <cover.1754901948.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XZARgE2KwM5nkx4m"
Content-Disposition: inline
In-Reply-To: <cover.1754901948.git.mazziesaccount@gmail.com>


--XZARgE2KwM5nkx4m
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ad7476 supports ADCs which use separate GPIO for starting the
conversion. For such devices, the driver uses different channel
information if the GPIO is found. The bit information is still always
used from the original (non 'convstart') channels.

This has not been causing problems because the bit information for the
'convstart' -channel and the 'normal' -channel is identical. It,
however, will cause issues if an IC has different characteristics for an
'convstart' -channel and regular channel. Furthermore, this will cause
problems if a device always requires the convstart GPIO and thus only
defines the convstart channel.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Reviewed-by: Nuno S=E1 <nuno.sa@analog.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>

---
Revision history:
 v1 =3D> :
 - No changes
---
 drivers/iio/adc/ad7476.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
index 7b6d36999afc..fc701267358e 100644
--- a/drivers/iio/adc/ad7476.c
+++ b/drivers/iio/adc/ad7476.c
@@ -121,8 +121,8 @@ static int ad7476_read_raw(struct iio_dev *indio_dev,
=20
 		if (ret < 0)
 			return ret;
-		*val =3D (ret >> st->chip_info->channel[0].scan_type.shift) &
-			GENMASK(st->chip_info->channel[0].scan_type.realbits - 1, 0);
+		*val =3D (ret >> chan->scan_type.shift) &
+			GENMASK(chan->scan_type.realbits - 1, 0);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		*val =3D st->scale_mv;
@@ -345,7 +345,7 @@ static int ad7476_probe(struct spi_device *spi)
 	/* Setup default message */
=20
 	st->xfer.rx_buf =3D &st->data;
-	st->xfer.len =3D st->chip_info->channel[0].scan_type.storagebits / 8;
+	st->xfer.len =3D indio_dev->channels[0].scan_type.storagebits / 8;
=20
 	spi_message_init(&st->msg);
 	spi_message_add_tail(&st->xfer, &st->msg);
--=20
2.50.1


--XZARgE2KwM5nkx4m
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmiZrvoACgkQeFA3/03a
ocWtHAf+KHAvSuLa6J9AO80UgVO4M+YTydPk+rkF1/333VPybNX7JzS9c20HtWsY
p6PB4Q5/pIeQZVCq7dAQPFUpxbhdLE+h3JkCRW9XU8ZtBdXbgdxqNi8u3bssYxg2
zkG+Y8HKxzkeKzKVmohKjOxo+CL2WCHvrC5Xq1gDID/yESSwIOzStimZSixKV089
/74D/VV07NiwRAgkTBjmOwS5n9t7U/MVowAKlDx9VEiA1MYAt2p1L1TvlH8p3Ud1
NNkG4DDNNpzwBiB745amUZJjPmbWo+tyF92KJYV0S7WeHgAkLAUSBc83C+ZAvHDd
p2NWY86fWwnhi/g/He99Ids7kcwSow==
=BCwh
-----END PGP SIGNATURE-----

--XZARgE2KwM5nkx4m--

