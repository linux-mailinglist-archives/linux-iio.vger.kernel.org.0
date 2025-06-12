Return-Path: <linux-iio+bounces-20524-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B24FAD68CF
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 09:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 120981BC352C
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 07:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC611221268;
	Thu, 12 Jun 2025 07:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JRVa03V7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8BB220F20;
	Thu, 12 Jun 2025 07:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749712787; cv=none; b=gtfqZWUjQ15MQeEn9Ipz10ah7+UcdrCxd/qOxkLFy7GORlOQOaTE/nwRzna85fz/P1smQw52BlzCZGFETdqfaDOOeBq9de7+j0piRiTF9wjGXpQSHySLL6V4jc71rAhVvVTNJvTfWAJifWL4YIP9nX//D+cQVQogUp/lENOwKnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749712787; c=relaxed/simple;
	bh=2vB3uaZ76UmD4+u+BlBPCzWOweF29pK7hPLSmmNUsp4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BBgBWxtLlDT1Kgi1EsJo6dPzfbvGjhlKmLZ9ExS8xW/0aqhf19wN0OWT3GZew+QSOlDWRudaW6rt2dlJSVyK6LT/+kE3gKOZT2ptcWKxg452dYnGJh3NfmV4bc2DMG7CSePJLVS7Cw9KPg2k54KIlSBZUVrGJ/pqZNXPd/PUdOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JRVa03V7; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45310223677so4758615e9.0;
        Thu, 12 Jun 2025 00:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749712784; x=1750317584; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UNgeTzNuPPlWV6399sRDI4mM2DYoN3BkqAj0IL8GhPg=;
        b=JRVa03V7MZASHhyCcIPRFxa1w59p/jv0vMnNhdfyvqG/vgIgmWRjLq7up4JerBIsVD
         3OAz9rpzyvtzD83sgQj1OyN1D1Fwr4Dtce1e3FHcnTE9eUt52M3P75vWgTTBiGPkP+qB
         Bcr93PJcGZAhJWMAunGuoWXltVUxbvzlw66zXJew+jSPl4B7ugQzUPsXdTKOU90zEiGD
         UDk3268mFWDUcIGppHdPBCb0mTpZKrFiBWyK2KeiQgKjYllnUxajWQNZx2VrbROW5Dd6
         SsTmiQi5q82p5ZU6fj58e8wjZNysHE9KsBqOJVhyUPbMa54NhwaWa9HuApylXOev7+pm
         Opqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749712784; x=1750317584;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UNgeTzNuPPlWV6399sRDI4mM2DYoN3BkqAj0IL8GhPg=;
        b=hUkans1YqPiA+Tklg9G6wIHK5BU6e+Vc2Jp/cEb6/BPWbW2auM/iedLKeSgo8uSrhz
         6gtAlwWkVjtv5raT61ztmkV2xRHaZJS1+stH5XsL+0mrCl4zxrwm+MFtpDvHhcQ+H3xs
         1CJej6tb13cHUX7rACPbMLkGrmXdvSzg2fIM5FRImud61vyE9mZW88+6qSl+0OHlg8yi
         ckQiU05qB6ugLevhQEjiRJn/vC4g7JfDa+iWVfT3+c5iAclOmmT5pNEobOsxCIhgbIMj
         +xnppICufWfpIRAKrfGWg3nIQdUhBOwpVrmI0Fv0pUEsBnl6DBq95IBw7Ajv6hoUnrYD
         02rQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrAYIOY4cFyqayeAurquA03YlG4wGkc6vHDB3F2kOj4WDjCQDMiIaNpbx7+mCcdVAVaYSjSrLfdiQ=@vger.kernel.org, AJvYcCXchpQ1sPrxomvLGalBgXib7NW2GhAkEgGKFMqxSSqcL+A9+7BDSLvH2OHlwXu6rrhj8Hygq7G7ZTk6247k@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/u4tUAnVclH56LRSFgz+weFsIS5sV/BpCr0fMYvQwKGW3IpCm
	kvvDPEwPmhIO6dGq8njUAMYQWVWCyU141sQpXsGySxM4CMS7cPaq0KyU
