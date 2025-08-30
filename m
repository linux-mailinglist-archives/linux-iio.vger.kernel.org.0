Return-Path: <linux-iio+bounces-23426-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 328B0B3C809
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 07:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94B4A18946DD
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 05:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE1E241663;
	Sat, 30 Aug 2025 05:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZXnCGVz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1B11C1F05;
	Sat, 30 Aug 2025 05:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756530056; cv=none; b=Vv2RpvznYP5BXi5g+Vbx8xAQARI+cQN+c1/WpvXxge0Qhc2bJrT3mz5sVMXnvYmjgqSbkmD0fpEGLMOvDtLVo4iVnIqbyKGTW/HByHBhYPZNmcbZUbCxijeQ8lnpH7i75kBk5W9FwMuIxxjZtBYfMfgghOH96vL5iJUr2sK6OBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756530056; c=relaxed/simple;
	bh=sUWCFQiozcXf8RFq48scZRqotCkwmrulquliXottWRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f4KxYyOZqH1sxeQTBfjyQvv/QrVZy1ILDErWhalZ31kz+Enu76Gdj8XXkOed2l/99dqoQjdJJrfX9QneUZAWwM7/ANgYUqzkutPKDXdVrp8Yp6s6skFf1+E5q9qD7Y2tywW1cd9Xhwj8ySWk+83j69TSsn/cTOgaPWyV5k1I6y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZXnCGVz; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-afede1b3d05so480799666b.2;
        Fri, 29 Aug 2025 22:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756530052; x=1757134852; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sUWCFQiozcXf8RFq48scZRqotCkwmrulquliXottWRM=;
        b=OZXnCGVzWmR5x5wfKPX9u/EjpUcSdTSlI6kw2lrywUiuLMtUswJPVWwYLV/EFkVWdY
         ru73xLpJkalGrriSJ4AIhSK8uK7maib8x0ENupEd8d10knnCvY9NzBJWwkOZhXumuGZH
         C8ilUXGJp9peSsW83hX0i36JG8uSkyjN75USgHvQnrRTgJV2+DonNf8cd54XLPIB+1lQ
         RxQM/7Qs84F10Ya9QDDwcj5dzppN9s4UfZB144/thSsrNgMErlsgL6cnyz0eAX6bMk7L
         4HHkpMVkWY0xf+nctv0Isv5jtT6t7F4WwXp0LPNZ1r8LaxM8J1d/co7h3Wie5H5da4ng
         C1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756530052; x=1757134852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sUWCFQiozcXf8RFq48scZRqotCkwmrulquliXottWRM=;
        b=bzuCug5UJdAkfuFXIWvc0jbd3vd2TsmL8Cv+959Jy8RRmrTmO82kpm0JJabRWbB0Lx
         eKMtZZ7+aqpOwZ0eVeXI6sFJJX2itb+iLWtutqAEGYTXL5V9OALVR7C3zdpHKJZd59g4
         Mwm4fgc8oKTuVA261/FyjonD94W6uqDMNRIogy5WYJOOXB1Mv9GEXSa+P/UEHCctayau
         PYXb1N3SLqWtQ/BUBm7xKGRGNqFBxZNCsVB6R3Rf8qYg35nq1NoMLB0syFVSpJfDcLaw
         7hYkkTx1WjPVT8EiUdsUIZDG0Nic2U/DOGLN/83h3Y30lQL26+ZS6IVUG/8FrR4tKk1l
         VjVA==
X-Forwarded-Encrypted: i=1; AJvYcCUO+LFmWcnsdRPJazrH4WK1p+WjqjXs2l62VcghScyqw7hHHzVjBMGuGp9GG2lrCMyfk6s1V9+RzcNy8yf8@vger.kernel.org, AJvYcCVZuz7sZi/oPT5MXxye/SQ5E58XbqnJcMiHDTd8LYVgRSbefbYozH2Kscbi/xqYRHC0Ag2D00KzWWfj@vger.kernel.org, AJvYcCXIBD4/kNypaAZRvk6WkBNg+ALoi42viYlX2wnb8xskKS5roO1KoPDkXKnLXrGE98fmysoRzy7m7pAd@vger.kernel.org, AJvYcCXfwjUvsur85kmTsKgP2AIstyKH4ibz7Z4UK2KZPnba4EiUJuyV06BefnozvzIY87kTmRX7HM7SmSxE@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/EvDVkRWuiKWH0GwpMRlnlDFdngu2QzxgwTyJUf/g/MK7dw94
	Ju7rwSU9uK1PAm4wCLOTS/9al+Pkx+AE7TeEnexX/uqyDrTFhxbcqjrsmF7fsBoA3Ml/X5Zt2a0
	qy7fa9+hlMRGtz/e/k/Gt3x8qLcxkeaSkFvtMx6c=
