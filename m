Return-Path: <linux-iio+bounces-18370-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 415B1A947F3
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 15:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4941C3A8252
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 13:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE7B1E9B03;
	Sun, 20 Apr 2025 13:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6CxSEE9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6470729D0E;
	Sun, 20 Apr 2025 13:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745154261; cv=none; b=j2jU5bCEhXRL1y7R3WfwPzungVlLD1MGC7Y6gcgvxWM5GORG1pDBn/1jxTyCyM80muHAv48eJohFG6gX69+Qh7ejTdnx9jfyx0NV+I6y4dTotI2kOf/Ay/8vULFvbBkrA8Iyw/9yuD84fHnU92LTbcXmDa58PX8zwXW7uPNi3SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745154261; c=relaxed/simple;
	bh=fPE9aFBY6YCla2BwooRyzGrQgoOewSFyKnemyUBnK78=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XAjYueky5nX+8wQ9mI/tqsYws6fq7aTnykVNNCjoScEfYpubl7mDJl3RlhnhD4ZO6hzB9BsqjKqM86t6x2hSTtx10gOMRFuXeib2dmvqPYMMY1sJF+nExDz3pMnjHM7GyhdrscNvpnorKazamXYE6r/Tj6clONjUJiGkNXeFeiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W6CxSEE9; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e8be1bdb7bso4902632a12.0;
        Sun, 20 Apr 2025 06:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745154254; x=1745759054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VLC0Xb7rcYfUnW4E07RKJLrh3ftNRi2mYiFFHP/PP2w=;
        b=W6CxSEE9Ri6wOQx9nnUPVYAKdIi6AsHJDJTuVLBPbK6GhmY8Vm8XpB7KtuxtXpYVUS
         oG1t/0/7NVN4wbp8pIjMO8QgqJkhMeOVj8qNXLh+4Gd3a2YwJU5FncJExbyGLYLU+Cyg
         hwRYndZTpnDQfSSv278BDVZjpunQ60DHLG4hVUYZ1YJB/4R0anu6sqy9upUFURuFfDBk
         3DI9Myrg4AOwBi/gqho41ilu19zHrJ05lP2cxD8R2QU465H2zWSN9rKnm4I/h9jwqVJn
         nTdDRmrUbBGMU9Fcl40PZN/GyAMpzYlCSEe15Dyw0GzEfwXnP9kEvSHJghCvXHjC9oeb
         rgTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745154254; x=1745759054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VLC0Xb7rcYfUnW4E07RKJLrh3ftNRi2mYiFFHP/PP2w=;
        b=vCTL033podF1Z2TVAAimT7dLeBEb74vrXYQmPq8bA41Jw+db7HDFGT72XlboAU1jWa
         aICBv/9F1B6LNN7a56lJIRjoc34YrfpM298zekGcC+by2NBL+4yO38Uoz12o6zvWGrKJ
         wPrq4B2SE85IPXI0GWFYm7TmNTxf2OYMiqJTA865I3J6OeUwP9KLwOsOKFDnQy8HB6BS
         9qUP0nQ83lrXQbDcmJ668Ns7FYyx+AjNHDbacWYM+q3wjo+mr7BqrEKk4DKfeYVvStmH
         GKWewtmHPGmapV525EBmO9AokE31o6cfDMUl7y6qKJl3wDstIj/YnDb+XtIBjTuwgCcB
         5M0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUbt6NW0HoGqii1xD39ETEjJj0pGmcD+59Gi+Pp2EQg54ugfSNtvb3IDjEnK37VVwfgSMgbRBbGjUmUiz8X@vger.kernel.org, AJvYcCUeqEnYfmV6/H+83uFtQ9Emz5EnNfIonTEp5XxbFxeH/JRUHnycpnldqIHUqmirRnPTyQsIk2NthP2i@vger.kernel.org, AJvYcCWZPxse1x7MXQGwQXi4SH62tlTpZYlMP7Z6plH5GI/joKgHIZScLs62+Tc4kdna+yOXs6S5m/9TAaf/@vger.kernel.org
X-Gm-Message-State: AOJu0YxiuTvZvQYF5BiyOfhtExlAJaxBl9mOgNgrHs0LCfxM9ZGOMCCi
	tk0X4/bUIf8ldC7MkmLR5kHm3jBBYx8Wvk2cPn5PcieJ0waBhll0MHrKSn8oMymOrgvvoS/KVKg
	Stp1HLAOo2TsQncimzU5n7v3kz3g=
X-Gm-Gg: ASbGncv8HdM8g9TQL/jHQ/o16o6Meto4PfGRpuuw8dTVmPpCtSQms6HXBKCtuigtWkE
	m+hbrv+sviBH8FlYNTRoac5MkHtE6mqvoRuzZAq96GzjGiE7tC2luIGFilHj2agZW1dYd42h3Ds
	0GCynmh1T3MB4C/h2162U=
