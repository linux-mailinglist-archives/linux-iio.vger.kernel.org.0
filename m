Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E941B581BBD
	for <lists+linux-iio@lfdr.de>; Tue, 26 Jul 2022 23:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239626AbiGZVkg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 26 Jul 2022 17:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239541AbiGZVkf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 26 Jul 2022 17:40:35 -0400
Received: from sonic313-21.consmr.mail.ir2.yahoo.com (sonic313-21.consmr.mail.ir2.yahoo.com [77.238.179.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2726410
        for <linux-iio@vger.kernel.org>; Tue, 26 Jul 2022 14:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1658871632; bh=pLQmEIJ5m0YYbOffMhaqcYc/X81hORTVkjuY9dZ4tsY=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=B1SLBOH77M9+bw7o5QVV9VLbHm9zXdClJ8yjfj1V1E8MpUaFL4eZjXnNym6fPVIQJcw/V44SsJS1iplfzJn2TnlSIRTFV4TnyYZ0dW/+Wa7kQKlxg+pY321fgo2wTh3aBr93pwfg0FeRuak/R1sFgBmM9IzbqBO07FkJPaADWmELIEJDFVKwavs9u3SZpvGwdviXYQ2rA0FnmogvraabT4wzJJsM7cNgLqOI4OMm4U956bzKgVb7uAjEdOGqjNYS/3VU2RIZjYOMdeXdMDfIL853lII4mNWnwNlEI645wsjH3nJzcp1Ga9q0SipeqLVG3zNLspgix8o6e/FtotByRg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1658871632; bh=1Ayxi8+nYGwH2wPHKewGM2MBCMy6hvts5t9zFtdMxIY=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=INFy1aEjVqGa1i6i4v+7nEooyD8VcwHmVbQ03Rj9x3IYAZhHwEVcGEKMGyFyxxIP98Jn180CIv12a9AlKsXdfPeYqUILtIvgKl/wwz273pKdsRvhCgbTdZkJ5KjcsIzzhRzRTm/UnuDmBpazmidVJlHIgVnp0BCrI+yHxSZSBPo/A5WcUyZb34CVPZX947rKg9mDKu7v3d6KtjARFRypijSREqbutZLhVGu9TqSHSpd92ldoOCpDdptpwU7lhTtFYimSc2hQXK/64+HIe9Efihx9kX8lzCdIGnfkMsGAmXdnel1VP5G047lK/EGK6QmDj8drNXqqNLktLl9GyeSpHw==
X-YMail-OSG: Pv7hJpMVM1kea7gEBYeAkTLNBI.KJZ8H1_r6nmKYcwKrPTGCXFdJBDTDaSx5Ho4
 yxSkjM0cAeny4LPMTSjtLPX4st0pl3Y0mbYjbeU7eXy65pRQu8WYX2UIMJcI2W_RWJRNKK8drAyS
 r5EKJyVrxgB90MGiCgbA_g8AXZqzVK9Mw.2_Npvi7OPJ1bQvOckleuVb4tWThHmjk2Y0gR0DCNF3
 KAwwlOZ8q3sfGgl1sz4EjT01Mb3t7GAcuCJfagdIJnqf7yqK1P_qT0jHwjswzOrVzapFSaigG1Tv
 ZnE_va2QWOZMvFSEpUOe1wipZTr96EU5XNzpb7hy8NYZteTUpUkNCMRMMtIN4KC2fCA5rGp_usDb
 5TqgUTfqg2fLqB3Thv_DNQlaJ5TGeYN2A2G61G2F44SE465y8DT1J8t428aya4BV3DZVhstarcei
 Wofu9ygbAzAv4210pqAvcTMISQdyom4bbR30qGdPmG4Xd5BKpi2GxHgfVzlNt_0OIL5co8HIwfQO
 X2648YlV7JQdu2GCVWyE3jp0LJEM.XLwWdkeYwf.jlSbj2ZQ6RpnNsZQGlYdNZKj3te29eSDLwuX
 2RWHyqzlFOBnDbqYBGB4.ptYP5cfQZivy63YDYdyhODOOrniepQ0JFJnd6L4YpiuSpzA5UQUGtXF
 YxLw.BIQjH43mzpFJ0sgA4O6rduPznFlfY_GANUeqFUKizXWfdvTM5lCwdqWtUolBlYSNZYY3SMC
 y.7.wp7th.GGQJwcbRuQWZpDHAtouMLLOfqL.Q383FJWb02iMjSD1QJASZRBmZOq0pR0JgZzfcIc
 dp1KXDoJy3reGWD0_WTspWkzqTJ2KM9RBO8N4sqGZ24Z7nkPf__pfumqvdqSsjWmvFEhnRsW92Ep
 SD26NdgZB0PiPovBniY.tzpEaF9A9w1Y_ZQ.heiZ.Lj3G8igHveiLrWd_KGEKLaDrrkXjn_bHq.S
 GbQrsUK3m6VZUf6pl.eognLnPpQBKOcOKp9oCFgEwuWQRQR8yUXiMg6jEBfdbLiyiXa9CrkWGbND
 45VsP4QyknV_X1OZ7BpmDVNd8ogUUP9QNSOBFMurfYc7jJ0u1oHNIOwTnbrLSokECklYsNED57Kg
 1NBfwzpq4803ly_KiM_tq6dyKF4hO_V21lQhN8saCs33RzAHmazEnoRZzKoZLiLb2jsxJa1JYz8H
 XVVvCTyvLov5a6KZR_8yPugj3QgkC0OsacyhOUKM2vdoggkfmXDiOScZSQyWcEMIsuW57hVnmDCB
 qZyNqZffx9uj5SJTjj2ilq_rEnQrTwFgNUMSa3KxMwEaD4fdIly8H7EeK9Ub0j05UWo9loCRqlZp
 Hb3DvppPh4dZPyNQ9TyfWTRx6IazLTKt0e.kLKpAex.tDIGjGPYfzijav3NyhwcD_2SdK4AByK5Q
 E6vT_Icn2W9SfewA9ldETu53LagDoYodPtCUT0HIqbJkLEq8fykee4_eWnjrGud5FyBhsL8JY.Wq
 TknQMGjFd2_l6UGtcKjudzD_4MsfmkNHCx6BAq6uZbqdXrEEmqjYJitG0Vm5Qx3f24NZycSUCWpn
 6iCDW0KFWrw_01udMq515fGngwUUbr5fin2xfV9ts8oVrhEmQp0k0tBLktbHYZbcDc2gqtq4x_Bf
 RzOLJP5NqeEF2dfaWjMMmBRkrA0MXd_vjJiuDcpxC.DPuJoDuABxvn04UjYImVZ1geg9nxTfWGs1
 0uDR8rhUZ0Xrxx2_vQssUUl.FTlKK9bkenYJJz6tig4dctjiTOd7n9_HuhSpdkeaeCCP.vWEeP34
 kwmkTaZ1zKQQyJp56q7SukBaYugw7WFU90B3ZWo12Pt6aGz9GJk5CjYLOaAbmTrbLOx0rY3xEt1h
 YsZUyStBNOrxk5fAjfTvXLe.CzVNKgILfpv1RstZv1iogo0eBLHZYisMls6JtqjpropzJQQwc_1w
 tyxQm1XypJiXdkGKD5aUsq_ZoAN32p95ZjxU5yuu1Ta51l6ckTID34vwL5uCpYbaBsbIWIDhP8aV
 zu_WCL1NuwpKCAqqIFJnFQjVaiZrL40ebt7bmVTrTRMfhC2jJ2MScJZWyjzR.wmA_1QQdD4qJoc_
 3ckwbfmpzKNnvDaYuMKx8L7x3otrycZCzAvggr1FPxtu5Pw1.zfrMG97_Y.hWnz1JT4R.BGME8Ny
 FpDZGwszR3F8KAzjftMjGVCA0LT9b9GldqohZak5fw1wjCvnNp0YP70l_.NySLpGzwsx_yd0nubJ
 usRW7mkwn4UimgYxtlvmzOGk4WgDj7ERf0v2WeIk2j2uN6ZBoK_W4bPbGLd_uaWGBIT2B
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ir2.yahoo.com with HTTP; Tue, 26 Jul 2022 21:40:32 +0000
Received: by hermes--canary-production-ir2-d447c45b6-2hw4d (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 2c52c59737de2a58e010c2330b05cf54;
          Tue, 26 Jul 2022 21:40:29 +0000 (UTC)
Message-ID: <47cdefdb-dd3c-7f63-fe4a-153408e8b335@rocketmail.com>
Date:   Tue, 26 Jul 2022 23:40:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 06/10] iio: magnetometer: yas530: Rename functions and
 registers
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
 <24d0ed13b317de4209cfd0b7ecd258af87b1b952.1656883851.git.jahau@rocketmail.com>
 <CAHp75VeBdLypGa+f0FVPtBBs-i5VzQ-UvDdm5G7SG6Jgn4YvVQ@mail.gmail.com>
From:   Jakob Hauser <jahau@rocketmail.com>
In-Reply-To: <CAHp75VeBdLypGa+f0FVPtBBs-i5VzQ-UvDdm5G7SG6Jgn4YvVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 04.07.22 20:04, Andy Shevchenko wrote:
> On Mon, Jul 4, 2022 at 12:03 AM Jakob Hauser <jahau@rocketmail.com> wrote:
>>
...
>>  /**
>> - * yas5xx_measure() - Make a measure from the hardware
>> + * yas530_measure() - Make a measure from the hardware
>>   * @yas5xx: The device state
>>   * @t: the raw temperature measurement
>>   * @x: the raw x axis measurement
>> @@ -190,7 +192,8 @@ static u16 yas532_extract_axis(u8 *data)
>>   * @y2: the y2 axis measurement
>>   * @return: 0 on success or error code
>>   */
>> -static int yas5xx_measure(struct yas5xx *yas5xx, u16 *t, u16 *x, u16 *y1, u16 *y2)
>> +/* Used by YAS530, YAS532 and YAS533 */
> 
> Why a separate comment and not embedded into the kernel doc above?
> 

I thought of it as an internal comment or hint. I'm not familiar with
kernel doc and didn't dare to add it there.

I'll move it to the bottom of the kernel doc part.

Kind regards,
Jakob
