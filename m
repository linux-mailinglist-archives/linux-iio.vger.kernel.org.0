Return-Path: <linux-iio+bounces-27518-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B07CFE246
	for <lists+linux-iio@lfdr.de>; Wed, 07 Jan 2026 15:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 58773307FAB0
	for <lists+linux-iio@lfdr.de>; Wed,  7 Jan 2026 13:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F91E2DCF74;
	Wed,  7 Jan 2026 13:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vsc1fXA0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BA128134C
	for <linux-iio@vger.kernel.org>; Wed,  7 Jan 2026 13:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767794134; cv=none; b=sQ+IGBFvWA5eJz1Ew/xSbMDqjw5Ig2gujQoAOdtUIcuWXd6yq6v38JYqr35IovTwTHH9SKarwNgCHG1lB0WAc2ykh968IBNy9NNzCmnA3iPqAcNkkXW5oX1Nf2/1LsXdspTjVYm9bZ49GawTV+Fwl/eA+iblfZRxfNv308jz/84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767794134; c=relaxed/simple;
	bh=MjmuTEdJLhRUCFKamYp5rxG8fH8Naro0YOHHi4oFs7E=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MhwEoZvjd4y7jbH5QKHi8dCcb3+gT+hbKcKxbnRudAsXXKIgJqc8KUT/cnciVgJAY7HxRPGsDXwu+KHbUaH1t0v8nE4o/Zk4dQsk0bTqg7CSGxaSDZCw4szSP1w1OljplM1cgCaJlPk0oNJZXUqwPXn+VxeJK/ibqyyZYKAHh9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vsc1fXA0; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-477a219dbcaso17592805e9.3
        for <linux-iio@vger.kernel.org>; Wed, 07 Jan 2026 05:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767794131; x=1768398931; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oakT7m3B+w4n/sN4kwRkp8thf4WnUxQ8zbdabrCd+vU=;
        b=Vsc1fXA0GNUzDSHjNXWJUhsR8wJvEPYdHsml3kDFscLQ2ub7p/YgUDByzJZFkJX24o
         rGe9KD1Knf1/PTnqxTTkI/NXZ3suDSjSeYGovQJqHlnWkm0Knu9B8d0Go7BbPRTxuT4q
         RIevQvgs2KLACl5aWL7cnJ72anFMvf77+DGbOVXFfUsDgMxYPUiR7OWg+L9DJJM/hf6S
         qxi9qcLBa/2/Q/w89FZ7w0SyZoRtS5/DlQHRimqQbq5SdwnRZQLS6tbnsdaM1e/9A8X9
         BmUWeZ7gUI7esgaWrhOeXolELu+VEv3dvdn/qDfeE6Ngfb1VQ9dqd+bJ2JAoojJ1YVuk
         tVTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767794131; x=1768398931;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oakT7m3B+w4n/sN4kwRkp8thf4WnUxQ8zbdabrCd+vU=;
        b=UCPFcFqxI9MMryFt0LjwJkKDk2BrySllfhS/spk+Fwsyh8UvOy01eqD0pdAH5ZE81H
         oPolFQhr8+rCwsr6radWzhfW7/6yaFyf3pfAG15MNgHWH3zziEhCyNqPfeQNaIEcfM/A
         TXPOow6+y6PF8VkFdnYUyzOfjjYKbqCxfE8Ldj4ETwwOOB+uTP8prDJq9m9pQHh8YXEG
         sJcA5U/HrkedbIZaNQsmr95+nu6Nf32kvjM+u4jkV4lCx5lx/kIcuutxUynr1K3oaaUU
         MAUT7h7DtSDJhEWlRLpTy7WGnO2kKbgnkxW9MJc2h1Sj/MWf9vsX3aME/cgaRdH0HEpw
         6lcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXddv/6bX6hLct7IYFFixd34+Id85iIrnAPtadBYWg7gR5nFeZX6M/YCUTiVn9a0OUB1b7tf49Z7Tw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQbCwseUWK8fYojkizGks5aqS38bQ/Gzke5W5SpVpHU420ZhFB
	MnX9oxdvvHfa1iZR9RNUYuXW1HRXwpT9iQ58xvkdkj7wuh+axrZqILjl
