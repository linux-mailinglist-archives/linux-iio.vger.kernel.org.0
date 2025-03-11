Return-Path: <linux-iio+bounces-16726-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AA9A5BC3F
	for <lists+linux-iio@lfdr.de>; Tue, 11 Mar 2025 10:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A77D1897985
	for <lists+linux-iio@lfdr.de>; Tue, 11 Mar 2025 09:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1222622DFA5;
	Tue, 11 Mar 2025 09:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QnDg68lV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C4D226177;
	Tue, 11 Mar 2025 09:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741685196; cv=none; b=H/uJM3DYGzHi1hkGeaII+D+Fl0yASamnIqj5ilipUfbEiseaRmCygmUZsK82BHQxoksnsydeTTvenm+v5jgUDrxW9xQLnlqmCFF/E6HrDgGYiGIwBynfOHVR6XFQsl6kPBhM8xJynDB9dSKTUBrg00ZKCpUinIiJRZYNbXItBW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741685196; c=relaxed/simple;
	bh=JzE+pw9KcnwwKfRG+kKsjx4c8h7NI0VsTSrzbD3MdQc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cZNd6LW1cjzxD11lL/cXHwYoZZGPqW6LABcJDoD2wQlpR7r7O/Fup4vWKo7OzSOWFsoELIlum4WVKBCVbhUUCf2VAVhGYS3EKh/Ep5l2se2xcn60rupOiUcuMXBhz0Skw7b3l0SLl8oUlzNUMhYdijMmNNuv071HVLE5m2IWSFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QnDg68lV; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-39149bccb69so1727974f8f.2;
        Tue, 11 Mar 2025 02:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741685192; x=1742289992; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mM2bMP6Sh4BYgktDGRk6I6pi4Md6xJTy2TsP3/Evhw0=;
        b=QnDg68lVpwx9RrxAqRL/qUOVIADeeZqjwK39mrAigFYL28FhC0bz1B9F+0mG7+rhUh
         /ZD6hiIUEp9aLFLTciR8RLC44MUxN6/rhFaTlETgz+C0pwQ4AaHeSgS+SWR+DAAx6g8N
         3Pgf5Pk10EkQ8nAqWMyGX9H9rTYh1fbDQTMfqieECSGU+BHVovWcZIKhthyrLaQrbXc9
         lBwF9aEb3GJeGxuxDqJ1s5l4+nZYo6t8wUcbmV7CaLhnPOW1uXWw+AJkjsW79MzHWH0U
         ixTTL2F4vgYgx20uyZVlqem81GlZr+6C+3lkzfjuoSQ4lFVc55Ssxdf640fg1NujZUAo
         JWcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741685192; x=1742289992;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mM2bMP6Sh4BYgktDGRk6I6pi4Md6xJTy2TsP3/Evhw0=;
        b=KtRioUahcRcKNnS4xD0H9DW/UagOWR5ySkyTATv6uypY8NVe+RQ7gEf1KARR/hfhZ8
         Y5MXNEk2E5cXt7eydMvNHOX9D0pUW2UzPAIDTcen6pA1oM6WUvD0lAH5FpFWMrwinwBh
         KnPGmUMs5vh+VJr53meyT8tfHOWxeC7qJNcTZLpyFNs9B8pQir/WzaVZjp10RUBUSvl8
         HLmzv4qqaJGct4yC+d+qVJT6pBbaga/QvBU7vCp17NQ/oQsn54QbfvAuYEyZhZ3U2y4t
         zUEhnGXwsEI8Nf7NtheEcGzrECIOOtbwNslpTFqrfLY0apHSg+3E/4GBbowPS/RADrHC
         oGXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhUQDquKCpc6qnM04KMPF2CQjMdiA9NjE4VO/9CBmpMovkLLnnsaa8umruCN3VED/kqcoVBHN3e1WwrKY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqt5+r120h5BnLdZEiWCeh41StH1ELajoXMr64HNqEAKfXZl2Z
	JW1GBa+UQ/slSvutMOftSuSx/x+RvRFgj20IKVso7vtmAXSQ4nqRXVGEg0wf0mk=
