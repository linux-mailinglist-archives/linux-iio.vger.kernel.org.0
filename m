Return-Path: <linux-iio+bounces-14256-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C6DA0ABAD
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 20:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B11C1885917
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 19:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB651C173F;
	Sun, 12 Jan 2025 19:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6HwzHu4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963201CA8D;
	Sun, 12 Jan 2025 19:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736710164; cv=none; b=T5Cm6rttCa2Kw+DMsxCU1wrppT4lmPEW8THnbhjeWXAITtN3/sGdAaIHHB+hdXAomdKcQSVJi0hE59zegO40+3IUMW5xwbZI852mfEjwX558x1uib9lIhkf0Eh9/fdJdFAZrdSF7BolmcW0AvtOeze2jPl3FaL40EpyWMEI9SYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736710164; c=relaxed/simple;
	bh=bRKk3YMR85DzsGMTu7b3JfeO2kwLJcgSpTy87Z7d1yg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uMtTLq2tee6sLdiFwBiUKw3LVE9baDrAxlxPrrtsyP49qwlZhTyqVXPuY2fdrrDUO7M9SNtKx6oAzahHgwIrza7Mq27BBTec+fIDqvOaUnyXDYud5y9RiaxZtM6+M80WeiWvmbnuMGbLPTNYMOWQ3ZfdaVyNLc+HpG8jWsu/ghU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q6HwzHu4; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa6c0d1833eso746575366b.1;
        Sun, 12 Jan 2025 11:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736710161; x=1737314961; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Monh7qKKJuJfcoMTV7YZr3NGatpOZq0i1SjB3z17CVI=;
        b=Q6HwzHu4LbeL3HCV0Fq3qm7oetY11YZRpV9P5KOX6vcGBYqA1YEjzcwxgXggd9o1cS
         Jz4u3vlB7g2alnwZBiTE/YgCQGpIzjWuoC2wrF9fI0FKKfqT4SfTShsfVzs44b/kWJ47
         UaRhLamZDrxz17NT6Ckt0eRkb7KzlxWHiFtUsujbN6kJqPH2hr2jOOCEMIgWi9bvOsAB
         H6Xbkr2FDaMo82MuO0uU7S8oPM0iHGijdIiWcVLwt5PdazZahKTBVok0Zx6551EKuc7T
         Pb5oeZr+gWevGXoOINlU9RI7cqWEn0skpGHoPeahSXKsIsH5/mPiTkfJvFeaH8eko544
         9OAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736710161; x=1737314961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Monh7qKKJuJfcoMTV7YZr3NGatpOZq0i1SjB3z17CVI=;
        b=FiMgrvegvmrgh2vzD2JyWpTMrERXLG5OFtKY900adJV+yFHgV4uYfH/xpWi13eBscO
         d7qNbwueDuObiiKsGvzn+bhWe+c6QXmTkjYe8YCK1WipkmbSZSdBdzzjB0GtoQFQc2Ak
         YfPT/Z0eHZyqsFwEYloyJKJvV4zkubN4727F+xSRnvnW4qMwo4V7I8BGrIH7bdUC1Y7p
         DYcEdmj7QGqd2R5h4NZwxaXj85FLMXEJHaFh7P6pREsYBjEztDXJvBfVOXoT/iLsk0CT
         07taJHZwXEDpQvVgYDpFqfOJvxkxAKz8ZnXAFUfrRdqa7TAGfvEZvxoO1+l1odw7OMOx
         aAtw==
X-Forwarded-Encrypted: i=1; AJvYcCV9wN+MsTT7EPC2fLuRrZrDnyMbdJcyFbWJkDz3qsM6RssOIAfa7uc9SbHG5OrYvdQ2E8rk+5Oo6J0s7I1t@vger.kernel.org, AJvYcCVUcaXvBSg6RACR0X39XfFcGxdxiXyFKSOqTDC992crXW21CeY1SjVuOd69Y65/GHwu7Geya5lXevo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaHEPRzyksuUJZ+3EJxUXBN8uOAkciA37+OEKHWn9DM/NA19z1
	xl1QOo61rWywj4NJwtpMB8OCK2qM3ns+PkPHtt9rrAZmFI/9AIXcSiDlixUg7kmq9sHfwrKshG3
	6sz4WIjHrl0VuA9J2oy655SD2TQo=
X-Gm-Gg: ASbGncvUw8bodHzziENIhLz9MIftJRow5WOYaVoEMt9mF17oIRO+EP3m/b1IdAiA8Gs
	y3Jgh7tv8jjzf9uhfjZLrnYcGfRTFpnmntZoZMA==
X-Google-Smtp-Source: AGHT+IF+LQPMbjAGfU4Gop48mbNRlb1dcJlGAONcivCqvFJUnIuR4mmaE96nHmCW2WGO5IFpe4C6Zc7XoqGJM2IhFDw=
X-Received: by 2002:a17:906:4788:b0:aab:9842:71fe with SMTP id
 a640c23a62f3a-ab2ab6fd650mr1700269466b.13.1736710160865; Sun, 12 Jan 2025
 11:29:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241228232949.72487-1-l.rubusch@gmail.com> <20250104130916.5a25b5bd@jic23-huawei>
 <Z4Poo4x9xvBpdeso@surfacebook.localdomain> <20250112163836.512ff0c5@jic23-huawei>
In-Reply-To: <20250112163836.512ff0c5@jic23-huawei>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 12 Jan 2025 21:28:44 +0200
X-Gm-Features: AbW1kvYImTE1m-pN5KND29JPHiL4mS0JC7t9sYT1hrfbgCcKBlfRythOG2Zu18M
Message-ID: <CAHp75VdCqUayfUyRcDSN0D1friz039Bqjxb5cOYQVCfastGrZg@mail.gmail.com>
Subject: Re: [PATCH v9 0/4] iio: accel: adxl345: add FIFO operating with IRQ
 triggered watermark events
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lothar Rubusch <l.rubusch@gmail.com>, lars@metafoo.de, Michael.Hennerich@analog.com, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 12, 2025 at 6:38=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Sun, 12 Jan 2025 18:06:59 +0200
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
> > Sat, Jan 04, 2025 at 01:09:16PM +0000, Jonathan Cameron kirjoitti:
> > > On Sat, 28 Dec 2024 23:29:45 +0000
> > > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > >
> > > > The adxl345 sensor offers several features. Most of them are based =
on
> > > > using the hardware FIFO and reacting on events coming in on an inte=
rrupt
> > > > line. Add access to configure and read out the FIFO, handling of in=
terrupts
> > > > and configuration and application of the watermark feature on that =
FIFO.
> > > >
> > > > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > > Series applied but with a tweak on patch 3.  Please take a look at th=
e
> > > testing branch where this will sit for a few days,
> >
> > I would expect the comments I gave to be addressed as well before going=
 to
> > upstream, but sorry for having a bit prolonged vacation.
> >
> I missed outstanding bits.

> Suggested improvements will need to be handled
> as cleanup patches on top.

Yes, that's what I meant.

> Hope you had a good vacation.

I have a good enough one, thanks!

--=20
With Best Regards,
Andy Shevchenko

