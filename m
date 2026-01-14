Return-Path: <linux-iio+bounces-27783-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C56C4D1F15F
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 14:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24739301896C
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 13:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FDF399004;
	Wed, 14 Jan 2026 13:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8bgwvID"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6C037F8AF
	for <linux-iio@vger.kernel.org>; Wed, 14 Jan 2026 13:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768397856; cv=none; b=Cq+AR11/FUfdyEcyvWY5GB1AVcLajkJAm3U4qoxDkjLGE/GcqrV0kIwao6urIaJy91idRVYuaCHIwrKLZyCFXKzSpra3ztYafhBzd52Ss9Xn/GCNghwq+Yd8n6WutUmC0nPJ/yFVuzdpJn9gT7ikKyr/8GSDFKmxVlW9AE3yjiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768397856; c=relaxed/simple;
	bh=8pw+K3c2vZJP8Gksc+NvkAXXHX8sytbZTL0zkIG9w9E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M+1SEh15sFmXhtd7VZioG60Y/eSbug8qk8okQ/8asSRT9Zzoye5gi+kL1wv/uhPOP1KoLz6Q/DdoLWlYyEBQS7BXnV0HwxQ1H1ZFGN37c8dZc/LGGwCZGwawwlqhIpYW4KCyws06ekMU4CswYajfn6GqeN/ki3wIN01z5tufdR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R8bgwvID; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47ee9817a35so234935e9.1
        for <linux-iio@vger.kernel.org>; Wed, 14 Jan 2026 05:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768397853; x=1769002653; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3CWtPbSbdgqm9PmjbJblJTUraVJXyGWVv5tT+d5pYsY=;
        b=R8bgwvIDd/Yll0JjRdK4Fi0LxYj4Oscq+DK1Po6xTdiRQJk+cMqfRoM3P6iabfzY6x
         PQT7u0USl/COHphSU3U0w8CAN0r+8WniA0J+Dqp2ONT+kjilRLeBF9Y+5wfyzKpzMlcW
         bJCbURjjWiI3TJff1Py9V2Oc0d9p9PkMQuSyG6vsUtZqj/RmmpietdhRhZR0wto9JK2E
         Mw+Vh1TDdWEJDeS5LHnmdUuk8YUnRQawbpCk7x8LT9GCSNRj0PcPyG+QQvYVn/Y9g9hl
         EDorl+ROg3aKa+YJYfIjfHZgcAIMgDAiLqBUbNRLcJxjggy/2NAFf/fH5wn07Km0Ztge
         8mnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768397853; x=1769002653;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3CWtPbSbdgqm9PmjbJblJTUraVJXyGWVv5tT+d5pYsY=;
        b=tEYItw07yD8CA09u3heDGw93Y+GwgPwgVcedMNlzsQI+Sh0ayM1fkypZjMbqqFqNMd
         7nZ1jqTyT5lYx0Tl0pBS0lLLPdECfiOzb8MtFZz57sXAfTT71OKpL9fHezzWWwc4jq+P
         FuQqPKyiWKcwM39oBAX2cVnHysSpNVjN3g/D4rDCNQlxHjpdsmR5K2Gf1iWNCMqds12Z
         kCn1H63OOFEteiwXv2HgmGWwidFQR0IDY3JhsDTMNHnydQKsIknxSZoBjhiDBlSi8CoM
         lABzmm8d9V37oGxe96yAGXMQIm3rqyGpoKe2XZP7ZUYXdy7HdJmd5s9veP/LtAtlHwpH
         hJlg==
X-Gm-Message-State: AOJu0YwMV7QQMUCqfsw3aAy4j11ULEcsN73NWJNFb89UOscN8BwM2vhJ
	fT6JRxPwzAGC/oyHzDBQtcyhX9I9tgY5NsyhdTJpklRfBoDTmhQ0sD91
X-Gm-Gg: AY/fxX5D7UUDkiR+Z3EmcIt8i2yZTMcoC0B2FLITRFsolJNFEqxPXBwsq73uU5FYaZQ
	EaoCByA4IuO1/XGoRmCWY76h4OOgnIgQFNl+vHvbNFXaYHXHmdR5Br7SFd05a91dixcx9MnhrYt
	e2FJ+rtFA4IATMdXAOv2HxzmizrKw3J+nhdAjGRhKr1dtVvfgz4Ht1Hl+yCjaoZr5cGdGry4rmg
	QCECL1QYr/759u6O5dRPyqLfZJKqwCFpUGnqKoJIhdXzWIRjFma+9T7cjbPUNj4rNGgcdGbIN+Y
	yqdg4IlP1Zhp2KYB4or5YxHZvqR5dIemj5FpZ1LuH6HuI8vS/eoNC+BVTkJ0To41kGtkBcBl/EM
	7NRobUrRgqxKlCzrujTISb7f4GSCfEN3A1bYaiOg2cF3bpec5Zp2pxPL4dR9gQUhOLDWoaL7z4J
	WUWhHTh+gHZ+AskUrsZto=
X-Received: by 2002:a05:600c:4443:b0:479:3a86:dc1d with SMTP id 5b1f17b1804b1-47ee33915b0mr23199115e9.37.1768397853024;
        Wed, 14 Jan 2026 05:37:33 -0800 (PST)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee578d12fsm29218715e9.3.2026.01.14.05.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 05:37:32 -0800 (PST)
Message-ID: <a4982b925658161c5c0f1bdf1aa7230e33909bdf.camel@gmail.com>
Subject: Re: [PATCH v3 4/4] iio: adc: ad9467: check for backend capabilities
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Tomas Melin <tomas.melin@vaisala.com>, Michael Hennerich	
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Lars-Peter
 Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, David
 Lechner	 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Olivier Moysan	 <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 14 Jan 2026 13:38:15 +0000
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

Another thing is that we also need to care about ad9467_debugfs_init(). No =
point in
adding that interface if we cannot do (or get) anything with it.

I guess we can still have the device specific test modes (without going to =
the backend)
but "calibration_table_dump" does not make sense to add if IIO_BACKEND_CAP_=
CALIBRATION is off.

With a dummy backend, iio_backend_debugfs_add() should already be a no-op.

- Nuno S=C3=A1

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
> =C2=A0
> =C2=A0	ret =3D devm_iio_backend_enable(&spi->dev, st->back);

