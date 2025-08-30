Return-Path: <linux-iio+bounces-23449-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95856B3CACA
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 14:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46A455E3A75
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 12:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8345263F30;
	Sat, 30 Aug 2025 12:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knpTJdh5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078231E515;
	Sat, 30 Aug 2025 12:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756557286; cv=none; b=e3grWsI6ozE7MU1oiq6VlRdcDCcT4XWipfKzg388kZPAj8DXBaLWtSs9C9LPmY3ki2NX2TgjURwSracZEoNmCbft9x7pqBzqO72ZNF8tkreD1aVk9w++LycBv9UnzlEmXzCNb6DILUTB3Dp2qM851kaHTN7XbkOKlCkO/5CIYDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756557286; c=relaxed/simple;
	bh=8QZ5WleGamk0PZPLdUEYji9bBabTYG9jnWSYpwfibbM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GyK2a2+dv9VFG50wroqtpGxpnb6oXRb01pPWgLq1/MTZXMyAaxT5nQMvganRnuXBRVcNpWj/VQ0i8gy90Z9nZZBN1VdW3NmpsuF2msS/0PDT72Rq5aKmRybeQX0j3rIlQESxloLKYJjgUDbQ7gb42Eg4VtcMYNeTxIls+UmodT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=knpTJdh5; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afcb78f5df4so503336266b.1;
        Sat, 30 Aug 2025 05:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756557283; x=1757162083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+abr0qykghD8v4nhgSo8eF00Ahn8gixG2++eX7mtOkI=;
        b=knpTJdh5Bx/dJtm61twAH90m1lgnL6eP7eEVS7W78V2aEulnJIUbAd1pPc/fh2l25c
         GJZuQI7K1PAw4wAJSGRXSLeeilnG9+QNeXpeGsGz76SJb50A46+3Hgp5+WmbbcCCSkMI
         DwJl45nFC3ut7FcidTf5s4pvXTSIuqAx+PDwL5OT/nDpZHcQBWVAy+84+QZLgMKAjVmc
         urJtbxxLpwpJcxONK5207sECLgQMt+cJAVwan359qAd86hpNw87sV89A/fI6VSrCcRc9
         y1RRfMKMrcvVcK+MSAnbfylx8dlSLjUevPO0Dho51VYN30eaURnZ6sNV7OAsSQJbNr99
         uKwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756557283; x=1757162083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+abr0qykghD8v4nhgSo8eF00Ahn8gixG2++eX7mtOkI=;
        b=ES1I8sVzI2sxzcxTnToGEu4SAurZN+6GtvFu43ayN9tSh6P9TI6wIb11kIUNz5nzjt
         qXRtAIN9zI27Im6NJjUWpzPKuNimCjyta+aogPlFWXOVGHPL6pqh6sb6VQdj3Bq+j3lY
         LFxZ0hOQSrBifrwpJ4EejLJ7v/5uQ4vLzFSjhS4HOe359skDaxHu2Fc8EqKOxI+zSbNA
         0YPYkr394emT+CogHpwx4qUYwNdbpA4tWdApR0xtZsfM37QrJ1TmEKdRBq2T1tbP3fQU
         DUMQ7brTQ9TyZHZy7DYjt7oIucpQxPXit/rdYdBJNDnykmNlnB451KKy5iRj7i3J2yPV
         U7sw==
X-Forwarded-Encrypted: i=1; AJvYcCUfXoS2aex7p+4ZmyqDqiJ4QgiqVGK/bRyx46ftjPKz0+8LGeO1Li+11zk4pTazGwHpDOsUx0fNZnVV6Cad@vger.kernel.org, AJvYcCW2HFczUlJwrrc/mSPgoKCj1PvfRk9W7WmkbziJyTlatts6Y7+pijYF9AwijtPOY+KmDOh/KFIQrrs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRMfgbtPkrfJC6PQPx+cfKKNOJekbMcW+s+XRSF0xyfWeSji6A
	tv28ma65lRQ8+Fzsz2zApB7cQElxzSwQSsSXCzdsupDBrEb1BQyFLgI1XxbqCrrQJziUHWrNwQl
	g9CQK+HmkWmLrjYGKm7EYu8mIOvYftHN0uNlXDl4=
X-Gm-Gg: ASbGncvEWzKUvqEKbp5NqdfG/xvkYZGEkVqkDwCmokjBHlSDV/rJqTCMjtFrWqQbiII
	jcuNrMQQdrKRkrMHtfGieLQ8eGKRDRk+52I++uQSV3Ymkw8G/gWsIuaRnZ9MVWpmV+W9irPV2UN
	OS2BhT+hR0nUpRagt0AIsPGsHnmAnA3P5HNZYMC31JKLFu83F+yBXEtkdqbbsaYgbm3xAn0tKKa
	uW4dMI=
