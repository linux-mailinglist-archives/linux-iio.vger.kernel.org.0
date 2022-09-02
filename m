Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7675AADCB
	for <lists+linux-iio@lfdr.de>; Fri,  2 Sep 2022 13:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235492AbiIBLiM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 2 Sep 2022 07:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235625AbiIBLiF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 2 Sep 2022 07:38:05 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92FDD71BFA
        for <linux-iio@vger.kernel.org>; Fri,  2 Sep 2022 04:38:02 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id c3so1742521vsc.6
        for <linux-iio@vger.kernel.org>; Fri, 02 Sep 2022 04:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=K9aCivmd3pOhXO+7wSe24RMSLcWBP61HE/hhO1yg1yw=;
        b=Ot4bF0kh4r+bt3yX0WbYoonh4TjK6eXhVCC+R0RZUyBpP7K1P+CLu/aIEu6XP5MVA2
         nbeeqpjm1ywv9wERsHt2phlXbMMLsYwMORsHWp8Lmlva1O6uoBdyRa2Asw+ABUM8xTD1
         KdqbMRM3ERQtUXQqZrU1yyl80QKPG1AylvSTCc/4uOsoXso1aG5T0bB+j5rjLDekUCIR
         3Y+4kXwYGQ8R/uDrT5ElbQMNkE7U4ppGrC0Q0i1DMdmTJtEtpD1SaiW76LOwMfpM7Tqy
         Zo5HRZuYJoScMgs1bXtBqDRtqimZQ5kPXYPuylO6rqjdxNdyTYoOYYVJR8F+zIXPOiRy
         Ap0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=K9aCivmd3pOhXO+7wSe24RMSLcWBP61HE/hhO1yg1yw=;
        b=pR8j+2UDvlwkmzcAo/Yitwfjp7aBVBHt9/s2gXmocO9732z6thsZ2OQ3JIQfoZLZLh
         sftFOxtBAk+3r/ew4bDWxXsAtPRiSw+YHtwJ3LprFzVEdbEdu8VIs4mSV2v/I3KGH2bY
         mDMa1MRr22Fdi+BYDess95akN8x81Cdv3G0MVvbCBZsZCapJ375N4g42Wfg5fv76qlhZ
         z+1PefDKmXYgQXLM/cNaQEnhdMiYtTQgFT7rEIYq3+sz8Gewk2AaXwO1zCW5T5mOkqzf
         Mb2rOgNsPmtDBoMXyYdae91O3/dgWu9zQuT883F2E4T8/ahhP/w3SFMeI4/w0UY0V630
         j+eA==
X-Gm-Message-State: ACgBeo2mxcPLlrYze2chFSHgB1AMaF/j+fUBlKsTsJMUjAnlVhDTG0rC
        /PMQOl/5XOHHb6V2w6U/q/RMufRbgpcuuWYISUU=
X-Google-Smtp-Source: AA6agR4Nf2JIOXS2Dic1Rwa7JNvICUcMJeoUUi4ThFrtacG0+NqwZFzABkMVn2OhmSS/y+hcBMwO/oEYIlq2SwJ3t8o=
X-Received: by 2002:a67:fd81:0:b0:390:d914:2cc9 with SMTP id
 k1-20020a67fd81000000b00390d9142cc9mr9244611vsq.30.1662118681346; Fri, 02 Sep
 2022 04:38:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6124:2425:b0:310:618c:a0e3 with HTTP; Fri, 2 Sep 2022
 04:38:00 -0700 (PDT)
Reply-To: mr.abraham022@gmail.com
From:   "Mr.Abraham" <davidkekeli001@gmail.com>
Date:   Fri, 2 Sep 2022 11:38:00 +0000
Message-ID: <CAD7994f_1hVHzmmWA9dpZkWnQN+WRdBraE_rJ=jUJ2LQYDua4w@mail.gmail.com>
Subject: Hi
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:e2c listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4837]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [davidkekeli001[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mr.abraham022[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [davidkekeli001[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

My Greeting, Did you receive the letter i sent to you. Please answer me.
Best Regard,Mr.Abraham,
