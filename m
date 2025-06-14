Return-Path: <linux-iio+bounces-20664-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0AAAD9F37
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 21:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAB22174B1E
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 19:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90F91E8320;
	Sat, 14 Jun 2025 19:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMmW5sKf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBCC54670;
	Sat, 14 Jun 2025 19:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749927783; cv=none; b=raVOFtej5iJDUTOPhUf0aTwVjnR2n2BMKSB5alh2U8u3KZb6nsJSu9YR3PjiUrFb2S+MN+PG8fk7XR4ReJaa7iS6YMKgIBwGPTSwj9OeKgIJCZw8UsZJ9rVirMDA+Zro0BcoEjf98pXVAzlHxycU5Ax2pW/h2ukpAPSsyXBGXMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749927783; c=relaxed/simple;
	bh=wmhIl5eNtjuRRYDprAwACUTyOPlF1TtOvf3w9eerE/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pReoRBM8VYkMRIi+TJwemdrjE+y3mJnRn8LAvIEgCwXf2vxpIMS0nMeZcHoNuRzHDPwO0e24kCZ6WlHzlZ9X+6iP8UjVRR8J8dK2q3SWE7Suqi9LNSrK02teLaRZ9Z225I7lnAPA7nUtgCWspwOSLAWjvi0nQxBX7ik5A2wvrKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cMmW5sKf; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ad8a8da2376so525518666b.3;
        Sat, 14 Jun 2025 12:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749927780; x=1750532580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TN6GkerJFD6CWH4ZgMxurVC6ip3Bfjx/2RgrJ7PlO8c=;
        b=cMmW5sKfBblHykes7p8HKQ6uqljv6ZQiUQCEzn8UC8qgMCPoUqF8ePl0MVQvEiIJsG
         3cBpoTw9xzOvm2DdnOVWWm2TWY64ANQHC0D1M39IGhtQUV6b6zaf8Kg+CT30a5ahtfkW
         cvC+JsH5dAID848GMrBx8jeBEBmCf6Mbh3m5N46OuUcBeFVXq9NNkoOTg7XVm7XXfs2i
         FRZw1UnCgvi0mbi5lyZM/arAE8G6qwvB/J/bRKV3yqVBaavQYqfkoYx5blxpev/k+4T3
         s0KhNGHErHg8DUsmJsZrLxLqxKOkYEd+inigGvbHOJmsJtLDp7bGa/Rlfo5iRWu53/R7
         PsBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749927780; x=1750532580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TN6GkerJFD6CWH4ZgMxurVC6ip3Bfjx/2RgrJ7PlO8c=;
        b=fAM90u/fTlQBxF/YpfRmO6f71m4uOk9AC57an43BWo8PDn4zJlQ7on3iaoz1kVYquc
         lbUU+FZPjYw9hM20euU/Jux0bDCZrAg/mYhl9lLUster4wgULYV2iTMhCVPLqIUKl0XN
         YFVZayC/hRoxPRw7kOmSeyqbtbKLa+c+NlR92VZNdD3nWdeX8RKTAiaOTO+0d7xxTwF5
         SxFSsOHSzcq6kRY1WmgTsa5lpYhLywSeIhfg8DAlPTkd+MgeeVI4mzB+7sIGWkT6+K0Z
         unKVW3FmDHsFo9qG847DE6F9OhRdMnGU1r4sAbINvp5nOMMW2MGPW44ZgIyXysP7Q2p1
         hIUA==
X-Forwarded-Encrypted: i=1; AJvYcCU9EI9Hmzozoammj5SoO+k7S5E2ctO84yH3VykkcYulNOiCXiPeaBZBXcoSnn/dzX8X1bWBA4JyIzMY@vger.kernel.org, AJvYcCUvTQ5T0zcjcJ5Ium9xDbfrd30RL3Yqj2GqWDU2zNdzBl5CVqxN486khGjPYJWJRPtNedxGK+Rwf6Y=@vger.kernel.org, AJvYcCVSbNlPqNgWwFxGwPsJEDDcoFK0QV92fPX5ef6sr7CLXX9EBIMvaaZyNpwvXEa1V27jv/x/VRg8EsG4KRUf@vger.kernel.org
X-Gm-Message-State: AOJu0YyLfpOsTSfD3TIFpJH+Xr+6URhy71WCkV70wLSfwwFkqgZ1Xalm
	O3fxARJdD1a9ePgHwsYL/K+qP6b3X2L8ENU5UT2aQ5ueWnY1+ybc85PZ8eO10QlCePk3+r6U3MF
	3Hql3eCKQB68OErbULuV0i4uBu85VrLlUFv5z
