Return-Path: <linux-iio+bounces-23283-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5BEB35679
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 10:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA5626807D1
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 08:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6716D2F49E6;
	Tue, 26 Aug 2025 08:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GpfmW+/q"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A5A284678;
	Tue, 26 Aug 2025 08:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756196050; cv=none; b=GuxzKwYqzsQUj+fnr4XAiudAdAiLWE0sT/92dDH572TB+WI5sUeBUu4DCAAXKBpRP+H8hnDFo/VFeexZcbfdrtRGLvyZ3msRcCU//iEQzHqi4m9v56d3+UFOUB03vdm7TNEh+Lwq7PmX1hzhZEjXlNprDFI01XKS9vv6UzpeuEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756196050; c=relaxed/simple;
	bh=K5a74MigWwPcCyFreDaIcqML8Y25Lv7ViHW6u82Go60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=enjz9MZaYdbhHPlpncQpNEhEza+yQoG2LIAEdhNKBN7Ozp2Gcy+TolfqnpdeRS+V9f1icLeGobKPRe7y6Z8fSWQAAZSum/4qWSsPG2L8tiTmNRlsBUdpg6EJ9ujXni3Od6IcPJ1E8BL9ZHPLjU69LVNIEjyh30t/hqD4+MPwVY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GpfmW+/q; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-afcb7347e09so907190766b.0;
        Tue, 26 Aug 2025 01:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756196047; x=1756800847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c+9cDqbe7/fXz5iaoORlIRYc1spfaZP8SiJ5AmziM+U=;
        b=GpfmW+/qzSFqjFkNptsmiUujnyioZBQuf9Uq7USMs8YpG2PsJO+e/exVFqAYYeUvvE
         blAxU7IFidEBwScvrDhFOh8PuWo0K/9mMsr2B85kga/aisxMmtW3lYy2mrSSTiPyo58U
         EMsuV3noXLrxatDrc/MLg3UVd5VQ2CPo73BO7asE4uWIVzF///+1FuoCfHH6nCqNgf++
         m/FqWvO+QJIJ15Jfp2aYmzLlVpeNK764u2LN9OgeVn+T0kDtdDHZijj3IGKj670Beq0L
         VFDCOAtLOnBFaW13/TlGuiwQP4DDKwpQGbGLpBmmhVjwAaHBVN1rvphnLzXadF1ONO81
         LxNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756196047; x=1756800847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c+9cDqbe7/fXz5iaoORlIRYc1spfaZP8SiJ5AmziM+U=;
        b=ARb3KbjdD9Q1is80k4OvfJhgSgiQarHmVkCIrML6lr33/J1khWQOyDasV5oyt5tx2L
         3KCrbRZPjXCtZhb3AITm+8Yi4m5SyJNCZIksnxOnFVgKGsY3bIhQIgtPMa3P9wAaNQ5z
         tZVy2MEYi/FyGTcoQOAJYXrfo5tTEPHIXKxZLP5Cg7R0i84R6EojCKE2vl9hlDz2ugi+
         BEF0zEVeGn28aPRRDL0aFTgb1kK1glurePmFWSKPm9DiQ8Gq3G7RMatoOhvG9rzgNWFY
         iI/IFa2fgxJp71YY2MC+WHd9ayha1n/HO1On0FmkON5NEFvfS0r5VHAigm8rC9CjCXPl
         L6IQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHkXUt+XuCbhhn6E6V2z4AogqHGBCMxTFdOKZC8fzNaePBj/TVP3OGDWmL+bF5VoAsiGOT5ofcnsY+pIhc@vger.kernel.org, AJvYcCW0aqY7uSsjPs8kn1HaV/WfikCxViHj8QSjVoz3lSE7EVQ6N5C5dEPHzsc6hdn5xYltsB0Yg2vrJ2Zj@vger.kernel.org, AJvYcCWInAE/gWtIiMJOoBIAj1jjtd0TZr5eIDSoS7+AHpCDK3d5vVCU+MbKYkuP3vd1QNm1+uD8kHjdKPil@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8dC4R7nuMZOVPi6W8G9NDH25EIMsvHS8e+sxmmIIvodWVN+ql
	6bzrk8s0Ru6Qyu7YhT2wPZkEl7VXPikjGhartrmriHISK8ZRA+U2OXmNcZ1KiBkwSbVraf1xHGx
	SVIq0jUOBq6cWUUUouJakM9YXMxwrehHpGRtBqU0=
X-Gm-Gg: ASbGncsBadU4HwApAB0Uo1/RZdQEzAUxbH5XCJ7xv++w8GX6OGjOKfAsvUFw4gHjT3x
	LuMwySywhfKgvMldppuSfvSYkSvx86OKU2XMtycdRX4u3QT+mzWN68IuYFkfqzI25dxJhfkgUDQ
	B0Kv65d47o6w7nrDrUEGZ3fTzz+qRCkfqQWVJUIPsidBeDWiAXrzvgizG2T4S7NkpJNzZI51mwW
	eL5uvg=
X-Google-Smtp-Source: AGHT+IG50ET/PhN9ukJyoZNxRs+zEBWaeQQsD1E6eaJ7b55Lbh0MZlW4U80jHXcFYMrLdpZtXZifvaaF8NUeXrUkU7Y=
X-Received: by 2002:a17:907:c487:b0:afc:aec3:7da4 with SMTP id
 a640c23a62f3a-afe2963b010mr1238928066b.58.1756196046480; Tue, 26 Aug 2025
 01:14:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825-iio-adc-ad7124-proper-clock-support-v2-0-4dcff9db6b35@baylibre.com>
 <20250825-iio-adc-ad7124-proper-clock-support-v2-4-4dcff9db6b35@baylibre.com>
In-Reply-To: <20250825-iio-adc-ad7124-proper-clock-support-v2-4-4dcff9db6b35@baylibre.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 26 Aug 2025 11:13:30 +0300
X-Gm-Features: Ac12FXzVmmj-5G2Y2-Ph7vd-m35fceWUBSLrx90B4elHQDFntoLJODJJ9ysQknQ
Message-ID: <CAHp75VeAMNp8gARndVRnh3EwrTb65MNFXL7pCThR+Ghd_+yHDw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] iio: adc: ad7124: add clock output support
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 1:55=E2=80=AFAM David Lechner <dlechner@baylibre.co=
m> wrote:
>
> Add support for the AD7124's internal clock output. If the #clock-cells
> property is present, turn on the internal clock output during probe.
>
> If both the clocks and #clock-names properties are present (not allowed
> by devicetree bindings), assume that an external clock is being used so
> that we don't accidentally have two outputs fighting each other.

...

>  static const int ad7124_master_clk_freq_hz[3] =3D {
> -       [AD7124_LOW_POWER] =3D 76800,
> -       [AD7124_MID_POWER] =3D 153600,
> -       [AD7124_FULL_POWER] =3D 614400,
> +       [AD7124_LOW_POWER] =3D AD7124_INT_CLK_HZ / 8,
> +       [AD7124_MID_POWER] =3D AD7124_INT_CLK_HZ / 4,
> +       [AD7124_FULL_POWER] =3D AD7124_INT_CLK_HZ,

Perhaps / 1 ?

>  };

...

> +               const char *name __free(kfree) =3D kasprintf(GFP_KERNEL, =
"%s-clk",
> +                       fwnode_get_name(dev_fwnode(dev)));

What's wrong with the %pfwP specifier?

> +               if (!name)
> +                       return -ENOMEM;

--=20
With Best Regards,
Andy Shevchenko

