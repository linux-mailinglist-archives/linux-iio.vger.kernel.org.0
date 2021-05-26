Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEC21391721
	for <lists+linux-iio@lfdr.de>; Wed, 26 May 2021 14:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233517AbhEZMO3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 May 2021 08:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233673AbhEZMO2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 26 May 2021 08:14:28 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD1CC061574
        for <linux-iio@vger.kernel.org>; Wed, 26 May 2021 05:12:56 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id e11so1303280ljn.13
        for <linux-iio@vger.kernel.org>; Wed, 26 May 2021 05:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v6cjFJOi/C3qLKP6nlHD6DQjz0ttxVnMBviJYIywEOE=;
        b=D4sOVY2ClTdGtp+G0cLkDjjVVdb7H/4I2OIDXNxfXExFT56KZ4hDH2qox6axslr7AF
         NUAPSpQAHKU71RVg7f8S1EPVKdh9bfyszSzP3ihkwoZ/rmr7Rx7yITXuWIbc8Ki8kbBU
         DXGm0sN0kaVSXg3BPRL0Ean16wRRRmSJckFkTydp5CxdDBTBzf81980j6hy3aP/TpF9h
         xuncUB15CW1wRTrA7S+VfRwBUYbVIcX0aqB1FXr8gD+XVJLiEPlRaX/63++gEZmLtqAN
         DZqNgOpD4fTUOcj845rRTjxcFhI7c0/+Hf9JJnrsobcDvaL9oCqnX8Y+8/eOyLYYuKyk
         GSVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v6cjFJOi/C3qLKP6nlHD6DQjz0ttxVnMBviJYIywEOE=;
        b=m9kFxtAMgTAJ+2TE+KAjUy9JTgkdoQN80+Y+e9KOXUlY5kIlOJ3noCxrM21UjIEzkU
         Z41bqeQtBVTPg4PMXT6XQhxwyg5lRyDBY616MF0z+BguSaaPlWbTgfo8vD3GgAM2zlMR
         wmJ2/pSom27K/a3sZyyiohQJMxRy6sipFU58PWbSB7PkRmHEdOD65kJ8Zl8SR162UKE7
         IX102ovhLR7ISQBgntfCW9IXa2G1Rno9M8L4U26t5DmndXWLXdRb4Tur2F9tzMyDQ8fS
         q8g1+i3jZRPGj6JXqUTCMluWhMoOzDOAFmq2Kh0gOnajVfsiZ6zn5P7rDmNJzK5IiJif
         UZ6g==
X-Gm-Message-State: AOAM530+pXu1sX9n0u8z3z7Nm6CT1e9B7HUF0ECTC5HjACxXBInaPP4z
        ZSgrk0aNoBmBTa7WxU0nAvKldgjA7fSjYFXhO7Qu7Q==
X-Google-Smtp-Source: ABdhPJzrsGOjwH+6oGcct2w7C+OCZXlqdj614/fJxA2bbHIJW+uxUD+wPV175cWUQdsbK+fdVjCn859c+nJSFCheN7M=
X-Received: by 2002:a2e:1319:: with SMTP id 25mr2005340ljt.200.1622031175267;
 Wed, 26 May 2021 05:12:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210526094408.34298-1-stephan@gerhold.net> <20210526094408.34298-3-stephan@gerhold.net>
In-Reply-To: <20210526094408.34298-3-stephan@gerhold.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 26 May 2021 14:12:44 +0200
Message-ID: <CACRpkdbT25_MXtJd02g_8JuD-29Heg_CMwRP2ROoRuXjRUGAKQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: accel: bma180: Add missing 500 Hz / 1000 Hz bandwidth
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, May 26, 2021 at 11:44 AM Stephan Gerhold <stephan@gerhold.net> wrote:

> According to the BMA253 datasheet [1] and BMA250 datasheet [2] BMA25x
> also supports a bandwidth of 500 Hz and 1000 Hz but this was not listed
> in the driver for some reason.
>
> Add it to the bw_table to make the driver match the datasheet.
>
> [1]: https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bma253-ds000.pdf
> [2]: https://datasheet.octopart.com/BMA250-Bosch-datasheet-15540103.pdf
>
> Cc: Peter Meerwald <pmeerw@pmeerw.net>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
