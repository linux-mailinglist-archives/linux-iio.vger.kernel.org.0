Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44A224000A7
	for <lists+linux-iio@lfdr.de>; Fri,  3 Sep 2021 15:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235153AbhICNla (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 Sep 2021 09:41:30 -0400
Received: from mga11.intel.com ([192.55.52.93]:32026 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235128AbhICNla (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 3 Sep 2021 09:41:30 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10095"; a="216283921"
X-IronPort-AV: E=Sophos;i="5.85,265,1624345200"; 
   d="scan'208";a="216283921"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 06:40:20 -0700
X-IronPort-AV: E=Sophos;i="5.85,265,1624345200"; 
   d="scan'208";a="477223512"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 06:40:18 -0700
Received: from andy by smile with local (Exim 4.95-RC2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mM9QV-00HDPF-KO;
        Fri, 03 Sep 2021 16:40:15 +0300
Date:   Fri, 3 Sep 2021 16:40:15 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, jic23@kernel.org, hdegoede@redhat.com,
        wens@csie.org
Subject: Re: [PATCH 1/5] iio: inkern: introduce devm_iio_map_array_register()
 short-hand function
Message-ID: <YTIlv9MR2wG9AzSe@smile.fi.intel.com>
References: <20210903072917.45769-1-aardelean@deviqon.com>
 <20210903072917.45769-2-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210903072917.45769-2-aardelean@deviqon.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Sep 03, 2021 at 10:29:13AM +0300, Alexandru Ardelean wrote:
> This change introduces a device-managed variant to the
> iio_map_array_register() function. It's a simple implementation of calling
> iio_map_array_register() and registering a callback to
> iio_map_array_unregister() with the devm_add_action_or_reset().
> 
> The function uses an explicit 'dev' parameter to bind the unwinding to. It
> could have been implemented to implicitly use the parent of the IIO device,
> however it shouldn't be too expensive to callers to just specify to which
> device object to bind this unwind call.
> It would make the API a bit more flexible.

AFAIU this dev pointer is kinda discussable thing. What scenario do you expect
(have in mind) when it shouldn't use parent?

-- 
With Best Regards,
Andy Shevchenko


