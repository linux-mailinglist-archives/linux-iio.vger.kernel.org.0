Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53AF22D45DA
	for <lists+linux-iio@lfdr.de>; Wed,  9 Dec 2020 16:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730907AbgLIPwf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Dec 2020 10:52:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729737AbgLIPwf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Dec 2020 10:52:35 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E6EC061794;
        Wed,  9 Dec 2020 07:51:55 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id f17so1435714pge.6;
        Wed, 09 Dec 2020 07:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+xRDEgsmg5JBAJ8W0eq3rsbhHiVssaRC34+8TCR4Zdg=;
        b=OiIbhXFWcJJO3YaMLW2jCkgfSw9PVgZy5lpHur3J7Ivb8JHuHBWJLZjiElBgjDnRcg
         p/ZsU9vSjR2MemaGG+Bp4EJ3czQmuRryIL0EPzERkhvACxz8BWuIupjiy5NZo3btwbNu
         Zja7ZMqMbf8vEazmnS0xdRry3pTpJsRgZ62C3/SKkqtDASCG4o4xl/cqK+N6nP2+PNKB
         YJC1xwoDQ5C7JOHjMCqdtDDNNiR6IRRiFqBtEDPhF7gdEhuJU7yypvUI1TSaJi/hyPxl
         7KQJosumPiTVXKtP+EjVSZZZ/Db+2UKbPF5ntV59wVgjd1W33nSN8idJAV/WKDXkxxEF
         VUbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+xRDEgsmg5JBAJ8W0eq3rsbhHiVssaRC34+8TCR4Zdg=;
        b=CiqEo4TzWDGPmtX9drYQhbow9dreQicuJgmpcEZCNMhJokLyH4rwQEq8F+314XAC3p
         qI9JdlA7vX+PyyXH5HFD4zYueY9v2N4MpHiKTt1dL9tURfcH+fYYGfzsz5RO7FJHAgBa
         B0E87/dnH8dURhEEspPbFZkDkEm7zLJTkSjB5HUAxSAf7c/huAygPF32tojHFvYGwZgD
         sGRgrqrvYUM6YVIe3KjQb9ZYT+VPZYtGQ4jfAZsM8GOi536Pe5Ve48FScVIDMW7avyLH
         66mS6Gl9TQ77vhV/UpHt0drjNlv2q9bfE8vBAjtOknMqyp0Phw4GutgnsXUWhuGZyLJc
         prZQ==
X-Gm-Message-State: AOAM533pc326oHdbBbKy/MDv8lh2Z7FKCyODe3ktLAPv7Ah/g/b2JN0D
        mrco2GJF3Y12eqNgqDHOZvY7eNNXJxSSOPWQGsYVvHibHSBlvg==
X-Google-Smtp-Source: ABdhPJwQ/MfkChHRu8f7YMv6lB/MdOQfWzwaiaUgEYLtnFmy8+KvoHm49cD5umSklDfcS8hyR+eXTeHcj2KVxXC+Qto=
X-Received: by 2002:a62:19cc:0:b029:19e:321b:a22e with SMTP id
 195-20020a6219cc0000b029019e321ba22emr2898014pfz.73.1607529114493; Wed, 09
 Dec 2020 07:51:54 -0800 (PST)
MIME-Version: 1.0
References: <20201204182043.86899-1-cristian.pop@analog.com> <20201204182043.86899-2-cristian.pop@analog.com>
In-Reply-To: <20201204182043.86899-2-cristian.pop@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 9 Dec 2020 17:52:42 +0200
Message-ID: <CAHp75VeOcn+O6KxRoMcYY1ALzqY8rSwvaWtbxwF7ks4d1MaqTg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: dac: ad5766: add driver support for AD5766
To:     Cristian Pop <cristian.pop@analog.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Dec 4, 2020 at 8:17 PM Cristian Pop <cristian.pop@analog.com> wrote=
:
>
> The AD5766/AD5767 are 16-channel, 16-bit/12-bit, voltage output dense DAC=
s
> Digital-to-Analog converters.
>
> This change adds support for these DACs.

> Link: https://www.analog.com/media/en/technical-documentation/data-sheets=
/ad5766-5767.pdf

Can we use Datasheet: tag instead, please?