X-Gm-Gg: ASbGncv0Nx6w3DNiv3rad7V9KPq67TNBbAUS59MWozWE/9Upo1ZQXrh844zSCGZ09ki
	yBY7YYl7jhRkJe8MKxJMOi5AFXwKD/H29CP7kTSTieUEVnyR8w+RcaJmZDO3WniSiLUGq2Mjw9a
	qT47ctP8QluRENsWuLcVojsPPttcpw2EZdQqA1LkGu/IZhFspJk4mOjTtuFbU4IVA+lCcPv/Rc6
	Jv4CDq/Vwso9IgEMfdUqlYw+azni5qb68wfKNHlA2P67szpaiyW1TyHPvyuTiVzFud0UtuRKEY9
	AtbM9cKorydNyesWIi61BtRI6CYV0w8kH7sWkrI7X1+91rbVWIZpzGwVsbMXdqR1/Zy40lOViJF
	WDmeM6ocPA1RarP37
X-Google-Smtp-Source: AGHT+IHj4+RWo70ASRymJlXUKimHweKCVLEzPvkQSKNrzM+rONmsDi8jzwmXafWIYZ4JwlJPUDkZHg==
X-Received: by 2002:a5d:5f94:0:b0:38f:4d20:4a17 with SMTP id ffacd0b85a97d-392641bcf76mr4072827f8f.13.1741685192146;
        Tue, 11 Mar 2025 02:26:32 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfdfdb9sm17390934f8f.27.2025.03.11.02.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 02:26:31 -0700 (PDT)
Message-ID: <8b006f8f2a445215365c9aca02b88cd4f2829918.camel@gmail.com>
Subject: Re: [PATCH 1/5] iio: adc: ad4030: check scan_type for error
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>,  Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Esteban Blanc	
 <eblanc@baylibre.com>, Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, kernel test
 robot	 <lkp@intel.com>, Dan Carpenter <dan.carpenter@linaro.org>
Date: Tue, 11 Mar 2025 09:26:37 +0000
In-Reply-To: <20250310-iio-adc-ad4030-check-scan-type-err-v1-1-589e4ebd9711@baylibre.com>
References: 
	<20250310-iio-adc-ad4030-check-scan-type-err-v1-0-589e4ebd9711@baylibre.com>
	 <20250310-iio-adc-ad4030-check-scan-type-err-v1-1-589e4ebd9711@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-03-10 at 15:43 -0500, David Lechner wrote:
> Check scan_type for error ad4030_get_chan_scale(). Currently, this
> should never fail, but it is good practice to always check for errors
> in case of future changes.
>=20
> Calling iio_get_current_scan_type() is moved out of the if statement
> also to avoid potential issues with future changes instead of assuming
> that the non-differential case does not use extended scan_type.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202503040954.n6MhjSsV-lkp@intel.com/
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad4030.c | 8 +++++---
> =C2=A01 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
> index
> 9a020680885d93f4da8922e5cfeecc0c7ce23f4d..af7a817e8273496e8856a5ba1a9c2e6=
6a11f
> 0a84 100644
> --- a/drivers/iio/adc/ad4030.c
> +++ b/drivers/iio/adc/ad4030.c
> @@ -390,16 +390,18 @@ static int ad4030_get_chan_scale(struct iio_dev
> *indio_dev,
> =C2=A0	struct ad4030_state *st =3D iio_priv(indio_dev);
> =C2=A0	const struct iio_scan_type *scan_type;
> =C2=A0
> +	scan_type =3D iio_get_current_scan_type(indio_dev, st->chip->channels);
> +	if (IS_ERR(scan_type))
> +		return PTR_ERR(scan_type);
> +
> =C2=A0	if (chan->differential) {
> -		scan_type =3D iio_get_current_scan_type(indio_dev,
> -						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st->chip->channels);
> =C2=A0		*val =3D (st->vref_uv * 2) / MILLI;
> =C2=A0		*val2 =3D scan_type->realbits;
> =C2=A0		return IIO_VAL_FRACTIONAL_LOG2;
> =C2=A0	}
> =C2=A0
> =C2=A0	*val =3D st->vref_uv / MILLI;
> -	*val2 =3D chan->scan_type.realbits;
> +	*val2 =3D scan_type->realbits;
> =C2=A0	return IIO_VAL_FRACTIONAL_LOG2;
> =C2=A0}
> =C2=A0
>=20


