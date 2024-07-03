Return-Path: <linux-iio+bounces-7209-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EFEC9253D3
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 08:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50DDA1C21228
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 06:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB2F13213B;
	Wed,  3 Jul 2024 06:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YzOSstTp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8BB130A4D
	for <linux-iio@vger.kernel.org>; Wed,  3 Jul 2024 06:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719988926; cv=none; b=EV4J8TkFncixiS8tzhKp4VGyAP1uAl4NlNt4h9PYbbaDNwEXZd7wH+Lllt2bV6zBVtNtOx08HlzRWKweUX086DJsh8MKwLQoIsToE51LePeS+7UZDtVbvtaJ4Z9Np9d3r+Fuk/whf7R6fUXZ0EEaDyMYYmnnfT9lnucrvFaG3Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719988926; c=relaxed/simple;
	bh=drhV+l/kmhfJs7deaiqhoqZiBYjVrhtJk0lA/W3ld+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LVPp1rBlNWbrHF1Mo19wQ/F7v992YD5TtdMj/05ROJr2/Goq05XDu973W3/ywoOIY8Bme6ZF3ErsXOGd3Fl7s8jbT+t4ZTq4S7ruNewY5n5LgsJQI9BLiPFw8zERUjouJ7DqSEeppy9X1dbjHtJz3zYSGmlI7cR1jooKa8hPUOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=YzOSstTp; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-4ef64a8cb39so100452e0c.0
        for <linux-iio@vger.kernel.org>; Tue, 02 Jul 2024 23:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719988924; x=1720593724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yur5x8y8+Q54jThB7cQ+pODfMdCJaF6otUCUrfdMD2I=;
        b=YzOSstTpV+l21mRdbWH+9vP0S3lEhR2snivwtXhKK5fVE781IGtYLZ+rUxloCKM1Ju
         l92zTxRdfCGvsXfXkWQYzkd/O4176rJGRiPNxrHgE67jlaKddbcl1lIs3jHUY2lcgw/T
         /LNmbbRpMm5+d80sWhA2ZK/Lmdi1f6l521dwKf0oRAipd1kyoE3CNzkHLdahoq7r4Ust
         EIODDRxB+QoKf0fdK5+o65nRAyJcIy1ge4fSN6QqAp3wZl8E57squpVRzxvXq5Y0j7Ib
         RPgdBXMHwGKpdIVHia+YHPYAZjT692wOQt7dR8LKZg1JxJbE1OobfQTpTm3+N5U4aVqa
         GsYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719988924; x=1720593724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yur5x8y8+Q54jThB7cQ+pODfMdCJaF6otUCUrfdMD2I=;
        b=Rmk3wraKGP76X/3CaWGoA5wv8ou0neQoWdWkjvb7Pm3kmoKbXWakCpPfJnOiHxuM5m
         R/Iq/XeTcwjcthwGZYbflBgqNQLeYT6jY3Lt+KYiIvD8yPeJyL4nmCqfoDw776aRVIRn
         ShDDNzqXUWcNBRy/V6BVQ3JJFYmYF6Gv2oh5LFVmFe+0tgVlTbFSWPsGbDmsv8OtlMkq
         T41G8qvsFtpDA49Hkyp/ngLh5WCgbIZ79g0HjbsAk1eebscc65M3etxT/iqVDubf/xyS
         Wu6MkLbzXmjwohyxNEUsNbdNzAQgGkre/x1fSBUpN59TeHIfGoLDyGh6eUZeYHiv7rIa
         omhw==
X-Gm-Message-State: AOJu0YyNX2+lbn8xtHH3pXrYaRHdmRjEyiLsp1hOn4iLV+SOw8aks5BJ
	2CkTU8HMAPh0x56X7/Vo/bjKEi28HqGub5saV0ulc/8Ola+ZY4rnXKf1i7gdhG1d+lt8P1HuNKV
	zQszMMI0Yglyt5mlswpkO/CTd/CtA5Mdv3co1rQ==
X-Google-Smtp-Source: AGHT+IGU4zJdFJrDIOvSRVl1gGVAB4S58FwSZgbCuX9M66AtIbG8KbGOLxeZ/4CsuVGL4OM88BGVexB1wvd6cPcHaVw=
X-Received: by 2002:a05:6122:4b0a:b0:4eb:152e:cf92 with SMTP id
 71dfb90a1353d-4f2a5503197mr10200692e0c.0.1719988924050; Tue, 02 Jul 2024
 23:42:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702-dev-iio-masklength-private-v1-0-98193bf536a6@analog.com> <20240702-dev-iio-masklength-private-v1-19-98193bf536a6@analog.com>
In-Reply-To: <20240702-dev-iio-masklength-private-v1-19-98193bf536a6@analog.com>
From: Alexandru Ardelean <aardelean@baylibre.com>
Date: Wed, 3 Jul 2024 09:41:53 +0300
Message-ID: <CA+GgBR8ERS31zCavAhwBDOga1hnYJH1QfUdQSuaP2RLrXZw-fA@mail.gmail.com>
Subject: Re: [PATCH 19/20] iio: imu: adis16475: make use of iio_for_each_active_channel()
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
>  drivers/iio/imu/adis16475.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
> index cf73c6f46c79d..1cc2a66a78ff3 100644
> --- a/drivers/iio/imu/adis16475.c
> +++ b/drivers/iio/imu/adis16475.c
> @@ -1608,8 +1608,7 @@ static int adis16475_push_single_sample(struct iio_=
poll_func *pf)
>                 return -EINVAL;
>         }
>
> -       for_each_set_bit(bit, indio_dev->active_scan_mask,
> -                        indio_dev->masklength) {
> +       iio_for_each_active_channel(indio_dev, bit) {
>                 /*
>                  * When burst mode is used, system flags is the first dat=
a
>                  * channel in the sequence, but the scan index is 7.
>
> --
> 2.45.2
>
>
>

