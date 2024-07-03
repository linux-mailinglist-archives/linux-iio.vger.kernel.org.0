Return-Path: <linux-iio+bounces-7203-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DADA59253A0
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 08:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 802AD1F23F93
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 06:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D234130A58;
	Wed,  3 Jul 2024 06:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="af9Infwb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1E3130A4D
	for <linux-iio@vger.kernel.org>; Wed,  3 Jul 2024 06:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719988006; cv=none; b=iSSaRH32WUCtd0zX2Sj+fj1aJkgLG7B1IQVMF6b5yv9bbsw+UCKNXrRj6xw6d39FI/KetqlV9Irb6WYgiUAE8RH4r31p6YY3zUh3VOgngPYraLjD5yfkctIgVUXDbVLhw5PSQNersDrszE7erSdQCBT1Wp97axQtE1aT1K8mYw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719988006; c=relaxed/simple;
	bh=Pk/QR1QRQCMZ2xFaECQBqXPCVHDzzRYa8n34BAZd6G0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uPo3dc+JXnRyFGqUpcS2nbzCiLtdTqu2ACMXOsUJT71aqADIkSVt2LVY/jvXHbj1aNFYNy2abn43XMFk9LKaJfftjJYMQIOnXJkX0Tr4hJ6NhISHQ2TzkPTOiBwwcClXhvgFlG0tTw9lgrTpS9XKs+hovt7mf38nz/GLCxSQrNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=af9Infwb; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-48f96299087so282917137.0
        for <linux-iio@vger.kernel.org>; Tue, 02 Jul 2024 23:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719988003; x=1720592803; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZeniwkoXAnUgaJ87uJT/b8fqh8VW1xJWs7CU9qOvv4U=;
        b=af9InfwbjuOv7pxV7oZHmdnxEv3vw1yb3zLkkJdhtWnQw82ETo864IXsfNpbrNhLpS
         9n3KUUCoaYNWJuLDpc9az0CEZ5aZ3pkoScsQzlN91VZhv+oLXS4C6RdLSBiFZMeeHP5t
         cC7wyIyDJWTtZEGeWXzWec7U4viDNtFO2JlTlnHmaLB7fhn1JM8r1V9seAxNz1234nrk
         nhpUoyrtv6ZMtZ4uouzr9qV66MTZ8yiCnk7AyxEiWlPDkO46Wi4KNaXtJ4SGx4YqQSIC
         cdxEXrTM3vZVhPNxHorE9gp8d6Igl0wA2DZS/2mfCunjN15KTH+MAi5oJXN5alhkLlms
         tJFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719988003; x=1720592803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZeniwkoXAnUgaJ87uJT/b8fqh8VW1xJWs7CU9qOvv4U=;
        b=gPC9piPX7RAycROooxGEzD4/DqpAlfseFQljAe7PeBV4o2P6ZDoWQfqgtxyHqvxbgT
         Obyiakzfir7lf/YjM/oUvohbtaB4N5vVPFUq6XQN3KY2aeGdlN/lDMBn20T9KXkxqKjO
         tKVJDF1bPfh+FgD6H9vWcUVhzEAeomEAWPWmXPGZhsn1LFQKUZdsAgdklXutQPFgXRUV
         t5gENOSmMJHS1KkSwz+57Z1cwWCOXhFfJ6sFPuzhxVI/tTlvfKhAZ5DepRegFL0oOSXh
         ODtsgaTDRW7FN1CFbYv0028LL2fDssDWWXpzw/O2+JlabyF2yE0xPzHyv2o/Vf1onuY4
         6ZqA==
X-Gm-Message-State: AOJu0Yw1lMt+dhi7xf8UHW/70DCgdAh0THU+OzUOBNbhNfs6338u9OvO
	0o4H/2jzVStZ+MoKL9UMkopp1xc8GJfH+DrsGAZGbMAfpAPHMoJvUO9gVI6OCMx91d8F69g12Jw
	aiRQDGVlc4mxpen2jpoA3+2/utyEyLt74CpPPEQ==
X-Google-Smtp-Source: AGHT+IGUXb9ngGHkkPuOkbjBMdicrLFhyex2By2jj3YkauKsdM6etom92MfQD0RMY5Z70Km8QtheStFu2YApca3rVv4=
X-Received: by 2002:a05:6102:2ac1:b0:48f:1db0:e268 with SMTP id
 ada2fe7eead31-48faf139718mr10136984137.3.1719988003057; Tue, 02 Jul 2024
 23:26:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702-dev-iio-masklength-private-v1-0-98193bf536a6@analog.com> <20240702-dev-iio-masklength-private-v1-12-98193bf536a6@analog.com>
In-Reply-To: <20240702-dev-iio-masklength-private-v1-12-98193bf536a6@analog.com>
From: Alexandru Ardelean <aardelean@baylibre.com>
Date: Wed, 3 Jul 2024 09:26:29 +0300
Message-ID: <CA+GgBR86+DgLh=e_Tu7XWDEcjwt1UUMvcTkwN6xmsuaeaODT_A@mail.gmail.com>
Subject: Re: [PATCH 12/20] iio: accel: stk8312: make use of iio_for_each_active_channel()
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
>  drivers/iio/accel/stk8312.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/iio/accel/stk8312.c b/drivers/iio/accel/stk8312.c
> index b3534d5751b95..abead190254b5 100644
> --- a/drivers/iio/accel/stk8312.c
> +++ b/drivers/iio/accel/stk8312.c
> @@ -448,8 +448,7 @@ static irqreturn_t stk8312_trigger_handler(int irq, v=
oid *p)
>                         goto err;
>                 }
>         } else {
> -               for_each_set_bit(bit, indio_dev->active_scan_mask,
> -                                indio_dev->masklength) {
> +               iio_for_each_active_channel(indio_dev, bit) {
>                         ret =3D stk8312_read_accel(data, bit);
>                         if (ret < 0) {
>                                 mutex_unlock(&data->lock);
>
> --
> 2.45.2
>
>
>

