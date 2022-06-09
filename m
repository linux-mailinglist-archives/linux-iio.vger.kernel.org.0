Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1F0544687
	for <lists+linux-iio@lfdr.de>; Thu,  9 Jun 2022 10:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242115AbiFIIvp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 Jun 2022 04:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242103AbiFIIvQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 Jun 2022 04:51:16 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B184C429
        for <linux-iio@vger.kernel.org>; Thu,  9 Jun 2022 01:50:57 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id g201so12809633ybf.12
        for <linux-iio@vger.kernel.org>; Thu, 09 Jun 2022 01:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CDMGnU/5QuisJhku5mR9LWhJd7uvk2ybw9nJB94v05A=;
        b=dpOPL9sHNWa8TVOJPyi/p5NNyuKJtsDmFGUp84aW3j1XKEGP6YMUeInce5E0ocSV0V
         ybhO0qyomunjRd3UjjDsCqamQifMI7mhi77aa22tCYUeP34cnUn+hsWpAQQY6d7IzaU6
         CGD2f+i9YgUo9WX3lng98332cqygBA6+BVXCIliCifHejM+Zesfy8ebGBuOrcTHRzDGo
         8q8CVJVmqUZi1KfJpFaSywTmct968RPomQlj8LrsN9wywPeDS+AZdZW47IqHRc2vUDYy
         bPnTLTRg130b7BD0uaUF4k9RN01z193Jnt6edLtHYAfHJwlCeLQ+mPXsR5a581ghprn6
         PsjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CDMGnU/5QuisJhku5mR9LWhJd7uvk2ybw9nJB94v05A=;
        b=5rTUUakDVodSDQa21/qnBmr0Fl56cK1XMLeya8IsXl36mdWq1HIaZX7xmBxfH8G4Yh
         r0AaQc3vqftTuWA3y2QWi0nQkf9Pnk1nMaAmkQCtv4S3pzb38gBMX2o0ckxhOgvp5fM6
         c101tMKtu1wexfz8MLlggrOeNavnkHqK8xwX1IwB3/5qhVqp5UXWv9/l2KiWrCkwn8E/
         xK7wFfCfm4NnMLcxuIOQhx2PZEyTeU6T4ZkbDwWyv8CN3mnLxZGY+dBC1dxPADGDYOXL
         lpKYtq85lzyanrL7jEH+Q6nvmtJtQpn+CdQcjNEsWWF6Lzyw06dS4Y1mNUgrfWZQ6aTZ
         yWhQ==
X-Gm-Message-State: AOAM532yEfQ541NDSnfLqkhKTC1ijRHWMH4WOAAIkuq6Kc/W9pefkET1
        DxoB2qo4CoUZgOT8qTmdJAEFxeTdvqnEbM9U3+MHhVKjNaU=
X-Google-Smtp-Source: ABdhPJzRcUEcD1jJVh9AkIq3EqlZt60G5uOjCVMy1Mw4sELrG5G4EEQ2xCVv9140uiuZu2W9oTPaewYvWloZ2MQIAZ4=
X-Received: by 2002:a25:b686:0:b0:664:2b6:8e13 with SMTP id
 s6-20020a25b686000000b0066402b68e13mr6732352ybj.533.1654764657132; Thu, 09
 Jun 2022 01:50:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1654727058.git.jahau@rocketmail.com> <719fc290550c40ccb75b1444917b91f69619806b.1654727058.git.jahau@rocketmail.com>
In-Reply-To: <719fc290550c40ccb75b1444917b91f69619806b.1654727058.git.jahau@rocketmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 9 Jun 2022 10:50:45 +0200
Message-ID: <CACRpkdYmkk2pQT8rFeW77V-JMwknE8ejD+uU+mx8Bxo6zu4G0w@mail.gmail.com>
Subject: Re: [PATCH 1/7] iio: magnetometer: yas530: Change range of data in
 volatile register
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jun 9, 2022 at 1:38 AM Jakob Hauser <jahau@rocketmail.com> wrote:

> In function yas5xx_volatile_reg(), the range for measure data should end at
> "YAS5XX_MEASURE_DATA + 7" instead of "+ 8" as we count from 0 to 7 here.
>
> This change is of low importance as the "+ 8" register isn't called.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
