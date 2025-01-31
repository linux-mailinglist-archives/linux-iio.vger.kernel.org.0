Return-Path: <linux-iio+bounces-14797-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D41A24558
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jan 2025 23:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CDCC3A372B
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jan 2025 22:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BFA1F0E5E;
	Fri, 31 Jan 2025 22:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NZD5N+cS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5469189906
	for <linux-iio@vger.kernel.org>; Fri, 31 Jan 2025 22:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738363568; cv=none; b=bx95Xa19YviIL0v6C9E94Y3NA+kCliKv15304+b3ypus7v8EV5OVlEqoCQw7J9zBTgWLz7Gk4p1ZwEmbR5HbOsrc7IZQujYoQm0hnQXuFVeyE2r0Vz1s6kpYvwszVN0Pb10jbgUu+ir40NDYNkP0IX0cTZU29qBdW5B+LoxpGzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738363568; c=relaxed/simple;
	bh=fV9hhrVRP+qzrleYSIWXpKoYEuxlmibMFIbjPlpYr2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xh+W3dpn+3D9Yy2JsKnR39E+oUSyISNsmhGT16jV2zt5SbYlbbKp0zhsuaBRbYgp1DDEmFofQ53t61kM3lq7q3zapHqO8CUL1Dy/mMcjPPCXjlb8PXDSiLAAH1xTZr7iZTUpBGgu/9NyDNGozGpmpEgVoWrQtCRND6DV2dHdrBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NZD5N+cS; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30737db1aa9so23249061fa.1
        for <linux-iio@vger.kernel.org>; Fri, 31 Jan 2025 14:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738363565; x=1738968365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fV9hhrVRP+qzrleYSIWXpKoYEuxlmibMFIbjPlpYr2A=;
        b=NZD5N+cSwgVpbp4uBKSqg9Ag0t7Oh4RA/lD0W3UwbFHWlduW2tIowWiv6HwJBhUViu
         xSuh4Kje+bigOiOnBVSWZDT9VJXlhLagMHAUEt3NEfB0hwA9nNvX8kSTyeMTKHxw9yfj
         2rGKONg+p1SpUW6udf14oHRIPfnrGXTD8eYwEzaZaiDCgXJZzTH743+hl0zqAVEXITbx
         R/56S+Sv2LB9ARZKAfSI+pU+Zz2QkHjOEGj1XrtamsQO7VLQbPmaZ27VBJFl/uBnoSWA
         u5IMRUwQcuazoVgnlNRV3UBcRy6Z1bB71Y+sxxmOty/Foo4vtnmr2VEsq5IGcAyjRxJ4
         hw8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738363565; x=1738968365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fV9hhrVRP+qzrleYSIWXpKoYEuxlmibMFIbjPlpYr2A=;
        b=XPpnZg/l5nI25hx+P4zbL7IfgIFl9cGhIE2JqC58frbMJhQ+wLRSMjbojrwWxnXMz9
         xJeAPOE1icT4DnYzooUpYd+bhQR8G+TZii2M5YsHzJHpepuhD6BYFjnwKoUUzaly1mXm
         DkevRGUtMh7tcvSKu6yGvBJUKZfImcjUSNIrlmZu7G8ffqw1L16NMbVbq6eph7w4nPX8
         fJp3eODlwhCKHA7SS3YK6u5h5c548oUoOSNbh3gS+0/pAjcnPxi0Ctmi0p/d788+Hupq
         5LEwRGeL7khR9u+oF7HHhTQ1zmKqpHbuMj/tLFnU+AlVsyc6VijVYR5woRR4JXBmGso8
         mh2w==
X-Forwarded-Encrypted: i=1; AJvYcCVNxjltj/p4jAYJ1xlmAyYpdBMkde5K9/hmj0LEmAiYzcB5drqYceTHs3DD2RznbxoZ0U+ZFGMA3LY=@vger.kernel.org
X-Gm-Message-State: AOJu0YySNzJIOTp3Lmo3kX6V8oAZkbIg7uxF775goJRjEoe6M3lniH3p
	cgO/ovJLL4sua0dd/3bBfn3PUgFiPTwDrYDCis4bvQKJxcgK3xqOthpF6x3PaVJtYTi+CJHa/Hs
	Pgcxse0qytI93AEbk3BjAOhPEbX1ayWtsdmqv3Q==
X-Gm-Gg: ASbGncs11S0WLIHbEZtu9lXcT4GXciwF7nhhoYS1P5fqpZge1GjDCBEg+b/9bLV+2fw
	PCXrB/k+nOUzl+amMN5j2Pyx3cyZmXTqzAvg45R86Ppm7NnPWpSUWd3ZH27lIxN0jEFIuXxQ=
X-Google-Smtp-Source: AGHT+IHHYjxVhba4NRZORQamjtU7NeuHHIHelxxj9O/XIYBIqNCjtNKWK69c7J1JA7YkTDGQPCWMRncUBp/ITQdEaIo=
X-Received: by 2002:a05:651c:897:b0:300:1c9a:80ce with SMTP id
 38308e7fff4ca-307968e0098mr51916141fa.33.1738363564658; Fri, 31 Jan 2025
 14:46:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250131-gpio-set-array-helper-v1-0-991c8ccb4d6e@baylibre.com>
In-Reply-To: <20250131-gpio-set-array-helper-v1-0-991c8ccb4d6e@baylibre.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 31 Jan 2025 23:45:53 +0100
X-Gm-Features: AWEUYZk_dyG4cveXgq-R2QdDjI5W5xxfEw1ByFh9vnHwzlCQYvkaIUdRlN711z4
Message-ID: <CACRpkdads3+XQqvZDJXmYHDLGfRK0H_S==72uqkuht2nEX1+rQ@mail.gmail.com>
Subject: Re: [PATCH 00/13] gpiolib: add gpiods_set_array_value_cansleep
To: David Lechner <dlechner@baylibre.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Peter Rosin <peda@axentia.se>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-mmc@vger.kernel.org, netdev@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David,

On Fri, Jan 31, 2025 at 9:24=E2=80=AFPM David Lechner <dlechner@baylibre.co=
m> wrote:

> This series was inspired by some minor annoyance I have experienced a
> few times in recent reviews.
>
> Calling gpiod_set_array_value_cansleep() can be quite verbose due to
> having so many parameters. In most cases, we already have a struct
> gpio_descs that contains the first 3 parameters so we end up with 3 (or
> often even 6) pointer indirections at each call site. Also, people have
> a tendency to want to hard-code the first argument instead of using
> struct gpio_descs.ndescs, often without checking that ndescs >=3D the
> hard-coded value.
>
> So I'm proposing that we add a gpiods_set_array_value_cansleep()
> function that is a wrapper around gpiod_set_array_value_cansleep()
> that has struct gpio_descs as the first parameter to make it a bit
> easier to read the code and avoid the hard-coding temptation.
>
> I've just done gpiods_set_array_value_cansleep() for now since there
> were over 10 callers of this one. There aren't as many callers of
> the get and atomic variants, but we can add those too if this seems
> like a useful thing to do.

I like it.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

for the series.

Yours,
Linus Walleij

