Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B227549BF6
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jun 2022 20:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbiFMSoU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Jun 2022 14:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbiFMSn0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Jun 2022 14:43:26 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4943EBB5;
        Mon, 13 Jun 2022 08:20:58 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id bg6so11943057ejb.0;
        Mon, 13 Jun 2022 08:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=H0RbFWd9DrLe0WWxoqcq/mfZ+46Z/yvi2sA+4RrsPZ4=;
        b=ArMqaNot+i7uNXL0UZW4oEJFT1VOIVQWm/7kvzDqKuUukB4qQtaq7t1Um4uXk6R4jW
         ArTr27oOcmljvsD/7iIP779coEEGO/I+LCeIoq6xJ95CYD8NapJZGnPEUzu4V+CzmztX
         DmzakeBchEh4JYIDZzmyn46l8Tq5qDbZ710Puo/s81rsmRG7BPtHXaFA8kiYDHzb8aTd
         dv1piE07aJng44mi/4rHRr73JLlUeWgIBIDUn3de4Enxh5USKZDiM/Yn0uXKXOReivPf
         agFKpZboDGdho+UPwiPU9BOc9pdaEtNFNh6ubvP92VUFuZ4AH4NIFtrA/5eYEk4g20lq
         h4tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=H0RbFWd9DrLe0WWxoqcq/mfZ+46Z/yvi2sA+4RrsPZ4=;
        b=XO9vi7/wnxYLK1colQY1fbYZClVh0Ysb0NxjFy3eIF3ZUsrlW93Rv+wAnxwjewtnO4
         VvfNbf/Z3fDK0NkUftAOngaA+Jj5m+vt/tmheJ7zFrdktc51GZ9/IOlpe5VYTHeHC0yB
         QuTV1eH69xuuZZlKezJcdKq8K4QuUijbvnONudOijHjX7F0GnfVP5j+buuSHCUyr3CRp
         QY1aiTgJWQIvvT43C60zhCWyIvATc3f6A+qGIyrVOpwQ9pe+mPl1kU3vrUqUe8gnHaW7
         TM8kZU7+RWppd7SLiBRFJkXtcHFidRuAZBFTqKi3O5FsZZ90ePtg5PYgRJ4lC1w5mxmP
         jFDg==
X-Gm-Message-State: AOAM531c75bmrnRlKkRrqlizrfwPhmZnNm+k6xL3Jhz39d8TA1RbEHpg
        bJ9HFIqBEOdfzHcByD68Bmk4gru7hQuYDh8+OUo=
X-Google-Smtp-Source: ABdhPJyLzwQ0rksJvvlcO0XqCHPfzL1ENAyoxMRzcrtgXBeTgJjYLVMBPmnc8+yw7Qz2IrDkf6OixrihbDEVwsLG378=
X-Received: by 2002:a17:906:1193:b0:70d:cf39:a4db with SMTP id
 n19-20020a170906119300b0070dcf39a4dbmr358944eja.44.1655133657028; Mon, 13 Jun
 2022 08:20:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1655081082.git.jahau@rocketmail.com> <b6e100de37921c22ebf0698f8e0e99794053303a.1655081082.git.jahau@rocketmail.com>
In-Reply-To: <b6e100de37921c22ebf0698f8e0e99794053303a.1655081082.git.jahau@rocketmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 13 Jun 2022 17:20:20 +0200
Message-ID: <CAHp75VfFwSQ6bk=TMLiyA1j-AsafjGdVFbTTHJJ67C8zeYfz8Q@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] iio: magnetometer: yas530: Add YAS537 variant
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        phone-devel@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
        <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy
        Shevchenko <andy.shevchenko@gmail.com>," 
        <~postmarketos/upstreaming@lists.sr.ht>
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

On Mon, Jun 13, 2022 at 3:18 AM Jakob Hauser <jahau@rocketmail.com> wrote:
>
> This adds support for the magnetometer Yamaha YAS537. The additions are b=
ased
> on comparison of Yamaha Android kernel drivers for YAS532 [1] and YAS537 =
[2].
>
> In the Yamaha YAS537 Android driver, there is an overflow/underflow contr=
ol
> implemented. For regular usage, this seems not necessary. A similar overf=
low/
> underflow control of Yamaha YAS530/532 Android driver isn't integrated in=
 the
> mainline driver. It is therefore skipped for YAS537 in mainline too.
>
> Also in the Yamaha YAS537 Android driver, at the end of the reset_yas537(=
)
> function, a measurement is saved in "last_after_rcoil". Later on, this is
> compared to current measurements. If the difference gets too big, a new
> reset is initialized. The difference in measurements needs to be quite bi=
g,
> it's hard to say if this is necessary for regular operation. Therefore th=
is
> isn't integrated in the mainline driver either.

...

> - * YAS537 MS-3T (2015 Samsung Galaxy S6, Note 5, Xiaomi)
> + * YAS537 MS-3T (2015 Samsung Galaxy S6, Note 5, Galaxy S7)

