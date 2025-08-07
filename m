Return-Path: <linux-iio+bounces-22414-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A24FDB1DEA4
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 23:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 637527A2B0F
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 21:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7EA22A4D5;
	Thu,  7 Aug 2025 21:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RNxIEJCk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EBB1D6DDD;
	Thu,  7 Aug 2025 21:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754600967; cv=none; b=qwJmANnb+Z4jRDm4VwnBv9KF3l3C1ohEF/pdlF5fluGOLgWKmijx5F18/d8bzzqXDR+BunLgF1srKRXZixOO9AbNT+UvsxLdc0jHiupa1rA3jb8fd1WHoYYJ8WfyVacGhGaN0xnWLdwPzOsZu9WgfBB0r+BE2R4CPOVIDVta0tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754600967; c=relaxed/simple;
	bh=O0mHde6WnBTZ5MgvvshFuh2INdC9WGHEWCvmUK9uiwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qUXTfeGEM26sSbuxKDp4ltajm8zWw95f+xEjWqOL+TQrWnounvqvlC5XSbVBv/Qyjnv5iMclNaWxWNYgd5sdaC2xceO3XjHLv7MBHRr2q48W95rnESouaTVAH3oQeCdaLstDasFLZHFXViqZqXWqwEKhOn0YeS1L6Ezpc7i7cW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RNxIEJCk; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-af98841b4abso252141466b.0;
        Thu, 07 Aug 2025 14:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754600964; x=1755205764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YmHCPaW6ggefEHmZS7Fxt70xyEe4A7AQ8DhQzt79KsM=;
        b=RNxIEJCkmb71xwZ16JQrigidLTAsy0S/IU4PfaI1mkLSaiFnotZWMuS6VSfMxZtSMe
         SCOYPnzlR9CwQi/ZzCxvkyLZvB7Dt6Zln5Jmyk0YbzBMTKcJAS/spguzE/BUnDUT4c17
         awJ5OYxNrrUgX5cwjs9BVu+avVQAJZ/kI+joqumolI8fZha+3ggqy7xz6r/8czz1xiJb
         rB68sDVVF8/fHT04Gj8peBuDkR5jjHOYQmG+D26qLU6+DSCRVr7kUK4iuy4ggPJKoqX1
         1mDEjo7CFx3xQLFIHAuCgIRNPWMYhgLOlmd/J1bRQOGO2t1nbhbFnjc883A1YbYaAIcQ
         rS5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754600964; x=1755205764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YmHCPaW6ggefEHmZS7Fxt70xyEe4A7AQ8DhQzt79KsM=;
        b=GrDB+my4yf/b9s+xJg4XqdEL+jzXLJI+IMLXMMQtSxwUf0+yGJUfRVDvKk3BhbS/A/
         UmhTpMosfCCjC8A7pl5TCG0VEG4MXLtgmTqlCyORPk3KqbRsvGefAIONIyG6uSE7xWiw
         Xw8MwRBpuPm2t0CzGNHLUtDe0vkj7Iax9Ibv++IxkjRnF+3vtsGhL14lNXAUG7xeo5HR
         0dXaFRmM5sPnzZYVYjoYV0cuakaBFsCFLbA/VDxdkXNiioKoPLevunoJF8neBE7nLpC3
         dDZNelwEbfa2H7nrE7tcTJ9RvUW2GzI1Xda0k3zlYNt1MhPpScGIdyJM6Ai5YnuSmVif
         hEkg==
