Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D86B584886
	for <lists+linux-iio@lfdr.de>; Fri, 29 Jul 2022 01:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbiG1XGQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Jul 2022 19:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233180AbiG1XGH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 Jul 2022 19:06:07 -0400
Received: from sonic309-25.consmr.mail.ir2.yahoo.com (sonic309-25.consmr.mail.ir2.yahoo.com [77.238.179.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5377D5246D
        for <linux-iio@vger.kernel.org>; Thu, 28 Jul 2022 16:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1659049560; bh=mSdbD0X4Lu+fGy3xz3HH7k5WX7/Ycufufu0opxOtals=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=fieo6qaSJxaKpDMjWu2CGTjsWhQO+MfXZ39wc2zgLnzw2Ekvo5NxFF5lwDXNUf0RyRSgsByq+m67etfL1x5HYxrH7tSTeuI/f6idgeiKerCaBKj1pCyfcj2Cq9LvJEyV+ThFrbEd5Blpavmu9AfCRs7N5ejRgnRM2iYR48oMdNhYs8RKzAv2ovEsPYRNdIy51ilzfFOpeKsAvzkxfj4GxF61co+ZP31cUTsfuL0tnBx1Mygggb4r4zhHrWjYbR9ENBPpDMARMP47O4MB0n0agWpVeZ0i5SnghADLITlk0U2KrTK+mXZwW8qgdreUe3+HATCreAcKdfFI1ZFNqfg/PQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1659049560; bh=knnZHNhFMQd2QHuNKjfJ0MilXNt2VVmKiYma2kEviYj=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=PfoKTrrvpsMm2TuQ+vB7pKGP76VDTdz0/HHJldNIvnoXow7ILvzS5tjwIFjVi8EhlJjck+HMA9paWse12+90opzwWlCw7A+pcyplF97+QSjbHhlJaW7DgB+aVIj4VBszVRhPqbnWgkKvMtC5edvs/HMynxrwzorgcEGWnWoSx5NXxQq5m4FoBn4Ah/igl7Z/eNKEWASJ1GBAGQNQwtx6as/jMpwPTVxbyDG+92iCEh9C2m/b0yGV0ruOX04Yo85Aj/JCBPyb+bYwZYe91QNaW9f+m6jwtjiBlb3DTBhV367x+qEf38on1+1ilq/xMiyipMv61dBwdo4nad+7Dn6K4g==
X-YMail-OSG: G7AqRFMVM1ld5LOWm1AF566ksevudeEY8FmZVC4SthNQihLjYArOL6.lKM8ouqI
 HhEKrlaIaMtySIe6Zi6Vfv3WVyyrFycvbcrUOVSgpO8pbq5dEESEAPuc5mbu0tBaGwezOJLlYRx9
 Ns1reg7NyJnNELppXuqrExtfeVqLozA8wTprlZeHa8a7fxzDeR7ZFpCG02BIY.lU7qhRM7M_UZts
 ddyJ40cqh0uzXCQhIHUC5Cof.N4ZmZ01mAejNjmxV0UZTgw6jmQYhsquKc16aEwK9Q5OCMpMZlNr
 iSMn_LDMv5RrhE8Z30n8SV7QfUM6VzGz5AElCYRMZviEMUIVOp.B7KPGCHqJ85kvXtaMKPqBrBnL
 YSC45YNZG82S.bKKPPtl7hEq.X9iRG8Hm0JigN8hQYfxz4j9Ytzl.0Y16T2VrIIg6A4YcmoaKJxK
 I.X4ayTebbLtg59g9uKFRJQ8oaTEZ__c1Aag9p_AA2M8_JJl3yJVhcWSuKJ20CzhcwaADoJcysVW
 mfLHU3kVLlowe1WhBdYz5Pf3Wqnv0IG890aQjGJPQtOy.SvguX8oLHpDIJYgWuHVytD9Sf2Q64zg
 pGd8q69T9p9QcCI3eoHCGnl3tb0OysL8EqLQwmXRm7.TnO1UsJV9rABSTENFlHAnQQ9MZS6sI_ty
 FoLy.VZK41_tjTX5QTSVWuTAatsBEnf8IvfK4zleGNkA963XzKakHUjMGEoOYKOWdNJ71SzVXmON
 MAcrvXZafIS05M.mlBwbuvE0ZsHNcR3ujnZqI688C3jz39BHNFLXqVOaKt.tJeO.z1J_m4Kdd6mT
 2JMFpY19dJlzqBUpGxANaDToyewkCM4xGDP9Tsb_fVcL2b72DWEtUWr4gb128TQz5PeR.wpamn4m
 O3uFnvy5GBX8ZAuLWtfkgbBqwRbYcb2kBp1Cf90B.v_CjKrjyDn71tQy83pN1grGeUxxvt8XbIXL
 oUolzl6v9MYtNI5GjxEXL7Qb2hKOFJrYecELikMB5HzQ2jzWseFU6WsR1cSJn8QwdGjQcyyK0j4s
 7QGY0dWx.6TjX03pFTMM6xDCXFMziBTJmqWpMxuvZQDk2DcllDNjP0jdFyUlb5Jg12te5Io1b14e
 OjKxeS4XuHLy35H4dCAaN_Gz90jLEcl_0F.613nyWNnImKYwERURxtZQdGZmDPhCUvGwXWu.xZju
 GLfTQONpMnrRiM0iHnzZKCXWN6l7TV.BNITdi9lpnVTI1miwGHt83NyJtCMubZSO7VRAAs15wG.8
 1jkPDi4BXacTWxRXratShglYvUur7wwPib6.QiymqjyjZAYrfqyD0vLlNdzApYLqpwWq..aBxKRi
 Qkbt3itaTAWyn8nBMdJjx4va6hxphZX7HQnVEgeXWty_FtLjAemqJB9OcipGci6FlHZV_JvYSl9c
 eIIAGZfGf5PFhC4OPB0sVgNGM1i9icJ8KUFCgIrCJgbzTCQTvekS2U3x7tNYrAYjKFo.wkR.pwzZ
 XN7LhEgCj6hSJRg2pUlYWcuhXkmtijoAoqcIzZRiRO46uRWwv1NyEzhCaTjyeZvk1UQWQCC8nTyv
 cRc6yhWk7DRH_IBUa6aIgs4lSqCfGUv4oaXAS7umUgMoNvHrbYVjoa1oywxwTgezfaO1ceEcQhSr
 DESPICLcKeb7JBc4fu29GohyI28voikYkG9F1FjYbB4xI29n0QJR5006dX2cKRKyyYj66razNS7F
 Pcf1rvxKB7NKDrscApo7YModmM5mjspGG6_sOqzU.4KK1g0Y_esxOrSrXveFZ7P2qIv1WxrNpQp5
 4rDMGQw1xH32CGKnCVe0olJVMjYjyRCcp_iWrv3cyT7F86vP6d7sWk4_XLcKEatCKydIFkDfKiZD
 my0_FmupSc2mhGdGSgDUBFGrF8SJtFYZZT9KxzP.yVvZNgoo8MTqEf7qApjW2iCG8tRCqNksNGCf
 Kgj2y8EM9XZnjHg9ZDgETp168so5T3t4JUSglH3m62BWfKQeR0XIrXjMRVs7eD1DNOHE6aj4aR1n
 hr1IOnzA9IwLeLhtNt2NOIth6_HrVZniwtapYRn9VCPk2Il0KWygfwzazYaS9gIM5M4XniJoeRIk
 t5sYgstEaclywuuynl6D1eBoEGhPvZsHjaceNOwJwMV_aTrTBa0oYNh3V9lqhs_k.PBOAF8NpTkv
 lU_gu1__mA0AmC2vyFv_0AfEO6.pLP2k1gumDErG2xQmrDQEXsXTWzeScDpJkDb6djW_Mspke_5T
 4IUHjBecNOP55im10UbmeH.wG_k4iZexrS5P6kLw1b6lqoxILAP6OPAtXMgrqyS43cZBI5nCvKw-
 -
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ir2.yahoo.com with HTTP; Thu, 28 Jul 2022 23:06:00 +0000
Received: by hermes--canary-production-ir2-d447c45b6-2hw4d (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID cc533e55d44823863c28b7b5f45a5333;
          Thu, 28 Jul 2022 23:05:55 +0000 (UTC)
Message-ID: <c52e34f1-1cc3-4351-e03b-6b9bf83481b6@rocketmail.com>
Date:   Fri, 29 Jul 2022 01:05:53 +0200
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
 <8639301c-ae9e-54ac-919d-baeb8760a31b@rocketmail.com>
 <CAHp75VecjLe67XfK6qgM4eZfKiTJ-UabD40i6Q_YmMpyWAWMkg@mail.gmail.com>
From:   Jakob Hauser <jahau@rocketmail.com>
In-Reply-To: <CAHp75VecjLe67XfK6qgM4eZfKiTJ-UabD40i6Q_YmMpyWAWMkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.20447 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy,

On 27.07.22 19:39, Andy Shevchenko wrote:
> On Wed, Jul 27, 2022 at 12:01 AM Jakob Hauser <jahau@rocketmail.com> wr=
ote:
>> On 04.07.22 21:37, Andy Shevchenko wrote:
>>> On Mon, Jul 4, 2022 at 12:04 AM Jakob Hauser <jahau@rocketmail.com> w=
rote:
>=20
> ..
>=20
>>> Possible alternative would be more steps in 2), i.e. introducing
>>> chip_info for the callback only, then add field (or semantically
>>> unified fields) by field with corresponding changes in the code. In
>>> this case it would be easier to review.
>>
>> What do you mean by "introducing chip_info for the callback only"? I
>> guess you mean the function pointers?
>=20
> Yes.
>=20
>> According to this, the patch could be split into:
>> 1) introduce function pointers
>> 2) introduce arrays to look up values
>>
>> However, what's missing there is the introduction of the chip_info
>> approach as such. Admittedly difficult to follow are the changes in
>> yas5xx_probe():
>>  - yas5xx->devid gets removed, it was the main switch decider before
>>  - (for usage on other switches it is moved to yas5xx->chip_info->devi=
d)
>>  - yas5xx->chip as an enumeration is newly introduced
>>  - yas5xx->chip_info as a structure gets initiated
>>  - As the chip_info now chooses according to the i2c_device_id (via
>>    enum chip_ids, thus yas5xx->chip), a new check is introduced to
>>    make sure it matches the device ID read from the register. This
>>    is done by "if (id_check !=3D yas5xx->chip_info->devid)".
>>  - The way of reporting product name and version name was changed
>>    because introducing chip_info required to do this in one place
>>    for all versions.
>>  - As a consequence of this, yas5xx->name became obsolete.
>>
>> This would have to be done before introducing function pointers and
>> arrays, like:
>> 1) introduce chip_info structural changes
>> 2) add function pointers
>> 3) add arrays to look up values
>>
>> But it can't be easily split that way. I can't establish an "empty"
>> chip_info approach as a fist step without removing or changing many
>> other things. The structural changes are related to other changes in
>> that patch.
>>
>> I'm thinking about first introducing chip_info and thereafter
>> establishing the function pointers. In between I could try to split ou=
t
>> the new temperature function:
>> 1) introduce chip_info structural changes incl. arrays to look up valu=
es
>> 2) split out new yas5xx_calc_temperature() function
>> 3) add function pointers
>>
>> I'm not yet sure it can be split that way because things are entangled=
=2E
>> But I will try to this in v5.
>=20
> Yes, my main point is to try to see under different angles on how you
> can split the series. We have plenty of time.

