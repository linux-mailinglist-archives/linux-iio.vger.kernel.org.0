Return-Path: <linux-iio+bounces-23182-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF6FB33255
	for <lists+linux-iio@lfdr.de>; Sun, 24 Aug 2025 21:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D70753BA39F
	for <lists+linux-iio@lfdr.de>; Sun, 24 Aug 2025 19:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7D31F91C7;
	Sun, 24 Aug 2025 19:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hf3OMcO/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD14614A4F9;
	Sun, 24 Aug 2025 19:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756063158; cv=none; b=im9LDOZrfLHQy7yTPZJy7DyYJ8WMRRZ9lF9DW93YmIAaWOD72RsEbEqUa8pEcRhaSZ1edRTNZ7ANcC66VDE/y6boa1TDpRhgOIUOKA8JJxwoCJnnGCdzklPpyby38LAPytIiKwmXesFJwQzxUe3sgXEi+sQKQsH9jgyC1/jiW6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756063158; c=relaxed/simple;
	bh=FF2wwvnb7LeI/rXhcslh/3INph1e8ZefN7u6tDjJ7mI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t1u2ao+ioMp41WVLAh/JkZ3pDsGOT5ShiNP3OtG75euH5da4RaHYk2CueUmXl/a5qzKP47JerFBSIzjwLfal16r/wCzozdxlq3Pugs8Av9IXrRy13UJ4qINit7ZxpWsPS2DAE42N4YaDTlOoyLQFS92RW5H4B5KAPf/i7n+YF4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hf3OMcO/; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-afcb7347e09so630257866b.0;
        Sun, 24 Aug 2025 12:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756063154; x=1756667954; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P31MEFWfiBDcFLjasshG2Q33dnrA+kN2tAwhwtnYyuo=;
        b=Hf3OMcO/5cSu8VqIos0dvc6DtwFlLTw09/ocHt03of7d79y5xIaa60mEQmDg3UoCbo
         0DLNflh37FCAXcs8NvEdP5J3sgk7MO1F0GfSxSz0xE926WdV9aIq+HZT+u2JU07KJYaX
         4p7UyxkhxsC4Lm+K1/MdAiMCr/1G2Rubky6jfwHTPy1EzK1CSF6nMl408e4nIxf0MWTr
         9H3CbR7Lb9JdeGovoSsUNt+svNE2A4zCvbDFksmXV4yUHVa1kHy4U0yviV2zYzrr8PGo
         tzVwzMO4DqhhqD4epUAr20S1NQIIX7Me4bp6EE3+iozQ88dXeL0USi1ZwO/zwFz6IVKr
         WQXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756063154; x=1756667954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P31MEFWfiBDcFLjasshG2Q33dnrA+kN2tAwhwtnYyuo=;
        b=G9A+RC4EKybfgJ9qCjXiPSFqkOlFlCq2fSPVxcKIxlPCxLE64TvP+xlRmrPpps9Ibn
         aENmTh+bi1a7xZ5s//g3Dya5R88mU2s7bvdwirlbj2v9KxLqc+IMUJVl/2NnwWPt8RB/
         eqCncPzI4bEM1SzkCZoGnbcEdzoyyHSqddvPEqnTP3YJyv1e6fbvPahJ8IFmKt577qKQ
         Ycn96sGw3n2Bm0EWRyOAdsYt3ddSheTWmm4TBv8gNjqTg+vST2SnPnHuo9S3KHNIeVBD
         Ka4DfhcsXBj57BeYqRvs54PXBGqbOIszG8Ivt4yl362y5QRvIlV1Nfgw6coeKpSGRrA1
         5eUA==
X-Forwarded-Encrypted: i=1; AJvYcCUz3PEx224f4HuJmmVTP/j3z8If+70H/GWf/8alwlsfuOpUxhKYs2eoV4mHJmilaPqeq/BCGOViTco=@vger.kernel.org, AJvYcCXmpGAug2tSO6/QhUogKfZtH32Wfu4/LRYu4N6+jEZ5dGtlWlVYq87vNoMA2JL5hpDDUz5wJC16kSnaeole@vger.kernel.org
X-Gm-Message-State: AOJu0YyfkjOsfZpudvzn+x2/ZF9V+IWYFGgpuJx0dem0ft6huIVmYPB6
	tiFG6k9jP4rtMNEOp6IDOHuy1lc0ZuEn3xXHrClsRU4gP/c5+WLwFr59QXrWMYYIY6Gv56xRhZF
	MbLNkdBKMuaIXeB+At+IObXwpPDLujsBzmvnqJt8zQg==