X-Google-Smtp-Source: AGHT+IHyvZvJuDnKKWgBJ5MWwXbxCdMsNlym6R9z/WaA3ofJOIx1BSjevlczhACPp8AdkaBWlzgqsEsdRIkDgjzroJw=
X-Received: by 2002:a17:907:868f:b0:acb:5adb:bd37 with SMTP id
 a640c23a62f3a-acb74b3af74mr771611966b.23.1745154254297; Sun, 20 Apr 2025
 06:04:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416081734.563111-1-j2anfernee@gmail.com> <20250416081734.563111-3-j2anfernee@gmail.com>
 <Z_95naiV7zpLokPr@smile.fi.intel.com>
In-Reply-To: <Z_95naiV7zpLokPr@smile.fi.intel.com>
From: Yu-Hsian Yang <j2anfernee@gmail.com>
Date: Sun, 20 Apr 2025 21:03:05 +0800
X-Gm-Features: ATxdqUH_04TzQWMnyralP5DQz5ksTbOJ4YLihDEExFl-M6MThzam-CCE9bW2JXo
Message-ID: <CA+4VgcKfDo2NSeBA6+z5AqCeEBds0-DwC0-e3H-bkJ7hEcHaWw@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] iio: adc: add support for Nuvoton NCT7201
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	javier.carrasco.cruz@gmail.com, gstols@baylibre.com, alisadariana@gmail.com, 
	tgamblin@baylibre.com, olivier.moysan@foss.st.com, antoniu.miclaus@analog.com, 
	eblanc@baylibre.com, joao.goncalves@toradex.com, tobias.sperling@softing.com, 
	marcelo.schmitt@analog.com, angelogioacchino.delregno@collabora.com, 
	thomas.bonnefille@bootlin.com, herve.codina@bootlin.com, 
	chanh@os.amperecomputing.com, KWLIU@nuvoton.com, yhyang2@nuvoton.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Andy,

Thanks for the review and the comments.
Will fix all, have a few questions (below)

Andy Shevchenko <andriy.shevchenko@linux.intel.com> =E6=96=BC 2025=E5=B9=B4=
4=E6=9C=8816=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=885:34=E5=AF=AB=E9=
=81=93=EF=BC=9A
>
> On Wed, Apr 16, 2025 at 04:17:34PM +0800, Eason Yang wrote:
> > Add Nuvoton NCT7201/NCT7202 system voltage monitor 12-bit ADC driver
> >
> > NCT7201/NCT7202 supports up to 12 analog voltage monitor inputs and up
> > to 4 SMBus addresses by ADDR pin. Meanwhile, ALERT# hardware event pins
> > for independent alarm signals, and all the threshold values could be se=
t
> > for system protection without any timing delay. It also supports reset
> > input RSTIN# to recover system from a fault condition.
> >
> > Currently, only single-edge mode conversion and threshold events are
> > supported.
>
> ...
>
> > +#define NCT7201_REG_VIN(i)                           (i)
>
> This doesn't do anything useful. Why do you need this rather useless macr=
o?
>

Actually here we should define NCT7201_REG_VIN(i) as (0x00 + i),
We simply it as (i).


> ...
>
> > +struct nct7201_chip_info {
> > +     struct device *dev;
>
> This can be derived from the respective regmap. No need to have it here.
>
> > +     struct regmap *regmap;
> > +     struct regmap *regmap16;
> > +     int num_vin_channels;
> > +     u16 vin_mask;
> > +};
>

Use regmap->dev is okay if use regmap API.
But if we need to print message not from regmap API,
how suggestions to do in this case?

