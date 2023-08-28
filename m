Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEEF78B151
	for <lists+linux-iio@lfdr.de>; Mon, 28 Aug 2023 15:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjH1NG5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Aug 2023 09:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjH1NGy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Aug 2023 09:06:54 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FEEA6
        for <linux-iio@vger.kernel.org>; Mon, 28 Aug 2023 06:06:51 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2bcc14ea414so48577881fa.0
        for <linux-iio@vger.kernel.org>; Mon, 28 Aug 2023 06:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693228010; x=1693832810;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=46Qd00mqgwhkkW6amCqEXLEzCc/q28cqM0GW7xvshDA=;
        b=O/lt5LD5Xsuwpk+vEIjOuHaU6gfLkT3SrGeLooL3f2svc/xymW3JAZmVIQaOwXIrgo
         jG6bBHjzRIyVBn/jBJFczBf17jXZeBFqhlgwHH1rCqra7dDjQLsL7tcOfoWLgBV11EEf
         /SmL5QHYiqgq2lK453Dmb2jlIZrTfkzPYRTF9bIcD0JZzGPMOCUmVKIA/iiSuqCZUnkW
         kxpd2I729bY0MblXN1sj0XgZLIMOzwCF3NaOtQhsiJJB61xe9gQX1Lj/A73ft7rntqCd
         ghrQmjwsvEv7Dpjfcj678jOZUI5EjHKtsLy2PmQxpS26PCDtgBR6UCG6D+Kpa+EjG7Ud
         DhpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693228010; x=1693832810;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=46Qd00mqgwhkkW6amCqEXLEzCc/q28cqM0GW7xvshDA=;
        b=gnD35f+A9UrK6wSjaVK5ZSV9/psQ8A7LZ3BunBmdM7p0duDIr9XpMau3TQJsa7i7mf
         xo+yu7yQNOXP4oD/zFRk1oKoe6AMgbIdTsTo956uGIT9MVz4O7QCQC71ZCZoSyslKXRM
         Ay00YFoDHDdwwF8RdOsBZHnwtU72DxI3KvdBlCLjvHz88h1i/tUuDRIXzcAbgoUHeEX8
         Yk2MP17QmB4IHBeqj9OLAsWnG7w3jyivlIRoP7WTqmWmcgQxP9JNBUKQUIOHeb2lLjTF
         qSKHwdao+m4GySfcB5db9zfnvVGB1/20RcMoBdSGObMlXCYsumCWxa8ff0dwjAfQpTw6
         tXew==
X-Gm-Message-State: AOJu0Yw3GSvwWHNL2leswubKg34iGDU0pEFLXdOcyI69X98bd1hK8FQE
        nmdZZohVlQegSw7JnleUon/jI8lhjYpYlffC+SE=
X-Google-Smtp-Source: AGHT+IH8MJj5SaTwXifdUuqZBGqpbMlRHoTKukzfNMPXYHO1CH2qELk6+rp1Augqi0VrRUbDzkL6Y7MgVSgGRe6U12o=
X-Received: by 2002:a2e:9818:0:b0:2bc:db70:b563 with SMTP id
 a24-20020a2e9818000000b002bcdb70b563mr11075132ljj.32.1693228009610; Mon, 28
 Aug 2023 06:06:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:81d0:0:b0:2b9:344f:fe4d with HTTP; Mon, 28 Aug 2023
 06:06:49 -0700 (PDT)
Reply-To: ab8111977@gmail.com
From:   Ms Nadage Lassou <vdhdg65@gmail.com>
Date:   Mon, 28 Aug 2023 14:06:49 +0100
Message-ID: <CALadyHYFs4p3skdPJOcHmzq9CZWhBc8mFVmC61xr0fjv3SJcSg@mail.gmail.com>
Subject: REPLY BACK.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,UNDISC_FREEM
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5003]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [vdhdg65[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [ab8111977[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [vdhdg65[at]gmail.com]
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:22a listed in]
        [list.dnswl.org]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  2.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Greetings.

I have something important to tell you.
i will send you the details once i hear from you.
Thanks,
Ms Nadage Lassou
