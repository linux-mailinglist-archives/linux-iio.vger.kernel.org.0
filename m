Return-Path: <linux-iio+bounces-20615-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56564AD97AC
	for <lists+linux-iio@lfdr.de>; Fri, 13 Jun 2025 23:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 067F44A0961
	for <lists+linux-iio@lfdr.de>; Fri, 13 Jun 2025 21:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD22428DB7A;
	Fri, 13 Jun 2025 21:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PlWus/VD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A493028D8CB;
	Fri, 13 Jun 2025 21:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749851449; cv=none; b=BU+PcEEE8NFa3xFbW5QlGNAg9X6SjuXwDTitF1ZBA2oTo5y5/2Ou6PJ1yO0fX+O+dM32PuimabsZ6lyoSCr4zhz1MAbEGmQZdeX/4H7G60vzDxom6PbcO4+b9w0rnWcUbt8fT1uFVENL9nSV0IuNRQZDlOKNRsSGketATD+LTRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749851449; c=relaxed/simple;
	bh=K9mWd8/q0ggZXcfzgfYXQVxI41zMW5x2lyNUhnOWHtU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ft1A7c4lJps8ovsSJUFjwFYIgokPQoG3VDP/H9edLVIA0S9x2kjaI1CHO/52hFCZ40pUAqDBhkHBhayhEV0e1UVPMDiA09TyoPNxOn0vpgtDid7ATjQmEm9drv31aa7avIRslk5vah6IpQKr2PtYqd3CbqwWHh9bz5kFBXNSKTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PlWus/VD; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ad56cbc7b07so377060066b.0;
        Fri, 13 Jun 2025 14:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749851446; x=1750456246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uOSL9TLbxc7EnOxObPg+BQQrO/iL+ytpD3IpW1ikCIg=;
        b=PlWus/VDCqz2RB5QIeTR3gGTbDWCExQj1gnl/TUyjaYOCSObjfDvI8K+47+3os5hDr
         tAwRDca1JmIb8Cj8W4S/lU5YRgwnCCB5NCVcLTTuE+PNuMC9gUPuSL9mcnl4b+bhgbdt
         J35CYbyCDoUg1/AO/ZO8GtQWgtGWruBprdXQ3+VPb2KsEFr3MVkd5HpVkBPHDgWh20oc
         wy9PFIll8kYl/KPGxapmZprtthP120ecIQ6ltN7r6JfeVb9WowUs+rqDzLl/gIStGr/E
         IDQe5LffeAAdySS8YjAtRUqoA2vBdbbHOoflamE+SFre8bficzoRIYn02wtuagjqiRE9
         E+Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749851446; x=1750456246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uOSL9TLbxc7EnOxObPg+BQQrO/iL+ytpD3IpW1ikCIg=;
        b=XQ6LjNfAf3BunkvWAjoyuohisa3ILEQOzYEJ3us1ZGU64kdkDdhziMujnZquv0Yrh0
         2hseAE1cYFttSlOa6FYaik+sYe3uuqyuq3AENOv4Er2aDW+yaM9KmlgcWAEszcgDoPDz
         hc/1B2rtrkC9b/ttdAJG4cSBm8aRalD/dNbC+P+72gaar2CrLldoFAQ88WDpRzTP0He3
         HzEPWCT+iv8hh8D9KHuY9F5F7PB4XiWoVjSYLob/vmUNGFCB1WpJ0Z0QL16cL0sgo9bq
         u/cfC9eG19EcNwUijiEVowB4TgMGFDloEIU84LsYhmvzllj5STK31tZROUoG4j+lwQiw
         s9Fg==
X-Forwarded-Encrypted: i=1; AJvYcCUVmuG4J9PfYLRyCEtykTBcsoud+/ua5cgaS0jyBvZsON0gsapSqb9v4aHKstvA191S1ynXoR7syg/5@vger.kernel.org, AJvYcCV9lrT2EIM3LxH513z9ADfPvMaJg0nvxGFHFzAqvMYMGJ0IEb6/zNrO0ct4pULcvMQ5lZokaQS7mACIjwqn@vger.kernel.org, AJvYcCXZ0LejhpNG/g8opVj4PXiVsrtGI1djYVGCcnNad+LLe2Ir4Oua4zkKfxfVKVjgzVNYuX3C9/zAHmSa@vger.kernel.org
X-Gm-Message-State: AOJu0YzJc66NanWRBa1uqvmA/t09tPfiSiTWXQZ69kApwRjIrMmpaFiw
	HfOQnbrf29C+UMBrquENxcKQVwbjDMtITxNPii7H9eBJuy9Toz5OabXAr4O+zYkeEZ4oYps4tAN
	eEFCckPcJMVtwUux2lZSAknY7KHo70cI=
