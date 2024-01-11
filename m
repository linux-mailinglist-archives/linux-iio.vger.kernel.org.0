Return-Path: <linux-iio+bounces-1590-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BCB82B645
	for <lists+linux-iio@lfdr.de>; Thu, 11 Jan 2024 21:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F07521F25F14
	for <lists+linux-iio@lfdr.de>; Thu, 11 Jan 2024 20:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220C756B7B;
	Thu, 11 Jan 2024 20:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tOE4yu9j"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF5B58113
	for <linux-iio@vger.kernel.org>; Thu, 11 Jan 2024 20:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50e9e5c97e1so7039132e87.0
        for <linux-iio@vger.kernel.org>; Thu, 11 Jan 2024 12:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1705006460; x=1705611260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ylEjVhaN7U3+Tq2GKvOYEoSFBqgDAhHQ3vUsYifSnC4=;
        b=tOE4yu9j+QLc7Wfki9AdGF44qj/iBWUFqM5ZJFsNQWpL1WpJ9+s3K7Ri5MlTd3Y6jq
         +cACdkIVhIkWTYuKL8gGHNSyya5Ri38og5XVz5o5nZVsACpNXrh2QqPen/5QpAW9rEIs
         EHDeFMfGkMS1UCCp2iMQF/l4IHdn1FlrBmWNOJIJdFcnmeG9VOflgBSEUOfffReeITWN
         YHSd569no6sBeGMpzPFdD4PE+ur3iK44dU82ArHwN2UxAFsfX9NnPcc83DmlhL21q+pV
         CkTazHLJTSaR49NTfSI8RzukrT7pIQuFMd17mLouR5e85ev1Jlj9O2JzRm3CIyOQV/Yb
         kV6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705006460; x=1705611260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ylEjVhaN7U3+Tq2GKvOYEoSFBqgDAhHQ3vUsYifSnC4=;
        b=sYHn2nfpiGm0LLwCKsLXCyFMejcv2B3KwZ0azMFoHi4SlER1DSy1H2lWTkrJJ5VzE+
         4Blb1jIIbuYVP7MmD5Jrq320A41Xy4Cw49AeDM4akT3rTEoNyxYk0uI06I+B/pU/KMnT
         EZtk0OL/MeGyst5T4nsWsxU58Rh1TZtGrOkaC0eBGyRFXpFEUKoxnqaqHRDp5SaQodf+
         veEiIFMAQ1er1rwD/E9S9ab5zAdyn87ypQVDi2hwcwtpo0FmS/NbBATzHmFaD/meo/zJ
         7mM71DR1Pcy8rvXWBXDaWt0IpQwlEhTgdaIg02m+gwyaN8HPkraPLz8sqHvLgjQ98Oqk
         1K5Q==
X-Gm-Message-State: AOJu0YzXYLuzaSFXXqJ+EKdr9hg5t4yLecClgEhwyVRAB+c1kbVngsm4
	chYmM3rYNVRwL1vtLjKDOdbLvMwjTLWCTBY/cqx3Qn5SXWesTg==
X-Google-Smtp-Source: AGHT+IEWzwr/tc2fYB85wLIF4FNfK9wFIyN4eyOO2fYyS4zfclc3IVSwHz7GtBfcfd6NENCzsVQn8Z5BmbvtojGy7fo=
X-Received: by 2002:a05:6512:3f04:b0:50e:dc80:d560 with SMTP id
 y4-20020a0565123f0400b0050edc80d560mr156153lfa.45.1705006460198; Thu, 11 Jan
 2024 12:54:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109-axi-spi-engine-series-3-v1-0-e42c6a986580@baylibre.com>
 <20240109-axi-spi-engine-series-3-v1-1-e42c6a986580@baylibre.com> <2c74aad9-3cb9-4222-8072-e72120c2658e@sirena.org.uk>
In-Reply-To: <2c74aad9-3cb9-4222-8072-e72120c2658e@sirena.org.uk>
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 11 Jan 2024 14:54:09 -0600
Message-ID: <CAMknhBGMRed9vDrDAuPJ5DnEe6MyHzd0VBebp5OaLX2Q+AyhMQ@mail.gmail.com>
Subject: Re: [PATCH 01/13] spi: add core support for controllers with offload capabilities
To: Mark Brown <broonie@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Hennerich <michael.hennerich@analog.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Frank Rowand <frowand.list@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Jonathan Corbet <corbet@lwn.net>, linux-spi@vger.kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Jander <david@protonic.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 3:36=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Wed, Jan 10, 2024 at 01:49:42PM -0600, David Lechner wrote:
> > This adds a feature for specialized SPI controllers that can record
> > a series of SPI transfers, including tx data, cs assertions, delays,
> > etc. and then play them back using a hardware trigger without CPU
> > intervention.
>
> > The intended use case for this is with the AXI SPI Engine to capture
> > data from ADCs at high rates (MSPS) with a stable sample period.
>
> > Most of the implementation is controller-specific and will be handled b=
y
> > drivers that implement the offload_ops callbacks. The API follows a
> > prepare/enable pattern that should be familiar to users of the clk
> > subsystem.
>
> This is a lot to do in one go, and I think it's a bit too off on the
> side and unintegrated with the core.  There's two very high level bits
> here, there's the pre-cooking a message for offloading to be executed by
> a hardware engine and there's the bit where that's triggered by some
> hardwar event rather than by software.
>
> There was a bunch of discussion of the former case with David Jander

I found [1] which appears to be the conversation you are referring to.
Is that all or is there more that I missed?

[1]: https://lore.kernel.org/linux-spi/20220512163445.6dcca126@erd992/

> (CCed) a while back when he was doing all the work he did on optimising
> the core for uncontended uses, the thinking there was to have a
> spi_prepare_message() (or similar) API that drivers could call and then
> reuse the same transfer repeatedly, and even without any interface for
> client drivers it's likely that we'd be able to take advantage of it in
> the core for multi-transfer messages.  I'd be surprised if there weren't
> wins when the message goes over the DMA copybreak size.  A much wider
> range of hardware would be able to do this bit, for example David's case
> was a Raspberry Pi using the DMA controller to write into the SPI
> controller control registers in order to program it for multiple
> transfers, bounce chip select and so on.  You could also use the
> microcontroller cores that many embedded SoCs have, and even with zero
> hardware support for offloading anything there's savings in the message
> validation and DMA mapping.
>

I can see how such a spi_prepare_message() API could be useful in
general and would be a good first step towards what we are wanting to
accomplish too.

For example, in the IIO subsystem, it is a common pattern when using a
triggered buffer to prepare some spi xfer structs in the buffer setup
phase that get reused multiple times. So this could, as you said, at
least save the overhead of validating/mapping the same xfers over and
over.

I will look into this first and then we can come back to the second
part about hardware triggers once that is done.

