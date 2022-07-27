Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32B2583241
	for <lists+linux-iio@lfdr.de>; Wed, 27 Jul 2022 20:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232957AbiG0SoM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 27 Jul 2022 14:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240029AbiG0Sny (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 27 Jul 2022 14:43:54 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC8011E595;
        Wed, 27 Jul 2022 10:40:37 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id o13so7439311edc.0;
        Wed, 27 Jul 2022 10:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=f8w16QovP5e3KJH04Z+cL7GAqJv28vQysbD2A2ttaG0=;
        b=pT/cGBpUrFvLbbouTYfl/61DYFl3llqAZg1QhYwSfT4VtdrNGgADkK+nVXX9lKOy0I
         HQVFD8x1zzALi8uzi7QmoEsxBLg7kjdIGJWIGkq2i0K3gX9t4MkvA69EP5zbZPjEhlM3
         ChHfFNtaUJoB7VF4M5T52YVcWZqFQy70U6g/NVW7x//RyceZfiX+o1U8K2OHM8fbCmeg
         g3RIF6ApEwIgBDSk841LlZh/VPGW4BdxHVl4FyJmjMxDRxgd1SF4f+9Vu07Hoh1xcuTF
         qWHpjH1U/2WjghvNnbx153NAtGXafs9Xw5DDlVdZb/YoAzX5bhKtblvOFAcq5JxIwkKo
         m2uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=f8w16QovP5e3KJH04Z+cL7GAqJv28vQysbD2A2ttaG0=;
        b=TkOvjVPQIHdocKSNj0CKTytxD/CQoCehAZI0wHbED8wLsMUhkLmZbkp+gdpZsXagKo
         fVdckncG5EIXLWqjgEKEZX06MD+zDmSIKEPmvcFKaDxSyM3+01XYRK8iqdG0eGK5CR9q
         wHNvCQqC+EMLNEHH9y7xLAbTTNhcNxqiZjxxafmIgvyRECdSXImfwCmMm5kWNCLUP9xk
         /0CiBMQNm/xobEdnAk7Q9iB4sH4HgtkaMTJZP6yQuBzGU8YizZIvE10Y+lqw1u+8DJWH
         H0Xktq6iZQE1A6t9RRpfJPbSUxjTR4eKovZcqmvLKVEok3lnX9dyLUubDYOsizvMeFW5
         dpKw==
X-Gm-Message-State: AJIora9wCh5XXO+HbAaSGoy5eYA/o1oI3NoTTX1NZUodep+NVrIcrjZz
        mSo0yv87eYhfDq0OFUaphlNNIxWHTHtW8l0JD/A=
X-Google-Smtp-Source: AGRyM1tMm4fIw0OIjLn6EWbo/nVMBcS7fdBKLeEqj3EthAeWCfF5/LJm3ZDHjCgeUm4kB37v1Y7SNWT/AUqP5joK/Yw=
X-Received: by 2002:a05:6402:40c3:b0:43b:d65a:cbf7 with SMTP id
 z3-20020a05640240c300b0043bd65acbf7mr24452815edb.380.1658943635920; Wed, 27
 Jul 2022 10:40:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1656883851.git.jahau@rocketmail.com> <28a2a9ec27c6fb4073149b897415475a8f04e3f7.1656883851.git.jahau@rocketmail.com>
 <CAHp75VfGqk_q1iDyj06tEuTNoG35xjOL0_5HgokFauUz_aAwFQ@mail.gmail.com> <8639301c-ae9e-54ac-919d-baeb8760a31b@rocketmail.com>
In-Reply-To: <8639301c-ae9e-54ac-919d-baeb8760a31b@rocketmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 27 Jul 2022 19:39:58 +0200
Message-ID: <CAHp75VecjLe67XfK6qgM4eZfKiTJ-UabD40i6Q_YmMpyWAWMkg@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Jul 27, 2022 at 12:01 AM Jakob Hauser <jahau@rocketmail.com> wrote:
> On 04.07.22 21:37, Andy Shevchenko wrote:
> > On Mon, Jul 4, 2022 at 12:04 AM Jakob Hauser <jahau@rocketmail.com> wro=
te:

...

> > Possible alternative would be more steps in 2), i.e. introducing
> > chip_info for the callback only, then add field (or semantically
> > unified fields) by field with corresponding changes in the code. In
> > this case it would be easier to review.
>
> What do you mean by "introducing chip_info for the callback only"? I
> guess you mean the function pointers?

