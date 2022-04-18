Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3BEE504C8A
	for <lists+linux-iio@lfdr.de>; Mon, 18 Apr 2022 08:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236741AbiDRGYT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Apr 2022 02:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbiDRGYR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Apr 2022 02:24:17 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C2B1837C
        for <linux-iio@vger.kernel.org>; Sun, 17 Apr 2022 23:21:40 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id s16so1927511oie.0
        for <linux-iio@vger.kernel.org>; Sun, 17 Apr 2022 23:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=gT0qunonoqmQDH3Sx35AGkd9jYv/vMqV6NEmgNMh3r8=;
        b=CQWwoX1IxE8b+uF1gIBaZkweamlPS68OR7HgJzH9bHVUvSqZtyTLSitK8nZ/wkyxz0
         55gSUwA10DEE4uZ2Lsg6yfVtlhKIcRqv5iJVHujCsLLknoB3Frd2Q/C7pCFh54Fyry4T
         nixUVMj8/QRwIn/SoMgEIf8RiwgI6ETuE8qeiv17wSAUwW49MUVLgXcvplEKz8JZJ52r
         K0OXuR2zrmPaoskDeEFD3+vUC5JLqNChRL/sFlh2IJMlY2c+3SSxO6evmmLY0GtvN8w3
         RYXW+XzmyUrbZBpXv9ms8LLErA7AZzUWXzghnxtCUR+t8fZMKgK6FgpFgEdS2y13teTt
         GXew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=gT0qunonoqmQDH3Sx35AGkd9jYv/vMqV6NEmgNMh3r8=;
        b=hE7qH0hbEF7dP8jY9yS/u6g8SBEY98QPUi2rxIeikRCaxvwuI0AlwmYdLgLr9vYmFD
         elURzjuYUDH3pYz2kcn/wzNveu8VvYRkL8NlOSJhUTvRop7p3Y2m0pJXZ+qOLUVhuWBM
         n/lpzSuPJ5vglKQiHV58J+SB4xNBiCWgj10WmcXYg6v2ohueQ1JTJQTaR6ZtxG1Esevy
         cZCkctI50CNo4gdNulIV3lQ7cUloOEkRRZRdRwr45YJzT2HpB45CsC4XKyDFyKSpXfoX
         Prxcsm/81X6LpyJ6LGWH1CQQYdYSOtoKNJ5mDKaTFObeDw+aZPKi28vc1Z00KquWgq6I
         rvQw==
X-Gm-Message-State: AOAM530ZPm9M3xyUSZbMpk+vdgA05dHEPUpDEyHCl1dN6PDzlYQiDcA2
        +m3ytIjt3shgzAzLTFsUk4+tUZ3viTb/mX1os8o=
X-Google-Smtp-Source: ABdhPJyqxmX3/TuBoA+q6CDJ2Dkv2Lx64mMRNkmgkQDbwI5zR2zafXvlsrzhQQukU6210L8FdbpmiJDW1XIIaXB3iPM=
X-Received: by 2002:a05:6808:23d0:b0:322:781a:65f4 with SMTP id
 bq16-20020a05680823d000b00322781a65f4mr2584700oib.263.1650262899352; Sun, 17
 Apr 2022 23:21:39 -0700 (PDT)
MIME-Version: 1.0
Reply-To: nafi177z@hotmail.com
Sender: g.prosper001@gmail.com
Received: by 2002:a4a:978f:0:0:0:0:0 with HTTP; Sun, 17 Apr 2022 23:21:38
 -0700 (PDT)
From:   Ms Nafisa Zongo <msnafisazongo@gmail.com>
Date:   Sun, 17 Apr 2022 23:21:38 -0700
X-Google-Sender-Auth: LtRfpaxvzhc6LGYcxsGvVA4JLl0
Message-ID: <CAL_6emfx43_+FNkoQUoi0dC_kPHgGYeVawh5U+XBnQctvwVSvA@mail.gmail.com>
Subject: RE.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:236 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4821]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [g.prosper001[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [g.prosper001[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

I seek for your partnership in a transaction business which you will
be communicated in details upon response.

Best regards
Ms. Nafisa.
