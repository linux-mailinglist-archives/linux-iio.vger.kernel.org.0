Return-Path: <linux-iio+bounces-18883-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1365EAA3B20
	for <lists+linux-iio@lfdr.de>; Wed, 30 Apr 2025 00:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A93BC1BC4FAD
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 22:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2738A270557;
	Tue, 29 Apr 2025 22:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JXYK4D9W"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513F422170A;
	Tue, 29 Apr 2025 22:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745964895; cv=none; b=n0s8RlVAS2F5+XZc2w9IcGLHA9/uE/myCjv689O7Y77zwC/RnyXTz49JN4zyLbofbtSrT+Q+bEWoOpLpCR0sJnTTCNHJsKIbOASHbVBZO4wNthckM/UTH7h9lWT6sJLLCO5t7c3IxIRxUN2ladt5v+IfmbTVgFR8BiBeKRwfUZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745964895; c=relaxed/simple;
	bh=RIcWBY8Fo3GEKK8o+yGRNgc/nVuWgmxFuKTA1IIx/NE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xbjx8eYe9eJknE2Kc992YXhGPQfn/I2i+w6mAejs3EAVjmUtA1jqwGd5NBW9nvlQ/bcFX06rWREeapGOdh0562nBaJu/YIdy2ZuGtpfmmAc5tbvZQD8rr/A7tZIMA1rHiB0gQeq1co+aBPsT7BoU2Bt87SKsbek87hvBPrKA//U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JXYK4D9W; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac2ab99e16eso1424978266b.0;
        Tue, 29 Apr 2025 15:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745964892; x=1746569692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vCPGMV2iOcTy2jhzzFW4RAkJHqiM2kdCsOEs0l55zcU=;
        b=JXYK4D9WJGO5Btx2Pm8rJnbDUAefdl+h+L3YKKvaZzqmzeQxACcLnEiz92cdJ28fMe
         1yuTF2b96t9wBg9wQzFWJDRf68+AHeAZmbsKaxloMB30tfe6DwDgXZOXbRwJdXGMxBOZ
         o/UG3WgORUk3cUY1D63jku1mbwzAewsFcX+Nq00ge6PQPAaB2TfmSil5ZQiocFwoMpfz
         f1899t2GGfhvjBQisQV8LBWpZLX/JaG79gYIhA/4kWsK6+A9bRV6l9B9/FXucsxg3LHw
         vzvMrhvNle2CKVTlhD9PSt/HXE022MwQlmmEMFoJjl7Lui9b6+gKlJJ7yyjW421Rjhrl
         yviQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745964892; x=1746569692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vCPGMV2iOcTy2jhzzFW4RAkJHqiM2kdCsOEs0l55zcU=;
        b=cnZvRqwqTzcTKkY7XotgKTL7LM4S2rQVB5c5Ms3NQtDJiEewBLGRvLHIqozGcI/f04
         EVY1eEKCMGU5jV4yrpaI8mAHgx0ncPrGlNf1jn7/nUunLQaOa29yZhQbEubsTslb1M/W
         oH7EvjARxxJ1aQMQGNQ4tYo3u8oOc9DQHBQS8rwlISy0ZFhTbicUwGSE27aPWV4RPNQr
         tGmEfNwpjOu9M++akow3j+ZMHaHgGTLGuJAXfbaDnQA6ihbhtdZotV9yxmqQ9t0DkGN+
         yNIWpQ3Ws9XM7uWgHC0T1qFuCVx61rFSrSeOCQ3x2aJK9yIsMPEGCZPMn5RmS6kiLE+h
         EYzA==
X-Forwarded-Encrypted: i=1; AJvYcCUcf16zrwRMNIzAdIvK7Q58ph3qu4YoG0xolEz0NwlgoO6Le3vu2T9rY3BkguG/LkrJdJK+JbzoRIDS@vger.kernel.org, AJvYcCVrMXrSAfsUEcWASElQBW+WmUTpwWyDOz6kx2gthfELyvcei48bEfxpRcoxsQ53zWFw381EF6C7wg+jjz1v@vger.kernel.org
X-Gm-Message-State: AOJu0YwDdmeFi0PoEUb7BaV4F9XpYJmwMabq6H830FKl0K0ZWx851TT3
	CuVDV8T9KDP94+NjIF8tLNZwQnnswWLd1s6DIYFRofB97D+YHvfbixoPJA21Nh51XWkKbwlvXmD
	8kYsaXG5K1H1Y5i1YoXzlk1q8HBE=
