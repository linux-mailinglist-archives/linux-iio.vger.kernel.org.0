Return-Path: <linux-iio+bounces-19742-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 539F2ABE185
	for <lists+linux-iio@lfdr.de>; Tue, 20 May 2025 19:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC8223A9270
	for <lists+linux-iio@lfdr.de>; Tue, 20 May 2025 17:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522E8270EC3;
	Tue, 20 May 2025 17:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="lTF5QwtG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F09025C6E7
	for <linux-iio@vger.kernel.org>; Tue, 20 May 2025 17:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747760825; cv=none; b=Zk54iykEWvXQDgWv9mRJSf4XRIiwgNtCEiR6GSvjGcVIYTH082YqzpO8seG1sLDE9WXAPZVIR2BbGxuH7mINDxELEvPKd5cZt0jHLsHhx/SA6RDEMwmI3Oy1D8uXjdlooQeGpo4X+tQcpl2aODFDGIOCrvOczvLLW/lqoskTm5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747760825; c=relaxed/simple;
	bh=Adr44lrbjsmXoOwujV+JXJKC/0dp11U+EuHbW3DQjGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=luRvDeDQRV19OljRSlxdxWAJAmaywaWdAEMc3fNRkkDRXikicAezc+UFAQbEaTkvg6cdP/UbYRRHE0Egy2nEcSXZyVRaKLmNJBhy+K7ARLIUTaclR5UgdBJtDn6+WSAcd7djCmdCh+dDNDmCyODcFamY0WmQP89vdsgVkuTOqrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=lTF5QwtG; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3292aad800aso9808311fa.0
        for <linux-iio@vger.kernel.org>; Tue, 20 May 2025 10:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1747760821; x=1748365621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKZ/DOS74Nf8VMwAesCPZapfqJEzoCeBvijff87jyRE=;
        b=lTF5QwtGMaBLkvztY7E3GRjU51KMstIpH2OjIiWiVDMUC1QVAguasaOAekQ1qTOOga
         aLBHhJr+n+poLCBVkmEhCJiyv52F2yOWtWuwCWoI9I4MNeQLIBcdFLwlP98uFEQFTC/S
         hGjYYV7q6nSdIoyHg5Eu5//EFGuuTVwEQ3i3CXVKXzwmAgwzcesAmr8UTmEMtgxCdoo5
         W5/xKEk0GWk7SdBR+l2PrRgOKTTatDummLwxO3/H6Zb6gyI26RHWPqcUQdk9QLbvvL3s
         +aTFwNudrIsNaFbVn0jcWwG30O0hSVYLKhZrBUNiq1ePkBFz4OUZg+PJaT/OVm21QO5C
         nv9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747760821; x=1748365621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LKZ/DOS74Nf8VMwAesCPZapfqJEzoCeBvijff87jyRE=;
        b=KWl8G9G2X6WOJj3+boAEnK1zjioq5t/YEeCSIA7r8u8AbKIhlS7riFaQLxEa2TqLUO
         +Q0aeudHm6Un/TNbIB7iE8Rujmbbs+b7+ddzle5ch3Q3Ds/EdfhkgqUM2EiF5cdTh317
         aXYLw0OyEzLhahDNnihByZ3E/fzuGEE9I68HQrUsOZjKYm3DNObmwe/f49EH63sIowI5
         38t3gcdeC9eHt6rKh3iioJ6KBV/p2bHT/NtQfUpM0NbU6U3GRknR8/3TDZn1vMWlx3LE
         cqbRY4lk6hdxFxDBToYpQwEEpQPXK98AZXFH1fiDzmtQ6sz832LE9MZmOINlFPqmkn/T
         EnXw==
