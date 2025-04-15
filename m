Return-Path: <linux-iio+bounces-18145-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E65E7A8A6F2
	for <lists+linux-iio@lfdr.de>; Tue, 15 Apr 2025 20:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAE00442FF4
	for <lists+linux-iio@lfdr.de>; Tue, 15 Apr 2025 18:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80EF622A4E7;
	Tue, 15 Apr 2025 18:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3YBn7OS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F50222568;
	Tue, 15 Apr 2025 18:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744742387; cv=none; b=IvHFVkGRlIQ+mt1at7ogzc/NcddLRi0sycT/kkir0whX+QMMe7pBdEDQsLNxX8neRwr0CjQFdwBK/FO3t7sUHNFsciiwMqqOnFUMK99ox3hAmryqbgefhIjkEY7gl4kxHeXRtv7Qmo+mxY8ov56Oqvn/Gth7gcN2MNlbZb9oXcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744742387; c=relaxed/simple;
	bh=qmJc2MyLlEUxcwBk5X+Clsm2SNsgozIxnrGPnZqoGcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GqYD9olAZDDzP9cEaAxH0CTePIeBSqj2hs5Yq6NSlMoKJQl8b+w5SX1oYvNsZaYG9UXqEVgMKm4R9lx4++DxPrCBXvX8i4EhvmWvsuZwTnm/exrMTIJRWtx4BpqIZM0lc6uzAgmjQbRjzIYPGz/Hjzz/IMmQHkQpCI+dkvBrXxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3YBn7OS; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e60cfef9cfso9727200a12.2;
        Tue, 15 Apr 2025 11:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744742383; x=1745347183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MuxD6d+TE3jsbY2UIjFJC1hqHPSQGHUKcYAlc4rVPHI=;
        b=M3YBn7OSyA/43jy/FZo9EAaSKw5ACjblMVSQ5nILIpZGr6c/Qtexw+y1j+mgJJBOL5
         rjhb30obhDQUAZ9kUAKePeTxoo2tl9sPzqr0AZAiR5Jn0TUTrqmZpTzGE8vKETsmY6sT
         5bjjhVi2HK3mRO2+z0u8bl7AWCnNlRh2XzMycYUzXetLo7X9I/un6wkbWOS1lTPTIoT3
         Ni+pDeLB5OplfVTx80YfhGadGDRu69WjJBjCbSezIgMVEKyV+x5uHlQyMBgziXRAA8hK
         eK6PnUuhRbwarxh+++1MGz0M0z+54An4ygYE7gUQQnRWXE/Rb4IQ7CuvUckov9zSmDE9
         6e9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744742383; x=1745347183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MuxD6d+TE3jsbY2UIjFJC1hqHPSQGHUKcYAlc4rVPHI=;
        b=eBSGDNBaje23ziKaxNHzrlKmqsdtG004G3hcMVBo4Qb+z7cYxIXNb9cQcsnDfdNDt8
         xlpInc9xwJN9RmslIqxfdQsSdNA4ND/h/rd5i818XO6ZSVFb9jf9j0LBMNMoVaTe2Lqj
         COZBS8qVfN+Ppw0okdbWIH9MPTAIfvn39RKxNFvSz8Kab6eSb4EPMZYP0paYLjqEXSBh
         WO6sBeDgLZCDQsxm1Wlxp7+AItT1D193YAz2v9FdKEY2eCiJRKoFdpp8Dl50dX6H3plo
         wJFV1mmHzSKWfYV3o8lii2ilb20No1XA8cCC+zKOQkC6tANAjv1H0YkqpQqeFWEEFNXM
         WhLg==
X-Forwarded-Encrypted: i=1; AJvYcCWFNBZy+fAo6P3rAaEIMhxkMNyJrAvMctnEI1PDAN5zH1H6LTTFsDkU61Z5oerRzEX1ugyCKRqrSBuaXM8B@vger.kernel.org, AJvYcCWr+MhctU7LPnatGAj/CXjVNVisDmLEgB6BxTVVB/oDn59Pip6mfiMXu6eaCHqfQH3T1H82ud8fFg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgS6laAb4Yg7iXVAwL4DLtZZT+LeCxEE70qYGGoHP3HtKxO12j
	ghH0t2IOJclcoCkkhEly3tLfua4GAd5sDB1pnXKSXs64LXFW/pjpoogB6dcUalCU6c795FpkniC
	DjDK3tFyflwSgW4Ax5G26CK6Xjbk=