Not sure what happened to Xiaomi. There is nothing in the commit
message about this change.

...

> +#define YAS537_MAG_AVERAGE_32_MASK     GENMASK(6, 4) /* corresponds to 0=
x70 */

Useless comment.

...

> +#define YAS537_MEASURE_TIME_WORST      1500 /* us */
> +#define YAS537_DEFAULT_SENSOR_DELAY    50   /* ms */
> +#define YAS537_MAG_RCOIL_TIME          65   /* us */

Instead of the comments, use unit suffixes, i.e. _US, _MS, _US.

...

> +       /* Read data */

Not sure how useful is this comment.

...

> +       *t =3D ((data[0] << 8) | data[1]);

Looks like get_unaligned_be16().

> +       xy1y2[0] =3D ((FIELD_GET(GENMASK(5, 0), data[2]) << 8) | data[3])=
;
> +       xy1y2[1] =3D ((data[4] << 8) | data[5]);
> +       xy1y2[2] =3D ((data[6] << 8) | data[7]);

Ditto for all above.

...

> +                       if (h[i] < -8192)
> +                               h[i] =3D -8192;

-BIT(13) ?

> +                       if (h[i] > 8191)
> +                               h[i] =3D 8191;

Altogether seems like NIH clamp_val() or clamp_t().

...

> +                       xy1y2[i] =3D h[i] + 8192;

BIT(13)

...

> +       /*
> +        * Raw temperature value t is number of counts. A product descrip=
tion
> +        * of YAS537 mentions a temperature resulution of 0.05 =C2=B0C/co=
unt.

resolution

> +        * A readout of the t value at ca. 20 =C2=B0C returns approx. 812=
0 counts.
> +        *
> +        * 8120 counts x 0.05 =C2=B0C/count corresponds to a range of 406=
 =C2=B0C.
> +        * 0 counts would be at theoretical -386 =C2=B0C.
> +        *
> +        * The formula used for YAS530/532 needs to be adapted to this
> +        * theoretical starting temperature, again calculating with 1/10:=
s
> +        * of degrees Celsius and finally multiplying by 100 to get milli
> +        * degrees Celsius.
> +        */

...

>                         /*
> -                        * Raw values of YAS532 are in nanotesla. Devide =
by
> -                        * 100000 (10^5) to get Gauss.
> +                        * Raw values of YAS532 and YAS537 are in nanotes=
la.
> +                        * Devide by 100000 (10^5) to get Gauss.

Divide (chance to fix a type while at it)

>                          */

...

> @@ -679,6 +887,7 @@ static int yas530_get_calibration_data(struct yas5xx =
*yas5xx)
>         c->r[0] =3D sign_extend32(FIELD_GET(GENMASK(28, 23), val), 5);
>         c->r[1] =3D sign_extend32(FIELD_GET(GENMASK(20, 15), val), 5);
>         c->r[2] =3D sign_extend32(FIELD_GET(GENMASK(12, 7), val), 5);
> +
>         return 0;
>  }
>

Not harmful, but a stray change. Ditto for the rest like this. I would
rather split them to a separate patch.

...

> +       dev_dbg(yas5xx->dev, "calibration data: %*ph\n", 17, data);

Use less stack by "%17ph".

...

> +       /* Sanity check, is this all zeroes? */
> +       if (memchr_inv(data, 0x00, 16) =3D=3D NULL) {

  if (!memchr_inv(...))

> +               if (FIELD_GET(GENMASK(5, 0), data[16]) =3D=3D 0)
> +                       dev_warn(yas5xx->dev, "calibration is blank!\n");
> +       }

...

> +               for (i =3D 0; i < 17; i++) {

16 and 17 seems like a magic that is used a lot, perhaps define?

...

> +               ret =3D regmap_write(yas5xx->map, YAS537_MTC + 3,
> +                                  ((data[3] & GENMASK(7, 5)) | BIT(4)));

Here...

> +               if (ret)
> +                       return ret;
> +               ret =3D regmap_write(yas5xx->map, YAS537_HCK,
> +                                  (FIELD_GET(GENMASK(7, 4), data[15]) <<=
 1));

...and here and in many other places, please drop outer parentheses,
they are not needed.

> +               if (ret)
> +                       return ret;

...

> +       usleep_range(YAS537_MAG_RCOIL_TIME, YAS537_MAG_RCOIL_TIME+100);

Please, add a comment explaining why this is needed.

...

> +               dev_info(dev, "detected YAS537 MS-3T");
> +               /* As the version naming is unknown, provide it for debug=
 only */
> +               dev_dbg(yas5xx->dev, "YAS537 version: %s\n",
> +                       yas5xx->version ? "1" : "0");

No need to have two prints, just add a version to the above one and
drop the bottom one.


--=20
With Best Regards,
Andy Shevchenko
