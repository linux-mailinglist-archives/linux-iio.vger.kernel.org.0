Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6AC581BE7
	for <lists+linux-iio@lfdr.de>; Wed, 27 Jul 2022 00:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239222AbiGZWB0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 26 Jul 2022 18:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239357AbiGZWBX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 26 Jul 2022 18:01:23 -0400
Received: from sonic312-26.consmr.mail.ir2.yahoo.com (sonic312-26.consmr.mail.ir2.yahoo.com [77.238.178.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2E832ED6
        for <linux-iio@vger.kernel.org>; Tue, 26 Jul 2022 15:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1658872879; bh=03ba5kRGdX2K2VMcrpk0Ny/tzqHulA7K3RP0joY/H7E=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=tosSOu/0y2wGA2Ntcr/awhO177t0Pk9y1snwhvBj5iRBWApjEfJfU0nN+Hgk2hiTnjgBTSWsXhoUNOUzwT9fOkjApvzNd+kt/fM27IefOJT6ZqQkNS2dqdybRezD1Ing52MgAZsuQZKPWkJukS6EDxZ8MNUq4bJl0F5n2nYdWS3XqYuCgvqOFz0zhjbDkj0+/sITGqmVOylLO12mUkF9iwAyh5pFgbpqpN3awJR9gejx+pSyzn4O26BzFes4eoRxtG3c+DYav0tz4VAJQVV14nFaGgtxabrEfByULlCcs3wbypukushfuqEqIzS84Oqs0ogiMyQFR7K1F/M4XfIvvQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1658872879; bh=2D3Wc151CxO9+BFX6VVBxlie3M/tFda0jNFtDaPDUKP=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=H8+sA1LGdm5E+rLx8Xnt9VSpJGLyE3wi6k0F98RC9zrrTlN/cnBWpuR68bFSpZwjazrLkq24eHxmsajBcaAoJleB2xxud9vwfKaXwyIrMOhny/QaAvwBR56Ov+OtxQWm/0sbJubDnToOqj41wXh9S86F0ceTScwNgo8F4UXFjpxD4SCAmpLlNErwAandJmgebhsqqZvpJGdWrzWAeoFinMZjc8GxrxnMb+Fh26sFRLc2RpROtcioqX8bpgZvfzJq9OvqQ7OesmCnqmoOgMqsf8c6SgTL4DtmSyV+0GKDbQKxddwIuNLgZbvZuIOcJeEfGndgXy/czkXKKRc2iXWimg==
X-YMail-OSG: jzT5dfsVM1k7ld3mfIsV3xz0L3qvqhaXdCiStQeta14RhoTvsRA.NCfd0PnXx4O
 5_8Apwy3EIZRygM7C_IZ.2DszZZiwx6BMzXhhDk_jsF9G7sbyZmqcvmuddlX_e.s.XQ_G3olbGcB
 YWloednS3gtqQJvq9U8X5vKaMo7VjQBCwZu9jhGgUZsav4FV9gJ8S3aGvINH_bBVfhAYdhMqbyxm
 HsundeOMBgx6FYGqriynppy3HrLrsIez4pP6_AmUVGzk1ldTBppgOsZQpEluckAWukB4rhtWcmk8
 5_yKjFtEd6R3TwfsQ1J0oTTl9WKAdvH7oF9lVK32XRT_JXFGi3_q9FoNZ.XXYn2C1CtP8oXMOzZ6
 HxZEFLY0846h0.MC0lWfZ59YmOWPy1DB5CS1kH3hVbYJ6az_3pr4ZiidgUfLMCezqhmjI7vu48yA
 wMu0AY3hnvyL9mSPje.Bn_iHjPqt_AGhelh_5ALiymMXKQdgISb_FYu8Rof.bG8MR3Ep1FP0Apt4
 32qxD5wUHf6mlNK8cBzzHQwJxTvOlVnuh_SlmxK4TTx2W5rinc0tR9OXGd5f9sjzRAPRthtDrag8
 VGy7x0Tel_Y.Z0Y9DigYElFSEJHZFXDksFWrg6Ko8h08hn7xsUOTy2R2u.d81OL_DqSgLGpYDNbJ
 _4gruT43Vk1KHcRRZzvXzEVvK1J2kXEna_mTQkh44QKN9tPBKBg_jAncZAmLmxCLuPIUivfnWwZl
 TvGbxeQrmePrP.Q0vL1utuVgquB8skJvEtZzMcG5GAdczNKXeA_z6cbW9U0P5z0yuxqsgHWlLQDt
 lJ9DbfATMYl1yS2Ek95pUiyJqZIzkYKInwe04JnfbL54kf6sASaE1gr54N2NUt4y3p4ED43gYCx6
 CgjxaVenC4TARViRF7M0K_Sj1M4Ve_lqO3d_UjhhyUuo3mf.UcSgIpXsQEgeCwLntTW_0g87hvOc
 LpE2XsKqVBmUh77u28GW4kdZR9X8ryHfE4_yadDvIZ9LIHL5QE3CUHAwIMD4J_PaXL5Iw9n1KbUX
 lwZUUejBVfSlWs3TSERHyVjFOW5Pkra.4k.gb5K6Me_ZRnYO6P_5r_n1W3i8PRapZ3Uqp.izjpFW
 D0cthHpm8CW5Vo_yEBhMjqGO62myfNX_L5OwYLItmPPW3wvrMypiSkyF6UiDUEwqI5n532IfMgdZ
 VYZsd1e35A8yQVtXMPIoQ7ok0PQgO_gwyexLqdBBirotVBb2GTE0q4L1YyXrHubx6NTylZGMdrkG
 ZywoD7cgzUlDZvHhMpDqzqDVBZyzhh6VmW6n121A_oiKjEo7MDeDoQ1t0xfAbACyT.TzQWFps4DC
 SPUIQ15rfW4qIUHwr69rAwJTpxBOwspWynqfbMuiP2riohNn.NNLrnYvAhw2PjajzI_Vr3MxXU3B
 urFSkxQS2u5olrfqdxrWZVRHnaK_VS0PKejJjvqR2GnvenA8tON_3yPj.g2utmG4Go.i1wTll66m
 KHyNx1.2Ni5wVRvqjULz_HSo53mWpAtbs.dOJecNOq7ODfw6NF0oXBiGTCjziaCvWTi1UHDWqe1y
 XipeY1Y.IJ2oTIUj6P.yqKHkluOyhsXYYvWt0KnoZj3OnrfwSkyw9BhyUL7hiIGd9qDF11Nf8uLa
 .Q9XMdRgyEnAToS8ewZPI4P7KYog1LAW2Kb4t3hUMKEEaTNlbUJ.lUxOZu9Nv9kronQ.IHV4i.un
 0NfPpzXFY3iJKatj5b5iYRsZY8Rn0t1HqL3vyv9XyWQUOGWr5IaxtVf6jQbVnuN6dy4mPD1phxED
 .8nG0RkGHRlFCIcfMXDKSJnsZF1eQBJx_W5bpzd4mI64Hs7D8IGxT4Sk9PyP17qGmRnNsdL8VaFA
 Ot6zbr8ON.RFzHp6PE13742FTblV6seDWY.QVX72G18wh9oeGTAZXr5EuQKT5.WGDfqdxFxRjKAB
 K8btFvxL2R30M_yPUF5WxPINKEpHwxnHRQFObU0nQ3hNAEG81W14p1CTESZ3nb.pmdQhnKh4y0cO
 mU2IzNiZRKX1KiPt3aqD9cLCS03wD14xoWkLbhJMCRRvrXz5994EeOkW1Me1bdkcX3d2vkZPhyc6
 Bug7v6Md_6FG7aGDR7NF0K4N.VFAbo07ivLD9rAEfswfq43urQ0OCGLekSiYc5WUaKVPMz7lrmT9
 L5SxyjZ3E_nC_VXCK2dF7Td93PQvX04vfmd9d3SLyW4WGrL6Y_vmCSiDUwex7IUM0dcaR9sJjGra
 9BlSojy5kfx2LsdKtsl5r.eJPQWR6DZ6p7xzEznR64dPMQjX2Itdg6K1nrun4Z5BREnKfNhid8i0
 -
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ir2.yahoo.com with HTTP; Tue, 26 Jul 2022 22:01:19 +0000
Received: by hermes--canary-production-ir2-d447c45b6-2hw4d (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8e8ed92372a8ed4e85bff6611599a804;
          Tue, 26 Jul 2022 22:01:14 +0000 (UTC)
Message-ID: <8639301c-ae9e-54ac-919d-baeb8760a31b@rocketmail.com>
Date:   Wed, 27 Jul 2022 00:01:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 09/10] iio: magnetometer: yas530: Introduce "chip_info"
 structure
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <cover.1656883851.git.jahau@rocketmail.com>
 <28a2a9ec27c6fb4073149b897415475a8f04e3f7.1656883851.git.jahau@rocketmail.com>
 <CAHp75VfGqk_q1iDyj06tEuTNoG35xjOL0_5HgokFauUz_aAwFQ@mail.gmail.com>
From:   Jakob Hauser <jahau@rocketmail.com>
In-Reply-To: <CAHp75VfGqk_q1iDyj06tEuTNoG35xjOL0_5HgokFauUz_aAwFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.20447 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy,

On 04.07.22 21:37, Andy Shevchenko wrote:
> On Mon, Jul 4, 2022 at 12:04 AM Jakob Hauser <jahau@rocketmail.com> wro=
te:
>>

=2E..

> Thanks for a new version, it's getting better. My comments below.
>=20
> But first of all, can you split this to at least two patches, i.e.
> 1) split out functions without introducing chip->info yet;
> 2) adding chip_info.

