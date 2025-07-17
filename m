Return-Path: <linux-iio+bounces-21735-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFF4B08D89
	for <lists+linux-iio@lfdr.de>; Thu, 17 Jul 2025 14:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C20D81897285
	for <lists+linux-iio@lfdr.de>; Thu, 17 Jul 2025 12:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212AD2D8386;
	Thu, 17 Jul 2025 12:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icWLeq3L"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A732D1F7E
	for <linux-iio@vger.kernel.org>; Thu, 17 Jul 2025 12:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752756749; cv=none; b=TfLGldKO2fsmUZGg09YYUTXPd98c3i7H/wpF0NDY/4gL2/HCJfZpBHFywWnkiMY2hf7RC8QUBfQtUYUb2rJvvN0Pp8Sb5+WcMdNQOwg1/doBLcJsABhGk4gIRpzExPFbwhcaeBYTFFURPYvaKyqTucbgJvokEdxEYOOwbYKFEGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752756749; c=relaxed/simple;
	bh=LqpLFU47gpf4EpYc4sRpXfNCAMe3lSRZHdkXOjLSkng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L6g4eLOyiPhH27NyRj4OQe2nUiQ4aOL++2sejaAZihFdYfw9+Qc8CNn1RTNu8jBRx//s0JudjSgjAFGQD24CE/TdhECmwxhX5DAaNS7o1AX8O7hPkZGfRSbYubOcp4VhfjUciSSygRMjsjFTKwHAX+6P+ErUD8QR7TCj3OHt4I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=icWLeq3L; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-60c4f796446so1358113a12.1
        for <linux-iio@vger.kernel.org>; Thu, 17 Jul 2025 05:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752756746; x=1753361546; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LqpLFU47gpf4EpYc4sRpXfNCAMe3lSRZHdkXOjLSkng=;
        b=icWLeq3LjhGrjZ75tglRRQhEnKCuobf05kZMeAZOO+P/38+/t8UzFW2i9IEKjshjUc
         AXS1xrSD2rXhDk3gvj3UA+U7uYyn8mxdl31Oxh2/xEDfXIuwYp5VSbOYLXJquL5U8O9o
         4aWX1uq2GWt66RAbF8hczaXt2AyYSqCZfPa8SOtlYizzz9mHUAkTZkgRrAWLagq8J1bK
         XAtVOhKrdLdYkftf0uHWn86BV+Bdu4yNcLXhF7iS7txIFcqjM/Q9gqJOb+LzCY/QKBkF
         Re+ad+NQLpScoOVL9PyXSYNt/S7XsqvkQeVDeWn+GxVv243u4TdB50MJp+9ciGXm8Iog
         NZdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752756746; x=1753361546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LqpLFU47gpf4EpYc4sRpXfNCAMe3lSRZHdkXOjLSkng=;
        b=i5SAHI+ZH6K3R6nxpu/2PEkMG8Gg4ZB6wO3VkPgFjodxgOvum4ila7n3R5WCaaT8fw
         KdaGapRDf2k1lah2MorS4rUuPeRMe1I08D+Mb69h0H4ho+bagA5R/QmkdZCXi9hEcxjS
         y6kQrgVIatkpDkrHkjMmFb5scCxhW/7IpwGBa9tjQAplmpr+hR41djCeuIno5sm++Hym
         10JrGfH3h98cAPhVTeQ3RRaxWukzXfL+AcYeDc5dA3IBhtAxBmPpdhfuO85R0QvisHuj
         jSUqY6yhWPq60X7tXex13s8RqlL3DIUbqVm+jct8eOSr0t9IzoVUfLixC/21NkSlrkOZ
         x4dA==
X-Gm-Message-State: AOJu0YwG33tx6WjH3JOhoEgYRGexY5q7QAU4o5XZLBp1e3yjbhV79V2x
	BTd6YPkymwbva1hdvA8kJtv3yUt/fvT8iGxmb5yg2uQ7JEdelaqC4qwS+2NmRUTgHVdkoHtENIN
	UBqzoamraI58cfnYc7YEJxOBqLC/Q138sJbyW1BM=
