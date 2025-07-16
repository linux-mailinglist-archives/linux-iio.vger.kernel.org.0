Return-Path: <linux-iio+bounces-21726-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D0AB07E17
	for <lists+linux-iio@lfdr.de>; Wed, 16 Jul 2025 21:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8825A45012
	for <lists+linux-iio@lfdr.de>; Wed, 16 Jul 2025 19:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48B52D780B;
	Wed, 16 Jul 2025 19:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="deJml6nQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D89D2D46C7
	for <linux-iio@vger.kernel.org>; Wed, 16 Jul 2025 19:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752694651; cv=none; b=lAmWr9p9b9ULVQw96pcy2NHlsFd1JJ6B9gfQLMw9CWFPuQIatOohyigGdu2WSPxYGyoJwZDeg3vy78P62geopjTFDnK2mxwJl7IBSV5WlUEqyErDQQXAaefqD/kF/nLMdCcCw0PvdfRF5jqOB4N2XR4Nzrq2theCKQJIapCA0C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752694651; c=relaxed/simple;
	bh=L2jrBlc5dI0IKuElxfFo5WQL+M1MVyn8FVc5rbLbHG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UN5O3Bw06+AkwNW2FGVCkpYtSCm+YYBtl3+1ngdiSrc4tYIYWstm1OU8ElRJSCkDnHPVNKPsjffIgQM4EJwgVX6muyLGV65xY1Lx27bTi/8gyS++nTlWfXj2x3Diyp06qWDOmDzZ++fQJGKumHTtc8g2bFnllsxxmWpy/frMpZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=deJml6nQ; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ae401ebcbc4so36612466b.1
        for <linux-iio@vger.kernel.org>; Wed, 16 Jul 2025 12:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752694648; x=1753299448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L2jrBlc5dI0IKuElxfFo5WQL+M1MVyn8FVc5rbLbHG4=;
        b=deJml6nQHpQg/VHYBGipJPZNDftIInxY6v+vUwnGoKFOqKi/O1zlYBLC225VaHOkZq
         J4XBNoenM3RdxUY1jmzLhNAqU/L0sVMyMfkfJyOJWdW9AiUCTIoOfyGzArhtWEgSAykn
         pAZExzivNWuue3nd7TDnIncUwqyBU3T0WQGraA3XksOK+nHanrB0Y7Ux6wf+GP0KVFmw
         8cgRWN6Q8SRxypDTLjQeg0UeiKA6PuGXcpTHdIFtczc+f9q+kpdT0sTxlLxC0sRxXPJk
         43kdoy89tYGRacGAswIq1vMSauYlvI6x3+j2rdVCy2qKRR2f1ZZ4ieW5gSgSFFRSzNM7
         jhOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752694648; x=1753299448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L2jrBlc5dI0IKuElxfFo5WQL+M1MVyn8FVc5rbLbHG4=;
        b=sSKk+2F/uG3qsIrqss8kHbCs/CJsC4XLlT4E7pp1BnnGg+TqkrC0hMU/25vcqAjCUL
         /r6WpFdG2C2jKkCDN0KFd7VhbnP+o2yN13WqXRuPLzBT+U2zueGTC9VH4ip/XoKyUvVV
         hO+83ZyW7Y6YNL7mDAPrxcQdkwrJyYXap92US0hBansORfF1DIcRYrz49ZKFcU4YLv5y
         Tu2Be0ev+/plaqm/N1mwSRY4fGniSVbfTSZa/xYmF2a4xFvN6pUhk1P2RmqOpobPY4TD
         4qRE025X29jPRzH6NadDjFNezW1HiqSvqo+mDO945QUDF6y529+ae5X72Qo22NlLMncO
         KfCg==
X-Gm-Message-State: AOJu0Yw7MkERfXgWMeZH9nZ8/fgE5baFYkp0fh6dZ3J8/81rCM+3hGIn
	5/PtAfg8o6IG6mxdN8G9efiYvN/quU/ZeOUBwuQY2tTUYclj8CyZb6sgW994vyP98nTJhBzJg6M
	52ei2SVZHIIH2ftP2hBGkM3hPRpaPxS4=
X-Gm-Gg: ASbGnctXdyMAeyCjYjfa8kH5GEx3ZV6yOeh8kjczse2ZcMx4IeArzD1yJt1ArsPxi/W
	yOnR8TfNgvzXCj5R+VWqIso+EtCz3AZG/dUQYm1f3WAalipTWXHtRb2mW2n/qn9MykezuELr1uX
	fRYqsFoJ4rlVBatsxcF4cjtQSut04f1gN/GJ77yQEwxEUt8EE0neroWYdvdxzPgjl88EYzLUyD+
	wBU8EFf/srC9GHPLA==
X-Google-Smtp-Source: AGHT+IG/rxzE5FgrxEBef5ZHUiMj4ytqxWf+5fNJ3Awx9vWasUI5PgXmQIy0Hx0y4xayYoNFiuUJ8un0j7A+5nk5pOk=
X-Received: by 2002:a17:907:7e99:b0:ae3:b2b7:7f2f with SMTP id
 a640c23a62f3a-ae9c9b3f3c5mr437340966b.40.1752694648258; Wed, 16 Jul 2025
 12:37:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716192231.30337-1-antonio@mandelbit.com>
In-Reply-To: <20250716192231.30337-1-antonio@mandelbit.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 16 Jul 2025 22:36:52 +0300
X-Gm-Features: Ac12FXwCLnWCdezrbha6kkAS4NjGkGzxYa_jsTJc7gD0fE5TKDs0cg_wW6mHdC8
Message-ID: <CAHp75Ve_geZr4+DPLD_g5ZyXF2AmKog-YShnohSAJ=qM5At12A@mail.gmail.com>
Subject: Re: [PATCH] iio: imu: inv_icm42600: fix 64bit multiplication
To: Antonio Quartulli <antonio@mandelbit.com>
Cc: linux-iio@vger.kernel.org, 
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 10:22=E2=80=AFPM Antonio Quartulli
<antonio@mandelbit.com> wrote:
>
> In inv_icm42600_accel_convert_wom_to_roc() multiplying
> `threshold` by `convert` may result in a number requiring more
> than 32bit.
> In this case, although `value` is 64bit wide, the result is
> truncated because the multiplication is performed in the
> 32bit domain, due to both operands being 32bit long.
>
> Cast the first operand to u64 to ensure the multiplication is
> performed in the expected domain.

Is this a theoretical or practical issue?

> Fixes: 50cfaa9a46c8 ("iio: imu: inv_icm42600: add WoM support")

> Address-Coverity-ID: 1647596 ("Integer handling issues (OVERFLOW_BEFORE_W=
IDEN)")

Is this tag now official? I can't find where it's documented.

--=20
With Best Regards,
Andy Shevchenko

