Return-Path: <linux-iio+bounces-12518-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEE39D64D0
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2024 21:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CBCEB21D27
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2024 20:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBEF175D38;
	Fri, 22 Nov 2024 20:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SuBT+1UU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEBD158DA3;
	Fri, 22 Nov 2024 20:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732306711; cv=none; b=BCTEq204Hw1sDgX8BjLSyj80xZX0/fzau7lU39sVFQ7PUWYGxZ7B/M7HUZFeGHsEcnlrkPM1SF2mtjOOmgU+Uz0c1mJPrjjOfnFP5qhWSAG9DoAPXGSoy5kfOHoyVf7FRXioiF3VxHX9TMFchZMam8UwdlJ1VL3D3VYdYDRn7Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732306711; c=relaxed/simple;
	bh=NH8Cib549nRPR2nrH+duRUcPRtLmJCXGYFg5JPI8qO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r2G7epg2MHUZOW1Vq1wH/Z2LkS6tWCZ0M3t9KBi88eZ96ikXYRvu1Q2N1A1/02sxmQUoUBKO7KKmcS5TxWgMncRAuaUh5XtKF/JuHyMVj4uWOTjQ3fvekKJpXb76h0huJrqrRhNWgi21XzaQSxniLwsy+vYEud3DPyjVT2zEeXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SuBT+1UU; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5ceca0ec4e7so2860654a12.0;
        Fri, 22 Nov 2024 12:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732306708; x=1732911508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iGhwe6p04v718Aq3l1QkLKkVuBpxdX/SdfLZdji1gxA=;
        b=SuBT+1UU3RNxuTQyHlJ/GifQ3Ty0s0DYxvkatoGZgk9HZ4HJ25+CgfbePAeZ0wnyvz
         L2jfB4pu/gmPWzgE9PyI0V99HNa4pCRXEjceye5vMn202t6gke9cyJf8oVxmGiod5HCN
         Va7DF7IpgcokgY+mLBKZ7WWsNIv8yJu33BSH7M0JYrjWpqD6o+v8XspKO3fJxeWlHQVp
         yYuys1xw51DGzhmHdAGAob29uja4TnSwasVuur/Uytx1woMV4NGTOjMEY+CahVjw4ZGL
         haCr84hG3A+On/i73RSRVjYQ08ts52cvb9nXuMfzV+lAdQrxZsTjFAr7I67lnWiz1CCM
         6ihA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732306708; x=1732911508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iGhwe6p04v718Aq3l1QkLKkVuBpxdX/SdfLZdji1gxA=;
        b=cT9lzTJdS+ztqPyRc+cXtY1PaWYhFnDsjr0GTkoTubNiJcRrhJDsRZG8EFeBKBkFqC
         A4VulasMZqoiIRPYYEUN5pptI/gwf+qj3MO1ELUEZmZI0McdNEEU23vg88v54dVyC/3L
         gRgLCoj+No5RGtvZI/+8ANnQoGL46YK7kvJXcmpX41L7YTKwIwb3zytFrmlvnTCdZ9Cr
         nvsaQKopSvLVt5j4qaSP5k3C+kJ6Zv3nivEuJOYcUiM7L7t/gqb4zryYTXbZAtD5Wf7W
         GrdH1wfnc/a9p7LxVy7+fazEFwdiwqJXP5q6jfsnVVRPXW5Kz/8Mg+ZyVgACOCazGGKF
         wv9A==
X-Forwarded-Encrypted: i=1; AJvYcCVWD5cWxhNTF2GC/pvceBvkZPnQO2258u90CUFwWiRPQkkVJVVb0CNr/nub//OZdZBSA65RSee9+Uvn@vger.kernel.org, AJvYcCVZPh8qdZfTCuon1n0FWETSDB0Msfw/tlqlQ1L1IZhQbsTPWHdEcp5/ZHTIx1kOYFmWEooLBMBDphqL@vger.kernel.org
X-Gm-Message-State: AOJu0YwSwbSIXU8q1ocrEgSOcOBi7YlLGXdbnJP1LnhBmwbLwe6LS2C7
	5u6lQEph32NpPV7fJwzlbjGhQm2JkapDafVZJO7JkdCtXkxVXgljcLGsl69zEyFoljmR2be4P0f
	ztIAPMjkd5HLNcQbLmt6wQRiLQs5VnivK
X-Gm-Gg: ASbGnctDDpAYdAMBvFiXryxIx3IBro8JM4vHjlBEjVe/7DSANUBYKvECNAaqBK/x2Zq
	fv1go6zWgkc7L3F8BZVV10AsBBy5u/kk=
X-Google-Smtp-Source: AGHT+IEg2mZ+11txTOaInr89UFwymZ8VqCrxPYZItS5nQDCe9hACEozC1DZEdZjPGmjBmJWEqHsUhHonYIGHh7MbPb0=
X-Received: by 2002:a05:6402:278e:b0:5ce:bdd8:18ca with SMTP id
 4fb4d7f45d1cf-5d0206240femr3278212a12.14.1732306707975; Fri, 22 Nov 2024
 12:18:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122113322.242875-12-u.kleine-koenig@baylibre.com> <20241122113322.242875-20-u.kleine-koenig@baylibre.com>
