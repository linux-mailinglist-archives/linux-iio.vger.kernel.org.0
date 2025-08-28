Return-Path: <linux-iio+bounces-23331-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCDDB39135
	for <lists+linux-iio@lfdr.de>; Thu, 28 Aug 2025 03:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E9781C20629
	for <lists+linux-iio@lfdr.de>; Thu, 28 Aug 2025 01:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D654120A5F5;
	Thu, 28 Aug 2025 01:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6du+zkr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED49113AD38;
	Thu, 28 Aug 2025 01:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756345624; cv=none; b=I2DotD6alPq2taERFyr49xrFNTbBordIMs9Het25Q4SgGRuxT/BO0LC0gmkLefb2QPplaWvF9GxuOIkc7xgvVEXxqS41Zh+WDoTjoBrL9y2K1o/U5T2arHS+EpLU8CnbFV8DpWTnDxqy6WEL+1iv9UupB5a98tlXUoWYTxnG9dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756345624; c=relaxed/simple;
	bh=T3Hg7EkZ6uQPwluaTtifdRM5GO0GjWB3JbNKFIMFfGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QnRHY/K67jpPYLhIZU96K/6nRgEYyZmt01nbwSBHS9cJpYi5FUj3Z9NJGk77SwpiDCwZopUBhuUy5r86Y+ahKtr0gntMyO8Nluo31T2K8JA5uYG9U6H3oyaXqTckSy9TQcbGXM9YrJvm5BFRVymUGGtmiI2okIf+lusoZFxoht8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f6du+zkr; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afebe21a1a3so73999566b.0;
        Wed, 27 Aug 2025 18:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756345619; x=1756950419; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T1jv81u7FwRRFWZvkxOnlEnADmrXUleR+Epv3Fxj0S0=;
        b=f6du+zkrYL8jliSXAssmHUfgkbLc+VlNLkjDf7h/Kt2AJ2Mj5lt9U75Yh0JVwvoxjA
         cAQLf+l2/fwmQF8V3f/OOXfpYLpTrp8ILV3wWn4cNqjZlye4WJD2++WG5zv99b1WUwNv
         mwZa3QVDpfOFMQLCq33WHQNhcXKGAQH72Ut86/PpXkTC6uADYui0fCjOkrnyQljw6l6q
         OZja1QgIUXikfPp1RmZKUTL29vsqhMeSGxCx/xHRx2S+dSFd0Uqp6ePp+YkBHn6KKMVx
         VpAcIZlQvmBRDOlvplQJIL5gvy8ul/k3q6IwPk7LBeNZlNUBfr4E2RhZsIhvxDdb+18D
         MKLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756345619; x=1756950419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T1jv81u7FwRRFWZvkxOnlEnADmrXUleR+Epv3Fxj0S0=;
        b=fhLQqxuBRRIaf0bJ65ZxbTlk9N+aast6aHnwm/YLQ6Llysgl8CvIwEzvsUclCyxOEv
         poUN2m7TTM3hM05jbeQCD2ZsnDi5rUEzUjJf9c8i2ytilT96a0EeW5MU6gFlIegi6NR9
         rOhKcq8dMpFvG5i3MsMoKpu5JdjkUybRn1EC0g0tTrzA1E+1lj6QNclOvKTj+O8DZSfu
         qqr5gM4q2WtRrL1x6/ZGPO+T39HqSk0XLjX2QmspMypRSknrVlhSMyY7ev6poITrTJTU
         G3HUAn7VqpvAeo38IbEGJrJNsauDX6hbZ8cz5uMRns/lwHwcwXehadNupltlXNBerX7u
         kI6w==
X-Forwarded-Encrypted: i=1; AJvYcCVi3LfipUfuYc2suQvSnmOXXjsxvSQPdvuqCVGLmb9L8CVCnhFehbSBe70LFwx1X7ozJ3VxgsB0UnvPRSH5@vger.kernel.org, AJvYcCXfY735TlgL5k2N+b5DJlPhNIFbYFaI26tyE6FG7rV5UNZSGAz5JZ4bhjWkIb6JCnk9l+fMNH1WPIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZrKDT7VR8lFfKwVQqnJ3+kfELegVgUwa8MhYBlS8MiTByFQ6O
	eqwH8M9hYdUzCCBPtOqWoiQefEil6o2ytAjdzCiwxxeaPz5zIslAa/E/n3+qGwM/5pxa8UPy9Kq
	Av2yvaDALu1unYWpMpjISI4uHNHo70Fk=
