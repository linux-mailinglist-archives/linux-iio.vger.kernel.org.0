Return-Path: <linux-iio+bounces-23394-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B7CB3C288
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 20:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7288C3B4546
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 18:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF5B314A9E;
	Fri, 29 Aug 2025 18:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+ebCSYq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250B015E5D4;
	Fri, 29 Aug 2025 18:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756492607; cv=none; b=MwB3tCRf2I62DsaOxewyuEtRS2KSS14i2pc9e/7TFJqQKzoT0tzFWJJjHUvK/UxeR7w2Nn4sCYXTGZAsVU50ZD6jiFMwvQz65EuzT6JcMwEKo5F5CnlAesGrl+PMarmHHoc+u9Gp9MQd2H/shRT640GMHavFPpfosaHpUTH/8fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756492607; c=relaxed/simple;
	bh=5SEZLB5P5tAtJYSFJdqN01R6qaz2spv5H0JSXrIukVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XOalo7BEptL6MxTkOFPKRbMjXKldzHKvKv7xmPEF2OwByudCaf0TGcYUMXAU6s3piAYswDUhVppmg2NAlsmbrPDVmuf3xFlvmQbJJkPpxSf4jjWPJ9OLHgOyozsaGXZN2aYPksDJdUx1/uF18h6Pa3nNuV8jtsY6oL+Wa9A6QUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l+ebCSYq; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-afcb7a16441so360460266b.2;
        Fri, 29 Aug 2025 11:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756492603; x=1757097403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h9H602sjBeOEb7jNXYDroFmxkNYxH9PUbkSHvi5DgQU=;
        b=l+ebCSYqP7sj4LetXJX/jRtgnooUT11BLdT8OVjsZFkeTcxQ3CvwnGqNctMyIcNiYm
         g33pLy4om/wWRlnGjOV6WkqgSEkz0EzJXI0Nszu/ZBPX6wkpPIwFW4QiURHtXfM0oX2c
         O2qsCOHsuzV91Zrozq+p6lP8Wk3nTqqaR+lIl1y0n6a49y9Wz3K4TcFdirdvvdJcbCtG
         0pYJyMuVVweHFCXVWlRKNHRh3QGKrhSrzq6TAz4WDrBuH1X6r+k8Cq+Dlz6qaYBRRx/r
         rfGXqP0qz7iDNupa7BP7jveJFoyQv8G/zs1C3ULP78hX8joPEN9zTcRl89JIB10ZCpTx
         u1Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756492603; x=1757097403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h9H602sjBeOEb7jNXYDroFmxkNYxH9PUbkSHvi5DgQU=;
        b=RCS5VwhzZd7HbD+Fsu38MZKILTkvht+AG7zjlfqqq25hJPzRvSSmtSMmIm4Gdp8WQW
         CTS2I4Y4290X3LnuQ100UxuCWyfi3M1+Oz65ekJED9qJVHrO6VVTujlLdLKWCUR0E3XD
         1chPXcqLQJlioabDoYhX5WBoXYAuVCL3U6hl4KuDKCbFBkkxCMmEw8zQO1W3BaXqZnAz
         UEF4VBNCbHhB3OaB51p502d0HjLAi1FHysyCqRGnt+UgOBnMgafSkSH6HBYutfIltwhR
         wJ1JP8hEtzgUhWUzXWPkSOp1u12akIAq3FZu/EB6vPF+C3drzQJ9c1j9IFCxT5jknNyS
         x7MQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHfY+mf7+QjEj1txmWPeYbXQmcZINrQg4avE984MbonKWMPzelaxCwyXsk8gZpDkxnTvy4KZqhO4W2@vger.kernel.org, AJvYcCWCjpTq4uIwujOlP3rSj2Zbsuc91Ft+Iaw1Jfclz/wN4mHnIH693iGKtlDqX7fccQvjeFm5j/DV4t8ZVfrm@vger.kernel.org, AJvYcCWIqPl+/Y1eKF5qWAv3UteNWPW6hkHkD9r+Rw4IgA4P3Q82BbWUfbHBcO7lbdjM7KD08rz98+wXNE1E@vger.kernel.org
