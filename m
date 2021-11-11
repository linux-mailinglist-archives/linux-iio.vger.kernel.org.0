Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA18D44D78C
	for <lists+linux-iio@lfdr.de>; Thu, 11 Nov 2021 14:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbhKKNwu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 11 Nov 2021 08:52:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbhKKNwt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 11 Nov 2021 08:52:49 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0940C061766
        for <linux-iio@vger.kernel.org>; Thu, 11 Nov 2021 05:50:00 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id w1so24463706edd.10
        for <linux-iio@vger.kernel.org>; Thu, 11 Nov 2021 05:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ficvgSjLgZPcFP6PFeICof6VymKGA90BPpVjo1xSdmE=;
        b=pT9IrmrpYbHyJ8CvT8mLUzpNOX2+p0jSFijV2tj+l9Wetr4V1s0QcAPckWGUBrZK7V
         ACylr+h08BLl09nVdyNGoO+Cwv0zaxVQ8QGrkQnLtcQPDsmPwccAy4MJjNj2ZJ4A17yx
         1sXdn3R5/AajkGBTVxsQWEM9gtQZ31e00VWAU9kSEAs+KFcXPrj6pvz1Ca86lyEzfpsn
         0XUdRgnoDbS+N6R3AodOWaPXbH6De1ZyCOfEaPvPCQjO5l31E4Ysrxh/32ex8+ZsH1Ae
         7LNh0V8NpWmrW3V0fyBOSBBl5NLNaKstP2cHP9RnMDIVkWUrObw3644wZDaXBW21rAfM
         /HDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ficvgSjLgZPcFP6PFeICof6VymKGA90BPpVjo1xSdmE=;
        b=eIw0oMBlHjPxGxdqlg9UlQ4hrHgrbccaDb4zxsaKTrZG97PlFIBClJJrQn4OO34WdI
         9Da0SIoqasOKLMmSz22GJOrNwRQA/UgOuapxBBo19stwelI12FIofBbeh+xFkROnShlS
         KqgwI+UhGKwE8ID1iPH2BzZFlqJfHLWRi2+BSHVIviGKmL4nmjGxNlaogkInSeJBSR8y
         gxDSjOxnYvCqOmaWK14fSUM23edAL04SSfZfo8OcN+5akegRT4yAKomrlhFhECYyXvcb
         Kslwhot//jAzi1+euHfeQWTKUUvZI4Z7y0wympkXzOhmxNC6NKNfi3sxMSAjnDa9tkAt
         Kiqg==
X-Gm-Message-State: AOAM532idgbTMkbKC8mvYBQfEV3GQw73gkL3gKf3R2wptYRpMgO2AvLd
        HaOXbcMFDithNRtzVZHHME0mRvkuDDPePYxFz7A=
X-Google-Smtp-Source: ABdhPJzw7e5LXTPLP3L/NvNLi5VZDk/rrsYGUw6p6w3WJEJOL7fPlylnUMf788qaFWjBXrJy+969rLNHhfg6REVMaDQ=
X-Received: by 2002:a50:8741:: with SMTP id 1mr4748561edv.119.1636638599079;
 Thu, 11 Nov 2021 05:49:59 -0800 (PST)
MIME-Version: 1.0
References: <20211111110043.101891-1-nuno.sa@analog.com> <20211111110043.101891-2-nuno.sa@analog.com>
In-Reply-To: <20211111110043.101891-2-nuno.sa@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 11 Nov 2021 15:49:14 +0200
Message-ID: <CAHp75Ve3ZfFz5g4qH6HhuqaLKgqd058Jj-xY4=-e3ciG67cfRg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] iio: dac: add support for ltc2688
To:     =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Nov 11, 2021 at 1:01 PM Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
>
> The LTC2688 is a 16 channel, 16 bit, +-15V DAC with an integrated
> precission reference. It is guaranteed monotonic and has built in

precision

> rail-to-rail output buffers that can source or sink up to 20 mA.

It's in good shape, several comments below, though.

...

