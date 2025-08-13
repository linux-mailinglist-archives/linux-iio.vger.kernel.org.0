Return-Path: <linux-iio+bounces-22650-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EF2B246E2
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 12:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A7BB3B787B
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 10:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA662F3C37;
	Wed, 13 Aug 2025 10:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QCmEod8A"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0DB212560;
	Wed, 13 Aug 2025 10:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755079633; cv=none; b=R8bolhae+znxd7uIuRjWlmhU2HUJ539Buyn8xBuJcqY+SAo+97lyt9y/uS4+polXqg9tweidGjVzk5HUWawTP1MDVlxKasIHNS8kA/Zd3TeGAD2EskJiQU+4JjCKzYthfaW/A9wzxgcXlZLZCRea1EediEwIpF1qdeTtx0LNA7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755079633; c=relaxed/simple;
	bh=qIFMU2TGOcaGmue3LZ1tJeI17oYWcCMOjO1dOq88nec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t6S1QNdJCg7E3p2/mbGFFx1MVP1jWRVylXkBqpwYNAOSUa1uk1hJaKm4QWkxaWgb6XtgTKYsml70CM6ogI130elgrX5AwEHmLTRHzDBjPZFO+XAPSyGYcGwiFW9qV4ejySHMAbbzph/HILWZp9r2T0isLPdOadFgx9lpqe7uR3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QCmEod8A; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-61568fbed16so10124474a12.3;
        Wed, 13 Aug 2025 03:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755079630; x=1755684430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qIFMU2TGOcaGmue3LZ1tJeI17oYWcCMOjO1dOq88nec=;
        b=QCmEod8AoKj31GIjW7u0S2ahXE7jGGQttMSA4XxM1Xl5hDsTnNmujQmv0MWmgeJdP9
         lib9tTLJlSbOK4zd+rMoDto4GRDkSsIgJeCEWGN7TzAPgnXjg0wDy8FbmNHizUa6QNwp
         UjvUmnxKaVDW15CVkX6Zy+Kwtso4ZyfRHQwiCv3JfFU3rMQfQjesri2zPnrujvsY8foL
         papusU225BvkBo6nz7PZxvNQBMqSA4jG9dYzbllpSyEd48B5UVE2FJbaVE1q40HAun7y
         1IT5VThDbtkH1WOO58opZ5Nt8zpHIbmqfYTAciLQnVnWx6Gj+7uDI/A7m4lTvZAmonyQ
         c3mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755079630; x=1755684430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qIFMU2TGOcaGmue3LZ1tJeI17oYWcCMOjO1dOq88nec=;
        b=jtGFFv9zFnj6+4uL+Tt4r9x5JS3LtyCFZoHJzpkEYPWvG7a5pWfFjv4bS40uOCrQ5u
         nsbajnOIZYj2GsYWuvAYCTvJTHsTbOXHetl2LGT+IKyBA+LQYp1uzpu3oHBxZhNCO+xO
         mdBtDx4E0JHOnV1YmfOMBjx0ksgyrrj4uzxsIeVAA8xhIahQ4zYd80I3Jlc3ZihoVl2S
         0lI7Qj7qbqKnJplF1hzYjmFuOVN3TDc3hMTzfJoum9w5H76jIqrkx19d19hjUhUp6lwd
         viKhjZrDTQ0wnGs2rVqVwOUrnpvfwNMpsHrkuvhR96dOWvd59Y7Ctc6kOnIV1T97DLIN
         xkPw==
X-Forwarded-Encrypted: i=1; AJvYcCURHErWpPP4H343nQ/K+GRLfXgwFYxbglHS6TleDY6n1wuMhs8jzeCnWWEE8wgSBcKGKuEqR/Gb8LF7MelB@vger.kernel.org, AJvYcCUq7t2/5ctp9vMNRc8FZlNMoOi11KN6QKbU8WhS9kWSWZlkgpr01eAvJFPRwpUIyo+YD7nI/V7c8Bq9@vger.kernel.org, AJvYcCVrYcc48IIR/Bkb7kGsVF2Drjhem0ZU/q/aBNZCGklbgeX5dARwZuWynmp+Rk9xdkdlydtK4OTipG21@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7IA1NSTZ4XYHWyRxU1jAqzRMnkc9SUQRcW1oB5JbwvSB7YiQY
	sNARBaTbjlB/vWyctFERUzUvtQD17+vBOzkjgV/x1dWE6OJleElFS7g3AomEAgVk72Od1RGG/w5
	v6crEdEk5S6IiKpEXqEnidRxC+AX3ERs=
