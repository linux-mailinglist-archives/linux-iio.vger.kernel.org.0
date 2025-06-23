Return-Path: <linux-iio+bounces-20932-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 656D9AE578C
	for <lists+linux-iio@lfdr.de>; Tue, 24 Jun 2025 00:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CBF11895D41
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 22:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E25A228CB8;
	Mon, 23 Jun 2025 22:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Y0bC4H9B"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272FB225792
	for <linux-iio@vger.kernel.org>; Mon, 23 Jun 2025 22:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750718696; cv=none; b=eN5PO9Wvcy9I0cr+CtknCwVxaoGZcq9ghR9N3otm5P5aFhXHbik0E8mmDmQ7qoSrqAelQHCykpNGV3tD8Z/iJpvhGsIXMSsO4y0Vm9wCynHbuzks6jJIJajd6lunOFyHxWN7ewJLleObiONHJBxGGbCyHWcjmiZNIo2BwoNIqHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750718696; c=relaxed/simple;
	bh=a5yUtzR8aIYejA5AasM5DgMoIvDkY3cOad1ESXk059c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ajs3gJTx5ZgwS+8CirKDuRLJxNOsMCHFikYmMgg5+4MhJ+CPFgFaQiRIQthJAvYZXl0SQ1NoHZARv1n3j4DnHngOeisJzXryg4wiQsn0iBG99fySqCwrjkzS+4UzIlJwwc8zXL/iTDBfQfGYmJoxRZVj8qgb+4D3rUouSerecMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Y0bC4H9B; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-32b7fd20f99so49302821fa.0
        for <linux-iio@vger.kernel.org>; Mon, 23 Jun 2025 15:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1750718692; x=1751323492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BsZod9XeehDSe+a5i5dEhZqfmDuleKr3HZqeh2BVFUw=;
        b=Y0bC4H9Biwyghs1nA2kv5P11/jXFekPBAFzZ/5VOkGsj1eHcmMty5bPBUzJBKVZPvM
         /kIZ0mQnAP8Q7MPIokBSv39KtD2vAjpW/sGu7rAnhJ5XiCT1mP+t5p5WI6Qbky8bWXsY
         QO1CHcDIHGp9B7qK/4Gb9+oPvv3rm4VsgE2r2y8hN7LpxNp6gftjsvElqw7MCKQtWCae
         lOauGt0S5VqHMZlin4d0DFIuE9lSWL+Mhd++Yx+N8IXVkyUr5xi06FZec569h8wnynjh
         dMT/cCliZ1ttHiS+z3cuUPi9L4SIU9d0r7bxMveE9Cm9vuWqpg0uH6PWz7BlVW6d+Xty
         CN8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750718692; x=1751323492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BsZod9XeehDSe+a5i5dEhZqfmDuleKr3HZqeh2BVFUw=;
        b=w5oam/YVrngfahvcZHNm4ewm8DOZ9JvfnL8LpL0nwXM9jIuMaK/as0E98K1/6K70p3
         6n9SLqAdOn8qvOrxg8+Xf14GK0Wwe4kleJzjwaERQhXiC/0seuY6fyXQxpGU+t/442ZH
         WCVi6czqhOdhziPqyV7OaC8KSTaWvJd5fX/ehTx7FGCRPFsHZFvsk48dxqBsySXWygIk
         QYYaSRyQt6aFxS7ZbkpfAjqvJ/MWZF6CTD3ze4nS635zrBq7YP55ERIrsfCsQRAXchad
         VmV/47oO5GKpZxibj0dJ760xvEE02sBB5N4Okb0vxsMBiM2qcQWinM5+lq3GUPeamlEe
         PqJg==
X-Forwarded-Encrypted: i=1; AJvYcCV2f1t9S1YvYCPYDUi13AQT3TzrIoOvcLYmQhbK8KOeScGP54BxK96mD8m93glALstCjHfFXc+ljG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCfUTgd5YqHiAMrB1WEbuRVxWOzzKSxV7V3OcNJOp6QtMo3YzD
	BALHnx8yq5rL+pGmQzcULqncSp+JGqmm+dbqMEiKO20+5iVmjdQ6Bhpn12Mmf6DPzM3o+uJwuzt
	z1DYxPY1D5rq82BYbfqT61mOb3EDPHoh5PCSCzC18gw==
