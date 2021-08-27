Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51B943FA186
	for <lists+linux-iio@lfdr.de>; Sat, 28 Aug 2021 00:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbhH0Wdj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 27 Aug 2021 18:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbhH0Wdi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 Aug 2021 18:33:38 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9893C0613D9
        for <linux-iio@vger.kernel.org>; Fri, 27 Aug 2021 15:32:48 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id c12so14021083ljr.5
        for <linux-iio@vger.kernel.org>; Fri, 27 Aug 2021 15:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X+9FDw9/QHU2Wo0eFuG7huo1QGMU+3uWfi8hED0MPa4=;
        b=Qo0VtEQt9lZ/c4e4HiAlFNwq9xr+tQMoyt3Wt7RQdgGwL6HgKUf67dATllg2noTt43
         ebC3SuIY1bxw7zwtpsh0PwaKUvUNKNrS1E1lcuTZih1hnrP9JNGmh9U1oWei2OKqIYFS
         ThVca1wMlnWwYP8VcFrWdXuS1iaPSbx6mtmD56wsTVuH8qmUo65InU8ka+YolKM3eSEO
         Apv02vDyTjmJDoKoJVMR792nF69SeO2wJj7g+/twoAfIf8PmoGQCujgvOOjTo5xijnxv
         TlL9dvx7wo4NwuhnJutyvv3B2ttUKY3nVbAczzV5SjgPWNxj0BMVu507Bu9dkLTN9fEb
         h1SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X+9FDw9/QHU2Wo0eFuG7huo1QGMU+3uWfi8hED0MPa4=;
        b=t0BruJO3rQJGm4YNT/Ia4b0iO6yIsxQEB205UlvxLb+HMuzDtAfO9jbAEIJ79qgd0s
         ERh9ulLQ+SuXf/U1wsnq21VjvjAuxhMWHxa5U/pOyRXJ0P2tSlXMub4mCdpAgxQCiX29
         PZUl6zMcIvcx9x9gX7YrNH19LJ39vFnaBmmLJWiX5C8hRrCFs795RrFObkLS1OSK4IYN
         +FFzZN3Ap894GK0wShjwAcL66WHHxzWmgb8cLKVeHjHpbQMlwGMGdRrnpgvkVrLl59su
         OeSEu7AfChsJXHUEDNlIE8cnSStsFx3PydRVIAkhUGCOeIaJidFq1rG2Yl8zK24fvjf6
         VtuQ==
X-Gm-Message-State: AOAM530f6dhw0YH/BBZUzgADeuMuO+PfsjQi+pad9bJi9Q8GJlNFB2W9
        7w/QzvO9DNwHPuYRipH9cmZDI0mNXe+9oj9FRwKAQQ==
X-Google-Smtp-Source: ABdhPJw46DrzRYYB5g0PAK5nKm45fNvdCMqobT6783q1X9zEgrOyWSNtHtBiY+lX4PQM2zxUc0deGo6RdtGGOb5ANXU=
X-Received: by 2002:a05:651c:4c7:: with SMTP id e7mr4392319lji.438.1630103567258;
 Fri, 27 Aug 2021 15:32:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210823112204.243255-1-aardelean@deviqon.com> <20210823112204.243255-4-aardelean@deviqon.com>
In-Reply-To: <20210823112204.243255-4-aardelean@deviqon.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 28 Aug 2021 00:32:36 +0200
Message-ID: <CACRpkdZRRODGR57U2308QMCf6pCoNNWRXxc0YWHW14+CX-a0Jw@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] iio: st_sensors: remove st_sensors_power_disable() function
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Denis CIOCCA <denis.ciocca@st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Aug 23, 2021 at 1:22 PM Alexandru Ardelean
<aardelean@deviqon.com> wrote:

> This change converts the st_sensors_power_enable() function to use
> devm_add_action_or_reset() handlers to register regulator_disable hooks for
> when the drivers get unloaded.
>
> The parent device of the IIO device object is used. This is based on the
> assumption that all other devm_ calls in the ST sensors use this reference.
>
> This makes the st_sensors_power_disable() un-needed.
> Removing this also changes unload order a bit, as all ST drivers would call
> st_sensors_power_disable() first and iio_device_unregister() after that.
>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

We should at some point add proper runtime PM to the ST sensors
(cf drivers/iio/gyro/mpu3050-core.c) but that can certainly be built
on top of this patch.

Yours,
Linus Walleij
