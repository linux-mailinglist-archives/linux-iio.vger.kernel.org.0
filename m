Return-Path: <linux-iio+bounces-2249-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A91C784B7A6
	for <lists+linux-iio@lfdr.de>; Tue,  6 Feb 2024 15:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64D1A28A415
	for <lists+linux-iio@lfdr.de>; Tue,  6 Feb 2024 14:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03CB132486;
	Tue,  6 Feb 2024 14:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7Yc5Y6D"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E41131E5F;
	Tue,  6 Feb 2024 14:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707229247; cv=none; b=bFpQKcCqeBfQkn3muJCt8gg/4sz9Z9c4SVkIhUEiSO5VoglahCEoU3MTz1xn6CEw7GIduSwHjkzu8YyGXp9Il+PqNLT+6R581MgVppJ2/vVdyqySAM3x3d6qJxaf8lQW6rVdUEsvK+lBbg8Wdsf2Bmzu/5rEatDTE1BXQPJARFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707229247; c=relaxed/simple;
	bh=e2K+5F5cLknwyMce9c2/hqxx0fE5qV+472Jq2ExEj0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eQJYa3bbMN+cGCsZMzwUKLTp5/5KwqMNch7N+fWYhmHrQZAu5rU9LxcYHmU27PfYg3iPzAQiwTvM1KkbU9ArtrBMTZPJ0SZpup65dDJGl/d9Hu3gYcgvLzkacCbb0J3WAWSaUUTbQNgJFuyOKzBQ24Y0A0QpfM3wqWpUkrrDV3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f7Yc5Y6D; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55ad2a47b7aso7259629a12.3;
        Tue, 06 Feb 2024 06:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707229244; x=1707834044; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ABBHJfLjGEhFvKKG8YJIpgisqqWyZephHkcgZCqaEv4=;
        b=f7Yc5Y6DrjXT7BTMiT3Ha0Nz2KaSxFyHeeR/hRTfAbsBqLwg4tj8wwukGBp/MGdCiI
         Hl3Oo++W6cpmftkMGakQpua7MlKiSnTUJRrp1Y9DpwH6NOd98/mHKgWPCEllFg2RfjCl
         MO3+WWtTSuYFnTUQbDQXdG9RbHOIQsVe9pNueFv9Dy1K09gGhh9NHZqeylP7dyLXsUoM
         rzNSk1hRmHJ3/LXzd2Hv1p0FVVZHtvS2WOmtx3bFm2kTjMtdqjpDUsCIS7udkxg2EQnv
         ibob69aOdgKPierhysWJvhLCMa8RKNwYdOSxOEUtgwS8LkA0II7cvoKqZDr89Ou9XNej
         mWtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707229244; x=1707834044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ABBHJfLjGEhFvKKG8YJIpgisqqWyZephHkcgZCqaEv4=;
        b=fLfRhiEYVWI4S4m2Ago0tur2DBjk+Joc11DEOI0OomxnnsziuArC2Ekix6PBSfyjKJ
         Ee7VVx0b2ojJN7+oIzkKEINAp/VcEgsfPlVwRnZtzl5BsWKzvJlse0tCBLfpF8L/dGxi
         9n5xJyXF3gNNEBUmDRdkJBNfWgoGXCWS2QsZYoBxWbH5ufYC8RU3H7FAcBwxp5rpMnQw
         WkxvZUWUbXZLNXClArslunuZhuVMx0k5AN0qJcK615M+9mAq1RGsS0iiRzUZ1Ap4NETG
         UwOJdZLGB+Hd84yV7myrPMFtJGSMmM7YV2c4Ea0YK8gC+SgeCYvdoDdQmHN5et3x5Gat
         wkCg==
X-Gm-Message-State: AOJu0Yzmq8UU0t9qaOPdO873c4oPY7YzVITNRL1NgCu9UmvNWdJkYRmc
	i2wEc7J8OMhjjPidBrkw7mEUWxgA7LWk1fmv7aHBqe40EgX52l6HvAWIA4OKU3oPZ/TSYrhyME2
	h7/4752/6ZMYvmRxY8z81Tq7X2Cs=
X-Google-Smtp-Source: AGHT+IG1x8cpSoeJ2SsWOhpuuCkMZ9CLnW1AUGuLwxZrfCAKwDTWcLsQdV/m8hlHhYtYqzqZ4RqWc2/cYJ5AyVJO64M=
X-Received: by 2002:a17:907:7f17:b0:a37:7fb9:ea27 with SMTP id
 qf23-20020a1709077f1700b00a377fb9ea27mr2503929ejc.48.1707229243816; Tue, 06
 Feb 2024 06:20:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206-iio-backend-v9-0-df66d159c000@analog.com> <20240206-iio-backend-v9-6-df66d159c000@analog.com>
In-Reply-To: <20240206-iio-backend-v9-6-df66d159c000@analog.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 6 Feb 2024 16:20:07 +0200
Message-ID: <CAHp75VeWV0+hqCoUb4YvfObnEAv0AaYJmXgpxJLfve+mBwhkyQ@mail.gmail.com>
Subject: Re: [PATCH v9 6/7] iio: adc: ad9467: convert to backend framework
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
> Convert the driver to use the new IIO backend framework. The device
> functionality is expected to be the same (meaning no added or removed
> features).
>
> Also note this patch effectively breaks ABI and that's needed so we can
> properly support this device and add needed features making use of the
> new IIO framework.
>
> Giving the lack of features (and devices supported) in the ad9467 driver

Given

> compared with the ADI out of tree version, we don't expect any user of
> the upstream driver so no one should notice the ABI breakage. However,
> if someone is affected by this, ADI will happily support in transitioning

support transitioning

> to the backend framework.

...

> -               .max_rate =3D 250000000UL,

> -               .max_rate =3D 500000000UL,

> -               .max_rate =3D 125000000UL,

...

> +static int ad9467_update_scan_mode(struct iio_dev *indio_dev,
> +                                  const unsigned long *scan_mask)
> +{
> +       struct ad9467_state *st =3D iio_priv(indio_dev);
> +       unsigned int c;
> +       int ret;
> +
> +       for (c =3D 0; c < st->info->num_channels; c++) {
> +               if (test_bit(c, scan_mask))
> +                       ret =3D iio_backend_chan_enable(st->back, c);
> +               else
> +                       ret =3D iio_backend_chan_disable(st->back, c);

> +

Unneeded blank line.

> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return 0;
> +}

....

> +       st->back =3D devm_iio_backend_get(&st->spi->dev, NULL);
> +       /* If not found, don't error out as we might have legacy DT prope=
rty */
> +       if (!IS_ERR(st->back))
> +               return 0;
> +       if (PTR_ERR(st->back) !=3D -ENOENT)
> +               return PTR_ERR(st->back);

This looks hackish...

Perhaps

  ret =3D PTR_ERR_OR_ZERO(st->back);
  if (ret && ret =3D=3D -ENOENT)
    return _a_new_helper_with_below_code_you_have();

  return ret;

--=20
With Best Regards,
Andy Shevchenko

