Return-Path: <linux-iio+bounces-20011-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7B3AC80D1
	for <lists+linux-iio@lfdr.de>; Thu, 29 May 2025 18:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BA307A5EB4
	for <lists+linux-iio@lfdr.de>; Thu, 29 May 2025 16:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B957D22CBEA;
	Thu, 29 May 2025 16:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OEJG8klE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBE319AD90;
	Thu, 29 May 2025 16:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748535809; cv=none; b=SaIcUALRVbFJOSzQ2zQxtvtFJ0olto4nbnjp/v6I3E7D7w9TtMEzBDzG1gUghd/VZfhI7Elh7MNKdG2xCyLERtRxC1PL/VTqc/GOc83ZrGj1gGQLp+eJ9KXmPHj8cX/EK19+8j0k2syLyWHYY2xNkDyZU0bk0VqxcFTebpEet7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748535809; c=relaxed/simple;
	bh=y88bWnjdDmH8A53C7ItcbB51L4+6m81K5nRKHO9GgrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u0BySTveLefhPHN0F8r/KHvNXXRKcrmu5/5Y/ixnnK7LwEARY8cwiCAGqP3RWe9aW6Jiydk6eRbvC9/lt2qhpESuK6Qoci5KKZe6KlvQXRGPs6+rUee2M49OZQmB7Gv9hP6dwGXdhPG4TR1tqyq3sW2yknjQEOnow2QumhL2YSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OEJG8klE; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e7d74904be7so100445276.2;
        Thu, 29 May 2025 09:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748535807; x=1749140607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y628e+r5J46wCH9AZO34Qtcv0eqO1tFbg737Vp+QQ1Y=;
        b=OEJG8klEQhlmOtNzEHNzSxTg910dfpQYm662Fu2bgV9PZiNGsYdp7aP9+AJBLk+gsV
         7iw2GLhCD/RzxzQCBs8b8/dCausxiVfm2nD+D46aDhpxu6g9m98khKkntMfyWbKkSRJ9
         UAAfOifq8udnqZoRFu747oJL9Qa+d6F+eOGURLvthFa8zXGVPq28Qf+OssKa7uTnUDLA
         FssbFKOaDpVYMY6fPWeModP+v5/ujYijQfEbsjlWjoL/id24Ne42FZlghI9eEJVFGgkS
         cfAoCNxNNQL3AOKHXRMfdFN22IOFunuLLaLsY0MPqY6ra0DC4xFexNxK7J0jmr2KhdZ1
         KXbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748535807; x=1749140607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y628e+r5J46wCH9AZO34Qtcv0eqO1tFbg737Vp+QQ1Y=;
        b=W9FRigxgjyc52ZjQ5ngdy4DNWuALRwv78EgdffsjNDye6LCWT4V8Q9pFGPCuMIMyz1
         gL/r9k0VvSN1IWYGMJM2o3oSTJwN5K/BEBURUDNNe2LY8GssBeSmVrdSHhj4D/Uhg53R
         8oxyVsm19KMjoOKBeEwZDj/wdkWXfh4+U8CvApa3lN+U6r+5NwckGmWBoKA/Q74ZwS10
         mdnh9ip98PmzrCPurqEuKi7/ZNEwXDS0OnKFLAsV1S9JfUqGRSjZxsLtlHa/maRuoRzv
         DXgJmz5Q6SQPArjn9ODPyA8A6RpAdb3PTH0NOpHU02mL9Oeh2o3VkMmeuviCApMDW3a5
         1Aeg==
X-Forwarded-Encrypted: i=1; AJvYcCUQEP628BKSm0tK3JWpmzyaeIzlT1oLjxSUAj/ehVrPMIumqu5eNDyWrIyfqrewJ77wBgvC01Hz01JNCJVo@vger.kernel.org, AJvYcCUTfRq5iKzHJqgV1a/CCm/isaPQ3PvN7wsZHuIuKAAHVKupEZ4EllPRX9v5GQz/d5bwEybtICsjcKWj@vger.kernel.org, AJvYcCVEoXQpquGZuUZqe24t3tGZBKE71+ye5s8yb0ZOnBqMp6r4FTEnodW/mQYsqTznwuek4xWZAmoRSMk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4SCSsskHYWpp9KMrE71/vPyhq2fz2NpUjNjy7s7LactQuVf5R
	NnlHE/frK2+NnH3lkf1tHMHJnw+D3jEUF7dBy9gjCF01RNMMXtD9JFrpoptXWV/CCcxzPu+Yc3r
	GV/38RjoZIXqFJcwk4YnNcePXZhzKwcA=
