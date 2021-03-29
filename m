Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 069A034CE89
	for <lists+linux-iio@lfdr.de>; Mon, 29 Mar 2021 13:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbhC2LNL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Mar 2021 07:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbhC2LNJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Mar 2021 07:13:09 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B697AC061574
        for <linux-iio@vger.kernel.org>; Mon, 29 Mar 2021 04:13:08 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id x21-20020a17090a5315b029012c4a622e4aso5001137pjh.2
        for <linux-iio@vger.kernel.org>; Mon, 29 Mar 2021 04:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MvQx4E9XjwuG92AbIJL9Pvipif3RhHCGY9rKOHLRmd8=;
        b=f8EqC71EEuVrmcikGQRDod57qGpluKjwTeQvK8dSdSN/JGnz2ycwLeOWu+EKL6Vnp7
         E8HYAxns/p7N4ED0Mkn7Lm88cp/gXA9JSh3Q+sn/zq6ynM46QMNv1CkzxOLCAC5+w6W5
         YuN9one/Q6QKZJauNVAlHwc7khbvoryDUJ++ilgZI0XlPkflt1nWLWvf/ILoTfHY5OOT
         GflBOblJajJ8bL+lRR2Xw/7+5OXmsHvbaeawAEpTdfaC/OIVD4Fa54JsWYrY9useytCz
         OUA+J5nMhAo2HBJQQ48hvKW6AeQK+r/mQkjX20oTlIVRR/9++qT/Ammla70iA99pfiYx
         jT4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MvQx4E9XjwuG92AbIJL9Pvipif3RhHCGY9rKOHLRmd8=;
        b=fHt1CvY80KVKo9DeOilAtePeCuSs9k8jAjta+Rj/sHET6BvL58Y2LFLAJcwMr6yYZF
         nH2xy2TRqED+NnMzvQUd0jQYy5952QKqcpVMzWoHYWJCKgLjOSDjF3THhFdUhTTFBy4h
         KCTIA0/bwxslFRzLTCfzZrTrMgtmG44vNbP5ZugZL+3Jpq8vEGv6Ud9yEUx+hR4GVoNl
         +2/N4uL/twi9DOzSxg0HNYL32GC5Bc66BqQ+WdoxQ1ieYtWsZfmeFr9KWtW2BKVkJpoL
         sPuonGVkL5qDIZlz/X61OBASSp5yWcEzJRSEhw+FenU3G2imex6xCiWc4wHAwRCe6nt8
         ss1g==
X-Gm-Message-State: AOAM533QM7ckczhC5EvmgSe5kolqPKW4GLlnPVBSgIhLvkOWGcuNCU6y
        9lKEJEZ+/gYd5sCro9avtFGn/0E0795Bwzd7MkBZrPywI13+Zw==
X-Google-Smtp-Source: ABdhPJxi0pm0u8gbMkyxkbWY1xmAO/6UiIqob9pOQ+InJ0EjMOpZ4GU2BJ7Ooztj8mewNv8jvo2KPIuwlfpeqbjEKsU=
X-Received: by 2002:a17:902:ee02:b029:e6:5397:d79c with SMTP id
 z2-20020a170902ee02b02900e65397d79cmr28278664plb.21.1617016388146; Mon, 29
 Mar 2021 04:13:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210328033639.1021599-1-gwendal@chromium.org>
 <20210328033639.1021599-3-gwendal@chromium.org> <CAHp75VcD4NC8AN1m4DoW8D_Y=n2yTFUyWt5ZSX5=Awg=yFLwNA@mail.gmail.com>
 <161698749780.3012082.7923744326858644645@swboyd.mtv.corp.google.com>
In-Reply-To: <161698749780.3012082.7923744326858644645@swboyd.mtv.corp.google.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 29 Mar 2021 14:12:51 +0300
Message-ID: <CAHp75Vd=v_qya1rFrxROrmho4BSRrKMM-oqXgq5G4N=w-5L41g@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: sx9310: Add debouncer-depth parameters
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Daniel Campello <campello@chromium.org>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Mar 29, 2021 at 6:11 AM Stephen Boyd <swboyd@chromium.org> wrote:
> Quoting Andy Shevchenko (2021-03-28 05:32:36)
> > On Sun, Mar 28, 2021 at 6:36 AM Gwendal Grignou <gwendal@chromium.org> wrote:
> > >
> > > Semtech SX9310 SAR sensor has a debouncer filter: only when N
> > > measurements are above/below the far/close threshold an event is
> > > sent to the host.
> > > By default the debouncer is set to 2 events for the close to far
> > > transition and 1 event (no debounce) for far to close.
> > > It is a balance speed of detection and false positive avoidance.
> > >
> > > On some chromebooks, the debouncer is set to a larger number.
> > ...
> >
> > > +               ret = device_property_read_u32(dev, "semtech,close-debouncer-depth", &depth);
> > > +               ret = device_property_read_u32(dev, "semtech,far-debouncer-depth", &depth);
> >
> > Are they existing properties or new ones? To me sounds like the
> > latter. In such a case you missed DT bindings update.
>
> The bindings are part of patch #1.

Thanks, it means _I am_ missing them :-)

-- 
With Best Regards,
Andy Shevchenko
