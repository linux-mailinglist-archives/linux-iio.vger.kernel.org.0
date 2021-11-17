Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA64D454DDD
	for <lists+linux-iio@lfdr.de>; Wed, 17 Nov 2021 20:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240472AbhKQTcD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 17 Nov 2021 14:32:03 -0500
Received: from mga03.intel.com ([134.134.136.65]:2552 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240459AbhKQTcD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 17 Nov 2021 14:32:03 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10171"; a="233981404"
X-IronPort-AV: E=Sophos;i="5.87,241,1631602800"; 
   d="scan'208";a="233981404"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2021 11:29:04 -0800
X-IronPort-AV: E=Sophos;i="5.87,241,1631602800"; 
   d="scan'208";a="568091347"
Received: from smile.fi.intel.com ([10.237.72.184])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2021 11:29:00 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1mnQc1-007ue9-8F;
        Wed, 17 Nov 2021 21:28:53 +0200
Date:   Wed, 17 Nov 2021 21:28:53 +0200
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     Anand Ashok Dumbre <ANANDASH@xilinx.com>,
        linux-kernel@vger.kernel.org, jic23@kernel.org, lars@metafoo.de,
        linux-iio@vger.kernel.org, git <git@xilinx.com>,
        Michal Simek <michals@xilinx.com>, gregkh@linuxfoundation.org,
        rafael@kernel.org, linux-acpi@vger.kernel.org,
        heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v9 5/5] MAINTAINERS: Add maintainer for xilinx-ams
Message-ID: <YZVX9R/TMvkPwuuF@smile.fi.intel.com>
References: <20211116150842.1051-1-anand.ashok.dumbre@xilinx.com>
 <20211116150842.1051-6-anand.ashok.dumbre@xilinx.com>
 <YZPtW5igA8RBYLWv@smile.fi.intel.com>
 <BY5PR02MB69168A6537474DF8948C3D0BA99A9@BY5PR02MB6916.namprd02.prod.outlook.com>
 <CAHp75VdaO4+DxMn2eJx7t0_UFgrHGV2vgzXvRB=qwZi-ZpMaOA@mail.gmail.com>
 <cf7ad8715a02f3a0e4fe0cd8a270585dcf84bb3a.camel@perches.com>
 <CAHp75VfJBwCcFwbv6fgvwf=Q1UdFXwgNex-4GqKLcf=ZhuqGjw@mail.gmail.com>
 <164612d20b252a28dda74f5058e0aacb@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <164612d20b252a28dda74f5058e0aacb@perches.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Nov 17, 2021 at 10:46:20AM -0800, Joe Perches wrote:
> On 2021-11-17 09:08, Andy Shevchenko wrote:
> > On Wed, Nov 17, 2021 at 6:05 PM Joe Perches <joe@perches.com> wrote:
> 
> > > What do you think checkpatch is supposed to find?
> 
> > To me AMS should precede AXI and not the other way around. Agree?
> 
> Sure but checkpatch just looks at patches and doesn't inspect the patched
> file, apply the patch then look at the result. The patch itself looks fine.

I see, checkpatch simply doesn't have such functionality and maintainers should
ask people to rung parse-maintainers.pl from time to time…

-- 
With Best Regards,
Andy Shevchenko


