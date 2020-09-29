Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D70B827BEF1
	for <lists+linux-iio@lfdr.de>; Tue, 29 Sep 2020 10:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbgI2IN7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Sep 2020 04:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI2IN5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 29 Sep 2020 04:13:57 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BEA2C061755;
        Tue, 29 Sep 2020 01:13:56 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id q21so3638969ota.8;
        Tue, 29 Sep 2020 01:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XCup1vGEgIO8d5dqKissyH4pLkKEy+8bhlwI7Fk/JgE=;
        b=PJsIvzsCo37C7ACdvZDANz7dBByHCqE+2UewKmT8tcfvrjNsHX80YlgzbFCcr5HYXx
         6N2S6KiHD+GdRRglVSF0I+HJ3nc3PF6h8gEoT9WtS4Z3tCsCBdlCD9+HwaYuTF49ttie
         NbyO6rubqvTgRsa4f7Heg2PfJfUbbgrLyZXoOJktwMIwQJ8txZwMmPwS2WQEgpSnik4b
         D9yzkXdcCbjW7C6EdZclYnV/3jDAjQdTV+nZ+WUksc0eKXzeJqlpeSQpkSiesBULXG32
         ouoDCU8Ful6wbbv6Xmjff25aOgiWx33ztUQ64zd0s+luAHlBHtSPSBGeUcRCkDNrYX63
         NAMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XCup1vGEgIO8d5dqKissyH4pLkKEy+8bhlwI7Fk/JgE=;
        b=of63Lk557eY+w3V4Q+XvckIzzcr1AyZr+yRuDy+QCVaCB1j7HQvFPdFsXj56e6G1LG
         PbCcIsxRXn1lRwI0Br1LZ8EkrxiFcVCTE24pHIVPBWsj5m/OpqMkt7BtJAYu/KnRnVR0
         1E5U+M0AZmrFHmIEFeMWaiETvjRHRnEX9y0mHm++dKD1BOR8jx/g0O9m6EeT87h4F4Nl
         XXLV+dOTqfDLenxSGOWKxgj7pibVbHo59aM7sFFPKXggH+bpD1QgZpSjLCHR2x2mpqb0
         bKe5CdwnYWzwhhV0q2cVPvpnBBCAUORWVPo7ftsET3v8kq61VLIcIBcXvIh5ZXTqsuMq
         ceEg==
X-Gm-Message-State: AOAM530aI++7sBvAKZgudj9flS4AdGNRMZlpa9O40wjiTu924ZgEFRcm
        C0OwvBuaUhp+GbpdQ2tFUGf+jAxW0qKfZDShoj1ndtG5r3U=
X-Google-Smtp-Source: ABdhPJwIl4voXZhuMAeIo5p6pCJJ4plObP3qKcN9I2JP8lusLk+mmggfoFHANVl5QMPSA+Q6ZDq2LEr9hblLYhSzQIc=
X-Received: by 2002:a9d:4d0:: with SMTP id 74mr1973157otm.119.1601367235571;
 Tue, 29 Sep 2020 01:13:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200929070908.10456-1-alexandru.ardelean@analog.com>
 <20200929070908.10456-2-alexandru.ardelean@analog.com> <CAHp75Ve_A_9ejG=sQKeLwEWWviLhZq1_L+WcTFk+=u8UGydKZw@mail.gmail.com>
In-Reply-To: <CAHp75Ve_A_9ejG=sQKeLwEWWviLhZq1_L+WcTFk+=u8UGydKZw@mail.gmail.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Tue, 29 Sep 2020 11:13:44 +0300
Message-ID: <CA+U=Dsp3SDEiKRF-VBS8FnW0q7TjArEiU1cjX-PxxdV8C3emjQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] iio: buffer: dmaengine: unwrap the use of iio_buffer_set_attrs()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        groeck@chromium.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Gwendal Grignou <gwendal@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Sep 29, 2020 at 10:49 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, Sep 29, 2020 at 10:09 AM Alexandru Ardelean
> <alexandru.ardelean@analog.com> wrote:
> >
> > The iio_buffer_set_attrs() helper will be removed in this series. So, just
> > assign the attributes of the DMAEngine buffer logic directly.
> >
> > This is IIO buffer core context, so there is direct access to the
> > buffer->attrs object.
> >
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > ---
> >  drivers/iio/buffer/industrialio-buffer-dmaengine.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> > index 93b4e9e6bb55..becea9f68181 100644
> > --- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> > +++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> > @@ -200,8 +200,7 @@ static struct iio_buffer *iio_dmaengine_buffer_alloc(struct device *dev,
> >
> >         iio_dma_buffer_init(&dmaengine_buffer->queue, chan->device->dev,
> >                 &iio_dmaengine_default_ops);
> > -       iio_buffer_set_attrs(&dmaengine_buffer->queue.buffer,
> > -               iio_dmaengine_buffer_attrs);
> > +       dmaengine_buffer->queue.buffer.attrs = iio_dmaengine_buffer_attrs;
> >
> >         dmaengine_buffer->queue.buffer.access = &iio_dmaengine_buffer_ops;
>
> A nit: can we group assignments together, like
> init()
> ...blank line...
> attr = ...
> access = ...

fine by me

>
> ?
>
> >
> > --
> > 2.17.1
> >
>
>
> --
> With Best Regards,
> Andy Shevchenko
