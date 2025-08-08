Return-Path: <linux-iio+bounces-22485-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18128B1F073
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 23:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 284685A42A6
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 21:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427B128A72A;
	Fri,  8 Aug 2025 21:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2nTL4j8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC9A28A714;
	Fri,  8 Aug 2025 21:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754689996; cv=none; b=j5TZrIsVKpxiMQjDz/IUhwCkdG83OZ5ynuGfHrcwJvpEhYiBwUjUCq57B13AvnFuZA4ikiIHEPcJ/dxasxCTKszaD37Y1Il1g52fnDPHbX8xw6USVXh8VZ0/bMnFycfHMAiai6+dR/uq1vhvmbfgc/QyqN2mi6cqiDkBMzZ/4VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754689996; c=relaxed/simple;
	bh=FHdoU4mNeEPmLoDZXwy3/cdEdLB/1Dkosg+2BYHMKn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=seVb48lRS2x4M4OKR0s+/8/ANnYjjm7A2+PoC15F0PeGGCkxogvSJFynjjEhZjX3EbqK3BCpt7zMkvWK/TW18SrccVdCQouIufKPjNGQehyFaTFD0kpe+4ThRUwwa+/xR7RjfQladSWsX1hW/Hc1M6aOVdWpAlukCya//afCMck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I2nTL4j8; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-af93150f7c2so399375066b.3;
        Fri, 08 Aug 2025 14:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754689992; x=1755294792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E2GN7W7Sz7gEboNuVXd3lEPoXXlYWcnFTU1ztKD3RZk=;
        b=I2nTL4j8gCdVzWvR4DVkRUR2we563kAUu/EvIk5z+dvPtOPcoz1N4ORgpHjWCuBvWS
         k6cZyCBHBonZKqVTPDsQCT00P+pRKaUJgQis/0C2mnFnlxVWjuWCjrpjJBpKsx8urj2X
         BIilYc0fs/1w/bHHi0zeh1+jBiRMV3loTkAQrGGiiXg33Pd78A8zaqgorA4FT3nQOaa1
         cL/5pKVhlQLQ71Y/dcBOFKWQXKeDwhnQPcGd8J1FE8aeCCyiBEGeE2T84xctaaY4IL4K
         OVzEAxX+5OgJGtvGAPszE+IDVdPHABVHvTyw5MksqhdjdvSY5HkICsAGuuEMudqvh3Am
         hISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754689992; x=1755294792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E2GN7W7Sz7gEboNuVXd3lEPoXXlYWcnFTU1ztKD3RZk=;
        b=F7ruHVmU7SrmLhS1aD151D6DVq7w9Zhq3yXF5Bhb0F58yOshCKNcliDP8KH/gbyk0j
         vCgY/z4DJscdZSRBa54x+9m+gRCpbSL6ftQFUY2UPEQBLMim0tbxQxdcilIIXQjVd96G
         fvEW7Ub2g8BE9pkY5/6okXaNAZ5s97JYyjUNWYNktSMEmOvxx7vUjNKcaLjc9wapVZBh
         n2WG1K25WvqOeYkiW6Ew5rZ2dLWjG5jnisJAad47ldc3iyi7930rS9xM5RSZtESDbV+Z
         NVePMgWdYPNxmcRjy34KUSKDslfX3B+kNwlPfH9rd7oxx5Q86kw8o5rdZG94wtUhiu6P
         ugjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNoB6z+MMX1rAKNnvLT0eBNsRfZpiiWElzlsR2yj7jicR2JdqrDyBTbaDlckt6aOfqGUZZGrONA+e6mkv5@vger.kernel.org, AJvYcCWztz3tZzVpalwCtaE0y6Is5oz0G/m1EtetTrHGoqi6mxwxgS0NqPkhZLMG4AK/KNlu5DkhrSWGleQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9t8APNqtBjGOz+ea6CTwVGt+iSQl6tF50rbTx1hQGPIRFvKwH
	3Cqu1XjAAsgmbQzf6ekq4tt6jG3liwMUACGP8HO6hcXwzknYXct1mRGM0VK6/rNSTlAkzkspVB2
	d4S74keF1BYne1W0SuanmWVo23Fl/n4k=
X-Gm-Gg: ASbGncusybtge4jn10SQ2xIgBOaw/QXt30oENSXtK7NvAcRDSF7BHq7DzKbIYdyS8F2
	7Vbm8jR2jEpY1ovVyyPlcZtTHHoGbYwvQxkKIYw1dgOzrlBJ7Ojt+xqpJTuX+QJ43rA4QAiaNeM
	8GX7qxL8Whq+ok3ZjfvpD3R6Shx5sB4AF8VOfm/frXR9KplmFxeT0Rjk6nbSMf7mi0dKoSGN9mr
	yDI0Cb8yA==
X-Google-Smtp-Source: AGHT+IEX9iv8bZjifqSIW6eXeKVomU13zNO5NsGsWmF335itG5QWaqkagb+K3LBMo9DYi9YczpXRUgw7iHwyOT80QcY=
X-Received: by 2002:a17:907:3f94:b0:af9:29c1:1103 with SMTP id
 a640c23a62f3a-af9c6591347mr419188566b.55.1754689992421; Fri, 08 Aug 2025
 14:53:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250808-icm42pmreg-v2-0-a480279e7721@geanix.com> <20250808-icm42pmreg-v2-5-a480279e7721@geanix.com>
