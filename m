Return-Path: <linux-iio+bounces-7208-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D614D9253D0
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 08:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 790741F25142
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 06:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCD2130A4D;
	Wed,  3 Jul 2024 06:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nnbPmD+9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1704D130A68
	for <linux-iio@vger.kernel.org>; Wed,  3 Jul 2024 06:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719988904; cv=none; b=cJztWSfAZi8Hm9gKRt1AQ0U0ue3JzeVUbbTs2kAUjs6JxvYeCMDOed4DQPvq1kPX3kcjhn0Q3OPcC9ZksSOqGBOnzXUjrH3O8JlgvbwbDznlY9OYauxlyHzrAuOVyvIRGoeXP1NRidASeoKS2RoBxwQLr9LYm53BYG0OifJrTck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719988904; c=relaxed/simple;
	bh=bMJccecekkBOVLBKBVwDQI6O/15WUEit6u9QoGrRMKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N+Z3HkZy4FqbJJ7FkdfXN4m7T3pEEk0ZLytr0In4ETFj5/lGceHD3T51dKc6+8o2iE4I2rdGMsxnLEuUKXCkmRuXhNquvv8374fQO6FNdohTXxfmsQ0l+mWckushmD0A9SYGsch/Wf5XP2F1sunROXD+KK4/EH/gyGgMRegT2KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=nnbPmD+9; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-48fa96f5a7dso235651137.3
        for <linux-iio@vger.kernel.org>; Tue, 02 Jul 2024 23:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719988902; x=1720593702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+vLgF0+RXMLNkLXXNsHGCbj/O0dwlYR16fZtiGDJBZ4=;
        b=nnbPmD+91fZ7kI7lPtbUrRBdRat+mJ1Hj0yL01a9e1VHLtQoHW8CcsIPzpXaG6I9EF
         QcGxZqNZN8SkboY9pz9ohSY47ky9p1PYHl6eRH39DFWn3/g1ekjuhbdSB4asMKShdgFo
         GIL5iv9mPP2L2FipKH+QFL3kJbKdBJXHY4n19yq/rLzvvx+X1amHCOx3kj8AqBtI5io5
         3mrMZNx2etuTMo+2/koWMYduazPhSRgAftF0jUuqAHkLb/tsR5VKsWo7tM5RzaEUscK9
         crtgESsPInNkWqeuDeKy8ElgfufagmVjqEkBTkCdt0Ic3xQI0lg8Qm15bBsXFK49Oh42
         OBxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719988902; x=1720593702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+vLgF0+RXMLNkLXXNsHGCbj/O0dwlYR16fZtiGDJBZ4=;
        b=H3WzVZs9SNlTMQSybXKelC1bBlXdNGM6p3uJGXzoAfp82tFreDPIMAjSPjLTsqdC2s
         tMwW0awI17aEkR7vALOzF8IUX0D+16jfTiy96xou01ig+xs8Z5F8HwSWIBhhAjjOyy6B
         gSGc3GrJzgO7Gg+cKpaeNFwv/b6XCL1gjPiWD2ufNTNlGfoVYgTx4x4fColzI+AMJqht
         ggOfZ/dl1Um7XuR0GUK0LtqYI5dXkIjG29rbzm8yUU7DEf3XklV/p2Z96hrLBGtRBeZW
         YIx+UqyG1uLrPbLdI/0r0ys1q6lqTRyMF2dUWzN/B01TGfymze379armC1ZtT19FOGNz
         S2cA==
X-Gm-Message-State: AOJu0YzeLR3LPGr6E9DYWrqgS8xXyW/qi3o8loFpNACL+c7hgyt+bxyg
	w34i5VfDvep7XlZ7V32T63iAz8MyyZG828DxWk3U/ppajBuDFYpsebAANJhJK4TPBWC4HKEdbR0
	sY+JGVGfI3TOWLkvruNHK7df88BiHBb4ieK1FNw==
X-Google-Smtp-Source: AGHT+IHGMiHK00ERdKXHAtg/IXadbm+bfVQrAHKqajcWok4pbyn+FZp8dsrbD42BALRcZB0eIZA2QvAekMrooHu+E+0=
X-Received: by 2002:a05:6102:a4b:b0:48f:8cd0:831c with SMTP id
 ada2fe7eead31-48faf03f703mr10165225137.1.1719988901931; Tue, 02 Jul 2024
 23:41:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702-dev-iio-masklength-private-v1-0-98193bf536a6@analog.com> <20240702-dev-iio-masklength-private-v1-17-98193bf536a6@analog.com>
In-Reply-To: <20240702-dev-iio-masklength-private-v1-17-98193bf536a6@analog.com>
From: Alexandru Ardelean <aardelean@baylibre.com>
Date: Wed, 3 Jul 2024 09:41:31 +0300
Message-ID: <CA+GgBR_8s++E59xFBpatkB7KzHNQKC88MtJCy98xbv9n-0KzFQ@mail.gmail.com>
Subject: Re: [PATCH 17/20] iio: adc: ad_sigma_delta: use new '.masklength' accessors
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
> Make use of iio_get_masklength) and iio_for_each_active_channel() to
> access '.masklength' so it can be annotated as __private when there
> are no more direct users of it.
>

Reviewed-by: Alexandru Ardelean <aardelean@baylibre.com>

> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  drivers/iio/adc/ad_sigma_delta.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_=
delta.c
> index a2b87f6b7a07..62653d7fe39b 100644
> --- a/drivers/iio/adc/ad_sigma_delta.c
> +++ b/drivers/iio/adc/ad_sigma_delta.c
> @@ -350,7 +350,7 @@ static int ad_sd_buffer_postenable(struct iio_dev *in=
dio_dev)
>
>         if (sigma_delta->num_slots =3D=3D 1) {
>                 channel =3D find_first_bit(indio_dev->active_scan_mask,
> -                                        indio_dev->masklength);
> +                                        iio_get_masklength(indio_dev));
>                 ret =3D ad_sigma_delta_set_channel(sigma_delta,
>                                                  indio_dev->channels[chan=
nel].address);
>                 if (ret)
> @@ -363,7 +363,7 @@ static int ad_sd_buffer_postenable(struct iio_dev *in=
dio_dev)
>                  * implementation is mandatory.
>                  */
>                 slot =3D 0;
> -               for_each_set_bit(i, indio_dev->active_scan_mask, indio_de=
v->masklength) {
> +               iio_for_each_active_channel(indio_dev, i) {
>                         sigma_delta->slots[slot] =3D indio_dev->channels[=
i].address;
>                         slot++;
>                 }
> @@ -525,7 +525,7 @@ static bool ad_sd_validate_scan_mask(struct iio_dev *=
indio_dev, const unsigned l
>  {
>         struct ad_sigma_delta *sigma_delta =3D iio_device_get_drvdata(ind=
io_dev);
>
> -       return bitmap_weight(mask, indio_dev->masklength) <=3D sigma_delt=
a->num_slots;
> +       return bitmap_weight(mask, iio_get_masklength(indio_dev)) <=3D si=
gma_delta->num_slots;
>  }
>
>  static const struct iio_buffer_setup_ops ad_sd_buffer_setup_ops =3D {
>
> --
> 2.45.2
>
>
>