OK, I'll try it like this in v5.

=2E..

>>>> -#define YAS530_20DEGREES               182 /* Counts starting at -6=
2 =C2=B0C */
>>>
>>>> -#define YAS532_20DEGREES               390 /* Counts starting at -5=
0 =C2=B0C */
>>>
>>> The comments suddenly disappear from the file. See below.
>>
>> The comment's didn't actually disappear but rather got restructured by=

>> introducing new chip_info approach. See below.
>=20
> See below.
>=20
> ..
>=20

=2E..

>>> Also, use * instead of one dimension of array.
>>
>> Sorry, probably I lack the basic knowledge here. Can you explain how t=
o
>> do that?
>=20
>   static const char *_name[][] =3D {
>   };
>=20
> ?

Indeed I was missing that basic knowledge. Thanks for showing!

After some trying and reading, I think it should be:

        static const char * const _name[][] =3D {
        };

>>>> +/* Number of counts between minimum and reference temperature */
>>>> +const u16 t_ref_counts[] =3D { 182, 390, 390 };
>>>> +
>>>> +/* Starting point of temperature counting in 1/10:s degrees Celsius=
 */
>>>> +const s16 min_temp_celcius_x10[] =3D { -620, -500, -500 };
>>>
>>> See above.
>>
>> The former comments...
>>     182 /* Counts starting at -62 =C2=B0C */
>>     390 /* Counts starting at -50 =C2=B0C */
>>
>> ... and the two new comments above the arrays actually should say the
>> same thing. At least that was my intention.
>>
>> The first value is a number of counts. And the counting starts at a
>> certain temperature, which is the second value. Both the old and the n=
ew
>> comments are intended to describe this.
>>
>> In the introduction of this temperature handling (patch 4), there is a=