X-Gm-Gg: ASbGncsbXI3SXVg/erwrRd4+FQwlGQgHE2eT3hXvq1ugTL4Ylh9+qZtE65FgQDSppUc
	mgY7qRfBF2PwkJBU/TLfRM3SJDhLa2j5SVzoCcO5ANcnjAyW608Bv6TnqpWEnTar1IarDMR99B0
	aXUgPCJ/+CV1qUVC/Bn9zTBF4qjpdL70H4Jno6RtsVFPM=
X-Google-Smtp-Source: AGHT+IFdoc2pwliRbBEiGkei6cQkFWYSPoWqPcfSOBVwxbPul4hRpbFt6QjgmYfX2Kkqg4TW3/UKTgvZPY6sL22GT+g=
X-Received: by 2002:a17:907:3d86:b0:ad8:9909:20a8 with SMTP id
 a640c23a62f3a-adfad51471dmr60352266b.49.1749851445563; Fri, 13 Jun 2025
 14:50:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250613130207.8560-1-victor.duicu@microchip.com> <20250613130207.8560-3-victor.duicu@microchip.com>
In-Reply-To: <20250613130207.8560-3-victor.duicu@microchip.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 14 Jun 2025 00:50:08 +0300
X-Gm-Features: AX0GCFuLwW4X6YfWz2eu-sth4SQ0jbD_vy-u6lw2TMKhvnViVAOrJ7yzJFL5Gi8
Message-ID: <CAHp75VdRisP+trez2Ysgrhan_zXMWsmawB3XeW+_ePsbNC4RzQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] iio: temperature: add support for MCP998X
To: victor.duicu@microchip.com
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	marius.cristea@microchip.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 4:02=E2=80=AFPM <victor.duicu@microchip.com> wrote:
>
> From: Victor Duicu <victor.duicu@microchip.com>
>
> This is the driver for Microchip MCP998X/33 and MCP998XD/33D
> Multichannel Automotive Temperature Monitor Family.

...

> +MICROCHIP MCP9982 TEMPERATURE DRIVER
> +M:     Victor Duicu <victor.duicu@microchip.com>
> +L:     linux-iio@vger.kernel.org
> +S:     Supported
> +F:     Documentation/devicetree/bindings/iio/temperature/microchip,mcp99=
82.yaml
> +F:     drivers/iio/temperature/mcp9982.c

So, with the first patch only the dangling file will be present
without record in MAINTAINERS. Please, make sure that your DT schema
file is in MAINTAINERS.


> +config MCP9982
> +       tristate "Microchip Technology MCP9982 driver"
> +       depends on I2C

...

> +#include <asm/div64.h>

This needs to be linux/math64.h instead. The rule of thumb: prefer
linux/foo over asm/foo (with some exceptions, that are not the case
here).

...

> +#define MCP9982_INT_VALUE_ADDR(index)          (2 * (index))

Maybe also ' + 0'? But I'm fine with this as well.

> +#define MCP9982_FRAC_VALUE_ADDR(index)         (2 * (index) + 1)

...

> +#define MCP9982_EXT_IDEAL_ADDR(index)          ((index) + 54)

What does 54 mean? What is the magic behind?

...

> +#define MCP9982_CHAN(index, si, __address) ({                           =
               \
> +       struct iio_chan_spec __chan =3D {                                =
                 \

Why not compound literal?

> +               .type =3D IIO_TEMP,                                      =
                 \
> +               .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),          =
                 \
> +               .info_mask_shared_by_all_available =3D BIT(IIO_CHAN_INFO_=
SAMP_FREQ) |     \
> +               BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) |       =
               \
> +               BIT(IIO_CHAN_INFO_OFFSET),                               =
               \
> +               .info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_SAMP_FREQ)=
 |               \
> +               BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) |       =
               \
> +               BIT(IIO_CHAN_INFO_HYSTERESIS) |                          =
               \
> +               BIT(IIO_CHAN_INFO_OFFSET),                               =
               \
