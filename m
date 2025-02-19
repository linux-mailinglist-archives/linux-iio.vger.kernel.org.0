Return-Path: <linux-iio+bounces-15761-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E0CA3BC19
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 11:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4A36177CF9
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 10:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564BD1DE4E9;
	Wed, 19 Feb 2025 10:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KD79gmQr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460721D5142
	for <linux-iio@vger.kernel.org>; Wed, 19 Feb 2025 10:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739962449; cv=none; b=DM5saxaeGdu+KS0KlU8ET7EcUAQnnDBJJ7XMAZHibSkBotulrcH0Xye5I7mprhyyWf+0b1wsveEwLCqKFM1QW5Fd0BhGGrTpQTwz+xQ/6LFhQUxTv+eND8LiGWl+kkR0HLc3UI25LdMaGyiYrQPH2JoRsYqaBRsTuc8j4It8Zoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739962449; c=relaxed/simple;
	bh=7o5wz5p7Mh1cuV7UO/iwgrObxpr3KwPVZ7jImIgvAsY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VMOQFUz374kJDyQHe7ePYRrzZ2pLTzHo9Bk1S34Bv6LvjHrJEHBC9sTA/gV2HpIfk55ryzVD8ioIFwSmgw96YqBx3lklcM4WEEzPMNDzFdF09XL89EGQJ6RkNo6DSj3H1bEMILQJWVG/4DHWYcy0reMabSryxo1NL8iK/uGMid4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KD79gmQr; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-436ce2ab251so44980215e9.1
        for <linux-iio@vger.kernel.org>; Wed, 19 Feb 2025 02:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739962445; x=1740567245; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Gvplsj9w6gbwLVByUye3aByOuHkcrbrTcHfJ4z/7rbA=;
        b=KD79gmQr+5NwPNHdoXQExo9zUS9vaBaBH5A2SEK7oCSF4Es7CrGhA557ca4/8uxAP4
         UZrZmyIqmQ1/L8SmQQGvx14hex6V+85eWlw2CzIUUYg/bphGgPFX/+ZoAEMs8D3t7hEK
         9bHkcJDF2UrDOgHq9TNCKAQu88JZmTupUUrhOOvwGX1/5pvK5YI9R+eK/giFWwX1zcTe
         JFWkqim6rdD4NyJuNlnek3cRlgndz1tvmOjHUDz548hVqsuHiIv9fNkGQOF7ruegoAID
         Hpd8/Hrii8OKuTQIjKZ2ZYW/Cw5HYHAWvSulLY7QMFY7XnIDoIv9QWFZ+Nof5DsyJpm0
         VOHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739962445; x=1740567245;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gvplsj9w6gbwLVByUye3aByOuHkcrbrTcHfJ4z/7rbA=;
        b=xS6OIm7QF+TXFcozK04NwIXR2KSSsn2SaWWl+uIGlz7Y7150+5cfIQ9BgNedQI98YU
         F501VUsfs3sfSZaiEp+mh2pdPc/LGrHcHmqgLUOrPn69M8mV0e7imoyQccj3RRDtOKMH
         BxbypI9c7bZ9ZMNjL+OcSB7+aIgkVLKn8L0E1VTxt1bBtMx2SraepIy14gKVSkPeUU2q
         /E9IU4fUHRPF9nqlIaKLh2o+fEKyJ2NGR/vQvhbzIWK88R2v0K8ITcJTtypEYbcEiC+k
         rsax5fEzNrWu0BjeFBl2KbDaML76CvB4lS5BwadK+BDXnK3oCWaWRudyAW8uaRf2kLXd
         RP3w==
X-Forwarded-Encrypted: i=1; AJvYcCWdbGi3u0gXmOc7wStS9GaF08pUNZATWn5FlUC6qrf1ss1fwVMMhfC7ALvADcsI1sbhcjYRd4mla7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmcI5OK9D5D/uaAmNELfd8jAElbxYY/AHqw5NeCVIWXlKMLWWq
	qQnqs7Mg0C6uXee74b7NNemdnE6FVCa8NU+jT9WodqaDcGSO3O5N
X-Gm-Gg: ASbGncsr/juwQGvKdAoICJ17DECt3/QslgHSmlaRqmpdnTUW3K+UNdbyC2mYUE9bwzS
	qfnwVde0tWAmLnzc97EEkirSO6kWqQGbdKAhnHyHMcYd1ui95G2iFdly29MAYbQoWEnXMh1CwS+
	79Ps+y8ZAoYchfuUaLLM87yCU/JXVWOADJCrcELyo/SmVXuSvCbYxuc/4Y+Sw6qHd3EdJYWYIue
	McvZK0zA8tcVHUiYk0uiquyOPfnZv83mFPKifPS9eyqc8d3xB+YCp6K89qIHZESa7QEDlheNipj
	P6AxfDJ7SnpL+lhVaD/1kxiAUb6W//ZV4tobtm+flTZjKdxibBJeN/7bll/1wSI=
