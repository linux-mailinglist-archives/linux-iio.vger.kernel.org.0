Return-Path: <linux-iio+bounces-27434-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BEF2CEACE5
	for <lists+linux-iio@lfdr.de>; Tue, 30 Dec 2025 23:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C18123019BD4
	for <lists+linux-iio@lfdr.de>; Tue, 30 Dec 2025 22:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DEF28152A;
	Tue, 30 Dec 2025 22:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PuIVQ6lh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5680D2737F2
	for <linux-iio@vger.kernel.org>; Tue, 30 Dec 2025 22:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767135390; cv=none; b=AWHplK7orlMrem65oVnzXACspdsouAORsbCaTwz89IMXkuXtUEOERBedlywRjUw6phWJSfAWgx0Z0y6hXdKOAj2jej56roJLuS3bZLFtB3lmOA68zy3UZ9O7IgL8WOL9Te8V+glyW3yK3AXPvqsd79my5Q0awQ/NgbBfHyUcUk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767135390; c=relaxed/simple;
	bh=Nv0KpP2XN+5h2LJNTfP///hIwNtcQhBLr/vQwgI2RSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gxbCP1nspO2k2Zr3tL02GIcgWnM4ESbbqwK7qDLnvjOI5pOiiG1ARifZ9OuVvhUdOwDByO4Gxw4QBVZNbyVDx7c/xStWvWVd+YYdHlpAkdDftEjIvWezoVEi3y2kHQqu+21Yd8Tc1LewikluNBPmGbXlquLzDjSzLWFeAHaHuqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PuIVQ6lh; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b7ce5d6627dso1845108066b.2
        for <linux-iio@vger.kernel.org>; Tue, 30 Dec 2025 14:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767135387; x=1767740187; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kDIbiSFOwXrTpGtZXeahaPNt8jq7lieEYzMTkzUmpLc=;
        b=PuIVQ6lhu18BOac90Aqe1uX98ih2IkEgufO/hgJ40AkjoKbbZQOuzQ0EvT7JbXb44S
         TEAyMmb2Ci1bzyqvLHztzohedT5l5cMhz7xKNKwpjOz1Y+c8f49Io6FQ79FVw3/9YHZK
         qi/YvlvJkM2Ojd5Csmfm3GCuOHbo+HRyVHxnv80a7V2ijGyR+c2dcHbCwC/tPm38g27N
         TX+4oDcq3JP4C7zqGfhdTgBCRf0iNJVRkjFpuqGVpAz+5NOVQ/59lmhlLSN+b5Q4Y4pM
         WRzc/ncpdV+S65mHCwVBrcIVnTEgUGv7SVG2a+ycE7jYkokTXAu7omzNhaHTRka8F39z
         qpHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767135387; x=1767740187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kDIbiSFOwXrTpGtZXeahaPNt8jq7lieEYzMTkzUmpLc=;
        b=HVwNnjWBHRdwth+o6l4xgMuZvyzkBeChPp87DG5bRM9Nzp5Mj8tXddx8eTQ459styk
         MEMx2bvpKmWen/sVtEcYjh6VakmVIYpoPB2HoETRrSlunRABs0szCwb6yRs4rit2bGmu
         2vLRdHSjGqLRxXwmlSb8kmYorWZxWtacn3+GVPShIk1X4HRSu79d/PVR+hh+3VrYD8c5
         mfcKWj7TjOFcbj9OmmL6fZB+xJKCU9fLVYD90dh38Pj0q0Fg6B3Nto5O8LIdTYzFnCqf
         MdSp5tS3/kw6Gn8eUUpr8sU9YnfCqCBHtQvJ8rq+owsu0ucHogYNcUolwofU21n7QdBx
         mpfg==
X-Forwarded-Encrypted: i=1; AJvYcCV+KbIWXlOKL2PIjzQN1ihcngBJamnif1kPmK8xOVIor2a8EZhCjqN+n3QMM2g4rqQnhtFFMPuczgE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8wrmqw98eSN1OQOlNbCJxEfSg5jRm8jcdwpGoF8p7dtK2vsi2
	848xqrangYrbemlii0S1KvZ0tCbFqe+up6aHwojEshWH9KJzUJay1mXHOgVlHivz8fNEsgedrBs
	2yhx9AP55/9yFx8/y3S3bPMUC5hlpRjw=
