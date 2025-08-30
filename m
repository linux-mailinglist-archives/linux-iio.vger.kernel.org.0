Return-Path: <linux-iio+bounces-23422-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E2EB3C78F
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 05:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8FD5207DB0
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 03:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC73126F297;
	Sat, 30 Aug 2025 03:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUr46Npf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08099199237;
	Sat, 30 Aug 2025 03:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756523600; cv=none; b=NjD291s2gYNum0JMZxKbspc01VR3HgNbfN7UTDKlpQat8MzMcmDKke2oD2ZtMRdJ4FpRktCamTHhEpo/rJhhCHaMRLIOW8JqHrXGav09iYrl3grXetEXhw8BDX+ja6NY6jRDO2k5rCo/G8o0IZnCfOfawYvWnGAJUjHsTE/HNBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756523600; c=relaxed/simple;
	bh=6iLpX2zx/SdMyxcO4oSHXHuePW/AlYt5vAWN8Rtcrlo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pie3LojB0/onYVM+Of5FFt1H5KeUb9XVsyoQJeBQaP6LRjT9ZnD3J9pv70feOv/29RNVwBJ5J0dBEEBnzH7MpdkRl49rScjz4iGgt9mfnBiLfbv5WndcnX9worL4oqkC/v5cxQGinvzv3hd6vYhqGE++AdiAA41/ZgvVlZgPQJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OUr46Npf; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-336c79c89daso2808881fa.2;
        Fri, 29 Aug 2025 20:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756523597; x=1757128397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fUGFJItPhj1RGIBa1yatafV6AgO9tzvsjBgp4edEIeE=;
        b=OUr46NpfTDZNz8oiqDk4KPcaPmi4R1D7uIan4tpPQUfnBJ9xTJL9oQRlCI+euI8KO4
         YxybrWVvg7FUK0BNe6sY9SmH1eoF+CEccZJ1lW4c2Iu4+mm2K/OgQSG5ZD3LVvhsdZMO
         cUhh6n+Tk/UjAiogxP7owihGLvJ8Ec+vl9Z+AApq3xcBsWXESIDmZ2I8B+/sJwNz0AZw
         x0HVY8+Z8z6xKbOtFPoZf8P/TK0f7Upn8496by1ud90tRROWVGVtTuH2fL7av0zvYGW6
         AkCxrTKzJ3Hi6s0DPw1fS8b/BrNW5DGAI2IvVTZ423HlSnm1hvVRi1NdK5mGSMffybwr
         9N7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756523597; x=1757128397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fUGFJItPhj1RGIBa1yatafV6AgO9tzvsjBgp4edEIeE=;
        b=GFxjjP89nu2CT51p1Lp1O9jUMomjwmb5KLmUFgzjOlsJBHTSL+S7TZtB6xYsZbePog
         4y57G4qhXxnJ3TeDMON3Sch56RcsUShR3kTtQeq5r36mTR0HlO8IdndCJXdm4rgv/WDE
         VJMwohDb2ktzP13EKCPa+nZD0AxIECL2nvBW3fpRif0R5nsTXJgH5aRwoimTi+P1AvIF
         2ZAs8wfrrucs2zDZzAsqYvhd+lheCuOZQpGd9agGoBUkAEsn3qyORcjrNf4Mfi7V1qqC
         cO+jfxa0uPLvAhF8MziY3LACM9zqgnRYB65f59vPa6fBBJuFu2KvGIXxctEZupomnLmD
         7E/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVTQacwYTdDJqfjFvUhAQ/VjbFAdB/l8QU+YLIUb6mDS3LebfiUTW7x1aTE67kznR+7lZSOjv4+cM4=@vger.kernel.org, AJvYcCXpabPLgxHHfvgCC/jE2ceiTUFQQuEdMO6pqmoWury+LgexpU9YNk/7HW6zedfgixQw94HVJG8V4BFF0V3K@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5qLR8jr33Zq0W79bGn2VNTrcUv087PFIIn/mbOnxkP+qK/Gtw
	kspbyBTQ373JRPgljv/90/ZoX58o+g9VPHKmhMdm75UJBDy87A69yQG/UH/X+J5r/AY9JqZ2Zq5
	DXM6xJ5xVDp71sDk3jHYPs2P12/8LpN+Q0w==
X-Gm-Gg: ASbGncsVjV3UFeld+3rKp81jyWOvUJ5Mdhkln3h1lLfV/BLr0SzzyiS48GcvBu4SZx1
	v3e8C9/P429hy4stO43tQuiMom79WBBCLUqJEn2ERcyczkNdewCm3IH3mrx3zsagmvlZR/tJt9R
	lQ8HNzsyP7ZYHPZrnEZsYrg+51NtmzZ/QLkTQGY+qWEtBWxQ5Thf+oZb7fg4o8yH3dz38s+RiZx
	k92YRIR1Hs2COylxB2hBEWEVaXELvwes4f9VuPHhA==
X-Google-Smtp-Source: AGHT+IGzJVJ7DvjTUW7GxiLzjzwSF5DlaaOoDTuqzylwAB4BopW/FyT228Lqnh3tj4dNJu4W+h7nBFa9zaVQtFxrWnc=
X-Received: by 2002:a05:651c:410a:b0:336:8abb:6b31 with SMTP id
 38308e7fff4ca-336cb0e06d7mr886231fa.37.1756523596941; Fri, 29 Aug 2025
 20:13:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827191919.1361787-1-akshayaj.lkd@gmail.com>
 <CAHp75VdQB673=qXBp0mPUHxQGxM=Z1CNSmEpP82OprVn++Y5uw@mail.gmail.com>
 <CAE3SzaTJTi3bHnqNbAfQ3W2jHcmhQHqa2ZtKE7=2BnP+onJv-w@mail.gmail.com>
 <CAHp75VeSMApm0TPU1=myhJiXQjWVpebbWEPGcRJQhfSaffdYmw@mail.gmail.com>
 <CAE3SzaR=uPtE20ZkWVXYwBrUZ=b46h1Ub=TbWArHW6XbD8qXfQ@mail.gmail.com> <CAHp75Vf5--WGoeb9qu0QoYz0PmnexUvLyChJFcwYAW3u=_nOwg@mail.gmail.com>
