Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 584EF25BD1A
	for <lists+linux-iio@lfdr.de>; Thu,  3 Sep 2020 10:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgICIWx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Sep 2020 04:22:53 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2745 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726162AbgICIWx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 3 Sep 2020 04:22:53 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id CCE998D1EEF503361E2B;
        Thu,  3 Sep 2020 09:22:51 +0100 (IST)
Received: from localhost (10.52.126.121) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 3 Sep 2020
 09:22:51 +0100
Date:   Thu, 3 Sep 2020 09:21:18 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-iio@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v1 1/8] iio: accel: bma220: Fix returned codes from
 bma220_init(), bma220_deinit()
Message-ID: <20200903092118.00001f79@Huawei.com>
In-Reply-To: <20200831151201.076c0f94@archlinux>
References: <20200831090813.78841-1-andriy.shevchenko@linux.intel.com>
        <20200831102145.0eaebb77@archlinux>
        <20200831114904.GH1891694@smile.fi.intel.com>
        <20200831151201.076c0f94@archlinux>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.126.121]
X-ClientProxiedBy: lhreml738-chm.china.huawei.com (10.201.108.188) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 31 Aug 2020 15:12:01 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Mon, 31 Aug 2020 14:49:04 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > On Mon, Aug 31, 2020 at 10:21:45AM +0100, Jonathan Cameron wrote:  
> > > On Mon, 31 Aug 2020 12:08:06 +0300
> > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > >     
> > > > Potentially bma220_init() and bma220_deinit() may return positive codes.
> > > > Fix the logic to return proper error codes instead.
> > > > 
> > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>    
> > > Hi Andy
> > > 
> > > A nice straight forward set and I suspect we aren't going to get any other
> > > reviews, hence...
> > > 
> > > Series applied to the togreg branch of iio.git and pushed out as testing for
> > > the autobuilders to poke at it.    
> > 
> > Thanks!
> > 
> > P.S. Consider this series as an example what can be done to many IIO drivers
> > in order to clean them up. My focus, of course, ACPI interaction:
> >  - use of ACPI_PTR / ifdeffery
> >  - inclusion of acpi.h
> >  - ...
> >   
> 
> Thanks.  This is probably a good one for anyone who wants to grow their
> experience in kernel patches etc.  I'll add it to my more or less
> never ending list if not and get to it eventually.
> 
> In the meantime we'll try to avoid introducing any new variants!
> 
> Jonathan

Andy, one thing that might want adjusting is the docs that suggest
doing ACPI_PTR and ifdeffery.

https://elixir.bootlin.com/linux/v5.9-rc3/source/Documentation/firmware-guide/acpi/enumeration.rst#L254

J

