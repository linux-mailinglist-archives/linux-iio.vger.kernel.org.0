Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC000351EBE
	for <lists+linux-iio@lfdr.de>; Thu,  1 Apr 2021 20:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235115AbhDASqG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Apr 2021 14:46:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:35182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235778AbhDASnC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 1 Apr 2021 14:43:02 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C22761364;
        Thu,  1 Apr 2021 15:05:47 +0000 (UTC)
Date:   Thu, 1 Apr 2021 16:05:57 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mugilraj D <dmugil2000@gmail.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: bcm_iproc_adc: Use %s and __func__
Message-ID: <20210401160557.533bae90@jic23-huawei>
In-Reply-To: <a2ac91a9-54e3-2525-1e7e-00a26d3393e3@gmail.com>
References: <20210401062517.28832-1-dmugil2000@gmail.com>
        <CAHp75VfgL0KW0fetgE3NuBb4itMK1oY+yLmr1xDYkn390hCscg@mail.gmail.com>
        <20210401113015.00006b70@Huawei.com>
        <a2ac91a9-54e3-2525-1e7e-00a26d3393e3@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 1 Apr 2021 20:22:47 +0530
Mugilraj D <dmugil2000@gmail.com> wrote:

> On 01/04/21 4:00 pm, Jonathan Cameron wrote:
> > On Thu, 1 Apr 2021 12:24:50 +0300
> > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> >   
> >> On Thu, Apr 1, 2021 at 9:27 AM Mugilraj Dhavachelvan
> >> <dmugil2000@gmail.com> wrote:  
> >>>
> >>> Change function's name to %s and __func__ to fix checkpatch.pl errors.    
> >>
> >> No, just drop the __func__ completely. First of all, we have a device
> >> name, and uniqueness of the messages in the driver should guarantee
> >> easy findings. Second, specific to _dbg() variants, with enabled
> >> Dynamic Debug it can be chosen at run time!
> >>
> >> I recommend going through all drivers and drop __func__ near to
> >> dev_dbg() and pr_debug().
> >>  
> > 
> > Agreed.  Though beware that some maintainers will count this
> > as noise and get grumpy.
> > 
> > I'm fine with such patches for IIO.  
> 
> Sorry for the noise. I just seen the docs about dynamic debug.
> So, if we use dev_dbg("log_msg") it will print statement like
> filename:lineno [module]func flag log_msg, If I get it correctly.
> And no need of specifying __func__ in dev_dbg() and dp_dbg() right!!
> 
> Jonathan do you have any TODO's?

I tend not to mind cleanup patches (within reason)in IIO so I'm absolutely
fine with a series removing any __func__ items like this.  One patch per
driver preferred because it avoids issues with this interfering with backports
etc. There will end up being about 18 patches from a quick grep.  Perhaps send
a small number first though to avoid having to put in too much effort as
any issues likely to affect the whole set.

Just be careful with other maintainers, they sometimes strike a different
balance for what they consider noise vs useful.  

Jonathan

> 
> > 
> > Jonathan
> >   

