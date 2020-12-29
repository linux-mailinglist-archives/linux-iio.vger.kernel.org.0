Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7322E7162
	for <lists+linux-iio@lfdr.de>; Tue, 29 Dec 2020 15:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgL2O3l (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Dec 2020 09:29:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:56612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbgL2O3k (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 29 Dec 2020 09:29:40 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7746A20825;
        Tue, 29 Dec 2020 14:28:59 +0000 (UTC)
Date:   Tue, 29 Dec 2020 14:28:56 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: sc27xx_adc: Use DIV_ROUND_CLOSEST() instead of
 open-coding it
Message-ID: <20201229142856.3e5fbf10@archlinux>
In-Reply-To: <CAAfSe-vy6Hv1Zxa+z+9dneGtamJOJ-_fu8VcJTm7EshnNfWTfw@mail.gmail.com>
References: <20201222191618.3433-1-lars@metafoo.de>
        <CAAfSe-vy6Hv1Zxa+z+9dneGtamJOJ-_fu8VcJTm7EshnNfWTfw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 23 Dec 2020 13:39:24 +0800
Chunyan Zhang <zhang.lyra@gmail.com> wrote:

> On Wed, 23 Dec 2020 at 03:16, Lars-Peter Clausen <lars@metafoo.de> wrote:
> >
> > Use DIV_ROUND_CLOSEST() instead of open-coding it. This makes it more clear
> > what is going on for the casual reviewer.
> >
> > Generated using the following the Coccinelle semantic patch.
> >
> > // <smpl>
> > @@
> > expression x, y;
> > @@
> > -((x) + ((y) / 2)) / (y)
> > +DIV_ROUND_CLOSEST(x, y)
> > // </smpl>
> >
> > Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>  
> 
> Acked-by: Chunyan Zhang <zhang.lyra@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan

> 
> Thanks,
> Chunyan
> 
> > ---
> >  drivers/iio/adc/sc27xx_adc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
> > index aa32a1f385e2..301cf66de695 100644
> > --- a/drivers/iio/adc/sc27xx_adc.c
> > +++ b/drivers/iio/adc/sc27xx_adc.c
> > @@ -307,7 +307,7 @@ static int sc27xx_adc_convert_volt(struct sc27xx_adc_data *data, int channel,
> >
> >         sc27xx_adc_volt_ratio(data, channel, scale, &numerator, &denominator);
> >
> > -       return (volt * denominator + numerator / 2) / numerator;
> > +       return DIV_ROUND_CLOSEST(volt * denominator, numerator);
> >  }
> >
> >  static int sc27xx_adc_read_processed(struct sc27xx_adc_data *data,
> > --
> > 2.20.1
> >  

