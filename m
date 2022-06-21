Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEBB5528C6
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jun 2022 02:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234609AbiFUAv0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jun 2022 20:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241911AbiFUAvZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Jun 2022 20:51:25 -0400
Received: from sonic305-21.consmr.mail.ir2.yahoo.com (sonic305-21.consmr.mail.ir2.yahoo.com [77.238.177.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44B01B788
        for <linux-iio@vger.kernel.org>; Mon, 20 Jun 2022 17:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1655772681; bh=3dJcYD5PDjD7mFQNoTB6WKsKKcBIMRBKhiEz/qcgKsw=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=R5nP06pjz1McGAsEgeI3UcRU73wStUzoujCkeJkcyMoTQQbViHCb7dFVeXCY6ZRZHw5YMR33xKEXS9Oeix3TRT/0fzk9uvTQm+7S7nrgb9RuSf+MptsE+zlxzdPOyuN1KMuKP5vydHYUPJzJ3C6yPQOHtemwma6lrJtmiH3Hym7eZOUjMC5vKyXnDdngCz0Bt48TumQuaLcy959lRqSihw5FkGzUXPlp9veDtzMlrpJzp4YOwLtebDHKDFbDGXpa5mKOdDS04RBSGmVLh28jp3TAUfQJvn0k5KOoZIQTMUoh8nE+zBh6fSq008/pVutXqfcfGxPxYKf2ZJGZfn63ZQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1655772681; bh=q/7Zt1788+uss2UWK4U6jDQq7HIIh5LNIwBmMMYco0E=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=giLWEZNjCU5gM81FUADYrddWiogaS5c6WfXON4kQQ4z4MlcgYElEjiJ4uQ3sQRH6Vssvk2KmheZVfjuGyLeV6p2JbVrN1oBWWLTge4xrdusYnadwdlvRxVDNSHf0MDB/Ads6K542Xn761DV8WUjfx2JsbLsLgF+EIMM4atv70lU2p9eY4Q2uBOVV4XNCkBW4g3w/llV8O4VRgTDSKMqd3ziXb5CJbFKmJoyEVJUyjLDSlYrMX8KhEK+0NO67+GcOxuP5n4+Eik7sdR7nm/Ean9nDD91eZFki2jW1ntwS+MeY4RlT23DumXK1to5UPriEdzdGkAD/XxOR/DeG+cIUvw==
X-YMail-OSG: otKAFAYVM1luTNDbkuJKKnWKf1SmmLVH0GrUdrKf2F.o..u4Qvl300TP7tFzgYy
 RGdkS7LXAKAd_afyi3ya18zbIlWJson0sINn6SNTxESGiMML9jiQyDN4cT.wE9.GWOkcUDdiDKGE
 Tre8VVHIkgUjctYXcw_1m_pVVNp.VGq1oOlHEXF7vYabhjFHkGTMZ8PcAZ1uQAQJftG0S6A1sENs
 jM14lRFcRjZdvI_9YFtn2TM2QtuxNhCOE400BjdgkBPDi8ORfOHbHH0w1x9qP1yLB.oRxUkr4.O1
 gMYqsNhqpaUBOsl78GSX1EFTeCSRLKZTC2RlNZ8hF7Fc1fDVQOJ5QHipm65BeorL9sYk.JBmtXVQ
 P_jQ5wyBVPasjjAHef0vOaaqNHT6wFfaTiqoHBzzRGEFWAA_AoUKlA7qKvrfLzJjft8zS8h76lcq
 6sY8hVfGu4qMKEbZh07R9oeav2RNmzcATIN.S4mqgPOxvam666QKs.80KVNL11T58dej.NubkhAZ
 UsG1lMcYe1brKwMmsyr7rDLCIbUopHVND1JZGWk0YQa.JmEFoQX1mNSte__ebevzRb7p0ySoVi7c
 k6zQtV3JJ5ycHjZP6z1bgVfDBFj2IenLFc0JW1hLf_Jzm.Ymw84ey2VoBJO6k7HkOkFAkYb9ffrK
 uupzeAIURy4BzHxBX08hR_h60qj3oQEvD9zIoH.2Ceu2MsuKeM7rSq7Zxyqkwl5gurq6fiTXfGYh
 e5ARPVkhtob6bma28f8DYJEMtrBXNtF32p8LClpRz_4QKAQzbjwE81zFVdzxaCbd7QMyqfLzb76t
 4euHkHqE3ZWbUX4KWRKoRvquFXFbIA_5kdGxQ0fXudRH0opecSVi0JqPa.kavP71CTNXF2IgO5nC
 yEyX7ntVxnU93DKJL0uOEKTn65Dot_FXd2HXM48sJkw0EDLFz9ukHOCDdOCqcysw3n5GjW2BsRMB
 gmXjDQZTSRiH4.4vraFDMjSbcxwhTwjWj7j5xIRWstUSLhyi0cSO56c7fo_bXRRKHioVbPEsQYXY
 SZYbCAxwdJ9yLIXsfVOYjT5M8D0uTlK.AYfFx1FLcLYSntoZnIuHZEKeeizZwc_Ja1lN3taWmjw3
 .E4t0vhF7Vp1iP7nukBidDYy.vX.6DB2bUxAjBL_naMeRc.q3neurvZ.c6pxbWRERz5l3jJ2QPaf
 2xwASeNlvCUOLPTNObsIwp7cCSosQ2vtzKPE5VtmzBytYi2JkMWVx103ZNKfi1UzryFr4Qhd5f6I
 55hUpCc3lfgpayfsUJGSk2TItC.PaX9Z0juvJRGaW5VEMVblmYRAAQYrkQvXkKRwRXwUMqLSLqIk
 pZz.0x7yDiQWx7ie8826JyqjyCR5elZXwDuiS0u_mi5IDqDu5Se583RFYexvcdG5unQHyfsVLM.S
 M9oEqaZ0C0emBzGiI1rzpXJxUHzwINZblDuo2MiNlOfpS7hZhmOEbHjUQ8B4hOs_wY63jzAXs93E
 goBspl3r.R7aGMEVArD86fNm.PYeBXF3A7Y7e7QSIawSZJ2170ontpMqZNY6ruiOnx4zpqEr.QLW
 ZV3Gzve1fGOYLQhdjobI7bn1g8wjlmoDIVgmcbKsOHs34pGXOL0wofmVcLudpwAoGk1ePMK6DZty
 Z1IuHHF0gvMMd8jMwXVfj8rCIlgP5eeq0gGSLuuS41KTvI_MY.8q9yyZ7P7wcE9FyXRmpjmEmCtQ
 YkbhAz_6ZXGJ4oSDaLC4ynLLg14Zozg92HzQGny3VME6xPGn9r10TYHjUWIAqpEK3LGjv.huWKeX
 XZi0LEnPg_ozOL3b7DguAzMa3ABsKWd46uyRRw1eykfIWk0LzT.mEVePOhSXemsuJBw3gAIFUfmv
 rqVcuO3K2yl2vpPLEX0MRR_oRZwOTKHI8hCQtAZo_iyfKMjwmEIHqXmflu_w5itxUjwtAI8AK6zX
 lkGJ3hBqDVtvCS3rYdKVR0Liv9S3xFLDWndhszuX9zriOyfijsQjacIH9e_LL.YHlIy7lZY7ewpB
 WCF63UXKwfKumrliDc2NJacDEvrHu37peUXtNZoDTDb4lRlCWvSmYqdo0e9SJRUwo5im42TkgJka
 pGgdObkc8kTqpK8C8VFrCfbb3gTQWgal4X3LXkuN2MsvTa8_I49OR8wwHT5CHvltUsLE51egdGfX
 AZ6bWAMSPc03l7FwOzGJJoF1TbcOX2kE4vkbIRQcx.n9NSIp4ZFtH2lk2I8Ob8wlodY9c7pQBX4n
 baop39gjKuk_0x.b4B2oDJMlq9qKw4n8rmdrFSQ39e35p336TFPijpq4h..kZSlmWhjOB9GhOsIa
 8.o0-
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ir2.yahoo.com with HTTP; Tue, 21 Jun 2022 00:51:21 +0000
Received: by hermes--canary-production-ir2-c9bf9d9bc-thtsc (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a48608e7e053ea1a6305bae8166b3a5f;
          Tue, 21 Jun 2022 00:51:18 +0000 (UTC)
Message-ID: <10c06f21-23d3-d3a8-5a6d-8290cf2971cb@rocketmail.com>
Date:   Tue, 21 Jun 2022 02:51:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 5/8] iio: magnetometer: yas530: Change data type of
 calibration coefficients
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <cover.1655509425.git.jahau@rocketmail.com>
 <18f223776f6942d52af2e41dd10160e220a23311.1655509425.git.jahau@rocketmail.com>
 <20220618155618.18996d0c@jic23-huawei>
From:   Jakob Hauser <jahau@rocketmail.com>
In-Reply-To: <20220618155618.18996d0c@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20280 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

On 18.06.22 16:56, Jonathan Cameron wrote:
> On Sat, 18 Jun 2022 02:13:13 +0200
> Jakob Hauser <jahau@rocketmail.com> wrote:
> 
>> This is a preparation for adding YAS537 variant.
>>
>> YAS537 uses other data types on the calibration coefficients [1] than YAS530 [2]
>> and YAS532 [3].
>>
>> On YAS537, at least for a4 and a7 this could matter because 8-bit unsigned data
>> from the register gets stored into a signed data type, therefore this should be
>> 8-bit as well.
>>
>> For YAS530/532, on the other hand, it doesn't seem to matter. The size of a2-a9
>> and k is smaller than 8-bit at extraction, also the applied math is low. And
>> Cx/Cy1/Cy2, now being defined as signed 16-bit, are extracted as unsigned 8-bit
>> and undergo only minor math.
> Ok. If this is harmless to existing drivers fair enough, though my personal
> inclination would have been to take the easier approach of making the
> new variant sign extend on variable load (sign_extend_32() and similar)
> just so we didn't need to check the older parts weren't affected.

I didn't know that operation :) Let's take this.

Not sure how to handle the "Reviewed-by:" tags. Even though it's a small
patch, it gets modified a lot. Therefore I'd remove the tags of Linus
and Andy.

Kind regards,
Jakob
