Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7648345033D
	for <lists+linux-iio@lfdr.de>; Mon, 15 Nov 2021 12:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbhKOLPb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Nov 2021 06:15:31 -0500
Received: from mga02.intel.com ([134.134.136.20]:23733 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230456AbhKOLPa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 15 Nov 2021 06:15:30 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10168"; a="220631468"
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; 
   d="scan'208";a="220631468"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 03:12:35 -0800
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; 
   d="scan'208";a="535475373"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 03:12:33 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mmZuS-0072To-Vi;
        Mon, 15 Nov 2021 13:12:24 +0200
Date:   Mon, 15 Nov 2021 13:12:24 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Yang Yingliang <yangyingliang@huawei.com>
Subject: Re: [PATCH v2 0/2] iio: buffer: allocation and freeing buffers fix
 and optimization
Message-ID: <YZJAmCsnD2QRNoCs@smile.fi.intel.com>
References: <20211013094923.2473-1-andriy.shevchenko@linux.intel.com>
 <20211017152611.13fb0357@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211017152611.13fb0357@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Oct 17, 2021 at 03:26:11PM +0100, Jonathan Cameron wrote:
> On Wed, 13 Oct 2021 12:49:21 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > Yang submitted a fix, but I think the code can be refactored a bit to be more
> > robust against similar mistakes in the future, if any.
> > 
> > In v2:
> > - put SoB Yang's patch (it's good for backporting)
> > - added refactoring patch on top of Yang's fix
> > 
> > Andy Shevchenko (1):
> >   iio: buffer: Use dedicated variable in
> >     iio_buffers_alloc_sysfs_and_mask()
> > 
> > Yang Yingliang (1):
> >   iio: buffer: Fix double-free in iio_buffers_alloc_sysfs_and_mask()
> > 
> >  drivers/iio/industrialio-buffer.c | 18 +++++++-----------
> >  1 file changed, 7 insertions(+), 11 deletions(-)
> > 
> 1st patch applied to the fixes-togreg branch of iio.git. I may well end up
> sending these in the merge window anyway in which case I'll probably stick patch 2
> on top of it before sending.  If not I'll pick that up next cycle now.

Is it a right time now?

-- 
With Best Regards,
Andy Shevchenko


