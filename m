Return-Path: <linux-iio+bounces-23451-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6CEB3CAD3
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 14:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73ED4189B443
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 12:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D3327B4F5;
	Sat, 30 Aug 2025 12:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwsZyZ8m"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCF5279359;
	Sat, 30 Aug 2025 12:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756557917; cv=none; b=jaTH3LixxnthAkyde/0s2YobiCwjZiyRenokKAGbvdj5xkdjkf2J30cHe2CPfVsca1m7aIny41hKZ6HbwxB2cpMTbj6qOGxEEdiTGbpMpjSymFSGR7Qg55VaLwJblAm8I5t/Hbk4Rn//05rstJ6db8bge3Ltj30V3MeeRXZ5y+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756557917; c=relaxed/simple;
	bh=5n0XllGsyWVL0XiuwmoPv6h1zeZ9O71p2tZRrUE4xUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T39MpXbPnOmQ+JMUY79HYBsvhNZcHJsyMgUYxTACNaUmUwQCZ87XonVdk6FR6qp82pN3tIDI0H1Mq3iqoiqwiYDy+xZ6uKNMzN/gJg8pknrsvKi3MYTnGC+mxsnRIGOH/aJ43eQnIoNR+HbdTQDGDT2yd6KOCTyPw0M2hyZEoOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SwsZyZ8m; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aff0365277aso235025666b.1;
        Sat, 30 Aug 2025 05:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756557913; x=1757162713; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S4mHOLTdpQjV64dCdpdvjh2zgbsXrdAk0hsxcagQzCk=;
        b=SwsZyZ8m+fsugtAVy2s+muvZh/4zRZdpWtZnmuM5vwRyRlCVQNhXaP8JuPGWBy/h01
         AH/xVaL69ZIOqL5bXwTJNmAUNtG/MVEd8rPwD3CfFD6eVLr1hY8CMlmP/BJXkPufYj5U
         INlIKnCor+KznvBz7Ok12Rx1rn2c2Yvpj31YyANt1AWgDdlHhM+dzp/WB+jphboRskDC
         kJOfoJf7T4HOGo/+AjNefa3THP4clXu8i3vaT4FJeAqcqAmzubTR/uzGFoMF/TxrvHaQ
         TaQcMtsUjYRJ4cNUq6HE76SJyRu9P2q30mmBaT9sY8kb+yJDooLEj29y3kByyPk+j2eS
         vo5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756557913; x=1757162713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S4mHOLTdpQjV64dCdpdvjh2zgbsXrdAk0hsxcagQzCk=;
        b=EUMqiLlBeHg8YfWM9HwPa67TDEgNuShqJ+IDNdSp9u4iKIZUU+lKgx5LSuZ9X+pQAH
         iGucENVPoYETCdYMO/FJDooQff2gbbMFaA1Bu/DPce842hVfNpIhMJXkU0NquWeyMFB2
         qdCOidEV1DsKmaAEtSACv4uoGjmMc4tM9B6GvMhsiyb2RIFUSJPRiQGIPo8GogaIX0Hk
         6bLytgOzTP36mjrifwgCjQiLZ8M+oYs/KZC6wVqBs2Nz4hfZwPLTuvYUlgY14TD4RpSp
         6oL0G5cMC4OxUdLQL5DcQPlL1rkYKASPd7sSKnYUWBD9nIts8WyJF+phVGIdnkxRnjrI
         bWRg==
X-Forwarded-Encrypted: i=1; AJvYcCUmJ0jMQTG/jV7/7+5eDHicRK2aQcWF6NXkRbq7FW6j5Vd92MKe1xUg4s2PHtYx6ADJQYHWH2MQ7I0=@vger.kernel.org, AJvYcCW8g7z3+Mhm2ueUyOucw20DxgDhCZxh3rv9VOaHyaAfE0N+r8SnqqXsn2wJKrpqrs8/hcfSYK/xaiSnrc4O@vger.kernel.org
X-Gm-Message-State: AOJu0YyhQ6Gu1Vp8Rh3yddbDeFTkhkiSoSeVG8gvGygbE61BaZG2Ee3/
	4VT3i/3ioUPP2i+aEIDD6/VRRC+osdnanmAbu1F0pCuQ7b5kygDU2jC/m4yU6v4qPKWNswZapg3
	mOefTnXNLxY+tgbcn31FBFhRJnPOleW0=
