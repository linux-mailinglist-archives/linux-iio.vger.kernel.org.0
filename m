Return-Path: <linux-iio+bounces-27772-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 000FDD1EC42
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 13:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 24D26304C66B
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 12:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A3E399014;
	Wed, 14 Jan 2026 12:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXGycMSC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6CC397AC1
	for <linux-iio@vger.kernel.org>; Wed, 14 Jan 2026 12:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768393707; cv=none; b=CPbBzNM7yiI317enYlLVBkZT4deMJSQ+M7VG+79AIKE8/7Yj3bCLeSKvv7HVKDrl1LNzZ0ew8eNUXR3aZq7HBQEmxvMQc362qBFLzrlzxx6Pdnv4jzI8Qr3reeevIclp1vN65YUc3+LkU4gv+NkTwuMiNwstrygpRpdMhN9QIlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768393707; c=relaxed/simple;
	bh=QgwsHL9AbTLz5x42otaIV8gXrDTeQm0xTsamF2Jq5bU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h8baPZ7s/HJtCkUwnnNyjDl1n6qMKKk+BFgHiJ/M1AA5RsExzDiHr/ImhzWHBgyUj/FpJX/frdJriW69kV5343ZcO9rN6BbClwjlOCMd6+nWMkDT2JjqRHauv4CvfoiWkWxDsoXe/XoYQbQ6Dvvq4r3kSADKpvVepZI5nX94H40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BXGycMSC; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-430f57cd471so4401051f8f.0
        for <linux-iio@vger.kernel.org>; Wed, 14 Jan 2026 04:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768393704; x=1768998504; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PNFOqNpn1rMH4P5bAL5Hvxr+IGOQ+YxsG/76tkaFGV8=;
        b=BXGycMSCkZUtITJM+m44UsyX8YnXut4MOd25/39GO2QoxDrdtgZcwXjtzUgZD0m76z
         4oc5gJXns8upNJfr1c/2vc673xKlvSJ1zqpWdKAfDtloJiGqxPhmMOyn+dh1hyvNEurf
         40CFp5Bg9SfJ2wr0+Te7A7w+LtiV4cZdmE7FrZRH1bkIIvaBeDrUz4KhMMrsLEs8s/+J
         gUBJk4Dx6o1YnLBaKpFkM5u/1+Gd60fRynDk/NcGd7Jd0SJRCwkExAh5HOP4aXzvAODQ
         JxXztnPaIAerhZOOIKiQk3lh4tWwPRjj6z5IiOhnxePc6N8dPDuTVr43FQCgUnyuoX8T
         WKHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768393704; x=1768998504;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PNFOqNpn1rMH4P5bAL5Hvxr+IGOQ+YxsG/76tkaFGV8=;
        b=tgxULVI7LP2NYiXfPxz54h0WNqAwXV1ODpbmpUYnalOEGNDfx25VWv/n3ffoJrodKu
         x5AJyS/NRIT1tx8HukM/UXFH48FfB/ZGA+U7FtESx+2KRKpEXmiM10g88kg+qsRH93Tz
         dAkDYta4pjYrNelJu50oDdq4uhhrThZRbdoCemFHI9XH5kbQnZuapB8iHzJGMdV6TcC6
         QHuT7dLA+fHHOwdOnRqNBUJYvbTIAI6XzthljBqEXTU47qyECzg8emDNz/Ergn5TTW0p
         X699Ef5OTCj1zwJi2DBvsY+MrKUsTMSsTei21ykyFnsSXettGLAlf7ThW1cD4KASehQ+
         nNnQ==
X-Gm-Message-State: AOJu0YxM8XRl9uQyHGc7EIdk/rJ610KUCNmfGKqWyq9XKU2et+LOjMy9
	U2J7SatDTxX9TwL4KeZZO+vuLTCf6J6xVCLJJ67m6AvcCs7f68ArqdFV
X-Gm-Gg: AY/fxX6fb6clBXCr9y8bcDQamrGDnH/ZsQWO/OeedwmUxVpcA5owDzvQV9dI1b170kB
	UWw0MWNhYnbBvm0AjoucTtY9I3xwPvmQwx5BYBJB9V+GSxGQFBOvIIM874qpC6l0PGwEUVpZULK
	gAeZp34rhNumPskPBQPLH6rV9qN3eHmWd/5EhLV7U2drNnjEY2RmJHcFZAuozdn8c4JtaS9tUgy
	6AP+mhAgXMAVN3PvQxlkjxI2bS/Dmbd4g/mLEZy7MSu4PTGitazA0hpZHVpADCt+JooUI97T9zT
	fY3n3trDMsWOksNQ4NVl/QkvdqslBPw4Dc6FcSrzZF8fBcuNzvUwP8tCPLG17yZEuCAWVcBCoJX
	B7qkdf8rLAmbnGuwjnlBtF11QEgPZ4HQdnOOnjXADk13YtYs/LZ3l/JiBN/Lgiu6rbeuxaMKg13
	LSeDa3jIVQZJhI4i6XQQY=
