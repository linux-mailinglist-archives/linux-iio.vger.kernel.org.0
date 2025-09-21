Return-Path: <linux-iio+bounces-24336-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 726EAB8E34B
	for <lists+linux-iio@lfdr.de>; Sun, 21 Sep 2025 20:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F75417CE07
	for <lists+linux-iio@lfdr.de>; Sun, 21 Sep 2025 18:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D731EBFE0;
	Sun, 21 Sep 2025 18:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ywnrhy8X"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9E2137C52
	for <linux-iio@vger.kernel.org>; Sun, 21 Sep 2025 18:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758479622; cv=none; b=qvVz8qSRlTmEhYOV3WCskwg0/aRyg9od4emGPWrP8ET1POSocBidtLibr6Qkalo3Rom+PrpCOWs9ImYbVeedwA9arf7vLxrOa8HAZdELWoqbVCC4inMMd2p1IwLZcKZb+ZiedkmkY7ImiYCkNCgHyDWK6ZbwHW4prnNv4nEwOlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758479622; c=relaxed/simple;
	bh=aoI5EA1Q9ddis6FAdUjfMMEy+ju0QkwuO+9f1M9RxRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NDizju7BzvRdi7wRKTfER62AHZW0PdB9VpYW+x9UVydVH9/BKMtQJairDWsXmhWmDsvcBw9YdsYMfOs3+nkn53Yq2alyvTcGAEnazTPUioSJwfS3dJzJibQuHi5s0IZykahxHsJdX/DUvf4Pvz/mOTv/0ppGR6/Ukv3cg6RFx88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ywnrhy8X; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b2b4096539fso78596266b.1
        for <linux-iio@vger.kernel.org>; Sun, 21 Sep 2025 11:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758479619; x=1759084419; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sTXsn+dbl5OayTNA74PTyK9yM2TR4se1zzy0Wcj19vI=;
        b=Ywnrhy8XL7TfNWVPCwmJ4+ofBamX8jXQ/2/ypSRZzbszIVca2qG3OFr/OVz4GR1bga
         rnzAfgugcetbXTD9h+e4eoovsd+s50k3NLRJ//ci1ZlIoMZBT+ApQIg0j0KT/fnq38N8
         mb4jIrF23Sju80FVsOvcmPLnIUJQMPBHPbF4WRPDU5mEwMDnGvhoPVT9YYcjmNMnAc7A
         NKEuIVGDphs04Sf7TZ5N9VE8FewxcHDolHkx2yIv2GIwCbZFF8PWpThMuxiMd3fJmRuO
         FUECqMjYufSQ1mr6riJwetukhVyk/6Nes9e4SHLgm2bbLwpjualr7WMFrsCKIdAaXvKJ
         vFBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758479619; x=1759084419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sTXsn+dbl5OayTNA74PTyK9yM2TR4se1zzy0Wcj19vI=;
        b=v9PgDtLAqlBZlehKht+wJ3lwqbg39EJdvUy7tKWcEBqq5vrSPTrLaTT4LinRmTKOFq
         4b7PH4hcLo5uhyUCTCkJCk0nY6YL30cn6LdhM3Hlzt7tbLfkUsdp/V1PtKF++dPfhhED
         n6qvDIHuB7D9DUDTVG6DGP2UopWS1aO/AmIT/1DsBHfXRs3QcM4ATIm42xH9GVKP92Mf
         9ZH0uAKr4jQiIw56Cc4v9rYEdJ2JZoQj2Ex3UEPT2tWAZcGLqpw+EVhCoG0NcvhoJWyw
         6aWa9g7rCScpjLMqDpr/PQsEzzG9p+6SUYUub5XB9ohVeJzWy6/MRH1L6m+SJzHjxF4i
         1i0g==
X-Forwarded-Encrypted: i=1; AJvYcCVAwjB/iE/iVSF+Sqpf5SgrNrXXfWX6sSPZfxc4rwDRozyM6yYAT1XBIYy/uIMEh9bpyTDuCiDkpQo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp66Tb9hze0FeCB9o7gSs/yceTLznUIkP0PERGgi6sp6Q47LCI
	hE7RoEZVzENXptUTvw4Uvf2urfd3Oq59Q73u43q8LBmHHfj0vsyGSpp3q1onmdhzI8GPfhRrgVr
	zEbefYvbUUTI2/Og2i6p7wgxToL8o/PqR3I0o
X-Gm-Gg: ASbGncu8MtsVk+hwFPs88Od1JwHjAHomDKTUYZ7g2O2kUNHeJlpU/PhAons7qJZqKFv
	TCblgAQpXeCtdMsB2rRA+5Kb3/WUM9qeK2PzqGQpq0W9I0P+4mGJEU8/fltF0dp3MNDtZAf4Dvq
	ibA1qlha6WC+CwE5SDwD+EmToY8RLmzc9rXbLz6ouF1qw1D8DZQJz+WVJGr/nUfcZohYwm0F8tk
	tBHBqU=
X-Google-Smtp-Source: AGHT+IHE6kkj6zEHA6FRknwexuoQviCdjwYfQ9bu0E/tNgpyN9MvqSrFBdZVovWMAQkYLx9OU2nIIZ1G+MuXi7CYLZc=
X-Received: by 2002:a17:906:2b47:b0:b2a:6316:72e9 with SMTP id
 a640c23a62f3a-b2a631678bfmr282997566b.20.1758479618607; Sun, 21 Sep 2025
 11:33:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250920-iio-indio_dev-name-wrong-v1-1-d376436abbb6@baylibre.com>
In-Reply-To: <20250920-iio-indio_dev-name-wrong-v1-1-d376436abbb6@baylibre.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 21 Sep 2025 21:33:02 +0300
X-Gm-Features: AS18NWBhQDyGph8zvUHZo91vKcQr6gv4tJP-utxiru0pemI4UO9AvveoZgh7nFw
Message-ID: <CAHp75VfkS_geLqSjMz95yb8smNqKTQTfyCA3KeeUGMSg1=EfOw@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: at91-sama5d2_adc: explain why indio_dev->name =
 dev_name() is wrong
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 20, 2025 at 7:44=E2=80=AFPM David Lechner <dlechner@baylibre.co=
m> wrote:
>
> Add an explanatory comment on why indio_dev->name =3D dev_name(dev) is
> wrong, and that we can't fix it without breaking userspace.
>
> The idea is to prevent future drivers from making the same mistake by
> copying this code. And if this driver is ever modified again, we can
> at least make sure any new compatible IDs use the correct name.

...

> +       /*
> +        * The device name is supposed to be the "part number", not the k=
object
> +        * name. Do not copy this code for new drivers. We can't "fix" th=
is
> +        * without breaking userspace, so we have to live with it. Howeve=
r, if
> +        * any new compatible IDs are added, please do something similar =
to
> +        * adc/ltc2497-core.c so that at least the new part numbers are c=
orrect.

Please, use the full path from the root of the source tree, i.e.
drivers/iio/adc/ltc2497-core.c. IIRC the Sphynx might even render the
links properly (if it ever goes to this deep comment, which is not
marked as kernel-doc).

> +        */
>         indio_dev->name =3D dev_name(&pdev->dev);

--=20
With Best Regards,
Andy Shevchenko