X-Gm-Gg: AY/fxX6efcl/rr+YzEteVLK2fuRQ+MHqSwSKYEuItPQoawQm1GUeMbUUUdBGXgBVok7
	Lhyz6sWaFla/K6DCpe4WxdezHs+S57OUD2LCt/SIpHOpPOAoEJKdYbPJy4A0zl+u/d/7io03n/N
	s2g5j90S808iH5GxMPC/OGnz9aqWnMt14WtT1KmRI5ZgBo18z5bGX0xZ2kFig+r52DQP6Qzm28i
	M+xVKHyZgmYgIkEpXRXt+n+r6+IpW7i3KzgbsZD67ZSmj1g2aH4hlpcZv/qNpicfRVRG9Hy6J6f
	mBVIMOwlLKhEYCfur+1bgmJN8hrwzrrHbnX9hyuigxi7A9TN9kVL99cURFq08XDMgJ76++G/Ide
	L4Dqy8zwCX7kklmizlu6crkl4pDYhBxr/LpgRufL9Bd/ta50pVtJa5acBdFs9SaFyQZh2+TcuJh
	XbueBkktqCWbG9eFMMBEA=
X-Google-Smtp-Source: AGHT+IFVFEQpINybWv/vNvdh7UuH51hN+BbScDbpxivdqT45ngiAUR+gzJegfPVsIPQqPfCIlZ4hxg==
X-Received: by 2002:a05:600c:4443:b0:477:755b:5587 with SMTP id 5b1f17b1804b1-47d84b0aad1mr28671665e9.8.1767794130679;
        Wed, 07 Jan 2026 05:55:30 -0800 (PST)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f410c86sm101388785e9.3.2026.01.07.05.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 05:55:30 -0800 (PST)
Message-ID: <52e5cea72b99fc23c922cf74d7dce3403f43c9cd.camel@gmail.com>
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
Date: Wed, 07 Jan 2026 13:56:12 +0000
In-Reply-To: <20260107123518.4017292-3-flavra@baylibre.com>
References: <20260107123518.4017292-1-flavra@baylibre.com>
	 <20260107123518.4017292-3-flavra@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Francesco,

On Wed, 2026-01-07 at 13:35 +0100, Francesco Lavra wrote:
> In sensor variants (such as ADXL380 and ADXL382) that support low-power
> mode, the SAR signal path allows sampling acceleration data at lower rate=
s;
> more specifically, when the sensor operates in VLP mode, the sampling
> frequency is 1 kHz.
> To add support for the 1kHz sampling frequency value, modify the operatin=
g
> mode selection logic to take into account the sampling frequency, and
> configure the decimation filters only when applicable (i.e. when using a
> sampling frequency that relies on the DSM signal path).
>=20
> Signed-off-by: Francesco Lavra <flavra@baylibre.com>
> ---
> =C2=A0drivers/iio/accel/adxl380.c | 49 +++++++++++++++++++++++-----------=
---
> =C2=A0drivers/iio/accel/adxl380.h | 10 +++++++-
> =C2=A02 files changed, 40 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/iio/accel/adxl380.c b/drivers/iio/accel/adxl380.c
> index bbf1f88ca781..a6919dfce2e9 100644
> --- a/drivers/iio/accel/adxl380.c
> +++ b/drivers/iio/accel/adxl380.c
> @@ -245,12 +245,14 @@ static int adxl380_set_measure_en(struct adxl380_st=
ate *st, bool en)
> =C2=A0
> =C2=A0		/*
> =C2=A0		 * Activity/Inactivity detection available only in VLP/ULP
> -		 * mode and for devices that support low power modes. Otherwise
> -		 * go straight to measure mode (same bits as ADXL380_OP_MODE_HP).
> +		 * mode and for devices that support low power modes.
> =C2=A0		 */
> =C2=A0		if (st->chip_info->has_low_power &&
> =C2=A0		=C2=A0=C2=A0=C2=A0 (FIELD_GET(ADXL380_ACT_EN_MSK, act_inact_ctl) =
||
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0 FIELD_GET(ADXL380_INACT_EN_MSK, act_inac=
t_ctl)))
> +			st->odr =3D ADXL380_ODR_VLP;
> +

So before this change we would go to low power mode but still report whatev=
er sampling frequency
userspace had configured (which I guess would not correspond to reality)? W=
ith the above we'll
update the reported odr right? Some things/doubts that come to mind:

1. If I'm right not sure if this shouldn't be treated as a fix.
2. Should we cache the current odr so that we restore it when appropriate?
3. Other thing that comes to mind is if it makes sense to allow controlling=
 odr if
Activity/Inactivity detection is enabled?

Thx!
- Nuno S=C3=A1


