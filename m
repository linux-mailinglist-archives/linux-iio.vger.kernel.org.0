Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D72575108
	for <lists+linux-iio@lfdr.de>; Thu, 14 Jul 2022 16:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238890AbiGNOpB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 14 Jul 2022 10:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233386AbiGNOo7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 14 Jul 2022 10:44:59 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CEB3ED66
        for <linux-iio@vger.kernel.org>; Thu, 14 Jul 2022 07:44:57 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id 20so1348978qky.5
        for <linux-iio@vger.kernel.org>; Thu, 14 Jul 2022 07:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=qFMeBXcZtcp4UfmXxS33p2to/PiDlsXeS+J0AoWTKPw=;
        b=Zlmkrh4L8hyRZKRSQmAJWhtJp+vHR2o/RGnLA7cg5q3VQrJtAwXI7BQMX1Qln24xI0
         uJmOsW9qVCKtL7uLHxqLDCIwMtdTi/iVCCtht9vRvyOAe4vsRnjZ/aI8rR1K52QzIwCF
         EgOSj0kiMlH23WT7odfuAPDHqOgNLxG4Byk/VXpHb16zofXZgzkC0DqybC5NDodhSdb7
         C4mf1sRfW0b7Lczz2XndNSbpES9PcF90I/am71FFJ526mMOTRiuJ8Ui8dVmvGz3oZWLI
         Qt3rp6P3WHjTer6CgKEZkKqs5OBNv4wHv05AQeXYaD930ajHNuMkT/uF4pcGagIdjtFI
         hkpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=qFMeBXcZtcp4UfmXxS33p2to/PiDlsXeS+J0AoWTKPw=;
        b=cMYRQBGbEv4T55wLUT4Wdh8vVlgT4ddnzpuK0LxIW4/S/mfvrkdoEgiT+eN6Hbq8TE
         IIA4PCO4ghaAas/2xleEFt6MOnozgdEIkI0Nnm9eN5Dpx3beE68NzB5nUXsbGBITPDWx
         c4I4xh97JzjrLgk0XK3SbZSAAWH42O1zyJ6/XxUl+4Ob7t9cOK3Rc5tXQlnW+lCc9Vui
         7CQ7loaFG2PxyJN7KwWQWIJChNRuKADPAsEIROn/C2TY1zT99GNHhV/3tjtJswVEF/dZ
         5ZPAiwTyNirLy35jyAzWR7Uc62H41aL0Jm/3n5mDgYmq/8EPsaEcilaHIImsjHqvlWQ/
         zr1Q==
X-Gm-Message-State: AJIora/Esoa18cyJGCVGFsr1gnslhvA4ingbqfnFeFqEeM34SzT0D5wN
        As1Xs2b3dUGuQ166A/U7B8yBbAignmBphV6BrUQ=
X-Google-Smtp-Source: AGRyM1tH2if90dDkfOdQ55JUFGgfc30O+YIV3vfiyF7S2lnhSY4NthjQk3nvCNWRuLIMEFZ7sp+gzm9sPW3F5RgF0Fg=
X-Received: by 2002:a05:620a:f89:b0:6ae:d418:f478 with SMTP id
 b9-20020a05620a0f8900b006aed418f478mr6193183qkn.344.1657809896691; Thu, 14
 Jul 2022 07:44:56 -0700 (PDT)
MIME-Version: 1.0
Sender: mrsmelaniat@gmail.com
Received: by 2002:a05:620a:2888:0:0:0:0 with HTTP; Thu, 14 Jul 2022 07:44:55
 -0700 (PDT)
From:   Hannah Wilson <hannahdavid147@gmail.com>
Date:   Thu, 14 Jul 2022 14:44:55 +0000
X-Google-Sender-Auth: ChJTp1h6Qdo13iPoYXTFbVQwFQM
Message-ID: <CANL8XDv=pfcBfNN0KeV5thNq6YucA9CG0z3rSRALM6+aK70Q5w@mail.gmail.com>
Subject: HELLO
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.3 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_MONEY_PERCENT,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:730 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mrsmelaniat[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  2.7 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Greetings,
  I am glad to know you, but God knows you better and he knows why he
has directed me to you at this point in time so do not be surprised at
all. My name is Mrs.Hannah  Wilson David, a widow, i have been
suffering from ovarian cancer disease. At this moment i am about to
end the race like this because the illness has gotten to a very bad
stage, without any family members and no child. I hope that you will
not expose or betray this trust and confidence that I am about to
entrust to you for the mutual benefit of the orphans and the less
privileged ones. I have some funds I inherited from my late
husband,the sum of ($12,000.000, dollars.) deposited in the Bank.
Having known my present health status, I decided to entrust this fund
to you believing that you will utilize it the way i am going to
instruct herein.
Therefore I need you to assist me and reclaim this money and use it
for Charity works, for orphanages and giving justice and help to the
poor, needy and to promote the words of God and the effort that the
house of God will be maintained says The Lord." Jeremiah 22:15-16.=E2=80=9C
It will be my great pleasure to compensate you with 35 % percent of
the total money for your personal use, 5 % percent for any expenses
that may occur during the international transfer process while 60% of
the money will go to the charity project.
All I require from you is sincerity and the ability to complete God's
task without any failure. It will be my pleasure to see that the bank
has finally released and transferred the fund into your bank account
therein your country even before I die here in the hospital, because
of my present health status everything needs to be processed rapidly
as soon as possible. Please I am waiting for your immediate reply on
my email for further details of the transaction and execution of this
charitable project.
Best Regards.
Mrs.Hannah  Wilson David.
