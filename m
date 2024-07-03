Return-Path: <linux-iio+bounces-7195-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F16292538E
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 08:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B510281456
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 06:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73F971B5B;
	Wed,  3 Jul 2024 06:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ohkpbHBL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4A31DA32B
	for <linux-iio@vger.kernel.org>; Wed,  3 Jul 2024 06:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719987489; cv=none; b=mkJHWF7HtBCsqxQ5FsDGyMvHk6rdDKS3pYriYmWK2Pkapj3gFmqyqBjtNG/4Eh+nyuXSZ7Tc6XfejlwsoOdJrmtedTz2F9WB5z8bySUyjos/LDXOM05ag/EnjjPnHYNbHDEq0Ay8KcwsTT0QDSlGdiOvocu/OpfRrzzMC7w/osQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719987489; c=relaxed/simple;
	bh=Qt2lzxBmiYbmS37M2+dHBvyq9puRTUhHeoY6sL+Q6c4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WfnTyQy1rQsz91P2RRsaVRdLn3KTcYWJbNqEyZQOQxHEKObr6sSciqTzM+PMrpWF9/SQ4CaAkjaPyvnMnlnIonsLhVJR9Ty0mwfUwH9koHaYLkkDyo0TK4ZxhXRAcHije2LqctZCQ1ohiFxzwuJwF0KF1kG5w7Q7PDX+SpWgneQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ohkpbHBL; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4ef63c6be17so167849e0c.0
        for <linux-iio@vger.kernel.org>; Tue, 02 Jul 2024 23:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719987487; x=1720592287; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oDID+M36pQUm2cmeBBQ6vdpVx/t6wAJFJWrrhENY1cM=;
        b=ohkpbHBLyiAtjPlYg4VJ8pPw1c/DtHtIlTjbff/gPTauJQO9Y4LPypHfosEB6lx/rp
         nMkx3d1hTI178LyJMuXD/Puaapc3aQKlPsCi5jGcUzsYlKN1C4WKRdUHyb1BwV+f/lDR
         Bc6bFYK4z9aDGNB8xFW1fKJ7LuykAIJJ4VGd9m2mOdk6xs6uH5Up0RWZqiqeoOUqn90o
         hsUBUiyZ5DmewJK1ib1jGL4LfTvayDyrjn1pQe4z20FctU4AnKk78HVdOGhfI+XqARj8
         i4nvcC6swIGJIYFuLEbaWxIMSpMR1grY06AKH8Lz1KjfVH6HcgWV7LKQTCPBNXXEQtD+
         IYgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719987487; x=1720592287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oDID+M36pQUm2cmeBBQ6vdpVx/t6wAJFJWrrhENY1cM=;
        b=wLwQSfUyXjNMCLTpqfxw5JBgMgb80fnWqWomEMTny9X7KVHw+N3oEeu1pFSICXeeTY
         QqAQ5qMBOPK+Mfh5j4gCHsoRtZQCG4DMrQmUpY70KEnccIN0ePdUoPJ6zv+lu42L+8jp
         C04ZBfaAE4Fub5xfTGfyoVtBxLmPvldchbYaR/Fql6tADERcONvqH8XEibTU6VUNnI45
         2jbPh7Gib2ZtJ6E394ooDqTCJfIkMJYr42LnrYhimsXZJGA0mXK+oir9cuvctOIqFiXs
         bw4p+ws2BJsQHW4G7RXUg3iiKtRwQ00OUyIDk5+6d7wpLVdh6HOZRVuHtIZTwWOgdIzd
         ZypA==
X-Gm-Message-State: AOJu0Yx9itm9sT6hhlwbykxIsOEJcJYRMK7QTu88Yx78IonP5cfSrdI9
	sSwq8ij9ydIg06J2ABZldNIerGwgmdp6qRgILmIPpNfAekFLGneu2WbYStoRdf3R65tBT/Ke6Aq
	Qu9pn/aaLUx0YpTKd+3+qufmov2i264/fC3UU4g==
X-Google-Smtp-Source: AGHT+IFWEngRuJMya3YyI1MxdVDX8TFMu0H0KHjpjrNbdQmmK4XlBgtxHsOPkFzlaci8++w8+a9EApIoTNTcq1nnVlY=
X-Received: by 2002:a05:6122:3224:b0:4eb:2012:f5ed with SMTP id
 71dfb90a1353d-4f2a56e4202mr10742434e0c.1.1719987487130; Tue, 02 Jul 2024
 23:18:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702-dev-iio-masklength-private-v1-0-98193bf536a6@analog.com> <20240702-dev-iio-masklength-private-v1-5-98193bf536a6@analog.com>
In-Reply-To: <20240702-dev-iio-masklength-private-v1-5-98193bf536a6@analog.com>
From: Alexandru Ardelean <aardelean@baylibre.com>
Date: Wed, 3 Jul 2024 09:17:54 +0300
Message-ID: <CA+GgBR9qakqbwVHbLSYVA7ZOo1DW2ehzMZMcF=PuNU6ZoYAijg@mail.gmail.com>
Subject: Re: [PATCH 05/20] iio: accel: adx1372: make use of iio_get_masklength()
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
> Use iio_get_masklength() to access '.masklength' so it can be annotated
> as __private when there are no more direct users of it.
>

Typo in commit title   adx1372  ->  adxl372

With that addressed:

Reviewed-by: Alexandru Ardelean <aardelean@baylibre.com>

> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  drivers/iio/accel/adxl372.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
> index c4193286eb05..ef8dd557877b 100644
> --- a/drivers/iio/accel/adxl372.c
> +++ b/drivers/iio/accel/adxl372.c
> @@ -1050,7 +1050,7 @@ static int adxl372_buffer_postenable(struct iio_dev=
 *indio_dev)
>         st->fifo_format =3D adxl372_axis_lookup_table[i].fifo_format;
>         st->fifo_axis_mask =3D adxl372_axis_lookup_table[i].bits;
>         st->fifo_set_size =3D bitmap_weight(indio_dev->active_scan_mask,
> -                                         indio_dev->masklength);
> +                                         iio_get_masklength(indio_dev));
>
>         /* Configure the FIFO to store sets of impact event peak. */
>         if (st->peak_fifo_mode_en) {
>
> --
> 2.45.2
>
>
>

