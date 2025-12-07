Return-Path: <linux-iio+bounces-26903-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEEECAB732
	for <lists+linux-iio@lfdr.de>; Sun, 07 Dec 2025 17:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 626A73001600
	for <lists+linux-iio@lfdr.de>; Sun,  7 Dec 2025 16:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9951B2FB612;
	Sun,  7 Dec 2025 16:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5YkMuul"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4232D8767
	for <linux-iio@vger.kernel.org>; Sun,  7 Dec 2025 16:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765123329; cv=none; b=LLY1lTuclcq2G73c7w5sOCpt9DAy+8R2QmyNkvPYAzBVjg04tnRjNLtLDv+eYBv82jqZMtSgNosQVsnwtkAyEfQ49ZCB+wKcVMF98EUbO32QaJSiIP9Vw4KUnbrp4Si1LyFCJ8uOymy6y+jmV62onlHsDFCsJ8mx4Tl+wyW5aLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765123329; c=relaxed/simple;
	bh=CFtfvPx1SPClm0CFDrtoxKRERrbvBMY5Uf16f9gT9/s=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:Mime-Version:
	 References:In-Reply-To; b=oOqbObDN+7S2ujOlzdIj3AKbQ7S1tWe7VcMqBKv/EYEb1jmIsEiudNbIQ3HnmCfiTpnlkiAzmif5e01CvxyXm6GT1NMJ3UFcsNsm1B/8xRGxp8Oq4DnceCV4+Crbq+gYLCPqiMoDcx+TaUDor91+gjTtp+BwSycZe5acQCmM4Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A5YkMuul; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-5dbd8bb36fcso3350860137.1
        for <linux-iio@vger.kernel.org>; Sun, 07 Dec 2025 08:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765123325; x=1765728125; darn=vger.kernel.org;
        h=in-reply-to:references:content-transfer-encoding:mime-version:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zcxsIVo7erQ0Y1WCvNuIeF6EelT1hTEyFCi/Lj2sheg=;
        b=A5YkMuulJnwHig5+eN+jJeFMPj78CCP7lC7WUIhqKARnsQzrUP9MlZqYQ8B/w4u5Hx
         vg/VMNneJ65dqux99clbtxTR3Cvt6enZHqrefcqzull81HCkp6+IokBXuJ5FVjd9tDtf
         rp4/a7DQigLbdcgNIYYD2NOezJhmqCbZllzaLgmubIjbYgi1NoqsZitEJ2qwPlxUfmB8
         kiCqxYmrZpbdpU1BJ8FGpNtfpi4BPPHiFu2XpW9wTqx8LwpfPvZUfeaa+DYEqPmHeVVm
         sbngr3z7ZuQje6HQLXmSOYgsZjqshziAYEmvFRqNqCukIxqCD6PHtveurOxdZ4P3OdzB
         LifA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765123325; x=1765728125;
        h=in-reply-to:references:content-transfer-encoding:mime-version:from
         :subject:cc:to:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zcxsIVo7erQ0Y1WCvNuIeF6EelT1hTEyFCi/Lj2sheg=;
        b=FJ9Oji1m8wu6h0gA848eiFn6bTSJ5KdyXl+t39W+XYHsZ7J1KFnp+G5+ZnAZXFiZeq
         gy6aIwVxO5AACpeRcGBRvP+hfTJEDFEQBVaUDUJo27cKPzdIZ7BK7364/ATGfI2+WUGf
         Qzb97RH/h7fpLqHCIcl79/ZtdIriapzto9dIWJWXvxOzC2bl8uT7uniPoyNT1xlj2iWS
         /jmpTV4O0YRPKKBUlRnSCwjrviMgCbHSZhm+NFIG4JLbeiq2lh6KaBJYSoNTSJ8OKrEJ
         8NjMlx8pkpVE5EqNVfgKafAQa4YCaFYvCp2a8xo5ehoJwBlVsbUktVj75Go5U3tFa3pI
         UQCg==
X-Forwarded-Encrypted: i=1; AJvYcCWIRQJJVRb6TzWLwx5zD76B0X2SIslQBE51UXmeXT8bQP+X+8nyIL5xavyGLSOysPxfylzKuoLKu2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtXH3+v4ssYxCm9sFcb/0MXJSQcGjG/JrmKAVYQvjlhPwYb3Vr
	Me0PZGNdTjjzY8YlU3u+N1QNBrcASIU5zWlDvhQsjTHVVKQ9DTB/KBk6
X-Gm-Gg: ASbGnct/37RndO+9V/R5KAhJchwImsSXM/T3MMlBaN096GUEvPmxmPLDznMzZYd4/dw
	Rn+fFogbY5VWDEMcL9fNUbSTIxXD1KvJMZsNYKFsp7E84zNTF8idvI6o68AkXFYX+xke4VdXj6V
	itW5uEnJ5UYODFcfWWijvkZXx+LwUWNeFaDLbms3u6hsorrxsStdpJef29asaU0i33w7+Qzb+3s
	S1M32dFwRD0flaVpN2iOVmf3IChJmpY80/H/U1P+S/FXXJhj/acnAWZQJAbWTfS9Kyhu7msP0oQ
	EwVn+56HQ9tgpCKkTKaheo/kD4hpcETpPjbctBoDWmEfUY+AZOGpkKQQPjzI/P2r0egN20gclGE
	CTh2oZk0NcVPbPAhuRH9KRrdD8bMnPDQky0ZESW4hdkI2OxhhnFqFhGW2LaSSFWFEdsSYderSJ8
	WZg4Y=
