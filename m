Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 045CC1CF419
	for <lists+linux-iio@lfdr.de>; Tue, 12 May 2020 14:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729382AbgELMRE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 12 May 2020 08:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726891AbgELMRD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 12 May 2020 08:17:03 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B238C061A0E
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2020 05:17:02 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id u4so10359342lfm.7
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2020 05:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AHRgMLmA3AvBWPfR6NKWwxmRE4rkD36q1pi3BiamBuk=;
        b=zawdNdom/gNdPx47D4yLAoF6P7G0lSQgL3HWoaTE5pIWlvLTLXvSgmJEAGLFAG5VGb
         /G7eaYc6og9aU4x4M7FTxm81UsoCa/45aiA5gY4tGQ2nVbaTMFmxcXsBl/dejya1fspB
         vuywN7waQfGB/WfPQNp9AS0c8Tc7UP5ZRUi0fdRxxFlktSSVW9rccOOp2fxxlHUfQf5D
         nEBX/9KNhiLH7lvfPT1ZjdrrfBc5k88EY57RUm+E8RKZ36irVE8C+CnyzGAJd56EWpX/
         jE8zVu3h1jj2JT28gOJMBYBIh8b5mcGCW6IcPVx93BDudEuaAtSIbnMBWyTet65NItej
         Gh0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AHRgMLmA3AvBWPfR6NKWwxmRE4rkD36q1pi3BiamBuk=;
        b=jTJEAk1flTKiQaO7Y691tjnxCG9Bv6PnByb2YBKTEyqCWrItKJuV6+l1Ry6EOHqa2e
         dIRn8jLWQmhiTodTfN+5V0IPe9e6t4wQKKnxvYu6lH7hxeZCyad6Fukf1KGeyrlSjwsr
         rP5/XIX8YXpC41qgRodhobl63jsEquzv/N3MKA9qL6M318sMpvErGN8bnln5F/RU6DN9
         4hdcohwtT7x1KeH4b/I9kU1ykLfg/FURp4mikuIGPEwJki3/5HQTJuGsWUaoccBzUN/S
         01pJhNr44raHoCTCOLKlCfFdXIM97/7xGq8LnWeD5u8N6fdx54i7lvedZ7BU/dT59R83
         AC6w==
X-Gm-Message-State: AOAM530DLrb3w93TqGXxi+pJwb834myQasZ4MWHSHQNC8xZoCXq+zV6E
        c4XmukH4q3pz4GoXawhRoRmylNQsK38Yt4oe/sqMSQ==
X-Google-Smtp-Source: ABdhPJznRAGEou4bDAZ+Qk/iOY8Hj6nqKR5DclT1eBmeTxgT/t1dvz+w7MKesU2FRotY9nN6kN31SK96tUzVsopvN4M=
X-Received: by 2002:ac2:5588:: with SMTP id v8mr14010972lfg.217.1589285820682;
 Tue, 12 May 2020 05:17:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200430143019.1704-1-brgl@bgdev.pl> <20200430143019.1704-3-brgl@bgdev.pl>
In-Reply-To: <20200430143019.1704-3-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 12 May 2020 14:16:49 +0200
Message-ID: <CACRpkdbzyMY2uOZ4woKyv0otYyO9fK7zSsBaYHtCB6Z+Xtm7Mg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] irq/irq_sim: simplify the API
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
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Apr 30, 2020 at 4:30 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> The interrupt simulator API exposes a lot of custom data structures and
> functions and doesn't reuse the interfaces already exposed by the irq
> subsystem. This patch tries to address it.
>
> We hide all the simulator-related data structures from users and instead
> rely on the well-known irq domain. When creating the interrupt simulator
> the user receives a pointer to a newly created irq_domain and can use it
> to create mappings for simulated interrupts.
>
> It is also possible to pass a handle to fwnode when creating the simulator
> domain and retrieve it using irq_find_matching_fwnode().
>
> The irq_sim_fire() function now only takes the virtual interrupt number
> as argument - there's no need anymore to pass it any data structure linked
> to the simulator.
>
> We modify the two modules that use the simulator at the same time as
> adding these changes in order to reduce the intermediate bloat that would
> result when trying to migrate the drivers in separate patches.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> #for IIO

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
