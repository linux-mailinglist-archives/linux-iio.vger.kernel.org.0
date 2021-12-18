Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B15DE479B1B
	for <lists+linux-iio@lfdr.de>; Sat, 18 Dec 2021 14:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbhLRNyp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Dec 2021 08:54:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbhLRNyo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Dec 2021 08:54:44 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA9FC061574
        for <linux-iio@vger.kernel.org>; Sat, 18 Dec 2021 05:54:44 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id y22so18943001edq.2
        for <linux-iio@vger.kernel.org>; Sat, 18 Dec 2021 05:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kiIGeE3vfnf2Oj6ZXg6G/IxXNRWm2qy77AMcsPt0eLQ=;
        b=YBd84E34YfOYrXZ8e2wEe9fa0AVKjMKLA+cMk8LlSuV2XLQP4OHwKE6LG9k+x+Uo+I
         8YMrWZ8IC9+SILP9xUnV4o/BZg8k13lJTLCvOMKmfK91s9s3M3pi7x55vCg0KcUjdxzd
         SdmO+inDVCBzNx0vT3UU9BkFJD7UyXNZZoxtUKxXlYia51i/2aHxeg3VnmGi6bSIZFbg
         9U8XjSrnsi9gd6G682XrIXHOpatpL9tRauGhjevM3+qNrljYreLWA1TB5IxewV/frlRR
         T4v16iL0utkaG0Ym6lA0og9a6ye7HP7RvZAZgX8Vs9oWPdNwJxd9Y0X4TuIYME9n7AQp
         7HXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kiIGeE3vfnf2Oj6ZXg6G/IxXNRWm2qy77AMcsPt0eLQ=;
        b=QsdiIrDkRc0BxGC/oxSAHKdcCoUF56YF2U/YpVrCPOfNqIVT69WI1WLAARwkbhTFM+
         CPtpb+nufMSSOuPQEBeIN9t66AuciC/nMThORndA4VHeZZewiP93UlLtK5p5VJKQ2svp
         j1XYUEHFbQvr+YdQU/ofBHyzuThZ0q/X4jVSVG6J4U7307zF9kJ79B3XaD3+B7oDpQ8a
         nJIql18Vkn/BYEpjpC7qTwSgOVTEmtMIt7KVkTI+llgSq685wMgE0DCWRQ1AVKEEz3k5
         rZuMUikD7+++lzkQxe8Py7ZkQ89DZysZ79BapmnSUGuQGPXgGECT3/asSNdoORRXUmvf
         JCxA==
X-Gm-Message-State: AOAM531xeP4zrIzCvm+eD2yklbicqlLwUsDSDGLpkh4lxPPtxzTRlra/
        2Yjvnl7Nr2BrL6sKwXefUtKoGUTkRij8c6TBA5av9HI/f9BXvA==
X-Google-Smtp-Source: ABdhPJxaYtO9khDWgztRtr1OPQXzmcggWQFAKiiySGEnKBRQvN/l0xWK40O8SYl/RWScKzti3EtFOF42ZP6Ee1HLuG8=
X-Received: by 2002:a17:906:ced9:: with SMTP id si25mr6694888ejb.77.1639835682059;
 Sat, 18 Dec 2021 05:54:42 -0800 (PST)
MIME-Version: 1.0
References: <20211218001755.3096807-1-gwendal@chromium.org> <20211218001755.3096807-3-gwendal@chromium.org>
In-Reply-To: <20211218001755.3096807-3-gwendal@chromium.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 18 Dec 2021 15:54:05 +0200
Message-ID: <CAHp75Vf_4nRXZ66_EwLU+wrK278Hb+z3ZOtRnQ_1PqCQ_Mcceg@mail.gmail.com>
Subject: Re: [PATCH v8 2/5] iio: sx9310: Extract common Semtech sensor logic
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, swboyd@chromium.org,
        linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Dec 18, 2021 at 11:58 AM Gwendal Grignou <gwendal@chromium.org> wrote:
>
> Before adding new Semtech sensors, move common logic to all Semtech SAR
> sensor in its own file:
> - interface with IIO subsystem,
> - interrupt management,
> - channel access conrol,
> - event processing.
>
> The change adds a bidirectional interface between sx93xx and sx_common.

...

> +/* All Semtech SAR sensor have IRQ bit in same order. */

sensors
in the same

...

> +EXPORT_SYMBOL_GPL(sx_common_events);

Here and in other places, can we switch to NS variants of the
EXPORT_SYMBOL_GPL()?

...

> +/**
> + * sx_common_probe() - Common setup for Semtech SAR sensor

> + *

Here and in all similar cases, remove this redundant blank line.

> + * @client:            I2C client object
> + * @chip_info:         Semtech sensor chip information.
> + * @regmap_config:     Sensor registers map configuration.
> + */

...

> +#include <linux/types.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/types.h>
> +#include <linux/regulator/consumer.h>

Perhaps grouped and ordered?

+ blank line.

> +struct device;
> +struct i2c_client;
> +struct regmap_config;
> +struct sx_common_data;

...

> + * @num_channels:      Number of channel/phase.

channels or phases

...

> + * @buffer:            Bufffer to store raw samples.

Buffer


-- 
With Best Regards,
Andy Shevchenko
