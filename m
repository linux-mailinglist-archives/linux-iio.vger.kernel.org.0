Return-Path: <linux-iio+bounces-18888-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1753DAA3B9C
	for <lists+linux-iio@lfdr.de>; Wed, 30 Apr 2025 00:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E94F1B67A5C
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 22:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF40276049;
	Tue, 29 Apr 2025 22:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8lv8X/K"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344AF25F7B2;
	Tue, 29 Apr 2025 22:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745966443; cv=none; b=KJGcUYlpi1uW0N7Fwfp1YgZgTFOQoP4suwZ+cbiyGeW2hs7Xut9oZWA8E6uO2WYl28Za/8Yo9U3wJJNKTAhQ2h4mDO323Ysh+0jwrgvIIK6WLKNEW1OyFEGl67m0GGK80G3txTdOkOE1RW2FHOlhYrna6S4TGWDztbTxsF82eXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745966443; c=relaxed/simple;
	bh=VzclYXw/epHHE3tCAInbvYGypjVJAJVYqcpXW+ev/LA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oyU4VsZXswZSmJQjRwC8vmD4yNuTQvHHmXww2InjZ6fI4KtptAq9wuVUmkjtW/SCJoRGCOhKzkY7TlfrvFvQ3nE59RSinPTDOwXKvoPGN8hBp3peGlpJLSi9v1bdeMYYsmlRB3pVd4+DSTS9dFhKfb+O/d5VW8qMXo+eSI91zR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c8lv8X/K; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5f4b7211badso10699152a12.2;
        Tue, 29 Apr 2025 15:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745966440; x=1746571240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJ7lMKN0QVZ1rXONbUYDf5wJmm+vFaVCY5jxozGZvDk=;
        b=c8lv8X/KBm26KweeU1EiMc8034PIvfELs9SZcwRUp8cKt1bLRyL6gyUzKIE1bJDbUE
         VLadPxBa2xgJy++pwIzNTq1v4Up2RXoKnFhGLITEIlPwsGNApDRlMTkwqA9RzsuX7OQi
         o8onuu/mSxh/8IrQ5Uu9Zpogb01vDlBZEMAQEB2BF3JGNf4SyYBEpXjdQcxnzFnIV9WD
         84gtCnAUZxZ3XUPhklQZMQJlgU84XKMevwvqFW614AgwNrc8lkC+OQv6zyqtVyjba0fm
         TQjrZBu+ladJmO8tWij8/0rjlZOfLgC43SDzlmEgGW12GtkPjET6f58jHqIFLd+UmTir
         rTVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745966440; x=1746571240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NJ7lMKN0QVZ1rXONbUYDf5wJmm+vFaVCY5jxozGZvDk=;
        b=ulGc+h6ZrgxfvgED422JCzLu0z353PZmunbJuQ7i9t7aj9t3lEShVsF1+/utZWYtfg
         LpoEyey2Xxb6y5NoDBS3AB/Fk2Ue559AH6XorYZDbNqBL87gLuedyHdGyq27zep0HwRd
         0mPuLyF7TDDVqneDkQu6STCH84BfZxlIIKRwh1KjpWIIOWl4eKqGKZRwJcRDlq8MtGMs
         Zw4Q4aRxnqHnU7HFPuNMK2eQzo+OxOnrzVeD6SqU7+hH/t45R5hTCXKvfawKQceLOsXC
         JAwuc2hMjKZAk20r2LLNVkB55jEokqkWm2eHrqXqQuwsSFAdbqS76R4KbUVVx/eqf5Lg
         Umfw==
X-Forwarded-Encrypted: i=1; AJvYcCUS/AeLhTuMD1aP46jmtH2U/M4SSXiw+N4ns3hnnkX0f7tCXlzClJJfhQkWMlAHjgSSQVFmrT71C0haNIYe@vger.kernel.org, AJvYcCX/Bt1ylIpHe2FPrWXEosgFr+HD4By2zYD30T4zH/eK5qQrHOy/xHyvwtTk6NU8jdVNc+uVMjLehdD/xg==@vger.kernel.org, AJvYcCXmmVCuVts6CSDAEaAxr4/UZr7rKql6GVf3yHm1CCZHvkXhN4oPrkpy97lDgCuQI1P0nGOGNvSo5iBM@vger.kernel.org
X-Gm-Message-State: AOJu0YzQzJosS7kSWS0Pz2+5ooUL2HW3gdvSBhP+SlNDEmKCGxlqLMlX
	VWuA/e65qxKBd9+rW0S3VPhsefFGj/dbigzgoQuVq5D0LinVWJRBZS4ej2mfufD6K6qfO2drypD
	Emkm45oXcAU4MRN3TfBd8T7kmZA/U+8aB
