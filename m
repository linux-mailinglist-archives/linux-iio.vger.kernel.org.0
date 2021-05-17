Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7482386C9C
	for <lists+linux-iio@lfdr.de>; Mon, 17 May 2021 23:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242966AbhEQVuf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 May 2021 17:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbhEQVuf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 May 2021 17:50:35 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2553AC061573
        for <linux-iio@vger.kernel.org>; Mon, 17 May 2021 14:49:18 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id e11so9028372ljn.13
        for <linux-iio@vger.kernel.org>; Mon, 17 May 2021 14:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XQR6C+OlywCeJLxPtozpKmJaDRB9K+Ets7Jiyl/FhpI=;
        b=P0Xd2RygZy20s2yz6HFsa1NJ/n3fT8BKx119d93rcrFzAiN5nXZPhmk10k/hIGaCYh
         Twt+b8rwWRYncKA1HVIl6uZsqUhK3N3ElZP8Pp56z8MDkKlAx0XfORFHuxxsIqjNzYZ5
         ONdqrtzpG2zyzZC5nHdSllz/L0P5j2xAI2SEg4tAdVsZJCXsT2EN8nCnxLi4I2puvSHY
         vBkmwlYTzkjuTKmWYjut3I+me33USfosNDCTrTRDuhuDUt3pISj222N83MPDEBl0BlFq
         3HpnsA6VTEZhvcD476YcpGcUbr2kyqUuvkG3g7I40p5UU55THfIGYBQr9YiBl/gS8NL5
         4L4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XQR6C+OlywCeJLxPtozpKmJaDRB9K+Ets7Jiyl/FhpI=;
        b=ec/nr7yrZuU70cEI+GIDsfxtMdEUhFFVNZevBHCEPoJ2cW0JUMiChQ0bVCWLUvLqPT
         Q0eH91pWOdXS7FF/0WiMo29rWUrzmWV4WI8u9u6YMznzCWiSI/ZisO/SYs9KmYXwY5zb
         RCZphTHSDAtH7M/1tX/XWFzIX0tcpZ73U310RWn25Ho+1Cg6XrzNJ8OcBQuKGF7mDeAp
         SzOYN4UcTrXq+bg50oLJbtEAAe399BAyNzzzGEzbwmDXymu02IHzesDUJYKSkM42c3eu
         xm0sJtcFtX3Wu49AcXSB/gG4Kyi2WJeRz5CJqF47kHV+hLATTz6XFAMeONpOgbj8/w1/
         5Q0Q==
X-Gm-Message-State: AOAM531DooDQZ3RTA/NSr4M4/+rFd+yQH0UKfgrRc5KhYlzhcnJLU89B
        vCDAUtaXRu3Kn6b4FRNvYKGe0VMvvGX7cktpOb5YYw==
X-Google-Smtp-Source: ABdhPJwR8njmrFn4YuxRXDBTz9vfQYm2PFI2G+UMsLK9O0bwE1wKxhFeR9T0H3e3XjvlNl2/0U5mF9u6l6Ol6u4CycE=
X-Received: by 2002:a05:651c:4c6:: with SMTP id e6mr1174830lji.326.1621288156687;
 Mon, 17 May 2021 14:49:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210509113354.660190-1-jic23@kernel.org> <20210509113354.660190-12-jic23@kernel.org>
In-Reply-To: <20210509113354.660190-12-jic23@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 17 May 2021 23:49:05 +0200
Message-ID: <CACRpkdZ_FBryJvGfTq1zJordVad11Ac8jnXMAUupVjf5_yOQ7w@mail.gmail.com>
Subject: Re: [PATCH 11/28] iio: magn: bmc150: Balance runtime pm + use pm_runtime_resume_and_get()
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, May 9, 2021 at 1:37 PM Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> probe() error paths after runtime pm is enabled, should disable it.
> remove() should not call pm_runtime_put_noidle() as there is no
> matching get() to have raised the reference count.  This case
> has no affect a the runtime pm core protects against going negative.
>
> Whilst here use pm_runtime_resume_and_get() to tidy things up a little.
> coccicheck script didn't get this one due to complex code structure so
> found by inspection.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