>> lot more description on these values in function yas5xx_get_measure().=

>> When creating the new "chip_info" patch 9, I was thinking about moving=

>> some of that description up here to these arrays. However, instead I
>> tried to following Jonathan's suggestion in v3 to keep the describing
>> text low and rather let the formulas speak for themselves. These value=
s
>> are applied at a formula in function yas5xx_calc_temperature() which i=
s
>> supposed to by kind of self explanatory.
>>
>> What may lead to confusion is the equivalent usage of "starting" and
>> "minimum" here. In the initial patchset I used "starting" related to t=
he
>> counts, Jonathan suggested "minimum" or actually "min_temp" related to=

>> the temperature. The comments here above are bit of a mixture of both.=
 I
>> still think it's good enough to understand. The sentence "Starting poi=
nt
>> of temperature ..." describes the value min_temp_celcius_x10. Using a
>> term like "starting temperature" would probably be more confusing.
>=20
> Confusing to me, who doesn't know the specifics of the chip, it is
> easy to read '-62 =C2=B0C' vs. "read comment, look into an array, calcu=
late
> in your brain".

I don't have a good idea how to fulfill your requirement in a brief way
when the values are stored in an array altogether.

Instead I end up at a longer comment again.

Though this also offers the chance to add some additional information
where the values were taken from.

