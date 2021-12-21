Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D84D747BFE4
	for <lists+linux-iio@lfdr.de>; Tue, 21 Dec 2021 13:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237780AbhLUMkJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Dec 2021 07:40:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237778AbhLUMkH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Dec 2021 07:40:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD36C061401
        for <linux-iio@vger.kernel.org>; Tue, 21 Dec 2021 04:40:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 43976B8167D
        for <linux-iio@vger.kernel.org>; Tue, 21 Dec 2021 12:40:05 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id D2ED4C36AEB;
        Tue, 21 Dec 2021 12:40:01 +0000 (UTC)
Date:   Tue, 21 Dec 2021 12:45:36 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>, swboyd@chromium.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v8 2/5] iio: sx9310: Extract common Semtech sensor logic
Message-ID: <20211221124536.5250d5a3@jic23-huawei>
In-Reply-To: <CAHp75Vf_4nRXZ66_EwLU+wrK278Hb+z3ZOtRnQ_1PqCQ_Mcceg@mail.gmail.com>
References: <20211218001755.3096807-1-gwendal@chromium.org>
        <20211218001755.3096807-3-gwendal@chromium.org>
        <CAHp75Vf_4nRXZ66_EwLU+wrK278Hb+z3ZOtRnQ_1PqCQ_Mcceg@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 18 Dec 2021 15:54:05 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sat, Dec 18, 2021 at 11:58 AM Gwendal Grignou <gwendal@chromium.org> wrote:
> >
> > Before adding new Semtech sensors, move common logic to all Semtech SAR
> > sensor in its own file:
> > - interface with IIO subsystem,
> > - interrupt management,
> > - channel access conrol,
> > - event processing.
> >
> > The change adds a bidirectional interface between sx93xx and sx_common.  
> 
> ...
> 
> > +/* All Semtech SAR sensor have IRQ bit in same order. */  
> 
> sensors
> in the same
> 
> ...
> 
> > +EXPORT_SYMBOL_GPL(sx_common_events);  
> 
> Here and in other places, can we switch to NS variants of the
> EXPORT_SYMBOL_GPL()?

We haven't yet done this for similar cases, but I agree it is
definitely a nice to have when we have a helper / core module
like this.  Given the editorial stuff in here means Gwendal
is going to be rolling a v9 this seems a good time to start.

As time allows we'll look to convert over similar modules in the
general interests of reducing namespace pollution.

Ultimately I'd like to move the IIO core to a namespace as well
but that is a messy job and there are several things ahead of
if that will cause mass driver churn.

Jonathan


> 
> ...
> 
> > +/**
> > + * sx_common_probe() - Common setup for Semtech SAR sensor  
> 
> > + *  
> 
> Here and in all similar cases, remove this redundant blank line.
> 
> > + * @client:            I2C client object
> > + * @chip_info:         Semtech sensor chip information.
> > + * @regmap_config:     Sensor registers map configuration.
> > + */  
> 
> ...
> 
> > +#include <linux/types.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/types.h>
> > +#include <linux/regulator/consumer.h>  
> 
> Perhaps grouped and ordered?
> 
> + blank line.
> 
> > +struct device;
> > +struct i2c_client;
> > +struct regmap_config;
> > +struct sx_common_data;  
> 
> ...
> 
> > + * @num_channels:      Number of channel/phase.  
> 
> channels or phases
> 
> ...
> 
> > + * @buffer:            Bufffer to store raw samples.  
> 
> Buffer
> 
> 