X-Received: by 2002:a05:6000:22ca:b0:432:8537:85ca with SMTP id ffacd0b85a97d-4342c554c55mr2772714f8f.50.1768393704095;
        Wed, 14 Jan 2026 04:28:24 -0800 (PST)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0dacc5sm49668267f8f.5.2026.01.14.04.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 04:28:23 -0800 (PST)
Message-ID: <34e97dbb610e82953657d8354c0a343a9e1fa57a.camel@gmail.com>
Subject: Re: [PATCH v3 4/4] iio: adc: ad9467: check for backend capabilities
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Tomas Melin <tomas.melin@vaisala.com>, Michael Hennerich	
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Lars-Peter
 Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, David
 Lechner	 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Olivier Moysan	 <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 14 Jan 2026 12:29:06 +0000
In-Reply-To: <20260114-b4-ad9467-optional-backend-v3-4-d2c84979d010@vaisala.com>
References: 
	<20260114-b4-ad9467-optional-backend-v3-0-d2c84979d010@vaisala.com>
	 <20260114-b4-ad9467-optional-backend-v3-4-d2c84979d010@vaisala.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-01-14 at 10:45 +0000, Tomas Melin wrote:
> Add capability checks for operation with backends that do not support
> full set of features, but are otherwise compatible with the device.
>=20
> Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
> ---
> =C2=A0drivers/iio/adc/ad9467.c | 11 ++++++++++-
> =C2=A01 file changed, 10 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
> index 9cfe66425d4e91e215cccc40e24a92c5e99e9b87..349779a049ad68b4c9f72abfc=
40154b4a3f2e095 100644
> --- a/drivers/iio/adc/ad9467.c
> +++ b/drivers/iio/adc/ad9467.c
> @@ -645,6 +645,9 @@ static int ad9467_backend_testmode_on(struct ad9467_s=
tate *st,
> =C2=A0	};
> =C2=A0	int ret;
> =C2=A0
> +	if (!iio_backend_has_caps(st->back, IIO_BACKEND_CAP_CALIBRATION))
> +		return 0;
> +
> =C2=A0	ret =3D iio_backend_data_format_set(st->back, chan, &data);
> =C2=A0	if (ret)
> =C2=A0		return ret;
> @@ -665,6 +668,9 @@ static int ad9467_backend_testmode_off(struct ad9467_=
state *st,
> =C2=A0	};
> =C2=A0	int ret;
> =C2=A0
> +	if (!iio_backend_has_caps(st->back, IIO_BACKEND_CAP_CALIBRATION))
> +		return 0;
> +
> =C2=A0	ret =3D iio_backend_chan_disable(st->back, chan);
> =C2=A0	if (ret)
> =C2=A0		return ret;
> @@ -807,6 +813,9 @@ static int ad9467_calibrate(struct ad9467_state *st)
> =C2=A0	bool invert =3D false, stat;
> =C2=A0	int ret;
> =C2=A0
> +	if (!iio_backend_has_caps(st->back, IIO_BACKEND_CAP_CALIBRATION))
> +		return 0;
> +

As David suggested, it might make more sense to do the check from the calle=
rs. Not as
important as within the backend functions though.

> =C2=A0	/* all points invalid */
> =C2=A0	bitmap_fill(st->calib_map, st->calib_map_size);
> =C2=A0
> @@ -1357,7 +1366,7 @@ static int ad9467_probe(struct spi_device *spi)
> =C2=A0		return ret;
> =C2=A0
> =C2=A0	ret =3D devm_iio_backend_request_buffer(&spi->dev, st->back, indio=
_dev);
> -	if (ret)
> +	if (ret && ret !=3D -EOPNOTSUPP)
> =C2=A0		return ret;

Don't agree with the above. I would prefer to see a dedicated CAP for buffe=
ring
otherwise I would argue why not doing the same for everything? While it mig=
ht
be acceptable merging IIO_BACKEND_CAP_TEST_PATTERNS and IIO_BACKEND_CAP_CAL=
IBRATION
(given they are related to some extent), that does not apply to buffering.

- Nuno S=C3=A1

