Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3AB629121
	for <lists+linux-iio@lfdr.de>; Tue, 15 Nov 2022 05:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbiKOENf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Nov 2022 23:13:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbiKOENe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Nov 2022 23:13:34 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170EB5F93
        for <linux-iio@vger.kernel.org>; Mon, 14 Nov 2022 20:13:33 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id m22so33112615eji.10
        for <linux-iio@vger.kernel.org>; Mon, 14 Nov 2022 20:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qyAC9pGA3bM4rM543zM+YmJ53hSTj7w0+tIgvP3ytYE=;
        b=GLj22QVZZqf1Y156NoErCBFBu7DGNVZDMclTD8PabJqnr4RTZokkf3GFRfpd/pe3xo
         whet4nCz8sYc0r3tCpXoNw1yb0JgFaINBg/bBArRWol9+Xa+FPh4ofQnsaPPQjDWaO11
         9PC9m5XX6gJ7A+/YiQLK/rCek2Ufx0bOkSj/zikwys7sUas63cwF7dTNZB+jkN5VkoMF
         0bizxE0ggt6kh+Eye19C3Lum5H5kkLyufgZqt58/ZrizARkwPKWO/OuqmxfRutLslcT1
         w9asOJlyuYU//6RYhzXOKGpiOPhTclatMIlJVdPoblo+UdRWupyacqFqMimUu3QZajVd
         KYfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qyAC9pGA3bM4rM543zM+YmJ53hSTj7w0+tIgvP3ytYE=;
        b=U5ZS44GU82O3vM7FUgzHQSv16AP3X3KdCJK8lDUyCAL0TQhjxAOvp3GI954oMFlH3j
         J/fPe7fYIHEN81Nvq2Dqtu7MW+KeSoLwV8zwAwmpU6IiV71+1K1barfgEVno7iRRy3s9
         A3Yo+qPk+A5P4Vj1Aga4N1hL/FsCmBCYWcF2kCtJIt7STqGXYkFuP8GNGwxxVOm36AH6
         uLRmlMbk5mRnhrwrJxPaMK1WBeAi9RuS8A3j1WMivIXxHfvSqzotiGF1qJFcg5yFo9Ac
         30Z8Z8cbEr+R3HBjUKFOkZBi/KHYI7Dy3AG8utGCcXUGdhX13Qm8BEhcsBLdan8aa9hJ
         ZE9w==
X-Gm-Message-State: ANoB5plkzdc6vnAVQn+wQ9pA12jwCynWGndvQditV1BVqjTtBLBBSVBX
        Dq1XUbjV9OfCH/HXNDcD4wm8wfjTNdB3Pyo7i+gOBp3/cQk=
X-Google-Smtp-Source: AA0mqf6uaVKsi/54W2jA8fovwcm2ziFCIXdjnccg+WQydSlmazICK5oXWIn7QpZ3QQgdJ6Wx7yHIMaXoxD4V1K8UDJk=
X-Received: by 2002:a17:906:814:b0:78e:ebd:bf96 with SMTP id
 e20-20020a170906081400b0078e0ebdbf96mr12463164ejd.625.1668485611363; Mon, 14
 Nov 2022 20:13:31 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a98:9343:0:b0:18c:e34a:8f66 with HTTP; Mon, 14 Nov 2022
 20:13:30 -0800 (PST)
Reply-To: abrahamamesse@outlook.com
From:   Abraham Amesse <gmaaassss20@gmail.com>
Date:   Tue, 15 Nov 2022 04:13:30 +0000
Message-ID: <CAM016Q-uwkPNXWcEFzqPuEL-+UD=z7=TN_DWxm20kKt8S4zjyw@mail.gmail.com>
Subject: ///////'//////////Ugrent
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:62e listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5002]
        *  1.0 HK_RANDOM_FROM From username looks random
        *  1.0 HK_RANDOM_ENVFROM Envelope sender username looks random
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [gmaaassss20[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [gmaaassss20[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

I am contacting you again further to my previous email which you never
responded to. Please confirm to me if you are still using this email
address. However, I apologize for any inconvenience.
