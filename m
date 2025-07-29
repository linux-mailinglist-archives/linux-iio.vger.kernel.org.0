Return-Path: <linux-iio+bounces-22125-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E1AB14962
	for <lists+linux-iio@lfdr.de>; Tue, 29 Jul 2025 09:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4037B18A09D7
	for <lists+linux-iio@lfdr.de>; Tue, 29 Jul 2025 07:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4218A26A1AA;
	Tue, 29 Jul 2025 07:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+/SCYTC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40076246BDE;
	Tue, 29 Jul 2025 07:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753775426; cv=none; b=rEENDb+L6dbW2PROfJy9+4e4CSvLs45RLREf9sEDR9jifK9O2BaAs+hHk3P8HNEj3s64dxTLplfF32DkPrdnYw85k/dzQYhbC60Vx1dxvlrLSnFJ7x2itJ9/u4nYhpYqJuzDULpv/niJpPKQpjbdXqdSUtsL0LBTHMfrKfHjWa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753775426; c=relaxed/simple;
	bh=CQl8LE8k+1s7Eg5bM1UKtsJ+iIs1rvwCqfLfLIPptGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CuI6O792cjfc53t3yPoknXNQe7HmjjWJApzUrO3Pt6Int5udqegJibLKYwKIENFYWmQoapOSqOh6+tjRQdXG3rcYCmqYb+pBLgFrF9V6+nSAdVqL6SuetyWwUvR52FkFcCIVEphmrMlfrMxspBzpvvgryR32Kmi3kl7hBIlQMKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+/SCYTC; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ae0d758c3a2so869157266b.2;
        Tue, 29 Jul 2025 00:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753775422; x=1754380222; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J2nY/YyGeNEbnKCTGYkjHDIFCHZRSI0DGKQEZxmy2WM=;
        b=g+/SCYTCzYibO+ASrc1vclArICbe/r2xpLsjG0KrCUaImuH3YzqDuRGjD1jxT2YEFT
         +zbkr5Hhfevf6HMHj3wT0ZX1bKceg50la4MluYCkBcDbXVmt4+mGvhLzr2IWXEXV3iF3
         Ina+TaLVQrXE2pITTZG2cQzORGaCO+BGHcOXR7NposKJrtzV5n0P/R5+I5X1/ttl1YKC
         9OPI6/AGXcyoOj12sYMx8tP01rbcQ2csyBQvBV8sRjYd6t15kX3XxB33jS0FSXl+wcgz
         esYWsvGdzCWKz7seUdGJ9pOa60cyWDwhzjp5ED9aO3j2ATpFjAnvo3GZfboU4gy+0HNK
         dnCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753775422; x=1754380222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J2nY/YyGeNEbnKCTGYkjHDIFCHZRSI0DGKQEZxmy2WM=;
        b=LjwlJxB7UMc7Mqa/P1599V/VV53muVFPRhl+KNFtbOX6vhstt9qGAfbcKSsXObczzl
         Xul2iZ0AoVzcr1cisK+zdmoqYEvxsfcfypdy1H4/XbOi1oJ32ttNBtA486FgZsd7h1SD
         SksKaWRJTCanGJWi+vTlaFFpk9uXXcMmZURHCzcRcw8eHSvL1PZtNEKAWQqi06mIFfdr
         0fU0v06muTmiJztlyKsIs0hSBzzoGFp2xqzYVsSXWae7YyCmydEDmFcHP6o/bhWwLyUn
         ILzpmYk20RyzsjOwv4Oi/TOtyk+B9VuOuaCqt9D6N4IkvV8L1Ngf7WlcyavUGjkL/JGv
         QliA==
X-Forwarded-Encrypted: i=1; AJvYcCUEk9KcuFrw9WUi0O/8QvP85Mkn/2hHdfg9Ot3c55jZIOdVZ27HanYEUk9kBeIUMHDSyAfxkOb1m7sf@vger.kernel.org, AJvYcCUZjjovyUUq1nCVcFYhir77FlC1rwYtEwI/lt56rW2wcQHMA6OKBsIewsX5ynzWeMeQkAMuzNedA3zJCyra@vger.kernel.org, AJvYcCVI+3yEi0QYkHauFvKoU76KqMvSzbaLeuTvQg9++hY2xP4gjBhQhN+exCPSoFwqMNmekOO2plIil2PK@vger.kernel.org
X-Gm-Message-State: AOJu0YxGFmSSLJW5+M0UjpOftqcEbto/sCOr4UamgdV5tGgXxIbLkdPE
	Pg8MMuKO/rwHQzVGmPYwYBbEC4KdDB1vX4/p3gqJVbjABcnQM3N/K361wcp6Xt2n5q6GEUx0aFJ
	LxVXpl0iEVkkeV2fHw4oulQYD1Oh/oysG42YDDDyeOw==