X-Gm-Gg: ASbGncu/QptNgsb/fWrhcF35MOJzkz/VrbaWK2jUbIif+Uf8aAlyULOQwTzZpVUYjJA
	Pjw+eM4Hs5i1yv2Bg2KblprFk9Hz5Zs489clMVde73WQ+thnnSMnRFRb9+dctjkKbrJbZT6lYBl
	/Ivv2bSIBKCbyEJQzBwOFsKA==
X-Google-Smtp-Source: AGHT+IEisiwVczW2Sf8mkqkbd1qMc0N+ZCObtgQq+MjEOc6IRfS8cIH59uCiLcWPYmA3XlAX9I6cpJIhvMKb7CtM6QM=
X-Received: by 2002:a17:907:7f8b:b0:ac7:ed27:974 with SMTP id
 a640c23a62f3a-acb3826464amr11355366b.20.1744742382684; Tue, 15 Apr 2025
 11:39:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250415-losd-3-inv-icm42600-add-wom-support-v2-0-de94dfb92b7e@tdk.com>
 <20250415-losd-3-inv-icm42600-add-wom-support-v2-2-de94dfb92b7e@tdk.com>
In-Reply-To: <20250415-losd-3-inv-icm42600-add-wom-support-v2-2-de94dfb92b7e@tdk.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 15 Apr 2025 21:39:06 +0300
X-Gm-Features: ATxdqUECvbr-Dz-xvlev5FJ7fdhC999j7ns3HMlVrNdQB14LcWiptXGSsn4Npnw
Message-ID: <CAHp75VcgEJaWRPCGV1NOUKd1Kxw90=cyMT6d4mcRvQSWJ99RUg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: imu: inv_icm42600: add wakeup functionality
 for Wake-on-Motion
To: jean-baptiste.maneyrol@tdk.com
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2025 at 5:47=E2=80=AFPM Jean-Baptiste Maneyrol via B4 Relay
<devnull+jean-baptiste.maneyrol.tdk.com@kernel.org> wrote:
>
> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
>
> When Wake-on-Motion is on, enable system wakeup and keep chip on for

keep the chip

> waking up system with interrupt.

up the system
with an interrupt.




> +       /* keep chip on and wake-up capable if APEX and wakeup on */
> +       accel_dev =3D &st->indio_accel->dev;
> +       wakeup =3D (st->apex.on && device_may_wakeup(accel_dev)) ? true :=
 false;

Redundant ternary.

> +

This blank line should be rather after the accel_dev =3D ... line.

> +       if (!wakeup) {

Can we use positive conditionals? Generally they are easier to read.

> +               /* disable APEX features and accel if wakeup disabled */
> +               if (st->apex.wom.enable) {
> +                       ret =3D inv_icm42600_disable_wom(st);
> +                       if (ret)
> +                               goto out_unlock;
> +               }
> +               accel_conf =3D INV_ICM42600_SENSOR_MODE_OFF;
> +       } else {
> +               /* keep accel on and setup irq for wakeup */
> +               accel_conf =3D st->conf.accel.mode;
> +               enable_irq_wake(st->irq);
> +               disable_irq(st->irq);
>         }

...

> +       /* check wakeup capability */
> +       accel_dev =3D &st->indio_accel->dev;
> +       wakeup =3D (st->apex.on && device_may_wakeup(accel_dev)) ? true :=
 false;
> +
> +       /* restore vddio if cut off or irq state */
> +       if (!wakeup) {

Same comments as per above.

> +               ret =3D inv_icm42600_enable_regulator_vddio(st);
> +               if (ret)
> +                       goto out_unlock;
> +       } else {
> +               enable_irq(st->irq);
> +               disable_irq_wake(st->irq);
> +       }

...

> +       /* restore APEX features if disabled */
> +       if (!wakeup) {
> +               if (st->apex.wom.enable) {

This is effectively if (foo && bar).

> +                       ret =3D inv_icm42600_enable_wom(st);
> +                       if (ret)
> +                               goto out_unlock;
> +               }
>         }

...

> @@ -924,6 +955,8 @@ static int inv_icm42600_resume(struct device *dev)
>                 inv_sensors_timestamp_reset(&accel_st->ts);
>                 ret =3D regmap_write(st->map, INV_ICM42600_REG_FIFO_CONFI=
G,
>                                    INV_ICM42600_FIFO_CONFIG_STREAM);
> +               if (ret)
> +                       goto out_unlock;
>         }

>  out_unlock:

Stray / unneeded change.

--=20
With Best Regards,
Andy Shevchenko

