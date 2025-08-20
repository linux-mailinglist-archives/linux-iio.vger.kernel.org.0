Return-Path: <linux-iio+bounces-23037-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 201EBB2D9C7
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 12:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE3B8165DC1
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 10:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C7D2E0B69;
	Wed, 20 Aug 2025 10:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5H0RPWn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E932D9EC8;
	Wed, 20 Aug 2025 10:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755684617; cv=none; b=rmIs+JropqKZjds/UpbKm7Y/35lAHf8KezD5mVVuGE4EZU/Y+1B4MGbJJY/qP7VYREF+8YRbDYrnAlnEyB6D0C1acZLhQzPGHhuaxQq4/yLS7+kGQ3VMprSDAAaRdVzgvRuJC5YpGMh8s95/IZkF1VeXez3imXOHV6EULVPzoEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755684617; c=relaxed/simple;
	bh=60GfjVXbry9G+w/OHLkAHNioFNEkyl7GB+4Ycj8rjoY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sZTT9UdWugtMbYwOowpRUYQoL88npHJtzIcs0L+HQWaLLKBa2IuhZsreX9C3oKaflK0pQwbNBIl8hO2GBd8tsWtirJbDcgGr8iHv1rnc1hUEdSKEGeYrbu/dnS+6n3SGPlLKIxTt+fnjJ8GwM3CgWmNcYZJq6FLEtZcUhxabROc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F5H0RPWn; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-afcb7ace3baso1074312566b.3;
        Wed, 20 Aug 2025 03:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755684614; x=1756289414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qr3cQzhEbQuCji4gAWpx2C5/wGxbJlr8wYKGSv1o+4E=;
        b=F5H0RPWnsvKDktkZqgGDvfbeBdURqhbclCUmD4T1Iz7zi7ZFI8GfffVlSNCn6ZLR2D
         X6L2fymZC2etDHDN6u3FcvOPnHoLz7wt5O438N9Du8HjvTremWyg5AoIY0E6Fjdwx0o/
         StvwwUdB8LYz7m9SoA0dfpZvZ6zSMIM+NNXuZWTKaEW0TPN5k5PP6Vp1ZWsrgvFE2A1M
         N5G/5WSfNGG7fRfWbtN0hV4AP50azvV3nCWZGRIreRh/G/hOb7g4BmuwsMLLC/KBWETu
         3TYxPJVKufBO+mNBLYPVu9+nVLpZ6uoCblKIslCV6/Q9yZ7EWGv4R8fA9ccwymkV1Tjd
         Puzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755684614; x=1756289414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qr3cQzhEbQuCji4gAWpx2C5/wGxbJlr8wYKGSv1o+4E=;
        b=Va2r5ympjf3xODoT2sTp/o9kiPQnxiMvBvU8Y/rjfKkY8G04WVzNMWfChJYIvvzl2l
         fcfrJ0pRzSl+CfdwWndm/cj4tbGZQmDrHmZvvuKcCk5kIDcRFEGOJuTLkmaaPMtMONVs
         dzBKKaTsjyYXuO0syvq033Wa83Ud1v30x7Kx7wxYmnKShd5cV0E5XabRmIqr0FyLdB0s
         jBHogYSE3UlcBVr0uQbbN5x+j8XkKIe54NNYrbgviCTAf2kE61AG86QyXr+U36wzKQPo
         eMcajt9ivz3yyH6kGWAIvbrdIrQy8+rltI+aIzaeN1tpajTWzE1JONCKx8jTxWKB6J69
         5FnA==