X-Gm-Gg: ASbGncs8SN4UGj6SXBLmFCFTqfK3/cKwQ+8/K4FDVfoPPfYCCOj/UVEx33rZhfE3SmQ
	w8ACtI6MLKC5jZF3xSnSCdDQd1jVtirgWT9+79FZjlfczxhaZ+pHu3AN+NoWTGFC15b4GbjBYAm
	h9CGQto4lc4q5n1XLqPBBpcmbszLov1AIFxDcaZNaGEzNIwfLB30LsxiOe6MHPN9wMwS0Jkbj82
	48LUYgwqSSkmwAfrLzE
X-Google-Smtp-Source: AGHT+IHVPk71QMTo4e6QHVVCfKybd5aV+PwQ9jyHs2FMw1sQjYgz58n+0UzqcRBuq9NtNO+Nzy6lskNswg4vO625AqU=
X-Received: by 2002:a17:907:7245:b0:ae3:6d27:5246 with SMTP id
 a640c23a62f3a-af619c0d676mr1677656766b.48.1753775422338; Tue, 29 Jul 2025
 00:50:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250726-tlv493d-sensor-v6_16-rc5-v1-0-deac027e6f32@gmail.com>
 <20250726-tlv493d-sensor-v6_16-rc5-v1-1-deac027e6f32@gmail.com>
 <141967ee-22f4-4b15-a8da-e8cef25828b4@baylibre.com> <aIg_SClXq0pO69iH@dixit>
In-Reply-To: <aIg_SClXq0pO69iH@dixit>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 29 Jul 2025 09:49:45 +0200
X-Gm-Features: Ac12FXxSD3PkDtLt2p5OvZu4apDEYIKrXmJ20tEHXkOFCwp6KsHRgzKY6jCUGE8
Message-ID: <CAHp75Vf8nj7xg5xadCTXQhaXzaCL0y5T5qsUHK_dcoQ3hozDXw@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: magnetometer: add support for Infineon TLV493D
 3D Magentic sensor
To: Dixit Parmar <dixitparmar19@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 5:26=E2=80=AFAM Dixit Parmar <dixitparmar19@gmail.c=
om> wrote:
> On Sat, Jul 26, 2025 at 03:44:03PM -0500, David Lechner wrote:
> > On 7/26/25 4:37 AM, Dixit Parmar wrote:

...

> > >   config SI7210
> > >       To compile this driver as a module, choose M here: the module
> > >       will be called si7210.
> > >
> > > +config TLV493D
> > > +   tristate "Infineon TLV493D Low-Power 3D Magnetic Sensor"
> > > +   depends on I2C
> > > +   select REGMAP_I2C
> > > +   select IIO_BUFFER
> > > +   select IIO_TRIGGERED_BUFFER
> > > +   help
> > > +     Say Y here to add support for the Infineon TLV493D-A1B6 Low-
> > > +     Power 3D Megnetic Sensor.
> > > +
> > > +     This driver can also be compiled as a module.
> > > +     To compile this driver as a module, choose M here: the module
> > > +     will be called tlv493d.
> > > +
> > >  config TI_TMAG5273
> > >     tristate "TI TMAG5273 Low-Power Linear 3D Hall-Effect Sensor"
> > >     depends on I2C

...

> > > @@ -35,4 +35,6 @@ obj-$(CONFIG_SI7210)                      +=3D si72=
10.o
> > >
> > >  obj-$(CONFIG_TI_TMAG5273)          +=3D tmag5273.o
> > >
> > > +obj-$(CONFIG_TLV493D)      +=3D tlv493d.o
> >
> > We try to keep these in alphabetical order.
> >
> Ofcourse, I considered TI_TMAG5273 as whole. Will move it above that.

David, Jonathan, I remember I have asked Jonathan once already about
these cases and unfortunately I forgot what was the conclusion about
this. The filename has no vendor prefix, and  I think we prefer the
order done by filename.

> > >  obj-$(CONFIG_YAMAHA_YAS530)                +=3D yamaha-yas530.o


--=20
With Best Regards,
Andy Shevchenko

