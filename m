Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E6D5390E4
	for <lists+linux-iio@lfdr.de>; Tue, 31 May 2022 14:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242915AbiEaMkK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 May 2022 08:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242460AbiEaMkJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 May 2022 08:40:09 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42BEE0B6
        for <linux-iio@vger.kernel.org>; Tue, 31 May 2022 05:40:07 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id s188so17256389oie.4
        for <linux-iio@vger.kernel.org>; Tue, 31 May 2022 05:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=AxZOLWWV2zJmAf07Z/UkIXx+4I8hu7YPuvmoKiDADCc=;
        b=X8ybkznLI7Ko6AZt846nTDMr3oTV4S7XHBuWTYoAF9DwEIAR+U+QMGlEEa/N3smTd+
         gRLnGXFAJMvePLg97WcuASBQch9B06bjdMHFHmiQMVd10EiVKD3GuCFLkuwU7vRCjqRY
         3iV8VP15FRvOtreou7JQgH8b9E1p6E0MrSTraIal2O6egqY98DGQ5U0NXTaoHJhBDonk
         NwmGnjOq/4NvwKCVcbOAdRXscoHDSWeo1wVK5v52Xd5O8rLG+tel7uxv5OXsk/57Yino
         +dUHIaXA9/NdJI7y4IqU+V3UFm3EyvaKK27H4ELN1adKKVgzUYNrjzX02tm+RbUDie+4
         oAdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=AxZOLWWV2zJmAf07Z/UkIXx+4I8hu7YPuvmoKiDADCc=;
        b=pn3YUEcwFR/RnPexNUHtYXbCmj9dXHdoHXp05RfLPRxmEWBQvBcYwMpsAXuO9UwPiY
         KKE6VePqnXCczq1MxfeIALd19YMk/uGlss23P8bCZBpMuRLeXJB0OjQg/xHm16RvIOA3
         jZwVXdzJ7snsoSZvQk6QLqEqHxu1VAAKWF+5CVPMClIkT3pC5+QQas2F5iFniRWevarR
         MsCkNr25ee1lW30nSYJ349I5oybQiDCoKItwgq86oYr5tYnC84skH09fSiskawVO2n6T
         uJlPpNWJHXiNbLd1Rlk3JADBuzTouTNBflLcF/5YibmUWfIrMEubzXHTv5SWpLPb5YhD
         a1FQ==
X-Gm-Message-State: AOAM533+sRB9W7VhrKCMNuX0g8UOkpFc0TakYR8d0jQtyMuYe+HPaPWl
        1DyM1FHpuWS6TcDVZsycDzRG//KQP0k0AehUhEY=
X-Google-Smtp-Source: ABdhPJyLeECuGeW7G6OAI6yhHA+oJkqUrvMaEYigObet3Qi+9Zb/dqWRzjAmWYuCjMAbbSf5Q6wrsPg6NsfcBEpEnQo=
X-Received: by 2002:a05:6808:124d:b0:325:788d:e23d with SMTP id
 o13-20020a056808124d00b00325788de23dmr12834849oiv.267.1654000807070; Tue, 31
 May 2022 05:40:07 -0700 (PDT)
MIME-Version: 1.0
Sender: charityvangal@gmail.com
Received: by 2002:a4a:98b3:0:0:0:0:0 with HTTP; Tue, 31 May 2022 05:40:06
 -0700 (PDT)
From:   Dina Mckenna <dinamckenna1894@gmail.com>
Date:   Tue, 31 May 2022 00:40:06 -1200
X-Google-Sender-Auth: FItW4agujMjI2wS9pJxE74tPc0g
Message-ID: <CABTbXjKOsb=e7HVikuwGqKgRr9sKa=4FKKWzFoMFauF7M1EAkg@mail.gmail.com>
Subject: Please need your urgent assistance,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.4 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_95,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY,URG_BIZ
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:22f listed in]
        [list.dnswl.org]
        *  3.0 BAYES_95 BODY: Bayes spam probability is 95 to 99%
        *      [score: 0.9721]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [dinamckenna1894[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.6 URG_BIZ Contains urgent matter
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  0.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello My Dear.,

Please do not feel disturbed for contacting =C2=A0you in this regards, It
was based on the critical health condition I found myself. =C2=A0My names
are Mrs. Dina Mckenna Howley. A widow and am suffering from brain
tumor disease and this illness has gotten to a very bad stage, I
 married my husband for Ten years without any child. =C2=A0My husband died
after a brief illness that lasted for few  days.
Since the death of my husband, I decided not to remarry again, When my
late husband was alive he deposited the sum of =C2=A0($ 11,000,000.00,
Eleven Million Dollars) with the Bank. Presently this money is still
in bank. And My  Doctor told me that I don't have much time to live
because my illness has gotten to a very bad stage, Having known my
condition I  decided to entrust over the deposited fund under your
custody to take care of the less-privileged ones therein your country
or position,
which i believe that you will utilize this money the way I am going to
instruct herein..

However all I need and required from you is your sincerity and ability
to carry out the transaction successfully and fulfill my final wish in
implementing the charitable project as it requires absolute trust and
devotion without any failure and I will be glad to see that the bank
finally release and transfer the fund into your bank account in your
country even before I die here in the hospital, because my present
health condition is very critical at the moment everything needs to be
process rapidly as soon as possible.

It will be my pleasure to compensate you as my Investment
Manager/Partner with 35 % percent of the total fund for your effort in
 handling the transaction, 5 % percent for any expenses or processing
charges fee that will involve during this process while 60% of the
fund will be Invested into the charity project there in your country
for the mutual benefit of the orphans and the less privileges ones.
Meanwhile I am waiting for your prompt respond, if only you are
interested for further details of the transaction and execution of
this  humanitarian project for the glory and honor of God the merciful
compassionate.
May God bless you and your family.

Regards,
Mrs. Dina Mckenna Howley..
written from Hospital..
