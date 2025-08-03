Return-Path: <linux-iio+bounces-22231-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6759B1951E
	for <lists+linux-iio@lfdr.de>; Sun,  3 Aug 2025 22:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01E1C189292E
	for <lists+linux-iio@lfdr.de>; Sun,  3 Aug 2025 20:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698011EDA3A;
	Sun,  3 Aug 2025 20:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OImCVZhl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2F01917CD
	for <linux-iio@vger.kernel.org>; Sun,  3 Aug 2025 20:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754252844; cv=none; b=p/WEGyhg2gk85OAdNhppYrKtxgDCoekci4lkm+8I/GjZCFotL+cpDZlQ2T4djg4BAy44/d/az5YWtnxMlHhK/rNz8YYS8oQlg+TGlXhxpowlItyjhmwsJGHDtYE9MmnmcmAduSlqHgO7S4eN62yQn8ZmHpfTBVqYzqxOgwN54JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754252844; c=relaxed/simple;
	bh=XAQIG/U6Uc0FSw+atsdYcwUcJr9ca1Azaa4JDAdoL7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=co4eNZAsabyv/mJsQmeJM45c3QIC+8yJYVllBkerWj/HY+eDKXc0PPm53rxYKKF/n/E5fCdx+GTHX0n0kjglh2/KQ/dbRkyzmFvrLv2qaHsRRp1ae9b28UR1wqBap4kXQEIltKGPX/eXy9m8wkSHqsXJCFXGafyh1xFsNzj+E1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OImCVZhl; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-af8f5e38a9fso643980966b.0
        for <linux-iio@vger.kernel.org>; Sun, 03 Aug 2025 13:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754252841; x=1754857641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AySg4syVl/wf5ppXcXn0sx0GkXKXDZPNyb2gn/J2Lcs=;
        b=OImCVZhl4ri9/u2X5iEhTVgF/Hn+Wj5/1fq/6DqmWkKE8ty4XPahaIBljlPXPIYfWg
         vwFxVRqJm5ctO/z2JiVDXvuqSIdtkTLDpleoyBC/wGZvZ2kzXRvV5+0MhggLJrxjbdSf
         NV2jmBa42THrQjFNbf9q0HlK+UHvn8kmMmGv8/YNfF+lKLFITML7jKHcpkyuzUc5fGWz
         b/CxcBrO0lYaFTL7CbNi2hBs+fCoLMSEIO//ceCotqlxDgxANEmQhADvkdVINffn8QQR
         cQeU1OeenSuMvPZ4QHAKPzCWdofRUdSTVfl/Ljvb+IuncKBd4UkwAOXs0COxbHTmC1cc
         JgLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754252841; x=1754857641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AySg4syVl/wf5ppXcXn0sx0GkXKXDZPNyb2gn/J2Lcs=;
        b=fFhUTo1N2WMRq58heB/3wepIdgWd/a3afG5RYobgpZo4MmSpIvxVLpCOkFchPr4YzZ
         g47t8yJoIp1JysTnOuxIeRfZndKBkUxigxTw9Z9ftYGxr6uRstb+BaiwIvRsyAgLuYzK
         aWXZFxeNgLWc2LqmWyGRhdmbYYGzKX3bjzXepPBkblbPS4/fwEttnxDYmVnTeQfvIgtu
         Z+YbnGn8DWLy1q2iz2YfcCmLty98SSZWCJYKmXxBAvl2D10gtrQkThFKHcTRIFhrJY7E
         ir+MH3q98CKgpK2HPAYLC7sWTs6RDZfPtXNe35ikItWQSFL1yq+fM2+f/sGjI670cO08
         qzuw==
X-Gm-Message-State: AOJu0Yyt7hzrnlwTjIoDC46pP699ZTZJ1xNrdK2oSaC2/beM9nuMXXqZ
	xvKwHHSzCadZCa2P6b/0vvjk4xITKRSq/XGbO9WmHwSpUjD50xY6k6bhnhiInsWuZDEjtGK+V+w
	TC7xramFgEBTVdO6z4qmQtzEkI1p9iuQ=
X-Gm-Gg: ASbGncsaGUVGbIs4ECrF2+B811DZvh5AVsaZu+KQoU8e5jzfxg6R9kMPAFYpTZbXr94
	ROk07TxqcrL1//BueaDs/9IZohtxUU48Lc3xkTUYtyw90KHS6l9AfqnbPSHzC2Xq8gvK+xWDLKy
	pyIjyD/1mwLsym51mZjw5Vps8ZpbQ37Sc0OxxF7n9+qYBSwCMZecgrXS9WXUiv5BChFW4PlW7GG
	/hfeLYz6g==
