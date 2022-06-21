Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 421855528E8
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jun 2022 03:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243705AbiFUBKs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jun 2022 21:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242659AbiFUBKr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Jun 2022 21:10:47 -0400
Received: from sonic303-21.consmr.mail.ir2.yahoo.com (sonic303-21.consmr.mail.ir2.yahoo.com [77.238.178.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D5C13CD2
        for <linux-iio@vger.kernel.org>; Mon, 20 Jun 2022 18:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1655773844; bh=irI8UO7SSH7B1jatfUrNiGk/Fdw50yvYDxvRu7HEBlg=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=crL9GFMzEMJ1B+V1Iy2rBWhxgsSAlBWdPLNaNJFkgTYe2tKuko4t1rWUeS/oimh1+LJZi2OgyW2NzjXXTkMnek1JWr8Rof1IPRu7U2TOGdhl05Cthp/S37gEfvemin78LoCOBMdqTZgBA8fzpz+c+lGIzOCkCTEqIheqr3vA8Tgtg4ejGMX+A0e7ywV3L18hVx+QVv9w9JME37jfGr+0qrtBtxABQ9tDLoaBCoa+8hhVFeB4yfiBL/Bq83ZKfbzu2vS2saVKQ3PmQY7vG1BG5V6eiJpxRjYe2ajBXIdKvY10Z9Cb98Nf9Tadoxnu4WGdj8atKiyItp2R9B3vRQzIrA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1655773844; bh=ktlkRFi03PQiIhSeQNYO8X0b+fv9824t2qsr3TQbPv2=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=qgdztMR7vct7rSjmrqS3IFAfsZd4iWShJD2rcofuA8gY3bRin+EXB9HUwPHCLTLco9WjRiQfALbsD6MIn1uKB3YrgE+gwWHZ+8FCfKBX1zmhTg0O9KCOpPw5IRO20EsQx4VU6VCdyoiwKVLYEvHZoxmATIvIE7+eu4Ol95z+UHfEzdQsTlLu4t3g+Ye5JGMUX5FatD4vuK73x4eWDbM7a3JiYWpZ88CVIRyTtEhElYl5bCsD40hllO4Ssn0gLMW/z56meG9zh4i6ulO7R+9BeyMugcwZpg7t8nYzk4EAAAiXp0KVdJ9gHnQzjkCILXGXatZN/Mu31SJxnFjMF88Qyg==
X-YMail-OSG: h9_VDuMVM1mY93zjkqNzNOW4OrFPEVqzDuYvjPS3nttJs68quTNglA0KD5LgiBK
 DuULbIO3MAdXbAKdr47aGn_vafUCgvXH1CmxsCHOx5AJv74efX38OrDYKK68s9JCn1FD0I_bGHNe
 _353MRSezIUxE_ikErUtofOL.nbe.JnkLsJWs_0rN8PVte47sWfG3aHR9sh6SVB7VthEJ8Aii7VQ
 Hw6HSYOiBv0goiN2y6ZllUahj8HqNRfmkP9w1YNqK2R5NFWTXKI179uFWpbbMULmnYqN4.p.6cOJ
 P7CB25vGOMzTDTNKtDBK7EwqGcHdBFyH.NS8wr9EP3MyKWb1ErVKMWpR.ZkCWm5Vf4byLjlpW6fh
 hy1uAIJBI0t0ScOuNifzntcOaVqgnfEtkLQej6EQxRkqQFX7K0Mnw1.gSD_0IW0ian2rQR2MqS8D
 mFYW7Fb5Puenzog5fMnZtzfVulyGkOynuImxEb1c5luWK.yjSMqmKvjHgY60D5KyMu33XVCaBoy3
 LAg_nlI_M7H24ShAL5.NGwnwWjsNtcVT9Gb4ZJ4Hxq7TZ9Ae.O.JIq9pwKeHRwjqvyuMcQmOPIvC
 jRl832gnfCD9m311EaQj3CGCfVCzEnqCoXO8w2iSp2UggGvnwELnb.UAbi_K5W5gsl0XZBgUI1s9
 8shgQqDWBJOgxhUgkxI2D3Ty0AzbEEBGM2fLKWZ1v7kuUHD5amYvKJR27jxTZ3eO9w0RK0oKcTaL
 qEoMKbi2KqyEfpQHXNyfOtpdihlKw1dSi26tvsfvl_b1I.eUM_iCuKeu6mPBc3vJwZWCioPd.RNy
 MTgNvKf02nxZ.sjwIoLBe_OOVOvSU4Q._hSO0CHJQG9FB6O8tDbbivamk.CzA3faWVxBXEzzjnZ.
 .ntPz0HH6xHGwM33NTr3Xt3fKIGHqRPyrtCpz72i3dKmYPbEAXyiHGd.bxx9fc2LiCDJanzdNZdz
 soV6267XiDxa1r8y.GDCaKVBgnlrIM3t_DjH9GKzgmL7zFfFFMdClZ.pznxrLS5_QV1mMRyh_q.c
 LqdOmDYBWkuWt4qmnVYsp1cBtXcy54sXjWmxaNr0wJFEUWX8bCZ1T_a_fAwaAgDqVW9_8.6PQLl5
 APJpgzHw8uB2QdKSLs0Gcewkv4GPSw8SRnLFSJ2uMGrwsOUPYtvv5h.YekkDLyUSpQZtZJqNs2LL
 cgJF34M.MDZynDW9sNkcPbskG1VkhwUhoXPMU5Rjk4rjt7xJzN8aGCriQMtrk1M2UfMvM15VOmPr
 2YnOm4IsGXviyklKY4J3zHBPPX09PhYgIAfGlQWidfCyjVgAlOyfwPfnv_K3EjDLwycfXV8SC_Vq
 U4gtoaPoKRQy20PiS0McK.noeldC7ztYBSSriexhaKANJ.2Kg1XX44B.hP6fKcwObqgKlQqx_ISW
 _kJpri4fkh2pQaTGtX1gahyuzmRGiamyn3AtopVFzO_1.VJMYrCWg2kASodxFkSGPdJnnm0oOnek
 yvfmfIP5FShFFT.MggFDw4UrOsdQNuhh2kOmQqDaNBDO1luV58t3Epo6xsDyW8XlGi5EUZQjqtPD
 B1oQ2gU8_XDuCmRCjwlGWrPaPUSXL8_NTfu0o8N0X8UlTxi87OWcJT07SfOlVnjGN0OoxcbZ3kcA
 XT4_Xi9E2ULi3jmw2o6BvM62PydHxMTA0FlMuGY4oWK5x7dUGMkdki8wIMiLsHfn3Am7Fol1Sc5H
 TebYVi2.i1nm_ge2e.Yr4anQAjIs5fWg4kvowRR.3fkTTm686otVbpCRNSA5TC9XDr3e4tvWGAg8
 QgTTU4.jE6UxTgLZ5RlULebdaoVYR7XN6Ec9SNkYxzochOhwp5wmob3B.jvuEDNXxUpF.TRwz9b1
 vfNkqHHlyDoBLffYbVkDRp9BH.a2UC.aAx7zJdKkUN78dTYSNeNDTT26N7aH879ha4WnZ3djRgQo
 F6MchB3c1PIhwu4PmjDDifDZAtAEeObSi97BEP2Pw6k5u5AEnX52pWBzfkpQRDb.Pnykbyjvynuh
 IrE0XkRx9AWM65q7xxza1cB024yilx7X1ZXHkeoPY0RjEIyWmaNGqr1PuYA.AzVXH.85ppRVz6VI
 OydPsPikT7Kr8TA3Ap41ovO7IPJKq9udRUjzeVPVoITanu.1acEDBe.OScfYiYfq5mHtr4AL0_t5
 9V3c3_Svnsj3GKqDNtaR3XbHP9Pp5sjAOXmoHV0rkCXfxYOp_E9Pj7fakznPADm85UlFyF3s6M4E
 wJbV7DxWbLlHbnPj1kKXJUd8UXAcgqhxcqxn9KgSov2xJNpDzNuTQ6mJ0CBjI3z0UvGLhl2wLDAL
 89N8-
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ir2.yahoo.com with HTTP; Tue, 21 Jun 2022 01:10:44 +0000
Received: by hermes--canary-production-ir2-c9bf9d9bc-nqj52 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 18921bf2c2afa0daaff3f43b2f87d010;
          Tue, 21 Jun 2022 01:10:40 +0000 (UTC)
Message-ID: <9b9c7a09-c71a-0881-5571-12cf814fdaa1@rocketmail.com>
Date:   Tue, 21 Jun 2022 03:10:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 8/8] iio: magnetometer: yas530: Add YAS537 variant
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <cover.1655509425.git.jahau@rocketmail.com>
 <3bdb392bb75073bdfe10aab1739fee2d6c64f10c.1655509425.git.jahau@rocketmail.com>
 <CAHp75VdvNMu=U8me4J4pD3AUCxaVaVC6fk-SZUsgTHt5ya+kkA@mail.gmail.com>
From:   Jakob Hauser <jahau@rocketmail.com>
In-Reply-To: <CAHp75VdvNMu=U8me4J4pD3AUCxaVaVC6fk-SZUsgTHt5ya+kkA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20280 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
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

On 18.06.22 12:57, Andy Shevchenko wrote:
>
> On Sat, Jun 18, 2022 at 2:15 AM Jakob Hauser <jahau@rocketmail.com> wrote:
>>
>> -/* These variant IDs are known from code dumps */
> 
> Not sure why this change
> a) is here (means maybe you need to move the comment somewhere else?);
> b) done at all (means maybe this comment is still actual?).

