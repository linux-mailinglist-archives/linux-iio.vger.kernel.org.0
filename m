Return-Path: <linux-iio+bounces-23181-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 369CAB32FEA
	for <lists+linux-iio@lfdr.de>; Sun, 24 Aug 2025 14:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FB172066D4
	for <lists+linux-iio@lfdr.de>; Sun, 24 Aug 2025 12:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFB828980A;
	Sun, 24 Aug 2025 12:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8E+MzeP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385B92B2D7;
	Sun, 24 Aug 2025 12:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756039027; cv=none; b=tiHHTOOma8dTf/15d+CO2GpaeqhOTCmdKTwpd+oSQJA55O+NCsZLhFr55IbVo2E4ihXaOB9oJ4bh3gwMOVJ/mlpKdG9u29hLjcr+bl2XE4mUPOrKJzGJqeWwTtWaTLylCbDIiFiFHSPv+Y5UCvgjf88sx9PqNy1oE78iMpXlQWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756039027; c=relaxed/simple;
	bh=UKWtuPYTxNHdFvtfzHlR5rgBM6cG3Z9Sqr1MtSciDdg=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=B1rrIu+IBm+KF4WEo1X2nqoKn4fpqyxWCxEjkE2p4yLLt2C5TzsO4ANVgGAMG3sfyYYJr8nUkp65cLAEl40Wkj9PeF0VlYTfrA5bUiq9MNB68obflVdFzbx2ZLe2RKpLP5BEfW0w6wH3FRintTqMImyXu7zE+q9Zfr8Agq1X5bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U8E+MzeP; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e93498d435cso3409729276.1;
        Sun, 24 Aug 2025 05:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756039025; x=1756643825; darn=vger.kernel.org;
        h=in-reply-to:references:to:cc:subject:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vVrYLaOumo8kIkzX/KWXeeqenR1JWl7YJ864174T5ZQ=;
        b=U8E+MzePlZyt6kR7PKyRf9EKGA5TJ/6LydP9h5uKRr28/R4teHTpPRdPGG7yRW1S96
         7E0qrXUgKgR/WVeXO4ndEW156FNCvPuAm8fVVLrBFFq7Qm9Bi9MOANSXSHquUqpLqii5
         tP71pGlNSAPzQcz1+simIz0oc0RPnqbjAg7xqAy7eV36w8fVKOiCEaCLESt2CdB0ZZEF
         2wg4iltzK7rIph/XOZE+ktT71wRUXWZt29HmTTCo1o6CjDhhF3UvDkjr8HtkB6WEWOnR
         jZDHzayood8n+HuLGZI6QKfbfctjNiwuarXmolcv7V4MDvuzhwSLNYQDjEt/86IocEBs
         CTcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756039025; x=1756643825;
        h=in-reply-to:references:to:cc:subject:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vVrYLaOumo8kIkzX/KWXeeqenR1JWl7YJ864174T5ZQ=;
        b=JHW5COTeoCfnIdbOBjBGrVjlXnPTfb31NA/JM0sbTJe50zUrpalX1KfOoDWQ5n35SD
         u8Ggm5xEMCPIfDFXO/TnnFq8CJXgZAMt7JX6MK2Kleb7VCRiXaJUG0qSF5eLduHzaw7j
         aiQET4vyfsTuniI+Cn74zNB9+8vwKGZ07dS8TwtMx6GBvapApOw1RcshbE+USDctdHXN
         lh6lcsvsSOUHmMg4zuWjAk6FfUCt2zvMYpcqkr3ZpdmVCdGLe2mMoeARIv3KlrSqgRo1
         pky/54mFuKwPhvHUVqv9sbW8JTZC4IMWMNtYV2ezWInT2VwCxrQ/q9KSNDx6RyYqfXxR
         4lPQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/i3qHHUxv97zbqBrhbSe/XLs0/v8FWrseb6kZDMhBFlLBUKyMy6/x0flmSN514EV0QDLKcHXErcA=@vger.kernel.org, AJvYcCXgPx7uyDrk77+rWgORrGloHjXk6t0F3Ia7XGHvMEVltgTT5sXiXQq7eGU7dEZXjr4AlT1jvMZjWuWumOoc@vger.kernel.org
X-Gm-Message-State: AOJu0YxN3sEQ9zJ0fWvvXNBQfko6VkNVVBqZqOLkPMk6peZijiEBJv3v
	QviR1bpffedFUSGPvmrhrxlhHeBztDf1pjsjHu2CHzmidUQAwWZ10I4H
X-Gm-Gg: ASbGnctMlTubIlnubxNWF6FznANfVBEwLECLbFSw/jEnVKb3XAUZ5nyDINsL62iwUk4
	lejDpf17Jp78otpdO5EF2488E/gKWUkPT7mRV6UPHZIpO9IVWzhKrJpcuZ7G5E+DqJTCGq2o3YX
	4OS7MgeR/NSZ/VHpVO+oiqEKq8LiFRFJFeWMWW5umSdAaasgTtFAZLmU/HDsHySZxelRKohdyqd
	kG8BPAtC7JQrnHydw1hUUrhKLNwNpKTYAa0zT+gQ2Cs/0FaO5q+uiZmgq1z9BcHsvVNfkSSyLI3
	zhS6eViOqaFTYCFhVufZbVg0fgfTFu40dPcAMCYbnfvCt7HDpYHTGsrUUO2FeGNsy/vWOrVfg7j
	AleonBBTuXNaj3701A2oPdEj0bg50
