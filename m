Return-Path: <linux-iio+bounces-21102-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D8FAECB92
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 09:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73D2D1897DD8
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 07:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DDD1D618A;
	Sun, 29 Jun 2025 07:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJtUVNeE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFAE64A8F;
	Sun, 29 Jun 2025 07:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751182256; cv=none; b=a5H9+p/gG7HI5g27JqOPoacWIxuipw6guVKDDBMNI+Kx/f0E67HJ2k29/5+hLntHHdWzMeHrl3mYfKIE/BF4b4+krKutmSdsU/FugDclQKO6CdZF+Lq+lIoJ0qJ6zuNdzlppE0g36UR/qRxO7PKJ0Qsd2IW/QdLXsVsDHK4MQ0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751182256; c=relaxed/simple;
	bh=lzAdXeWzS7UHunGV9sC2feZ0Lyi6sv0tG38eI9AAZxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NYOh4LKe9MVY719SlNZ/0vNWncn0Sww3AWKQMhhZwwiTpKwx7Jy627j86vK+tje9nlwtrZyY2tQEB2gT0FCcw963txPUtlDZLCHasJptHkPVuI9n9VbcvMPjxkyeQ+8T7XTijDgt7KKbEz7cWiOc6HQ+ZRfYdYfhygim+oYoWvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YJtUVNeE; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-60c4521ae2cso6309064a12.0;
        Sun, 29 Jun 2025 00:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751182252; x=1751787052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gouqz/P0ZHGMXYfLBgSpafQwUrps1XiVFKY5YDRAgcA=;
        b=YJtUVNeEtqaGYCZ4Ajs3BxUQjQeHW4z4D1SJ8mhu+FgjwrO2eGGapmw8isM8Atxu7K
         c6nJ10o60C8foxLP+NkzXqzcibu2Wuve/6zrDtpmZrPe++Hhh58ePRNd5Uxx8QRH7boZ
         SpnOzjG2iE7OcL0GdO/HJm83EC+Dhr7hAcCIJDBuPa0r7k5rux2FfOTB+B8nbLKHiioD
         HYa0BXHu4CPAs0vSCyw4RT93fdoNsU1Iaz7stnn4+UsFGjYai+BBgNDD3+DEAH9WzWoW
         z1yhI1ko9N8U/5yIVl97bY9AU5IESIxlOCRCfjus0yX7MGPtahE0VLdXdKNhZKXJ3ouY
         g8qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751182252; x=1751787052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gouqz/P0ZHGMXYfLBgSpafQwUrps1XiVFKY5YDRAgcA=;
        b=XLOSL9DoCsKFq+I6g7WzFSOnMrFryLuNjXDyVw7VbSUN+y4WvUPtipIKjXTFq51cOc
         iroj2UCdw38xGOfr5ZzW7lfZTAA/NghiKr20nUv6IGOJkOCd4ZI7LE27Lcvg5T9kBwBa
         aw/oOd6iusqnIZwTcjPRheo7cUndRtwrNXLFRA0uyaKoX3zpnFmre2q/aOphpYaaXaOQ
         3eSsEi/+s1nMuGVdtoc/TtFcRumg2nlnwbJ2EOvCaalE4N79VszV8OMnz6MhpwSFeS3I
         f49iaVHh88Z8beAlIt3sh0xxTilTMJacOc1h3fCXleZRevDEOQQFMSOjJct7ffDSHjFo
         rW5A==
X-Forwarded-Encrypted: i=1; AJvYcCUM8dfrXZmlOH7tZgXXZ2dRjyH+3E/L128gl5xNjaR9aHxZ0xcxCQiDDr8w/73mfNtkcobg7d4cuf5f@vger.kernel.org, AJvYcCV+HKiUVqgB/oPESXFy6oTPSE77kN34P5dfNPFSqpU0Ih2m1pF/c/xFy9TAv0nbQAYaVw8I/acMvbYKOyls@vger.kernel.org, AJvYcCXPdVWteK6vIGZijuG9bjb2Kl2y4iCXRXfcdELNPzEnh6gV0oAvnNZqXYv8jrK69m9ngVYHnwsnMgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUfE+1TU6wCjOd4RaieWMAVDCHBsEGd9eI9JgW5bXeG+p9Hwrp
	Kv4zkkmybQvKcGbiSTAeSiyo8ZlRwML0KOrVTmAzb4DWTm5TFoQgkvVOQYEgG0j1hZ3+nEVXEi7
	U0JxOanby+IBlzau1IC5k7b/EyP6ZG9Kp2lLc9eQ=
