Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7CB387716
	for <lists+linux-iio@lfdr.de>; Tue, 18 May 2021 13:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242204AbhERLHY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 May 2021 07:07:24 -0400
Received: from mga03.intel.com ([134.134.136.65]:51353 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240967AbhERLHX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 18 May 2021 07:07:23 -0400
IronPort-SDR: Dje68KGn9b+tF/0WAAg2rwLzpFYHnJZOedHwpU85qVHFr941SHFminJHG1oNPKgWFMzsn6L0wP
 Z3X6se7kJU+A==
X-IronPort-AV: E=McAfee;i="6200,9189,9987"; a="200737363"
X-IronPort-AV: E=Sophos;i="5.82,309,1613462400"; 
   d="scan'208";a="200737363"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 04:05:42 -0700
IronPort-SDR: zKCIRSfEz+OWt90PIwP9HGCf7Oh2uOd6Dya8uY57giCnWai1FDlCugEFiwVff7H8fuMJn2kVRG
 anjpKauinh4w==
X-IronPort-AV: E=Sophos;i="5.82,309,1613462400"; 
   d="scan'208";a="630397175"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 04:05:28 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lixXK-00Cvyz-HY; Tue, 18 May 2021 14:05:18 +0300
Date:   Tue, 18 May 2021 14:05:18 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Denis Ciocca <denis.ciocca@st.com>,
        Daniel Drake <drake@endlessm.com>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH 4/5 v2] iio: magnetometer: st_magn: Support mount matrix
Message-ID: <YKOfbpxgmdQ15dPD@smile.fi.intel.com>
References: <20210517233322.383043-1-linus.walleij@linaro.org>
 <20210517233322.383043-4-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517233322.383043-4-linus.walleij@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, May 18, 2021 at 01:33:21AM +0200, Linus Walleij wrote:
> Add support to read and present the mounting matrix on ST magnetometers.

...

> +static const struct iio_chan_spec_ext_info st_magn_mount_matrix_ext_info[] = {
> +	IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, st_magn_get_mount_matrix),
> +	{ },

No need to have comma in terminator line.

> +};

-- 
With Best Regards,
Andy Shevchenko


