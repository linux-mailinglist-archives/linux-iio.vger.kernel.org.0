Return-Path: <linux-iio+bounces-27638-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 418A0D12CDB
	for <lists+linux-iio@lfdr.de>; Mon, 12 Jan 2026 14:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACBD1301B494
	for <lists+linux-iio@lfdr.de>; Mon, 12 Jan 2026 13:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0118E358D09;
	Mon, 12 Jan 2026 13:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfkaNEc9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1868B3590A2
	for <linux-iio@vger.kernel.org>; Mon, 12 Jan 2026 13:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768224378; cv=none; b=KS7dfFB2WB+4/N0xubLVF4GZlSe8BVmBgDhrq7Ljj7PRSvXrcWh+2pY7q129ZOj2Oj4gCJyHTXIabC4HER0jJ97MJ0yNV7ZeIGuGHuAHJJgQ0OUc5SMeRqhNHIddVembetn4JykAvHCoWBpUIKjSU/A8eBME0olVErpAKrK443Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768224378; c=relaxed/simple;
	bh=2oF3EvFvkFdV1ST1qNlWtL9H1W7jx/jvnRhy2/pkxC4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LL03nMDU9Kcl1DQoHcEJUDCG/f3oYBw6opjxLeNwOChpJzTi9oiYFy1zsZnlTVRbkcJiN5oSH0IYAtUsH/xEG7ym1epIqJxzwmLsbKo+euB1nHBDU7qo6eG12EZ07GeVzd5QO0aYPW/2/TS0yrlRExSsl7Z8ahH+1/jRlRWAqUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DfkaNEc9; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-477ba2c1ca2so70335485e9.2
        for <linux-iio@vger.kernel.org>; Mon, 12 Jan 2026 05:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768224375; x=1768829175; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2oF3EvFvkFdV1ST1qNlWtL9H1W7jx/jvnRhy2/pkxC4=;
        b=DfkaNEc9mo5G1xuMYZpBK0Yi0vLlUZHCHl3vpqDjoDZdz+k5meKzNWCALaQNcLLh3w
         svzJ4ikCeeSJnn9WahXETk/B1yK7uqqjY3ef9bL7jEuskjDnwuIOMdP+KNW1PfypGCAP
         1TOOJMjgovTTJ34gqhpA78wRDO4HJOH3iGWlqKX3gi5zzu2Pua1gAI6i1O+MX2shgoNY
         I0UtMomjlO3wVpsbDbuhb0uRvXa2Bbd82tokIyuzzeAoKRrsoJEGu62hlpq2ws8/eP1A
         xHjx1QDL6/mMLnaaJe5TpxS/J4Q+GTRRTcBV3z4nz2+RJ5xV+CPaR9pGrcqKLKkAZQWi
         L/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768224375; x=1768829175;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2oF3EvFvkFdV1ST1qNlWtL9H1W7jx/jvnRhy2/pkxC4=;
        b=YoliOaL9T9OHz+om9u9tSBOPQ8rVO1t6Waf+fyl1DSPcpCZ2BtANxoJD74FBcsH3uZ
         9l67w+aCur83sWkdW4VUYQc3OfKDCe/+Y5WrkvVG5vlUUSs8e5HQrSHoQ3xI4WCQL+mo
         T79cFrDX2+44EOD54l3KouQ54jxciDoLbeqViZL5liW3p1cnd4x5fOZ0zaq70UJe404y
         6N+/PVMNNldu3VD8V8qbu8SLxPweeBd+thO9Ou2tK5syjPNiZN3RpZ3mveFE7nTrwgKs
         2b54fSqGJMGwDFI4i8UlG0+8SwtUnuLWOrX6QIYru27k3nRSRsUmWCwSTc2CyHKyB8Aj
         2f1g==
X-Forwarded-Encrypted: i=1; AJvYcCUAbqeorVr2c/r5wTaVCotVX4Z2QmDP/LSYHerTIhKcPst0qLpfK9soGxTB+V4PUFHqIuLEpHF7qaE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2bM3RIgJRVZU6ItXVBrF9LckHf6GEr/UCYeDZC6MisY+vCBYO
	NYKxKOZAlr09Y3GeDlw1CM04a4L43kdsxkzSxZVqBwAbXkwmzKQFtttE
