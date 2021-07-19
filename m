Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B71C3CD41A
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jul 2021 13:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbhGSLHt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Jul 2021 07:07:49 -0400
Received: from mga01.intel.com ([192.55.52.88]:64303 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230493AbhGSLHs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 19 Jul 2021 07:07:48 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10049"; a="232810505"
X-IronPort-AV: E=Sophos;i="5.84,252,1620716400"; 
   d="scan'208";a="232810505"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 04:48:27 -0700
X-IronPort-AV: E=Sophos;i="5.84,252,1620716400"; 
   d="scan'208";a="494039926"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 04:48:25 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1m5Rkw-00FUxJ-MN; Mon, 19 Jul 2021 14:48:18 +0300
Date:   Mon, 19 Jul 2021 14:48:18 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        vlad.dogaru@intel.com, linux-kernel <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Andrea Merello <andrea.merello@iit.it>
Subject: Re: [PATCH 2/4] iio: imu: add Bosch Sensortec BNO055 core driver
Message-ID: <YPVmgpmWkagk+ngf@smile.fi.intel.com>
References: <20210715141742.15072-1-andrea.merello@gmail.com>
 <20210715141742.15072-3-andrea.merello@gmail.com>
 <CAHp75Vf_Og2wjRy2j0gC37DgR0x9B_F5iSUj8VOtWkhWjgiOag@mail.gmail.com>
 <CAN8YU5MFMqh3wZo-yOOE8och3x089kYWjtrr83Jt8wCQTKFE8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN8YU5MFMqh3wZo-yOOE8och3x089kYWjtrr83Jt8wCQTKFE8Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jul 19, 2021 at 11:02:07AM +0200, Andrea Merello wrote:
> Il giorno gio 15 lug 2021 alle ore 18:50 Andy Shevchenko
> <andy.shevchenko@gmail.com> ha scritto:
> 
> >
> > > +/* must be called in configuration mode */
> > > +int bno055_calibration_load(struct bno055_priv *priv, const struct firmware *fw)
> > > +{
> > > +       int i;
> > > +       unsigned int tmp;
> > > +       u8 cal[BNO055_CALDATA_LEN];
> > > +       int read, tot_read = 0;
> > > +       int ret = 0;
> > > +       char *buf = kmalloc(fw->size + 1, GFP_KERNEL);
> > > +
> > > +       if (!buf)
> > > +               return -ENOMEM;
> > > +
> > > +       memcpy(buf, fw->data, fw->size);
> >
> > kmemdup() ?
> >
> 
> As a second thought: no, the whole point of reallocating and copying
> here, is that we want to allocate an extra byte; kmemdup() will
> allocate and copy only the very same amount of memory

kmemdup_nul() then.


-- 
With Best Regards,
Andy Shevchenko


