Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D5458C799
	for <lists+linux-iio@lfdr.de>; Mon,  8 Aug 2022 13:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242548AbiHHLgo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Aug 2022 07:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbiHHLgn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Aug 2022 07:36:43 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094D4CCD;
        Mon,  8 Aug 2022 04:36:41 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id s2so6213191qtx.6;
        Mon, 08 Aug 2022 04:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=DVU4OEHOSh/MsBPduiHfw1uKK384DVNhq4wS24Fsn54=;
        b=GAQo1kTtCoWRwwEGXthErSNCQj0QmRRc1M5VhaeoruIYxg66VoZfpAFt874QcOmDEO
         0Nt1BpC/iO1Hya7yTOuNhnACn0uhH5yTCLHLm3d9wEuTp+ShzyskHvzCUD4cJr2N5Hkw
         TPEvSsAxvfPqCtTCduFeUIC5iDNVITC/fkUKLQjahf+fhTzDN0vf6x34PraZKdWlGBep
         KMku8vuHocON7Qur48DOKv6qBvNJdZB92J70F/3GzMa1ZzVr54neShwwMSUCDGzLtsSY
         PXXCaqhns3tbVIVt/fN8ru3yq+csSOXpB7TuVNe/lxI0fZAWDto3zAN1TjYkOxKnUAPD
         pOAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=DVU4OEHOSh/MsBPduiHfw1uKK384DVNhq4wS24Fsn54=;
        b=S+meEXd2fMa9GFkYGnU+lsg1szEzekwtwEOR2IyHFy6xvFaipL/CqjzJhoYuQivlJV
         cA0/qaI38Hj/z3SXVEH+ir/M2sVPLLf+8JBIz1d7XYsWw2r+ZhtQp+3FDdS2TKkRu7Hl
         ezY4IcboYAzOarQ0MYAB4s+wFnqS7BrKBFLr2Xyn7NxlSdcWsJpx4Ll/uMHv+jMmW3l7
         0tddpu0X+ZNeIRhtXbPBIc2z7dNmoLHmGBG9Mv7FAZP4ue4tWL4d/frah6Ni/3PWr0nd
         QNwAY7OSACjzMVvpp5J17/M9qcKoDJJJAvFJJGqVoimN5BP7TRSmam6tzKmPhuqwTzjx
         b2DA==
X-Gm-Message-State: ACgBeo3qBfQgUud2m7HuO+2Lcve797wkZswQYa5gFYkWtxd1xog5N9YL
        Nqex8tQf3O+1Cfxy4ViSePqeCEzIUAuTIzmUEkkMByWZh02Cow==
X-Google-Smtp-Source: AA6agR4weuoKdBzDaMBSBe6GTKnjFb9dQyp1jaHARchkPc1Rg78v5ZhXOMwTiprcTVEuHM4ExfwazyYLEtucaMyXUOs=
X-Received: by 2002:a05:622a:48f:b0:343:463:351a with SMTP id
 p15-20020a05622a048f00b003430463351amr64823qtx.61.1659958600028; Mon, 08 Aug
 2022 04:36:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1659909060.git.jahau@rocketmail.com> <2a93df6f99913e438dd2d394c074cf79544ab692.1659909060.git.jahau@rocketmail.com>
