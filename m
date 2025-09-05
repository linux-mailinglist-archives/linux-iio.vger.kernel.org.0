Return-Path: <linux-iio+bounces-23776-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D26B4583B
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 14:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A98E7B8423
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 12:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2060E350827;
	Fri,  5 Sep 2025 12:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YphyGiUh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DDE38DDB;
	Fri,  5 Sep 2025 12:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757076831; cv=none; b=qYq7jJxT857o4fA5ePp/lzJmqy1qGjpgxdk8w/00ZnjXcfzUWZqyv84DujG8NTUR/zrtiaPW40Pw2LgEudYTnqEpx5RMaKVJFtXgQvzbLulsO7+sFhO6KKrJIYFnkqHABu9BqxzVYehyqfN2ZXXeUcfPEorIinyO5I8zaArYebs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757076831; c=relaxed/simple;
	bh=5ckxlBqChHNEt0/61pFY3yAoEfx3s3PCFryFHohgRR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pn9ITIVUVIh357xFPdsupq9EQYVvfeMX5bMqvSKbZBSzuZyAC2nATq1lskW8ODotXezEJIQoiT4V5/Q6KTZWb4cpKox6cSMIjT77I1FKyuF7UeZAyHF91T0oRz4qmlnLAUShSV28gPWtEQ6Rg4ncOo4WkuOuWcCn7hHLpxM/bc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YphyGiUh; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b0415e03e25so306875066b.0;
        Fri, 05 Sep 2025 05:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757076829; x=1757681629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T33stcPp6bK9hL8nH81dnT87IxHmxbJraeRaG/h8CM0=;
        b=YphyGiUhgigsdRDm36BD5rWIC3hM4UwvtuKDz6/mYohYs6x7v2u1xBvOf4GZFDEb6X
         7PJzgVyZ0Ix+4ID0BJO7iQ8+TIBst9uny2qCE2hrd6eYZFeJRDcVUHlR4EMOdN7TuyxF
         FBMgw55fsdKnrD16ylUg4fZS5TvtLJt66Gv2HTftuiT7s6sgi63khvs9dFZ+QVHm8z8i
         rDBBYxk5UfjeUkViDGzEw9q88bcLFVZKgVw2Qe3+WUafpFgHYUC+VGa9zrK4hHFPWkQ7
         hzPq0AkueN6IoIjh/XNFczGPP/C24c9d4nSzmfAV84Mw5tV1Dd/dolWVyhPQYC+uaSS+
         pgFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757076829; x=1757681629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T33stcPp6bK9hL8nH81dnT87IxHmxbJraeRaG/h8CM0=;
        b=w2tjjAur0afurwYkdUk/LzaQ41D4ZhqDgTgNmweCeJHCzYF6iB/OlkXiX1Qw9ezB+m
         yPWMj1ZIrMHqkdq2o9X2/YrlSKsZfZItFfRekOtIuKRC7wTjeadmGgH5DntcYbgNrN46
         P081S1/ZsipfTLy8Kbyj1dMbSVHVZ022XwG2zu244DtjRILnW1zvv7vUM5rwhlbtQT57
         GO3PgN5XKTkonVpDs0pxPLVrp0vrQ2sBG+g3qdOsX9W0+kG7DPPPXUw+YBCKxHBXqOUE
         YvgroQc7CCZWrna3xk2snfKOuGXpDsNaXkmVUVSnV2mUU/kpJ798Yh+QRVb4ve2mZLAS
         De6w==
X-Forwarded-Encrypted: i=1; AJvYcCUTgjGbdHzk7WhRu3N2KhnKKboOHi3CjYEO7JXoOQkELL9ZhwoZtOQg6FR4sw1rG84wGiTKgY4ivwm/CA==@vger.kernel.org, AJvYcCVZbyaIfJM3t51LlEqYUHsys0SZF/wtpmf2bLQTiiWRRBiJq46B75pKTfAT/21cnLt4p5xLzDkgRpwQ@vger.kernel.org, AJvYcCWHqYVk33KmJB0JLE09NsqDU2elqsTwEIGTvzaANr7sws14x19MAuTBG1N4aH7K7+GHmCaL2OqRE7vz@vger.kernel.org, AJvYcCXkriMFs/GUD8TLxMUgmc/FUROTLZasu2SYTEJ3MLdXfdg1oB1ez1ehVFeP/rNQf2nvdMYSdiQ/6rnmnoyR@vger.kernel.org
X-Gm-Message-State: AOJu0YytpHSxaWZ1ddIBLh8YhobCC/F/R1Pogui3mtD+ePozMEF9fjdF
	ygzEbSqGi/GJgFkR4av5W32BpwNoI1N9cFTgmv2hdHqWM61WWTuNeMPPW0CDCcbF34bs1Cc+okL
	+xWpjJkc5Jygu4iYg3TcCcN+I6E2GBKu/Tfzp