> +enum {
> +       LTC2688_SPAN_RANGE_0V_5V,
> +       LTC2688_SPAN_RANGE_M10V_10V,
> +       LTC2688_SPAN_RANGE_M15V_15V,
> +       /*
> +        * These 2 were deliberately re-arranged to be the last items as =
they
> +        * have the same fs and we will just return 1 in read_available.

WTH "fs" mean?

> +        */
> +       LTC2688_SPAN_RANGE_0V_10V,
> +       LTC2688_SPAN_RANGE_M5V_5V,
> +       LTC2688_SPAN_RANGE_MAX
> +};

...

> +static const int ltc2688_off_tbl[LTC2688_SPAN_RANGE_MAX] =3D {
> +       [LTC2688_SPAN_RANGE_0V_5V] =3D 0,
> +       [LTC2688_SPAN_RANGE_M10V_10V] =3D -32768,
> +       [LTC2688_SPAN_RANGE_M15V_15V] =3D -32768,

> +       [LTC2688_SPAN_RANGE_0V_10V] =3D 0,
> +       [LTC2688_SPAN_RANGE_M5V_5V] =3D -32768

+ Comma

Isn't it more natural to move them up by two lines?

> +};
> +
> +static const int ltc2688_reg_val[LTC2688_SPAN_RANGE_MAX] =3D {
> +       [LTC2688_SPAN_RANGE_0V_5V] =3D 0,
> +       [LTC2688_SPAN_RANGE_M10V_10V] =3D 3,
> +       [LTC2688_SPAN_RANGE_M15V_15V] =3D 4,
> +       [LTC2688_SPAN_RANGE_0V_10V] =3D 1,
> +       [LTC2688_SPAN_RANGE_M5V_5V] =3D 2

As per above.

> +};

...

> +static int ltc2688_span_set(const struct ltc2688_state *st, int c, int s=
pan)
> +{
> +       const struct ltc2688_chan *chan =3D &st->channels[c];
> +       u32 i =3D ARRAY_SIZE(chan->span_tbl);
> +       int off =3D ltc2688_offset_avail[chan->offset_idx];

> +       while (i--) {

Can ARRAY_SIZE() give 0?
If not, do {} while (--i); looks more natural.

> +               if (span =3D=3D chan->span_tbl[i][1]) {
> +                       /*
> +                        * The selected scale needs to fit  the current o=
ffset.
> +                        * Note that for [0V 10V] and [-5V 5V], as the sc=
ale is
> +                        * the same, we will always succeed here. Hence i=
f
> +                        * someone really wants [0 10V] and does not set =
the
> +                        * offset to 0, then :man-shrugging:
> +                        */
> +                       if (off =3D=3D ltc2688_off_tbl[i]) {
> +                               break;

> +                       } else if (i < LTC2688_SPAN_RANGE_0V_10V) {

Redundant 'else'.

> +                               /*
> +                                * At this point, only one offset is vali=
d so we
> +                                * already can assume error.
> +                                */
> +                               dev_err(&st->spi->dev, "Offset(%d) not va=
lid for current scale(0.%09d)\n",
> +                                       off, span);
> +                               return -EPERM;
> +                       }

> +                       continue;

Redundant, see below.

> +               }

> +               if (!i) {
> +                       dev_err(&st->spi->dev, "span(%d) not available\n"=
, span);
> +                       return -EINVAL;
> +               }

This is invariant to the loop.

> +       }
> +
> +       return regmap_update_bits(st->regmap, LTC2688_CMD_CH_SETTING(c),
> +                                 LTC2688_CH_SPAN_MSK,
> +                                 FIELD_PREP(LTC2688_CH_SPAN_MSK, ltc2688=
_reg_val[i]));
> +};

...

> +       if (off !=3D ltc2688_offset_avail[0] && off !=3D ltc2688_offset_a=
vail[1])
> +               return -EINVAL;

Extra condition, See below.

> +       if (off =3D=3D ltc2688_offset_avail[0])
> +               chan->offset_idx =3D 0;
> +       else

else if

> +               chan->offset_idx =3D 1;

else
  return -EINVAL;

...

> +       ret =3D regmap_read(st->regmap, reg, &regval);
> +       if (ret < 0)

Is it the first time you tested explicitly for a negative result?

> +               return ret;

...

> +       return sprintf(buf, "%u\n", !!(regval & BIT(chan->channel)));

sysfs_emit() ?

> +}

...