X-Gm-Gg: ASbGncuZl80u7SuygDQX9Kj7LigbpNOr5PX2SXu8V4zy+iEsYCsUCKRTSK+vcqbSNuC
	RYk7lel8Vpp+jmmHQ/dB7VrIxuozFRlKeSYfj8+Mw0dD+1VGhXdPH18yRWpLA5L4+DZSZcl3tXP
	UJZozP3M9LAptIVImS3FpQLbj8CvuvpVNi2vdNUbsFmbr25IHmIeaUIra2g9U2hSPYTGOMhOn7s
	mt0Vy55bg==
X-Google-Smtp-Source: AGHT+IE9R9aISHn0jhZGhmYqKZ+gehmgCn9mgWnaSm8kG5ba1KPW8kAvqssBgYjBlNCnNCH+GBgf+xj81vdP49hOmN0=
X-Received: by 2002:a17:906:f5a3:b0:af9:a53a:6b38 with SMTP id
 a640c23a62f3a-afca4d19fbamr276153466b.20.1755079630120; Wed, 13 Aug 2025
 03:07:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6837249bddf358924e67566293944506206d2d62.1755076369.git.mazziesaccount@gmail.com>
 <CAMRc=Mf75cangdeg7T4E0nAhJs_BTdLyCu6GcrCL8vJzzAkFWg@mail.gmail.com>
In-Reply-To: <CAMRc=Mf75cangdeg7T4E0nAhJs_BTdLyCu6GcrCL8vJzzAkFWg@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 13 Aug 2025 12:06:32 +0200
X-Gm-Features: Ac12FXxJbFqzAEUvLoHWu1u9ELrl11kqJ-gmAZlNCwzAabXkrefeK7pGC1tMOPo
Message-ID: <CAHp75VcY9JWGH3+HmmJQQtLLTLPvaZ1RJzmPZ1wFBM+gqRiTHw@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: bd79124: Add GPIOLIB dependency
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Marcelo Schmitt <marcelo.schmitt@analog.com>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
	Tobias Sperling <tobias.sperling@softing.com>, Antoniu Miclaus <antoniu.miclaus@analog.com>, 
	Trevor Gamblin <tgamblin@baylibre.com>, Esteban Blanc <eblanc@baylibre.com>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 11:40=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
> On Wed, 13 Aug 2025 11:16:06 +0200, Matti Vaittinen
> <mazziesaccount@gmail.com> said:
> > The bd79124 has ADC inputs which can be muxed to be GPIOs. The driver
> > supports this by registering a GPIO-chip for channels which aren't used
> > as ADC.
> >
> > The Kconfig entry does not handle the dependency to GPIOLIB, which
> > causes errors:
> >
> > ERROR: modpost: "devm_gpiochip_add_data_with_key" [drivers/iio/adc/rohm=
-bd79124.ko] undefined!
> > ERROR: modpost: "gpiochip_get_data" [drivers/iio/adc/rohm-bd79124.ko] u=
ndefined!
> >
> > at linking phase if GPIOLIB is not configured to be used.
> >
> > Fix this by adding dependency to the GPIOLIB.

...

> > I am somewhat curious why the failure occurs only at the linking phase?
> > Wouldn't it either be better to have these functions
> > devm_gpiochip_add_data_with_key() and gpiochip_get_data() only declared
> > when the CONFIG_GPIOLIB is y/m, to get errors already during
> > compilation, or provide stubs?
>
> Providing stubs is not correct for sure - a GPIO provider must always pul=
l
> in the relevant infrastructure over Kconfig.

I disagree with this statement. The (provided) resource can be
optional and hence the stubs are a way to go.

> As for the former: it seems it's
> a common pattern for the headers containing the "provider" part of the
> subystem API, you'd get the same issue with regulators or pinctrl.
>
> I don't have a good answer, I'd just apply this as it's not a common issu=
e
> from what I can tell.

If the GPIO functionality is optional (not the main one), the user
should be able to compile it conditionally, in such a case it's either
an ifdeffery in the code, or separate module with its own stubs.

--=20
With Best Regards,
Andy Shevchenko

