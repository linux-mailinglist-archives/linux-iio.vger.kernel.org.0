Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5AB3FAC45
	for <lists+linux-iio@lfdr.de>; Sun, 29 Aug 2021 16:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbhH2Og1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Aug 2021 10:36:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:47622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229824AbhH2Og0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 29 Aug 2021 10:36:26 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D28C6023D;
        Sun, 29 Aug 2021 14:35:30 +0000 (UTC)
Date:   Sun, 29 Aug 2021 15:38:45 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Liam Beguin" <liambeguin@gmail.com>
Cc:     "Andy Shevchenko" <andy.shevchenko@gmail.com>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        "Michael Hennerich" <Michael.Hennerich@analog.com>,
        "Charles-Antoine Couret" <charles-antoine.couret@essensium.com>,
        Nuno =?UTF-8?B?U8Oh?= <Nuno.Sa@analog.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "linux-iio" <linux-iio@vger.kernel.org>,
        "devicetree" <devicetree@vger.kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>
Subject: Re: [PATCH v6 0/5] AD7949 Fixes
Message-ID: <20210829153845.0c7eda30@jic23-huawei>
In-Reply-To: <CDKYEMJOURHJ.2U1JRK17FRGD0@shaak>
References: <20210815213309.2847711-1-liambeguin@gmail.com>
        <CAHp75VdOMg-7xX+KbdaDt5tduPhorujFwvpMPmdHKMVg=vj2Ew@mail.gmail.com>
        <CDKYEMJOURHJ.2U1JRK17FRGD0@shaak>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 16 Aug 2021 08:59:28 -0400
"Liam Beguin" <liambeguin@gmail.com> wrote:

> On Mon Aug 16, 2021 at 4:08 AM EDT, Andy Shevchenko wrote:
> > On Mon, Aug 16, 2021 at 12:35 AM Liam Beguin <liambeguin@gmail.com>
> > wrote:  
> > >
> > > While working on another series[1] I ran into issues where my SPI
> > > controller would fail to handle 14-bit and 16-bit SPI messages. This
> > > addresses that issue and adds support for selecting a different voltage
> > > reference source from the devicetree.
> > >
> > > v1 was base on a series[2] that seems to not have made it all the way,
> > > and was tested on an ad7689.
> > >
> > > v6 drops support for per channel vref selection.
> > > After switching the voltage reference, readings take a little while to
> > > stabilize, invalidating consecutive readings.
> > >
> > > This could've been addressed by adding more dummy cycles at the expense
> > > of speed, but discussing the issue with colleagues more involved in
> > > hardware design, it turns out these circuits are usually designed with a
> > > single vref in mind.
> > >
> > > [1] https://patchwork.kernel.org/project/linux-iio/list/?series=511545
> > > [2] https://patchwork.kernel.org/project/linux-iio/list/?series=116971&state=%2A&archive=both
> > >
> > > Changes since v5:
> > > - rename defines: s/AD7949_CFG_BIT_/AD7949_CFG_MASK_/g
> > > - rename AD7949_MASK_TOTAL to match other defines  
> >  
> > > - make vref selection global instead of per channel, and update
> > >   dt-bindings  
> 
> Hi Andy,
> 
> >
> > Same as per v5: is it a hardware limitation?
> > It's unclear to me what happened here.  
> 
> I tried to provide more details in the last paragraph above.
> 
> After switching the voltage reference, readings take a little while to
> stabilize invalidating consecutive readings.
> 
> One option was to add more dummy cycles, but in addition to making
> things slower it was brought to my attention that this kind of circuit
> is usually designed with a single vref in mind.
> 
> For those reasons and because I didn't have an explicit need for it, I
> decided to drop that part.

It's not 'impossible' to add it back in later if someone needs it, but
until then this works for me.

Series applied with tweaks as described in individual patch replies.

Thanks,

Jonathan

> 
> Liam
> 
> >  
> > > - reword commits 2/5, 3/5, and 4/5
> > > - move bits_per_word configuration to struct spi_device, and switch to
> > >   spi_{read,write}.  
> >
> > --
> > With Best Regards,
> > Andy Shevchenko  
> 

