Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376C558E3C8
	for <lists+linux-iio@lfdr.de>; Wed, 10 Aug 2022 01:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiHIXhF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Aug 2022 19:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiHIXhE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Aug 2022 19:37:04 -0400
Received: from sonic308-19.consmr.mail.ir2.yahoo.com (sonic308-19.consmr.mail.ir2.yahoo.com [77.238.178.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214717D7BF
        for <linux-iio@vger.kernel.org>; Tue,  9 Aug 2022 16:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1660088220; bh=vvdNEZJzPmOKnBpklilB720hYA7aUvvb/4g0VyOBQfQ=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=CIs5RdP/YoZ17l6BKeiz7+QM94KwbLEADF6R4IW2bvrz5qUnOaB2X/yheGtv6/LDp3hVS5SyLQHAQU0YoXOzrA0ddHVXBQIjrHpHJuDfMEOKflMtuIXvR/tYlEeTeuXWh6EBV22FYycPYtsgRGjPhyrvF8VajuMyOklDzD8Njr5X4xPZSZhOhxtIcXCg8OGP0x8nku+4NRiWNdiTfj4aIzuXJ8/OKFu4GL7mUsPgZoaBX+ApLk3NqoGX/6V3x019HlUBJzaPe2ETffCAh/ckZ2zVL2NEEpzHQ0E4qH7NV1dVbvFYxcb2lNhxpIPqh7byZPecL4KI4wjLAiOYfPcm/w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1660088220; bh=z+FFMvyEO3mGj6tzFx7qesfvl/ayk3q0nYEyl/oRhki=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=VhpoyCb43TfM5xZPdKwm0KJ6DWhZ8hKUj7xOu5z985xBgfcpVW4s/US+yEhhM+eeigrBNJppA/BXs7as6w9yzriwypLe2urlxUsyBeWgHW2nzu694bCDPbK8XtoLx98ZZG3PDSu4bQNHw2sh6klS+Klpu+6cg85stHGzJUoLNB7NyrI6/EctSzejXct0sDHRZ/GezjLza8KzgefLUCSPuCwp3nmLb/bZ9YpqkiSxXhPo46Xqq16RutJBtmCgcrQvHb8gTnUmY9mCeETwfJDK1FPOg37mfwWasLFFhl5Vgm2wx/hPD1ahG5wGh6XQQU/iwic+9/IBEsFpVDtbPT3I1w==
X-YMail-OSG: 0lzMhIgVM1msDNJnnvjh9.dp48kTvmScNIHrIMriY2a1qeu1FTrjQ4gxUJOMjCX
 Y5s7miC20j1HEhxv9l9ubKpydx6Lhdq8w6WJOYYVjmUktpLz59bJsC3xvsQEk86VcgkOP_3t2Bq4
 TK9UePKmH3RZG7tUKBOGobaw8x6RZmSNOAhZtNW6v5KtiprO4Pjkuf8m4Y7hpcDSmYdI.T9b6zSo
 WIlNBR1DN9RNETgjrz0bp7SYvBwnfCtqloksLebvfhhCiHpic410feVqwmoZefVb.xsjtU4wCXVi
 3FQlJJf7hm7y38sSJ8b6aNUDkRC5._gN43I.hp.B.j4MGDT_L8vs3H7BUOwm7V6mWrA2UsT_2eI4
 dHF81sj.JRUfFbfvPXepKZqlSrdyj.6pqB18wbZalIImDl5wBTPHcfSzKDmn39YLLhM5.wEnVF1Z
 GQcasv7HMeEraNZgdR2GhU8DgNiXhTJnXmtMkhyhyf9ctWUJZGRhOVx1npDSMZPlnnqZFGOS8SkR
 Wp.QOTEJ5nXqpW1WhoeqlvMzZ2bNIjLIrWEXgeOlNWNtYqQjfxfNbekpyZPdlEPImE8wrnK9ZRDO
 WB_SjU5MXB_M60ypyQD8xargH256S9r2R7xyzVzHyDI9_AyY6_MC08NHMYj5kCgGvQH6lq6ixZAi
 FP2NV2Z_0qhz3qf.OFbgYa1060VdtDb0hekNE5WE9LKnih8VYOP1BrFlWvTLuheksFPPiv0VIvGi
 5iP45AEG.4TwldcgLJ9j8X_61_8TjqVE12Oxgee8zQmy23CivftGy9X6W.wg.iBveEeWcV.KMIbi
 VevDvXje3XUI.wlUfF5_PALkQ7ovm0eF9c9_K2ciA.9.YqKEaWtN1YT2n6883Gum2QO5PUUKjb8t
 ksfu2tCHX8PL5ARQhbMPaskvpEMVY8UMD9AM4usrKw5Zn3yssrCza_0uq7vTaZ8gHP78G3EA59N0
 Jd87nxuuHYtKXZ6ySZbEdl5tiv1lIJMqIQDadfw2eefpvZEKJ3Tlhq7kY4l6NhSjZr4fP2tXNZA0
 9aeadx5hCSRMrTTPkWPBMTs4RZVQHGqPfd3dkFIZ6fplzdQtHNvVyopzwyW1BLhKFnJ_QrNqv7y8
 Kw6fyrAs_eSoZ1_WrBtu9OyXWDyPWfeOG_1dP4lCZhu0JtyaC__Bs3br2QNoPi6QpRHL.34m2hQ0
 5lRtxY7MhGi4hxW44d9ZV73evecLoG7SqhIauL_SBT.O06OC3KrKWj4OLbqHEhIF_1PxO0jXETAM
 sGFJvZj3B4u6K7LfDXMV6_VnSSFOMW1B2nR95t6wYoVzhBhJi2AwtOHcw..Ls6i8X.MH6bwS0.qm
 pXWDKIO8W98j38e7Q7tYV9ViJDVOLonZthnYchCfN2a27WDRiRF_FmybioTxMiaE7JSs3X0p7hp.
 4b5nxIgD6zlFzShhR2qsVzn5DGHSO8Tme8Yu7_wWYT_B8KggWm.Qx2fYO7z36fPqLgcrouBhLRcB
 OMkYLQobx_NWomU6YPApL3C6UwYS_ChbhmNw9w0gfh7a5CQF40LJ8ER0K92eQ5eo8TR0sSR3T5Pr
 .e1gTXwHocJZWiW3cKqunwf7x19OHyRj6gNkN.4J7hn9xHWygNPwWxviwMZ1OYKAu8ttrWDV2YAY
 OiuidHwcWHFwC0d_dnMQSOEHOkFyEKKqf9.DbI8Hp4bd72BXnuzirLRmXX_i40xQZxzh7blAA6mm
 t8uQtxJFep_eUAAWotjsSJ0bjHMcJh1_X5z.0G4IZKuekxjjKMhEIGpA4ztpdqNArGqBb2h7Xa9p
 GxtZW0ShO8Zxl6HEjIkGFw3ITtHoxMDpacegu1RgcS.aRdqLXlnE.11SWU2vte5a2GIh9tx.QwqX
 FS73ejIDKjWqV_XcyTmAGkEja8RUSUZGkmZcUqtXfTQMIzLQWk8pp_oKL2dYfThs_o_YB4kD6T7o
 3kYame.8WsBH6ACAMjyGPrWVLnIUta7SB4uABo2PQ.NqH6omtkFHDZjRiQ3W6A3cE0DqwhRPhAHn
 60MBAZefneTO73NpjsXhX5AWPXhTFrnaftjvE8z16aXaplHQOlPvN6qfdfy3NBO7lGxIjYL6Mdxp
 5KTP6A2vqrsoejijEJvmCpyyicu37QNnYb7cRWRmLXMf4wjd7MJIRO9MfGsMY5U00IKRT_D3SwAc
 3VLRCnZmZI110lLzafBolcSF_C.4p2h8mBqeLET9cS99RpZXVXH2wXpqdNiBl_a6OY5YAZvxUc9y
 iAtqhDF4xE8Qi7hfEKmR0nAEb8tezT8x2JbkhW8_CpnFf3jAA0w4A8bho4HMoJHfGLnplpPIhREI
 a3A--
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ir2.yahoo.com with HTTP; Tue, 9 Aug 2022 23:37:00 +0000
Received: by hermes--canary-production-ir2-f74ffc99c-pzqbs (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b025576e7c6b5e861c51e979db17d6bc;
          Tue, 09 Aug 2022 23:36:56 +0000 (UTC)
Message-ID: <42e40cc3-15ef-3481-f52f-5bb022b28280@rocketmail.com>
Date:   Wed, 10 Aug 2022 01:36:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 12/14] iio: magnetometer: yas530: Add temperature
 calculation to "chip_info"
Content-Language: de-DE
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <cover.1659909060.git.jahau@rocketmail.com>
 <2a93df6f99913e438dd2d394c074cf79544ab692.1659909060.git.jahau@rocketmail.com>
 <CAHp75VfSx+bnNRqmkEP=NAM=yssw2xvtQ1qzrDw_J3eLZwaZYA@mail.gmail.com>
From:   Jakob Hauser <jahau@rocketmail.com>
In-Reply-To: <CAHp75VfSx+bnNRqmkEP=NAM=yssw2xvtQ1qzrDw_J3eLZwaZYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.20491 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy,

On 08.08.22 13:36, Andy Shevchenko wrote:
> On Mon, Aug 8, 2022 at 1:07 AM Jakob Hauser <jahau@rocketmail.com> wrot=
e:
>>
>> Add temperature calculation to the "chip_info" structure to ease the h=
andling
>> of different YAS variants.
>=20
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

=2E..

Due to C11 standard 6.6.7 considering array calls not as constant
expression (discussion on patch 9), the temperature values need to be
moved directly into the chip_info table as well.

I would move the comments in a reduced way into the kernel doc. It would
look like this:

/**
 * struct yas5xx_chip_info - device-specific data and function pointers
   ...
 * @t_ref: number of counts at reference temperature 20 =C2=B0C
 * @min_temp_x10: starting point of temperature counting in 1/10:s
 * degrees Celsius
   ...
 *
 * The "t_ref" value for YAS532/533 is known from the Android driver.
 * For YAS530 it was approximately measured.
 *
 * The temperatures "min_temp_x10" are derived from the temperature
 * resolutions given in the data sheets.
 */
struct yas5xx_chip_info {
        ...
        u16 t_ref;
        s16 min_temp_x10;
        ...
};

static const struct yas5xx_chip_info yas5xx_chip_info_tbl[] =3D {
        [yas530] =3D {
                ...
                .t_ref =3D 182, /* counts */
                .min_temp_x10 =3D -620, /* 1/10:s degrees Celsius */
                ...
        },
        [yas532] =3D {
                ...
                .t_ref =3D 390, /* counts */
                .min_temp_x10 =3D -500, /* 1/10:s degrees Celsius */
                ...
        },
        [yas533] =3D {
                ...
                .t_ref =3D 390, /* counts */
                .min_temp_x10 =3D -500, /* 1/10:s degrees Celsius */
                ...
        },
};

As this is quite some change on that patch, I'd skip your "Reviewed-by:"
tag and you would need to review it again in v6.

Kind regards,
Jakob
