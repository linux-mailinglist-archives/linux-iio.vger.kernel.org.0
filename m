Return-Path: <linux-iio+bounces-3329-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE3E870420
	for <lists+linux-iio@lfdr.de>; Mon,  4 Mar 2024 15:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DBD6B28038
	for <lists+linux-iio@lfdr.de>; Mon,  4 Mar 2024 14:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786AA41C6D;
	Mon,  4 Mar 2024 14:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kFoPDBUl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC46D3FE47
	for <linux-iio@vger.kernel.org>; Mon,  4 Mar 2024 14:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709562549; cv=none; b=m9efTKelqSw9vEAVqvl0St5XFxaWvAda/XaD+g9u7YgtiY/04/4qaYigb8GB7pZiuxTYzyYfSWKXDjKmcZY9SiQgJCkEW+TpR3oBQsj5ku4SvisTPSGq/juKv12Z8jlArEfZiY5DNzO62yULlprmko7Hh3Ueu58ZN4aUBHOVE5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709562549; c=relaxed/simple;
	bh=gV/b+qA5KVEGKiKWm/zfGRZwkWT8RLOeLLQr/iVoN4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P7bmWOKxYEEcRSo60btdqRGpUw9yyDlDRjNVrH+zCUS6XBarkuKQ8hojRlKIidJuelqedpHFcTLriKCMNQCCFdSHNSUSkCgHa081iUWvt57P9oo112qO7fmZHYxKgIixhRGUxEI9j+8qSTB+c7XLidOInWvT3Jd+JXCNzEGD5RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=kFoPDBUl; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d288bac3caso53668171fa.2
        for <linux-iio@vger.kernel.org>; Mon, 04 Mar 2024 06:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1709562544; x=1710167344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iaw5xhUG4Aj8G7CnWQRBmfpPKQL5MFpdOIILwmIvtEw=;
        b=kFoPDBUlStaUeMB2xlid/1AGUvPTBnljuysDn70fcfOcor9UQ10+NwwzsCBqkiEPgC
         xRSaAMiQEdK3F7hqn+hC5QqGL790g57UEvO2RUn8zdze74ZHh7tpBk6iDVdTqbVTLpb1
         /+cklCGMrqCCOQB/rDDAASlP0AUTGn6SEal9eJct6e1ml8wAuVhlXatio8vAqAVsIH/s
         fxURxBbjM+Q61OWZk1OqFG4tpbYtRZeR17dGcIXaL4kd8sGMi4Ett1cfcmzlT/OyeL7k
         /VnUhUOztptONtr/HbysQ2U6PNqyA4+yp5Inl9//svwofu8iAeYw3agIJhLj7V9ZkkZt
         QzlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709562544; x=1710167344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iaw5xhUG4Aj8G7CnWQRBmfpPKQL5MFpdOIILwmIvtEw=;
        b=nkcEdfP1/FtUJF6zz3Rp+c+OGWL/XQTRBWitDfByCTiV2QX5s1+jzSfmOelM2afAOx
         wsLaTSYDcQklZ+g0tKI1t4q3PHYPBocLh7L2opfCOat/ZnPnoCQJNh9sU2MQit/6rn45
         tRJtqpQKQO1Jvl3uB7AQPlzCQb4xG+HyJc4COAo5ps1usNHkZU2w6aXWGP93dXkKYFRX
         PGJDd8Btm7guShagHvaMgxfF8xGJ8Gug3l1b752IOzrFQbKr9ItJuBSWHs6RoClT0/ec
         D3FA99Wjy/42pcpPsNGdGnM6YsiLsQam5PbcU5yrzUFjKsLivDOk8cfKIoWz68z83FQ3
         zqfA==
