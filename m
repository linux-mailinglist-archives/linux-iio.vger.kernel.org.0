Return-Path: <linux-iio+bounces-26737-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F69CA40F9
	for <lists+linux-iio@lfdr.de>; Thu, 04 Dec 2025 15:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 34FC03005530
	for <lists+linux-iio@lfdr.de>; Thu,  4 Dec 2025 14:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34ACC3446C2;
	Thu,  4 Dec 2025 14:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifugpqNu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A11121CFEF
	for <linux-iio@vger.kernel.org>; Thu,  4 Dec 2025 14:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764859294; cv=none; b=ZhAPQkVGY775TGBSVItXiX2BqLAR1SiXowVN5qmCntDnzVqleVnu//sG8mAT0Ptf0Gdg+CQYx1+FSLpe9AnK9h9lycKtkQ+Bk42zwUYzjWH70Pw5DcUFb8aITEhk08g7XMvVI/EuXGIL/LzETfcCy7CpngZTZcZC8ZGBfeBMDgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764859294; c=relaxed/simple;
	bh=uAbMxMyvm57aMdOKZPBzu7Mfg9sM22DttjO/XotaqdI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OLsOhmGqOgCMkg5YBokuEAr7AwcAHhGTq2v0/0CwhszjmdR9UDewg4cs3ml0NCRCbAMgntHt94qSXwE+lRro1ZuRSgTmpTbFp2XKuj5mOHfcjuwI1IE0qhYWbKw6i8dbexpPTXm1sXwGc45e/VWgCGaeIPPPX5E/NZGuavoY2+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ifugpqNu; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47798ded6fcso8297275e9.1
        for <linux-iio@vger.kernel.org>; Thu, 04 Dec 2025 06:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764859290; x=1765464090; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SYgaHNAH7r57kAaWKROJc+fUVWL2egFyf5e3gACu0+M=;
        b=ifugpqNuFKSCWISv2en0YOmvevrsf3hEInorKtqAnB++86b+K9PNbsq+TAFUnkgHfW
         Vn7ple4mKbGvXgZ3LzUPzOnTKLIkQ3IwOOZDfWzr3XMU0ZezIptEpNe+kg4jH8oyVbYg
         t0k5KUXVDPbIAeleAOIwCA/R/VCMmffd0inHruECqjsCywjwkJHhebqgkn6BxTdOicUJ
         vgcFl+i9EzCwxcg0qsGocGIDoo8olDQ/3Yt+cjwQJ1HaK046yzfOOCOUvIAjLNEHrqgK
         NpT7dkUKhKeQADu6yBob4eDsX1U65B3Bua7vZ9wSU8kFlnfNnKaWzPdZAJaFp0I/+SIN
         YaYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764859290; x=1765464090;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SYgaHNAH7r57kAaWKROJc+fUVWL2egFyf5e3gACu0+M=;
        b=dQyQ+VZnOUbLMcFh9CLBFRZQlQ/I0m8Jlx/iny1DVoH/mZCkRg4FQTByYHX2HIDfb/
         APGcggX2VDkbAX/ezpWNj2g/V/eGxhRxZuOxXHueJTDH6qiSlNs+kEH3Tk8kQTFc4dBV
         ypCObQ057mqGj4uizDoSBkCXSV+hmTusCz4ahCRu2Vi/JBpMCF4iL1cvhzabJuXuN6CM
         zBXtL8vRkXVXUGlLrNi0RpdbdZvXY2uxKgYy2Tmr6rNBESJarWDBms/8eb5A0YQmAme1
         r52h2/hc3R/sPm11s5dZTHRSGA8JT1cc/xzcQv/onH/I/YHc4au+z1SvPW2h2Me/qfWu
         EU6g==
X-Forwarded-Encrypted: i=1; AJvYcCUO8WGBjhiVWv38U31OAlSJKpP0KgKGkWANPZT/edj/+3AIo1C9PZ20ve3qBWdBBu2Hu1Mwj2Kc2zE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDU+9J/mwreOj99oZvcTSnmb8rtr3+dSl5sEAAp4sEQjCqWwmH
	2x7U1K9X4iHx/5LOFtiR+P7jhxmpYrqSpnvjJDdztuOFculMsqMIINdt
X-Gm-Gg: ASbGncvzt7zv+e2d0nS2TNldqB90Y5rvtEY2EGx4/DVxwsaBrS14wti99agBIi/FsaP
	yLbBa/DaHtpH6ow6J6DGzv+qj/XvKrLtobGob/kBQDVcoN3x/RV2Sx8E40PLtKWr0ialyNS6rI7
	gd+77+oUrX5fxQvxHeakUG/s6Kkm+ApWYne91mdgwNypoY2OLJwI5UjU0Bl1EfNpAFirD83ujAK
	h63o5r3SEf86bpRpY40uXM3DhXpEjIVVuJ9IN9Gyl8WVmn4fGmWeBlhNJAH1+18deKm8TU3wvqs
	l3IRGP5zBF9OXksrNgqaYyZwiK+ogu29hxAchemcqDm5dpdW1V0dEXz5z2aGr03RnNhu9gtnzNZ
	z1U0uNSsq2qvyEO6OXVg/aCxFofYVJNtuq0UlFS9LE0v9jfz0Ogri/hjH4bNO9+ADm0/tm9DJJP
	S4/CRL/P4WVwA7ZWcAyzI=
