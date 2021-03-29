Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3EB34C3F5
	for <lists+linux-iio@lfdr.de>; Mon, 29 Mar 2021 08:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbhC2Gma (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Mar 2021 02:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbhC2GmY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Mar 2021 02:42:24 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0BC2C061574;
        Sun, 28 Mar 2021 23:42:23 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id j26so11633816iog.13;
        Sun, 28 Mar 2021 23:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=590wVvTYdFk9t8zKZJMq+7iofIj4M2X5kyHkLHAKRX8=;
        b=hiumg1nODsUWTv6OC9EEPBPJ5ddKMaXEoqpFobvUdc/fvlVazh0jZoaUMr3ncUHnuG
         QmGmtTqWIT5OYMIhkz+BAwyBQ5KMuG3dzzsynlZdAht4z32FzmbUR5pwG82o+RvWBCki
         F+ycx1CSflrxOLeaMxASydGSC3EI4tDMvKWrYh8ONWGmUnTFvdoUCX3MQmvqCE5ksWjl
         uRrnkEkTDK5NBaPyZclkxRjvlX0kDU/JN8MKCFL4t2k9g32GnIKn7R3TJfRnxqEegSmR
         5j4RYxUJNtJrNvMCKxjFPJ2/wieSwYeSrMTx/OLEzEy8tZIGDbGmbJugobZpynUvZp++
         E8Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=590wVvTYdFk9t8zKZJMq+7iofIj4M2X5kyHkLHAKRX8=;
        b=BFWCQo6VB9O/htnQkkR0WC6qYkgkEXTMOQ51maEzNy+znSNBJFyETGid4Rp/fGMPs9
         ebYhjLbzfURwHaIbv2L2sz7xgcMBzHK81x5RO4NUOVBFdZq+3AdaD5C+pohcURwyLhA/
         lfzMEF5zvUHLcDqNk0eE6QdQDdICKLlsHB7e0ugHulc3Gp6Z234DbL/7hr+9RjxbIFue
         ZowU0S74jN8il7Cp+FDOVHTX4IjRADS//SFcTJlpXB/finwyt9w0a8spZzXmMTHhW5Rl
         vhoK0HUHFeYfxJVUXIrvf+kAXOWxcwVVK4VEGZO0yrTgbCCnPeoyQKfCLZlMzDBownwV
         MNaA==
X-Gm-Message-State: AOAM531A4jpJT/zUpvnwrMQ8sP7SS+v0N8qcgSnO5U3AC8EA8Qr4++++
        B0Q7Ha2on5yWTiTnoP2aJsZr8DiXtQQ7QMzeGpE=
X-Google-Smtp-Source: ABdhPJxi1IVMCWYVLFR9bzDgrTvNoOIQ/WXiJ/SwfwMjS0Sn3QwYFUViOfGdAwEiqtfVRw+qqeKl06BYHNmxrYFkFBc=
X-Received: by 2002:a02:8545:: with SMTP id g63mr22606460jai.79.1617000143505;
 Sun, 28 Mar 2021 23:42:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210328035159.47259-1-julianbraha@gmail.com>
In-Reply-To: <20210328035159.47259-1-julianbraha@gmail.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Mon, 29 Mar 2021 09:42:12 +0300
Message-ID: <CA+U=DsrbZN51cR6tbyNuwQ-zZnauOrmqetGa6T8+RtcC58mxFg@mail.gmail.com>
Subject: Re: [PATCH] drivers: iio: adc: fix unmet dependency on OF
To:     Julian Braha <julianbraha@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, fazilyildiran@gmail.com,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Mar 28, 2021 at 7:08 AM Julian Braha <julianbraha@gmail.com> wrote:
>
> When AD9467 is enabled, and OF is disabled,
> Kbuild gives the following warning:
>
> WARNING: unmet direct dependencies detected for ADI_AXI_ADC
>  Depends on [n]: IIO [=y] && HAS_IOMEM [=y] && OF [=n]
>  Selected by [y]:
>  - AD9467 [=y] && IIO [=y] && SPI [=y]
>
> This is because AD9467 selects ADI_AXI_ADC
> without selecting or depending on OF,
> despite ADI_AXI_ADC depending on OF.
>

Hey,

Thanks for the patch.
This should have been fixed a bit differently with patch:
https://patchwork.kernel.org/project/linux-iio/patch/20210324182746.9337-1-aardelean@deviqon.com/

Can you check if this fixes your setup?

Thanks
Alex

> Signed-off-by: Julian Braha <julianbraha@gmail.com>
> ---
>  drivers/iio/adc/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index e0667c4b3c08..7606c9b1630e 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -248,7 +248,7 @@ config AD799X
>
>  config AD9467
>         tristate "Analog Devices AD9467 High Speed ADC driver"
> -       depends on SPI
> +       depends on SPI && OF
>         select ADI_AXI_ADC
>         help
>           Say yes here to build support for Analog Devices:
> --
> 2.25.1
>
