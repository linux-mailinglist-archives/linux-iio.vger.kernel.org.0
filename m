Return-Path: <linux-iio+bounces-23870-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 710EEB48020
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 22:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 245A23C1CB4
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 20:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65E121C173;
	Sun,  7 Sep 2025 20:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VB6JSZ9e"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9D414D29B;
	Sun,  7 Sep 2025 20:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757278575; cv=none; b=dDvz2tGosagUI2vk7G+pLZ9hXbR4yZXtm/if5vW4hlGsK4bQggxq45BRh4YRVFXmX6sTfo1Kk8sS+4gJkaWaoyL0G4hj1SVj0GNlhfl2hb5g7S12lLFikUhgCtPp/+eu2PJy9IuUIQfOemvFdZI2Cp20eEa58a7lUqLkMrGZWV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757278575; c=relaxed/simple;
	bh=6P0HgZbw4HXtenDT6y2xs8u/qk5v4ufWtF4mxqooHm8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JlCDlxMWsKncELd1pC7QEy615FUKjwuoXyCxR0uLR8Qk00gJV4VP4tdPT4KM3Mb47rccc1l+QFUUI+KMcBznqNYZIOr6BS/7uo5UCaFT54LJSfEV2JJTFmtiE0YGOooOK93oM9XOf659dEZ6VGdznNPo1RgFJ/caB6O8zZNhPB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VB6JSZ9e; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-625e1dfc43dso1875092a12.1;
        Sun, 07 Sep 2025 13:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757278572; x=1757883372; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0zZEheeM1rUpP8ZGVFjjiK4EdwdbE8pDt0S3/UybYHU=;
        b=VB6JSZ9eQ4t9WzvTZXBRS9rDNEJMY7IltFagPHwk7oCnHf8vekUpYJDwoJ8BRqSo/b
         8INrWT73CFI4uoOZ13hUzNpenn86re4XIkNfkj9a4ioIKVKY7RqmWfdnJofaaggmTFzN
         DqBWKpjDOqc1b8hE+ua0YjE0eTmJhtQGuaKX5+ZCRuBAdkhF/wQMzCNt8pt2uVvPZ5Bo
         rgGfI9e9H8dzOMwYDV5T4oRZg3WPtOSTGS3Gb7kSi9mfyQ7/Zapt0ZnHV5RFaEAa/nnG
         EEb0YA9IiXbAbmq+Tz3TRGV7XkI0Mljt0Sm7+hHK/0elHv5wTYAXrGhjtKU9xQ9r/Qmp
         qt5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757278572; x=1757883372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0zZEheeM1rUpP8ZGVFjjiK4EdwdbE8pDt0S3/UybYHU=;
        b=HHDYgIA8ywBSyndyXzo7+MyGuLhrQtEL0ESerNLlXIvSuLJ/6Ibh6kl9P3MveDTp1M
         J16bI6XT8nR4LgFylCgABk97D88pIOYsRdRvl2U5k3zFtwGvcp+Oo9hnudYpRKBTan0B
         ZyTN8Lil9CYH+rwDQ9DZ7/JbxtxufVP3jALaRpsfoNpVGPSVs/M3ME1asYL+LmGbgoYE
         KN6OHGE+YGplCkDBs+394t1KUMtOPqaEk3XWt9z+WveDjmoaJ33fCV5z/XAo9393X+eU
         YE4+F0vzrt8s4z/n1Ffxy03WvpbJVhKGsOHPFofVuxtMbvX0voEBotzppvVQV57Zy/Ez
         g38A==
X-Forwarded-Encrypted: i=1; AJvYcCUyXq0uU/JaV6aHLLabbU+XQtkHAsrGlH7rLGIgKRFM0/+F6nP5BiEht+19YMCKlQ4kiZQ9xE5qu9Cr@vger.kernel.org, AJvYcCVYInka3IBUvSN1ZopzeaOSp2S0ckLOXE8HeJAyUKJ803cR7MYcJAYN01IrBfm2jPyXzk0JnBLBKG+4TC+V@vger.kernel.org, AJvYcCW4Lrdhvfa/Z70vDXzeC15+WK8ebxbD/QxPgHuK097Q+QE83LaeeUe5lTNq/vzqInQ1OW0SNx+2b9Dq@vger.kernel.org, AJvYcCXcdvv/qsZQwCDJEVcbV2YyWDX89DyzCJtQUEWfQYFcvwzhtNVxowazveXy2t4+mbjbq8yJw5sI6zMP8A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxdrTK8ZjjoI5Igg+peEXyKqfuTNSFfaG4uoWcLHQYwJS3NsLCY
	yFe5S/4IYYiVKeBwKO4clcND65ZsTKsQwNBoBjpmga/k1M/A7voHgK6DlwZ8WI/qVHaaFhGtN87
	t0NBy7HEYrb1jMw45j2+WSmamgzhdNjc=