> +               .channel =3D index,                                      =
                 \
> +               .address =3D __address,                                  =
                 \
> +               .scan_index =3D si,                                      =
                 \
> +               .scan_type =3D {                                         =
                 \
> +                       .sign =3D 'u',                                   =
                 \
> +                       .realbits =3D 8,                                 =
                 \
> +                       .storagebits =3D 8,                              =
                 \
> +               },                                                       =
               \
> +               .indexed =3D 1,                                          =
                 \
> +       };                                                               =
               \
> +       __chan;                                                          =
               \
> +})

...

> +static const unsigned int mcp9982_window_size[3] =3D {1, 4, 8};

Add surrounding spaces inside {}.

...

> +/*
> + * (Sampling_Frequency * 1000000) / (Window_Size * 2)

This comment needs more elaboration, i.e. units in use for frequency
and perhaps window size.

> + */
> +static unsigned int mcp9982_calc_all_3db_values(void)
> +{
> +       u32 denominator, remainder;
> +       unsigned int i, j;
> +       u64 numerator;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(mcp9982_window_size); i++)
> +               for (j =3D 0; j <  ARRAY_SIZE(mcp9982_sampl_fr); j++) {

Have you considered making mcp9982_sampl_fr to be struct u64_fract?
Also using here on stack something like

  struct u64_fract tmp;

> +                       numerator =3D MICRO * mcp9982_sampl_fr[j][0];
> +                       denominator =3D 2 * mcp9982_window_size[i] * mcp9=
982_sampl_fr[j][1];
> +                       remainder =3D do_div(numerator, denominator);
> +                       remainder =3D do_div(numerator, MICRO);
> +                       mcp9982_3db_values_map_tbl[j][i][0] =3D numerator=
;
> +                       mcp9982_3db_values_map_tbl[j][i][1] =3D remainder=
;

The proposed changes will clarify the meaning of [0] and [1] in such a tabl=
e.

> +               }
> +       return 0;
> +}

...

> +struct mcp9982_priv {
> +       struct regmap *regmap;
> +       u8 num_channels;
> +       bool extended_temp_range;
> +       bool recd34_enable;
> +       bool recd12_enable;
> +       unsigned int beta_values[2];
> +       /*
> +        * Synchronize access to private members, and ensure
> +        * atomicity of consecutive regmap operations.
> +        */
> +       struct mutex lock;
> +       struct iio_chan_spec *iio_chan;
> +       const char *labels[MCP9982_MAX_NUM_CHANNELS];
> +       unsigned int ideality_value[4];
> +       unsigned int sampl_idx;
> +       const char *dev_name;

> +       bool apdd_enable;

Wouldn't it be slightly better to group all booleans (and move u8 here)?

> +};

...

> +               if (strchr(priv->dev_name, 'd')) {
> +                       *vals =3D mcp9982_conv_rate[4];
> +                       *length =3D (ARRAY_SIZE(mcp9982_conv_rate) - 4) *=
 2;
> +               } else {
> +                       *vals =3D mcp9982_conv_rate[0];
> +                       *length =3D ARRAY_SIZE(mcp9982_conv_rate) * 2;
> +               }

So, the length can be multiplied only once here...

...

> +       case IIO_CHAN_INFO_SAMP_FREQ:
> +               *val =3D mcp9982_conv_rate[priv->sampl_idx][0];
> +               *val2 =3D mcp9982_conv_rate[priv->sampl_idx][1];
> +               return IIO_VAL_INT_PLUS_MICRO;
> +       case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:

> +

Why this blank line?

> +               ret =3D regmap_read(priv->regmap, MCP9982_RUNNING_AVG_ADD=
R, &tmp_reg);
> +               if (ret)
> +                       return ret;
> +               /*
> +                * In Filter Selection Register values 1 and 2
> +                * are mapped to the same setting.
> +                */
> +               switch (tmp_reg) {
> +               case 0:
> +                       idx =3D 0;
> +                       break;
> +               case 1:
> +               case 2:
> +                       idx =3D 1;
> +                       break;

Instead of comment this can be regrouped like

case 0:
case 1:
  idx =3D tmp_reg;
  break;
case 2:
  idx =3D 1;
  break;
default:
  ...

> +               default:
> +                       idx =3D 2;
> +                       break;
> +               }
> +
> +               *val =3D mcp9982_3db_values_map_tbl[priv->sampl_idx][idx]=
[0];
> +               *val2 =3D mcp9982_3db_values_map_tbl[priv->sampl_idx][idx=
][1];
> +               return IIO_VAL_INT_PLUS_MICRO;

