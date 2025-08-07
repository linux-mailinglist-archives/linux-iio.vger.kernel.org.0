Return-Path: <linux-iio+bounces-22410-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 740A4B1DE98
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 23:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F8C23B48C3
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 21:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A2A239E7D;
	Thu,  7 Aug 2025 21:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cfwcBntC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9685C23959D;
	Thu,  7 Aug 2025 21:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754600538; cv=none; b=JBtJFNQFQlG949FhHmM5Tt1MOAqLe8mOwX0/Vxe6r4KonloukRmlwPEOgkraK5Tmfkilu982wvy55tIf7NsGfQcV4AAfQqe7114GDlazmiJGS86p3xl+Anm2RbdVWfaRdWjWZQjzlXi05RP+AiQVjCkPXqoivTlKOatF3q248bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754600538; c=relaxed/simple;
	bh=01z02HFWROB2Zl3fIAkQbe1K1I4+3DZzn/+UuKJr2aw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FI0tWh2Zfbe7OEYVj+Jty/xhG1nbQY8Iwd/GbNbVZf3r5JKyTBk3p7g4ETOLzmU9T3zE+j5LjcWyW83jahca1K7l11kRWEW93XrhGvGvIw37e5/BoPxn0fKkTvCKAfR8gHc1Ndaecj1iUqNtVO3nSrjkHl0XnQ1kuQDg/xEDmuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cfwcBntC; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-af96d097df5so276666266b.3;
        Thu, 07 Aug 2025 14:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754600535; x=1755205335; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y19NW6nzgcJ1Pditu0KobyMToFqqyPC+EWFslF+SB7I=;
        b=cfwcBntCwngSxXktx7d76nwBxze3dxkkPtlrUjYbyq8xL7NQUgBOllU/sBcYXB/ydy
         CMF2qcMrLjQXMgUrhRqBSIalW2wACAj9rFh3MOXP7AaC+NaQOTiE5v0snbHG3WMHHl4P
         OOsZ1/0dhO6ynNnzRzi7QaberUCdAvjOU/c1Bxe2cCHz3EAMOoJObnT/g/qS32vgUlUO
         +HxVCpRzceNCRUx01shxUVuZMnATjq4YZ1ms4eT5w7B18iRO0AsL1UDy8u7srhW8D3fh
         ozNDHoS2pau7kTDA/oRV0uPdAykY0vd6CzAkal3yHVJvsN8EGCKJDoFHkdlA2GLa2Xla
         6FUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754600535; x=1755205335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y19NW6nzgcJ1Pditu0KobyMToFqqyPC+EWFslF+SB7I=;
        b=o1XB5wCSHm9QCo1q2u20suxb+RDpOPm3GPOamekjxyJb/5LlkwQOtsqUAEoFoGCt70
         Ul//ZLHc+11He1oGavlHh/R7YlCe22gCX6G10TFfUDdlyh9xPoe1M5RpoeBC57PLdz40
         lda3W1FwyRZXtMBOt34kPQgmfw69ZLbg2KOp5UnIQHInxiUye2iQaRPHHPMCIICeVtXz
         ByfA2A9RJ6CbyhscZg/qFGKpaCshhI3zciAjO2T3l4rT3wZ47r9r/Yh+OLEX9Ak+dKBV
         kf1iscrD1rbuyj9zosSjx/baU7tHZuR2pgXH7nksKzW2s/1DUDpi/q2RcmAhRNCIgOtt
         WiQg==
X-Forwarded-Encrypted: i=1; AJvYcCUI8p4Bnv6mM6ZDaZAoHiSC4Gq0xQG/C4sChqVM1Cg723yMufngsrt17NglsNdt1naC46L3pF3UeElTeD3c@vger.kernel.org, AJvYcCWxPsyZWhXzy1XGgG/vPHWQ3d6gRYanG4LLNgQkhLIbp9jhm0/c1xuJc9VnaapK/EIBH56KQwBvpKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF0K0+BplRSkJzAORC4ryARrvYxjQNgLRQ8ru721bH3aaXPKRg
	NvN3kDfKIRo/FEVdtM3tDi5iAJDdpmV0SGU01d6Gl4vKqA8BqM4/LCpGSxAIIb7VdoD+ccMhATK
	i3V3YsCWYQMYj/aDowX0ap+A2OMMzWZFRlVfGGpc=
