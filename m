Return-Path: <linux-iio+bounces-19230-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BA4AAD84D
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 09:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 752374E2C33
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 07:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270CC20FA86;
	Wed,  7 May 2025 07:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Duc7T/6l"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3670520FAA4;
	Wed,  7 May 2025 07:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746603449; cv=none; b=LcBjjteMujQZoJf3an7a5YPbKgYMNfWnhS4G5RW+w+RH1TC6TIiDxcVPtuqsy0tHBsHBQIrxn9hNOTtYIRv1PY3swgqXVKdklVnZS2OAzk5AiahvfxIyvLO+gj1ju+YpJb/Xz6UJNq3B48uxf/fyawYIWbM/ZB4Tnz4Wd52B+Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746603449; c=relaxed/simple;
	bh=FuemIm8116hywSfV2SSwxng11itfwwUW+mKk4yp4GCI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uTe7qu5xpdZ2n1/4IaEK3NaBcs/3s6zakuftK7oMiLW62pkG1tAWDZ+Pfcuad7CAu8RVn0D/vHjLww2rwdlIWCKHU88EGdFqTSyr4avppTN4ngq2LNfEpZIwpgDg17qs8OUf8vTliGfOeImrgH33vIzN8WTrOP85bYYULq5zb/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Duc7T/6l; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-39ee651e419so3442930f8f.3;
        Wed, 07 May 2025 00:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746603446; x=1747208246; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DbZ5zfwh7oAWQ9rUKaaES+YOBoWmN1midVh0tt2UzNo=;
        b=Duc7T/6lMNKOm81XW9ytJE2ORCAm9AS7e5r3IB7QKW6klzvqr4LwEZn9Wu/CRAw0Ef
         qorH5JfQTZ+Ggts9XIy51UKXUDlDfm8wmBzt3cQXMbEw0JVVjRftQ2BuT7BqG/m4Jxmr
         EX+jnuML+MwtUagmeFUflC61Jaz0P4KvSdE60H3X4kzxneRCVF4TD/fxzH+qOWlnm10o
         orsO4gcaysqWTkgCi9Qp9vZ2C4I4/yLhnw9KE2oimypxr96STfIfnSDs0hzKQRYh/LhS
         c0rR8HuXpDwKYB/zBZVmcMCm8rzg9ZCiYaQ9nAYXXNmOTwieONF1WHMyjXaHPj+b2Yvh
         kv7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746603446; x=1747208246;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DbZ5zfwh7oAWQ9rUKaaES+YOBoWmN1midVh0tt2UzNo=;
        b=vCQvUe8De+zYOAH0JPoz5rGRLgrxOLxyjZMrg9nB+H6/79JWMOLVpgrdkmiJGYpQZp
         JkvU5h9tOuJDMgW1brdFzLjqGjRYjoqzS/q3qFzbQ5mOCd/DK3iq59XJqc+vQauhCQIw
         udj3NWkmxEbu9aUxNHkbksDo+Qv0RssXYS/yuDOI/tSDCmZ3dAR55yED/ufbwDKMh06m
         u+xjmOmdG+evP0Vm1FZ4rMtF2tMrgxQCXtsJ+vraT8vu0bvb78vu5mEnLTLip7mmZVK7
         h1I+QIaL7koUjCDet6ysh7b8GR9hpLroa1BXcai4EXss3LqbIpqzFf5tqPH30cvM2WEd
         nZ5A==
X-Forwarded-Encrypted: i=1; AJvYcCV90tI/KMskFlVacrjNJdp2IncOypR+DNtL6Wk9skkUShxCDxa3C2UaGL8uDbYuPHnljD0UNj6S0p0slNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFV+L/Ve1b2qmFEiux5UsInMpKmxoHhZWX9I8dUOGpkaysPECi
	5d5qkxY7tIYAqzLGOA93+jARfwV5ylUwxxPtD68i2neZ+kb2igL1KFLlVjDFtZw=
X-Gm-Gg: ASbGncujp+p4sYPiPB6nLnsYcgK6k7nm2ovKcbDlUx+wmF5Umr4Yf4c3Cmy5IsrYFsd
	txqsfGdDi1steyTokW7d9+DZr4oJ9TW3wHh5MpwOdPxoY2hq5lHg+cG7GT6dXqVzrOKVSd0O3XU
	kF3je9rC4P18x73DQPbK5yfFgJiaedH8fGjtxxmgWdDZzfnvemn18+v4uZ/RxM/TQ/Q2057EGAC
	D75oUqlUzS1WS73F7RZ1yuVqO3ZbZKpR/lhMi8wCpCg/9ao90ef+KvuFn+LHnTyn3uJCBodMCaH
	uhncBQbudnYy7WuwHAe/V770kkU+Sir3a9cZrF62N8EfZOuYZgAARktYPH7JrXkSbr+NbpwI2vz
	I3wTn40nT73zLeVg=
X-Google-Smtp-Source: AGHT+IFOksKkR0HZi+I7KBLluOyRJCQ76SAH8OckOWSd1HHAyJ3vZMTUpdS4daPAGAHRQm6jtP2RIA==
X-Received: by 2002:a05:6000:2905:b0:3a0:6b91:fefc with SMTP id ffacd0b85a97d-3a0b4a465ecmr1462408f8f.50.1746603446339;
        Wed, 07 May 2025 00:37:26 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a0b6d0e1ebsm378231f8f.80.2025.05.07.00.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 00:37:25 -0700 (PDT)
