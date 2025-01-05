Return-Path: <linux-iio+bounces-13898-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1836EA01A27
	for <lists+linux-iio@lfdr.de>; Sun,  5 Jan 2025 16:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC0B93A22C8
	for <lists+linux-iio@lfdr.de>; Sun,  5 Jan 2025 15:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3E91487C5;
	Sun,  5 Jan 2025 15:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="BtC9USIq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9C3F9C1;
	Sun,  5 Jan 2025 15:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736092202; cv=none; b=YnQq2WWpi0Pokz/KtOgjbaWrHiLEs1ncPwItq8MmHtpzY5tCBrMNsdql+RIMtTkzSiTd1FBdvdo3nMS9FiksuzMMHK4AF7b6LZNqRtq0Zo2sqX0nAnIuB6FO/8QIUn9/fiWzuG6x7dZSgLbMhU/1/k2NzvDJfvUAXt9cXCEJEPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736092202; c=relaxed/simple;
	bh=RM5s8U32OtCMbASk0leCuR/9r2hIRgbjXYDeee/6GXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oR19AyHopn57UzEJvzDLPy/Y2T3ES9P5+04ZJJefMGc5faGDHBghl+4vFTqpcaSMsj/huy6e9AIeVGSed0KDfCAbp8XOtGIvKnze896/8cv5Ibs0pRBtZYDrUFyG2od+lF7eB9WTpBQQc3CF6f25cOg0bjqOyG4V0yioab+5V/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=BtC9USIq; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2161eb95317so198417595ad.1;
        Sun, 05 Jan 2025 07:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1736092200; x=1736697000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YywA5lTEdJWoFMmlp4DfxD/jE6edYt47y3+JzLz1vMk=;
        b=BtC9USIqGHutKlQSvsbSTHuykR6RHTEW78OQ5zdHx1fygPrM11Cjm1iomUVasw+ZpZ
         kLxowF9aGYzu0zHexLLUZPt3K41XzEQq8ZXvTo45Y/FY+BiXGg9ZELFZbAv9TL80QFnF
         TnWMeDvi8B/SpCKzsBQ0oN17VF2Li5XzfMx03J5BUBk/OMsUP0d04X5oPenfI7NEXRxY
         TX/wlCnS3zExIxLJERmZn4t0vOqqZTkSXdfQzVbCzhetojTBWthhLni8tHidkohJcZCB
         IrQPIY3FPvwVdCrwcP5N/BYeLTSYEYkHk9Ip5DnwmCZUMC0TsD4dWBjJIRnXcbMC0Mwj
         UPpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736092200; x=1736697000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YywA5lTEdJWoFMmlp4DfxD/jE6edYt47y3+JzLz1vMk=;
        b=oBXL1lIIe+mq57y2dSExeP+CQUOm6ovr3Xrf+BIXN4rkEwOsCsyuSNJaEkhT7NY7d5
         xAPbG7YdvU9w4t/JyeWPskE4/+XwH567J05JwZVoN8lTaMdjIIPW5qhaOoAY2bcbFVhS
         IzfWAAIgfv5kbR0QByIWYCAPjmRA3CRZlwUsvKXNEkP95lihyjEQHNM9E8pf6G+CyU1m
         e8T046+QoHBQKJJN2CnXnpbK5I2RBoa0a7tJDblhC2q8gQu67wzThPaDfjK5Aa2Nfcug
         9Oa5F8B/VhqFIIF0gizS8moITTMHoDa/FVbU4Llp9MwmAN78Os4Jiq6sysJaOS/c+Fyf
         OqXw==
