Return-Path: <linux-iio+bounces-11607-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6131B9B63DD
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 14:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 849E11C20B12
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 13:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353E147A73;
	Wed, 30 Oct 2024 13:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pjun1mSb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1FD1E9093;
	Wed, 30 Oct 2024 13:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730294185; cv=none; b=aXYcqZrHqbYASxm+RZgKC7vhCj5jdXkkRCPaG2ABSt2oOYPpyumkUp3Po7gsRKZDcvdSr9Fe5Pg2WgzjTNThQ20vxqsCH9jBo8KQ9XjFkh7ryWxpEVHZgtpQGnpTPZaeiL3RUb4DRLW5fdB6MoFZXTriKUvcIZX18yxL5lAfKWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730294185; c=relaxed/simple;
	bh=mjpOykWQQEPD08Zedf+uqfUx3hOJDIiOsWhO6tR9sJg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YYMhHX+dKOwHJB/Edp9eXmwljrfCQxHtWlmSPoqZusdOPF1Q3mLwDorTRQWKSM0JByLXo2bsp84QScHkadeo5f73lZP4PRjhvL4mJCLWXFTlzCj0Znjs85+OpcbcZhTy9aAyjqHf8C8gNtfsOKYGjw3d7rZaGV/w6kRY93005UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pjun1mSb; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539ebb5a20aso6825024e87.2;
        Wed, 30 Oct 2024 06:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730294181; x=1730898981; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EwlnyAJH2YmkogP0eusSK0qgfGqw+0ITGuYRph0kP/c=;
        b=Pjun1mSbVgfhugL494m3+/K7jJdM8J/QkOWQn4y6BgPtrJJz2PqgJfSUEaYwiLVIms
         bx5JC8euHJAwbQQPjRM2BfPu5Z8GcIjJ8xxPQEHrucQRVjkI2HgplaE7L+k+ol+0Wt7y
         Afm1prlFxwck2kYThD028My5vYO6JQrUHP08ZUHF5VzY+ls+upA+PhuBMzyRqlpt8Fnr
         PIuHd/7/fLVKDgXswQfsE+1U6pSzh2WPQRFfuvvHOy3bEfRC86Tn6r+Sv6VnZn3riikr
         5UFyA1vGIawPIGUB29rwhQfKojOU6vTrzd9xO1gWQ8Ux/K5+y1lAmpLK4WWYhqFDFB8J
         M5Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730294181; x=1730898981;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EwlnyAJH2YmkogP0eusSK0qgfGqw+0ITGuYRph0kP/c=;
        b=ixwpPXqOg4imbRxiKtPYqBQlFZmAlnzTnUkhJcdqFAluvzOKOgSMMbSZcZ07zW4jYn
         ZTfkyV2+3GvAdWJye4800KWbJbpqIykjpAmm+2QCZY0vIpZxph5oplGObldOmdV3dDjg
         ++QzpB031jZx2i4441i7QDL58g1GkJDPy5qlqnKCqeNzD1UPGh1n+FC4D/g8tTAjNhGk
         ZJ85AkiBLc/x4PSGebkjb30OS49zsAaw93psKaXPHSWzUx453xKEZskoHipNWP0rdEzH
         7UmChTMr6j56LQmZtKIg0kvFk6E+O9VWzeMaEby4r8p2zZW8xFioM9lwxtzA7b11k3mm
         I0ow==
X-Forwarded-Encrypted: i=1; AJvYcCW4VkIzKF5mPJd3vRxKtKAaMPU6mLLtQu4pTkyNFJVTKBAt4rbQWrtXvpWMFup9T8VBfwm/8j7yhQc=@vger.kernel.org, AJvYcCWkg42ALjpE5mE5p0bID8AKKYxnobWTxlEnR+saZh38yzZauJUP/54WXPBdRPspbhOPFAAkiu6JVQITMEFM@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk3GAw8+6Mqv5JQv92seMpYW5ly2v5vDHUMB6ossbXRwBHW+xP
	n5A7ONfZJz4WbyoFdxE41Dm4E28fozvMphtSEdSoLxAl0AE5HOXV