X-Gm-Gg: ASbGnctU4G090Tho8ub1zdswZCPUYyLdZEhDA/x+pO7luY7AXeyGLk9kwqaEX1+X+0J
	rKw0ygV59YwPvrZmj2xTLfKO0B7d4h9YHnbbvAeywSXPY29q2C8eYFfdY63woKOZ2ZdmYDFdBeM
	WrQiBFTWN5EgdzwPGbwepcUtJfG9tQSxSYQtY8NXX+Lo28Wwf1GrD47LagHP5xJAn3Z4Z3A/0d0
	Ij622D7S2fxErOOxpFukBgee4vCwuIt5Bg1CXhZv/efABQrrP4f
X-Google-Smtp-Source: AGHT+IEZWeTSzBkzGLVR2yaRBbMemXneCFlAQBdCD8/YCgdl7IV8CH88NNaVc+UHXhtDjTUX9Fe4uDmqRTei2KAi3eQ=
X-Received: by 2002:a17:907:741:b0:af9:6065:fc84 with SMTP id
 a640c23a62f3a-af9c6495e76mr35380866b.27.1754600534714; Thu, 07 Aug 2025
 14:02:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aJReTh-t5D45aZNV@pc> <fe98c2a2-ec8d-4352-a9fb-6f0e798f7268@baylibre.com>
In-Reply-To: <fe98c2a2-ec8d-4352-a9fb-6f0e798f7268@baylibre.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 7 Aug 2025 23:01:38 +0200
X-Gm-Features: Ac12FXynvbL8MhVZlmHQ4NJFHebs8w4OSIsZaoh9iNIoi8hSeaWfhdS0zYK3mYY
Message-ID: <CAHp75VfH6xuiPNZA_eGmFgMGxdGTf-y6o+SEKeCbG=wsUOJYfg@mail.gmail.com>
Subject: Re: [PATCH v2] iio: adc: ad4170-4: Use ERR_PTR() with %pe to improve
 error logging
To: David Lechner <dlechner@baylibre.com>
Cc: Salah Triki <salah.triki@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Marcelo Schmitt <marcelo.schmitt@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 6:03=E2=80=AFPM David Lechner <dlechner@baylibre.com=
> wrote:
> On 8/7/25 3:05 AM, Salah Triki wrote:

...

> >       ret =3D __ad4170_read_sample(indio_dev, chan, val);
> >       if (ret) {
> > -             dev_err(dev, "failed to read sample: %d\n", ret);
> > +             dev_err(dev, "failed to read sample: %pe\n", ERR_PTR(ret)=
);
> >
> >               ret2 =3D ad4170_set_channel_enable(st, chan->address, fal=
se);
> >               if (ret2)
> > -                     dev_err(dev, "failed to disable channel: %d\n", r=
et2);
> > +                     dev_err(dev, "failed to disable channel: %pe\n", =
ERR_PTR(ret2));
> >
> >               return ret;
> >       }
>
> Interesting, I didn't know we had this format specifier. But I think
> this is something we would want to do kernel-wide or not at all to stay
> consistent.

I'm sorry but I didn't follow. This is a kernel-wide format specifier.

> And if we are doing this in more places, it would make sense to have a ne=
w
> format specifier for integer error values instead of casting them to
> pointers.

Will _very unlikely_ to happen. This has to be a C standard for that,
otherwise you are suggesting to always have a kernel warning for each
of these cases. The only way we can customize specifiers w/o
introducing a compiler warnings is to continue (and still carefully)
using %p extensions.

--=20
With Best Regards,
Andy Shevchenko

