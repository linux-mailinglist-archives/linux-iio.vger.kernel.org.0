Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C12934C227
	for <lists+linux-iio@lfdr.de>; Mon, 29 Mar 2021 05:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbhC2DMA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Mar 2021 23:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbhC2DLk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Mar 2021 23:11:40 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E62C061574
        for <linux-iio@vger.kernel.org>; Sun, 28 Mar 2021 20:11:40 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id i6so1359385pgs.1
        for <linux-iio@vger.kernel.org>; Sun, 28 Mar 2021 20:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=5Q+qgiDsgwjSQKIYdYJdHljkEvk8AN2J32oSoFHduGw=;
        b=WjjYVyIdpUEw49H3DF6KwLiSJnjfat8LZXHa6IQvgfjo5W7ZPUWPg/IPa6RvkZYY/6
         bXO45yfctPD09cLJO0HgIP/o+XCn7b1MVHlI1kSDAKmN4kKHbTnNq79nl+xYdQEFJfqo
         2mOGDyfOoahli0a00rVDFrnDEmzNjCFY4bsTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=5Q+qgiDsgwjSQKIYdYJdHljkEvk8AN2J32oSoFHduGw=;
        b=ErqQYQGQMLpCOEbcc6COZz1xIAKgEnvf4XWKn4aAEOTva+5KuorlQyIAmkl3kZlMSb
         k18uE0fMoSMktFJe0OGMPg3GKdOdk5MBFVqFSTDKnu9xkIbZi68AmgrEmAsGznnl9coi
         YWYW50Jnthgl+M1iJJ07gSlVwZHaMZoepI8y45t66dFFEAZ1QHq2hTBuCM5UwKUe3Mx9
         WuFFtKk3vdkBp5K+lO9irpC2JV8pj8FxI0bSFVxIVwoEaV9F4NrSHDpUxmt4b+Mh6QiC
         WWL3ck6IwCTu92r7Btpx1s2Wsb7nuOlXISiV6bNm0j80T/1utr39mXTaHsmMABrx7qWD
         sLeA==
X-Gm-Message-State: AOAM532IvUHaZZTu943viI9qQJEX1udpjnYLSJc2bbi2JF9BSlpNlEGd
        wdVg7E7bgsVxZA05wCd87phr2A==
X-Google-Smtp-Source: ABdhPJyWhGlZ8xzgupeCVraZEMrbI82Rg0gE/nrkvcHLVZyvWSXmzY1kPzjxodjivhh8BBWNzZSr7Q==
X-Received: by 2002:a65:63d6:: with SMTP id n22mr22510978pgv.393.1616987500424;
        Sun, 28 Mar 2021 20:11:40 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:201:d06e:3541:6cd6:ab0e])
        by smtp.gmail.com with ESMTPSA id w189sm14998934pfw.86.2021.03.28.20.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 20:11:39 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAHp75VcD4NC8AN1m4DoW8D_Y=n2yTFUyWt5ZSX5=Awg=yFLwNA@mail.gmail.com>
References: <20210328033639.1021599-1-gwendal@chromium.org> <20210328033639.1021599-3-gwendal@chromium.org> <CAHp75VcD4NC8AN1m4DoW8D_Y=n2yTFUyWt5ZSX5=Awg=yFLwNA@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: sx9310: Add debouncer-depth parameters
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Daniel Campello <campello@chromium.org>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>
Date:   Sun, 28 Mar 2021 20:11:37 -0700
Message-ID: <161698749780.3012082.7923744326858644645@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Andy Shevchenko (2021-03-28 05:32:36)
> On Sun, Mar 28, 2021 at 6:36 AM Gwendal Grignou <gwendal@chromium.org> wr=
ote:
> >
> > Semtech SX9310 SAR sensor has a debouncer filter: only when N
> > measurements are above/below the far/close threshold an event is
> > sent to the host.
> > By default the debouncer is set to 2 events for the close to far
> > transition and 1 event (no debounce) for far to close.
> > It is a balance speed of detection and false positive avoidance.
> >
> > On some chromebooks, the debouncer is set to a larger number.
> ...
>=20
> > +               ret =3D device_property_read_u32(dev, "semtech,close-de=
bouncer-depth", &depth);
> > +               ret =3D device_property_read_u32(dev, "semtech,far-debo=
uncer-depth", &depth);
>=20
> Are they existing properties or new ones? To me sounds like the
> latter. In such a case you missed DT bindings update.

The bindings are part of patch #1.
