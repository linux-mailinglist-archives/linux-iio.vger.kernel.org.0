Return-Path: <linux-iio+bounces-13291-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A839EA1BE
	for <lists+linux-iio@lfdr.de>; Mon,  9 Dec 2024 23:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1C01281D96
	for <lists+linux-iio@lfdr.de>; Mon,  9 Dec 2024 22:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CEC19E82A;
	Mon,  9 Dec 2024 22:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCkAghCC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623F219DF77;
	Mon,  9 Dec 2024 22:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733782764; cv=none; b=DvHV5PFT7tq78gwBPbbs/OY5OYvbexoNa9/CzGglDmMUdsDO5YUD3vDpCFL896Jjdep6kyjBRAwlbC1KUxApSNzcG+bER8jM7ztxqJUjlO6uMzpu3EXPZCcmz+u9OtI+G4dsZG0bHuJ7p469rN/AdMyaYGwa/CRodtjQ+9yR/rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733782764; c=relaxed/simple;
	bh=UizDA8id5TOzAqzh5MU69ufJkDcioXInDSASuF7B4qg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X9spmRc0pOD5KZ313ygNYsmAz4QUsYiIPYPUN6xTRTRcQ871jrssOCXuqHj/m4u6V002lytbUEBrY3dmBRhfzM8DRXmYyewcwBAtJfFpnJ9Fxdw0o2/G59GRyv7IE1Lg4Gq5Sg0b5SrYujm2PmZInNqag4RBQpWVGgpYPGLQXgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CCkAghCC; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6efea8d5268so2082177b3.1;
        Mon, 09 Dec 2024 14:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733782761; x=1734387561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TBcPGvste8xIaQ/+MJ0w8njhyN9mQHppjBGBCMsNJJ4=;
        b=CCkAghCC9t1yB29dpj+1BYkO9ZQ8ClX4z38UJbTgQ0kyeiYblqmLcpHlwS5bjMnI4v
         FlADVreWdi7e7dsVbK+x0YKpjRAMgL2hUEY0i2Sa10TESN8uwUSD0dKep3dR07n/K/JF
         pMrrN0qEqab1ebZi5PwPXV+CxxDphldDmwjj0dF3W73Zli//XTyPF8ftCjt2zlqYm2eV
         Jb4Z7h0aSuf9qqaou/oXO9RaXjzl8UUjahK797AWpOWXlWpPTbAvF0fgNEpN52gk+ry/
         VBB4VUQMmURQ/0YX2VNJjM6Ig7Mz8UJXR1M+9YaducVYc66yHjGBMFeOVRyrqdab75b8
         44bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733782761; x=1734387561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TBcPGvste8xIaQ/+MJ0w8njhyN9mQHppjBGBCMsNJJ4=;
        b=MvzUfBrgVeUGEPWCtlwGy5G75sS1AuyAqarzRrDlO/BsjFmg4ydnxdYOMx5muJauk6
         OGnbMiSL3cUzOnjRi6VAtBzrzGAMsHWvGpwzawh0fwuJjEBlPeOOve43vlIJ6FUwNBI1
         6MpK79TxuIL6VSoCjqqx9nFngSBXjB8/bXyp48GwBKIm3skhOtykUEUaztrmm5aLEwj4
         vZl3zJrBzrByIVp/Es8ntHSZNbzoylFUbLnx82M9x0atDs6II6GT0aK8TIA4qbOftk5q
         +NOC85bvB2C4FYIyCEYOqw7k6t1v9SY2XLU78NRAl5yTBEwTfs3GObs7qQO3jjHwGAvR
         pJlA==
X-Forwarded-Encrypted: i=1; AJvYcCVLYzW7iYA9D2RJcGTjjDmcI1+3L7zrMC/0kEHosCb/oC/ZxWABYz/FMJrDQX4/OFxxl8Pj9/Ajocc3@vger.kernel.org, AJvYcCXOMK4gyJocZ1CZq1rQoZY8TsyNCE4DWQlUmDZZyxHXxcS8C40W6Kt0BwcPEXFlU0YYyu9UAuNujfaMTzvy@vger.kernel.org, AJvYcCXmcDKAUdK0vBHsB4qhht9s/v1GyIh3fiZt5UCvB1tSuCq9v1sN6hqCVdTu33+C4gCSoXnKTDAWH5p7@vger.kernel.org
X-Gm-Message-State: AOJu0YzmGOhcJouYnotNrBO1WEm2q2MerH+lQUWLOr6fyBvzU79gufU+
	Pp+EZz1auWYP+e0FXY/nAQWHK91MHgU5/QID3qEihZoiZQv6NRR+d4sCoYELp5kErwOgGk99tmo
	lDqp1jD6xX0Usj5T+VIo93gRprHA=
