Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC474E89CB
	for <lists+linux-iio@lfdr.de>; Sun, 27 Mar 2022 21:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbiC0TlI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Mar 2022 15:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiC0TlG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Mar 2022 15:41:06 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F7A165A5
        for <linux-iio@vger.kernel.org>; Sun, 27 Mar 2022 12:39:27 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id r13so24649000ejd.5
        for <linux-iio@vger.kernel.org>; Sun, 27 Mar 2022 12:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iLCEWNKLjmg1AhHJemsx++QgmaPxoo4gv7BxIKqV5Hs=;
        b=a24dnsPvixX34p/kdX3w8hA1C3FjwfVddHBBI/7f5jNQxbSlovO+DaQR5ZBHregcCq
         hktN4LTw6Hp1Vf4ObV3PXi0r5UjPMF4+P5eai9rKfJ/arCDSePRCJRG2OtAgyRmZK0N4
         n055NvzKSUbJ27D3xErSdigYklAKSYkUjXllbe/+k669WpgzRIrXiVpMNCK6hlb3PL0e
         hEJL4VLYjOiyRujqPu6GA6jokce7h4OQZ6nNAQu7gFFfTgXep+ROo2dzMfsEatpvcNju
         ozKG8UxUjFXrZzYnXmpxNMuj/L1Iiw4gNN5+MD/Lf237bjwtsmiPssdWkuRA1o0fquqY
         Sszg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iLCEWNKLjmg1AhHJemsx++QgmaPxoo4gv7BxIKqV5Hs=;
        b=xM/R6M+X8ZbdJ9c0TlrKL41RecPjGU4SDP4R89W5toeZGngQsGfJ196eOivWhkjrdj
         2Ereip/nyKqzz5vawRnl1HEfgAALexrJM3KGkbNxq4Mf094mHH8wOrhvCp2guUrjRKIr
         tJ5OOBiNMMhjNfmQG4diN6Ig+lxfLbKVtSaZWGTrPSTPB7LAP7WCwXB6uNQryQtopvFs
         MKKHrw9bwoBDxXjpapnTdIMcwy5rre1NRChkvNyNbthxTmDHdT9mcR61wQc8vLFTJOZ5
         VSXi1eoRiG/+fIAjL1bZw+FKFsXGPTub/cIvDHJL0/GuElOpLGijGXmpfn2J7mGNMxn1
         POvQ==
X-Gm-Message-State: AOAM532i/C26rDXzTxgPGscGAfwr6Duq3BF1y5kQTikjOQDi7GAocgva
        NEULMJhXS0U40plB8nnFKHMnc537i5tY8vVfQmZZGl2z/9w=
X-Google-Smtp-Source: ABdhPJzzXQAWs8KJsV19zlIjIZ5QvjKnunFsN/AWFWiFYULIABtG7YeZAKP/hsDlvb/dcCxhmkYz1jl8h50e2PX0GYI=
X-Received: by 2002:a17:906:4cc7:b0:6d0:7efb:49f with SMTP id
 q7-20020a1709064cc700b006d07efb049fmr23473328ejt.639.1648409965566; Sun, 27
 Mar 2022 12:39:25 -0700 (PDT)
MIME-Version: 1.0
References: <c75f0e1c683b6ad0333d5504fb00c6f1b14dd1bf.1648114531.git.lorenzo@kernel.org>
 <20220327153555.289eddf4@jic23-huawei>
In-Reply-To: <20220327153555.289eddf4@jic23-huawei>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 27 Mar 2022 22:38:49 +0300
Message-ID: <CAHp75VdpgB4xveRkmGAHEnYoEeiMUOL8J0NoovsXhuskwiwvtg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: updated Lorenzo's email address
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Mar 27, 2022 at 10:36 PM Jonathan Cameron <jic23@kernel.org> wrote:
> On Thu, 24 Mar 2022 12:05:43 +0100
> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>
> > Using my kernel.org email for iio devices.

> Applied.

I'm wondering all those email changes in the MAINTAINERS, are they
being accompanied with the .mailcap changes?
It would be good to have this done in order to decrease the amount of
(email) bounces.
OTOH dunno if get_maintainer.pl looks into .mailcap.

-- 
With Best Regards,
Andy Shevchenko
