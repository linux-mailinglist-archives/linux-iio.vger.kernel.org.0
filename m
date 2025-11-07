Return-Path: <linux-iio+bounces-26007-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC74C3EDE5
	for <lists+linux-iio@lfdr.de>; Fri, 07 Nov 2025 09:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73F5B3A541B
	for <lists+linux-iio@lfdr.de>; Fri,  7 Nov 2025 08:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5324330F7E0;
	Fri,  7 Nov 2025 08:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0AzOqIU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D59730DEC8
	for <linux-iio@vger.kernel.org>; Fri,  7 Nov 2025 08:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762502665; cv=none; b=fhY7FEMJvkVPw111kZ7NdnwOhEihS1CB7JK4qlljh+3XDmsNGUr3FhP7H1Mhj6jyvtfFd6z1zr41IYs5Oydw6ynNO+Kx+pRXXjQt28Ya3/2rW59On5wbKdoKiLbY6Vm6mSB/M84JpxvunFrqWHON4lyukMwsduuPyNlIKw/1Foc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762502665; c=relaxed/simple;
	bh=snAkFDVYRfKppUHhQmG/xJ0KfiGHH3syHzc39HQjvR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ujLUBGLy/QrrtsM0cwvDBXyfA0+DMWpNWcIlZKogHLD/OCDNIH1QGMqr9WyiBRaxZ07NXlj6KrgJ8jWL47VA7+anWoVXs+iETnzY8xd9zT3ac7eegEJPODgQ35GixxQFmB/yE2M+qLPWv7I00XlTKEbPFQcJuS5CgJACrCCo/jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q0AzOqIU; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b3c2c748bc8so52110466b.2
        for <linux-iio@vger.kernel.org>; Fri, 07 Nov 2025 00:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762502662; x=1763107462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I90MjBmySIkPhmxDdLvFAJjwQFW8Mzv4w6oF/Lid6MY=;
        b=Q0AzOqIUo/L4CBpR1nForJyvfg22SFOPDyAHpH5MQGsK2hDMkaJWO5YqPIWdYFtdkj
         7CwuoFieZZ4OzRtUWg5d66296UsdUv+UoMv93RaYVY6TRsr0HWEgz1K321rBE7fYJLkL
         yysjAiaMSKLyV4OUCNOYMel5aCKouTHxdtxWtgSZgeZX7vLPkEBysKZv5MOihESMlnwH
         zOVfSC5HrcuRk5pHWnJRpUcBkQfV8GuUh1CPj6Qj3pDYuJEpsa9ZT6enXaiOgxibBhLo
         kLz7CEtJdpacUuvrQhzQxg604u0EM+2cx3kj+zx49udfiyaOWHxKsuVIijGuZzUds6l1
         QkIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762502662; x=1763107462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I90MjBmySIkPhmxDdLvFAJjwQFW8Mzv4w6oF/Lid6MY=;
        b=QMjZH08VNLwfJjLRdScqLF4HpdR/i7mV/Nz8Wet+0t4300tS3j7zyk8AznkCAbBYok
         ToPVV8lPiuut2Bq840vHqFO/p0nw9QXOaQ1R7fMx0SouOrJWFg0YO763kUfbldBNmYa0
         OF4rLK6+S0vPaEbe2iZ8VtpOy7T1B3SgRjCiIqkJtjkgIrDalngwybsEa+WJx+KvgF8M
         4cghVSI79pqlqoNt4BPtfg8ggUj6Iv8gVUyDhhzvhgCCrjYiQwssfdOcsoHLpTsVu26R
         WGqaVVAKFHJKB5JChMeB8YnJ/1oV+3ITi0bqn9zZjTEpTN4vnpwFOdMIMs+uFu61YQn5
         uzRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVc7keCbdfp6A39gQ9Htl8zT1ZHzpikxRxQ2seFCBQsnt3oKeLezaVfrerCj5UoX6U+j4q0e7qf6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwagI5pqXLzqT1xSBiyChTjDxb9ObqpYEcIejlgBvLy9Xn2jyrJ
	IkmD883pGKcMZfFCBsFLzQMY+d7ZF75YSjUJHNXblNhNZ1cZiMgM2p1XC31EG84g+mHF8QnMJZ1
	89prBtkZY09cgPx+l9FCmoXflRrLW5GU=
X-Gm-Gg: ASbGncuUjAYm1Af8QuSpZYnKnEhIu7UwjWWd7zJ1wWhzeVwVnfnnObAMjPGT6wJigPk
	+osXoU4O4ePkBfOjf+OxIjitE4csl+by6iZALWXaLxX7v0aBudRSSg8kiDItYMdv4Ejx+0NYkwG
	sfNWNle7DngXUME5Jv49oosoCCJz8blQxeTGtTrUYTyE8ENajV1bXvMqSAv6aFMcc1PN8d3zLJR
	I3fJs9tWD45LgSk8cWAkItP5bTJD7OUanmjBmz974jC8PN7bcHsLwh88fJYow==
X-Google-Smtp-Source: AGHT+IH7QgHT9eplPXnblcZrAf+4AH1nvr7H0mJZC5Z77CdcMj1Gwejx1wskK7SvWJW9voFU7/sfUU/ovQGDLgCuQK0=
X-Received: by 2002:a17:907:7246:b0:b71:dd06:48de with SMTP id
 a640c23a62f3a-b72c0dbef32mr188016666b.59.1762502659405; Fri, 07 Nov 2025
 00:04:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107020200.6285-1-make24@iscas.ac.cn>
In-Reply-To: <20251107020200.6285-1-make24@iscas.ac.cn>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 7 Nov 2025 10:03:43 +0200
X-Gm-Features: AWmQ_bkyChgkG7twno4Fs2ZRPuAxXDGpX4YTffQDhSDTVbjb7HgdE6IcQyCfBLI
Message-ID: <CAHp75VfiKrCC-T45z4RggH0-eMnxvRW2pGC85KWZDdoaxNALDw@mail.gmail.com>
Subject: Re: [PATCH v3] iio: trigger: Fix error handling in viio_trigger_alloc
To: Ma Ke <make24@iscas.ac.cn>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 4:02=E2=80=AFAM Ma Ke <make24@iscas.ac.cn> wrote:
>
> viio_trigger_alloc() initializes the device with device_initialize()
> but uses kfree() directly in error paths, which bypasses the device's
> release callback iio_trig_release(). This could lead to memory leaks
> and inconsistent device state.
>
> Additionally, the current error handling has the following issues:
> 1. Potential double-free of IRQ descriptors when kvasprintf() fails.
> 2. The release function may attempt to free negative subirq_base.
> 3. Missing mutex_destroy() in release function.
>
> Fix these issues by:
> 1. Replacing kfree(trig) with put_device(&trig->dev) in error paths.
> 2. Removing the free_descs label and handling IRQ descriptor freeing
>    directly in the kvasprintf() error path.
> 3. Adding missing mutex_destroy().
>
> Found by code review.

...

>         trig->name =3D kvasprintf(GFP_KERNEL, fmt, vargs);
> -       if (trig->name =3D=3D NULL)
> -               goto free_descs;
> +       if (trig->name =3D=3D NULL) {

> +               irq_free_descs(trig->subirq_base, CONFIG_IIO_CONSUMERS_PE=
R_TRIGGER);

Why?

> +               goto free_trig;
> +       }

Please, slow down and think a bit. Also you may split the patch to at least=
 two:
1) add missed mutex_destroy();
2) fix the clean up in the error path.


--=20
With Best Regards,
Andy Shevchenko

