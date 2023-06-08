Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F375B7285E4
	for <lists+linux-iio@lfdr.de>; Thu,  8 Jun 2023 18:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233801AbjFHQ6s (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 8 Jun 2023 12:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232708AbjFHQ6s (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 8 Jun 2023 12:58:48 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8CE1210E
        for <linux-iio@vger.kernel.org>; Thu,  8 Jun 2023 09:58:46 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-461b408594fso585293e0c.1
        for <linux-iio@vger.kernel.org>; Thu, 08 Jun 2023 09:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686243526; x=1688835526;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Rx+fpDDKBbZXT14MW39zqik03Yfc8fMJgTANrynY4d8=;
        b=RROP5Hz/BCEfATYWrt7zb/CAtaufX9c93nz/Jeuott2/lyWwCRh+8mk7Q3zo05Ie2Y
         4fkP5obOvQgWdoy2rny9lYnLqtqUgSe7NbGfq4GYr8nb0DXfbIeRRXwhfgjCgQhUyGZJ
         0xdwSVA9l6QPpT7iJfT+ayDtqjMfb0rvZbD7uq7s5Sb6Mi611Ybt94FtAfVhAhwayyFQ
         l8HE0P56kjaZYcU0ceCKAzCU/TRkTerk+FteAtbNbfEwPwltbY2M7t7WTHHyypApq5AJ
         8uDSxF39MMN6Z4L3cwTL69tAi6wls5R6ZNavAa71mW6QB/IbA4LDH4/j2CEfhgQQ79Yw
         8PuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686243526; x=1688835526;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rx+fpDDKBbZXT14MW39zqik03Yfc8fMJgTANrynY4d8=;
        b=AxGv0twiQuS0bn4wunIQJF5G6c2sjlKv+XxjTEeK1PzESfJq0QWQ5nooR9S1CIiwB5
         18cRPYcYgqUtF6TLx05mvGz4Va0EnMVfuwn7RMGhhx6JQqm5GJ2oWcc6RgrONkUYFeqe
         P5zckOwAdojOL5CNsLXAESPBJr/q8DPuMG8t7kXS59dEoMEzm2StsZXJUU30u72gNBv0
         3cDtfC3XBoxgeZGMcYHu+goldrx4QSujJIqpq0ncAu+pGRtlvXPFWhlfFBVNxGX7FELj
         ZPcKPw9upo/3NQjcqmyLRj7TNtFsR96XqQAXk9j0UyKp2oLHS17NtPsZF4GZ1VE80eD/
         9QQA==
X-Gm-Message-State: AC+VfDzUPGKRXuYDtGYAlW8Af1r7DUW3FJMdKOY43QIhC25mLSj0mVG0
        eW94q3pKIvpHIsQ2ES4HhM3c8cS+V0xg+sMpYcI=
X-Google-Smtp-Source: ACHHUZ71Tu+zhsKd6/YqWNWAQJ66yLedizdJfhf2ZrE0/ENETru/EW7KCmAxSrDMNOANdX/9tJqpjWLToWhYrR6x1Yg=
X-Received: by 2002:a1f:4116:0:b0:43f:c6ba:c56c with SMTP id
 o22-20020a1f4116000000b0043fc6bac56cmr104621vka.5.1686243525724; Thu, 08 Jun
 2023 09:58:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:d64b:0:b0:3d6:22c2:b2d0 with HTTP; Thu, 8 Jun 2023
 09:58:44 -0700 (PDT)
Reply-To: elizabethedward021@gmail.com
From:   Elizabeth Edward <mrs.diallobalguissa1@gmail.com>
Date:   Thu, 8 Jun 2023 09:58:44 -0700
Message-ID: <CADp572uwHLXQO=63dYsLSpTgo2X_4ZZmLH+dmfrLGkUoBp_Xug@mail.gmail.com>
Subject: Greetings
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:a30 listed in]
        [list.dnswl.org]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mrs.diallobalguissa1[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [mrs.diallobalguissa1[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [elizabethedward021[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  0.2 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  1.3 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Please forgive me for stressing you with my predicaments as I know
that this letter may come to you as a big surprise.


Meanwhile, I am Madam Elizabeth Edward, 73 years, am from USA,
childless. I am suffering from adenocarcinoma Cancer of the lungs for
the past 8 years and from all indication my condition is really
deteriorating as my doctors have confirmed and courageously advised me
that I may not live beyond 4 weeks from now for the reason that the
tumor has reached a critical stage which has defiled all forms of
medical treatment.


Since my days are numbered, I=E2=80=99ve decided willingly to fulfill my
long-time vow to donate to the less privileged in at least 5 poorest
countries around the world, the sum of ($18.5M). I have tried to
handle this project by myself when I get better but I have seen that
my health could not allow me to do so anymore.


If you are interested in running a charity project for the interest of
the poor I will like you to introduce yourself to me including your
identity card and your project opinion.


And I will introduce you to my account officer for the transfer.


Best Regards!
Elizabeth Edward
