Return-Path: <linux-iio+bounces-18039-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A3DA87168
	for <lists+linux-iio@lfdr.de>; Sun, 13 Apr 2025 11:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 344557AC888
	for <lists+linux-iio@lfdr.de>; Sun, 13 Apr 2025 09:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FC419DF5B;
	Sun, 13 Apr 2025 09:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmgu+Ch5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B6517B505;
	Sun, 13 Apr 2025 09:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744537347; cv=none; b=FyLYPlQploRqdGOetaDCxAcvdKE6jbPA8SWHmClCeurnKoc2t6j7GIIu/HxtFumv+hLNh95ES1euiA99TR+BT67glHuApGffQN5hlzKR7t1xcLlC+BlJfuXjpBZGuGDmOkUD/rC3cmysudxTrEL1WJ1qg6emWGD0qOj11omXau0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744537347; c=relaxed/simple;
	bh=aiFgaKkQ7d7rDisr7NBqzs8rMB5K3Ef46CwT6pChnjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hq/+12QopEWTbFqwEcmOioKw/aBFw0W74dgEr3NbrcWGb5D+0UEwpRs3mx2hzRXOiHsZV1N37LppTSuB7jWmxk4tUNv7Ffk+MRPmmy5CEb3Lvpm3EwZKZt9sAZ/S8+8FcM+gLQAUnjbSiYxsixzrWAx93exRjaNA3Pam73jF67I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mmgu+Ch5; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-39c266c1389so2247739f8f.1;
        Sun, 13 Apr 2025 02:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744537344; x=1745142144; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n64Y28j5ioEXxqy3qDOgxoNsAXMuye9f85AGvrRQrp0=;
        b=mmgu+Ch52mRPRKzmN8f4bOmxHLNgN1ymfRgtWZG2HI9i/WFl3xfj7zbCp3Bjwl85Yd
         6iKN5arRF9qnhyjqZ0JiGszohA49XG0rSSxofMxcPB6534pRAIswJyqHlU02BMiO7UCS
         9+92CR6feEKvtxST8YUnHVcJhphTOk+2bxLv5/gi0PUIZshtpAGns1jGhsdFnfoO1BoL
         1P8GwaqMSCM4rndZD3qpsgnHzLT0yovQbIXdcJNQPW/ByClyVZpl8hFhcto1Dcada38w
         0Rkw40+SG532nQJf8KEnRMQvvgzInOj/2NZ7BHy0KaNyml4hBJMiL8oD4LbGXV8iiX3E
         fjiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744537344; x=1745142144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n64Y28j5ioEXxqy3qDOgxoNsAXMuye9f85AGvrRQrp0=;
        b=rFlekeDtoF+WLN+6iu1zGvO33C1kce44ZjN9niwRwlbEwv6Pllk8sTusCIhvJVMARE
         eDfcaolXzrsnsu14KdGiHwK2IAyHEGQNECzP/FDuK5QBhf5TzrTf4JMNK8cCEO3dgE5u
         VF+3ljIrw1/5GB2iBnuvW/qmzgSxzR5qEWDar4mkO9MiSWSXkUcqGMHoWbT2Fw5CJS8t
         BbFytI8nHTxpnp1DRJVl/JdcTSvm3m+foWWtpaeMagk6J+/bPyL+Mc9dKXXvg2Rbuvhn
         8PHg5CQTksEC/Oj8xLP9nDe9AqgbDYtR7fRdFE8FBLhLMh8OUUP8er2gQ+ocg4joYVYq
         Bj9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUbVhDkq9l+iUcXv3+d+taALazhkU97n7C8Of9gyRa0tiqlC7VixcQzW3/nSVBWntyJHIDl8ND0DotjePV7@vger.kernel.org, AJvYcCViOM9KKq9wLn5KpMzeL+fV/MJZP0WsyvE/x7JyeqGnLuJgVq3/uMxxUE6U5IPWwhX7auv57a87UHLu@vger.kernel.org, AJvYcCWCodJTJcEY4KPGROwS+j9fP3GilLjNrCIFfutWYQ0cXen7Az8gbP7oGdTZxtSDpCSMzqYx00TG3efG@vger.kernel.org, AJvYcCXIQT1ewtrzDqjE5NeXJKBopIb4J5DSJcjSYeNktnLxR78Awep65zDl0l34eEiHZAYH7PWy8wYSf9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcVgPRlpUnaLxuVXmaIAw+q+22/3B4TZ614tLaOohGoHnxOOD5
	WN3FWtKoHe5nWSImuKNvyAG7I67vZAk1oOVxRfBGJcqdkIEY83uU4xKtLz12MGzqCToCsZoDzRM
	3wl13da2D7LOMkhJpDmprkRBzyrM=