Yes.

> According to this, the patch could be split into:
> 1) introduce function pointers
> 2) introduce arrays to look up values
>
> However, what's missing there is the introduction of the chip_info
> approach as such. Admittedly difficult to follow are the changes in
> yas5xx_probe():
>  - yas5xx->devid gets removed, it was the main switch decider before
>  - (for usage on other switches it is moved to yas5xx->chip_info->devid)
>  - yas5xx->chip as an enumeration is newly introduced
>  - yas5xx->chip_info as a structure gets initiated
>  - As the chip_info now chooses according to the i2c_device_id (via
>    enum chip_ids, thus yas5xx->chip), a new check is introduced to
>    make sure it matches the device ID read from the register. This
>    is done by "if (id_check !=3D yas5xx->chip_info->devid)".
>  - The way of reporting product name and version name was changed
>    because introducing chip_info required to do this in one place
>    for all versions.
>  - As a consequence of this, yas5xx->name became obsolete.
>
> This would have to be done before introducing function pointers and
> arrays, like:
> 1) introduce chip_info structural changes
> 2) add function pointers
> 3) add arrays to look up values
>
> But it can't be easily split that way. I can't establish an "empty"
> chip_info approach as a fist step without removing or changing many
> other things. The structural changes are related to other changes in
> that patch.
>
> I'm thinking about first introducing chip_info and thereafter
> establishing the function pointers. In between I could try to split out
> the new temperature function:
> 1) introduce chip_info structural changes incl. arrays to look up values
> 2) split out new yas5xx_calc_temperature() function
> 3) add function pointers
>
> I'm not yet sure it can be split that way because things are entangled.
> But I will try to this in v5.

Yes, my main point is to try to see under different angles on how you
can split the series. We have plenty of time.

> Btw, looking through this, I realized that in patch 6 "Rename functions
> and registers" I unfortunately missed to rename instances of
> "yas5xx_get_measure", "yas5xx_power_on", "YAS5XX_ACTUATE_INIT_COIL" and
> "YAS5XX_MEASURE". I'll correct this in v5.

Also my point why smaller changes are better.

...

> >> -#define YAS530_20DEGREES               182 /* Counts starting at -62 =
=C2=B0C */
> >
> >> -#define YAS532_20DEGREES               390 /* Counts starting at -50 =
=C2=B0C */
> >
> > The comments suddenly disappear from the file. See below.
>
> The comment's didn't actually disappear but rather got restructured by
> introducing new chip_info approach. See below.

See below.

...

