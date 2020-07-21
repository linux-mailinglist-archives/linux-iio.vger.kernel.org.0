Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3EE2227C58
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jul 2020 12:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729038AbgGUKAY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jul 2020 06:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729030AbgGUKAY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jul 2020 06:00:24 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BECC061794;
        Tue, 21 Jul 2020 03:00:24 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id c25so14635191otf.7;
        Tue, 21 Jul 2020 03:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PBTTFW09d3uJCGdXFdf82CVoARDUgIcQiOObd5wi+hY=;
        b=N6q2gA4vNplPC9DJhcWz5owtT5G62o1I0swh5lZ1W3C1Z2XFkPWtjzFLCEl1/3oTaD
         EF/GxWBef9kMAWarvqggEXvsESVELNgvYWsalXBqjQrmjHmaPLK/t5OrTyoM9PolQnl4
         jtVSdT1dg/q5YombUg6uYu/0wwjnMDhyIEPINvHObgolmWPzuQa2JbZIRpqCy32uTSK5
         amxN6ycGasTf6gkPt8t40SMvwFIXkZedXlVXafklSCyr57Bc8+TQYJhymGakJUeIhI/g
         HMwegWQUeGJdc5DVvnE6cGGf42JSSHoUUxjIiyncrxKU4QaXEaRXKXyvSpU9KKIgk1A9
         4pVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PBTTFW09d3uJCGdXFdf82CVoARDUgIcQiOObd5wi+hY=;
        b=Yr12pPNhaZmSFnfDCxV7TbNGgVG7i4PP/fZ8rCKmuiOWFDygw/CT6XHqXk9vPCl2qo
         4QPamHqlKNoacpBugrGo675S3J3EC5wTtvG6cSEL+Yzpz6U3SWKLm3w/dNYuro8RxUKf
         yInv+XhGaOg08hE+InVgOGulh++zbpBt2aR83VboDfTtkJ5z34iVP+wl9hYznITgmqsR
         Dhoek/Siojp7SuYSW8QhdxhO40edvwcEwKQJZELsK1i/DLNwsRidMcS6bM5zsS+XSnBP
         jMwg2vUbAi22KV5g39CHEx4qjLro2oHB9B2Q7wXbiy6Xe9LysL9qpulCQvPOC2SR9Vzr
         +rdg==
X-Gm-Message-State: AOAM530LSsUNRBheCy19xS8gnGBk3uCkEUAbquC/U22VGq09yxC+1oUJ
        SRD0QNqVR7+BTu1iDGBKR9IL2ByG5uvHdvFiTXY=
X-Google-Smtp-Source: ABdhPJxhGwQ6pCOaqOQatkxg1LzUkfpdQWM7Q2QSqfBJrI/D5KFrXdQ0dhr5ajFjpIXpJR5yHoS9mg1LLM2qQFb0Nc0=
X-Received: by 2002:a9d:480d:: with SMTP id c13mr24350720otf.224.1595325623588;
 Tue, 21 Jul 2020 03:00:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200630045708.14166-1-alexandru.ardelean@analog.com>
 <20200630045708.14166-3-alexandru.ardelean@analog.com> <20200721094643.GA1598380@eriador.lumag.spb.ru>
In-Reply-To: <20200721094643.GA1598380@eriador.lumag.spb.ru>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Tue, 21 Jul 2020 13:00:11 +0300
Message-ID: <CA+U=DsqLAnXG0BZvXw5=_rUS_N-1qSs2Xxu7-x2qA2HH7pPyVA@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] iio: core: wrap IIO device into an iio_dev_opaque object
To:     Dmitry Baryshkov <dbaryshkov@gmail.com>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jul 21, 2020 at 12:47 PM Dmitry Baryshkov <dbaryshkov@gmail.com> wrote:
>
> Hello,
>
> On Tue, Jun 30, 2020 at 07:57:03AM +0300, Alexandru Ardelean wrote:
> > There are plenty of bad designs we want to discourage or not have to review
> > manually usually about accessing private (marked as [INTERN]) fields of
> > 'struct iio_dev'.
> >
> > Sometimes users copy drivers that are not always the best examples.
> >
> > A better idea is to hide those fields into the framework.
> > For 'struct iio_dev' this is a 'struct iio_dev_opaque' which wraps a public
> > 'struct iio_dev' object.
> >
> > In the next series, some fields will be moved to this new struct, each with
> > it's own rework.
>
> [skipped]
>
> >
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  drivers/iio/industrialio-core.c | 19 +++++++++++++------
> >  include/linux/iio/iio-opaque.h  | 17 +++++++++++++++++
> >  include/linux/iio/iio.h         |  6 +++++-
> >  3 files changed, 35 insertions(+), 7 deletions(-)
> >  create mode 100644 include/linux/iio/iio-opaque.h
> >
> > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> > index 75661661aaba..33e2953cf021 100644
> > --- a/drivers/iio/industrialio-core.c
> > +++ b/drivers/iio/industrialio-core.c
>
> [skipped]
>
> > @@ -1506,11 +1510,14 @@ struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv)
> >       /* ensure 32-byte alignment of whole construct ? */
> >       alloc_size += IIO_ALIGN - 1;
> >
> > -     dev = kzalloc(alloc_size, GFP_KERNEL);
> > -     if (!dev)
> > +     iio_dev_opaque = kzalloc(alloc_size, GFP_KERNEL);
> > +     if (!iio_dev_opaque)
> >               return NULL;
> >
> > -     dev->dev.parent = parent;
>
> This chunk (together with 8cb631ccbb1952b6422917f2ed16f760d84a762e and
> d3be83244c7dfe686d23f1c0bac75915587fc044) break devicetree bindings of
> IIO clients. After these changes there are no links between devicetree
> nodes and corresponding IIO channels. I'd kindly ask to restore this
> dev->dev.parent assignment (which restores of node binding).
>

Ack.
Will send a fix.
Thanks for catching this.
Apologies for the breakage.
It seems that I was tripping quite a bit with too many patchsets.


> > +     dev = &iio_dev_opaque->indio_dev;
> > +     dev->priv = (char *)iio_dev_opaque +
> > +             ALIGN(sizeof(struct iio_dev_opaque), IIO_ALIGN);
> > +
> >       dev->dev.groups = dev->groups;
> >       dev->dev.type = &iio_device_type;
> >       dev->dev.bus = &iio_bus_type;
>
> --
> With best wishes
> Dmitry
