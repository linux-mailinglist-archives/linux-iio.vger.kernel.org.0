Return-Path: <linux-iio+bounces-23321-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E18A4B37389
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 22:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04B721B20253
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 20:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F209A2D2384;
	Tue, 26 Aug 2025 20:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYlIVqNq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7197372633
	for <linux-iio@vger.kernel.org>; Tue, 26 Aug 2025 20:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756238474; cv=none; b=o4UVvvF2IWYG1FXSmmod/rbZCsDOPxW/jsup4O1sMuK65xTBsKZomaVkI17cSb+iTZOOSwpqEAAIikUGgqmBG7EDeNeCSXVtHoaO2p1ORz2dQtsx1TMCMbzka0CoRM1uqjITL2ssorJIt7WKJFtFRvdIWmY1vlvbKrTKfFkMY1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756238474; c=relaxed/simple;
	bh=WZrQfXJWpYvYHabyZ3xnK77nlYcOxHsTKy6J5uSFgoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cvD9vfC3R5Co69NkwEj6QAkZ4hN86vWAEcKL2Ro82j6E+HyxER0VCgOC2KQNny8sp39k5Cfgj+uOvzD4K5AtLXxAcph3t9koqug8LW6VatUzq0CA93rvDYCyCJ1T8H7buSE+8ab9Ck9M6VMk8An9SbcuH7TQaK2NR2ycjNka3y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FYlIVqNq; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-61c266e81caso5216608a12.3
        for <linux-iio@vger.kernel.org>; Tue, 26 Aug 2025 13:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756238471; x=1756843271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZrQfXJWpYvYHabyZ3xnK77nlYcOxHsTKy6J5uSFgoo=;
        b=FYlIVqNqUvdWvz4Zxm9GKImXnB5xBI7o9jt7mYRGjGtIgdPFVgpqROec9sOuDI/gJU
         AtGvpp6xCOj0WWHn9m55LkR0NF5TtGKF4ul8/RaM4gqXsCmJpFv2asryGTQuZZ0eRcIj
         Z2qvo4f6taBZkWXMJxqTQ6GixAUVr2bh4VrZKwBIuw6eLmMezF0E/UNEjjPxIeXO/qL5
         niKQKlP9xFN6/+1/9qUms3U2h1qmUr4B+RCCs/ab7atDSPEoGWWS2Lop+QXssikFHCt+
         8lIRSvvDGXEXHEd1qG4BytGqEnKN0nvwqLP+RwxC6FQ5XxcCyWSjpm38C/JMvLKXqqDF
         jwgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756238471; x=1756843271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WZrQfXJWpYvYHabyZ3xnK77nlYcOxHsTKy6J5uSFgoo=;
        b=uWKIaB2q6yqidnL9L/nfSTdbseGizs0ZbywGhwBC9q2JDOUWWZ/sOnmBG64voY+MLs
         9H3FOFh5GgLMlPNM8tl6gYMqB8DxqeuQxDn6F9JzNXUMDu3+rXXZkBB5gO8Z3KcTM/ku
         Lngsk5MKu1LbZcBcs+xwQV6IPFVQuFI7fJa1U3/9w8+fBK+Ojaq4bFiMnllbtB++P0Rl
         EFXoY3ZJywMmAEqmw2I6bPWASbLClqsTp9L8y5iTqfqI+qjAwcEm8XYhw4MK7Odl8A/D
         rZLrYDGEcKmXxd+KEWzCLs8k0WAmv9CsDxFSkxg714hKK5zg1gIR3vKOVFGJuwWUzzVH
         7WTw==
X-Forwarded-Encrypted: i=1; AJvYcCWFHpr1BfkN1m319qziL3ww4G2Cp0i2Bf/TvUOXd9rJP/dUz5eso+oLkZsh6iWAhHH0/bBEn/pPmhI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC5YTfQCFfEDZZRVleKapHTCVk1RpTlY6EM+rGQpcHeI15ah/p
	iLDxeDFItHQwYEUcVwakNxKNjYjbmNYfZEZXuNmHjYjsaUdlwzN+rSyadHoIn7emRD+m3yUTCzf
	CHF6bcFEyfFkgvNqbJo5PexqhNKJYD+Q=
