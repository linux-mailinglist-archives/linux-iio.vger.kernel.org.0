Return-Path: <linux-iio+bounces-1692-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9730882DCA5
	for <lists+linux-iio@lfdr.de>; Mon, 15 Jan 2024 16:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30E611F228AF
	for <lists+linux-iio@lfdr.de>; Mon, 15 Jan 2024 15:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E9D179BD;
	Mon, 15 Jan 2024 15:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="W9alNlrs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06467179B0
	for <linux-iio@vger.kernel.org>; Mon, 15 Jan 2024 15:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50edf4f478eso6455620e87.3
        for <linux-iio@vger.kernel.org>; Mon, 15 Jan 2024 07:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1705333788; x=1705938588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jHJQ4earuuaFIn8gfONIxWyf6Xnetl4fMLp/gZmJ898=;
        b=W9alNlrs/CK9L7ne3hmc2cUOCb5xo3Jdkzt3MOZMBoF/1FJsz1T07U/i5gxeN4YS7h
         ED3kgGsS/+BAEWz/blG6tb5tO0NPA/u842jqoVFbZG5MBUNtZdyg3XIg3ky+RrOWQP2f
         sZ9SzwcfCOTb/HXkeECV0zCCKiVwHww1Dz6fI2rJCY5SAY48cnLQXpNWYc1C3V/sN8dG
         mNwUO6p/xdZw8XmhxmuvFbsRnCHMrKf6AuLp+Sml3x2iyyaoViECIPYLqxpFd/kz+MaV
         eeUnl6mLTsVXXwl1GvQHwJf4xclT9Mr2YSPCFCOvoH8OoyU0tgEQki9e3fqk8jEvVTmm
         Mlow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705333788; x=1705938588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jHJQ4earuuaFIn8gfONIxWyf6Xnetl4fMLp/gZmJ898=;
        b=F5aVIf7A4HHziUADmLYPHWpGt+NRjNJatlvfP8Jkb7Syc9b8dTxkf6+AB4c5Tx0qHX
         Hbn04DE2uQUS9tcL4vtBcutKkpP//reQ1Qs4fsQ0fY5ACEmjgeJrBBq/U0d8ZvBktwhJ
         ue4v4m64Io+62h0Lu9U2gaTUV4Z2F6h5FzlZX6wVKacCvvaXS5uk1bnU0AR5dums09LR
         beU3g6XoZCqIhFFktPUQiJZASfUR4AldypBWWtGrIciRKOaG7rsZtP//ycOnV2t4G40J
         kJgh30dxPFn0f33VEXAsugegXyPB1wIvLATmYxCPsb/x905eExNqi14kgcZDWrRZA2sj
         io4w==
X-Gm-Message-State: AOJu0Ywo7QDxcQkaVWsD/+qKAxkbqhDinwu/pTcvsUYsM5yfgxCwaJ4Z
	RnjpsfqYV6FsewDIN4N4njVHcvfkvBsmydyzyePyyLenrRjRLg==
X-Google-Smtp-Source: AGHT+IHgEX+7twLQU00cb+DsNWKlD57CB0NlIY6djT9veWhE/kedhQ8tRwjh0skznQHrO1uMOmX5Z+JmK1O7gg5ZmOc=
X-Received: by 2002:a2e:7202:0:b0:2cc:e86c:7fc7 with SMTP id
 n2-20020a2e7202000000b002cce86c7fc7mr2602397ljc.92.1705333787796; Mon, 15 Jan
 2024 07:49:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231217173548.112701-1-jic23@kernel.org> <CAMknhBF1fyop-s38psUmKc8KVZ30psEtica3g2tZPczYN70=DA@mail.gmail.com>
 <20240114173336.360443cb@jic23-huawei> <20240114173909.1b8defec@jic23-huawei>
In-Reply-To: <20240114173909.1b8defec@jic23-huawei>
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 15 Jan 2024 09:49:36 -0600
Message-ID: <CAMknhBHUN_+uDvi2oQQ1HvriMFTm_82cK01yerc72sZN3kHuoQ@mail.gmail.com>
Subject: Re: [RFC PATCH V2 00/10] IIO: Use the new cleanup.h magic
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 14, 2024 at 11:39=E2=80=AFAM Jonathan Cameron <jic23@kernel.org=
> wrote:
>
> On Sun, 14 Jan 2024 17:33:36 +0000
> Jonathan Cameron <jic23@kernel.org> wrote:
>
> > On Sun, 17 Dec 2023 19:10:48 -0600
> > David Lechner <dlechner@baylibre.com> wrote:
> >
> > > On Sun, Dec 17, 2023 at 11:36=E2=80=AFAM Jonathan Cameron <jic23@kern=
el.org> wrote:
> > > >
> > > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > >
> > > > A lot of the advantages of the automated cleanup added for locks an=
d similar
> > > > are not that useful in IIO unless we also deal with the
> > > > iio_device_claim_direct_mode() / iio_device_release_direct_mode()
> > > > calls that prevent IIO device drivers from transitioning into buffe=
red
> > > > mode whilst calls are in flight + prevent sysfs reads and writes fr=
om
> > > > interfering with buffered capture if it is enabled.
> > > >
> > > > Relies on Peter Zilstra's conditional cleanup handling which is que=
ued
> > > > up for the merge window in the tip tree. This series is based on
> > > > a merge of tip/master into iio/togreg.
> > > >
> > > > All comments welcome. If this looks positive I'll make use of it in=
 a
> > > > lot more drivers, but hopefully these give an idea of how it will w=
ork.
> > > >
> > > > The need to always handle what happens after
> > > > iio_device_claim_direct_scoped() {} is a little irritating but the
> > > > compiler will warn if you don't do it and it's not obvious how to
> > > > let the compiler know the magic loop (hidden in the cleanup.h macro=
s)
> > > > always runs once.  Example:
> > > >
> > > >         iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> > > >                 return 42;
> > > >         }
> > > >         /* Can't actually get here, but compiler moans if no return=
 val */
> > > >         return -EINVAL;
> > >
> > > Maybe better would be?
> > >
> > >         unreachable();
> >
> > Interesting thought, but there is very little precedence for using that=
 in the kernel.
> > + I think it's a C23 feature so we'd be relying on whether gcc and clan=
g happened
> > to implement it rather than being sure it was available.
>
> Ah. I'd missed the default implementation in compiler.h.
> So let us fall back on the first argument of limited precedence.

Couldn't the same be said about limited precedence for cleanup.h? This
seems like a new sort of problem we don't usually have in kernel code
so requiring an uncommon solution doesn't seem entirely out of place.
It just seems to me like the natural solution here. It's self
documenting and should help the compiler do a better job optimizing
code.

