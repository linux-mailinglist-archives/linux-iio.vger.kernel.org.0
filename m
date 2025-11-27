Return-Path: <linux-iio+bounces-26523-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 01882C8F7A3
	for <lists+linux-iio@lfdr.de>; Thu, 27 Nov 2025 17:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3652E354333
	for <lists+linux-iio@lfdr.de>; Thu, 27 Nov 2025 16:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F742C326A;
	Thu, 27 Nov 2025 16:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPs5FdL0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EC72C0F9A
	for <linux-iio@vger.kernel.org>; Thu, 27 Nov 2025 16:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764260205; cv=none; b=mNya39zaY9bcTdOSdmKWOnjvCcnb+9HnG68/f+YzJQHUUYgC9rjXrrnF8zLJ5ZdtHfPHoZCWzb5PeGREvB2mIF44KgC/BdfXrVQOeSBMGnzWuEnqYd4BXS2HkAsNQ51r9qbL/qrpZcUxP0MxmYtoWrqv7/slvfJuJmrzJSf0WaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764260205; c=relaxed/simple;
	bh=xDypKOX/n6GRcGDAU8VyLfV/rY9GENv82TIM6XTxRto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rGG61br0Yes2IEmCFYe0UsINSbBgzZFAAyhfehWPKlIuSUCeCZhDu3MoPA3wlt2jz0iDc6rdfVLkOuuqgpW/lrM6FETfh3fSGNtmsHt4moFxCHfW91fcR5nnDRnsSzLmwgJVGET+wWRE6LXxO25KSEr/p75XQoRAjiAHjrK7Qic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KPs5FdL0; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b737c6c13e1so193183266b.3
        for <linux-iio@vger.kernel.org>; Thu, 27 Nov 2025 08:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764260200; x=1764865000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KNO28PzgIsx+2Ndb8A3ECc1R+7TzxXSai5xVu+osWaY=;
        b=KPs5FdL04I8adeZnQ9V4xT1D/R21qLv4bEymY7y1NKEsv1aSHOxF7+0WOhOANz6hEu
         H0t9EqE3YzDceOOA3aOZJ50d9mUgX6KkcBRvBSfaqWx0Vx5/aQXfdqzXkhrn9NrISEpq
         FNhREaJi6TU+fIpTf4p3drfvf7RVIdc9L2+mIuGhqUNNVtnf4tdoPBB0GJ8B1hso97xG
         XEQnXkv895T5F58P8cYDt+Z/7cV2HHFfsC5TbUh7o34q52u+qWHcnDjbG1vyCouftlhm
         Ojjghv40AkxBRREjFwcO5yf9SysAncr+yoDaaiYIpcUnwfWjCWKTlUaJcVSdFALHypzg
         bynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764260200; x=1764865000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KNO28PzgIsx+2Ndb8A3ECc1R+7TzxXSai5xVu+osWaY=;
        b=IlZmk5jN3M9ZvqJjdZlXpSIQcW6gh6EJC5s8cNU7dOtSCoMFmhr6rKcUTzh7mvI37s
         TiTHRkOdAh/27SPIT6nFdkJkoEhMofMf6vrfXEaKmEyy8MZmzEML9o2oWBb9bP0yD4fn
         19kZbZQRVj8j4g0SuO/rSaLk7w3f0wBRPBnGUhyvzTzUKPGwBzFmFCJGTiNVCwLxiEss
         yRO47sPEE65ZQyg6FCUmzggLP6sU6wiv0biXa6qD3/9XH2Ur6G/TqBIpaFlOrVoV88Bu
         87zcQtbgdmSWotxiZvhRNlMyAQKWtMDc+wPWTiuzF+hwh2w8YC758/eBYYj26S2n4Lvf
         qN6w==
X-Forwarded-Encrypted: i=1; AJvYcCWSOuQzMwJ2F9tFZ75QeKHpXpZr9kYnA5u3+ulcxPPe3TxiZqwVTnFzqR2JH0xZYNIzYMUwi2dF1O4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz32uUUlfJFYH2m7mCk/VPO96tQYHClZJReUeCZ/jYXfRZ+3Vbe
	PXQOUVzGGc/d8GOd2l+TBoOvweZQCqFgxmIHfClapkhhoMLVHCi4yaPR9m/9wNoGURt/KcBm2i7
	zu+jzW/XTIPP8RzBy4Nef2pObEbpxY1Q=
