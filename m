Return-Path: <linux-iio+bounces-16352-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61183A4E1C6
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 15:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C94B0188316C
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 14:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2346324BD1C;
	Tue,  4 Mar 2025 14:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rdj8m4rS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8942517BB
	for <linux-iio@vger.kernel.org>; Tue,  4 Mar 2025 14:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741099526; cv=none; b=ox+ORGiauftApabkPZhxomMEvoHd4SwDy6E0tBUtuBhA9VVU8bhR/8FPEtXMDRosR62ckV91QW3B74fp1QL1hFx/tjWu1Zt6bQDm6/SketFEinn8S5P3KONWe7R6kEh2mO/ESiweugeAX5BB1oA0MajzYdUXW2GumHS7iLJ8zBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741099526; c=relaxed/simple;
	bh=jKdpkROggTpGv8i7lEqCeoDnoMhE9yvTEkBnneKoX/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EqAU+DGejNeu31SBwbU93eETQW/N5klJmUbEO3MRpns4HxGowfJwqLqW1M6Hdq8R2nXtweKAdl0+sv7KROvP5umx81AvVsCwk26DFbuVceH2e7RaH9IJnVHOK78E8yupuH0GKcjMuqVTakUEzRedICy2uUuojtj33zLaTB9ZDCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rdj8m4rS; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30613802a6bso61153021fa.1
        for <linux-iio@vger.kernel.org>; Tue, 04 Mar 2025 06:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741099522; x=1741704322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TETrHFzeOASenqMV9S9QwkBZdWbDaJ44vy3Vca6/dVU=;
        b=rdj8m4rSLSJKTDoGbzAdjQsZ3OS+JQmMqW3laXfGaj2lRh17o2j0JK/1P/RPvSYPj+
         54VONGuvrWWINZs68Wh3cW4v2/kcYyiW4XxRny9pL3T+ngO/SYK1dTrWE+hRmd8TCW2a
         Usuwt4U+GghZqCUoRxcNb2iqwq6dTMZP3cc7Tx/ymm5ctquH467NBFazrR9E74AjNTOD
         dowkJOSNFAR9OOThiCmAmNF5Jdjht0qtuCx9VsrH9n5HpOc1LAxgB4p8IG4yXRRBIHq9
         MnKm8oC6X1HK5HFIKWVQ9HihrVHHmYoVjN4AohwahRuqkSeaJKWLl4UZdlr/Vk+Nw20t
         +Hgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741099522; x=1741704322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TETrHFzeOASenqMV9S9QwkBZdWbDaJ44vy3Vca6/dVU=;
        b=nrAnsuuIo/3Krnp4bG3BEGmk/OYd3a5MITeT2BHcHijj+p60ty5yk0kVv5GvuF9Tfn
         QhKqALsBiJicjYHYEm0IDWJp7SFtmgywgW//atbAjeXnEHTwZKE9OiIoBOVJEuc8pFLV
         zpxoFZHzMXciwzVSWjhROiGLMz/pY+jOT5ndQBpS9mapRCSNzKdster1USwgbEL9e8De
         5nq0B6NopJnBtOMubn28++ZUdwq6fAEP+VyqmHNomMJgDV4Ta68rtJtatfHH6teReoK7
         lm3O6QvOrvBiMrtGel3R47UtyIH6HUazrSbSYyzIG3QwYOdK9DJrwWw8RSYxQItdHFn4
         RW2A==
X-Forwarded-Encrypted: i=1; AJvYcCXplNg58cp6o3O5DyWKt2+InY/08+AIKnvoAbq3JUX2AspmI4h+FchCT9aL1o6+1luAQmMyC/ZIlwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzaclUP7Gwn+LrtEdEWpV7CVtO514VY0PzzCvw9SRrgKcM+qrV
	PHC4hRJJSXBi4pChQnsR8xcwrzwpMQsIb18HYQ3iWUkonyy18hpaOBm1o1v730XVpmz1hcw3dTU
	8eEUfCrxWZZSwygkMp5U62kgaKNVFAcHliN/sFQ==
X-Gm-Gg: ASbGncvoWQKwIlBr/VtNMt/YWf/4cyFMf/PIoogmq3hgbAjq+NDF4mj29z3chJdiCFv
	tp9ZnhWnZpMuAgbgFVSdgfwbb2dpxXVgNRr0tLBgJP7JvBj9U2iorg5x/E8zzQ2bj4eJ6XzlPbH
	yl6U2/9D6FQZqGs6y0Xdd2S8e8Og==
X-Google-Smtp-Source: AGHT+IETKuyPMVM5CdYgZm14hIMgbe8X/D5820Fs21Iu8QTNB9GUGUO3MUy3gVkpuL3W82B4uH6iGXTKzY4qdWaX2WU=
X-Received: by 2002:a2e:91c3:0:b0:30b:9813:b00c with SMTP id
 38308e7fff4ca-30b9813b714mr64990571fa.27.1741099521825; Tue, 04 Mar 2025
 06:45:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304-wip-bl-spi-offload-ad7380-v2-0-0fef61f2650a@baylibre.com>
 <20250304-wip-bl-spi-offload-ad7380-v2-2-0fef61f2650a@baylibre.com>