X-Google-Smtp-Source: AGHT+IFS8fxarz/Ajf87YTbmEN+WSlQK6b9XCgaXn95oIJM9OIcg90gyB/QNrP022LYByL9LIcA1OA==
X-Received: by 2002:a05:6512:3406:b0:539:88f7:d3c4 with SMTP id 2adb3069b0e04-53b348ded37mr8251994e87.29.1730294180723;
        Wed, 30 Oct 2024 06:16:20 -0700 (PDT)
Received: from mva-rohm ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53bc0d6fd23sm246359e87.271.2024.10.30.06.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 06:16:19 -0700 (PDT)
Date: Wed, 30 Oct 2024 15:16:11 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Kalle Niemi <kaleposti@gmail.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: kx022a: Fix raw read format
Message-ID: <ZyIxm_zamZfIGrnB@mva-rohm>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9YP4nW3d0VQmSZYA"
Content-Disposition: inline


--9YP4nW3d0VQmSZYA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The KX022A provides the accelerometer data in two subsequent registers.
The registers are laid out so that the value obtained via bulk-read of
these registers can be interpreted as signed 16-bit little endian value.
The read value is converted to cpu_endianes and stored into 32bit integer.
The le16_to_cpu() casts value to unsigned 16-bit value, and when this is
assigned to 32-bit integer the resulting value will always be positive.

This has not been a problem to users (at least not all users) of the sysfs
interface, who know the data format based on the scan info and who have
converted the read value back to 16-bit signed value.

This, however, will be a problem for those who use the in-kernel
interfaces, especially the iio_read_channel_processed_scale().

The iio_read_channel_processed_scale() performs multiplications to the
returned (always positive) raw value, which will cause strange results
when the data from the sensor has been negative.

Fix the read_raw format by casting the result of the le_to_cpu() to
signed 16-bit value before assigning it to the integer. This will make
the negative readings to be correctly reported as negative.

This fix will be visible to users by changing values returned via sysfs
to appear in correct (negative) format.

Reported-by: Kalle Niemi <kaleposti@gmail.com>
Fixes: 7c1d1677b322 ("iio: accel: Support Kionix/ROHM KX022A accelerometer")
Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Tested-by: Kalle Niemi <kaleposti@gmail.com>
---
 drivers/iio/accel/kionix-kx022a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-k=
x022a.c
index 53d59a04ae15..b6a828a6df93 100644
--- a/drivers/iio/accel/kionix-kx022a.c
+++ b/drivers/iio/accel/kionix-kx022a.c
@@ -594,7 +594,7 @@ static int kx022a_get_axis(struct kx022a_data *data,
 	if (ret)
 		return ret;
=20
-	*val =3D le16_to_cpu(data->buffer[0]);
+	*val =3D (s16)le16_to_cpu(data->buffer[0]);
=20
 	return IIO_VAL_INT;
 }

base-commit: 81983758430957d9a5cb3333fe324fd70cf63e7e
--=20
2.47.0


--9YP4nW3d0VQmSZYA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmciMZcACgkQeFA3/03a
ocUAbAf8CemZaa8l9ZL0wm+5dOk5Q6Xqc0R6LoHRx4ub7WgqoXh2gnPzQIjZJNEa
ZHL/M6o2GQucL0I2+mWSmXAzYaEXe/eCT3gJ3trEYN6RJxN0j9m2v59jqxCK/eO6
OfDWKiDUk+edc5Gy0DfnmP2KOa2JfR/CX6JxEz5NSA1LbsMpAYO4YJkJRwBPiAPr
tC1pmbJ2RitWdGGGHtF5Ip6ObuPqZy0P3y0ixayasWiar412gsGP5kRan+8I/u6K
JKa9K7jOdVM7Lbg9PP2l+XOT6aQxm9qk7ctGWwn+QBi97vhYzvbHQGarchkqofOg
R2b+7OrZSvVcSNhEcroCJ1c9l6rsVQ==
=Q3JL
-----END PGP SIGNATURE-----

--9YP4nW3d0VQmSZYA--