X-Gm-Gg: ASbGnctTJsWXZzgeA9YDQcTHUDcm1z8XvYysPOJevQDpm7wzBgdq6j6lH57rW+kSG1Z
	msuYiRGPcIqVmObV4DKFNYD5+NuXeActaMBY9Qrthdelna6ihvq6yqc/unu7doJSMgyEzdk5FfT
	DSZQKd+eSMz7jOAyiPju+lbzfblj4JdoVliyppnPADK+lya7t5qM/yNS5h5DYXf9N/TgqdMqpAF
	lqPsbKxuQ==
X-Google-Smtp-Source: AGHT+IE5QukTRfe8Dfp6gX9QcaTDIw5TSh77oi4AXizQmZn3cKHhHTYOKCK5zoe4yWepEMJWTUUObsYiDmlmhHG7l2s=
X-Received: by 2002:a17:906:730f:b0:ae0:aede:8a2c with SMTP id
 a640c23a62f3a-ae9c9ac14a9mr812310066b.32.1752756746041; Thu, 17 Jul 2025
 05:52:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716192231.30337-1-antonio@mandelbit.com> <CAHp75Ve_geZr4+DPLD_g5ZyXF2AmKog-YShnohSAJ=qM5At12A@mail.gmail.com>
 <63b49206-5e08-4295-bc7a-cd0c54e82f15@mandelbit.com> <CAHp75VdU=8dOsG6U9mEZNx53Fm9EDHhQUHerNRB3em_JduhNjg@mail.gmail.com>
 <98b8bde7-0288-42fd-a341-a6d04db5184e@mandelbit.com>
In-Reply-To: <98b8bde7-0288-42fd-a341-a6d04db5184e@mandelbit.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 17 Jul 2025 15:51:49 +0300
X-Gm-Features: Ac12FXwjYZl5VN9E_YphzniXuAj6CzatPRKS3_KwYEJVapiP_cohxPugEltygHI
Message-ID: <CAHp75VeWvhW=b0Q1Cvr1njo7MG1wk65zJAe5tgiYncJTDauFXg@mail.gmail.com>
Subject: Re: [PATCH] iio: imu: inv_icm42600: fix 64bit multiplication
To: Antonio Quartulli <antonio@mandelbit.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-iio@vger.kernel.org, 
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 10:50=E2=80=AFAM Antonio Quartulli
<antonio@mandelbit.com> wrote:
> On 17/07/2025 08:21, Andy Shevchenko wrote:
> > On Wed, Jul 16, 2025 at 10:44=E2=80=AFPM Antonio Quartulli
> > <antonio@mandelbit.com> wrote:
> >> On 16/07/2025 21:36, Andy Shevchenko wrote:
> >>> On Wed, Jul 16, 2025 at 10:22=E2=80=AFPM Antonio Quartulli
> >>> <antonio@mandelbit.com> wrote:

...

> >>>> Address-Coverity-ID: 1647596 ("Integer handling issues (OVERFLOW_BEF=
ORE_WIDEN)")
> >>>
> >>> Is this tag now official? I can't find where it's documented.
> >>
> >> I don't think it's official, but it's what I have found in the git
> >> history for other bugs reported by Coverity.
> >> I already used it on other accepted patches as well.
> >
> > Are you an official representative from the coverity that runs against
> > Linux source code? Or please explain how it keeps those numbers (e.g.,
> > 1647596) unique per project. For example, you and I run coverity and
> > we get let's say the very same number (ID) but for different problems
> > (even if we are looking at the same project), is this scenario real?
> > If not, we need to have documentation inside the Linux kernel source
> > tree explaining how to run Coverity, who is eligible to do that, how
> > to resolve clashes (if any), etc., etc...
>
> There is an ("official") linux-next project in Coverity managed by
> Gustavo A. R. Silva, where all maintainers can subscribe to and then
> receive the weekly scan results:
>
> https://scan.coverity.com/projects/linux-next-weekly-scan
> https://embeddedor.com/blog/2024/09/28/one-simple-and-rewarding-way-to-co=
ntribute-to-the-linux-kernel-fix-coverity-issues/
>
> I assumed all IDs in git are taken from that scan/project.

This makes a lot of sense! Gustavo et al., can you make a
Documentation patch to explain all this?
Personally from now on I am okay with the tag as long as the patches
tagged with it are at least Acked by Gustavo.

--=20
With Best Regards,
Andy Shevchenko

