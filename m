Return-Path: <linux-iio+bounces-14552-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96751A1B647
	for <lists+linux-iio@lfdr.de>; Fri, 24 Jan 2025 13:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 482403AB67D
	for <lists+linux-iio@lfdr.de>; Fri, 24 Jan 2025 12:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C60F5223;
	Fri, 24 Jan 2025 12:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FyaagRTy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA5820ED;
	Fri, 24 Jan 2025 12:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737722904; cv=none; b=Y3MfJuX0N4AQGD44IQAP6g8X42aYcOW8WfJyZ8seybaB/p/oX4+WSucR0QXOCe0CzE/79nQJisCyXUcR0MurbrMOlnwPz4Izoyrmgtmmsy1xW5BUh4iNTBEunKsqcSzHztf+mrWYbYtArzFs6SaEn0S60Lxrc4rOAMNxNr9CERk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737722904; c=relaxed/simple;
	bh=NKgevKjVWB6It2Gr7fMZpTjFLywBrGDhcuhK7moexxE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=azr6h9RVyRJi7vnpXTz6+c6VdpitQkHLMcCxudJAZDC9XgzjPR3dB2G7bsgTslsNI90OYXanGsOvyON/Vag/jZKmKHZmSZCzdwUW2mQLSh+UMTAygYsxFEPiiNrFy64/bUeRN8av8AoOaTiHUqHlK4xn6VRlQ3C2erfNTcdcciY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FyaagRTy; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4368a293339so22691025e9.3;
        Fri, 24 Jan 2025 04:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737722901; x=1738327701; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9BpZfiANeGUJE7BJzoODf3qfwwcdWrs0MeIftv1wi3o=;
        b=FyaagRTywSsjxIIUnQViVVW23azWRKRS9T8lC89vSLZ1TEwbcDy5EPUXUZqk/n25Tl
         0Yn7snQ5yO92tIEnDVlgbnQ/HCJKf1Zgu976qZD/tcOfx0aIpnZ8bMwe7+qtFRk0JlfB
         YhK4v1oKkhkuaFZhc6pwBD/97XbIcx+SKt8BoDhHyVFymeyhMhAmyR/XYHFgsMJG49O6
         5zdJDkR69V/z6JzAn+r9l0w/yZrYWYYoDiaa6kPd5vgDe6jrORviDrhBUnRLM23/msjd
         QLlArMqcR24gfOdt4hedethUnmsSZa4WVB/crRfUV3n2f566tX5gVPomyNf4OxOIyaep
         /MwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737722901; x=1738327701;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9BpZfiANeGUJE7BJzoODf3qfwwcdWrs0MeIftv1wi3o=;
        b=XI0BQhXyGcPn9JLkgO3Mo1oh0bY1jSQnv6BdK0YZIylz9Ddmsvk8FV8WHxAnGzLROL
         PYi3kkcDdEwAygD6iX6twDS8Seb+bgtONkUnGeR3tMvRjzSOtTLTUMmL4LjOT/Ew6Ni8
         HFKUMgYllrjfaGdcj6CPsNDb6Y4SzyDtCo4XY7Nc18Tm51O8l3+W4fVwMs6vOIooBUnR
         4zr78hafVUWvdMabe1ytkaVO1CIIPb2fiFPN+NO4I31ldc3NPT9Oc6jOGPiuJrsmbEni
         SJcGyOXd2E3Rnas4QHEK7tx8lGtMi2Rppy77iMmJuYk/qkf5bkw0CtKYI2WIt3zGxpM5
         mLCw==
X-Forwarded-Encrypted: i=1; AJvYcCX0pZ2fHXXnbFEGhaHsVILleBeJdQgyORTqUg6vr2pcfbEnsy2XsHfYI8U+iycJgk1uekiTa/khUJuhPdE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz77bXXJrObCXes+26wfhuIuxJDA7tJBPjUKAOM3/AL9qNp5DW/
	jjyG6Yu2hdk98Zg9gtVwWGJ3k6mgIamkGbh9n5fyo7511dtnuKuk
X-Gm-Gg: ASbGnctSEQej5ZZ6nk91/Kt6oBtCCXxpT/9W9MYXGu7EOHPucv0p9I9hOILFIvUL/bz
	KP8yN5/pM6nRQTW8HXWJ2FXOm7NoP9nEJKK8hlPyjubS3Mj/MOptIaCBoCVJLgXwbXJnz/VJb1U
	HwnCIerC++OYCT6vw9cLI658lEiiaMf6piLNaLJg+LmJsojS4oDpYInR8caDmvWv7uyBpjTeufD
	T52xOJrapRkDdDPzc4eBDG32NeWB7kQmY7tronjlPJtmORl/+AgLpaBjP1ZeT0WTmB9LnoC1psn
	hb69iCcj9XbknvDURnLppiG3uSGzEsbRIFrhY7yKNAh0l1wJdkT4
X-Google-Smtp-Source: AGHT+IGbjUTRaikreubSDA+n8nwL8UDLQvqVMwrORE1L/9nk1KX8UE4bj8aUOTGbnbe5urjLqvLokA==
X-Received: by 2002:a05:600c:6b18:b0:438:a1f4:3e9d with SMTP id 5b1f17b1804b1-438a1f43efdmr199243745e9.9.1737722900423;
        Fri, 24 Jan 2025 04:48:20 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd4900e2sm25429105e9.24.2025.01.24.04.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 04:48:20 -0800 (PST)
Message-ID: <d7aa9c53958c1e685bff9f863890bd2f0f29cad5.camel@gmail.com>
Subject: Re: [PATCH] iio: dac: ad5791: fix storage
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Michael Hennerich
	 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 24 Jan 2025 12:48:21 +0000
In-Reply-To: <20250122-iio-dac-ad5791-fix-storagebits-v1-1-53746e0f25cd@baylibre.com>
References: 
	<20250122-iio-dac-ad5791-fix-storagebits-v1-1-53746e0f25cd@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-01-22 at 17:16 -0600, David Lechner wrote:
> IIO uses "natural" alignment so storagebits should always be a power of
> 2. Change storagebits to 32 since that is the natural size to store 24
> bits of data.
>=20
> The ad5791 driver currently doesn't use this field anywhere and doesn't
> support buffered writes, so this does not change anything. We just don't
> want anyone to think that it is OK to have storagebits =3D 24 in other
> drivers.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> Since this is purely cosmetic, I didn't bother with a fixes flag.
> ---
> =C2=A0drivers/iio/dac/ad5791.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/dac/ad5791.c b/drivers/iio/dac/ad5791.c
> index
> 57374f78f6b885e1d4f2fb452ac0563b85fc222e..034228a7c059f136cdecfb4683228d0=
be4c3
> 7477 100644
> --- a/drivers/iio/dac/ad5791.c
> +++ b/drivers/iio/dac/ad5791.c
> @@ -294,7 +294,7 @@ static const struct ad5791_chip_info _name##_chip_inf=
o =3D
> {		\
> =C2=A0			.scan_type =3D {					\
> =C2=A0				.sign =3D 'u',				\
> =C2=A0				.realbits =3D (bits),			\
> -				.storagebits =3D 24,			\
> +				.storagebits =3D 32,			\
> =C2=A0				.shift =3D (_shift),			\
> =C2=A0			},						\
> =C2=A0			.ext_info =3D ad5791_ext_info,			\
>=20
> ---
> base-commit: 012b8276f08a67b9f2e2fd0f35363ae4a75e5267
> change-id: 20250122-iio-dac-ad5791-fix-storagebits-9f86efa07abb
>=20
> Best regards,


