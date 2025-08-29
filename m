Return-Path: <linux-iio+bounces-23395-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2DEB3C2AE
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 20:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8154189A6E2
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 18:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E84188734;
	Fri, 29 Aug 2025 18:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMOwKDW7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7BC30CD9F;
	Fri, 29 Aug 2025 18:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756493387; cv=none; b=WVRh4p4kdWANZnL2I12WgLhtXdAzq6pIFgoV5qQf8RYs1Wp3TxCH7aBaTRr+y3Q3DRcAxGahCKjfT4J4In/rCWlRYDDSgMaQyZXMK2drQ63t3or9EVXvWUcMuhZDva3R7nWvOINp8Z29Ff2JwYVrc39n+CS8RhxpSw1BtnAhJlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756493387; c=relaxed/simple;
	bh=6l/sBVvdwV4pchZx0764azbmqL6qAQYoK1hLYol6zD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IljC5eXevNuoLmiJda9INnjJOq7JEe4NGDW8fgVHvE0B59eYlHTT8X9jMoz0ECxk8jUhLZMUwzFdjP4jWyGddnwibzv6peJ37FjXyjD8yjcKKZY6Q5XHQjh42b6Re+Lu1MJRIkmOH6V+O8eq8oKgcJaP6Cw/Lfur8kb9urwp2O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aMOwKDW7; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-afebb6d4093so398134266b.1;
        Fri, 29 Aug 2025 11:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756493384; x=1757098184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LF7sIvG/dVAc9/FdLPw0DLFRlZh/5iDDl1rgmMp7+I8=;
        b=aMOwKDW78ekZO416Kz3Mek9MKvYFoZVQuIicQ59YhhDx6kvHSKNtl8U6bOctmL4xSk
         KB3zd9cWYpE8ODgz8b9E6EAfUrkrmMKUrkkNwaGuapQhCqyCvcMaK+igG3dLmksE9cig
         Mzs6h0hB9OYYDynJBNmQaDUOr/ahQDHFJMm2DO374UXg0iuH+FPv29954pvqKN9+WdDM
         0FsUa6/7LwOjgXpNcveyZxHDoT4EX6+b/tfimQOtJYoURsB7CMoBRwGVajTfQdagmiLH
         dZfs1HgPgI3W6HiMMQfVRdFTpYMJ4mLhbV7EmW/89L+K8uX33qa0yjzzWslp7W0VHJW2
         D20A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756493384; x=1757098184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LF7sIvG/dVAc9/FdLPw0DLFRlZh/5iDDl1rgmMp7+I8=;
        b=ibreAKtivBYkalc+v/wux/EGflJqKXIthnLFl/7p6Bjz7T/VF3E7i5s0afDnYW7Oh7
         Wnmu0iyQ562s/v5d+fBByWZRCs47Pq7z+lHK2lvCSPCT2V5OPSBGpJ8o7/vIQaEnBUqR
         +dUCQRElD61Nz6XZC5dKSBFbSuN8y1KckrtCfMpM9DF9VNJJbtmrVk+6WYd9heBFn6R9
         X88h9ZA4qBxKVTgMSJhvSi/k14FS2W4reiZdTSGLCIx6W0Xx/Jt0d3YMgbcxSR7tbGOK
         IDPnosyPBl1tob75b/zhnKLnD4ZqZO0/x0vUUGZJ/aXNlgP8ASiveYD/ZItm+3E14Jqa
         xhTg==
X-Forwarded-Encrypted: i=1; AJvYcCUCbR2MCXR9Zaj2v/s4WMalqCe63oSoeVMHD+G1CeaXYbIHaTaXg16MI6rtVsJX7t4COShvgTL4FSg=@vger.kernel.org, AJvYcCXgXKgz3E+dwFNVJgQNMTNAXYsgwj6xgC0sShX07YNU6JZYKfymr3H3zqr53EDHCtL/RCE7rEmfDk9bSwc5@vger.kernel.org
X-Gm-Message-State: AOJu0YynxnkDqcGlafiMv/AiwbE/tVsEMTAi5DKkUdELQNWjbKnT+w+F
	zu1HYa5eKPRtCiB5qozyWXSUSyDyBSdMQWZPkupBjSP+HMixmGbz+25A4zZ67M0Z36jZGKi7aIF
	jpFsI69LQj70j80Gi2dEaYrTLCEkFcC4=
X-Gm-Gg: ASbGncuks2QtHq4R6SjflZZHH3JYhY7J5wfb+Obcx6nyq+PFRYb6xKmDm0dFNDx3HL6
	9rI10p+fbsh7v2mWBuGWJWTt2/kgmPVOUIuGAH9X/RDAndy004FR9t4W88+C5vlgumy3ZpF/Fn9
	rex0dk4kQSUTMhrTqJGQ/23A0RAPWgWKR8Z6Aa4EJ3pHn43EweFGHH/ExtO1ghj/8ceaQnYW4ey
	upPNLhJCFM3i69p9w==
