Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1893708C9
	for <lists+linux-iio@lfdr.de>; Sat,  1 May 2021 21:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbhEAT2a (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 May 2021 15:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbhEAT23 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 May 2021 15:28:29 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A090C06174A
        for <linux-iio@vger.kernel.org>; Sat,  1 May 2021 12:27:39 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id y32so871053pga.11
        for <linux-iio@vger.kernel.org>; Sat, 01 May 2021 12:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rsmMUP+WH8EUrVXANwdzOZhDdL1p0AyDM0RBcbz28uA=;
        b=YefXvzTSaDnGGr76kb7yDNDdy30enCIucoMuZHvoEs+hpIkxhVIV9zwhJP1OQB9cHW
         JfkEsOpj1lUPFWdnr0H4PTyMAq4a8vOz6g/TXEj4Es+oprvTZPtu/BKWXowVPX/o4u5E
         00wlClwGGyQOxXEnPRiffy2EkgnJScyLb4z1UlCdg+Y9Fw83E1xl1RlEh6Z2Bsvzcqfc
         mKNV+lF1GRFwXOBrdlYymeBCB6oV6G/9hcYWVZXq0R3HBuBTN/3ZZNPFNRtXy72jH6L+
         ewSGJc4pXSBTAt4j1HVUiP6XgMGJ59Cny6g6gllZy07CDqdUVqP5hdVvmQIj4vHg6LJo
         k2WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rsmMUP+WH8EUrVXANwdzOZhDdL1p0AyDM0RBcbz28uA=;
        b=saZgVyMCbT4xIOWPu1zi4yFZdYETxtz1yoVXsIKGB1yNPipep7MxLKIj0v3nJN2UQ0
         RDIM/sjztjYP7RDKXFRVJzNwnNYqkfd+ZxAZ+nZf2lkxFKMHrjCc3lwpiMeKsp61n2Pg
         wmxCWzTrSFXBd8G1Ux/kvdFtJzXZ256kjyISYCRuQp+zfCsGFT8z7jWg90+N5pmG/hUH
         Uyxh7z/sfN9Sq2M8V2J+k2Kr2hkjJWp+soMIAMhCZmOTHFU0xiho0fMow7nG72++KM8a
         O9Z8ADt+dHQoPUY/HM/JEOEI172ZI2bZAO6D7Plt0Tee/9am6JndB7prM996N77RRyzW
         G7Tg==
X-Gm-Message-State: AOAM530fYN8mORGJY+bZuKXeK6U8srUSlz0S/CELOl+6DLERiQEuH/Wq
        Ph7efZ7YNrLxNRGRCJweCsDO+oIBaPkMA70/1M0=
X-Google-Smtp-Source: ABdhPJwpXLfIcx9g+Gm0yiiFoUwXmXGb7kNux9o0wbScqMcsEjrtk6gbrl/ejwlWWKp22QgXXnFSnNpp+5pN2TCdKUw=
X-Received: by 2002:a63:a847:: with SMTP id i7mr10365768pgp.203.1619897259033;
 Sat, 01 May 2021 12:27:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210501172515.513486-1-jic23@kernel.org> <20210501172515.513486-2-jic23@kernel.org>
 <CAHp75VdRTh6Pzj8yy6sDQqfhfAJj1nGZ79UmzBckNR4b1h5sog@mail.gmail.com>
In-Reply-To: <CAHp75VdRTh6Pzj8yy6sDQqfhfAJj1nGZ79UmzBckNR4b1h5sog@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 1 May 2021 22:27:22 +0300
Message-ID: <CAHp75VdNiEGLC44AycNTJ7_oaibtshJHaFFcq+UKBJ3XtAcp+w@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] iio: core: Introduce iio_push_to_buffers_with_ts_na()
 for non aligned case.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, May 1, 2021 at 10:25 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Sat, May 1, 2021 at 8:28 PM Jonathan Cameron <jic23@kernel.org> wrote:

...

> > +               iio_dev_opaque->bounce_buffer =
> > +                       devm_krealloc(&indio_dev->dev,
> > +                                     iio_dev_opaque->bounce_buffer,
>
> Oh la la, foo = realloc(foo, ...) is 101 type of mistakes.
> Please, don't do this.
>
> > +                                     indio_dev->scan_bytes, GFP_KERNEL);
> > +               if (!iio_dev_opaque)

And this check...

> > +                       return -ENOMEM;
> > +       }

-- 
With Best Regards,
Andy Shevchenko
