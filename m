Return-Path: <linux-iio+bounces-21473-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D94AFE41F
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jul 2025 11:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CFA51C4381F
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jul 2025 09:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADBF2857F8;
	Wed,  9 Jul 2025 09:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VA4OeVmH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5139126B752;
	Wed,  9 Jul 2025 09:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752053604; cv=none; b=Ek4GjZolQpCrLRwgkh8VpGQ0JirwVKQKbYiAcCcVBdETy37qzrbCTIW3XgqExcmSUI+aqY1KP6zwfRsP9J1NFIjY+7qOmlrDyn+LOfdCxU6C4dBrg170L8mtlcZ931UxGr42qJbz0jEUwfuN8kT6wEL7cAMw5xOsP5zr8HoeQBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752053604; c=relaxed/simple;
	bh=MIQp0OpgiTSr6aANGpONpxKgKSkzv3sJQ+ecTn99yew=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EZ3mOSYR+WhKqc7QX5fHMaav+QeAsO1ENO5vbLkauQh+5c0zC5ktRDG30f53rXNUAIE5BxQkM9PPNm9ySnvHy5zslNhmYaynaJ9YhHRT2FPFFS8t5x12jJa6tk9NiMC5r3+KW03NSgVfqwQkz0ZCdDWT/4gu3HJ3gGRDJrabYkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VA4OeVmH; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-453608ed113so58267715e9.0;
        Wed, 09 Jul 2025 02:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752053600; x=1752658400; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zyBNauItX86u17MOdnDoK+WHQ8rAHDVjYuFkMuD0ey0=;
        b=VA4OeVmHEnQHYQfNsFnNRoHYYILN25gk7cDUH5PfKehoUJk42yuBpd7DbVr+SV/DKU
         1+zG5UJo1WfagDNVa26ETS9drm1RzTKHciUJSXXTrzoh9bLnB0LYXtE2SutBQYFxalKu
         4kQylLFvYJguqVU0MTRsSJDtSHi5D1LV8HJyQo+Oj2qm8pb4VyaBWImIayWKYRuY9u9U
         Jd1JCsTr2h9/QXDMG5rdTSxsnIPViQ8K2i88nulWNUyJbit4VlKvO/jkFg9UaBPQDlcO
         hcouCA0jZYbLW4ZY+vcUtyUHaXdpnfCrTcjU8CK3Bm3stKTEDU97I2McI6Tjv2Fp2z56
         2DBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752053600; x=1752658400;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zyBNauItX86u17MOdnDoK+WHQ8rAHDVjYuFkMuD0ey0=;
        b=VhI1fXXfh2ozkgePfh4w1a76CM7z3couife77mmoseMltaOJYFEHcDjldfRNssd0iy
         2u04sYdi236lUDOPHBxk9AxbwPIDWQzpRIgxnOKa6EytmSoOnbWsjSJEu7TgFxMWjhwx
         KRH1GJY99543cRRNNJwMzejTUrtqfkVbGk7R99vk5oDxN17A1d7L5FDVkIl+MOS62k+X
         nWycUTlcKBnKinVg2V+PgSWFKEyg+InKvbrNJtZMD7DVFloBUT0hRSPq9oGm3iqWcOTS
         k7o8ku9PVurEgrOcdE+a2MhNZu+bgrfStn6FWCo0CivXYPVhYxxOI1Ag9XiIMvtbtb3V
         hSiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxH51wN3E8XwgvpIAifDba2Dw7E+LvO3UiWFhpoZSLxSyu1adBVLaa07meIq1wBg9CYVHBvcQCPF8=@vger.kernel.org, AJvYcCV+xCmAeRaq4t90ZjwtEPdZUPZaZbq68r/hCrB863YMGjiZQCbCC81eCsE/G+gKX0jxRNA0xhDkGCqi8rMu@vger.kernel.org
X-Gm-Message-State: AOJu0YzE2NM3sfy2aJfF4Zhox1Ivf900iDfZlinaXKVX+TxZ3Qpj5eAv
	C1A7rm4T9r14k9JC+014uZcTlzpipyGKWND27FxC1YgA6nlEou7oxBu1
