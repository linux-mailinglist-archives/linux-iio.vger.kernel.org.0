Return-Path: <linux-iio+bounces-18759-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFE0A9E8D9
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 09:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2BD91898C3F
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 07:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092EE1D61B7;
	Mon, 28 Apr 2025 07:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGNLP/Id"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FD4155393;
	Mon, 28 Apr 2025 07:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745824151; cv=none; b=PB6XUlG61nFRQ8ztBYj0DWLEMSeLIHapXuOzxxokt9CuUHhTYSQulZvax0WrbA89qTrjdzjkLU+iKRX2eQxb6sin0iygNGeT8Rl5+WrZrKds/J63f9p3QXQasd5tO+dF9gjVwL9jTN9/B+kGc1EmiXB0Hc0BrPhCdYcq8IRCkc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745824151; c=relaxed/simple;
	bh=gka9weWxTZjajAIimjZ3pa3XN3kAR+XNJ5I/Ft114ig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jaY69OmeJuI5EVuDoacltPbFQxc+3i+LOJLPWYfNQd3omPlCAzrSMD+e5O9VqLwFn9+mCGoMDVKybm/I2X7WTMptL1PEspTugLKGDEDFvu0t9Qx+BZHOENDESF1wz3qwwNWclg/4/xnlf1YxDNqHzkTtT0hkJRZBBDTRE6ttqRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BGNLP/Id; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac339f53df9so844637566b.1;
        Mon, 28 Apr 2025 00:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745824148; x=1746428948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=slqnJQvEEC42Lj5xhFfWgvPVf1ysVH9OxYineuce2Lw=;
        b=BGNLP/IdpMwWNifRticoNuH+1BoYVVMOe6KX0vJFigSRBI5SQHop3133pTm20DJycH
         cHJz5SZHjS9rdknjPO4z/YYtclnKNnzW5pIoDCFEacYwbpNANI2gFuBcVuk+h7AoyfRf
         FzexP6pyBPI+vs4yUWhdzdJkGbdHQMRscTstue4L+7TbigQZvsSC67Y3KKK4U3nWhOwU
         3icuSsWqUiVJp2RbV0YZd5g9FLjW8PzMRk+j89XR+g4IUeA6ljmPLu/Er2MLojeGb67/
         +jYTjlY5xfEl2QDUYjq2eUJ+UT6tR6C4osePcfcjqkCxt5vio/HZejyZYi/7uXJltwG6
         ArOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745824148; x=1746428948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=slqnJQvEEC42Lj5xhFfWgvPVf1ysVH9OxYineuce2Lw=;
        b=inIX4oXZJbeRTH28d6WSfYaqJjWGVvsAEJmkLVisfLSMRmLBQyTzvXyrV3eXEa0z6Y
         l3VBDRB2XE5tATMbyT5q66sfJPu5w5KOKPt2goq5BZIoOt0fGBmWSQYSQnbytf5+G1vE
         mq8RAd6zFdTUVQl4IKSodMCxvxpT2j2iJXKRjyCUiDK2X8gT5wfKsS78n8xH9MmRqS7B
         SyVLbtzMt5CLG3jGgOj9b1H+5S9Wlx47TxzrI39dv14oi+HLgulGhGcUAva7jIl59Y22
         5LbYPuzcp9HEcg1Z7dJSTOqWb2KVk9RJPTAaQAYIDBO9Q3WnRMOWeUeEvvgUvaFbDxBM
         6b0w==
X-Forwarded-Encrypted: i=1; AJvYcCUiTN5N6zJXVFL8YNJzXt6FneS8VW/enjhG3O4fjzIEPH8/HE5mKhrVdReTjFuM1WaG4VXDixJ8Mus=@vger.kernel.org, AJvYcCXfUaDK/7YbWM+YD9eGGOC1mQMVeWNGYBM1nb3yXPfHxbAB+QcLQOzKucTyRC4w0L32SWKqbAQv8cFhRNzy@vger.kernel.org
X-Gm-Message-State: AOJu0YzfCZHEWzzSu9SSCdRCoDCbgULQJHobjmeuW/3fhoaMAQxEsPhV
	76V3qu5A73CrQCGQB5CUehiyrusl3HrvtngLHqZOxh9SvcWyitYP+qUNR3+aMesAW+PyFUBZU6U
	NpChFr1IH2DB+z3EWqgEEiK/fmv8=
X-Gm-Gg: ASbGncuL5UJyEY46vfapNp/ATPWNL9qfK5a6EX0CuPALjASbWh4B9sdDPkiG/PoXcbx
	N8XY/SYL7alQvGbraTDA1PCXVSFdTqDuOKQk5ut/BLxUk3st/yz25Brybeis0gark3YVgqPi4Q4
	mBv7ar3OEffo108Ay61b75PPaT
X-Google-Smtp-Source: AGHT+IE690i8RePF99ikkuMIY9tUJ3K9A1HV5tC4BBW98oISB3KjRSe2XsSDTCvRdgs5sRQB3S48TU2V+3o3NQx0AH0=
X-Received: by 2002:a17:907:3e05:b0:ac4:3d0:8bc6 with SMTP id
 a640c23a62f3a-ace848f3161mr619281266b.13.1745824148413; Mon, 28 Apr 2025
 00:09:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <59106e24332743a7f9eb0b13ad6a2f5595ab485a.1745823530.git.mazziesaccount@gmail.com>
In-Reply-To: <59106e24332743a7f9eb0b13ad6a2f5595ab485a.1745823530.git.mazziesaccount@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 28 Apr 2025 10:08:32 +0300
X-Gm-Features: ATxdqUFXyH-wl1MvTA0gqSdJJjzWzYU2YSsfseGPnx_pSiINnb7FNsIVVaBAKT4
Message-ID: <CAHp75VcUcrj-BLp9QDsYMDY_SeQS76LDGge5vVqrx-MVwukP0w@mail.gmail.com>
Subject: Re: [PATCH] iio: ti-adc128s052: Drop variable vref
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 10:02=E2=80=AFAM Matti Vaittinen
<mazziesaccount@gmail.com> wrote:
>
> According to Jonathan, variable reference voltages are very rare. It is
> unlikely it is needed, and supporting it makes the code a bit more
> complex.
>
> Simplify the driver and drop the variable vref support.

...

> +       int vref_mv;

vref_mV please. And yes, I know historical and other reasons for them
all being small, but let's try to be more scientific in these crazy
days.

...

> +       adc->vref_mv =3D ret / 1000;

MILLI ?
Or actually a time to introduce MILLIVOLT_PER_VOLT in units.h ?

--=20
With Best Regards,
Andy Shevchenko

