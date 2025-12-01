Return-Path: <linux-iio+bounces-26596-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FBAC97C0F
	for <lists+linux-iio@lfdr.de>; Mon, 01 Dec 2025 15:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8AC83A19B7
	for <lists+linux-iio@lfdr.de>; Mon,  1 Dec 2025 14:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27C6318152;
	Mon,  1 Dec 2025 14:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISlFFX3h"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF81A23D2B2
	for <linux-iio@vger.kernel.org>; Mon,  1 Dec 2025 14:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764597630; cv=none; b=Nen2bOHjUM/JruySAVlYqOVVmocjZShVdP4AqvaHd2+TvVKIrw/qP9PZ03iuYdB9NarVRExY3EfmdI/e4P/UUCI03ppqAniFR+IDtpCuAwYNiqiipRe3PTfXJR01DcaX7D8thQvc0xFGsmVS9T+zZuMd2PQRZ1O774TfXR3geNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764597630; c=relaxed/simple;
	bh=Kdw5sKwxkB1gbWGVj1Owv/+WY8LOXQPm9aw1CABrb58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cadc09dyBfljAOcpvx5fwOqHc1Jl4At/zfpoQatQ2Oo6A3cVuqocBtz1l1FPXsA32g7YyczAjpaHhYWmcZrhFlydIIVmaaTVTjSthR34TTFF+oIsiuR8pwl8HyihQ6Qg+yQoQscYepjHzhLi/1OfxCwjQA0GwcwrPv5uqkoMb+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ISlFFX3h; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b735b7326e5so861666666b.0
        for <linux-iio@vger.kernel.org>; Mon, 01 Dec 2025 06:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764597627; x=1765202427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jMgZgWMsI7C0bZ6DP+sgc9GtkiOVIqRxeD8wCUODhhQ=;
        b=ISlFFX3hhVmhJiCo04Dqpd760tCVOxDXwZ8s/XPswbhcXdgfdjpMPO5Ikgdmx8ltvA
         23GbRsZ3t7hRO5eN4QDNh9xNOBPOeomwXl+gcIoId/gH2POFet4hvlDyr/7wsadcLpWm
         5sf+Uv/6LJOAsiFiySfbd7256OXa4Es2VBjDo3eVIx2b4V4yG3B2/HhxAFiZiWQHQwWW
         Xu+4PAsx1xfGVoFE5WY6rrbF5NM+EnPrWfBBGxi7QvPS11m+G+jcZ9H4dBCMcethWxt8
         3XivcZ97ccXYce4QXdXxD7kILtaHKE+cfZs5QLYNmqYSvHh8H0YjWMmovgf6fiG7Rblr
         IJhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764597627; x=1765202427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jMgZgWMsI7C0bZ6DP+sgc9GtkiOVIqRxeD8wCUODhhQ=;
        b=pB4fDfJ61YmKzDD9abkVYTGFGZkGUvqJkP4YC/Ok3Z0pRdnTiwPMpxSEXQ6A64E48w
         thkHENHVvoDTg6nqhudeqILCGNgnH8qLK6KUk1iK4rVyDbOpJHbkZH4t1u7Hsb/J9cj7
         WL5xD23tHNqfMPFh86ma+ex2txyZ2nPXY+Q3doX2BuQ1ffHoalNF2BT1rO+m14qkCCiG
         jR7w0AQZmhZJkjCan31A6VSu/R83HnB2w/ILzVPKWd9gV6UgQbn1I+mLFBXSU20ujJHe
         1MrFhXMlJ8V68/sGCTL68YEeXBnov51b9cuTN9jj04oRY8hRg/OVjBGWkQUZUTctk+y5
         fA1A==
X-Forwarded-Encrypted: i=1; AJvYcCWMZCaALoAmhGScvw3wNnsfRQXbZ4xrOuMrjKWsrGsrNHQG2NOaNUQ9j7q2Me/Gifcg86rYe6vaShc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv7fvsXKVs/AKNyAXPZjmXDcdlLiWyYuvCx7fQMznlAF+n0QK8
	+ZyOg1YGzllgK9bkXFN2BzhFSvjlEh5iqC1Zbs7SvOLu3ltfU+8XlJywkvVdcEbd7HeOcdGaUjh
	H7NZhBFSdd6EhwDUzMXS+VfbMmP5JS88=
