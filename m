Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C393B3A9C1B
	for <lists+linux-iio@lfdr.de>; Wed, 16 Jun 2021 15:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233314AbhFPNlT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Jun 2021 09:41:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:41196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233306AbhFPNlS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 16 Jun 2021 09:41:18 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 908B661241;
        Wed, 16 Jun 2021 13:39:07 +0000 (UTC)
Date:   Wed, 16 Jun 2021 14:41:08 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ye Xiang <xiang.ye@intel.com>, linux-input@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alessandro Zummo <a.zummo@towertech.it>
Subject: Re: [PATCH v2 1/1] iio: hid-sensors: lighten exported symbols by
 moving to IIO_HID namespace
Message-ID: <20210616144108.3771d4b2@jic23-huawei>
In-Reply-To: <YMnzlGDQn2s1vuKz@smile.fi.intel.com>
References: <20210614162447.5392-1-andriy.shevchenko@linux.intel.com>
        <YMfDBhM52iyM0eFU@piout.net>
        <20210616134153.1007b5cf@jic23-huawei>
        <YMnzlGDQn2s1vuKz@smile.fi.intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 16 Jun 2021 15:50:28 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Wed, Jun 16, 2021 at 01:41:53PM +0100, Jonathan Cameron wrote:
> > On Mon, 14 Jun 2021 22:58:46 +0200
> > Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:
> >   
> > > On 14/06/2021 19:24:47+0300, Andy Shevchenko wrote:  
> > > > A namespace for exported symbols makes clear who is a provider
> > > > and who is a consumer of the certain resources. Besides that,
> > > > it doesn't pollute the common namespace.
> > > > 
> > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>    
> > > Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>  
> > 
> > Thanks,  applied to the togreg branch of iio.git and pushed out as
> > testing for 0-day to poke at it  
> 
> Thanks!
> 
> > and see if we missed anything.  
> 
> Hopefully nothing in the code.
> 
> What I have missed is the Ack from Srinivas. Can you add it later on?
> 

Done which was easy because I hadn't pushed it out anywhere yet!

Jonathan


