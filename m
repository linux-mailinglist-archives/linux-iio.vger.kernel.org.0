Return-Path: <linux-iio+bounces-23457-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F9EB3CB30
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 15:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F2B41BA4482
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 13:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99777223DD6;
	Sat, 30 Aug 2025 13:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6+Y8Hz8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B502144D7;
	Sat, 30 Aug 2025 13:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756560261; cv=none; b=QEmTrUAYmChyp9c213L3GesusYdiEIXhZitwFFP4PmQAnE1gz5cNrjVbq/T5K4pNMUH1zDjkfu15bPpMpwn6/Z1Tg1vFrFACqSFeEuYsbbkylS5vbvxpG/D5p5FKIBwRuBUHxNGR8is1sGn9i5PiYRObz5+PO4k72p6TAbs/BYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756560261; c=relaxed/simple;
	bh=v1S8PwCYxbPDEaSi9ebrVlh9Cc9cdjf1qti9Yi5A7ew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NtLeXnDQkimBQqbllj78qOzVLwi/pwWz8bb+KUdwxs1v9NtrgYm2IHPSRvpDgVTsQYvSVlpLVusHBkS2DSnFn9LWsT5oWfPk2Cdf8BnsEbg73i6KBzhMO6MoXu52JYymp08gb/hv/AVGZG0pneoo0oYHDiDnqEJQvvXhds0tuhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m6+Y8Hz8; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-55f6f7edf45so579220e87.2;
        Sat, 30 Aug 2025 06:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756560258; x=1757165058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WRR1X5lDkWRdj6f4lzCozikifP8gzwHC2QO/O204APA=;
        b=m6+Y8Hz8ZdktXjk0j2lNRznyUfhJszSCOp5oGBwM5ovJjp4HRRyxqFmJDOabZd4QL0
         79fYHJTVkzMa1apwvb8bvIJm37y7bp/HKFMYGj9GTMOJNOd8ioGYOe3Qb/T2+xngDXTR
         27B+1Qi9gVXMF/SHXKKejVyuynvwYUPzpDewAY6mcGCLna6lVzqO5NWSo8A4Zaq9OOYu
         uYPIvKZW92Iy3QV0B8E84xSOKq1jLb4M+CC1I+Z1s7xhXjt0u4xCUfMiKg7cB9rGi2qn
         y8g23GRFmjEUbogn0OXZe0ijlZryURC3XzlMLiD8sQxb8lvAtD3XXF045uv6rSEIS9cH
         7abg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756560258; x=1757165058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WRR1X5lDkWRdj6f4lzCozikifP8gzwHC2QO/O204APA=;
        b=GGqx/LoD3i+Dzo4PgJV11Zq53cl6wD2BwKYg9dnPOQbA28PwHcApysfegXri4Onq0g
         9fUC+T5OdvM8YHe4ZOM27UF4Mcsidko1wdkKXYUdoc3AEvDRAKAmQ7VCmhE1nwhNT/v2
         Qay8OJAyBTGRAgECLAcFGhgWa83nDRJK63nLK4sn5IyLrz2cp5zZLlgKp5P0SWJNdjSE
         JSbrRvxMGEBD7pR2CxD+N2812AoSC4/iYAQgCoqhW8EMFuM5XqYYnmAMLAuK7z3NVstF
         WxJT7HpFhsxabFT+BCJmj1HN4r3xVhqJldYb3heyuNwW34WHeRfTiIJQbRqBi8DUF8XD
         M0DQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPO43rzw8xvYV5a3rI87wHpRvAL5p+HIz5Si5x909dDeXURcBhRyuk2h9M8cd08QinuLnf3h5SYaXIjhgq@vger.kernel.org, AJvYcCWcDfSVQ524wWZaY6Bsnv9FZ/6BY+ZzpCUf0cT1Os9UOehkFpr43GBwQ9sPpsdIhJhxYaseSqPx9vE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHci4Z54yK7eqpWjhg1DHKIs+unv0KPzAWjhX1ZtKnTxH3hpfS
	LpWY0DDZMI4ybqx12BaGaXAh3ItwzHnY3bdwmJps6ZKOm8IuyoFXV4QIOSMMaw3ZVFVPqe/Pw/a
	yxMBrBoMVkAJHea8FSLr0ETPNE5tQMcT+EO3p
X-Gm-Gg: ASbGncuHMw8O5+uXVzfetJAxpfNvY6ln/jK/xbcSWl/kX/Np4J7sQGWr42otubohXQQ
	uzSd4ORqltqOyrTriLFw+f13fmcJn0bntI4iGh665dX55N1m1v1LhyywFuqHc/EX0QsAEME9EKi
	SEWZCEvlrFjOz0tTctmDg0OtOk4cIBVoKnO09aqMqq2p1tvvQQ93Ixyxkdavk7buoIeHJpB50gC
	S59IPqqueFTp5aypmslIEw/vD/d5lJwyWagOeu0M7YYIEEu0JPt
