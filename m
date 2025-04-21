Return-Path: <linux-iio+bounces-18429-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7881CA95124
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 14:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DCBB1893067
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 12:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EEF264FAF;
	Mon, 21 Apr 2025 12:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hIw4797F"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292522641CC;
	Mon, 21 Apr 2025 12:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745239345; cv=none; b=m4KVXsCklYmCnRbWZe7gixB5qjdJl2X4nsybctZTSYcZjyvt8IiYO5RAx2dmbtmxtKWxn04HHbsJoq4E7hxKOzRMa7jhGIKIguwfXOvFrUMR07zvnbIaTLjp02bPU3ncR5U2Z3RaXVoF0mpCmVWxy0p0hVa1tiZKJi6x1OKd3ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745239345; c=relaxed/simple;
	bh=ySaU0zfcByRkaTwII81wn1XRoHdzTb73+Y3DGUNQiWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PG+jI8f6yTS2sQEecB2+nNAK3x5Rpdc6O+9qbhRb6JKhhG0Aj9Mn5lWYn/CWpD1z5n3+dQRXUGKtG92/6jwSGIKpmVlyBcuwTJq49AhhsLwbOLt7/yQEFlKcrqtvbucojI8rrGfc7gYxesrML2n6pKsNlG2VT559i/1XB+Aphdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hIw4797F; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-476ae781d21so41628431cf.3;
        Mon, 21 Apr 2025 05:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745239343; x=1745844143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7PTLCflwUHpQ/HL4KjpSfyOHQhDYwwUWvDGsEADJNO8=;
        b=hIw4797FRdCjcHq3SDDQJ57VgiSXzhTZC5dGXYxVHS6P7LZDImMqn8/50dNTY1iBRz
         Hm2wCTXhWpF7UlPFeeDI20ym/2+RD4X67LC00G2jTa+aftwr/edX+yy9XPMw57LPoY3J
         29Xfo4m1JFwNCJMF7Ajv54kPSh5AvG3F2BjeSSAIm7dXRV4lBHs4yxWv9rdv4awz02NK
         DGNumUL9zpGKtOTsiaTB73+lCS7RliM9uRKN/twXxDMZa7hyCMt7xDRgZfK5phoLQMnr
         eI1258TK6xV/zDyuo95/SeGReQ0ZbiBQxKIGUNlcWYsDhYOHtdNzD7zOaHZSHG1l3AJD
         wKCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745239343; x=1745844143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7PTLCflwUHpQ/HL4KjpSfyOHQhDYwwUWvDGsEADJNO8=;
        b=Llw0Hj1x8TIlakArAM5kizdUpWYyQbdvCArRezg/HGKKuNM9Vz0qHaze0keHtC1sdx
         kQFaEaZHBq27Wp/UNKCQm1K/Dqivl9ZBAEhTHBFNUBtimv+ZXasHxi2S2eJHF43RR1U2
         K5qikc3KNK4lddl8iE7yAGILCO3xPy1z/Xd+/WEKZj3CXp80u5rEmsOj/Er0IBe9Wwwr
         Bfz8g/H+TTCEtLtse6u0+Sdel29WcNXTi1NkfYeoJrq+TyRzlnItNodvpbTt5GBUZGny
         F1+VBCTyprYVO3XNEa8evOkzWzUdzUC/0UMDwBgUTRmfb83mQhHsA4FOPXFNSKCeNgOy
         C3lQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVMiqA+aBrdVrRalF4zdFSB7QUC1U9Oy5NnT9R+GbQjZDGPmRM10ijpVKSFJQHDSVdlnB6CF9Nw+jmBNOy@vger.kernel.org, AJvYcCWrrJkZZO/GlwR9IF3GbmAOFIacusUWwntaTwyQyQHYkLo8O2zkwjFkoTaLCjWgOt8tz4CuXVfG@vger.kernel.org, AJvYcCX9U+cd1MKbzggPhuHruHcxBXJnrEUmYs+kIYF4SVXJy2+UHIpLFoYfjgpjpj7BLnnu+8cq1jE4/C4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtqb8lnBEWAnIFZ02B/FbpRjKb+BrE0cM6F27diV7S9s5h46Fn
	mzR0irZo8qKn3F5k5IgX1YslslE7sBAwBAkcLF9E2f66u7F1S6A34K6bxFMhPdarVgo45SAxm9m
	i7KipsGjfTE/BjTdmXxp7ckzGipc=