In-Reply-To: <20241122113322.242875-20-u.kleine-koenig@baylibre.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 22 Nov 2024 22:17:51 +0200
Message-ID: <CAHp75Vd_jVnf+oY7Y19pFiRVNUNT24J9i9spRRag-e0bw73pSw@mail.gmail.com>
Subject: Re: [PATCH v3 08/10] iio: adc: ad_sigma_delta: Check for previous
 ready signals
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Alexandru Ardelean <aardelean@baylibre.com>, 
	Alisa-Dariana Roman <alisa.roman@analog.com>, Conor Dooley <conor+dt@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Dumitru Ceclan <dumitru.ceclan@analog.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>, 
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2024 at 1:34=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> It can happen if a previous conversion was aborted the ADC pulls down
> the =CC=85R=CC=85D=CC=85Y line but the event wasn't handled before. In th=
at case enabling
> the irq might immediatly fire (depending on the irq controller's

immediately

> capabilities) and even with a rdy-gpio isn't identified as an unrelated
> one.
>
> To cure that problem check for a pending event before the measurement is
> started and clear it if needed.

...

> +static int ad_sigma_delta_clear_pending_event(struct ad_sigma_delta *sig=
ma_delta)
> +{
> +       int ret =3D 0;

Unneeded assignment, see below.

> +       bool pending_event;
> +
> +       /*
> +        * read RDY pin (if possible) or status register to check if ther=
e is an
> +        * old event.
> +        */
> +       if (sigma_delta->rdy_gpiod) {
> +               pending_event =3D gpiod_get_value(sigma_delta->rdy_gpiod)=
;
> +       } else {
> +               unsigned status_reg;
> +
> +               ret =3D ad_sd_read_reg(sigma_delta, AD_SD_REG_STATUS, 1, =
&status_reg);
> +               if (ret)
> +                       return ret;

Side note: in the initial logic the 0 assigned above is overwritten by
0 here. While it's not a technical problem, it might affect the
workflow in the future.

> +               pending_event =3D !(status_reg & AD_SD_REG_STATUS_RDY);
> +       }
> +
> +       if (pending_event) {

So, check for the error condition first pattern?

  if (!pending_event)
    return 0;

This among other benefits makes the below code less indented and hence
less LoCs to be occupied.

> +               /*
> +                * In general the size of the data register is unknown. I=
t
> +                * varies from device to device, might be one byte longer=
 if
> +                * CONTROL.DATA_STATUS is set and even varies on some dev=
ices
> +                * depending on which input is selected. So send one byte=
 to
> +                * start reading the data register and then just clock fo=
r some
> +                * bytes with DIN (aka MOSI) high to not confuse the regi=
ster
> +                * access state machine after the data register was compl=
etely
> +                * read. Note however that the sequence length must be sh=
orter
> +                * than the reset procedure.
> +                */
> +               unsigned int data_read_len =3D DIV_ROUND_UP(sigma_delta->=
info->num_resetclks, 8);

BITS_TO_BYTES()

> +               uint8_t data[9];

Why not u8?

> +               struct spi_transfer t[] =3D {
> +                       {
> +                               .tx_buf =3D data,
> +                               .len =3D 1,
> +                       }, {
> +                               .tx_buf =3D data + 1,
> +                               .len =3D data_read_len,
> +                       }
> +               };
> +               struct spi_message m;
> +
> +               /* Oh, back out instead of overflowing data[] */
> +               if (data_read_len > sizeof(data) - 1)
> +                       return -EINVAL;
> +
> +               spi_message_init(&m);
> +               if (sigma_delta->info->has_registers) {
> +                       unsigned int data_reg =3D sigma_delta->info->data=
_reg ?: AD_SD_REG_DATA;
> +
> +                       data[0] =3D data_reg << sigma_delta->info->addr_s=
hift;
> +                       data[0] |=3D sigma_delta->info->read_mask;
> +                       data[0] |=3D sigma_delta->comm;
> +                       spi_message_add_tail(&t[0], &m);
> +               }
> +
> +               /*
> +                * The first transferred byte is part of the real data re=
gister,
> +                * so this doesn't need to be 0xff. In the remaining
> +                * `data_read_len - 1` bytes are less than $num_resetclks=
 ones.
> +                */
> +               data[1] =3D 0x00;
> +               memset(data + 2, 0xff, data_read_len - 1);

> +               spi_message_add_tail(&t[1], &m);

Instead you can also use

  if (...)
    spi_message_init_with_transfers(..., 2);
  else
    spi_message_init_with_transfers(..., 1);


> +               ret =3D spi_sync_locked(sigma_delta->spi, &m);
> +       }
> +
> +       return ret;

return spi_sync_locked(...);

> +}

--=20
With Best Regards,
Andy Shevchenko