X-Google-Smtp-Source: AGHT+IGLwDqWzxeGxCyb0bVX5x39+aDihKdFtoZMOSgD8NWedYUMpGJY5U9ver7LESKb+qZTABZU1m0cIHpJ/p40Q6I=
X-Received: by 2002:a17:907:9444:b0:afe:b2a5:c1ce with SMTP id
 a640c23a62f3a-b01d974bd87mr161053566b.35.1756557283073; Sat, 30 Aug 2025
 05:34:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250830113502.83102-1-akshayaj.lkd@gmail.com>
In-Reply-To: <20250830113502.83102-1-akshayaj.lkd@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 30 Aug 2025 15:34:06 +0300
X-Gm-Features: Ac12FXw-d0vq0T7-hzZTELUrhm7OtoI4meXl80JovbtYoi5DCSkR6TxMllJ-Y64
Message-ID: <CAHp75Vc6J+Qm4hsV=PJn9Oyfn5xr9SZLGMagHm9NdFrkk9Y_5A@mail.gmail.com>
Subject: Re: [PATCH v3] iio: light: ltr390: Implement runtime PM support
To: Akshay Jindal <akshayaj.lkd@gmail.com>
Cc: anshulusr@gmail.com, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, shuah@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 30, 2025 at 2:35=E2=80=AFPM Akshay Jindal <akshayaj.lkd@gmail.c=
om> wrote:
>
> Implement runtime power management for the LTR390 sensor. The device
> autosuspends after 1s of idle time, reducing current consumption from
> 100 =C2=B5A in active mode to 1 =C2=B5A in standby mode as per the datash=
eet.
>
> Ensure that interrupts continue to be delivered with runtime PM.
> Since the LTR390 cannot be used as a wakeup source during runtime
> suspend, therefore increment the runtime PM refcount when enabling
> events and decrement it when disabling events or powering down.
> This prevents event loss while still allowing power savings when IRQs
> are unused.

...

> Changes since v2:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 1. Andy's feedback:
> -> Check return value of pm_runtime_resume_and_get().
> -> Do not check return value of pm_runtime_put_autosuspend().
>
> 2. Set data->irq_enabled =3D true after checking return value of pm_runti=
me_resume_and_get() only.
>
> Changes since v1:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 1. Andy's feedback:
> -> Refactor iio_info callbacks.

> -> Preserve the order of header file includes.

You missed my comment. This has not been addressed yet.

> -> Avoid redundant usage of pm_runtime_mark_last_busy.
> -> Dissolve the ltr390_set_power_state(data, [true|false]) function.
> -> Avoid macro usage which is internal to header file.
> -> Update changelog with reason of not using wakeup as a source
> capability.

...

> @@ -27,6 +27,7 @@
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/regmap.h>
> +#include <linux/pm_runtime.h>

You missed my comment.

...

>  static int ltr390_read_event_config(struct iio_dev *indio_dev,
>                                 const struct iio_chan_spec *chan,
>                                 enum iio_event_type type,
>                                 enum iio_event_direction dir)
>  {
>         struct ltr390_data *data =3D iio_priv(indio_dev);
> +       struct device *dev =3D &data->client->dev;
>         int ret, status;
>
> +       ret =3D pm_runtime_resume_and_get(dev);
> +       if (ret < 0) {
> +               dev_err(dev, "runtime PM failed to resume: %d\n", ret);
> +               return ret;
> +       }
> +
>         ret =3D regmap_read(data->regmap, LTR390_INT_CFG, &status);
> +
> +       pm_runtime_put_autosuspend(dev);

>         if (ret < 0)
>                 return ret;
> -
>         return FIELD_GET(LTR390_LS_INT_EN, status);

Stray '-' line.

>  }

...

> +static int ltr390_write_event_config(struct iio_dev *indio_dev,
> +                               const struct iio_chan_spec *chan,
> +                               enum iio_event_type type,
> +                               enum iio_event_direction dir,
> +                               bool state)
> +{
> +       int ret;
> +       struct ltr390_data *data =3D iio_priv(indio_dev);
> +       struct device *dev =3D &data->client->dev;
> +
> +       guard(mutex)(&data->lock);
> +
> +       if (state && !data->irq_enabled) {
> +               ret =3D pm_runtime_resume_and_get(dev);
> +               if (ret < 0) {
> +                       dev_err(dev, "runtime PM failed to resume: %d\n",=
 ret);
> +                       return ret;
> +               }
> +               data->irq_enabled =3D true;
> +       }
> +
> +       ret =3D __ltr390_write_event_config(indio_dev, chan, type, dir, s=
tate);
> +
> +       if (!state && data->irq_enabled) {
> +               data->irq_enabled =3D false;
> +               pm_runtime_put_autosuspend(dev);
> +       }
> +
> +       return ret;
> +}

This looks like overcomplicated and duplicate checks. Just make two
functions with and without IRQ enabling handling.

--=20
With Best Regards,
Andy Shevchenko

