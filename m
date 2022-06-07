Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C62653F720
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jun 2022 09:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbiFGHZf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 Jun 2022 03:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237571AbiFGHZd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 7 Jun 2022 03:25:33 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6894C5E49
        for <linux-iio@vger.kernel.org>; Tue,  7 Jun 2022 00:25:31 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id bg6so13511072ejb.0
        for <linux-iio@vger.kernel.org>; Tue, 07 Jun 2022 00:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=OHbou33WPhW0PDy9/CZae9mIrL4buN3/FALSld4obAM=;
        b=CmizLCdUkCHQniGZ4iUmr8R03QR4tCO086jT6ADfiS8VP6aKTFRcT0upeq6SgvqdWY
         aC7OA5fFEwoyPtwHHc4T89KDqtf1WQV7D9hJCXipz3FeeWGTMryoV32+2isimg+8fd6k
         DbK3NgGHCa0xquCkgQJ11vuSZoQpAvHvGQuEgoy9FKjSTQVL/jZR+brMG7iNEB9ZpVmo
         TDbdl60dUMHtDgAm6yp0JVDdZxmIIxBI50961DjUG4LYR8AHClgHs7Qa9K/866pbv/8m
         0go+3hMj5PsGTMrynlH2b8QOtW5dUNnqd6ULJ4l1Sd4gwH9eoka4Yuu+Opu85A2074yN
         imNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=OHbou33WPhW0PDy9/CZae9mIrL4buN3/FALSld4obAM=;
        b=df0fx8968eVcsNAL4KICdPYGz71pxcbVf4/Z8E9IZ3z5WMBFkUOt+p48lsDkiE9hHp
         15sK/fEPKTn3wqn0R55a2j1z/rKFQxZ9kljaGSr7zzi1MxicMdGyWJnzwTmdJeg9+nq0
         4u3eqUucR2M4uhsUwMSzD0qeDuoS2uLMpcco1BKO3qEImwrDHo8aW9eWq7stAjyfJiHq
         O6nl4Auv68M8KyhdEeZXk4FpcixlOnsuyyTfOI+NCfgPbu4Dniz93XpIDtk0x1GJ6CYX
         U4i/6bVd2lfKKx1lNlSHTGWqhxOEfQjxDw0dbsQcz7LkxHx1MecCBVu+qF0aQFO/WsU/
         WZBA==
X-Gm-Message-State: AOAM53055JEhmPY8WvCnnDaBL8fBlBLrHQOzTRfnQgdllKJRSDrFhuKD
        Qo5GZQVseHF+I78cbE6vrGtp9SQI5cfukI3Zl+c=
X-Google-Smtp-Source: ABdhPJxyY8OYw9kzVkLnX5xkqvof1/SwCadEupsFP8YgqYYfX+CQw3PKOwc12xT65ew/6mE7xGY1M4W6OKng121HPMk=
X-Received: by 2002:a17:906:85cb:b0:70b:ffb4:b0e with SMTP id
 i11-20020a17090685cb00b0070bffb40b0emr21770211ejy.533.1654586730901; Tue, 07
 Jun 2022 00:25:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6402:26c8:0:0:0:0 with HTTP; Tue, 7 Jun 2022 00:25:30
 -0700 (PDT)
Reply-To: andyhalford22@gmail.com
From:   Andy Halford <fameyemrf@gmail.com>
Date:   Tue, 7 Jun 2022 00:25:30 -0700
Message-ID: <CAATdNatDezvvFjLL_Lw3ivwhoUpdxTbAEMzu_LOx8DB2cB2=OA@mail.gmail.com>
Subject: Dear Friend
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.8 required=5.0 tests=BAYES_50,DEAR_FRIEND,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:643 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [fameyemrf[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [andyhalford22[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  2.6 DEAR_FRIEND BODY: Dear Friend? That's not very dear!
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.3 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

-- 
Hello Sir



  I am Andy Halford from London, UK. Nice to meet you. Sorry for the
inconvenience it's because of the time difference. I contacted you
specifically regarding an important piece of information I intend
sharing with you that will be of interest to you. Having gone through
an intelligent methodical search, I decided to specifically contact
you hoping that you will find this information useful. Kindly confirm
I got the correct email by replying via same email to ensure I don't
send the information to the wrong person.



REGARDS
Andy Halford
