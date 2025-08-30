Return-Path: <linux-iio+bounces-23430-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA197B3C8CE
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 09:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AABE5565A8C
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 07:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B18D278150;
	Sat, 30 Aug 2025 07:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPjrcQXQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D4213C3F6;
	Sat, 30 Aug 2025 07:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756539411; cv=none; b=rg79uVct1IXRtdyGfvLPks1L1uADhkdXUdQLiX6AWdpaE83LMhcmzzLYbn6Q/NS6qTfqGzEg57WO4spQgd/IarDKhh2hPlmAWUKu/em20et46vWGitUGfLWKUJbrxLFLbS13ygtXfYwEvq/ZuHL0C1XVDhWFLZrkFngAvUBHDZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756539411; c=relaxed/simple;
	bh=nwELxDxzSAOFGITdilBF/c44lqaQcxw4uOGtKRdodjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EcH13LTuaaBZIiTB50ShzQezuoMtnulZnZKsAM8uVsSXJ+g9tw8VJDVBXu18XdFoZG95KMOF/HuS2yWO76b2/u1mfSNTeHj8d5u08symSJJRYme8IVBO4/oKGsSyxqcabr8q5oRQDIFF6cKEo0ARpk8f+bLbxUm5kvXcbj8vsnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IPjrcQXQ; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aff0775410eso179419966b.0;
        Sat, 30 Aug 2025 00:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756539408; x=1757144208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SzmH4C1XJrne9YPtVNZi7FEYp3+WvxSqJ1AyOKPaNaM=;
        b=IPjrcQXQHH25hhH23ZZonEdYKH70q8JxT0jWxIDx3m+5HYf/lnqg/+Qd79G46RX9sG
         RKEv/kF8cTD6rx1p9oFUDw7Qm/0jFvSh2C5nhn4BhxWrh7MTOgXzGr5ETybG7/gI5Qkx
         hF4cftrYq+4O30DdZV5QIdVvO+u9J6d0wdYGyoqrranGSZA0TOE4py+PDxL/UF92iOeu
         OPmlXs2RMc32vpYZSqrJq+44ulTdGI136qYHKJ+bxyEshdo8nzFarMeqi838azuno8bc
         wLIx4JYreaCg53LDkoUz/4GZ3vCzuJKrBRYrj8uPcqaU724adMNsJyTDOyFfKghrcpO9
         G0Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756539408; x=1757144208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SzmH4C1XJrne9YPtVNZi7FEYp3+WvxSqJ1AyOKPaNaM=;
        b=oVRx6fb4YPSBYZfIjCwP699SHVDAiL1FXRkCvd7IFJz3/9W5x/Pcdrtk/yzHPCNzeT
         8IbuViWAb5lS5PKVHaxIgvS1IhFC5cutduP59KGbouMt75VJKgHOgWN4oUv/g/SSZciz
         2Zfm+O4XFoFDiWVFDz2qomYcYkIb9sT7qugJGgOe4IuKFhvqifUJjJvKjcdt6eZWMRHB
         raznUEcQIDDjCu36Jdt+FAmUO9+Efyd06J22uoNbgJdbOWshm9irjftaBPqCnzLbqpE/
         QFQ0Zy3kkQyVyXauPzNWf1iPm5rTE+6rri6jCgGCiTirdVrJ3ixkR76xUH7zYYDeP0Lm
         TeAg==
X-Forwarded-Encrypted: i=1; AJvYcCUOq1byOeafRjxSjct0cjbgC2yJHSvmEzGH4YzLaFbBnm3ROmP66IduzX8YgRY71gb/g922Y6EQAE7c@vger.kernel.org, AJvYcCUR8epXiAjDHc5alPDIcz5I4IHYtM7YP367VQPzPx3yFOpU4HDVsaw6HOdSDzMU7F8g+IoCbjm3Im/elw2Y@vger.kernel.org, AJvYcCV2J+F5U/gKeL4d7WII+6253yZXxjy5EEk3v3QjM+r2R3+GUUn1TpZAeN4VfMArhXkXqk1h2wqLxjDZ@vger.kernel.org, AJvYcCVFUwfFJG47HmdrZi4XgXDOkJXp5WXwmNcsjbhzDV/p2JuRCw3F8f/rkUVf/prs4sxfnWkleknPFe3u@vger.kernel.org
X-Gm-Message-State: AOJu0YzcUzEZ6ljBC7SiTytS3pXiAyKeqLUse1p+J7yXhKO9PFWNh8O8
	pDutd+4uaDLybONFw4Xl7CYichjC/DawMpUO8UCNLgEMc1DQdxrC0b0kX6nsqInlx69Pqmumx3s
	mxTNFzgJbkMut7O+lNjjwiw/Xbrmm5QE=
X-Gm-Gg: ASbGnctE/VjkdnyNAJgdUt2mqzRqaOP5KZL6BIy9hrbkH3JPQNdAmIB9xran7dl1JGc
	KG6hErm+A+NH6rBCDhr/gBWhPraBVwiA1kDpjB+4C3WQVW7ghNOILiV8eheD25iF6SgNvyGtglQ
	lGFcOdrGevlpQrcWToM9xBun99A0+yVCMVTvJ4of6rrObz0BmweZcnKgw/fGN70wQgom2s8GWCO
	b0YJso=
