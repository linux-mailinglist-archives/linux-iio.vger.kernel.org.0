Return-Path: <linux-iio+bounces-520-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B92097FFF82
	for <lists+linux-iio@lfdr.de>; Fri,  1 Dec 2023 00:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 162FEB20EE4
	for <lists+linux-iio@lfdr.de>; Thu, 30 Nov 2023 23:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA7A5954A;
	Thu, 30 Nov 2023 23:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gMGAQTSQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB8F10E2
	for <linux-iio@vger.kernel.org>; Thu, 30 Nov 2023 15:34:11 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50bb92811c0so1532733e87.1
        for <linux-iio@vger.kernel.org>; Thu, 30 Nov 2023 15:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1701387250; x=1701992050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JQZO2smk9lB8IbFGyWpiiaWx+EoPvHvBmIDoExFNLfs=;
        b=gMGAQTSQURSXc7mTg/GbOCnWsqHvSn1TrGiEwckP07HIHh20ORy9AHIBudW1KUhp11
         rR4BCQBE/xnQ0qjlttSnOqbeAegxvEHNJS/Lc0nn/4Y+XNZwSzoaYG0VtSeQQWCaSar+
         DHRmELFtGmVXwCVx2HdGP5D7nrOAeubgAe8fdH6oWu9NMdAlZOVQWed/YRo4QgchukBT
         j1vWyRCvcRwvLVWpa8IqPqDK5x7Oi9YXbIhmV2tKZNkRCpXUkUnWtVfiB5DVqn5cwo0D
         8f0PUQksZkbXwzXed8yG8FvoCipwhzRkTKJkU4iS0Cpe9wd2JrRdoQfkDn9P04Gzs4Jd
         EhbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701387250; x=1701992050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JQZO2smk9lB8IbFGyWpiiaWx+EoPvHvBmIDoExFNLfs=;
        b=VCozckAaOf1LWwutHCSnU8Sv0Z1YnytBMtPR8ZkqLGbU+EF5JRiL+DUWvaqPBEtfEb
         4rl42AgWa0KRM95vAu019jEm3KhV6lwrpl/G7GC3l4MtaRP6wZlRJaA9et7a/v7pW1Oq
         C/9YUs6dAVznKX+f7Bsl4sNH/1Gm7NYVwP+bP5/MoaJNzjBgeSdZgD5S+BPtCg1D8MH4
         mXXYMF4vjJWWRupxfkQ/Iw2wVjwnk9GYVnpplrNim158uBCdgF4EGmL4y3+JgBUfjNco
         Iq7LVABFSIMKa1RlLgK+cmHPP0ZSaK/MX8Qppff02MSywR8+lVqzSvGqLfJbk48r1MDC
         Y55g==
X-Gm-Message-State: AOJu0YzNbN3xA6TSeGKHXtp8Cg0T0qW0EEgL/z2fY0A8hD1dBKrtYt1X
	QmaTJrOBUWkI2VFlnEwy2ZZDixSSqWEXDOgv+CR3VA==
X-Google-Smtp-Source: AGHT+IGdZffvtch0g6MlraHwYeW6Dn5ZPxtraT1CJGSOhr2L5QRrHtST+DhfAVRqaUY+thzmGSVaBDHnDo15+vMR1q0=
X-Received: by 2002:a05:6512:b96:b0:50a:ae89:491f with SMTP id
 b22-20020a0565120b9600b0050aae89491fmr211943lfv.3.1701387249855; Thu, 30 Nov
 2023 15:34:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231121-dev-iio-backend-v1-0-6a3d542eba35@analog.com> <20231121-dev-iio-backend-v1-12-6a3d542eba35@analog.com>
