Return-Path: <linux-iio+bounces-7198-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9012925398
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 08:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 604CB285553
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 06:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3457912E1DB;
	Wed,  3 Jul 2024 06:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GuFmrlCD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491E661FFB
	for <linux-iio@vger.kernel.org>; Wed,  3 Jul 2024 06:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719987896; cv=none; b=urDVxLk2aDsW6Kl1ihcsAmcrLWGzVEK7qowChR49/Z454QnuC9C7EIwA+mH8VMy3vi957lri85dJj/vEVUi8rsKTtSx37tsFkhH/G8x6QqM3ccC/sM9JzQN/4Qg55iTlLmufUN9R5i8t5MnLNzPKFyxZ1jMMpdeiCMVByd9PuPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719987896; c=relaxed/simple;
	bh=Lq0UPT3vUQwvMnkgN5ANXQqvkRrFxjXL3a8v7cYbbKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bW+Ihe+ulZwkX430vSR+iBdyqI4mgD6U/fkxhXrCA0BSei6YpnhVJSsAZMUkCOogGzLLkK8lK16fArUcBbqcz3nY1E2Cdaungst0NaSnjASeTTm10lhylfxDvQWss4vdT38dhwdCShK/mzoZbB2mr4lm8X5IjAfpCyNUbaYPqvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GuFmrlCD; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-810214fd29eso1602241.3
        for <linux-iio@vger.kernel.org>; Tue, 02 Jul 2024 23:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719987892; x=1720592692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WEAcm2StCwwyeYic14Aly2kc9DLmMiiXY5kGptpy0bM=;
        b=GuFmrlCDOGbdpXeqfRP2tqEhWNKNLw2UyObTUzlzwD/AfDAIlv4Jc20gQaIss405SI
         pWJ/K/Af93LLOtElH+PDerHl9QnYycum+likHs5gpv0lLC4D4TsOvzi9eH4U0C9l7h2F
         gtFAIvErC9EYqMGIv2gAhE0u9V1boGCzlXO9+I1kEX17l9Ue8i9tjEdRPtreovqtC4Wz
         8p8V66OhuUsd7NuIOkZ9SSbGdI1JfwTvWmKSgVRH0SmwiSLkZ0r+wwTJpMVB3FkChYB1
         VW3nLRJD7EzBnvrQZgWNTZcr3d8nfw5VAzahFa/XOBY1qrlPyXul1IEJu7rCwzIDbpNG
         POxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719987892; x=1720592692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WEAcm2StCwwyeYic14Aly2kc9DLmMiiXY5kGptpy0bM=;
        b=V7Hydsrn3OKYzEqdHV+ec9apQpPOYt/e+dbQ7xXhxa62uWhupnqom1NCTOkCYvk9d8
         8sBZFJG1SjhM7WJIXSN4XKXH1on6+RtI/lAj8r91apTajdqPUcI+8gbJLtrH+tjSqJzp
         K1Pt+0t7oMzudNGw4JxKje1qsGiFfpMi1rZ3dyL6FLKA06U4MuFINKENll5kjHtLYTjv
         QGVQb90ZygrnFEA+a2d3G6yj8KSS8fQeJsRrvkgWPSiz7FnX9xp6ILXmtd1bTJHmXRnn
         Ql3JSXjT8ikRM6DykQii/2sDIfDYvcQyP5KzlGmcxPmqY3oYRlF/bLUSKf8uaSXVqWE+
         cMOA==
X-Gm-Message-State: AOJu0Yzodbo1LA1ROhTchraGWJnfOMsRcuFVIsZPJSzPs5FSYMVy3pVD
	RysUr7DKrXRE3AYho6XAgaigtfR+bRDoDCJnwxTCrAqoGpmCwscQGeHbLw8DDVKpfvzfLVEbUQK
	JEfR0KvfdadoXastVnEItrdKn9qN4ab5jWh/6wA==
X-Google-Smtp-Source: AGHT+IHzDhYnFR47ftpP+Gt0lHBcil5vtvlxM8vVGY5EFzQWbzo51CBClp9XHZNsLZkA20Z2tXq5nPi0G0RMWbj9Yig=
X-Received: by 2002:a05:6102:5090:b0:48f:19af:d2a4 with SMTP id
 ada2fe7eead31-48faf0db435mr11451472137.2.1719987890841; Tue, 02 Jul 2024
 23:24:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702-dev-iio-masklength-private-v1-0-98193bf536a6@analog.com> <20240702-dev-iio-masklength-private-v1-7-98193bf536a6@analog.com>
In-Reply-To: <20240702-dev-iio-masklength-private-v1-7-98193bf536a6@analog.com>
From: Alexandru Ardelean <aardelean@baylibre.com>
Date: Wed, 3 Jul 2024 09:24:38 +0300
Message-ID: <CA+GgBR8kZjenSU96tf0QAeJc_yX8Lefy1CGhNZUJFmciiE3yiw@mail.gmail.com>
Subject: Re: [PATCH 07/20] iio: accel: bmc150-accel-core: make use of iio_for_each_active_channel()
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

On Tue, Jul 2, 2024 at 7:02=E2=80=AFPM Nuno Sa via B4 Relay
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
>  drivers/iio/accel/bmc150-accel-core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bm=
c150-accel-core.c
> index ae0cd48a3e293..03121d020470e 100644
> --- a/drivers/iio/accel/bmc150-accel-core.c
> +++ b/drivers/iio/accel/bmc150-accel-core.c
> @@ -1007,8 +1007,7 @@ static int __bmc150_accel_fifo_flush(struct iio_dev=
 *indio_dev,
>                 int j, bit;
>
>                 j =3D 0;
> -               for_each_set_bit(bit, indio_dev->active_scan_mask,
> -                                indio_dev->masklength)
> +               iio_for_each_active_channel(indio_dev, bit)
>                         memcpy(&data->scan.channels[j++], &buffer[i * 3 +=
 bit],
>                                sizeof(data->scan.channels[0]));
>
>
> --
> 2.45.2
>
>
>

