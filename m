Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB1E479566
	for <lists+linux-iio@lfdr.de>; Fri, 17 Dec 2021 21:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237634AbhLQUYX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Dec 2021 15:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbhLQUYW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Dec 2021 15:24:22 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA2AC061574
        for <linux-iio@vger.kernel.org>; Fri, 17 Dec 2021 12:24:22 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id f17so2544926ilj.11
        for <linux-iio@vger.kernel.org>; Fri, 17 Dec 2021 12:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0RPlLAADCWMblEKj6QzqpFSkD5gFMewlPA251bUBwtQ=;
        b=LuwKVSsbkKvsf8d8/SqKhtlPxz78bmCSgZhGhZOi0HR50/t6V6wMgjIyl907bZxAlj
         y0q1ve/4tOJTVI7GVfXy3zPy+GxVVi8XBZTaRu+nFh4rLMTCtbhcWuORWORQjofdOmdS
         5Mn1ngTpFMh1bsNcJKVGK4sJDDd6vEIjwNARY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0RPlLAADCWMblEKj6QzqpFSkD5gFMewlPA251bUBwtQ=;
        b=kclr4lWlUBFQGXvmewqXo2/Fx40eCtIDtzrhaGMWvYWh3rNH6KTn8+Wg4wGF1SROjh
         OkXB1bQHdebrB/cXfyi++IzeJaz+GPWvqz3brRt6D5ZtR2c5m2y8UNIUk2fukY4g0qu6
         G5LV/yhaZtEvZxDM2IrpZmjIWBxlPUQoW1vgyOEQo1NPrXS1m86M2Qy6ZMrLjlk5Ne5W
         Zvcyjef31u9F2dbVinms+fnA7foox4Pq6PNBHwl50uIE0GRmaH2swInw2TFyhHjYIbMQ
         b5ojKzvvxpz51q5DLLDhhIlze/6D3AfAXqe+g0gJk6Krefo0MSD85iqfNqLXy3QWM4tx
         A3gw==
X-Gm-Message-State: AOAM530tFGvEm227iPp/k7pEXnNcA2tkcWAPSbDf0G0nbgj2v0Tzv+qW
        KWVBNBGEZqmhfBOhMrmK4ts2v/a4gf8YgNXXgrCOSg==
X-Google-Smtp-Source: ABdhPJwXqMZFvAkBkyNmxNyOSySXNqoBZqPD6QRi7zTVWpSIlpuRrpjsXt9IjGGcpa5Yy1YXfSFwd/fKoBiSidJVnHE=
X-Received: by 2002:a92:c089:: with SMTP id h9mr2410498ile.289.1639772661621;
 Fri, 17 Dec 2021 12:24:21 -0800 (PST)
MIME-Version: 1.0
References: <20211213024057.3824985-1-gwendal@chromium.org>
 <20211213024057.3824985-2-gwendal@chromium.org> <20211216155905.1fac607c@jic23-huawei>
In-Reply-To: <20211216155905.1fac607c@jic23-huawei>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Fri, 17 Dec 2021 12:24:10 -0800
Message-ID: <CAPUE2utoztf+LUsO4zKrRgVz862Bj1UyDsqSVT-1T5ANMkp8ag@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] iio: add IIO_MOD_REFERENCE modifier
To:     Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc:     robh+dt@kernel.org, lars@metafoo.de, swboyd@chromium.org,
        andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Dec 16, 2021 at 7:54 AM Jonathan Cameron
<jic23@jic23.retrosnub.co.uk> wrote:
>
> On Sun, 12 Dec 2021 18:40:54 -0800
> Gwendal Grignou <gwendal@chromium.org> wrote:
>
> > Add modifier IIO_MOD_REFERENCE for reporting sx9360 reference
> > proximity measurement.
> > All modifier must be defined for libiio to recognize
> > |in_proximity_reference| as a channel.
> >
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> Hmm. So the question is whether this is a valid modifier.
>
> I'm not totally convinced, because I can see we might well
> get stacking cases say
>
> iio_concentration_o2_reference
>
> However we do have precedence with 'ambient' which applies
> to temperature sensors.
>
> The alternative here would be to have it as a normal indexed
> channel but with a label saying it is the reference.
>
> Would that work for this case?  If I were doing the ambient
> case again I'd use label for that as well, but label is a more
> recent addition to the ABI.
That would work, I am submitting a v4 without IIO_MOD_REFERENCE.

Gwendal.
>
> > ---
> > New in v3.
> >
> >  drivers/iio/industrialio-core.c | 1 +
> >  include/uapi/linux/iio/types.h  | 1 +
> >  2 files changed, 2 insertions(+)
> >
> > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> > index 20d5178ca0739a..2b272f54de8ae9 100644
> > --- a/drivers/iio/industrialio-core.c
> > +++ b/drivers/iio/industrialio-core.c
> > @@ -134,6 +134,7 @@ static const char * const iio_modifier_names[] = {
> >       [IIO_MOD_ETHANOL] = "ethanol",
> >       [IIO_MOD_H2] = "h2",
> >       [IIO_MOD_O2] = "o2",
> > +     [IIO_MOD_REFERENCE] = "reference",
> >  };
> >
> >  /* relies on pairs of these shared then separate */
> > diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
> > index 48c13147c0a870..aa83a9b578502a 100644
> > --- a/include/uapi/linux/iio/types.h
> > +++ b/include/uapi/linux/iio/types.h
> > @@ -95,6 +95,7 @@ enum iio_modifier {
> >       IIO_MOD_ETHANOL,
> >       IIO_MOD_H2,
> >       IIO_MOD_O2,
> > +     IIO_MOD_REFERENCE,
> >  };
> >
> >  enum iio_event_type {
>