Is it appropriate to include this to kernel doc? Generally I'm unsure on
kernel doc but I guess yes...

It would look like:

/**
 * const u16 t_ref_counts[] - Number of counts at reference temperature
 *
 * The temperature value at YAS magnetometers is a number of counts. The
 * values in t_ref_counts[] are the counts at the reference temperature
 * of 20 =C2=B0C.
 *
 * For YAS532/533, this value is known from the Android driver. For
 * YAS530, it was approximately measured.
 * /
static const u16 t_ref_counts[] =3D { 182, 390, 390, };

/**
 * const s16 min_temp_celsius_x10[] - Starting point of temperature
 * counting in 1/10:s degrees Celsius
 *
 * The array min_temp_celsius_x10[] contains the temperatures where the
 * temperature value count is 0. The values are in 1/10:s degrees
 * Celsius to ease the further temperature calculation.
 *
 * These temperatures are derived from the temperature resolutions given
 * in the data sheets.
 */
static const s16 min_temp_celsius_x10[] =3D { -620, -500, -500, };

Please note that I have to touch and extend these comments in the last
patch "Add YAS537 variant". In the first comment I'll add that the value
for YAS537 was approximately measured too. And in the second command I
have to add the word "theoretical" temperatures because on YAS537 it is
at -386 =C2=B0C, which is below absolute zero Kelvin, thus a mere theoret=
ical
temperature.

