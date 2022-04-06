Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823AC4F6AFA
	for <lists+linux-iio@lfdr.de>; Wed,  6 Apr 2022 22:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234051AbiDFUOe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 6 Apr 2022 16:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235547AbiDFUNY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 6 Apr 2022 16:13:24 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDAA1DF66A
        for <linux-iio@vger.kernel.org>; Wed,  6 Apr 2022 10:14:02 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-ddfa38f1c1so3587628fac.11
        for <linux-iio@vger.kernel.org>; Wed, 06 Apr 2022 10:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=2yxIHdSniEBfLfiIcgeVHAibkiH/0T+8iYozr27DbcY=;
        b=DIDZJozu6kfJB/vlpeMZEHmCp2KoYk2TnctteVe5VjssokFpexrrLukTsFlmTgeEX0
         YdqFxuGoCocE6JJGCiVRCm7Mcc+rkBPCq69TclWm9VxhFETtltg9EnZ1WY4C29+VUObg
         /SO9xkY2849lc9evDh4CDH3ZL03JyjDT87yyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=2yxIHdSniEBfLfiIcgeVHAibkiH/0T+8iYozr27DbcY=;
        b=OQUDOhEady8jfyVz3qbjtarVH6LMVBryoWA8Lcmri537Sk2Iw7nErxNl2t4fEjkjwq
         xsO7Mo0tV3fp1kRGLO6QupvavVxrCHVRl6w7sWTONgtwk/7sUdN/SkWscMt7V09SURWS
         oGRw8xpgdgB8S66oIfRIR1Q6jjGE3fogWAugMvumwP74UrmVfmqAcOvlOVjCy5+AE73B
         SrQgYXQzDxbf4Wb6pFpkPItahYJT4wWe1rnfddfTtpJ03GONXasH7UgF7tu5AkLhPQnh
         04lPP1sDk0690DkAXiB+xooVBLrBStQK551UmVBhpo5zYKsGuSK1FlM0f49JhNbmoQ/I
         I6EQ==
X-Gm-Message-State: AOAM532R+eLBcZ6+RPbbxB3AoLJUdpVG0vA9Uwjpa8wMgr1TaAz0yzrK
        tL5LqFym06dEJztNMu0I/bb/4AGGTR2PE2mHTWp9vA==
X-Google-Smtp-Source: ABdhPJzza78cOie+/jWrIh6BHMqq0rRkvnFS14aj9FFqa1rBdt8zhxHRvhWUZMbJt9Kz0Wuf7nyK8/iZfAOrN782P50=
X-Received: by 2002:a05:6870:558e:b0:e1:db7c:26aa with SMTP id
 n14-20020a056870558e00b000e1db7c26aamr4434923oao.63.1649265242083; Wed, 06
 Apr 2022 10:14:02 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 6 Apr 2022 10:14:01 -0700
MIME-Version: 1.0
In-Reply-To: <20220406165011.10202-2-gwendal@chromium.org>
References: <20220406165011.10202-1-gwendal@chromium.org> <20220406165011.10202-2-gwendal@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 6 Apr 2022 10:14:01 -0700
Message-ID: <CAE-0n532f37UD8OyiFc0_ROzgc24Hb=aOYN+ALgruiehiNTfuQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/8] iio: sx9324: Fix default precharge internal
 resistance register
To:     Gwendal Grignou <gwendal@chromium.org>, jic23@kernel.org,
        robh+dt@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Gwendal Grignou (2022-04-06 09:50:04)
> Fix the default value for the register that set the resistance:
> it has to be 0x10 per datasheet.
>
> Fixes: 4c18a890dff8d ("iio:proximity:sx9324: Add SX9324 support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
