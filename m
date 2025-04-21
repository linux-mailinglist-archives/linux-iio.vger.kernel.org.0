Return-Path: <linux-iio+bounces-18399-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C423FA94CAD
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 08:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DC971890DFE
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 06:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45442586DA;
	Mon, 21 Apr 2025 06:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nomho5gh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0A3FC08;
	Mon, 21 Apr 2025 06:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745217731; cv=none; b=XTo9PONgkoy2cbDSEilbWyesGBz1e3mWxxflCq6NjpbkQaw5gx1SwC1W2CCq2pq0CErnEm5iX9Dr/M01IItoje9CiDD6ok8GPuwxkiBuBjiTQtmLhA/VvRn4nT85nO4WtA4uTvSnOPVknN0Zg6PoBOh4QymU2l6r0rBBiaYeyUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745217731; c=relaxed/simple;
	bh=Y9HnLPvN25MNFm/b8/YAXkzfu/Lfubhj/l5eVhmJX2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kLGrjTFF2TdncoWGL35gWgrGlUgk1rlbY8rg7CHWJmqYUzTYVNEwR4jalch4BMGnFvAVmHwvdcjJN6RSh4xzwgdrwdQaDDlwS/b71Lw+k/xVnxJUk5cycrODEZO/Z6Je8IoZb9/cNQOuImJqX13q8LjbHxWTYCSYoFrpdixpmIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nomho5gh; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7390d21bb1cso3206277b3a.2;
        Sun, 20 Apr 2025 23:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745217729; x=1745822529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ugs8lJ14AIbApKr9W0oBVK0o4S2j2Z4DyYGZRqIdOAE=;
        b=Nomho5ghgeghxTAn3fWJp2QJJQioxnFTCI9TcHacztgjKLphczHAfFqbegBABIcQaD
         tw6d+sutYo2M9qh+06YWDrgF4EFTbkXgXlCtrXRckCAKRr9f01F/u0sZbObkN+o+jFId
         7oRG0vnd91r7aFZ/DQRQTPSlVFTSky/7ft1lGeCnSRvYI8vfNOLpr/155UnjBkkiR7ou
         /ocLjmIqgkwv1B6JCz6eGpfs6gxvwmeOOV8PixaqyG5q6hC8m1plCF/7mrByWLt+iqcZ
         V5paWshZRFWYid5tMtYD1xDNX/YzeWMIqoE58H3BQ5wWbNCyORnr3OiOGWHO0VYZlNEF
         qq9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745217729; x=1745822529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ugs8lJ14AIbApKr9W0oBVK0o4S2j2Z4DyYGZRqIdOAE=;
        b=oyKBDX1FHczvwAfyir+gp+CYJUuq2vBt8PAr3cihjH/lenN+U510HovTi+kd8xjUDX
         VrrrWe5QSlIpnYZEyRtQdqF/knfoB9cXKY62zRAUhEbYCCEwBfK/WJPDw0ErX7Js/A2b
         7nw/nI05zGt7+Lanp+NjFu6MqsJkyduJRyg0gTBoP/N29ry8l3wm0bsJEacIOQB+C419
         KnxYOEf5DkzwCnDLgOu1bH9YKT04uEyiVubeWMSo/wyMCC+Mr8E2c3rBDFlBo8S+VRb+
         D5cBTI2XAQqfVm3b+/8VYcOecgvH0F+y5lUcvsorVyK9KSrA38GFTuPW7A1Yy3O8vvLc
         tJ0A==
X-Forwarded-Encrypted: i=1; AJvYcCUet0sjOC2JNQ820S5q8KRx4d1xkL1Ls6kThWCxjMWtDzL8GoJ0Vp0WKkVrzSbhRPQdAhTVtGa0aOYN@vger.kernel.org, AJvYcCVAhTkXHzAzCK3CPIXjllKkngeuOnXKHDSGBfwgzkw35+4YVe4EtBdiSQQSR5V+/WlYKKQfFPM/AlFk@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx5dDgRpa6yHas9mDtuS7bGzwlYEp9JaCJe/bbWiZcSlUJY1QX
	BBveunCd1FfYmGAJcQCTTsJrMnDITPA2SdMR4B74PfT+FnLY++PHD/QrkPT9wiLz25yuzFEeoAC
	NjzYnX9MwWa4mtRfrDmB2xLzxxeE=
X-Gm-Gg: ASbGncvrV/sV2pqmmX6KKPaF+hywMgcRsihEWdRjEtq5QO5bgmQFmGyP2VVInzrUKNU
	DIqKXy61zS+soYYsA3TkNWUg48l/BE7+wxbSfWrBEIYM5NMqz4oZFBQGwLwvQ+pLSCpq6YRtyps
	FSkTnUAo58CibBTKHje/Y0khWqc+/Y1PDS7Q==