X-Gm-Gg: ASbGncsSLOp6u+LSq3WmVKV/oMmQ+P9lsyQ41V9mIETu3EhMG+d1nifb0qYIv4xeW+0
	lhBu8TyQzQvb4U0csaOuGz9+uD3zsbzUO2NO4DyUzd1I/vVxmX/jBOkKZ7SuVUSpPrLUoGaRC/O
	P1IaNGDXHupXH1kjljn1oh1g==
X-Google-Smtp-Source: AGHT+IHuP3Bl4Dmp0Pl7/Fmgk0hAiMhrjLDf8jEdSrrC/XeiUwmnFVpkzNgk6qoS1idlayWeAZncqG5roFf/mYHCS/8=
X-Received: by 2002:a17:907:7daa:b0:abf:fb78:673a with SMTP id
 a640c23a62f3a-acedc6130c5mr121403066b.29.1745966440275; Tue, 29 Apr 2025
 15:40:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1745605382.git.Jonathan.Santos@analog.com> <4493dc2e3e0fb61ba3e8a0e54571998aaaaf46c8.1745605382.git.Jonathan.Santos@analog.com>
In-Reply-To: <4493dc2e3e0fb61ba3e8a0e54571998aaaaf46c8.1745605382.git.Jonathan.Santos@analog.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 30 Apr 2025 01:40:03 +0300
X-Gm-Features: ATxdqUG5-w5giO5XQP4rANKcNaXe9Cvn7hriB3UXwLJqNd6a4jtKZMuNy3Av140
Message-ID: <CAHp75VdJTcDs4SgR8NPcUJ4MX9sG2e+8t0bswDbQ8WkwNzK0hA@mail.gmail.com>
Subject: Re: [PATCH v6 10/11] iio: adc: ad7768-1: add filter type and
 oversampling ratio attributes
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, andy@kernel.org, 
	nuno.sa@analog.com, Michael.Hennerich@analog.com, marcelo.schmitt@analog.com, 
	jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	marcelo.schmitt1@gmail.com, linus.walleij@linaro.org, brgl@bgdev.pl, 
	lgirdwood@gmail.com, broonie@kernel.org, jonath4nns@gmail.com, 
	dlechner@baylibre.com, Pop Paul <paul.pop@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 3:14=E2=80=AFAM Jonathan Santos
<Jonathan.Santos@analog.com> wrote:
>
> Separate filter type and decimation rate from the sampling frequency
> attribute. The new filter type attribute enables sinc3, sinc3+rej60
> and wideband filters, which were previously unavailable.
>
> Previously, combining decimation and MCLK divider in the sampling
> frequency obscured performance trade-offs. Lower MCLK divider
> settings increase power usage, while lower decimation rates reduce
> precision by decreasing averaging. By creating an oversampling
> attribute, which controls the decimation, users gain finer control
> over performance.
>
> The addition of those attributes allows a wider range of sampling
> frequencies and more access to the device features. Sampling frequency
> table is updated after every digital filter parameter change.

...

> +static int ad7768_get_filter_type_attr(struct iio_dev *dev,
> +                                      const struct iio_chan_spec *chan);
> +static int ad7768_set_fil_type_attr(struct iio_dev *dev,
> +                                   const struct iio_chan_spec *chan, uns=
igned int filter);

Would it be possible to avoid forward declarations?

...

>  static void ad7768_fill_samp_freq_tbl(struct ad7768_state *st)
>  {
> -       int i;
> +       int i, freq_filtered, len =3D 0;

Should 'i' be signed?

> +
> +       freq_filtered =3D DIV_ROUND_CLOSEST(st->mclk_freq, st->oversampli=
ng_ratio);
> +       for (i =3D 0; i < ARRAY_SIZE(ad7768_mclk_div_rates); i++) {
> +               st->samp_freq_avail[len] =3D DIV_ROUND_CLOSEST(freq_filte=
red,
> +                                                            ad7768_mclk_=
div_rates[i]);
> +               /* Sampling frequency cannot be lower than the minimum of=
 50 SPS */
> +               if (st->samp_freq_avail[len] >=3D 50)
> +                       len++;
> +       }
> +       st->samp_freq_avail_len =3D len;
> +}

...

> +       dec_rate =3D clamp_t(unsigned int, dec_rate, 32, max_dec_rate);

Can't clamp() be used? _t variants are not very good and may play a
bad joke on subtle cases.

...

> +               /*
> +                * Decimations 8 (idx 0) and 16 (idx 1) are set in the
> +                * FILTER[6:4] field. The other decimations are set in th=
e
> +                * DEC_RATE[2:0] field, and the idx need to be offsetted =
by two.

needs

> +                */

...

> +       /*
> +        * The decimation for SINC3 filters are configured in different
> +        * registers

Missing period at the end.

> +        */

--=20
With Best Regards,
Andy Shevchenko