> >> +static const char yas5xx_version_name[][2][3] =3D {
> >> +       { "A", "B" },
> >> +       { "AB", "AC" },
> >> +       { "AB", "AC" }
> >
> > Shan't we put indices here?
>
> Do you mean:
>
>         static const char yas5xx_version_name[][2][3] =3D {
>                 [yas530] =3D { "A", "B" },
>                 [yas532] =3D { "AB", "AC" },
>                 [yas533] =3D { "AB", "AC" },
>         };
>
> I can add this.

Yes.

> > Also, use * instead of one dimension of array.
>
> Sorry, probably I lack the basic knowledge here. Can you explain how to
> do that?

  static const char *_name[][] =3D {
  };

?

...

> >> +/* Number of counts between minimum and reference temperature */
> >> +const u16 t_ref_counts[] =3D { 182, 390, 390 };
> >> +
> >> +/* Starting point of temperature counting in 1/10:s degrees Celsius *=
/
> >> +const s16 min_temp_celcius_x10[] =3D { -620, -500, -500 };
> >
> > See above.
>
> The former comments...
>     182 /* Counts starting at -62 =C2=B0C */
>     390 /* Counts starting at -50 =C2=B0C */
>
> ... and the two new comments above the arrays actually should say the
> same thing. At least that was my intention.
>
> The first value is a number of counts. And the counting starts at a
> certain temperature, which is the second value. Both the old and the new
> comments are intended to describe this.
>
> In the introduction of this temperature handling (patch 4), there is a
> lot more description on these values in function yas5xx_get_measure().
> When creating the new "chip_info" patch 9, I was thinking about moving
> some of that description up here to these arrays. However, instead I
> tried to following Jonathan's suggestion in v3 to keep the describing
> text low and rather let the formulas speak for themselves. These values
> are applied at a formula in function yas5xx_calc_temperature() which is
> supposed to by kind of self explanatory.
>
> What may lead to confusion is the equivalent usage of "starting" and
> "minimum" here. In the initial patchset I used "starting" related to the
> counts, Jonathan suggested "minimum" or actually "min_temp" related to
> the temperature. The comments here above are bit of a mixture of both. I
> still think it's good enough to understand. The sentence "Starting point
> of temperature ..." describes the value min_temp_celcius_x10. Using a
> term like "starting temperature" would probably be more confusing.

Confusing to me, who doesn't know the specifics of the chip, it is
easy to read '-62 =C2=B0C' vs. "read comment, look into an array, calculate
in your brain".

...

> >> +struct yas5xx_chip_info {
> >> +       unsigned int devid;
> >
> >> +       const int *volatile_reg;
> >> +       const int volatile_reg_qty;
> >> +       const u32 scaling_val2;
> >
> > Why const here?
> > I assume entire structure is const, no?
>
> I'm rather new to C language, not having a good grasp of "const" in
> structures yet. I would have guessed it doesn't work well with the
> function pointers.
>
> However, having some compile tests, there are no complaints about the
> function pointers.
>
> To change the whole chip_info structure to "const", I would:
>  - within the "struct yas5xx" change to "const struct
>    yas5xx_chip_info *chip_info;"
>  - change following typedef to "static const struct
>    yas5xx_chip_info yas5xx_chip_info_tbl[] =3D ..."
>
> Then, within the "struct yas5xx_chip_info", I can remove "const" from:
>  - int volatile_reg_qty;
>  - u32 scaling_val2;
>
> However, I have to keep "const" at the following, otherwise the complier
> complains that "initialization discards 'const' qualifier from pointer
> target type":
>  - const int *volatile_reg;
>
> Summarizing, after the changes it would look like the following (snippets=
):
>
>         struct yas5xx_chip_info {
>                 unsigned int devid;
>                 const int *volatile_reg;
>                 int volatile_reg_qty;
>                 u32 scaling_val2;
>                 int (*get_measure)(struct yas5xx *yas5xx, s32 *to,
>                                    s32 *xo, s32 *yo, s32 *zo);
>                 int (*get_calibration_data)(struct yas5xx *yas5xx);
>                 void (*dump_calibration)(struct yas5xx *yas5xx);
>                 int (*measure_offsets)(struct yas5xx *yas5xx);
>                 int (*power_on)(struct yas5xx *yas5xx);
>         };
>
>         struct yas5xx {
>                 struct device *dev;
>                 enum chip_ids chip;
>                 const struct yas5xx_chip_info *chip_info;
>
>                 ...
>
>         };
>
>         static const struct yas5xx_chip_info yas5xx_chip_info_tbl[] =3D {
>                 [yas530] =3D {
>
>                         ...
>
>                 },
>         };
>
> If that's reasonable, I'll change it that way.

Yes, chip_info should be immutable, right? Otherwise it's something we
may not rely on.

> >> +       if (id_check !=3D yas5xx->chip_info->devid) {
> >>                 ret =3D -ENODEV;
> >> -               dev_err(dev, "unhandled device ID %02x\n", yas5xx->dev=
id);
> >> +               dev_err(dev, "device ID %02x doesn't match %s\n",
> >> +                       id_check, id->name);
> >
> > ret =3D dev_err_probe() ?
>
> Makes sense, will change that.
>
> Though I have difficulties to implement this nicely. dev_err_probe()
> requires an "error value to test". The current "if (id_check !=3D
> yas5xx->chip_info->devid)" doesn't offer such a value by itself.
>
> Do you think the following would be appropriate, nesting the check
> within the dev_err_probe()? It doesn't look too good to me.
>
>         ret =3D dev_err_probe(dev, id_check !=3D yas5xx->chip_info->devid=
,
>                             "device ID %02x doesn't match %s\n",
>                             id_check, id->name);
>         if (ret)
>                 goto assert_reset;
>
> If there are no better ideas, I would implement it that way.
> Additionally adding a comment and putting it into a block with the
> regmap_read before:
>
>         /*
>          * Check if the device ID from the register matches the one set
>          * in the Device Tree.
>          */
>         ret =3D regmap_read(yas5xx->map, YAS5XX_DEVICE_ID, &id_check);
>         if (ret)
>                 goto assert_reset;
>         ret =3D dev_err_probe(dev, id_check !=3D yas5xx->chip_info->devid=
,
>                             "device ID %02x doesn't match %s\n",
>                             id_check, id->name);
>         if (ret)
>                 goto assert_reset;
>
> Hm, I think it's a bit hard to read. Suggestions for improvement are
> welcome. Otherwise I'd add it that way.

It should be like:

  if (id_check !=3D ...)
    return dev_err_probe(dev, -ENODEV, ...);

...

> >> +       dev_info(dev, "detected %s %s\n", yas5xx_product_name[yas5xx->=
chip],
> >> +                yas5xx_version_name[yas5xx->chip][yas5xx->version]);
> >
> > I'm wondering if these arrays can be actually embedded into chip_info?
>
> While the variants (like "YAS530") are listed in the chip_info, the
> versions (like "A") are not. Yet, including the versions in chip_info
> would double the amount, making it visually more unclear, with only
> minor benefit.
>
> The first part of this call, the "product name", applies to the
> variants. Going the detour via chip_info, the array element to call
> could just be hard-coded in the chip_info table, like:
>
>         static struct yas5xx_chip_info yas5xx_chip_info_tbl[] =3D {
>                 [yas530] =3D {
>                         ...
>                         .product_name =3D yas5xx_product_name[0],
>                         ...
>
> The second part, the "version name", is currently in the
> three-dimensional array yas5xx_version_name[]. The first dimension is
> the variant, this would need to be hard-coded in the chip_info table,
> similar to the example above. The second dimension is the version, this
> would need to come from within the yas5xx_probe() the function. I
> couldn't find a way how to assign one dimension in one place and another
> dimension in another place.
>
> To include the second part in the chip_info, I would split the
> three-dimensional array yas5xx_version_name[] into three separate
> two-dimensional arrays, one per variant. It would look like this (snippet=
s):
>
>
>         static const char yas530_version_name[][3] =3D { "A", "B" };
>
>         static const char yas532_version_name[][3] =3D { "AB", "AC" };
>
>         static const char yas533_version_name[][3] =3D { "AB", "AC" };
>
>         ...
>
>         struct yas5xx_chip_info {
>                 ...
>                 const char *product_name;
>                 const char (*version_name)[3];
>                 ...
>
>         ...
>
>         static struct yas5xx_chip_info yas5xx_chip_info_tbl[] =3D {
>                 [yas530] =3D {
>                         ...
>                         .product_name =3D yas5xx_product_name[0],
>                         .version_name =3D yas530_version_name,
>                         ...
>
>         ...
>
>
>         dev_info(dev, "detected %s %s\n",
>                  yas5xx->chip_info->product_name,
>                  yas5xx->chip_info->version_name[yas5xx->version]);
>
>
> I'm not fully sure this is the best way. Also note that I had to set the
> size of the second dimension of yas530_version_name to 3.
>
> Do you think I should do it this way to include "product_name" and
> "version_name" in the chip_info?

Again, you are the author and my point is just to make you look at
this from different angles. If you see no better way, go with the
current approach, but just spend a half an hour and perhaps we may
have a cleaner solution?

> If yes, should I probably do a similar thing for the values
> "t_ref_counts" and "min_temp_celcius_x10"? Here as well, the array
> elements are directly called in function yas5xx_calc_temperature()
> without using the chip_info structure.
>
> Also I noticed that I should add "static" to the typedef of arrays
> "t_ref_counts" and "min_temp_celcius_x10". Darn, and I have to correct
> the spelling of "celcius" into "celsius" in "min_temp_celcius_x10".

--=20
With Best Regards,
Andy Shevchenko
