Return-Path: <linux-iio+bounces-20016-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3876AC823C
	for <lists+linux-iio@lfdr.de>; Thu, 29 May 2025 20:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E772C1C05925
	for <lists+linux-iio@lfdr.de>; Thu, 29 May 2025 18:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853D4231829;
	Thu, 29 May 2025 18:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kIHbrq1c"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61ACF201100;
	Thu, 29 May 2025 18:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748543836; cv=none; b=e+3uSefopW/q4HcxNfa4XVfiugMs0BKXDo+zC8a5xo0/WXbj9MQWEPndTS0SBTtuNHqdUdFzglTnzKIlQoO18r0tYHVPP3GEii1Uwchz6SLDrqFWrGTLK4/ML6WI8bj+zaNBh2Dh6xk/3HmKeWtSlRqJv4N8+yLExgKEzvQai4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748543836; c=relaxed/simple;
	bh=DeJngLE902S0qbuNPh9r9MgcKXgEivdZMfjB26hYvU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=slyQ7bkU3Xk1A/oZqhgUgwlv8pmx0vQDeaCb3W3pMH4QMaGUdpFf8jA2ZqBVS/jNrHk972AYC+s3UuUMPmUPZ34tHUdml3HFhgdKEwJCaAcjk0XzUw53v7jgIiVXC7KGmvDcPbO29Qv621/wtj2FtJJaUqIy+zdgF5wzke+7Bco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kIHbrq1c; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ad89ee255easo215170966b.3;
        Thu, 29 May 2025 11:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748543833; x=1749148633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZeASMpgBPmJsh0bE3a3rFG1VwhVQpebcZ426lKBjWA=;
        b=kIHbrq1cvVeUstVTP2DlD9wZnnD6DiZyxzBFpG+rROherE+vfRk75YFGpv9gWcf707
         /RqcdMPHN7seIPtTurdroPcn5+e8DPOXEWkKxdx1cNAkCyqKvy35TQblGjlAQTXv9vqG
         ELZwl/zSroz+X5RJzqd9JI8VEJjk21OCHxyheP7q06+gfBrAXG8Xf4O96BzSPARk3lA8
         N7U15JtGl8uBCL+p1qOJqzukRytZxcHmO8PwDWxz9PwcPSXVye2fCqllPB/KpvA0ZYoQ
         mBTQ6OLG4H8h8nbSOI8VsHWOnUCUkO7UPz4FIP/0A3mxSDIYvwCx1RPPZZP6lw8LQcin
         OHLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748543833; x=1749148633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TZeASMpgBPmJsh0bE3a3rFG1VwhVQpebcZ426lKBjWA=;
        b=ZwYP0lKdrItd/J0Fp8l3xHQTjHbGjQWbUoobD04K3IQkNpwy3qvPevNELAy2Dku0TG
         Z4lhRgkYRmgXBQbGDPlbU/y/WjrQ9iPNf4oXGNjksmgnE0umVghgPK1jHxfcrZZOurp1
         TqxQwoyyuec26fr8kXaF8836rEUSsC0gmUMWqrrQ/n6JMTQxBZ9ejjscQfR1wxbCC3x3
         /T9tn1iv7H7AEzLk9BNKuxmyqTA4T8ZtcUL5bVPxx2RrvxbSHhA6dzsVWJjRu5XZwNek
         kZUpVdojmScBpe1zte6YUh5eOrdxkk0eO1s+T+dXllRngidNeRJMv78jafV1CgM20FNQ
         nTyw==
X-Forwarded-Encrypted: i=1; AJvYcCUgkHCc/z372mnGWKxyijAr6lYrxTRe4Fb40LS2083m8ZbfgGaFHgEvSAOT2v2JMMedEUN5sgImDkHb@vger.kernel.org, AJvYcCVApSGgDCUcp4O8AnzNc0094pYK+w+U2ShrTc5ewpQFino6JhMo6mbhJeA9Y2lh+cqTMjZ9bDScHLet@vger.kernel.org, AJvYcCVzY7aQFMte0BUMRCQDC3NAAWKU3onxhXzh3AUS1lQQwzvjytWW6vZ+kEQc4Yo+th0IV306To90snWvo86z@vger.kernel.org
X-Gm-Message-State: AOJu0YxCqO6Gv+08h0p1e+De+H5uU53vY682dw8tSBXTzPyfyPEn4S5i
	nkyLkB7S4chp6ie4PxGu492a+ydiZQDni1aK8XzbSY9Ic1nHZzqzuHP3c0SCscJZPtb6xhytWb/
	BS+L3AnkxZJH/61SCfcjhFjj0Wvk8ys4=
