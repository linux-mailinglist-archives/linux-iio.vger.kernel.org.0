Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D64356A244
	for <lists+linux-iio@lfdr.de>; Thu,  7 Jul 2022 14:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234818AbiGGMrt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 7 Jul 2022 08:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233344AbiGGMrt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 7 Jul 2022 08:47:49 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501E827178
        for <linux-iio@vger.kernel.org>; Thu,  7 Jul 2022 05:47:48 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id l190so1043565vsc.0
        for <linux-iio@vger.kernel.org>; Thu, 07 Jul 2022 05:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=1jdblMpFBKUwk7zox+k3ZbwIYwyiF/LOyoPJdh00Exg=;
        b=KeMZOFkYvAygb489U03KzGP5lp+GE20DSw8FGYR0NqgffVAtdZKs6BmXype1bDUt26
         M6gof1KE/xGg+SJ49b5PC5+LgemD/qkaHZoP38TjJ28birR9e9i13H2VrocclSTgWoMy
         2GEwrShTpAZUQ1IaHGOlrHCE/a//UDsebnQ5fPXm1HrIc7o6Q507M7ExGTElFUtlcnR3
         aiiSXmHlXgT7jx9LblW3f54KY+9cSmd2KUitUJdpwrVirQGLStkFaamj62yeiS3oVPIO
         QqdGKPXNzKptXiCe9lxQgzmdaA7JxMJkT11NgJJ4VCf1Mq0IFii8eR+3UFOIJpt/k73d
         B1qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=1jdblMpFBKUwk7zox+k3ZbwIYwyiF/LOyoPJdh00Exg=;
        b=nYWAoQAE05b3i5V9/UuWod+sbEVVvePn7JozNQKYZp6mU64kcfl/rsx9XzFIlJ7X2k
         YO3OdPTc7Z/AFgKaO2eQMyux2YaR/+5TYyoFcqi4uM0/owngf8ULa/euWtuP23EnCkb9
         zioq1Hv8uePthraoIxTTl8rXPrqtosskTSw0X2PZ8HqXZblFTchPq6kbGSQbEvQwS1I/
         dPIf2SXShVHx8Trw+NVfP+Ai4cWVsqpOOPD47KFYfPh6ONQ2Jt8zwb/Af9540agqyr4F
         NCcOHzPxqpKVZpE3fEf0GDFBsIh6fxTSxvQThLpbwlxhZ9ay5rml91FhlBm7EqtkVX+v
         2PNg==
X-Gm-Message-State: AJIora+O6JU8XmdBJ0P16SFB5eXuPHqeE2/1ZE14PPcfmBWGwCxG3IXY
        9Nw+ASWTvZZGPCLFhB8aR12PWyw10wKb90zUxEQ=
X-Google-Smtp-Source: AGRyM1ty87FlfoxuMZEVkPSw3Tl7CLEYsmxSbh24A8VpMEe6VrzdMc0DXwDu4MLj8gzdjMrSHCmy5X81u+NvenLdIdU=
X-Received: by 2002:a67:c38e:0:b0:357:1ac2:eddb with SMTP id
 s14-20020a67c38e000000b003571ac2eddbmr4438502vsj.24.1657198067148; Thu, 07
 Jul 2022 05:47:47 -0700 (PDT)
MIME-Version: 1.0
Sender: ndersontheresa.24@gmail.com
Received: by 2002:a05:6102:3f0a:0:0:0:0 with HTTP; Thu, 7 Jul 2022 05:47:46
 -0700 (PDT)
From:   "Doris.David" <mrs.doris.david02@gmail.com>
Date:   Thu, 7 Jul 2022 05:47:46 -0700
X-Google-Sender-Auth: mv8AST8KZhnSDBBiH7gEfXZwQKo
Message-ID: <CAEJT=xCxNudPTWcBfSAUe6Pt3GF4FW+CeJHhk5sJbrCkhXqPZA@mail.gmail.com>
Subject: Re: Greetings My Dear,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.4 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:e2f listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5207]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [ndersontheresa.24[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ndersontheresa.24[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  2.6 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Greetings,

I sent this mail praying it will find you in a good condition, since I
myself am in a very critical health condition in which I sleep every
night  without knowing if I may be alive to see the next day. I am
Mrs.doris david, a widow suffering from a long time illness. I have
some funds I  inherited from my late husband, the sum of
($11,000,000.00) my Doctor told me recently that I have serious
sickness which is a cancer problem. What disturbs me most is my stroke
sickness. Having known my condition, I decided to donate this fund to
a good person that will utilize it the way I am going to instruct
herein. I need a very honest God.

fearing a person who can claim this money and use it for Charity
works, for orphanages, widows and also build schools for less
privileges that will be named after my late husband if possible and to
promote the word of God and the effort that the house of God is
maintained. I do not want a situation where this money will be used in
an ungodly manner. That's why I' making this decision. I'm not afraid
of death so I know where I'm going. I accept this decision because I
do not have any child who will inherit this money after I die. Please
I want your sincere and urgent answer to know if you will be able to
execute this project, and I will give you more information on how
thunder will be transferred to your bank account. I am waiting for
your reply.

May God Bless you,
Mrs.doris david,
