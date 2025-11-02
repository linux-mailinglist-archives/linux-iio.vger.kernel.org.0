Return-Path: <linux-iio+bounces-25809-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1685C28FB9
	for <lists+linux-iio@lfdr.de>; Sun, 02 Nov 2025 14:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 103BF188BDC6
	for <lists+linux-iio@lfdr.de>; Sun,  2 Nov 2025 13:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036FA72629;
	Sun,  2 Nov 2025 13:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eXVG3SUf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C19C2566
	for <linux-iio@vger.kernel.org>; Sun,  2 Nov 2025 13:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762091161; cv=none; b=BJ/op57Wxiyf7nVhxlavmsc7J3wDzfMRkBKB+ze1L70dKjuPsSReJCzc+slJGiMnB5apEmEwVcixEpaAboEsV1ZtiCGC0gb+8d0E7YGAjuK3tg3JuKN9jIJfNWq1gEpYfXHTXXDDKFLOQ7CpDMTPnCcUCKKIlfDHqyBAKKdO/WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762091161; c=relaxed/simple;
	bh=jNItuRhavCC2zJCafsw69HX16W0ocJWm4TPNXbQQNQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KWXu6t3y/y5PV9+k1cxuvRRybgsCtdEHtOyITALDZRQkSo7P8FvTqGO8PUxNScGVqaGX0H9+ldcc2BWIqBPxJBgqjxcKdawvfQUFhwZu+jY8cVfdOhwRH9fud8390FNUjCQrf0pHA0OdJvsgbtogEofdcTpE1iNTXSQEKZ1f2c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eXVG3SUf; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6406f3dcc66so6067160a12.3
        for <linux-iio@vger.kernel.org>; Sun, 02 Nov 2025 05:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762091158; x=1762695958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fw3S9KYKQCs6CdacIU3IrV9hQ+3vjKqALVZ6UycO7uM=;
        b=eXVG3SUf1UJv1YFNoDznELugP23AQ+cjhAN36hoZ3ABW+jPDlUD7plfeS7UPZaOVf2
         wr2IesaR7wC9mOjFx5S3BfIi8BIahjxHqE/CN+n4fkOJ4lkBgZcmMJjTXNaQObvNiAT4
         erR/9I6wnvoXHuXwLOaJjm8g0FE6RWwZnzDZpEhnkeZJJi/4DuvPhiqBjHYduK+Aay7t
         B2ItRpzq7DGwLV7vxD2jL6jbPQy81nKEP61DldCegOJhtAVmJLeS9bwMti3/q9IAN/BJ
         VMeh0k72R4ebUt9vf7tj+YO73w2OZYK1ygNdc2I6AirrAHcgGtRBY+WlzWlyFBtqtByK
         WVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762091158; x=1762695958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fw3S9KYKQCs6CdacIU3IrV9hQ+3vjKqALVZ6UycO7uM=;
        b=essIyCylbt8idTx40XxymmZGqiIfuptxAdm5Fo+lUOO0WVoHXxA2OhByQKedyJ+YF6
         fMLfGxoyJa/FEB7pr7VOJaAnKNgC1TqX4CKKJbmVeSOq5FxeLPF9PowKPX/HiynZ8TX0
         rZCmI/vQJZmnjogE4bbHC3E6CJT4U1IfQ0vh6TI/qz4rShgBnd3JivhYUtuBr0f/MAsW
         ojqRtXqrmB5RHGzJWkBozZlozD4c3uHvSEk0syybtIlGIGgWDUTHVOli/4jpiNBPJdFL
         8cpDzEI9r2bLqP9w1tdErs+q8E5XXyBupg1ChK4DKb+2wQ5914P5wzawG2KJo7E5hiy9
         kUHg==
X-Forwarded-Encrypted: i=1; AJvYcCWuL0cqUj+Yx7WJV7ELz4UoE45oEXzbRKCqqZEqJcYSzpMGUJnzuT6dqlkT9fYmuUGLmUVCzcSjeaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnBQ0BkleENZVJc9txqhFOxY7zvPKSdRQ9U9ZChiG0kZ0bGeXo
	PCC+AepOtjjIw75Oy6DEh8kADhmPO5/3YfBj8dxN7TB96mOXPpCkqpxqebJvIZ0k6AY0zUxYEsF
	TOnkxUL7XaXVuA1+/8gWQdnCzYtS+OWE=
