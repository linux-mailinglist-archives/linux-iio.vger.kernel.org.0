Return-Path: <linux-iio+bounces-21733-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB59CB084C7
	for <lists+linux-iio@lfdr.de>; Thu, 17 Jul 2025 08:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DA431A6842B
	for <lists+linux-iio@lfdr.de>; Thu, 17 Jul 2025 06:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14942163BD;
	Thu, 17 Jul 2025 06:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYf698IH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40C62147E6
	for <linux-iio@vger.kernel.org>; Thu, 17 Jul 2025 06:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752733346; cv=none; b=BSRbFld05SsBg7FBb0J1/p35CAbAqdKG43zFpg02kv/oP+kHnUklSxYF1zK1okl1RhDY5KnEXh/m+4avCskbr00CijF8l3TCi/vMOEmYzFwtOBg92pxvhtCZza1blhtq/V2WJeqh53P+P/4hULHPhZLLVzAEmp2jbbkDh2jsxh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752733346; c=relaxed/simple;
	bh=AlG25brTXeaPWO3N+D3I9w5YFJplNcGC0PDpZwDSHxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YJhR74Vu0iW5tl1fdHNgtV1yfYg1MasOh5txWz0kTYGsZqG45y9J3zpGIFbHFFGNWuT+msNsAT6s3mbmfzVP7MpdJStHI7V8ps4Gb03vp8hw+y82UhLZN3f5ZmQPMK0giJ+dcRFZlW6A/gRmHXaunotH+qYwnz6BSYnJbSshy0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JYf698IH; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ae04d3d63e6so113527966b.2
        for <linux-iio@vger.kernel.org>; Wed, 16 Jul 2025 23:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752733343; x=1753338143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AlG25brTXeaPWO3N+D3I9w5YFJplNcGC0PDpZwDSHxE=;
        b=JYf698IHpxrpcwJPK+9YtD1xnuUtEB94my6TD3Mk+UTwOu7iDBnEdlDSpsnIBkn83S
         bsWo4Bl8AJeN3/n86HSOaqcwPEklSClASMQkZy50B9UAa3VWLR8fCwzaKWmL4Iwtqhgg
         7+kZ3btd4nLK59Im6uvJVA9F9AkMn9GyExe9HBCN21ME3RLWylQeBciTP+iC20cIfr8B
         FCfvxtf3ZFnKV01mnEDZbzMBvQS2ENV69XbKNSekStblwgF875mC4kNfRPLSLnqPAtkb
         /hrCOBGogCPqw0WtvYdRHlw0ctBWhgVaaUmRnRNrJ6j5KnG4gVrdrh1HL9/RlNFHbSFm
         dKcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752733343; x=1753338143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AlG25brTXeaPWO3N+D3I9w5YFJplNcGC0PDpZwDSHxE=;
        b=CXGrNA1z/EdAJOOTMKFGGTCh92+hvX+7Hv3CpfH3NiUz0H1ZkHMb1SeZ5tu7EiICOs
         Fle8/N8ZZQDwloyp2e/z3nzBu5QCxJ9ohTx3l8DOAdPl0oPNegbtC2QY1yKFHmKzUkN0
         db3aLRlCNOQffO9Vf0gc0WQjMD9kpp8Qf+KRuqLhGDBB/sf7LGdW+RkOUCHkBDPgflH7
         0BhWsYkXL/Mz4OT1hZrbFVy8Y6Pef1fXKjQ8DNwuMTNR/uwke/0dlvBJ35m/4TTOeMbO
         v4bjRdZmHeluFnnr21U3ikCwEd1PqbzIDRcZktyMxsEuB0HdcMDK+nPTL9mkpnA1fg3K
         lvOg==
X-Gm-Message-State: AOJu0YyMf+s5xfXwwDpyoxPjD3Gu6PQavqTjaWL+fq3wJ6XZp2tOYHF5
	fWnJv/iuPrlatRrB8kkhVVjxt1+L4Uu0k5JsOvLZpEhF2oElvJh9pW0n6/1KielfZPuOiz1xNaq
	0hGj1MomhuV2+rW+4bI3AQAaKPq5EXgc=
