Return-Path: <linux-iio+bounces-23686-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2B3B4219F
	for <lists+linux-iio@lfdr.de>; Wed,  3 Sep 2025 15:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70B13189C944
	for <lists+linux-iio@lfdr.de>; Wed,  3 Sep 2025 13:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AED63090CC;
	Wed,  3 Sep 2025 13:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwxHvLJj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A905306D36;
	Wed,  3 Sep 2025 13:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756906232; cv=none; b=Oy3QqYITlRjoxyazpo5gH+HpsIE6c+JW/pGpgY/DIF4a3I2Jn9ttpLivXmxrKDvHFHcnLvxWKV6RV/NiDWpYoWUjr0Bs+Ffs+rrLNjA/GzbXi91EmvcCfyZAWj3n2tkBr0CHFYgILw79slhtkySyqUgqA+4IxchC1CGeU/CdCOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756906232; c=relaxed/simple;
	bh=KQI7/pDIhz5ZQM/Z/ICCvoi8h1PcS9zhNsNSDrzD4gI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B/5y0/018fEI8AZbSlM2/oGC79zwGDuEaXm3QJrOE3cTQnz8xeACFhN5Onu429NHjHIyYQHdgvKcLYPrJ+pKZULi1fwS4THQ+B2X9JKE1gdK0/XEcl9g4/1oqcQHxinNEgGfoIT+/a6qmFoj445Hi7xU0GeuGfaY92tTfLb+QA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GwxHvLJj; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6188b5b113eso8807096a12.0;
        Wed, 03 Sep 2025 06:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756906228; x=1757511028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9kY4ld87xkJ109VN1e4fZ8Pvba4PV6yLWSNAEFQE588=;
        b=GwxHvLJjags3l5ZaPhN6a0gimXjNJfsNlg1R1sMMbtN5D3C7KtN+JCRgFds7PJAXh6
         3d7ETmZYfw2GoM7omqLnQ810ITpEUlSjW7OgY9iKJx04PwMTy9BNZmVM8ZCY10Fl7A/8
         nASBDbW6H7r2t9FFBkylNVJz2damEe3WXd02OAM6QpSyqar1LB4RRzglO448pHJkEgMR
         O04Sq1G2DvpJGkZGS4g+Ky+R770wKE7eCj94SvLC7XWQoixDKN/aK9m+LFjN9KIDWQud
         p1AeqYPSJtCLXdErLc+Vwf12CThqqWaIDaGjjkKQYp7UNNLmPE3HsLGP9VFtZTy/hTwk
         FGaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756906228; x=1757511028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9kY4ld87xkJ109VN1e4fZ8Pvba4PV6yLWSNAEFQE588=;
        b=SRgRHmNBdccfj8hvq0AVKRNuwUnnqwMPRX+0PEurIswdL+Izjep1sc5JiHHtfSZrZX
         82O+r3LwkPlGaB1JGRymKpquRXK3RnQYdnu7yFDPJCSM4mVyi3XRX60BW0flYWQeT+Ng
         c4Rlcjqt3zqvoqPiIDuvxToopThDp0Sl8E/6VGJQIYNpoQv7HFOqrwzFVfseIasAFA0d
         acNjTLui0Xl+JZkERWsXEdcXwL9bUjX1huslhUmE8O9zwmeBuHLMw40ZlPYnB59SVhon
         pjpzH+bAhkRKJHyOgljO1wc2qGpvlfybrqwziqqUfpjuQeuVd7KaVMTiFK/sseNsPZmF
         4Q3Q==
X-Forwarded-Encrypted: i=1; AJvYcCV/HV97cwEGBTfUJODCJPtp0PlmjTisqQ/9lpb6sJD6XNEt7DBRH4Y9POh4kqjCI9/yOLs5VF5s5LjssQ==@vger.kernel.org, AJvYcCX32MDaBsC13NVkSCJoa90/IlmVLcYmEmec0lcWyCB5V3GJBOUtRd2L9Pxges5AIIkrX57gbuwPHbl5@vger.kernel.org, AJvYcCXPsN2b2nMo9mGe3DSKMiEgSFv8e4A9NONUVdCV5N3pl5//WU2ueCyMe8nxomRAUk9/4eIl6twPEyFaYd2O@vger.kernel.org, AJvYcCXa2zvyg5oaqwtb+Zh7pY4WuyF1v0ZFynVgDZT/lEylKUKrdztPJisaD3H2xUE6wHRyEyjQyDuYo++9@vger.kernel.org
X-Gm-Message-State: AOJu0YwwQEHNiaa6G4pnBFR5NbZW+ywVg4JdFgoip9MU/LaZaDHIkGtH
	pwMJwrxcTg5RNwx0YrQSGJxLhj+RvDYBAp9LrKwFqaWYsIV9HP8XMpooiAkNOUvt3ATl1osVKzu
	HNyC5EV+XmKM/vToHYil9ogbNWlRAGFs=