X-Gm-Gg: ASbGnctujlnu5pdAEaaET4qBXsM+VEqXFRLZ4yRGQlm241NrziyEPYUf6Y84L1XPbsV
	egznxIjj59Kj6WkFjB7ArJH/WDpyk4emWr0xReRnX4ZBhE3EXb/b1CdZWe3PZ6lBuonZpSkNDIa
	KtfAUBmLnQhFTraJNfkoa1mZawB4vj8LC+dDOGiAH0p2GcTVQu7R0UOw==
X-Google-Smtp-Source: AGHT+IFGRI6w4PZTzPqR/wy6WxWpUIfMgCPO/lf/RGWDPHDkzKldCNpcwF092qguuCIgto3Q9ayDtKHGpNvNYtXoYHE=
X-Received: by 2002:ac8:5796:0:b0:476:875e:516d with SMTP id
 d75a77b69052e-47aec4c44e9mr191962431cf.36.1745239342859; Mon, 21 Apr 2025
 05:42:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250420013009.847851-1-gshahrouzi@gmail.com> <20250421124401.0daa6a2e@jic23-huawei>
In-Reply-To: <20250421124401.0daa6a2e@jic23-huawei>
From: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Date: Mon, 21 Apr 2025 08:42:11 -0400
X-Gm-Features: ATxdqUG2HbCo2jVQA1NMcR6DOLpddrMYAY_8SU4fLCk3lus5iMrFHCUuPeKi4mQ
Message-ID: <CAKUZ0zLTjXPm7qGLsV==fJZZEFMEiEM78-qgZ__DYhqL7Te5BQ@mail.gmail.com>
Subject: Re: [PATCH v4] staging: iio: ad5933: Correct settling cycles encoding
 per datasheet
To: Jonathan Cameron <jic23@kernel.org>
Cc: gregkh@linuxfoundation.org, lars@metafoo.de, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev, 
	Michael.Hennerich@analog.com, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2025 at 7:44=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Sat, 19 Apr 2025 21:30:09 -0400
> Gabriel Shahrouzi <gshahrouzi@gmail.com> wrote:
>
> > The AD5933 datasheet (Table 13) lists the maximum cycles to be 0x7FC
> > (2044).
> >
> > Clamp the user input to the maximum effective value of 0x7FC cycles.
> >
> > Fixes: f94aa354d676 ("iio: impedance-analyzer: New driver for AD5933/4 =
Impedance Converter, Network Analyzer")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
> I'm taking this the slow path as it has been wrong a very long time
> and there is a lot of churn on IIO staging drivers right now so we may
> have other stuff that I don't want to delay building on top of this.
Got it, thanks.
>
> Applied to the togreg branch of iio.git and pushed out as testing.
>
> Jonathan
>
> > ---
> > Changes in v4:
> >       - Provide clear git body description.
> > Changes in v3:
> >       - Only include fix (remove refactoring which will be its own
> >         separate patch).
> > Changes in v2:
> >         - Fix spacing in comment around '+'.
> >         - Define mask and values for settling cycle multipliers.
> > ---
> >  drivers/staging/iio/impedance-analyzer/ad5933.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/=
staging/iio/impedance-analyzer/ad5933.c
> > index d5544fc2fe989..f8fcc10ea8150 100644
> > --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
> > +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
> > @@ -411,7 +411,7 @@ static ssize_t ad5933_store(struct device *dev,
> >               ret =3D ad5933_cmd(st, 0);
> >               break;
> >       case AD5933_OUT_SETTLING_CYCLES:
> > -             val =3D clamp(val, (u16)0, (u16)0x7FF);
> > +             val =3D clamp(val, (u16)0, (u16)0x7FC);
> >               st->settling_cycles =3D val;
> >
> >               /* 2x, 4x handling, see datasheet */
>

