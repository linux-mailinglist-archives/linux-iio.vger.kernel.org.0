Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7241CF415
	for <lists+linux-iio@lfdr.de>; Tue, 12 May 2020 14:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729243AbgELMPy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 12 May 2020 08:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbgELMPy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 12 May 2020 08:15:54 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1562BC061A0E
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2020 05:15:54 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id l19so13382195lje.10
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2020 05:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ccKOdwRe3iqeZSagNuE5XkunpZg3mt6JpF6qvoS7Ef8=;
        b=g1XpMo8TF7t4f6zVYEweNwAI8Xk50lfP6d27IehOWdIvNoMqK6nyLV8t08ANmCaD4+
         pvDi6YDCBzNKq89VZ1U8vtV0q4tHTotYLCtJQp4Y28cBgTLCrSNOdJLdqszeZEgE1eCf
         LpqcMPXgpK93bH4dQ7OooyRkrQ4W3Qzu3FZNMue7Agpms7aFaqAWXLM59S0R5TW3lOUX
         TB3UavKDUp03/Ze1R6KSY/BZXuDlLddJWmQcVU682QXLHTuLc1K3Yn9ZP1oZZ2BBuC/V
         diBSq9EYcTzYLccxhU+/sQ4v5oy3HY2xJnHXGMKGzbflqu8te/RW8NrsZr9DEj0ZyKLv
         mczQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ccKOdwRe3iqeZSagNuE5XkunpZg3mt6JpF6qvoS7Ef8=;
        b=dsJ/50bDHJyl1LPsqCiumdBrimlLeOHeV12J6Vip3UTPvWsdX/EjG/2Z2A0cjXt+T3
         9/HfaVAbnKLvmhYB/ewprHhvqGCcC8xUQgscP9fYIGCVNlzx1IVm6hIqdLzelLdq3YPJ
         WsHpd5yXtxzRG2Ym/fctci+vg9LHqZg6Cvt4LPgXsXeYyEbOydCo5ReCOgk8b+0v3K9S
         CLLKKTOXRebNWFGzb4sQf/pNXcR2PE2NCps92Ucvsg8qibfgb7vDzN+smmMt4k/ZNo0/
         68yb1WeiDtQAIcVqtiU1lIEdELoEVgVfpgl1tmQi5f1u0CTt9ZF67kiRnWWJon/GaW21
         dteg==
X-Gm-Message-State: AOAM531DCcQe4kgRCSlRQ7MH6P8YTzZaqNSWVujgAnUhImh0bCz283Su
        AsEJ2vyULjwgGUHwVt9Z8CPqolktM3yUN7X3zwJMgg==
X-Google-Smtp-Source: ABdhPJzzFcmf7nPjGcBG/Cdu0kwKO+w/24JLBkomICqKKfEEx8rLHtcWxInOvM6+OmT2C66Q9tBx42aLEAhCRR1J9qc=
X-Received: by 2002:a2e:b6cf:: with SMTP id m15mr13019356ljo.168.1589285752348;
 Tue, 12 May 2020 05:15:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200430143019.1704-1-brgl@bgdev.pl> <20200430143019.1704-2-brgl@bgdev.pl>
In-Reply-To: <20200430143019.1704-2-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 12 May 2020 14:15:41 +0200
Message-ID: <CACRpkdb3LkeMKjg3Kh2YwCiJkBQy5X2v4eShb0WG9PivGLizzQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] irq: make irq_domain_reset_irq_data() available
 even for non-V2 users
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Apr 30, 2020 at 4:30 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> irq_domain_reset_irq_data() doesn't modify the parent data, so it can be
> made available even if irq domain hierarchy is not being built. We'll
> subsequently use it in irq_sim code.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Makes sense to me.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