X-Gm-Message-State: AOJu0Yzku6EdOLl+5f5IcR7J2xW1IuQvG9guspARAIJCXU3aLapeYSqm
	ZTP11GDY7CP5EY27lPTo06dLOaCiCbMY3BLxy949qqvTE3YI+TtSk1F//cauAPXf/NeAUpuyifN
	yKMjhAzBMT7UKLfbgxQqRpN9FzzAexyzfLmcrJtr9fu5+gDRdeTT/
X-Gm-Gg: ASbGnctYWeeiVO+P1ub3J+e+UZdAlJwfsjKN7dKD7io09Dy8XU8zY8LXjhg2hICC72x
	3qRWOhBcf1zkS9f6E3WDrY0zMSK+n62zgMKcpDzjIkF44tLZVwb73aPk47kvtfC77Uo0LxvjfW1
	XSbYDbMsPw3veWoMeu4j9c5UqLrmqU6HK9WaU1bHE5H/sY/pP4lSRoXYfpWvC0frs9
X-Google-Smtp-Source: AGHT+IE94WYPcJWNFg4NYJY80yMW+YBrxzlbo6GpAVtlZwVgXjjobfKZPhi/TuG+fBNOHPLriHho0nGdbtbKb+ATFBw=
X-Received: by 2002:a2e:ad0a:0:b0:328:c9c4:8ca5 with SMTP id
 38308e7fff4ca-328c9c48e0bmr53924511fa.9.1747760821408; Tue, 20 May 2025
 10:07:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1747083143.git.marcelo.schmitt@analog.com> <6e7dde3fa52161873c6e05891a7410bc8ef75249.1747083143.git.marcelo.schmitt@analog.com>
In-Reply-To: <6e7dde3fa52161873c6e05891a7410bc8ef75249.1747083143.git.marcelo.schmitt@analog.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 20 May 2025 19:06:49 +0200
X-Gm-Features: AX0GCFu-1HWUSDG-PKcPd3_RvCPjeJCFAZE3atYyLGkjJRLlS3BwEdYRGfrtQ1c
Message-ID: <CAMRc=MfJuT8q1jRMeSJQaE9aQGQFpph4O9TrE6xircqi3v5FgQ@mail.gmail.com>
Subject: Re: [PATCH v3 08/10] iio: adc: ad4170: Add GPIO controller support
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, jic23@kernel.org, 
	lars@metafoo.de, Michael.Hennerich@analog.com, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linus.walleij@linaro.org, marcelo.schmitt1@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025 at 2:36=E2=80=AFPM Marcelo Schmitt
<marcelo.schmitt@analog.com> wrote:
>
> The AD4170 has four multifunctional pins that can be used as GPIOs. The
> GPIO functionality can be accessed when the AD4170 chip is not busy
> performing continuous data capture or handling any other register
> read/write request. Also, the AD4170 does not provide any interrupt based
> on GPIO pin states so AD4170 GPIOs can't be used as interrupt sources.
>
> Implement gpio_chip callbacks to make AD4170 GPIO pins controllable throu=
gh
> the gpiochip interface.
>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> Change log v2 -> v3
> - Defined masks for updating GPIO mode register.
> - Replaced regmap_clear/set_bits() by regmap_update_bits() to set GPIO di=
rection.
> - Removed GPIO direction check before setting GPIO output values.
> - Made use of regmap_assign_bits() to set GPIO output reg bits.
> - Made value to be set as GPIO output state be either 0 or 1.
> - No longer locking on state mutex on GPIO set since GPIO output should n=
ot
>   conflict with other direct mode functionality (e.g. single-shot read).
>
>  drivers/iio/adc/Kconfig  |   1 +
>  drivers/iio/adc/ad4170.c | 224 ++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 224 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 6e4b14243599..a328f03eea34 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -78,6 +78,7 @@ config AD4170
>         select IIO_BUFFER
>         select IIO_TRIGGERED_BUFFER
>         depends on COMMON_CLK
> +       select GPIOLIB

In general GPIOLIB should be depended on, not selected.

The rest looks good to me so with that:

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