X-Gm-Gg: AY/fxX5iSZyfCX0ozV5uPCYm5lT9rM7ENrQraU4MwMFtNjgMUW6rAYtE/VeZ0P/L9Be
	AKF1kBKeZTtCXvHgpmo7Et/7iAa7M2BfG5WJurii9UXshXSzOsyqAzQCslGGODOHiQiWEfpJjvG
	77foFQt6Mt5KWGlTEFYBvdhENccIHwE3xvbeYtFBl4TmAWquL2M/aD8s40PdYD9kziTF5cif0Xk
	Mwj8yjzkxtHDTao4bSgTl0iq2jTACrOdeWnpEd9DYHpswp7m3iQMOfsMnq1ZVI5ofYvv28HfGzJ
	PBKlhKRsZ9onbL56f3pxzaY+EForp4ZOOGrgdeoEuxxXJs7pTvHAFsdEGiPYfUjgSJOxtZruUMC
	b73PLqKw=
X-Google-Smtp-Source: AGHT+IEbMpfoSLDeshJ9t8GqOY5kwNiT0OnYtMQI0Fdnp+7OmSfR3GJ4eJV3P2PJp0sS7Ux6mE0W6B/gYBriqOxHCRo=
X-Received: by 2002:a17:907:a4b:b0:b7d:1cbb:5deb with SMTP id
 a640c23a62f3a-b8036f90f16mr4505285966b.27.1767135386311; Tue, 30 Dec 2025
 14:56:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251230203459.28935-1-tomasborquez13@gmail.com> <20251230203459.28935-6-tomasborquez13@gmail.com>
In-Reply-To: <20251230203459.28935-6-tomasborquez13@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 31 Dec 2025 00:55:50 +0200
X-Gm-Features: AQt7F2pkFW549AxW7l62eAZUeU7cH5ZkfebQCfE6utnpa0rzBmgZRmxWa36fFyQ
Message-ID: <CAHp75Vch9ud6fP=jg0tFx4WjHKYyfZjwaELBzfSubBVksQ7hSQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] staging: iio: ad9832: convert to iio channels and
 ext_info attrs
To: Tomas Borquez <tomasborquez13@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025 at 10:35=E2=80=AFPM Tomas Borquez <tomasborquez13@gmai=
l.com> wrote:
>
> Convert ad9832 from sysfs attributes to standard channel interface
> using a single IIO_ALTCURRENT channel with ext_info attributes, as this
> device is a current source DAC with one output.

...

> -static int ad9832_write_frequency(struct ad9832_state *st,
> -                                 unsigned int addr, unsigned long fout)
> +static ssize_t ad9832_write_frequency(struct iio_dev *indio_dev,
> +                                     uintptr_t private,

Torvalds said that uintptr_t shouldn't be used in the Linux kernel,
the unsigned long suffice and enough. Why do we need it here?



> +static IIO_DEVICE_ATTR(out_altcurrent0_frequency_symbol, 0644,
> +                      ad9832_show, ad9832_store, AD9832_FREQ_SYM);
> +static IIO_DEVICE_ATTR(out_altcurrent0_phase_symbol, 0644,
> +                      ad9832_show, ad9832_store, AD9832_PHASE_SYM);
> +static IIO_DEVICE_ATTR(out_altcurrent0_enable, 0644,
> +                      ad9832_show, ad9832_store, AD9832_OUTPUT_EN);

Why not IIO_DEVICE_ATTR_RW()?

...

> +       &iio_dev_attr_out_altcurrent0_frequency_symbol.dev_attr.attr,
> +       &iio_dev_attr_out_altcurrent0_phase_symbol.dev_attr.attr,
> +       &iio_dev_attr_out_altcurrent0_enable.dev_attr.attr,
> +       &iio_dev_attr_out_altcurrent0_pincontrol_en.dev_attr.attr,
>         NULL,

At some point we may also drop the comma in the terminator entry.

--=20
With Best Regards,
Andy Shevchenko