X-Gm-Gg: ASbGncvfkYRHvnyLBszYW0w2l0OpnALoaQ9LKoioKdsW8/dRwA/qeaNxoesY0+7o1xG
	EUeaLa61q9TFG/2bqpQsbDdPbHILn+j3PpwKeo+oLaw0Abv49CSasr7numEj9JfJfStFIxGVcwd
	5tP+yeAl7Ov3XrO/PJGqZhMc0/OzrjgHmzfFcMS2GuhI8=
X-Google-Smtp-Source: AGHT+IHmRGtTp2pg8PbUd97wKQYpNi2bWQLdQuXvY+30IQ6iQDcaiKpgK5G1Qv/GB7L/NtzN+uonAto/7oYcM5C44RY=
X-Received: by 2002:a17:907:6d17:b0:ad8:9041:7706 with SMTP id
 a640c23a62f3a-adb322fafaamr49658766b.56.1748543832213; Thu, 29 May 2025
 11:37:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250529093628.15042-1-victor.duicu@microchip.com> <20250529093628.15042-3-victor.duicu@microchip.com>
In-Reply-To: <20250529093628.15042-3-victor.duicu@microchip.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 29 May 2025 21:36:35 +0300
X-Gm-Features: AX0GCFu5VW-ofF169peGSI_faZ75qXrDOZNH-q9Iuz9GH6V6zQwMW0YHhYJdvQg
Message-ID: <CAHp75VeC8sWRpjKXc1Z1dvpSmCbz15ZB05daiOjdJaGiKGQ6wQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: temperature: add support for MCP998X
To: victor.duicu@microchip.com
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	marius.cristea@microchip.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 29, 2025 at 12:37=E2=80=AFPM <victor.duicu@microchip.com> wrote=
:
>
> This is the driver for Microchip MCP998X/33 and MCP998XD/33D
> Multichannel Automotive Temperature Monitor Family.

...

> +/*
> + * (Sampling_Frequency * 1000000) / (Window_Size * 2)
> + */
> +static int mcp9982_calc_all_3db_values(void)
> +{

> +       int i, j;

Why signed?

> +       u64 numerator;
> +       u32 denominator, remainder;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(mcp9982_window_size); i++)
> +               for (j =3D 0; j <  ARRAY_SIZE(mcp9982_sampl_fr); j++) {

> +                       numerator =3D 1000000 * mcp9982_sampl_fr[j][0];

MICRO ? Ditto for the below case.

> +                       denominator =3D 2 * mcp9982_window_size[i] * mcp9=
982_sampl_fr[j][1];
> +                       numerator =3D div_u64_rem(numerator, denominator,=
 &remainder);

The remainder seems unused here. So, why do you use the div_u64_rem()
and not simply do_div()?

> +                       mcp9982_3db_values_map_tbl[j][i][0] =3D div_u64_r=
em(numerator, 1000000,
> +                                                                        =
 &remainder);
> +                       mcp9982_3db_values_map_tbl[j][i][1] =3D remainder=
;
> +               }
> +       return 0;
> +}

...

> +struct mcp9982_priv {
> +       u8 num_channels;
> +       bool extended_temp_range;
> +       bool beta_autodetect[2];
> +       /*
> +        * Synchronize access to private members, and ensure
> +        * atomicity of consecutive regmap operations.
> +        */
> +       struct mutex lock;

> +       struct regmap *regmap;

Wouldn't moving this to be the first member help with the code
generation (size)?

> +       struct iio_chan_spec *iio_chan;
> +       char *labels[MCP9982_MAX_NUM_CHANNELS];
> +       int ideality_value[4];
> +       int recd34_enable;
> +       int recd12_enable;
> +       int apdd_enable;
> +       int sampl_idx;
> +};

...