X-Google-Smtp-Source: AGHT+IEOLPbp3qTZPtnFbQYyqJuzU7fRvjG8R4IVWcinxMBpTD+d0esX9RsjNuxUUL8rlpEr38nh8cs/LJ6G1NnKqaA=
X-Received: by 2002:a17:907:970f:b0:ae3:5185:5416 with SMTP id
 a640c23a62f3a-b01d8c74a17mr136545566b.13.1756539407942; Sat, 30 Aug 2025
 00:36:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1756511030.git.marcelo.schmitt@analog.com> <0d9f377295635d977e0767de9db96d0a6ad06de0.1756511030.git.marcelo.schmitt@analog.com>
In-Reply-To: <0d9f377295635d977e0767de9db96d0a6ad06de0.1756511030.git.marcelo.schmitt@analog.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 30 Aug 2025 10:36:11 +0300
X-Gm-Features: Ac12FXwg_QF3-9Cykf3CcyTZFU9PAwBoEab4GDUA14oUf05enERpJO1q4eCtTXQ
Message-ID: <CAHp75Vfu-C3Hd0ZXTj4rxEgRe_O84cfo6jiRCPFxZJnYrvROWQ@mail.gmail.com>
Subject: Re: [PATCH 07/15] iio: adc: ad4030: Add SPI offload support
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-spi@vger.kernel.org, jic23@kernel.org, Michael.Hennerich@analog.com, 
	nuno.sa@analog.com, eblanc@baylibre.com, dlechner@baylibre.com, 
	andy@kernel.org, corbet@lwn.net, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, broonie@kernel.org, Jonathan.Cameron@huawei.com, 
	andriy.shevchenko@linux.intel.com, ahaslam@baylibre.com, 
	sergiu.cuciurean@analog.com, tgamblin@baylibre.com, 
	marcelo.schmitt1@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 30, 2025 at 3:43=E2=80=AFAM Marcelo Schmitt
<marcelo.schmitt@analog.com> wrote:
>
> AD4030 and similar ADCs can capture data at sample rates up to 2 mega
> samples per second (MSPS). Not all SPI controllers are able to achieve
> such high throughputs and even when the controller is fast enough to run
> transfers at the required speed, it may be costly to the CPU to handle
> transfer data at such high sample rates.  Add SPI offload support for
> AD4030 and similar ADCs so to enable ADC data capture at maximum sample

Either add a comma after ADCs or drop 'so' word.

> rates.

> Cc: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> Cc: Nuno Sa <nuno.sa@analog.com>
> Cc: Trevor Gamblin <tgamblin@baylibre.com>
> Cc: Axel Haslam <ahaslam@baylibre.com>
> Cc: David Lechner <dlechner@baylibre.com>

First of all, please keep Cc:s just after the '---' line, which will
have the same effect for email and make the commit message less noisy.
Second, don't put Cc for the people that you already have other tags
for.
Here I found at least 3 people that are repeated in the given specific
tags below. By default the tools (git send-email) converts all tags to
the Cc automatically.

> Co-developed-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> Co-developed-by: Nuno Sa <nuno.sa@analog.com>
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> Co-developed-by: Trevor Gamblin <tgamblin@baylibre.com>
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> Co-developed-by: Axel Haslam <ahaslam@baylibre.com>
> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>

...

