Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEB4C1D96C8
	for <lists+linux-iio@lfdr.de>; Tue, 19 May 2020 14:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbgESMzj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 May 2020 08:55:39 -0400
Received: from mga18.intel.com ([134.134.136.126]:39330 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727904AbgESMzj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 19 May 2020 08:55:39 -0400
IronPort-SDR: 1QPPdSq2c9YrdNEUA/yMS0QtjXL8OiMKEqSbz7jX6N/vygoq0njAYnAz1G9jXJ3rOcIRdoyBrV
 k2EMAEwxmjAQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2020 05:55:38 -0700
IronPort-SDR: ZdSL02WNQcrR3lRD0XvomnzS/+alYOWgQuiQ2cvisdS+wVE8M13quLDYGhM9s4kNmDqizzcbP5
 G/whYnOTF+aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,410,1583222400"; 
   d="scan'208";a="465961411"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005.fm.intel.com with ESMTP; 19 May 2020 05:55:35 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jb1mT-007daU-FJ; Tue, 19 May 2020 15:55:37 +0300
Date:   Tue, 19 May 2020 15:55:37 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Albrieux <jonathan.albrieux@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jilayne Lovejoy <opensource@jilayne.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Steve Winslow <swinslow@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v3 3/4] iio: magnetometer: ak8975: Fix typo, uniform
 measurement unit style
Message-ID: <20200519125537.GH1634618@smile.fi.intel.com>
References: <20200519124402.26076-1-jonathan.albrieux@gmail.com>
 <20200519124402.26076-4-jonathan.albrieux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519124402.26076-4-jonathan.albrieux@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, May 19, 2020 at 02:43:53PM +0200, Jonathan Albrieux wrote:
> Minor comment style edits.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
> ---
>  drivers/iio/magnetometer/ak8975.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
> index 3c881541ae72..fd368455cd7b 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -385,9 +385,9 @@ static int ak8975_power_on(const struct ak8975_data *data)
>  		return ret;
>  	}
>  	/*
> -	 * According to the datasheet the power supply rise time i 200us
> +	 * According to the datasheet the power supply rise time is 200us
>  	 * and the minimum wait time before mode setting is 100us, in
> -	 * total 300 us. Add some margin and say minimum 500us here.
> +	 * total 300us. Add some margin and say minimum 500us here.
>  	 */
>  	usleep_range(500, 1000);
>  	return 0;
> -- 
> 2.17.1
> 

-- 
With Best Regards,
Andy Shevchenko


