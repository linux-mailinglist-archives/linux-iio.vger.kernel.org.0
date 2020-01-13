Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B82101392CB
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2020 14:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbgAMN6N (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Jan 2020 08:58:13 -0500
Received: from mga12.intel.com ([192.55.52.136]:40044 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729262AbgAMN6M (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 13 Jan 2020 08:58:12 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jan 2020 05:58:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,429,1571727600"; 
   d="scan'208";a="372269346"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004.jf.intel.com with ESMTP; 13 Jan 2020 05:58:09 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ir0EM-0008VG-5T; Mon, 13 Jan 2020 15:58:10 +0200
Date:   Mon, 13 Jan 2020 15:58:10 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Denis Ciocca <denis.ciocca@st.com>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Subject: Re: [PATCH v1 8/9] iio: st_sensors: Drop redundant parameter from
 st_sensors_of_name_probe()
Message-ID: <20200113135810.GO32742@smile.fi.intel.com>
References: <20191216173853.75797-1-andriy.shevchenko@linux.intel.com>
 <20191216173853.75797-8-andriy.shevchenko@linux.intel.com>
 <20191223162810.26637345@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191223162810.26637345@archlinux>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Dec 23, 2019 at 04:28:10PM +0000, Jonathan Cameron wrote:
> On Mon, 16 Dec 2019 19:38:52 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > Since we have access to the struct device_driver and thus to the ID table,
> > there is no need to supply special parameters to st_sensors_of_name_probe().
> > 
> > Besides that we have a common API to get driver match data, there is
> > no need to do matching separately for OF and ACPI.
> > 
> > Taking into consideration above, simplify the ST sensors code.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> This looks good to me, but its big enough that purely on that basis I'd
> like to leave it a little longer to let Denis / Lorezo or someone else have time
> to take a look.
> 
> If I seem to have lost it by the end of the first week in January, give
> me a poke.  I may have drunk a few things before then ;)

Gentle ping.

-- 
With Best Regards,
Andy Shevchenko


