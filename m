Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B387757635A
	for <lists+linux-iio@lfdr.de>; Fri, 15 Jul 2022 16:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235208AbiGOOD4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Jul 2022 10:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235211AbiGOODh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Jul 2022 10:03:37 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F9B25E
        for <linux-iio@vger.kernel.org>; Fri, 15 Jul 2022 07:03:33 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id n206so6179494oia.6
        for <linux-iio@vger.kernel.org>; Fri, 15 Jul 2022 07:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=wiMWIX3l/jdmh+YACZVdS2gYVkizBVrd2KWV3gaU6Z4=;
        b=BIRzzrrQL0Y/ssJ/J1a73s5ddfcBNpuq17wksb8BrAecgeXu79gNbOCSg7gg8jDc0H
         CIr1FWr21Meh2ptFidR5u9gmSIZhBwhI42OMVN78REczlTDM2LNNpUt4maUQj4RmDA4N
         Fxp9Td+foUrQg3YajUZ00tt+YxZpEduZrGheQ14DJF8A3km3RH0YY++b3N6opKBOHHv9
         GTiioG580OvYVpkzcUPcOvkljBoqb5eSpakejnEzXH9k1NyId7a9rcNnnOI+vp5Pud9+
         MigV+TpA2wubAcgg1n/x+icopUw/rPXKn9oKqrMXFWYvfnCG6986liovKMbpE+KwympK
         ImsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=wiMWIX3l/jdmh+YACZVdS2gYVkizBVrd2KWV3gaU6Z4=;
        b=j0UshMoOFnHwgeQ+tahTK1+yS4GVWkbE6juI3kILRL0EYybCZQOrIE06KONGAujFn0
         CJz9JGO0cPD4iTNPyNPPBr3EMGRjgjAspPsb1ZRSKQuOeMoOt43u7YewiOv9c4VRP329
         3NUEf37cqa31OPgWxzYfb8U6euKxB5/zZG2XPd6JTwTkkQjhVGtGl8IVjhXItQk4IYBz
         C4OjLp2qE4Tiyq3zvvs1qhJzk6BFfAQDqzPS8kdBvi7Kcy0vwJoGuMEK39lDB9rjprCB
         OauaMRwfEibwz+1rKTmje0kFOzCaTa6ELZhkywu/At+51Uj1rS/4KmJOd8Xd9XevApoJ
         3nSA==
X-Gm-Message-State: AJIora/ioX6T5Pjdef0JCTs8OVpV6qyMyRwcuRiv/SGAxK5y5waH4Nmh
        nrSgxt0YOPn32EDRVaHiMKPrED5brsy9XuhV9Vw=
X-Google-Smtp-Source: AGRyM1s7LNB9hr5fGR7PvT5GhGUNbd6q7ioj8oQdK5JBz12Jn9CqYgSj7yZHq+Y6vkjCAL8dMSh0MfxAu/mEdRA2LYE=
X-Received: by 2002:a54:4105:0:b0:33a:3de4:3316 with SMTP id
 l5-20020a544105000000b0033a3de43316mr3632547oic.145.1657893812959; Fri, 15
 Jul 2022 07:03:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:7f0b:0:0:0:0:0 with HTTP; Fri, 15 Jul 2022 07:03:32
 -0700 (PDT)
Reply-To: susanneklatten201@gmail.com
From:   Susanne Klatten <dhelp782@gmail.com>
Date:   Fri, 15 Jul 2022 17:03:32 +0300
Message-ID: <CAO1axY_jCnf7Xt4J7jEjQ8kvB5MK7o9-Aanf5T4Vk-2jDoBvww@mail.gmail.com>
Subject: RE
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.9 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,REPTO_419_FRAUD_GM_LOOSE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:242 listed in]
        [list.dnswl.org]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.6404]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [dhelp782[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [susanneklatten201[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [dhelp782[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  1.0 REPTO_419_FRAUD_GM_LOOSE Ends-in-digits Reply-To is similar to
        *      known advance fee fraud collector mailbox
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

-- 
Hallo,

   Wie geht es dir heute?

Bitte haben Sie meine vorherige Mail erhalten, die ich Ihnen geschickt habe?
