Return-Path: <linux-iio+bounces-24088-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BDDB56844
	for <lists+linux-iio@lfdr.de>; Sun, 14 Sep 2025 14:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 135F53A8A88
	for <lists+linux-iio@lfdr.de>; Sun, 14 Sep 2025 12:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B5D258CE8;
	Sun, 14 Sep 2025 12:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvARUJB+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABE61B4141
	for <linux-iio@vger.kernel.org>; Sun, 14 Sep 2025 12:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757851509; cv=none; b=ciBIoZLd7F8rIgyT4JsfJF+li+Yu65NP22hjyerZ2yjNyzOLnTZWMVwGo4jo8xEEDxlSzR6JyCh+H6NMIe6Q3vrNViUGkz0b3iarGYnbRRd4/EgwYct8Xgcd9kVK5j4ybC3YujlepMVQFWc28A4KMSProA6I9it/8FUj7iAtfRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757851509; c=relaxed/simple;
	bh=2XEUW3sv2PyTMtUGHSUVu8YoqpR7RWEQF674FEhLsR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l7/3ci+DbkBKxNTMe2446O8TOCeq/vLMsvY5wo8iixl95RbwfvPBVsG3yK4NbrcOk3gsu+RIQhTEPROQjMKSXsylHED393XiglC1RoxcTxyYhdZ8V3IO/Wg0SpEFEATtSLldCEDkPwAItM2EM/8ZPl92g7lcV99b0ZRxSUPGfiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IvARUJB+; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b03fa5c5a89so506207166b.2
        for <linux-iio@vger.kernel.org>; Sun, 14 Sep 2025 05:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757851507; x=1758456307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fY6DSEo3jc/AJz5h4ijfNxRlC4eYjZTzab4rWN3vGwY=;
        b=IvARUJB+3LjKzMNjVqb5Qa205KJ5gvr6ef7dG7G3E0shxZKsFaeWmxGOuNyxjN8xF6
         ieFK4u2iFFWvkGgka4wwLlpp4VeD9wdyPWYyowIRAkKuZnCKL6r5o4fvMfsFfHq5xu3e
         9cQT9eJQygNT+OTQ1jPzZ3NdIfNTiQGMvSZ8tDGC8nlB3SfRPJ/INE/A9S2Zf5UgiN3Z
         UxxU+0N5AYjCEXWWkhJKQyVkeSq1Hsf4ZCSoZryl/zARi1XFYJtGwWppKt1ftjFG1AQl
         d9Z0DOYzG5cem9DAdwxCmYTitAjKiR+z5oYzvJVPwTikLh+SSrn9lUm5f0aBVzmSLQQ8
         MEfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757851507; x=1758456307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fY6DSEo3jc/AJz5h4ijfNxRlC4eYjZTzab4rWN3vGwY=;
        b=WRMyz3s+1ZR2r+QSNZRkevLmz2zzFeor1BYk2ClpeJZI1h5XzszUTlQX7ASIc3SapY
         /Oy6uKKhoRv8Bk4qOptJw7Y5WHOcuHD6xTonYWmwT+nYbYnv6YRfotJ8OwndfTuMmk11
         D90e9PfOBq+DTtapqw4ILtH28OHafrDVrYIAZdviCl/BBSF1uOqlPNjCr8cXoUJHg+EG
         zxkYmMsFakZ1mWXbbDsSNKcgm+lP2346/i4XvvhrJ3YQ3aUg8i0l74kbN1+bBAGvoLMD
         QkU6JaTbChjag4Hwd+7m1OxnVWHHxTriX8g/AhWtWw5gj3OwRWom0UuQvLQuSYle1uoV
         TANw==
X-Forwarded-Encrypted: i=1; AJvYcCUIb0dtMEr4i2p30q5OySW3dXuNwkUiatHgwzmV/gzuv8ev4/v+6uHRcfSUh2Tt8S+AOPq1sQZzBNk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh8tXwfjJ0ZEUFGYMkaFWMCH1F4lQjRcryL9F7mIEnfQ9Nyu77
	PuJpG43LY5NRCm3oefI8wZOKBKb0ofLt62OSeB1MTSWq+lSUFZspxXv7iDm1o8dVT/KyazLvX6K
	0IoFZrLzdNoLPXaCmHicOZvbhL/ezp1Q=
X-Gm-Gg: ASbGncssvJksjOipWhg4MK+G3ApZ/m4k4Vvab8UbgOylCM7o0mZ9jbOUpIrpFLuSWSt
	3u2lCFvnCRYqW9tpMYimqLFNth6tZY8F2klxgJITIyTzUeQpJAzFbuyMkk8b+pMgiGU1JlchzZ2
	cfJ4zBpAHhQ7aKLlS+dHlXdq+dpZbbJUy87+uTz7QAtOYNPpK3Kal1VWL6dpBolP9qPJpKcoy0e
	+he9w0=
X-Google-Smtp-Source: AGHT+IHsndcZySXaL6I1jcRzVrpRT63KT1X95uqVC06SA7Ggplz0Yps+bfOG8puX6cEkwkqk4cjU2eV9ySlSoHck3Gk=
X-Received: by 2002:a17:907:6e9e:b0:b04:aa9d:2240 with SMTP id
 a640c23a62f3a-b07c37dbd64mr909536866b.39.1757851506307; Sun, 14 Sep 2025
 05:05:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250913-b4-bma220_improvements-v3-0-0b97279b4e45@subdimension.ro>
 <20250913-b4-bma220_improvements-v3-6-0b97279b4e45@subdimension.ro>
In-Reply-To: <20250913-b4-bma220_improvements-v3-6-0b97279b4e45@subdimension.ro>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 14 Sep 2025 15:04:29 +0300
X-Gm-Features: Ac12FXwYsc-BkMVQQt5TjOs94PVItMr4VpPlJOUdr5AMKIOfTub8Tv9c2hIE7dI
Message-ID: <CAHp75VcQW2LLjDSL+6z-RLjoniqNL-eqLz82eBozJuG49r4kgA@mail.gmail.com>
Subject: Re: [PATCH v3 06/18] iio: accel: bma220: turn power supplies on
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 13, 2025 at 6:40=E2=80=AFPM Petre Rodan <petre.rodan@subdimensi=
on.ro> wrote:
>
> Add devm_regulator_bulk_get_enable() to device probe().

...

>  {
>         int ret;
> +       static const char * const regulator_names[] =3D { "vddd", "vddio"=
, "vdda" };
> +
> +       ret =3D devm_regulator_bulk_get_enable(&spi->dev,
> +                                            ARRAY_SIZE(regulator_names),

Adding

  struct device *dev =3D &spi->dev;

will make this line and others shorter.

> +                                            regulator_names);
> +       if (ret)
> +               return dev_err_probe(&spi->dev, ret, "Failed to get regul=
ators\n");

...

It's possible to do in a separate patch for all of the cases, though.


--=20
With Best Regards,
Andy Shevchenko