The code is in nct7201_init_chip(struct nct7201_chip_info *chip)
...
> > +     err =3D regmap_read(chip->regmap, NCT7201_REG_BUSY_STATUS, &value=
);
> > +     if (err)
> > +             return dev_err_probe(dev, err, "Failed to read busy statu=
s\n");
> > +     if (!(value & NCT7201_BIT_PWR_UP))
> > +             return dev_err_probe(dev, -EIO, "Failed to power up after=
 reset\n");


> ...
>
> > +struct nct7201_adc_model_data {
> > +     const char *model_name;
> > +     const struct iio_chan_spec *channels;
>
> > +     const int num_channels;
>
> What is the meaning of const here?
>

We don't need const int , just int.

> > +     int num_vin_channels;
> > +};
>
> ...
>
> > +#define NCT7201_VOLTAGE_CHANNEL(num)                                 \
> > +     {                                                               \
> > +             .type =3D IIO_VOLTAGE,                                   =
 \
> > +             .indexed =3D 1,                                          =
 \
> > +             .channel =3D (num + 1),                                  =
 \
>
> Parentheses are in a wrong place
>
We remove parentheses.

> > +             .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),          =
 \
> > +             .info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE),  =
 \
> > +             .address =3D num,                                        =
 \
> > +             .event_spec =3D nct7201_events,                          =
 \
> > +             .num_event_specs =3D ARRAY_SIZE(nct7201_events),         =
 \
> > +     }
>
> ...
>
> > +static int nct7201_write_event_config(struct iio_dev *indio_dev,
> > +                                   const struct iio_chan_spec *chan,
> > +                                   enum iio_event_type type,
> > +                                   enum iio_event_direction dir,
> > +                                   bool state)
> > +{
> > +     struct nct7201_chip_info *chip =3D iio_priv(indio_dev);
> > +     unsigned int mask;
> > +     int err;
> > +
> > +     if (chan->type !=3D IIO_VOLTAGE)
> > +             return -EOPNOTSUPP;
>
> > +     mask =3D BIT(chan->address);
>
> Just join this with the definition above.
>
>

okay

> > +     if (state)
> > +             chip->vin_mask |=3D mask;
> > +     else
> > +             chip->vin_mask &=3D ~mask;
> > +
> > +     if (chip->num_vin_channels <=3D 8)
> > +             err =3D regmap_write(chip->regmap, NCT7201_REG_CHANNEL_EN=
ABLE_1,
>
> Remove _1.
>
> > +                                chip->vin_mask);
> > +     else
> > +             err =3D regmap_bulk_write(chip->regmap, NCT7201_REG_CHANN=
EL_ENABLE_1,
> > +                                     &chip->vin_mask, sizeof(chip->vin=
_mask));
>
> > +     if (err)
> > +             return err;
> > +
> > +     return 0;
>
> As simple as
>
>         return err;
>
> > +}
>
> ...
>
> > +static int nct7201_init_chip(struct nct7201_chip_info *chip)
> > +{
> > +     struct device *dev =3D chip->dev;
>
> Derive this from chip->regmap.
>
> > +     __le16 data =3D cpu_to_le16(NCT7201_REG_CHANNEL_ENABLE_MASK);
> > +     unsigned int value;
> > +     int err;
> > +
> > +     err =3D regmap_write(chip->regmap, NCT7201_REG_CONFIGURATION,
> > +                        NCT7201_BIT_CONFIGURATION_RESET);
> > +     if (err)
> > +             return dev_err_probe(dev, err, "Failed to reset chip\n");
> > +
> > +     /*
> > +      * After about 25 msecs, the device should be ready and then the =
Power
> > +      * Up bit will be set to 1. If not, wait for it.
>
> "Up bit" is odd, please be more specific.
>
> > +      */
> > +     fsleep(25000);
>
> + Blank line.
>
> > +     err =3D regmap_read(chip->regmap, NCT7201_REG_BUSY_STATUS, &value=
);
> > +     if (err)
> > +             return dev_err_probe(dev, err, "Failed to read busy statu=
s\n");
> > +     if (!(value & NCT7201_BIT_PWR_UP))
> > +             return dev_err_probe(dev, -EIO, "Failed to power up after=
 reset\n");
> > +
> > +     /* Enable Channel */
> > +     if (chip->num_vin_channels <=3D 8)
> > +             err =3D regmap_write(chip->regmap, NCT7201_REG_CHANNEL_EN=
ABLE_1,
> > +                                NCT7201_REG_CHANNEL_ENABLE_MASK);
> > +     else
> > +             err =3D regmap_bulk_write(chip->regmap, NCT7201_REG_CHANN=
EL_ENABLE_1,
> > +                                     &data, sizeof(data));
> > +     if (err)
> > +             return dev_err_probe(dev, err, "Failed to enable channel\=
n");
> > +
> > +     err =3D regmap_bulk_read(chip->regmap, NCT7201_REG_CHANNEL_ENABLE=
_1,
> > +                            &chip->vin_mask, sizeof(chip->vin_mask));
> > +     if (err)
> > +             return dev_err_probe(dev, err,
> > +                                  "Failed to read channel enable regis=
ter\n");
> > +
> > +     /* Start monitoring if needed */
> > +     err =3D regmap_set_bits(chip->regmap, NCT7201_REG_CONFIGURATION,
> > +                           NCT7201_BIT_CONFIGURATION_START);
> > +     if (err)
> > +             return dev_err_probe(dev, err, "Failed to start monitorin=
g\n");
> > +
> > +     return 0;
> > +}
>
> ...
>
> > +     ret =3D nct7201_init_chip(chip);
> > +     if (ret < 0)
>
> Why ' < 0' ?
>
> > +             return ret;
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

