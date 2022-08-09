Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3CD658E3BB
	for <lists+linux-iio@lfdr.de>; Wed, 10 Aug 2022 01:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiHIX1E (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Aug 2022 19:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiHIX1E (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Aug 2022 19:27:04 -0400
Received: from sonic312-26.consmr.mail.ir2.yahoo.com (sonic312-26.consmr.mail.ir2.yahoo.com [77.238.178.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FEF27E32B
        for <linux-iio@vger.kernel.org>; Tue,  9 Aug 2022 16:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1660087620; bh=qMVpVMGU1TmkPPFJPrzujKkBRMxMp5uPVQQr6TEumP0=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=EI5DmwVkeLKOXTd3t2EgRCoxGYj12S3kw9hNLEEdTmS9iW7JPlXAVR4DoNGdAIIR2JQmEacgUo6zRtSwzQFYNVI+k4qeeCCwPyZyA79gWbJPyx5+pG2zIVgi1kXex8U+4f39rKIlTktU8GdLvovq7hqp5fLgqfXg8nbPECfB2Awda2GMCMQd5bj2Y9HxgPKx2d7PHSOQI2QpZd07SM/yYuhP9t9FQw0Urcp5dd2BWPo0z1qeRHeoUsUEu9Xj3z47BZBmFcylQvj1EX+uyvpmfvdBid/GWxc5bfIJ2tk35P36lVIJYK4tYAWW83N3zz/KupCq2ss3ACozjp7MNA1YAQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1660087620; bh=MSM9QHT88GYky9RU0PK3IxogEpzR4P63tCe/qAmR2/T=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=TiqQS8t7jalW8EYYfbIGyokoiPd0mx0fl7xfAj/OfIOkSlxJw4oBISFOvZQbcuJcQvnDHwbJEueECu3Et2YwviYJUD/JBzWbCbEPd2YMxLXnbxoHurn1/HsP9DwRP8t0CuML/9LwL4/bo2nOg2b57dOaeIOeabeDVwd+wzizxYvR1IErthBETc1jUEqLQBeyPWZQl5yd+LSKCOHZLdX3phjEmatO9G4SpH4qdCXQcJE3KRzGfSYXekfJr9BKWwyzLIQrOxQxoCYJ0MKGBF41zhYPmARht/DeWBj2bn61v0Fx6aFDFeOk+ahkOMd3xYCTsecMogtSW9j31Kr+OSCY1A==
X-YMail-OSG: bnhCLiAVM1nQI_G50fPMrhrdEpozZGTCz9qYh9vn9dAflV2RQC7tEk5zDuZXLZd
 2G3_yNWRt7VhrQ.6sDiWhm1M2JA0FZIIgpzMOBM0MKY8AoCqnDVncMAZR8u0LMuYKNRGqxuAWx1R
 zMkkHnc9KkuRjQvQX92.In87csLC.Cobk1QpVQ7P6jNBNLjH6.XEheb.vDEEQGP6DGtZBjm0W99M
 nTs9zL3XwH3S1P6F.pOCxdCZSeFtPyIWWya3WdLYQfs1v70.uNPaLJUXITroczvmg5..GtJrDccy
 qRKcRenaYZYClz_Cn24jiO9y.2htQIWwJC40Vh3QzQ..NNIbEpvLKjJCNyioVXGL3Q0v3EJebZze
 GdgM.4gjevblmdG2UZ15DX88ca0aASO_PQdHo2SoqcQ22CzAkpOKuffoog7l_.SMbWlb1wFltCfa
 4.3STY.CFE4Dhq008SjLyPv_KVAcPn2IFvTffLoUIEjBy8LM1VeHm1YlcG5Nac3PqJDmh_cx6..y
 FE1aDnJu43UNvj7MJfhybaux_SHKobPJxfc74wmjJPQSpjRR_nATnWfQwLCpVdxtx7kPaZrrlL8V
 fqwAhzqNhDRKE1TTe5Q6JQzI_KCBhLrhiQEBvy_rTCF9Bw_H.Ck.nQgQfOeIbxgaZpjF1oXWA9XG
 IJUDJqSUJWiuy_wdf8_BlypaCPbKY.Jy0ratVzWnt4XFaTRfFHTsxrIahbIiIR8IraWQQjFgSebh
 My3oDgx.nkOmmGDvZOw9ubEANRcQa9ls1hk7Lg0Czu4QuHpXVBuDoCtF6rWpngiPE5Wp01SPJFXs
 uihNH2KrOh7UmRsegQTP9vy0_VR0Z5L8Hp8Y09kzL4H7zhG45t41TIZn6yacxt1psI1ZJCtHgyZf
 pUwsz9wGgDCT5XhPgwzFYRskw7BKT8BKi2BP7uKuXAhLDlWJ5Pelq4CBI7mANe_jUICgjNFbT_Rq
 6P6szUMPpJoMWQsCDIXtFu1dC3KTvlFbirlgA2qlrWsEd55tyacyumcWxS_d.lKxNLZQowW8nfYr
 uWXj20wQWdJ2mO2EJHLUHWoJg9j4gxc9HSfsaPOaC4G4ENGZUDQiywIRiAdUboH5uY12OpSFxyqu
 4.4Ld14P3orxrztAaYJXhSo4H5RDwrTWqDeWlBWnQWNzfTGWItZ02ra.zFU2YKfpDmHr84KMJzya
 wgK2OHKAFihKlgehhvboh8kY8Xx3bGavyuPF2z2_Iy.GB37z6hofg1Gy7UOQw6VhpQ9s_MIfLDxD
 .dTNxWKpd9WN48x8a8_Yw7u9_S64.HmZtRyFEvuENsNzGhXhVNVHLr6fdemmZ2tHmejLV8WNpDMV
 1Wkh3yDL8o9DNkuIkpWW41iOCOT4sAq6hDNEEit4X_KwO4xnwNYeXMwxjri9sT9UoN8v5gds2vGT
 y7Ue8ueoxj_UPr9mlW6WHtwfELms_wOS_6gKuZ_1wMaNzmZb9h0UWxwWRQY2CCscJeFsci0kCTi0
 opn8HXX9v1vvLKWKXGco.jfzQeWRco1Ue1kqN0ZJLy8wVz_qyLqfKmCM0LfyzTXaUSrqGr345uKS
 MvFVCMJjILI7rdHkWjzX_Al90K3XypFj8NsgCXDasQLvvQsApZ8RM02xmKf5liXpaml.jM2CxEcC
 Xnql84LLVth9uEg0Py5mCZovbf3oTw4gQTQRyPqCh5ULeJvsiDa25KLsEdLsW7Q.YHBB8.h6dxUJ
 SaE9sHxFZKCbxdNyZWcUEtc8vdvy5hlNRt0v__1slaLdvixwJn9Ty1paxKAZrPABgZjPVrzh5gl4
 0RQrDCeN3EYYzPHqjgh_hf0Ceqt3Nvr6zGoEYh6kvVor_UqzQlKJwuPq6akLss17kEdLQuT1Q0Bh
 pwDdkGSPAkU3.fg5CtHDng1B1R4DHnGCOTaKnANnzfVywMZWjYp3aMuf3hBeM7a2Ra2mGBzpD8.C
 RLxYPPmghvomz3ULoQ_z0.2P1pP5WBlDcDkC4P2VL_n3cmo_NlSijRI2ren.J3rY2ahSx7H1aajx
 3LhjBQ9V.JbJna7InC7d7_sMtE_WVyeRWBnqV7a5hYfozAarttlJgbuIHA8nALW5.4peyohFae6o
 DQ__ecZ5YCbueui2mC55VWpTwRtsx6gc7rTj2rHwsemL_wGmQAtozKIQDk0HrgZNBSoumxynsEfl
 JyZMF4wzyOwdvTd5ZL1LWKcT6bxGhcD1Ax9QiQSsmHMkX0uXmn7fC0380j3i3oJmvVuJ0FC1XtLe
 1hwoTPnN.Z97LUtW2qomUMZbG1iX30rW6ja5nwdFB6GEvuBgAAHGKjUj5_f.1Iy_cJRUUEXjiN9v
 n_R3K9qmjNf2BCX5QuQ--
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ir2.yahoo.com with HTTP; Tue, 9 Aug 2022 23:27:00 +0000
Received: by hermes--canary-production-ir2-f74ffc99c-5fxhh (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ae15838654147fff1cca5820a59898a3;
          Tue, 09 Aug 2022 23:26:56 +0000 (UTC)
Message-ID: <42968746-9b8c-c6f0-7dfe-b08d26111d34@rocketmail.com>
Date:   Wed, 10 Aug 2022 01:26:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 09/14] iio: magnetometer: yas530: Introduce "chip_info"
 structure
Content-Language: de-DE
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>
Cc:     kernel test robot <lkp@intel.com>,
        Jonathan Cameron <jic23@kernel.org>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <8f5f58c9bf0f4006fabd01b5564af071d20f2a2d.1659909060.git.jahau@rocketmail.com>
 <202208081346.EWHUWCSa-lkp@intel.com>
 <CAHp75VecMvtHwkA6=JxHbX0oeRg+-fXNraggBCaOxqhf9WUdzQ@mail.gmail.com>
 <YvEy9uq49ZiBHtFd@dev-arch.thelio-3990X>
 <CAHp75VePJ2iKDx0Sj5SErW4nfpx-9KrN3c5yRFyfwgpfnMCkEg@mail.gmail.com>
From:   Jakob Hauser <jahau@rocketmail.com>
In-Reply-To: <CAHp75VePJ2iKDx0Sj5SErW4nfpx-9KrN3c5yRFyfwgpfnMCkEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.20491 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy,

On 08.08.22 20:04, Andy Shevchenko wrote:
> On Mon, Aug 8, 2022 at 5:59 PM Nathan Chancellor <nathan@kernel.org> wr=
ote:
>> On Mon, Aug 08, 2022 at 01:18:06PM, +0200, Andy Shevchenko wrote:
>>> On Mon, Aug 8, 2022 at 7:40 AM kernel test robot <lkp@intel.com> wrot=
e:
>>>
>>> ...
>>>
>>>> All errors (new ones prefixed by >>):
>>>>
>>>>>> drivers/iio/magnetometer/yamaha-yas530.c:933:19: error: initialize=
r element is not a compile-time constant
>>>>                    .product_name =3D yas5xx_product_name[yas530],
>>>>                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>    1 error generated.
>>>
>>> What?!
>>>
>>> The yas530 is a part of the enum, how come that compiler can't see
>>> this? Looks like a Clang bug.
>>
>> That is not what clang is complaining about here, you'll see the same
>> error even if you used '0', '1', or '2' here:
>>
>>   drivers/iio/magnetometer/yamaha-yas530.c:933:19: error: initializer =
element is not a compile-time constant
>>                   .product_name =3D yas5xx_product_name[0],
>>                                   ^~~~~~~~~~~~~~~~~~~~~~
>>   1 error generated.
>>
>> It is complaining that the initializer element
>> ('yas5xx_product_name[yas530]', rather than just 'yas530') is not
>> constant, which is a true complaint if I am reading C11 standard 6.6.7=

>> correctly.
>>
>> GCC 8+ has chosen to accept const structures as constant expressions i=
n
>> designated initializers, which it is allowed to do per 6.6.10. Nick di=
d
>> have a patch to try and match this behavior in clang but the work that=

>> was requested doesn't seem to be trivial so it was never finalized:
>> https://reviews.llvm.org/D76096
>>
>> You'll see the same error with GCC 7:
>>
>>   drivers/iio/magnetometer/yamaha-yas530.c:933:19: error: initializer =
element is not constant
>>      .product_name =3D yas5xx_product_name[yas530],
>>                      ^~~~~~~~~~~~~~~~~~~
>>   drivers/iio/magnetometer/yamaha-yas530.c:933:19: note: (near initial=
ization for =E2=80=98yas5xx_chip_info_tbl[0].product_name=E2=80=99)
>>   drivers/iio/magnetometer/yamaha-yas530.c:938:19: error: initializer =
element is not constant
>>      .product_name =3D yas5xx_product_name[yas532],
>>                      ^~~~~~~~~~~~~~~~~~~
>>   drivers/iio/magnetometer/yamaha-yas530.c:938:19: note: (near initial=
ization for =E2=80=98yas5xx_chip_info_tbl[1].product_name=E2=80=99)
>>   drivers/iio/magnetometer/yamaha-yas530.c:943:19: error: initializer =
element is not constant
>>      .product_name =3D yas5xx_product_name[yas533],
>>                      ^~~~~~~~~~~~~~~~~~~
>>   drivers/iio/magnetometer/yamaha-yas530.c:943:19: note: (near initial=
ization for =E2=80=98yas5xx_chip_info_tbl[2].product_name=E2=80=99)
>=20
>>>>    930  static const struct yas5xx_chip_info yas5xx_chip_info_tbl[] =
=3D {
>>>>    931          [yas530] =3D {
>>>>    932                  .devid =3D YAS530_DEVICE_ID,
>>>>  > 933                  .product_name =3D yas5xx_product_name[yas530=
],
>>>>    934                  .version_name =3D yas5xx_version_names[yas53=
0],
>=20
> Would then
>=20
>   .product_name =3D "YAS530 MS-3E",
>   .version_names =3D { "A", "B" },
>=20
> work?
>=20
> Jakob, note 's' in the field name as well.

Thanks for clarifying. I'll change it that way.

>>>>    935          },
>>>>    936          [yas532] =3D {
>>>>    937                  .devid =3D YAS532_DEVICE_ID,
>>>>    938                  .product_name =3D yas5xx_product_name[yas532=
],
>>>>    939                  .version_name =3D yas5xx_version_names[yas53=
2],
>>>>    940          },
>>>>    941          [yas533] =3D {
>>>>    942                  .devid =3D YAS532_DEVICE_ID,
>>>>    943                  .product_name =3D yas5xx_product_name[yas533=
],
>>>>    944                  .version_name =3D yas5xx_version_names[yas53=
3],
>>>>    945          },
>>>>    946  };
>=20

Kind regards,
Jakob
