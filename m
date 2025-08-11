Return-Path: <linux-iio+bounces-22594-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DECB21525
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 21:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 556F07A99DB
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 19:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7602D9EEF;
	Mon, 11 Aug 2025 19:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NlSinD29"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1041D288C12;
	Mon, 11 Aug 2025 19:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754939313; cv=none; b=sZ4ePY+sOSRnjVz+hJ4vP8yvFIC6W81e9vg9mlqn1kKDXragrKwgGVp+QdP/8TsjcWVH4lZI21eDalbQuivhY/lA4ZgXGLbTELuZ7Cw9b68Ls6zJw5q2/ZwcOXvvCDbeHEF0c2G8ZbDB02bpnO2ZIzGW2nmzcSAS72m/cOLPsXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754939313; c=relaxed/simple;
	bh=NHQSVnc5+tACV3yqddnCZc/tQspWSnzMjasUFcwRzFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ax7wn/8yrr6tGSFM95UVKRkuCXZHAgsqqc3wA1xm1ryCQqca3E4YFA1hwT9SKG3LYsvJDn2MIUZtYunn+3vAvVQRrfS35FLb8dHeWNUX3g3l7jtaXfGTvdOxMcAFFA0UiU8PGqKLeSC8fVfFR+uylY3/49q5+CwGqmX21rcbk5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NlSinD29; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-af66d49daffso790650366b.1;
        Mon, 11 Aug 2025 12:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754939305; x=1755544105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3NJk4h4fsJ5/xDMCZWar+AJr9mE49P7ldYeZaehXKkM=;
        b=NlSinD29ztInfvnRh6xNk1S1t8P3NF/kl3dMFq2ZCCxKXAx0ifPfKFxHv9X3+8mdLE
         Jk0CT6WGvbMAmOzsxDhQd2xpwmEaOJ2qK2sIApz9zZ9pNij88TLLSAS/qSKkawgx6Qva
         R1yn0mw07LdDHlNvHfTQMi2/z6N3XI17RcziZdvFtmXwB4i/6BDHQTeqA8DF+5Jfpu1h
         4cgRRe0C93s2crpuLtsPGGuu93JSlLIMaf2G03yy/Nj+1XgZutFv751RliPYwSj7OKUZ
         oOsyzsexINH6bkNgDkJzNTN93WaeoXqA3iM0GId/Ul8RryTxANNJTHjRmGi2QnGMvg8c
         LuVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754939305; x=1755544105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3NJk4h4fsJ5/xDMCZWar+AJr9mE49P7ldYeZaehXKkM=;
        b=S6rktY+ustraGECCLXbNo356ToHqjyFrDj78KWigFlFCIVUqP/FQoSrYsHaDf0J4TA
         0vUhQm5TBJ5svykYgvIraICJ4sDy7HkiM1PjA8orLru5qf/QYXAhNu7ke4zf/2H8OxH/
         vvfxgpQ4jznuM2KubYQCh76ikeole9f4VUuW/pC+wmvBlepK0LiR/MXePK69btdUQUH4
         nDYxXJlQfpIpELSehhBxOfIU2BkK26BTrq4DieCUBhRIRok9K7xsZr1IH04+Uv2rGot2
         chHZk02n+qKZve5k0UtPT0yBbjfKEpe85o/dHdcofIT3yv/Ro5ZwwsYtsyDT/r/M1VJ2
         5pyg==
X-Forwarded-Encrypted: i=1; AJvYcCU3MWvt7nOhbfKuWv435rTEeh77GVGQnb6fhvQAbLdEx+p4UyavjQkrY9/uoT6B1Dx1B3FYI9Bgd8yHq9Cm@vger.kernel.org, AJvYcCUOuCChSsAySAQm69DA/sUGkg2Oew0aSl9PRl2QfGfnJdKEVXvorjilISJJV3V3NlxxCrf7ontS120=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgWspOfza2MaqeDtGXULt4rnOF+4G16situD398DEbO5nNW5DY
	1FNc7wyV2Qmrgeq9kbCKmwhS+SR4BEE/yfmZNShy0o5QX1vwBmcktfPfqs9Y9bv8fZ4DCUo2IU+
	SF2jvHaE4GHy2C5290kG9ts8dOWLsq9o=
X-Gm-Gg: ASbGncuuvtuahZ0gs3duo5hIhzhEGd0ppXqeB/cOGD0qMmIwTMOzn95nQPtSmHMbYRT
	z26tWWSQr8eRVLC1Pn0xTP8yMLTCETkHpxlZz2Zc8aQYxCX1XW3PSgKZCu9Km/LDlAzPHGqvGjB
	sNLzuX+zdz2J0qwE/e1eq+xnjqzBxuLptUlwEPPz4WF0UQJzSwHfwAU6iqUa23EBkW6V1DzfBdr
	AQbzDv2Ig==
X-Google-Smtp-Source: AGHT+IHLbgyTqPIe1rLnsQquscLMx3yX6mJjAryYPpGCtXZv2P23eDwUTQ6d3YbnJoQMq5v43w5rvz2ozkfWgXvAWeM=
X-Received: by 2002:a17:907:7f12:b0:af8:ed6a:a9c6 with SMTP id
 a640c23a62f3a-af9c640e32emr1143102566b.20.1754939305051; Mon, 11 Aug 2025
 12:08:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811-iio-adc-ad7380-fix-missing-max_conversion_rate_hs-on-ad4381-4-v1-1-ffb728d7a71c@baylibre.com>
In-Reply-To: <20250811-iio-adc-ad7380-fix-missing-max_conversion_rate_hs-on-ad4381-4-v1-1-ffb728d7a71c@baylibre.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 11 Aug 2025 21:07:48 +0200
X-Gm-Features: Ac12FXz-j2X-yjzU8w23g1OeQ3kOpA2cYoHVVaXRdUW_7bY4aftbWUkZlzhT0ws
Message-ID: <CAHp75Vc_-2czsaZ_-3+cSWAzyvz-PASR5mjCyoAxTu9qSEYyLA@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: ad7380: fix missing max_conversion_rate_hz on adaq4381-4
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Angelo Dureghello <adureghello@baylibre.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 8:32=E2=80=AFPM David Lechner <dlechner@baylibre.co=
m> wrote:
>
> Add max_conversion_rate_hz to the chip info for "adaq4381-4". Without
> this, the driver fails to probe because it tries to set the initial
> sample rate to 0 Hz, which is not valid.

...

> +       .max_conversion_rate_hz =3D 4 * MEGA,

MEGA --> HZ_PER_MHZ

With that done
Reviewed-by: Andy Shevchenko <andy@kernel.org>


--=20
With Best Regards,
Andy Shevchenko