The only function that's split out newly is yas5xx_calc_temperature().
However, it uses "yas5xx->chip" to look up the right values in the array
for "t_ref" and "min_temp_x10". So it cannot be easily split from the
introduction to the chip_info approach.

> Possible alternative would be more steps in 2), i.e. introducing
> chip_info for the callback only, then add field (or semantically
> unified fields) by field with corresponding changes in the code. In
> this case it would be easier to review.

What do you mean by "introducing chip_info for the callback only"? I
guess you mean the function pointers?

According to this, the patch could be split into:
1) introduce function pointers
2) introduce arrays to look up values

However, what's missing there is the introduction of the chip_info
approach as such. Admittedly difficult to follow are the changes in
yas5xx_probe():
 - yas5xx->devid gets removed, it was the main switch decider before
 - (for usage on other switches it is moved to yas5xx->chip_info->devid)
 - yas5xx->chip as an enumeration is newly introduced
 - yas5xx->chip_info as a structure gets initiated
 - As the chip_info now chooses according to the i2c_device_id (via
   enum chip_ids, thus yas5xx->chip), a new check is introduced to
   make sure it matches the device ID read from the register. This
   is done by "if (id_check !=3D yas5xx->chip_info->devid)".
 - The way of reporting product name and version name was changed
   because introducing chip_info required to do this in one place
   for all versions.
 - As a consequence of this, yas5xx->name became obsolete.