X-Gm-Message-State: AOJu0Ywcqh+ze5YcZYreAqSYbR2dp5kd04qJgY2PJ1/BN4KvmkFeRhQ4
	reJcHiiXb0PJwuZ1QOtv98qM57kgz1oC7vNc8EMJ1n4QOhXwGaEEcwtmg7Tvv2od6Vc+USwh1AF
	ROGn2q2RkOF186B4iNBTBAZhQ0n/LfWVhWgvyxw==
X-Google-Smtp-Source: AGHT+IET7LODBdoZNl+GGg65TD4CtUdpf8gj/b7Xj+UvmWcUszyvhkn6G1kvOct99i5iNOQW5nXdw88nUSu6bY5Z35g=
X-Received: by 2002:a05:651c:1501:b0:2d3:74ce:38cd with SMTP id
 e1-20020a05651c150100b002d374ce38cdmr4513415ljf.51.1709562543894; Mon, 04 Mar
 2024 06:29:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229-ad7944-mainline-v4-0-f88b5ec4baed@baylibre.com>
 <20240229-ad7944-mainline-v4-2-f88b5ec4baed@baylibre.com> <20240303134359.16d5e5f1@jic23-huawei>
In-Reply-To: <20240303134359.16d5e5f1@jic23-huawei>
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 4 Mar 2024 08:28:52 -0600
Message-ID: <CAMknhBGYd8v=t-LB7PEz3OzFRKfVXhw=4Tm7RBKbxSoi_QWh-w@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] iio: adc: ad7944: add driver for AD7944/AD7985/AD7986
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 3, 2024 at 7:44=E2=80=AFAM Jonathan Cameron <jic23@kernel.org> =
wrote:
>
> On Thu, 29 Feb 2024 10:25:51 -0600
> David Lechner <dlechner@baylibre.com> wrote:
>
> > This adds a driver for the Analog Devices Inc. AD7944, AD7985, and
> > AD7986 ADCs. These are a family of pin-compatible ADCs that can sample
> > at rates up to 2.5 MSPS.
> >
> > The initial driver adds support for sampling at lower rates using the
> > usual IIO triggered buffer and can handle all 3 possible reference
> > voltage configurations.
> >
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> >
> Hi David,
>
> Fresh read through showed up a few more things.  They are all trivial exc=
ept
> for what I think is an inverted error condition which would break
> cases where ref was not supplied in DT.

Thanks. All suggestions seems reasonable to me.

> >
> > +
> > +     /*
> > +      * Sort out what is being used for the reference voltage. Options=
 are:
> > +      * - internal reference: neither REF or REFIN is connected
> > +      * - internal reference with external buffer: REF not connected, =
REFIN
> > +      *   is connected
> > +      * - external reference: REF is connected, REFIN is not connected
> > +      */
> > +
> > +     ref =3D devm_regulator_get_optional(&spi->dev, "ref");
> > +     if (IS_ERR(ref)) {
> > +             if (PTR_ERR(ref) !=3D -ENODEV)
>
> Confused. Isn't this inverse of what we want?

Yes, thanks for catching.

> return an error if we got anything other than -ENODEV.
>                 if (PTR_ERR(ref) |=3D -ENODEV)
>                         return dev_err_probe(&spi->dev, PTR_ERR(ref),
>                                              "failed to get REF supply\n"=
);
>                 ref =3D NULL;
>         }
>
> > +                     ref =3D NULL;
> > +             else
> > +                     return dev_err_probe(&spi->dev, PTR_ERR(ref),
> > +                                          "failed to get REF supply\n"=
);
> > +     }
> > +
>
> > +
> > +     adc->cnv =3D devm_gpiod_get(&spi->dev, "cnv", GPIOD_OUT_LOW);
> > +     if (IS_ERR(adc->cnv))
> > +             return dev_err_probe(&spi->dev, PTR_ERR(adc->cnv),
> > +                                  "failed to get CNV GPIO\n");
>
> Is this optional?  If we don't yet support the case the dt binding talks
> about worth a comment here to say we don't yet support XYZ so this
> is not optional.

For now, it is required since we have only implemented 4-wire mode.