X-Gm-Gg: ASbGncves7WO602x1C/gX2eW5zifpbIpHqaFHCvVKERDOnaMwmSydv56t0/tU/l7BRq
	Ae291Ch9ODtU7fomudiR0qqVjNi1MUp40gYIazVkqexAb0verjPKWLF+bcm01aoMycorpuk2s8a
	xRw3yrWn1O5iWRysq7AN6Q1pgenOhAl8pHeSkDSRk0PFnv+5WWYQ7ldtp0SqyoaKn7h5dUmXnFm
	vil1EhGzkGTxEvKPg==
X-Google-Smtp-Source: AGHT+IGsFhgIY8ckvcxhjCmKBpAVfWyQaIzUz1Ej2o2bODIrmlVBuwjq1/e2LgjpB9BvWnNiXU4luaj3RwC0TMstfhA=
X-Received: by 2002:a17:906:4fca:b0:afe:ac57:f0be with SMTP id
 a640c23a62f3a-b010832f5famr244927066b.31.1756557913265; Sat, 30 Aug 2025
 05:45:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250830115858.21477-1-gustavograzs@gmail.com> <20250830115858.21477-2-gustavograzs@gmail.com>
In-Reply-To: <20250830115858.21477-2-gustavograzs@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 30 Aug 2025 15:44:37 +0300
X-Gm-Features: Ac12FXykwZMzgTh5iaEYIPYpzP5j8F81w4Mfy3EWfPnqbplSS4lzltm54UzkkzQ
Message-ID: <CAHp75Ve93UPiE=STPLiGzfipWUe0WeQsER5X50sKbkdMWDR4bQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] iio: imu: bmi270: add support for motion events
To: Gustavo Silva <gustavograzs@gmail.com>
Cc: lanzano.alex@gmail.com, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 30, 2025 at 2:58=E2=80=AFPM Gustavo Silva <gustavograzs@gmail.c=
om> wrote:
>
> Any-motion event can be enabled on a per-axis basis and triggers a
> combined event when motion is detected on any axis.
>
> No-motion event is triggered if the rate of change on all axes falls
> below a specified threshold for a configurable duration. A fake channel
> is used to report this event.
>
> Threshold and duration can be configured from userspace.

...

> +#define BMI270_INT_MICRO_TO_RAW(val, val2, scale) \
> +       ((val) * (scale) + ((val2) * (scale)) / MEGA)
> +#define BMI270_RAW_TO_MICRO(raw, scale) \
> +       ((((raw) % (scale)) * MEGA) / scale)

In the macro names "MICRO" in the implementation "MEGA", please make
this consistent.

...

> +static ssize_t bmi270_show_accel_value_avail(struct device *dev,
> +                                            struct device_attribute *att=
r,
> +                                            char *buf)
> +{
> +       struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> +       struct bmi270_data *data =3D iio_priv(indio_dev);
> +       int ret, scale, uscale;
> +       unsigned int step, max;
> +
> +       ret =3D bmi270_get_scale(data, IIO_ACCEL, &scale, &uscale);
> +       if (ret)
> +               return ret;
> +
> +       max =3D BMI270_G_MICRO_M_S_2 / uscale;
> +       step =3D max / BMI270_MOTION_THRES_FULL_SCALE;
> +
> +       return sysfs_emit(buf, "[0 %u %u]\n", step, max);

Do we need []? Is it common in IIO? The usual way in SW to have "$min
$max $step" (see `seq` in shell, range() in Python and so on).

> +}
> +
> +static IIO_DEVICE_ATTR(in_accel_value_available, 0444,
> +                      bmi270_show_accel_value_avail, NULL, 0);

IIO_DEVICE_ATTR_RO()

...

> +               return FIELD_GET(BMI270_INT_MAP_FEAT_STEP_CNT_WTRMRK_MSK,=
 regval) ?
> +                                                                       1=
 : 0;

Make it one line by replacing ternary with !! (double exclamation mark).

...

> +                       return FIELD_GET(BMI270_INT_MAP_FEAT_NOMOTION_MSK=
,
> +                                        regval) ? 1 : 0;

Ditto.

--=20
With Best Regards,
Andy Shevchenko