X-Google-Smtp-Source: AGHT+IFZVLlCsiIj+W7MkskoknZWOJWt1+uBz/VnH3qVP0gmNZDGK8PME93IILaywDsrkXs2+vBMrw==
X-Received: by 2002:a05:6102:956:b0:5db:cf38:f4fd with SMTP id ada2fe7eead31-5e52cbfdf63mr1544082137.11.1765123325404;
        Sun, 07 Dec 2025 08:02:05 -0800 (PST)
Received: from localhost ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-93f01d022a4sm3059647241.3.2025.12.07.08.02.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Dec 2025 08:02:05 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Sun, 07 Dec 2025 11:02:03 -0500
Message-Id: <DES3ZWAKXXEB.2LQPMDZN4JFCB@gmail.com>
To: "Jonathan Cameron" <jic23@kernel.org>, "Kurt Borja" <kuurtb@gmail.com>
Cc: "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Tobias
 Sperling" <tobias.sperling@softing.com>, "David Lechner"
 <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v6 2/2] iio: adc: Add ti-ads1018 driver
From: "Kurt Borja" <kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251204-ads1x18-v6-0-2ae4a2f8e90c@gmail.com>
 <20251204-ads1x18-v6-2-2ae4a2f8e90c@gmail.com>
 <20251206200721.5e683a83@jic23-huawei>
In-Reply-To: <20251206200721.5e683a83@jic23-huawei>

On Sat Dec 6, 2025 at 3:07 PM -05, Jonathan Cameron wrote:
> On Thu, 04 Dec 2025 13:01:28 -0500
> Kurt Borja <kuurtb@gmail.com> wrote:
>
>> Add ti-ads1018 driver for Texas Instruments ADS1018 and ADS1118 SPI
>> analog-to-digital converters.
>>=20
>> These chips' MOSI pin is shared with a data-ready interrupt. Defining
>> this interrupt in devicetree is optional, therefore we only create an
>> IIO trigger if one is found.
>>=20
>> Handling this interrupt requires some considerations. When enabling the
>> trigger the CS line is tied low (active), thus we need to hold
>> spi_bus_lock() too, to avoid state corruption. This is done inside the
>> set_trigger_state() callback, to let users use other triggers without
>> wasting a bus lock.
>>=20
>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>

...

>> +#define ADS1018_VOLT_CHAN(_index, _chan, _realbits) {				\
>> +	.type =3D IIO_VOLTAGE,							\
>> +	.channel =3D _chan,							\
>> +	.scan_index =3D _index,							\
>> +	.scan_type =3D {								\
>> +		.sign =3D 's',							\
>> +		.realbits =3D _realbits,						\
>> +		.storagebits =3D 16,						\
>> +		.shift =3D 16 - _realbits,					\
>> +		.endianness =3D IIO_BE,						\
>> +	},									\
>> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |				\
>> +			      BIT(IIO_CHAN_INFO_SCALE) |			\
>> +			      BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
>
> What motivates per channel sampling frequency?
>
> Given you have to write it each time you configure I guess it doesn't mat=
ter much
> either way.

I guess making it shared by all is simpler too, so I'll go with that.

...

>> +/**
>> + * ads1018_calc_delay - Calculates a suitable delay for a single-shot r=
eading
>> + * @ads1018: Device data
>> + *
>> + * Calculates an appropriate delay for a single shot reading, assuming =
the
>> + * device's maximum data-rate is used.
>> + *
>> + * Context: Expects iio_device_claim_direct() is held.
>
> What in here changes if we are in buffered mode?
> We have no reason to call it but why does that matter?

Yep, I just pasted this mindlessly. I'll remove it.

...

>> +/**
>> + * ads1018_single_shot - Performs a one-shot reading sequence
>> + * @ads1018: Device data
>> + * @cfg: New configuration for the device
>> + * @cnv: Conversion value
>> + *
>> + * Writes a new configuration, waits an appropriate delay (assuming the=
 new
>> + * configuration uses the maximum data-rate) and then reads the most re=
cent
>
> I'm lost on this.  Normally the longest delay is governed by the minimum =
data rate.
> I.e. Samples take longer when running few per second, so we wait longer.

We are using the minimum data rate on the maximum data-rate mode. I
should have added "mode" there.

>
> I think this is meant to mean the delay needed for a sample at the minimu=
m expected
> rate for this configuration.

Yes, I think this was too confusing.

I'll add a `hz` argument to ads1018_calc_delay() and pass the frequency
of the maximum data-rate mode when preparing the config.

I think this will make the intent more explicit.

...

>> +static int
>> +ads1018_write_raw_unlocked(struct iio_dev *indio_dev,
>
> Similar to the naming discussion on the ACQUIRE RFC I'm not sure
> using locked here is really descriptive of more than an internal
> detail of how we prevent mode switching. I'd prefer something like
> ads1018_write_raw_direct_claimed() or ads1018_write_raw_direct_mode()
> (the absence of any other write_raw_*** would indicate this is the only
> valid one perhaps).
>
> Also this isn't the unlocked version, it's the one that doesn't take
> the lock.

I'll go with ads1018_{read,write}_raw_direct_mode().

>

Ack to everything else, including bindings stuff. Thanks, Jonathan!


--=20
 ~ Kurt