X-Gm-Gg: ASbGnctBwzSVUrEzzDaELpIGlN3gVtoky/SybzRt6ga/XLg1kH5+X0kF2AH0Cg5NnX1
	Mw4lMRNYOKfOnTR99FUi/cB64NEKt7uetucv1dMwEWqptmQ8dr2TnjhSiswPAwIVW04leJljPhO
	WZaEpDgq9GDqQCFz8uXF8NtxSDu0IU7VqSCGH7Izp3/4fJYANDpIcL9KPiUVqxiBIevtpDZ+yBg
	NrOHMN2xQ==
X-Google-Smtp-Source: AGHT+IHCkAI2miwYNHs2g6eJYnq9N3vYGNJAwzJgcpakomhgRN/s/Xrco+m0zhoB1YXZ5TJ/0BMaJ2cx/dK3Sn2E8tg=
X-Received: by 2002:a17:907:1b29:b0:ae0:bff9:98de with SMTP id
 a640c23a62f3a-ae9ce10a59bmr491058066b.40.1752733342641; Wed, 16 Jul 2025
 23:22:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716192231.30337-1-antonio@mandelbit.com> <CAHp75Ve_geZr4+DPLD_g5ZyXF2AmKog-YShnohSAJ=qM5At12A@mail.gmail.com>
 <63b49206-5e08-4295-bc7a-cd0c54e82f15@mandelbit.com>
In-Reply-To: <63b49206-5e08-4295-bc7a-cd0c54e82f15@mandelbit.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 17 Jul 2025 09:21:46 +0300
X-Gm-Features: Ac12FXz-Cq6XACcBkFUV8ipcNu5dsK-DLgc_YTbZAoxuFxbwKC-wssNORocKIeI
Message-ID: <CAHp75VdU=8dOsG6U9mEZNx53Fm9EDHhQUHerNRB3em_JduhNjg@mail.gmail.com>
Subject: Re: [PATCH] iio: imu: inv_icm42600: fix 64bit multiplication
To: Antonio Quartulli <antonio@mandelbit.com>
Cc: linux-iio@vger.kernel.org, 
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 10:44=E2=80=AFPM Antonio Quartulli
<antonio@mandelbit.com> wrote:
> On 16/07/2025 21:36, Andy Shevchenko wrote:
> > On Wed, Jul 16, 2025 at 10:22=E2=80=AFPM Antonio Quartulli
> > <antonio@mandelbit.com> wrote:
> >>
> >> In inv_icm42600_accel_convert_wom_to_roc() multiplying
> >> `threshold` by `convert` may result in a number requiring more
> >> than 32bit.
> >> In this case, although `value` is 64bit wide, the result is
> >> truncated because the multiplication is performed in the
> >> 32bit domain, due to both operands being 32bit long.
> >>
> >> Cast the first operand to u64 to ensure the multiplication is
> >> performed in the expected domain.
> >
> > Is this a theoretical or practical issue?
>
> Can't say if it's practical because I don't know how large `threshold`
> can be.
>
> This said, `value` is declared as u64, therefore I assumed the result is
> expected to be potentially larger than 32 bits.

Yeah, but can you prove the potential overflow? Can the compiler prove
otherwise?

> >> Address-Coverity-ID: 1647596 ("Integer handling issues (OVERFLOW_BEFOR=
E_WIDEN)")
> >
> > Is this tag now official? I can't find where it's documented.
>
> I don't think it's official, but it's what I have found in the git
> history for other bugs reported by Coverity.
> I already used it on other accepted patches as well.

Are you an official representative from the coverity that runs against
Linux source code? Or please explain how it keeps those numbers (e.g.,
1647596) unique per project. For example, you and I run coverity and
we get let's say the very same number (ID) but for different problems
(even if we are looking at the same project), is this scenario real?
If not, we need to have documentation inside the Linux kernel source
tree explaining how to run Coverity, who is eligible to do that, how
to resolve clashes (if any), etc., etc...

--=20
With Best Regards,
Andy Shevchenko