In-Reply-To: <20231121-dev-iio-backend-v1-12-6a3d542eba35@analog.com>
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 30 Nov 2023 17:33:59 -0600
Message-ID: <CAMknhBFk1SbcQeG_bxtKUhR_hF2R0cRrVAPFomL_TOS9eh8Kqw@mail.gmail.com>
Subject: Re: [PATCH 12/12] iio: adc: adi-axi-adc: move to backend framework
To: nuno.sa@analog.com
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-iio@vger.kernel.org, Olivier MOYSAN <olivier.moysan@foss.st.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 4:17=E2=80=AFAM Nuno Sa via B4 Relay
<devnull+nuno.sa.analog.com@kernel.org> wrote:
>
> From: Nuno Sa <nuno.sa@analog.com>
>
> Move to the IIO backend framework. Devices supported by adi-axi-adc now
> register themselves as backend devices.
>
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  drivers/iio/adc/Kconfig       |   1 +
>  drivers/iio/adc/adi-axi-adc.c | 364 ++++++++----------------------------=
------
>  2 files changed, 65 insertions(+), 300 deletions(-)
>
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index af56df63beff..cc42a3399c63 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -292,6 +292,7 @@ config ADI_AXI_ADC
>         select IIO_BUFFER
>         select IIO_BUFFER_HW_CONSUMER
>         select IIO_BUFFER_DMAENGINE
> +       select IIO_BACKEND
>         depends on HAS_IOMEM
>         depends on OF
>         help
> diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.=
c
> index c247ff1541d2..b2ab2c119efa 100644
> --- a/drivers/iio/adc/adi-axi-adc.c
> +++ b/drivers/iio/adc/adi-axi-adc.c

<snip>

> @@ -390,37 +166,23 @@ static int adi_axi_adc_probe(struct platform_device=
 *pdev)
>         if (ret)
>                 return ret;
>
> -       if (cl->info->version > ver) {
> +       if (*expected_ver > ver) {
>                 dev_err(&pdev->dev,
>                         "IP core version is too old. Expected %d.%.2d.%c,=
 Reported %d.%.2d.%c\n",
> -                       ADI_AXI_PCORE_VER_MAJOR(cl->info->version),
> -                       ADI_AXI_PCORE_VER_MINOR(cl->info->version),
> -                       ADI_AXI_PCORE_VER_PATCH(cl->info->version),
> +                       ADI_AXI_PCORE_VER_MAJOR(*expected_ver),
> +                       ADI_AXI_PCORE_VER_MINOR(*expected_ver),
> +                       ADI_AXI_PCORE_VER_PATCH(*expected_ver),
>                         ADI_AXI_PCORE_VER_MAJOR(ver),
>                         ADI_AXI_PCORE_VER_MINOR(ver),
>                         ADI_AXI_PCORE_VER_PATCH(ver));
>                 return -ENODEV;
>         }
>
> -       indio_dev->info =3D &adi_axi_adc_info;
> -       indio_dev->name =3D "adi-axi-adc";
> -       indio_dev->modes =3D INDIO_DIRECT_MODE;
> -       indio_dev->num_channels =3D conv->chip_info->num_channels;
> -       indio_dev->channels =3D conv->chip_info->channels;
> -
> -       ret =3D adi_axi_adc_config_dma_buffer(&pdev->dev, indio_dev);
> +       ret =3D devm_iio_backend_register(&pdev->dev, &adi_axi_adc_generi=
c, st);
>         if (ret)
>                 return ret;
>
> -       ret =3D adi_axi_adc_setup_channels(&pdev->dev, st);
> -       if (ret)
> -               return ret;
> -
> -       ret =3D devm_iio_device_register(&pdev->dev, indio_dev);
> -       if (ret)
> -               return ret;
> -
> -       dev_info(&pdev->dev, "AXI ADC IP core (%d.%.2d.%c) probed\n",
> +       dev_info(&pdev->dev, "AXI ADC IP core (%d.%.2d.%d) probed\n",

Was this format change intentional? There are other places above where
%c is still used.

>                  ADI_AXI_PCORE_VER_MAJOR(ver),
>                  ADI_AXI_PCORE_VER_MINOR(ver),
>                  ADI_AXI_PCORE_VER_PATCH(ver));
> @@ -428,6 +190,8 @@ static int adi_axi_adc_probe(struct platform_device *=
pdev)
>         return 0;
>  }
>
> +static unsigned int adi_axi_adc_10_0_a_info =3D ADI_AXI_PCORE_VER(10, 0,=
 'a');
> +
>  /* Match table for of_platform binding */
>  static const struct of_device_id adi_axi_adc_of_match[] =3D {
>         { .compatible =3D "adi,axi-adc-10.0.a", .data =3D &adi_axi_adc_10=
_0_a_info },
>
> --
> 2.42.1
>
>

