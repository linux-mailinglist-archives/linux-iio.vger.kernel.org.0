Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D827565E15
	for <lists+linux-iio@lfdr.de>; Mon,  4 Jul 2022 21:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbiGDTiJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 Jul 2022 15:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiGDTiJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Jul 2022 15:38:09 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637379FCB;
        Mon,  4 Jul 2022 12:38:08 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-31bf3656517so89774407b3.12;
        Mon, 04 Jul 2022 12:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oszJ77F2FRLFZiRT4PLikjAIOd77jSDJ8S6luXx4hmo=;
        b=dlEoiNMn5VqJxHvwRxY77Cpk71emtQfaetnUv5+QegcQtPAUlXH3Er1dbx7mzrzcv/
         wQoF43D+Fc8iVhFxhm54vAv0Qan+VvZ7aMEOWWd8CDpjfTYXNb9iNU0xMUB9ODt/ezj0
         E1OGGnbB5EQLtFWpRFacDzXWKFXZiBwZJgs24e73O/ywCk0S1KhZEPc4b9kOpRNDwGmX
         OtVtVrw2//WfUDjF9iwY7JgjlzaxIr04VoG/V8yWf6RhbTR4MB7vU459Q0duEsoMuAWo
         9RYUcrE+8d7US2zgl3TjY1Z65kNSmK280CTHOhEbpiBShGhUo20cd7LCsA9lo9MGijFq
         WsYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oszJ77F2FRLFZiRT4PLikjAIOd77jSDJ8S6luXx4hmo=;
        b=u7RulcDtFnf+mHNRKhcOc9H1aj4MkbtN+yqfSqUPRhrU8MfFtwX5Hr71hIxiCSsbWA
         iwLrTbmQh95Osr9JRmQkodJmBMk6KWwLZCvgbNzD7WN2GJCeY9jYh3Uzc6C0NGcJpnZ7
         /8Yq8N5JkB7CIol3iVxgLvebLWX0yy7frgaI3wHMhh+jSS72fPrt0ED4l2vOg/iSSkB/
         GfYVgBbSwYdhDV7h9NHj7CRBCrPNjMU4q+Vsck53ne/ND5sx+k0biRgAdal7n58+W0+E
         tNmAhpVW485s0vLMonoeMvmC2FW1w/cW1MYJYgpU0pMdKQU0T5XpkckSrfT1ts7hW7cF
         FBWA==
X-Gm-Message-State: AJIora9S4/BPT9yPf1kR6cvGh85crDXHfwhf+lBO1J3jB1N68vFonOdt
        +zKjACoQe9f3jS10ctpvSVUUDJIfAzmSWqetnCg=
X-Google-Smtp-Source: AGRyM1t2Z/Sss9bJC+w75RUZhUMQh0sX0Ici3Q4T3BXacm2+e94SGpCxT3mlrBHed6OSdfiPng27zOzhO4TqvHYpqDk=
X-Received: by 2002:a81:3984:0:b0:31c:b59e:a899 with SMTP id
 g126-20020a813984000000b0031cb59ea899mr2577964ywa.195.1656963487512; Mon, 04
 Jul 2022 12:38:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1656883851.git.jahau@rocketmail.com> <28a2a9ec27c6fb4073149b897415475a8f04e3f7.1656883851.git.jahau@rocketmail.com>
In-Reply-To: <28a2a9ec27c6fb4073149b897415475a8f04e3f7.1656883851.git.jahau@rocketmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 4 Jul 2022 21:37:30 +0200
Message-ID: <CAHp75VfGqk_q1iDyj06tEuTNoG35xjOL0_5HgokFauUz_aAwFQ@mail.gmail.com>
Subject: Re: [PATCH v4 09/10] iio: magnetometer: yas530: Introduce "chip_info" structure
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

On Mon, Jul 4, 2022 at 12:04 AM Jakob Hauser <jahau@rocketmail.com> wrote:
>
> This commit introduces the "chip_info" structure approach for better vari=
ant
> handling.
>
> The variant to be used is now chosen by the devicetree (enum "chip_ids"),

Device Tree

> not by the chip ID in the register. However, there is a check to make sur=
e
> they match (using integer "id_check").

...

Thanks for a new version, it's getting better. My comments below.

But first of all, can you split this to at least two patches, i.e.
1) split out functions without introducing chip->info yet;
2) adding chip_info.

Possible alternative would be more steps in 2), i.e. introducing
chip_info for the callback only, then add field (or semantically
unified fields) by field with corresponding changes in the code. In
this case it would be easier to review.

I leave this exercise to you if Jonathan thinks it worth it.

...

> -#define YAS530_20DEGREES               182 /* Counts starting at -62 =C2=
=B0C */

> -#define YAS532_20DEGREES               390 /* Counts starting at -50 =C2=
=B0C */

