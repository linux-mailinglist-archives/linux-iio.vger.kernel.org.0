Return-Path: <linux-iio+bounces-20756-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4949ADE34B
	for <lists+linux-iio@lfdr.de>; Wed, 18 Jun 2025 07:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 644357A7D89
	for <lists+linux-iio@lfdr.de>; Wed, 18 Jun 2025 05:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9912B1F4192;
	Wed, 18 Jun 2025 05:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zao22/0Q"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70A7522F;
	Wed, 18 Jun 2025 05:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750226181; cv=none; b=YxnJWgzxJW9R4fgA8p6NVf9+C9+cQ4LSmyp5sygkb9ustL045XGvHAz1tKaYevMzBdfF68dSI+02Wj2qbICl7NB8T1GHUrWS0ggOYCRg24nkSed9Ye+LaAX8lt2m3d05KTcEUloR1suFRjYaBFlrRhwk3GoSqRl4HZ3gjlF8I3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750226181; c=relaxed/simple;
	bh=SMjAnSKocpk1xDh9knIAN42NfOw/SV8S2Pj/S8JAgPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u4QqR3uG1mY5XK3FqIilHdFB2BnoBZi7JxU7v8e/Rh/qLscUfENj4qDBnWvkUQmqkO60QrEhbcGzGRcMMQ0l7mrQv+lyqHuAD/2MS5txIxnZsXN27rNo08dRSBK6cs6E4evML1mC28NLAVx+mw4/qxHZKIJxoLtpio6rBCmbCEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zao22/0Q; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ad89c32a7b5so1020060266b.2;
        Tue, 17 Jun 2025 22:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750226178; x=1750830978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SMjAnSKocpk1xDh9knIAN42NfOw/SV8S2Pj/S8JAgPs=;
        b=Zao22/0QhLTEYDnyA7UGydSZIxTkDBgDT6/CXQcnXbdc87rufWFV6MkG7lFxZNNp7H
         CSTE+cRCdqPegXS70NawSzVBl5pgQCRRXR7WaeRMthUxzfartHHSzjbe/YmXffKHgGM2
         QYE7SPf9M2HRuNE4hQ4UDGbBK5mUSJ7XsTwvwBHmjDOxOcvbpyTl55qH4BkbKl95K8N3
         wGuoRWEseP8n0+uE89lRh2WggrSbnsGMIYX+BQudml3CrbAVx3l/H6gk64B8ycGolYCY
         UXdphsebw4lw4se4gWIVLi5vbM6c7/TMdqQ9x8Yz5zBuMIk3YAsnD51cWq3ffwkX9G4f
         4Mcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750226178; x=1750830978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SMjAnSKocpk1xDh9knIAN42NfOw/SV8S2Pj/S8JAgPs=;
        b=YjV5KxmLWcaBlSllBdkpVNAp64e3bCz/dZGv3XDc09ud6LhRjrB8UH5n9Sxiecv6Zt
         RnpoA+aOh8kuzpGpqSpzD7InDKXuJyEZs85Lrq00gIff0KOXrCqIwL77EdhW8bybvBcm
         5k/TPeXyy69usfll+7TQgDY+6nU9BUXj6lQQOKNXYtzyf0li7GiT9GzsHKKqEQjQCLSo
         LGTNCRXXGopL81SIaUKLTucam7sL/aYMsKh70/s5wR/bcxNHFjfQjFhO5GOA1Pg6p51c
         QEpg1wcynwS+cBxqe8sSmac8NoL0GG1tV02QqTZXWpjPfhfzAIXh7ygoIumwAKOY81dy
         sFeg==
X-Forwarded-Encrypted: i=1; AJvYcCUFvJBpA6NZuI17e7SfXSYqPUr0UEA2qZ/4EVpHIJhhMi8OuaH7f8YBN/jHD6WsKVBk2TdpDrxzPIk=@vger.kernel.org, AJvYcCUyxDvzFY+fOUqe9LEbhxBn5e/9vSQz85fHqrciopSEn5vEUWeuQe8tys+MTNNIDZ2F+ZCEOwZVkhC8RmQO@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5VhA8w6lPye4fbQSSSbJNy772QTn4Tqjplx5jnGnakUwW10wd
	H+CjLaYMY1bxCTI++fN0Qx3gB3lGzvIhDazJEpA15SMEWpKvJWhMnwrf7PIrrmQ3TYhvPTEWDjE
	YUQx6nAyF9+UVI5+7rGvkfZCi57kXNAU=
X-Gm-Gg: ASbGncs7mrFFTkFXXYSr2KZqgW8L85HzJe51xf9JP5LIwXrjRXGPlwART3uJ+kBigzD
	vY+phQAgL8f403QSqnJJJEDp1zhmJ635GtSHXJzSVJxcDgWShEUHgFG5Uza3cmQ/xmSzmumPvZj
	o7Y0R/GCk+s4VPQoPdUkJwpf9f7ogSDHlYbcD5K7fs9aqHCg==
X-Google-Smtp-Source: AGHT+IFoVWJ7cfQrRuHMwZrlUWuEF4hXXhBaw9OoFPGWE8lerIM5kZ0T0pu12IV9aEokgZxew3Df0CuZG764YUpMu3k=
X-Received: by 2002:a17:906:c10c:b0:ad5:59ef:7f56 with SMTP id
 a640c23a62f3a-adfad4d4efbmr1676549466b.48.1750226177825; Tue, 17 Jun 2025
 22:56:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618031638.26477-1-andrew.lopes@alumni.usp.br>
In-Reply-To: <20250618031638.26477-1-andrew.lopes@alumni.usp.br>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 18 Jun 2025 08:55:41 +0300
X-Gm-Features: Ac12FXw0MpyTquAEiH7h4Pb6yZKDeOceKWmAcPSZYIyrQTZ4hrj4dbdhd8qFs2c
Message-ID: <CAHp75Ve4yAp6sViUWZY+0abRoNZ0W+rQLCmsbijEcrh8kguVOA@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] iio: accel: sca3000: simplify by using newer infrastructure
To: Andrew Ijano <andrew.ijano@gmail.com>
Cc: jic23@kernel.org, andrew.lopes@alumni.usp.br, gustavobastos@usp.br, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	jstephan@baylibre.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 6:17=E2=80=AFAM Andrew Ijano <andrew.ijano@gmail.co=
m> wrote:
>
> The sca3000 driver is old and could be simplified by using newer
> infrastructure.

I haven't found any reference to a base commit here. Have you
forgotten to use --base when preparing the series?
In any case, please clarify what this series is based on.

--=20
With Best Regards,
Andy Shevchenko