> +       struct ltc2688_state *st =3D iio_priv(indio_dev);
> +       bool en;
> +       int ret;
> +       u32 val =3D 0, reg;

Reversed xmas tree order ?

> +       ret =3D strtobool(buf, &en);

kstrtobool()

...

> +       if (ret)
> +               return ret;
> +               break;

What does this mean?

...

> +       "4",
> +       "8",
> +       "16",
> +       "32",
> +       "64",

One line?

...

> +       "0",
> +       "90",
> +       "180",
> +       "270",

Ditto.

...

> +enum {
> +       LTC2688_CHAN_MODE_TOGGLE,
> +       LTC2688_CHAN_MODE_DITHER

+ Comma.

> +};

...

> +static const char * const ltc2688_clk_names[LTC2688_CHAN_TD_MAX] =3D {
> +       "TGP1", "TGP2", "TGP3"

In this notation, + comma.

> +};

...

> +       for_each_set_bit(bit, &mask, ARRAY_SIZE(ltc2688_clk_names)) {
> +               struct clk *clk;

+ blank line

> +               /*
> +                * If a TGP pin is set, then we need to provide a valid c=
lock at
> +                * the pin.
> +                */

> +       }

...

> +       fwnode_for_each_available_child_node(fwnode, child) {
> +               struct ltc2688_chan *chan;
> +
> +               ret =3D fwnode_property_read_u32(child, "reg", &reg);
> +               if (ret) {
> +                       fwnode_handle_put(child);

> +                       return dev_err_probe(&st->spi->dev, ret,
> +                                            "Failed to get reg property\=
n");

One line.

> +               } else if (reg >=3D LTC2688_DAC_CHANNELS) {

Redundant 'else'.

> +                       fwnode_handle_put(child);
> +                       return dev_err_probe(&st->spi->dev, -EINVAL,

> +                                            "reg >=3D %d\n", LTC2688_DAC=
_CHANNELS);

The message is cryptic. Decrypt it for the user.

> +               }
> +
> +               chan =3D &st->channels[reg];
> +               ret =3D fwnode_property_read_u32(child, "adi,mode", &mode=
);
> +               if (!ret) {
> +                       if (mode > LTC2688_CHAN_MODE_DITHER) {
> +                               fwnode_handle_put(child);
> +                               return dev_err_probe(&st->spi->dev, -EINV=
AL,
> +                                                    "chan mode inv value=
(%d)\n",
> +                                                    mode);
> +                       }
> +
> +                       chan->dither_toggle =3D true;
> +                       if (mode =3D=3D LTC2688_CHAN_MODE_TOGGLE) {
> +                               ltc2688_channels[reg].ext_info =3D ltc268=
8_toggle_ext_info;
> +                       } else {
> +                               ltc2688_channels[reg].ext_info =3D ltc268=
8_dither_ext_info;
> +                               /* enable dither mode */
> +                               mask =3D LTC2688_CH_MODE_MSK;
> +                               val =3D BIT(11);
> +                       }
> +               }
> +
> +               ret =3D fwnode_property_read_u32(child, "adi,toggle-dithe=
r-input",
> +                                              &clk_input);

> +               if (!ret) {

if (ret) {
  if ...
} else {
 ...
}

> +                       if (clk_input > LTC2688_CHAN_TD_TGP3) {
> +                               fwnode_handle_put(child);
> +                               return dev_err_probe(&st->spi->dev, -EINV=
AL,
> +                                                    "toggle-dither-input=
 inv value(%d)\n",
> +                                                    clk_input);
> +                       }
> +
> +                       clk_msk |=3D BIT(clk_input);
> +                       mask |=3D LTC2688_CH_TD_SEL_MSK;
> +                       /*
> +                        * 0 means software toggle which we are not suppo=
rting
> +                        * for now. Hence the +1

In all multi-line comments miseed (grammatical) period.

> +                        */
> +                       val |=3D FIELD_PREP(LTC2688_CH_TD_SEL_MSK, clk_in=
put + 1);
> +               } else if (chan->dither_toggle) {
> +                       /*
> +                        * As sw_toggle is not supported, we need to make=
 sure
> +                        * a valid input is selected if toggle/dither mod=
e is
> +                        * requested
> +                        */
> +                       return dev_err_probe(&st->spi->dev, -EINVAL,
> +                                            "toggle-dither set but no to=
ggle-dither-input\n");
> +               }

> +               chan->overrange =3D fwnode_property_read_bool(child,
> +                                                           "adi,overrang=
e");

One line?

> +               if (chan->overrange) {
> +                       val |=3D LTC2688_CH_OVERRANGE_MSK;
> +                       mask |=3D BIT(3);
> +               }
> +
> +               if (!mask)
> +                       continue;
> +
> +               ret =3D regmap_update_bits(st->regmap,
> +                                        LTC2688_CMD_CH_SETTING(reg), mas=
k,
> +                                        val);
> +               if (ret) {
> +                       fwnode_handle_put(child);
> +                       return dev_err_probe(&st->spi->dev, -EINVAL,
> +                                            "failed to set chan settings=
\n");
> +               }
> +
> +               mask =3D 0;
> +               val =3D 0;
> +       }

...

> +       int fs =3D ltc2688_span_helper[idx][1] - ltc2688_span_helper[idx]=
[0];
> +
> +       if (chan->overrange)
> +               fs =3D mult_frac(fs, 105, 100);
> +
> +       return fs;

if (...)
 return ...
?

...

> +       u32 c, i;

In one case you use int or unsigned int if I'm not mistaken, here out
of a sudden u32. Why? Please, be consistent over the code.

...

> +                       /* we will return IIO_VAL_INT_PLUS_NANO */
> +                       s =3D DIV_ROUND_CLOSEST_ULL(st->vref * fs * 10000=
00000ULL,
> +                                                 4096 * 1 << 16);

Can you make use of one of the SI prefixes here? (See unit.h)

...

> +       gpio =3D devm_gpiod_get_optional(&st->spi->dev, "reset", GPIOD_OU=
T_HIGH);
> +       if (IS_ERR(gpio))
> +               return dev_err_probe(&st->spi->dev, PTR_ERR(gpio),
> +                                    "Failed to get reset gpio");

> +

Redundant blank line.

> +       if (gpio) {
> +               usleep_range(1000, 1200);
> +               /* bring device out of reset */
> +               gpiod_set_value_cansleep(gpio, 0);

> +       } else {

I'm wondering why 'else'? Can't it be both? Why not?

> +               ret =3D regmap_update_bits(st->regmap, LTC2688_CMD_CONFIG=
_REG,
> +                                        LTC2688_CONFIG_RST,
> +                                        LTC2688_CONFIG_RST);
> +               if (ret < 0)
> +                       return ret;
> +       }
> +
> +       usleep_range(10000, 12000);

+ blank line, so the reader won't be confused about the function of this sl=
eep.

> +       ret =3D ltc2688_channel_config(st);
> +       if (ret < 0)
> +               return ret;
> +
> +       if (vref) {
> +               ret =3D regmap_update_bits(st->regmap, LTC2688_CMD_CONFIG=
_REG,
> +                                        LTC2688_CONFIG_EXT_REF, BIT(1));
> +               if (ret < 0)

These ' < 0' parts are inconsistent over the code.

> +                       return ret;
> +       }
> +
> +       ltc2688_span_avail_compute(st);
> +       return 0;
> +}

...

> +       /* ignoring the no op command */
> +       .max_register =3D U16_MAX - 1

Really?! Have you ever considered what burden you bring with this to
one who accidentally or on purpose tries to dump registers via
debugfs?

...

> +       st->regmap =3D devm_regmap_init(&spi->dev, NULL, st, &ltc2688_reg=
map_config);

I'm wondering why it's not a regmap SPI?

> +       if (IS_ERR(st->regmap))
> +               return dev_err_probe(&spi->dev, PTR_ERR(st->regmap),
> +                                    "Failed to init regmap");

...

> +       ret =3D ltc2688_regulator_supply_get(st, "vcc");
> +       if (ret)
> +               return ret;
> +
> +       ret =3D ltc2688_regulator_supply_get(st, "iovcc");
> +       if (ret)
> +               return ret;

Can bulk regulators be used?

...

> +               st->vref =3D ret / 1000;

Make use of unit.h

--
With Best Regards,
Andy Shevchenko
