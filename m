Return-Path: <linux-iio+bounces-22455-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A883B1E9BB
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 15:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34C41175EF6
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 13:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C7D14B086;
	Fri,  8 Aug 2025 13:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFcI+hyZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD8212CDA5;
	Fri,  8 Aug 2025 13:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754661564; cv=none; b=fyYGM6lO8phasg/Rdw4BEreJDyQpQrTq5v7NGNnvwHkdXG1qGTWt6qlgx6tCnFChqA086VAw9Rl4LeG8CZxq4yCdCLNK2GGo80bWI/dgJmJNHXnAOZE1i9RZUN5ApTDmsq7teUnSf6Uq0wbqcrJ9Y4bN/CdBbyT5hmyBVWHV1uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754661564; c=relaxed/simple;
	bh=n7Ysa+dxm5v8spXQntkPxQkNqTdCEe12rA4bvGJIlsg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jxm8D7Z97bXDtbED8Tn8ibjAzircizCE5vN3Cn4khkv1dk04BIXl8hzXO9MrVrrJ8qggjlhq4RAfF/vO0CCmgkf6og3oifK7tiAjuterLkxGvowB+2CjpbSihR+PyAAzi9pZmw1Q0fW0dt8g9sGxyYSoDfkYpXE4Syyn6BCyImM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RFcI+hyZ; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-af93381a1d2so375340866b.3;
        Fri, 08 Aug 2025 06:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754661561; x=1755266361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DcLQcAWgsSc68JDGp9ydxgV/pyrE7bzp3NUCYCyeOHo=;
        b=RFcI+hyZA5l/Zuux9jSP6x8yVPWVaKR8Al6Jb/jhFXQmdlJkTAOL15EUDwZPXPbTox
         IDehHXu6EmQIHk5yxEjxKUN0Ny7HWa8241gNEEIWlfOHl+MCE2BN93PlKYzm5GYyW2DE
         shPAPz1BUp28jqzU66O9x/gg+pOcMJfUhwv9xhvEUnKZSN7CIGiZPjkxULdsnmwcJnwn
         RrAfSwfxR7OxXv2VXDNiypQ5XM4+8vpuF63XKk1FqIEqqZ4AD61htMVq3BmAX54bDJU8
         w+YVc8eQ1XRbsxB9xGoUg58p8eN+UY7IseANjrcajF64d+UPIxEg64JocfHedBzc+VlJ
         Xo8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754661561; x=1755266361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DcLQcAWgsSc68JDGp9ydxgV/pyrE7bzp3NUCYCyeOHo=;
        b=I/qxUHNDpCAeetsj8XHhQhdUkpEOTLCH1yS0Il+9TsrbzaMfgBBxDlgPsWDnjw9HWa
         nt9xvI8A1Yee3R5hJ+Mga1OQHaaY2f6d0RZIeQD9o4+NLSHyFK1JfrdgSTRjCgG6K5sb
         0KOwN3gRWu4BA0OCnTX+ys/G8iJDYMpF+ceWjfJfpQjd3XFiLaR9EgRep2oamtUdRbYn
         6+vcQBSQV53CbNXYmeXPF7ASFpXQE0fg16laISsOCCeVzI3xFDEz/9t+1o3th6TZvYmm
         c6s8k0uPiN1f1QCm++VE2aNr1zXRTojT+C5hngolDCNFv8L/EZdgviwZaVGlhaGd59Wx
         roqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMhz/ZkjUnPwUMDY3crTJAG9mNLBejDAHxz4Iy2IrzVY6VGpgR5My9bIdsXzMl4IQF9xu+kstdGv/uTJTy@vger.kernel.org, AJvYcCVYe/OA9hXP61w+UbiEmzanEQ+1RP+4NYTAHaaCnvzwLa6n809DvaM/FsfuTWEbOpVY9WV4HRqq+Sdr@vger.kernel.org, AJvYcCWlzd0PKDw0zJIr6IdqsyvXjqmxAQayiSw5Xa8djF6i4jr5tqJf1OjBhdOL8VsKhmLtqajqQJLhWc+v@vger.kernel.org