X-Google-Smtp-Source: AGHT+IGwPzcCScstkaW1JYgs6ST+2pHxRJAu6rrwNjx2W/K3deKlfF0F62zXGHhuoPdhomhltshf9Q==
X-Received: by 2002:a05:600c:4f54:b0:475:de14:db1e with SMTP id 5b1f17b1804b1-4792af34a2emr67754295e9.24.1764859290271;
        Thu, 04 Dec 2025 06:41:30 -0800 (PST)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4792b14ad9dsm41299175e9.12.2025.12.04.06.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 06:41:30 -0800 (PST)
Message-ID: <17ac2fa9033104c3bf9260fbecc1c9a5b42fcbba.camel@gmail.com>
Subject: Re: [PATCH RFC 6/6] iio: light: opt4060: Use cleanup.h for IIO locks
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Kurt Borja <kuurtb@gmail.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>,  Lars-Peter Clausen	 <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,  Jonathan Cameron	
 <jic23@kernel.org>, Benson Leung <bleung@chromium.org>, Antoniu Miclaus	
 <antoniu.miclaus@analog.com>, Gwendal Grignou <gwendal@chromium.org>, 
 Shrikant Raskar <raskar.shree97@gmail.com>, Per-Daniel Olsson
 <perdaniel.olsson@axis.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Guenter Roeck
	 <groeck@chromium.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	chrome-platform@lists.linux.dev
Date: Thu, 04 Dec 2025 14:42:10 +0000
In-Reply-To: <20251203-lock-impr-v1-6-b4a1fd639423@gmail.com>
References: <20251203-lock-impr-v1-0-b4a1fd639423@gmail.com>
	 <20251203-lock-impr-v1-6-b4a1fd639423@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-12-03 at 14:18 -0500, Kurt Borja wrote:
> Simplify and drop "hacky" busy-waiting code in
> opt4060_set_driver_state() by using guard().
>=20
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
> =C2=A0drivers/iio/light/opt4060.c | 52 +++++++++++++++-------------------=
-----------
> =C2=A01 file changed, 17 insertions(+), 35 deletions(-)
>=20
> diff --git a/drivers/iio/light/opt4060.c b/drivers/iio/light/opt4060.c
> index 500899d7bd62..903963606143 100644
> --- a/drivers/iio/light/opt4060.c
> +++ b/drivers/iio/light/opt4060.c
> @@ -22,6 +22,7 @@
> =C2=A0#include <linux/iio/trigger.h>
> =C2=A0#include <linux/iio/trigger_consumer.h>
> =C2=A0#include <linux/iio/triggered_buffer.h>
> +#include <linux/cleanup.h>
> =C2=A0
> =C2=A0/* OPT4060 register set */
> =C2=A0#define OPT4060_RED_MSB				0x00
> @@ -302,41 +303,22 @@ static int opt4060_set_driver_state(struct iio_dev =
*indio_dev,
> =C2=A0				=C2=A0=C2=A0=C2=A0 bool continuous_irq)
> =C2=A0{
> =C2=A0	struct opt4060_chip *chip =3D iio_priv(indio_dev);
> -	int ret =3D 0;
> -any_mode_retry:
> -	if (!iio_device_claim_buffer(indio_dev)) {
> -		/*
> -		 * This one is a *bit* hacky. If we cannot claim buffer mode,
> -		 * then try direct mode so that we make sure things cannot
> -		 * concurrently change. And we just keep trying until we get one
> -		 * of the modes...
> -		 */
> -		if (!iio_device_claim_direct(indio_dev))
> -			goto any_mode_retry;
> -		/*
> -		 * This path means that we managed to claim direct mode. In
> -		 * this case the buffer isn't enabled and it's okay to leave
> -		 * continuous mode for sampling and/or irq.
> -		 */
> -		ret =3D opt4060_set_state_common(chip, continuous_sampling,
> -					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continuous_irq);
> -		iio_device_release_direct(indio_dev);
> -		return ret;
> -	} else {
> -		/*
> -		 * This path means that we managed to claim buffer mode. In
> -		 * this case the buffer is enabled and irq and sampling must go
> -		 * to or remain continuous, but only if the trigger is from this
> -		 * device.
> -		 */
> -		if (!iio_trigger_validate_own_device(indio_dev->trig, indio_dev))
> -			ret =3D opt4060_set_state_common(chip, true, true);
> -		else
> -			ret =3D opt4060_set_state_common(chip, continuous_sampling,
> -						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continuous_irq);
> -		iio_device_release_buffer(indio_dev);
> -	}
> -	return ret;
> +
> +	guard(iio_device_claim)(indio_dev);
> +
> +	/*
> +	 * If we manage to claim buffer mode and we are using our own trigger,
> +	 * IRQ and sampling must go to or remain continuous.
> +	 */
> +	if (iio_buffer_enabled(indio_dev) && iio_trigger_using_own(indio_dev))
> +		return opt4060_set_state_common(chip, true, true);
> +

I think that if we are open coding lock(mlock) plus iio_buffer_enabled, the=
n
iio_device_claim kind of loses it's real meaning. To me

guard(iio_device_claim)(indio_dev);

it's basically iio_dev_lock

- Nuno S=C3=A1

> +	/*
> +	 * This path means that we managed to claim direct mode. In this case
> +	 * the buffer isn't enabled and it's okay to leave continuous mode for
> +	 * sampling and/or irq.
> +	 */
> +	return opt4060_set_state_common(chip, continuous_sampling, continuous_i=
rq);
> =C2=A0}
> =C2=A0
> =C2=A0/*

