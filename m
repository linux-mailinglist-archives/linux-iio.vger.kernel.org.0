Return-Path: <linux-iio+bounces-18875-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B33EAA1B65
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 21:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60F8C4C1672
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 19:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828FC25E804;
	Tue, 29 Apr 2025 19:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJoOyf1U"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF991C6B4;
	Tue, 29 Apr 2025 19:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745955424; cv=none; b=Q37e9QvhOeQQnqiPNo9lIsX8L0qLzOoKmvgbTx27gqg3TtmDYrUSDcslXzNjN0+i0tk9zTy5LONKENzhOSmQAC1PB9if9dFCPJFyqH4E/c2DpPJQcLuGk12p4bPsozLIB4zOg+YafB0lptzIk8IGHkbRPWMexpM4q/3mvs+XdSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745955424; c=relaxed/simple;
	bh=3RSQBQYYivFKA9pKVHeDfBEhAwfCaWu2qO7THyAb160=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=imvMLmGS4CTYB5djQsPlgjHge8xwCzay0BO5EuiMLef3u70eF/5Z8PlE6WS3XzKmw+lQ9GuRTa0m+IrhXvZMvxUrohzj+AiD07S7KWMIOK6fLLo2ekXR4Es2vIWCYlyl5NK8+BcxGF8qZAeFcOnINEL8h1bdzk2AU+NW6jHbBE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJoOyf1U; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac2902f7c2aso1063380066b.1;
        Tue, 29 Apr 2025 12:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745955421; x=1746560221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Tp6jQbur2uPrp6S/Am4jXNTxdawW/c11k2ZMTBdl30=;
        b=fJoOyf1U6Pa6345Od2497LXzpl83rb9N+T6+cN/D3HlJU4d5LzBTECy2H/BE3lNNrX
         E+dRq6tHD/NKWl4Fcp2pSF9lgh0tikvUrRC0jUxpnb20jjTBnkWJseAQQ9ZOdyx7aIbv
         YhdvAWlcEODLO65qMpNspMiFRrVZdV7HBY/iHSBLTYTmpJi92y4XY4kQc/09k5uLhMZz
         Lp3oN8lmi2SiYrgNv6mchB/zpCJQLK6VQFD/Dwl2i6uA+OhpUXALg8m92r4w36lsZrIg
         9bwMV0hXc6BEDUJC9jInX18W4cyc7fYx8SUhlroWllyVZ7eZIQ4GGjs/H7SY3S1etNZX
         zoJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745955421; x=1746560221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Tp6jQbur2uPrp6S/Am4jXNTxdawW/c11k2ZMTBdl30=;
        b=OcAyf64JcjCTeGZze8llQPEcdVMByzHLb3+v7x2gvjhG7jOlbsfLnO8IUh/Rf7jIYM
         DoDVG0i6vXuzwGMpLK5bZRbR52Q917EZgTOrUXhHPWW//v85awyhm6EGnglIaXT3seEm
         cxBMcyCAC9EGfvjzK+cv7CYn4PR849D0wTxbZ3AbfLMPd+8McEqSNMoB+K26pRkyibjn
         W4ddsghqwB2YL9KhHPwrGVzKRDUwh5L6sUkkhh0o5PDeBJaY5GevTyq+w6nUwCb3ajG1
         qQRPreYfuFVXRLwXfV8yjhn4LATzPYDf1dI2/EUOwQAn2cvMTYv80WX1DcCErYFqf9yq
         nZrA==
X-Forwarded-Encrypted: i=1; AJvYcCUCYP3mT6FiTv0AuwlDyiPM1gr29exkIJca+vfp0WZLkp9k7WmOwPCIWlAIsyTuP513j+tFno6mz1M=@vger.kernel.org, AJvYcCWhNT3Ab2zqUGsJeXsLAlIeTgyKYFUjBf/OgTMdpVTIabVRcE0WPc3D9zLAy3g1jMKM4o/3cmhJZxxuFqva@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2MrPG8TdCSn+8ypkq9HwkgKYOff1EGwLR9gIvZKMioesODhKc
	/MvhlZTY4xQw8dayC/Wl1NVNO95nxk3mvuQUcKN9hy8mvtk1IeTnhso1h9fBm97L1M3Z0V/i5fZ
	0nFu3/hC+myI7OZE74VyTBMbWXkU=
