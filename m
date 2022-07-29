Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7156E5856F4
	for <lists+linux-iio@lfdr.de>; Sat, 30 Jul 2022 00:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239560AbiG2Wwa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 29 Jul 2022 18:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239542AbiG2Wwa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 29 Jul 2022 18:52:30 -0400
Received: from sonic310-12.consmr.mail.ir2.yahoo.com (sonic310-12.consmr.mail.ir2.yahoo.com [77.238.177.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A767D783
        for <linux-iio@vger.kernel.org>; Fri, 29 Jul 2022 15:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1659135147; bh=1JUeSuTl5UnqmpQmXxlJ9fFmonK1o1XoIKUnYly2J6Y=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=VP0rhVRlVAbkA/z+ilXbId3ZQZWJaV7K9svgf1c2Bg7cEqKmefTqVDxRLI33PDcBqgk9QqaCt2vyRUpzNPnIb4NqwO7cMRI0MEjlPiInXZgHHJ3tEMgEslP3nFNXZH0ie3D2/Vcqcnz0WbcP3UczI31rocHKVbl/LuADHPZSWBD9zH4VvWHHLn+HlXSPmGrngXBlCTpq1F3/b4VzmSAbZpYOfDCGewnT8+yLOUIicyZ4jSbWje6gGoLwjL7iSvj2lJD2E3WnCqnKO8EkffQnLaj4SfNRwSuB6CiswE+tToKZsi/gf2dcRdiJhYoD6ig5OX9umsSWnVjgwuH9nCwy1w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1659135147; bh=05wwq41KnAfy/tUR/JWKMXCRvwRxXP4G40yNIwRrQ3H=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=IS3EHR589kQxxf4/o0GIs2ScqQE17W4P7S844p4kmHEoC46BEuV5FENRHhJ0rhGqkgXlAAfWhQw+ErdYmuZ0UQXk6M6DQ+2VudZItE7kybLgw6qQpWxV+s+kKGF0R8AuXcaWZsUJBY41xPQn04eQ2Xn+If4MDJG5B1td8V0KFl+1z+k5a8ZMXKKMhNb3kJCOn0fhzjkloJ35HJwD8LP09xi/jDCMZHixejwfxS3tH0rwKvDqqhH8v2IWab4UTkvdfOTOdX0cMgkYK/lojvz+4lHqKEqQhJj+qoXdHLhJ4DBlAkiPRAWpWODzzP3/wKIu6Rtwb3K2Hyuger1OTEgX+A==
X-YMail-OSG: GG9KCe8VM1nDzQZn_Uc3CaouocdfoNXjr5PENQNVmXrNhrlfyJgYhtReXcWWefM
 FeGkkhVt4TlPkXE6Ao74U7IyUnscCAK3gaqErHRu84QNyw7PWUQzil0sKJolYaDkaeQ2O56srwCC
 UYcCBrLKuQiHKqaNTJdaQTEEDaXbHKsze7VgQbksH4JM0RPv9sWC0KSmXPOCSVh8G.VJLSF0Nhkk
 fTi7tlep4_uBRF2XnuRVejYDsIo0p11FTy_iIp.m4an6MpETrH70hCAaglounIbsH86RVP2tSTND
 M_0zgVMU_rmteuiWRx5at893Zuy1MOc6oZk.tWWanuS8CIfYID6lJnldP9aCv5ccjC3_oFfAq9h7
 rzFxZF71up1FiHBCrU_BP8Uv_Ntbrym7Bk.JlBmP5xL5JEAx6CDboZlwVu66KalQMq2JTrQ9XxU9
 aoJNPMpCCqbxwiE4UAYPRAqJzi.KFn8cQELWEyTmR6U57XiS.yEvY7dv0sYtHqJ7pNrkS0bhDQTx
 zE6oGrncpW4tREpPjbiqpXKyj5Q7bdlT.XSrEtPAw24WGJ3yDB9LlCDfXdG1ByLfcfziQ5SDhtOY
 t6Qabu2l3oNz37yLKefH9qWPjubmDbBnfiVhsvmN.oMhq12TGMm_h1KQzOdBkobTC8Mh8EunGsf7
 qULgBmRj_i7.XxyBfTIxwlUC9RxLbW9RaGzrgfLpv1XAF08GmVeJVg1JtK5BIUcWai5QTPekxHqi
 0nYmTC1i6gSBUwXzxAGsaSpnJBui9tLLSMlEuC0dXmgiGU6y2frUfHa8oMOd6zvoHau1IliKNj9t
 7tUDR5EFPeS8PyvlshqTMyy4zhEGqAFnMxTClJ9vPa4CcUgMzCxCO_ZfJNdmgWbjNhDq4J.FKHnU
 hYVoIswu09liCZsPcYYC3pox5BALi9JSRuy5tjaA5DTR1iw2Ou.9H.cqFTkvLkv6SsGpsgs1SrAH
 hwvp9VAn1J_DCyJfBmNlLUZwI52d04ygUI9r4g3dC1kNs4Gea9P5tHElM1Pngp0DtpIydvhIN22P
 X.lpdR18.jHE8uE1o658hNtPnIYI.JYzuG5klTHfp9xMMzp5rC0pc3D9u5GHT3Ej5.sXLu6vVbSx
 Op6lrAdEila0n_KYq4aMDrrZZRdur60.axN4g5iWY1.zfuHEVJ9bV8SejYFwOxMNtJpf7XTLAHtf
 OjiAUkd8logUEXvK__U_2x2NbsTQTxBema9qm2fFv4PDSJ9S6y00BYhNb0vor2E5HHepwl.jfJrL
 0CT_7v1P4Hg4B8KiyqZ3ffb5ADfRGM8FBNb77jdS6nA.6EhuT2AnV1nTi6KCqWYOC9N5DhetHwVU
 sPJgueAhW93bt0RauLLFpVw2vSJcFZMe49X4TLKLOxA1aGoYAjzW2ZDRHjTl_h0gRj28udq1e91c
 wFn3rWT0BChOetiqSzKBm4nRomcZZW4VFIOGNbzkJ._grPOE1PbtDoN1fIt2ZD6BPzFad2NoCjK4
 .3UYA_VZelHo0oPwcOBkMWiuUOHyYDFdw8ueiKXAVMo5suBL07QEFxEKfAsgc6SOU9UFUqNuqbol
 oi0bXOf3rt.8xt86RsibNdoqQvSX96d0RQujcRPKPKs85EhaPIpbxrL3.38NPOCLwpTwKjqkkfiE
 9Y5OG8gfTwJSsfrhv_Zf5wfOeRdkEhbKNo.BhFv48Z8a86bjoxuXMLBazoeINywVQjO7UcqlXz2j
 KaNP6yZJAySiitggVItpAdzsZ.JYZhADv79q6Xrz7lMZewDjwxOKRtycKmgPUmyAt8Aku4eAbq9K
 cFTkhrlDcHJ6H_CH7YgGYfUTle3yDgcKFYd8e68ek6iLNnBhK_Vg7FzdXFzlMt3pHb84.gnA2tnK
 9KK9N4CYK1mPOumlN3vSXgrOYi7p.odaV9s663AnWYYDFssdJdZUQe9xWrhfdXejrDv5VrFqQUM7
 uBaHuYPsyPQ_eTBq33M50T.sfd4hENqWHMU0q9zuRBpinyFebGxHi9OTcMCvFna.zZZ0jtK2flpS
 lyDjk9M97JE.VF.W6kLHSczX5BPS0Os_gbiwsXIktV_sP6KxllYtIzL_PfdpSCdgCVr.7vy_UHcM
 YB7OYPPe3LRkcn093GRRqCntO1zdrTZ5VeXr2qScIGEPgS4ob210HVomjrqEQO1z4mhcCiDrjoWF
 koTGV0d1gKtYnsQN0_Zm2053je4D59A4qCg.7.3fTsQWT8Nd0pS2Q1fQWuFusp1gKePbLcC08Oqd
 s71t9WEnxrytaC0sGE18NgOU1oTtYxAoklYL3lusXq_O5CH3b3JNfVFUronvg.6BzNGht5bX7_uJ
 PoV8-
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ir2.yahoo.com with HTTP; Fri, 29 Jul 2022 22:52:27 +0000
Received: by hermes--canary-production-ir2-d447c45b6-sqmx2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID fa79a2b2568bda8e5dd95eac776ed450;
          Fri, 29 Jul 2022 22:52:22 +0000 (UTC)
Message-ID: <4dbfd85f-a79e-9340-2654-d08eea616de4@rocketmail.com>
Date:   Sat, 30 Jul 2022 00:52:20 +0200
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
 <c52e34f1-1cc3-4351-e03b-6b9bf83481b6@rocketmail.com>
 <CAHp75Vc9cYNOTmpr+NeQQEUVtkL6hnsjToiMBa2_NGnr2zuFtQ@mail.gmail.com>
From:   Jakob Hauser <jahau@rocketmail.com>
In-Reply-To: <CAHp75Vc9cYNOTmpr+NeQQEUVtkL6hnsjToiMBa2_NGnr2zuFtQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.20447 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy,

On 29.07.22 18:08, Andy Shevchenko wrote:
> On Fri, Jul 29, 2022 at 1:06 AM Jakob Hauser <jahau@rocketmail.com> wro=
te:

=2E..

>> Is it appropriate to include this to kernel doc? Generally I'm unsure =
on
>> kernel doc but I guess yes...
>=20
> I'm unsure if it's appropriate for static (integer) arrays, you may
> run kernel doc script yourself and check man, html and pdf formats to
> see if it's rendered correctly.

Nope, doesn't work...

It was a beginner's mistake on my side. I did check
Documentation/doc-guide/kernel-doc.rst before and followed the "typedef"
part, which is quite short. I thought "typedef" is a more general
designation =E2=80=93 but after reading more on "typedef" I now know what=
 it is :/
https://github.com/torvalds/linux/blob/v5.18/Documentation/doc-guide/kern=
el-doc.rst#typedef-documentation

So, as far as I can see, kernel doc applies to functions, structures,
unions, enumerations and typedefs only.

I would then switch the comments to regular comments:

/*
 * t_ref_counts[] is the number of counts at reference temperature.
 *
 * The temperature value at YAS magnetometers is a number of counts. The
 * values in t_ref_counts[] are the counts at the reference temperature
 * of 20 =C2=B0C.
 *
 * For YAS532/533, this value is known from the Android driver. For
 * YAS530, it was approximately measured.
 */
static const u16 t_ref_counts[] =3D { 182, 390, 390, };

/*
 * min_temp_celsius_x10[] is the starting point of temperature counting
 * in 1/10:s degrees Celsius.
 *
 * The array min_temp_celsius_x10[] contains the temperatures where the
 * temperature value count is 0. The values are in 1/10:s degrees
 * Celsius to ease the further temperature calculation.
 *
 * These temperatures are derived from the temperature resolutions given
 * in the data sheets.
 */
static const s16 min_temp_celsius_x10[] =3D { -620, -500, -500, };

=2E..

Kind regards,
Jakob