X-Gm-Gg: ASbGnctwu+GkgoYEms9Uhpa8KFarndFfKF7+gvGlBSOcKN7YxUhL3NcMQwJHybsYsR8
	MzIXuDvfQHmlklCFEU4TthSw9DhVQLm6hah03GhUVdP1H9+/HB7sr8bi9Iibd2KLaQsJ2hyYa/a
	hBFAlFeNtIYD4ma2pd1exRilSfPLygo9uILboDRIzYTM2y7QVXAhAiSe5CCl9MSH9Qgy1XdLEsj
	J0BupG2jZg2fJn+Z3N+2/nydU/QfO4ZEl9ST4OWNRbL8aEPDa1idDFCB+1Sd/q2Okd5LPztp+i9
	IMFsCMnuIPYrMkqFxtgO9D95rOVbYF54QuW58fYpURP5JbCEd838/1gJMX1n3EqN87uQNXW5T7j
	CRPn/S/fy6/vgktdu7YYAwBCAfA+SZxzo/Yq4
X-Google-Smtp-Source: AGHT+IH/JcWlJPaQUqLWdYPKZkUPwPJlkgLNR5yKATgmWr/yuLPXR2kI6m4eDzVYNtOSsGSLwcilIg==
X-Received: by 2002:a05:6000:26cc:b0:3a4:e629:6504 with SMTP id ffacd0b85a97d-3a56130b81bmr1325247f8f.49.1749712783836;
        Thu, 12 Jun 2025 00:19:43 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a561a3cd11sm1108313f8f.59.2025.06.12.00.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 00:19:43 -0700 (PDT)
Message-ID: <028710c4e4494285bee82ae811147b03cfa612f2.camel@gmail.com>
Subject: Re: [PATCH v5 1/3] iio: accel: sca3000: replace error_ret labels by
 simple returns
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andrew Ijano <andrew.ijano@gmail.com>, jic23@kernel.org
Cc: andrew.lopes@alumni.usp.br, gustavobastos@usp.br, dlechner@baylibre.com,
  nuno.sa@analog.com, andy@kernel.org, jstephan@baylibre.com, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 12 Jun 2025 07:20:15 +0100
In-Reply-To: <20250611194648.18133-2-andrew.lopes@alumni.usp.br>
References: <20250611194648.18133-1-andrew.lopes@alumni.usp.br>
	 <20250611194648.18133-2-andrew.lopes@alumni.usp.br>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-06-11 at 16:39 -0300, Andrew Ijano wrote:
> Replace usage of error_ret labels by returning directly when handling
> errors. Cases that do a mutex unlock were not changed.
>=20
> Signed-off-by: Andrew Ijano <andrew.lopes@alumni.usp.br>
> Co-developed-by: Gustavo Bastos <gustavobastos@usp.br>
> Signed-off-by: Gustavo Bastos <gustavobastos@usp.br>
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> ---

Code looks good. But since you're doing this you could cleanup some of the =
switch()
cases. Some return in every case statement while other don't (even think I =
saw one
one place where 'return' in the end was not needed). IIRC, there's preferen=
ce for
returning in place.

- Nuno S=C3=A1

