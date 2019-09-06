Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47168ABE16
	for <lists+linux-iio@lfdr.de>; Fri,  6 Sep 2019 18:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393213AbfIFQzd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 6 Sep 2019 12:55:33 -0400
Received: from mga02.intel.com ([134.134.136.20]:11171 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393211AbfIFQzc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 6 Sep 2019 12:55:32 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2019 09:55:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,473,1559545200"; 
   d="scan'208";a="267414818"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001.jf.intel.com with ESMTP; 06 Sep 2019 09:55:28 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1i6HWB-0002Ld-Cm; Fri, 06 Sep 2019 19:55:27 +0300
Date:   Fri, 6 Sep 2019 19:55:27 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Colin Ian King <colin.king@canonical.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RFC] Revert "iio: hid-sensor-attributes: Convert to use
 int_pow()"
Message-ID: <20190906165527.GW2680@smile.fi.intel.com>
References: <20190906154609.2421410-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906154609.2421410-1-arnd@arndb.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Sep 06, 2019 at 05:45:55PM +0200, Arnd Bergmann wrote:
> The change to use the generic int_pow instead of the private version
> caused a number of build issues on 32-bit architectures and makes
> it generally less efficient because of the 64-bit math:
> 
> drivers/iio/common/hid-sensors/hid-sensor-attributes.o: In function `hid_sensor_write_samp_freq_value':
> hid-sensor-attributes.c:(.text+0x29c): undefined reference to `__aeabi_uldivmod'
> drivers/iio/common/hid-sensors/hid-sensor-attributes.o: In function `hid_sensor_read_raw_hyst_value':
> hid-sensor-attributes.c:(.text+0x420): undefined reference to `__aeabi_uldivmod'
> hid-sensor-attributes.c:(.text+0x448): undefined reference to `__aeabi_uldivmod'
> drivers/iio/common/hid-sensors/hid-sensor-attributes.o: In function `hid_sensor_write_raw_hyst_value':
> hid-sensor-attributes.c:(.text+0x570): undefined reference to `__aeabi_uldivmod'
> 
> There is probably a nicer solution to this, but for the moment,
> the revert makes it compile again.
> 
> Fixes: 473d12f7638c ("iio: hid-sensor-attributes: Convert to use int_pow()")

Does the fix [1] works for you?

[1]: https://lore.kernel.org/linux-iio/6851830d050ddb2f27d1e6969755ee4f3293d37c.camel@intel.com/

-- 
With Best Regards,
Andy Shevchenko


