Return-Path: <linux-iio+bounces-17635-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26119A7C9D9
	for <lists+linux-iio@lfdr.de>; Sat,  5 Apr 2025 17:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04F873BB8B1
	for <lists+linux-iio@lfdr.de>; Sat,  5 Apr 2025 15:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCB0148857;
	Sat,  5 Apr 2025 15:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7/mqHTY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42398BEC;
	Sat,  5 Apr 2025 15:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743866620; cv=none; b=V0FqSEF3aUMYTiLcMPVRm8O0PLR1OZa2UIBCRviccqB7N48SjVAR/x9PzjD6OCXNmoEgr4tOdUvF5YsbO4BPiZUk3fuKHxfLXzPeGNQp487i2iF8fmfD3epWWkDNDdt9ctSI6/hGE7vji7YgQmNV414D3xGyMvnFeFCTtpDEeMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743866620; c=relaxed/simple;
	bh=od8ciXik2FNftK2oe/yN1gUgminPHYcCOtS2LwNZHHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JIAAOQ4aslefnqPE98aMqbCfVDZDWyddlmi8+2Xt6DyxCdphrzIHWE/xotytLdkH8+HWZWfZRXABYLhAEwxR8OqYDLlRq8ailZvd/9yDfEb30wMVCBU6JdiBBED6sPBuszl3FyIzNg85pQ4+6UN/fBH9zcPbFOMJYDfCkWDRtpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f7/mqHTY; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-39c31e4c3e5so1756713f8f.0;
        Sat, 05 Apr 2025 08:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743866617; x=1744471417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yJKAzaBgFuNvggoWvAUUbSt2fnMG4Xy93l9u0g7kzKo=;
        b=f7/mqHTYe70OieHeCUwRls1I/P9ZSt95iEJNvjP19HAwCr3bZvTeXd0Q5g0wxuObv2
         BxsbeYduVLHxrtFDad2PejEim8lN3qZ5+X1SbYyunc6ienI8UDdbO2jrfKEb1F5KUuV+
         k9FVjHLGXmZqSJd3RbsIaRPm98CiOhJ/qQ8DQjOCFQPri/5sZZe5rHB2y1Akuk8tJhiV
         0VSBf4cpDvbcdKxh48vH7ImX2puDFDPzAuXMR5iAKhd5gZe8N4UjVGrq4XqU4xQyUwe1
         EOgNbpJt0wvK9TNTCDvD2z1UD+4kRKrCjTsD825twciWvtTC1//j94j7y2R3BhOG71Zo
         CXdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743866617; x=1744471417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yJKAzaBgFuNvggoWvAUUbSt2fnMG4Xy93l9u0g7kzKo=;
        b=gwGN07EER2SsLtISsvimcAH306T8Oiw6CcCTODBXbQid658gDPPzi+FwVOhCz1xTTR
         4oGT8thpwTQhkmPLbCUvKCmmpZ/+OsXBHJ3izdDpZlDHOemm/jsHPXPjsjB1MoUEmCIs
         WX2ORlL9Vk02W+zXA7/4Kfhujf9rOh/vaxZLo10p/AEdMG60nMwWO5Kzf2Y9DaO3qMpK
         UxnIBOTK8dBWdsQxwgcuIXLkW9SH8fkeMo1Li+j2LOopjjO3iijhV3+LwX/4nxBXIcm3
         KA6f+WiNj45hgaQ0WaylzOfy0t1FrKdVN/oPhBUf64KiYXWb1xchEpwave/CmTytT1sK
         o6zQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlKMOU71HevvkHf8IeesDepzAefs8sYg/HKyvMOpQeyFr2m9efx9/Bjz0SvHJzKe+Izm0Ur8D7UonP@vger.kernel.org, AJvYcCWgCMcE6EWj3JpW40VnOjnJmuojaLM9zyAI1gxIQhM7pDBYPTAItbwGXg+WBSyp8V5BcZXlHDFx64+vWDzO@vger.kernel.org, AJvYcCXBdzfKDxzWmAsVybQLdah157m0hTkl0QxhhNgDmvIoDiUaG4mfpeuwfVV9HZyoE3ZZ5abkqpUaEz5M@vger.kernel.org
X-Gm-Message-State: AOJu0YxpH0cFn5zXFUlxkw2Y+shqxmSdUGr8TewaMI9/Vc0VDd1LY0/T
	JerenPn3v7bYkwGjbBFLrDEIE9pyjaCzAdZ+urBy4T/h1KsG7fR7g3BLIQfthv5jnQwHaW1S2dq
	bKUaheIVLIXMjnrH0KGbE22sj6GHQJZoY
X-Gm-Gg: ASbGncvIDdl86eVnapf39FTlfNq+Oo+Dqd/mnECAqnMOlpXMan6T6XSCNtqhxelrVn+
	VXKgq9sjI2irDlJfCyZI/AbjiIcM9/7hytflGBnv9yHChOoEKPdUTY4Po4MrBos6S6hQUgIQ1x8
	hpz17jogwSLRrSthm4k7pUhfL7oXXp/gHJyGpeRQ==
X-Google-Smtp-Source: AGHT+IEPt+tKOg6rGXgPs53euEcYmbmmxLIOdzXJGLTp96YiHffnzoMrFpobNWGEGoacapq3E8kRsxT8k43ifapJ+Tc=
X-Received: by 2002:a05:6000:4021:b0:391:2df9:772d with SMTP id
 ffacd0b85a97d-39cb3596914mr5945618f8f.13.1743866616591; Sat, 05 Apr 2025
 08:23:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310075638.6979-1-clamor95@gmail.com> <20250310075638.6979-3-clamor95@gmail.com>