The device IDs of YAS537 and YAS539 were placed there as placeholders
for future additions. The comment kind of explained why they are there
without being used within the driver. Now, with YAS537 being added, it
becomes clear that there is only YAS539 left to complete the family, the
comment is not necessary.

...

>> +       switch (yas5xx->devid) {
>> +       case YAS530_DEVICE_ID:
>> +       case YAS532_DEVICE_ID:
>> +               if (reg == YAS530_532_ACTUATE_INIT_COIL ||
>> +                   reg == YAS530_532_MEASURE)
>> +                       return true;
>> +               break;
>> +       case YAS537_DEVICE_ID:
>> +               if (reg == YAS537_MEASURE)
>> +                       return true;
>> +               break;
>> +       default:
>> +               dev_err(yas5xx->dev, "unknown device type\n");
>> +               break;
> 
>> +               /* fall through */
> 
> What does this mean?
> 
> It seems here you may actually to return directly.

I wanted to avoid:

        default:
                dev_err(yas5xx->dev, "unknown device type\n");
                return false;
        }

        return false;

I'll just remove the "fall through" comment and keep it like this:

        default:
                dev_err(yas5xx->dev, "unknown device type\n");
                break;
        }

        return false;

...

>> +       /* Writing SRST register, the exact meaning is unknown */
> 
> Wild guess: Software ReSeT (SRST). Would explain why it should be done
> before calibration.

I'll remove the "the exact meaning is unknown" part.

...

>> +       case YAS537_VERSION_0:
> 
>> +
> 
> Redundant blank line.

Within switch statements no empty lines for visual structuring allowed
at all?

...

>> -               strncpy(yas5xx->name, "yas530", sizeof(yas5xx->name));
> 
> Okay, strncpy() -> strscpy() perhaps in the separate patch.

Yes, this needs to go into a separate patch, it's implemented like this
in the current driver.

...

Kind regards,
Jakob