The comments suddenly disappear from the file. See below.

...

> +enum chip_ids {
> +       yas530,
> +       yas532,
> +       yas533,
> +};
> +
> +static const char yas5xx_product_name[][13] =3D {
> +       "YAS530 MS-3E",
> +       "YAS532 MS-3R",
> +       "YAS533 MS-3F"
> +};
> +
> +static const char yas5xx_version_name[][2][3] =3D {
> +       { "A", "B" },
> +       { "AB", "AC" },
> +       { "AB", "AC" }

Shan't we put indices here?
Also, use * instead of one dimension of array.

> +};

...

> +static const int yas530_volatile_reg[] =3D {
> +       YAS530_ACTUATE_INIT_COIL,
> +       YAS530_MEASURE

+ Comma.

> +};

...

> +/* Number of counts between minimum and reference temperature */
> +const u16 t_ref_counts[] =3D { 182, 390, 390 };
> +
> +/* Starting point of temperature counting in 1/10:s degrees Celsius */
> +const s16 min_temp_celcius_x10[] =3D { -620, -500, -500 };

See above.

...

> +struct yas5xx_chip_info {
> +       unsigned int devid;

> +       const int *volatile_reg;
> +       const int volatile_reg_qty;
> +       const u32 scaling_val2;

Why const here?
I assume entire structure is const, no?

> +       int (*get_measure)(struct yas5xx *yas5xx, s32 *to, s32 *xo, s32 *=
yo, s32 *zo);
> +       int (*get_calibration_data)(struct yas5xx *yas5xx);
> +       void (*dump_calibration)(struct yas5xx *yas5xx);
> +       int (*measure_offsets)(struct yas5xx *yas5xx);
> +       int (*power_on)(struct yas5xx *yas5xx);
> +};

...

> +       int i, j;

j can have a proper name.

> +       j =3D yas5xx->chip_info->volatile_reg_qty;

...

> +static struct yas5xx_chip_info yas5xx_chip_info_tbl[] =3D {
> +       [yas530] =3D {
> +               .devid =3D YAS530_DEVICE_ID,
> +               .volatile_reg =3D yas530_volatile_reg,
> +               .volatile_reg_qty =3D ARRAY_SIZE(yas530_volatile_reg),
> +               .scaling_val2 =3D 100000000, /* picotesla to Gauss */
> +               .get_measure =3D yas530_get_measure,
> +               .get_calibration_data =3D yas530_get_calibration_data,
> +               .dump_calibration =3D yas530_dump_calibration,
> +               .measure_offsets =3D yas530_measure_offsets,
> +               .power_on =3D yas530_power_on,
> +       },
> +       [yas532] =3D {
> +               .devid =3D YAS532_DEVICE_ID,
> +               .volatile_reg =3D yas530_volatile_reg,
> +               .volatile_reg_qty =3D ARRAY_SIZE(yas530_volatile_reg),
> +               .scaling_val2 =3D 100000, /* nanotesla to Gauss */
> +               .get_measure =3D yas530_get_measure,
> +               .get_calibration_data =3D yas532_get_calibration_data,
> +               .dump_calibration =3D yas530_dump_calibration,
> +               .measure_offsets =3D yas530_measure_offsets,
> +               .power_on =3D yas530_power_on,
> +       },
> +       [yas533] =3D {
> +               .devid =3D YAS532_DEVICE_ID,
> +               .volatile_reg =3D yas530_volatile_reg,
> +               .volatile_reg_qty =3D ARRAY_SIZE(yas530_volatile_reg),
> +               .scaling_val2 =3D 100000, /* nanotesla to Gauss */
> +               .get_measure =3D yas530_get_measure,
> +               .get_calibration_data =3D yas532_get_calibration_data,
> +               .dump_calibration =3D yas530_dump_calibration,
> +               .measure_offsets =3D yas530_measure_offsets,
> +               .power_on =3D yas530_power_on,
> +       }

Keep comma here.

> +};

...

> -       int ret;
> +       int id_check, ret;

Don't add variables with different semantics on the same line.

...

> +       if (id_check !=3D yas5xx->chip_info->devid) {
>                 ret =3D -ENODEV;
> -               dev_err(dev, "unhandled device ID %02x\n", yas5xx->devid)=
;
> +               dev_err(dev, "device ID %02x doesn't match %s\n",
> +                       id_check, id->name);

ret =3D dev_err_probe() ?

>                 goto assert_reset;
>         }

...

> +       dev_info(dev, "detected %s %s\n", yas5xx_product_name[yas5xx->chi=
p],
> +                yas5xx_version_name[yas5xx->chip][yas5xx->version]);

I'm wondering if these arrays can be actually embedded into chip_info?

--=20
With Best Regards,
Andy Shevchenko