X-Gm-Gg: ASbGncthZYjUtIZAupuaJy7Vv6ARH5Y20jOp/92Trocijkyy0GOxa6hwOjRZs6tsS7a
	IocTllQ9iRQB56kiM1cD7SdYhbVa5F4IGwGhpGh6WipMTBkIvllG+2aN3i5LiOjZR1nLahtzzoR
	1zXl67ArKVGLjzL3IOfMIgPh+8wHus29FDK6RYOimeDMmTgrsgNqiYVyCHjH6lHjoZO2tkk9G6e
	eGeGnks66Te0Vd92yVMqgJXW0b10vtTwS5LQ0H5pA==
X-Google-Smtp-Source: AGHT+IEnL9VXg4cyotl1ytQflhKjwbNu4U2sTOudA1Z9kYNPrTdA2jl1myaWu1D0PL19L8rUzhQpENA+1sR3mrzapbA=
X-Received: by 2002:a05:6402:50cc:b0:61c:9970:a841 with SMTP id
 4fb4d7f45d1cf-61c9970acbemr1879510a12.25.1756238470637; Tue, 26 Aug 2025
 13:01:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJE-K+D_U3F_61vzXPHDZV_Rm4Jzd--nO3yf083g7-0=Hh7OFw@mail.gmail.com>
 <CAHp75Vcte3F3VNhKZPd4vv45Kedzok0LKQax1jt=geG9w7b1EQ@mail.gmail.com>
 <CAJE-K+CNsGdJWeYW-NL7PtkOog3YfLEeqJLJRHEtTfb=A=o8pg@mail.gmail.com>
 <CAJE-K+BjnNdE0kN1fqfZQGb+9Gcdead=DRiAXn6qpSz-WKOj9w@mail.gmail.com> <0e475ae0-acd7-4eca-915c-9dd44682db2d@baylibre.com>
In-Reply-To: <0e475ae0-acd7-4eca-915c-9dd44682db2d@baylibre.com>
From: Sidharth Seela <sidharthseela@gmail.com>
Date: Wed, 27 Aug 2025 01:30:58 +0530
X-Gm-Features: Ac12FXwbjIcKFpqBwWv-09uPkGTnIn44dE8jSTMaAfZgWaO4w2dIs8dn3093ABc
Message-ID: <CAJE-K+DGNDY6HLd6eEv2PRS5Q3Q86opOpTR6iawXptt_88ajqQ@mail.gmail.com>
Subject: Re: [PATCH v1] chemical/mhz19b.c: Replaced datasheet reference to new revision.
To: David Lechner <dlechner@baylibre.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, "gye976@gmail.com" <gye976@gmail.com>, 
	"jic23@kernel.org" <jic23@kernel.org>, nuno.sa@analog.com, andy@kernel.org, 
	linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 1:03=E2=80=AFAM David Lechner <dlechner@baylibre.co=
m> wrote:
> Please give at least 24-hours for other reviewers to have a look before
> sending a new revision (for things more than a few lines, allow a week).
>
> The second revision should have been v2, not v1 and should not be sent
> in reply to the previous version.
>
> Also, the subject should be "iio: chemical: mhz19b: Replace datasheet
> reference to new revision."
>
> And there should be a blank line between the message and the
> Signed-off-by:.
>
> And revisions should contain an additional changelog so that reviewers
> know what change since the last revision.
>
> All of these expectations and more are documented at [1].
>
> [1]: https://www.kernel.org/doc/html/latest/process/submitting-patches.ht=
ml
>
Thankyou David for taking the time. I will keep this in mind from now on.
--=20
Thanks,
Sidharth Seela