X-Gm-Message-State: AOJu0Yzso44dmzkPD/BtY5ubJ1Dr1K1WppgaCakoY4Mq9LCu6HDraNKr
	IY9whzfsHeLiLaRhljalgJ6BvTbn+++07lAyBwUDgwQNqAohfLEWhi3Wck+V0KY60oFyJb/r9QN
	cs4NCFYM7uDYfikX4Ce0CFX3KMk9kfLQ=
X-Gm-Gg: ASbGnct/kHPEjnaduosXJZjbaUHPSeAo5QMdF+OmIa/Z1NTD+dCFxgLa0twJcf3ZhGy
	tRgn64qMH6HI9Z6J4Ird2j1Lg+ZM76Z7jAiGdqhq8QVTEyFuaGWgNL1qm5Oluh/ehtPrB1GooS/
	TNjdJChAF4jpbRq5Wy8N2ZA6UPihr7TU8jk27MqK6W4Vtd6YqnI0sCuN497FkmzA65IUCAtJlPS
	SbqYFIa+dsdrnHZkprW
X-Google-Smtp-Source: AGHT+IHpkQ+u2CWeR1dH/haH7QYO+80WoQubSJ75IFnilLoEhsG/sE8G3N6mVHFCCV+EIG0EfIQzD0pvkaTyLYIYcxI=
X-Received: by 2002:a17:907:9705:b0:ad8:9c97:c2e5 with SMTP id
 a640c23a62f3a-af9c606d956mr292716666b.0.1754661561089; Fri, 08 Aug 2025
 06:59:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1754559149.git.mazziesaccount@gmail.com>
 <09bf5e7973c37413ada950741e6e09c375e37c57.1754559149.git.mazziesaccount@gmail.com>
 <CAHp75VcHR78Uwgo74n-i3a1sSfDxBwVKWihcnFp5x3d=puAySQ@mail.gmail.com>
 <13505077-fb36-4126-9767-fead98e01009@gmail.com> <CAHp75Vf7PbHPFuVjmK1xPMZxotc81S6FAQkgZ0ETNXSWozaUQw@mail.gmail.com>
 <83a6949b-6e84-4a0d-9a95-a9f45f62e84e@gmail.com>
In-Reply-To: <83a6949b-6e84-4a0d-9a95-a9f45f62e84e@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 8 Aug 2025 15:58:44 +0200
X-Gm-Features: Ac12FXzgyAyc3seV6r0ebLtj_x5DG7zqv9HJrT_J2VShUz4lsBzxHTEsdsi5UdE
Message-ID: <CAHp75VetWyWY9F6u6edADq2aUzdFOz8wWWhPsRs_fWk8eNGKmg@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] iio: adc: ad7476: Drop convstart chan_spec
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 3:30=E2=80=AFPM Matti Vaittinen <mazziesaccount@gmai=
l.com> wrote:
>
> On 08/08/2025 15:52, Andy Shevchenko wrote:
> > On Fri, Aug 8, 2025 at 7:38=E2=80=AFAM Matti Vaittinen <mazziesaccount@=
gmail.com> wrote:
> >> On 08/08/2025 00:16, Andy Shevchenko wrote:
> >>> On Thu, Aug 7, 2025 at 11:35=E2=80=AFAM Matti Vaittinen
> >>> <mazziesaccount@gmail.com> wrote:

...

> >>>> +       BUILD_BUG_ON(ARRAY_SIZE(st->channel) !=3D ARRAY_SIZE(chip_in=
fo->channel));
> >>>
> >>> We have static_assert(). Why can't it be used?
> >>
> >> Don't know. Can you please enlighten me why one is preferred over the =
other?
> >
> > Despite already made changes, I answer to this. The static_assert()
> > has at least two benefits over BUILD_BUG_ON():
> > - it can be declared in a global scope
> > - it produces more condensed (to the point) error message
> >
> > That's why in general it's preferable over BUILD_BUG_ON().
>
> Thanks. It's always good to learn something new. One of the great things
> when working upstream :) (Although neither of those points seem to make
> a big difference here.

I think the second one is the main point in my comment. Yes, the first
one doesn't matter.

> Oh, and AFAIR, there was a variant of
> BUILD_BUG_ON which allows you to add a message(?))

static_assert() can be one or two args, the second variant is with the
custom message added.

--=20
With Best Regards,
Andy Shevchenko