This would have to be done before introducing function pointers and
arrays, like:
1) introduce chip_info structural changes
2) add function pointers
3) add arrays to look up values

But it can't be easily split that way. I can't establish an "empty"
chip_info approach as a fist step without removing or changing many
other things. The structural changes are related to other changes in
that patch.

I'm thinking about first introducing chip_info and thereafter
establishing the function pointers. In between I could try to split out
the new temperature function:
1) introduce chip_info structural changes incl. arrays to look up values
2) split out new yas5xx_calc_temperature() function
3) add function pointers

I'm not yet sure it can be split that way because things are entangled.
But I will try to this in v5.

Btw, looking through this, I realized that in patch 6 "Rename functions
and registers" I unfortunately missed to rename instances of
"yas5xx_get_measure", "yas5xx_power_on", "YAS5XX_ACTUATE_INIT_COIL" and
"YAS5XX_MEASURE". I'll correct this in v5.

=2E..

>> -#define YAS530_20DEGREES               182 /* Counts starting at -62 =
=C2=B0C */
>=20
>> -#define YAS532_20DEGREES               390 /* Counts starting at -50 =
=C2=B0C */
>=20
> The comments suddenly disappear from the file. See below.

The comment's didn't actually disappear but rather got restructured by
introducing new chip_info approach. See below.