X-Gm-Gg: ASbGnctF3WY6o33+voXJwfSNQrSi7xqmK2HryuDnwCsntl4N6ZKbHf8G9Nu0Y51pbWP
	UcGjz7zao3jGtrau96Mqgz99EwKiGElOdg+p8NIGiGQfvk2+haB54Seyuz37L3/zkMXLbI293kM
	hQUVjz4QPIOf7mjaLK3iYuiCdyTwqH6zvC40ZaHN9sV/bpsd73K2W9MOrRtlnAH6aFkaGz4J/gU
	rCtZYoOWvk2Ct+hH+eMOtotIQPbMvM266ZmITmrW4HS1UwPYahUMGCD8cDNAw3sy+seCQ==
X-Google-Smtp-Source: AGHT+IGqghQc9gTYwkiV88BkHnLam8aO+LAS6X8ouZBTmZ7uz1rfP6jEkO5biLJ/wtXdRPYGfNZvKjEKAAhqEyh++gU=
X-Received: by 2002:a17:907:72c6:b0:b04:830f:822d with SMTP id
 a640c23a62f3a-b70708a1c37mr939497166b.63.1762091158174; Sun, 02 Nov 2025
 05:45:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030072752.349633-1-flavra@baylibre.com> <20251030072752.349633-7-flavra@baylibre.com>
 <aQMbb6BUBHQUXX9y@smile.fi.intel.com> <32a7741bc568243c8a19d691b922d9a8c2cba429.camel@baylibre.com>
 <aQNs8VVoStUJ6YHB@smile.fi.intel.com> <20251102112958.435688d5@jic23-huawei>
In-Reply-To: <20251102112958.435688d5@jic23-huawei>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 2 Nov 2025 15:45:21 +0200
X-Gm-Features: AWmQ_bnoR5A-A4QhwUAXufBnv5gAwBRIfgnbDoKWsoumHD55ISAtUFRF5CkD2HI
Message-ID: <CAHp75Ve2+eU2X30EvC8dOuhEo3XZBwFrUH60itEYdYdGM7HvOA@mail.gmail.com>
Subject: Re: [PATCH 6/9] iio: imu: st_lsm6dsx: remove event_threshold field
 from hw struct
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Francesco Lavra <flavra@baylibre.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 2, 2025 at 1:30=E2=80=AFPM Jonathan Cameron <jic23@kernel.org> =
wrote:
> On Thu, 30 Oct 2025 15:49:37 +0200
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Thu, Oct 30, 2025 at 12:10:08PM +0100, Francesco Lavra wrote:
> > > On Thu, 2025-10-30 at 10:01 +0200, Andy Shevchenko wrote:
> > > > On Thu, Oct 30, 2025 at 08:27:49AM +0100, Francesco Lavra wrote:

...

> > > > > +       *val =3D (data & reg->mask) >> __ffs(reg->mask);
> > > >
> > > > Seems like yet another candidate for field_get() macro.
> > >
> > > FIELD_GET() can only be used with compile-time constant masks.
> > > And apparently this is the case with u8_get_bits() too, because you g=
et a
> > > "bad bitfield mask" compiler error if you try to use u8_get_bits().
> >
> > We are talking about different things.
> > Here are the pointers to what I'm talking:
> >
> > - git grep -n -w 'field_get'
> > - https://lore.kernel.org/linux-gpio/cover.1761588465.git.geert+renesas=
@glider.be/
> >
> True that it will be a usecase for that, but given plan is to merge that =
through
> a different tree in next merge window, it's not available for us yet.  He=
nce would
> be a follow up patch next cycle.

Yes, but we can still define them here. Dunno either with #under or
under (namespaced) names, but still possible to use now.

--=20
With Best Regards,
Andy Shevchenko