X-Gm-Gg: ASbGncsjwT3vOS6mtnaqL1bh5S0SwGPGiY3lrODHZPm4hQs5ybaCs+IRMj4E0V8BPSk
	bALRgSP9imnCxwTNRuGLrtbHVQ0WVGjlnl4axWK9KKIzhyCp66uVxgxebwofza1JBAuhANRuKG0
	bGKRQ6PFErKfYb+ELEZryF3edGcY4uVMPCTMCZl47/LJ04waL1BI0yRqyr4cdEHSmjmgj6sHA8V
	/qDNfpV4g==
X-Google-Smtp-Source: AGHT+IEsfu4gvqMD8OwVlaIS7RK7dSX5WGQAcTtTRrhsReDH3Vd1wM+apHYJwSdx0NbhTNcmTuGwy1GUhGONE1k9GQM=
X-Received: by 2002:a17:907:3d55:b0:afe:9e58:754d with SMTP id
 a640c23a62f3a-b01dda8645fmr2203141666b.64.1757076828364; Fri, 05 Sep 2025
 05:53:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1757053456.git.mazziesaccount@gmail.com>
 <3cc1faffcb4f71f0755b6192f193acecd36bea67.1757053456.git.mazziesaccount@gmail.com>
 <CAHp75VdaAH+1mh16KWoYtYFMV+_ec8x9YipeD3K8g6yQr-2VjA@mail.gmail.com> <2c36496c-68bb-4c06-8580-3efc694429ea@gmail.com>
In-Reply-To: <2c36496c-68bb-4c06-8580-3efc694429ea@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 5 Sep 2025 15:53:11 +0300
X-Gm-Features: Ac12FXxynidtISOU6Dli41yMOcpy9qfjqFReTGh1U0WVTOgJVRzzEgetmIKArAE
Message-ID: <CAHp75VcDJm9ZQwuHNDZf79LBAH=cEHLoNskT6On2v9zquLJESw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] iio: adc: Support ROHM BD79112 ADC/GPIO
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Marcelo Schmitt <marcelo.schmitt@analog.com>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
	Tobias Sperling <tobias.sperling@softing.com>, Antoniu Miclaus <antoniu.miclaus@analog.com>, 
	Trevor Gamblin <tgamblin@baylibre.com>, Esteban Blanc <eblanc@baylibre.com>, 
	Ramona Alexandra Nechita <ramona.nechita@analog.com>, Hans de Goede <hansg@kernel.org>, 
	Herve Codina <herve.codina@bootlin.com>, Alisa-Dariana Roman <alisadariana@gmail.com>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 10:10=E2=80=AFAM Matti Vaittinen
<mazziesaccount@gmail.com> wrote:
> On 05/09/2025 09:54, Andy Shevchenko wrote:
> > On Fri, Sep 5, 2025 at 9:42=E2=80=AFAM Matti Vaittinen <mazziesaccount@=
gmail.com> wrote:

...

> >> +/*
> >> + * The data-sheet explains register I/O communication as follows:
> >> + *
> >> + * Read, two 16-bit sequences separated by CSB:
> >> + * MOSI:
> >> + * SCK:        | 1 | 2 | 3   | 4      | 5 .. 8 | 9 .. 16 |
> >> + * data:| 0 | 0 |IOSET| RW (1) | ADDR   | 8'b0    |
> >> + *
> >> + * MISO:
> >> + * SCK:        | 1 .. 8 | 9 .. 16 |
> >> + * data:| 8'b0   | data    |
> >> + *
> >> + * Note, CSB is shown to be released between writing the address (MOS=
I) and
> >> + * reading the register data (MISO).
> >> + *
> >> + * Write, single 16-bit sequence:
> >> + * MOSI:
> >> + * SCK:        | 1 | 2 | 3   | 4     | 5 .. 8 |
> >> + * data:| 0 | 0 |IOSET| RW(0) | ADDR   |
> >> + *
> >> + * MISO:
> >> + * SCK:        | 1 .. 8 |
> >> + * data:| data   |
> >> + */
> >
> > What I meant in previous reviews is that the | are not aligned (in the
> > same columns). Is it on purpose? If so, I can't read that as I don't
> > understand the meaning of | in each case. For example, the data starts
> > with 0, followed by 0, and the latter one is when SCL is #1? Okay, but
> > how to read IOSET that overlaps 2 SCK cycles and is unaligned with
> > times... I'm really quite confused by these charts.
>
> Ah. I think I now know what you mean. Whitespaces are hard :)
> I see I have '\t' between the SCK: and first |.
>  >> + * SCK: /* '\t' here */       | 1 | 2 | 3   | 4     | 5 .. 8 |
>
> It works perfectly on my editor, which has tab width 8. Thus, all the
> '|' on SCK and data rows are perfectly aligned for me. My original
> thought has been to align the first '|' on all rows by tab, but since
> the " * data:" is already 8 chars I didn't add a tab for this row...
>
> I now realize this will not work if tabs behave different from my setup.
> I will do replacing the '\t' with ' '. Does this make it better for your
> editor or do you see some other problem besides that?

I can't answer before seeing. Can you reply with what you mean?

> Thanks for the patience explaining it.

You're welcome!

--=20
With Best Regards,
Andy Shevchenko

