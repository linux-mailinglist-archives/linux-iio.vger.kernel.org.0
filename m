Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4237A18F419
	for <lists+linux-iio@lfdr.de>; Mon, 23 Mar 2020 13:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbgCWMKg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Mar 2020 08:10:36 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35964 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727384AbgCWMKf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Mar 2020 08:10:35 -0400
Received: by mail-pg1-f194.google.com with SMTP id j29so218362pgl.3;
        Mon, 23 Mar 2020 05:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MlNbdsKoZglu02JmE6j7s82pOmi6hUKrXhzXXYWzb3U=;
        b=b8v722V3lHjGLReQGi5K9OvQK6x9ONT+ZTYq1NU0THWLfDdApSvvP/M8z9/kxQrlRD
         jg58JB8Ve57GDm99BztkqNxw3AM7mmQRs7FxA0ETQ++matXgRTHh3cj9Vt6um3V+RbK+
         w7cR/bdN0Tq03HcSpAf/3hgUAqvLK/4a4QTwvAwSqyNI1kPFd+pSEkTMT8nRmRWGLEFx
         u8AQBvi0moW8dQHBLGDkFnRVO/PDrJW9q338CnEcAP4esOeFQClvR2p+e70aV+wRE6LI
         h8G2MDiT2hBXf2x0FyEWrNIuGdwKhzjixduxxWNADDVof9TvDrl4MpjICbjquVRH8ktb
         6RVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MlNbdsKoZglu02JmE6j7s82pOmi6hUKrXhzXXYWzb3U=;
        b=nfhNGkiJ2aS2LeJuB0+7QYuwY8wDhIlPfPddG4LUx0LGjRryAGQwd93GJa+65Bi7Qd
         5y5KGqBLjx4VOPmh4QDuEzk27uHSU/HV1TH2N4SQONW+wAvs6/FeJkESEhHYJEBErsy8
         pPEydpR1QAdo+k1uazfW1lz0QJ7EcsXgDl5LT+cTf5HLDSP7LfaRdv1NbPOaLlLqRRhE
         BUdYSxPqHe15q7otDW+NiF80gXdtQRUg9rzUu5/NE38CPBufo1UiV7FyD6iVWKXK4E9+
         prijj1zcvlgt01qyT05cOi6nvvhX6EhxeVukKgFbFb8aBne1jIHG98us3iSmqm7QaqOg
         OXlg==
X-Gm-Message-State: ANhLgQ15I7ZeSQUaUJf0k6bb69CpmJLraq5u5jiOZ/RCYeQjxAKigc73
        8BELdYt3/40DO6UQ1IIomcMS6NCoQVuUOf66SXU=
X-Google-Smtp-Source: ADFU+vtPHwwDms34oGPAgbK5FoVt8CGhBDYsS8GEceo6UTeFwpey3XsHjBzgJHRFUoWAlESzy6YFOA7a0a8rw7ZYkfU=
X-Received: by 2002:a63:798a:: with SMTP id u132mr22684974pgc.203.1584965434383;
 Mon, 23 Mar 2020 05:10:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200323103926.21271-1-i.mikhaylov@yadro.com> <20200323103926.21271-3-i.mikhaylov@yadro.com>
In-Reply-To: <20200323103926.21271-3-i.mikhaylov@yadro.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 23 Mar 2020 14:10:27 +0200
Message-ID: <CAHp75Ve4rejBKjG+mioRL3S7i3meyy=_4TtW1fr2aGvnVn2tBA@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: proximity: Add driver support for vcnl3020
 proximity sensor
To:     Ivan Mikhaylov <i.mikhaylov@yadro.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Mar 23, 2020 at 12:41 PM Ivan Mikhaylov <i.mikhaylov@yadro.com> wro=
te:
>
> Proximity sensor driver based on light/vcnl4000.c code.
> For now supports only the single on-demand measurement.
>
> The VCNL3020 is a fully integrated proximity sensor. Fully
> integrated means that the infrared emitter is included in the
> package. It has 16-bit resolution. It includes a signal
> processing IC and features standard I2C communication
> interface. It features an interrupt function.

Thank you for a patch, my comments below.

> Datasheet available at:
> http://www.vishay.com/docs/84150/vcnl3020.pdf

I'm thinking that we may simple introduce new tag, called Datesheet:
to put such links.

> Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>

...

>  obj-$(CONFIG_SRF08)            +=3D srf08.o
>  obj-$(CONFIG_SX9500)           +=3D sx9500.o
>  obj-$(CONFIG_VL53L0X_I2C)      +=3D vl53l0x-i2c.o
> +obj-$(CONFIG_VCNL3020)         +=3D vcnl3020.o

