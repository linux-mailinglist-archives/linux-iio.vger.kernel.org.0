Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 145761DAD2E
	for <lists+linux-iio@lfdr.de>; Wed, 20 May 2020 10:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgETIXb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 May 2020 04:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbgETIXa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 May 2020 04:23:30 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4432C061A0E;
        Wed, 20 May 2020 01:23:30 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ci23so905568pjb.5;
        Wed, 20 May 2020 01:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ydJr1FI/eDhp6ARKNzCABXniNl9l6KBQGwfYvbwjzD4=;
        b=WVhCmGX5+bbu2oNKUHCJMjgJVZwHDvqEyXVHcxsbWR3VIz9AfzMHjjRpXnSCRKz8f4
         Ku+Ea9yzFJSt6uljgh+evfBdgKBAnUfp00LPRHXg0VbCtBJNDR0TykAU5vd/hRcF8Vki
         a3RiBdTVnURtwQHzNed2Gb7Ik1XNr8DzOG6dL+bzf6qDTsHTNx3IZ9I5XZUbM6KfjDGy
         M4WPpwpJsQUos+wGjK1i72k2SFftXoj4QvDA5lT1xQ9B2eZ4YjNk+9N8E7RiIMwGt78f
         TvvwZr7GbZ2BsNJyc4N6EaWJXrXODxHl+Y5ds4Brg4hX+xQHWU2AgDiKNqkz9LB3hdCH
         F9tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ydJr1FI/eDhp6ARKNzCABXniNl9l6KBQGwfYvbwjzD4=;
        b=sEu2+3RskjWzLTBbWq0b9ghNWOd4u0w/Sn76nz0CPNjKgfV7OWOu9kubiQPzPMZVAS
         hJ1uDGY1t9vcJbI0ROCdAhaln6XbR3924IYg7vqSzdaVDOJ9p3Xe9Kx7z6x9NJTtiWh5
         sx7fNuSV9HpiinvBOJV0V6oBQVGL5Z/rNqFVn04WhlRHfEl5bQPpG+VY+4mgEF24GJSo
         o4QV1PGaUYMwtO9WYZs9lJknXRn628YcqdvApEGdq4Se37CyzTBN6lgZcwiOdi2IHg/e
         FkMK7IoY3VZKugW8I8vLRVAsW3X28ixRuQHHVsd+ojuGIhqdzp/++chCDniDrtQuV7u+
         XqjA==
X-Gm-Message-State: AOAM530nIR+34kqTlECt2Xdt4VP6TvC9EB0VlKmGPjEx0bGdg+HiwrC0
        T2FLCPL5aP5TJHAY8ydCY65kegzWBcnOdRHVTqlsldaNKyo=
X-Google-Smtp-Source: ABdhPJx1cbItXqm/dq+8SPg/JJ59McZbevS+5zuzZUw+JrFXOf1S9QaDE+zP72JnAbxSTImWrgH1IaIfNuliCSXK1Rk=
X-Received: by 2002:a17:90b:113:: with SMTP id p19mr4126093pjz.129.1589963010284;
 Wed, 20 May 2020 01:23:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200520073125.30808-1-jonathan.albrieux@gmail.com> <20200520073125.30808-2-jonathan.albrieux@gmail.com>
In-Reply-To: <20200520073125.30808-2-jonathan.albrieux@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 20 May 2020 11:23:18 +0300
Message-ID: <CAHp75VcWBe=3j68t9pmRk=xigsym_f_EHG4HLLKe_cmQi5E6mA@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] dt-bindings: iio: magnetometer: ak8975: convert
 txt format to yaml
To:     Jonathan Albrieux <jonathan.albrieux@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Allison Randal <allison@lohutok.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jilayne Lovejoy <opensource@jilayne.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, May 20, 2020 at 10:32 AM Jonathan Albrieux
<jonathan.albrieux@gmail.com> wrote:

> +maintainers:
> +  - can't find a maintainer, author is Laxman Dewangan <ldewangan@nvidia.com>

Alas, you'll never go forward with this.
One (easiest way) is to drop this patch completely if you won't be a
maintainer of the binding.


-- 
With Best Regards,
Andy Shevchenko
