Return-Path: <linux-iio+bounces-18143-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B8AA8A6A0
	for <lists+linux-iio@lfdr.de>; Tue, 15 Apr 2025 20:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30ADA7A973B
	for <lists+linux-iio@lfdr.de>; Tue, 15 Apr 2025 18:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7384A2206B2;
	Tue, 15 Apr 2025 18:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IGi+G+7+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD0C2DFA58;
	Tue, 15 Apr 2025 18:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744741159; cv=none; b=Yvk1eW3iQ4KC/oV4HkCv+KsfowDQa1IYgpyX2qCfWz4Q0iHPWO/lpgEymvzAj5iSMhSuybGmmayFXKp9paDJeVKk9kdVu5+yIp/WodcqS75MYyLUWtuqcpY6Pi+WxGd19M0UkcM4JHnkDf53A+JXWLFJ4B08vf6Xs0j3ZQQeDTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744741159; c=relaxed/simple;
	bh=Gws1wIvg9siKK58DXTdW+CIQSwFMBVuhPeqgwZ/OWjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nn47/0Fze5mVcyitK2I9BbNrmudyADdMlUUWy4FXrNbcR8cfEwRYbMLLYsnEBZLVKF2EF1cAskQ7ZxdL4A/sde8bIb1OqVZdMrlOPRtpcxT2awlVQPoMZvheUwxICZVFah6FHhhtWuYEO7u/DdxCM9DN1w3Ydd3zKASe3MYBH6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IGi+G+7+; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-acacb8743a7so887268166b.1;
        Tue, 15 Apr 2025 11:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744741156; x=1745345956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hPZCbg626WMu8lisEMtyqcoplCJWzV6TAyAoZ850/GI=;
        b=IGi+G+7+8f9Y/sv9hJehVT1dG5yZVan2c5fl8fb27v+wjVeDHTPq6c23NR7jyZ7duy
         Cjb1b2GwBhvBTYz6gSNugmGrwSYBNii8uMWvOUpRDuBFZm+1WpO3HOsZHMY+IIAoauN9
         v/bPR0SWuvcshHPy87VHBvArzPjNLc8SR0/ha41Y4NVJA+DrWNAlIo+Wrf7T3rPUdwbK
         uIFfUrAiLKKuVNKRKXaeh7ymhCX+EiqD0PTzdMFCUKy3tELDQhj8/5bmLYbw/oU/UxID
         uzSRjNLCnZniplpiqL3faftzi1yOo7tvkNJreLuOaHXfsS5Cuigc/NLBxwTDox67WDjC
         sU5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744741156; x=1745345956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hPZCbg626WMu8lisEMtyqcoplCJWzV6TAyAoZ850/GI=;
        b=UjGSVEYBY36mgJf7d/WzHM1bR51h3Sdsl+FgSxyDS6Nt1hTPzYcuyZib/vHLeIzZp8
         +p99aOXAbC70dILkgAx+RnkCvbkYgkG+/2ZYRIz2QxmABxZUvPPS2QjXeGl1b+kZ3uUH
         KAZQJ6l4E/p1eQJVPDUjODCKuz3VQktr7fvlliJwxYA7DA0ZgiYsfeqYV9+YE5KZKQH6
         CBvFSgkDkkZjalwZ19NTxLeWuLKz8STwfXU9XaDiWK1CC7A/GtkY+s4jJ+AS8hLIcoiF
         hHAhY6RdO9Y1gA2ZqZLneH+pSIAcF5eL9GbK7n7oBNDAKXkQ3lupJ5iQ6Jl4tVF31OlJ
         54HA==
X-Forwarded-Encrypted: i=1; AJvYcCVCXe1bvjfB+JWw9n+53EdFrMGPxZYPgXgv6590mdpdybzSU6AEh0QaB/ojoK+YCh5SujWRlHCwtkY=@vger.kernel.org, AJvYcCWV2nc62zw+ODnKaGM4XtVq/8X3uaNDcBUASO81o1lOJA1VFVlzV4WPsS/JsF+Iqgo593dWIgBqXKVKlr/S@vger.kernel.org
X-Gm-Message-State: AOJu0YwR3IxXAV5N4LZrxpLFE0o7zqkvAe96XQHch2/THP9xwMilBHOE
	mRn/IKbqJ+prDI/dxvzBEdz+wYW9wwM8ylzhuel+JA5HqzCkKreGa0sKowJwuiVfRK6o15eff/+
	A6ery4sqTu6fWvf/s2xHlNbMhzb0=
