Return-Path: <linux-iio+bounces-17265-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D958A713BE
	for <lists+linux-iio@lfdr.de>; Wed, 26 Mar 2025 10:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91ED53AD9E5
	for <lists+linux-iio@lfdr.de>; Wed, 26 Mar 2025 09:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8657F18C034;
	Wed, 26 Mar 2025 09:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGXhz9Na"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCDA2F42;
	Wed, 26 Mar 2025 09:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742981617; cv=none; b=L84hvcHvtI9vKucMo3pvo6gAtqwhpsizGu82wYpVSLD3SexMDyQj9zJsNi2fAt/4fiDKp/3mRKzHXaUzzOfDvBRnSFLEQ7/SQBf08ClBObzWXrR8urJ28+GdsI560afs76lBJY6j3uyfhfkEV7VY0ftcCMdymTt1cQAge7DH/oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742981617; c=relaxed/simple;
	bh=uAA2hM7tPaYfJN/zb7UpKxsTEfTA46sept5quLi9nAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eUYWkAPX7czw4d0xQf8iM//FPp1M7pFrppYjNxpATx8M+p14eU2nH+ZDbjXFdlAB8R9qXuwaK5mNA/5avnJg/JGyz5bxfB0Ov8pfDfbxrLYxPre7a7CiUensqj4difMyea1biC3b8dJtvLqdSyx/YISDajN9Trgz97WUel38sjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jGXhz9Na; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac289147833so950771566b.2;
        Wed, 26 Mar 2025 02:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742981613; x=1743586413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xw82ouHwqu6P+Pu6iOwX0J7CTE+gv8SpwU7wjfAuYnM=;
        b=jGXhz9NavGStDUItbblqHyBYbVgD9Yr9xSqhCATxFSOBqD5C9yJDiMp0OpdZ6LIFaT
         XJCmYFew7URUa6Aj/uGN0KOIp4kGjw5voE/cM+cNkV9iUux44MBCBo1fVnTS2yX3bjep
         6GbByoOxdo/c56cd0tsBHq8daEhWTS+/OD0KTrxcuEYM33qMaGDi900UE2HzUQWjjqI1
         +eaXtJkK2FxXyJym06+5weQJJ9tDcr5dXaYG7w9c6N6+aX4FEZ+DnGffCdMkHuQXfjMT
         iVGqqe/yGR8sf8CXxr59copwtVNJ5pR5nS4QOXVWoF9uBs3w1xsHl6MG2WUrY/D6AM69
         ZqSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742981613; x=1743586413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xw82ouHwqu6P+Pu6iOwX0J7CTE+gv8SpwU7wjfAuYnM=;
        b=XLJXHLurbvsVxTNXnJeW8vtHn5N7Tdnbs5Acx4nK/HXjRyK0krWC1/Br0VMsHobdHA
         hI6hyNZwHoeTQJGdLyHVzp8MI8Ly1wr7fSJiRDtQTyGskPI1D/YRRtpyiXs9WH7beewF
         IPWX7eyyaA14ekf5ZNVsv2mrFIxaDMm9ih6dh6TtUPpwjGjKVUx9NaY1dwTIMXMBCTBv
         czNCfPSay8XpdfMOen9e55VaHwMgquhNv+5TSB6Mls7nQjZeo9qsWVBTSw1SYllpe7rE
         9Gyo5IQqsKulqdE5xM2VbtdJgdVw+ZD+oM7YzdbIkHM8JkomV0ZKcNMReGSz2/lOzp2B
         4hJw==
X-Forwarded-Encrypted: i=1; AJvYcCW6iDTXYI1SV+DoL8J52r3IC3jh4JtHup0dfNrn7j+Lv0C2kRmweJ5oan+7wDEqRsp39wAmMoFWgPjCC2Vi@vger.kernel.org, AJvYcCWwlC4kAVH+10BUDa2NMRr4oNhRW2ifaOGG1esGJPgYxbLPCceS5/YFxC+QXs8jV7e8CTlUb6v47zE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc9nT4ynK2Q6nxos7jxEvoOetUcZlUc/1sQOWkBQf/PfYD8d/3
	FMTqexdPkA2c3E3po/AKKL6zitT4M8OpykEJkkdQ2mifUYyGD5csel7xDQmaNx88OZZZbKvmmJr
	zVYCkRQQ2dMYgf5We79ctMjhbB3c=
X-Gm-Gg: ASbGnct5NGtkEZaUStI0LWHHxRMAVkaMpOzyAr0mXX4tAGHd3RcVRdWfdri0XboA8Wp
	ZmQipDIT4lRV3rPhRWSQGJraB/wa1pd1cpPppIcffL1vcHm8PJ+PyNuYEbdUHfLs9Qtr2mG6FZZ
	vcPbyYUjLwDUsAbOYNJ+489a1m5N1k
