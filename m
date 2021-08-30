Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D89D83FB2CB
	for <lists+linux-iio@lfdr.de>; Mon, 30 Aug 2021 11:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235012AbhH3JBa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Aug 2021 05:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbhH3JB3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Aug 2021 05:01:29 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AE9C061575
        for <linux-iio@vger.kernel.org>; Mon, 30 Aug 2021 02:00:36 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id oa17so9005763pjb.1
        for <linux-iio@vger.kernel.org>; Mon, 30 Aug 2021 02:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FSgnXU29dUjU60IGFMCcNVAb3SNOD52EohtY8x3q0WU=;
        b=kHQMJe6P4mGiWhzV3E7WP4lnuBq7WItQtNd6/QlQGJveGoE7RDzup9b8ZkgsJ0zKuM
         /FvktDDpmoFN6xYWGOi8Yw0aQ2pzvurhMB3hqUU6TCjn82B3j/Z9j9nHGMRsQZOqRTXi
         zEX2CWpkqgY1QxNR4GPXufgThgTa7hzqvyG2a26WrL/sGvDPEM05gs4bDk1+7aMmH3Qv
         GWAUTw3mhM8rfeQDlXwinAGYk/CpKPlfhhotwxfa9h8Rl7cjaviI8V6oOkos8GdH3S2v
         PscbEYFNAu1/SBCnW43xfb3ONM0831vZenVmB0LcKeFXJ+44DIX+Jm5P9yRCCROq3sr6
         NKaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FSgnXU29dUjU60IGFMCcNVAb3SNOD52EohtY8x3q0WU=;
        b=mEp9hT2XkqyMF4o3MK7KTY6Noji0uOBgD3rosqDCCvGc622NNTa5WDRqzSZe+u1xCi
         91nn6YVfIE120laSDCjwimHGqGrHqo3zAKm9rpuaWefL+hmM9m/oJ3XYD7XWaTX2t1i1
         j/+jziDeOg8dmjaMKKaMFgrl53Hnfjw1rV6XMZ89iRoh95tnsPHa45BOiAddlIrZP8Bi
         6celteDpt0P2zjE00Qt2yhtTtAvHCzus1SfA0W8Ru3+safkb/hzhMnZDznCezkeDr1RW
         CD7W1EJ4LaFdxDZKYVTBpUN9qcIat0JGoSn+dnjP9i6nQ7MJYJX6ZhCw6KcNAeNqTg70
         kS1Q==
X-Gm-Message-State: AOAM532fGjYNRBeMb+faNrexJQ1sCsba3hzcSrTQSDbyH8TTFy9PokeE
        Y8KAODdhaabDTpJHWk0CI2idbhjqjBenDAdHapdYF8I7MgA=
X-Google-Smtp-Source: ABdhPJxy//oiAk/xUb0SE9bB0wnTdKvjqNTVVfRkkjRXhLRjBa8TR6BojmuZMBcy7l0gY/HtM/+vwcnTU5RHar79cfw=
X-Received: by 2002:a17:90a:d78d:: with SMTP id z13mr24411749pju.228.1630314036078;
 Mon, 30 Aug 2021 02:00:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210830081032.267891-1-sean@geanix.com>
In-Reply-To: <20210830081032.267891-1-sean@geanix.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 30 Aug 2021 12:00:00 +0300
Message-ID: <CAHp75VePkvuGCOpPNNYfesiLvx3JN6vaNM-b_FfSfA6_3tbFFQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] iio: accel: fxls8962af: add threshold event handling
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Aug 30, 2021 at 11:10 AM Sean Nyekjaer <sean@geanix.com> wrote:
>
> Add event channels that control the creation of motion events.

