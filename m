Return-Path: <linux-iio+bounces-26350-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6F8C77F7E
	for <lists+linux-iio@lfdr.de>; Fri, 21 Nov 2025 09:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DFAFA4E6D58
	for <lists+linux-iio@lfdr.de>; Fri, 21 Nov 2025 08:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592BA33ADA3;
	Fri, 21 Nov 2025 08:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lQGUfYIM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A122FFDDB
	for <linux-iio@vger.kernel.org>; Fri, 21 Nov 2025 08:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763714619; cv=none; b=ugSGx7B7aLFfe7xW9P1TDLPVWw0RoCyZnks9x6An4ZMCozdJ3yqtYuDu9JFyhYf6tzMzA8uLe/MxkN8Mr7ZUuoERzFf54cIISQHTeEp+ZcZeqGqxk3jU5YtPE//8qT1EOeZ7UyB954aseEk6nIkHwxE02UVT8uM03JwRaFPDOOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763714619; c=relaxed/simple;
	bh=3ut8kCXbCC9msdmQfS5l2TFODoTzQzlS2077LmEgTKY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WvPxCvroG1dkqatW6DonwumpWhQqv/VpoQ3oiDiwuAywDgBuhskkIy+ctCgUdK9LCV368R4oKZJc+1jkV9X4XAQx0EpHoTgBGJbCcG+pcSLZgyfHlGgH/fa1Js+bn6KrhzHPSKOZCA5aV6lBLFMAy7z2PrRodAH+UZvnkLEpv0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lQGUfYIM; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47796a837c7so11332035e9.0
        for <linux-iio@vger.kernel.org>; Fri, 21 Nov 2025 00:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763714614; x=1764319414; darn=vger.kernel.org;
        h=mime-version:user-agent:organization:references:in-reply-to:date:cc
         :to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ut8kCXbCC9msdmQfS5l2TFODoTzQzlS2077LmEgTKY=;
        b=lQGUfYIM/t7c7WcMzzZctkeYYvB7HSERdsT3mxn4cP1LFQ3cQ2bWX8xtaoSwXmqrV0
         Cy7ReXV4WDn29LxJsuu9YDvWBTB+BIB6smV8hwv7EcnIGLiGjEacK0NUYXgRnvGb6NNF
         seTwGx8HDp7cNL+pp6aF04Hcpx7I7KcQOpLq/d8PdvzEAzidDjtnqGD4Z4qBhuzoBOTN
         XBplq2ha4ubqF+MOWf1OvEadWkKOzOit24SZEe/W7dKT7oVzp5Tha9aA7Ojl/u1oJmlJ
         4yNG2FR6IX6mzNpL/LDInJxplmicD8bzLBYZuSx6DDGUSlu/pz6cGE1HFk0pEcy5WsJX
         UpAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763714614; x=1764319414;
        h=mime-version:user-agent:organization:references:in-reply-to:date:cc
         :to:from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ut8kCXbCC9msdmQfS5l2TFODoTzQzlS2077LmEgTKY=;
        b=IRFq6CwD/812wmddhM0SCG/6j1+F9cF7pvrqn/ikgDx4tjQJNgLv5fN7pb7k9g8i+m
         5+fmg2xoqGxB7UC3X4V+b4FLto9preS0trvhyht7gywCFanVDsA+ElqWpjb+F4rPy0BR
         sYOK4UoPbk+QccZrJefElzpkq3FD4ffvuSKVXXuljQSNVbamMqFIpFF1spsgd7O0PS9l
         ESMlnNRyZzHov/FVw6Z1ANODxTOd47US+KYm0r49CLXO3fz+swiDPwbVW29TJqEJOOwL
         /WwgFUXLDSz87BNKG6QZtKPSE9u7wvYtgKiAXHwpONjkR4W05iKzNUR5XmFcLx01jKuw
         1fzg==
X-Forwarded-Encrypted: i=1; AJvYcCVdd6wIkqAX3FkVU6RtdA5c0MPCDxLZhXNHUrClZQky5t6Xqj3aSr5L+/qxwhUiE0vrDXfj3ATS4TY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPqcGA6sfXOqK18bX5QxXO4lpRjhbfOpGX8H0v6dVhqhlkEeKQ
	vznvDnRP8pycHWMYhaNEdlle5m5iC3Nb0B5/oz0CHGlfbHjvWDF8z2NvnwzWPWoh47o=
X-Gm-Gg: ASbGnct7DIJx9r/aypuoZ6yF6pQlXfBu+9SoMJ46obxNq/rR89lM6Y11v1iAi/pdr9V
	Y27g7kvd8OBtPHeL1DZyW1qdrfEJVhIpBqZDVoPl+tM1EPLk83O1gmRmyg5StR//1dT3n4MEcBQ
	yUF2Frq/23cMYTXY8pFWYWKtPw8rBzG5DA1O9ik39Bv4wZ/SzVVoLsMAcVbM30sp6FGbV09PyY8
	4NvkZctmw3ehKRMRV7SuLfJ5MO1fw3Xrwxi6cENnRJJOi1cZ2aw6hVKy5HbVvTKPr6qBKD+j7+5
	oelGWR7lxEDyDWi1zWct/jrSvvXQtRMCySNihu01T7N0zQ4gWEwpgdd3WetDOVp68Cu8l58G2FW
	E7k9OefAelauqedD/3mUutPGW07B/5JLA2jH03crjnf5SstSAj18kki769UkVhUdxytxzDw==