X-Gm-Gg: ASbGncv2Ttu8nTX8KhYOpTT65NUxPjGNtYQF7de96ZoCmcrrM5ITa/9Jg+9Mn7aDCj6
	BzKFW7M8Qn9xmAN2B+qZtj7wYblDeLegeeRpwJhR2i4/mSbEWwio8caySBoRZKZmTBM0tvm9JHA
	XfpqYOt0uui+NTlkF5/7vAwS7E4czRUodueQ==
X-Google-Smtp-Source: AGHT+IEGH7olQcjvLrYzDZgoAmEhCmF8rkWhW2psIV1CTby+PwnSvoGyFwWT1vIPyBwyldspOZw6NCpar6dgo85QFRU=
X-Received: by 2002:a05:6000:18a2:b0:38f:503a:d93f with SMTP id
 ffacd0b85a97d-39eaaec7db5mr7316066f8f.40.1744537343735; Sun, 13 Apr 2025
 02:42:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310075638.6979-1-clamor95@gmail.com> <20250310075638.6979-3-clamor95@gmail.com>
 <CAPVz0n0NA+=+4da8izPvTn3XacdJndyxrvyMY-QvHdie206wVg@mail.gmail.com>
 <20250412115354.0b266fae@jic23-huawei> <CAPVz0n0eqLEjVgMX=4A8jZZ++Ffb_vfCRdqYdizDmuLbXjVb1w@mail.gmail.com>
 <20250413102822.0cca4941@jic23-huawei>
In-Reply-To: <20250413102822.0cca4941@jic23-huawei>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 13 Apr 2025 12:42:12 +0300
X-Gm-Features: ATxdqUF0gtMc65tYDzP9TnqmoSTC7QCPFeL4mZbuAWoZWQrt0PKrPahnb4EKjq8
Message-ID: <CAPVz0n16TbodhuTcqUufCk6=178ZTcc=2SLUjYHe5YsSJvettQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] thermal: thermal-generic-adc: add temperature
 sensor channel
To: Jonathan Cameron <jic23@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Laxman Dewangan <ldewangan@nvidia.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BD=D0=B4, 13 =D0=BA=D0=B2=D1=96=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 12:2=
8 Jonathan Cameron <jic23@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sat, 12 Apr 2025 14:06:06 +0300
> Svyatoslav Ryhel <clamor95@gmail.com> wrote:
>
> > =D1=81=D0=B1, 12 =D0=BA=D0=B2=D1=96=D1=82. 2025=E2=80=AF=D1=80. =D0=BE =
13:54 Jonathan Cameron <jic23@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > On Sat, 5 Apr 2025 18:23:25 +0300
> > > Svyatoslav Ryhel <clamor95@gmail.com> wrote:
> > >
> > > > =D0=BF=D0=BD, 10 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 09=
:57 Svyatoslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > > > >
> > > > > To avoid duplicating sensor functionality and conversion tables, =
this
> > > > > design allows converting an ADC IIO channel's output directly int=
o a
> > > > > temperature IIO channel. This is particularly useful for devices =
where
> > > > > hwmon isn't suitable or where temperature data must be accessible=
 through
