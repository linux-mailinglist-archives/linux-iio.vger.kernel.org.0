Return-Path: <linux-iio+bounces-22285-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2F6B1A31D
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 15:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAF683B0CDB
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 13:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F4E26656D;
	Mon,  4 Aug 2025 13:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+3xJstu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C2F262FE5;
	Mon,  4 Aug 2025 13:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754313638; cv=none; b=gsKqa/QCsdcErlAg+PYkrsPSArRvqPAFwG0r5DHCRzdLWDOHS/YAtwhKt4pNHWkhfHq+QggIzLX4uKB24/J7VfdKksYlFPn5RZHT6z7DPNjdd0E+J4BqjE3n5FIUBoYRw+D/sH9LJ5p+NgwysV7c5Fj+jqs/3tm+WSAMFwlST8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754313638; c=relaxed/simple;
	bh=xUJp6yI+hjv4UYDrCNusaF8cgIWHM7CBfcUbTfyFUF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K9TtLrdrUZA0meArFnDgWV7J8nSerpTkYo+NVDnBB31jdz34DVyJ83USk9uaAAE9ER8DEMogizWXZqdW7rCYgJMZdaT2iHyEUxURj62gtx1JScyQVKFtx8h0PA3ZImiZ8v7Twc2LeeuZZVATUoTvWuQLq/fU4/aGaYHJlEKU55I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+3xJstu; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-af8fd1b80e5so729226866b.2;
        Mon, 04 Aug 2025 06:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754313633; x=1754918433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8uNMJX530UJ5/FMBVTRpdxGyIh+Z1Pm9NrQtCU29omM=;
        b=m+3xJstumtX4UImZyLUeveBAqV3/e6FVbG6j/ItnGint5zYbPDlJjT+lAhvY+uhldL
         2imagpQDVZCgxPWgYppy7vEbienRC2iUqxPMLBVUDFp9Tq4Ew8qlHJJPFjQFXmtF7y4x
         6WRzhtbJCPgcJK8HP/m8scFUFoi1UA3CLAUheJSU8kLSykRiuuG9O31tBaFYy38JX3kG
         YCVlLDneONET4JM6LPcv5UhDmwT3XCM5XTZ/SQPiaM6/ze++WhIjO5QoQTTNdhZdthuK
         gS6p7UuENoMeXqTlEiNZGvj9o40u7YaXvNKIVmntCinYMTTbExLAgFuH97IQXBFTRlEH
         fJSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754313633; x=1754918433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8uNMJX530UJ5/FMBVTRpdxGyIh+Z1Pm9NrQtCU29omM=;
        b=RKKVeHoAoyYWwjbLkUBvoMgdA4F3X/23auUqqtzeThZe0ZX3mfYfTqm4QWcJyhfS80
         dXEo+8hAMDH9G/GNdAHay05q8gohAbPhY4cWPTT2P+XOwk3tXgurwdMKgFaslukfxuVA
         HHOyizGcxGfJaLjlkauONt8oWUydMDEADViGvG/ria9mQ3XH8dfjGQyuJ0L5PZMmHyti
         xxEET7J/3EOSR32jtNQARIOyTcepBy6V1Qo+lhKKfS4xiyaxxD3a2EQTRFeVG7lAp+CC
         DjaPWZo5x3q71JzsFdoIng8b5LMA7azEYkw1GwRQZKlitVrYTkEps8Ph4nyXSjFgYQxw
         W3dg==
X-Forwarded-Encrypted: i=1; AJvYcCUDjQIHjNK7gkbwDV8P4S3gihKDUZ8W2ovNcotx1AapcmDk93LzPIwAsDogW47mMZd9XZp24VVTUQMs@vger.kernel.org, AJvYcCXSCwd3PBKn4tmGEeKhdYPWhlU6R9/YrJzOyh8f0JotqPZt4D1AuGgkmrdbRhl7s03+iRUaFqBMIL5MmU/2@vger.kernel.org, AJvYcCXaHzfuKhuLsU5GVezvYb+wV9YAil/9kGNYSgjxqBtKGpuYccn3sMRl4vjiiD0yF8MY8n6iEm4dQCTb@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+XwxMbu7AF6RLGAeJUjvQUuoV11j+CisBqYF0gDPNHjbVXhOP
	1qKcSaC1acztb0Zi7QFbXjz9doF4M0XZ8acdp8b25JMI7PayxX/3JzAbVrg/p3dvlmglHBxRTU6
	h0Ep5hNIxgTRAJGS6dlm8d+pltE23e+U=
X-Gm-Gg: ASbGncs5KU1/iFIjlocQt88XhxI6TR18OThkQs6asuZEOHp6drnvOcRkJYKC+4OZAKg
	e9Ghcozb9vz2KIxFbUhh4a4HjWPxWIGQZIvssxsXoabWypvN34qilKyrKzvGZIka2sLpCcn5z4s
	Ms89q0XuEZ7ISBvE/qj85i0KQD8FS+ddRcjIgTNlV+0Ocd2eHuLLxm/YNplKUNo8JIPJIAEbzvr
	oGOtNiRNg==
X-Google-Smtp-Source: AGHT+IH55Yo1BgDPedqMf76upD4RRZOwqu/nbofA0uIoYKNZwi6dqXWIkk5A1EpmC7x7m7FwcTy17me/S9RW0g81Zc8=
X-Received: by 2002:a17:907:9812:b0:af6:3194:f024 with SMTP id
 a640c23a62f3a-af940081981mr890827266b.13.1754313632780; Mon, 04 Aug 2025
 06:20:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804100219.63325-1-varshini.rajendran@microchip.com> <20250804100219.63325-10-varshini.rajendran@microchip.com>