X-Gm-Gg: ASbGncuYhkTSEXl+FKVvPS/GYNucDD7q95jPubdbZOfnLqIONabO7aubQrXla0WUCo0
	kdkp8PFxD0kSPUVjjzxnQBzdifzJ/FyWq5MFeSKEgC0n5pOXEM3UG0MA6njjydcjrNJHRVX9fQ+
	cSeABEo9eTggUpQJBzzYlpL7k0N9Ecpd0DM23TKTK0v3Y=
X-Google-Smtp-Source: AGHT+IF50GuhEIAA2Fh2jVWqVfwOST8iVXR0u7QFx4pqn+hMfIjvZh+1flLbwV32FocpRdiPFv+4QxpalQA5zgKUwFU=
X-Received: by 2002:a17:906:ee89:b0:ada:99ed:67a3 with SMTP id
 a640c23a62f3a-adfad38e441mr323296266b.27.1749927779997; Sat, 14 Jun 2025
 12:02:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610215933.84795-1-l.rubusch@gmail.com> <20250610215933.84795-9-l.rubusch@gmail.com>
 <aErE0xmlm4qBHg03@smile.fi.intel.com> <20250614145528.2fb9bf3f@jic23-huawei>
In-Reply-To: <20250614145528.2fb9bf3f@jic23-huawei>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 14 Jun 2025 22:02:23 +0300
X-Gm-Features: AX0GCFt88bJw5nhB_CRIf29OKUbv23Mn_mR9u2ZKikXKpJjNPiYuXpbHZ0JYHrs
Message-ID: <CAHp75VeJg1Vi_-h+-j9Udzwf+ySv9oj7t2Kq_8irM8KgPGQDhg@mail.gmail.com>
Subject: Re: [PATCH v9 08/11] iio: accel: adxl345: add inactivity feature
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Lothar Rubusch <l.rubusch@gmail.com>, lars@metafoo.de, 
	Michael.Hennerich@analog.com, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, corbet@lwn.net, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 14, 2025 at 4:55=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:

...

> > >     if (type =3D=3D ADXL345_ACTIVITY) {
> > >             axis_ctrl =3D ADXL345_ACT_X_EN | ADXL345_ACT_Y_EN |
> > >                             ADXL345_ACT_Z_EN;
> > >     } else {
> > > -           axis_ctrl =3D 0x00;
> > > +           axis_ctrl =3D ADXL345_INACT_X_EN | ADXL345_INACT_Y_EN |
> > > +                           ADXL345_INACT_Z_EN;
> > >     }
> >
> > Now this can be as simple as
> >
> >       axis_ctrl =3D ADXL345_ACT_X_EN;
>
> That flag is only set in the activity case.  Confused with ADXL345_INACT_=
X_EN?
> (initially I thought you'd run into a bug!)

Ouch, you are right! Please, discard my above suggestion, it's indeed
simply wrong.

> >       if (type =3D=3D ADXL345_ACTIVITY)
> >               axis_ctrl |=3D ADXL345_ACT_Y_EN | ADXL345_ACT_Z_EN;
> >       else
> >               axis_ctrl |=3D ADXL345_INACT_Y_EN | ADXL345_INACT_Z_EN;
> >
> > Yeah, I don't know how to make the diff better (it gets worse), but the=
 end
> > result is better.
> >
> > One way, which I don't like much is to previously have this conditional=
 written as:
> >
> >       axis_ctrl =3D ADXL345_ACT_X_EN;
> >       if (type =3D=3D ADXL345_ACTIVITY)
> >               axis_ctrl |=3D ADXL345_ACT_Y_EN | ADXL345_ACT_Z_EN;
> >       else
> >               axis_ctrl =3D 0;
> >


--=20
With Best Regards,
Andy Shevchenko

