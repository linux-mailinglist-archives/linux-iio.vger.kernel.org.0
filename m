Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B86D238771B
	for <lists+linux-iio@lfdr.de>; Tue, 18 May 2021 13:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244049AbhERLIp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 May 2021 07:08:45 -0400
Received: from mga01.intel.com ([192.55.52.88]:52788 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240967AbhERLIp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 18 May 2021 07:08:45 -0400
IronPort-SDR: RN8YEgGxUDh1+lUJu5/pOg9Y+HfMTtHKXUS5lZYDla6FOk0ko0gAWF7+gSbr0IwwoML6zBaeRC
 V06cNZpNbOvA==
X-IronPort-AV: E=McAfee;i="6200,9189,9987"; a="221733552"
X-IronPort-AV: E=Sophos;i="5.82,309,1613462400"; 
   d="scan'208";a="221733552"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 04:07:15 -0700
IronPort-SDR: Qw6vuIAUiCvNVOwJo2nwB6ZAcSD0oI6luPJyajBUiNiVzCuykcR5udItyj9OBUh+7Q2aHr7VrM
 T5A+GVEg6KMQ==
X-IronPort-AV: E=Sophos;i="5.82,309,1613462400"; 
   d="scan'208";a="433030165"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 04:07:12 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lixZ7-00Cw0L-I5; Tue, 18 May 2021 14:07:09 +0300
Date:   Tue, 18 May 2021 14:07:09 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Denis Ciocca <denis.ciocca@st.com>,
        Daniel Drake <drake@endlessm.com>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH 1/5 v2] iio: st_sensors: Create extended attr macro
Message-ID: <YKOf3TWVI9F4vsUv@smile.fi.intel.com>
References: <20210517233322.383043-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517233322.383043-1-linus.walleij@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, May 18, 2021 at 01:33:18AM +0200, Linus Walleij wrote:
> Extend ST_SENSORS_LSM_CHANNELS() to a version that will accept extended
> attributes named ST_SENSORS_LSM_CHANNELS_EXT() and wrap the former as a
> specialized version of the former.

After addressing comments

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

for the entire series.

P.S. I think I can send one patch that should prepend your series, stay tuned!

-- 
With Best Regards,
Andy Shevchenko