In-Reply-To: <CAHp75Vf5--WGoeb9qu0QoYz0PmnexUvLyChJFcwYAW3u=_nOwg@mail.gmail.com>
From: Akshay Jindal <akshayaj.lkd@gmail.com>
Date: Sat, 30 Aug 2025 08:43:05 +0530
X-Gm-Features: Ac12FXwPmu2YHPlJ5mPqZ_9LxYWXNUsQbqYe8hk5Yxdq4xq2XnlA755HeXKlTTY
Message-ID: <CAE3SzaSvF-JLtUamnib+psG3pONJ9gPxFK+KJ0UtXtb_PfV6_g@mail.gmail.com>
Subject: Re: [PATCH v2] iio: light: ltr390: Implement runtime PM support
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: anshulusr@gmail.com, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, shuah@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 30, 2025 at 12:19=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Fri, Aug 29, 2025 at 9:03=E2=80=AFPM Akshay Jindal <akshayaj.lkd@gmail=
.com> wrote:
> > On Fri, Aug 29, 2025 at 9:16=E2=80=AFPM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Thu, Aug 28, 2025 at 9:47=E2=80=AFPM Akshay Jindal <akshayaj.lkd@g=
mail.com> wrote:
> > > > On Thu, Aug 28, 2025 at 7:17=E2=80=AFAM Andy Shevchenko
> > > > <andy.shevchenko@gmail.com> wrote:
> > > > > On Wed, Aug 27, 2025 at 10:19=E2=80=AFPM Akshay Jindal <akshayaj.=
lkd@gmail.com> wrote:
>
> ...
>
> > > > > > +static int ltr390_read_raw(struct iio_dev *iio_device,
> > > > > > +                          struct iio_chan_spec const *chan, in=
t *val,
> > > > > > +                          int *val2, long mask)
> > > > > > +{
> > > > > > +       int ret, retval;
> > > > > > +       struct ltr390_data *data =3D iio_priv(iio_device);
> > > > > > +       struct device *dev =3D &data->client->dev;
> > > > > > +
> > > > > > +       ret =3D pm_runtime_resume_and_get(dev);
> > > > > > +       if (ret < 0)
> > > > > > +               dev_err(dev, "runtime PM failed to resume: %d\n=
", ret);
> > > > >
> > > > > If it fails, there is no point to read the value, it will be garb=
age
> > > > > or even can make the bus stuck.
> > > > >
> > > > My rationale behind this approach is that earlier ltr390_read_raw()
> > > > had all the functionality
> > > > of the .read_raw callback so the return value whether success or
> > > > failure was of the core functionality.
> > > > But now, since the core functionality has been relocated into
> > > > __ltr390_read_raw(), I felt the return value
> > > > ltr390_read_raw should be the return value of __ltr390_read_raw().
> > >
> > > "Main" returned value. But this is not the point. The Q is, how do yo=
u
> > > expect to get not garbage from, e.g., powered off device, please?
> >
> > I got your point.
>
> I don't think so.
>
> > My Rationale:
> > ------------------
> > From a functionality point of view, if before runtime PM usage, the
> > core retval was being
> > returned (success/failure), then now with runtime PM also, it should
> > be the same core retval
> > which should be returned, but I think that is not correct thinking.
>
> From the pure SW concept that's correct, but the important detail is
> we are communicating to the device via the special bus like i=C2=B2c.
>
> > Updated Approach:
> > -------------------------
> > Since we are introducing new functionality of runtime PM in the
> > callbacks, the return
> > value should reflect ANY failure in the callback, be it failure of
> > core functionality

> > ret =3D pm_runtime_resume_and_get();
> > if (ret < 0)
> >      return ret; //main functionality will not be called.
> > retval =3D __ltr390_read_raw();
> > // not checking retval because irrespective of retval we need refcount
> > decrement and suspension.
>
> > ret =3D pm_runtime_put_autosuspend();-
> > if (ret < 0)
> >      return ret;
>
> So, returning an error here, how would it help? For example, if this
> returns -EAGAIN and user space tries again, we will have always on
> device. The same, btw, will happen if we do not check for the error
> code here. That said, I don't know why we should care about returning
> value from _put_autosuspend. I have just checked randomly chosen 20+
> drivers in the v6.16 and only 2 check for error:
> - one for the pure message printing (say the same as not checking)
> - one for real, BUT it is done in the specific PM related method that
> does change the power state and callers know about this.
> And it seems that all of them (20+ drivers) check for the _resume
> errors. I really need a good explanation of your discoveries why in
> the normal case we need to check for the error code on _put part of
> runtime PM. I might learn something new.

Thanks for the detailed explanation Andy.
I do not have any technical reason to return value from _put function.
My thought was, since we are doing for _get, we should do it for _put.
I agree with your observations. That being said, I will update the code
as follows:

ltr390_read_raw()
{
   ret =3D pm_runtime_resume_and_get()
   if (ret < 0)
      return ret;
   ret =3D __ltr390_read_raw();
   pm_runtime_put_autosuspend();
   return ret;
}

