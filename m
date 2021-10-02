Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7C941FCF3
	for <lists+linux-iio@lfdr.de>; Sat,  2 Oct 2021 18:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233529AbhJBQIg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 2 Oct 2021 12:08:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:41558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232575AbhJBQIc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 2 Oct 2021 12:08:32 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFCDB60FA0;
        Sat,  2 Oct 2021 16:06:45 +0000 (UTC)
Date:   Sat, 2 Oct 2021 17:10:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kamel Bouhara <kamel.bouhara@bootlin.com>
Subject: Re: [PATCH] counter: microchip-tcb-capture: Tidy up a false
 kernel-doc /** marking.
Message-ID: <20211002171043.427a2b09@jic23-huawei>
In-Reply-To: <YVZtgkZQi3Vbqx4e@shinobu>
References: <20210930170347.101153-1-jic23@kernel.org>
        <YVZtgkZQi3Vbqx4e@shinobu>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 1 Oct 2021 11:08:02 +0900
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> On Thu, Sep 30, 2021 at 06:03:47PM +0100, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Deals with
> > W=1 warning This comment starts with '/**', but isn't a kernel-doc comment.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Kamel Bouhara <kamel.bouhara@bootlin.com>
> > Cc: William Breathitt Gray <vilhelm.gray@gmail.com>  
> 
> Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
Applied.

Thanks,

Jonathan

> 
> > ---
> >  drivers/counter/microchip-tcb-capture.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/microchip-tcb-capture.c
> > index 79e0c84a3b81..0ab1b2716784 100644
> > --- a/drivers/counter/microchip-tcb-capture.c
> > +++ b/drivers/counter/microchip-tcb-capture.c
> > @@ -1,5 +1,5 @@
> >  // SPDX-License-Identifier: GPL-2.0-only
> > -/**
> > +/*
> >   * Copyright (C) 2020 Microchip
> >   *
> >   * Author: Kamel Bouhara <kamel.bouhara@bootlin.com>
> > -- 
> > 2.33.0
> >   