In-Reply-To: <2a93df6f99913e438dd2d394c074cf79544ab692.1659909060.git.jahau@rocketmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Aug 2022 13:36:02 +0200
Message-ID: <CAHp75VfSx+bnNRqmkEP=NAM=yssw2xvtQ1qzrDw_J3eLZwaZYA@mail.gmail.com>
Subject: Re: [PATCH v5 12/14] iio: magnetometer: yas530: Add temperature
 calculation to "chip_info"
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Aug 8, 2022 at 1:07 AM Jakob Hauser <jahau@rocketmail.com> wrote:
>
> Add temperature calculation to the "chip_info" structure to ease the hand=
ling
> of different YAS variants.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
> ---
>  drivers/iio/magnetometer/yamaha-yas530.c | 140 ++++++++++++-----------
>  1 file changed, 71 insertions(+), 69 deletions(-)
>
> diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magne=
tometer/yamaha-yas530.c
> index 262a36c31616..780c7f4d1eff 100644
> --- a/drivers/iio/magnetometer/yamaha-yas530.c
> +++ b/drivers/iio/magnetometer/yamaha-yas530.c
> @@ -79,7 +79,6 @@
>  #define YAS530_DATA_BITS               12
>  #define YAS530_DATA_CENTER             BIT(YAS530_DATA_BITS - 1)
>  #define YAS530_DATA_OVERFLOW           (BIT(YAS530_DATA_BITS) - 1)
> -#define YAS530_20DEGREES               182 /* Counts starting at -62 =C2=
=B0C */
>
>  #define YAS532_DEVICE_ID               0x02 /* YAS532/YAS533 (MS-3R/F) *=
/
>  #define YAS532_VERSION_AB              0 /* YAS532/533 AB (MS-3R/F AB) *=
/
> @@ -91,7 +90,6 @@
>  #define YAS532_DATA_BITS               13
>  #define YAS532_DATA_CENTER             BIT(YAS532_DATA_BITS - 1)
>  #define YAS532_DATA_OVERFLOW           (BIT(YAS532_DATA_BITS) - 1)
> -#define YAS532_20DEGREES               390 /* Counts starting at -50 =C2=
=B0C */
>
>  /* Turn off device regulators etc after 5 seconds of inactivity */
>  #define YAS5XX_AUTOSUSPEND_DELAY_MS    5000
> @@ -119,6 +117,31 @@ static const int yas530_volatile_reg[] =3D {
>         YAS530_MEASURE,
>  };
>
> +/*
> + * t_ref_counts is the number of counts at reference temperature.
> + *
> + * The temperature value at YAS magnetometers is a number of counts. The
> + * values in t_ref_counts[] are the counts at the reference temperature
> + * of 20 =C2=B0C.
> + *
> + * For YAS532/533, this value is known from the Android driver. For YAS5=
30,
> + * it was approximately measured.
> + */
> +static const u16 t_ref_counts[] =3D { 182, 390, 390 };
> +
> +/*
> + * min_temp_celsius_x10 is the starting point of temperature counting
> + * in 1/10:s degrees Celsius.
> + *
> + * The array min_temp_celsius_x10[] contains the temperatures where the
> + * temperature value count is 0. The values are in 1/10:s degrees Celsiu=
s
> + * to ease the further temperature calculation.
> + *
> + * These temperatures are derived from the temperature resolutions given
> + * in the data sheets.
> + */
> +static const s16 min_temp_celsius_x10[] =3D { -620, -500, -500 };
> +
>  struct yas5xx_calibration {
>         /* Linearization calibration x, y1, y2 */
>         s32 r[3];
> @@ -143,6 +166,8 @@ struct yas5xx;
>   * @volatile_reg: device-specific volatile registers
>   * @volatile_reg_qty: quantity of device-specific volatile registers
>   * @scaling_val2: scaling value for IIO_CHAN_INFO_SCALE
> + * @t_ref: number of counts at reference temperature
> + * @min_temp_x10: starting point of temperature counting in 1/10:s degre=
es Celsius
>   */
>  struct yas5xx_chip_info {
>         unsigned int devid;
> @@ -151,6 +176,8 @@ struct yas5xx_chip_info {
>         const int *volatile_reg;
>         int volatile_reg_qty;
>         u32 scaling_val2;
> +       u16 t_ref;
> +       s16 min_temp_x10;
>  };
>
>  /**
> @@ -349,6 +376,20 @@ static s32 yas530_linearize(struct yas5xx *yas5xx, u=
16 val, int axis)
>                 (yas5xx->hard_offsets[axis] - c->r[axis]) * coef;
>  }
>
> +static s32 yas5xx_calc_temperature(struct yas5xx *yas5xx, u16 t)
> +{
> +       s32 to;
> +       u16 t_ref;
> +       int min_temp_x10, ref_temp_x10;
> +
> +       t_ref =3D yas5xx->chip_info->t_ref;
> +       min_temp_x10 =3D yas5xx->chip_info->min_temp_x10;
> +       ref_temp_x10 =3D 200;
> +
> +       to =3D (min_temp_x10 + ((ref_temp_x10 - min_temp_x10) * t / t_ref=
)) * 100;
> +       return to;
> +}
> +
>  /**
>   * yas530_get_measure() - Measure a sample of all axis and process
>   * @yas5xx: The device state
> @@ -363,7 +404,7 @@ static s32 yas530_linearize(struct yas5xx *yas5xx, u1=
6 val, int axis)
>  static int yas530_get_measure(struct yas5xx *yas5xx, s32 *to, s32 *xo, s=
32 *yo, s32 *zo)
>  {
>         struct yas5xx_calibration *c =3D &yas5xx->calibration;
> -       u16 t_ref, t, x, y1, y2;
> +       u16 t_ref, t_comp, t, x, y1, y2;
>         /* These are signed x, signed y1 etc */
>         s32 sx, sy1, sy2, sy, sz;
>         int ret;
> @@ -378,47 +419,30 @@ static int yas530_get_measure(struct yas5xx *yas5xx=
, s32 *to, s32 *xo, s32 *yo,
>         sy1 =3D yas530_linearize(yas5xx, y1, 1);
>         sy2 =3D yas530_linearize(yas5xx, y2, 2);
>
> -       /* Set the temperature reference value (unit: counts) */
> -       switch (yas5xx->chip_info->devid) {
> -       case YAS530_DEVICE_ID:
> -               t_ref =3D YAS530_20DEGREES;
> -               break;
> -       case YAS532_DEVICE_ID:
> -               t_ref =3D YAS532_20DEGREES;
> -               break;
> -       default:
> -               dev_err(yas5xx->dev, "unknown device type\n");
> -               return -EINVAL;
> -       }
> -
> -       /* Temperature compensation for x, y1, y2 respectively */
> +       /*
> +        * Set the temperature for compensation (unit: counts):
> +        * YAS532/YAS533 version AC uses the temperature deviation as a
> +        * multiplier. YAS530 and YAS532 version AB use solely the t valu=
e.
> +        */
> +       t_ref =3D yas5xx->chip_info->t_ref;
>         if (yas5xx->chip_info->devid =3D=3D YAS532_DEVICE_ID &&
>             yas5xx->version =3D=3D YAS532_VERSION_AC) {
> -               /*
> -                * YAS532 version AC uses the temperature deviation as a
> -                * multiplier.
> -                *
> -                *          Cx * (t - t_ref)
> -                * x' =3D x - ----------------
> -                *                100
> -                */
> -               sx =3D sx - (c->Cx * (t - t_ref)) / 100;
> -               sy1 =3D sy1 - (c->Cy1 * (t - t_ref)) / 100;
> -               sy2 =3D sy2 - (c->Cy2 * (t - t_ref)) / 100;
> +               t_comp =3D t - t_ref;
>         } else {
> -               /*
> -                * YAS530 and YAS532 version AB use solely the t value as=
 a
> -                * multiplier.
> -                *
> -                *          Cx * t
> -                * x' =3D x - ------
> -                *           100
> -                */
> -               sx =3D sx - (c->Cx * t) / 100;
> -               sy1 =3D sy1 - (c->Cy1 * t) / 100;
> -               sy2 =3D sy2 - (c->Cy2 * t) / 100;
> +               t_comp =3D t;
>         }
>
> +       /*
> +        * Temperature compensation for x, y1, y2 respectively:
> +        *
> +        *          Cx * t_comp
> +        * x' =3D x - -----------
> +        *              100
> +        */
> +       sx =3D sx - (c->Cx * t_comp) / 100;
> +       sy1 =3D sy1 - (c->Cy1 * t_comp) / 100;
> +       sy2 =3D sy2 - (c->Cy2 * t_comp) / 100;
> +
>         /*
>          * Break y1 and y2 into y and z, y1 and y2 are apparently encodin=
g
>          * y and z.
> @@ -426,36 +450,8 @@ static int yas530_get_measure(struct yas5xx *yas5xx,=
 s32 *to, s32 *xo, s32 *yo,
>         sy =3D sy1 - sy2;
>         sz =3D -sy1 - sy2;
>
> -       /* Process temperature readout */
> -       switch (yas5xx->chip_info->devid) {
> -       case YAS530_DEVICE_ID:
> -               /*
> -                * Raw temperature value t is the number of counts starti=
ng
> -                * at -62 =C2=B0C. Reference value t_ref is the number of=
 counts
> -                * between -62 =C2=B0C and 20 =C2=B0C (82 =C2=B0C range).
> -                *
> -                * Temperature in =C2=B0C would be (82 / t_ref * t) - 62.
> -                *
> -                * Contrary to this, perform multiplication first and div=
ision
> -                * second due to calculating with integers.
> -                *
> -                * To get a nicer result, calculate with 1/10:s degrees C=
elsius
> -                * and finally multiply by 100 to return millidegrees Cel=
sius.
> -                */
> -               *to =3D ((820 * t / t_ref) - 620) * 100;
> -               break;
> -       case YAS532_DEVICE_ID:
> -               /*
> -                * Actually same procedure for YAS532 but the starting po=
int is
> -                * at -50 =C2=B0C. Reference value t_ref is the number of=
 counts
> -                * between -50 =C2=B0C and 20 =C2=B0C (70 =C2=B0C range).
> -                */
> -               *to =3D ((700 * t / t_ref) - 500) * 100;
> -               break;
> -       default:
> -               dev_err(yas5xx->dev, "unknown device type\n");
> -               return -EINVAL;
> -       }
> +       /* Calculate temperature readout */
> +       *to =3D yas5xx_calc_temperature(yas5xx, t);
>
>         /*
>          * Calibrate [x,y,z] with some formulas like this:
> @@ -943,6 +939,8 @@ static const struct yas5xx_chip_info yas5xx_chip_info=
_tbl[] =3D {
>                 .volatile_reg =3D yas530_volatile_reg,
>                 .volatile_reg_qty =3D ARRAY_SIZE(yas530_volatile_reg),
>                 .scaling_val2 =3D 100000000, /* picotesla to Gauss */
> +               .t_ref =3D t_ref_counts[yas530],
> +               .min_temp_x10 =3D min_temp_celsius_x10[yas530],
>         },
>         [yas532] =3D {
>                 .devid =3D YAS532_DEVICE_ID,
> @@ -951,6 +949,8 @@ static const struct yas5xx_chip_info yas5xx_chip_info=
_tbl[] =3D {
>                 .volatile_reg =3D yas530_volatile_reg,
>                 .volatile_reg_qty =3D ARRAY_SIZE(yas530_volatile_reg),
>                 .scaling_val2 =3D 100000, /* nanotesla to Gauss */
> +               .t_ref =3D t_ref_counts[yas532],
> +               .min_temp_x10 =3D min_temp_celsius_x10[yas532],
>         },
>         [yas533] =3D {
>                 .devid =3D YAS532_DEVICE_ID,
> @@ -959,6 +959,8 @@ static const struct yas5xx_chip_info yas5xx_chip_info=
_tbl[] =3D {
>                 .volatile_reg =3D yas530_volatile_reg,
>                 .volatile_reg_qty =3D ARRAY_SIZE(yas530_volatile_reg),
>                 .scaling_val2 =3D 100000, /* nanotesla to Gauss */
> +               .t_ref =3D t_ref_counts[yas533],
> +               .min_temp_x10 =3D min_temp_celsius_x10[yas533],
>         },
>  };
>
> --
> 2.35.1
>


--=20
With Best Regards,
Andy Shevchenko