X-Gm-Gg: ASbGncs16BCvMb25LYJ4gNu1pJV0OL2Lbo0GzBc4HvcV8lvXD+yX5984NG0yYiwN91R
	u4RXVr026/cAhwKDNVnJq7bKW/jfm9tRP91tIclbLyny5fwIVaKWubWJeZ7Pu/uLCJNNXgtRLlR
	eApscVp5Wa93zP8LCGHmMPOSiXtDhG4fpIuHIOaf3Gn9YGW3ez9c2dpz5LdHKkwcQOw8RaKJ8h2
	aaRF+5d6iFFMzZLVZrkVyNRWyi0XeRxOq3AFiimEsv2+XZwU92APw+STRysgjlTy5dudn09yDsd
	Jwvrpd1EwEWnPhnGgn4S2H/Qjbvdc/j26h/2zx6ZFhPlL16QCW/bE30btmC2T5D+pGCwzA==
X-Google-Smtp-Source: AGHT+IGw8fIhaNXig7GqYOR+yh7Pbg1Y3vuenLEp5xXZL2PqjJMbaJww4CMWrhiDzVKXHa07kEM47A==
X-Received: by 2002:a05:6000:40dc:b0:3a4:e75f:53f5 with SMTP id ffacd0b85a97d-3b5e452620bmr1397663f8f.35.1752053600292;
        Wed, 09 Jul 2025 02:33:20 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47225a4e1sm15272987f8f.74.2025.07.09.02.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 02:33:19 -0700 (PDT)
Message-ID: <75b46712867097cbe7a4e7bf070730d5c524149f.camel@gmail.com>
Subject: Re: [PATCH] iio: adc: ad7313: fix calibration channel
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Michael Hennerich
	 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Nuno
 =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Guillaume Ranquet
	 <granquet@baylibre.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Wed, 09 Jul 2025 10:33:32 +0100
In-Reply-To: <20250708-iio-adc-ad7313-fix-calibration-channel-v1-1-e6174e2c7cbf@baylibre.com>
References: 
	<20250708-iio-adc-ad7313-fix-calibration-channel-v1-1-e6174e2c7cbf@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-07-08 at 20:38 -0500, David Lechner wrote:
> Fix the channel index values passed to ad_sd_calibrate() in
> ad7173_calibrate_all().
>=20
> ad7173_calibrate_all() expects these values to be that of the CHANNELx
> register assigned to the channel, not the datasheet INPUTx number of the
> channel. The incorrect values were causing register writes to fail for
> some channels because they set the WEN bit that must always be 0 for
> register access and set the R/W bit to read instead of write. For other
> channels, the channel number was just wrong because the CHANNELx
> registers are generally assigned in reverse order and so almost never
> match the INPUTx numbers.
>=20
> Fixes: 031bdc8aee01 ("iio: adc: ad7173: add calibration support")
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad7173.c | 5 ++---
> =C2=A01 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
> index
> c41bc5b9ac597f57eea6a097cc3a118de7b42210..61749586670d4f0730ca423d6e4c0ee=
1bf19
> edfa 100644
> --- a/drivers/iio/adc/ad7173.c
> +++ b/drivers/iio/adc/ad7173.c
> @@ -392,13 +392,12 @@ static int ad7173_calibrate_all(struct ad7173_state=
 *st,
> struct iio_dev *indio_d
> =C2=A0		if (indio_dev->channels[i].type !=3D IIO_VOLTAGE)
> =C2=A0			continue;
> =C2=A0
> -		ret =3D ad_sd_calibrate(&st->sd, AD7173_MODE_CAL_INT_ZERO, st-
> >channels[i].ain);
> +		ret =3D ad_sd_calibrate(&st->sd, AD7173_MODE_CAL_INT_ZERO, i);
> =C2=A0		if (ret < 0)
> =C2=A0			return ret;
> =C2=A0
> =C2=A0		if (st->info->has_internal_fs_calibration) {
> -			ret =3D ad_sd_calibrate(&st->sd,
> AD7173_MODE_CAL_INT_FULL,
> -					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st->channels[i].ain);
> +			ret =3D ad_sd_calibrate(&st->sd,
> AD7173_MODE_CAL_INT_FULL, i);
> =C2=A0			if (ret < 0)
> =C2=A0				return ret;
> =C2=A0		}
>=20
> ---
> base-commit: 2233378a8c606f7f6893d4c16aa6eb6fea027a52
> change-id: 20250708-iio-adc-ad7313-fix-calibration-channel-198ed65d9b0a
>=20
> Best regards,

