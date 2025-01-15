Return-Path: <linux-iio+bounces-14376-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8816CA1268D
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jan 2025 15:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 926DB1637DE
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jan 2025 14:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2F08633D;
	Wed, 15 Jan 2025 14:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DwTe6zDF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234F786320;
	Wed, 15 Jan 2025 14:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736952819; cv=none; b=FUsU5Qazu97hpmjsUpmbwOvUIuX4f02EA+pxYe1NF249AjKQS1HPKF3vSlLe6v4eV59oR5AM6C0ogEDA3ePLKRnbeRmTIHaUGuoLbtNT7isgm9Jj19EiidYhy9hJQhDilbH1LeE65/o/+DORCQVvRXuOtT7PaB0asVVCI3qCoqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736952819; c=relaxed/simple;
	bh=eTIklboiApzMKKv778CmvlxODnK8KRmDBxowGwWzISk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qoXf9PngUtT+IEP77N2Wfr7+GOYMRq3wUCNjEWfFo/YqFzCM7uquFn0QqaNTbLUueI3E9jDjr0nyZRvjQCGtvYNysaepFZalrr+R+R0NcoUc/k/Y/QxwfZ43qWxc5AOiqI09KsTfzRfPF5W3mRTjwltYZIklxHXXJO9CnDqUh/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DwTe6zDF; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d3ecae02beso8645122a12.0;
        Wed, 15 Jan 2025 06:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736952816; x=1737557616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Exad6A8hI8geVpZ7f8Mu8SK2Zs48oxewcA2FP2FpJs=;
        b=DwTe6zDFHmG1X34sHZTbmsUzk/wlEC3TDUhyPQJI8ljKCSYvx4BNv5W2vbk7HkuR54
         mY0otAa+s54a6VFqZtc6yKmb5FP6s8tYOf/I4szJUb5RXyiwKDo1XxQrMUVRUDR1wCbK
         VRrvUXkeJRw1VcUZNxz+ucBVlfh4HTRXFR8PMzCiSoQdVzIqtlcJewVmAzEtdSTG+kKg
         n+2OqyBoHWiqjpnlcUXynpCd+0Z+a6yU6uheKTbc+YlTrlVoDBlT5p/WLfGi8lOmBcCt
         yrFfykXW6EP8XQIK5McD9wMXZ3VX15OsknzmsYZklWNtVB3dAd8ohflnFSj9RnSASTQ0
         uDsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736952816; x=1737557616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Exad6A8hI8geVpZ7f8Mu8SK2Zs48oxewcA2FP2FpJs=;
        b=XvlyG+zV15J6SI+g+ck9bYA7c3cF+O71FfDShYlbF7m+UitQi63d/lFkyOrJepLZwl
         ql6qq/AQO9YBOI8kDAwBitD6ekDTN4izS54Y+oltkUhFINZ20Vzc3umxjlLmu6EmhiuZ
         peL+/YEYnjoWW99vITKWUWx4GUq5IyKvRInyvruT1hu/7HRf4efGJbb1H2BwlSmWMqoC
         iZtmKNRLmFTGNO438ULlHV82EcsQETf6Ar4Ebmk+br1UN2Bjsk0+satkuMcG1DPyEQsP
         0mtPBVeOtzFq1XBUvYGKU7SgyJjrJMnK0D12HtHBCAmgC6rVbVop2ErclHhiC1jHTqAr
         xQUA==
X-Forwarded-Encrypted: i=1; AJvYcCUU3L6vxmiWJhI2tvzDUo0FODGQYIQCREhtsLmiJB54LzGy/Dx/BwixsR22qMoZ4z8zrgDb1prBmHbW@vger.kernel.org, AJvYcCVa6kIFmkXa9OyYvN2xylakdfYHJMyqXVyoDuzTryK6RXx8kSVJvSXXjB4fgb9ThoBx1wb04wjlbCwkRnI8@vger.kernel.org, AJvYcCWYLGu4kqTSyzmZyXhXPRQQ4ZsDSkAskKqDpIjLLE1J88Qd3QHi+8/025tBVtaxqhpYLphgb9idnFr2@vger.kernel.org
X-Gm-Message-State: AOJu0Yy188Q66nIPNqfIM18/lCQfwfUd+TK0sjDKZsi0ajDcXjp+1KGv
	JR9g9HEjUFD5Y36VKcwDEsRrjLHLa2g/CP4/qAsFf79zn9cX/MWSWHB+cWzbNX+8FB4gSqQxijL
	GqzLcOkbzk/vo5jEGc2lvvjAL6kY=
X-Gm-Gg: ASbGncue5KXqiYcb7yBUybSMDUo0/GC4uMfmBrYxOgk/rsyzlwcOvXRu9CAxXESjqPx
	ffAohE3VmQ7Ezp5HrmCmvP0+c5zDZx+H3sQZ+Yihw