In-Reply-To: <20250804100219.63325-10-varshini.rajendran@microchip.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 4 Aug 2025 15:19:55 +0200
X-Gm-Features: Ac12FXyVSAOQ2aISM_03IMhcULkAAa8cSQa55tHeNKnPhc_HQaN3w3aON3y7Tjs
Message-ID: <CAHp75VddM_4efeC_YpTya81DrSzdo2AQKJEQ4z21KiCT3gt0TQ@mail.gmail.com>
Subject: Re: [PATCH 09/15] iio: adc: at91-sama5d2_adc: adapt the driver for sama7d65
To: Varshini Rajendran <varshini.rajendran@microchip.com>
Cc: eugen.hristev@linaro.org, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, nicolas.ferre@microchip.com, 
	alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev, srini@kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 4, 2025 at 12:03=E2=80=AFPM Varshini Rajendran
<varshini.rajendran@microchip.com> wrote:
>
> Add support to sama7d65 ADC. The differences are highlighted with the
> compatible. The init and parsing of the temperature sensor and
> calibration indexes are the main differences.

...

> +static int at91_sama7d65_adc_temp_sensor_init(struct at91_adc_state *st,
> +                                             struct device *dev);

Again, please try to avoid forward declarations. They make code harder
to maintain.

...

> +enum at91_sama7d65_adc_ts_clb_idx {
> +       AT91_SAMA7D65_ADC_TS_CLB_IDX_P1 =3D 2,
> +       AT91_SAMA7D65_ADC_TS_CLB_IDX_P4 =3D 1,
> +       AT91_SAMA7D65_ADC_TS_CLB_IDX_P6 =3D 4,
> +       AT91_SAMA7D65_ADC_TS_CLB_IDX_MAX =3D 10,

MAX and trailing comma are odd when they go together.

> +};

...

> +static const struct at91_adc_platform sama7d65_platform =3D {
> +       .layout =3D &sama7g5_layout,
> +       .adc_channels =3D &at91_sama7g5_adc_channels,
> +#define AT91_SAMA7D65_SINGLE_CHAN_CNT  16
> +#define AT91_SAMA7D65_DIFF_CHAN_CNT    8
> +#define AT91_SAMA7D65_TEMP_CHAN_CNT    1
> +       .nr_channels =3D AT91_SAMA7D65_SINGLE_CHAN_CNT +
> +                      AT91_SAMA7D65_DIFF_CHAN_CNT +
> +                      AT91_SAMA7D65_TEMP_CHAN_CNT,
> +#define AT91_SAMA7D65_MAX_CHAN_IDX     (AT91_SAMA7D65_SINGLE_CHAN_CNT + =
\
> +                                       AT91_SAMA7D65_DIFF_CHAN_CNT + \
> +                                       AT91_SAMA7D65_TEMP_CHAN_CNT)
> +       .max_channels =3D ARRAY_SIZE(at91_sama7g5_adc_channels),
> +       .max_index =3D AT91_SAMA7D65_MAX_CHAN_IDX,
> +#define AT91_SAMA7G5_HW_TRIG_CNT       3
> +       .hw_trig_cnt =3D AT91_SAMA7G5_HW_TRIG_CNT,
> +       .osr_mask =3D GENMASK(18, 16),
> +       .oversampling_avail =3D { 1, 4, 16, 64, 256, },
> +       .oversampling_avail_no =3D 5,
> +       .chan_realbits =3D 16,
> +       .temp_sensor =3D true,
> +       .temp_chan =3D AT91_SAMA7G5_ADC_TEMP_CHANNEL,
> +       .temp_init =3D at91_sama7d65_adc_temp_sensor_init,
> +};

It's harder to read the static assignment interleaved by the sparse
definitions. Can't you group definitions followed by the initialiser?

...

> +static int at91_sama7d65_adc_temp_sensor_init(struct at91_adc_state *st,
> +                                             struct device *dev)
> +{
> +       struct at91_adc_temp_sensor_clb *clb =3D &st->soc_info.temp_senso=
r_clb;
> +       struct nvmem_cell *temp_calib;
> +       u32 *buf =3D NULL;

What for this NULL initialiser?

> +       size_t len;
> +       int ret =3D 0;

This initialisation can be avoided (see below how).

> +       if (!st->soc_info.platform->temp_sensor)
> +               return 0;
> +
> +       /* Get the calibration data from NVMEM. */
> +       temp_calib =3D devm_nvmem_cell_get(dev, "temperature_calib");
> +       if (IS_ERR(temp_calib)) {
> +               ret =3D PTR_ERR(temp_calib);
> +               if (ret !=3D -ENOENT)
> +                       dev_err(dev, "Failed to get temperature_calib cel=
l!\n");
> +               return ret;
> +       }
> +
> +       buf =3D nvmem_cell_read(temp_calib, &len);
> +       if (IS_ERR(buf)) {
> +               dev_err(dev, "Failed to read calibration data!\n");
> +               return PTR_ERR(buf);
> +       }

...

> +       /*
> +        * We prepare here the conversion to milli from micro to avoid

Here we prepare the...

> +        * doing it on hotpath.
> +        */

...

> +free_buf:
> +       kfree(buf);
> +       return ret;

Can't use cleanup.h? I.e. __free().

--=20
With Best Regards,
Andy Shevchenko

