Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9552D34A5F2
	for <lists+linux-iio@lfdr.de>; Fri, 26 Mar 2021 11:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbhCZK5Q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 26 Mar 2021 06:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbhCZK4x (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 26 Mar 2021 06:56:53 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178DFC0613AA
        for <linux-iio@vger.kernel.org>; Fri, 26 Mar 2021 03:56:53 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id lr1-20020a17090b4b81b02900ea0a3f38c1so5429815pjb.0
        for <linux-iio@vger.kernel.org>; Fri, 26 Mar 2021 03:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fNVzOtdPMap+f7duUe11pWCc8/dBsjC1H7LmwZAhzKM=;
        b=sQ906fvk7CfAXsRUK9ARWPRsVEHOwaDOMb5l3hxa1JmkHg6be/3pE525debFgkiJEi
         pLw1B3ywvAMhs//3K+kZz6dm3YolELfo3qoFSPouEa17eVdmkamHq1Ydre+oyi+Jgb8H
         gB3vkNvkfCcpD8lvikgrfFVQT0yRHPbJwjBauI/OnN3MF9zu3QPxiOdbDrhOjZciiuxq
         IX05sSz7wwWB0kff6+apBus2aJxO5xes06nFmvt5r+zhmWE8b3GosXzfhL1SCrsVi4I7
         pyRnc5THO7wBM5MG2GDaulD1f2diI1oTnOJUYRh8SsLlDwRRjCQJ6L32j6bX7z39MYjp
         Eaog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fNVzOtdPMap+f7duUe11pWCc8/dBsjC1H7LmwZAhzKM=;
        b=hdj8exQJ7VMloglcX1JCtHOOaDzUidAgziLaN4lefvZ2JM2MBNBKxSXTxqEEe3CndN
         6RNjoycsDaQRK1JrnP0o1Ky49RvVx5cXJhWq76b31WKqFL8h0KzvscNhZSgE6nm5w2eC
         s1c5T50b7YW4tSZxFqPvra0kOIk089UY5KHdG6QaoWgffmjNGD9xarWEIc4xPeyPAi+e
         EpfDcEngMcBREp3tTVKwv4WcRhEVMx1p6PGvRjnrbStEYmH6j15WA9FqmtVmXmA1C2Ub
         i4EI7acK1zn2xBCh1k2PF7M+bI4jByvg74pCm9r5iMNvJV6MRaNMa0mgHc+WVxOPW+vO
         NTQw==
X-Gm-Message-State: AOAM530DgvsiHayF1LvKGYOMqWVhkONZx/3iIshu5e6Tu8u6wNC1nxMt
        jm0jR3zUJdgZEutexJEBkfyn4jd2hoL1nmvxec4=
X-Google-Smtp-Source: ABdhPJwWgtGInP3QS9O3d0LXbOX+b6/MhEHBLlxyq8uxHSCiG+2eSv+V7RNeznsOKB3YalJz3qM46Br3SKzJe4nOlSw=
X-Received: by 2002:a17:902:ee02:b029:e6:5397:d79c with SMTP id
 z2-20020a170902ee02b02900e65397d79cmr14690563plb.21.1616756212578; Fri, 26
 Mar 2021 03:56:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210325131046.13383-1-lars@metafoo.de> <20210325131046.13383-2-lars@metafoo.de>
In-Reply-To: <20210325131046.13383-2-lars@metafoo.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 26 Mar 2021 12:56:36 +0200
Message-ID: <CAHp75VcHJrJyvdW9qCdCprrROozUuTb6EPP7DDMg3FSoY=Ch=A@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: inv_mpu6050: Make interrupt optional
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Mar 25, 2021 at 3:12 PM Lars-Peter Clausen <lars@metafoo.de> wrote:
>
> The inv_mpu6050 driver requires an interrupt for buffered capture. But non
> buffered reading for measurements works just fine without an interrupt
> connected.
>
> Make the interrupt optional to support this case.


> -       irq_type = irqd_get_trigger_type(desc);
> -       if (!irq_type)
> +               irq_type = irqd_get_trigger_type(desc);
> +               if (!irq_type)

A side note: perhaps change this to comparison with IRQ_TYPE_NONE (as
a separate change)?

-- 
With Best Regards,
Andy Shevchenko
