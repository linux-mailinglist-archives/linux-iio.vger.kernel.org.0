Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 451D045DF5B
	for <lists+linux-iio@lfdr.de>; Thu, 25 Nov 2021 18:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbhKYRKK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 25 Nov 2021 12:10:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242492AbhKYRIJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 25 Nov 2021 12:08:09 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530D3C061371
        for <linux-iio@vger.kernel.org>; Thu, 25 Nov 2021 08:57:12 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id 47-20020a9d0332000000b005798ac20d72so10270150otv.9
        for <linux-iio@vger.kernel.org>; Thu, 25 Nov 2021 08:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d/MKsi0UT9fEDSNAYACI6GQbp1DFoYRScCU+tMfqG3g=;
        b=xpTE+ZTUPeszq7MEHeesfd11YulmdOwwwDGtUbWmecCGsNYlRpzg8Z63MsgDRAOQgv
         TKayFFlmb3bo2jjkceGy1Jbed8dhrmK8W0cz7fNa+H4tWIOrlrirxG5CN4cIK4GiQJ7i
         o7BOEMbqYEqa+0v00+JzR0nXMrZlwpX2rzgnoD9DSTGiKXB+nmLgfVR9k4hHrprcqirO
         Bk8nmRTi510+juTG1a6k1LxW7UpAa7srVS8wv60o29zoZNKTPFBFfYbu7S2bv+FpEV/j
         O+7qdKY1owLniZrqjUNhDk7p41va8fj2PYGd5Qm2wBTPYp+Kbs9OwHCfmCQlkhaKC771
         T4Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d/MKsi0UT9fEDSNAYACI6GQbp1DFoYRScCU+tMfqG3g=;
        b=UJ4TVCflIc2XhuqTCfIUGefdi1vQRWs+8BZANMtsVXfSFgUf09Rse0B36JocqU/bAs
         E7DE62RHUBKwl+qboFgIhwAXUCeXHijx2edJgbUgtZLa9K/KaabeCVj1sPEgGOHdQVG8
         mkiRS+BfD1hszbINXZ4R5QaMkBs0DiTnlbtGDu7jaEdo5vOc0wUC5fYbI+i2Xjo5TjHx
         vNEF8fGwLtieQlMyOHeDWM4M0xZMOxMbuKGqwzrxbziVMiB5DOiAZMdUbbVhn9JyT0K4
         W+oMm0EYZzPYs7bHiyGIZQXdlUWQW8kYuG/zPrB6vAbDbkWrFAHqkQb/VDLQ1WQOaCK4
         LgiA==
X-Gm-Message-State: AOAM53278eTJArLqQbN+5WH6kU9YHF+gs1NaQEx7tIXTYIemp6dcfwRj
        JlOdcqzH7/Y7g4fCc7IOhV1yr9lFr5YJzCyYAqwyKg==
X-Google-Smtp-Source: ABdhPJx4z5S2QI0cmD7RSX5bQjy0V2BoB4NNmasYM7AHQtZ6NzK83ciK4VmVJFRDN2ZTHRRJsiXrhaOOKo6NW/XmxbE=
X-Received: by 2002:a9d:a42:: with SMTP id 60mr23396416otg.179.1637859431688;
 Thu, 25 Nov 2021 08:57:11 -0800 (PST)
MIME-Version: 1.0
References: <20211123211019.2271440-1-jic23@kernel.org> <20211123211019.2271440-49-jic23@kernel.org>
In-Reply-To: <20211123211019.2271440-49-jic23@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 25 Nov 2021 17:56:59 +0100
Message-ID: <CACRpkdb7ZHmrcknNzoydALMjVOR0yCAA_Mjo6K3T0uh0GeqSBA@mail.gmail.com>
Subject: Re: [PATCH 48/49] iio:gyro:mpu3050: Switch from CONFIG_PM guards to
 pm_ptr() / __maybe_unused
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Nov 23, 2021 at 10:07 PM Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Letting the compiler remove these functions when the kernel is built
> without CONFIG_PM support is simpler and less error prone than the
> use of #ifdef based config guards.
>
> Removing instances of this approach from IIO also stops them being
> copied into new drivers.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
