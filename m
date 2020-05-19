Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6453A1D933E
	for <lists+linux-iio@lfdr.de>; Tue, 19 May 2020 11:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgESJWN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 May 2020 05:22:13 -0400
Received: from mga14.intel.com ([192.55.52.115]:39906 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbgESJWM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 19 May 2020 05:22:12 -0400
IronPort-SDR: a+Zo8fZcTo/WVeqQdOd9OmpMIERmZq7unbZhy01Od9lGvy0+rhfpKDG5IsPqr41fDybxBSCCTc
 Lr0niFdadg6w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2020 02:22:11 -0700
IronPort-SDR: 8j68tHuc1QcJNBPZx5GrAM4yqAJBRFFpuCf4oXE/synt8I1biu4iTX9PLv8aTXqXp5xPWJAWqC
 APxMp1AlF1Zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,409,1583222400"; 
   d="scan'208";a="373669435"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001.fm.intel.com with ESMTP; 19 May 2020 02:22:09 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jayRw-007bhX-1i; Tue, 19 May 2020 12:22:12 +0300
Date:   Tue, 19 May 2020 12:22:12 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Albrieux <jonathan.albrieux@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 0/3] iio: magnetometer: ak8975: Add gpio reset support
Message-ID: <20200519092212.GT1634618@smile.fi.intel.com>
References: <20200519065749.4624-1-jonathan.albrieux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519065749.4624-1-jonathan.albrieux@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, May 19, 2020 at 08:57:40AM +0200, Jonathan Albrieux wrote:
> Convert documentation from txt format to yaml. Add documentation about
> reset-gpio. 

Trailing white space (though it doesn't matter here, in cover letter).

> Deassert reset on ak8975_power_on, assert reset on ak8975_power_off.
> 
> Without reset's deassertion during ak8975_power_on, driver's probe fails
> on ak8975_who_i_am while checking for device identity for AK09911 chip
> 
> AK09911 has an active low reset gpio to handle register's reset.
> AK09911 datasheed says that, if not used, reset pin should be connected
> to VID. This patch emulates this situation

I dunno if it's your first submission to Linux kernel project or other OSS,
but here you missed a changelog. Rule of thumb is to provide a summary of
the changes done in the history of the evolution of a patch series.

-- 
With Best Regards,
Andy Shevchenko


