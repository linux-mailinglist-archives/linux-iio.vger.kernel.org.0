Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77C58352F77
	for <lists+linux-iio@lfdr.de>; Fri,  2 Apr 2021 21:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbhDBTAi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 2 Apr 2021 15:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhDBTAh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 2 Apr 2021 15:00:37 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9756C0613E6
        for <linux-iio@vger.kernel.org>; Fri,  2 Apr 2021 12:00:34 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id il9-20020a17090b1649b0290114bcb0d6c2so5000422pjb.0
        for <linux-iio@vger.kernel.org>; Fri, 02 Apr 2021 12:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hQX9o8ML0wGM+JfJktWXQEeIjsxrgu/bia9xAXZC7Bk=;
        b=CcVhdP3jtU/RYgPX85PZpA9PgVHbiJJOBSf1jhB6ZCB5eNAlG1KzCg7oAewinOn0aU
         tVcgYyaPb1BF/4RRAWr/+5n/sp1v3J5wh6qdPcNHut/Ucn3JPvt0Nbzz6yx81Hrbqmtg
         r8qtXUJKQbUrPH7OpCZDOpnaCamfyJ2jd+rHxR4I12zFx85Z+N9WoxaVhvMy9ZI1dV75
         LT3c2lFnP3AEjFP9NcBDavc+kb6IN2XH88ihxRarXWCbtZNoklTjthhlSuu7gHRYcVwW
         DZuRJcRypTU+b0OwJ++t1cXRaxOELF1t7xMKoXE6sZL7OmMGrH9zLzHWEPIyHmQxxMHE
         Lf7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hQX9o8ML0wGM+JfJktWXQEeIjsxrgu/bia9xAXZC7Bk=;
        b=emNzefPFAMa4ZC1uR2sHWwT+0axxtnfM1JGM4YFMAZ1jIoMu4SMxl9dBJ41ma5OKCn
         mdMqQ4aM3K7GVBVJDUWDiMoPI8kNv4Bpv6yBM5iVJaNMjTiYcUFtA3iEFZKiH/b9c9x3
         mqbsVlo8aik/VpzRaqsVMf+vKLaX0o05rGCedDwxxKb8x2tiqfuNj1H4jcwnojuOA7js
         BIfIYlh+9PbVdx+U2lKtx8A3VMqsa/a9nT6b0VgBzihiJA2sBVlSeUi1U+FVgzDVtAZe
         lrxDYapkrE78iWKVjh4Mv6Z8zOHrxSfXOPDrLI7LG6MI7bpWq+SAjDrBs/HXGugkMfE6
         0jgQ==
X-Gm-Message-State: AOAM533dU013iExM0ELQ5z5o3TJy4u+dewk277qvxUle1J/bbPNO0xky
        u8HM8Tuel2yxqXMmhdqC0A+Kvzo7SGgKg2u5Xjc=
X-Google-Smtp-Source: ABdhPJxzU2GivIqWg1j1c5y55NRxMykvtP49jzWNXu5gS601K39WPPTDeFRbQ4nxZXd1XB5RcyIsW5cptAoc6Dgs8Ak=
X-Received: by 2002:a17:90a:db49:: with SMTP id u9mr15568737pjx.181.1617390033723;
 Fri, 02 Apr 2021 12:00:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210402184544.488862-1-jic23@kernel.org>
In-Reply-To: <20210402184544.488862-1-jic23@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 2 Apr 2021 22:00:17 +0300
Message-ID: <CAHp75VcG7OQy-vmsOLXpamrkT_LBP6RoXRJ_vkCmxwG6eRS8DQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] iio: Use IRQF_NO_AUTOEN
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Apr 2, 2021 at 9:48 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> This series is dependant on
> cbe16f35bee68 ("genirq: Add IRQF_NO_AUTOEN for request_irq/nmi()")
> which is available in an immutable tag in the tip tree.
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/tag/?h=irq-no-autoen-2021-03-25
> which I'll merge in to the IIO tree if we need it before it's available
> upstream.
>
> That patch introduces a new IRQF_NO_AUTOEN flag for irq requests to avoid
> the current dance where we either mark an irq as not to be autoenabled before
> we know if we can actually request it succesfully, or (as IIO drivers seem to

successfully

> have gone with) we disable the interrupt just after requesting it.
> In short the flag stops the interrupt being autoenabled in the first place.
>
> So this series applies this magic to IIO :)
>
> Note these are all just compile tested and some of them aren't entirely
> trivial because of other aspects of the irq flag handling.

I have looked at them and indeed in all cases it's clearer now what is going on.
FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Jonathan Cameron (7):
>   iio:adc:ad7766: Use new IRQF_NO_AUTOEN to reduce boilerplate
>   iio:adc:exynos-adc: Use new IRQF_NO_AUTOEN flag rather than separate
>     irq_disable()
>   iio:adc:nau7802: Use IRQF_NO_AUTOEN instead of request then disable
>   iio:adc:sun4i-gpadc: Use new IRQF_NO_AUTOEN flag instead of request
>     then disable
>   iio:chemical:scd30: Use IRQF_NO_AUTOEN to avoid irq request then
>     disable
>   iio:imu:adis: Use IRQF_NO_AUTOEN instead of irq request then disable
>   iio:adc:ad_sigma_delta: Use IRQF_NO_AUTOEN rather than request and
>     disable
>
>  drivers/iio/adc/ad7766.c          | 15 +++++++--------
>  drivers/iio/adc/ad_sigma_delta.c  |  7 ++-----
>  drivers/iio/adc/exynos_adc.c      |  4 ++--
>  drivers/iio/adc/nau7802.c         |  6 +++---
>  drivers/iio/adc/sun4i-gpadc-iio.c |  4 ++--
>  drivers/iio/chemical/scd30_core.c | 16 ++++++++--------
>  drivers/iio/imu/adis16460.c       |  4 ++--
>  drivers/iio/imu/adis16475.c       |  5 +++--
>  drivers/iio/imu/adis_trigger.c    | 11 ++++++-----
>  9 files changed, 35 insertions(+), 37 deletions(-)
>
> --
> 2.31.1
>


-- 
With Best Regards,
Andy Shevchenko