Perhaps keep ordered?

...

> +/*
> + * vcnl3020.c - Support for Vishay VCNL3020 proximity sensor

Using file names in themselves is a bad idea. Whenever you would
rename file (for instance, to support new sensors from the same family
in the future) you will forget (often, I see this in practice!) to
update this line.
Just drop it from here and try to avoid in the future.

> + *
> + * based on vcnl4000.c

This sounds like a continuation of previous sentence. Drop line in
between and use proper English grammar and punctuation.

> + */

...

> +struct vcnl3020_data {
> +       struct i2c_client *client;
> +       u32 rev;

> +       struct mutex vcnl3020_lock; /* for i2c operations */

Simple 'lock' is enough, the rest is dup noise.
Also, consider kernel doc format instead of odd comments.

> +};

...

> +static const struct i2c_device_id vcnl3020_id[] =3D {
> +       { "vcnl3020", 0 },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(i2c, vcnl3020_id);

Can you group this with OF table below?

...

> +static int32_t vcnl3020_init(struct vcnl3020_data *data)

int32_t...

> +{

> +       s32 rc;

...s32?!

Applies to entire code.

> +       u32 led_current;
> +       struct device *dev =3D &data->client->dev;

Reversed xmas tree order looks better.

> +       rc =3D i2c_smbus_read_byte_data(data->client, VCNL_PROD_REV);

Can you use regmap I=C2=B2C API?

> +       if (rc < 0) {
> +               dev_err(dev, "Error (%d) reading product revision", rc);
> +               goto exit;
> +       }
> +

> +       if (rc =3D=3D VCNL3020_PROD_ID) {
> +               data->rev =3D rc & 0xff;

This conjunction looks strange. Also, why type of rev is u32 instead of u8?

> +               mutex_init(&data->vcnl3020_lock);
> +       } else {
> +               dev_err(dev, "Product id (%x) did not match vcnl3020 (%x)=
", rc,
> +                       VCNL3020_PROD_ID);
> +               rc =3D -ENODEV;
> +               goto exit;
> +       }
> +
> +       /* set led current */
> +       rc =3D i2c_smbus_write_byte_data(data->client, VCNL_LED_CURRENT,
> +                                      led_current);
> +       if (rc < 0) {
> +               dev_err(dev, "Error (%d) setting LED current", rc);
> +               goto exit;
> +       }
> +
> +       return 0;

> +exit:
> +       return rc;

Useless. Return directly.

> +};

...

> +       /* wait for data to become ready */
> +       while (tries--) {
> +               rc =3D i2c_smbus_read_byte_data(data->client, VCNL_COMMAN=
D);
> +               if (rc < 0)
> +                       goto fail;
> +               if (rc & VCNL_PS_RDY)
> +                       break;
> +               msleep(20); /* measurement takes up to 100 ms */
> +       }

Timeout loops look more naturally in do {} while format.

  unsigned int tries =3D 5;
  ...

  do {
  ...
  } while (--tries);

...

> +       *val =3D (rc & 0xff) << 8;

> +       *val |=3D rc & 0xff;

All these conjunctions looks fishy. Why do you need them? Cant you
rely on the returned value by I=C2=B2C API?

...

> +fail:

Better name is 'err_unlock' or 'out_unlock'. The rule of thumb to
describe in the label what you *about to do* there.

> +       mutex_unlock(&data->vcnl3020_lock);
> +
> +       return rc;
> +}

...

> +                       rc =3D vcnl3020_measure_proximity(data, val);
> +                       if (rc < 0)

Can rc be positive? Drop all these ' < 0' in cases where it is
guaranteed not to be the case.

> +                               return rc;

...

> +static int32_t vcnl3020_probe(struct i2c_client *client,
> +                             const struct i2c_device_id *id)

Can you switch to ->probe_new() ?

...

> +       dev_info(&client->dev, "Proximity sensor, Rev: %02x\n",
> +                data->rev);

Noise.

...

> +       rc =3D devm_iio_device_register(&client->dev, indio_dev);
> +       if (rc !=3D 0)

Redundant ' !=3D 0' part.

> +               goto out;
> +
> +       return rc;

> +out:
> +       devm_iio_device_free(&client->dev, indio_dev);
> +       return rc;

Managed resources are exactly for this not to be appeared in the code.

> +}

...

> +static const struct of_device_id vcnl3020_of_match[] =3D {
> +       {
> +               .compatible =3D "vishay,vcnl3020",
> +       },

Missed terminator. How did you test this?

> +};

--
With Best Regards,
Andy Shevchenko
