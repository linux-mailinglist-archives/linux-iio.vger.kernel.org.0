Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEDB5AD1EE
	for <lists+linux-iio@lfdr.de>; Mon,  5 Sep 2022 13:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236214AbiIELzH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Sep 2022 07:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237713AbiIELzG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Sep 2022 07:55:06 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32BD1B7A0
        for <linux-iio@vger.kernel.org>; Mon,  5 Sep 2022 04:55:05 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id z187so8389969pfb.12
        for <linux-iio@vger.kernel.org>; Mon, 05 Sep 2022 04:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date;
        bh=3heU9XnQLBxOKcLg4YsF7ZYEM3SBcg+5pXKhqb5TwPI=;
        b=oSWMFsVerK3P9BYD8DCKg0VYtamA/CK8Qx54UYBBLH22jCXmBjWEh/cd5/qiqd1CBl
         Jl9hvSfrzJou0jAw7uJjAp+i/3YFNyTfQz8NNE7NaDp9XbsIUNp/eyGxzmI3ThObk0id
         1VvzQvKSqWVZf/rXv5mpIMCVOLw9Lw514mhy5NW7x7rhC5LHF5muh0p+cASrDVPRbYKg
         JdtMCtcY34Lq6QBySAV7VFCAmfYDjqwvsgdcWfw+lqjAo0n/cSGcusvs3GhlEdhIf5CZ
         E9oEIijQJAN4BASREpbEOiN8ll7GD6lCxKm8+YosrBdt0VB2ptg5h+wvXQFTMeOHhVw0
         yUDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=3heU9XnQLBxOKcLg4YsF7ZYEM3SBcg+5pXKhqb5TwPI=;
        b=JqC5t+YXID22kpa2fFVSar/kkRacFZcv6SytbdtShZ8WAZDL+s6JlgWwyRw0GreCwt
         Jirg9iWyCPuTIrnYeLCnMw5CzrrhcurH9k2PiUAnv1fwWwUeCu4i+C4bbPhDt0wn61E+
         YOXb8aTJjbPin4pFruzXimvnzPVyjW0HtbdUtcFO5TuNPZS2pTQIJtlOdW3fz97bw/MF
         Ille5KkWXQmNZKAV1p1g6/xsFyvtP3nFm3R1TWpeU454FLhPvKNfZlRsEOxvRs6jiShm
         CPyh+NALpX/Jp5o2a+viob2fFK4QjlktMsz0A61QpJInvsWUvFFtSoknnBMOHlXjFM98
         jxig==
X-Gm-Message-State: ACgBeo3JyGZGQdvM275A1NZ38aKFJpluEUzgxUkbf3LhqUphP+G6tcKZ
        wB0E9I5bbhDKsSmJW/ztcekaDMEoPv75eMAnOBI=
X-Google-Smtp-Source: AA6agR77IV0BZfIy/jLAPSyjlp44DOGt+dT5SaNwNxz4imBZ8J6UGqrsLLvC30g9Dxf8Nhfo9nxjIRC3dM2yQtIP9uw=
X-Received: by 2002:a05:6a00:23c5:b0:535:5c24:68df with SMTP id
 g5-20020a056a0023c500b005355c2468dfmr49978045pfc.62.1662378905208; Mon, 05
 Sep 2022 04:55:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac4:a093:0:b0:569:502d:4e6f with HTTP; Mon, 5 Sep 2022
 04:55:03 -0700 (PDT)
Reply-To: almondd797@gmail.com
From:   Duke Almond <bosssalomon269@gmail.com>
Date:   Mon, 5 Sep 2022 04:55:03 -0700
Message-ID: <CAJoaEJ==v6NoJY5t9XYonJwk=6MSzCAjk6MfzjQvVmXOaUfe=w@mail.gmail.com>
Subject: From Captain.Duke Almond
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:42c listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5001]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [almondd797[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [bosssalomon269[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [bosssalomon269[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

--=20
Good Day,

I know this email might come to you as a surprise because is coming
from someone you haven=E2=80=99t met with before. I am Duke Almond, From
Cyprus A Military Man, I would like to
establish with you in any profitable business there in your country
with my saved money here in the military peacekeeping mission.

I will introduce Myself better and send you my photos and more Details
as soon as I receive your reply.

Captain.Duke Almond.
