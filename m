Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D64E257719E
	for <lists+linux-iio@lfdr.de>; Sat, 16 Jul 2022 23:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiGPVrS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 Jul 2022 17:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiGPVrR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 16 Jul 2022 17:47:17 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C97819008
        for <linux-iio@vger.kernel.org>; Sat, 16 Jul 2022 14:47:16 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id p4so4916783wms.0
        for <linux-iio@vger.kernel.org>; Sat, 16 Jul 2022 14:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=1Wa6X8AdL0KnTRBIO9JvG5gqYz06mbtzxWUnUnljK0c=;
        b=XtoJye9hr72QSX6LyIEW0LGwK2pB8zb1sqGFubzJ5EzjJ8c2LBdSOktVLglmmMOXNE
         i0azzJYeVKQDtnvaRxJvBBhtMbCJMmuyp9Wa9ZIvCXbElGKg5jnJ4CoNILbSXnj4MyaE
         BNHdpP+GKLkjN6GoWh/ES7+VLiHJQ/arPblmK8Dx5/PhFsZ7Ir5ke2EFYQgdyCy4cJSk
         z1a6WTENXBEq4VAnGGLVN19Y9yAfBpWWTUDRjVRY8yhjEEe0CUGCTm7Ah/i7io6ydI8F
         sRHse9ZVuPDx1xBmwmZFFm0J5HuszVSpNPCuBQm7q7uCOzhFwaiLuNd3QzX09HdyTWob
         esRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=1Wa6X8AdL0KnTRBIO9JvG5gqYz06mbtzxWUnUnljK0c=;
        b=v2n+68l4pj5O8skokkliu8k4VxnqEY80WHezn2cG7l5coLxK+LDK35IrWhvCOUcxk2
         JZoW5MLKnQ6Zwnmf0iSrdaDrfYRYg6UmoJKC6tVTAEysp6mardOZIJmdjya95Lh+NzUV
         HjQ7HwqW+ANaxe9i+aWpBrb9TSZ4dU/Mn8iOOqbStIhFMR4flo2uGCADYNQ5gkFZw3Fd
         sXwUxdqZrrkMzJYC8Pcbg27hcKl4UyW3SySy3rf66KL+iJPWlBRp/dmuRyOgS2lUg8ms
         AMlRTey/Oqyv9/0L5L1or/eLADFVjWpFOH8WePF8dDOKdM4FDNWN6c13l7LPbmlv7Z+l
         muLw==
X-Gm-Message-State: AJIora/TttvynXvhPtR8jhv4jDwPQ64/CEcaxYFyhGmjN2eHUJ3aqBSC
        NQ0WwJZ3EJkHZROeKQwRDiIkOcpVbP1WzmqNykY=
X-Google-Smtp-Source: AGRyM1sG03MurMOmVm8U/99V3DbM5L0y5xcFTOL2aUdkZgr6vp/lnrV6g2X7wAVXKbQ6CjuqtdG/MivrWGLVLm5OFMo=
X-Received: by 2002:a05:600c:5129:b0:3a1:92e6:563e with SMTP id
 o41-20020a05600c512900b003a192e6563emr19743335wms.81.1658008034859; Sat, 16
 Jul 2022 14:47:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6020:ef26:b0:1f1:15f5:ae03 with HTTP; Sat, 16 Jul 2022
 14:47:14 -0700 (PDT)
Reply-To: susanneklatten201@gmail.com
From:   Susanne Klatten <hisakozlongshore7@gmail.com>
Date:   Sun, 17 Jul 2022 00:47:14 +0300
Message-ID: <CAEPpJ_B8jkzt5KgCmYY2X6usy_gzV1UEKR+C4qZfW_Jzi_PUxQ@mail.gmail.com>
Subject: RE
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,REPTO_419_FRAUD_GM_LOOSE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:344 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4992]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [susanneklatten201[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [hisakozlongshore7[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [hisakozlongshore7[at]gmail.com]
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
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,

  How are you doing today?

please did you receive my previous mail i sent to you?

Signature,
Executive Chairman
Susanne Klatten.
