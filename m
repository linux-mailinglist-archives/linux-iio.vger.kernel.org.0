Return-Path: <linux-iio+bounces-2252-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC5A84B7DF
	for <lists+linux-iio@lfdr.de>; Tue,  6 Feb 2024 15:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45ABF282744
	for <lists+linux-iio@lfdr.de>; Tue,  6 Feb 2024 14:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163E813249A;
	Tue,  6 Feb 2024 14:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WiwuqLg6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EACB12FF97;
	Tue,  6 Feb 2024 14:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707229689; cv=none; b=sjmLvRYQ+5TfzBMEF2dlq+U+9V1d0kmZLdGk5DUKnawekYtzhl/OOdjQ9hBHnXl2A9DmfMNIN4LFgOHOxmXgxQxltIfw0n9swYdw5UugiNmxsWMosMI6ZeoK2Di+DSqNTRQRkDUVuCnL9NAnloheEac6BVQiSU57Pw8g/lQxQCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707229689; c=relaxed/simple;
	bh=cyh53gHARpSlo8pRbJAjx/1Lilqg5aw+GMQZUfOzwh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b7nDKnvNApUwaKB9fj6mo3Ib44o1c9JngL86BgTx/eJ2Idt9KnONc24H7t0iZMOeXXZOsnDSfaWVpf5xTOUVwB1QcGGId3F6nj2AOpa8SgAjRG1wcmMXoq3jnMVSRLHq3/Y/YWrDfJav6rlUjluR+c0c8rrjw8xO0Wxu5QK/KZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WiwuqLg6; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a30e445602cso140140766b.0;
        Tue, 06 Feb 2024 06:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707229686; x=1707834486; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IsG1+eI+WKAgfWkdutU6cnwMLIxYvLKbx7dmLSp5vRM=;
        b=WiwuqLg6G8/JPjnqbqySI1CMrn9COZP2m7+/Ww8+kplSIIMHUKlGUN6opTQ6J2l+qb
         ge0UxOa0UdR6B8Roft6lLqO4OLny82HxEyccmg6zLxECvLN4iL7D5rkGJRPRDeHRgeQB
         A9Z8lwidee2AaYyrhWT4Lfe+7tdZnbINs1QFZo1l17qSjFucmGFa+UOgk4v8dc7FSx25
         iIQlDpxVPP37WobKDgjXYDARYoyYrqeF9nTI8wTZY4bArkpesWqwdqUwfqldJadl5JbK
         vP3Ybm9AyUcq8tSkuHdq4cb1h8H0jSw+tn0QZfgeMlRJdHag4uzTa0upWfD6x3t1dSiK
         BlRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707229686; x=1707834486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IsG1+eI+WKAgfWkdutU6cnwMLIxYvLKbx7dmLSp5vRM=;
        b=UwtMEFggc/8yfVaYsbhJIVzeopuaR9ubl/p9yb2KEyODizIMlSb/ipO1NK0EAHV0ef
         ktr29TObksHyI3Y98bO+MWAv9BEFfh3XE90YsaDT6QErFXahtSATR444CoqZE2TZlOm8
         UOnWrB1cYO92/vcAEwFwcosUNKCurhFDO3XezEEikM9t0C1i2jdtlFt6HddRboSEbfwZ
         b43WXmFxhGZPX+m0Ox+d/iyGv9Ha6CHOHHgQxnJwx1WKFi2KlrgNcgVkH6QGfnh13Se/
         EEARt5xcaO78dWMINMkeKrHNB6nVjkLAOoSAxOE23Hll3tLMq4m453B+siyt4vMx1658
         ZIAg==
X-Gm-Message-State: AOJu0YwZTXUgk3liu4tpsZ84e9daMTko13LZco92CGEHl/hqefzHd21X
	x8LOe43Gq6psMMjScNU+ws0fi7alPyKEoN5Cp32gtXE68SNup9Ic6CKtTfR5TlUgwPA/peSIwZr
	rV8R/pNAxka+Y9dJm9FzkWmE1rp8OONPm15s=
