Return-Path: <linux-iio+bounces-9722-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F39697E79E
	for <lists+linux-iio@lfdr.de>; Mon, 23 Sep 2024 10:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAB381F21A62
	for <lists+linux-iio@lfdr.de>; Mon, 23 Sep 2024 08:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E1119342D;
	Mon, 23 Sep 2024 08:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YmPukJah"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFAC188905
	for <linux-iio@vger.kernel.org>; Mon, 23 Sep 2024 08:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727080506; cv=none; b=rb+5FamyTkcF2tf6gPvWc9+6ViiNE/RNCPYsMs9LbCKHUHaUJJ4eXP9ufvafu7olKaUokWrvCZfSTxDBYohbHDElG4Y3O+62Gk54gFOpM2ybKr/IGitXAzns35JGkMnAwABYs07SHyBifE61S6u9d0obhoKGg4iWNzURzafYG0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727080506; c=relaxed/simple;
	bh=WCn0BjX16f0sbfaNXaV5vArZJvaoV0TjIkATMCuqyzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f7zRW28FIzKnz8vfwl/S+YozZlJ/V+LjtMRXcU8+bsqtuwk1Qw5ew+km19wFiKpqzSg6Xk0h84DFc/PJWqDjCp3nhWQJu0e6co2drsiv8eHRhoVwruCf7GdGq8GVAmaNGdXMEpIS+cmHqcCB4mvv8k22a7krpAz3oxNvRzrEN/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=YmPukJah; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f8ca33ef19so4226591fa.2
        for <linux-iio@vger.kernel.org>; Mon, 23 Sep 2024 01:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727080503; x=1727685303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WCn0BjX16f0sbfaNXaV5vArZJvaoV0TjIkATMCuqyzc=;
        b=YmPukJahIBWJ4D4MaecjXhemlkGwS2BQFoTIMwpY5qBktTKhdxV6pC7JK9D3Kbm7Qj
         4Ye7Lu3iMOEXaH5tIIAnozRmSFvUzKPv/hQzZY6UkFVGsTJPbYrGx8D2NhJa5TDeG1o0
         03yPubG8wZq18S+xZewQWlDNUl2Gr9/WoRkexoq34VQHHOIZiCv//i4+FhIOW//dnBJb
         e9bPsSvfcNh2N6VnUNVSM26N6hLcFdg+421bZfqqs3LfLxR3hXJvr9THWu9rIpiG4q5T
         dmqNxpR0WUSpbyuYqRJlNiAxWxiPNHxCXuPKpelwC9+DUAPXEW4+7n4o0YndBqNPfZag
         WLyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727080503; x=1727685303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WCn0BjX16f0sbfaNXaV5vArZJvaoV0TjIkATMCuqyzc=;
        b=a7aEeVU78soFWMbq+Nx1NAOYD4UZZNda5wHvjOnHduBFhfHwDAkLX9DGVqaQvFXMkN
         V1A7Ez+qFzlp/1wgsJ4Wyu1iCa/M9xDA0UNOUw1hln8wl2CqIOqCd6c3J22rSbQ+2c7h
         dAuXD0E7FgODzF7QD1fKnAmLrLADUeEhBcKo0nkUh4yeroiNZf85iSDtCtPccVonpIov
         BCVNgAGYlpeK10vq+JOGFgtnTdtWkvMjWjOWTbvpULHcTPwM6BpqXajvZo/qdxj4xN4o
         xOPRAZc4X7d9ksW+uG/F3wGQY3bbJVUPA4qgcA0VoRcAE3WoQf4qHnHT9IlMlZ1Oh8+G
         NoBA==
X-Forwarded-Encrypted: i=1; AJvYcCXxKsuZ/YPsrd8hC9aRyBEcsRGUAwS03nluUtG5wzAeOxPPZGViZzzyjfjCgDJhw9lcGk/Dr3sAevg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzBNNDz+ahdlGDw8D6oAnWQthjg/Ah1ycil5H6fPkBHgpbFHa7
	b5uPwPJgmNh0yw5DRTThTcuPX0NaACaAtATwyEHXB2F/AJLznwzmXQaPpn14hqBP0it+sHbFbcX
	GeezP8Qo02xXCr/y0x+AMLWm9czXeu8JRgLtWmQ==
X-Google-Smtp-Source: AGHT+IGB0HmD4yUCXfyiEGHZvou7JbCti99d3PK2v6+1ygu6PUNxbcxYam6wZ0jMVxzgb9p/QjTuS1exJPMjEaQahlc=
X-Received: by 2002:a05:651c:1543:b0:2f7:c7f3:1d2e with SMTP id
 38308e7fff4ca-2f7cb31c4e8mr59626701fa.19.1727080502814; Mon, 23 Sep 2024
 01:35:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240920-ad7606_add_iio_backend_support-v2-0-0e78782ae7d0@baylibre.com>
 <20240920-ad7606_add_iio_backend_support-v2-10-0e78782ae7d0@baylibre.com>
In-Reply-To: <20240920-ad7606_add_iio_backend_support-v2-10-0e78782ae7d0@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 23 Sep 2024 10:34:51 +0200
Message-ID: <CAMknhBE51oUjNZVE1mq1xtdOzAG2fpxXW7S+haMGQosdweaZsQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] iio: adc: ad7606: Disable PWM usage for non
 backend version
To: Guillaume Stols <gstols@baylibre.com>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Michal Marek <mmarek@suse.com>, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-doc@vger.kernel.org, aardelean@baylibre.com, jstephan@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 20, 2024 at 7:33=E2=80=AFPM Guillaume Stols <gstols@baylibre.co=
m> wrote:
>
> Since the pwm was introduced before backend, there was an example use
> whit triggered buffers. However, using it may be dangerous, because if

with

> the PWM goes too fast, a new conversion can be triggered before the
> transmission is over, whit the associated mess in the buffers.

with

> Until a solution is found to mitigate this risk, for instante CRC

instance

> support, the PWM will be disabled.
>
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
> ---

