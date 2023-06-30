Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0767440E3
	for <lists+linux-iio@lfdr.de>; Fri, 30 Jun 2023 19:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbjF3RJb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 30 Jun 2023 13:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232793AbjF3RJa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Jun 2023 13:09:30 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25AE1BE9
        for <linux-iio@vger.kernel.org>; Fri, 30 Jun 2023 10:09:29 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b69ff54321so34153241fa.2
        for <linux-iio@vger.kernel.org>; Fri, 30 Jun 2023 10:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688144968; x=1690736968;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JGCKey1oVTvw3qqUpnKTc5J/Ov91stFWYyRGWkdeiAU=;
        b=W6D7bjsB/YhrqYpUKY6n0EmizhoQ6V4WkC+GoaEqpYJ/AhGUYbaeciwr4NYp1qZRP+
         cP/FBgXMME3vomZyrm8hn5Ylun8o1f5m8a6l1QxQOb2e7N5We/HdpoBfoVlbBdr8xZTy
         XcGnfz/pMFn34k1tCjr236JPlEoItu8hhYvlje5S/gyyrwKp3pwLJdUddievsbyMbMuq
         IdOMeo13vSjHL52UKfhAf4c8+9W9ynwH7+8vDDFjS1z7/ToDF5o2ByVf7/NLZL4yPala
         xNSAeNc7aLvWZhTl4bGCMinqNg8mOTiiVC0jTh0ZkaeTLgPrFVJqa49l61oYy15L1ULb
         g06A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688144968; x=1690736968;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JGCKey1oVTvw3qqUpnKTc5J/Ov91stFWYyRGWkdeiAU=;
        b=ESiJmbgGda6PX4Qeg2WVTt7UUam2ZH/wJpD2/gKcXYfyx7rzUbmV0WV3sM3HmRqgML
         pdFmc6C/1eIh0REu7ExcPQpXtjJ99x84AvX5F+MyrCO4RQKGEhKRcMALr53lV1RavsZ8
         Ud3iFr4DlSANUFfuYzR1Uz4KeYeI24Wgh/T7wgntLoKnuZ4rdfZ5yYknGUnfH3ON3yzt
         K4E9OwFR8Bbn3odAE+z38OHlCPh7QEk8ij8WyiDrRi2TRN/pc/gX3czhBUrNt5jeyydQ
         xWjrDfbIl0RoIZMe8RCvJCaFyrxBLJAjdIxGvJGbHPx/JLC2FpRRbgF34v57Qr1zLsG7
         sjSA==
X-Gm-Message-State: ABy/qLbSydtu4JPyldqhaUo5dXu6Am1c+v0paMWed4MpUvBCj4b3KHy0
        DQ9w5EwZkRtYDRuSFjJsSvA5Ca1NzQ7e1YWOTgE=
X-Google-Smtp-Source: APBJJlEo6coODtKi9kp8gwXLIiHDqj56G4R15M1r0r7aooYTM04hD7ZsbA4zdp7MIrPola95KZLNNQdooPuZfycUk9E=
X-Received: by 2002:a2e:7a06:0:b0:2b5:9b3b:f7ea with SMTP id
 v6-20020a2e7a06000000b002b59b3bf7eamr2252916ljc.41.1688144967928; Fri, 30 Jun
 2023 10:09:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:9c02:0:b0:2b6:c8ae:720f with HTTP; Fri, 30 Jun 2023
 10:09:27 -0700 (PDT)
Reply-To: mrandrewkabore@gmail.com
From:   "Mr.Andrew Kabore" <jling7671@gmail.com>
Date:   Fri, 30 Jun 2023 10:09:27 -0700
Message-ID: <CAMzTaQXS_hC2xnQQDkwCKcWybOX6bWWDDSB58EDZjD7Oiii8XA@mail.gmail.com>
Subject: Mr.Andrew
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.8 required=5.0 tests=ADVANCE_FEE_4_NEW,BAYES_50,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:235 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5076]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [jling7671[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [jling7671[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  0.0 ADVANCE_FEE_4_NEW Appears to be advance fee fraud (Nigerian
        *      419)
        *  3.2 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

My dear

 Good day Friend.I'm Mr.Andrew Kabore.Take your time to read my
message i know It may look as a surprise to you that I am using this
medium to contact you for the first time, because I need your
assistance in an urgent transaction with mutual benefit that requires
maximum confidence and I believe that you will not betray this trust
that I have on you.

It is also my desire to notify you that this transaction is hitch free
and that you should not entertain any atom of fear and please you have
to make known to me now your stand in this proposal so that i will
know my faith on you, as this transaction means a lot to me so that i
can send the details of the business to you and i will be awaiting for
your response this mail soonest.

Yours faithfully,


Mr.Andrew Kabore
