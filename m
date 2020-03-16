Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01193186665
	for <lists+linux-iio@lfdr.de>; Mon, 16 Mar 2020 09:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730017AbgCPI1V (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Mar 2020 04:27:21 -0400
Received: from mga14.intel.com ([192.55.52.115]:51187 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728302AbgCPI1V (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 16 Mar 2020 04:27:21 -0400
IronPort-SDR: GQn6lAS/t/IZ2GUynwpQ7t/V0WdUWCxVWhyxJhXadbWPxtR82GWlHnThGLfx1C2V78fqq+zDVe
 AnqSNJc1B+lw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2020 01:27:20 -0700
IronPort-SDR: DxzK6vod9WQQlKu8OhidIpDcJuwB7EJ2xolqqbVKIPAAdEDmbND7aV3vskMu1k1vTHwKhUMxfl
 NOKZygrOlkDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,559,1574150400"; 
   d="scan'208";a="323422968"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001.jf.intel.com with ESMTP; 16 Mar 2020 01:27:19 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jDl5l-00A0Ha-5f; Mon, 16 Mar 2020 10:27:21 +0200
Date:   Mon, 16 Mar 2020 10:27:21 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Denis Ciocca <denis.ciocca@st.com>
Subject: Re: [PATCH v2 8/8] iio: humidity: hts221: Drop unneeded casting when
 print error code
Message-ID: <20200316082721.GA1922688@smile.fi.intel.com>
References: <20200313104955.30423-1-andriy.shevchenko@linux.intel.com>
 <20200313104955.30423-8-andriy.shevchenko@linux.intel.com>
 <20200315124451.461856e2@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200315124451.461856e2@archlinux>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Mar 15, 2020 at 12:44:51PM +0000, Jonathan Cameron wrote:
> On Fri, 13 Mar 2020 12:49:55 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > Explicit casting in printf() usually shows that something is not okay.
> > Here, we really don't need it by providing correct specifier.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Applied.  These may sit in my local tree for a few days as I have
> an existing pull request out and will want to fast-forward the
> tree after that.

It's fine, thank you, Jonathan.

-- 
With Best Regards,
Andy Shevchenko