X-Gm-Gg: ASbGncvtl9mUcCX97rbRv00gUalkHKLYkZ9o7vQa38irIrDJmdIl3jjHmWwPnv6JaZK
	WJFi38FPkeu38LtZDhl4eHNyYMqbcJ05tfqqa4jGkhIfsYWqZz/WSU5ffVYlOeNtxM1dKG+I+Vv
	/zWyW22p5F4+B8GmWwRCvfTIuB7YNRXq8NNr8GOwKVV2jORyrmpekJpiyMczlh7L8B0D9x8RVUs
	8x2k5ypRteY3896RDuv
X-Google-Smtp-Source: AGHT+IFi3i9QappuV1Dxsy0Wf3FMyqqZE3MA60vyMDHwbi3OD+mCvydMq+joyaZp/sQKizttQjpuUyL0BU+nG4cZmoI=
X-Received: by 2002:a17:906:9fc6:b0:ad5:d597:561e with SMTP id
 a640c23a62f3a-b01f20c2808mr1493846766b.56.1756906228106; Wed, 03 Sep 2025
 06:30:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1756813980.git.mazziesaccount@gmail.com>
 <08929460fe11dd0b749c50a72a634423f13f4104.1756813980.git.mazziesaccount@gmail.com>
 <aLb8HuIG0XXLu653@smile.fi.intel.com> <00ee1968-a471-4d2b-a024-4bee00e40513@gmail.com>
 <aLglJoqBDap_eMIj@smile.fi.intel.com> <10c6b0c4-d75f-494c-bb3c-883c06cf3bc2@gmail.com>
In-Reply-To: <10c6b0c4-d75f-494c-bb3c-883c06cf3bc2@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 3 Sep 2025 16:29:51 +0300
X-Gm-Features: Ac12FXztiXPEVydU5mzlqQ25Dyf9oVnKji_S6mRJICGVz4OIiv4RxuoHYKEGzMA
Message-ID: <CAHp75Ve4vgU5kK3z3bZyGqDOPVkMbW7RUd6_EA3jjZSeruWs=Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] iio: adc: Support ROHM BD79112 ADC/GPIO
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Marcelo Schmitt <marcelo.schmitt@analog.com>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
	Tobias Sperling <tobias.sperling@softing.com>, Antoniu Miclaus <antoniu.miclaus@analog.com>, 
	Trevor Gamblin <tgamblin@baylibre.com>, Esteban Blanc <eblanc@baylibre.com>, 
	Ramona Alexandra Nechita <ramona.nechita@analog.com>, 
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>, Hans de Goede <hansg@kernel.org>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 3:14=E2=80=AFPM Matti Vaittinen <mazziesaccount@gmai=
l.com> wrote:
> On 03/09/2025 14:23, Andy Shevchenko wrote:
> > On Wed, Sep 03, 2025 at 09:52:02AM +0300, Matti Vaittinen wrote:
> >> On 02/09/2025 17:15, Andy Shevchenko wrote:
> >>> On Tue, Sep 02, 2025 at 03:24:31PM +0300, Matti Vaittinen wrote:

...

> >>>> +static int bd79112_probe(struct spi_device *spi)
> >>>> +{
> >>>> +  /* ADC channels as named in the data-sheet */
> >>>> +  static const char * const chan_names[] =3D {
> >>>> +          "AGIO0A", "AGIO1A", "AGIO2A", "AGIO3A", "AGIO4A", "AGIO5A=
",
> >>>> +          "AGIO6A", "AGIO7A", "AGIO8A", "AGIO9A", "AGIO10A", "AGIO1=
1A",
> >>>> +          "AGIO11A", "AGIO12A", "AGIO13A", "AGIO14A", "AGIO15A",
> >>>> +          "AGIO0B", "AGIO1B", "AGIO2B", "AGIO3B", "AGIO4B", "AGIO5B=
",
> >>>> +          "AGIO6B", "AGIO7B", "AGIO8B", "AGIO9B", "AGIO10B", "AGIO1=
1B",
> >>>> +          "AGIO11B", "AGIO12B", "AGIO13B", "AGIO14B", "AGIO15B",
> >>>
> >>> Can you make all of the lines to be the same in terms of amount of en=
tries?
> >>
> >> Maybe :) I would like to know why? As you know, I prefer to keep lines=
 short
> >> to fit multiple terminals in parallel, so this will probably make the =
entry
> >> to consume more rows. Thus, I would like to have a solid reason.
> >
> > Sure, the array above is unindexed. It's prone to errors and typos.
>
> Ha. Thanks :) I see it now when I count the entries :) Should be 32,
> was 34. I agree this would have been easier to spot!
>
> > Moreover, it's really hard to follow in case one needs to debug such
> > a typo and see which value needs to be fixed (imagine you typed twice
> > the same name).
>
> Or, if I typed twice the same name twice ;) Thanks!