X-Gm-Gg: AY/fxX5hjr8JUcP8PuN255k8jKTjnZ7RXFnCmwq9TnayILsazqjMw+VuQCPgnef/D9h
	o70IaQa+e3ZZ4X2oR302Otb45PuQ6HPCX7D50ioxV6IMqnGDEriRNftf9qJYqGG2slIDkkA/zHU
	Sj/dOSa1q4UN7k61HRtMv/XNrwrw4A1E/C7IxVl0Scdgma8MbJFDlnE3IJwGtqkGnOx3qEKpuZS
	LIs2G250rEn7/9EA1Vt/SC11dp4V2vgJ0otx69+7AnC8R1W/hh0JNUod98NzgdPxrS8x2BKTQRd
	Yyv89VEnFkJb5cTTunYisZkcLp7nE6aAI2O0FUVVDnhrHwyHy9Nd5zrPXOrHIGSD7v1gUU1scWd
	Rbqtc1H/M7t9iu0RNFE+o2omur+VXaSUArA2NpsPRxZYI0KjvErUilvl7SW0X323UHjnkXFtd6O
	g99RDp3MhdNYPZ+60/enU=
X-Google-Smtp-Source: AGHT+IE0r9BfXZwwCs8FxodI7q7TaoHaAIhaO6CL+8zbXIknTrrEsGAV9Dt1QcHGcpWUSxtAtrNqnw==
X-Received: by 2002:a05:600c:37c8:b0:479:3a87:2092 with SMTP id 5b1f17b1804b1-47d84b3db2cmr177108365e9.36.1768224375401;
        Mon, 12 Jan 2026 05:26:15 -0800 (PST)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d8717d9e7sm128261375e9.8.2026.01.12.05.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 05:26:15 -0800 (PST)
Message-ID: <bf02e226e8010e973ba1477259bedf0006f02292.camel@gmail.com>
Subject: Re: [PATCH 2/2] iio: accel: adxl380: Add support for 1 kHz sampling
 frequency
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Francesco Lavra <flavra@baylibre.com>, Ramona Gradinariu	
 <ramona.gradinariu@analog.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>,  Lars-Peter Clausen	 <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,  Jonathan Cameron	
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, 	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 12 Jan 2026 13:26:57 +0000
In-Reply-To: <371503c267d9ded0195da126b58bc8339cb864e8.camel@baylibre.com>
References: <20260107123518.4017292-1-flavra@baylibre.com>
		 <20260107123518.4017292-3-flavra@baylibre.com>
		 <52e5cea72b99fc23c922cf74d7dce3403f43c9cd.camel@gmail.com>
		 <9a5db937dc7072d95d6757cdf2eb8d6fde4abbd0.camel@baylibre.com>
		 <5cd68e397bb45f606f59038290e4f3ac09d241da.camel@gmail.com>
	 <371503c267d9ded0195da126b58bc8339cb864e8.camel@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-01-08 at 15:07 +0100, Francesco Lavra wrote:
> On Thu, 2026-01-08 at 13:45 +0000, Nuno S=C3=A1 wrote:
> > On Wed, 2026-01-07 at 16:39 +0100, Francesco Lavra wrote:
> > > On Wed, 2026-01-07 at 13:56 +0000, Nuno S=C3=A1 wrote:
> > >=20
> > > > 3. Other thing that comes to mind is if it makes sense to allow
> > > > controlling odr if
> > > > Activity/Inactivity detection is enabled?
> > >=20
> > > Disallowing odr control when activity detection is enabled could be a=
n
> > > option, but what error code should be returned if the user tries to s=
et
> > > the
> > > sampling frequency value when not allowed? -EBUSY?
> >=20
> > I think it makes sense given the constrains on activity events. EBUSY
> > would be my choice as well.
> > Out of curiosity, do you know how the chip behaves if we change the odr
> > with activity enabled? Is it
> > just ignored?
>=20
> The chip supports activity detection only when in low-power mode; changin=
g
> the odr to a value that requires exiting from low-power mode would mean
> effectively disabling activity detection. The driver prevents this by
> forcing low-power mode whenever detection is enabled, which means that an=
y
> odr changes by userspace do not take effect as long as detection is
> enabled.

Thx for the explanation!

- Nuno S=C3=A1

