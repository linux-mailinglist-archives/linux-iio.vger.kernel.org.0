Return-Path: <linux-iio+bounces-2407-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C4F850A6D
	for <lists+linux-iio@lfdr.de>; Sun, 11 Feb 2024 18:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C9DB1C21DC7
	for <lists+linux-iio@lfdr.de>; Sun, 11 Feb 2024 17:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51C25C611;
	Sun, 11 Feb 2024 17:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JwXCvwKn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1097D33CF5
	for <linux-iio@vger.kernel.org>; Sun, 11 Feb 2024 17:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707671040; cv=none; b=Gx0O/gsH4xEU4j1M1zocvxoz0DrG+OxOl/iyWXQCNWJegnmRG2PC9AJThJ8sU6XWdi81HQ4erIo4z5fSjT7NHav0GD/3roXlfxbWn0URkHRpIAv/GH7PYCn/daz0w/c187l5/h6I2hGr7JxxRYfrK2ObqiPtlumFLT1QU1dKTwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707671040; c=relaxed/simple;
	bh=EaYBvPTL5340RMBzf1X/yXQwMXrnL0mGGyjOfVqJ/8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fmXohn2enZr3HTsFqF57W/lpnjuIaG1i0QR3p/w6ROZHIOC6w9lPX5IOBB6136uik7R6cGSNzrQanuEHn32DNMpQa9cERTQdcppWnewio/dWTKFA7di1BE5TGxqEKrjJg0U8mSkwsKIr5rkMKS4m0SagtQDnHyQ+FnWPE2TKWAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JwXCvwKn; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d0a0873404so30224721fa.2
        for <linux-iio@vger.kernel.org>; Sun, 11 Feb 2024 09:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707671035; x=1708275835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l6r6uQO0yvhxMh2sO8XzcbE67h9/FEe/yCCnsnSaz5I=;
        b=JwXCvwKn2QtzpDo0Z+YLgAGxSUdQJTWY31TIJW717+pfEB1ejLLqIBF1MWPMOhtx2e
         HS3UsdFRljcimS6AdNwW8E+8AkB4JmsygI1Fi6DF78yoHh5YaMjuWIQCUv9Dwicr6h+i
         wV0gXIU2YwKSAaYAdJWYtCdn72KLuMXVvZXBXgunmFUp59QJDhTm1fPxpg6hhYsliaVd
         VZFZWiZFoH/DWaD3UGIrXlJQkB0h3LRZSuuFdnY0cDhYuWJXKEu4BUFLDBgkj5kQTeVv
         MSgGsQRGlSaDl2fEGr7scJGKDsEfxECYJhPCxGfPKTVi5H4jxhDEwOWw+BCVPbeeEiy+
         6sNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707671035; x=1708275835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l6r6uQO0yvhxMh2sO8XzcbE67h9/FEe/yCCnsnSaz5I=;
        b=GxwASgqc2I1KtBPcLs8ZefQnrt127zh0fWbufl3bq58cCqGtm1MSDZJ8F5dq6ZJw+c
         iPQ5qbhfYCh/zM+1YFQW8Xt4/ZdErEKwQRGCgNM3hy9+pDRa4laVMtfNm7UigBn7EDr5
         S3JxaWxeQa8mkQ3PJODYNiaSZLDqbrIIdpTneuBnvenpU8Yy/xCRX8MdeJNneE7VJ5yK
         JPyGgf0MSoWhL3HfJ/FVtwM1uqqTuNHtpOSY5AI9GkwCwROFhIDEGqo2gAakU9vovD3T
         8r0/QH9K8kd491FytrSFO28uHbcOUVVuRZkf3lv+JwLPTgYfgTSv8+6THWesCDx1MVLR
         nmNQ==
X-Gm-Message-State: AOJu0YzmMbjgDq+p4y+ZIdR7Ym7AGZl2XXfGApu0j4g6aQIM+qx5UbHp
	a+EcdlsAJie2U23xAsEGpzWbugbZiFsc1t7Sj0AMVszCrCHkMhmOHQgosWTVohP2n4kAVzK3Wnj
	CvAqgQMVRdjIyAPDyEarZfOC57KPMbVxfYX+www==
X-Google-Smtp-Source: AGHT+IFeDYfZDJITP4t95JWsaHGGTqFSftILCragwFVbCOlKyMcp3OUXURqrXAodacWjBBT74IYU2gIgeUHSZyAxt+8=
X-Received: by 2002:a05:651c:89:b0:2d0:a21b:c62c with SMTP id
 9-20020a05651c008900b002d0a21bc62cmr2510616ljq.52.1707671034856; Sun, 11 Feb
 2024 09:03:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206-ad7944-mainline-v1-0-bf115fa9474f@baylibre.com>
 <20240206-ad7944-mainline-v1-2-bf115fa9474f@baylibre.com> <20240210174729.7c6cb953@jic23-huawei>
In-Reply-To: <20240210174729.7c6cb953@jic23-huawei>
From: David Lechner <dlechner@baylibre.com>
Date: Sun, 11 Feb 2024 11:03:43 -0600
Message-ID: <CAMknhBG3J-fW8o6DaAE34GD-_oNk6pnMpV4SnoA26gVmHWJP6g@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: adc: ad7944: add driver for AD7944/AD7985/AD7986
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 10, 2024 at 11:47=E2=80=AFAM Jonathan Cameron <jic23@kernel.org=
> wrote:
>
> On Tue,  6 Feb 2024 11:26:00 -0600
> David Lechner <dlechner@baylibre.com> wrote:
>
> > This adds a driver for the Analog Devices Inc. AD7944, AD7985, and
> > AD7986 ADCs. These are a family of pin-compatible ADCs that can sample
> > at rates up to 2.5 MSPS.
> >
> > The initial driver adds support for sampling at lower rates using the
> > usual IIO triggered buffer and can handle all 3 possible reference
> > voltage configurations.
> >
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
>
>
> The one thing in here that will probably bite if this gets much use of
> different boards is the use of non multiple of 8 word sizes.
>
> Often we can get away with padding those with trailing clocks.
> Any idea if that is safe here?

We can probably get away with it on these chips. The ultimate goal
here, though, is to get these chips working a max sample rate which
only has a few 10s of nanoseconds of wiggle room between SPI
transfers. So I would rather have a bit more play in the timing than
try to support generic SPI controllers.