Couple of nit-picks below (maybe Jonathan can address them when
applying), after addressing feel free to add
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
> Changes since v1/v2:
>  - Fixed comments fron Andy (Thanks)
>  - Corrected sign mess
>
>  drivers/iio/accel/fxls8962af-core.c | 266 +++++++++++++++++++++++++++-
>  1 file changed, 264 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls=
8962af-core.c
> index 6b36eb362d07..dd639420fb0f 100644
> --- a/drivers/iio/accel/fxls8962af-core.c
> +++ b/drivers/iio/accel/fxls8962af-core.c
> @@ -22,6 +22,7 @@
>  #include <linux/regmap.h>
>
>  #include <linux/iio/buffer.h>
> +#include <linux/iio/events.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/kfifo_buf.h>
>  #include <linux/iio/sysfs.h>
> @@ -30,6 +31,7 @@
>
>  #define FXLS8962AF_INT_STATUS                  0x00
>  #define FXLS8962AF_INT_STATUS_SRC_BOOT         BIT(0)
> +#define FXLS8962AF_INT_STATUS_SRC_SDCD_OT      BIT(4)
>  #define FXLS8962AF_INT_STATUS_SRC_BUF          BIT(5)
>  #define FXLS8962AF_INT_STATUS_SRC_DRDY         BIT(7)
>  #define FXLS8962AF_TEMP_OUT                    0x01
> @@ -73,6 +75,7 @@
>  #define FXLS8962AF_ASLP_COUNT_LSB              0x1e
>
>  #define FXLS8962AF_INT_EN                      0x20
> +#define FXLS8962AF_INT_EN_SDCD_OT_EN           BIT(5)
>  #define FXLS8962AF_INT_EN_BUF_EN               BIT(6)
>  #define FXLS8962AF_INT_PIN_SEL                 0x21
>  #define FXLS8962AF_INT_PIN_SEL_MASK            GENMASK(7, 0)
> @@ -96,8 +99,14 @@
>  #define FXLS8962AF_ORIENT_THS_REG              0x2c
>
>  #define FXLS8962AF_SDCD_INT_SRC1               0x2d
> +#define FXLS8962AF_SDCD_INT_SRC1_X_OT          BIT(5)
> +#define FXLS8962AF_SDCD_INT_SRC1_Y_OT          BIT(3)
> +#define FXLS8962AF_SDCD_INT_SRC1_Z_OT          BIT(1)
>  #define FXLS8962AF_SDCD_INT_SRC2               0x2e
>  #define FXLS8962AF_SDCD_CONFIG1                        0x2f
> +#define FXLS8962AF_SDCD_CONFIG1_Z_OT_EN                BIT(3)
> +#define FXLS8962AF_SDCD_CONFIG1_Y_OT_EN                BIT(4)
> +#define FXLS8962AF_SDCD_CONFIG1_X_OT_EN                BIT(5)
>  #define FXLS8962AF_SDCD_CONFIG2                        0x30
>  #define FXLS8962AF_SDCD_OT_DBCNT               0x31
>  #define FXLS8962AF_SDCD_WT_DBCNT               0x32
> @@ -152,6 +161,9 @@ struct fxls8962af_data {
>         int64_t timestamp, old_timestamp;       /* Only used in hw fifo m=
ode. */
>         struct iio_mount_matrix orientation;
>         u8 watermark;
> +       u8 enable_event;
> +       u16 lower_thres;
> +       u16 upper_thres;
>  };
>
>  const struct regmap_config fxls8962af_regmap_conf =3D {
> @@ -451,6 +463,15 @@ static int fxls8962af_write_raw(struct iio_dev *indi=
o_dev,
>         }
>  }
>
> +static int fxls8962af_event_setup(struct fxls8962af_data *data, int stat=
e)
> +{
> +       /* Enable wakeup interrupt */
> +       int mask =3D FXLS8962AF_INT_EN_SDCD_OT_EN;
> +       int value =3D state ? mask : 0;
> +
> +       return regmap_update_bits(data->regmap, FXLS8962AF_INT_EN, mask, =
value);
> +}
> +
>  static int fxls8962af_set_watermark(struct iio_dev *indio_dev, unsigned =
val)
>  {
>         struct fxls8962af_data *data =3D iio_priv(indio_dev);
> @@ -463,6 +484,194 @@ static int fxls8962af_set_watermark(struct iio_dev =
*indio_dev, unsigned val)
>         return 0;
>  }
>
> +static int __fxls8962af_set_thresholds(struct fxls8962af_data *data,
> +                                      const struct iio_chan_spec *chan,
> +                                      int val)
> +{
> +       int ret;
> +
> +       /*
> +        * Add the same value to the lower-threshold register with a reve=
rsed sign
> +        * in 2-complement 12 bit format.
> +        */
> +       data->lower_thres =3D -val & GENMASK(11, 0);
> +       data->upper_thres =3D val & GENMASK(10, 0);
> +
> +       ret =3D regmap_bulk_write(data->regmap, FXLS8962AF_SDCD_LTHS_LSB,
> +                               &data->lower_thres, chan->scan_type.stora=
gebits / 8);
> +       if (ret)
> +               return ret;

> +       ret =3D regmap_bulk_write(data->regmap, FXLS8962AF_SDCD_UTHS_LSB,
> +                               &data->upper_thres, chan->scan_type.stora=
gebits / 8);
> +
> +       return ret;

return regmap_bulk_write(...);

> +}
> +
> +static int fxls8962af_read_event(struct iio_dev *indio_dev,
> +                                const struct iio_chan_spec *chan,
> +                                enum iio_event_type type,
> +                                enum iio_event_direction dir,
> +                                enum iio_event_info info,
> +                                int *val, int *val2)
> +{
> +       struct fxls8962af_data *data =3D iio_priv(indio_dev);
> +       u16 raw_val;
> +       int ret;
> +
> +       if (type !=3D IIO_EV_TYPE_THRESH)
> +               return -EINVAL;
> +
> +       /*
> +        * Read only upper-threshold register as the lower-threshold regi=
ster have the
> +        * same value with reversed sign.
> +        */
> +       ret =3D regmap_bulk_read(data->regmap, FXLS8962AF_SDCD_UTHS_LSB,
> +                              &raw_val, chan->scan_type.storagebits / 8)=
;
> +       if (ret)
> +               return ret;
> +
> +       *val =3D sign_extend32(raw_val, chan->scan_type.realbits - 1);
> +       *val2 =3D 0;
> +
> +       return IIO_VAL_INT;
> +}
> +
> +static int fxls8962af_write_event(struct iio_dev *indio_dev,
> +                                 const struct iio_chan_spec *chan,
> +                                 enum iio_event_type type,
> +                                 enum iio_event_direction dir,
> +                                 enum iio_event_info info,
> +                                 int val, int val2)
> +{
> +       struct fxls8962af_data *data =3D iio_priv(indio_dev);
> +       int ret;
> +
> +       if (type !=3D IIO_EV_TYPE_THRESH)
> +               return -EINVAL;
> +
> +       if (val < 0 || val > 2047)
> +               return -EINVAL;
> +
> +       if (data->enable_event)
> +               return -EBUSY;

> +
> +

One blank line is enough.

> +       if (fxls8962af_is_active(data)) {
> +               ret =3D fxls8962af_standby(data);
> +               if (ret)
> +                       return ret;
> +
> +               ret =3D __fxls8962af_set_thresholds(data, chan, val);
> +               if (ret)
> +                       return ret;
> +
> +               ret =3D fxls8962af_active(data);
> +       } else {
> +               ret =3D __fxls8962af_set_thresholds(data, chan, val);
> +       }
> +
> +       return ret;
> +}
> +
> +static int
> +fxls8962af_read_event_config(struct iio_dev *indio_dev,
> +                            const struct iio_chan_spec *chan,
> +                            enum iio_event_type type,
> +                            enum iio_event_direction dir)
> +{
> +       struct fxls8962af_data *data =3D iio_priv(indio_dev);
> +
> +       if (type !=3D IIO_EV_TYPE_THRESH)
> +               return -EINVAL;
> +
> +       switch (chan->channel2) {
> +       case IIO_MOD_X:
> +               return FXLS8962AF_SDCD_CONFIG1_X_OT_EN & data->enable_eve=
nt;
> +       case IIO_MOD_Y:
> +               return FXLS8962AF_SDCD_CONFIG1_Y_OT_EN & data->enable_eve=
nt;
> +       case IIO_MOD_Z:
> +               return FXLS8962AF_SDCD_CONFIG1_Z_OT_EN & data->enable_eve=
nt;
> +       default:
> +               return -EINVAL;
> +       }
> +}
> +
> +static int
> +fxls8962af_write_event_config(struct iio_dev *indio_dev,
> +                             const struct iio_chan_spec *chan,
> +                             enum iio_event_type type,
> +                             enum iio_event_direction dir, int state)
> +{
> +       struct fxls8962af_data *data =3D iio_priv(indio_dev);
> +       u8 enable_event, enable_bits;
> +       int ret;
> +
> +       if (type !=3D IIO_EV_TYPE_THRESH)
> +               return -EINVAL;
> +
> +       fxls8962af_standby(data);
> +
> +       switch (chan->channel2) {
> +       case IIO_MOD_X:
> +               enable_bits =3D FXLS8962AF_SDCD_CONFIG1_X_OT_EN;
> +               break;
> +       case IIO_MOD_Y:
> +               enable_bits =3D FXLS8962AF_SDCD_CONFIG1_Y_OT_EN;
> +               break;
> +       case IIO_MOD_Z:
> +               enable_bits =3D FXLS8962AF_SDCD_CONFIG1_Z_OT_EN;
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       if (state)
> +               enable_event =3D data->enable_event | enable_bits;
> +       else
> +               enable_event =3D data->enable_event & ~enable_bits;
> +
> +       if (data->enable_event =3D=3D enable_event)
> +               return 0;
> +
> +       /* Enable events */
> +       ret =3D regmap_write(data->regmap, FXLS8962AF_SDCD_CONFIG1, enabl=
e_event | 0x80);
> +       if (ret)
> +               return ret;
> +
> +       /*
> +        * Enable update of SDCD_REF_X/Y/Z values with the current decima=
ted and
> +        * trimmed X/Y/Z acceleration input data. This allows for acceler=
ation
> +        * slope detection with Data(n) to Data(n=E2=80=931) always used =
as the input
> +        * to the window comparator.
> +        */
> +       ret =3D regmap_write(data->regmap, FXLS8962AF_SDCD_CONFIG2, enabl=
e_event ? 0xc0 : 0x00);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D fxls8962af_event_setup(data, state);
> +       if (ret)
> +               return ret;
> +
> +       data->enable_event =3D enable_event;
> +
> +       if (data->enable_event) {
> +               fxls8962af_active(data);
> +               ret =3D fxls8962af_power_on(data);
> +       } else {
> +               if (!iio_buffer_enabled(indio_dev))
> +                       ret =3D fxls8962af_power_off(data);
> +       }
> +
> +       return ret;
> +}
> +
> +static const struct iio_event_spec fxls8962af_event =3D {
> +       .type =3D IIO_EV_TYPE_THRESH,
> +       .dir =3D IIO_EV_DIR_EITHER,
> +       .mask_separate =3D BIT(IIO_EV_INFO_VALUE) | BIT(IIO_EV_INFO_ENABL=
E),
> +};
> +
>  #define FXLS8962AF_CHANNEL(axis, reg, idx) { \
>         .type =3D IIO_ACCEL, \
>         .address =3D reg, \
> @@ -481,6 +690,8 @@ static int fxls8962af_set_watermark(struct iio_dev *i=
ndio_dev, unsigned val)
>                 .shift =3D 4, \
>                 .endianness =3D IIO_BE, \
>         }, \
> +       .event_spec =3D &fxls8962af_event, \
> +       .num_event_specs =3D 1, \
>  }
>
>  #define FXLS8962AF_TEMP_CHANNEL { \
> @@ -522,6 +733,10 @@ static const struct iio_info fxls8962af_info =3D {
>         .read_raw =3D &fxls8962af_read_raw,
>         .write_raw =3D &fxls8962af_write_raw,
>         .write_raw_get_fmt =3D fxls8962af_write_raw_get_fmt,
> +       .read_event_value =3D fxls8962af_read_event,
> +       .write_event_value =3D fxls8962af_write_event,
> +       .read_event_config =3D fxls8962af_read_event_config,
> +       .write_event_config =3D fxls8962af_write_event_config,
>         .read_avail =3D fxls8962af_read_avail,
>         .hwfifo_set_watermark =3D fxls8962af_set_watermark,
>  };
> @@ -605,7 +820,8 @@ static int fxls8962af_buffer_predisable(struct iio_de=
v *indio_dev)
>
>         ret =3D __fxls8962af_fifo_set_mode(data, false);
>
> -       fxls8962af_active(data);
> +       if (data->enable_event)
> +               fxls8962af_active(data);
>
>         return ret;
>  }
> @@ -614,7 +830,10 @@ static int fxls8962af_buffer_postdisable(struct iio_=
dev *indio_dev)
>  {
>         struct fxls8962af_data *data =3D iio_priv(indio_dev);
>
> -       return fxls8962af_power_off(data);
> +       if (!data->enable_event)
> +               fxls8962af_power_off(data);
> +
> +       return 0;
>  }
>
>  static const struct iio_buffer_setup_ops fxls8962af_buffer_ops =3D {
> @@ -725,6 +944,41 @@ static int fxls8962af_fifo_flush(struct iio_dev *ind=
io_dev)
>         return count;
>  }
>
> +static int fxls8962af_event_interrupt(struct iio_dev *indio_dev)
> +{
> +       struct fxls8962af_data *data =3D iio_priv(indio_dev);
> +       s64 ts =3D iio_get_time_ns(indio_dev);
> +       unsigned int reg;
> +       int ret;
> +
> +       ret =3D regmap_read(data->regmap, FXLS8962AF_SDCD_INT_SRC1, &reg)=
;
> +       if (ret)
> +               return ret;
> +
> +       if (reg & FXLS8962AF_SDCD_INT_SRC1_X_OT)
> +               iio_push_event(indio_dev,
> +                               IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, IIO_MOD_=
X,
> +                                       IIO_EV_TYPE_THRESH,
> +                                       IIO_EV_DIR_EITHER),
> +                               ts);
> +
> +       if (reg & FXLS8962AF_SDCD_INT_SRC1_Y_OT)
> +               iio_push_event(indio_dev,
> +                               IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, IIO_MOD_=
Y,
> +                                       IIO_EV_TYPE_THRESH,
> +                                       IIO_EV_DIR_EITHER),
> +                               ts);
> +
> +       if (reg & FXLS8962AF_SDCD_INT_SRC1_Z_OT)
> +               iio_push_event(indio_dev,
> +                               IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, IIO_MOD_=
Z,
> +                                       IIO_EV_TYPE_THRESH,
> +                                       IIO_EV_DIR_EITHER),
> +                               ts);
> +
> +       return ret;
> +}
> +
>  static irqreturn_t fxls8962af_interrupt(int irq, void *p)
>  {
>         struct iio_dev *indio_dev =3D p;
> @@ -744,6 +998,14 @@ static irqreturn_t fxls8962af_interrupt(int irq, voi=
d *p)
>                 return IRQ_HANDLED;
>         }
>
> +       if (reg & FXLS8962AF_INT_STATUS_SRC_SDCD_OT) {
> +               ret =3D fxls8962af_event_interrupt(indio_dev);
> +               if (ret < 0)
> +                       return IRQ_NONE;
> +
> +               return IRQ_HANDLED;
> +       }
> +
>         return IRQ_NONE;
>  }
>
> --
> 2.33.0
>


--=20
With Best Regards,
Andy Shevchenko