>>>> +struct yas5xx_chip_info {
>>>> +       unsigned int devid;
>>>
>>>> +       const int *volatile_reg;
>>>> +       const int volatile_reg_qty;
>>>> +       const u32 scaling_val2;
>>>
>>> Why const here?
>>> I assume entire structure is const, no?
>>
>> I'm rather new to C language, not having a good grasp of "const" in
>> structures yet. I would have guessed it doesn't work well with the
>> function pointers.
>>
>> However, having some compile tests, there are no complaints about the
>> function pointers.
>>
>> To change the whole chip_info structure to "const", I would:
>>  - within the "struct yas5xx" change to "const struct
>>    yas5xx_chip_info *chip_info;"
>>  - change following typedef to "static const struct
>>    yas5xx_chip_info yas5xx_chip_info_tbl[] =3D ..."
>>
>> Then, within the "struct yas5xx_chip_info", I can remove "const" from:=

>>  - int volatile_reg_qty;
>>  - u32 scaling_val2;
>>
>> However, I have to keep "const" at the following, otherwise the compli=
er
>> complains that "initialization discards 'const' qualifier from pointer=

>> target type":
>>  - const int *volatile_reg;
>>
>> Summarizing, after the changes it would look like the following (snipp=
ets):
>>
>>         struct yas5xx_chip_info {
>>                 unsigned int devid;
>>                 const int *volatile_reg;
>>                 int volatile_reg_qty;
>>                 u32 scaling_val2;
>>                 int (*get_measure)(struct yas5xx *yas5xx, s32 *to,
>>                                    s32 *xo, s32 *yo, s32 *zo);
>>                 int (*get_calibration_data)(struct yas5xx *yas5xx);
>>                 void (*dump_calibration)(struct yas5xx *yas5xx);
>>                 int (*measure_offsets)(struct yas5xx *yas5xx);
>>                 int (*power_on)(struct yas5xx *yas5xx);
>>         };
>>
>>         struct yas5xx {
>>                 struct device *dev;
>>                 enum chip_ids chip;
>>                 const struct yas5xx_chip_info *chip_info;
>>
>>                 ...
>>
>>         };
>>
>>         static const struct yas5xx_chip_info yas5xx_chip_info_tbl[] =3D=
 {
>>                 [yas530] =3D {
>>
>>                         ...
>>
>>                 },
>>         };
>>
>> If that's reasonable, I'll change it that way.
>=20
> Yes, chip_info should be immutable, right? Otherwise it's something we
> may not rely on.

OK

>>>> +       if (id_check !=3D yas5xx->chip_info->devid) {
>>>>                 ret =3D -ENODEV;
>>>> -               dev_err(dev, "unhandled device ID %02x\n", yas5xx->d=
evid);
>>>> +               dev_err(dev, "device ID %02x doesn't match %s\n",
>>>> +                       id_check, id->name);
>>>
>>> ret =3D dev_err_probe() ?
>>
>> Makes sense, will change that.
>>
>> Though I have difficulties to implement this nicely. dev_err_probe()
>> requires an "error value to test". The current "if (id_check !=3D
>> yas5xx->chip_info->devid)" doesn't offer such a value by itself.
>>
>> Do you think the following would be appropriate, nesting the check
>> within the dev_err_probe()? It doesn't look too good to me.
>>
>>         ret =3D dev_err_probe(dev, id_check !=3D yas5xx->chip_info->de=
vid,
>>                             "device ID %02x doesn't match %s\n",
>>                             id_check, id->name);
>>         if (ret)
>>                 goto assert_reset;
>>
>> If there are no better ideas, I would implement it that way.
>> Additionally adding a comment and putting it into a block with the
>> regmap_read before:
>>
>>         /*
>>          * Check if the device ID from the register matches the one se=
t
>>          * in the Device Tree.
>>          */
>>         ret =3D regmap_read(yas5xx->map, YAS5XX_DEVICE_ID, &id_check);=

>>         if (ret)
>>                 goto assert_reset;
>>         ret =3D dev_err_probe(dev, id_check !=3D yas5xx->chip_info->de=
vid,
>>                             "device ID %02x doesn't match %s\n",
>>                             id_check, id->name);
>>         if (ret)
>>                 goto assert_reset;
>>
>> Hm, I think it's a bit hard to read. Suggestions for improvement are
>> welcome. Otherwise I'd add it that way.
>=20
> It should be like:
>=20
>   if (id_check !=3D ...)
>     return dev_err_probe(dev, -ENODEV, ...);

Ah! Thanks :)