X-Forwarded-Encrypted: i=1; AJvYcCUm69Dosp13PB8RQkDOvasXqnz6aNdfLyXgSil2fZBmk4yDbHCAkyScUdrk6fbDIEt1dXpPjnZxbUb2@vger.kernel.org, AJvYcCWh6FwfoZvOiur2NAuxLNM7iTO3Ek/2LY4mbvm/QucqvE0cMgp6U3fRZIgHQ2S4t+IDe3ztamZ1vjdy@vger.kernel.org, AJvYcCXHuLT+gnNtsd9q63ZpYmDeZ2xSBXveNZjZtM7w18am3B2jhPi6p5inp1LEfnF5QaxX5+bg5HsTaFPVIN+Y@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbr4rfLFF/QzKy2wKmCzjkq5WM9l7uVcqNbYjv1sFToCZBYRar
	be8N0e9QgW9TTjSTjn442wQZrXAV9bupSp5zvfcR+NYkT3b5iUaxkf5o1JOPXFYV3ve7JU4Xfj0
	5UIwyjQGpGtyhrdvEERbNz5XwujEuNDs=
X-Gm-Gg: ASbGncvs9/Xlk4uoPQNoVSiQF8AlfSn2JHR3+scB71PhNGQa9GgTKFVgd/Pr8qEL7+7
	UoxYPwXj0m2hMXJk73+i5wCMNyWDiGcjzqzCDOtwXR/4qL9+iGUI/Gd6ulbTvr8x7UUcfenfk/k
	IhjN6cs5/fz8yV5DRtHHaM4J7DXxiCGQbHaZuXFoe2mxj0AI+g6nEpX/dvnjIWkQJe+oQBoBOS+
	MfkCi96wY7BK0W9uDO9bAxSGN7iaN13F12O2SJa0Q==
X-Google-Smtp-Source: AGHT+IFNMng+1TQPi8H1kdbZcSxE1O+RTc1QDBVOPxslTWV1asIU4y0wZ0WFEUyq17vB+jE6ddI2+Uzsh/wAionLawo=
X-Received: by 2002:a17:906:6a10:b0:af9:8c18:c11d with SMTP id
 a640c23a62f3a-af9c63428d8mr33360666b.8.1754600963650; Thu, 07 Aug 2025
 14:09:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1754463393.git.mazziesaccount@gmail.com>
 <c7f94cdf9bdc6882953f6a074db3fd87570fa98b.1754463393.git.mazziesaccount@gmail.com>
 <aJO6jVcITlOXp0YB@smile.fi.intel.com> <f738f3fb-2ce8-4699-bb13-3778ed1c6606@gmail.com>
In-Reply-To: <f738f3fb-2ce8-4699-bb13-3778ed1c6606@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 7 Aug 2025 23:08:46 +0200
X-Gm-Features: Ac12FXz27d6PABF7f5dpuzogOoVjo2wFGmpzZJfA1b4yV4j6m_WGzfSvNXZrBMQ
Message-ID: <CAHp75VfsCHJtrueAVQdbwUjLBCo_kRKVfifUgVrhicvXftPrDQ@mail.gmail.com>
Subject: Re: [PATCH 7/8] iio: adc: ad7476: Support ROHM BD79105
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 9:31=E2=80=AFAM Matti Vaittinen <mazziesaccount@gmai=
l.com> wrote:
> On 06/08/2025 23:26, Andy Shevchenko wrote:
> > On Wed, Aug 06, 2025 at 10:04:43AM +0300, Matti Vaittinen wrote:

...

> >> +static void bd79105_convst_enable(struct ad7476_state *st)
> >> +{
> >
> >> +    if (!st->convst_gpio)
> >> +            return;
> >
> > With 10ns sleep in mind this is also unneeded check.
> >
> >> +    gpiod_set_value(st->convst_gpio, 1);
> >
> >> +    udelay(1); /* 10ns required for conversion */
> >
> > We have ndelay(). But I believe toggling GPIO is much longer operation.
>
> Thanks for the review Andy.
>
> As I replied to David, this 10nS is rubbish. I need to clarify the right
> value.

Then probably you want to call fsleep(), and if the value is few /
dozens of useconds, I would drop the check for GPIO and leave with a
small delay.

--=20
With Best Regards,
Andy Shevchenko