> > > > > IIO.
> > > > >
> > > > > One such device is, for example, the MAX17040 fuel gauge.
> > > > >
> > > > > The temperature data, while technically a product of conversion a=
nd thus
> > > > > categorized as IIO_CHAN_INFO_PROCESSED, maintains its unscaled st=
ate
> > > > > (milli-degree). To account for this, IIO_CHAN_INFO_RAW is used al=
ong with
> > > > > IIO_CHAN_INFO_SCALE to provide different degrees of accuracy.
> > >
> > > You've lost me in this description.  The base units of an IIO tempera=
ture channel
> > > are milli-degrees so if the scaling is already right for that you wou=
ld
> > > be fine using a IIO_CHAN_INFO_PROCESSED channel.
> > >
> > > A few other minor things inline.
> > >
> > > > >
> > > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > > ---
> > > > >  drivers/thermal/thermal-generic-adc.c | 62 +++++++++++++++++++++=
+++++-
> > > > >  1 file changed, 61 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/thermal/thermal-generic-adc.c b/drivers/ther=
mal/thermal-generic-adc.c
> > > > > index ee3d0aa31406..7dcc2e1168a4 100644
> > > > > --- a/drivers/thermal/thermal-generic-adc.c
> > > > > +++ b/drivers/thermal/thermal-generic-adc.c
> > > > > @@ -7,6 +7,7 @@
> > > > >   * Author: Laxman Dewangan <ldewangan@nvidia.com>
> > > > >   */
> > > > >  #include <linux/iio/consumer.h>
> > > > > +#include <linux/iio/iio.h>
> > > > >  #include <linux/kernel.h>
> > > > >  #include <linux/module.h>
> > > > >  #include <linux/platform_device.h>
> > > > > @@ -73,6 +74,65 @@ static const struct thermal_zone_device_ops ga=
dc_thermal_ops =3D {
> > > > >         .get_temp =3D gadc_thermal_get_temp,
> > > > >  };
> > > > >
> > > > > +static const struct iio_chan_spec gadc_thermal_iio_channel[] =3D=
 {
> > > Even though there is only one. If it is an array use channels.
> > >
> > > or stop it being an array and just take a pointer to a single channel
> > > instance.
> > >
> >
> > There should not be more channels, but tbh, you never know, I will
> > rename to channels.
> >
> > > > > +       {
> > > > > +               .type =3D IIO_TEMP,
> > > > > +               .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> > > > > +                                     BIT(IIO_CHAN_INFO_SCALE),
> > > > > +       }
> > > > > +};
> > > > > +
> > > > > +static int gadc_thermal_read_raw(struct iio_dev *indio_dev,
> > > > > +                                struct iio_chan_spec const *chan=
,
> > > > > +                                int *val, int *val2, long mask)
> > > > > +{
> > > > > +       struct gadc_thermal_info *gtinfo =3D iio_priv(indio_dev);
> > > > > +       int ret;
> > > > > +
> > > > > +       switch (mask) {
> > > > > +       case IIO_CHAN_INFO_RAW:
> > > > > +               ret =3D gadc_thermal_get_temp(gtinfo->tz_dev, val=
);
> > > > > +               if (ret)
> > > > > +                       return ret;
> > > > > +
> > > > > +               return IIO_VAL_INT;
> > > > > +
> > > > > +       case IIO_CHAN_INFO_SCALE:
> > > > > +               /* scale to a degree centigrade */
> > >
> > > As above.  See Documentation/ABI/testing/sysfs-bus-iio
> > > entries from temperature. Scaling of a temperature channel is milli-d=
egrees
> > >
> > > This is a bit of a historical artefact. Way back at the start of IIO
> > > when we had relatively few channel types, where possible I matched th=
e
> > > scaling to hwmon.  With hindsight that made things a bit inconsistent
> > > but we are stuck with it as ABI :(
> > >
> >
> > RAW channel is in milli-degrees, or this is not enough? I don't get
> > your point here tbh. What is wrong? Battery driver requires
> > temperature in degree centigrade hence it is scaled to it.
>
> If the battery driver is assuming the temperature from a query to an IIO
> provide (to get the processed value) is in degrees centigrade then that
> is a bug that needs fixing and it probably implies a scaling problem
> in some other driver given I assume someone is using that driver!
>
> The scale here should be 1.  Simplest being to just make a processed
> channel and not provide scale at all.
>
> We never explicitly document the internal ABI but the use of
> scale and raw must match the userspace ABI which is documented
> in Documentation/ABI/testing/sysfs-bus-iio
>
> Jonathan
>

Acknowledged. I will return back to processed and send a fix regards
the battery.

>
> >
> > > Jonathan
> > >
> > > > > +               *val =3D 1;
> > > > > +               *val2 =3D 1000;
> > > > > +               return IIO_VAL_FRACTIONAL;
> > > > > +
> > > > > +       default:
> > > > > +               return -EINVAL;
> > > > > +       }
> > > > > +}
> > > > > +
> > > > > +static const struct iio_info gadc_thermal_iio_info =3D {
> > > > > +       .read_raw =3D gadc_thermal_read_raw,
> > > > > +};
> > > > > +
> > > > > +static int gadc_iio_register(struct device *dev, struct gadc_the=
rmal_info *gti)
> > > > > +{
> > > > > +       struct gadc_thermal_info *gtinfo;
> > > > > +       struct iio_dev *indio_dev;
> > > > > +
> > > > > +       indio_dev =3D devm_iio_device_alloc(dev, sizeof(struct ga=
dc_thermal_info));
> > > > > +       if (!indio_dev)
> > > > > +               return -ENOMEM;
> > > > > +
> > > > > +       gtinfo =3D iio_priv(indio_dev);
> > > > > +       memcpy(gtinfo, gti, sizeof(struct gadc_thermal_info));
> > >
> > > sizeof(*gtinfo) probably slightly better.
> > >
> > > > > +
> > > > > +       indio_dev->name =3D dev_name(dev);
> > >
> > > What does this end up as?  The convention in IIO is to name after
> > > a part number.  If you have duplicates this isn't how you tell them
> > > apart.  So I'd kind of expect thermal-generic-temp or
> > > something like that.
> > >
> >
> > it is "generic-adc-thermal" with this name, it is not present anywhere =
in IIO.
> >

Then this is acceptable?

> > > > > +       indio_dev->info =3D &gadc_thermal_iio_info;
> > > > > +       indio_dev->modes =3D INDIO_DIRECT_MODE;
> > > > > +       indio_dev->channels =3D gadc_thermal_iio_channel;
> > > As above, I'd stop that being an array and use
> > >         indio_dev->channels =3D &gadc_thermal_iio_chanel;
> > >         indio_dev->channels =3D 1;
> > >
> > > Unless you think maybe we will get more channels in future, in which =
case
> > > just rename it channels (which happens to have one element this time)
> > >
> > > > > +       indio_dev->num_channels =3D ARRAY_SIZE(gadc_thermal_iio_c=
hannel);
> > > > > +
> > > > > +       return devm_iio_device_register(dev, indio_dev);
> > > > > +}
> > > > > +
> > > > >  static int gadc_thermal_read_linear_lookup_table(struct device *=
dev,
> > > > >                                                  struct gadc_ther=
mal_info *gti)
> > > > >  {
> > > > > @@ -153,7 +213,7 @@ static int gadc_thermal_probe(struct platform=
_device *pdev)
> > > > >
> > > > >         devm_thermal_add_hwmon_sysfs(dev, gti->tz_dev);
> > > > >
> > > > > -       return 0;
> > > > > +       return gadc_iio_register(&pdev->dev, gti);
> > > > >  }
> > > > >
> > > > >  static const struct of_device_id of_adc_thermal_match[] =3D {
> > > > > --
> > > > > 2.43.0
> > > > >
> > > >
> > > > Added Jonathan Cameron and linux-iio@vger.kernel.org to list.
> > > >
> > > > Jonathan, this is newer version of the thermal-generic-adc you have
> > > > reviewed recently with channels adjusted like proposed in v3.
> > >
>