X-Gm-Gg: ASbGncsB8hujECu6Tgx/FCsiKBj3rLbHn7k2fHMINHVuVtiYmYcXPh3HDzQuvR2WNdd
	M6tej7Vs0RAr7X2J3OnXs2/V9pPvOK/SPsWOD/Vz7nCAtoeXNHWSAoyLT5JP+ZRMN6xMlBkoNfO
	qgVW3Ips641d8/i++T2x6UVFppotsnYE1JYFIiWMyotHNnWFXwJA62KG/1fsKGKGuLqLpLBQzXc
	mN9T70=
X-Google-Smtp-Source: AGHT+IHCT2zDSXD/L3GSuxA+gxdGUgwEs8H2u4IqtSR8nJxD8VlOUizuwPWSwQJDYYyjlCqGJcnZmVMIzg9Qb2BouMc=
X-Received: by 2002:a17:906:7953:b0:ae0:b847:435 with SMTP id
 a640c23a62f3a-afe295c1e9bmr841553566b.49.1756063153670; Sun, 24 Aug 2025
 12:19:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822180335.362979-1-akshayaj.lkd@gmail.com>
 <CAHp75Veqf6tKiFh=dNkgNkc2qE17VM7u-Yt8CZaXOsnEFUwd_w@mail.gmail.com> <CAE3SzaSW7j0yNaD9yQzc5KcJ-LH00TGebLQYDkuqwjky3ZBohA@mail.gmail.com>
In-Reply-To: <CAE3SzaSW7j0yNaD9yQzc5KcJ-LH00TGebLQYDkuqwjky3ZBohA@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 24 Aug 2025 22:18:37 +0300
X-Gm-Features: Ac12FXxhmGNy1qak8a9MGAxjdIWYXkbNbXmrNAurlxqWTWJFphO6xqyA0T4FCHM
Message-ID: <CAHp75Vd4V5o90q7-burt-S3_YnZ3bfaKXdFuTRcy05x0cvz8DA@mail.gmail.com>
Subject: Re: [PATCH] iio: light: ltr390: Add runtime PM support
To: Akshay Jindal <akshayaj.lkd@gmail.com>
Cc: anshulusr@gmail.com, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, shuah@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 23, 2025 at 12:10=E2=80=AFPM Akshay Jindal <akshayaj.lkd@gmail.=
com> wrote:
> On Sat, Aug 23, 2025 at 1:41=E2=80=AFAM Andy Shevchenko <andy.shevchenko@=
gmail.com> wrote:
> > On Fri, Aug 22, 2025 at 9:03=E2=80=AFPM Akshay Jindal <akshayaj.lkd@gma=
il.com> wrote:

...

> > >Ensure that interrupts continue to be delivered during
> > >runtime suspend by disabling the sensor only when no
> > >interrupts are enabled. This prevents loss of events
> > >while still allowing power savings when IRQs are unused.
> > >
> > Have you tried to enable it as a wake source and disable it?
>
> Yes, before coming onto this approach, I had given it a thought and hence=
 did some R&D for this.
> Official documentation here & here talks about power.wakeup being an attr=
ibute for system wakeup
> NOT runtime. This checks out because in the complete IIO subsystem, there=
 is not a single driver
> which implements both runtime PM and wakeup functionality.
> As of now there are 4 drivers in the whole of IIO, which enable this wake=
up capability
> and that too are only using it in system_suspend callbacks. Hence I had t=
o come up with this approach.

Please, make sure in the next version the summary of the above is
present in the commit message or comment block.

...

> > > +               pm_runtime_mark_last_busy(dev);
> > > +               pm_runtime_put_autosuspend(dev);
> >
> > mark_last_busy is redundant.
> >
> Pardon me here, but I am not able to see the redundancy.
> I think this should be very much there before we call _put_autosuspend wh=
ich further calls
> autosuspend_expiration() which reads this last_busy field.
> Did you mean dev->power.last_busy is being updated elsewhere too? or some=
thing else?
> Can you please clarify?

https://elixir.bootlin.com/linux/v6.17-rc2/source/include/linux/pm_runtime.=
h#L603


--=20
With Best Regards,
Andy Shevchenko

