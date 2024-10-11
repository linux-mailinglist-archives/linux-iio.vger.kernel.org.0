Return-Path: <linux-iio+bounces-10460-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 757FD99A719
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 17:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A566B1C20AE8
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 15:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F9B187FE4;
	Fri, 11 Oct 2024 15:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kr2PD2hx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B660339FD6;
	Fri, 11 Oct 2024 15:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728658902; cv=none; b=jGQrtUxXNLadWK7pvus19+317Yq1Xk8Pp/Wem5Ernn4BhiZuMyNUr+fyN4xr0Dw7InvwC7NTacfpd6xiL6C1/YGohQGMMms5JQk8CQCt/Rk7RiwRfYGKbZoJW4fvXHgUuTjnYJXTOPHfJnLorb5BQk6lY8Q3uNz26ir7/oXvkM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728658902; c=relaxed/simple;
	bh=nr1kTSxvBIb9LRmYw14N6GTTVefLFfgK/8kJVEww7WM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sfi1gINYkfb7rm6snLCJU+Bausu2MkEeUa1vF9m8Px6gFrOGdcNdoBZ/vHjQZcfpvSGqZI/zACVyvwIym1IPAplBKiqYq2TNQ3934+ms2OCt3tYHJkgeWdJOX+RK+pceYICSF/DPk6PA6POY1ulHYFfTFrUYSVL5LL7yaXixubM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kr2PD2hx; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c40aea5c40so4170787a12.0;
        Fri, 11 Oct 2024 08:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728658899; x=1729263699; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kzELerGxwENbVERb4Z1vrEYFWmlmJCGafD6FOzDywR8=;
        b=kr2PD2hx8Shs9L20PowKSqvpPv7/zYCeMUB6wIzSZbgqfOPQIUQxWjO8P+tqI26BfA
         JYzx4dXK1yW97SzMfogRf1q8j6Uhl790epxRiVJSs6f21gm+2ONEjTNe0MUGPT83lymv
         9kCoUGx28WamcZLweOZ77DlmLM9I/lFFeF1oukXnH/GxkdeIQZJRCiV3oMNTcWXR9nWC
         HnFFk8jJi2Gg29uW3S7rYdcs+MYUZLf79c+H6rUMIumFHGwf/K0r4xNVAlKxe6JoBJaH
         DG1jA+uDxCMfYUKEls8YLh2o7pdDJF2NRJ0/uc9BDylRAVObBhOwfv91URY7iYyPX7Dm
         N0ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728658899; x=1729263699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kzELerGxwENbVERb4Z1vrEYFWmlmJCGafD6FOzDywR8=;
        b=UR2rrSipA9eic19azBD7NRkA1A6n7K0tZ2x7JrSRMa1Pzhm3QGqH64W0UnlywVYTcx
         PJnGkVk0BOd5UtqBUxvKNecnlA2eLPb5SLjiBr9vDKGiSj191E+a14s2Sg/jxZZ07plJ
         yfSQj0lwBmHA+SaqN1H4oPajaByO2/S6HeVLF6KsskxXTqArb82cDs8/7FrCZh/hxO+R
         FqiHcfvbvf0abktHtpSz0aJG5Skrpf+Mmek7x8luGr8QpG2avJHzhx1/4ZCfcHVHLjN0
         OZFapf2L9LoJzFOSxaDR8m3kYJ/M2wn1CoRO0RMEgzHqH1l7d/ex97OpO/ftgInHDIt7
         P8fA==
X-Forwarded-Encrypted: i=1; AJvYcCVL731CVrye24rVgpF5laHY2pQechqOpJFZpx/H9UUHrivbCKj7Q9deLHo0y2UsBgzF/NU5Npza9t4=@vger.kernel.org, AJvYcCXYcmCQWQQwCFbFJ9li7U4rwACv++ulafTUMkdR8rPSoIrIBLC10YtvSTwW3NBgT8xX9e0NKBop8Job7E57@vger.kernel.org
X-Gm-Message-State: AOJu0YyzZD2qdlJfzLwx0DLIgxhMroMtU5RlY0Y9EFKlGP3h5vWzmXtg
	+MZURCFaE8QjvstP5byPjIcqjEdpyMB7nXMHEzhkEsOe0Lf+g5qNdg2n8qMMRFCsE/dIaJmx/91
	b2SOTdbAh30VGyyt/FMq5kyf3VIg=