In-Reply-To: <20250808-icm42pmreg-v2-5-a480279e7721@geanix.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 8 Aug 2025 23:52:35 +0200
X-Gm-Features: Ac12FXxKpxuO8YMoYbsgDqhalk0UzbXLJ0r5sG70xlV3YnQfZtwgOelFnshdeEI
Message-ID: <CAHp75VeA36CHbvmhHVesw3itRW0aGURTqCJPAtw_P=q12F_0Yw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] iio: imu: inv_icm42600: use guard() to release mutexes
To: Sean Nyekjaer <sean@geanix.com>
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 5:58=E2=80=AFPM Sean Nyekjaer <sean@geanix.com> wrot=
e:
>
> Replace explicit mutex_lock() and mutex_unlock() with the guard() macro
> for cleaner and safer mutex handling.

...

>         pm_runtime_get_sync(dev);
> -       mutex_lock(&st->lock);
> +       guard(mutex)(&st->lock);
>
>         ret =3D inv_icm42600_set_accel_conf(st, &conf, NULL);
>
> -       mutex_unlock(&st->lock);
>         pm_runtime_mark_last_busy(dev);
>         pm_runtime_put_autosuspend(dev);

This makes PM calls under the mutex. In some cases it may lead to deadlocks=
.
I think you wanted to use scoped_guard() here and in similar cases.

...

>         struct inv_icm42600_state *st =3D iio_device_get_drvdata(indio_de=
v);
>         int ret;
>
> -       mutex_lock(&st->lock);
> +       guard(mutex)(&st->lock);
>
>         st->fifo.watermark.accel =3D val;
>         ret =3D inv_icm42600_buffer_update_watermark(st);
>
> -       mutex_unlock(&st->lock);
> -
>         return ret;

Now remove ret and use return directly.

>  }

> -       mutex_lock(&st->lock);
> +       guard(mutex)(&st->lock);
>
>         ret =3D inv_icm42600_buffer_hwfifo_flush(st, count);
>         if (!ret)
>                 ret =3D st->fifo.nb.accel;
>
> -       mutex_unlock(&st->lock);
> -
>         return ret;

In the similar way as above.

ret =3D _flush();
if (ret)
  return ret;

return ...nb.accel;

...

>         struct inv_icm42600_state *st =3D iio_device_get_drvdata(indio_de=
v);

>         int ret;

Now unneeded, just return directly.

> -       mutex_lock(&st->lock);
> +       guard(mutex)(&st->lock);
>
>         if (readval)
>                 ret =3D regmap_read(st->map, reg, readval);
>         else
>                 ret =3D regmap_write(st->map, reg, writeval);
>
> -       mutex_unlock(&st->lock);
> -
>         return ret;

...

>         int ret =3D 0;

Now unneeded assignment.

> -       mutex_lock(&st->lock);
> +       guard(mutex)(&st->lock);
>
>         st->suspended.gyro =3D st->conf.gyro.mode;
>         st->suspended.accel =3D st->conf.accel.mode;
>         st->suspended.temp =3D st->conf.temp_en;
> -       if (pm_runtime_suspended(dev))
> -               goto out_unlock;
> +       ret =3D pm_runtime_suspended(dev);
> +       if (ret)
> +               return ret;

...

>         /* disable vddio regulator if chip is sleeping */
>         if (!wakeup)
>                 regulator_disable(st->vddio_supply);
>
> -out_unlock:
> -       mutex_unlock(&st->lock);
>         return ret;

Now return 0 to make it clear that this is a success.

...

> @@ -881,10 +878,11 @@ static int inv_icm42600_resume(struct device *dev)
>         bool wakeup;
>         int ret =3D 0;

Assignment is useless now.

> -       mutex_lock(&st->lock);
> +       guard(mutex)(&st->lock);
>
> -       if (pm_runtime_suspended(dev))
> -               goto out_unlock;
> +       ret =3D pm_runtime_suspended(dev);
> +       if (ret)
> +               return ret;

...

> -out_unlock:
> -       mutex_unlock(&st->lock);
>         return ret;

  return 0;

?

...

>         regulator_disable(st->vddio_supply);
>
> -error_unlock:
> -       mutex_unlock(&st->lock);
>         return ret;

Ditto.

>  }

...

>         int ret;

Now useless variable.

>
> -       mutex_lock(&st->lock);
> +       guard(mutex)(&st->lock);
>
>         ret =3D inv_icm42600_enable_regulator_vddio(st);
>
> -       mutex_unlock(&st->lock);
>         return ret;
>  }

...

>         int ret;

Ditto.

> -       mutex_lock(&st->lock);
> +       guard(mutex)(&st->lock);
>
>         st->fifo.watermark.gyro =3D val;
>         ret =3D inv_icm42600_buffer_update_watermark(st);
>
> -       mutex_unlock(&st->lock);
> -
>         return ret;
>  }

...

> -       mutex_lock(&st->lock);
> +       guard(mutex)(&st->lock);
>
>         ret =3D inv_icm42600_buffer_hwfifo_flush(st, count);
>         if (!ret)
>                 ret =3D st->fifo.nb.gyro;

Invert conditional and return ret directly.

> -       mutex_unlock(&st->lock);
> -
>         return ret;

--=20
With Best Regards,
Andy Shevchenko

