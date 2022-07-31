Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3C2586045
	for <lists+linux-iio@lfdr.de>; Sun, 31 Jul 2022 19:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiGaRxm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 Jul 2022 13:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiGaRxk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 31 Jul 2022 13:53:40 -0400
Received: from sonic305-20.consmr.mail.ir2.yahoo.com (sonic305-20.consmr.mail.ir2.yahoo.com [77.238.177.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F191EFD01
        for <linux-iio@vger.kernel.org>; Sun, 31 Jul 2022 10:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1659290017; bh=K/5/FexNxcPCJp6CIyfuRIhngV7XVF8l8IBWNwNsyuA=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=d22/kzHxPMfFsiVvbxPtN9hinLWtutWjc8QcPLIwk6NOug86Zi1e2k1umrCsTNLfS+D0+C9sFeQakYljhxNctlhjFh+IvWTmCEIWD6V87QjSMvIGMSZQMPQyHMe/tC/ubpiZTTsurdePiD+Jyhyc525Psgniq1o8QlSvrjCj66iMCy8mGWWMZWyuVC5Sb+pQm8Q43l1njTGoXzzVhS8VTOCiRfth6oMI3MDKUlmZmicK7NGTKJqXuvOvmoX913pY2OFA8qd3nm+AwfjV+fKYOVPS6eYytVmgRr7WpVV8jOKoklY1d/W44u6pfClIMLE/Hz6NhWorBup2yiwA+IcKeQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1659290017; bh=NtvM9e8WXyaurvUu0BYwF6dOuBRvhDQm0oUxgTaxSSH=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=ZNpltb3vZt4i2WPR0sSNQVa71quMPhlN6V6xirur0aKO5f0taLIv4NkfjTeGGNb3Oqdc3fXWS1tR6Xlz7JC9itPzmPdKCKf8PpA/FaDpXd+IQx5qPaWnVtJ59TqQixTZREO/InnWd2JDPHn/k8TS+eRmUgwChPxkbRWwBRpwRFNmyYgRGGyRLgV9pnIry+Yaj7lQqxdOQHCVAmIeVEK32IUOWWSlElWZrqpCNYJwSdx6nZhPWbpoXsvv78hfamwZMDW+Zz9oq3PB+FZ+R9ReCyDbdjqADoihuyowtnUUq4KD2uwaaARGV+MyGk6zhM69J99PkB5b+a/opzw5p6fo1A==
X-YMail-OSG: bxpjWWoVM1mjuLOJTmfJVDDZCeTaqcZaI9bh7vBbF_RHhNppql3NkuWpfK9In55
 Mg4LFk0iPWd6OVc8G1PpCdragvdGvz3tXjqbT1NwrIPAny6sSpoLAFHuwYR4MkUBZfYqYaiss3kK
 gVmYlUxp42YxYeF.7tO8ztbMw1YBn4mXDCt_RTNuHoBF93A8AjTNBa2NHWvITlvHmxrhU_tXdSqn
 qKVuw1TyyjPQS1CeRP8SG0xCEptfY1pR1IHkDbpw2ZS3D796_Z5p9UcHN7KPhkCRJ1P7OigZSL3X
 opzQI8PbW.MdfT8Q1Rbpo2LIYDGI1Fg5dsFnI5I1xlc0npuTINIDKbqi8bogJW6wF1Cc.N1ANM8f
 tzvudU_KrtAwau4RNiAMI9EAgsTXNiTd5e7K1Bq2ZKlnOGkX6ii0Ih__B1nf7Exuuw6QyUAr9txv
 DEL1ngqYi4sKaieEr5oACsJAGPSgyWq_nxDnLLArJVUs_E7ZhEs4uZ8zwfvkXGOBZ1pZ0RBrfCq5
 uRwvC_V2IhstSkmqbIej5nYUoKCQde9f8Bg6CChPz_KVRMmMo.6J763mIN3xb7A2Q.KSYylnGHo7
 7t_Ra25NCzYlHlAbkd3sfquMoNgZ31dmJ_XVwf2YnI9fXH2fl3zLADjajcvwc6UmzaV0Wulj2ss3
 b6iG.6yAZkx8X5LrvC1jiAMEu6dbLnX1cJbpUwdorVvu0VLca5FFdreeW9sv5tLhieoBfNAaYXXM
 VvHkHIxVOijD_ZHv9lqXF8IOwLvkJ7XTw8gSdXy4Gt33.o172z2sxxuQcew2EEMXE5kP07Gi1QB4
 TEpQbIB3zkHMoUPur7Z1LDZhal9_ZyyNUJxPkL8Or9jbF7duMYtBwdoAdT7cdWlgpopiuHVNHYE9
 P4Ac.SEOr9GGzctWOuT7B6Y9f61erEZdOBJ_udoO56pC2uy8KO6357NGDmZR.MIiykZFdfJBPKb4
 VlLS94ylpMd9i2IY0J34nojIZrq6WubFmCFw8CTy.YOBBinUKCboAE3wIT3zxpXR9QCpX6.tMeu3
 mzWjFNMXjPxOt0du.8pL.0smRBoV6dbC11fdjuptBqxgZFItCTERMTKyzqu0GJAT9gH.UqObSCW2
 EuwXvardnXlCBQmd0FX5dPjxzmMy89GyZKGZlHJffyEZSWqffOEpeVNqlEdseK0xv4zz0fIOMQuL
 m9LxMbm7cJ74HQTrAWgm_gY_cZ.FgN7c.giJJmM3Bb9rTlyVey6p1lTD4vUSNN6bz.eXNy_D6UNm
 68.5zLpSnVFuJOJKp_92C8pG1QMtUBosUPnBW0DfPBfLlTqwYVlYZ2xvEKVI5oJdml76iOJBT1O7
 JiROQC3PmPRKN9AAqOmTGNe4R_eDiZZBNPYQyS3zIh42Ovd1pU.vr_nHLmrEvzOYeJj_4HC2_nas
 1Y6MX2_oHp9DEisNbrLn3yUBg89uv8x7Fjsj0QxXML.L3Tcm2DE_AQT6OURJI1MpHghAXT_hQcRB
 xA0nNtLcuwyDGtLcp4ig0KM10tgTDlqxNa84M33gwdE5W9XkkNx1hgwPyVcjetan..o3TklUps_y
 GAeNMhmlqdkiR4KGqwnZKdl.bO1hXpQ_eMfoKrlEmDnj6w0fmXevm9ufsz63emcIRcRqO9FQfxV7
 sSN64gZ5d.8XKwfGJORmDQ9bm7B4Nw.vyWFWPn7T8I21dm0BkjRPBPPjDfzjoTUOm4g8Kiv2Yebt
 KU4r_64g1uFeXiefcQE9oPcLnvKTWETHIKquO5aOdReP5Wq1z6p2FtQ2KeOGEjOPfj5q4Y9rALOp
 cdwyT.JAxkdVvsv7qbnnAgZPSd2L2mE6TXMhl7Imm4ZpUh1ue8.x_30Wi8GJ.uTDn2yZGnh3bjVq
 9yeyTS5jcQ8z9n.IuFKOd3JZd1N_0X6bTACDcpVxrFRVQA61.u2uJzvni7Q7f5GN7e0JrBtGB.AF
 WxHpBsx8v6Pum4UAJihj1g9yVWDn.lOdUezoBJDPtF0aHeClnCNbSmRwv_u.K5Bb55q.4aS5qbjP
 9628xkqmYW65kr8AP7gnoi5J1L2_Tp4JFPRhUe74rhKWs6GecZiqPbZWU09.LzqCcg0G2EvUvxiZ
 8AZ8fIJn2xHkzRYZuZvl57Y_ts3._yAZnJGFXMUH2rp3akgmm0.pOL1VtZISpUwTFupKx62Gax1C
 5kVRnrmML3d1DZS5DRnF5eEFiJGMeht4mvMrQ_o17R3eE6DWxh5BLBsFKmGypWXl1m1MyJqubBBo
 J5bxVzilbFfRWbEfcEW5GqVAKPCQOenujzKITpHM8VHUe16UChWlsgens.WqpmoGGfGarDJZ.E9Z
 GTKk-
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ir2.yahoo.com with HTTP; Sun, 31 Jul 2022 17:53:37 +0000
Received: by hermes--canary-production-ir2-d447c45b6-7sdnx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID cb9c42801513822815c81e6e191de409;
          Sun, 31 Jul 2022 17:53:35 +0000 (UTC)
Message-ID: <ff661a51-2b80-2466-b3e2-7be263aa2164@rocketmail.com>
Date:   Sun, 31 Jul 2022 19:53:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 10/10] iio: magnetometer: yas530: Add YAS537 variant
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
 <69a512cf5b62b34415d5983a6406c3d5ba438a1d.1656883851.git.jahau@rocketmail.com>
 <CAHp75Ve5Z9OOx94FtXY77_Fwkp27D32Hn7bAG+Da++HXmupytA@mail.gmail.com>
 <c5643cee-8491-3fae-b9d4-ac03d86c1e8a@rocketmail.com>
 <CAHp75VdDdKo7rt+cik4J+_4tDRgBXhgZYc8p+dOSH4s_gtCOUg@mail.gmail.com>
 <6e13daf2-179f-d37f-ace4-db5cd37be8d3@rocketmail.com>
 <CAHp75VdLBowZ7=6g4aFVr5zkN5Pkv7ir68vPCdkRmoFysqRz9Q@mail.gmail.com>
 <f8071532-14c5-c2a8-ca75-f4327066817b@rocketmail.com>
 <CAHp75VcPMZSpDS_S_4mM2bfq4154HVMHzZHvdJnP6oUA7RtpiQ@mail.gmail.com>
 <fa6c77e9-1d22-de2f-4cad-4afadf8c6a2a@rocketmail.com>
 <CAHp75VcsFmzvmk93eSNUwZCDoUN8-7gRkZZ1V4vbFHgnweq5uw@mail.gmail.com>
From:   Jakob Hauser <jahau@rocketmail.com>
In-Reply-To: <CAHp75VcsFmzvmk93eSNUwZCDoUN8-7gRkZZ1V4vbFHgnweq5uw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20447 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy,

On 30.07.22 18:36, Andy Shevchenko wrote:
> On Sat, Jul 30, 2022 at 3:32 PM Jakob Hauser <jahau@rocketmail.com> wrote:
>> On 30.07.22 13:32, Andy Shevchenko wrote:
>>> On Sat, Jul 30, 2022 at 1:10 AM Jakob Hauser <jahau@rocketmail.com> wrote:
>>>> On 29.07.22 19:24, Andy Shevchenko wrote:
> 
> ..
> 
>>>>> To the 4100 denominator:
>>>>> https://github.com/XPerience-AOSP-Lollipop/android_kernel_wingtech_msm8916/blob/xpe-11.1/drivers/input/misc/yas_mag_drv-yas537.c#L235,
>>>>> seems you can find a lot by browsing someone's code and perhaps a Git
>>>>> history.
>>>>
>>>> I've seen that comment before but I don't understand its meaning.
>>>
>>> It points out that there is a SMPLTIM, which I decode as Sample Time,
>>> which is in 4.1 msec steps (up to 255 steps).
>>
>> Also thanks for this interpretation, that makes sense. Then the
>> denominator consists of factor 1000 to convert microseconds back to
>> milliseconds and a factor of 4.1 milliseconds per step. The value
>> "intrvl", which is written into the YAS537_MEASURE_INTERVAL register,
>> would then be the number of steps of the sample time.
>>
>> However, I wouldn't add anything of this into the driver as a comment or
>> as a name, because we're just guessing.
> 
> Or we can precisely tell that this is guesswork. Up to you.

I would keep it as it is. It has no direct relevance.

> 
> ..
> 
>> I think the define and the formula both look strange.
> 
> Definition is available in units.h, for most of the SI prefixes.
> 

Ah, thanks, I didn't find that myself. Sorry for my incomprehension.

OK, everything clarified. I'll prepare v5 within the next days.

Kind regards,
Jakob
