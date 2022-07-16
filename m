Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F384E5771E1
	for <lists+linux-iio@lfdr.de>; Sun, 17 Jul 2022 00:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbiGPW0p (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 Jul 2022 18:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiGPW0o (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 16 Jul 2022 18:26:44 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D0F1C936
        for <linux-iio@vger.kernel.org>; Sat, 16 Jul 2022 15:26:44 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id p4so4949793wms.0
        for <linux-iio@vger.kernel.org>; Sat, 16 Jul 2022 15:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=EghGj1sxYfr8OVhDjPsSzkZ463+NHpt7aIzEyhPkSJc=;
        b=ihc5m2jylB4Q9R43h9pWsZue6vlVyjO560kbi8GruVbQjZ0M0hsBaya3OhSk8b2tau
         DXUr1CTFH5ojWe86G6nniaPuGHVqiO2N8ZocPmEmGXtxgIdQj5e/aA/k8fnUTATPaF+S
         vaJbIIIbifl3KdrUatdTOp2y/8CBL9drUERIsBrQHnHd+T+tROCZ0OECKILbnYzP1Tde
         yTSXwpTGw5+ndN+G4BM0dygs/VSl0551DU7Ohib9ZSo1vOkZ6QRHz761o/oNO/1EsFK6
         dWztURQvuY68Y5qvAq9L4T5Ex+yyGjgEEAjgUILTwW99oQfiFTmSD9yfJBXHg/indiVY
         sRSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=EghGj1sxYfr8OVhDjPsSzkZ463+NHpt7aIzEyhPkSJc=;
        b=oE/3p7TFJeEFbsKcfheqCiVk+Jf6kX5qFp28xFVR6M4pCpDlIACKVo5Dp4VsSoi6Ri
         bQEyeoc9I4Zg0AOmJgVdJfefbRT1cMzDo+HLMP5ZdprlyPwCa7JdTm+a2XT79F8WzQuo
         vKBragdJRtCSjECDCJnPcz+DPQ5nWN2QXbgZCzYkoxpQA6b2VZVmbJrWQSyJ5WAUw3pU
         43Vhh06xHBq5SXKKwKRNCZ7kZIEj03YrRfb5JVEWii6msy4I8jj1m3JeEJoXFqmKuE2m
         MHtT5ojJXcvlkrN+qedLRE5v7/yScQES63Y9xlzNudMt//iAYlzfIP8TX3jyG5sl63Y0
         7tlA==
X-Gm-Message-State: AJIora+OgkHF7clHpO9NeRlkv9P/5zle1aSpMU83Osp72hhJShYkpodf
        gljxTdCXLsV8VrvSqh6FyvxddyaUNWG/r3RHPWM=
X-Google-Smtp-Source: AGRyM1vUC7i5qWvoeJtoWq8cpFJM3YPIKTdklMKqBiS6dL+WJDBsjIbINxyPzS0IA+I3jo7MOEoU2DxEA9Hy9R2bZfY=
X-Received: by 2002:a05:600c:3d09:b0:3a3:1969:b0e with SMTP id
 bh9-20020a05600c3d0900b003a319690b0emr379wmb.72.1658010402620; Sat, 16 Jul
 2022 15:26:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6000:604:0:0:0:0 with HTTP; Sat, 16 Jul 2022 15:26:42
 -0700 (PDT)
Reply-To: susanneklatten201@gmail.com
From:   Susanne Klatten <templeslbudhaa@gmail.com>
Date:   Sun, 17 Jul 2022 01:26:42 +0300
Message-ID: <CAJeifn9=Cn_-0Yq4SBXWY5_EQVspdfR2jUgCFTn5vkD2=pW-mA@mail.gmail.com>
Subject: RE
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,REPTO_419_FRAUD_GM_LOOSE,
        SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:344 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5004]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [susanneklatten201[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [templeslbudhaa[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  1.0 REPTO_419_FRAUD_GM_LOOSE Ends-in-digits Reply-To is similar to
        *      known advance fee fraud collector mailbox
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hallo,

   Wie geht es dir heute?

Bitte haben Sie meine vorherige Mail erhalten, die ich Ihnen geschickt habe?

Unterschrift,
Vorstandsvorsitzender
Susanne Klatten.