X-Forwarded-Encrypted: i=1; AJvYcCVA7DoHuuVY4yAKHlZWE+yC2tZJ8TRb1E1/hcLy8bNQ+TxPZpjXTTDBUnH/1xjaWrkCndFqjbWaOKwN@vger.kernel.org, AJvYcCWHEC/b2jA4owbL6szYzQgC0NXRJsZj2SyhHQjBYvob8gUmAeI+OrLuVCklEVWM4nDcl9I28omJVdsSrN4g@vger.kernel.org, AJvYcCXepgDfgaCYwXerCgKt5nq08Wu9h9+JuJ67LLxPKA2QTvPKOu/48kbsnW2vSru3RZpjY/8aGsWxHbDh@vger.kernel.org
X-Gm-Message-State: AOJu0YycNnVaIn0ilP0k/fkHNt76WX8CUr7U7Q/xb7vLL9lnkkM5DHTf
	6U04LQ8i6ZAFavEc+hWI+Fe7toe9wNoA7tYd6q057YTtUIn3UizXdMGAHn/27CkS7kbigMTAQ3H
	5EXrFiGwJtk6iTR3ZODg1+nAwk7xY4LE=
X-Gm-Gg: ASbGncuAAcEhfb/L5uIu3Ghvy+l8xqCbhV/v6lUTapT+xLeZ/ujeHTDFhqHJobr72PM
	bzjZWeqXSkzMZn8V5s4yHkSTEKhS3h9SQkY33UopTO4pICQYeLn97dmou4GvqQjaiDenJktgvjM
	vgVYbmyqDR9aqoc0fEV4kGxTPSXtaDDS3Y/IeOWJM5gOZ2AUZVqwWrbZ+SiL2jZm6JrMzG4oeZc
	CiCQgphetBwGloLuaHn
X-Google-Smtp-Source: AGHT+IGUDeay0CHadV0kDasR5/URUsLzjs3fmO8xfoV974vBOyXjgOwrOobdN2ZV6BW8B7jc4KHR7n5rOwAj7AoLzbI=
X-Received: by 2002:a17:906:dc8f:b0:af9:6e4a:3b55 with SMTP id
 a640c23a62f3a-afdf01d1cf1mr187516666b.40.1755684614205; Wed, 20 Aug 2025
 03:10:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819-upstream-changes-v7-0-88a33aa78f6a@watter.com> <20250819-upstream-changes-v7-5-88a33aa78f6a@watter.com>
In-Reply-To: <20250819-upstream-changes-v7-5-88a33aa78f6a@watter.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 20 Aug 2025 13:09:37 +0300
X-Gm-Features: Ac12FXwGD-Ms_xqdRj3SNO41-1EuHkSMk4JDYqYE8OgoC9syVbvADiz5cuDJ8MI
Message-ID: <CAHp75Ve2RigBHxn9s=MCY0zE66-vUhJtaixi3kSqYmKp7KR6eg@mail.gmail.com>
Subject: Re: [PATCH v7 5/5] iio: mcp9600: Add support for thermocouple-type
To: Ben Collins <bcollins@watter.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andrew Hepp <andrew.hepp@ahepp.dev>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 2:45=E2=80=AFAM Ben Collins <bcollins@watter.com> w=
rote:
>
> dt-bindings documentation for this driver claims to support
> thermocouple-type, but the driver does not actually make use of
> the property.
>
> Implement usage of the property to configure the chip for the
> selected thermocouple-type.

...

> +       /* Accept type from dt with default of Type-K. */
> +       data->thermocouple_type =3D THERMOCOUPLE_TYPE_K;
> +       ret =3D device_property_read_u32(&client->dev, "thermocouple-type=
",
> +                                      &data->thermocouple_type);
> +       if (ret < 0 && ret !=3D -EINVAL)

' < 0' part is redundant.

> +               return dev_err_probe(&client->dev, ret,
> +                                    "Error reading thermocouple-type pro=
perty\n");
> +
> +       if (data->thermocouple_type >=3D ARRAY_SIZE(mcp9600_type_map))
> +               return dev_err_probe(&client->dev, -EINVAL,
> +                                    "Invalid thermocouple-type property =
%u.\n",
> +                                    data->thermocouple_type);

...

> +       /* Set initial config. */
> +       ret =3D mcp9600_config(data);
> +       if (ret < 0)

Maybe here as well, but I haven't checked the actual code of the callee.

> +               return ret;


--=20
With Best Regards,
Andy Shevchenko

