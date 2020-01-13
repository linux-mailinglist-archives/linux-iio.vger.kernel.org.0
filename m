Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB03E1392DD
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2020 14:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbgAMN6f (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Jan 2020 08:58:35 -0500
Received: from mga05.intel.com ([192.55.52.43]:12911 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728789AbgAMN6e (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 13 Jan 2020 08:58:34 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jan 2020 05:58:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,429,1571727600"; 
   d="scan'208";a="224904233"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003.jf.intel.com with ESMTP; 13 Jan 2020 05:58:32 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ir0Ei-0008Vk-Tk; Mon, 13 Jan 2020 15:58:32 +0200
Date:   Mon, 13 Jan 2020 15:58:32 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        lorenzo.bianconi83@gmail.com, denis.ciocca@st.com
Subject: Re: [PATCH v1 9/9] iio: st_sensors: Make use of device properties
Message-ID: <20200113135832.GP32742@smile.fi.intel.com>
References: <20191216173853.75797-1-andriy.shevchenko@linux.intel.com>
 <20191216173853.75797-9-andriy.shevchenko@linux.intel.com>
 <20191223163033.1b48c0c7@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191223163033.1b48c0c7@archlinux>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Dec 23, 2019 at 04:30:33PM +0000, Jonathan Cameron wrote:
> On Mon, 16 Dec 2019 19:38:53 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > Device property API allows to gather device resources from different sources,
> > such as ACPI. Convert the drivers to unleash the power of device property API.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Also looks fine, but will allow a bit more time for others to take a look.

Gentle ping.

-- 
With Best Regards,
Andy Shevchenko