X-Gm-Gg: ASbGncurfVWEWQJfhbFA6ML96saLl1jjouyHZCwMYjuPj/oQmiDjLfrRJEg0aAMC0aE
	GsqWQJaEczXu2BnewShWYqeMS5W0L6ZzfbK4RjWB0ngHirkjmdd00WSczZVcEXUxDRv2fDEXmzI
	p5Yu6ml3FcLGUa1vQ/20HKa11Dy5qE/PtYuzTwevHSQE40m0Izy4FEOLO4Q1lN/iKZ6YUS21UXl
	eOGqQeBbLyBlRoaOgqegahtYX5zVsLNxKnQM3fCmLXEkQehzt0ZwGz7uhply6gHbcZ3XouBBnmY
	WazbGRcimYCpY+bGy3Upcf9YDl9x4e+6TrxJuE5eR8UXIyMT69DrbilW7pRqK0TgccaASXzzZjK
	1m+RIUQ==
X-Google-Smtp-Source: AGHT+IHehKhEj8QLBIocpyJO9hWzH9+Euu5pC4QzoGearZ3clC6tZOlpWV21aiCkwAw8ifHBEhoD3ZfmBxOG/R5BJb8=
X-Received: by 2002:a17:907:e8d:b0:b76:cf68:72a7 with SMTP id
 a640c23a62f3a-b76cf68761emr2382461766b.27.1764597627020; Mon, 01 Dec 2025
 06:00:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251201-ad9434-fixes-v1-0-54a9ca2ac514@vaisala.com> <20251201-ad9434-fixes-v1-2-54a9ca2ac514@vaisala.com>
In-Reply-To: <20251201-ad9434-fixes-v1-2-54a9ca2ac514@vaisala.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 1 Dec 2025 15:59:50 +0200
X-Gm-Features: AWmQ_bly-_v0d2jRyminW-5_C1EOPXPSvjRpJfv4hwj69q_m1ArgJc9dZEBnceI
Message-ID: <CAHp75VdaYR5S7MmVEMBH1e6g-0bQim_d7m48=X2ybpf3hBAfTA@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: adc: ad9467: support write/read offset
To: Tomas Melin <tomas.melin@vaisala.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
	Alexandru Ardelean <alexandru.ardelean@analog.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 1, 2025 at 2:00=E2=80=AFPM Tomas Melin <tomas.melin@vaisala.com=
> wrote:
>
> Support configuring output offset value. Among the devices
> currently supported by this driver, this setting is specific to
> ad9434.

...

> +#define AD9434_CHAN(_chan, avai_mask, _si, _bits, _sign)               \
> +{                                                                      \
> +       .type =3D IIO_VOLTAGE,                                           =
 \
> +       .indexed =3D 1,                                                  =
 \
> +       .channel =3D _chan,                                              =
 \
> +       .info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE) |         =
 \
> +               BIT(IIO_CHAN_INFO_SAMP_FREQ) |                          \
> +               BIT(IIO_CHAN_INFO_OFFSET),                              \
> +       .info_mask_shared_by_type_available =3D avai_mask,               =
 \

Okay, this macro uses parameterized avai_mask (which should be spelled
correctly and probably in parentheses, but it's not the point) and
it's being called only once. Why can't we just embed it for now?


> +       .scan_index =3D _si,                                             =
 \
> +       .scan_type =3D {                                                 =
 \
> +               .sign =3D _sign,                                         =
 \
> +               .realbits =3D _bits,                                     =
 \
> +               .storagebits =3D 16,                                     =
 \
> +       },                                                              \
> +}

Also, looking at the existing macro below, I think you should have a
common, parameterised macro and then 3 different on top of it for this
case, and for the existing two.

Does it make sense?

>  #define AD9467_CHAN(_chan, avai_mask, _si, _bits, _sign)               \

...

>  static const struct iio_chan_spec ad9434_channels[] =3D {
> -       AD9467_CHAN(0, BIT(IIO_CHAN_INFO_SCALE), 0, 12, 's'),
> +       AD9434_CHAN(0, BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_OFFSE=
T),
> +                   0, 12, 's'),
>  };

Also the first and third parameters are identical in all cases, can we
for now just make them using a single parameter?

...

> +static int ad9467_get_offset(struct ad9467_state *st, int *val)
> +{
> +       *val =3D ad9467_spi_read(st, AN877_ADC_REG_OFFSET);
> +       if (*val < 0)
> +               return *val;

The standard pattern is to avoid polluting the output in case of known
errors. Hence

   int ret;

       ret =3D ad9467_spi_read(st, AN877_ADC_REG_OFFSET);
       if (ret < 0)
               return ret;

       *val =3D ret;

> +       return IIO_VAL_INT;
> +}


...

> +       if (val < st->info->offset_range[0] || val > st->info->offset_ran=
ge[2])
> +               return -EINVAL;

Wondering if at some point we can switch to in_range(). And we perhaps
need a new generic macro to supply start/end instead of start/size.

--=20
With Best Regards,
Andy Shevchenko