>> +enum chip_ids {
>> +       yas530,
>> +       yas532,
>> +       yas533,
>> +};
>> +
>> +static const char yas5xx_product_name[][13] =3D {
>> +       "YAS530 MS-3E",
>> +       "YAS532 MS-3R",
>> +       "YAS533 MS-3F"
>> +};
>> +
>> +static const char yas5xx_version_name[][2][3] =3D {
>> +       { "A", "B" },
>> +       { "AB", "AC" },
>> +       { "AB", "AC" }
>=20
> Shan't we put indices here?

Do you mean:

        static const char yas5xx_version_name[][2][3] =3D {
                [yas530] =3D { "A", "B" },
                [yas532] =3D { "AB", "AC" },
                [yas533] =3D { "AB", "AC" },
        };

I can add this.

> Also, use * instead of one dimension of array.

Sorry, probably I lack the basic knowledge here. Can you explain how to
do that?

=2E..

>> +static const int yas530_volatile_reg[] =3D {
>> +       YAS530_ACTUATE_INIT_COIL,
>> +       YAS530_MEASURE
>=20
> + Comma.

OK, I didn't know this is allowed. I'll add it here and at the other
locations.

>> +/* Number of counts between minimum and reference temperature */
>> +const u16 t_ref_counts[] =3D { 182, 390, 390 };
>> +
>> +/* Starting point of temperature counting in 1/10:s degrees Celsius *=
/
>> +const s16 min_temp_celcius_x10[] =3D { -620, -500, -500 };
>=20
> See above.

The former comments...
    182 /* Counts starting at -62 =C2=B0C */
    390 /* Counts starting at -50 =C2=B0C */

=2E.. and the two new comments above the arrays actually should say the
same thing. At least that was my intention.

The first value is a number of counts. And the counting starts at a
certain temperature, which is the second value. Both the old and the new
comments are intended to describe this.

In the introduction of this temperature handling (patch 4), there is a
lot more description on these values in function yas5xx_get_measure().
When creating the new "chip_info" patch 9, I was thinking about moving
some of that description up here to these arrays. However, instead I
tried to following Jonathan's suggestion in v3 to keep the describing
text low and rather let the formulas speak for themselves. These values
are applied at a formula in function yas5xx_calc_temperature() which is
supposed to by kind of self explanatory.

What may lead to confusion is the equivalent usage of "starting" and
"minimum" here. In the initial patchset I used "starting" related to the
counts, Jonathan suggested "minimum" or actually "min_temp" related to
the temperature. The comments here above are bit of a mixture of both. I
still think it's good enough to understand. The sentence "Starting point
of temperature ..." describes the value min_temp_celcius_x10. Using a
term like "starting temperature" would probably be more confusing.

>> +struct yas5xx_chip_info {
>> +       unsigned int devid;
>=20
>> +       const int *volatile_reg;
>> +       const int volatile_reg_qty;
>> +       const u32 scaling_val2;
>=20
> Why const here?
> I assume entire structure is const, no?

I'm rather new to C language, not having a good grasp of "const" in
structures yet. I would have guessed it doesn't work well with the
function pointers.

However, having some compile tests, there are no complaints about the
function pointers.

To change the whole chip_info structure to "const", I would:
 - within the "struct yas5xx" change to "const struct
   yas5xx_chip_info *chip_info;"
 - change following typedef to "static const struct
   yas5xx_chip_info yas5xx_chip_info_tbl[] =3D ..."

Then, within the "struct yas5xx_chip_info", I can remove "const" from:
 - int volatile_reg_qty;
 - u32 scaling_val2;

However, I have to keep "const" at the following, otherwise the complier
complains that "initialization discards 'const' qualifier from pointer
target type":
 - const int *volatile_reg;

Summarizing, after the changes it would look like the following (snippets=
):

        struct yas5xx_chip_info {
                unsigned int devid;
                const int *volatile_reg;
                int volatile_reg_qty;
                u32 scaling_val2;
                int (*get_measure)(struct yas5xx *yas5xx, s32 *to,
                                   s32 *xo, s32 *yo, s32 *zo);
                int (*get_calibration_data)(struct yas5xx *yas5xx);
                void (*dump_calibration)(struct yas5xx *yas5xx);
                int (*measure_offsets)(struct yas5xx *yas5xx);
                int (*power_on)(struct yas5xx *yas5xx);
        };

        struct yas5xx {
                struct device *dev;
                enum chip_ids chip;
                const struct yas5xx_chip_info *chip_info;

        	...

        };

        static const struct yas5xx_chip_info yas5xx_chip_info_tbl[] =3D {=

                [yas530] =3D {

        		...

                },
        };

If that's reasonable, I'll change it that way.

=2E..

>> +       int i, j;
>=20
> j can have a proper name.

Ok, makes sense. I'll probably name it "reg_qty".

>> +       j =3D yas5xx->chip_info->volatile_reg_qty;
>=20

=2E..

>> -       int ret;
>> +       int id_check, ret;
>=20
> Don't add variables with different semantics on the same line.

Ok. I wasn't aware of putting different semantics on different lines,
thanks for the hint, makes sense.

>> +       if (id_check !=3D yas5xx->chip_info->devid) {
>>                 ret =3D -ENODEV;
>> -               dev_err(dev, "unhandled device ID %02x\n", yas5xx->dev=
id);
>> +               dev_err(dev, "device ID %02x doesn't match %s\n",
>> +                       id_check, id->name);
>=20
> ret =3D dev_err_probe() ?

Makes sense, will change that.

Though I have difficulties to implement this nicely. dev_err_probe()
requires an "error value to test". The current "if (id_check !=3D
yas5xx->chip_info->devid)" doesn't offer such a value by itself.

Do you think the following would be appropriate, nesting the check
within the dev_err_probe()? It doesn't look too good to me.

        ret =3D dev_err_probe(dev, id_check !=3D yas5xx->chip_info->devid=
,
                            "device ID %02x doesn't match %s\n",
                            id_check, id->name);
        if (ret)
                goto assert_reset;

If there are no better ideas, I would implement it that way.
Additionally adding a comment and putting it into a block with the
regmap_read before:

        /*
         * Check if the device ID from the register matches the one set
         * in the Device Tree.
         */
        ret =3D regmap_read(yas5xx->map, YAS5XX_DEVICE_ID, &id_check);
        if (ret)
                goto assert_reset;
        ret =3D dev_err_probe(dev, id_check !=3D yas5xx->chip_info->devid=
,
                            "device ID %02x doesn't match %s\n",
                            id_check, id->name);
        if (ret)
                goto assert_reset;

Hm, I think it's a bit hard to read. Suggestions for improvement are
welcome. Otherwise I'd add it that way.

=2E..

>> +       dev_info(dev, "detected %s %s\n", yas5xx_product_name[yas5xx->=
chip],
>> +                yas5xx_version_name[yas5xx->chip][yas5xx->version]);
>=20
> I'm wondering if these arrays can be actually embedded into chip_info?

While the variants (like "YAS530") are listed in the chip_info, the
versions (like "A") are not. Yet, including the versions in chip_info
would double the amount, making it visually more unclear, with only
minor benefit.

The first part of this call, the "product name", applies to the
variants. Going the detour via chip_info, the array element to call
could just be hard-coded in the chip_info table, like:

        static struct yas5xx_chip_info yas5xx_chip_info_tbl[] =3D {
                [yas530] =3D {
                        ...
                        .product_name =3D yas5xx_product_name[0],
			...

The second part, the "version name", is currently in the
three-dimensional array yas5xx_version_name[]. The first dimension is
the variant, this would need to be hard-coded in the chip_info table,
similar to the example above. The second dimension is the version, this
would need to come from within the yas5xx_probe() the function. I
couldn't find a way how to assign one dimension in one place and another
dimension in another place.

To include the second part in the chip_info, I would split the
three-dimensional array yas5xx_version_name[] into three separate
two-dimensional arrays, one per variant. It would look like this (snippet=
s):


        static const char yas530_version_name[][3] =3D { "A", "B" };

        static const char yas532_version_name[][3] =3D { "AB", "AC" };

        static const char yas533_version_name[][3] =3D { "AB", "AC" };

        ...

        struct yas5xx_chip_info {
                ...
                const char *product_name;
                const char (*version_name)[3];
        	...

        ...

        static struct yas5xx_chip_info yas5xx_chip_info_tbl[] =3D {
                [yas530] =3D {
                        ...
                        .product_name =3D yas5xx_product_name[0],
                        .version_name =3D yas530_version_name,
                        ...

        ...


        dev_info(dev, "detected %s %s\n",
                 yas5xx->chip_info->product_name,
                 yas5xx->chip_info->version_name[yas5xx->version]);


I'm not fully sure this is the best way. Also note that I had to set the
size of the second dimension of yas530_version_name to 3.

Do you think I should do it this way to include "product_name" and
"version_name" in the chip_info?

If yes, should I probably do a similar thing for the values
"t_ref_counts" and "min_temp_celcius_x10"? Here as well, the array
elements are directly called in function yas5xx_calc_temperature()
without using the chip_info structure.

Also I noticed that I should add "static" to the typedef of arrays
"t_ref_counts" and "min_temp_celcius_x10". Darn, and I have to correct
the spelling of "celcius" into "celsius" in "min_temp_celcius_x10".

Kind regards,
Jakob