>
> Signed-off-by: Cristian Pop <cristian.pop@analog.com>

No blank lines in tag block, please.

...

> + * Analog Devices AD5766, AD5767
> + * Digital to Analog Converters driver

Looks like one line.

...

> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/module.h>
> +#include <linux/spi/spi.h>
> +#include <linux/iio/iio.h>
> +#include <linux/bitfield.h>

Keep it sorted?

...

> +#define AD5766_CMD_WR_IN_REG(x)                        (0x10 | ((x) & 0x=
F))
> +#define AD5766_CMD_WR_DAC_REG(x)               (0x20 | ((x) & 0xF))

Why not GENMASK()?

...

> +#define AD5766_CMD_READBACK_REG(x)             (0x80 | ((x) & 0xF))

Ditto.

...

> +enum ad5766_type {
> +       ID_AD5766,
> +       ID_AD5767,
> +};

This may be problematic in case we switch to device_get_match_data().

...

> +enum ad5766_voltage_range {
> +       AD5766_VOLTAGE_RANGE_M20V_0V,
> +       AD5766_VOLTAGE_RANGE_M16V_to_0V,
> +       AD5766_VOLTAGE_RANGE_M10V_to_0V,
> +       AD5766_VOLTAGE_RANGE_M12V_to_14V,
> +       AD5766_VOLTAGE_RANGE_M16V_to_10V,
> +       AD5766_VOLTAGE_RANGE_M10V_to_6V,
> +       AD5766_VOLTAGE_RANGE_M5V_to_5V,
> +       AD5766_VOLTAGE_RANGE_M10V_to_10V,

> +       AD5766_VOLTAGE_RANGE_MAX,

No comma for terminator line.

> +};

...

> +enum {
> +       AD5766_DITHER_PWR,
> +       AD5766_DITHER_INVERT

+ comma

> +};

...

> +/*
> + * External dither signal can be composed with the DAC output, if activa=
ted.
> + * The dither signals are applied to the N0 and N1 input pins.
> + * Dither source for each of the channel can be selected by writing to
> + * "dither_source",a 32 bit variable and two bits are used for each of t=
he 16
> + * channels: 0: NO_DITHER, 1: N0, 2: N1.
> + * This variable holds available dither source strings.
> + */
> +static const char * const ad5766_dither_sources[] =3D {
> +       "NO_DITHER",
> +       "N0",
> +       "N1",
> +};

Can't we rather be simpler, i.e. use 0,1 and -1, where the latter for
NO_DITHER cas?.

...

> +/*
> + * Dither signal can also be scaled.
> + * Available dither scale strings coresponding to "dither_scale" field i=
n

corresponding

> + * "struct ad5766_state".
> + * "dither_scale" is a 32 bit variable and two bits are used for each of=
 the 16
> + * channels: 0: NO_SCALING, 1: 75%_SCALING, 2: 50%_SCALING, 3: 25%_SCALI=
NG.
> + */
> +static const char * const ad5766_dither_scales[] =3D {
> +       "NO_SCALING",
> +       "75%_SCALING",
> +       "50%_SCALING",
> +       "25%_SCALING",
> +};

Oh, no. Please, use plain numbers in percentages.

...

> + * @cached_offset:     Cached range coresponding to the selected offset

corresponding
Please, run checkpatch.pl --code-spell (or how is it called?).

...

> + * @offset_avail:      Offest available table

Ditto.
Offset (I suppose)

...

> +static int _ad5766_spi_write(struct ad5766_state *st, u8 command, u16 da=
ta)
> +{
> +       st->data[0].b8[0] =3D command;
> +       st->data[0].b8[1] =3D (data & 0xFF00) >> 8;
> +       st->data[0].b8[2] =3D (data & 0x00FF) >> 0;

Please,  use get_unaliged_XX() / put_unaligned_XX() and other related
macros / APIs.

> +       return spi_write(st->spi, &st->data[0].b8[0], 3);
> +}

...

> +static int ad5766_reset(struct ad5766_state *st)
> +{
> +       int ret =3D 0;

In general it's a bad idea and in particular here it's not needed.

> +       return 0;
> +}

...

> +       ret =3D _ad5766_spi_write(st, AD5766_CMD_DITHER_SIG_1,

> +                         st->dither_source & 0xFFFF);

