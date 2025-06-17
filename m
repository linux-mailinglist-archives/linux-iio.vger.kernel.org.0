Return-Path: <linux-iio+bounces-20734-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5B3ADC26C
	for <lists+linux-iio@lfdr.de>; Tue, 17 Jun 2025 08:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D3BF3AB682
	for <lists+linux-iio@lfdr.de>; Tue, 17 Jun 2025 06:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D283128BAB9;
	Tue, 17 Jun 2025 06:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4CM7Uxl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45622116E9;
	Tue, 17 Jun 2025 06:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750142016; cv=none; b=mclrOpGc+UUtim9qYRUYLTEL/WbEJ++pOEyjXUN5Q7dUyKpGrwIqnvKNkZK9qxYlyPAM7r3iBoLq4irv5w2FdYX56P/woIph7KRZNXlZBA5MxnRHvTnyJMwcKcrAUJxZj0LRbAqfk4mqccE5z01CJZh2vVVwVsku0N8BYTxmUfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750142016; c=relaxed/simple;
	bh=keXtiVN31fKx64oUF/7iPO90TbGTcSFJ55j+G9vybIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U/pzqVFuDbyt6VbeNW7WexmsJw/T0dR6eTvzRDMdPUUuYJmEljj3n+WzdSVB8Vgc+28sFgJMw2hk1k5bdL8nvowvwOrwroY/i4XyyNT+M+GlJRY+Ds1P6hiBPLTRm5z8c9sBCFJ7DNdJVzEKr8C2lBjLW92X3exlylMGFMLeQjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B4CM7Uxl; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ade326e366dso977231966b.3;
        Mon, 16 Jun 2025 23:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750142013; x=1750746813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NA0TLB9oKte+OwEm1gowNLenoPqaplJehC52uwcC+A8=;
        b=B4CM7UxlP3GE188GSYm4ntjeFvvmfM8WyENFmMVTLimXbiK2Pdfe56cAGFrhmX2VtV
         YAdh55pvvrSiAQ5rCk6DR0jGR1oWG82FiIXHhnzM7ttWsRvbDZPZ7D+CVcKGgoQMoNHF
         2X5Fa06Qp0Y5oRewjAq/x9OgOQBfJqMONR1ro/BcOZCaDsblPCLX8B3Rubm2llzdhErm
         41ChbDYsLzk/v/cabcHySoEu/lgO+4bht8dAnI6+Ag72zfwS/xkOEXAUzYIXjUmJMjom
         eGXjPgwBN5hlctn4rt1ecYTruoEk8fnraRneaM4iFVqDSTdoujTCBXGQnWXzN4KOdKwp
         jKvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750142013; x=1750746813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NA0TLB9oKte+OwEm1gowNLenoPqaplJehC52uwcC+A8=;
        b=C/cEvK7YrcSno457yXrg1GCfqucnwsCyITY1wFQ9wZ5zx7tbyY7MtcM9ekbFmfdXAW
         qeEayGrv7x790n3B32ehtwPMk4zcqP5hwGscUnyYLhiZ/7E62qsbHsV8rYEnDcWLFeBa
         cGce8wYj4GvvV1LrZdBDiQewo6lKjeqLcCejJijr8/EfUsL7YZoSStZ92eeezZkF2/cz
         13AQyneqKVrbZgwvrcogTE1Qq4E2YkXWfFxGWliDuq1TUQmhN03Um4AlZHMbsJitXjoR
         2aiDBB9VQtroaFrZgGGNN6SYlizVqhBod+4nnPaotYjXdZXEBev/JRUQp8Ne9Lg+JoiJ
         /OsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdqVeZAe+3hdY+Dz65EyMImN7ep4jdHFjtcj3SmHnQEX+ST9wNdVda/CFxBeDxzzHcffGenF/KTEA=@vger.kernel.org, AJvYcCWvSuEkYsFB6u3yXUCfK6NYQ+FrWvkebb3IWI5jgPd+oCnBPJ11V8WyZQGrkTQlp0drdDWPszXQYEfMXztq@vger.kernel.org
X-Gm-Message-State: AOJu0YygGhJ3OPuqm49Le2xEspqcr7QsWTw5ei7c1qWuSUKEvmENvuZi
	SlFV6CIYGckyA3QCNvMVAj6cRVeJ7I0JhyEaI3mQmU+PUN34flYWyk1q/RzaDGygVg/IfhtWy5H
	IHdh9Oz1SxP8AHcvvpWpoXnbmzM5rN5U=
