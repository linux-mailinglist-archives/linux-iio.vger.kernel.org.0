Return-Path: <linux-iio+bounces-14505-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC36A16FBA
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jan 2025 16:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C6223A8206
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jan 2025 15:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3492A1E8855;
	Mon, 20 Jan 2025 15:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fr1wM937"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453311B4F02
	for <linux-iio@vger.kernel.org>; Mon, 20 Jan 2025 15:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737388345; cv=none; b=ddC/qs6lZ484Hp2U9GspP7lswp64pEmlWoJddRr7OnKKiIN+T/uRiDRafLFK4FLoC/KYJWdu3V+OgO6X/Am3wnS5kZItR/Faf457I5l10vgAyq49lxxX/6nqtHfs7iy4dPqw/jR/g1H0rNlaI8eipMQxroTrLIxL4LmlOCFmmOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737388345; c=relaxed/simple;
	bh=wsz8IDHsFR/fqhN9P/Ahd6NPf8QVT7UWixK+6By5kNA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R2rHF5/VMVS9QUgP7OQogpeApX6bp9aIkFEUXMmRBN+4WhX6ftmfZGyAgPyEc4JN3ZPooMuG1dPc0tBu9bKXr3KFVkK9EINo2ew2BRpFzlVgMriJ5b4tJkDFwF6br0K7Bsrfa2esswXKBRM647tOqAxeZMwMC0KHLhJvJJcPz5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fr1wM937; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4361f796586so50972015e9.3
        for <linux-iio@vger.kernel.org>; Mon, 20 Jan 2025 07:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737388341; x=1737993141; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AnNOz8juYuGT2Tqa8MEQHwOEAWblqNqvCaZBWgyLdqY=;
        b=fr1wM937AJx3B3li3KuAQgMHQlBt+N3yVZ6C1X4yQMHL92XFK+pS9aJzlaH/WiGkWs
         6FmtawxO3qrqRGVlL3HElrDkTa5C5LgG0VrPORrvWYLWsbPG0nnNNUT1qcL/YdQ6Ec/A
         YE6XJ1RXjbLZQ5afw9FDX0NbbsDjfnVXDsJz8Pa/QvbKOOa/B6JClM8SHbd6gpurJjmz
         Y2KwXAAslS9D7meAVVcZdEiW6ZKdrrLpOrchuSfyhaaerE1tz3L4+7HQObjSF5ptGSkV
         QrmqpmZdfUFk+5+ouKMQConomp3u0vHm9p2OBdHtdwzhVUQfGez9gyQppazRkoXvHecW
         PqDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737388341; x=1737993141;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AnNOz8juYuGT2Tqa8MEQHwOEAWblqNqvCaZBWgyLdqY=;
        b=RoTYENWbbIhd1ykHAusHFExJNZUNFjIfpXfPNNXGQfneGktUrl+NFdRbolj/cBXid1
         2zv1fhP0mzbAUHVnx9IfCddAlIqe+Qa9xwBv/q+jTArYyj5IWFa2o/t/jwKIj+9RXauq
         8m6XNSpFzch91lR/EfElSXKbgKzP9LJy5Dt5PBm/mVFt6TSJDeFdJEzHvm0a+6Hlhdsr
         ya0jeRarT4HIUYE0JfPM1zmh7XeFBvOuTCt8GRd62enZcC66a+yrUHSA1R7YOUBhWOEN
         5aWsH8nL5nsJ2n2XkfAo7wlqSlN69bkvaW/QTg7UaExOTuTNQtFYpxsSDJFbeveS8J1s
         Jh4A==
X-Gm-Message-State: AOJu0Yx2JyitkGc1Dcn5XSv3a3yyunFoHM8ztaUqt0LATGYE2R7/AG08
	iyX622IfcOGjkiacBuJPJA1V7EjVOiUgxIQAwr57cYhcZiXHHNHEbgY9/KUWAhY=
X-Gm-Gg: ASbGncsxEXGrpymp4oq/wNFaprSQxffaZbS0EDYQtDBH0WzisD3cGijTvqMZvPiWv3l
	hVrqmQb/NB2kK/3WItMUinPj7kGUgTvVuA9cdg5iCDP+CyXgPSe0HwcNw+XJoR2VEJrWJ4wGhs2
	5OjdmtqIWVvFEiyputEsD+CYfXv2+ny1LW8V6Cj58g2vdsQTY5yXP3FX6AooUy27SSLU7zLiq/L
	MmfHvizgAoRFShsdD78m+79ie66yQfIbA2oNDCHW6nWqNkSiDw7Ynf/Uhw0LpJ0jvTeK3xNDpEf
	WxQu0ARUwCRqdzvqRlSjHDJ1HMB1C96djSU6KlNVsQ==