X-Google-Smtp-Source: AGHT+IFORBGxIURGLn2pS1Q7OBZLc0+pFB2lyKCOdGwCkr5ZXD7TL9dKAStWG0fBJKqOeuX6zRPbhA==
X-Received: by 2002:a05:600c:468c:b0:477:79f8:daa8 with SMTP id 5b1f17b1804b1-477c01b219amr14465015e9.17.1763714613950;
        Fri, 21 Nov 2025 00:43:33 -0800 (PST)
Received: from [10.203.83.154] ([151.37.169.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fba201sm9742736f8f.32.2025.11.21.00.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 00:43:33 -0800 (PST)
Message-ID: <c665ae5fed9fb42e0312f000a2d3e784360a8d01.camel@baylibre.com>
Subject: Re: [PATCH v2 5/9] iio: imu: st_lsm6dsx: remove event_threshold
 field from hw struct
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>,  Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,  linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 21 Nov 2025 09:43:28 +0100
In-Reply-To: <aSAfT3OZRnaTtjXn@lore-desk>
References: <20251120082615.3263892-1-flavra@baylibre.com>
	 <20251120082615.3263892-6-flavra@baylibre.com> <aSAfT3OZRnaTtjXn@lore-desk>
Organization: BayLibre
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-9tVpcc+jyRluSKh9yzo1"
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-9tVpcc+jyRluSKh9yzo1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2025-11-21 at 09:14 +0100, Lorenzo Bianconi wrote:
> > This field is used to store the wakeup event detection threshold value.
> > When adding support for more event types, some of which may have
> > different
> > threshold values for different axes, storing all threshold values for
> > all
> > event sources would be cumbersome. Thus, remove this field altogether,
> > and
> > read the currently configured value from the sensor when requested by
> > userspace.
> >=20
> > Signed-off-by: Francesco Lavra <flavra@baylibre.com>
>=20
> Just a nit inline, fixing it:
>=20
> Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> > ---
> > =C2=A0drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 3 +--
> > =C2=A0drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 12 +++++++++---
> > =C2=A02 files changed, 10 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > index bbb967b2754b..e727a87413e5 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > @@ -79,6 +79,7 @@ enum st_lsm6dsx_hw_id {
> > =C2=A0#define ST_LSM6DSX_MAX_TAGGED_WORD_LEN=C2=A0((32 /
> > ST_LSM6DSX_TAGGED_SAMPLE_SIZE) \
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 *
> > ST_LSM6DSX_TAGGED_SAMPLE_SIZE)
> > =C2=A0#define ST_LSM6DSX_SHIFT_VAL(val, mask)=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0(((val) << __ffs(mask))
> > & (mask))
> > +#define st_lsm6dsx_field_get(mask, reg)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0((reg & mask) >>
> > __ffs(mask))
>=20
> To be aligned with the rest of the code, I guess we could use capital
> letters
> here:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#define ST_LSM6DSX_FIELD_=
GET(mask, reg)=E2=96=B8=C2=A0=C2=A0=C2=A0=C2=A0 ((reg & mask) >>
> __ffs(mask))

That's what I proposed initially, but Andy suggested [1] using small
letters instead.

https://lore.kernel.org/linux-iio/aQh4m25uVBV8A09F@smile.fi.intel.com/


--=-9tVpcc+jyRluSKh9yzo1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEhleFT5U73KMewxTm7fE7c86UNl8FAmkgJjAACgkQ7fE7c86U
Nl9Bsgv+KcuQ7Qt3ZHHjjPIxyu5Ho76R2Sl7v5y7NttZiTJJJ4AXe7eVX40Jm4++
F/uw0b6oTJHRiqTw19vxzb7Rb8EnDwGMu3DBrcrYV9+qLTHWurj3sITjBZgKaa2E
5i8Un5gI4fmnSAFtik4fwDc+vDih5/w9r1yp+1Hjr4JYCwYZtB3ocJOnwhfqhpIC
Z+h7JBGl9K8vMfI0Z9IDYAWo3n1bCwQbzugbZpwMB9rJkrsgwYT65OGYos05x1hL
O5Munn+3yELsZ0+vRE3+IDjfvGQUo1ws6GepmmBDN4ALoAAhizBDHeXm7X3ADgAO
l9erXCYwedkZtzdgac9A86Cg4U79AHdNXp4Sc0W5YU8J9WyM4OW/rYTjgAPKyauy
7kHetizoZ4gOuApvbBoqTNh3B1SBJVYxhSDetMx2fr3zr4m41pZEmXjErwPTrHZK
bDnhPwdEiGGrepWZt5YWF8te1jEYzR04EKKqMSj3rurOJs7AuRNV/nFjQEbteiRW
cF9Vp5t+
=rnAh
-----END PGP SIGNATURE-----

--=-9tVpcc+jyRluSKh9yzo1--