X-Google-Smtp-Source: AGHT+IFXwv6Dah4jWKj0iq3M2Num7s/tXbpA6k/S/GBr1HxkGi/ajU5CJw/hKlpaXIcriTrLVANEqcUgXN5i2yle2sU=
X-Received: by 2002:a17:906:48e:b0:a36:bc00:439 with SMTP id
 f14-20020a170906048e00b00a36bc000439mr3012530eja.13.1707229686248; Tue, 06
 Feb 2024 06:28:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206-iio-backend-v9-0-df66d159c000@analog.com> <20240206-iio-backend-v9-5-df66d159c000@analog.com>
In-Reply-To: <20240206-iio-backend-v9-5-df66d159c000@analog.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 6 Feb 2024 16:27:30 +0200
Message-ID: <CAHp75VdUjNeYsgJHcMC+z9m9j=z7Qzh0BFXR=Zi7jPs6rRVUKg@mail.gmail.com>
Subject: Re: [PATCH v9 5/7] iio: add the IIO backend framework
To: nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Frank Rowand <frowand.list@gmail.com>, Olivier Moysan <olivier.moysan@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 12:08=E2=80=AFPM Nuno Sa via B4 Relay
<devnull+nuno.sa.analog.com@kernel.org> wrote:
>
> From: Nuno Sa <nuno.sa@analog.com>
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

Not sure what the meaning of @ in the above lines.

...

> +/*
> + * Framework to handle complex IIO aggregate devices.
> + *
> + * The typical architecture is to have one device as the frontend device=
 which
> + * can be "linked" against one or multiple backend devices.

Can we have an ASCII art with an example?

>  All the IIO and
> + * userspace interface is expected to be registers/managed by the fronte=
nd
> + * device which will callback into the backends when needed (to get/set =
some
> + * configuration that it does not directly control).
> + *
> + * The framework interface is pretty simple:
> + *   - Backends should register themselves with @devm_iio_backend_regist=
er()
> + *   - Frontend devices should get backends with @devm_iio_backend_get()
> + *
> + * Also to note that the primary target for this framework are converter=
s like
> + * ADC/DACs so @iio_backend_ops will have some operations typical of con=
verter
> + * devices. On top of that, this is "generic" for all IIO which means an=
y kind
> + * of device can make use of the framework. That said, If the @iio_backe=
nd_ops
> + * struct begins to grow out of control, we can always refactor things s=
o that
> + * the industrialio-backend.c is only left with the really generic stuff=
. Then,
> + * we can build on top of it depending on the needs.
> + *
> + * Copyright (C) 2023-2024 Analog Devices Inc.
> + */

...

> +/*
> + * Helper macros to call backend ops. Makes sure the option is supported

Missing period.

> + */

...

> +/**
> + * iio_backend_chan_enable - Enable a backend channel
> + * @back:      Backend device
> + * @chan:      Channel number
> + *
> + * RETURNS:

Not sure if this is the style used in other IIO core files...

> + * 0 on success, negative error number on failure.
> + */

...

> +       if (!try_module_get(back->owner)) {
> +               dev_err(dev, "Cannot get module reference\n");
> +               return -ENODEV;

devm_*() are supposed to be used only at ->probe() stage, hence
dev_err_probe() is fine (and eventually would be nice to have for the
sake of making messaging uniform).

> +       }

...

> +       link =3D device_link_add(dev, back->dev, DL_FLAG_AUTOREMOVE_CONSU=
MER);
> +       if (!link) {
> +               dev_err(dev, "Could not link to supplier(%s)\n",
> +                       dev_name(back->dev));
> +               return -EINVAL;

Ditto.

> +       }

...

> +       if (name) {
> +               ret =3D device_property_match_string(dev, "io-backend-nam=
es",
> +                                                  name);

One line?

> +               if (ret < 0)
> +                       return ERR_PTR(ret);
> +               index =3D ret;
> +       } else {
> +               index =3D 0;
> +       }

...

> +       fwnode =3D fwnode_find_reference(dev_fwnode(dev), "io-backends", =
index);
> +       if (IS_ERR(fwnode)) {
> +               dev_err(dev, "Cannot get Firmware reference\n");
> +               return ERR_CAST(fwnode);

dev_err_probe() ?

> +       }

...

> +       if (!ops) {
> +               dev_err(dev, "No backend ops given\n");
> +               return -EINVAL;

dev_err_probe() ?

> +       }

--=20
With Best Regards,
Andy Shevchenko

