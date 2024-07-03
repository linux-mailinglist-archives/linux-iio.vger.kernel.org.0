Return-Path: <linux-iio+bounces-7197-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4860925397
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 08:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68F5B1F23C93
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 06:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA61B12E1CE;
	Wed,  3 Jul 2024 06:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OlL5mW8V"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DD261FFB
	for <linux-iio@vger.kernel.org>; Wed,  3 Jul 2024 06:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719987846; cv=none; b=Pz0F/y1NXSLHemwnR2IfvdLeFjlp5otmsMdT9jKvYILIQAcmsyltMVRBTIxGTmnxNMeqRfZIjCTrhCIP0uGj8LCOSuQORMAC/9kZe9muh5DlpVUDCLudx/Pelh2yfoakAbvhVpZQ4k90sgl5CcWpy0lAWkCjPrPLtcBQ/i4MnwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719987846; c=relaxed/simple;
	bh=MEOJ88XvyP4x4YpTAbmio5cpISsYZT4lPvcy33vcuZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VoDARqcfs8kJ+FRfeNJmc/pHdUfYbdIye9ZH/Rbu7thBK9b5eZ1I5dU40PYQ6IUU0SN8Ouv/fQZ4h7GrnOAPRPGbXkF5iioGgxdCrpZ4BqddameLpfrehyjOA48pQvyATtR2ncvlwey4ks5AWR3wMhqMzWNCOrscsN66D3nZk0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OlL5mW8V; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-80fe2f8f6edso200201241.0
        for <linux-iio@vger.kernel.org>; Tue, 02 Jul 2024 23:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719987842; x=1720592642; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B90T9+qJnSvewQnG3SRs23eyBpPBHimMd3xTTqkFe80=;
        b=OlL5mW8V6e5p6T6OPLcuZY/9kR519N+NijiToxc1px+zwZUtCSK0Icu8SA6gTyTgne
         3VDp6GVpHNc8AubrZIesLb5awH0WxHvKVQQCBNr2HL2SVqtiGJFvk1BQQYGkT+y24HxG
         BOf0UnJn3n0ggqFKj8IOMEmDaCTx5Im4UiMiiEi+sDKv/peSV6WQIvAEQLidV7TyDioF
         xZJY2RIEijupp3FCnblwculi4b0UjIyLzX+ICMTpNS39QmYs4sRp+gvhX8eQTyFAEaIy
         tQXkS8u1Jch4osrBrZu2pHNTQmrdjnVL8jViw7sR8HAV4fj1Sfnqx+Uuh6ytEvroMIrK
         73cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719987842; x=1720592642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B90T9+qJnSvewQnG3SRs23eyBpPBHimMd3xTTqkFe80=;
        b=BKjcNdgVfYMZjh2EsPPe9RnRwHpvcyDB7XyI4BGDfrICAOJpyRKY22mQoDJEa8ByUm
         b6lmfgIOVuIrIBencOLM39fiHbI1mB9sR3w3RInEwnJuU6aPWRHsbHhbqI80nhZCQ/om
         0oC5HXF1cfU0/mP3lP3MKHAQb8fC9a9FewWKcEkYAhYLMllmRTxlbQeLjHRB//uNsEO4
         N0nKSTzTXOawWBBr/Y2oSwSIg2fJiWrCyHfWuDxTHCxkgBmxvtvgszvmIQCiVZfarqmC
         pzkVyUl9e+yCor6pwEBCH9mY3yqB8HudGtF760MvUoBo/UQyQFtqaMm3j4wjnwAO2mjL
         eH0w==
X-Gm-Message-State: AOJu0YxTEgpQn7oDB3yOK8MyB0bAKKhBnid2ClOUKVBhAmmLF8MCzsYW
	ZWpknLKVuN09nbkk4DwhjNtbFIAZvX4GR5OxiM1v04imLoxuFcGLe0HmOMGWIvWW9GahvlSPp82
	W4SmICYt7k0Echtaoifish27U/2POpcKuu0hcxA==
X-Google-Smtp-Source: AGHT+IEvoaDw6GoXfUAvbDw4QpnNY30WWBvZAY+2S6VYPqlblqVVWDho20/AIINjpZRw8gNL7XP031dwLiyilOrhXek=
X-Received: by 2002:a05:6122:134d:b0:4ec:ef7d:b99 with SMTP id
 71dfb90a1353d-4f2a5561d1fmr10725772e0c.0.1719987840954; Tue, 02 Jul 2024
 23:24:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702-dev-iio-masklength-private-v1-0-98193bf536a6@analog.com> <20240702-dev-iio-masklength-private-v1-6-98193bf536a6@analog.com>
In-Reply-To: <20240702-dev-iio-masklength-private-v1-6-98193bf536a6@analog.com>
From: Alexandru Ardelean <aardelean@baylibre.com>
Date: Wed, 3 Jul 2024 09:23:48 +0300
Message-ID: <CA+GgBR9vdx1=yNPUsmuiEHzUSpHvi=7_vb7EWYix9B_204nApg@mail.gmail.com>
Subject: Re: [PATCH 06/20] iio: accel: bma180: make use of iio_for_each_active_channel()
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
>  drivers/iio/accel/bma180.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
> index 6581772cb0c46..2445a0f7bc2ba 100644
> --- a/drivers/iio/accel/bma180.c
> +++ b/drivers/iio/accel/bma180.c
> @@ -876,8 +876,7 @@ static irqreturn_t bma180_trigger_handler(int irq, vo=
id *p)
>
>         mutex_lock(&data->mutex);
>
> -       for_each_set_bit(bit, indio_dev->active_scan_mask,
> -                        indio_dev->masklength) {
> +       iio_for_each_active_channel(indio_dev, bit) {
>                 ret =3D bma180_get_data_reg(data, bit);
>                 if (ret < 0) {
>                         mutex_unlock(&data->mutex);
>
> --
> 2.45.2
>
>
>