X-Gm-Gg: ASbGncvv9QFw5FnOZzwjvS8+/cICJ4K69rb5/TETY/6hF1Y/G0aPpUhtanGFHnklITh
	7fLpjbkcMvgGoeQFEp+J1NggVUXp89yiXgku+TzoG33cbpIUfH+e0vDKUSeiyaA2umFGCrZta0C
	wVMR/KR1LiUNf7OxN25ySFOA==
X-Google-Smtp-Source: AGHT+IEdsoIHAufNtJaT4e5z5ds/k/kKnJc+/x9kYEJiD5thFR4klPRX4LXJHI2J2frB9Rw/oGoqyvr69rpkRppUdB4=
X-Received: by 2002:a17:907:9801:b0:ace:c225:c721 with SMTP id
 a640c23a62f3a-acedc56d9cemr51735966b.8.1745955420643; Tue, 29 Apr 2025
 12:37:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428-iio-introduce-iio_declare_buffer_with_ts-v4-0-6f7f6126f1cb@baylibre.com>
 <20250428-iio-introduce-iio_declare_buffer_with_ts-v4-1-6f7f6126f1cb@baylibre.com>
 <1d90fae5-9c58-4a77-b81c-2946e7cc74d4@baylibre.com> <5c762653-b636-45bd-8800-e804ad8dfda5@baylibre.com>
In-Reply-To: <5c762653-b636-45bd-8800-e804ad8dfda5@baylibre.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 29 Apr 2025 22:36:24 +0300
X-Gm-Features: ATxdqUE34hEo360r8C9Web68AMwiNqGY2UEskFkoO_CVQ5Qq3fMSkPAEA4zL0cU
Message-ID: <CAHp75VfcmvLhBDjbu6x46wGyzG+i7=rVypzSm11qzWN9Qq_rew@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] iio: introduce IIO_DECLARE_BUFFER_WITH_TS macros
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Eugen Hristev <eugen.hristev@linaro.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 10:31=E2=80=AFPM David Lechner <dlechner@baylibre.c=
om> wrote:
> On 4/28/25 9:12 PM, David Lechner wrote:
> > On 4/28/25 3:23 PM, David Lechner wrote:
> >> Add new macros to help with the common case of declaring a buffer that
> >> is safe to use with iio_push_to_buffers_with_ts(). This is not trivial
> >> to do correctly because of the alignment requirements of the timestamp=
.
> >> This will make it easier for both authors and reviewers.
> >>
> >> To avoid double __align() attributes in cases where we also need DMA
> >> alignment, add a 2nd variant IIO_DECLARE_DMA_BUFFER_WITH_TS().

...

> >> +/**
> >> + * IIO_DECLARE_DMA_BUFFER_WITH_TS() - Declare a DMA-aligned buffer wi=
th timestamp
> >> + * @type: element type of the buffer
> >> + * @name: identifier name of the buffer
> >> + * @count: number of elements in the buffer
> >> + *
> >> + * Same as IIO_DECLARE_BUFFER_WITH_TS(), but is uses __aligned(IIO_DM=
A_MINALIGN)
> >> + * to ensure that the buffer doesn't share cachelines with anything t=
hat comes
> >> + * before it in a struct. This should not be used for stack-allocated=
 buffers
> >> + * as stack memory cannot generally be used for DMA.
> >> + */
> >> +#define IIO_DECLARE_DMA_BUFFER_WITH_TS(type, name, count)   \
> >> +    __IIO_DECLARE_BUFFER_WITH_TS(type, name, count)         \
> >> +    /* IIO_DMA_MINALIGN may be 4 on some 32-bit arches. */  \
> >> +    __aligned(MAX(IIO_DMA_MINALIGN, sizeof(s64)))
> >
> > I just realized my logic behind this is faulty. It assumes sizeof(s64) =
=3D=3D
> > __alignof__(s64), but that isn't always true and that is what caused th=
e builds
> > to hit the static_assert() on v3.
> >
> > We should be able to leave this as __aligned(IIO_DMA_MINALIGN)
> >
> > And have this (with better error message):
> >
> > static assert(IIO_DMA_MINALIGN % __alignof__(s64) =3D=3D 0);
>
> I was working late yesterday and should have saved that reply until morni=
ng
> to think about it more!
>
> We do want to align to to sizeof(s64) instead of __alignof__(s64) to avoi=
d
> issues with, e.g. 32-bit kernel and 64-bit userspace (same reason that
> aligned_s64 exists and always uses 8-byte alignment).
>
> So I think this patch is correct as-is after all.

I'm wondering, shouldn't it be better just to make sure that
IIO_DMA_MINALIGN is always bigger or equal to sizeof(s64)?

--=20
With Best Regards,
Andy Shevchenko

