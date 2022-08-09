Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D43158E3CA
	for <lists+linux-iio@lfdr.de>; Wed, 10 Aug 2022 01:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiHIXin (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Aug 2022 19:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiHIXim (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Aug 2022 19:38:42 -0400
Received: from sonic306-21.consmr.mail.ir2.yahoo.com (sonic306-21.consmr.mail.ir2.yahoo.com [77.238.176.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202AD7FE40
        for <linux-iio@vger.kernel.org>; Tue,  9 Aug 2022 16:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1660088319; bh=TDGroOcJ5FlBomnwNgFChEWpHN3cLVGYpJ4lYuXKAXc=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=qqi5ZywuE7tFuqgL5v59hBjBHt7cfUtXi0K63z9psBsxlU3axAT466xzzNCGG44x/pfXcs8z0QnuKL4TT7g4zOmsUqhe/7c+S38yPGqo1iDmEfpDfnZ6Sq/Oq6Y82YylWvvm7U7fk00zsy9f+dR0aurNWPITsidalLwah4U5kU4bbrSFiUae+Go4XaYDWRqAhWTJHvY8QjEK+pccuhFNKNzSbV/SG7fFeQRJCvupleHBOvRbUPLUlm99ZsRn0WhiudVWSjQbWzJFsDPsTrzT6OLAad7aydijcqDpDC/UwkkbsWKW6qeIwb/kiNR/eWotmXlQdi6Sixw/Zq1txpNvuw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1660088319; bh=oACuPx5RawpOZlSEcm6Bkdj4Wbzgb2/t/6/J0kxTqfX=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=nzqFp5/h5gw2pigtkF63vVgnsJWE0m3o3cOG8MsCI0kG6JUjC6tEiRQaeJFSG31J2yjeLfaxTVsk2mC9E1JSiRHFSq35OBtfx7UGogSVrWoRScEKiSSq77StaudSMgcycfcKDHUDARpHLGrm7clrH6BJKQl6NUDwJm7sc1Iv13GQSJilwn6tJOvVaUrt8XxU+JximIxFeCDx574U4t9ZjAKljQ+CsBwT/6fvP9ybNbKrHnp/rOqBxPCrD0Yyy47/HF/o2YoJ0hgU0kkAtXAZwvykUBHdjGzHzwcWPjVw4rF1sQ7muXxGneFtQnFKyaz4v6S3xwAJ+t3gtG0+IKUZ5A==
X-YMail-OSG: ok95tnkVM1kPLMoyo9a_8rr0EPbnRkBJWyR3Af4kW3a8lPJhqm6hsh3_LUPLaRT
 8HGACom9oOAiPK61V.PRHLFA3KDEqo7tjZNMaW7Yy7hkBSN.C6nfLrprcV5BDjHVqUBgqN2b6t1D
 Hy6Lhyopd9.SIEHZdnw1HIPERwwqaZCRFJemr7jqhbID3BXzLfaOKJxWVPlEbMfWzK97dp4tz5O0
 W2ApLk.sNy8_GI4Ib52RgKZkSMklk.xlRKiFLhx9Hp9gQ.MYp8yMmRrdtas_qaNFZt6iItjT8iXC
 6Z0YzRVFYZZlStC5k.gv9HCLJ_bkPXFO1bRI7H9hIqXink1W4.cIDKhkx31Zrb040jXWKdh5_NsE
 fYDp2buJU32nPYbNYjfQ4HjveqTI_M6GCW3pZYPc714FVRjD8IwfBcOfRePOJRlS8PDMyxiGI7LG
 WD8gAhJ9gmc5Ik15tOO1E7i.ChVvyGz.IkPOIx83cNco2kWyFLTm0la7CdCKpcjOBN3fK8TzIo7l
 udrJisecusE58d18KuunXpixTGKqg8Bqh0hhjXvBRX5FAO53wwYgfuEO9CnLeNZroq9ucIJBE62f
 tSn_u.6SrHlLU_LQqTaf2OdXtweF9EnDg9BJK4VV10BS0HClOWylkzYL9Uukvnds.25fsFTdZ3t0
 kUmYFrDRQKwFH3uOz9QoPveeM8KyxZTNZ2J34WtltNRqu_CrFxq5.w1A0QIfncarWM1lYgrwJHVi
 Zqzr971tJY4lM8x_0OtTClcXaOBb5V0J202uu3MPq8cqGDOCtYhLBy0iW2IfvLE5qGaY4Rcy7tzZ
 B_I3AQInnaSg0J4GovYjNup1oVUfKXW8bL8eRbRkUQDrUzNVxObAmAlkaEDWcM7fdttmh.c9l7cu
 g4L1rR07CiBCWPXOVb80IkoKN8ss.cOYu8S8GFzieTsy4r8fiK1rvomKDdIqw8c5nNFdXVwScC_S
 B2ZK4or3V0U0Il9UoLoVWzSsCuepp1kjQyXbt0OyQj3.nDgOivDdTKQA.QpNdnuC5dhHBIWemntB
 cwvpafoCqBnnUJPGYURHx4vWFd05jxJ.fq2MS2q8x1xeG3cjfI4MElW1F6qX3zukpaKd.m3aEdGv
 ORHIr5tNT4XxAttfloGRx0uyN4NfT5wdaVHaRE4FM1KU5tbLSqjCPjD5vNbgOmHBa4bx5L2wb6Kb
 OmFeYf0Md0xau7e3KWN5mCJvdtUBVf4WKliTxBgRez7_AF3l2MLAwUWD5UrMDUPO8rThJhPDpkY.
 V3pEwzEqo5LBKmng_fqaKe4McV_VQxQ.wd6083XnFHhRGvk69tscYoakE7Bnvvy_n05fqAymdF6Y
 375_RzQbya5pIuXaLeOhC4RkfEhDK8SGPfEdap26STMUSrM7_qszWVZiZ0KZLp720NrJv5Fo50zK
 DirSk77NNpxi4ZnzEUq0zGnhVmIxtpzFJFgG8JzkFdqRTDMF9BVSWJQivF7dHd6zB4i5hxQCs04I
 aIpG6UFl_hVb.IeEe1Ns_BMGnuUgIr.u5F7Xpw1hQz7Ql4pZe4GgvZZ.8U49p04bE3QVZYlzmtpr
 pI3tZWJfyiK4wlc9Ps0fpMW8qkkJ7r9fWERjCNy3Nkk5VTGjlgQtdbBcekds9qa6F5HE3VButWpg
 8KmruUSfJq0OpHwnYEdUwjAzVcVsZsDNZK0mkcq8ajiQC26zs8_t4C4tqUd_xsSMxWnn5c0tNIfZ
 gvbTejoTYyxMhTxQUqyW3E62.j9txAlNeVoVQoi9oE3KJO9ZGJEbWgXsJP_r.FJ_8zDqWq2izi.D
 XYVdfX5dV91hpZzIj.15ewGg.9633_iqM8Ip81EL9BK5RRHhChJ9pu6Nv0dvy4hAmf31_j9Cat.8
 e5I.j3CJhipZwjqKz1sZXs.05nTpSImL64N4lo3bLCWDXNf2hOTPduGqMgKRErpRHFbeG5wCQL8Z
 z4oHR1WxxzT49pVv_OU_D7kFGQeQAKMCn9CWMrzCnrtFto9FBfCCC1BIVOXtuJPhiAGEakQZoz.j
 ogzg1_2IaRPxoHDCpSOFtdUZ4tQDxPMuR8ROXaZOS4bnNjtzAc8wbC0T9tHFjAqcswD6EZ8Pp0Wf
 tqGo5elixv8GseRmI3YmKGlc8BecWuY4Q8T.aPRhSWRnU3DA8hrndMTbhawfrnTxRztv8ALmTFBH
 5D6WUcyNTHNOKmG.DbnC_SJQ5FSDweARo5qLK4TbjQcZnxXTrij1Y0fM477qRS7I3veiHi9qAyHd
 wmmBPdp8MAeOZ_BrUAlkuzmH93zbta.qOnaVH1wpe7LDBZYQ_imsBn0aYvUQgYvpZpyjV2uljt1W
 fkzEVyw--
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ir2.yahoo.com with HTTP; Tue, 9 Aug 2022 23:38:39 +0000
Received: by hermes--canary-production-ir2-f74ffc99c-r76pr (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 95a4f5784e1390987f7948589f0971ed;
          Tue, 09 Aug 2022 23:38:37 +0000 (UTC)
Message-ID: <4ad6942d-473a-ac04-6535-087c5860c77c@rocketmail.com>
Date:   Wed, 10 Aug 2022 01:38:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 13/14] iio: magnetometer: yas530: Add function pointers
 to "chip_info"
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
 <20ad0e793df229e71575c4e7d0bc4f6a5fb49f29.1659909060.git.jahau@rocketmail.com>
 <CAHp75VdW1gtcH-S1O6FFPWF2hZrryDxL2hq+P4ncGpsKKuS6GQ@mail.gmail.com>
From:   Jakob Hauser <jahau@rocketmail.com>
In-Reply-To: <CAHp75VdW1gtcH-S1O6FFPWF2hZrryDxL2hq+P4ncGpsKKuS6GQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20491 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy,

On 08.08.22 13:37, Andy Shevchenko wrote:
> On Mon, Aug 8, 2022 at 1:07 AM Jakob Hauser <jahau@rocketmail.com> wrote:
>>
>> Add funtion pointers to the "chip_info" structure to ease the handling of
> 
> function

Oops. Will correct this.

>> different YAS variants.
>>

...

Kind regards,
Jakob
