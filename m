Return-Path: <linux-iio+bounces-7210-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7470D9253D6
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 08:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FD30284C31
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 06:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655EC132134;
	Wed,  3 Jul 2024 06:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="l5Tlyjgs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC29130A4D
	for <linux-iio@vger.kernel.org>; Wed,  3 Jul 2024 06:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719988973; cv=none; b=TSFfzjo9YnGoujnFQFAla7U+Gyjr0rMUR2KAPB0Vnvm2n3pzP1gPloMytroGysOtisZ1a6ezXWGkW4iVQ5Ji4WjCLwijqdouovpnSNd8yWHm/zeMBcxRKHvFNKqO4NwTwxHr1FbsCKW+cKy+PLd/k9rGbKy/YQSqKezyFD654gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719988973; c=relaxed/simple;
	bh=PdwtN+Rbxelkr4Xw5fQ4J8100LEDw0GCaAdRl9JJ3GE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RSjnfqJEofOkvy1YCht33/v3k5dUZlSuA4ON7E9o+qci6LPcsdJH1hsslWlDRVhNcFcITxH62iZ1gCk/Byd8Q6m/9K5OxPrlJu+wTkbeuL8FlDmijkuTJqeRSExLtVbHKqvAxPDqOLXxrR44SicCJ4Q8WWsnCQ+5S4t4Huos9RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=l5Tlyjgs; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4f2e0a2bf79so12532e0c.2
        for <linux-iio@vger.kernel.org>; Tue, 02 Jul 2024 23:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719988969; x=1720593769; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/BWoe3r8T20wkxLXJ9U4Y3vjxspmRkp94Q3dB56o7kw=;
        b=l5TlyjgswuKhK4zbUZgrQyH9UoBRhJgsFma+D31IrrE41jwXvQjKYq/wr0LReb9aFO
         AH9HCkNVyXfOI5kdD72v6TULeJ8wA14swlKpt3nsx9JhOWw55LyEqBK5hkLvT9cjvTZY
         F6o/XUOMhM+jamJ/8MAYj2GjgXtvSpBt7mzOaAVs+L4IYGVDCNCNNqT/w1INBEclO9N3
         Gp/1PQ+GFhIfhtv/f53r+g19WmEjfAgR0KdgL5NEKtSAS8FT7fHM4Q3kEPT+8qB1tW+d
         g9CAQZPbUqwiuPziGkrHZJ65kGrSdcZt6qY3AjJjoXQL0D9oduMTiIUpWfipnkRBrmVw
         BhLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719988969; x=1720593769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/BWoe3r8T20wkxLXJ9U4Y3vjxspmRkp94Q3dB56o7kw=;
        b=wkw1Wo62QyrabXkMpcQA01IxxdDcaQS85++wzcJNrIRYR3qDf6tb0CDyWkoGqNey4Q
         4egStufFqUfdnIIHoHzJr+emV2a8WzNzrvR5qBhdMarprhGNCQWzkhyGcAB/EDIxswGE
         55+Yp6EeWIflZE6CUk6L3i6rTNizM7YVQ7Hypd22XRFJR6AzWVruFWSXi8aQRNIEPtoZ
         7VSB4ocwpKdiK2pMXi1zG53+VymwkhQLpdc1PrDBU+o8j1G+ou15Xdd2w02CX40RYeCT
         WTIr2Ry+UjkUABZsz6Fbh63zQYbIsh83bSeLFC1CD2Tao431ByKIpoNHdIO6olWQGP67
         5eFA==
X-Gm-Message-State: AOJu0Yxs34aS0Lrwl4um5vBjcktp5cinTtsiQ2K9iaLXDdSgAdWN73dz
	EG/TrkDJFo/0YH01hI4jOoik8ZhIwlwucb8CQqvInEueDhk/k0YQmIDiIgwKw/aAu+Iv0+YfC4U
	XLw5gL9rrSwdYAfm2wzX2dNjy1+a3nl2sxZjcqA==
X-Google-Smtp-Source: AGHT+IHgEiNF2c/I5ttLf/dG1qkuSt8wiZrHpmF098bQrHHOFu8xkCJVjtcHyToLzuSleFqfYMgS8eGjf+ziCjEcnxI=
X-Received: by 2002:a05:6122:3224:b0:4eb:2012:f5ed with SMTP id
 71dfb90a1353d-4f2a56e4202mr10781037e0c.1.1719988969594; Tue, 02 Jul 2024
 23:42:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702-dev-iio-masklength-private-v1-0-98193bf536a6@analog.com> <20240702-dev-iio-masklength-private-v1-20-98193bf536a6@analog.com>
In-Reply-To: <20240702-dev-iio-masklength-private-v1-20-98193bf536a6@analog.com>
From: Alexandru Ardelean <aardelean@baylibre.com>
Date: Wed, 3 Jul 2024 09:42:38 +0300
Message-ID: <CA+GgBR9iiWdgihgQU+kxedhqUzMK7qYJynxCpwwkutrWevO9Jw@mail.gmail.com>
Subject: Re: [PATCH 20/20] iio: imu: adis16480: make use of iio_for_each_active_channel()
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
>  drivers/iio/imu/adis16480.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
> index 56ca5a09fbbfc..2f08268bd724a 100644
> --- a/drivers/iio/imu/adis16480.c
> +++ b/drivers/iio/imu/adis16480.c
> @@ -1410,7 +1410,7 @@ static irqreturn_t adis16480_trigger_handler(int ir=
q, void *p)
>                 goto irq_done;
>         }
>
> -       for_each_set_bit(bit, indio_dev->active_scan_mask, indio_dev->mas=
klength) {
> +       iio_for_each_active_channel(indio_dev, bit) {
>                 /*
>                  * When burst mode is used, temperature is the first data
>                  * channel in the sequence, but the temperature scan inde=
x
>
> --
> 2.45.2
>
>
>