...

> +static int mcp9982_write_raw(struct iio_dev *indio_dev, struct iio_chan_=
spec const *chan,
> +                            int val, int val2, long mask)
> +{
> +       struct mcp9982_priv *priv =3D iio_priv(indio_dev);
> +       int ret;
> +       unsigned int i;
> +       unsigned int start =3D 0;
> +
> +       guard(mutex)(&priv->lock);
> +       switch (mask) {
> +       case IIO_CHAN_INFO_SAMP_FREQ:
> +               /*
> +                * For MCP998XD and MCP9933D sampling frequency can't
> +                * be set lower than 1.
> +                */

> +               if (strchr(priv->dev_name, 'd'))

Why not simply have this in an additional field of chip_info structure?

> +                       start =3D 4;
> +               for (i =3D start; i < ARRAY_SIZE(mcp9982_conv_rate); i++)
> +                       if (val =3D=3D mcp9982_conv_rate[i][0] && val2 =
=3D=3D mcp9982_conv_rate[i][1])
> +                               break;
> +
> +               if (i =3D=3D ARRAY_SIZE(mcp9982_conv_rate))
> +                       return -EINVAL;
> +
> +               ret =3D regmap_write(priv->regmap, MCP9982_CONV_ADDR, i);
> +               if (ret)
> +                       return ret;
> +
> +               priv->sampl_idx =3D i;
> +               return 0;
> +       case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +               for (i =3D 0; i < ARRAY_SIZE(mcp9982_3db_values_map_tbl[p=
riv->sampl_idx]); i++)
> +                       if (val =3D=3D mcp9982_3db_values_map_tbl[priv->s=
ampl_idx][i][0] &&
> +                           val2 =3D=3D mcp9982_3db_values_map_tbl[priv->=
sampl_idx][i][1])
> +                               break;
> +
> +               if (i =3D=3D ARRAY_SIZE(mcp9982_3db_values_map_tbl[priv->=
sampl_idx]))
> +                       return -EINVAL;
> +
> +               /*
> +                * In mcp9982_3db_values_map_tbl the second index maps:
> +                * 0 for filter off
> +                * 1 for filter at level 1
> +                * 2 for filter at level 2
> +                */
> +               if (i =3D=3D 2)
> +                       i =3D 3;

> +               ret =3D regmap_write(priv->regmap, MCP9982_RUNNING_AVG_AD=
DR, i);
> +
> +               return ret;

Why not

  return regmap_write(...);

?

> +       case IIO_CHAN_INFO_HYSTERESIS:
> +               if (val < 0 || val > 255)
> +                       return -EINVAL;
> +
> +               ret =3D regmap_write(priv->regmap, MCP9982_HYS_ADDR, val)=
;
> +               return ret;

Ditto.

> +       case IIO_CHAN_INFO_OFFSET:
> +               if (val !=3D 0 && val !=3D -64)
> +                       return -EINVAL;
> +               priv->extended_temp_range =3D !(val =3D=3D 0);

> +               ret =3D regmap_assign_bits(priv->regmap, MCP9982_CFG_ADDR=
, MCP9982_CFG_RANGE,
> +                                        priv->extended_temp_range);
> +               return ret;

Ditto.

> +       default:
> +               return -EINVAL;
> +       }
> +}

...

