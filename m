Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B40B387717
	for <lists+linux-iio@lfdr.de>; Tue, 18 May 2021 13:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243587AbhERLHb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 May 2021 07:07:31 -0400
Received: from mga12.intel.com ([192.55.52.136]:33067 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240967AbhERLHb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 18 May 2021 07:07:31 -0400
IronPort-SDR: 5yUSHmpNFXJ/NEz7uidXObmeScnUVknfvZtKMjhZzDNst/9DP9OzyDU17QwW2CgIsigXrxNZEu
 d6+lkuxzsAOQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9987"; a="180286993"
X-IronPort-AV: E=Sophos;i="5.82,309,1613462400"; 
   d="scan'208";a="180286993"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 04:06:13 -0700
IronPort-SDR: QMRNbimDQKY/H2fsRdzNkD2DEiPXoV4tX+7te5yz6S2CB1QCzyQADZUJVhH6SP/5XdchYNCxWm
 Ay1B/K2UBw9w==
X-IronPort-AV: E=Sophos;i="5.82,309,1613462400"; 
   d="scan'208";a="473497164"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 04:06:11 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lixY8-00Cvzh-Bm; Tue, 18 May 2021 14:06:08 +0300
Date:   Tue, 18 May 2021 14:06:08 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Denis Ciocca <denis.ciocca@st.com>,
        Daniel Drake <drake@endlessm.com>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH 5/5 v2] iio: gyro: st_gyro: Support mount matrix
Message-ID: <YKOfoMbpM3YMjgfB@smile.fi.intel.com>
References: <20210517233322.383043-1-linus.walleij@linaro.org>
 <20210517233322.383043-5-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517233322.383043-5-linus.walleij@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, May 18, 2021 at 01:33:22AM +0200, Linus Walleij wrote:
> Add support to read and present the mounting matrix on ST gyroscopes.

...

> +static const struct iio_chan_spec_ext_info st_gyro_mount_matrix_ext_info[] = {
> +	IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, st_gyro_get_mount_matrix),
> +	{ },

Unneeded comma.

> +};

-- 
With Best Regards,
Andy Shevchenko


