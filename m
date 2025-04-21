Return-Path: <linux-iio+bounces-18434-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3931A95159
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 15:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6AE6188E4C1
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 13:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC5F265623;
	Mon, 21 Apr 2025 13:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyLLAp0h"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F84263F32;
	Mon, 21 Apr 2025 13:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745240739; cv=none; b=LhLtpwS7geWZlpYaMcU2Z0GrnsvalsZqApbJX7FFoSrlZdtexewj7rWLHdIXdhmoqA9EbzqPek8YvVH60UgYrzpPQOoaoTt+UBJjB4vTJNmfJFIrTSd40c1eMdPqUsGLOXazB/mmZB4lsYbnZmlkSISQhX231fafZAcTOMOX1H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745240739; c=relaxed/simple;
	bh=f+BKdAC4I6YUGknxlC3Xm4jFCVMEuPMlEQphh5ZvvvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nIYznoqJ3m2GXpRJoOD0U199vGAzwfKuaBzbJWQPtgspN3tQGoVXvUXOjST0MYyeoMkgtT8lZoURnlMSu2h6lmFtgxG4HfYn2chDIpX/rdnAdVPOmV2X1YBhvTbOiBukCY9iR1eYmPBuyI/Hvdj1maT8u2KyOvLy+h6lp3bXdLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fyLLAp0h; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-47690a4ec97so42330361cf.2;
        Mon, 21 Apr 2025 06:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745240735; x=1745845535; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mFtNIhESQPUgGQGLUOpZgw8PI1xqIhF3XCImtswCRMw=;
        b=fyLLAp0hBV1cXX9gf/HZAMrb0BH7bdBrylF8ZlmKItnV2WUD/NBnOit3M3hbY69fDL
         snLI5+vVF3wZAqDi2pn4O+nsIzBlReySopIsNaMgQylOd0jMrPHP3LZQUWJ4NC9fHFid
         6TN4qJA2TBGtTD5ydceI7B8xWwXEkkWSzFtzNoNkHkzZiUvfkTUgjavBYRHOOWYRgGIC
         dK25d6YbrPXXou7l8UX/D2ONx1hqwn23eVhRU835dFLIr6jEi+933msIlERsDFFzWWKv
         QVpYzLxi1dHGk64bJREV1ixDpuPi5bZk2SWeggGcNWf+w8fpqx25iiUL4u2tC4CueCRV
         BE6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745240735; x=1745845535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mFtNIhESQPUgGQGLUOpZgw8PI1xqIhF3XCImtswCRMw=;
        b=afl/oGgTB62BjIYj4GRJLH7FsX7Sp7VdCrjCwHkQxUBPTuzCA01BR/7WhDBJJHA6qy
         iZMEKx2kGBBfDiKBPDqenF13Uk/R0blayk9uedMbjajiNAgRSXK0EPdBZSUHkOyBJDeW
         kQHbkXZNSeWDUteNyuYQoz2N1vD2GktBJ0hHCq6aIaE2czil4IFwq0L4xpOxv2ElvJ4t
         2UL65YFIeknUKFQB9p17KDO/bHb+KfT0FhqbvCv111nLH38BdlVDYU7OKKNgdjW5SUCS
         bMXf2szMa06YWZsnx2LG5sBHBjhJ+y7uOKuAzt+8l981QFGXNx3UUZjT5U6xi0PVG9XG
         k31w==
X-Forwarded-Encrypted: i=1; AJvYcCUG5B35FRD8/dr7OMoSiv3ESRfE11/c8E2G7wHeu6lAxtkeM6A2QTJzJYIfOjFEHwv34qHQajIogeddRQde@vger.kernel.org, AJvYcCV/3djDq+Te7rSaAXkr2heUMcYAh6rzSbE51Gq5luwXhTLRLeEd5zNAILEu0ooVoxgaLIWUycdS9dQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6qI2N6q58wYvSEjfez29kSuHPhpZFAST2CBTRiPc7c9Aouhy3
	Wx242j2lOGBmhdZSRJT898AXTn1+PRQKyzmM66MtPMnWc6zgySaQgnCYe/8eyOg/EegWki8Xwbd
	VUAgmCQRGz0vK9UbnyYs4bwtib20=
