Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 377F5356507
	for <lists+linux-iio@lfdr.de>; Wed,  7 Apr 2021 09:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243992AbhDGHQu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 7 Apr 2021 03:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349383AbhDGHQt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 7 Apr 2021 03:16:49 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F4AC061756
        for <linux-iio@vger.kernel.org>; Wed,  7 Apr 2021 00:16:39 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id o126so26929317lfa.0
        for <linux-iio@vger.kernel.org>; Wed, 07 Apr 2021 00:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rQ2f2+Kk40JX+D7VfT4wjmPcjRCue3hUmLtbdEUVmtU=;
        b=w9Y0KRg7NfgkhAhzdUrsNuMOCIXrLZg0jlD1QPgr7AVAvE8oaOHoxK+nBAKzF43GY7
         HtGU7HOZZM2j9G/LW5pa/HGw+kb+ooVa9yj2kTpMMH88Vg1LvWanp0e5+L3pYubfwAkw
         sBh3JzTEZfLTf9fz8ZZawcxYJqPdsQtzHtwU/6eRBiVNju8KGVx+oUkZWn/MX+BYnnqx
         1lrLoWCsHscoMMJ720+yzzndpNI1x9+XXTxYUsq0xcVK7zk12d+A2qNqOlIjwcHiHmn1
         4EdcDzvoW4b8YkqA6+KEFc1AAaysNl/kWgHMJ+W5cqXjqfCnq5QV2gMghBo74Zz8mTP2
         SydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rQ2f2+Kk40JX+D7VfT4wjmPcjRCue3hUmLtbdEUVmtU=;
        b=BU1ybRfXOSkn1flUFkq5AlydVJLwI8zookVF1zaxHi/+W7lm4ubOkPWnjcr1zFmGiA
         o8a4PYGgzxb5luI79KKAhO0KA6M5YYLs9A486ddz9x60l2hatfDhk3qSVVeVLe/xoAFf
         tayylNzXf+BtreOPgEUUWhcbiAGFKw/DMx4w1RNzIDBPkLykL9MalAeQ/WL8Iw2MB4QC
         AJMNUC6+Dw2c/O6DcpWO4/pyJK0e0z9oOGNzdm2NBpwhdVdFeHV/RRooZmgTd6L67lgw
         KSB9K9JxRwlTApJ9HCUwwA4kbKDDqNzkHMZe9CWNqKuyclan+mMmV4S9gEJcziSQi5uX
         JNmA==
X-Gm-Message-State: AOAM530wrpQj4HoEXpdDAHPJ/Oc/tQguQiKjD0oYrJ1cIsl4s88qeQ/J
        /fc4Zn6ib6u55N4qAys4Fq3o5CtsY8eZoJRWe5grHQ==
X-Google-Smtp-Source: ABdhPJzO81Quh59/U5y3og/InemAPc+SixXY8vU5+STsw8ZLy9f4Xv4HrGFGMYmTu4aaAkD+Tqc6rgzK3B1Jx8C9Jxc=
X-Received: by 2002:a05:6512:c0b:: with SMTP id z11mr1643665lfu.586.1617779797862;
 Wed, 07 Apr 2021 00:16:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210407034927.16882-1-dinghao.liu@zju.edu.cn>
In-Reply-To: <20210407034927.16882-1-dinghao.liu@zju.edu.cn>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 7 Apr 2021 09:16:25 +0200
Message-ID: <CACRpkdZ8WpBgZpTjuxz2F6BryARo6eC0z_dGG_+r7KfG3kwKqw@mail.gmail.com>
Subject: Re: [PATCH] iio: light: gp2ap002: Fix rumtime PM imbalance on error
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     Kangjie Lu <kjlu@umn.edu>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Apr 7, 2021 at 5:49 AM Dinghao Liu <dinghao.liu@zju.edu.cn> wrote:

> When devm_request_threaded_irq() fails, we should decrease the
> runtime PM counter to keep the counter balanced. But when
> iio_device_register() fails, we need not to decrease it because
> we have already decreased it before.
>
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>

Looks correct, this semantic ordering always confuse me
a bit:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