X-Gm-Message-State: AOJu0YxajV5eRQznx2FIDfacu2hsZOc7q7Pbw4wAptsbnkRbtAAaGJkN
	cSCExFobXKTr3m5nALkUOP7YweBrPItrwvn4L7tMxRSRn2VTNe/jRvOAolWVZkyPdaA2U1RVPzE
	8tiqNM5wqF9KeztmWiQ6068cOuCapfJ4=
X-Gm-Gg: ASbGncu0Z9AWvrWDKyWAMoMK6gkC+ckJIMbohulATauJ3iNTMbWln3n26skpLuKWD1i
	Jly7BZ72c+7sZ1dJVT6v3pf0kPKfgRKKc/kog3lkIcXZZ2vavm24wVy1MWmniWSNusUlGNFcXio
	w7z1LMYoDQOpMC8vTAZWWa9fJjoQCcqBU1vIFzRrh7Oe0OrVWklOK8jKp/AMrjk8MJVXhreOExN
	RbcLU0cmG3aLZPHQA==
X-Google-Smtp-Source: AGHT+IEZDUxIUCP3/+5xY+/z+Ba4/VI8zYWQojd+Pgi5Hhf5t8yekcvjzqyswMF+bxZUm19uZ7DLYComDZ+1wxvSInk=
X-Received: by 2002:a17:907:3ccc:b0:afe:f651:118e with SMTP id
 a640c23a62f3a-afef6511206mr517745866b.49.1756492603178; Fri, 29 Aug 2025
 11:36:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829143447.18893-1-victor.duicu@microchip.com> <20250829143447.18893-3-victor.duicu@microchip.com>
In-Reply-To: <20250829143447.18893-3-victor.duicu@microchip.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 29 Aug 2025 21:36:05 +0300
X-Gm-Features: Ac12FXx97Wy5aAQBQOH5ryhw9e9JOGQXI-jB-j4EUwlJIbUC9iIQoid7ozNC1vs
Message-ID: <CAHp75Vct9BMqFcCjpjgkKr+vNOi5uFsi0FST-Hz5EzqA8UJueQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] iio: temperature: add support for MCP998X
To: victor.duicu@microchip.com
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	marius.cristea@microchip.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 5:35=E2=80=AFPM <victor.duicu@microchip.com> wrote:
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

This file is orphaned in accordance with checkpatch, that's why we
usually add MAINTAINERS entry with the first file added to the tree,
i.e. DT bindings in this case.

> +F:     drivers/iio/temperature/mcp9982.c

> +config MCP9982
> +       tristate "Microchip Technology MCP9982 driver"
> +       depends on I2C
> +       help
> +         Say yes here to build support for Microchip Technology's MCP998=
X/33
> +         and MCP998XD/33D Multichannel Automotive Temperature Monitor Fa=
mily.
> +
> +         This driver can also be built as a module. If so, the module
> +         will be called mcp9982.

...

> +#include <linux/array_size.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/delay.h>
> +#include <linux/device/devres.h>
> +#include <linux/dev_printk.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/iio.h>
> +#include <linux/math64.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/string.h>
> +#include <linux/units.h>

...

> +#define MCP9982_INTERNAL_HIGH_LIMIT_ADDR       0x0B
> +#define MCP9982_INTERNAL_LOW_LIMIT_ADDR                0x0C

For this and other similar registers, can't we use __be16 and read
properly these data?

...

> +#define MCP9982_CHAN(index, si, __address) ({                           =
               \
> +       struct iio_chan_spec __chan =3D {                                =
                 \
> +               .type =3D IIO_TEMP,                                      =
                 \
> +               .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),          =
                 \
> +               .info_mask_shared_by_all_available =3D BIT(IIO_CHAN_INFO_=
SAMP_FREQ) |     \
> +               BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),        =
               \
> +               .info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_SAMP_FREQ)=
 |               \
> +               BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) |       =
               \
> +               BIT(IIO_CHAN_INFO_HYSTERESIS) |                          =
               \
> +               BIT(IIO_CHAN_INFO_OFFSET) |                              =
               \
> +               BIT(IIO_CHAN_INFO_SCALE),                                =
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

Instead of a GCC expression, please use compound literal. It will make
it shorter and neater.

...

