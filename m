Return-Path: <linux-iio+bounces-24199-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF83B7F0E1
	for <lists+linux-iio@lfdr.de>; Wed, 17 Sep 2025 15:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B15ED58063A
	for <lists+linux-iio@lfdr.de>; Wed, 17 Sep 2025 07:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860EC2D191E;
	Wed, 17 Sep 2025 07:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ndf2w8Mr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978242C21C2
	for <linux-iio@vger.kernel.org>; Wed, 17 Sep 2025 07:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758092735; cv=none; b=q/8Hf+GayqvfoqOtnDgxmPwqxIEAPSR+jAEdYNNG7/jzBIOo0fbmAFVqE1K3SzHbLXP6AQchaoR62fNozCQ7ujo+LeJlyr38pNSTu+Fd3mCSnlCoLN/EfyUdwmL5v22UAnSqqx4etboDBmXQ/PKP04519WT3VDmatvjCY9UaZrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758092735; c=relaxed/simple;
	bh=qel+sB8eI+vw5fI+IXJcuamEgWVr7FnrIkhWQFmMCoo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BzUvcfVtLCg5NtrxzGUjA9cV9NMGyylknnuPY2vFdQIxTHSJ2s1rFXX90ayF0ELiYkVpcQoYYq3zZOJC4OgXiyuopw0Nj1Sd4YCpf/ibrJVq5qWixhOczappWoyrwuehecs+SB0XPbeZ++xE9D5jppsNMHngHHkKFg42BY35jEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ndf2w8Mr; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45f2fa8a1adso4187515e9.1
        for <linux-iio@vger.kernel.org>; Wed, 17 Sep 2025 00:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758092732; x=1758697532; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1lELm1XWpGTgxI5pP/LWBGwSZ4uAGIlOCNe7xRYuVz0=;
        b=Ndf2w8MrDvJ09zTwEX2ML8CNBujrVNHGYSU/PnDx6U8Aoru2ujsMEzmJtcDe8nVIz1
         tlfK/o0UtBRVX4r+3hFEsD8Oi08bCJLMy6labEwqR+xGxzVjs9oaM8IAJzbz3gtl0auF
         jGFa+u72GOadt93x7GkZFe/645O48ZApieVvkgreOOU6FVjJv2xPLEcqhyAUpHgyznPD
         cZl/zndOsKelCUQhuLBx6K8LMwZrHy3yw+CmnApk2D9s/gARlZAMOp5Hhek07E8CH/5d
         LxqlA3NwhoXbzSCC4Qm2m5OyL9nh6+tI4wHKhD7l4/ileTz+5h2ovp3JUEO8W99n8pc7
         0XOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758092732; x=1758697532;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1lELm1XWpGTgxI5pP/LWBGwSZ4uAGIlOCNe7xRYuVz0=;
        b=NGa916sAUc6uIj2SsUwfk9CF9rlYXSElr4wwlVlf9vhUi3nSEAe7DSRKvm39QlNI3W
         7k6OWmcIivOzh4gAGSpYBGCAbTKwASt7fWT2xUy9/RR7lMCx2sIPldWN+1ZnVStHlIOt
         SAYb2Ev1g0FJ2abuw7GQafsiSy9TTKNclGz+PjSYt61BTM5E3+UoEDUhKsCkvlrX3MYC
         ZmI1QIznPgVQhI/6G9gegYym8w1uNQL2BXv6iWgYbAyaefkiV9bpgHDn+UhuHeGnnFHy
         NgVfNPxW3F7MsA+K7Gg6eoS634nsE5bs2YNbqI0glBzQ50RZ1A9JXN0ThPjryBpGYKvf
         juuw==
X-Gm-Message-State: AOJu0YxENeYHLOsAmlhdt2Hk0gYJ5RRKYd3IyRryHaRzV+8kUW8/Uxfi
	rtRSBwwdI+zyxzKNRWtpRBnFQx5UuglHuCB2tYWdNne0XkF+t8NrjWRgODSgcMwkEdc=
