Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED22A445962
	for <lists+linux-iio@lfdr.de>; Thu,  4 Nov 2021 19:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234093AbhKDSNU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 4 Nov 2021 14:13:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:55758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234102AbhKDSNP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 4 Nov 2021 14:13:15 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9989E60EC0;
        Thu,  4 Nov 2021 18:10:35 +0000 (UTC)
Date:   Thu, 4 Nov 2021 18:15:10 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     lars@metafoo.de, swboyd@chromium.org, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/5] iio: proximity: Add SX9324 support
Message-ID: <20211104181510.2a4f31ed@jic23-huawei>
In-Reply-To: <CAPUE2utpxe098AZEkAKnJDte7Kv8v3R44w71b0Tdba+vXskv2w@mail.gmail.com>
References: <20211030111827.1494139-1-gwendal@chromium.org>
        <20211030111827.1494139-4-gwendal@chromium.org>
        <20211030180423.6451830e@jic23-huawei>
        <CAPUE2utpxe098AZEkAKnJDte7Kv8v3R44w71b0Tdba+vXskv2w@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

> > > +static ssize_t sx9324_phase_configuration_store(struct device *dev,
> > > +                                             struct device_attribute *attr,
> > > +                                             const char *buf,
> > > +                                             size_t len)
> > > +{
> > > +     return -EINVAL;  
> >
> > Don't do this. If they are read only treat them correctly as such
> > with appropriate permissions etc.  
> used channel .ext_info instead.

Even better.

> >  
> > > +}
> > > +
> > > +#define IIO_DEV_ATTR_PHASE_CONFIG(_idx) \
> > > +IIO_DEVICE_ATTR(in_proximity_configuration##_idx, 0644, \
> > > +             sx9324_phase_configuration_show, \
> > > +             sx9324_phase_configuration_store, _idx)
> > > +
> > > +static IIO_DEV_ATTR_PHASE_CONFIG(0);
> > > +static IIO_DEV_ATTR_PHASE_CONFIG(1);
> > > +static IIO_DEV_ATTR_PHASE_CONFIG(2);
> > > +static IIO_DEV_ATTR_PHASE_CONFIG(3);  
> >
> > Documentation of these? I'm not going to comment on them without appropriate
> > docs in
> >
> > Documentation/ABI/testing/
> >
> > Just wastes time figuring out what they are.  
> It is not easy to explain without the doc (not released by semtech but
> available at https://edit.wpgdadawant.com/uploads/news_file/program/2019/30184/tech_files/program_30184_suggest_other_file.pdf),
> but let me try:
> 
> Each sensor has 3 inputs, CS0, CS1 and CS2. Hardware engineers decide
> if the input is not connected (HZ), grounded (GD), connected to an
> antenna where it can act as a base (DS - data shield), or measured
> input (MI).
> The sensor rotates measurement across 4 phases (PH0, PH1, PH2, PH3),
> where the inputs are configured and then measured.
> By default,  during the first phase, [PH0], CS0 is measured, while CS1
> and CS2 are used as shields. `cat in_proximity0_mode` returns
> "MI,DS,DS".
> I did not make this change configurable: if the hardware designer
> decided to ground or leave an input dangling, it does not make sense
> to set it as a shield. [it can be changed if the need arises].
> Having 4 phases allows different treatment of the input. For instance,
> one phase could be used for object detection,the other for body
> detection. Configuring each phase is not implemented yet.
Ah. I read the emails backwards, this explanation is good - it's a
combination of 'what is wired' and what you are trying to measure.

> 
> Add missing documentation in ABI/testing/sysfs-bus-iio-sx9324.