X-Gm-Gg: ASbGnctr8Puv0uYpCSlhD82rVKSTVL7la6gSxKpHAS218qXpx0fz1BiOgEPkeFfpOJ9
	8Xam9sfcAVzlxbelcDEWHd+wj+Y6TEUMhim2oCNSYGKH1b1MP1BCzijh3rOQ/psnLenRyYWX/A4
	vnj5m0uUlYCDzeTatNCgvCdDtsJA3n21kB+IlegSLcq5Dk/Q==
X-Google-Smtp-Source: AGHT+IEPibyVVx6ANOKw4K146U1HPHC7bbE3rmky9TQQiRKsFBaiNe2CFrP1DN4lcLRKeGTdSO8sI6qrP8ASCwjEySc=
X-Received: by 2002:a17:907:7e92:b0:ad8:97d8:a52e with SMTP id
 a640c23a62f3a-adfad4f40f1mr1188544366b.55.1750142013006; Mon, 16 Jun 2025
 23:33:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616-bmi270-events-v3-0-16e37588604f@gmail.com> <20250616-bmi270-events-v3-3-16e37588604f@gmail.com>
In-Reply-To: <20250616-bmi270-events-v3-3-16e37588604f@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 17 Jun 2025 09:32:56 +0300
X-Gm-Features: AX0GCFujvum22WkIySIVbQeVbVZg254I-tYPkhT9vPcG30nWAYbTMKR0MrYZHaE
Message-ID: <CAHp75Ve+6BjG0vFy0ohMsODkybH3L+4EM6RODJYDRw+W6Gdtmg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] iio: imu: bmi270: add support for motion events
To: Gustavo Silva <gustavograzs@gmail.com>
Cc: Alex Lanzano <lanzano.alex@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lothar Rubusch <l.rubusch@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 2:53=E2=80=AFAM Gustavo Silva <gustavograzs@gmail.c=
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

> +#define BMI270_INT_MICRO_TO_RAW(val, val2, scale) ((val) * (scale) + \
> +                                                 ((val2) * (scale)) / ME=
GA)

Much easier to read and maintain when it's split logically, i.e.

#define BMI270_INT_MICRO_TO_RAW(val, val2, scale) \
        ((val) * (scale) + ((val2) * (scale)) / MEGA)

...

> +#define BMI270_RAW_TO_MICRO(raw, scale) ((((raw) % (scale)) * MEGA) / sc=
ale)

Ditto for the sake of consistency with the above.

...

> +       case IIO_ACCEL:
> +               switch (type) {
> +               case IIO_EV_TYPE_ROC:
> +                       return FIELD_GET(BMI270_INT_MAP_FEAT_NOMOTION_MSK=
,
> +                                        regval) ? 1 : 0;

I would do it with logical split despite being longer (than 80) line

                       return
FIELD_GET(BMI270_INT_MAP_FEAT_NOMOTION_MSK, regval) ?
                                        1 : 0;

Or even
                       return
!!FIELD_GET(BMI270_INT_MAP_FEAT_NOMOTION_MSK, regval);

if 1 is important here, or w/o !! if not.

> +               case IIO_EV_TYPE_MAG_ADAPTIVE:
> +                       ret =3D bmi270_read_feature_reg(data, BMI270_ANYM=
O1_REG,
> +                                                     &motion_reg);
> +                       if (ret)
> +                               return ret;
> +
> +                       feat_en =3D FIELD_GET(BMI270_INT_MAP_FEAT_ANYMOTI=
ON_MSK,
> +                                           regval);
> +                       switch (chan->channel2) {
> +                       case IIO_MOD_X:
> +                               axis_en =3D FIELD_GET(BMI270_FEAT_MOTION_=
X_EN_MSK,
> +                                                   motion_reg);
> +                               break;
> +                       case IIO_MOD_Y:
> +                               axis_en =3D FIELD_GET(BMI270_FEAT_MOTION_=
Y_EN_MSK,
> +                                                   motion_reg);
> +                               break;
> +                       case IIO_MOD_Z:
> +                               axis_en =3D FIELD_GET(BMI270_FEAT_MOTION_=
Z_EN_MSK,
> +                                                   motion_reg);
> +                               break;
> +                       default:
> +                               return -EINVAL;
> +                       }
> +                       return (axis_en && feat_en) ? 1 : 0;

Do you expect boolean to be not 1 when it's true? IIRC this is part of
the C standard.

> +               default:
> +                       return -EINVAL;
> +               }

...

> +       int ret, reg;
>         u16 regval;
> -       int ret;

Why? And why is reg signed? Also check other cases with reg and
semantically similar variables.

--=20
With Best Regards,
Andy Shevchenko