X-Forwarded-Encrypted: i=1; AJvYcCUVEfB1f3LTA/DiQphq5tYfwrzL9IP7h/JYOw4Sn2ZPUt1e/ToVfkn0hJN2pdOZRMHuAtXIUUp0vNuo@vger.kernel.org, AJvYcCUwkUJ9xSeHiFJzbf1XcBH2jG6LiKc+jKFUIgSQvvyC43VojVS/kLA5hIYdjeG4qt6iK9nxvQW/9APNKryc@vger.kernel.org, AJvYcCXkpBCatZ2x0AM6punXnYxutmw+cGX4TfamQj0z/iB3izJK6395GNvGdZCoMIrVEWKHqRnDRT9admxp@vger.kernel.org
X-Gm-Message-State: AOJu0YwBGtoiDovQvQMNrNBBOn5jnaGtg8Yp8rBMGKqHVdKar186+K3h
	a5Pw6LiSXNlO5Jdjfo7V7+WEXus5gbOmUC9Vkz3RP0Yvn9R41JT7ZV9BGiY34Qdw/TnkUQ4hjWA
	5U1rg0dBhxKBzWkggsfUyasguOMo=
X-Gm-Gg: ASbGncuX+SS2TiQNVFjCZbn+weo6zWYoe2CaodTk/ol03W99ILUFJNgPP1atXZwyFWe
	2dvBDdGnJof91MjVm5PueJR0KhQUxgiJWKecRCHvboaei1gz0nZHU
X-Google-Smtp-Source: AGHT+IHBq4Bpn7IMCuiOvWpCDfq6WSEWbk+kF8P/My012EE2LHfMCwEfjsvbXgI3Q5S8UqpawhTxxnoNTWpu5as8yyE=
X-Received: by 2002:a17:902:d4c4:b0:216:7cbf:951f with SMTP id
 d9443c01a7336-219e6ea195cmr764170955ad.21.1736092200275; Sun, 05 Jan 2025
 07:50:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241231194207.2772750-1-martin.blumenstingl@googlemail.com>
 <20241231194207.2772750-3-martin.blumenstingl@googlemail.com> <20250104135912.390ec87c@jic23-huawei>
In-Reply-To: <20250104135912.390ec87c@jic23-huawei>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sun, 5 Jan 2025 16:49:49 +0100
Message-ID: <CAFBinCBxaVet9HxW98uCSDnv1XVXV6r4V9Z3BRmZJypTcxDZ0Q@mail.gmail.com>
Subject: Re: [RFC PATCH v1 2/2] iio: adc: meson: add support for the GXLX SoC
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-amlogic@lists.infradead.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, gnstark@salutedevices.com, lars@metafoo.de, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	christianshewitt@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

On Sat, Jan 4, 2025 at 2:59=E2=80=AFPM Jonathan Cameron <jic23@kernel.org> =
wrote:
>
> On Tue, 31 Dec 2024 20:42:07 +0100
> Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:
>
> > The SARADC IP on the GXLX SoC itself is identical to the one found on
> > GXL SoCs. However, GXLX SoCs require poking the first three bits in the
> > MESON_SAR_ADC_REG12 register to get the three MPLL clocks (used as cloc=
k
> > generators for the audio frequencies) to work.
> >
> > The reason why there are MPLL clock bits in the ADC register space is
> > entirely unknown and it seems that nobody is able to comment on this.
> > So clearly mark this as a workaround and add a warning so users are
> > notified that this workaround can change (once we know what these bits
> > actually do).
>
> So IIUC this is to make some non ADC component work.
That's correct

> How are you handling dependencies?  The ADC driver might not be loaded or
> is there some reason it definitely is at the point where the audio driver
> loads?
Unfortunately there are no dependencies at the moment.
To me it's not even 100% clear if those bits are a dependency for the
audio IP or if they are instead linked with the clock controller (more
background info: some of the MPLL clocks are - at least in theory, in
practice we don't use that - are also used as input for the Mali GPU
and video subsystem. The only practical usage that I'm aware of is the
audio controller).

Christian and I have both tried with all of our contacts at Amlogic
but did not get any answers.
If I knew the purpose of these bits I'd model them as whatever they
are (resets, clock gates, ...) and provide proper dt-bindings.


Best regards,
Martin

