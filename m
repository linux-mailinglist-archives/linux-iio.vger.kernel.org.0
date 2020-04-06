Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A24B119FA00
	for <lists+linux-iio@lfdr.de>; Mon,  6 Apr 2020 18:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbgDFQTm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Apr 2020 12:19:42 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46932 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728802AbgDFQTm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Apr 2020 12:19:42 -0400
Received: by mail-pg1-f195.google.com with SMTP id k191so138748pgc.13;
        Mon, 06 Apr 2020 09:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oa630XzomU4aKMww5XPentv1Soe/ZbLABSO++PNFqs0=;
        b=aqKQfC2j1EtWORNiX4VgxmMztGjb35unU4GdvAMFBwhin7sem4OKIy3z49zGwXOVfS
         VpF6XarXErLaQsxPJ2rqcvnQZKNA14z1/xM3a4J/+Z/tOldiJBMpsLRExlldLq0mhzyy
         IUkWeK+rSRD5JwJoEfMyz3nIHV5M8tl4y2j1yKrJ3f7c1NnyFnGGWi+OxUqJ2QlzY5VV
         pEe/guSd252MxJRhFTEJocKAEPNjVk7n8RNPP3hEIogaeocCUyZs64H3uKOHBmBk0naT
         D2gwTJDo8tX8XF9ep2t38ZjR5lHKuaYpA00JHRJKpzKbOwjAOIDSYcMZwZauhEaDJ/JW
         +Yjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oa630XzomU4aKMww5XPentv1Soe/ZbLABSO++PNFqs0=;
        b=j9jmTcT0ouwhNsle1lDecYIoVvaUrDk1IuD/f000pXXKFTmJQ40fdVto3mT/FnDEjo
         32t/WxMS/IlRB86cbEWDBLO38or6Svf1Zjejm07r87VLZowFTfRyq/YCUum7exrpfwUq
         f/wh8mLR+7HnUBUf36KHFY6wsxbRI27MM2Phsk6+g8dWJyk82VovPFOlAN1o8NqLrC/8
         ipMrmeP333Sbn+J5C4Giq+oYtFbLl37K466N5msGe6SzLcbPvO2V8CY/OMmC39A1GCbm
         oPQXD1xA9LSBypPkZ1CVoQM5XAY9oirqL+gQrX562qVsPLYwkh3WnXqoY0M/mBjQ51n+
         onPQ==
X-Gm-Message-State: AGi0PuYOsrD1djWqoyp7K001ay329Omp4IdXCDHZTBtN7p6h7s23VO4Z
        1oKld4M8gvdFNU2w3mI+f+61H386F3MWlmhp5RE=
X-Google-Smtp-Source: APiQypJU+5ObmGWWzP72qOYvrzN6MOlLYHJRMcoUevfMEqea7emG1qqaRhegC8m0z8uNHfnVVLeFLZhlLL3aAyMhlIg=
X-Received: by 2002:a63:1d4:: with SMTP id 203mr9970690pgb.74.1586189978891;
 Mon, 06 Apr 2020 09:19:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200406150846.878-1-nuno.sa@analog.com> <20200406150846.878-6-nuno.sa@analog.com>
In-Reply-To: <20200406150846.878-6-nuno.sa@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 6 Apr 2020 19:19:31 +0300
Message-ID: <CAHp75VeK8K0WHK3gDwyT3ZAaMaVdfZ5xVG94JY4O8fd2U0HEHg@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] iio: imu: Add support for adis16475
To:     =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandru Ardelean <alexandru.Ardelean@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Apr 6, 2020 at 6:10 PM Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
>
> Support ADIS16475 and similar IMU devices. These devices are
> a precision, miniature MEMS inertial measurement unit (IMU) that
> includes a triaxial gyroscope and a triaxial accelerometer. Each
> inertial sensor combines with signal conditioning that optimizes
> dynamic performance.
>
> The driver adds support for the following devices:
>  * adis16470, adis16475, adis16477, adis16465, adis16467, adis16500,
>    adis16505, adis16507.

...

> +       int i =3D ARRAY_SIZE(adis16475_3db_freqs);
> +       int ret;

> +       while (--i)
> +               if (adis16475_3db_freqs[i] >=3D filter)
> +                       break;

Nit: perhaps {} to add.

...

> +enum adis16475_variant {
> +       ADIS16470,
> +       ADIS16475_1,
> +       ADIS16475_2,
> +       ADIS16475_3,
> +       ADIS16477_1,
> +       ADIS16477_2,
> +       ADIS16477_3,
> +       ADIS16465_1,
> +       ADIS16465_2,
> +       ADIS16465_3,
> +       ADIS16467_1,
> +       ADIS16467_2,
> +       ADIS16467_3,
> +       ADIS16500,
> +       ADIS16505_1,
> +       ADIS16505_2,
> +       ADIS16505_3,
> +       ADIS16507_1,
> +       ADIS16507_2,
> +       ADIS16507_3,

> +

Extra blank line.

> +};