X-Gm-Gg: ASbGncvC3pRTm48b7XVMIa7O3Dp8syrc8itLBc0vGl26CpnA6Kp/u9Rm/KpPerxZJX1
	awibUqqtH8AtZUGlHwwBewix7i8DU/G8aIZIVO++rQ0ayzWtZ4eVPyzZV8sOXrs7Uv/cEyMwQzw
	c8llT0+OWTayZF3E1Q6eIBSiviNT386VS4eS8i5VdBudk2cVOGQa9+2sZxba//42uNnagiiGXSv
	KwrsBY=
X-Google-Smtp-Source: AGHT+IEjDHP1unXxSQbNQm1sw4+9qAhjYAtuNlGfL1MCTN0zUKm27Bv7C4qDJsHhC00wyklQz0F5kXgoDhH7BebhRkw=
X-Received: by 2002:a17:907:749:b0:afe:8761:e77a with SMTP id
 a640c23a62f3a-b01d8a7311cmr89257966b.19.1756530051865; Fri, 29 Aug 2025
 22:00:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1756511030.git.marcelo.schmitt@analog.com> <f9d40e8deb3d17a41b4fd6ecc1b8ac92275f0078.1756511030.git.marcelo.schmitt@analog.com>
In-Reply-To: <f9d40e8deb3d17a41b4fd6ecc1b8ac92275f0078.1756511030.git.marcelo.schmitt@analog.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 30 Aug 2025 08:00:15 +0300
X-Gm-Features: Ac12FXy_P7anbjpt8vW1zV6UGse9GLLWxC5jXgoPInY0GO9P8lb1L2avEZxEEIE
Message-ID: <CAHp75VdhtF1NgygHCRaW-+A83Qz-O8bMEfeMoF9ke-Hno+e4tQ@mail.gmail.com>
Subject: Re: [PATCH 01/15] iio: adc: ad4030: Fix _scale for when oversampling
 is enabled
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-spi@vger.kernel.org, jic23@kernel.org, Michael.Hennerich@analog.com, 
	nuno.sa@analog.com, eblanc@baylibre.com, dlechner@baylibre.com, 
	andy@kernel.org, corbet@lwn.net, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, broonie@kernel.org, Jonathan.Cameron@huawei.com, 
	andriy.shevchenko@linux.intel.com, ahaslam@baylibre.com, 
	marcelo.schmitt1@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 30, 2025 at 3:40=E2=80=AFAM Marcelo Schmitt
<marcelo.schmitt@analog.com> wrote:
>
> Previously, the AD4030 driver was using the number of scan realbits for t=
he
> voltage channel to derive the scale to millivolts. Though, when sample
> averaging is enabled (oversampling_ratio > 1), the number of scan realbit=
s
> for the channel is set to 30 and doesn't match the amount of conversion
> precision bits. Due to that, the calculated channel scale did not correct=
ly
> scale raw sample data to millivolt units in those cases. Use chip specifi=
c
> precision bits to derive the correct channel _scale on every and all
> channel configuration.
>
> Fixes: dc78e71d7c15 ("iio: adc: ad4030: remove some duplicate code")
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> This was probalby buggy since
> commit 949abd1ca5a4 ("iio: adc: ad4030: add averaging support")
> but I decided to set the fixes tag with dc78e71d7c15 because this patch w=
ill
> not apply cleanly over 949abd1ca5a4.

FWIW, you may add a few Fixes tags: The original one, and the one(s)
which changed
 drastically the code. In any case for the small conflicts we don't
care, just put the correct Fixes and if needed to backport, one
provides an updated patch specifically for backporting.


--=20
With Best Regards,
Andy Shevchenko