TBH, I even haven't noticed that the array _has_ already mistakes :-)

> > Recommended way is to use power-of-two per line (and even add a comment
> > at the end), like
> >
> > static const char * const chan_names[] =3D {
> >       "AGIO0A", "AGIO1A", "AGIO2A", "AGIO3A",         /*  0 -  3 */
> >       "AGIO4A", "AGIO5A", "AGIO6A", "AGIO7A",         /*  4 -  7 */
> >       "AGIO8A", "AGIO9A", "AGIO10A", "AGIO11A",       /*  8 - 11 */
> >       ...
> >
> > (or hexadecimal offsets, whatever is better and more in accordance with
> >   the SW / data sheet).
>
> Ok, This makes sense now.
>
> >>>> +  };

...

> >>>> +  data->vref_mv =3D ret / 1000;
> >>>
> >>> (MICRO / MILLI)
> >>
> >> I find this much more confusing than plain 1000. (I know we had this t=
ype of
> >> discussion before. See [1] again).
> >
> > Rings a bell, but that's what IIO reviewers suggest to do nowadays as a
> > compromise between creating a new bunch of unit (V) related definitions=
.
>
> I am sorry, but this just seems stupid to me. I'd say that it is very
> obvious for most of the readers dividing microvolts by 1000 results
> millivolts. And if it is not, then having this MICRO / MILLI is likely
> to just cause more confusion.

No, it tells that we have a value in microSOMETHING that is converted
to MILLIsomething.

> I _really_ dislike these defines. Why is MILLI 1000? Why it isn't 0.001?

You know exactly a few reasons why it's not.

> It makes no sense that KILO and MILLI are the same. Especially not when
> we are dealing with physics.

Yes, this is the limitation of computers and particularly of _a_ kernel.

> This is just an obfuscation compared to using plain 1000. (I kind of
> understand having a define for a value like 100000 - where counting the
> zeros gets cumbersome, although 100 * 1000 would be equally clear. But
> 1000 _is_ really 100% clear, whereas MICRO / MILLI is not).

See above why this way.

...

> >>>> +  gpio_pins =3D bd79112_get_gpio_pins(iio_dev->channels,
> >>>> +                                    iio_dev->num_channels);
> >>>
> >>>> +
> >>>
> >>> Instead of leaving this rather unneeded blank line I would move above=
...
> >>>
> >>>> +  /* We're done if all channels are reserved for ADC. */
> >>>
> >>> ...to be here
> >>>
> >>>     gpio_pins =3D bd79112_get_gpio_pins(iio_dev->channels,
> >>>                                       iio_dev->num_channels);
> >>
> >> I suppose you mean something like:
> >>
> >> register_gpios:
> >>      /* We're done if all channels are reserved for ADC. */
> >>      gpio_pins =3D bd79112_get_gpio_pins(iio_dev->channels,
> >>                                            iio_dev->num_channels);
> >>      if (!gpio_pins)
> >>              return 0;
> >>
> >> right?
> >
> > Yes.
> >
> >> I don't like this because now the comment suggests we do call
> >> bd79112_get_gpio_pins() only to see if all channels were for ADCs. Thi=
s,
> >> however, is not THE reason for this call, only an optimization. I thin=
k:
> >> having:
> >>
> >>          /* We're done if all channels are reserved for ADC. */
> >
> > Then you can amend the comment
> >
> >           /* If all channels are reserved for ADC, we are done. */
> >
> >>          if (!gpio_pins)
> >>                  return 0;
> >>
> >> is clearer.
> >
> > Which makes my approach sustainable.
>
> I like your wording better, but placing this comment before the call to
> bd79112_get_gpio_pins() is still more confusing that placing it before
> the actual check:
>         if (!gpio_pins)
> is still misleading. Comment applies to the check, not the retrieval.

The variable assignment, or i.o.w. the source of the value we are
testing is also part of the equation.

--=20
With Best Regards,
Andy Shevchenko

