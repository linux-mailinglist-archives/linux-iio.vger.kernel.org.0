Return-Path: <linux-iio+bounces-23393-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5951FB3C233
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 20:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0527B1798A1
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 18:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E30030AD0F;
	Fri, 29 Aug 2025 18:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m36VYb/2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED533A1DB;
	Fri, 29 Aug 2025 18:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756490592; cv=none; b=tNzR16n8sQ1JYyxTHcDZ1c67eZ1WKC4TJLYSgGmcEAf2GkajtEiY3ai/xDi03RWvHNGK/MKkObivETUDa5LR8lL/xruz9WcnQsFSyTN4oFbr/0hl21HmxeljbXq+/4eRwUTWRv6m9hWC0xJAjN7boKrhvBgoV3D9v8jBF1Qt0Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756490592; c=relaxed/simple;
	bh=zmRz5kvNLS0OBEgM+ZKhPS27r1lwjCP98zvrRB/y9yw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=suwuIv1Uie67Af42hz0DXs2RLAPNnqxW9KLqzsRZ9ibUsZOd8XiLFRJyfbQZJAVkpxEVEqmC8JegewskjXE5a80hjGXhx/KQEtEkyI4QoXy2SkKszsWgAQDevhaJRQvp3jYdYpmt//cEQ4MzkkgStamQ2J/GSpiLNr/j71iGZMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m36VYb/2; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-333f901b2d2so21099781fa.2;
        Fri, 29 Aug 2025 11:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756490588; x=1757095388; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VsKBrNA2mQVzli8hEEvCxWxO5Vs3VXHIST1y+o5n3G0=;
        b=m36VYb/2aRwi/ctHULwOxnqU97kcxh6rrtSud7twjtv08IM0+DC7v4h4DriGctj7CU
         A6vwm04LrMFYDvi0AEUC7NjZZpH/RhpQxE/4hAR+f4aECMqFoKQKhxRyZPteCflCGTCP
         FjwzRrXEd6E5PLtUbi1W72jfBi6z/SwHK347uDR74cjrxM+W2ce3AOeF7NTSIkDCWKry
         YBm3tUZiKLl9r57F7txWbMugeWZn/WtHiV2qkl/T61lohrD+tbbArZyBiCNMZCuTVAdh
         W2BDg09Qnb9dOunu8uWZI9Hnt+QW/zDQGSN8ML+eKgHcOPNTEQp0tCoOjggxvAIoiMI+
         NM8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756490588; x=1757095388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VsKBrNA2mQVzli8hEEvCxWxO5Vs3VXHIST1y+o5n3G0=;
        b=OwLAFKGFnRg4ZrKZl7lHT1ZkoPRzDXdCByyfeo/2i+Wzzz01ifm6GiuNtNzYLa2kXt
         cMGZ0FZGw5U1aGUK5P7+KoFry3dYzvY6UTF6jKT+/gOkW4mTDxgACHJufe4kx5AXr2oj
         uRrnPlBgojbZqYgGDPCrqQANF1kNtmEzuxXdsew6Dy4jm1see3KamttM1I1OtVrvj4q7
         fckjHaN+75QwnqWDrKeQHWIs29MQX9J5ZZa04BkQj9Nbg9MOxg/pdUreOpEWSiUNWIMN
         Xxwi00hVcwqcYcpujFYgbZSrMtW6fezauDl+jAK5G82xpTLd9RN00PJ/l5OV1jQYmL7z
         tVrg==
X-Forwarded-Encrypted: i=1; AJvYcCUmDE0OEqVqLJion+i1tpkHxMiuKOaBr93ECURRQKF5nBMHa0hOxtyruTLwM6LEXnGfPpyFjbDc5W6R996j@vger.kernel.org, AJvYcCWm7uDkXP/9jx/ynGLLwe6w6RMo7V0rHVjKr8ap2JmMQ8jxjPHFHCUW4jluePh80FdsQuQsrnQ55I0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXM9gihtDQH9IcPWCrwc/3wsaPSB0vPGTgpil3easlJMSE9RId
	99bupTG1cHHkEgPAzbaGHlNdUEAigyWAY6ilwk88eTu1BIni/xVvY6D8v1y9h1E4S5AJPWvhQu1
	0Yk1g/kn1svv1DXKMqfZ3vI03UTI1W0AF3qCR