>>>> +       dev_info(dev, "detected %s %s\n", yas5xx_product_name[yas5xx=
->chip],
>>>> +                yas5xx_version_name[yas5xx->chip][yas5xx->version])=
;
>>>
>>> I'm wondering if these arrays can be actually embedded into chip_info=
?
>>
>> While the variants (like "YAS530") are listed in the chip_info, the
>> versions (like "A") are not. Yet, including the versions in chip_info
>> would double the amount, making it visually more unclear, with only
>> minor benefit.
>>
>> The first part of this call, the "product name", applies to the
>> variants. Going the detour via chip_info, the array element to call
>> could just be hard-coded in the chip_info table, like:
>>
>>         static struct yas5xx_chip_info yas5xx_chip_info_tbl[] =3D {
>>                 [yas530] =3D {
>>                         ...
>>                         .product_name =3D yas5xx_product_name[0],
>>                         ...
>>
>> The second part, the "version name", is currently in the
>> three-dimensional array yas5xx_version_name[]. The first dimension is
>> the variant, this would need to be hard-coded in the chip_info table,
>> similar to the example above. The second dimension is the version, thi=
s
>> would need to come from within the yas5xx_probe() the function. I
>> couldn't find a way how to assign one dimension in one place and anoth=
er
>> dimension in another place.
>>
>> To include the second part in the chip_info, I would split the
>> three-dimensional array yas5xx_version_name[] into three separate
>> two-dimensional arrays, one per variant. It would look like this (snip=
pets):
>>
>>
>>         static const char yas530_version_name[][3] =3D { "A", "B" };
>>
>>         static const char yas532_version_name[][3] =3D { "AB", "AC" };=

>>
>>         static const char yas533_version_name[][3] =3D { "AB", "AC" };=

>>
>>         ...
>>
>>         struct yas5xx_chip_info {
>>                 ...
>>                 const char *product_name;
>>                 const char (*version_name)[3];
>>                 ...
>>
>>         ...
>>
>>         static struct yas5xx_chip_info yas5xx_chip_info_tbl[] =3D {
>>                 [yas530] =3D {
>>                         ...
>>                         .product_name =3D yas5xx_product_name[0],
>>                         .version_name =3D yas530_version_name,
>>                         ...
>>
>>         ...
>>
>>
>>         dev_info(dev, "detected %s %s\n",
>>                  yas5xx->chip_info->product_name,
>>                  yas5xx->chip_info->version_name[yas5xx->version]);
>>
>>
>> I'm not fully sure this is the best way. Also note that I had to set t=
he
>> size of the second dimension of yas530_version_name to 3.
>>
>> Do you think I should do it this way to include "product_name" and
>> "version_name" in the chip_info?
>=20
> Again, you are the author and my point is just to make you look at
> this from different angles. If you see no better way, go with the
> current approach, but just spend a half an hour and perhaps we may
> have a cleaner solution?

Indeed, to my own surprise I found a solution with the 2D array:

        static const char * const yas5xx_product_name[] =3D {
                "YAS530 MS-3E",
                "YAS532 MS-3R",
                "YAS533 MS-3F",
        };

        static const char * const yas5xx_version_name[][2] =3D {
                [yas530] =3D { "A", "B" },
                [yas532] =3D { "AB", "AC" },
                [yas533] =3D { "AB", "AC" },
        };

        ...

        struct yas5xx_chip_info {
                ...
                const char *product_name;
                const char * const *version_name;
                ...
        };

        static const struct yas5xx_chip_info yas5xx_chip_info_tbl[] =3D {=

                [yas530] =3D {
                        ...
                        .product_name =3D yas5xx_product_name[0],
                        .version_name =3D yas5xx_version_name[0],
                        ...
                },
        };

        ...

        dev_info(dev, "detected %s %s\n",
                 yas5xx->chip_info->product_name,
                 yas5xx->chip_info->version_name[yas5xx->version]);


>> If yes, should I probably do a similar thing for the values
>> "t_ref_counts" and "min_temp_celcius_x10"? Here as well, the array
>> elements are directly called in function yas5xx_calc_temperature()
>> without using the chip_info structure.

I then will include "product_name" and "version_name" as well as
"t_ref_counts" and "min_temp_celsius_x10" to the chip_info struct to
have everything collected.

=2E..

Kind regards,
Jakob