Message-ID: <b986f420280ae64b77c9534b856f3537bd5b29ed.camel@gmail.com>
Subject: Re: [PATCH v5 6/7] iio: accel: sca3300: use
 IIO_DECLARE_BUFFER_WITH_TS
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>,  Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Eugen Hristev
 <eugen.hristev@linaro.org>, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Date: Wed, 07 May 2025 07:37:50 +0100
In-Reply-To: <20250505-iio-introduce-iio_declare_buffer_with_ts-v5-6-814b72b1cae3@baylibre.com>
References: 
	<20250505-iio-introduce-iio_declare_buffer_with_ts-v5-0-814b72b1cae3@baylibre.com>
	 <20250505-iio-introduce-iio_declare_buffer_with_ts-v5-6-814b72b1cae3@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-05-05 at 11:31 -0500, David Lechner wrote:
> Use IIO_DECLARE_BUFFER_WITH_TS() to declare the buffer that gets used
> with iio_push_to_buffers_with_ts(). This makes the code a bit easier to
> read and understand.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> This is an alternative to [1]. Also, this serves as a test to see if we
> can get a rule of thumb to decide how much is too much to put on the
> stack vs. needing to put the buffer in a static struct. SCA3300_SCAN_MAX
> is 7, so this add a bit over 64 bytes to the stack, make the stack now
> roughly double what it was before.

IMHO, I think that for this buffer size, having it on the stack is very rea=
sonable.

>=20
> [1]:
> https://lore.kernel.org/linux-iio/20250418-iio-prefer-aligned_s64-timesta=
mp-v1-1-4c6080710516@baylibre.com/
> ---
> =C2=A0drivers/iio/accel/sca3300.c | 18 ++----------------
> =C2=A01 file changed, 2 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/iio/accel/sca3300.c b/drivers/iio/accel/sca3300.c
> index
> 1132bbaba75bcca525fac2f3e19f63546380fd4f..67416a406e2f43e4e417210410904d4=
4c93111d2
> 100644
> --- a/drivers/iio/accel/sca3300.c
> +++ b/drivers/iio/accel/sca3300.c
> @@ -58,15 +58,6 @@ enum sca3300_scan_indexes {
> =C2=A0	SCA3300_SCAN_MAX
> =C2=A0};
> =C2=A0
> -/*
> - * Buffer size max case:
> - * Three accel channels, two bytes per channel.
> - * Temperature channel, two bytes.
> - * Three incli channels, two bytes per channel.
> - * Timestamp channel, eight bytes.
> - */
> -#define SCA3300_MAX_BUFFER_SIZE (ALIGN(sizeof(s16) * SCA3300_SCAN_MAX,
> sizeof(s64)) + sizeof(s64))
> -
> =C2=A0#define SCA3300_ACCEL_CHANNEL(index, reg, axis) {			\
> =C2=A0	.type =3D IIO_ACCEL,						\
> =C2=A0	.address =3D reg,							\
> @@ -193,9 +184,6 @@ struct sca3300_chip_info {
> =C2=A0 * @spi: SPI device structure
> =C2=A0 * @lock: Data buffer lock
> =C2=A0 * @chip: Sensor chip specific information
> - * @buffer: Triggered buffer:
> - *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -SCA3300: 4 cha=
nnel 16-bit data + 64-bit timestamp
> - *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -SCL3300: 7 cha=
nnel 16-bit data + 64-bit timestamp
> =C2=A0 * @txbuf: Transmit buffer
> =C2=A0 * @rxbuf: Receive buffer
> =C2=A0 */
> @@ -203,7 +191,6 @@ struct sca3300_data {
> =C2=A0	struct spi_device *spi;
> =C2=A0	struct mutex lock;
> =C2=A0	const struct sca3300_chip_info *chip;
> -	u8 buffer[SCA3300_MAX_BUFFER_SIZE] __aligned(sizeof(s64));
> =C2=A0	u8 txbuf[4] __aligned(IIO_DMA_MINALIGN);
> =C2=A0	u8 rxbuf[4];
> =C2=A0};
> @@ -492,7 +479,7 @@ static irqreturn_t sca3300_trigger_handler(int irq, v=
oid *p)
> =C2=A0	struct iio_dev *indio_dev =3D pf->indio_dev;
> =C2=A0	struct sca3300_data *data =3D iio_priv(indio_dev);
> =C2=A0	int bit, ret, val, i =3D 0;
> -	s16 *channels =3D (s16 *)data->buffer;
> +	IIO_DECLARE_BUFFER_WITH_TS(s16, channels, SCA3300_SCAN_MAX);

On top of what you mentioned I like this change. The pattern you're removin=
g is the
typical one for getting into unaligned accesses.

> =C2=A0
> =C2=A0	iio_for_each_active_channel(indio_dev, bit) {
> =C2=A0		ret =3D sca3300_read_reg(data, indio_dev->channels[bit].address,
> &val);
> @@ -505,8 +492,7 @@ static irqreturn_t sca3300_trigger_handler(int irq, v=
oid *p)
> =C2=A0		channels[i++] =3D val;
> =C2=A0	}
> =C2=A0
> -	iio_push_to_buffers_with_ts(indio_dev, data->buffer,
> -				=C2=A0=C2=A0=C2=A0 sizeof(data->buffer),
> +	iio_push_to_buffers_with_ts(indio_dev, channels, sizeof(channels),
> =C2=A0				=C2=A0=C2=A0=C2=A0 iio_get_time_ns(indio_dev));
> =C2=A0out:
> =C2=A0	iio_trigger_notify_done(indio_dev->trig);
>=20