X-Google-Smtp-Source: AGHT+IFUY/OCgMk9WNsxTvgYLcufBK4bsDrPKFf+YaBwn3XK88JYO3grwsZlt0sp6w7ddkeyCjSvtQ==
X-Received: by 2002:a05:6000:4023:b0:38f:4f25:14a3 with SMTP id ffacd0b85a97d-38f4f251583mr7205638f8f.30.1739962445317;
        Wed, 19 Feb 2025 02:54:05 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258fc8b4sm17723678f8f.50.2025.02.19.02.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 02:54:04 -0800 (PST)
Message-ID: <d83749838aec01b2c85eb402df7e12369996ecb6.camel@gmail.com>
Subject: Re: [PATCH 09/29] iio: adc: ad4030: Switch to sparse friendly
 iio_device_claim/release_direct()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>, Olivier Moysan	
 <olivier.moysan@foss.st.com>, Mike Looijmans <mike.looijmans@topic.nl>,
 Phil Reid <preid@electromag.com.au>, Marek Vasut
 <marek.vasut+renesas@gmail.com>, Miquel Raynal	
 <miquel.raynal@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?=	 <u.kleine-koenig@baylibre.com>,
 Alisa-Dariana Roman <alisa.roman@analog.com>,  Marek Vasut <marex@denx.de>,
 Frank Li <Frank.Li@nxp.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date: Wed, 19 Feb 2025 10:54:08 +0000
In-Reply-To: <20250217141630.897334-10-jic23@kernel.org>
References: <20250217141630.897334-1-jic23@kernel.org>
	 <20250217141630.897334-10-jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-02-17 at 14:16 +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> These new functions allow sparse to find failures to release
> direct mode reducing chances of bugs over the claim_direct_mode()
> functions that are deprecated.
>=20
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad4030.c | 21 +++++++++------------
> =C2=A01 file changed, 9 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
> index ab5497c8ea1e..209cfc2e1785 100644
> --- a/drivers/iio/adc/ad4030.c
> +++ b/drivers/iio/adc/ad4030.c
> @@ -784,13 +784,12 @@ static int ad4030_read_raw(struct iio_dev *indio_de=
v,
> =C2=A0	if (info =3D=3D IIO_CHAN_INFO_SCALE)
> =C2=A0		return ad4030_get_chan_scale(indio_dev, chan, val, val2);
> =C2=A0
> -	ret =3D iio_device_claim_direct_mode(indio_dev);
> -	if (ret)
> -		return ret;
> +	if (!iio_device_claim_direct(indio_dev))
> +		return -EBUSY;
> =C2=A0
> =C2=A0	ret =3D ad4030_read_raw_dispatch(indio_dev, chan, val, val2, info)=
;
> =C2=A0
> -	iio_device_release_direct_mode(indio_dev);
> +	iio_device_release_direct(indio_dev);
> =C2=A0
> =C2=A0	return ret;
> =C2=A0}
> @@ -822,13 +821,12 @@ static int ad4030_write_raw(struct iio_dev *indio_d=
ev,
> =C2=A0{
> =C2=A0	int ret;
> =C2=A0
> -	ret =3D iio_device_claim_direct_mode(indio_dev);
> -	if (ret)
> -		return ret;
> +	if (!iio_device_claim_direct(indio_dev))
> +		return -EBUSY;
> =C2=A0
> =C2=A0	ret =3D ad4030_write_raw_dispatch(indio_dev, chan, val, val2, info=
);
> =C2=A0
> -	iio_device_release_direct_mode(indio_dev);
> +	iio_device_release_direct(indio_dev);
> =C2=A0
> =C2=A0	return ret;
> =C2=A0}
> @@ -839,16 +837,15 @@ static int ad4030_reg_access(struct iio_dev *indio_=
dev,
> unsigned int reg,
> =C2=A0	const struct ad4030_state *st =3D iio_priv(indio_dev);
> =C2=A0	int ret;
> =C2=A0
> -	ret =3D iio_device_claim_direct_mode(indio_dev);
> -	if (ret)
> -		return ret;
> +	if (!iio_device_claim_direct(indio_dev))
> +		return -EBUSY;
> =C2=A0
> =C2=A0	if (readval)
> =C2=A0		ret =3D regmap_read(st->regmap, reg, readval);
> =C2=A0	else
> =C2=A0		ret =3D regmap_write(st->regmap, reg, writeval);
> =C2=A0
> -	iio_device_release_direct_mode(indio_dev);
> +	iio_device_release_direct(indio_dev);
> =C2=A0
> =C2=A0	return ret;
> =C2=A0}