> -enum {
> +enum ad4030_lane_mode {

Sounds like a candidate for a separate change, but I haven't checked
how big this part is, so perhaps it's fine just to do it here.

...

>  static const int ad4030_average_modes[] =3D {
>         1, 2, 4, 8, 16, 32, 64, 128,
>         256, 512, 1024, 2048, 4096, 8192, 16384, 32768,
>         65536,

Side note, this looks like the list of bits, and can be optimised to use BI=
T().

>  };

...

> +       /*
> +        * The hardware does the capture on zone 2 (when spi trigger PWM
> +        * is used). This means that the spi trigger signal should happen=
 at
> +        * tsync + tquiet_con_delay being tsync the conversion signal per=
iod
> +        * and tquiet_con_delay 9.8ns. Hence set the PWM phase accordingl=
y.
> +        *
> +        * The PWM waveform API only supports nanosecond resolution right=
 now,
> +        * so round this setting to the closest available value.
> +        */
> +       offload_offset_ns =3D AD4030_TQUIET_CNV_DELAY_NS;
> +       do {
> +               config->periodic.offset_ns =3D offload_offset_ns;
> +               ret =3D spi_offload_trigger_validate(st->offload_trigger,=
 config);
> +               if (ret)
> +                       return ret;
> +               offload_offset_ns +=3D 10;

> +

Unneeded blank line.

> +       } while (config->periodic.offset_ns < AD4030_TQUIET_CNV_DELAY_NS)=
;

...

> +static int ad4030_set_sampling_freq(struct iio_dev *indio_dev, unsigned =
int freq)
> +{
> +       struct ad4030_state *st =3D iio_priv(indio_dev);
> +       int ret;
> +
> +       if (PTR_ERR_OR_ZERO(st->offload))
> +               return -EINVAL;

Why shadow the actual error code?

> +       if (!freq || freq > st->chip->max_sample_rate_hz)
> +               return -EINVAL;

in_range() ?

> +       ret =3D __ad4030_set_sampling_freq(st, freq);
> +       iio_device_release_direct(indio_dev);
> +
> +       return ret;
> +}

...

> +       case IIO_CHAN_INFO_SAMP_FREQ:
> +               if (PTR_ERR_OR_ZERO(st->offload))
> +                       return -EINVAL;

Shadowing an actual error code needs a good justification.

> +               ad4030_get_sampling_freq(st, val);
> +               return IIO_VAL_INT;


...

> +       st->offload_msg.offload =3D st->offload;
> +       ret =3D spi_optimize_message(st->spi, &st->offload_msg);
> +       if (ret < 0)

Why ' < 0'? Is it capable of returning positive values? If so, what
are their meanings?

> +               goto out_reset_mode;

...

> +       /*
> +        * Preemptively disable the PWM, since we only want to enable it =
with
> +        * the buffer

Missing period.

> +        */

...

> +static void ad4030_prepare_offload_msg(struct ad4030_state *st)
> +{
> +       u8 data_width =3D st->chip->precision_bits;
> +       u8 offload_bpw;
> +
> +       if (st->lane_mode =3D=3D AD4030_LANE_MD_INTERLEAVED)

> +               /*
> +                * This means all channels on 1 lane.
> +                */

This is a one line comment. Why 3 LoCs?

> +               offload_bpw =3D data_width * st->chip->num_voltage_inputs=
;
> +       else
> +               offload_bpw  =3D data_width;
> +
> +       st->offload_xfer.speed_hz =3D AD4030_SPI_MAX_REG_XFER_SPEED;
> +       st->offload_xfer.bits_per_word =3D offload_bpw;
> +       st->offload_xfer.len =3D roundup_pow_of_two(BITS_TO_BYTES(offload=
_bpw));
> +       st->offload_xfer.offload_flags =3D SPI_OFFLOAD_XFER_RX_STREAM;
> +       spi_message_init_with_transfers(&st->offload_msg, &st->offload_xf=
er, 1);
> +}

...

> +       /* Fall back to low speed usage when no SPI offload available. */

is available

And choose one style for one line comments and use it everywhere.

...

> +       if (ret =3D=3D -ENODEV) {
> +               /*
> +                * One hardware channel is split in two software channels=
 when
> +                * using common byte mode. Add one more channel for the t=
imestamp.
> +                */
> +               indio_dev->num_channels =3D 2 * st->chip->num_voltage_inp=
uts + 1;
> +               indio_dev->channels =3D st->chip->channels;
> +               indio_dev->available_scan_masks =3D st->chip->available_m=
asks;
> +
> +               ret =3D devm_iio_triggered_buffer_setup(dev, indio_dev,
> +                                                     iio_pollfunc_store_=
time,
> +                                                     ad4030_trigger_hand=
ler,
> +                                                     &ad4030_buffer_setu=
p_ops);
> +               if (ret)
> +                       return dev_err_probe(dev, ret,
> +                                            "Failed to setup triggered b=
uffer\n");

> +

Stray blank line.

> +       } else {
> +               /*
> +                * One hardware channel is split in two software channels=
 when
> +                * using common byte mode. Offloaded SPI transfers can't =
support
> +                * software timestamp so no additional timestamp channel =
is added.
> +                */
> +               indio_dev->num_channels =3D 2 * st->chip->num_voltage_inp=
uts;
> +               indio_dev->channels =3D st->chip->offload_channels;
> +               indio_dev->available_scan_masks =3D st->chip->available_m=
asks;
> +               ret =3D ad4030_spi_offload_setup(indio_dev, st);
> +               if (ret)
> +                       return dev_err_probe(dev, ret,
> +                                            "Failed to setup SPI offload=
\n");
> +
> +               ret =3D ad4030_pwm_get(st);
> +               if (ret)
> +                       return dev_err_probe(&spi->dev, ret,
> +                                            "Failed to get PWM: %d\n", r=
et);
> +
> +               ret =3D __ad4030_set_sampling_freq(st, st->chip->max_samp=
le_rate_hz);
> +               ad4030_prepare_offload_msg(st);
> +       }

...

> -       }
> +       },

You see, this is the point I always make about leaving trailing commas
in the non-terminator entries.
(It's just a good example I can't help comment on this just for others
to point out again on this)

...

> +       .max_sample_rate_hz =3D 2 * MEGA,

HZ_PER_MHZ


...

> +       .max_sample_rate_hz =3D 2 * MEGA,

Ditto.

...

> +       .max_sample_rate_hz =3D 2 * MEGA,

Ditto.

...

> +       .max_sample_rate_hz =3D 500 * KILO,

HZ_PER_KHZ

...

> +       .max_sample_rate_hz =3D 500 * KILO,

Ditto.

--=20
With Best Regards,
Andy Shevchenko