X-Google-Smtp-Source: AGHT+IHY+dztU/fvgeXUkQuh1oo2N8+Y4J1J9NKU3rw1ZWywfAgvZ/5f6SkE0cQZsiZzIzBuzWhFJOR/y/uQ38RTmKE=
X-Received: by 2002:a05:651c:50e:b0:336:bc68:d29c with SMTP id
 38308e7fff4ca-336ca910440mr4561671fa.3.1756560257355; Sat, 30 Aug 2025
 06:24:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250830113502.83102-1-akshayaj.lkd@gmail.com> <CAHp75Vc6J+Qm4hsV=PJn9Oyfn5xr9SZLGMagHm9NdFrkk9Y_5A@mail.gmail.com>
In-Reply-To: <CAHp75Vc6J+Qm4hsV=PJn9Oyfn5xr9SZLGMagHm9NdFrkk9Y_5A@mail.gmail.com>
From: Akshay Jindal <akshayaj.lkd@gmail.com>
Date: Sat, 30 Aug 2025 18:54:05 +0530
X-Gm-Features: Ac12FXw9iYlLGUmW6NRlKatRbg2atIdjgh0CQHtEvNtaZw_ZEHvUlOwAQzYs5Ug
Message-ID: <CAE3SzaSYLFFRL4OuqUbk8J0dWCuxedCyGiX2_tJySG1FC=w95g@mail.gmail.com>
Subject: Re: [PATCH v3] iio: light: ltr390: Implement runtime PM support
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: anshulusr@gmail.com, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, shuah@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the speedy review Andy. Follow-up inline.

On Sat, Aug 30, 2025 at 6:04=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Sat, Aug 30, 2025 at 2:35=E2=80=AFPM Akshay Jindal <akshayaj.lkd@gmail=
.com> wrote:
> > @@ -27,6 +27,7 @@
> >  #include <linux/module.h>
> >  #include <linux/mutex.h>
> >  #include <linux/regmap.h>
> > +#include <linux/pm_runtime.h>
>
> You missed my comment.
Yeah, this got missed. Will address this.

>
> > +static int ltr390_write_event_config(struct iio_dev *indio_dev,
> > +                               const struct iio_chan_spec *chan,
> > +                               enum iio_event_type type,
> > +                               enum iio_event_direction dir,
> > +                               bool state)
> > +{
> > +       int ret;
> > +       struct ltr390_data *data =3D iio_priv(indio_dev);
> > +       struct device *dev =3D &data->client->dev;
> > +
> > +       guard(mutex)(&data->lock);
> > +
> > +       if (state && !data->irq_enabled) {
> > +               ret =3D pm_runtime_resume_and_get(dev);
> > +               if (ret < 0) {
> > +                       dev_err(dev, "runtime PM failed to resume: %d\n=
", ret);
> > +                       return ret;
> > +               }
> > +               data->irq_enabled =3D true;
> > +       }
> > +
> > +       ret =3D __ltr390_write_event_config(indio_dev, chan, type, dir,=
 state);
> > +
> > +       if (!state && data->irq_enabled) {
> > +               data->irq_enabled =3D false;
> > +               pm_runtime_put_autosuspend(dev);
> > +       }
> > +
> > +       return ret;
> > +}
>
> This looks like overcomplicated and duplicate checks. Just make two
> functions with and without IRQ enabling handling.
>
LTR390 only supports 1 event/interrupt which is toggled in this callback ba=
sed
on value provided to sysfs entry. There cannot be a version of this without=
 IRQ
handling. It is supposed to do IRQ handling only.

Pseudo code of the said function will be something as follows:
ltr390_write_event_config() {
if (interrupt needs to be enabled && previously it was disabled)
     pm_runtime_resume_and_get()
do_actual_reg_writes()
if (interrupt needs to be disabled && previously it was enabled)
    pm_runtime_put_autosuspend().
}

With the current function , we achieve the following objectives:
1. idempotency in refcount change. Meaning if IRQ is already enabled and
if someone enables it again, it will not increase the refcount, same goes f=
or
double disable case. This has been tested as well.
2. Only if the new and previous config is different, then only the refcount=
 will
change.
3. Adheres to previous comments received regarding checking return value
of _get and ignoring that of _put.

I genuinely don't see any duplicate checks here. In addition, I feel the ab=
ove
function is fine from a simplification point of view and cannot be bifurcat=
ed
further.

Although, if you could clarify what you mean by further bifurcation, I migh=
t be
able to connect with your thoughts.

Thanks,
Akshay