> +static int mcp9982_init(struct mcp9982_priv *priv)
> +{
> +       int ret;
> +       unsigned int i;
> +       u8 val;
> +
> +       /*
> +        * For chips with "D" in the name
> +        * set the below parameters to default to
> +        * ensure that hardware shutdown feature
> +        * can't be overridden.
> +        */
> +       if (strchr(priv->dev_name, 'd')) {
> +               priv->recd12_enable =3D true;
> +               priv->recd34_enable =3D true;

> +               for (i =3D 0; i < 2; i++)
> +                       priv->beta_values[i] =3D 16;

memset32() ?

> +               for (i =3D 0; i < 4; i++)
> +                       priv->ideality_value[i] =3D 18;

Ditto.

> +       }
> +
> +       /*
> +        * Set default values in registers.
> +        * APDD, RECD12 and RECD34 are active on 0.
> +        */
> +       val =3D FIELD_PREP(MCP9982_CFG_MSKAL, 1) | FIELD_PREP(MCP9982_CFG=
_RS, 1) |
> +             FIELD_PREP(MCP9982_CFG_ATTHM, 1) |
> +             FIELD_PREP(MCP9982_CFG_RECD12, !priv->recd12_enable) |
> +             FIELD_PREP(MCP9982_CFG_RECD34, !priv->recd34_enable) |
> +             FIELD_PREP(MCP9982_CFG_RANGE, 0) | FIELD_PREP(MCP9982_CFG_D=
A_ENA, 0) |
> +             FIELD_PREP(MCP9982_CFG_APDD, !priv->apdd_enable);
> +
> +       ret =3D regmap_write(priv->regmap, MCP9982_CFG_ADDR, val);
> +       if (ret)
> +               return ret;
> +       priv->extended_temp_range =3D false;
> +
> +       ret =3D regmap_write(priv->regmap, MCP9982_CONV_ADDR, 6);
> +       if (ret)
> +               return ret;
> +       priv->sampl_idx =3D 6;
> +
> +       ret =3D regmap_write(priv->regmap, MCP9982_HYS_ADDR, 10);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D regmap_write(priv->regmap, MCP9982_CONSEC_ALRT_ADDR, 112)=
;
> +       if (ret)
> +               return ret;
> +
> +       ret =3D regmap_write(priv->regmap, MCP9982_RUNNING_AVG_ADDR, 0);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D regmap_write(priv->regmap, MCP9982_HOTTEST_CFG_ADDR, 0);
> +       if (ret)
> +               return ret;
> +
> +       /* Set beta compensation for channels 1 and 2 */
> +       for (i =3D 0; i < 2; i++) {

ARRAY_SIZE()

> +               ret =3D regmap_write(priv->regmap, MCP9982_EXT_BETA_CFG_A=
DDR(i),
> +                                  priv->beta_values[i]);
> +               if (ret)
> +                       return ret;
> +       }
> +       /* Set ideality factor for all external channels */
> +       for (i =3D 0; i < 4; i++) {

Ditto.

> +               ret =3D regmap_write(priv->regmap, MCP9982_EXT_IDEAL_ADDR=
(i),
> +                                  priv->ideality_value[i]);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return 0;
> +}

...

> +       priv->beta_values[0] =3D 16;
> +       priv->beta_values[1] =3D 16;

memset32() ?

> +       device_property_read_u32(dev, "microchip,beta1", &priv->beta_valu=
es[0]);
> +       device_property_read_u32(dev, "microchip,beta2", &priv->beta_valu=
es[1]);
> +       if (priv->beta_values[0] > 16 || priv->beta_values[1] > 16)
> +               return -EINVAL;

...

> +       if (priv->num_channels > device_nr_channels)
> +               return dev_err_probe(dev, -EINVAL, "More channels than th=
e chip supports\n");

Hmm... Perhaps -E2BIG?

...

> +       priv->labels[0] =3D "internal diode";
> +       iio_idx++;
> +       device_for_each_child_node_scoped(dev, child) {
> +               fwnode_property_read_u32(child, "reg", &reg_nr);
> +               if (!reg_nr || reg_nr >=3D device_nr_channels)
> +                       return dev_err_probe(dev, -EINVAL,
> +                                    "The index of the channels does not =
match the chip\n");
> +
> +               priv->ideality_value[reg_nr - 1] =3D 18;
> +               if (fwnode_property_present(child, "microchip,ideality-fa=
ctor")) {
> +                       fwnode_property_read_u32(child, "microchip,ideali=
ty-factor",
> +                                                &priv->ideality_value[re=
g_nr - 1]);
> +                       if (priv->ideality_value[reg_nr - 1] > 63)
> +                               return dev_err_probe(dev, -EINVAL,

-EOVERFLOW?

> +                                    "The ideality value is higher than m=
aximum\n");
> +               }
> +
> +               fwnode_property_read_string(child, "label",
> +                                           &priv->labels[reg_nr]);
> +
> +               priv->iio_chan[iio_idx++] =3D MCP9982_CHAN(reg_nr, reg_nr=
,
> +                                                        MCP9982_INT_VALU=
E_ADDR(reg_nr));
> +       }

--=20
With Best Regards,
Andy Shevchenko

