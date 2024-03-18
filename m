Return-Path: <linux-iio+bounces-3592-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF9C87EAAF
	for <lists+linux-iio@lfdr.de>; Mon, 18 Mar 2024 15:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A172A1F21179
	for <lists+linux-iio@lfdr.de>; Mon, 18 Mar 2024 14:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDD24AEF1;
	Mon, 18 Mar 2024 14:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wsjr9B1x"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4364AEDC
	for <linux-iio@vger.kernel.org>; Mon, 18 Mar 2024 14:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710771456; cv=none; b=SjgY1A5t7CPozWLrAR6VsNe416qxgm+ioHtH9pqHpfON2p/waVEdXmaHaRDZf7yczM5gu6siynFV3uV6ZaNlLN+gCDg5iuXH+R1W7sus+mi9UU6JKdEwn2JlzSIYTuIbKU2cnwYjHcwG7Q9//Dkkh89g9PZAPVzv3OVSNIFsP8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710771456; c=relaxed/simple;
	bh=1BMaNU0E/2bIytmAKxmyvavAPtvvU8WEvdK71T7wLaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KTO9U8O2mqq2p6cjPw50kCORvduR/wq5xqsUZ3ti2C9osFkiRpZuydAkTXsDBfUjo+nbJqsx+CpGWuFWU7wsk+LQn98d4NnxxnRzuMytcMHABvvj7PUOgSUpnHRXA8E1ydvXFpXHAv8l0XQ0DsxZ9Ew5eh7vn9/rlv5OChsvemw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=wsjr9B1x; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d46c44dcc0so54581731fa.2
        for <linux-iio@vger.kernel.org>; Mon, 18 Mar 2024 07:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1710771451; x=1711376251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ME6ksLF4MpzhmHVbYXi2u6r0c/TRTWgp1dMRqLVgFwU=;
        b=wsjr9B1xN51E8mvYUPux9bc98h6s0CCN6LrZW5an8DLtbz+Ndm25VkKrpuNCwpXelI
         kr4Z6B7ljQAAp0LquO0Inn1LQgQMKRpVCLZEh/J1SLO+9Qh1ff/br3XuOqjShnlIgN38
         hrCstjSyRfxU4Yt4cg8V+wkpbSiTj9tBSM8IQk+/fzjgRy7GBI75O+MFDjwvtph5IiaZ
         Xc9bB5F/mqIqK1ggJ8KEVGeBnQ1Qc4/5c8YdAf6paM13W3MjmcfO/L0dGfLfZquiOPBb
         K84JindNipSHduij5xZ2SI0WuWAAknGWhUIgiWrNrmEyv0M+2HM4wmIlanHgRONDxJzJ
         /h1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710771451; x=1711376251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ME6ksLF4MpzhmHVbYXi2u6r0c/TRTWgp1dMRqLVgFwU=;
        b=mA1dnkeW74/TKqkegNnHGAjPOWQCdMDutzLRxMyHaCM3OjC82pedfANVES3sEhD+1I
         H9YlBvPiP6oyLb6Y5ySFluqfg9yGKlmJIJk0EHY4WMllzzcl63IwtREKg/ui0/kjpdBw
         U6vrRY/03CMSo5E0n7qlZJ+l2MYwewdQEz+1/+Fo67HjG/KSyVCXEVM3Iktuev/p30e4
         n1l5yeN34eG9VWBLrayGujMY4ItiS3O7f4isB8Dt8AKHqPIcq+cUH1cFQrqp5l5KNTYY
         33hq/TwZhmfLrYS7Oy4oJZsnvMYF4N/fl5kqb5BAxKfhuMaNy4Ldjhj13+3JWhe2fy0T
         Fzkg==
X-Forwarded-Encrypted: i=1; AJvYcCWz8Z3XcL57tGwY7hMmOZw67MnmFdndeZZH+xP8UBjmwAx1YE16NZvSY5073qJ3JJ4X+bo81CSYJeGSXqusq7DSUT3bpGeehSnp
X-Gm-Message-State: AOJu0YyaEL8a49nZviZoMgJ1I2/3YBQQc/iMbU50K4MxeoJ9QBkeSCcf
	BPgOr/hBz0QEEf4wkjpqBMnOZceP1Bcig1vGD+QKIxCIxjDFzwdgR4dsYVloa/tsqR4LVVGWue4
	nuKjfXO5I9kOpgm/D1dsY9ygLa5MbEghajipc0A==
X-Google-Smtp-Source: AGHT+IFV3lnYog2QCYliVIypmWM0EjlzA1MG9cFe6FTWDujKfk7Qq020WT7L6jVTGy2B45+hBQUIH0K8ogOutG9URJw=
X-Received: by 2002:a2e:aa98:0:b0:2d4:31a0:6adf with SMTP id
 bj24-20020a2eaa98000000b002d431a06adfmr6804803ljb.24.1710771451026; Mon, 18
 Mar 2024 07:17:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314-mainline-ad7944-3-wire-mode-v2-1-d469da0705d2@baylibre.com>
 <ZfX5jynjW4M9pvw1@surfacebook.localdomain> <20240318124041.0000032d@Huawei.com>
 <CAHp75VeQcvuEy4V6-+3PeWTZJ9=Qae0AiiNB93OOw3wuc-uh3A@mail.gmail.com>
In-Reply-To: <CAHp75VeQcvuEy4V6-+3PeWTZJ9=Qae0AiiNB93OOw3wuc-uh3A@mail.gmail.com>
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 18 Mar 2024 09:17:19 -0500
Message-ID: <CAMknhBG4OAc=qsZZrahYBiwOEK=XM3pUWup9O5J5W4dMCS4FUw@mail.gmail.com>
Subject: Re: [PATCH v2] iio: adc: ad7944: Add support for "3-wire mode"
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Jonathan Cameron <jic23@kernel.org>, 
	Michael Hennerich <michael.hennerich@analog.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 8:10=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Mar 18, 2024 at 2:41=E2=80=AFPM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> > > >  struct ad7944_adc {
> > > >     struct spi_device *spi;
> > > > +   enum ad7944_spi_mode spi_mode;
> > > >     /* Chip-specific timing specifications. */
> > > >     const struct ad7944_timing_spec *timing_spec;
> > > >     /* GPIO connected to CNV pin. */
> > > > @@ -58,6 +75,9 @@ struct ad7944_adc {
> > > >      } sample __aligned(IIO_DMA_MINALIGN);
> > > >  };
> > >
> > > Have you run `pahole` to see if there is a better place for a new mem=
ber?
> >
> > I know this matters for structures where we see lots of them, but do we=
 actually
> > care for one offs?  Whilst it doesn't matter here I'd focus much more
> > on readability and like parameter grouping for cases like this than was=
ting
> > a few bytes.
>
> This is _also_ true, but think more about cache line contamination.
> Even not-so-important bytes may decrease the performance. In some
> cases it's tolerable, in some it is not (high-speed ADC). In general I
> assume that the developer has to understand many aspects of the
> software and cache line contamination may be last but definitely not
> least.

Where could someone who doesn't know anything about cache line
contamination learn more about it? (searching the web for that phrase
doesn't turn up much)

