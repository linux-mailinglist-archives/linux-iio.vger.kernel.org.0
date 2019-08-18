Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01C6991941
	for <lists+linux-iio@lfdr.de>; Sun, 18 Aug 2019 21:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfHRT1L (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Aug 2019 15:27:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:45554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726005AbfHRT1L (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 18 Aug 2019 15:27:11 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDD0C2184E;
        Sun, 18 Aug 2019 19:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566156429;
        bh=zBUhARBmOXI6h0lyRpeDF9P3Js+wgl8uEXqldayuRZ0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xCbFrwnx0vDVs0ZG3GEUXrdMwWjj5qsHXX5c8Z3YfmEMxx2/6nvfthMFrfWPpxP5w
         /iCTuVaMlkVChFk5lzqVFpcYBGlO2XD3jqiGDyUClrLO5qUdsIrVSOrmg7utSILhU8
         5amjwXGHcDoeLqpi6UXm6HaX2AHJaV7v/cwHUdM0=
Date:   Sun, 18 Aug 2019 20:27:04 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        freeman.liu@unisoc.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-iio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: sc27xx: Change to polling mode to read data
Message-ID: <20190818202704.69e95a4d@archlinux>
In-Reply-To: <CAMz4ku+ansL1RJScmJRsvKR-dJVLNjAZqgTFqRSEJWQSYUy_Sg@mail.gmail.com>
References: <1870ea18729f93fb36694affaf7e9443733dd988.1564035575.git.baolin.wang@linaro.org>
        <20190727182709.037fc595@archlinux>
        <CAMz4kuLLSYw0JRLRVN-JegxZcK1bdv4K2m4mVu7oep6xfb+xxg@mail.gmail.com>
        <20190805145037.0a03f21e@archlinux>
        <CAMz4kuK4GFfOi3vGvFOLdRfmqrwVLDs5CN+Xp_it3jG4=iKi=w@mail.gmail.com>
        <20190811090251.5fbd7d75@archlinux>
        <CAMz4ku+ansL1RJScmJRsvKR-dJVLNjAZqgTFqRSEJWQSYUy_Sg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 12 Aug 2019 10:37:44 +0800
Baolin Wang <baolin.wang@linaro.org> wrote:

> On Sun, 11 Aug 2019 at 16:03, Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Tue, 6 Aug 2019 15:39:45 +0800
> > Baolin Wang <baolin.wang@linaro.org> wrote:
> >  
> > > Hi Jonathan,
> > >
> > > On Mon, 5 Aug 2019 at 21:50, Jonathan Cameron <jic23@kernel.org> wrote:  
> > > >
> > > > On Mon, 29 Jul 2019 10:19:48 +0800
> > > > Baolin Wang <baolin.wang@linaro.org> wrote:
> > > >  
> > > > > Hi Jonathan,
> > > > >
> > > > > On Sun, 28 Jul 2019 at 01:27, Jonathan Cameron <jic23@kernel.org> wrote:  
> > > > > >
> > > > > > On Thu, 25 Jul 2019 14:33:50 +0800
> > > > > > Baolin Wang <baolin.wang@linaro.org> wrote:
> > > > > >  
> > > > > > > From: Freeman Liu <freeman.liu@unisoc.com>
> > > > > > >
> > > > > > > On Spreadtrum platform, the headphone will read one ADC channel multiple
> > > > > > > times to identify the headphone type, and the headphone identification is
> > > > > > > sensitive of the ADC reading time. And we found it will take longer time
> > > > > > > to reading ADC data by using interrupt mode comparing with the polling
> > > > > > > mode, thus we should change to polling mode to improve the efficiency
> > > > > > > of reading data, which can identify the headphone type successfully.
> > > > > > >
> > > > > > > Signed-off-by: Freeman Liu <freeman.liu@unisoc.com>
> > > > > > > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>  
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > My concerns with this sort of approach is that we may be sacrificing power
> > > > > > efficiency for some usecases to support one demanding one.
> > > > > >
> > > > > > The maximum sleep time is 1 second (I think) which is probably too long
> > > > > > to poll a register for in general.  
> > > > >
> > > > > 1 second is the timeout time, that means something wrong when reading
> > > > > the data taking 1 second, and we will poll the register status every
> > > > > 500 us.
> > > > > From the testing, polling mode takes less time than interrupt mode
> > > > > when reading ADC data multiple times, so polling mode did not
> > > > > sacrifice power
> > > > > efficiency.  
> > > >
> > > > Hmm.  I'll go with a probably on that, depends on interrupt response
> > > > latency etc so isn't entirely obvious.  Faster response doesn't necessarily
> > > > mean lower power.
> > > >  
> > > > >  
> > > > > > Is there some way we can bound that time and perhaps switch between
> > > > > > interrupt and polling modes depending on how long we expect to wait?  
> > > > >
> > > > > I do not think the interrupt mode is needed any more, since the ADC
> > > > > reading is so fast enough usually. Thanks.  
> > > > The reason for interrupts in such devices is usually precisely the opposite.
> > > >
> > > > You do it because things are slow enough that you can go to sleep
> > > > for a long time before the interrupt occurs.
> > > >
> > > > So question becomes whether there are circumstances in which we are
> > > > running with long timescales and would benefit from using interrupts.  
> > >
> > > From our testing, the ADC version time is usually about 100us, it will
> > > be faster to get data if we poll every 50us in this case. But if we
> > > change to use interrupt mode, it will take millisecond level time to
> > > get data. That will cause problems for those time sensitive scenarios,
> > > like headphone detection, that's the main reason we can not use
> > > interrupt mode.
> > >
> > > For those non-time-sensitive scenarios, yes, I agree with you, the
> > > interrupt mode will get a better power efficiency. But ADC driver can
> > > not know what scenarios asked by consumers, so changing to polling
> > > mode seems the easiest way to solve the problem, and we've applied
> > > this patch in our downstream kernel for a while, we did not see any
> > > other problem.
> > >
> > > Thanks for your comments.  
> >
> > OK. It's not ideal but sometimes such is life ;)  
> 
> Thanks for your understanding :)
> 
> >
> > So last question - fix or not?  If a fix, can I have a fixes tag
> > please.  
> 
> This is a bigger patch, I am afraid it can not be merged into stable
> kernel, and original code can work at most scenarios. So I think no
> need add stable tag for this patch. Thanks.
> 
Fair enough.  Needed a bit of merge effort as crossed with a generic
cleanup patch it seems.

Anyhow, hopefully I got it right.

Pushed out as testing for the autobuilders to play with it.

Thanks,

Jonathan