In-Reply-To: <20250310075638.6979-3-clamor95@gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sat, 5 Apr 2025 18:23:25 +0300
X-Gm-Features: ATxdqUF8_oQAqCXmMxuE7ddj49zaZyxRt4svID7IzWlEsor7h37jwEUmiyyN2pE
Message-ID: <CAPVz0n0NA+=+4da8izPvTn3XacdJndyxrvyMY-QvHdie206wVg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] thermal: thermal-generic-adc: add temperature
 sensor channel
To: Jonathan Cameron <jic23@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Laxman Dewangan <ldewangan@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D0=BD, 10 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 09:57 Svya=
toslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> To avoid duplicating sensor functionality and conversion tables, this
> design allows converting an ADC IIO channel's output directly into a
> temperature IIO channel. This is particularly useful for devices where
> hwmon isn't suitable or where temperature data must be accessible through
> IIO.
>
> One such device is, for example, the MAX17040 fuel gauge.
>
> The temperature data, while technically a product of conversion and thus
> categorized as IIO_CHAN_INFO_PROCESSED, maintains its unscaled state
> (milli-degree). To account for this, IIO_CHAN_INFO_RAW is used along with
> IIO_CHAN_INFO_SCALE to provide different degrees of accuracy.
>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/thermal/thermal-generic-adc.c | 62 ++++++++++++++++++++++++++-
>  1 file changed, 61 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/thermal-generic-adc.c b/drivers/thermal/ther=
mal-generic-adc.c
> index ee3d0aa31406..7dcc2e1168a4 100644
> --- a/drivers/thermal/thermal-generic-adc.c
> +++ b/drivers/thermal/thermal-generic-adc.c
> @@ -7,6 +7,7 @@
>   * Author: Laxman Dewangan <ldewangan@nvidia.com>
>   */
>  #include <linux/iio/consumer.h>
> +#include <linux/iio/iio.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> @@ -73,6 +74,65 @@ static const struct thermal_zone_device_ops gadc_therm=
al_ops =3D {
>         .get_temp =3D gadc_thermal_get_temp,
>  };
>
> +static const struct iio_chan_spec gadc_thermal_iio_channel[] =3D {
> +       {
> +               .type =3D IIO_TEMP,
> +               .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> +                                     BIT(IIO_CHAN_INFO_SCALE),
> +       }
> +};
> +
> +static int gadc_thermal_read_raw(struct iio_dev *indio_dev,
> +                                struct iio_chan_spec const *chan,
> +                                int *val, int *val2, long mask)
> +{
> +       struct gadc_thermal_info *gtinfo =3D iio_priv(indio_dev);
> +       int ret;
> +
> +       switch (mask) {
> +       case IIO_CHAN_INFO_RAW:
> +               ret =3D gadc_thermal_get_temp(gtinfo->tz_dev, val);
> +               if (ret)
> +                       return ret;
> +
> +               return IIO_VAL_INT;
> +
> +       case IIO_CHAN_INFO_SCALE:
> +               /* scale to a degree centigrade */
> +               *val =3D 1;
> +               *val2 =3D 1000;
> +               return IIO_VAL_FRACTIONAL;
> +
> +       default:
> +               return -EINVAL;
> +       }
> +}
> +
> +static const struct iio_info gadc_thermal_iio_info =3D {
> +       .read_raw =3D gadc_thermal_read_raw,
> +};
> +
> +static int gadc_iio_register(struct device *dev, struct gadc_thermal_inf=
o *gti)
> +{
> +       struct gadc_thermal_info *gtinfo;
> +       struct iio_dev *indio_dev;
> +
> +       indio_dev =3D devm_iio_device_alloc(dev, sizeof(struct gadc_therm=
al_info));
> +       if (!indio_dev)
> +               return -ENOMEM;
> +
> +       gtinfo =3D iio_priv(indio_dev);
> +       memcpy(gtinfo, gti, sizeof(struct gadc_thermal_info));
> +
> +       indio_dev->name =3D dev_name(dev);
> +       indio_dev->info =3D &gadc_thermal_iio_info;
> +       indio_dev->modes =3D INDIO_DIRECT_MODE;
> +       indio_dev->channels =3D gadc_thermal_iio_channel;
> +       indio_dev->num_channels =3D ARRAY_SIZE(gadc_thermal_iio_channel);
> +
> +       return devm_iio_device_register(dev, indio_dev);
> +}
> +
>  static int gadc_thermal_read_linear_lookup_table(struct device *dev,
>                                                  struct gadc_thermal_info=
 *gti)
>  {
> @@ -153,7 +213,7 @@ static int gadc_thermal_probe(struct platform_device =
*pdev)
>
>         devm_thermal_add_hwmon_sysfs(dev, gti->tz_dev);
>
> -       return 0;
> +       return gadc_iio_register(&pdev->dev, gti);
>  }
>
>  static const struct of_device_id of_adc_thermal_match[] =3D {
> --
> 2.43.0
>

Added Jonathan Cameron and linux-iio@vger.kernel.org to list.

Jonathan, this is newer version of the thermal-generic-adc you have
reviewed recently with channels adjusted like proposed in v3.