X-Gm-Gg: ASbGncubwwC+cAFMnK06ypAiVC1LYXYUzDFeINX4m0du0liQiZ/0Zea6TT8djJ+wvpv
	shQJGaGdoAYTXOw5MXhEvPjEesvyuCMCYFYqcwEDt5RCtzB6HuZMnSXPo8XS0Ow02KCoAYln8Ah
	133R6ZZ0GnQ3r55N/IL2OHvbdD0TfIiuTSYBx0BztykE4gdTwYpmBb/8vC15iaAT5M/j/CTYb5y
	jatsLE/dNMrADYL2Q==
X-Google-Smtp-Source: AGHT+IG2cAHaNzeA2PPUEo6E90wAox3EQpXy6vAMOvdMI6HFpRD5lFQmKjzj246bI+rwMmB4f+CnhxohPl4jX9hXxGE=
X-Received: by 2002:a17:907:d94:b0:afe:db34:d769 with SMTP id
 a640c23a62f3a-b04b140d092mr551593766b.18.1757278572085; Sun, 07 Sep 2025
 13:56:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1757053456.git.mazziesaccount@gmail.com>
 <3cc1faffcb4f71f0755b6192f193acecd36bea67.1757053456.git.mazziesaccount@gmail.com>
 <20250907124207.2fe64214@jic23-huawei>
In-Reply-To: <20250907124207.2fe64214@jic23-huawei>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 7 Sep 2025 23:55:35 +0300
X-Gm-Features: Ac12FXxb44-QyBlIfiDXLWTvbl0eO5yLXHfNVS4oRrwPF2pu7aYj4Q6saPNfw5E
Message-ID: <CAHp75VeaHFDDZDmc9xsbUxZbRgkipRtcSdXN=ZXL2+V2OvL=Mw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] iio: adc: Support ROHM BD79112 ADC/GPIO
To: Jonathan Cameron <jic23@kernel.org>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, 
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
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

On Sun, Sep 7, 2025 at 2:42=E2=80=AFPM Jonathan Cameron <jic23@kernel.org> =
wrote:
> On Fri, 5 Sep 2025 09:42:31 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:

...

> > +/* ADC channels as named in the data-sheet */
> > +static const char * const bd79112_chan_names[] =3D {
> > +     "AGIO0A", "AGIO1A", "AGIO2A", "AGIO3A", "AGIO4A",       /* 0 - 4 =
*/
> > +     "AGIO5A", "AGIO6A", "AGIO7A", "AGIO8A", "AGIO9A",       /* 5 - 9 =
*/
> > +     "AGIO10A", "AGIO11A", "AGIO12A", "AGIO13A", "AGIO14A",  /* 10 - 1=
4 */
> > +     "AGIO15A", "AGIO0B", "AGIO1B", "AGIO2B", "AGIO3B",      /* 15 - 1=
9 */
> > +     "AGIO4B", "AGIO5B", "AGIO6B", "AGIO7B", "AGIO8B",       /* 20 - 2=
4 */
> > +     "AGIO9B", "AGIO10B", "AGIO11B", "AGIO12B", "AGIO13B",   /* 25 - 2=
9 */
> > +     "AGIO14B", "AGIO15B",                                   /* 30 - 3=
1 */
> > +};
>
> > +     /* Let's assign data-sheet names to channels */
> Not seeing any value in this comment given the code that follows.
> Probably drop it

It was my suggestion. I don't know if you noticed that the amount of
the values is *not* power-of-two and it's harder to find a needed
value in the list. Moreover, you can read the discussion back and find
that actually it was a mistake in the list, which can be avoided (or
chances of which will be minimized) in the first place if we see the
comments.

--=20
With Best Regards,
Andy Shevchenko