X-Google-Smtp-Source: AGHT+IFN2ruPpX+rF3CSC3fCNb412lYmuHqhuMWiuWtoCdAs9xgtJHMTzjNJTXkuvgnkR3mx/81ySQNtS5IkrjwEqec=
X-Received: by 2002:a17:906:d554:b0:ad4:f517:ca3 with SMTP id
 a640c23a62f3a-af94003330fmr773758866b.20.1754252840486; Sun, 03 Aug 2025
 13:27:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017233022.238250-1-vassilisamir@gmail.com>
 <20250803140802.36888-1-Achim.Gratz@Stromeko.DE> <20250803140802.36888-4-Achim.Gratz@Stromeko.DE>
In-Reply-To: <20250803140802.36888-4-Achim.Gratz@Stromeko.DE>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 3 Aug 2025 22:26:44 +0200
X-Gm-Features: Ac12FXwNImI-zfymMwzgc7ias5bvoBWOW5XmbnxhZ93gnwUyMKYPGOXVgkF0toU
Message-ID: <CAHp75VfhzJrPU6E=potYqPDYMbimhOy7edw9U0MfKsYMYwo8Sw@mail.gmail.com>
Subject: Re: [bmp280 v1 3/6] iio: pressure: bmp280: implement
 sampling_frequency for BMx280
To: Achim Gratz <Achim.Gratz@stromeko.de>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 3, 2025 at 4:09=E2=80=AFPM Achim Gratz <Achim.Gratz@stromeko.de=
> wrote:
>
> As was already commented in bm280.h:468, sampling_frequency can be
> emulated on BMx280 devices indirectly via t_standby configuration.
> Actually implement it to enable this useful feature.  This allows to
> switch between MODE_FORCED and MODE_NORMAL operation and use the same
> sysfs reads for both modes.
>
> The actual sampling frequency depends on the oversampling_ratio
> settings. In order to not complicate the code too much, the available
> sampling frequency values are fixed and have been calculated for
> oversampling_ratio=3D1 on all three channels assuming maximum
> measurement duration per the data sheet, corresponding to the minimum
> achievable sampling frequency for the highest measurement speed
> configuration.
>
> THe ODR tables for the BM[35]80 devices have been extended to allow
> for MODE_FORCED operation also and the handling of the table values
> adapted accordingly.
>
> Report of the actual sampling frequency via sysfs is possible, but not
> yet implemented.  In preparation for that implementation the
> calculation of measurement time has been factored out from
> bmp280_wait_conv into bmp280_calc_meas_time_us.

...

The comments below make my eyebrows rise. Can you add a comment on top
explaining the relation between ODR Hz and t_sb, because it's
obviously not an inverted proportion.

> +enum bmp280_odr {
> +       BMP280_ODR_0HZ,         /* MODE_FORCED */
> +       BMP280_ODR_110HZ,       /* t_sb =3D  0.5ms */
> +       BMP280_ODR_14HZ,        /* t_sb =3D 62.5ms */
> +       BMP280_ODR_7_5HZ,       /* t_sb =3D  125ms */
> +       BMP280_ODR_3_85HZ,      /* t_sb =3D  250ms */
> +       BMP280_ODR_1_96HZ,      /* t_sb =3D  500ms */
> +       BMP280_ODR_0_99HZ,      /* t_sb =3D 1000ms */
> +       BMP280_ODR_0_49HZ,      /* t_sb =3D 2000ms */
> +       BMP280_ODR_0_24HZ,      /* t_sb =3D 4000ms */
> +};
> +
> +enum bme280_odr {
> +       BME280_ODR_0HZ,         /* MODE_FORCED */
> +       BME280_ODR_110HZ,       /* t_sb =3D  0.5ms */
> +       BME280_ODR_14HZ,        /* t_sb =3D 62.5ms */
> +       BME280_ODR_7_5HZ,       /* t_sb =3D  125ms */
> +       BME280_ODR_3_85HZ,      /* t_sb =3D  250ms */
> +       BME280_ODR_1_96HZ,      /* t_sb =3D  500ms */
> +       BME280_ODR_0_99HZ,      /* t_sb =3D 1000ms */
> +       BME280_ODR_51HZ,        /* t_sb =3D   10ms */
> +       BME280_ODR_34HZ,        /* t_sb =3D   20ms */
> +};

...

