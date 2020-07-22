Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB99A22A04C
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jul 2020 21:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732632AbgGVTtC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Jul 2020 15:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732624AbgGVTtC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Jul 2020 15:49:02 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F32C0619DC
        for <linux-iio@vger.kernel.org>; Wed, 22 Jul 2020 12:49:02 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id m22so1845082pgv.9
        for <linux-iio@vger.kernel.org>; Wed, 22 Jul 2020 12:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jc9E8zZr6hmET+/1UAV9GoyrfO+T1CN2QS4e+oyyTm8=;
        b=rAixs765IBPwhi4iRRm0EDOTPpj3cLlCciVVmBSzyPvtrWrNcbbKBXn165F/kYpNRm
         fw7udxhjuDpg5uQWCFtKO7jgxp2Dj9xTQFEsjKSknasPbYV55rB6xwanORW6eAErHsB7
         6nTiCQ0WayVFOYY2teP8diiySwG+DXmOweeP6EeF8kEPwnwqUhQRelZme/gft9c95ddK
         jEckZMjVpHcaZC8LC5RzI30uAfarSZH2erIsenKPppGfLeZRWVI+PGdvyeA5rolVOiu+
         TaOJGKGlO+p9Fc2EGhRjMfjtYIAJkvUItOsh91dmygqv+tXNJ3Y+nVO1ptfHPyyvPGuV
         giRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jc9E8zZr6hmET+/1UAV9GoyrfO+T1CN2QS4e+oyyTm8=;
        b=Mes+d5QgNwvDJG/faJyPbynaQv9c3AavctdUIn7U6knq3GJ4GbKHHN0OY/LrJKPA6Z
         hJ5/BYya8nNZLk/9FWpDsjUNxo1MwY8nUiTV6I7satVPsxiQlw/R+FseI2J/r0n+WV2e
         xc53HSppwfF0qRyyvv1crJh/t8ZIvaneG3oIF7WVkxdb1KKjn9iwF0GCy92g3RzyiNDF
         s59nEsKvpHcuXXIa4CXKcelDb0MI75v5TxRtCOKmRGCPqunrZLeGu9mbNmPeMEu3p2h+
         sPqAo7WMgcEWbPO4ZVnLKyJaK7CPP0+QZUL8XI+HeunecYxqLUILANOO0wMK2iOWH14G
         BNng==
X-Gm-Message-State: AOAM532nhjsv1Es1iA6QW5CiLPqU4LWE+FavBIKyi9MEqDMQhyfg7HgI
        ubrTbSZX6HSy4WemBSc6/frNHp//pSHWle6/n1Y=
X-Google-Smtp-Source: ABdhPJxCOee+ql6u16gs27imPZWw4sg6bKpt6BgWHIAiyGx2iJH4uBGv8/4pJ9R/PM24VM9IyU93v4eo2xVjiXibBi8=
X-Received: by 2002:a63:ce41:: with SMTP id r1mr1239223pgi.203.1595447341900;
 Wed, 22 Jul 2020 12:49:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200722155103.979802-1-jic23@kernel.org> <20200722155103.979802-12-jic23@kernel.org>
In-Reply-To: <20200722155103.979802-12-jic23@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 22 Jul 2020 22:48:45 +0300
Message-ID: <CAHp75VfWcdUXPUWJrnggk+dP+vVOemvJRF+VATBSfTPbYak=eA@mail.gmail.com>
Subject: Re: [PATCH v3 11/27] iio:light:st_uvis25 Fix timestamp alignment and
 prevent data leak.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Jul 22, 2020 at 6:53 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> One of a class of bugs pointed out by Lars in a recent review.
> iio_push_to_buffers_with_timestamp assumes the buffer used is aligned
> to the size of the timestamp (8 bytes).  This is not guaranteed in
> this driver which uses an array of smaller elements on the stack.
> As Lars also noted this anti pattern can involve a leak of data to
> userspace and that indeed can happen here.  We close both issues by
> moving to a suitable structure in the iio_priv()
>
> This data is allocated with kzalloc so no data can leak apart
> from previous readings.
>
> A local unsigned int variable is used for the regmap call so it
> is clear there is no potential issue with writing into the padding
> of the structure.

...

> +               u8 chan;

> +       hw->scan.chan = val & 0xFF;

0xFF is not needed.

-- 
With Best Regards,
Andy Shevchenko
