Return-Path: <linux-iio+bounces-18371-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 132A9A94833
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 17:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D49B3ADF48
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 15:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B220B1A9B2C;
	Sun, 20 Apr 2025 15:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nj1sEaSW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6E32D023
	for <linux-iio@vger.kernel.org>; Sun, 20 Apr 2025 15:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745163341; cv=none; b=ty6yByeqgynhuhhs/3KM59JY8O8QuKp1+ALJdi3Wm70kW9SmB95a+npirJprUUopnu6hwyRxUUECNnfTfhDpNnB8WwmnRE9b6D6ChE17izdQqka99Hw233h1B+v4sQJu7rBLnDqAHULutu+MiKJuFdlCYoBvPF0ZWl2R5k1wKR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745163341; c=relaxed/simple;
	bh=mLe/H7RjVNSBBQdN7lqG+bcyhjXE7XXU8C4xXEKfopg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BXtN3SEo0t5DGQcXbsmKCvxyuepioJ3217llyevnbCkWpELh25sVj4QaAus90J7EZ8uJvPIVYm+rcnX1fqAq515tndrR/ZVSjzAkkJrUWNV8c14G+Y4uXvxzrO/+y0GZQsLk0Qa+8gSzkgiFlJVJ4ZdgNDcUpWhkElgml5O5TDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nj1sEaSW; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5edc07c777eso4305393a12.3
        for <linux-iio@vger.kernel.org>; Sun, 20 Apr 2025 08:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745163338; x=1745768138; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mLe/H7RjVNSBBQdN7lqG+bcyhjXE7XXU8C4xXEKfopg=;
        b=nj1sEaSWhvIF5Qu5W04cdBz+GY7gY0ZKNw/DqxOUL7PJ8YXop/5WpFERu54klhUquJ
         +EthIF+N9HEfcV1xcykqBqhmipnGrD+rrdiDDzKqtrVQ1jismYPb4H1lZBFjpWsAb2YH
         nHKqyREtzvv/bwzazieFO6HZrVnaSI/RJpzZSeBz9rP5QJNImKdsEkAOcVvL3HtbLPYt
         0/YlceCUz8LmQJHiogGQFEeESFgF1qNBp9boLxzPGf55NSx3HKxLdv+WD6hRBAEZ832Q
         k/7IuCo0jwhdCidi35xGzNYs1AaN+KJsjniQAZNzFU3Mcolfv82N2zLJ4570SbTiCc4l
         WgTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745163338; x=1745768138;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mLe/H7RjVNSBBQdN7lqG+bcyhjXE7XXU8C4xXEKfopg=;
        b=WHu99xyyz23N+jXh206Vjl/mg+5OLeMI67gVm3T4W0kP4MX/cNlDQI5ZrY0xM5P2jW
         u2DzXPVI9/iGDRiqb7vHGJENanzfCoVRShvJXfWQWuGRnftFb8TaZN5iJJXHmbM6RBZm
         gm4t0NKs5LnyxDBKbDu5H+a85n0qFIj+EOIUfzGpRjNYfUO+ZwgQFlbjuO7VrTBZMjS2
         yBo8yZYcUyTi1IbHyBzdgZf1Dyute4BrOpUl+UBBCiqry5hYKY5rIz5xpSoZRemLTzgG
         CUgHWNpPSnCSI5WwksKvM0gK0JqjAi9u7TnfEE2E4WaCP0hG2SFnQmRox6m/nC8IwHNh
         PPlQ==
X-Forwarded-Encrypted: i=1; AJvYcCV157Panftr0i+sEvtCeHHKsHKQGGU66CDmhUA4p8Uv9hSk4hdk9RY+yXv7WbbUZnN72XekiiInWaE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs7O3FzlguVH20pEMaVT6lwcp8W+pTLwJ/QT1bjUHdYAg11YUr
	nzCYIlOzww47wf3jdGLCoZVhPDZtecpZ1OkZ4RMDeNwoF/qOvE4uFaT0U4hDmExyQ57xkjcfvP/
	j3UWMszV7gjSKtNCy/LrGVepBJQg=
X-Gm-Gg: ASbGncvmEZRzudQwg9eZUOZzOGeicozfsHAkQhBvMgpNeXvigPf1pQAKwJ7NHBSF3Ys
	Q+b7eaDeEF+8f2Uc0n6PE2KrIsUbEtTSvrtKJ2hd3hBW3lH1nHH7byqDhGXm6Kx5HQr54RCixR/
	j1vP6KyMFzfa0bkUsXA5WihGfZkp21wi1KBO7OTcPfLugoxTDOh9pc5Kk=
X-Google-Smtp-Source: AGHT+IEHmmzIvd01a9rkDMHzXiMROndcYxvYO0DIGLg2659HGX/Fe5xK9nUYKGPzEtZtanf6GyxNYgaBoyY2NTKNuik=
X-Received: by 2002:a17:907:97d1:b0:ac3:4226:d40 with SMTP id
 a640c23a62f3a-acb74ad9670mr871892566b.12.1745163337774; Sun, 20 Apr 2025
 08:35:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250419161347.28157-1-arthurpilone@usp.br> <906f8d69-d08d-4150-9f84-2ce714cccb3c@baylibre.com>
 <aAP3gbRT95b6Ip7g@debian-BULLSEYE-live-builder-AMD64>
In-Reply-To: <aAP3gbRT95b6Ip7g@debian-BULLSEYE-live-builder-AMD64>
From: Arthur Pilone <art.pilone@gmail.com>
Date: Sun, 20 Apr 2025 12:35:13 -0300
X-Gm-Features: ATxdqUFfACJVYgPy42q5aI5OzA3e1j8TwbVjhvsHY9vjhhGabwUpK5RiIXFpYlw
Message-ID: <CA+m-LuVxd58dxjPRVfPRaYu4Dw=Cw99vLAMz3JdQUGi_XWbY4A@mail.gmail.com>
Subject: Re: [PATCH v1] iio: adc: ad7091r-base: Move reg volatility check to
 new macro
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, jic23@kernel.org, marcelo.schmitt@analog.com, 
	linux-iio@vger.kernel.org, bruno.stephan@usp.br, aschwarz@usp.br
Content-Type: text/plain; charset="UTF-8"

Thanks David and Marcelo for the feedback.
...
> > TBH, I think the old code is more readable than hiding the values in a macro
> > even if it is duplicating a few lines of code.
> >
> > But if everyone else thinks this is better, I would at least suggest to make
> > the macro AD7091R_IS_READ_ONLY_REG instead of volatile. Using not volatile
> > as an indicator of writable seems really strange. But using readonly as an
> > indication of volatile seems more logical. A comment to the effect of "the
> > read-only registers also happen to be the only volatile registers" in the
> > ad7091r_volatile_reg() function would help too.
> >
> From my side, no strong preference between having the expanded code or a macro.
> About the name, I was thinking about it the other way around. All
> ad7091r-2/-4/-5/-8 registers are writeable, except the ones that are updated by
> the device itself and those are read only. Of course, that logic only applies
> because ad7091r happens to not have any read only reg that is not volatile
> (e.g. a device or vendor ID reg). Agree though that it would be nice to add
> a comment clarifying why volatile regs are read only and vice-versa.

I, too, agree with you and see that a comment would be adequate.

Regarding the name of the macro, I see David's suggestion as being
slightly more
intuitive. Otherwise, someone might eventually argue that the same comment on
the read-only volatile registers should accompany the definition of the macro.

I'm addressing your comments on a new patch.

Thank you,
Arthur