X-Gm-Gg: ASbGncv1BGkzOaw9wOIQh93t4bkOGVmJBmesSaQv2rysrMxHvFE3huPiifeCsbSSklq
	eZ7vPO3/GEFxlgTpC6sLKJX+78tdoIr/TYnKm/VtRClpSf5pOPp7BeGi8cm8rCf9PA04Dtx4Ern
	Zbb6t9dQNaqabZrlAUWFtjRSgfAcKfC7EacLYRhomEKLpegDEqDGbNS1zqmaM1Eol4mUt17LAlv
	GH3z8raghXg8j/6jk+rT43Iq7dywkjvxJr6iYQoHjlkNHP5ra52qvg44ePloGwt0iHnOrs3aSE9
	NhR01X1VBlQpcP21cuXdioztU3mRow67zoP0kI7EVWXgO2/x0wM22qpFcsn5TyaJj2Rw1rsGP61
	F7Ahr2BLV6PMkgCXx/rr6lQ==
X-Google-Smtp-Source: AGHT+IFlPuJM7gO5ArkZaq21I+GH1aAzibNklb9hk65tHGxbHIZmR7Qv5O6d6pSrCpHsc9ccC0z1IQ==
X-Received: by 2002:a05:600c:4f54:b0:45f:2d7b:7953 with SMTP id 5b1f17b1804b1-461fa02bc5emr9192095e9.18.1758092731465;
        Wed, 17 Sep 2025 00:05:31 -0700 (PDT)
Received: from [10.5.0.2] ([45.94.208.90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4613dccb4fesm23735855e9.16.2025.09.17.00.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 00:05:31 -0700 (PDT)
Message-ID: <ce724693ffd6bc8f3f10cb8d753fd69191a19d8d.camel@gmail.com>
Subject: Re: [PATCH] drivers: iio: adc: ad7124: remove __ad7124_set_channel()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Michael Hennerich
	 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Nuno
 =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 17 Sep 2025 08:05:57 +0100
In-Reply-To: <20250916-iio-adc-ad7124-remove-__ad7124_set_channel-v1-1-aa7a2cbec8a0@baylibre.com>
References: 
	<20250916-iio-adc-ad7124-remove-__ad7124_set_channel-v1-1-aa7a2cbec8a0@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-09-16 at 16:39 -0500, David Lechner wrote:
> Remove __ad7124_set_channel() wrapper function. This just added an
> unnecessary layer of indirection with an extra call to container_of().
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> Just a small cleanup while I continue to work on this driver.
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad7124.c | 11 ++---------
> =C2=A01 file changed, 2 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> index
> 910b40393f77de84afc77d406c17c6e5051a02cd..c24f3d5127cb83eeab0cf37882446fc=
99417
> 3274 100644
> --- a/drivers/iio/adc/ad7124.c
> +++ b/drivers/iio/adc/ad7124.c
> @@ -657,20 +657,13 @@ static int ad7124_prepare_read(struct ad7124_state =
*st,
> int address)
> =C2=A0	return ad7124_enable_channel(st, &st->channels[address]);
> =C2=A0}
> =C2=A0
> -static int __ad7124_set_channel(struct ad_sigma_delta *sd, unsigned int
> channel)
> -{
> -	struct ad7124_state *st =3D container_of(sd, struct ad7124_state, sd);
> -
> -	return ad7124_prepare_read(st, channel);
> -}
> -
> =C2=A0static int ad7124_set_channel(struct ad_sigma_delta *sd, unsigned i=
nt
> channel)
> =C2=A0{
> =C2=A0	struct ad7124_state *st =3D container_of(sd, struct ad7124_state, =
sd);
> =C2=A0	int ret;
> =C2=A0
> =C2=A0	mutex_lock(&st->cfgs_lock);
> -	ret =3D __ad7124_set_channel(sd, channel);
> +	ret =3D ad7124_prepare_read(st, channel);
> =C2=A0	mutex_unlock(&st->cfgs_lock);
> =C2=A0
> =C2=A0	return ret;
> @@ -965,7 +958,7 @@ static int ad7124_update_scan_mode(struct iio_dev
> *indio_dev,
> =C2=A0	for (i =3D 0; i < st->num_channels; i++) {
> =C2=A0		bit_set =3D test_bit(i, scan_mask);
> =C2=A0		if (bit_set)
> -			ret =3D __ad7124_set_channel(&st->sd, i);
> +			ret =3D ad7124_prepare_read(st, i);
> =C2=A0		else
> =C2=A0			ret =3D ad7124_spi_write_mask(st, AD7124_CHANNEL(i),
> AD7124_CHANNEL_ENABLE,
> =C2=A0						=C2=A0=C2=A0=C2=A0 0, 2);
>=20
> ---
> base-commit: df76e03e8127f756f314418d683bad24b460c61f
> change-id: 20250916-iio-adc-ad7124-remove-__ad7124_set_channel-d8e5c30ec7=
c6
>=20
> Best regards,