X-Gm-Gg: ASbGncsLXbPkzHykmqJLQI7ktGeSPQG2Itx9sFrkfeDkr+q1tFIgVzd4QbyJJsl5bB/
	dR8pwDp7wgoO3TnAoLTnWxu7recV8f63pVUZuqsNMhBSi7jYsbQQA60FL5pKx0OwjUCCS0QD4IL
	b/keXIOYD4pl3lHMFdvp2Fja0T4DWq36KJ
X-Google-Smtp-Source: AGHT+IF5k22LCWqIm1IKBib3ZCxfVAR9SkkoKIsyRXYzomlQDL/heybQBl/tfU6QyfbFPneWtOBItUISatf9RT2Q6fc=
X-Received: by 2002:a17:907:94ca:b0:ac6:b639:5a1c with SMTP id
 a640c23a62f3a-acedc610e2bmr95262866b.22.1745964892481; Tue, 29 Apr 2025
 15:14:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1745841276.git.marcelo.schmitt@analog.com> <e4abdd44a28c395dd51c5a492aeda5074331e6ea.1745841276.git.marcelo.schmitt@analog.com>
In-Reply-To: <e4abdd44a28c395dd51c5a492aeda5074331e6ea.1745841276.git.marcelo.schmitt@analog.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 30 Apr 2025 01:14:16 +0300
X-Gm-Features: ATxdqUFPvAPaawirq-Ww1Rjfr9-58GArZTeAVZQQzWAXckyhrqm6bPqILX_rwb8
Message-ID: <CAHp75VfF2DJKghy47UP_GPtcfxKNFfJW2oWz4sUZ1XTCxOte9g@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] iio: adc: ad4170: Add GPIO controller support
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jic23@kernel.org, lars@metafoo.de, 
	Michael.Hennerich@analog.com, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	marcelo.schmitt1@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 3:29=E2=80=AFPM Marcelo Schmitt
<marcelo.schmitt@analog.com> wrote:
>
> The AD4170 has four multifunctional pins that can be used as GPIOs. The
> GPIO functionality can be accessed when the AD4170 chip is not busy
> performing continuous data capture or handling any other register
> read/write request. Also, the AD4170 does not provide any interrupt based
> on GPIO pin states so AD4170 GPIOs can't be used as interrupt sources.
>
> Implement gpio_chip callbacks to make AD4170 GPIO pins controllable throu=
gh
> the gpiochip interface.

...

> +static int ad4170_gpio_set(struct gpio_chip *gc, unsigned int offset, in=
t value)
> +{
> +       struct iio_dev *indio_dev =3D gpiochip_get_data(gc);
> +       struct ad4170_state *st =3D iio_priv(indio_dev);
> +       unsigned int val;
> +       int ret;
> +
> +       if (!iio_device_claim_direct(indio_dev))
> +               return -EBUSY;
> +
> +       guard(mutex)(&st->lock);
> +       ret =3D regmap_read(st->regmap, AD4170_GPIO_MODE_REG, &val);
> +       if (ret)
> +               goto err_release;
> +
> +       if (val & BIT(offset * 2 + 1))
> +               ret =3D regmap_update_bits(st->regmap, AD4170_GPIO_OUTPUT=
_REG,
> +                                        BIT(offset), value << offset);

Haven't you seen my previous review (v1)? I asked what if the value is > 1?
I also recommended looking at regmap_assign_bits().

> +       else
> +               ret =3D -EPERM;
> +
> +err_release:
> +       iio_device_release_direct(indio_dev);
> +       return ret;
> +}

--=20
With Best Regards,
Andy Shevchenko

