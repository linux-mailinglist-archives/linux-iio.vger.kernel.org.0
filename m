Return-Path: <linux-iio+bounces-2344-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E0A84F97A
	for <lists+linux-iio@lfdr.de>; Fri,  9 Feb 2024 17:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6854C289AF0
	for <lists+linux-iio@lfdr.de>; Fri,  9 Feb 2024 16:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647F1762D7;
	Fri,  9 Feb 2024 16:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l95ykCD3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993A271B2F;
	Fri,  9 Feb 2024 16:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707495599; cv=none; b=P/OH2y0o8iu0KhNUCxGR72wR9vq5ExW5GFuvsigSzVuSN9b16pdETxI7/4J5/8hHZF1N5a48Yv7aIgFWnwc/utMnAk3gKF5gOlmaNcHR+tJRwACoi4ksOz/y3UeN0gzJJSCZEvst9jGK72Fu4K+RGLNmrESnu13NXGwkxY2++78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707495599; c=relaxed/simple;
	bh=uDjDUY3P0+WE/SPdp/1ux0/uBkjqqDlL7BI+AmmT2tI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ds177alD9PY6m7bwgyHRIa9Qb0Lv7DLQQz0HiY9+yS6n4AJT0ppQipwevbXNvlKklyJf2PcYCvEtOAxyzQhDsKzsq7Q0JleD/CnZOgPk6SmZZMRTjDrZQMjMdYuXRfm/a0f1Jf7D0047HCCvkArdQY0QihumS70LUwiblH1W+vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l95ykCD3; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a293f2280c7so160124466b.1;
        Fri, 09 Feb 2024 08:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707495596; x=1708100396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wLP9iN3k8faqF+s9nCNVsfYWD3ZQYtsS40zG0nFvago=;
        b=l95ykCD30K15nXul/IfqSdxhyp+XJ5sor9iu0e8J5yUKsaP4WYVklCuSQKEMC0Pw0i
         sD2217IEoNIZTnZwlU3yT2qjvY7VB9OcXbrVWFfPKqjYMl7fZYyvcOZy5pUK0QBuzzW5
         Hb/bWVM4pQRz9DNI7zUdrb3wph858DstudbGpczX6dZbhTSh2ryqZOhLzh9a9Ay3iBDt
         Ny7fLtIiYCbTcRm0/NUHicXLMY4PkQSs2qSC8ljecaFCktuGV5aGjxgkMlIonUVmitCB
         A817QU2UmtcHgQ1qRAM/QKQ3vU9m9lJXOH8Y2qlh+z0Ip5yGjZ/fcke/QmT3piRksQGH
         5N4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707495596; x=1708100396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wLP9iN3k8faqF+s9nCNVsfYWD3ZQYtsS40zG0nFvago=;
        b=OJQ4XDHUirce5Zwu/fwnTcvzH+5eT2iw1taSh/49ncC9qY0i/laolWvzg9NVL03fki
         j/ytpvh6lQfyTDcRBLStjjRGpKW2Z0Irfi5CaoJMTTodwWGuHYFb0+KDs+JK7u2IEB0D
         EP7zF4p6nvBbsVKUOL2a5Pjdt6sI3E0spl72n3C4oO0oQR2fSXEQa/DSZz17DeDLtmvB
         dasKYeIijdBs/gr0rxmGpSurX5jnp1XKh8dGTDYKnYGqUmCw1M6EMGXHiVaY+h6HafPu
         T5AUpdMyWDI/jZk6hwa4a7rhS2IEIb/LUXk6OkXexbnK841/bW2evMHSai0PizLSGAB6
         otAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUADJC+gH+QBjTfM/9vP302WAvtYqkU+J/o1Fk+Z0ppDY3BPS7R+hQhmZPcdrT4Cr+8EoUeWafB/LJaXJalTTm0f1G3mCI/39Vt+A==
X-Gm-Message-State: AOJu0YwQslldAwTWm8j7874xyqFqxyHcgqyTQ2KDy2csRjSC/FYb5UXd
	Whi14fjtZSqaVa0ewtGa9v9AJhqQf1apap/oyIGb2hbjf5YrtIQjw8Z+W7s+iqhOs/HhVytrkvV
	md1L+CGGszHcp7XRR0h45waTltEc=
X-Google-Smtp-Source: AGHT+IEHK6VVEB+VN3NaW9zCak+RKLaMsm7Ru5zv6jOnArykt/XGpIEXG224KeccUyxBvD3o32Y3TDpway3uwAkjRkY=
X-Received: by 2002:a17:906:bc5b:b0:a38:c07:7d51 with SMTP id
 s27-20020a170906bc5b00b00a380c077d51mr1821507ejv.59.1707495595578; Fri, 09
 Feb 2024 08:19:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209-iio-backend-v10-0-3ed842064318@analog.com> <20240209-iio-backend-v10-5-3ed842064318@analog.com>
In-Reply-To: <20240209-iio-backend-v10-5-3ed842064318@analog.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 9 Feb 2024 18:19:19 +0200
Message-ID: <CAHp75VfxXohbPXZBzTqjBvr8Yec0MTRgBOg5SKs108+0oseq3Q@mail.gmail.com>
Subject: Re: [PATCH v10 5/7] iio: add the IIO backend framework
To: Nuno Sa <nuno.sa@analog.com>, Andi Shyti <andi.shyti@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Frank Rowand <frowand.list@gmail.com>, Olivier Moysan <olivier.moysan@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 5:26=E2=80=AFPM Nuno Sa <nuno.sa@analog.com> wrote:
>
> This is a Framework to handle complex IIO aggregate devices.
>
> The typical architecture is to have one device as the frontend device whi=
ch
> can be "linked" against one or multiple backend devices. All the IIO and
> userspace interface is expected to be registers/managed by the frontend
> device which will callback into the backends when needed (to get/set
> some configuration that it does not directly control).
>
> The basic framework interface is pretty simple:
>  - Backends should register themselves with @devm_iio_backend_register()
>  - Frontend devices should get backends with @devm_iio_backend_get()

...

> +       fwnode =3D fwnode_find_reference(dev_fwnode(dev), "io-backends", =
index);
> +       if (IS_ERR(fwnode)) {
> +               dev_err_probe(dev, PTR_ERR(fwnode),
> +                             "Cannot get Firmware reference\n");
> +               return ERR_CAST(fwnode);

You can combine them in one line (yeah, a bit ugly, I know, we
discussed with Andi at some point that it would be nice to have
dev_err_probe*() family of helpers for this and other not yet covered
cases). Whatever Jonathan likes (as two or a single line), I'm fine
with this, just a side note.

> +       }

--=20
With Best Regards,
Andy Shevchenko