Do you really need this conjunction? If so, why not GENMASK()?

> +       if (ret)
> +               return ret;

...

> +       ret =3D _ad5766_spi_write(st, AD5766_CMD_INV_DITHER, st->dither_i=
nvert);
> +       if (ret)
> +               return ret;
> +
> +       return 0;

return _ad5766_spi_write(=E2=80=A6);

...

> +static int ad5766_set_offset(struct ad5766_state *st, int val, int val2)
> +{
> +       int i;
> +       s32 (*tbl)[AD5766_VOLTAGE_RANGE_MAX][2] =3D &(st->offset_avail);

Too many parentheses.

> +
> +       for (i =3D 0; i < AD5766_VOLTAGE_RANGE_MAX; i++) {

ARRAY_SIZE() ?

> +               if ((*tbl)[i][0] =3D=3D val && (*tbl)[i][1] =3D=3D val2) =
{
> +                       st->cached_offset =3D i;
> +                       return 0;
> +               }
> +       }

Entire function hurts my eyes. Can you give some time and think over it aga=
in?

> +       return -EINVAL;
> +}

...

> +static int ad5766_set_scale(struct ad5766_state *st, int val, int val2)

Ditto.

...

> +               *vals =3D (const int *)st->scale_avail;

Why do you need casting?

...

> +               *vals =3D (const int *)st->offset_avail;

Ditto.

...

> +static int ad5766_read_raw(struct iio_dev *indio_dev,
> +                          struct iio_chan_spec const *chan,
> +                          int *val,
> +                          int *val2,
> +                          long m)

It may take much less LOCs.

...

> +static int ad5766_write_raw(struct iio_dev *indio_dev,
> +                           struct iio_chan_spec const *chan,
> +                           int val,
> +                           int val2,
> +                           long info)

Ditto.

...

> +               const int max_val =3D (1 << chan->scan_type.realbits);
> +
> +               if (val >=3D max_val || val < 0)
> +                       return -EINVAL;
> +               val <<=3D chan->scan_type.shift;

You can do better, i.e. drop unneeded temporary variable and use fls().

...

> +       return (source >> chan->channel * 2);

Seems parentheses in incorrect place in case you want to increase robustnes=
s.

> +}

...

> +       st->dither_source |=3D (mode << (chan->channel * 2));

It's not LISP, seriously.
I'm wondering if Analog has internal mailing list (and perhaps a wiki
with common tips and tricks for Linux kernel programming) for
review...

...

> +       return (scale >> chan->channel * 2);

As above.

...

> +       st->dither_scale |=3D (scale << (chan->channel * 2));

As above.

...

> +               return sprintf(buf, "%u\n", 0x01 &
> +                              ~(st->dither_power_ctrl >> chan->channel))=
;

Oh l=C3=A0 l=C3=A0.

!(st->dither_power_ctrl & BIT(chan->channel)) ?

...

> +               return sprintf(buf, "%u\n", 0x01 &
> +                              (st->dither_invert >> chan->channel));

Ditto.

...

> +       default:

> +               ret =3D -EINVAL;
> +               break;

Point of this? Can't return directly?

> +       }
> +
> +       return ret;

...

> +       switch ((u32)private) {

Why casting?

...

> +       default:
> +               ret =3D -EINVAL;
> +               break;

Why not to return here?

> +       }

> +       return ret ? ret : len;

return len; ?

...

> +               offset =3D div_s64(offset * 1000000, denom);
> +               st->offset_avail[i][0] =3D div_s64(offset, 1000000);
> +               div_s64_rem(offset, 1000000, &st->offset_avail[i][1]);

...

> +               scale =3D div_u64((scale * 1000000000), (1 << realbits));
> +               st->scale_avail[i][0] =3D (int)div_u64(scale, 1000000);
> +               div_s64_rem(scale, 1000000, &st->scale_avail[i][1]);

Perhaps it's time to extend units.h with mV / V / uV / etc?

...

> +static const struct of_device_id ad5766_dt_match[] =3D {
> +       { .compatible =3D "adi,ad5766" },
> +       { .compatible =3D "adi,ad5767" },

> +       {},

No comma for terninator.

> +};


--=20
With Best Regards,
Andy Shevchenko
