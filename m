Return-Path: <linux-iio+bounces-7202-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DBE92539F
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 08:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17AB01F23F6C
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 06:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E039130A4D;
	Wed,  3 Jul 2024 06:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qg189c2S"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E1512E1DB
	for <linux-iio@vger.kernel.org>; Wed,  3 Jul 2024 06:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719987989; cv=none; b=RgHdIwzRMvg4a28861rtwEtwCgx3hsobj/mlKY3a61Y3ip9Fq/9yMyOKDOpNWmVWyxCRiq0s7mv7hUpoai5D3lO4GC+FH+mistY8fsKYm9WNUELL16LEnUwwnPDnGuZGjhe1ovIF5u7Zsikych9zJG/AjaSdoARbo7uqGupKQ9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719987989; c=relaxed/simple;
	bh=IPaXlrtvEWY4XmSWWnalLsC3CtYjJseAzPp1WvLsvYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JdLkFOzc/zyUm9wVHKrNvPGcNNoGWaseML8Nq0NswzAyv80o9ZJyHmnf4ReDpvcMhh9Auj/RMkUH0CIxd5ACuJLy/SUr9XbPdDCS1+JqYa++BjBDMiVco9vBwIjy/Ch/RD6TFtn2ID4iVFjO8Hg//Zb6FUXaMZC/zwKTlWIjXuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qg189c2S; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-48f609f3180so180787137.0
        for <linux-iio@vger.kernel.org>; Tue, 02 Jul 2024 23:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719987987; x=1720592787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sne0kbDH+CE2KyZ6pihV0DRumsxIF74y33+jT/BOnEM=;
        b=qg189c2Swo5acd3bm3zF4XpuXPBBEvn8BU/3YRISjWSbr0uYLWWX/qMV8RNDfRaaho
         qT5yrm1SKltB09nLmdABnTbjPP9P4T5JZ8p5bNrbX5ZYPX4Xh3ys2WBCxF0is1EgR2OM
         4NeE23CGjY2TWD5WrBEqDNZR1XUvsf16Xf45fSTBdEZu4O8iK/jMV01EeFsx0XJ1Bfcz
         /wjusdU3B4Vucd8LHuuNDsGXhfik9QruqKXISI6pdKd2kqhbhxaGNCrKQTJrNcUMFdYd
         ielvJ6jFJDeIDpIpQAso1/5InQII0RSOIO9BNK6SuNVJ7xt+9vFbKvziXt0/1DV15JDf
         6c/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719987987; x=1720592787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sne0kbDH+CE2KyZ6pihV0DRumsxIF74y33+jT/BOnEM=;
        b=Mnefwe+rFIZPyjHSW1+V0D/uo1NQOF6g4kHklnU0f9QwKqeDm8D3/vVurNc6Joi4Nb
         Tk8vyJ5Mxo2MidIxRJBLfS79AMMbL7TolavFiZBjrjj5Gn+yzQVVAKy1nvjjZYet3gip
         dDeZXT9mP7qsdmfFO0Bv4EPqP5pgmE4VTe0boxLUeDhxXd9liPg/CDbsXvKndE6PwzYw
         FyBbYjlOLa7QeGK7MuwdWvAbPXXLcLmIfb5dOgaWi6+8etpMIAPgSShyBeuW6KU8PdIX
         1SZhAttsR6DW7RPNDuIA/01rjUVAMMlkj1iaVSWiwRvM380iw0QT7RPtIyJTmUsAtSYy
         Urcw==
X-Gm-Message-State: AOJu0YxpdqXovwjZut1TqkWS3cDNB/LPuuyzNaCRL4IBM0y+/kN4nhe/
	jqnl9weEp05H79liHcLrdhSrsEyOCBGTjZzSptZ6s87h1zdkCZ1sSR3IGl7i5MuTAIik4VzYppt
	9uwstBrHuNoINE/MjlGpQoAuT3pU7cdPM+ce74A==
X-Google-Smtp-Source: AGHT+IHV7uCAspqYexpyv/SktQQ4BYJXqCHn4QagF4ADMhb6Z4Ltp07c/8lFKyHFQ7r043Pz++ddER57r6T5Fq8YbI8=
X-Received: by 2002:a05:6102:e0d:b0:48d:c235:54b4 with SMTP id
 ada2fe7eead31-48faef3e72bmr11468217137.0.1719987987166; Tue, 02 Jul 2024
 23:26:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702-dev-iio-masklength-private-v1-0-98193bf536a6@analog.com> <20240702-dev-iio-masklength-private-v1-11-98193bf536a6@analog.com>
In-Reply-To: <20240702-dev-iio-masklength-private-v1-11-98193bf536a6@analog.com>
From: Alexandru Ardelean <aardelean@baylibre.com>
Date: Wed, 3 Jul 2024 09:26:14 +0300
Message-ID: <CA+GgBR_oj7XticpwcNAt3gE+Kr85vGzPo8UPNE5VOX2qddSFZg@mail.gmail.com>
Subject: Re: [PATCH 11/20] iio: accel: sca3300: make use of iio_for_each_active_channel()
To: nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, chrome-platform@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Cosmin Tanislav <cosmin.tanislav@analog.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, Dmitry Rokosov <ddrokosov@sberdevices.ru>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 7:03=E2=80=AFPM Nuno Sa via B4 Relay
<devnull+nuno.sa.analog.com@kernel.org> wrote:
>
> From: Nuno Sa <nuno.sa@analog.com>
>
> Use iio_for_each_active_channel() to iterate over active channels
> accessing '.masklength' so it can be annotated as __private when there ar=
e
> no more direct users of it.
>

Reviewed-by: Alexandru Ardelean <aardelean@baylibre.com>

> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  drivers/iio/accel/sca3300.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/iio/accel/sca3300.c b/drivers/iio/accel/sca3300.c
> index 306482b70fad..fca77d660625 100644
> --- a/drivers/iio/accel/sca3300.c
> +++ b/drivers/iio/accel/sca3300.c
> @@ -494,8 +494,7 @@ static irqreturn_t sca3300_trigger_handler(int irq, v=
oid *p)
>         int bit, ret, val, i =3D 0;
>         s16 *channels =3D (s16 *)data->buffer;
>
> -       for_each_set_bit(bit, indio_dev->active_scan_mask,
> -                        indio_dev->masklength) {
> +       iio_for_each_active_channel(indio_dev, bit) {
>                 ret =3D sca3300_read_reg(data, indio_dev->channels[bit].a=
ddress, &val);
>                 if (ret) {
>                         dev_err_ratelimited(&data->spi->dev,
>
> --
> 2.45.2
>
>
>

