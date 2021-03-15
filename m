Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3E7433ACE1
	for <lists+linux-iio@lfdr.de>; Mon, 15 Mar 2021 08:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbhCOH6d (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Mar 2021 03:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbhCOH6G (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 Mar 2021 03:58:06 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724F3C061574
        for <linux-iio@vger.kernel.org>; Mon, 15 Mar 2021 00:58:06 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id k2so32407870ioh.5
        for <linux-iio@vger.kernel.org>; Mon, 15 Mar 2021 00:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gXJotL87kb208DULEaYsuSrgsOPbWPHz2zA/gPV6XIY=;
        b=m7jZrsykCIFh8ZJG01qIlZSyU0oBewuiKfYZ7zTwXn8IwEWH8caEAXV2N6VkxpaxKy
         vhFsICiWO+b+dG16ENewg/Iqul9vSBCDBZ+7eiF9wEDUxDVWih6ebsyunx9Te74SIvwn
         NGJQ7uHFFW/osmlcjsuxboHCG0+ZpBlYRAPKxQ9mt5sAdHwVw+0si2DozSmHh6cwjB+j
         3j6gRCas3nmOBH2nXgkclUJXdpPPu0V5NQI+mECwTbS9ntjwEUxfbWqsTWLp4Ycl79zk
         cHqTw+bfKniGhIhw2K5tE2CTQ6hVY8hrBmq+7BqCTRAgNabRGXQLEY8fkQr/X/puwfO+
         VLOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gXJotL87kb208DULEaYsuSrgsOPbWPHz2zA/gPV6XIY=;
        b=Ki+xyYEvmRlXt/g2NqNQgGPBDxz/S8YReYCSSpwN9Y+RC5yMH8sMdHuMUFSabnXj5K
         lNkAUFeApoFPZyngMJbFusUsg8bcWzDTF4N3H0M1Vfp7kbezKMZRhhkwnkxYFjghdFka
         aRjfrTdv/9uoICp3Ggwp8rI5rJC1SunBbwPCqYDprkhwTMRSZtch3vPO7FEj5DAartBv
         0S5hOeyE2S+rf6c1nYaGWZsoabu/i9cOYMjnnWHFD4PZ+kj2P2tMLCC9CL4KD2hq4WkS
         Qbxkkz8BI/XdKFdPz4/B/rHWgL2kdUBR94GpBZezaTqHHtONO6dVkdkbLiio+/OL5yEE
         1p1g==
X-Gm-Message-State: AOAM532WRsV1xNXG4OyhPT6pRhf1qeTca6H0hHbECyKBLB+7VkafEnVU
        7Jey5Q/d1yco86jVpCd8TYQAOXx2yV1uH2WOaOk=
X-Google-Smtp-Source: ABdhPJwCe443x0BOPO66k2phQfnXjgmr7+6USrlhht08lNueU4TGTMiwaJJs7o/ct6RruSP19jqamsUGNqJ/92IsUBA=
X-Received: by 2002:a02:9663:: with SMTP id c90mr8512259jai.16.1615795086003;
 Mon, 15 Mar 2021 00:58:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210314164655.408461-1-jic23@kernel.org> <20210314164655.408461-2-jic23@kernel.org>
In-Reply-To: <20210314164655.408461-2-jic23@kernel.org>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Mon, 15 Mar 2021 09:57:55 +0200
Message-ID: <CA+U=DspfWZQfw-bsNOwyZSSTWnAMedCveq+LR=U1OLQY==u4TQ@mail.gmail.com>
Subject: Re: [PATCH 1/8] iio: pressure: zpa2326: kernel-doc fixes
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Mar 14, 2021 at 6:53 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Two comment blocks had wrong naming for function/structures that they
> referred to.  Results in warnings when doing a W=1 build.
>

Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>

> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/iio/pressure/zpa2326.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/pressure/zpa2326.c b/drivers/iio/pressure/zpa2326.c
> index 70adff62cd20..a93411216aee 100644
> --- a/drivers/iio/pressure/zpa2326.c
> +++ b/drivers/iio/pressure/zpa2326.c
> @@ -103,7 +103,7 @@ static const struct zpa2326_frequency *zpa2326_highest_frequency(void)
>  }
>
>  /**
> - * struct zpa_private - Per-device internal private state
> + * struct zpa2326_private - Per-device internal private state
>   * @timestamp:  Buffered samples ready datum.
>   * @regmap:     Underlying I2C / SPI bus adapter used to abstract slave register
>   *              accesses.
> @@ -1382,7 +1382,7 @@ static const struct iio_trigger_ops zpa2326_trigger_ops = {
>  };
>
>  /**
> - * zpa2326_init_trigger() - Create an interrupt driven / hardware trigger
> + * zpa2326_init_managed_trigger() - Create interrupt driven / hardware trigger
>   *                          allowing to notify external devices a new sample is
>   *                          ready.
>   * @parent:    Hardware sampling device @indio_dev is a child of.
> --
> 2.30.2
>
