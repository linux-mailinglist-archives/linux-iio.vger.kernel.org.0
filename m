Return-Path: <linux-iio+bounces-18617-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2BAA9BDA3
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 06:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70E7C9A0DC7
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 04:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704062185AC;
	Fri, 25 Apr 2025 04:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mwfsytwu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9170F21770D;
	Fri, 25 Apr 2025 04:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745555640; cv=none; b=Kp8h8SGRYmcb4/aqsBP0lQwpjDYycECVscyhQZI0soniArvI31ZXMFKe5stncvedR54I7i+kLJNrpepfOFhn27eEMxiVpW/ZMnpSY4oMJLt5DrNQ9zzo6NE/rB6pziJFnn0BjkEreiCEwYtgm0G4rCcWKctynGWkBY7cZNJVNXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745555640; c=relaxed/simple;
	bh=uKkCY+xDNSuBKaZTGZXKQ2pseGJCvNXp3NItQOrGSV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fRBUAnWcBcz5p5Wk6WO28Lelhgxg7tCoENAftaghepoLxl0VP6zdFZLtHb7tDkmIu3vdl7I4OEF2iyy1gENEWwxV+tF7hc74Jd92S1G5+4eZCBxRdDYULhlKl+U+7Id0uM4vSHwHvBRrqErNIM9DGJDOUX6JJAzJroSXTPGANT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mwfsytwu; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac2963dc379so265388866b.2;
        Thu, 24 Apr 2025 21:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745555637; x=1746160437; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vyoGVpD2bZ3qu1xP+KQPqweBUpFDdXyW9e6EmCalIYs=;
        b=Mwfsytwu006+4aOue+zP7WMmUM7IrPgo8LF/Hoq5mpZ/p+qwXNfx3omMnSvliRrfqT
         0/tqaEKMobZnWnH+Xpenk5+5UUmvf1pC8ukpT1Mju8Pvw0FSTbKNxaAudikGbo/ztoEh
         0tre4IRMB9tSP4LotLpMJODJLxirqoNAqL3MMY+UREnWd5O68wKqB9XPLZ0dJYYva7YQ
         NDg6ofCyxzjO3Wav4wmQht54jwEMx/zVuGu44nZrkgoBaTdqUdK/x8scKJngP2/nINMf
         2f3SN26kkMVay+aXMsIjR9JI/MlSbbtLRhyb2ySdc2Sua5Xj+xTVdUHjegPEA8++eno3
         oKow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745555637; x=1746160437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vyoGVpD2bZ3qu1xP+KQPqweBUpFDdXyW9e6EmCalIYs=;
        b=acyxd+b96JHROXARc945B+cCVPtDLgBXWBBCfxoki9oWbcuiz0wjCZaZLxPJIeczNb
         AIbIpS3jRSh8NiPfh5AypVvyxfUp7iMpjY+wc0YMv4OsNH1kRrPkgeexI9/CCnKmdzBj
         189UH5LuYB4EoILAJANuCmzl9W7atGSYACobLULJ2/AdJ3rLqGP+b1FHCowq06Mt7u+O
         xTpSunHwLVEsJqLHTAhqMDAmEduwsZC5+dp+TJ2c6Zuc7aDfGlLl0p0YbtNvtYZxwRlH
         c3gTXS1j9GeVmLKYzS41v1tjLKUtNFiNOzzgAM90V96tUjvTpUTyNQtekmzpZKhj7B4q
         b9Gg==
X-Forwarded-Encrypted: i=1; AJvYcCVxHtaP4I5MUH/4o2+dqqO4uKho3/SwDy3yLj3L6kiEHRYjA7Y9iRFiqpxj0Gq4avYXTbJNYyXCHsw=@vger.kernel.org, AJvYcCWlWsLc19MGRq2UjHcv1Z2mhwTc24dIN7BgonUdnE2IKwgmulJBaFHsWq0FnWHTinfUP0AgS5qww0pdx/W+@vger.kernel.org
X-Gm-Message-State: AOJu0YycZX7uqwLsn5utHotWIjzAia9YLEuuPAuZE2FTsIW2N2IppF9B
	jzp/pFqoNJctRw0RvDp6mmlXOa2G97GwSn0NezuYKtgYV2cu5UG6sBCs7Uv9Yh8aWgFkdgYoALk
	Dg0mxo7hJVgtvUHhDrPSSIP3D9a8=