X-Gm-Gg: ASbGncu7mKBFhbWEvkA95lCrFGnb/lwqdRZY6ihIhNV5WUMiCYwHABQfoz5RozJeY/n
	yTo8A9pW9Z4y2RkTrUmPXMdmFa2wpxzXXxeJU69Hs0OFbuvyUPTckA0suYyZw/nMTx5wUAjbnu3
	a+bADngvDxHYmYQ/aNEMe4TcKfXIFyG51HI5jqO5IqYJYYWmRgt/xADiJQ50vQ8CNO8302yO083
	QlXF7E=
X-Google-Smtp-Source: AGHT+IEmAQlLuP1pTqYq4q1D67AG6BOJMUGXrskQA/JI7zXTEbiF5N6PZMRRBbjIAeP2yZDJ2BbZ0xZYwDwBGFl29FU=
X-Received: by 2002:a17:907:7ba7:b0:afe:8ae2:a8fe with SMTP id
 a640c23a62f3a-afeafeca898mr806316166b.14.1756345619135; Wed, 27 Aug 2025
 18:46:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827191919.1361787-1-akshayaj.lkd@gmail.com>
In-Reply-To: <20250827191919.1361787-1-akshayaj.lkd@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 28 Aug 2025 04:46:22 +0300
X-Gm-Features: Ac12FXwc9apHvUznQas7uzoIbSF2GJjoh69nsBWoAlduNBQ-WlMxoaFB7tLoai4
Message-ID: <CAHp75VdQB673=qXBp0mPUHxQGxM=Z1CNSmEpP82OprVn++Y5uw@mail.gmail.com>
Subject: Re: [PATCH v2] iio: light: ltr390: Implement runtime PM support
To: Akshay Jindal <akshayaj.lkd@gmail.com>
Cc: anshulusr@gmail.com, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, shuah@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 10:19=E2=80=AFPM Akshay Jindal <akshayaj.lkd@gmail.=
com> wrote:
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

> -> Preserve the order of header file includes.

Seems needs more

...

> --- a/drivers/iio/light/ltr390.c
> +++ b/drivers/iio/light/ltr390.c
> @@ -27,6 +27,7 @@
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/regmap.h>
> +#include <linux/pm_runtime.h>

With the given context 'p' should be before 'r'.

...

> +static int ltr390_read_raw(struct iio_dev *iio_device,
> +                          struct iio_chan_spec const *chan, int *val,
> +                          int *val2, long mask)
> +{
> +       int ret, retval;
> +       struct ltr390_data *data =3D iio_priv(iio_device);
> +       struct device *dev =3D &data->client->dev;
> +
> +       ret =3D pm_runtime_resume_and_get(dev);
> +       if (ret < 0)
> +               dev_err(dev, "runtime PM failed to resume: %d\n", ret);

If it fails, there is no point to read the value, it will be garbage
or even can make the bus stuck.

> +       retval =3D __ltr390_read_raw(iio_device, chan, val, val2, mask);
> +
> +       ret =3D pm_runtime_put_autosuspend(dev);
> +       if (ret < 0)
> +               dev_err(dev, "runtime PM failed to autosuspend: %d\n", re=
t);

Taking into account the above, I do not see how this message is
useful. If we fail here, we can't do much about it, but printing a
message will exaggerate the logs.

> +       return retval;
> +}

...

> +static int ltr390_write_raw(struct iio_dev *indio_dev, struct iio_chan_s=
pec const *chan,
> +                       int val, int val2, long mask)

As per above.

...

> +static int ltr390_read_event_value(struct iio_dev *indio_dev,
> +                               const struct iio_chan_spec *chan,
> +                               enum iio_event_type type,
> +                               enum iio_event_direction dir,
> +                               enum iio_event_info info,
> +                               int *val, int *val2)

Ditto and so on...

--=20
With Best Regards,
Andy Shevchenko