X-Gm-Gg: ASbGncunAxwSGEA+BLFSeOFYe5OHCTnH5YLWBmYjNTyeHpsLI+DFxiJiJt7nH1CgWK2
	L2Ykm/ynm+lPUdIPlW/Z+RsdRAGN+1VjiWGh0ggZWn6KvAOd5DYkPN5VMHI16VZoWIbY2bi0SE9
	g39Crh0GDG7IMzZ0s1rTEDRG5UigmZy60I
X-Google-Smtp-Source: AGHT+IGhObu3W6mQruMR/+MrCuHMLXN9Vg4M2aXNyeRCnDSL2N9NCp8mknXUuMRRBVrSuN72UeazYuMSeQSlYdpxwvA=
X-Received: by 2002:a05:690c:4808:b0:70e:923:217d with SMTP id
 00721157ae682-70f97e11cbbmr481117b3.1.1748535806730; Thu, 29 May 2025
 09:23:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250523223523.35218-1-l.rubusch@gmail.com> <20250523223523.35218-10-l.rubusch@gmail.com>
 <20250525140351.559be514@jic23-huawei>
In-Reply-To: <20250525140351.559be514@jic23-huawei>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Thu, 29 May 2025 18:22:50 +0200
X-Gm-Features: AX0GCFvzeuawi05YPC7HpbpaM7CtaLMYnQbBAczI4RTC1RjBW97G2T84TwCz5CA
Message-ID: <CAFXKEHb96Kyr_L_Mw3UQxxD=nR8X2bU3TCcgH6OWsqYfaQtE+Q@mail.gmail.com>
Subject: Re: [PATCH v3 09/12] iio: accel: adxl313: add activity sensing
To: Jonathan Cameron <jic23@kernel.org>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, corbet@lwn.net, 
	lucas.p.stankus@gmail.com, lars@metafoo.de, Michael.Hennerich@analog.com, 
	linux-iio@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

On Sun, May 25, 2025 at 3:04=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Fri, 23 May 2025 22:35:20 +0000
> Lothar Rubusch <l.rubusch@gmail.com> wrote:
>
> > Add possibilities to set a threshold for activity sensing. Extend the
> > interrupt handler to process activity interrupts. Provide functions to =
set
> > the activity threshold and to enable/disable activity sensing. Further =
add
> > a fake channel for having x, y and z axis anded on the iio channel.
> >
> > This is a preparatory patch. Some of the definitions and functions are
> > supposed to be extended for inactivity later on.
> >
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> One comment I found confusing.
>
> I see this hardware is similar to our friend the axl345 so some of the ou=
tcomes
> of final reviews on that series may apply here as well.

Yes. To be honest with you, I already saw several places, where I
probably need to send you some refac for the ADXL345 as well.
Implementing the same type of source a second time, sometimes leads
[me] to different[/better?] solutions and brings different insights.

>
> > ---
> >  drivers/iio/accel/adxl313_core.c | 229 ++++++++++++++++++++++++++++++-
> >  1 file changed, 227 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl3=
13_core.c
> > index 80991cd9bd79..74bb7cfe8a55 100644
> > --- a/drivers/iio/accel/adxl313_core.c
> > +++ b/drivers/iio/accel/adxl313_core.c
>
> >  static const unsigned long adxl313_scan_masks[] =3D {
> > @@ -300,6 +334,60 @@ static int adxl313_read_freq_avail(struct iio_dev =
*indio_dev,
> >       }
> >  }
> >
> > +static int adxl313_is_act_inact_en(struct adxl313_data *data,
> > +                                enum adxl313_activity_type type)
> > +{
> > +     unsigned int axis_ctrl;
> > +     unsigned int regval;
> > +     int axis_en, int_en, ret;
> > +
> > +     ret =3D regmap_read(data->regmap, ADXL313_REG_ACT_INACT_CTL, &axi=
s_ctrl);
> > +     if (ret)
> > +             return ret;
> > +
> > +     /* Check if axis for activity are enabled */
>
> If all 3 axis perhaps?  Or If any axis?  I'm not sure what intent is here=
.

For the ADXL313 I do generally all axis, i.e. x-, y-, z-axis - enabled
and disabled, respectively. I'll modify the comment.

Sry about spamming the ML with my emails about the reset function. I
oversaw your other mail. Patches will be merged.

Best,
L

>
> > +     if (type !=3D ADXL313_ACTIVITY)
> > +             return 0;
> > +
> > +     axis_en =3D FIELD_GET(ADXL313_ACT_XYZ_EN, axis_ctrl);
> > +
> > +     /* The axis are enabled, now check if specific interrupt is enabl=
ed */
> > +     ret =3D regmap_read(data->regmap, ADXL313_REG_INT_ENABLE, &regval=
);
> > +     if (ret)
> > +             return ret;
> > +
> > +     int_en =3D adxl313_act_int_reg[type] & regval;
> > +
> > +     return axis_en && int_en;
> > +}
>