X-Gm-Gg: ASbGncs9bj/EC5W3+/eX8e27WKnPOWHiwU1pZD3JXdbGkRZLNqkK8lHIRyqVhqifVyE
	ZFCBTlJFmQ8cXicrEdz4SyDnIyO+uCebY+MHp5DMyjcqJfHfhIj7haz9Pq55La6aj+5lg9byONM
	9jg0y3ZSiR+Vbsd5cWYHkqQQ==
X-Google-Smtp-Source: AGHT+IFx62jCxLjOvML5SIqoqArujGPiRPm0rGLGdivLsRsOcGNbz7gM7bmkw9yvPRdXakGb1+l7eHAAPkcAnPGyT2k=
X-Received: by 2002:a17:906:9f88:b0:aca:95e7:ec59 with SMTP id
 a640c23a62f3a-ace710a0e2dmr80854666b.19.1745555636500; Thu, 24 Apr 2025
 21:33:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424-bmi270-events-v1-0-a6c722673e5f@gmail.com> <20250424-bmi270-events-v1-2-a6c722673e5f@gmail.com>
In-Reply-To: <20250424-bmi270-events-v1-2-a6c722673e5f@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 25 Apr 2025 07:33:20 +0300
X-Gm-Features: ATxdqUHzXrFjZeBnhQ59BRut15sZlzEzMLe5nYCzByHMGY3xYaIra_fzYXFittg
Message-ID: <CAHp75Vc30u=1jx3qNft-uOVCk49e4gTgyLf3+kgmUADQB56wEA@mail.gmail.com>
Subject: Re: [PATCH 2/3] iio: imu: bmi270: add step counter watermark event
To: Gustavo Silva <gustavograzs@gmail.com>
Cc: Alex Lanzano <lanzano.alex@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 3:15=E2=80=AFAM Gustavo Silva <gustavograzs@gmail.c=
om> wrote:
>
> Add support for generating events when the step counter reaches the
> configurable watermark.

With the below being addressed,
Reviewed-by: Andy Shevchenko <andy@kernel.org>

...

> +static int bmi270_write_event_config(struct iio_dev *indio_dev,
> +                                    const struct iio_chan_spec *chan,
> +                                    enum iio_event_type type,
> +                                    enum iio_event_direction dir, bool s=
tate)
> +{
> +       struct bmi270_data *data =3D iio_priv(indio_dev);
> +
> +       switch (type) {
> +       case IIO_EV_TYPE_CHANGE:
> +               return bmi270_step_wtrmrk_en(data, state);
> +       default:
> +               return -EINVAL;
> +       }

> +
> +       return 0;

Dead code.

> +}

...

> +       switch (type) {
> +       case IIO_EV_TYPE_CHANGE:

> +               if (!in_range(val, 0, 20461))

I prefer that + 1 to be separated and the value defined.

(0, _FOO + 1)

> +                       return -EINVAL;

> +               raw =3D val / 20;

Needs a comment.  Is this in the Datasheet? Then reference to the
section / table / formula would be nice to have.

> +               return bmi270_update_feature_reg(data, BMI270_SC_26_REG,
> +                                                BMI270_STEP_SC26_WTRMRK_=
MSK,
> +                                                FIELD_PREP(BMI270_STEP_S=
C26_WTRMRK_MSK,
> +                                                           raw));
> +       default:
> +               return -EINVAL;
> +       }

...

> +               raw =3D FIELD_GET(BMI270_STEP_SC26_WTRMRK_MSK, reg_val);
> +               *val =3D raw * 20;

Same.

> +               return IIO_VAL_INT;


--=20
With Best Regards,
Andy Shevchenko

