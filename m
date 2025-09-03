Return-Path: <linux-iio+bounces-23676-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F246B41C8B
	for <lists+linux-iio@lfdr.de>; Wed,  3 Sep 2025 13:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3B253A92E9
	for <lists+linux-iio@lfdr.de>; Wed,  3 Sep 2025 11:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D90B2F3C30;
	Wed,  3 Sep 2025 11:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qg5e8DUp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4448E2EA14A;
	Wed,  3 Sep 2025 11:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756897358; cv=none; b=PrvATV8XsLrh47tKYn+uGzHXaxtCkiVZDC5WF41CIPivBme7qDK71BXcEzVDoCVdT3XKJ9edLlo1GEfYtcIfw6Fzy5P0gde6Mfrq6yTKzzOcjEBJpbD6kWI4QUz5iWbEeqL+FJ/f4RWmW75NHM96+yiWAwm80nkQNvZ8RFLWfCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756897358; c=relaxed/simple;
	bh=vb7SylUAbX23LuW42xkdwkf9gBZtj/UNNDx/esBIVek=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LlwGBtCh/XS9snT/O3Zz6ltu1PjfXMOefHoNvKhxA5ogqnk8oY2WNyJ4OjMY3o4qb8VUk6XkUiGee5vmFZZomyfCDSqMXNp2FMwwKv7omk8RQn/Pz0mfKlDlnnahHfH8IjpFYi5r+YZLGSJ0HVjMW+RbmoNA7ly9KQQigreeNXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qg5e8DUp; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45b7722ea37so4758025e9.1;
        Wed, 03 Sep 2025 04:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756897355; x=1757502155; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vb7SylUAbX23LuW42xkdwkf9gBZtj/UNNDx/esBIVek=;
        b=Qg5e8DUpUEje1q57hwLfmPvxmhoFfIhZdJS3JLUV0Vdc6OVlMUOf5v40BtOPCDlTJi
         XUt9UddWLPjzbg4zi6idNfzBxq7IJx7qlYiW60akD3GvUoLK5Knf7EXCm5PQ7LB1pHkH
         L+WdOqSZTdjdjuxBj+hHhUJALdFhsGEjdgs/MWBpsFIyKNlDFGB3eDz6J/HQdGpeRZc7
         QFvi9WR02oZ7gmJSnxjMK5KqKYl3cjBaFZwGZgf+oZbcTdBH0XzY7WlIg0zpV1YlEpvI
         4ZF6hL/p0mBLAwzGCthI4SFa1hyKvJqnJDP9zeAOzjBOwlPqeqL8EGj53oBdnBnOpPCv
         xJtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756897355; x=1757502155;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vb7SylUAbX23LuW42xkdwkf9gBZtj/UNNDx/esBIVek=;
        b=ftUAYHDW9IIKU+YZU7/tQRM3gws9sPeHYOsb/sqTkrvEYW4VYvXssSqHkh3/9eg/1x
         EEUWs+CxCHN3xebGGsHeFaW5O0v7Pf5Wng2FZ+q14lkI0swo/LG8zbrshpdwAKfXjjBM
         MTW/OLW97pVkLuXjnQAmJxM0S3eWnvN0ieTkMiFhPmbdlkazV6uZ7SyZjK0O9QRB2B5P
         ZquWJmFqhTH3zGRu8LMa0TGtnABsHgU9XnrjchNsZ4fs4O2+f67XBqBjnn5KCsvnkar1
         +6GESjWZuLeF/OoS/a27itq9n/E/o3UlO09boDvXNh+h+5oyS5T1etN0uNnKuoKYHVU6
         1yPw==
X-Forwarded-Encrypted: i=1; AJvYcCUYJrnqPE8IDtmdzTq/LTL3ulxNOyL8Lmj3Ciy/+W888+kvcNfflNT877kAYV7ZthgEOfRyEGUm5M+0@vger.kernel.org, AJvYcCVHQ8L/hqEBmCFAevDMUViwK4DMA6j/pUsGJnz5+dJPXAtLhnfwjh5LOA43BEDhlSEF1qNsB3jrwHnq1A==@vger.kernel.org, AJvYcCWWa9uKebtIJPxJNfdu6bnu3M/eyXNsWQD2Fy22KNqdxQfQpxoWtUDx2xBkpSyp/0BXEoaenZSPK3704dDd@vger.kernel.org, AJvYcCWu1hhH+qdZGZarctdIEZ6QwhFN3H6EhQ0tm27IB9WgsVsZaOcy+ZDKVLu7MvbdekgBtDZaseJ1g5qy@vger.kernel.org
X-Gm-Message-State: AOJu0YzA47b6lw5yRTcx/6JQtprUgUvHzjn6CU/Y/E3eyt+zGtK67lMl
	IPcpjMKIOBGOvpjRQrMTUX/Z2f3rmplCwaqbXC0g7fNEa//qkelG8YaK