X-Gm-Gg: ASbGncvZA7HLSos7vnC7vUFuvsPcoEC6aHafl3OBfshA3QCrbIZfZJk9qdkDtzhhDoB
	sBjv8XxLxWxK+8/KD2OGCNbaJEGsTj21jwT/VtCiKhRIbQad0UA1VsLaPVExzwMmj1P7ZOgTxMr
	fPHfbFZfVOBE6HsYylx9XO3LjhsFgdRTqtHZKmEVjKWx7q
X-Google-Smtp-Source: AGHT+IFEv/RGHeBCLRnW1DXwkC+VJSgGLx7prppFBg88rivJWosk723ecnxZL7IbB4HR3d0OB8US84nKea08bmcjAKg=
X-Received: by 2002:a2e:beac:0:b0:329:1712:c38d with SMTP id
 38308e7fff4ca-32cb95b50a6mr3638601fa.5.1750718691946; Mon, 23 Jun 2025
 15:44:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623-losd-3-inv-icm42600-add-wom-support-v5-0-4b3b33e028fe@tdk.com>
 <20250623-losd-3-inv-icm42600-add-wom-support-v5-2-4b3b33e028fe@tdk.com>
In-Reply-To: <20250623-losd-3-inv-icm42600-add-wom-support-v5-2-4b3b33e028fe@tdk.com>
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 23 Jun 2025 16:44:41 -0600
X-Gm-Features: AX0GCFsuSsTxw0IHWVuoRFxoAWC28ru0cW0dczEUfiobRKwGF-pHyUXB99AbMh0
Message-ID: <CAMknhBHaSBF-a9nLZ0ZxB2-9HzYkPMBqUr4Aa4TthNnJMwtFgg@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] iio: imu: inv_icm42600: add WoM support
To: jean-baptiste.maneyrol@tdk.com
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 6:56=E2=80=AFAM Jean-Baptiste Maneyrol via B4 Relay
<devnull+jean-baptiste.maneyrol.tdk.com@kernel.org> wrote:
>
> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
>
> Add WoM as accel roc rising x|y|z event.
>

...

> +static int inv_icm42600_accel_enable_wom(struct iio_dev *indio_dev)
> +{
> +       struct inv_icm42600_state *st =3D iio_device_get_drvdata(indio_de=
v);
> +       struct inv_icm42600_sensor_state *accel_st =3D iio_priv(indio_dev=
);
> +       struct device *pdev =3D regmap_get_device(st->map);
> +       struct inv_icm42600_sensor_conf conf =3D INV_ICM42600_SENSOR_CONF=
_INIT;
> +       unsigned int sleep_ms =3D 0;
> +       int ret;
> +
> +       ret =3D pm_runtime_resume_and_get(pdev);
> +       if (ret)
> +               return ret;
> +
> +       scoped_guard(mutex, &st->lock) {
> +               /* turn on accel sensor */
> +               conf.mode =3D accel_st->power_mode;
> +               conf.filter =3D accel_st->filter;
> +               ret =3D inv_icm42600_set_accel_conf(st, &conf, &sleep_ms)=
;
> +       }
> +       if (ret)
> +               goto error_suspend;
> +       if (sleep_ms)
> +               msleep(sleep_ms);
> +
> +       scoped_guard(mutex, &st->lock) {
> +               ret =3D inv_icm42600_enable_wom(st);
> +               if (ret)
> +                       break;

I reviewed this from the bottom up, so see comments on similar code below.

> +               st->apex.on++;
> +               st->apex.wom.enable =3D true;
> +       }
> +       if (ret)
> +               goto error_suspend;
> +
> +       return 0;
> +
> +error_suspend:
> +       pm_runtime_mark_last_busy(pdev);
> +       pm_runtime_put_autosuspend(pdev);
> +       return ret;
> +}
> +
> +static int inv_icm42600_accel_disable_wom(struct iio_dev *indio_dev)
> +{
> +       struct inv_icm42600_state *st =3D iio_device_get_drvdata(indio_de=
v);
> +       struct device *pdev =3D regmap_get_device(st->map);
> +       struct inv_icm42600_sensor_conf conf =3D INV_ICM42600_SENSOR_CONF=
_INIT;
> +       unsigned int sleep_ms =3D 0;
> +       int ret;
> +
> +       scoped_guard(mutex, &st->lock) {
> +               /*
> +                * Consider that turning off WoM is always working to avo=
id
> +                * blocking the chip in on mode and prevent going back to=
 sleep.
> +                * If there is an error, the chip will anyway go back to =
sleep
> +                * and the feature will not work anymore.
> +                */
> +               st->apex.wom.enable =3D false;
> +               st->apex.on--;
> +               ret =3D inv_icm42600_disable_wom(st);
> +               if (ret)
> +                       break;

The fact that scoped_guard() uses a for loop is an implementation
detail so using break here makes this look like improper C code. I
think this would be better to split out the protected section to a
separate function and just use the regular guard() macro.

> +               /* turn off accel sensor if not used */
> +               if (!st->apex.on && !iio_buffer_enabled(indio_dev)) {
> +                       conf.mode =3D INV_ICM42600_SENSOR_MODE_OFF;
> +                       ret =3D inv_icm42600_set_accel_conf(st, &conf, &s=
leep_ms);
> +                       if (ret)
> +                               break;
> +               }
> +       }
> +
> +       if (sleep_ms)
> +               msleep(sleep_ms);

Probably don't need the if here. msleep() won't sleep if we pass 0 to it.

> +       pm_runtime_mark_last_busy(pdev);
> +       pm_runtime_put_autosuspend(pdev);
> +
> +       return ret;
> +}
> +