X-Google-Smtp-Source: AGHT+IFy7ymbejWY6DD1vopQb3Nvd3BFbq/43xjIhtOlp5qIH3pCIrfoW5eG4IB2ZBt6kUIEkK1ycg==
X-Received: by 2002:a05:600c:4ecb:b0:434:ff45:cbbe with SMTP id 5b1f17b1804b1-438913f5c63mr131165165e9.18.1737388339724;
        Mon, 20 Jan 2025 07:52:19 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c749956fsm207578905e9.4.2025.01.20.07.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 07:52:19 -0800 (PST)
Message-ID: <dfb5c6311896c040593bafc390d72b5a0ef307d5.camel@gmail.com>
Subject: Re: [PATCH v2] iio: adc: ad7124: Micro-optimize channel disabling
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>, 
 Lars-Peter Clausen
	 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron
	 <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Date: Mon, 20 Jan 2025 15:52:20 +0000
In-Reply-To: <20250120140708.1093655-2-u.kleine-koenig@baylibre.com>
References: <20250120140708.1093655-2-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-01-20 at 15:07 +0100, Uwe Kleine-K=C3=B6nig wrote:
> The key objective in ad7124_disable_one() is clearing the
> AD7124_CHANNEL_EN_MSK bit in the channel register. However there is no
> advantage to keep the other bits in that register because when the
> channel is used next time, all fields are rewritten anyhow. So instead
> of using ad7124_spi_write_mask() (which is a register read plus a
> register write) use a simple register write clearing the complete
> register.
>=20
> Also do the same in the .disable_all() callback by using the
> .disable_one() callback there.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> Hello,
>=20
> in (implicit) v1 I only adapted ad7124_disable_one() which resulted in
> the very legitimate question why this wasn't done for .disable_all(). I
> haven't checked because I wrongly assumed that .disable_all() used
> .disable_one(). This v2 now makes the latter true and so .disable_all()
> now also benefits from the micro optimisation.
>=20
> Best regards
> Uwe
>=20
> =C2=A0drivers/iio/adc/ad7124.c | 17 +++++++++--------
> =C2=A01 file changed, 9 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> index 6ae27cdd3250..2fdeb3247952 100644
> --- a/drivers/iio/adc/ad7124.c
> +++ b/drivers/iio/adc/ad7124.c
> @@ -540,6 +540,14 @@ static int ad7124_append_status(struct ad_sigma_delt=
a
> *sd, bool append)
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> +static int ad7124_disable_one(struct ad_sigma_delta *sd, unsigned int ch=
an)
> +{
> +	struct ad7124_state *st =3D container_of(sd, struct ad7124_state, sd);
> +
> +	/* The relevant thing here is that AD7124_CHANNEL_EN_MSK is cleared.
> */
> +	return ad_sd_write_reg(&st->sd, AD7124_CHANNEL(chan), 2, 0);
> +}
> +
> =C2=A0static int ad7124_disable_all(struct ad_sigma_delta *sd)
> =C2=A0{
> =C2=A0	struct ad7124_state *st =3D container_of(sd, struct ad7124_state, =
sd);
> @@ -547,7 +555,7 @@ static int ad7124_disable_all(struct ad_sigma_delta *=
sd)
> =C2=A0	int i;
> =C2=A0
> =C2=A0	for (i =3D 0; i < st->num_channels; i++) {
> -		ret =3D ad7124_spi_write_mask(st, AD7124_CHANNEL(i),
> AD7124_CHANNEL_EN_MSK, 0, 2);
> +		ret =3D ad7124_disable_one(sd, i);
> =C2=A0		if (ret < 0)
> =C2=A0			return ret;
> =C2=A0	}
> @@ -555,13 +563,6 @@ static int ad7124_disable_all(struct ad_sigma_delta =
*sd)
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> -static int ad7124_disable_one(struct ad_sigma_delta *sd, unsigned int ch=
an)
> -{
> -	struct ad7124_state *st =3D container_of(sd, struct ad7124_state, sd);
> -
> -	return ad7124_spi_write_mask(st, AD7124_CHANNEL(chan),
> AD7124_CHANNEL_EN_MSK, 0, 2);
> -}
> -
> =C2=A0static const struct ad_sigma_delta_info ad7124_sigma_delta_info =3D=
 {
> =C2=A0	.set_channel =3D ad7124_set_channel,
> =C2=A0	.append_status =3D ad7124_append_status,
>=20
> base-commit: b323d8e7bc03d27dec646bfdccb7d1a92411f189


