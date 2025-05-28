Return-Path: <linux-iio+bounces-19984-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22032AC62CA
	for <lists+linux-iio@lfdr.de>; Wed, 28 May 2025 09:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EF091BC3A89
	for <lists+linux-iio@lfdr.de>; Wed, 28 May 2025 07:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAD2246333;
	Wed, 28 May 2025 07:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKdsMgbt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76F82459C5;
	Wed, 28 May 2025 07:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748416650; cv=none; b=rtPkvo9FvxETUI3dabd19xrhm+wCNdaMabNpdfMFo8c+T7wuhE1Wb6m+EApHBHGIlLAUGFG7M/8Y9ksFhLH7Ow6zHADRkmpSzB7gjVVpzmk5AXLRpN1XgxgNnnbDbOEXDyYJbyMLUrJ+lkN8pxldPYOm/aObegx4BfH7xaq6/sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748416650; c=relaxed/simple;
	bh=bd/aJP8Z+HFGyFKthRLPNXegtvWYiD2y2JJ2wy+gcmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DB0oDGUsVgITxSyma2s2Yf6xcSI8ilC7odNrwWzG3pA9CyEJ2TXGowwQBU/R4ID8WXMUD1VmkFd78fR685/wYnmiu+dZmUBnbUwqUZ/tC1tgMUBixhJitbWp1JOH0b+ZcrpIy88pSRBVTzpgGmCEW6Jey4srzU8i/xOLndnnEUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iKdsMgbt; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c59e7039eeso561210585a.2;
        Wed, 28 May 2025 00:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748416647; x=1749021447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bd/aJP8Z+HFGyFKthRLPNXegtvWYiD2y2JJ2wy+gcmg=;
        b=iKdsMgbtZhL1peKScE7j+3LmxVr7+wXLU+QAVpcUEGSB63BldoJkw237YgIFbN2CGz
         t/bR/fEZMBimj7OYvO2kG7jTu4DG4Ggy2/sCJZ8khnY9YGlSWmTHVJhNkEovW8EbejX3
         7O14joWjKAMFxrPyB+npX6IBPHCpHa7dcLrBc/A2k1Fw1zP6LmhhUzaoYbaSFzjK2mxm
         dBkEacSlK4JMxoIcnJ12w9lk95OxuCjqy7LtnNqA9yyGMjMLpw6WBksI0TjQHGUIq7oA
         loZI7yIHVx9beLCtToSSUGerPJ6iM90UiDI9xuESnh/Yd/5uhjtVPNoKFtgJafC2tEEd
         0KIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748416647; x=1749021447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bd/aJP8Z+HFGyFKthRLPNXegtvWYiD2y2JJ2wy+gcmg=;
        b=EKQYJKmh/RwIokOQYAVLJfM8Uc+KvCH0dtW6GEGxnlw9VCwHU7jrwtdFOrT0Z7O7Me
         s1hl3GeTZDFF1h+p3zR6UgefB3X3pnXPUXoHaLRzHXlI2Y09Ld4pvKJXShNISrdJVDpi
         98TARe4uzGWIBZwWEXEhSNwwkALsEDD0xHTyM/z16iXVS9JheJ2fjewaOiz2MyO26vzF
         wmLnYoTX3fM3mBgnBnu/w4U6q8LCj2v9MwDaauIf51whFJpIul+9S+rnH1lWf12cLLT1
         NS/DI7m2hfSx5gAbBVnKac3ihMCtHGVs0/9NptP+bOfzI5jvZvAt2z94qVc1aWPb+9ry
         9XdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsV+c3L4+7WwHuW1VE2rpMiojOhZh9udqwBorF1ApgrJJ9vCxH5OeJ3C/3ANmr1752nKMbw7Z5+oo=@vger.kernel.org, AJvYcCV1OMoDpahVjAPXhMlpdbs3ISQj1Ik5sq/5iAcuy9gTUWyImejeT28Kqy8TZ/Qb9ZC5iYXM7MPURdkD7RdC@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6dAb9lawxli2Eb+C9uDqJMzdEsd0Iboko7sfz8zqLzTB2Xy/O
	tDf/sqsTc60mC+aAeOGeiHiMIkKeYw833aIVRr9WCzRfxbJdzXCno4IHt4ixn2pTFurQVB1N4/i
	ihTY+TZXqtjuITIwCjBDRfjYffEjtyebx9OPE
X-Gm-Gg: ASbGnctAx5S5rqoNpxP3VnKd5HmpW32QmxdppnLmpSzPfEPqzWj5RaXYhcLfjWraQt7
	EvH/bS94S50hC7wZlnnwYtBfn/DT+AFlOBypT3qYZdLxe4Bp55qcnBU+Kj2XkLTvs/Hqmu/nhBD
	gDdCZkCNjG+T1GBLBdUfR3ter1sX7wSWx9uelkE3zCSWI=
X-Google-Smtp-Source: AGHT+IEcA1KfBo8BpmPpVnNMOQSYL7FTtU+tEkri+kXIIGVB2noWHyiZVcSqevKrJX8uVLLo8KqamkiUBCc70hZqEa0=
X-Received: by 2002:a17:90b:4b83:b0:2fe:baa3:b8bc with SMTP id
 98e67ed59e1d1-311104b6bdfmr20792918a91.23.1748416637352; Wed, 28 May 2025
 00:17:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250527200534.98689-1-gye976@gmail.com> <CAHp75VcUr7-X+F1f=wPH4=Z7q3kFffv8BgkmKWM4VTjy2w-tGg@mail.gmail.com>
 <CAKbEznuuGX3Gnqg6WF2mqbigRps0gzK_PfGHGNy8-v1WOZoMUQ@mail.gmail.com> <CAHp75VfEeNyspiMSax1_d+cpbmCQQVbOBEPCHuAag2O0ZHC1jA@mail.gmail.com>
In-Reply-To: <CAHp75VfEeNyspiMSax1_d+cpbmCQQVbOBEPCHuAag2O0ZHC1jA@mail.gmail.com>
From: Gyeyoung Baek <gye976@gmail.com>
Date: Wed, 28 May 2025 16:17:06 +0900
X-Gm-Features: AX0GCFu9luqM_jmgZAjq-9c7kyPq1xlIiuHnZ845qEB9XjiYNxbovY3TIngikt8
Message-ID: <CAKbEznt7ZhN9gZWy-7wHhFhwbF8XtCGrukuxe4eAFZpfxfu6vg@mail.gmail.com>
Subject: Re: [PATCH] iio: trigger: Avoid data race
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 6:19=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, May 27, 2025 at 11:10=E2=80=AFPM Gyeyoung Baek <gye976@gmail.com>=
 wrote:
> > On Wed, May 28, 2025 at 5:25=E2=80=AFAM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Tue, May 27, 2025 at 10:05=E2=80=AFPM Gyeyoung Baek <gye976@gmail.=
com> wrote:
>
> ...
>
> > > At bare minimum they are not relevant to the patch change and haven't
> > > been described in the commit messages.
> >
> > Hi Andy, thanks for your review.
> > I initially skipped this part as I thought it was minor.
> > But on a second look, it seems better to separate the declaration from
> > the logic.
> >
> > What do you think about the data race logic? Would it make sense?
>
> The point is valid, the atomic_read() + atomic_set() is 101 thingy,
> whoever did that doesn't really have a clue what atomic(ity) is.

Thanks for your explanation.
Then I=E2=80=99ll send a v2 patch with only the `int i` change, following t=
he
review feedback.

--
Best regards,
Gyeyoung