X-Google-Smtp-Source: AGHT+IGlCV2xGhABt1QWMbT5r4sfGaYS75eVG4A6Rg1bj/CCsva+E6d7GDLX+Jv5TRXZj1Hz15MTDaCzOMpKJgTcI4s=
X-Received: by 2002:a05:6a00:9281:b0:736:ab1d:83c4 with SMTP id
 d2e1a72fcca58-73dc11a04bemr14828592b3a.0.1745217729229; Sun, 20 Apr 2025
 23:42:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250420181015.492671-1-gye976@gmail.com> <20250420181015.492671-4-gye976@gmail.com>
 <CAHp75VdAeJ0HhExE=OAeFdYz2MYFKgMffbD_Gidf86w=zhKccg@mail.gmail.com>
In-Reply-To: <CAHp75VdAeJ0HhExE=OAeFdYz2MYFKgMffbD_Gidf86w=zhKccg@mail.gmail.com>
From: Gyeyoung Baek <gye976@gmail.com>
Date: Mon, 21 Apr 2025 15:41:58 +0900
X-Gm-Features: ATxdqUHj76YXzGSdsbQXjNO1cJU1Vaiqsh-s-tbZsvBZczsEIl9Z8PHB8QTX3Ms
Message-ID: <CAKbEznvax5maXFH9V7ZLkME2=Ydt4DiJ9pwfyL_nbsJ5_G3B8A@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] iio: chemical: add support for winsen MHZ19B CO2 sensor
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Andy, thanks for the review.

On Mon, Apr 21, 2025 at 4:22=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Sun, Apr 20, 2025 at 9:10=E2=80=AFPM Gyeyoung Baek <gye976@gmail.com> =
wrote:
> >
> > Add support for winsen MHZ19B CO2 sensor.
>
> > The datasheet is available at
> > Link: https://www.winsen-sensor.com/d/files/infrared-gas-sensor/mh-z19b=
-co2-ver1_0.pdf
>
> Instead, just make it Datasheet: tag.
>
> >
>
> Should not be this blank line here.
> > Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
>

Sorry, I now understand what you mean.
('Datasheet:' is a tag, not an explanation. So there should be no
space between the tags.)
However, when I use the 'Datasheet:' tag, I get the following warning
by checkpatch.pl.
Would it be OK? then I'll use 'Datasheet:' tag.

    "WARNING: Unknown link reference 'Datasheet:', use 'Link:' or
'Closes:' instead
     #8:
     Datasheet:
https://www.winsen-sensor.com/d/files/infrared-gas-sensor/mh-z19b-co2-ver1_=
0.pdf"

---

> > +#include <linux/completion.h>
> > +#include <linux/device.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/sysfs.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/module.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/serdev.h>
> > +#include <linux/unaligned.h>
>
> Semi-baked list, see below what's missing (actually a lot). I believe
> I already pointed that out.

From the last review, I understood the two main points as:
(1) Avoid using large headers and explicitly include only the necessary one=
s.
(2) Reduce including headers as much as possible to improve build times.

However, I found that removing headers like 'types.h' didn't cause any
build failure,
So I thought it would be better to remove headers that are unnecessary
to improve build time.
But in the next patch, I'll explicitly include the headers you've pointed o=
ut.

---

> > +/*
> > + * echo 0 > calibration_forced_value            : zero point calibrati=
on
> > + *     (make sure the sensor has been worked under 400ppm for over 20 =
minutes.)
>
> working
>
> > + * echo [1000 1 5000] > calibration_forced_value : span point calibrat=
ion
> > + *     (make sure the sensor has been worked under a certain level co2=
 for over 20 minutes.)
>
> working
>
> It seems you ignored this comment from the previous review.

Sorry, I only changed 'had -> has'.
I missed changing 'worked -> working' ..

---

> > +       if (ppm) {
> > +               if (!in_range(ppm, 1000, 4001)) {
>
> Missing minmax.h.
>
> The second parameter is length of the range.
>
> > +                       dev_dbg(&indio_dev->dev,
> > +                               "span point ppm should be 1000~5000");
>
> The above range check doesn't agree with this message.

in_range() uses the range 'start <=3D val && val < (start + len)'.
So, to allow 5000, the 'len' should be 4001, not 4000.
I have tested this.
But would it be correct that I understand your point?

---

> > +                       return -EINVAL;
> > +               }
> > +
> > +               cmd =3D MHZ19B_SPAN_POINT_CMD;
> > +       } else
> > +               cmd =3D MHZ19B_ZERO_POINT_CMD;
>
> Have you run checkpatch? This needs {} per Coding Style.

Yes, checkpatch.pl didn't raise any warnings.
And after making the changes as you point out, there were no warnings eithe=
r.
It seems that checkpatch.pl allows both.
But for consistency, I'll add the { }.

---

> > +       dev_set_drvdata(dev, indio_dev);
>
> Is it really used?

Yes, this 'dev' is the same as '&serdev->dev'.
But I found 'serdev_device_set_drvdata()', so I'll change it to that.

--
Thanks,
Gyeyoung