X-Google-Smtp-Source: AGHT+IHHWjC8qOT4Oi2eYAHCKIBiFYj6dF5DkKOLHX8nPNZYjrjycduDD7FWBxGdo3pOjWUbgIex5g==
X-Received: by 2002:a05:690c:a08c:20b0:71f:f359:6ca2 with SMTP id 00721157ae682-71ff3596fe7mr37428677b3.52.1756039025026;
        Sun, 24 Aug 2025 05:37:05 -0700 (PDT)
Received: from localhost ([14.1.81.27])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff18e31acsm10981137b3.67.2025.08.24.05.37.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Aug 2025 05:37:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 24 Aug 2025 20:36:58 +0800
Message-Id: <DCANVO3ZBHUN.A8E9WABNLHG4@gmail.com>
From: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
Subject: Re: [PATCH 2/2] iio: humditiy: hdc3020: fix units for thresholds
 and hysteresis
Cc: "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Chris Lesiak"
 <chris.lesiak@licorbio.com>
To: <dimitri.fedrau@liebherr.com>, "Li peiyu" <579lpy@gmail.com>, "Jonathan
 Cameron" <jic23@kernel.org>, "David Lechner" <dlechner@baylibre.com>,
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, "Dimitri Fedrau" <dima.fedrau@gmail.com>
X-Mailer: aerc 0.20.1-4-g02324e9d9cab
References: <20250821-hdc3020-units-fix-v1-0-6ab0bc353c5e@liebherr.com>
 <20250821-hdc3020-units-fix-v1-2-6ab0bc353c5e@liebherr.com>
In-Reply-To: <20250821-hdc3020-units-fix-v1-2-6ab0bc353c5e@liebherr.com>

Hello Dimitri, thank you for your patch. A few comments inline:

> From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
>
> According to the ABI the units after application of scale and offset are
> milli degree celsius for temperature thresholds and milli percent for
> relative humidity thresholds. Change scale factor to fix this issue.

I miss some explanation of what is going on (i.e. wrong) at the moment,
the scale factor that is being used and what results are being obtained.

> @@ -379,12 +379,12 @@ static int hdc3020_thresh_get_temp(u16 thresh)
>  	 * Get the temperature threshold from 9 LSBs, shift them to get
>  	 * the truncated temperature threshold representation and
>  	 * calculate the threshold according to the formula in the

Having used 65535 back then without explaining why, or at least without usi=
ng
a #define was not the best idea. It's difficult to understand why it is use=
d
without getting into details.

13107 is even less obvious. I believe you divided 65535 by 5 everywhere in =
the
code, but it's not clear why.

I'd suggest a clear definition at the beginning of the code because it
is used in different parts of the code, after having explained why it
is necessary in the commit message as I mentioned before.

> -	 * datasheet. Result is degree celsius scaled by 65535.
> +	 * datasheet. Result is degree celsius scaled by 13107.
>  	 */
>  	temp =3D FIELD_GET(HDC3020_THRESH_TEMP_MASK, thresh) <<
>  	       HDC3020_THRESH_TEMP_TRUNC_SHIFT;
> =20

Again, it's difficult to understand why everything is divided by 5.

> -	return -2949075 + (175 * temp);
> +	return -589815 + (35 * temp);
>  }
> =20
>  static int hdc3020_thresh_get_hum(u16 thresh)
> @@ -395,12 +395,12 @@ static int hdc3020_thresh_get_hum(u16 thresh)
>  	 * Get the humidity threshold from 7 MSBs, shift them to get the
>  	 * truncated humidity threshold representation and calculate the
>  	 * threshold according to the formula in the datasheet. Result is
> -	 * percent scaled by 65535.
> +	 * percent scaled by 13107.
>  	 */
>  	hum =3D FIELD_GET(HDC3020_THRESH_HUM_MASK, thresh) <<
>  	      HDC3020_THRESH_HUM_TRUNC_SHIFT;
> =20

Similarly, multiplying by 20 (100/5) looks weird for a percentage.

> -	return hum * 100;
> +	return hum * 20;
>  }

...

> @@ -630,7 +630,7 @@ static int hdc3020_read_thresh(struct iio_dev *indio_=
dev,
>  		thresh =3D hdc3020_thresh_get_temp(ret);
>  		switch (info) {
>  		case IIO_EV_INFO_VALUE:

MILLI, as suggested for [1/2]? The same would apply to the following
diffs.

> -			*val =3D thresh;
> +			*val =3D thresh * 1000;
>  			break;
>  		case IIO_EV_INFO_HYSTERESIS:
>  			ret =3D hdc3020_read_be16(data, reg_clr);
> @@ -638,18 +638,18 @@ static int hdc3020_read_thresh(struct iio_dev *indi=
o_dev,
>  				return ret;
> =20
>  			clr =3D hdc3020_thresh_get_temp(ret);

Thanks and best regards,
Javier Carrasco