...

> +static void adis16475_burst32_check(struct adis16475 *st)
> +{
> +       int ret;
> +       struct adis *adis =3D &st->adis;
> +
> +       if (!st->info->has_burst32)
> +               return;
> +
> +       if (st->lsb_flag && !st->burst32) {
> +               const u16 en =3D ADIS16500_BURST32(1);
> +
> +               ret =3D __adis_update_bits(&st->adis, ADIS16475_REG_MSG_C=
TRL,
> +                                        ADIS16500_BURST32_MASK, en);
> +               if (ret)
> +                       return;
> +
> +               st->burst32 =3D true;

+ Blank line.

> +               /*
> +                * In 32bit mode we need extra 2 bytes for all gyro

32-bit

> +                * and accel channels.
> +                */
> +               adis->burst_extra_len =3D 6 * sizeof(u16);
> +               adis->xfer[1].len +=3D 6 * sizeof(u16);
> +               dev_dbg(&adis->spi->dev, "Enable burst32 mode, xfer:%d",
> +                       adis->xfer[1].len);
> +
> +       } else if (!st->lsb_flag && st->burst32) {
> +               const u16 en =3D ADIS16500_BURST32(0);
> +
> +               ret =3D __adis_update_bits(&st->adis, ADIS16475_REG_MSG_C=
TRL,
> +                                        ADIS16500_BURST32_MASK, en);
> +               if (ret)
> +                       return;
> +
> +               st->burst32 =3D false;

+ Blank line

> +               /* Remove the extra bits */
> +               adis->burst_extra_len =3D 0;
> +               adis->xfer[1].len -=3D 6 * sizeof(u16);
> +               dev_dbg(&adis->spi->dev, "Disable burst32 mode, xfer:%d\n=
",
> +                       adis->xfer[1].len);
> +       }
> +}

...

> +       for_each_set_bit(bit, indio_dev->active_scan_mask,
> +                        indio_dev->masklength) {

One line?

> +                               if (st->lsb_flag && !st->info->has_burst3=
2) {
> +                                       u16 val =3D 0;

> +                                       const u32 reg =3D ADIS16475_REG_X=
_GYRO_L +
> +                                               (bit * 4);

Redundant parentheses.

> +                                       adis_read_reg_16(adis, reg, &val)=
;
> +                                       data[i++] =3D cpu_to_be16(val);
> +                               } else {
> +                                       /* lower not used */
> +                                       data[i++] =3D 0;
> +                               }
> +                       }
> +                       break;
> +               }
> +       }

...

> +               if (sync->sync_mode =3D=3D ADIS16475_SYNC_SCALED) {
> +                       u16 up_scale;
> +                       u32 scaled_out_freq =3D 0;
> +                       /*
> +                        * If we are in scaled mode, we must have an up_s=
cale.
> +                        * In scaled mode the allowable input clock range=
 is
> +                        * 1 Hz to 128 Hz, and the allowable output range=
 is
> +                        * 1900 to 2100 Hz. Hence, a scale must be given =
to
> +                        * get the allowable output.
> +                        */
> +                       device_property_read_u32(dev, "adi,scaled-output-=
hz",
> +                                                &scaled_out_freq);
> +
> +                       if (scaled_out_freq < 1900 || scaled_out_freq > 2=
100) {
> +                               dev_err(dev,
> +                                       "Invalid value:%u for adi,scaled-=
output-hz",
> +                                       scaled_out_freq);

When there is no property or property has a value 0 this message can't
tell the difference.
Perhaps you have to check return code from device_property_read_u32() call.

> +                               return -EINVAL;
> +                       }

> +               }

...

> +       /*
> +        * It is possible to configure the data ready polarity. Furthermo=
re, we
> +        * need to update the adis struct if we want data ready as active=
 low.
> +        */
> +       irq_type =3D irqd_get_trigger_type(desc);
> +       if (irq_type =3D=3D IRQF_TRIGGER_RISING) {
> +               polarity =3D 1;
> +       } else if (irq_type =3D=3D IRQF_TRIGGER_FALLING) {
> +               polarity =3D 0;
> +               st->adis.irq_flag =3D IRQF_TRIGGER_FALLING;
> +       } else {
> +               dev_err(&spi->dev, "Invalid interrupt type 0x%x specified=
\n",
> +                       irq_type);
> +               return -EINVAL;
> +       }

Here is the problem. You got type, but you compare it to flags. It's
not correct.
Although values are the same, the meaning is different.

--
With Best Regards,
Andy Shevchenko
