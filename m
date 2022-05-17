Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E146D529CF5
	for <lists+linux-iio@lfdr.de>; Tue, 17 May 2022 10:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243621AbiEQIy0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 May 2022 04:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243803AbiEQIyZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 May 2022 04:54:25 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC89F433BB
        for <linux-iio@vger.kernel.org>; Tue, 17 May 2022 01:54:22 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id i8so2822624plr.13
        for <linux-iio@vger.kernel.org>; Tue, 17 May 2022 01:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=SUWQMmwZSct1NUq5pHL/uGOr0m/f9iWjJQkP63QJuAY=;
        b=NvmQSJGdjKtpHGcAKlUwoZazkK2OPpkx5N0nn9RCxjpj5uE1sHV/4nN1H4jzBVujWw
         sssuqqWi9bI+t7YPbxYbV54onnklAlgif0afvfGpQLC7L4RBPI1tWdpw5IrtWcoYTkFZ
         EcVEHC+zueNhLXHPwnKeddsuIc/OaeSrbvcytLVH5ao0j7YNQU7FWKy6fcaBRNkFBDp3
         4eydA5qZtrstDenXB2TB63waE6Sll4kxQxheRCPcrQtRa1rLp5s3yJhFf+4ng9hzZqRz
         GKOkn4SFnQTW4cBYFv8IVs+4ZNH4tRnA5qINPHypJ+cYiwWwwCUxMuohdTU2C13Ql6Wr
         6D+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=SUWQMmwZSct1NUq5pHL/uGOr0m/f9iWjJQkP63QJuAY=;
        b=POqN+kFXHZIxN5bc1eczcIi2J33pKzRGYfXT5HrkKo5fgvMh458c4PBWfK6zDp/a4w
         wI05U/5+ffYVvUU4wn0wnI+uZ5s2TPMjIdXom7iY5NCfrWy3C2caQLbe5rwTyxHDYwnW
         U9BoGPWHNSu10x2O+sAp6DKzm/1x7RuS26YjLuGY65NgA1mUoZVtvJEpDmpJZikamsqr
         Hab3MVTO9eSE1Um/XX4fBnMM0l5ochRn4Wg3l0MatL+aGGrTNPJDz7maXKTlETocpkXO
         5l7SPeV9kUF4qxWWlX5YafuQcYjfnILvlcDo/garrD/+aQtuh454Lry1+ss/9SKN9BaN
         2TNA==
X-Gm-Message-State: AOAM531Y5y3RPC3c6o5lMF4gCvsG44YrJGr/EWoIqf15yvIl3bO7Cxtr
        EBfnSADx1orHXKKIle51SSEMxPyO3hljuRIflb4=
X-Google-Smtp-Source: ABdhPJxhkXJnVZVBIdNk55MABZH32+ec4Cxt4kGWwtlLOGUKmJDqMINJclfGMMKzUOohqFDumtGRaCvJ7Rp2fWhJdyQ=
X-Received: by 2002:a17:902:7401:b0:161:9465:809b with SMTP id
 g1-20020a170902740100b001619465809bmr5571379pll.161.1652777662205; Tue, 17
 May 2022 01:54:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a20:7208:b0:7f:52b4:286f with HTTP; Tue, 17 May 2022
 01:54:21 -0700 (PDT)
Reply-To: jub47823@gmail.com
From:   Julian Bikram <kodjoadannou123@gmail.com>
Date:   Tue, 17 May 2022 08:54:21 +0000
Message-ID: <CAOtKoZ8vJ05A53XRPQjRBgB42BLMr1-1CEyUOU0Dm73M52u+DQ@mail.gmail.com>
Subject: Please can i have your attention
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:634 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4987]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [kodjoadannou123[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [kodjoadannou123[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [jub47823[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.4 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Dear ,


Please can I have your attention and possibly help me for humanity's
sake please. I am writing this message with a heavy heart filled with
sorrows and sadness.

Please if you can respond, i have an issue that i will be most
grateful if you could help me deal with it please.

Julian
