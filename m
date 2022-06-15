Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 886AB54D3E6
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jun 2022 23:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346792AbiFOVnQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Jun 2022 17:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346491AbiFOVnQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Jun 2022 17:43:16 -0400
Received: from sonic305-21.consmr.mail.ir2.yahoo.com (sonic305-21.consmr.mail.ir2.yahoo.com [77.238.177.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF29A31900
        for <linux-iio@vger.kernel.org>; Wed, 15 Jun 2022 14:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1655329392; bh=2ZknfOT5zwSbcn0ktq9DoH21W/cCl1+GT/742JS3Vrs=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=SB8LJoDfy9v6VgmhQpYqYHgBI5Isc2A6N1nl+eBsN93WiE4BOoS1wAQXoTi/0KcuVuWqH0XsDWjQ7qUNDRjctHkTkkwLVy2q5lE5/UQrlEYWujb6QoW9BuOY6RdFeeto9Kdp56Mt7SAbfulBXRNTSp/aAm1MIOF1jSw2uhiTq6m0IlRUyXbcETawYr6K/CpYcsPxKx9i3mG7/gdZ2fp+SNkb1Yqo3sXNgU5F28m3k/HLvR7up43idvcxOvV0SHpr22f3DfyPixe2p29DXsQ0HF0Qk5lYuuHPit8Tae3aRzeYPgzp7SXTLSfK7mtK+WlfatUZhrPfpoJUIPPAytSkZQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1655329392; bh=oBb3QdoHJxOM37y0/OGk+HvRjnnhzlXQof4RxiY5cOj=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=T/mS/MPVifNDRpbtbuKAefFoBDySvQyvkIXhI/lTL5mcgEm4Fqb+r/31sXiTrCygUe7pT8mgzpeauUkM02aFwBUXomQU6qWcNXuect+Fl2M5XQk5eJBNfg1ExbuNYI5KTOebKLFuBk+XxpecFEpJfQnVqCQOQ3fBbgaZKQmUK4Gds1vxgl+7vOt8oNtqvpl2ciXp0lPipdbo/yovtWvEWJwbc1PqiizrBBLBiJ8N+K3e+9/DfsPQI3/0VIK3bOcRWQskJ3pM+1YV9+JH8LGQ7zhn1cXXNByQQM11pVsJY8yRGWQKcd9nB3DizkzDTqhVCkhnozuw9iCqCTnFlZRhfg==
X-YMail-OSG: FnGw3FYVM1myjp._LF7b.KaqvXsjYwRLX7v11QguRSZMncrTrembX6DVcyzEo6K
 zGTDo9of1uxmyB2t7LlQfMilHoUVu8.1W8vG0qf2hM8hRiZ_YIzaoUx.sDLfbULbIp99jZ40ynAp
 7NBhP7uTpMQIC6LlDBbq32Y59139rXme6gE.Tz9Pk8nk5P9_4q0ORltVkYwJm_iW_aFx7fd.otDd
 UuzKw5sEIVTOqLqkycNCAJFoe0ictkMgXZ8JK7YSIzh1hm0tAnAwVQ4I3cq3TQ84PoPedWzrm4ue
 Uh7Jy_turf0MMxEaOWbVD8PZkLE68XIMvpsI9VIo7oV9dqQZGCUXD1TBkX.qk63axeP3IuEioPDL
 SAPqt2ZDRL1ZKbvjChXioug4AH.4yuf8C1whzifsEzgJMDNDXbzcq2fNElNzdeD22ad6381SVkz5
 N18eygHLJ0VDdqHjFTUvPGRMNjdzLDsgaZTHLs8MG3DL74_w.1spRuZEwpr_kzUOGciaBzJ5NUat
 dtO09CJeJbYhssXHA.UwqPP8mgk0z1rgDDFaFzA009HgXdNjf_w7_dfjHnb8gf6HXrFwEW0ZAdyD
 Kvd0QsKpsfFpCTHMbSYpM1UQ1zUq2Um9HmTFhroywU3IFNzWAWk_8s7hk2tANdPmcqi3My.Las4D
 9B5I0yVX.R3Fpw6x9nWY8QlWcHU4a6J1sJtA8.HbYw4ybL7TJN7kqsc55n2t45fMER5lLsgeE6Eb
 TD1Ux8NgAgrIaiappperIaAXTnnPSStSKxmYZHXLEtv_Gs.Xnzkp176C.yTTMkZdjpJi0RXFqRDC
 fSKlrXdjoFuSjXWELfftDiG1X8NaDK9hsYDN8Obhw7AecFHxbsW9Bf866zRLar7R9pBIeiImXbSb
 szHlY6ZDymUuxt7cuGh3tQS_f28gX4honJgOs_661nvy7lI_Bhfwk2vOhf2EFY8Y30gkZfCpGJ6R
 G47IvONzCUpXbf.zdnQEwxxEtoQi5ZhGabusCNVgIHFMXoKmeWLqZ9Tfaq__RtIHmrQVNV_LO_pE
 Xj.wti7LaQAoXrl0nYkRGceNUvum4dgBhPh51ZsOvSkHl22IWs0JswCXbxtOeDBAHvUf8kk1N8W7
 bZX8nrZAQ0p.mIW3NCScZ.IM3aGP8lJ7Z9QG2ufCOtvu90c7G.6W4E4XOh8JiRiqBxUkKzkYyBSF
 JbdMv3P01.VBf2smPGE67shkfMowR9cBal3uoUIGzpKEbMsb53G9zrDmUQBSMbQu8vtVlChsI_xC
 3_zkB2LinP5nVeh5Ne2JdiqKPQ7nGH57N_QsWktwyxFxxLbszW3OGPPaMm_oDQqJMe9OMB3N7ghz
 .JyV7yzNyQyQWcmNvymH3U3HFhz6mf0GWtwVDZp8ltvWG6NbuVbqmsz38Zs53s45Crd.nIqRIXQD
 A8GnGWr.cXVIgwQuml_yRLAmZw0asYnr7jLK0WHJ1WupY2L2vsMcnFJFB6Cvv_RqTc90r2h5aOub
 rHwjDn.qVyNGzxWC09Vk2RUDv5uBskbLYz.Yv.4.lCqbMlA.rER8RxVeu52NdJBo5KZdauZHsbEB
 2KJd9l741P7xZOkci.3nlPLRfxgM7soVSaOsKO44pN2tNJ6XHFdUIkkoYb8uKKzOzVhNn4e1baDB
 4TZ2U48gA7EEGDuD5cxHxtf9hMVckRUSn87qNPOtKaYC7ZlJ2Vyb4DpgftvSGdtrs6zZeMNL0IWF
 CsWPe3DzfjkGeuYH.aK3bxsQFKwGWv13i0jLxA0c_sNZapeYZU7apbVRROprQcjIEe4shxYXsqrh
 EpRdrMq7n02NOlsFgJPR.Nin1KfiBZq97m31.I202FL2.WkW2jVRA8odRubh4VCky83BA1T6jJUH
 rQMeKqlj.xDAQnPrjucqkHJmqlHvRWBwKvJWS1QTN_seO4lCaoEs3Yo0uX9v8lJUOnjTXRjSbVgq
 mBcql91Q8BFQGuJuIx9EFNsBp7A82g67NtYs8XKIzwkiEMzyPgeIjuThr.YKqN_ok3swyOCbeEHz
 kKjKcKzMzCwZd1bqlpFi.PBjOzVD6_LhTQSL5fBzouk269oDbeMML8fzuBJOXC_ZEJgaDFflndzN
 VyYJiVRkVn5IHFWwzayTWguGQGLgKfLdunBt.ZwKMs4PUFSaaf_kCP.SiDGoHqUijaQ.fIkk5LVq
 dYkvk8wH0lmT1VowFOXlwHCXhg0HS2FUvsPesJNa77J3ACnyUYmFjmRG_THiYGeHfEInhvnRag0Z
 VNT15KYrLIyVL9Y3tfE.MYazXsqvsWtOZ3iU9MGl3J9_GmU7GTVbeADKF7kFLL3NKbaMsQAWxcvj
 ylg--
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ir2.yahoo.com with HTTP; Wed, 15 Jun 2022 21:43:12 +0000
Received: by hermes--canary-production-ir2-c9bf9d9bc-brwkd (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5a325aea9ee056441ff70e4c9e27b4df;
          Wed, 15 Jun 2022 21:43:10 +0000 (UTC)
Message-ID: <033f64ea-4ba7-eb89-3259-688008e29989@rocketmail.com>
Date:   Wed, 15 Jun 2022 23:43:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 7/7] iio: magnetometer: yas530: Add YAS537 variant
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <cover.1655081082.git.jahau@rocketmail.com>
 <b6e100de37921c22ebf0698f8e0e99794053303a.1655081082.git.jahau@rocketmail.com>
 <CAHp75VfFwSQ6bk=TMLiyA1j-AsafjGdVFbTTHJJ67C8zeYfz8Q@mail.gmail.com>
From:   Jakob Hauser <jahau@rocketmail.com>
In-Reply-To: <CAHp75VfFwSQ6bk=TMLiyA1j-AsafjGdVFbTTHJJ67C8zeYfz8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.20280 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy,

again on the Cc list, sorry: Looks like the part...

"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
<devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy
Shevchenko <andy.shevchenko@gmail.com>,"

=2E.. as a text string is saved in your e-mail clients' address book as
the name of the e-mail address <~postmarketos/upstreaming@lists.sr.ht>.

On 13.06.22 17:20, Andy Shevchenko wrote:
>
> On Mon, Jun 13, 2022 at 3:18 AM Jakob Hauser <jahau@rocketmail.com> wro=
te:
>>
>> - * YAS537 MS-3T (2015 Samsung Galaxy S6, Note 5, Xiaomi)
>> + * YAS537 MS-3T (2015 Samsung Galaxy S6, Note 5, Galaxy S7)
>=20
> Not sure what happened to Xiaomi. There is nothing in the commit
> message about this change.

"Xiaomi" is too generic, specific devices should be listed here. E.g.
Xiaomi Redmi 2 seems to have YAS537 but I'm fully sure this applies to
all its variants [1]. Samsung Galaxy S7 (and S7 edge) is often quoted in
conjunction with YAS537, so I took this.

Further down you suggested to move stray changes into a separate patch.
I'll move this one too.

[1] https://en.wikipedia.org/wiki/Redmi_2#Variants

>> +#define YAS537_MAG_AVERAGE_32_MASK     GENMASK(6, 4) /* corresponds t=
o 0x70 */
>=20
> Useless comment.

The comment is related to the values in the Yamaha Android driver [2].
It depends on the "average" to be chosen [3], "YAS537_MAG_AVERAGE_32" is
used for regular operation [4]. As this isn't easily comprehensible on
the first sight, I added that comment.

Within the mainline driver, the comment is not necessarily needed. Will
remove it.

[2]
https://github.com/msm8916-mainline/android_kernel_qcom_msm8916/blob/GT-I=
9195I/drivers/iio/magnetometer/yas_mag_drv-yas537.c#L258
[3]
https://github.com/msm8916-mainline/android_kernel_qcom_msm8916/blob/GT-I=
9195I/drivers/iio/magnetometer/yas_mag_drv-yas537.c#L63-L68
[4]
https://github.com/msm8916-mainline/android_kernel_qcom_msm8916/blob/GT-I=
9195I/drivers/iio/magnetometer/yas_mag_drv-yas537.c#L748

>> +#define YAS537_MEASURE_TIME_WORST      1500 /* us */
>> +#define YAS537_DEFAULT_SENSOR_DELAY    50   /* ms */
>> +#define YAS537_MAG_RCOIL_TIME          65   /* us */
>=20
> Instead of the comments, use unit suffixes, i.e. _US, _MS, _US.

OK, thanks for the hint.

>> +       /* Read data */
>=20
> Not sure how useful is this comment.

It's part of the "process description": Read data, Arrange data, Assign
data. Maybe I've overdone the commenting here, I'll remove those three
comments.

>> +       *t =3D ((data[0] << 8) | data[1]);
>=20
> Looks like get_unaligned_be16().
>=20
>> +       xy1y2[0] =3D ((FIELD_GET(GENMASK(5, 0), data[2]) << 8) | data[=
3]);
>> +       xy1y2[1] =3D ((data[4] << 8) | data[5]);
>> +       xy1y2[2] =3D ((data[6] << 8) | data[7]);
>=20
> Ditto for all above.

Ah, I wasn't aware about using this here. Will apply.

>> +                       if (h[i] < -8192)
>> +                               h[i] =3D -8192;
>=20
> -BIT(13) ?
>=20
>> +                       if (h[i] > 8191)
>> +                               h[i] =3D 8191;
>=20
> Altogether seems like NIH clamp_val() or clamp_t().

I didn't know, thanks. I will change...

if (h[i] < -8192)
        h[i] =3D -8192;
if (h[i] > 8191)
        h[i] =3D 8191;

=2E.. into:

clamp_val(h[i], -BIT(13), BIT(13) - 1);

>> +                       xy1y2[i] =3D h[i] + 8192;
>=20
> BIT(13)

Hm, if doing it here, it probably should be done for the whole
paragraph. In that case...

for (i =3D 0; i < 3; i++)
        s[i] =3D xy1y2[i] - 8192;
h[0] =3D (c->k *   (128 * s[0] + c->a2 * s[1] + c->a3 * s[2])) / 8192;
h[1] =3D (c->k * (c->a4 * s[0] + c->a5 * s[1] + c->a6 * s[2])) / 8192;
h[2] =3D (c->k * (c->a7 * s[0] + c->a8 * s[1] + c->a9 * s[2])) / 8192;
for (i =3D 0; i < 3; i++) {
        if (h[i] < -8192)
                h[i] =3D -8192;
if (h[i] > 8191)
                h[i] =3D 8191;
        xy1y2[i] =3D h[i] + 8192;
}

=2E.. would become:

for (i =3D 0; i < 3; i++)
        s[i] =3D xy1y2[i] - BIT(13);
h[0] =3D (c->k *   (128 * s[0] + c->a2 * s[1] + c->a3 * s[2])) / BIT(13);=

h[1] =3D (c->k * (c->a4 * s[0] + c->a5 * s[1] + c->a6 * s[2])) / BIT(13);=

h[2] =3D (c->k * (c->a7 * s[0] + c->a8 * s[1] + c->a9 * s[2])) / BIT(13);=

for (i =3D 0; i < 3; i++) {
        clamp_val(h[i], -BIT(13), BIT(13) - 1);
        xy1y2[i] =3D h[i] + BIT(13);
}

Further down in function yas537_get_measure(), there is another part...

*xo =3D (x - 8192) * 300;
*yo =3D (y1 - y2) * 1732 / 10;
*zo =3D (-y1 - y2 + 16384) * 300;

=2E.. that could be changed accordingly to:

*xo =3D (x - BIT(13)) * 300;
*yo =3D (y1 - y2) * 1732 / 10;
*zo =3D (-y1 - y2 + BIT(14)) * 300;

Overall for me it's harder to read that way. But maybe I'm just not used
to it.

>> @@ -679,6 +887,7 @@ static int yas530_get_calibration_data(struct yas5=
xx *yas5xx)
>>         c->r[0] =3D sign_extend32(FIELD_GET(GENMASK(28, 23), val), 5);=

>>         c->r[1] =3D sign_extend32(FIELD_GET(GENMASK(20, 15), val), 5);=

>>         c->r[2] =3D sign_extend32(FIELD_GET(GENMASK(12, 7), val), 5);
>> +
>>         return 0;
>>  }
>>
>=20
> Not harmful, but a stray change. Ditto for the rest like this. I would
> rather split them to a separate patch.

Makes sense to split. Though the new patch will likely get a quite
generic commit title like "minor cleanups".

>> +       dev_dbg(yas5xx->dev, "calibration data: %*ph\n", 17, data);
>=20
> Use less stack by "%17ph".

OK.

There is a similar line in the current driver, will change this as well
in the new stray change patch.

In yas530_get_calibration_data() I see a little mistake, it reads 14
fields, should be 16. I'll include this little correction in the stray
change patch too.

>> +       /* Sanity check, is this all zeroes? */
>> +       if (memchr_inv(data, 0x00, 16) =3D=3D NULL) {
>=20
>   if (!memchr_inv(...))
>=20
>> +               if (FIELD_GET(GENMASK(5, 0), data[16]) =3D=3D 0)
>> +                       dev_warn(yas5xx->dev, "calibration is blank!\n=
");
>> +       }

No problem to change for YAS537.

At YAS530/532, there is a similar line that should be changed
accordingly. However, there is a patch by Linus that was already added
to "fixes-togreg" branch in iio.git quite a while ago [5]. The patch is
not included in torvalds/linux v5.19-rc1 or -rc2 and neither in iio.git
testing branch. So I'm unsure what I should base the patchset on if I
want to change that line. I will probably choose linux-next, as the
patch is included there and in Kconfig also patch "iio: magnetometer:
ak8974: Drop dependency on OF" is included (which on the other hand
isn't included in "fixes-togreg" branch in iio.git).

[5]
https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=3D=
fixes-togreg&id=3Dbb52d3691db8cf24cea049235223f3599778f264

>> +               for (i =3D 0; i < 17; i++) {
>=20
> 16 and 17 seems like a magic that is used a lot, perhaps define?

17 is the size of the calibration data array in YAS537. Accordingly we
work with array fields 0 to 16.

On YAS530, the calibration data array has a size of 16, therefore
working with fields 0 to 15. On YAS532 the size is 14, working with
fields 0 to 13.

I wouldn't use "define" as it is kind of defined by declaration "u8
data[17];" in YAS537 for example. We could probably make more use of
sizeof(data). E.g. the line ...

dev_dbg(yas5xx->dev, "calibration data: %*ph\n", 17, data);

=2E.. could be written as...

dev_dbg(yas5xx->dev, "calibration data: %*ph\n", sizeof(data), data);

=2E.. but we wanted to change this to %17ph anyway.

Also we could change the line...

        for (i =3D 0; i < 17; i++) {

=2E.. into...

        for (i =3D 0; i < sizeof(data); i++) {

=2E.. however, I wouldn't do that, as it makes readability worse for the
next steps,...

                if (i < 12) {
                        ...
                } else if (i < 15) {
                        ...
                } else {
                        ...
                }

=2E.. in the current implementation it's easier to see that the last one
is the remaining 15 and 16.

Summing up, I wouldn't change anything on the handling of the numbers 17
or 16.

>> +               ret =3D regmap_write(yas5xx->map, YAS537_MTC + 3,
>> +                                  ((data[3] & GENMASK(7, 5)) | BIT(4)=
));
>=20
> Here...
>=20
>> +               if (ret)
>> +                       return ret;
>> +               ret =3D regmap_write(yas5xx->map, YAS537_HCK,
>> +                                  (FIELD_GET(GENMASK(7, 4), data[15])=
 << 1));
>=20
> ..and here and in many other places, please drop outer parentheses,
> they are not needed.

It looked too dangerous without =E2=80=93 but thanks for the hint, I'll g=
ladly
drop them.

>> +       usleep_range(YAS537_MAG_RCOIL_TIME, YAS537_MAG_RCOIL_TIME+100)=
;
>=20
> Please, add a comment explaining why this is needed.

OK, I'll add: "Wait until the coil has ramped up".

>> +               dev_info(dev, "detected YAS537 MS-3T");
>> +               /* As the version naming is unknown, provide it for de=
bug only */
>> +               dev_dbg(yas5xx->dev, "YAS537 version: %s\n",
>> +                       yas5xx->version ? "1" : "0");
>=20
> No need to have two prints, just add a version to the above one and
> drop the bottom one.

OK.

----------------------

I also spotted a minor mistake in function yas537_get_calibration_data()
in the following part:

        /* Get data into these three blocks val1 to val3 */
        val1 =3D get_unaligned_be32(&data[0]);
        val2 =3D get_unaligned_be32(&data[3]);
        val3 =3D get_unaligned_be32(&data[6]);
        val4 =3D get_unaligned_be32(&data[9]);

The comment isn't up to date, talking about three blocks instead of
four. I'll correct this.

Kind regards,
Jakob