In-Reply-To: <20250304-wip-bl-spi-offload-ad7380-v2-2-0fef61f2650a@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 4 Mar 2025 15:45:10 +0100
X-Gm-Features: AQ5f1JpGYBLGOoxbrmddIe3_7MKUmgER6V4l4XNFfg4pNtoeYf3XgHXjFSF6e-E
Message-ID: <CAMknhBFfjo_bWZ7=9LD10y02WTVanCYhQpMNk834k8P3iQ_uFw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] docs: iio: ad7380: add SPI offload support
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 10:39=E2=80=AFAM Angelo Dureghello
<adureghello@baylibre.com> wrote:
>
> Document SPI offload support for the ad7380 driver.
>
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
>  Documentation/iio/ad7380.rst | 54 +++++++++++++++++++++++++++++++++++---=
------
>  1 file changed, 43 insertions(+), 11 deletions(-)
>
> diff --git a/Documentation/iio/ad7380.rst b/Documentation/iio/ad7380.rst
> index cff688bcc2d9601a9faf42d5e9c217486639ca66..e593ab6037b0da4cebfad1483=
13f21cca7f00fd4 100644
> --- a/Documentation/iio/ad7380.rst
> +++ b/Documentation/iio/ad7380.rst
> @@ -142,21 +142,21 @@ Example for AD7386/7/8 (2 channels parts):
>  .. code-block::
>
>            IIO   | AD7386/7/8
> -                |         +----------------------------
> -                |         |     _____        ______
> -                |         |    |     |      |      |
> +                |         +----------------------------
> +                |         |     _____        ______
> +                |         |    |     |      |      |
>         voltage0 | AinA0 --|--->|     |      |      |
> -                |         |    | mux |----->| ADCA |---
> +                |         |    | mux |----->| ADCA |---
>         voltage2 | AinA1 --|--->|     |      |      |
> -                |         |    |_____|      |_____ |
> -                |         |     _____        ______
> -                |         |    |     |      |      |
> +                |         |    |_____|      |_____ |
> +                |         |     _____        ______
> +                |         |    |     |      |      |
>         voltage1 | AinB0 --|--->|     |      |      |
> -                |         |    | mux |----->| ADCB |---
> +                |         |    | mux |----->| ADCB |---
>         voltage3 | AinB1 --|--->|     |      |      |
> -                |         |    |_____|      |______|
> -                |         |
> -                |         +----------------------------
> +                |         |    |_____|      |______|
> +                |         |
> +                |         +----------------------------
>

It looks like this is just cleaning up whitespace, so should be in a
separate patch.

>
>  When enabling sequencer mode, the effective sampling rate is divided by =
two.
> @@ -169,6 +169,38 @@ gain is selectable from device tree using the ``adi,=
gain-milli`` property.
>  Refer to the typical connection diagrams section of the datasheet for pi=
n
>  wiring.
>
> +
> +SPI offload support
> +-------------------
> +
> +To be able to achieve the maximum sample rate, the driver can be used wi=
th the
> +`AXI SPI Engine`_ to provide SPI offload support.
> +
> +.. _AXI SPI Engine: http://analogdevicesinc.github.io/hdl/projects/ad738=
x_fmc/index.html
> +
> +When SPI offload is being used, some attributes will be different.
> +
> +* ``in_voltage-voltage_sampling_frequency`` attribute is added for setti=
ng the
> +  sample rate.
> +* ``in_voltage-voltage_sampling_frequency_available`` attribute is added=
 for
> +  querying the max sample rate.
> +* ``timestamp`` channel is removed.
> +* Buffer data format may be different compared to when offload is not us=
ed,
> +  e.g. the ``buffer0/in_voltage0-voltage1_type`` and the
> +  ``buffer0/in_voltage2-voltage3_type`` attributes.
> +
> +.. seealso:: `SPI offload support`_

This is referring to the same section, so doesn't make sense here.

> +
> +Effective sample rate for buffered reads
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Using SPI offload, the PWM generator drives the starting of the conversi=
on by
> +executing the pre-recorded SPI transfer at each PWM cycle, asserting CS =
and
> +reading the previous available sample values for all channels.
> +Default sample rate is set to a quite low frequency, to allow oversampli=
ng x32,
> +user is then reponsible to adjust ``in_voltage-voltage_sampling_frequenc=
y`` for

s/reponsible/responsible/

> +the specific case.

Another important thing to mention here is that for single-ended chips
where we have 2 banks of simultaneous inputs, if at least one channel
from each bank is enabled in a buffered read, the effective sample
rate will be 1/2 of what ``in_voltage-voltage_sampling_frequency``
says because a separate conversion needs to be done for each bank.

> +
>  Unimplemented features
>  ----------------------
>
>
> --
> 2.48.1
>