> +static int mcp9982_read_raw(struct iio_dev *indio_dev, struct iio_chan_s=
pec const *chan,
> +                           int *val, int *val2, long mask)
> +{
> +       struct mcp9982_priv *priv =3D iio_priv(indio_dev);
> +       int ret, index, index2;

regmap API takes unsigned int, why are these signed? And in general
it's better not to mix the returning variable with something
semantically different.

> +       ret =3D regmap_write(priv->regmap, MCP9982_ONE_SHOT_ADDR, 1);
> +       if (ret)
> +               return ret;
> +
> +       guard(mutex)(&priv->lock);
> +
> +       switch (mask) {
> +       case IIO_CHAN_INFO_RAW:
> +               ret =3D regmap_read(priv->regmap, MCP9982_INT_VALUE_ADDR(=
chan->channel), val);
> +               if (ret)
> +                       return ret;
> +
> +               /* The extended temperature range is offset by 64 degrees=
 C */
> +               if (priv->extended_temp_range)
> +                       *val -=3D 64;
> +
> +               ret =3D regmap_read(priv->regmap, MCP9982_FRAC_VALUE_ADDR=
(chan->channel), val2);
> +               if (ret)
> +                       return ret;
> +
> +               /* Only the 3 MSB in low byte registers are used */
> +               *val2 =3D mcp9982_fractional_values[*val2 >> 5];
> +               return IIO_VAL_INT_PLUS_MICRO;
> +       case IIO_CHAN_INFO_SAMP_FREQ:
> +               *val =3D mcp9982_conv_rate[priv->sampl_idx][0];
> +               *val2 =3D mcp9982_conv_rate[priv->sampl_idx][1];
> +               return IIO_VAL_INT_PLUS_MICRO;
> +       case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +
> +               ret =3D regmap_read(priv->regmap, MCP9982_RUNNING_AVG_ADD=
R, &index2);
> +               if (ret)
> +                       return ret;
> +
> +               if (index2 >=3D 2)
> +                       index2 -=3D 1;

Sounds like a clamp(). (Note, what if for whatever reason you will get
index2 bigger than array size?

> +               *val =3D mcp9982_3db_values_map_tbl[priv->sampl_idx][inde=
x2][0];
> +               *val2 =3D mcp9982_3db_values_map_tbl[priv->sampl_idx][ind=
ex2][1];
> +               return IIO_VAL_INT_PLUS_MICRO;
> +       case IIO_CHAN_INFO_HYSTERESIS:
> +               ret =3D regmap_read(priv->regmap, MCP9982_HYS_ADDR, &inde=
x);
> +               if (ret)
> +                       return ret;
> +
> +               *val =3D index;
> +               return IIO_VAL_INT;
> +       default:
> +               return -EINVAL;
> +       }
> +}

...

> +static int mcp9982_write_raw(struct iio_dev *indio_dev, struct iio_chan_=
spec const *chan,
> +                            int val, int val2, long mask)
> +{
> +       struct mcp9982_priv *priv =3D iio_priv(indio_dev);
> +       int i, ret;

Why is 'i' signed?

> +       guard(mutex)(&priv->lock);
> +       switch (mask) {
> +       case IIO_CHAN_INFO_SAMP_FREQ:
> +               for (i =3D 0; i < ARRAY_SIZE(mcp9982_conv_rate); i++)
> +                       if (val =3D=3D mcp9982_conv_rate[i][0] && val2 =
=3D=3D mcp9982_conv_rate[i][1])
> +                               break;

> +               if (i >=3D ARRAY_SIZE(mcp9982_conv_rate))

What is the meaning of '>' here?

> +                       return -EINVAL;

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

> +               if (i >=3D ARRAY_SIZE(mcp9982_3db_values_map_tbl[priv->sa=
mpl_idx]))
> +                       return -EINVAL;

Ditto.

> +               /*
> +                * Filter register is coded with values:
> +                *-0 for OFF
> +                *-1 or 2 for level 1
> +                *-3 for level 2

This lists the negative values.... Are you sure the comment is aligned
with what the code is really doing?

> +                */
> +               if (i =3D=3D 2)
> +                       i =3D 3;
> +               ret =3D regmap_write(priv->regmap, MCP9982_RUNNING_AVG_AD=
DR, i);
> +
> +               return ret;
> +       case IIO_CHAN_INFO_HYSTERESIS:
> +               if (val < 0 || val > 255)
> +                       return -EINVAL;
> +
> +               ret =3D regmap_write(priv->regmap, MCP9982_HYS_ADDR, val)=
;
> +               return ret;
> +       default:
> +               return -EINVAL;
> +       }
> +}

...

> +static ssize_t mcp9982_extended_temp_range_store(struct device *dev,
> +                                                struct device_attribute =
*attr,
> +                                                const char *buf, size_t =
count)
> +{
> +       struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> +       struct mcp9982_priv *priv =3D iio_priv(indio_dev);
> +       int ret, val;
> +
> +       ret =3D kstrtouint(buf, 10, &val);
> +       if (ret)
> +               return -EINVAL;

Why is the error code shadowed?

> +       switch (val) {
> +       case 0:
> +               priv->extended_temp_range =3D false;
> +               break;
> +       case 1:
> +               priv->extended_temp_range =3D true;
> +               break;
> +       default:
> +               return -EINVAL;
> +       }

Useless, use kstrtobool() instead.

> +       guard(mutex)(&priv->lock);
> +       ret =3D regmap_assign_bits(priv->regmap, MCP9982_CFG_ADDR, MCP998=
2_CFG_RANGE,
> +                                priv->extended_temp_range);
> +
> +       if (ret)
> +               return ret;
> +
> +       return count;
> +}

...

> +static ssize_t mcp9982_show_beta(struct device *dev, struct device_attri=
bute *attr, char *buf)
> +{
> +       struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> +       struct mcp9982_priv *priv =3D iio_priv(indio_dev);
> +       struct iio_dev_attr *this_attr =3D to_iio_dev_attr(attr);
> +       int val, ret;

Why is val signed? Please, check your code and fix types all over the place=
.

> +       /* When APDD is enabled, betas are locked to autodetection */
> +       if (priv->apdd_enable)
> +               return sysfs_emit(buf, "Auto\n");
> +
> +       ret =3D regmap_read(priv->regmap, MCP9982_EXT_BETA_CFG_ADDR(this_=
attr->address), &val);
> +       if (ret)
> +               return ret;
> +
> +       if (val < 15)
> +               return sysfs_emit(buf, "%s\n", mcp9982_beta_values[val]);

> +       if (val =3D=3D 15)
> +               return sysfs_emit(buf, "Diode_Mode\n");

> +       else

Redundant 'else'.

> +               return sysfs_emit(buf, "Auto\n");
> +}
> +
> +static ssize_t mcp9982_store_beta(struct device *dev, struct device_attr=
ibute *attr,
> +                                 const char *buf, size_t count)
> +{
> +       struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> +       struct mcp9982_priv *priv =3D iio_priv(indio_dev);
> +       struct iio_dev_attr *this_attr =3D to_iio_dev_attr(attr);

> +       int i;

Signed? Why?

> +       /* When APDD is enabled, betas are locked to autodetection */
> +       if (priv->apdd_enable)
> +               return -EINVAL;

The below looks like an attempt to reimplement sysfs_match_string().

> +       for (i =3D 0; i < ARRAY_SIZE(mcp9982_beta_values); i++)
> +               if (strncmp(buf, mcp9982_beta_values[i], 5) =3D=3D 0)
> +                       break;
> +
> +       if (i < ARRAY_SIZE(mcp9982_beta_values)) {
> +               regmap_write(priv->regmap, MCP9982_EXT_BETA_CFG_ADDR(this=
_attr->address), i);
> +               return count;
> +       }
> +
> +       if (strncmp(buf, "Diode_Mode", 10) =3D=3D 0) {
> +               regmap_write(priv->regmap, MCP9982_EXT_BETA_CFG_ADDR(this=
_attr->address), 15);
> +               return count;
> +       }
> +
> +       if (strncmp(buf, "Auto", 4) =3D=3D 0) {
> +               regmap_write(priv->regmap, MCP9982_EXT_BETA_CFG_ADDR(this=
_attr->address), BIT(4));
> +               return count;
> +       }
> +
> +       return -EINVAL;
> +}
> +
> +static ssize_t mcp9982_beta_available_show(struct device *dev,
> +                                          struct device_attribute *attr,=
 char *buf)
> +{
> +       int i;
> +
> +       for (i =3D 0; i < 15; i++) {

> +               strcat(buf, mcp9982_beta_values[i]);
> +               strcat(buf, " ");

Huh?!

> +       }
> +       strcat(buf, "Diode_Mode Auto\n");
> +       return sysfs_emit(buf, buf);

What does this mean, please?

> +}
> +
> +static IIO_DEVICE_ATTR(enable_extended_temp_range, 0644, mcp9982_extende=
d_temp_range_show,
> +                      mcp9982_extended_temp_range_store, 0);
> +static IIO_DEVICE_ATTR(in_beta1, 0644, mcp9982_show_beta, mcp9982_store_=
beta, 0);
> +static IIO_DEVICE_ATTR(in_beta2, 0644, mcp9982_show_beta, mcp9982_store_=
beta, 1);
> +static IIO_DEVICE_ATTR(in_beta_available, 0444, mcp9982_beta_available_s=
how, NULL, 0);

First of all, we have IIO_DEVICE_ATTR_RO/RW, second, move each of them
to be closer to the related callback(s).

...

> +static struct attribute *mcp9982_attributes[] =3D {
> +       &iio_dev_attr_enable_extended_temp_range.dev_attr.attr,
> +       &iio_dev_attr_in_beta1.dev_attr.attr,
> +       &iio_dev_attr_in_beta2.dev_attr.attr,
> +       &iio_dev_attr_in_beta_available.dev_attr.attr,
> +       NULL,

No comma for the terminator.

> +};

I stop there as it reminds me that I had commented on something
similar in the past and nothing here was following those comments. Am
I correct?

--
With Best Regards,
Andy Shevchenko