X-Gm-Gg: ASbGnct/25XcenA2/A2WU2juPNf7TmmFzanDy67uG6v4HkkCjoNHvuMQ+hukVZ/btw/
	uqh/W5kBHKusVwgyb/umBYamE5IN3ZIItqzQ=
X-Google-Smtp-Source: AGHT+IH2l+9WfFfXBybh1dyhw89xFdfwcFQxCGPGreisNOmc12R5bHKK18ypQcE+doXoW9vsu8juM6MZZu0tx1DZ6bY=
X-Received: by 2002:a05:690c:4c13:b0:6ef:53bd:3633 with SMTP id
 00721157ae682-6efe3c818bbmr54656567b3.5.1733782761161; Mon, 09 Dec 2024
 14:19:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205171343.308963-1-l.rubusch@gmail.com> <20241205171343.308963-4-l.rubusch@gmail.com>
 <20241208133458.4a8428b7@jic23-huawei>
In-Reply-To: <20241208133458.4a8428b7@jic23-huawei>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Mon, 9 Dec 2024 23:18:45 +0100
Message-ID: <CAFXKEHbPmFc8DNZW=Ww39j+XkAfLOyFY2qgvz+uEUaBYri_3hA@mail.gmail.com>
Subject: Re: [PATCH v5 03/10] iio: accel: adxl345: measure right-justified
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear IIO-ML, Hi Jonathan!

On Sun, Dec 8, 2024 at 2:35=E2=80=AFPM Jonathan Cameron <jic23@kernel.org> =
wrote:
>
> On Thu,  5 Dec 2024 17:13:36 +0000
> Lothar Rubusch <l.rubusch@gmail.com> wrote:
>
> > Make measurements right-justified, since it is the default for the
> > driver and sensor. By not setting the ADXL345_DATA_FORMAT_JUSTIFY bit,
> > the data becomes right-judstified. This was the original setting, there
> > is no reason to change it to left-justified, where right-justified
> > simplifies working on the registers.
> >
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
>
> I'm still confused by this one.  Does this change affect the data output
> to userspace?  If seems like it definitely should. If it does we have
> an ABI regression somewhere. Is it currently broken and wasn't at some
> earlier stage, or is this the patch breaking things?

No, it should not affect the userspace.

This setting opens the mask for regmap/update bits to allow for
changing the data format.
My point is rather, does it actually makes sense to allow to change
the data format, since
the driver will use just one format. The bit was never applied, it's
just the mask here.

May I ask you, if you could also could give me a brief feedback to the
three questions in
the cover letter to this series?

I would really appreciate, since I'm still unsure if I actually
verified everything correctly.
From what I did about this bit, I removed and set the justified bit in
STREAM and in
BYPASSED mode (current mode), without any difference in the results in
iio_info or
iio_readdev. The numbers look generally odd to me, though. And, I'd
rather like to ask
to still wait with applying the patches, if this is ok for you? But,
perhaps with the answers
of the cover letter items, it could become clearer to me. I'm still
about to measure and
verify against the old and the input driver results as comparison.

Best,
L


> If it worked and currently doesn't send a fix.  If this changes a previou=
sly
> working ABI then drop this patch.  Alternative being to fix up the scale
> handling to incorporate this justification change.
>
> Jonathan
>
> > ---
> >  drivers/iio/accel/adxl345_core.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl3=
45_core.c
> > index 88df9547bd6..98ff37271f1 100644
> > --- a/drivers/iio/accel/adxl345_core.c
> > +++ b/drivers/iio/accel/adxl345_core.c
> > @@ -184,7 +184,6 @@ int adxl345_core_probe(struct device *dev, struct r=
egmap *regmap,
> >       struct iio_dev *indio_dev;
> >       u32 regval;
> >       unsigned int data_format_mask =3D (ADXL345_DATA_FORMAT_RANGE |
> > -                                      ADXL345_DATA_FORMAT_JUSTIFY |
> >                                        ADXL345_DATA_FORMAT_FULL_RES |
> >                                        ADXL345_DATA_FORMAT_SELF_TEST);
> >       int ret;
>

