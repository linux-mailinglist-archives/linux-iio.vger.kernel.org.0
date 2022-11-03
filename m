Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8129F61896F
	for <lists+linux-iio@lfdr.de>; Thu,  3 Nov 2022 21:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbiKCUMQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Nov 2022 16:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbiKCUMO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 3 Nov 2022 16:12:14 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FE5205DE
        for <linux-iio@vger.kernel.org>; Thu,  3 Nov 2022 13:12:13 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id g13so1685532ile.0
        for <linux-iio@vger.kernel.org>; Thu, 03 Nov 2022 13:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eRqJLEoj2IQ/JF9LEX6H2ITW4FZJ568BdKfdiP8mFxQ=;
        b=Znngut9DM/YUKlXHKZjUQxeWAiORCTaIIgdaxTtfrwgbpv1QcRsIg1AaaTnSvJ4StG
         Ny7uj0RxHMIH8+qoC67u91gqq5e1zFX6mnpkpczFyH1oLo6+yqY+LHrFAYEImrdheGrx
         fnjINSF/p1LHLtTS5eqEQ2LF+Y5FtcV4SPuRxnZhLhsugY7Kv0sIz5C2ZWdVEvDh1Tdv
         UOaNtmt3uP44eJWci84fK9lMAMt0eCN+lkfbtd+D4opL0No3Ct6hrsxjrcup04orMpxV
         3/8KCymR5AljjklMjormg17D5zhQQHAZqiwuL6BmHURH2FVX07siNtu/k5HRAfJIXrvL
         mXDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eRqJLEoj2IQ/JF9LEX6H2ITW4FZJ568BdKfdiP8mFxQ=;
        b=P+ZhI/l2/wlTP/6xpvSq0YTKoHzSyFfsHLW8s9crAWrPl9Kb5dGysy92vy8qw/Ihdb
         M12L+/FfGI44qXqTVEbAZ09IT3DbFWORt8nn2hn+Y9da+vF5l9HFGccsPDdXHGwRvcsK
         usKjD+zxa+0hB0cjLWLKGQKH03VW5QQTHuf2ih7yCB5PHyC7pN2w5vjMh1wtwAe9NgLM
         Qd1RbkXlp2qeSnP4IRoZPHL+206VozkgPhj0a36UzaYFz4rYjMoJp/wTdiCDYUXw7yiw
         uNbbBi+46fz+yolpak0RtHZeWLqVBjSKx/vfny38V+l1jPKwz3mturgQEc3/GdaYPlpA
         6FmA==
X-Gm-Message-State: ACrzQf1LfqJpcpgJv4E+2vJ8nzDts9oAlhtGCoZ4ZTDn/e9I2QSLibWS
        MQFTjUqy5Na2TETKmLnT+cM+SHXq/iZd6i4N+IY=
X-Google-Smtp-Source: AMsMyM7z/0Yopq6nEVnLdTleFNxewkKlxCXty1BY53A9faef+OYLA5fAmRd2k59TCB9k/7Xstc8Gvgu31Jg1lZgExXU=
X-Received: by 2002:a92:c886:0:b0:300:cb13:7cce with SMTP id
 w6-20020a92c886000000b00300cb137ccemr6515000ilo.41.1667506332350; Thu, 03 Nov
 2022 13:12:12 -0700 (PDT)
MIME-Version: 1.0
Sender: robertwood0337@gmail.com
Received: by 2002:a92:c243:0:0:0:0:0 with HTTP; Thu, 3 Nov 2022 13:12:10 -0700 (PDT)
From:   MRS HANNAH VANDRAD <h.vandrad@gmail.com>
Date:   Thu, 3 Nov 2022 08:12:10 -1200
X-Google-Sender-Auth: qlXr6Sb90zHlC58p4-MGM-TOdcM
Message-ID: <CAChgFCOJgYHJ8=ATMmxYuxy-vhb4asYhs3HOCeBm3itrU_LrFQ@mail.gmail.com>
Subject: Greetings dear
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.1 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:142 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5515]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [robertwood0337[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [robertwood0337[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  3.2 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Greetings dear


   This letter might be a surprise to you, But I believe that you will
be honest to fulfill my final wish. I bring peace and love to you. It
is by the grace of god, I had no choice than to do what is lawful and
right in the sight of God for eternal life and in the sight of man for
witness of god=E2=80=99s mercy and glory upon my life. My dear, I sent this
mail praying it will find you in a good condition, since I myself am
in a very critical health condition in which I sleep every night
without knowing if I may be alive to see the next day. I am Mrs.Hannah
Vandrad, a widow suffering from a long time illness. I have some funds
I inherited from my late husband, the sum of ($11,000,000.00, Eleven
Million Dollars) my Doctor told me recently that I have serious
sickness which is a cancer problem. What disturbs me most is my stroke
sickness. Having known my condition, I decided to donate this fund to
a good person that will utilize it the way I am going to instruct
herein. I need a very honest and God fearing person who can claim this
money and use it for Charity works, for orphanages and gives justice
and help to the poor, needy and widows says The Lord." Jeremiah
22:15-16.=E2=80=9C and also build schools for less privilege that will be
named after my late husband if possible and to promote the word of god
and the effort that the house of god is maintained.

 I do not want a situation where this money will be used in an ungodly
manner. That's why I'm taking this decision. I'm not afraid of death,
so I know where I'm going. I accept this decision because I do not
have any child who will inherit this money after I die. Please I want
your sincere and urgent answer to know if you will be able to execute
this project, and I will give you more information on how the fund
will be transferred to your bank account. May the grace, peace, love
and the truth in the Word of god be with you and all those that you
love and  care for.

I am waiting for your reply.

May God Bless you.

Mrs. Hannah Vandrad,
