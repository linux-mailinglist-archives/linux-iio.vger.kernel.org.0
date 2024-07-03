Return-Path: <linux-iio+bounces-7191-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EE2925380
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 08:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68E891C2104C
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 06:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7424DA04;
	Wed,  3 Jul 2024 06:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fCltS7g7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BDF4CDF9
	for <linux-iio@vger.kernel.org>; Wed,  3 Jul 2024 06:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719987032; cv=none; b=PwfHDfDM1Lm6PsFwWTW9l77GC7ski6iCV0Whz03YI+QOktJ5nGMMPXN8+h/6gy3C9KIH3phw4kj7Ws10pdWkneBjvBsG2YTMLdCHz5aduBqCVHZWVfulnaJtn18laE7CZkAHz2+N6jTQHAkWjaCSOaCdQwmSONj4/l/g3QQwNDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719987032; c=relaxed/simple;
	bh=pc8ANiJ80l8AyWFumFO0M/7xAzIYJdDQhrWSCZ3cT1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Opu1ARXiY/Xc6VUChpXGlOmAVsNjrf7FUE/TxQ4wvEnED0ey21TlAx139ByZlAeho/HaVBxeVwUzUzsHcTP2v+D92a0EW1XZPPDCp10IKG5ikpfHtk3XnFgbuDR8R/xFDpULhoiWGjCsaExp9wyJZiKjNvFj0fv1Zibku1qIsJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fCltS7g7; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-48fdf832431so3491137.3
        for <linux-iio@vger.kernel.org>; Tue, 02 Jul 2024 23:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719987028; x=1720591828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TuQlEn1bKXmTtw08wuy4xcpjyoCGwx/Gk1HDM4Uta84=;
        b=fCltS7g7EAvL3Gb7TqwGHkF3ca2dKgpYEpso61jBrPyWQUQv9KoDP2ZH2yGEI+TPy0
         QckkjafS566JsyuLVlrrQYgLxOB40D0QyqhuLKUt8cbCSZu4R2FCjUdVToYvEcRXbJDV
         oTjKtqnczDe+Ig5lbnFo+6TAZJRpSLggsSflBxZ6scOqI5YqQxL2/NSynjPuoBMI+FeQ
         U5w6Gu3GoaSw1IFMe+Ghk2KYoueEFqNbE8b3uajily+ZsCOHFCqKyaeQs36PhkKlRFNl
         vxktEDSMVbXkkCp7c2Aw+sxNRxCVje5KeMDFHoX+QZBc67WMJLgwMl1jQL1av8ckCV82
         StXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719987028; x=1720591828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TuQlEn1bKXmTtw08wuy4xcpjyoCGwx/Gk1HDM4Uta84=;
        b=i1rjJky/+KP8x5JZI8YgUZs7sanjShwvjfRM/TvwVIx9yP9o2fVGWXWm0wQ2v6inrv
         ymPKaOjTp/dFAZRTGsACAC5rXOTLsh/qsVAiQOhEEC7R1bUVFK/hxq63QWULi/g2iCwm
         YdicErtLVpouzcKJQmVFZwimbXQGTJXiBCq2F9QBNoe74HwRfCDBqyonFG2bKD9RWHfy
         cVzZgP/bNkKHPKDsfbKqYjizrbqBKcryCn50UvsX4zLmjyhDO0CEiUgn4EZr0CeU7RO9
         eYGLHTUOS121UcrHkywzj93JJzUeE6X0t3X2fHsBivhq2Dn+F3nhkZn/rPkf78R74jIC
         NEvQ==
X-Gm-Message-State: AOJu0YzMrUrePo45XosorjzXAf3LP8oAuH1ffWUIlNZRDKCD7g2zoJgE
	ib2DB/LrRV2ktqeeiOwx6T7WWYYd+CFDeLbM3h1epZbUTUnCt2D5pNICGWlxA1toFJhCpqzGJSl
	M4ByJw1TkaObVRIUuZlGlECHCzth6xTSO3hi/jZ+nzLUNGYjD6b8=
X-Google-Smtp-Source: AGHT+IGUm6vh2ZK/ADqj6mBXlm0rx9uk8jTZJpwdWSND65/86xD95RZbIo+NssVjVNwmhp3zcwo1NixrZZhNFtJGqd8=
X-Received: by 2002:a05:6102:5090:b0:48f:19af:d2a4 with SMTP id
 ada2fe7eead31-48faf0db435mr11426822137.2.1719987027726; Tue, 02 Jul 2024
 23:10:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702-dev-iio-masklength-private-v1-0-98193bf536a6@analog.com> <20240702-dev-iio-masklength-private-v1-1-98193bf536a6@analog.com>
In-Reply-To: <20240702-dev-iio-masklength-private-v1-1-98193bf536a6@analog.com>
From: Alexandru Ardelean <aardelean@baylibre.com>
Date: Wed, 3 Jul 2024 09:10:15 +0300
Message-ID: <CA+GgBR-anzo8VvTT2yc4dK35YBOCXV914QL1xcocgMfc71U1yQ@mail.gmail.com>
Subject: Re: [PATCH 01/20] iio: core: add accessors 'masklength'
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
> 'masklength' is supposed to be an IIO private member. However, drivers
> (often in trigger handlers) need to access it to iterate over the
> enabled channels for example (there are other reasons). Hence, a couple
> of new accessors are being added:
>
>  * iio_for_each_active_channel() - Iterates over the active channels;
>  * iio_get_masklength() - Get length of the channels mask.
>
> The goal of these new accessors is to annotate 'masklength' as private
> as soon as all drivers accessing it are converted to use the new
> helpers.
>

Reviewed-by: Alexandru Ardelean <aardelean@baylibre.com>

> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  include/linux/iio/iio.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 894309294182d..dd6bbc468283e 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -855,6 +855,24 @@ static inline const struct iio_scan_type
>         return &chan->scan_type;
>  }
>
> +/**
> + * iio_get_masklength - Get length of the channels mask
> + * @indio_dev: the IIO device to get the masklength for
> + */
> +static inline unsigned int iio_get_masklength(const struct iio_dev *indi=
o_dev)
> +{
> +       return indio_dev->masklength;
> +}
> +
> +/**
> + * iio_for_each_active_channel - Iterated over active channels
> + * @indio_dev: the IIO device
> + * @chan: Holds the index of the enabled channel
> + */
> +#define iio_for_each_active_channel(indio_dev, chan) \
> +       for_each_set_bit((chan), (indio_dev)->active_scan_mask, \
> +                        iio_get_masklength(indio_dev))
> +
>  ssize_t iio_format_value(char *buf, unsigned int type, int size, int *va=
ls);
>
>  int iio_str_to_fixpoint(const char *str, int fract_mult, int *integer,
>
> --
> 2.45.2
>
>
>

