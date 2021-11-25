Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4B145DF50
	for <lists+linux-iio@lfdr.de>; Thu, 25 Nov 2021 18:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237227AbhKYRGL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 25 Nov 2021 12:06:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240862AbhKYREK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 25 Nov 2021 12:04:10 -0500
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43E9C061784
        for <linux-iio@vger.kernel.org>; Thu, 25 Nov 2021 08:56:32 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id m37-20020a4a9528000000b002b83955f771so2239522ooi.7
        for <linux-iio@vger.kernel.org>; Thu, 25 Nov 2021 08:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3i1v7Qdr36LiuinZGWZtMoRxDTA/JGAsTQ6soRNZn3A=;
        b=vYFUeLT1RDPIDIp82NPCwI6MmQoo0ETx5eKBdVqQ3cRGftZRIYsjnkxb/r8jTySo4g
         LGpaqJLUSIimf+HOZIaAI1gy2Hgsceo3yWua8UiXxIzsdVEGVQFVCeBWtdDaGdutgEF/
         /c63ntGCOLVkh1gevDYILny6IU2NHJE9V4jLb2bzdTmezyyBDRPM3tOfblOflG7msBDl
         g/9I9eo7dcMndUkklLTAR1ZWt1NNDFzIrVd5oz5hQDybhxOL7EEba3CNQGrxqxk7Qk74
         cWedUmyRtWCY6sMOcblWLVSxQ8hk4grRWq57S+XONcvOiVCi8tLarsTWoCgeBZmvvnjV
         QTCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3i1v7Qdr36LiuinZGWZtMoRxDTA/JGAsTQ6soRNZn3A=;
        b=BMsnHyU+YB7yTnBDPeCCKdsRHgKabIZ0txgbCOPUdtswzjWyOBFqHJwbJWrB+HV8K1
         vVWtlKvg3taVqxciFdr2DG3Cqm2rdEbHpZ/HqttYO0MJnljhr99eRqOyLXdldBVFqLie
         8qWEeCp8njRt6JcfF0xhLBN0OuuE7ySZySBo92CHWVW9nFxnsl3lXua8lnDK1tRaCoyC
         dv1SCSwcGsaN/KITo8nazUKHm/1pkcH8DejZXEB14GtmoWmxc5GkakXU48XZRFImi5xe
         zsLk7PZt7VfFbxAuWwkJIV/JduVqRqSTV73/poMsy/P8BgCMaFWXUSZlnjaa2KWPvUis
         HYog==
X-Gm-Message-State: AOAM53025u9GBq/PRj+8ZkbC2xUP3E4yFAhHYfmH5Ro1wc/39ObyW3k7
        q5ghov9bY4Yv9i60Yl82zova5uH4leo/6HUNIFiefw==
X-Google-Smtp-Source: ABdhPJxtTd8C/wCa4oX7xO+tk+OF0RaLUJjEcX+J09PYt5stYHBJxaS4otFcZkrO+CUrDmnnnOECGwh4rSvGWuRTsDk=
X-Received: by 2002:a4a:8515:: with SMTP id k21mr15270840ooh.71.1637859390839;
 Thu, 25 Nov 2021 08:56:30 -0800 (PST)
MIME-Version: 1.0
References: <20211123211019.2271440-1-jic23@kernel.org> <20211123211019.2271440-25-jic23@kernel.org>
In-Reply-To: <20211123211019.2271440-25-jic23@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 25 Nov 2021 17:56:19 +0100
Message-ID: <CACRpkdb7z0ROZOpbbVTe7L+RKsTKQCHnhaT+d2CEPz0vaYGyRg@mail.gmail.com>
Subject: Re: [PATCH 24/49] iio:light:bh1780: Switch from CONFIG_PM guards to
 pm_ptr() / __maybe_unused
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Nov 23, 2021 at 10:06 PM Jonathan Cameron <jic23@kernel.org> wrote:

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