X-Google-Smtp-Source: AGHT+IEbhyCBCUFr5GwEB2WTwvWrbvbmgR2slJPEU2ow6vse26leP8JmjUm8AWy9PaTsRG4cZKdlMdZQ4Er/xNPI4sQ=
X-Received: by 2002:a17:907:1b1e:b0:af9:10c7:59b6 with SMTP id
 a640c23a62f3a-afe295d2e67mr2619816166b.32.1756493383595; Fri, 29 Aug 2025
 11:49:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827191919.1361787-1-akshayaj.lkd@gmail.com>
 <CAHp75VdQB673=qXBp0mPUHxQGxM=Z1CNSmEpP82OprVn++Y5uw@mail.gmail.com>
 <CAE3SzaTJTi3bHnqNbAfQ3W2jHcmhQHqa2ZtKE7=2BnP+onJv-w@mail.gmail.com>
 <CAHp75VeSMApm0TPU1=myhJiXQjWVpebbWEPGcRJQhfSaffdYmw@mail.gmail.com> <CAE3SzaR=uPtE20ZkWVXYwBrUZ=b46h1Ub=TbWArHW6XbD8qXfQ@mail.gmail.com>
In-Reply-To: <CAE3SzaR=uPtE20ZkWVXYwBrUZ=b46h1Ub=TbWArHW6XbD8qXfQ@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 29 Aug 2025 21:49:06 +0300
X-Gm-Features: Ac12FXxcTbowR9jgii-6dMLYVoktgAxd5mCTZzYXDksEelFmscxTYNcvhhm34oU
Message-ID: <CAHp75Vf5--WGoeb9qu0QoYz0PmnexUvLyChJFcwYAW3u=_nOwg@mail.gmail.com>
Subject: Re: [PATCH v2] iio: light: ltr390: Implement runtime PM support
To: Akshay Jindal <akshayaj.lkd@gmail.com>
Cc: anshulusr@gmail.com, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, shuah@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 9:03=E2=80=AFPM Akshay Jindal <akshayaj.lkd@gmail.c=
om> wrote:
> On Fri, Aug 29, 2025 at 9:16=E2=80=AFPM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Thu, Aug 28, 2025 at 9:47=E2=80=AFPM Akshay Jindal <akshayaj.lkd@gma=
il.com> wrote:
> > > On Thu, Aug 28, 2025 at 7:17=E2=80=AFAM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:
> > > > On Wed, Aug 27, 2025 at 10:19=E2=80=AFPM Akshay Jindal <akshayaj.lk=
d@gmail.com> wrote:

...

> > > > > +static int ltr390_read_raw(struct iio_dev *iio_device,
> > > > > +                          struct iio_chan_spec const *chan, int =
*val,
> > > > > +                          int *val2, long mask)
> > > > > +{
> > > > > +       int ret, retval;
> > > > > +       struct ltr390_data *data =3D iio_priv(iio_device);
> > > > > +       struct device *dev =3D &data->client->dev;
> > > > > +
> > > > > +       ret =3D pm_runtime_resume_and_get(dev);
> > > > > +       if (ret < 0)
> > > > > +               dev_err(dev, "runtime PM failed to resume: %d\n",=
 ret);
> > > >
> > > > If it fails, there is no point to read the value, it will be garbag=
e
> > > > or even can make the bus stuck.
> > > >
> > > My rationale behind this approach is that earlier ltr390_read_raw()
> > > had all the functionality
> > > of the .read_raw callback so the return value whether success or
> > > failure was of the core functionality.
> > > But now, since the core functionality has been relocated into
> > > __ltr390_read_raw(), I felt the return value
> > > ltr390_read_raw should be the return value of __ltr390_read_raw().
> >
> > "Main" returned value. But this is not the point. The Q is, how do you
> > expect to get not garbage from, e.g., powered off device, please?
>
> I got your point.

I don't think so.

> My Rationale:
> ------------------
> From a functionality point of view, if before runtime PM usage, the
> core retval was being
> returned (success/failure), then now with runtime PM also, it should
> be the same core retval
> which should be returned, but I think that is not correct thinking.

From the pure SW concept that's correct, but the important detail is
we are communicating to the device via the special bus like i=C2=B2c.

> Updated Approach:
> -------------------------
> Since we are introducing new functionality of runtime PM in the
> callbacks, the return
> value should reflect ANY failure in the callback, be it failure of
> core functionality
> or failure of runtime PM calls.

It's not about SW or refactoring. Think about what will happen on the
actual line. The I=C2=B2C bus is very sensitive to the issues on the line.

> With this in mind, I will be
> refactoring the callbacks
> as follows:

But the end result is in the right direction.

> ret =3D pm_runtime_resume_and_get();
> if (ret < 0)
>      return ret; //main functionality will not be called.
> retval =3D __ltr390_read_raw();
> // not checking retval because irrespective of retval we need refcount
> decrement and suspension.

> ret =3D pm_runtime_put_autosuspend();-
> if (ret < 0)
>      return ret;

So, returning an error here, how would it help? For example, if this
returns -EAGAIN and user space tries again, we will have always on
device. The same, btw, will happen if we do not check for the error
code here. That said, I don't know why we should care about returning
value from _put_autosuspend. I have just checked randomly chosen 20+
drivers in the v6.16 and only 2 check for error:
- one for the pure message printing (say the same as not checking)
- one for real, BUT it is done in the specific PM related method that
does change the power state and callers know about this.
And it seems that all of them (20+ drivers) check for the _resume
errors. I really need a good explanation of your discoveries why in
the normal case we need to check for the error code on _put part of
runtime PM. I might learn something new.

> return retval;

> Let me know your thoughts.



--=20
With Best Regards,
Andy Shevchenko