X-Google-Smtp-Source: AGHT+IGW/6FiYvt3urJzRIq5N0EHLG9l8NfLeEXHKSvHcWOKXSI41CWNhWYeebqTMgP9CGTXk+lib7CwbGIi9mWuiDE=
X-Received: by 2002:a05:6402:354c:b0:5c8:a4c1:d59a with SMTP id
 4fb4d7f45d1cf-5c933544dc4mr6299265a12.8.1728658897704; Fri, 11 Oct 2024
 08:01:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011093752.30685-1-0xff07@gmail.com> <20241011115334.367736-1-0xff07@gmail.com>
 <26f2e35e-0a07-4b24-91a2-a48d4bc5dadc@gmail.com>
In-Reply-To: <26f2e35e-0a07-4b24-91a2-a48d4bc5dadc@gmail.com>
From: Yo-Jung Lin <0xff07@gmail.com>
Date: Fri, 11 Oct 2024 23:01:25 +0800
Message-ID: <CAHhBtNr6rycOKjXvAR6nK9ZKF8Ze=wvki2yetCZDNz-LHA+FvQ@mail.gmail.com>
Subject: Re: [PATCH v2] iio: Fix uninitialized variable
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: linux-kernel-mentees@lists.linuxfoundation.org, ricardo@marliere.net, 
	skhan@linuxfoundation.org, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Vasileios Amoiridis <vassilisamir@gmail.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Angel Iglesias <ang.iglesiasg@gmail.com>, Adam Rizkalla <ajarizzo@gmail.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Javier,

On Fri, Oct 11, 2024 at 8:31=E2=80=AFPM Javier Carrasco
<javier.carrasco.cruz@gmail.com> wrote:
>
> On 11/10/2024 13:52, Yo-Jung (Leo) Lin wrote:
> > clang found that the "offset" in bmp580_trigger_handler doesn't get
> > initialized before access. Add proper initialization to this variable.
> >
> > Signed-off-by: Yo-Jung (Leo) Lin <0xff07@gmail.com>
> > ---
> > Change in v2:
> > - Make value initialization immediate before its first use.
> > - Link to v1: https://lore.kernel.org/all/20241011093752.30685-1-0xff07=
@gmail.com/
> >
> > ---
> >  drivers/iio/pressure/bmp280-core.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/=
bmp280-core.c
> > index f4df222ed0c3..682329f81886 100644
> > --- a/drivers/iio/pressure/bmp280-core.c
> > +++ b/drivers/iio/pressure/bmp280-core.c
> > @@ -2222,6 +2222,8 @@ static irqreturn_t bmp580_trigger_handler(int irq=
, void *p)
> >               goto out;
> >       }
> >
> > +     offset =3D 0;
> > +
> >       /* Pressure calculations */
> >       memcpy(&data->sensor_data[offset], &data->buf[3], 3);
> >
>
> That was a quick reply. I would recommend you to wait a little bit while
> the first version is under discussion.

It was my bad not waiting for enough feedback to finalize another
patch. I=E2=80=99ll definitely do better next time.

I feel that initializing it as sizeof(s32) in the beginning and not
using it until the second memcpy() only widens the gap between value
initialization and its first access, which doesn=E2=80=99t address
Shevchenko=E2=80=99s concern.

>
> I still see the offset thing a bit weird. data->sensor_data uses an
> offset to avoid hard-coded numbers, but for data->buf we do exactly
> that, in the very same lines.
>
> Setting offset to 0 to access the first element i.e. no offset required,
> and then adding the actual offset sizeof(s32), which could even be a
> const if the first access was to sensor_data[0], looks to verbose.

While that is also true, it=E2=80=99ll take a more general refactoring to m=
ake
it driver-wise consistent. Maybe that refactoring should be on top of
a fix, instead of being part of a fix.

>
> These things are of course not critical, and the proposed fix is
> definitely ok, but I am missing some consistency here.

Best,
Leo