X-Gm-Gg: ASbGncvz1wT4dOWGT3eyUbrFQ3HADvVGPcXTboCFoThfGVAwfEfFxNPqiG+DRQwr9Si
	oj7LkVOPf4OG0fnTN68A6+mlA6OMULU2LsqmqIG6o1o2k9BcxE7jvYDl7WOsNn1Fg1pRYJWftOI
	Ni6sP2vYO94Uu6R9JynudDDQ3IbaDqaKoFMylMWzjTLHghRfPZ3LbL5Q==
X-Google-Smtp-Source: AGHT+IHib53xCZKrc2Ivoz5WYTDlq3yiyFEunZ6CtvFcHDULZm8fYw4k/pC+f9O6IXUlgNpWdWxPoYtQtm7kxngZato=
X-Received: by 2002:a17:907:d29:b0:ad4:f517:ca3 with SMTP id
 a640c23a62f3a-ae34fddcf01mr818564166b.20.1751182251367; Sun, 29 Jun 2025
 00:30:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250622155010.164451-1-l.rubusch@gmail.com> <20250622155010.164451-5-l.rubusch@gmail.com>
 <aFkh-E1dG__p_G4m@smile.fi.intel.com> <20250628170839.482a3d63@jic23-huawei> <CAFXKEHZ7bNuy+6X4NgPPMOsT3AkSXhacH=3HS33bLTNgYa3PWg@mail.gmail.com>
In-Reply-To: <CAFXKEHZ7bNuy+6X4NgPPMOsT3AkSXhacH=3HS33bLTNgYa3PWg@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 29 Jun 2025 10:30:15 +0300
X-Gm-Features: Ac12FXz8D5AKOwJ4AnJFbp2W7wkTqO3f4X7--2CD-9oLu4-ogHgVvmgjftMqIDE
Message-ID: <CAHp75VfOKDZRoVWLQoPQPzpN2MceTeN_4OoU0RvxG7_J8OAoMw@mail.gmail.com>
Subject: Re: [PATCH v10 4/7] iio: accel: adxl345: add inactivity feature
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andriy.shevchenko@intel.com>, lars@metafoo.de, 
	Michael.Hennerich@analog.com, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, corbet@lwn.net, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 29, 2025 at 12:11=E2=80=AFAM Lothar Rubusch <l.rubusch@gmail.co=
m> wrote:
> On Sat, Jun 28, 2025 at 6:08=E2=80=AFPM Jonathan Cameron <jic23@kernel.or=
g> wrote:

...

> > > > +           axis_ctrl =3D ADXL345_INACT_X_EN | ADXL345_INACT_Y_EN |
> > > > +                           ADXL345_INACT_Z_EN;
> > >
> > > Consider
> > >               axis_ctrl =3D
> > >                       ADXL345_INACT_X_EN | ADXL345_INACT_Y_EN | ADXL3=
45_INACT_Z_EN;
> > >
> > > (yes, I see that it's longer than 80, but it might worth doing it for=
 the sake of
> > >  consistency with the previous suggestion).
> > Hmm. I'd go longer rather than do that just because it looks really ugl=
y.
> >
> >                 axis_ctrl =3D ADXL345_INACT_X_EN | ADXL345_INACT_Y_EN |=
 ADXL345_INACT_Z_EN;
> >
> > I don't care that much as long as long lines are justified by readabili=
ty. Here
> > I think either Andy's suggestion or the all on one line are justified.
> >
> > Tomorrow I may have a different view :(
> >
>
> As I=E2=80=99ve seen quite a bit of discussion around this. In fact, usin=
g
> binary OR here might not even be necessary, since I can define
> ADXL345_ACT_XYZ_EN and ADXL345_INACT_XYZ_EN directly and OR the fields
> in the header. If you have no objections, I=E2=80=99ll likely prepare thi=
s
> change for the next version.

Actually I like your idea. This will be sustainable over style
preference changes.


--=20
With Best Regards,
Andy Shevchenko