...

> +static int inv_icm42600_accel_write_event_config(struct iio_dev *indio_d=
ev,
> +                                                const struct iio_chan_sp=
ec *chan,
> +                                                enum iio_event_type type=
,
> +                                                enum iio_event_direction=
 dir,
> +                                                bool state)
> +{
> +       struct inv_icm42600_state *st =3D iio_device_get_drvdata(indio_de=
v);
> +
> +       /* handle only WoM (roc rising) event */
> +       if (type !=3D IIO_EV_TYPE_ROC || dir !=3D IIO_EV_DIR_RISING)
> +               return -EINVAL;
> +
> +       scoped_guard(mutex, &st->lock) {
> +               if (st->apex.wom.enable =3D=3D state)
> +                       return 0;
> +       }
> +
> +       if (state)
> +               return inv_icm42600_accel_enable_wom(indio_dev);
> +       else

This is redundant else and can be removed.

> +               return inv_icm42600_accel_disable_wom(indio_dev);
> +}
> +

...

> +static int inv_icm42600_accel_write_event_value(struct iio_dev *indio_de=
v,
> +                                               const struct iio_chan_spe=
c *chan,
> +                                               enum iio_event_type type,
> +                                               enum iio_event_direction =
dir,
> +                                               enum iio_event_info info,
> +                                               int val, int val2)
> +{
> +       struct inv_icm42600_state *st =3D iio_device_get_drvdata(indio_de=
v);
> +       struct device *dev =3D regmap_get_device(st->map);
> +       u64 value;
> +       unsigned int accel_hz, accel_uhz;
> +       int ret;
> +
> +       /* handle only WoM (roc rising) event value */
> +       if (type !=3D IIO_EV_TYPE_ROC || dir !=3D IIO_EV_DIR_RISING)
> +               return -EINVAL;
> +
> +       if (val < 0 || val2 < 0)
> +               return -EINVAL;
> +
> +       value =3D (u64)val * MICRO + (u64)val2;
> +       pm_runtime_get_sync(dev);
> +       scoped_guard(mutex, &st->lock) {
> +               ret =3D inv_icm42600_accel_read_odr(st, &accel_hz, &accel=
_uhz);
> +               if (ret >=3D 0)
> +                       ret =3D inv_icm42600_accel_set_wom_threshold(st, =
value,
> +                                                                  accel_=
hz, accel_uhz);

At least we aren't using break here, but still this could be better
split out to a separate function so that we can use the regular return
on error pattern.

> +       }
> +       pm_runtime_mark_last_busy(dev);
> +       pm_runtime_put_autosuspend(dev);
> +
> +       return ret;
> +}
> +