X-Gm-Gg: ASbGncuShvkG54eV3cmNZ07nvXpzNg2gItjAumplzwey+oCSLx0kCF2FXTu9pYcaL79
	70MKeaRit+r4ry6nLaKhUnS5Af9GTZVjmbhVXEykCeYJ8bwYV4Vrlex896VQbjFGZHrT1MflJHd
	espcYDZPSwqZeEZ/q/WGyhYA==
X-Google-Smtp-Source: AGHT+IHaoZWyw+82+PVB7AdmUylxYQg3UPV10NA/4oQfwzG9Kpb8HU+IW5Vx0fiz1Vk0epFaNCInel1iGpVcztthndE=
X-Received: by 2002:a17:907:7211:b0:aca:d276:fa5 with SMTP id
 a640c23a62f3a-acb3558fc6bmr50021566b.0.1744741155443; Tue, 15 Apr 2025
 11:19:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250415-losd-3-inv-icm42600-add-wom-support-v2-0-de94dfb92b7e@tdk.com>
 <20250415-losd-3-inv-icm42600-add-wom-support-v2-1-de94dfb92b7e@tdk.com>
In-Reply-To: <20250415-losd-3-inv-icm42600-add-wom-support-v2-1-de94dfb92b7e@tdk.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 15 Apr 2025 21:18:38 +0300
X-Gm-Features: ATxdqUFl6iqEMWz7LC3M1qjUo8P9zpCz6tPTSRFk6Q4Wg1o84FisiL1TwyrHdAg
Message-ID: <CAHp75VdZDovPuRqQMpP=TkjeBr9AgRssPFJfmsjnXC=wUXxFHg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] iio: imu: inv_icm42600: add WoM support
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
> Add WoM as accel roc rising x|y|z event.

...

> +struct inv_icm42600_apex {
> +       unsigned int on;
> +       struct {
> +               bool enable;
> +               uint64_t value;

Why not kernel types? It seems in many places in the driver the
*intXX_t are used instead of simple uXX/sXX.

> +       } wom;

Have you run `pahole`? To me it seems swapping the members in the
outer struct will save some memory at run time.

> +};

...

>         struct {
>                 int64_t gyro;
>                 int64_t accel;

s64 ?

>         } timestamp;

...

> +       uint8_t buffer[3] __aligned(IIO_DMA_MINALIGN);

u8 ?

...

> +static unsigned int inv_icm42600_accel_convert_roc_to_wom(uint64_t roc,

u64

> +                                                         int accel_hz, i=
nt accel_uhz)
> +{
> +       /* 1000/256mg per LSB converted in m/s=C2=B2 in micro (1000000) *=
/

That 1000000 is redundant, just properly spell the units.

> +       const unsigned int convert =3D (1000U * 9807U) / 256U;
> +       uint64_t value;
> +       uint64_t freq_uhz;

u64

> +       /* return 0 only if roc is 0 */
> +       if (roc =3D=3D 0)
> +               return 0;
> +
> +       freq_uhz =3D (uint64_t)accel_hz * 1000000U + (uint64_t)accel_uhz;

u64

MICRO?

> +       value =3D div64_u64(roc * 1000000U, freq_uhz * (uint64_t)convert)=
;

MICRO

> +       /* limit value to 8 bits and prevent 0 */
> +       return min(255, max(1, value));

Reinvention of the clamp() ?

> +}

...

> +static uint64_t inv_icm42600_accel_convert_wom_to_roc(unsigned int thres=
hold,
> +                                                     int accel_hz, int a=
ccel_uhz)

Similar comments as per above.

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
> +               if (ret)
> +                       goto error_suspend;
> +       }

> +       if (sleep_ms)

Do you need this check?