>         switch (mask) {
>         case IIO_CHAN_INFO_PROCESSED:
> -               /* switch off unused channels */
>                 switch_off =3D 0;
> -               switch (chan->type) {

AFAIU this code piece was just invented by one of the previous
patches. Can we just go to the point from the first one, please, and
avoid this ping-pong style of patching?

> -               case IIO_HUMIDITYRELATIVE:
> -                       temp_oversampling_press =3D 0-1;
> -                       switch_off |=3D (prev_oversampling_press > switch=
_threshold);
> -                       /* can't be switched off as it is needed for comp=
ensation */
> -                       temp_oversampling_temp  =3D 1-1;
> -                       break;
> -               case IIO_PRESSURE:
> -                       temp_oversampling_humid =3D 0-1;
> -                       switch_off |=3D (prev_oversampling_humid > switch=
_threshold);
> -                       /* can't be switched off as it is needed for comp=
ensation */
> -                       temp_oversampling_temp  =3D 1-1;
> -                       break;
> -               case IIO_TEMP:
> -                       temp_oversampling_humid =3D 0-1;
> -                       temp_oversampling_press =3D 0-1;
> -                       switch_off =3D (prev_oversampling_humid > switch_=
threshold) |
> -                                    (prev_oversampling_press > switch_th=
reshold);
> -                       break;
> -               default:
> -                       return -EINVAL;
> +               if (data->op_mode =3D=3D BMP280_FORCED) {
> +                       /* switch off unused channels */
> +                       switch (chan->type) {
> +                       case IIO_HUMIDITYRELATIVE:
> +                               temp_oversampling_press =3D 0-1;
> +                               switch_off |=3D (prev_oversampling_press =
> switch_threshold);
> +                               /* can't be switched off as it is needed =
for compensation */
> +                               temp_oversampling_temp  =3D 1-1;
> +                               break;
> +                       case IIO_PRESSURE:
> +                               temp_oversampling_humid =3D 0-1;
> +                               switch_off |=3D (prev_oversampling_humid =
> switch_threshold);
> +                               /* can't be switched off as it is needed =
for compensation */
> +                               temp_oversampling_temp  =3D 1-1;
> +                               break;
> +                       case IIO_TEMP:
> +                               temp_oversampling_humid =3D 0-1;
> +                               temp_oversampling_press =3D 0-1;
> +                               switch_off =3D (prev_oversampling_humid >=
 switch_threshold) |
> +                                            (prev_oversampling_press > s=
witch_threshold);
> +                               break;
> +                       default:
> +                               return -EINVAL;
> +                       }
>                 }

Oh, yeah, my recommendation to refactor will really help to address
the above comment. So, not just consider, but please indeed refactor
code first. Ditto for the other switch-case and related pieces.

...

> +static const int bmp280_odr_table[][2] =3D {
> +       [BMP280_ODR_0HZ]        =3D {0,       0}, /* MODE_FORCED */

Why is the comment repeated here?

> +       [BMP280_ODR_110HZ]      =3D {110,     0},
> +       [BMP280_ODR_14HZ]       =3D {14,      0},
> +       [BMP280_ODR_7_5HZ]      =3D {7,  500000},
> +       [BMP280_ODR_3_85HZ]     =3D {3,  850000},
> +       [BMP280_ODR_1_96HZ]     =3D {1,  960000},
> +       [BMP280_ODR_0_99HZ]     =3D {0,  990000},
> +       [BMP280_ODR_0_49HZ]     =3D {0,  490000},
> +       [BMP280_ODR_0_24HZ]     =3D {0,  240000},
> +};
> +
> +static const int bme280_odr_table[][2] =3D {
> +       [BME280_ODR_0HZ]        =3D {0,       0}, /* MODE_FORCED */

Ditto.

> +       [BME280_ODR_110HZ]      =3D {110,     0},
> +       [BME280_ODR_14HZ]       =3D {14,      0},
> +       [BME280_ODR_7_5HZ]      =3D {7,  500000},
> +       [BME280_ODR_3_85HZ]     =3D {3,  850000},
> +       [BME280_ODR_1_96HZ]     =3D {1,  960000},
> +       [BME280_ODR_0_99HZ]     =3D {0,  990000},
> +       [BME280_ODR_51HZ]       =3D {51,      0},
> +       [BME280_ODR_34HZ]       =3D {34,      0},
> +};

...

> +static int bmp280_wait_conv(struct bmp280_data *data)
> +{
> +       unsigned int reg, meas_time_us;
> +       int wait_cycles =3D BMP280_MEAS_WAITCYCLES;

Signed?

> +       int ret;

...

> +       u8 tstby =3D FIELD_PREP(BMP280_TSTBY_MASK,
> +                             (data->sampling_freq ? data->sampling_freq =
- 1 : 0));

Redundant parentheses, also possible shorten this to

(data->sampling_freq ?: 1)  - 1

...

>         ret =3D regmap_update_bits(data->regmap, BMP280_REG_CONFIG,
> -                                BMP280_FILTER_MASK,
> -                                BMP280_FILTER_4X);
> +                                BMP280_FILTER_MASK |
> +                                BMP280_TSTBY_MASK,
> +                                tstby | BMP280_FILTER_4X);


Make this more consistent (same parameter on the same columns and
perhaps one line for each)

_FILTER_MASK | _TSTBY_MASK,
_FILTER_4X | tstby


...

> +       .sampling_freq_default =3D BMP280_ODR_0HZ, /* MODE_FORCED */

Why is this comment repeated all over the code? Any justification why
it's so important, please?

--=20
With Best Regards,
Andy Shevchenko

