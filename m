Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2770D51E25F
	for <lists+linux-iio@lfdr.de>; Sat,  7 May 2022 01:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357306AbiEFWVr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 6 May 2022 18:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbiEFWVq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 6 May 2022 18:21:46 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E08F0B
        for <linux-iio@vger.kernel.org>; Fri,  6 May 2022 15:18:02 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id t11so7027163qto.11
        for <linux-iio@vger.kernel.org>; Fri, 06 May 2022 15:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=2X7okUOFinGFj+Vk5wl8ORWJSZhAxnt3NdvEIzO27Ug=;
        b=lI3hY+zBVhVKqFRBt0/qX4uhNyVjc+h8jgYCoyVrEC/3+uhf1aH7L+AP7+GraYyF7l
         KW3CRiIssCL+6SlTWRMDoh44m9sgjSPXMLuUrO89gc/MtFoFeYChh16IU2hYHoz5e8v1
         GpP6DqBLz+VOI//DcA/aykOkEc/vcoJPr+l2GKzHFBnRSrVMjumh/izDEbipZMcjum+f
         tNcyTL1Tbf3vrSQbTpwEJJgx0ZppoXS3W1V0GDhA4d4uZeZPabKcnFVIZFa2cJGD2nlN
         D7gu4H70C8ZMrPAWkOvyLcwK90T1hRdU3zKkzYB/VWFXns/l/72UGJnVip72N/ihSS5Q
         U8nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=2X7okUOFinGFj+Vk5wl8ORWJSZhAxnt3NdvEIzO27Ug=;
        b=vn/hV1+yJVCvEjeAt04dilDP/VP76qeFukB5LDBHAZH6WAsBl7BIcQQ6pwDE2k6nqR
         IbTClMg5TaDFs/lp9Db0OlmBF25tj87u4xdOKofOUgcb8hE0qeK4+qkeBX1lUKy8BPKR
         KgZX0V4l2VWh3pqozaC63807UDE60jRz5INFCO10G6zXxygg4fB1RfqyZ4T4S9ZK0YTT
         B5dI2kqwdHGguTuhsU16xU9UorbeQBdtqdL1sGxHVDWAVE/oMkAQtBoMVDEhVbRTmM10
         iH05h30+Ir/IWOIeUUtl5CxQV94MVwqETp2RKoJte2tDF07EPKjL+gvYIxAZPRxyYXvI
         /fzg==
X-Gm-Message-State: AOAM531AYETqNtJdocYOlHL1DQ01jAWm3Famb4Xmo5z1d3goSC5mHGxm
        AzVc9mVUF/hguZYTdXQCQQqXyrJxUhQ9qd1tV/0=
X-Google-Smtp-Source: ABdhPJyO5/u8Eicn3TR/bDXVKK+F1wed3K8HHv21xXzuDkoOkwrmRWag+Dd5/gjGfNnjmZXXCcyg1dvKxeFc14e6w2s=
X-Received: by 2002:a05:622a:1183:b0:2f3:ba22:5b53 with SMTP id
 m3-20020a05622a118300b002f3ba225b53mr4917599qtk.203.1651875481674; Fri, 06
 May 2022 15:18:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6214:1c4f:0:0:0:0 with HTTP; Fri, 6 May 2022 15:18:01
 -0700 (PDT)
From:   Frank Hughes <ccmk137@gmail.com>
Date:   Fri, 6 May 2022 23:18:01 +0100
Message-ID: <CANqQpXWxaGXQcqxrvR04nnj27cXdV70ChRBxEZkprRhMJ8h-NQ@mail.gmail.com>
Subject: Hello,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.3 required=5.0 tests=ADVANCE_FEE_3_NEW_MONEY,
        BAYES_60,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_MONEY_PERCENT,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:82e listed in]
        [list.dnswl.org]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.6295]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ccmk137[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [ccmk137[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  2.1 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  2.7 ADVANCE_FEE_3_NEW_MONEY Advance Fee fraud and lots of money
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,

I'm Frank Hughes. a former commander during the United States War in
Afghanistan. Now that the United States has completed its mission in
Afghanistan, I am currently in Syria for more assignments but will
soon be assigned to the Joint Multinational Readiness Center (JMRC),

During my 6 years here in Afghanistan, I was able to make the sum of
$25,000,000.00 Million Dollars. this money came from oil deal.
Second, I'm a uniformed person and I can't parry with that
amount, so I have to present someone as my foreign partner. I am an
American and an intelligence officer i have 100% authentic means of
shipping the money through diplomatic shipping company. I just need
your acceptance and everything is ready.

The only way to be safe with that money is to invest it there in your
country, considering I will be there for some time. So I need someone
to deal with. If you accept, I will move the money to you as my
foreign partner. For your help, you will be given 30% of the total
fund and 70% will be for me, from there I will invest the rest. Before
leaving Afghanistan , I sealed and package the consignment was moved
from Afghanistan to the United Kingdom, through a special arrangement
with the united nation RED CROSS service in London with an agreement
that I will provide with details of my partner and recipient of the
shipment.

When we agree to work together, I will you to the company information
in London to complete the shipment formalities and introduce you as
the partner and recipient of the shipment. Where we are now, we can
only communicate through our military communications facilities, which
are secured. Please send me your personal cell phone number so that I
can call you for further inquiries when I'm from our military network.

regards
commander Frank Hughes.
