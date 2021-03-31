Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCD934F585
	for <lists+linux-iio@lfdr.de>; Wed, 31 Mar 2021 02:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbhCaAiW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 30 Mar 2021 20:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232900AbhCaAiR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 30 Mar 2021 20:38:17 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E80FC061574
        for <linux-iio@vger.kernel.org>; Tue, 30 Mar 2021 17:38:17 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id r17so9547664ilt.0
        for <linux-iio@vger.kernel.org>; Tue, 30 Mar 2021 17:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P5BD0xwsyzWtgrYN78O5NZBCcGxuWb1OBPHfXomu+hY=;
        b=XkudtjyOi+lTX2UiyqunhojeQZHvmzqllFnD6vz7PB+dau5a//xUQtrSHqA9gMf4Fr
         ZJAvNLeQ5+V7mlzzBtoJoyEF/QdX3ucmhK5i6qXkXAYB7MBLhzcnGTOY+Q68EUFN2u3J
         HQHzsR2ojgZJ1QMrczpFaQ2RM3bKCd7yXUzRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P5BD0xwsyzWtgrYN78O5NZBCcGxuWb1OBPHfXomu+hY=;
        b=sn0flxd/e89OofVZlxK1TVIj4MAR6Tc/ZDKRZJRPOufPbVprb6Afo5e5Lc+Q9XDcra
         IdKIQE2kiNbYJvDLWuZ7l6zoluL2vJFwMRHrwmxnzX7/1NQEtYSxLiTRCXx8amm1BnRb
         EgdlRW/Av+vhYTlIoC0V+WDPJJRaj9sV8EPyOQlncQP3Y+JhlZ7Np1W6rIUXIcF3QhxS
         5VCwgobFGVWM/EUD6zk+pgQuMhcdBE5+r74bNlhzGKi0EP70rfEjACa1Oe14WeH6nbZB
         ew/aILTT81qE+Fe6fldWo+EsN6MdM7nNLW5M7xC1vuP8TseIP+5xQxubFpLdE9LzZNZF
         FJtw==
X-Gm-Message-State: AOAM531D3PoYQgPuGMLjoOoaYktS9O16TtVZFOLTCtSmNowxTTAmja5M
        MsO84QV9jOxv77HiJN2A7T3br4k/017B8oRtvGDVIh15QAnY2A==
X-Google-Smtp-Source: ABdhPJyOB/HwC6UN0pGq4RjaMXN8jBmradDeAhHbAOYbM7tCyCeFbK1DY/N+kXf1lG2dvdqXBtuLQCc3koYAwfsvOsE=
X-Received: by 2002:a92:c568:: with SMTP id b8mr624758ilj.50.1617151096522;
 Tue, 30 Mar 2021 17:38:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210328033639.1021599-1-gwendal@chromium.org> <161698755179.3012082.10332557476670862687@swboyd.mtv.corp.google.com>
In-Reply-To: <161698755179.3012082.10332557476670862687@swboyd.mtv.corp.google.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Tue, 30 Mar 2021 17:38:03 -0700
Message-ID: <CAPUE2usX-Tq2wyO4ekkAUaR6rRfJ3mZG3SQMqJbpzzUTMwd-0A@mail.gmail.com>
Subject: Re: [PATCH 0/2] iio: sx9310: Add debouncer-depth parameters
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Daniel Campello <campello@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Mar 28, 2021 at 8:12 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Gwendal Grignou (2021-03-27 20:36:37)
> > Semtech SX9310 SAR sensor has a debouncer filter: only when N
> > measurements are above/below the far/close threshold an event is
> > sent to the host.
> > By default the debouncer is set to 2 events for the close to far
> > transition and 1 event (no debounce) for far to close.
> > It is a balance speed of detection and false positive avoidance.
> >
> > On some chromebooks, the debouncer is set to a larger number.
> >
> > This patch applies on top of commit 103d6ec82676 ("iio: sx9310: Support ACPI properties")
>
> The near/far debounce settings are already supported via sysfs. Can you
> use those instead of putting this into DT/ACPI? See
> sx9310_read_far_debounce() and associated code.
Stephen, I missed you already proposed these bindings earlier
[https://lore.kernel.org/linux-devicetree/20200906150247.3aaef3a3@archlinux/].
After Jonathan inputs, it is done via sysfs interface
[events/thresh_{falling|rising}_period].

The debounce parameters are in the same class as the other parameters
already present in the DT. They are calculated during tests to meet
FCC requirements, in particular the time it takes to detect a human
body near the antennas.
Depending on the SAR antenna design, it is a balance between lowering
the debouncer "period" to raise an event as soon as possible, and
increasing it to prevent false posible.

In addition to controlling it from sysfs, could it be acceptable to
have it in DT/ACPI as well?
In the meantime, I will make sure semtech,sx9310.yaml matches
in_proximityX_hardwaregain_available and connect to that attribute.

Gwendal.