X-Gm-Gg: ASbGnct6NTq/j1E53Opm0AA0K7kCLLOHDutYThx1Igs5OUJGHXrrCaG2ovi+mo5LvDI
	dfjJ9ukUobgEEmC891eL1DmPg8e3T7901D3M41jhuqKe9AYzARBt3lpKzULTGkgB2rCGt2sP5lr
	nCP6Tn9QooGCMyOJIn+ubLr+d22rwn3EBnPkM42+IpnTrim7xrq9WcRBM9nseGPmh9aj0R5NKhi
	Im+IsjVhxNvYw7D7YDfWQmOauv9cnUZjydWupEPn1oBrq7Dp9vHMBC2REZlXDIZ6XosE2ZfBdi3
	uaHpl9DPggE3RUQV2//RtKJVe9wKQV4lQdilosA0scAXZqcR5dZaR1FlxVR/bBb8M7QuNsWE0Rx
	OnTb/H6NQ4wNxuh0NGbgodDtgTGdIfUm4NJk=
X-Google-Smtp-Source: AGHT+IHDL02xd5pdSPuKxzWpHg6hzSioQKDNS6ot7FrvSDadpKSjoTT4GmvYdN0GJxGhByTgcWLGFg==
X-Received: by 2002:a05:600c:4454:b0:45b:47e1:ef7b with SMTP id 5b1f17b1804b1-45b855b3ffcmr138549905e9.17.1756897355138;
        Wed, 03 Sep 2025 04:02:35 -0700 (PDT)
Received: from [10.5.0.2] ([192.145.38.183])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b87b3900dsm100274475e9.0.2025.09.03.04.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 04:02:34 -0700 (PDT)
Message-ID: <908feb42783fd182c8b0f22ae5c147de2f7a60d2.camel@gmail.com>
Subject: Re: [PATCH 2/3] iio: adc: Support ROHM BD79112 ADC/GPIO
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>, Matti Vaittinen
	 <mazziesaccount@gmail.com>, Michael Walle <mwalle@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Jonathan Cameron	
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Rob Herring	 <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley	 <conor+dt@kernel.org>, Bartosz
 Golaszewski <brgl@bgdev.pl>, Marcelo Schmitt	 <marcelo.schmitt@analog.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,  Tobias Sperling
 <tobias.sperling@softing.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Trevor Gamblin	 <tgamblin@baylibre.com>,
 Esteban Blanc <eblanc@baylibre.com>, Ramona Alexandra Nechita
 <ramona.nechita@analog.com>, Thomas Bonnefille
 <thomas.bonnefille@bootlin.com>, Hans de Goede	 <hansg@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Date: Wed, 03 Sep 2025 12:02:56 +0100
In-Reply-To: <CACRpkdbPzq6yKMHJXaFmXZSsttUkt5OAKRTSc_pjLwZZiZr7Gw@mail.gmail.com>
References: <cover.1756813980.git.mazziesaccount@gmail.com>
	 <08929460fe11dd0b749c50a72a634423f13f4104.1756813980.git.mazziesaccount@gmail.com>
	 <CACRpkdbOhm4PawYZUxU1SMi8WGr-LxhR1jhSVPDvPh3TTp8SWQ@mail.gmail.com>
	 <ffef0fa6-45e4-467b-b264-1df15754d213@gmail.com>
	 <CACRpkdbPzq6yKMHJXaFmXZSsttUkt5OAKRTSc_pjLwZZiZr7Gw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-09-03 at 08:47 +0200, Linus Walleij wrote:
> On Wed, Sep 3, 2025 at 7:23=E2=80=AFAM Matti Vaittinen <mazziesaccount@gm=
ail.com>
> wrote:
>=20
> > Anyways, fast-forward to this day, I don't see it handling valid_mask. =
I
> > think it is a must for this device/driver, where pins can be either
> > GPIOs or ADC inputs.
>=20
> Why not just add a .init_valid_mask() to
> struct gpio_regmap_config so it can just pass that
> down to its gpio_chip?
>=20

Hmm I guess I'll get a similar comment on the series I just sent [1] :)


[1]: https://lore.kernel.org/linux-hwmon/20250903-ltc4283-support-v2-0-6bce=
091510bf@analog.com/
- Nuno S=C3=A1

> OK I don't want to load you with too much extra work for
> the driver, but it seems such a small thing for a blocker,
> and Michael who wrote the library is really helpful
> with extending the code, so consider it!
>=20
> Yours,
> Linus Walleij