> +struct mcp9982_features {
> +       const char      *name;
> +       u8              phys_channels;
> +       bool            hw_thermal_shutdown;
> +       bool            allow_apdd;
> +};
> +
> +static const struct mcp9982_features mcp9933_chip_config =3D {
> +       .name =3D "mcp9933",
> +       .phys_channels =3D 3,

> +       .hw_thermal_shutdown =3D 0,
> +       .allow_apdd =3D 1,

AFAICS they are booleans, please avoid unneeded type conversions.
Same for all other assignments of these fields.

> +};

...

> +/* (Sampling_Frequency(Hz) * 1000000) / (Window_Size * 2) */
> +static unsigned int mcp9982_calc_all_3db_values(void)
> +{
> +       u32 denominator, remainder;
> +       unsigned int i, j;
> +       u64 numerator;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(mcp9982_window_size); i++) {
> +               for (j =3D 0; j <  ARRAY_SIZE(mcp9982_sampl_fr); j++) {

> +                       numerator =3D MICRO * mcp9982_sampl_fr[j].integer=
;

The comment above doesn't really explain this MICRO part. Please,
elaborate more on it.

> +                       denominator =3D 2 * mcp9982_window_size[i] *
> +                                     mcp9982_sampl_fr[j].fract;
> +                       remainder =3D do_div(numerator, denominator);
> +                       remainder =3D do_div(numerator, MICRO);
> +                       mcp9982_3db_values_map_tbl[j][i][0] =3D numerator=
;
> +                       mcp9982_3db_values_map_tbl[j][i][1] =3D remainder=
;
> +               }
> +       }
> +       return 0;
> +}

...