X-Gm-Gg: ASbGncu9173iurMnXAVdb9Fy0+DhGgtVWGmwqGj3knnoJSR6LM9oEsDwdL4RaFqDDuN
	5z1LEZviQcIc9qet/EfPHxS1L7dNQhAX7XOPVf2T/7PILz+m5xQpHmrRuHYJp38BRbf+uTuoyLw
	5mrFeQolPVse2cYRWTjnZ4C013aiwEOYKdtO1+o7zQcFYL8rjJ0M51i2T1wEZwlN/GkfrPV4V88
	gqnl+Wr8/1P1OlvroH9Ka8HvqwCq/gCcIk7bBROjuYW6nITbej5Eo7kt3iHou2UKWyTBxzuFLU6
	KCznLCMiPDHXxSQFFmVcN0/dbHZWFNmryxM/gF4KGKPhNlaLtt9peywEzkM9fc/j3PVOkxo=
X-Google-Smtp-Source: AGHT+IE6et7KPZp2GkXfofcAVlXzT7muZvGR6VaoGxIvgHz2tucfIoZqOFaUmU2ZIt9fSGn6WlPk+6UoVkEjoIjxQZM=
X-Received: by 2002:a17:906:f5a5:b0:b3f:f207:b748 with SMTP id
 a640c23a62f3a-b76c547167bmr1211487466b.10.1764260200132; Thu, 27 Nov 2025
 08:16:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127155452.42660-1-dev-josejavier.rodriguez@duagon.com>
In-Reply-To: <20251127155452.42660-1-dev-josejavier.rodriguez@duagon.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 27 Nov 2025 18:16:03 +0200
X-Gm-Features: AWmQ_bkZa2nrqUftdjH6MAYONe3JSVeW4Th2GGUqnpqYo2uuwkRVZXIvhkoPc0g
Message-ID: <CAHp75VdvJUFwFBRKT+iqwQXiK-toah3gZq6pX9Omcp6d2R7g+A@mail.gmail.com>
Subject: Re: [PATCH 0/2] mcb: Add modpost support for processing MODULE_DEVICE_TABLE
To: Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com>
Cc: linus.walleij@linaro.org, brgl@kernel.org, jic23@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	gregkh@linuxfoundation.org, jirislaby@kernel.org, morbidrsa@gmail.com, 
	jth@kernel.org, wim@linux-watchdog.org, linux@roeck-us.net, nathan@kernel.org, 
	nsc@kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2025 at 5:56=E2=80=AFPM Jose Javier Rodriguez Barbarin
<dev-josejavier.rodriguez@duagon.com> wrote:
>
> During the process of update of one of the device drivers that are part o=
f
> mcb bus (gpio-menz127.c),

> one maintainer of the GPIO subsystem

Krzysztof? Did I miss something and he is now a (co)maintainer here?

> asked me
> why I was adding new MODULE_ALIAS when I also added the same new
> information on MODULE_DEVICE_TABLE.
>
> You can find the messages here:
>
> https://lore.kernel.org/linux-gpio/80a20b13-7c6a-4483-9741-568424f957ef@k=
ernel.org/
>
> After a deeper analysis, I came across that the mcb_table_id defined insi=
de
> MODULE_DEVICE_TABLE on all device drivers was being ignored as modpost wa=
s
> not processing the mcb MODULE_DEVICE_TABLE entries. For this reason, form=
er
> contributors were using MODULE_ALIAS for enabling mcb to autoload the
> device drivers.
>
> My proposal with these changes is to complete the mcb bus by adding
> modpost support for processing mcb MODULE_DEVICE_TABLE and removing
> MODULE_ALIAS from all device drivers as they are no longer needed.
>
> Jose Javier Rodriguez Barbarin (2):
>   mcb: Add missing modpost build support
>   mcb: Remove MODULE_ALIAS from all mcb client drivers
>
>  drivers/gpio/gpio-menz127.c            | 1 -
>  drivers/iio/adc/men_z188_adc.c         | 1 -
>  drivers/tty/serial/8250/8250_men_mcb.c | 3 ---
>  drivers/tty/serial/men_z135_uart.c     | 1 -
>  drivers/watchdog/menz69_wdt.c          | 1 -
>  scripts/mod/devicetable-offsets.c      | 3 +++
>  scripts/mod/file2alias.c               | 9 +++++++++
>  7 files changed, 12 insertions(+), 7 deletions(-)
>
> --
> 2.51.1



--=20
With Best Regards,
Andy Shevchenko