X-Google-Smtp-Source: AGHT+IGE1D35CHfWqvVfCZQSkSqFFguIA4godpROtOM/p50qJjSmwqLzsjH3po+5swCRk8JA0ac/PzNbiU3ubLiqQgo=
X-Received: by 2002:a17:907:1c2a:b0:ab3:3eea:1ccc with SMTP id
 a640c23a62f3a-ab33eea225cmr617929466b.27.1736952816205; Wed, 15 Jan 2025
 06:53:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250112104453.45673-1-apokusinski01@gmail.com>
 <20250112104453.45673-3-apokusinski01@gmail.com> <CAHp75VedQvf2xwY3fDWX=FQaHyhaUSVJW3Y6Yt2ecpwru756vw@mail.gmail.com>
 <20250113221905.ruv3w3k4w53hvf2b@antoni-VivoBook-ASUSLaptop-X512FAY-K512FA>
 <CAHp75Vf-zdsh6CP3XX6jyjVutch9Z_iH78zrpaFkt9WkP=qz4w@mail.gmail.com> <20250114235323.3xkktco7fsb6pmzk@antoni-VivoBook-ASUSLaptop-X512FAY-K512FA>
In-Reply-To: <20250114235323.3xkktco7fsb6pmzk@antoni-VivoBook-ASUSLaptop-X512FAY-K512FA>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 15 Jan 2025 16:53:00 +0200
X-Gm-Features: AbW1kvbZ1F20LXQEngSIM0CFKappqECMmI-4ITDJAE3I-6NkA4RCqT21mmgS6eQ
Message-ID: <CAHp75VcWiXUe4oDmhZc66CB+gaRpy9=9eixt+jA9xAO_-J2-=g@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] iio: magnetometer: si7210: add driver for Si7210
To: Antoni Pokusinski <apokusinski01@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, andrej.skvortzov@gmail.com, neil.armstrong@linaro.org, 
	icenowy@aosc.io, megi@xff.cz, danila@jiaxyga.com, 
	javier.carrasco.cruz@gmail.com, andy@kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 1:53=E2=80=AFAM Antoni Pokusinski
<apokusinski01@gmail.com> wrote:
> On Tue, Jan 14, 2025 at 11:43:11AM +0200, Andy Shevchenko wrote:
> > On Tue, Jan 14, 2025 at 12:19=E2=80=AFAM Antoni Pokusinski
> > <apokusinski01@gmail.com> wrote:

...

> > > > > +struct si7210_data {
> > > > > +       struct i2c_client *client;
> > > >
> > > > Do we really need a room for that? Isn't it derivable from the belo=
w
> > > > regmap? Also note the frequency of use of client vs. regmap. The
> > > > result in the object file can be much better if regmap becomes the
> > > > first member here. Check it (with bloat-o-meter, for example).
> > >
> > > I used arm-linux-nm and the bloat-o-meter to compare the sizes and it
> > > turned out that the version which contains the `i2c_client` has
> > > slightly smaller size actually. Here are the results:
> > >
> > > $ ./scripts/bloat-o-meter -p arm-linux-  ./old_si7210.ko  ./new_si721=
0.ko
> > > add/remove: 0/0 grow/shrink: 1/0 up/down: 4/0 (4)
> > > Function                                     old     new   delta
> > > si7210_probe                                 556     560      +4
> > > Total: Before=3D4021, After=3D4025, chg +0.10%
> > >
> > > Here is the diff (shortened for better readability) between
> > > the old_si7210.ko (uses `si7210_data->i2c_client`) and
> > > new_si7210.ko (does not use `si7210_data->i2c_client`):
> > >
> > >  struct si7210_data {
> > > -       struct i2c_client *client;
> > >         struct regmap *regmap;
> > > ...
> > >  static int si7210_device_wake(struct si7210_data *data)
> > >  {
> > > +       struct device *dev =3D regmap_get_device(data->regmap);
> > >         int ret;
> > >
> > > -       ret =3D i2c_smbus_read_byte(data->client);
> > > +       ret =3D i2c_smbus_read_byte(to_i2c_client(dev));
> > > ...
> > > static int si7210_probe(struct i2c_client *client)
> > >         data =3D iio_priv(indio_dev);
> > > -       data->client =3D client;
> > >
> > > Hence, I guess that it's actually better to leave the `i2c_client` as=
 it is.
> >
> > I don't think you have tested all that I was talking about, i.e. have
> > you tried to swap the positions of client and regmap? What I expect is
> > that when you swap them you will see a good size reduction due to
> > pointer arithmetics becoming no-op for the regmap pointer. And then
> > the dropping of the client might waste all that beneficial size.
> >
>
> Ok, so I've tried to swap the `i2c_client` and `regmap` pointers and...
> there was no change shown by the bloat-o-meter. The only improvement was
> that the new object file (that is after moving the `regmap` to the
> beginning of the struct) was 8 bytes smaller in file size.
>
> Out of curiosity I've also tried moving
> the `regmap` further away in the structure (e.g. I placed it after the
> regulator and mutex) but there was still no change. I am a bit confused,
> since this behavior is different from what you described that it should
> be.

I haven't told "should" I have told "expected". So this means that for
the compiler in use and platform (architecture) there are no
differences. Good to have a confirmation for that. Nevertheless, I
would keep them swapped, because it's more natural to see the most
used member first at the structure.

> > > > > +       struct regmap *regmap;
> > > > > +       struct regulator *vdd;
> > > > > +       struct mutex fetch_lock; /* lock for a single measurement=
 fetch */
> > > > > +       s8 temp_offset;
> > > > > +       s8 temp_gain;
> > > > > +       s8 scale_20_a[A_REGS_COUNT];
> > > > > +       s8 scale_200_a[A_REGS_COUNT];
> > > > > +       u8 curr_scale;
> > > > > +};


--=20
With Best Regards,
Andy Shevchenko

