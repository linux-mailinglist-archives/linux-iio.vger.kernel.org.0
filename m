Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C0958E3B4
	for <lists+linux-iio@lfdr.de>; Wed, 10 Aug 2022 01:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiHIXXe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Aug 2022 19:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiHIXXd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Aug 2022 19:23:33 -0400
Received: from sonic301-22.consmr.mail.ir2.yahoo.com (sonic301-22.consmr.mail.ir2.yahoo.com [77.238.176.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3304570E48
        for <linux-iio@vger.kernel.org>; Tue,  9 Aug 2022 16:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1660087409; bh=BwdQJDAS+JtBvKGSdnYRmOH7dchyCaO/CNeXt5g+bZY=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=lAorvlyyw3idGO04rldDyWfsrNj2VVOQS0kCM76reXSpNbFMRO8mUtgD61bDpztMcur0XKIy7peBmC0EbN1wsb0RX//BMCWA0s3YCc2iwX22q3kwvartPiRD7p2EkNZJE19RXO49UEPWLsUAI3iuT5qTlOFDbHyxVAi7w94dG2swmQns4DuVpCNo85UjWadRrNVRMLxiODtRejAs2m1Ln286A8pAK3P78e+rZGKVuMKFq0lhOLsN6QFwkjUrSoyCsx+80apTPARBmK6kOrtrxIUONEm61i4equE1t4cMXV9rHEvRx8PAhazSAAgzDlcWqO51DiyzGKD4jWhOxo4jwQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1660087409; bh=3a/40YZ3yQW7TV6RpN9J4V/2tup5GSZ9zyionenBWRy=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=FRtMGtgs/U7QiijvbVyNYMPNq8/M2kgd+a8mx8HOtA7mkV0IcRakheAjbaTlKdYW3O2GihAOBi4NNBiE5ALqRdWa9EfX/ZCQ3S5PhPqE7MNDg0bv2fUToSTUNgNWPORczrHWF71HUclOoSPL6F+Z16IjVl80C8awFr+2kblj4XgMJoTblB97iPjKCilmt5dS+IxTDnNJvkcPMPC1WkzJlIn0xSganvrwd/6TJxXxRI1lC1cLIlOoiBdmd9bBZ8RAHdPVfm0jgH8HTY3/AsOh2idDWIXhHTMLy59XiJja6RGGNGfMBpvtLaN3uK3wre8/L6WWZARXkqwA6ht4w4pSxA==
X-YMail-OSG: TUlLqUoVM1n62W3LW_8PVEpT3PNhh3yu_OFe9B4rabGAmbkG4u8lVfAk2ARqnbm
 wxbYGW.ba01i0CLtqu8kRm7y7oAVX5qACzVbWxgYX_.jvEzltJppXhf74qqIrN4o3Psq5c5LwzfJ
 z4651cMOAs8RGUWS9ul4go8AKlBvgcVXVPWACpCFRkspyaChonUtHehGSEEdzmf9E_.aK6VJDzS3
 .VN5T0coc1gVLyljmmQmOpwH56XVPcvzhEL_eGzHVPTVWCBEE6UBSQdq73tTbI65Mk9ZYreyOKDI
 sZS8zeVYpaqDT9_V0b9GYzY8GmJ7W6qQFfYGS80aEryeCcNpnE0NLFEH5_eofQDbgc0O7FQJ6ITc
 2O0JXef4q.diUGLEhv1lsVk0xnoVwpJm9IwUN0obmGlD4FXSAiahu9T5k93IMTFre0pEwN.N.5Do
 tbVYhAv8DFR2gDtUzgg0yxXIXn0m3TGzUdNefpLHuzB6tDHSewzzXdPyrd0mT0OEZ4pU6N3xfLqB
 wmL7TWrjU4dD9dJgKZSase8AzrEoTNNGbIZgl9nflKX7XPsHiByicSGMEstEdM0SxE.L_YDREVyD
 mR8JQN4mz02UAnLZC0c1tCgLmxeqcmjV5Ap0de3j9egeCdj2fsx3kfnSCqwOd1D10JMUXSAlWbdZ
 ASC7qdHXaLTpLDvjxUD7wqsSVVKVeaeP3Rh_5KNod8CGHB0RcRwcy3Tw5gF_zkV4iUI5Ozp1tvs9
 BwYiiU_i1F2c_fKGDhYMNcUCTj.exn0E3HbSamRKHb2Yp44HFBd_FB8DqZ.K4XWHC7OWXq5CK2cW
 DB6w5_RGPcOfrwL.dblgUysA8VzM5s763d.tKcyCAjxMLIa4PTOi4yxKa48rfXwN_Jlq1nvWJbhM
 RuGIP34q2hnaqA2hCnyDH83YCkLJOnPmvPf6aNKwb8msMzU3H5txazYBdRhjwPnyePVlmZCc5BDS
 Bpejtg42PDFpz6XFy3fsLTQ2fqslfS1gzlhGn6WUrHCZlloCTKvrbCHOJwRLZ8KxHrRAYsieIxmB
 3wv16JHJXBZk1mA2NGkr5QLSkUYYpRsYoTuNOCM0yNK3EofMzfsgbWkcFA.K7PONm0JLeHfrypRW
 UhS6G_ZtlpN6OR20yw8koMhQ1GmGa7C6fswMaqauBuHWdHTndR..ZjDV.m.ffS4LfRTvE7k0fCyy
 6J18ltuHt40TIHbvr5yuhRAYUxMFYfMCE.Rspt7BESY9WSruEDLgK9U4odxNbxoLLqfzknnATY7v
 0zj9Mr35XPOjzjW94pewdZkIOeFP6CeniPjt8NdDBczLBrr1voJ_8hE5WayrYusJvZRgs34t9f9R
 aHEsUZLiWmyREW82ed8rkgxtULdu.uVZKTxyk2yhI6hrsr7RSwl1gvV54DpWkfXc6oHHlwXIRPTd
 WnWzKdihMz5Yqk1PBHAKKE4HF6AJgXm.Fqac.ZVOGgsBnGHD5YC3ajYTt.xcr4j7qoPjVenMCpZj
 nG46TBsG.se9eMTe8x3_L5lHrwK31lf0wOk82asL.DExTvByISZwVjKp5h55HO_54RZP1oG2Y3sb
 tv62O_WqEKf9FxVwL7JSqrtozHLS.946q8jzARo3zZpFEKqXd5C6mG8a8GWlgbMpAk3pLFWvvk.M
 lc36Br9GXOxb_HM5DhHHvYjDJGy20kH82cY91qPgFpm8kPl2yTFMeBUW3vgakAN1W.Nu7xokuIzx
 BqSrEdylt.LOGWE62G5cavSZxNywR_fz4nke8PtOcpGn43DWm0pWjnlnWq4CAizIhhkIKIXlGn5N
 R8QKzCWQ9lA2L.ZRuzMt4WhzuStdw6_t90Hw1H2eYt3tHcEoMhKk8ebp..bQnQGYnnJkUSE.V7XK
 lk9OpcNk2UgM3Ub5sAE_Uw528FxXTtuFfYMBI5d6xEvSNKtFZ9KabcQTv9uZADghhBKTkK_yK7sQ
 Me5bq3ISPbiIWnYFEJBtb0fx7de0.oTYP5qkgrVwVOosX234i1wUJWLMbrzD2qz5_6CrNrQosO7W
 kBIVH6ExUXME7FWlo4fQTdtftWOzj7.qfiScTvuaDs9uOZKxDL0wv0jZf0IwxT6P5zfV4C2me7lp
 kIpErP1A49l6wnDzeuC3oviSCMwPNVq665HiTr6WDQw5gFTmKKE8FLtjbdre240.b2duLgl1juDl
 mbY0Zr0PGfqqVZ9v.7o7K1CKPyWuKI8taOI5rdl6BRRGqRhJmrccerlMRVZghAlKJ1pzEFniyKyr
 GYMMwj8hy7Z3RMhDpd4SEt6iPdcLz0QJam3oqf7vZT4vBijr_3ym6VCys_arzPXPeANzrBh4WSnb
 xcDM-
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ir2.yahoo.com with HTTP; Tue, 9 Aug 2022 23:23:29 +0000
Received: by hermes--canary-production-ir2-f74ffc99c-5fxhh (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 38d44100923a307cc7178f7ca9765083;
          Tue, 09 Aug 2022 23:23:24 +0000 (UTC)
Message-ID: <4fea7e1f-06a4-9d1a-892a-ac85cf4de176@rocketmail.com>
Date:   Wed, 10 Aug 2022 01:23:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 06/14] iio: magnetometer: yas530: Rename functions and
 registers
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
 <ca008512c5196a377042cd71254dedad3668bb44.1659909060.git.jahau@rocketmail.com>
 <CAHp75Ve19nzSem+CCL6w77mkavSCW0LzrDTAWkfQUHJXy=QAoA@mail.gmail.com>
From:   Jakob Hauser <jahau@rocketmail.com>
In-Reply-To: <CAHp75Ve19nzSem+CCL6w77mkavSCW0LzrDTAWkfQUHJXy=QAoA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20491 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy,

On 08.08.22 13:08, Andy Shevchenko wrote:
> On Mon, Aug 8, 2022 at 1:03 AM Jakob Hauser <jahau@rocketmail.com> wrote:
>>
>> This is a preparation for adding YAS537 variant.
> 
> the YAS537

OK

>> Functions that are used only by YAS530, YAS532 and YAS533 are renamed from
>> yas5xx to yas530. Same for the registers.
>>
>> To avoid part listing in function and registers names, the name of the first
>> variant is used. Where appropriate, comments were added that these functions
>> are used by more than one variant.
>>
>> Functions that will be used by all variants including YAS537 remain in the
>> naming scheme yas5xx. Or YAS5XX for registers, respectively.
> 
> ..
> 
>>  /**
>> - * yas5xx_get_measure() - Measure a sample of all axis and process
>> + * yas530_get_measure() - Measure a sample of all axis and process
>>   * @yas5xx: The device state
>>   * @to: Temperature out
>>   * @xo: X axis out
>>   * @yo: Y axis out
>>   * @zo: Z axis out
>>   * @return: 0 on success or error code
> 
>> + * Used by YAS530, YAS532 and YAS533
> 
> In this case (multi-line comment) the period should be added to the
> sentence. Ditto for other similar cases.

OK

>>   */

...

Kind regards,
Jakob
