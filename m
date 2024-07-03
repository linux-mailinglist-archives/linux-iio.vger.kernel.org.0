Return-Path: <linux-iio+bounces-7196-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94177925393
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 08:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07A00B20FD4
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 06:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B46479B6F;
	Wed,  3 Jul 2024 06:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Zvz7tAI4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEA34501E
	for <linux-iio@vger.kernel.org>; Wed,  3 Jul 2024 06:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719987734; cv=none; b=Qr2xxPn0G483hKjV/2jnpvyv+oM8RsyEd97tQ0wLSYhidxcHoDmlxlwT2YoxyNcjWKaoF+VIc5PNEGpfAnGi3da75YVPuq4ig3Wgy1z5sNA5pYt3sw3tk4jiDCzYrRdBd6w1EXAg3wwGHoc2ARSwSco5cM5qcrXC9po2n2H+Xk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719987734; c=relaxed/simple;
	bh=XZdsue1IOxPXtH6rQLFlCm6icV7WKAp+6Op3Ei/cy+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LnbrFoK+pBjS/whwLvJlseLOuoSg2NL4E/5LBiX+GoPHOL1k2/Qyrui5zYbGuqHj0AjAdmmAoHaDgDm/uR8pHhiJd01eC2z/Dndyhl+9KuT+fM96mVWz1gFSNQ9VD4RCxpCRXI7s63fSFuXrIljzbmB6CZWWuoaMUnUiQGFBvHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Zvz7tAI4; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4ef63c6be17so167958e0c.0
        for <linux-iio@vger.kernel.org>; Tue, 02 Jul 2024 23:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719987730; x=1720592530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YBEWRqpgrXvyx1qgXgTOG9V3qv/r9LpDWANmRNgSxM0=;
        b=Zvz7tAI4zL12Z5sjfb1klwAnXLDcySz/A7ICeqtX7QJ9OgERZU3PRTFANHZjSsfiD2
         8+cJZbA30pIbCvGNzfXKadOkkHvazbSOn+8xZsYqQNKOVP2xNMWn0gmRmNofJqWt/KPI
         CYnZKwrLO968wMDMnffORcr+IJoRqdX8uR/eiytgAHonNB16e8Jq0zfnTiVxJZvxOmev
         KJrJKILFQzpqd2sYRs3viEKJTj2FsXPp2mM8WM8yueP7MXMhqMGeDp2EronJnt7IYWjq
         L8epC7sQtkCfrWn1d+hP6SgInb2bL12299nCID47glccGpa2dU0rKBkR/pZ70+iZpbjA
         fqeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719987730; x=1720592530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YBEWRqpgrXvyx1qgXgTOG9V3qv/r9LpDWANmRNgSxM0=;
        b=foLmoacrP3BKuZ1RD7ZU7B9fXwEKOCdHEX/RMvyLRitOcNw3rfqKpU9r3BYogo9pUe
         QW3msdKLHApMTIfzC6iThce8QY0Akb9OAXXhad+VArJOO92I3aSbBvMi59qYl7CsEn0F
         xss56f+x9gmZqi0XZxtAqn64ss77TLlA1QscbQzdMsUFHJEpSPlYR3DKyj+4HHYNlgsV
         6zeQK+HyneBcajmX+1kbQcvs1PAJxLYEhw//12kuwRcGHdeFgZDSEP8DpxOE/b2Sdq19
         pbuWLFXKuV8F3M2gpAhQzT+6xi40lCv6BXhVGA9yiKExOHGxbvTheyYcs1DNmr/zr4TK
         E9hw==
X-Gm-Message-State: AOJu0YwXeiqeuKD0Uxm7gUNu6uJYydxqB/kSwKOLDu6n2ZD2OjSxaT1z
	bAWrxORlfBZeKK4rlMYSYMF8NxVjp8j+OBNkRJdhTaacU25b7lMEOTz9+CirU20t1y54B16EMtr
	Mw7AlKx6Prc8OK7XsmH9DlMy00avgpjAbxRy+fA==
X-Google-Smtp-Source: AGHT+IEjA+wy+jAwLZCcCRVwwsk42Iz8nk5t41mgUdbYSB5CMR/5n9Hq9GQdG9ybjgyMQCUw9l4XB1sl+wqswq73kHc=
X-Received: by 2002:ac5:cb63:0:b0:4ec:f2b9:65c9 with SMTP id
 71dfb90a1353d-4f2a555e9a9mr10758649e0c.0.1719987730370; Tue, 02 Jul 2024
 23:22:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702-dev-iio-masklength-private-v1-0-98193bf536a6@analog.com> <20240702-dev-iio-masklength-private-v1-16-98193bf536a6@analog.com>
In-Reply-To: <20240702-dev-iio-masklength-private-v1-16-98193bf536a6@analog.com>
From: Alexandru Ardelean <aardelean@baylibre.com>
Date: Wed, 3 Jul 2024 09:21:57 +0300
Message-ID: <CA+GgBR8BZV+bRyKWYmakeFM5VS0QLsPZz1a0G_H76SCHU4n4iw@mail.gmail.com>
Subject: Re: [PATCH 16/20] iio: adc: ad799x: make use of iio_get_masklength()
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
> Use iio_get_masklength() to access '.masklength' so it can be annotated
> as __private when there are no more direct users of it.
>

At this point, I am wondering if it would make sense to go a little
further with the abstraction and find a wrapper for the
"bitmap_weight(indio_dev->active_scan_mask, indio_dev->masklength)"

Maybe it's doable at a later point.

Reviewed-by: Alexandru Ardelean <aardelean@baylibre.com>

> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  drivers/iio/adc/ad799x.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
> index 0f0dcd9ca6b60..0f107e3fc2c85 100644
> --- a/drivers/iio/adc/ad799x.c
> +++ b/drivers/iio/adc/ad799x.c
> @@ -237,7 +237,8 @@ static int ad799x_update_scan_mode(struct iio_dev *in=
dio_dev,
>         if (!st->rx_buf)
>                 return -ENOMEM;
>
> -       st->transfer_size =3D bitmap_weight(scan_mask, indio_dev->masklen=
gth) * 2;
> +       st->transfer_size =3D bitmap_weight(scan_mask,
> +                                         iio_get_masklength(indio_dev)) =
* 2;
>
>         switch (st->id) {
>         case ad7992:
>
> --
> 2.45.2
>
>
>