> =C2=A0drivers/iio/accel/sca3000.c | 29 +++++++++++------------------
> =C2=A01 file changed, 11 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
> index aabe4491efd7..bfa8a3f5a92f 100644
> --- a/drivers/iio/accel/sca3000.c
> +++ b/drivers/iio/accel/sca3000.c
> @@ -369,23 +369,20 @@ static int sca3000_write_ctrl_reg(struct sca3000_st=
ate *st,
> =C2=A0
> =C2=A0	ret =3D sca3000_reg_lock_on(st);
> =C2=A0	if (ret < 0)
> -		goto error_ret;
> +		return ret;
> =C2=A0	if (ret) {
> =C2=A0		ret =3D __sca3000_unlock_reg_lock(st);
> =C2=A0		if (ret)
> -			goto error_ret;
> +			return ret;
> =C2=A0	}
> =C2=A0
> =C2=A0	/* Set the control select register */
> =C2=A0	ret =3D sca3000_write_reg(st, SCA3000_REG_CTRL_SEL_ADDR, sel);
> =C2=A0	if (ret)
> -		goto error_ret;
> +		return ret;
> =C2=A0
> =C2=A0	/* Write the actual value into the register */
> -	ret =3D sca3000_write_reg(st, SCA3000_REG_CTRL_DATA_ADDR, val);
> -
> -error_ret:
> -	return ret;
> +	return sca3000_write_reg(st, SCA3000_REG_CTRL_DATA_ADDR, val);
> =C2=A0}
> =C2=A0
> =C2=A0/**
> @@ -402,22 +399,20 @@ static int sca3000_read_ctrl_reg(struct sca3000_sta=
te *st,
> =C2=A0
> =C2=A0	ret =3D sca3000_reg_lock_on(st);
> =C2=A0	if (ret < 0)
> -		goto error_ret;
> +		return ret;
> =C2=A0	if (ret) {
> =C2=A0		ret =3D __sca3000_unlock_reg_lock(st);
> =C2=A0		if (ret)
> -			goto error_ret;
> +			return ret;
> =C2=A0	}
> =C2=A0	/* Set the control select register */
> =C2=A0	ret =3D sca3000_write_reg(st, SCA3000_REG_CTRL_SEL_ADDR, ctrl_reg)=
;
> =C2=A0	if (ret)
> -		goto error_ret;
> +		return ret;
> =C2=A0	ret =3D sca3000_read_data_short(st, SCA3000_REG_CTRL_DATA_ADDR, 1)=
;
> =C2=A0	if (ret)
> -		goto error_ret;
> +		return ret;
> =C2=A0	return st->rx[0];
> -error_ret:
> -	return ret;
> =C2=A0}
> =C2=A0
> =C2=A0/**
> @@ -577,7 +572,8 @@ static inline int __sca3000_get_base_freq(struct sca3=
000_state
> *st,
> =C2=A0
> =C2=A0	ret =3D sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
> =C2=A0	if (ret)
> -		goto error_ret;
> +		return ret;
> +
> =C2=A0	switch (SCA3000_REG_MODE_MODE_MASK & st->rx[0]) {
> =C2=A0	case SCA3000_REG_MODE_MEAS_MODE_NORMAL:
> =C2=A0		*base_freq =3D info->measurement_mode_freq;
> @@ -591,7 +587,6 @@ static inline int __sca3000_get_base_freq(struct sca3=
000_state
> *st,
> =C2=A0	default:
> =C2=A0		ret =3D -EINVAL;
> =C2=A0	}
> -error_ret:
> =C2=A0	return ret;
> =C2=A0}
> =C2=A0
> @@ -834,7 +829,7 @@ static ssize_t sca3000_read_av_freq(struct device *de=
v,
> =C2=A0	val =3D st->rx[0];
> =C2=A0	mutex_unlock(&st->lock);
> =C2=A0	if (ret)
> -		goto error_ret;
> +		return ret;
> =C2=A0
> =C2=A0	switch (val & SCA3000_REG_MODE_MODE_MASK) {
> =C2=A0	case SCA3000_REG_MODE_MEAS_MODE_NORMAL:
> @@ -857,8 +852,6 @@ static ssize_t sca3000_read_av_freq(struct device *de=
v,
> =C2=A0		break;
> =C2=A0	}
> =C2=A0	return len;
> -error_ret:
> -	return ret;
> =C2=A0}
> =C2=A0
> =C2=A0/*


