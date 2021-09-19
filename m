Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3F5C410C85
	for <lists+linux-iio@lfdr.de>; Sun, 19 Sep 2021 19:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbhISRJD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 Sep 2021 13:09:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:56092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229483AbhISRIz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 Sep 2021 13:08:55 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE07761028;
        Sun, 19 Sep 2021 17:07:27 +0000 (UTC)
Date:   Sun, 19 Sep 2021 18:11:08 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Mihail Chindris <mihail.chindris@analog.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        "Bogdan, Dragos" <dragos.bogdan@analog.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 4/6] drivers: iio: dac: ad5766: Fix dt property name
Message-ID: <20210919181108.41e61514@jic23-huawei>
In-Reply-To: <CA+U=Dsrm8daPO+0gob1USqSSxrkpCwR=L-2zQrW=DNEDk9ZhLA@mail.gmail.com>
References: <20210916182914.1810-1-mihail.chindris@analog.com>
        <20210916182914.1810-5-mihail.chindris@analog.com>
        <CA+U=Dsrm8daPO+0gob1USqSSxrkpCwR=L-2zQrW=DNEDk9ZhLA@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 17 Sep 2021 10:53:54 +0300
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> On Fri, Sep 17, 2021 at 9:11 AM Mihail Chindris
> <mihail.chindris@analog.com> wrote:
> >
> > In the documentation the name for the property is
> > output-range-microvolts which is a standard name, therefore this name
> > must be used.
> >  
> 
> This requires a Fixes tag.
> With that addressed:
> 
> Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>

Good catch. These cases are always a mess. 
As the binding doc went in with the driver, there should have been no window
in which anyone who was actually checking their DTS files against the yaml could
have this wrong. Hopefully that means we don't have any broken ones out there in the wild

As this is binding related, sensible to cc Rob and the dt list.
+CC


> 
> > Signed-off-by: Mihail Chindris <mihail.chindris@analog.com>
> > ---
> >  drivers/iio/dac/ad5766.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/iio/dac/ad5766.c b/drivers/iio/dac/ad5766.c
> > index 3104ec32dfac..dafda84fdea3 100644
> > --- a/drivers/iio/dac/ad5766.c
> > +++ b/drivers/iio/dac/ad5766.c
> > @@ -503,13 +503,13 @@ static int ad5766_get_output_range(struct ad5766_state *st)
> >         int i, ret, min, max, tmp[2];
> >
> >         ret = device_property_read_u32_array(&st->spi->dev,
> > -                                            "output-range-voltage",
> > +                                            "output-range-microvolts",
> >                                              tmp, 2);
> >         if (ret)
> >                 return ret;
> >
> > -       min = tmp[0] / 1000;
> > -       max = tmp[1] / 1000;
> > +       min = tmp[0] / 1000000;
> > +       max = tmp[1] / 1000000;
> >         for (i = 0; i < ARRAY_SIZE(ad5766_span_tbl); i++) {
> >                 if (ad5766_span_tbl[i].min != min ||
> >                     ad5766_span_tbl[i].max != max)
> > --
> > 2.27.0
> >  