X-Gm-Gg: ASbGncuh3w04PCXCOvXgPYrOErfaXpZcwzLKNwwE7okc/TQkpzyiozAbG3ZTtSUEOgj
	VBTKhKoTyNwRzoPCAQc+GOGKxpr6qnz5K7tte1Qf3SACjDKQnX5t2teUeOjgkJ9cSKGgM5+07Y1
	rusHkame6YC2P88bcGxRdDXm1TmVbYZmlMBT1/OOgkiqAR02//nBgZlpxaXWeJeqHGhD+7Fi2Yg
	a6cK4YNjbWOK30Co7JWw18rQ+A5BpbIcpOFGRi+QM1oXM2zVzOl
X-Google-Smtp-Source: AGHT+IGyHWR0ixeODWGiHZ4tKEMSCyemNET6jsgAUT5a1106U13tsYaZMkqV4CsDAhBgVhUCs2umgFiwys4+toeStdQ=
X-Received: by 2002:a05:651c:20cc:20b0:32b:78ce:be8e with SMTP id
 38308e7fff4ca-33650faa9c1mr59523441fa.32.1756490587922; Fri, 29 Aug 2025
 11:03:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827191919.1361787-1-akshayaj.lkd@gmail.com>
 <CAHp75VdQB673=qXBp0mPUHxQGxM=Z1CNSmEpP82OprVn++Y5uw@mail.gmail.com>
 <CAE3SzaTJTi3bHnqNbAfQ3W2jHcmhQHqa2ZtKE7=2BnP+onJv-w@mail.gmail.com> <CAHp75VeSMApm0TPU1=myhJiXQjWVpebbWEPGcRJQhfSaffdYmw@mail.gmail.com>
In-Reply-To: <CAHp75VeSMApm0TPU1=myhJiXQjWVpebbWEPGcRJQhfSaffdYmw@mail.gmail.com>
From: Akshay Jindal <akshayaj.lkd@gmail.com>
Date: Fri, 29 Aug 2025 23:32:56 +0530
X-Gm-Features: Ac12FXxpA1I72rFIqjSO0x4NQcFT8cd2xI8vNlfmebF0hE-ZenfdlTkyDUCSBv8
Message-ID: <CAE3SzaR=uPtE20ZkWVXYwBrUZ=b46h1Ub=TbWArHW6XbD8qXfQ@mail.gmail.com>
Subject: Re: [PATCH v2] iio: light: ltr390: Implement runtime PM support
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: anshulusr@gmail.com, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, shuah@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 9:16=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, Aug 28, 2025 at 9:47=E2=80=AFPM Akshay Jindal <akshayaj.lkd@gmail=
.com> wrote:
> > On Thu, Aug 28, 2025 at 7:17=E2=80=AFAM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Wed, Aug 27, 2025 at 10:19=E2=80=AFPM Akshay Jindal <akshayaj.lkd@=
gmail.com> wrote:
>
> ...
>
> > > > +static int ltr390_read_raw(struct iio_dev *iio_device,
> > > > +                          struct iio_chan_spec const *chan, int *v=
al,
> > > > +                          int *val2, long mask)
> > > > +{
> > > > +       int ret, retval;
> > > > +       struct ltr390_data *data =3D iio_priv(iio_device);
> > > > +       struct device *dev =3D &data->client->dev;
> > > > +
> > > > +       ret =3D pm_runtime_resume_and_get(dev);
> > > > +       if (ret < 0)
> > > > +               dev_err(dev, "runtime PM failed to resume: %d\n", r=
et);
> > >
> > > If it fails, there is no point to read the value, it will be garbage
> > > or even can make the bus stuck.
> > >
> > My rationale behind this approach is that earlier ltr390_read_raw()
> > had all the functionality
> > of the .read_raw callback so the return value whether success or
> > failure was of the core functionality.
> > But now, since the core functionality has been relocated into
> > __ltr390_read_raw(), I felt the return value
> > ltr390_read_raw should be the return value of __ltr390_read_raw().
>
> "Main" returned value. But this is not the point. The Q is, how do you
> expect to get not garbage from, e.g., powered off device, please?

I got your point.

My Rationale:
------------------
From a functionality point of view, if before runtime PM usage, the
core retval was being
returned (success/failure), then now with runtime PM also, it should
be the same core retval
which should be returned, but I think that is not correct thinking.

Updated Approach:
-------------------------
Since we are introducing new functionality of runtime PM in the
callbacks, the return
value should reflect ANY failure in the callback, be it failure of
core functionality
or failure of runtime PM calls. With this in mind, I will be
refactoring the callbacks
as follows:

ret =3D pm_runtime_resume_and_get();
if (ret < 0)
     return ret; //main functionality will not be called.
retval =3D __ltr390_read_raw();
// not checking retval because irrespective of retval we need refcount
decrement and suspension.
ret =3D pm_runtime_put_autosuspend();-
if (ret < 0)
     return ret;
return retval;

Let me know your thoughts.

Thanks,
Akshay.