> +struct mcp9982_priv {
> +       struct regmap *regmap;
> +       const struct mcp9982_features *chip;
> +       /*
> +        * Synchronize access to private members, and ensure atomicity of
> +        * consecutive regmap operations.
> +        */

This comment doesn't make clear where the private members are.

> +       struct mutex lock;
> +       struct iio_chan_spec *iio_chan;
> +       const char *labels[MCP9982_MAX_NUM_CHANNELS];
> +       unsigned int ideality_value[4];
> +       unsigned int sampl_idx;
> +       unsigned long  time_limit;
> +       bool recd34_enable;
> +       bool recd12_enable;
> +       bool apdd_enable;
> +       bool run_state;
> +       bool wait_before_read;

Taking into account the above and thinking of what those members, the
booleans might be converted to bit-flags to occupy less space (makes
sense only if 3+ booleans can be combined.

> +       u8 num_channels;
> +};
> +
> +static int mcp9982_read_avail(struct iio_dev *indio_dev,
> +                             struct iio_chan_spec const *chan, const int=
 **vals,
> +                             int *type, int *length, long mask)
> +{
> +       struct mcp9982_priv *priv =3D iio_priv(indio_dev);
> +       unsigned int idx =3D 0;
> +       unsigned int sub =3D 0;

Instead of these assignments, make them an 'else' branch. This will be
compact in one place and make code more robust against some subtle
changes.

> +       if (priv->chip->hw_thermal_shutdown) {
> +               idx =3D 4;
> +               sub =3D 8;
> +       }
> +       switch (mask) {
> +       case IIO_CHAN_INFO_SAMP_FREQ:
> +               *type =3D IIO_VAL_INT_PLUS_MICRO;
> +               *vals =3D mcp9982_conv_rate[idx];
> +               *length =3D ARRAY_SIZE(mcp9982_conv_rate) * 2 - sub;
> +               return IIO_AVAIL_LIST;
> +       case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +               *type =3D IIO_VAL_INT_PLUS_MICRO;
> +               *vals =3D mcp9982_3db_values_map_tbl[priv->sampl_idx][0];
> +               *length =3D ARRAY_SIZE(mcp9982_3db_values_map_tbl[priv->s=
ampl_idx]) * 2;
> +               return IIO_AVAIL_LIST;
> +       default:
> +               return -EINVAL;
> +       }
> +}

...

> +       if (!priv->run_state) {

Make it positive conditional, it's slightly easier to read.

> +               ret =3D regmap_write(priv->regmap, MCP9982_ONE_SHOT_ADDR,=
 1);
> +               if (ret)
> +                       return ret;
> +               /*
> +                * This delay waits for system start-up, as specified by
> +                * time to first conversion from standby

Missing period.

> +                */
> +               mdelay(125);

The comment poorly explains why we need so long _atomic_ (!) delay.
This needs to be _very well_ justified.

> +               ret =3D regmap_read_poll_timeout(priv->regmap, MCP9982_ST=
ATUS_ADDR,
> +                                              reg_status,
> +                                              !(reg_status & MCP9982_STA=
TUS_BUSY),
> +                                              mcp9982_delay_ms[priv->sam=
pl_idx] * 1000,

USEC_PER_MSEC

> +                                              1000 * mcp9982_delay_ms[pr=
iv->sampl_idx] * 1000);

USEC_PER_MSEC and MSEC_PER_SEC

> +               if (ret)
> +                       return ret;
> +       } else {
> +               /*
> +                * When working in Run mode, after modifying a parameter =
(like sampling
> +                * frequency) we have to wait a delay before reading the =
new values.
> +                * We can't determine when the conversion is done based o=
n BUSY bit.

the BUSY

> +                */
> +               if (priv->wait_before_read) {
> +                       if (!time_after(jiffies, priv->time_limit))
> +                               mdelay(jiffies_to_msecs(priv->time_limit =
- jiffies));

Ditto.

> +                       priv->wait_before_read =3D false;
> +               }
> +       }

...

> +static int mcp9982_read_label(struct iio_dev *indio_dev,
> +                             struct iio_chan_spec const *chan, char *lab=
el)
> +{
> +       struct mcp9982_priv *priv =3D iio_priv(indio_dev);
> +
> +       if (chan->channel < 0 || chan->channel > 4)

Is the channel signed?

> +               return -EINVAL;
> +
> +       return sysfs_emit(label, "%s\n", priv->labels[chan->channel]);
> +}

...

> +               /*
> +                * in Run mode, when changing the frequency, wait a delay=
 based
> +                * on the previous value to ensure the new value becomes =
active
> +                */

Respect English grammar and punctuation.

...

> +       case IIO_CHAN_INFO_HYSTERESIS:
> +               if (val < 0 || val > 255)

Do you want to check if it's U8_MAX? Or are these HW related values?

> +                       return -EINVAL;
> +
> +               ret =3D regmap_write(priv->regmap, MCP9982_HYS_ADDR, val)=
;
> +               if (ret)
> +                       return ret;
> +               break;

...

> +       /*
> +        * Chips with "D" work in Run state and those without work
> +        * in Standby state
> +        */

Missing period. Just fix all multi-line comments to be the same style,
i.e. with proper English grammar and punctuation.

> +       if (priv->chip->hw_thermal_shutdown)
> +               priv->run_state =3D 1;
> +       else
> +               priv->run_state =3D 0;

  ->hw_thermal_shutdown =3D ->run_state;

No condition needed.

...

> +       /* Set auto-detection beta compensation for channels 1 and 2 */

Why only these channels? Comment needs elaboration.

> +       for (i =3D 0; i < 2; i++) {
> +               ret =3D regmap_write(priv->regmap, MCP9982_EXT_BETA_CFG_A=
DDR(i),
> +                                  MCP9982_BETA_AUTODETECT);
> +               if (ret)
> +                       return ret;
> +       }

...

> +static int mcp9982_parse_of_config(struct iio_dev *indio_dev, struct dev=
ice *dev,

Replace _of part by _fw as this is agnostic.

> +                                  int device_nr_channels)

...

> +       device_for_each_child_node_scoped(dev, child) {
> +               fwnode_property_read_u32(child, "reg", &reg_nr);

I don't see where you assign the default value for reg_nr. And better
to check the return value here as it seems to be mandatory property.

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
> +                               return dev_err_probe(dev, -EOVERFLOW,
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

...

> +       chip =3D i2c_get_match_data(client);
> +       if (!chip)
> +               return -EINVAL;
> +       priv->chip =3D chip;

You can use priv->chip directly, no local variable is needed, But OTOH
this makes code shorter.

...

> +       ret =3D mcp9982_parse_of_config(indio_dev, &client->dev, chip->ph=
ys_channels);

You have dev, use it.

> +       if (ret)
> +               return dev_err_probe(dev, ret, "Parameter parsing error\n=
");


--
With Best Regards,
Andy Shevchenko

