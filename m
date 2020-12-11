Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46E1A2D7136
	for <lists+linux-iio@lfdr.de>; Fri, 11 Dec 2020 09:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390215AbgLKII2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Dec 2020 03:08:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389741AbgLKIIY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Dec 2020 03:08:24 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5A7C0613CF
        for <linux-iio@vger.kernel.org>; Fri, 11 Dec 2020 00:07:44 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id x15so7996301ilq.1
        for <linux-iio@vger.kernel.org>; Fri, 11 Dec 2020 00:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vRKZNwN1K3IY9DWo9TzQPjf4hfKLsctY/UvlzetBWhU=;
        b=WwVPOutjWdOEcwwfqxHAzt5LbVFnJNlycQWeI/jx3Mn92/Ksyq5KAmAYBEXbYOPx0j
         NSP1YvCsSyyEad+pNlpcn3nIOchrq2SvlUsfhbW6To1xpsNed2wIoInNYXYZUL28aRW8
         r20hOI/LFTAo274DLEJSd0iP579lEywNNYp+y7ejDZ/91hF8KdflRZAIFC0i3lZZ2U3k
         rxeGMFWqt8Puwaoze3Pd+g+Y5Wj4iXXl3PPIc/h7oDODbtHYFFYoCWc7HJP6P1THsh2h
         vHHgjyYmBA9T0x1Pydo5shg8cmBraIqcUwi8BF8X1O9I/s4MqaMhhIj5Ei6RCE8p6bIR
         dRPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vRKZNwN1K3IY9DWo9TzQPjf4hfKLsctY/UvlzetBWhU=;
        b=crLAWS2erXZ+IyhjERFRr1WpofcRSiGOjRhn1ewQTZey0RRE27faCxc7ibbYaZEr9t
         h7F3w1GXjnBHBt4+xdbTsxuHDTyY36FQQcI8NFERQIH+Q8qQv0obMJXqXKiU41S4ANgs
         peAcY70bhGcvTzowGVOaG+HM5OlHA0diormvpFh+3BzgzRkG5+WXDTli7xPQWtOgQM9e
         FSsI0o609MKXgHtz0VnmZ21zTND+g6bZ5ntBgNnoi6OGIhicXfMG9uMHOkhkV+5reYnK
         aEOtUF8IKBhhkdVVlzjwqsFJM568Jm7kJtY1M2ZpePJiZ9yIEzR99uv4dx6DdJPRsfl7
         trDw==
X-Gm-Message-State: AOAM5339EbXF2fuO8v9ZoqivTSFvRmy+YwrkFjGU0v6fgK3HLdKcsoYb
        glbZCvMOT8zYq8WPN1ozDu07RWNG/gv4Aj/WCpA=
X-Google-Smtp-Source: ABdhPJxV8dpRcE57SAX0TebwBIp0K+nqEhQpXxGB71wWQIUTxF68NRypg5NVSrhxFKdwYeqhuPuNqTzqQkmUt1IcPTo=
X-Received: by 2002:a92:8707:: with SMTP id m7mr14482191ild.217.1607674063502;
 Fri, 11 Dec 2020 00:07:43 -0800 (PST)
MIME-Version: 1.0
References: <20201210204211.967018-1-gwendal@chromium.org> <20201210204211.967018-8-gwendal@chromium.org>
In-Reply-To: <20201210204211.967018-8-gwendal@chromium.org>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Fri, 11 Dec 2020 10:07:32 +0200
Message-ID: <CA+U=Dsrds=qWRwbqHKyeWA7Wpd=Xm+YSA+KQZXfjiJJX=eTVNQ@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] iio: as3935: Remove code to set trigger parent
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Dec 10, 2020 at 10:42 PM Gwendal Grignou <gwendal@chromium.org> wrote:
>
> Already done in boiler plate code

Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

>
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
>  drivers/iio/proximity/as3935.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
> index b79ada839e01..edc4a35ae66d 100644
> --- a/drivers/iio/proximity/as3935.c
> +++ b/drivers/iio/proximity/as3935.c
> @@ -411,7 +411,6 @@ static int as3935_probe(struct spi_device *spi)
>
>         st->trig = trig;
>         st->noise_tripped = jiffies - HZ;
> -       trig->dev.parent = indio_dev->dev.parent;
>         iio_trigger_set_drvdata(trig, indio_dev);
>         trig->ops = &iio_interrupt_trigger_ops;
>
> --
> 2.29.2.576.ga3fc446d84-goog
>