X-Gm-Gg: ASbGnctPw2bpdZE284BHzydK6gtd2JQD4E97DBZhu+dxaF0Z58Mdxk/U1QxiXo1QKeE
	RCc/g7ERXj1Z+OMPT1PsYDDYwqJPCnMq4A7nm6/0Yiaf6ShrmuIMh2l00rcMg9Bc4peG1/y5JTJ
	ehBBW5pasmYf/NrHtyjZsor5WtcgbiquHSmx8QlxKknZozSu6Sl0LB/Q==
X-Google-Smtp-Source: AGHT+IFzhhB+GWbWRt4VxGeCchwkPhazFoXhUCuwU/HnqxTikuays0RZ9Gjb8LQHrf9hUaObS2S/SGrxuiz6Va7SYmY=
X-Received: by 2002:ac8:5748:0:b0:477:cb1:ab2a with SMTP id
 d75a77b69052e-47aec39436bmr229380531cf.13.1745240735267; Mon, 21 Apr 2025
 06:05:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250419144520.815198-1-gshahrouzi@gmail.com> <20250421124915.32a18d36@jic23-huawei>
In-Reply-To: <20250421124915.32a18d36@jic23-huawei>
From: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Date: Mon, 21 Apr 2025 09:05:24 -0400
X-Gm-Features: ATxdqUGZBqiT-xkUtjMAQApZJcXMrreXjPpwyLrHEPICF2V0q6d2B3Psi9ZDg1k
Message-ID: <CAKUZ0z+CSMqCNFAT9k6nUkiwYjq0QG=hH3QPLO-w47xWLkVUxg@mail.gmail.com>
Subject: Re: [PATCH] iio: adis16201: Correct inclinometer channel resolution
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael.Hennerich@analog.com, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2025 at 7:49=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Sat, 19 Apr 2025 10:45:20 -0400
> Gabriel Shahrouzi <gshahrouzi@gmail.com> wrote:
>
> > The inclinometer channels were previously defined with 14 realbits.
> > However, the ADIS16201 datasheet states the resolution for these output
> > channels is 12 bits (Page 14, text description; Page 15, table 7).
> >
> > Correct the realbits value to 12 to accurately reflect the hardware.
> >
> > Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
> > ---
> > Omit fixes tag because it targets driver before it moved out of staging=
.
>
> Why does that matter?  Should have a fixes tag.  Whether we chose
> to backport the fix is a different matter.
Ah ok, that makes sense.
>
> Otherwise looks fine to me. Reply to this thread with a fixes tag
> and I can pick it up without needing a v2.
Got it, will send shortly.
>
>
> > ---
> >  drivers/iio/accel/adis16201.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iio/accel/adis16201.c b/drivers/iio/accel/adis1620=
1.c
> > index 982b33f6eccac..dcc8d9f2ee0f1 100644
> > --- a/drivers/iio/accel/adis16201.c
> > +++ b/drivers/iio/accel/adis16201.c
> > @@ -211,9 +211,9 @@ static const struct iio_chan_spec adis16201_channel=
s[] =3D {
> >                       BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
> >       ADIS_AUX_ADC_CHAN(ADIS16201_AUX_ADC_REG, ADIS16201_SCAN_AUX_ADC, =
0, 12),
> >       ADIS_INCLI_CHAN(X, ADIS16201_XINCL_OUT_REG, ADIS16201_SCAN_INCLI_=
X,
> > -                     BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
> > +                     BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 12),
> >       ADIS_INCLI_CHAN(Y, ADIS16201_YINCL_OUT_REG, ADIS16201_SCAN_INCLI_=
Y,
> > -                     BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
> > +                     BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 12),
> >       IIO_CHAN_SOFT_TIMESTAMP(7)
> >  };
> >
>