> +               msleep(sleep_ms);
> +
> +       scoped_guard(mutex, &st->lock) {
> +               ret =3D inv_icm42600_enable_wom(st);
> +               if (ret)
> +                       goto error_suspend;
> +               st->apex.on++;
> +               st->apex.wom.enable =3D true;
> +       }
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
> +               st->apex.wom.enable =3D false;
> +               st->apex.on--;
> +               ret =3D inv_icm42600_disable_wom(st);
> +               if (ret)
> +                       break;
> +               /* turn off accel sensor if not used */
> +               if (!st->apex.on && !iio_buffer_enabled(indio_dev)) {
> +                       conf.mode =3D INV_ICM42600_SENSOR_MODE_OFF;
> +                       ret =3D inv_icm42600_set_accel_conf(st, &conf, &s=
leep_ms);
> +                       if (ret)
> +                               break;
> +               }
> +       }

> +       if (sleep_ms)

Ditto.

> +               msleep(sleep_ms);


> +       pm_runtime_mark_last_busy(pdev);
> +       pm_runtime_put_autosuspend(pdev);
> +
> +       return ret;
> +}

...

> +void inv_icm42600_accel_handle_events(struct iio_dev *indio_dev,
> +                                     unsigned int status2, unsigned int =
status3,
> +                                     int64_t timestamp)

Okay, I believe here int64_t is inherited from IIO definitions.

> +{
> +       struct inv_icm42600_state *st =3D iio_device_get_drvdata(indio_de=
v);
> +       uint64_t ev_code;

u64.

> +       /* handle WoM event */
> +       if (st->apex.wom.enable && (status2 & INV_ICM42600_INT_STATUS2_WO=
M_INT)) {
> +               ev_code =3D IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, IIO_MOD_X_OR=
_Y_OR_Z,
> +                                            IIO_EV_TYPE_ROC, IIO_EV_DIR_=
RISING);
> +               iio_push_event(indio_dev, ev_code, timestamp);
> +       }
> +}

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
> +       /* handle WoM (roc rising) event */
> +       if (type =3D=3D IIO_EV_TYPE_ROC && dir =3D=3D IIO_EV_DIR_RISING) =
{

Invert the conditional to reduce indentation of the below. It will
also follow the traditional pattern, i.e. checking for the errors
first.

> +               scoped_guard(mutex, &st->lock) {
> +                       if (st->apex.wom.enable =3D=3D state)
> +                               return 0;
> +               }
> +               if (state)
> +                       return inv_icm42600_accel_enable_wom(indio_dev);

> +               else

Redundant 'else', but in this case for the sake of symmetry it can be left.

> +                       return inv_icm42600_accel_disable_wom(indio_dev);
> +       }
> +
> +       return -EINVAL;
> +}

...

> +       if (type =3D=3D IIO_EV_TYPE_ROC && dir =3D=3D IIO_EV_DIR_RISING) =
{

Invert the conditional.

> +               /* return value in micro */
> +               *val =3D div_u64_rem(st->apex.wom.value, 1000000U, &rem);
> +               *val2 =3D rem;
> +               return IIO_VAL_INT_PLUS_MICRO;
> +       }
> +
> +       return -EINVAL;

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
> +       uint64_t value;

u64

> +       unsigned int accel_hz, accel_uhz;
> +       int ret;
> +
> +       /* handle WoM (roc rising) event value */
> +       if (type =3D=3D IIO_EV_TYPE_ROC && dir =3D=3D IIO_EV_DIR_RISING) =
{

Invert the conditional.

> +               if (val < 0 || val2 < 0)
> +                       return -EINVAL;

This can be checked even before anything else, but see above. With
that it will automatically get on the same indentation level as
previous one.

> +               value =3D (uint64_t)val * 1000000ULL + (uint64_t)val2;

MICRO.
ULL is not needed, the first one already ULL.

> +               pm_runtime_get_sync(dev);
> +               scoped_guard(mutex, &st->lock) {
> +                       ret =3D inv_icm42600_accel_read_odr(st, &accel_hz=
, &accel_uhz);
> +                       if (ret >=3D 0)
> +                               ret =3D inv_icm42600_accel_set_wom_thresh=
old(st, value,
> +                                                                        =
  accel_hz, accel_uhz);
> +               }
> +               pm_runtime_mark_last_busy(dev);
> +               pm_runtime_put_autosuspend(dev);
> +               return ret;
> +       }
> +
> +       return -EINVAL;
> +}

--=20
With Best Regards,
Andy Shevchenko

