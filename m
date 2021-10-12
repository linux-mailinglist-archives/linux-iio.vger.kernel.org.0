Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30A2842B089
	for <lists+linux-iio@lfdr.de>; Wed, 13 Oct 2021 01:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236320AbhJLXsF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 12 Oct 2021 19:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235857AbhJLXsE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 12 Oct 2021 19:48:04 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB126C061746
        for <linux-iio@vger.kernel.org>; Tue, 12 Oct 2021 16:45:59 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id i20so2457933edj.10
        for <linux-iio@vger.kernel.org>; Tue, 12 Oct 2021 16:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g9QIQ7pA6on+PhPbmC46MmFbUXQiDnzNiglml743kow=;
        b=k2m1G+XqaO6GS9hxIV80tHPHDWpZY4uwLvDS+MT4diT5j6QCboVs3PDEau/U8LUwTW
         A6XepDfgCu5N08ZkIPJxerRz+/JGwOB2tjrirHQZ3McM1QnSir2qAoARulRpYgOvuqCM
         O1LwpUCr4ooefYltNCvn2LBwWK6OoU+Dw5EIMOUCXR5H6r2e9L/NbA5dpgYyPEcklvTD
         Q4+Ohi0pI+jnB/Cv6F8uJAUzLDC0me96Wc2TLjhAGe5/KN5CJWGvdEfx0Mi6eGwBQEJT
         yAzytTfNKk35T700tp2dqkUaZ4Aw9sg11TI+STxlLKa9a0Gae0rkumMyw6d65TYkP+KA
         PZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g9QIQ7pA6on+PhPbmC46MmFbUXQiDnzNiglml743kow=;
        b=vrU17ZXaHXbDQtcWZnIgv2Icm0zImGIwcG2j/Dj2+5JZcEANK0qZnKZbyosIYY2wC1
         apqs/OT0ckeaQeZEagzUjp3UbJf2bXoVatCIzy6te+3ublcurQHQNbqoUdHhjOYBcQ9a
         Y4bTx9F/lQbz6kpEiaZg0jFuCxO3kH+ZELR7Z9nnj8KcNmdUB1HDB1ul6Kkv/3JTwQOj
         qAKyVhHVgdK9rP3abL90D2MWBkp4GltNtBpISvMNxQCxnMSgzJQt1dOVjPYT0KcqIHgT
         9jPruynb8KneXe08htuH0Zwq2SxZxETdak68bPMLLd0kxAiczo/0xxYjVopnHpTa2JPu
         HwLw==
X-Gm-Message-State: AOAM532rjBJd/HLqqtcbvLr6q6Vz+eiy13t+FkPj05h/JfjnKl6AskGD
        pQeINV3te4ejsIDGi8JtcqXPl7wwn9l7sPAlCipB6A==
X-Google-Smtp-Source: ABdhPJwCFUpePR+Sp++Rs+7vC3g8AGn9zz5QRwj1VvVdaDdZ2qI0vgrM9Ktl6M/kclmNKHUDk8LFA+Gd/VjkqPSuWbc=
X-Received: by 2002:a05:6402:34f:: with SMTP id r15mr2991976edw.111.1634082358220;
 Tue, 12 Oct 2021 16:45:58 -0700 (PDT)
MIME-Version: 1.0
References: <20211008092656.421-1-caihuoqing@baidu.com>
In-Reply-To: <20211008092656.421-1-caihuoqing@baidu.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 13 Oct 2021 01:45:47 +0200
Message-ID: <CACRpkdY0uM4BNapd7XNUhZ5U0sGdP3hu5Tr+dM1jigg5vQ+KDw@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] iio: light: cm3605: Make use of the helper
 function dev_err_probe()
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Kevin Tsai <ktsai@capellamicro.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Oct 8, 2021 at 11:27 AM Cai Huoqing <caihuoqing@baidu.com> wrote:

> When possible use dev_err_probe help to properly deal with the
> PROBE_DEFER error, the benefit is that DEFER issue will be logged
> in the devices_deferred debugfs file.
> Using dev_err_probe() can reduce code size, and the error value
> gets printed.
>
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
> v2->v3:
>         *Handle platform_get_irq() that returns -EPROBE_DEFER.
>         *Handle the lack of availability of an IIO channel
>          by converting an -ENODEV to an -EPROBE_DEFER.

This looks good to me!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
