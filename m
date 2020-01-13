Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AADDC1392BC
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2020 14:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbgAMN5m (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Jan 2020 08:57:42 -0500
Received: from mga14.intel.com ([192.55.52.115]:56477 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729197AbgAMN5l (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 13 Jan 2020 08:57:41 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jan 2020 05:57:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,429,1571727600"; 
   d="scan'208";a="219300610"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008.fm.intel.com with ESMTP; 13 Jan 2020 05:57:39 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ir0Dr-0008Ue-Pv; Mon, 13 Jan 2020 15:57:39 +0200
Date:   Mon, 13 Jan 2020 15:57:39 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Denis Ciocca <denis.ciocca@st.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Subject: Re: [PATCH v1] iio: st_gyro: Correct data for LSM9DS0 gyro
Message-ID: <20200113135739.GN32742@smile.fi.intel.com>
References: <20191217171038.17004-1-andriy.shevchenko@linux.intel.com>
 <20191223124534.1ed2d23b@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191223124534.1ed2d23b@archlinux>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Dec 23, 2019 at 12:45:34PM +0000, Jonathan Cameron wrote:
> On Tue, 17 Dec 2019 19:10:38 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > The commit 41c128cb25ce ("iio: st_gyro: Add lsm9ds0-gyro support")
> > assumes that gyro in LSM9DS0 is the same as others with 0xd4 WAI ID,
> > but datasheet tells slight different story, i.e. the first scale factor
> > for the chip is 245 dps, and not 250 dps.
> > 
> > Correct this by introducing a separate settings for LSM9DS0.
> > 
> > Fixes: 41c128cb25ce ("iio: st_gyro: Add lsm9ds0-gyro support")
> > Depends-on: 45a4e4220bf4 ("iio: gyro: st_gyro: fix L3GD20H support")
> > Cc: Leonard Crestez <leonard.crestez@nxp.com>
> > Cc: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Looks good to me.  Will just leave it a bit longer to give others
> time to check it.
> 
> Give me a shout if I seem to have missed this by about a week into the new
> year (to let people get back from holidays etc).

Gentle ping.

-- 
With Best Regards,
Andy Shevchenko