X-Google-Smtp-Source: AGHT+IEEmFEjdvTMARkp1rgUl5EPFLUzl4s9fa7jUzu3UM3H3HJL8PThybe23wEseGUCeQQhiAzbA7CtgNRJHfTM1i4=
X-Received: by 2002:a17:907:a58c:b0:ac4:3d0:8bc8 with SMTP id
 a640c23a62f3a-ac403d08cb3mr1769289166b.35.1742981612683; Wed, 26 Mar 2025
 02:33:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313165049.48305-1-l.rubusch@gmail.com> <20250313165049.48305-5-l.rubusch@gmail.com>
 <Z9ctSODRTxI53jAY@surfacebook.localdomain> <20250317105540.4b4a586f@jic23-huawei>
 <CAHp75Vc=c=0yhtaKuiE4mZTTzQdrPywt89E7A1GuHha9=V=GUQ@mail.gmail.com> <CAFXKEHacRWoGz59FYJJyYjOsg5CBTAFYPdwobvmF4jUqZJJAqw@mail.gmail.com>
In-Reply-To: <CAFXKEHacRWoGz59FYJJyYjOsg5CBTAFYPdwobvmF4jUqZJJAqw@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 26 Mar 2025 11:32:56 +0200
X-Gm-Features: AQ5f1Jp7jSPC31UoveOOEhcsclqhj_67D0ecmOwqEy81dGrFPNlJI1kX10V-6hw
Message-ID: <CAHp75VeNXZB_sbrvLAdo-KunNeq2WwPVpA6AsF7t2P1TiBLB5w@mail.gmail.com>
Subject: Re: [PATCH v4 04/14] iio: accel: adxl345: introduce
 adxl345_push_event function
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, lars@metafoo.de, Michael.Hennerich@analog.com, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 11:45=E2=80=AFAM Lothar Rubusch <l.rubusch@gmail.co=
m> wrote:
> On Mon, Mar 17, 2025 at 4:52=E2=80=AFPM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Mon, Mar 17, 2025 at 12:56=E2=80=AFPM Jonathan Cameron <jic23@kernel=
.org> wrote:
> > > On Sun, 16 Mar 2025 21:58:00 +0200
> > > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > > > Thu, Mar 13, 2025 at 04:50:39PM +0000, Lothar Rubusch kirjoitti:

...

> > > > > +   int ret =3D -ENOENT;
> >
> > Also note, this variable is redundant as far as I can see, just return
> > the error code directly.
>
> The pre-initialization of ret is actually needed in the follow up
> patches. Anyway, I can return -ENOENT directly here.

Just do it when it's needed, I mean that this patch can survive
without ret variable.

> Evaluation of the sensor events in follow up patches then uses the
> ret. It is also possible that reading sensor events fails, then the
> error is returned. It is possible, that no sensor event happened, then
> it will fallback to -ENOENT. And, of course, if sensor event happened
> and could be handled - no error is returned.
>
> Is this approach acceptable? Say, if I'd describe it better in the
> commit comment? Could you think of a better approach here? I think
> returning 'samples' here does not make fully sense, though. First,
> 'samples' is not be used outside the called function. Second, I have
> to distinguish a case "no event handled" - This covers then all
> remaining events like e.g. OVERRUN, DATA READY,... which still need to
> have status registers reset, but won't be pushed - currently this is
> coveredy by the 'return -ENOENT;' fallback. Third, I need to be able
> to return error codes.

But does the 'samples' contain an error code? Perhaps you should just
make it do so...

> > +   if (FIELD_GET(ADXL345_INT_WATERMARK, int_stat)) {
> > > > > +           samples =3D adxl345_get_samples(st);
> > > > > +           if (samples < 0)
> > > >
> > > > > +                   return -EINVAL;
> > > >
> > > > In the original code it makes no difference, but if you are going t=
o share
> > > > this, I would expect to see
> > > >
> > > >                       return samples;
> > > >
> > > > here. Why the error code is shadowed? If it's trully needed, it has=
 to be
> > > > explained in the comment.
>
> As said above, 'samples' is just internally used inside this function.
> Basic question here also,
> since intuitively you'd expect it rather returning a samples number -
> should I rename the function
> to make it clearer?

Perhaps renaming helps, but still, I don't see how a negative return
value can fit here. I would expect a negative to be a meaningful Linux
error code.

--=20
With Best Regards,
Andy Shevchenko

