Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6A10387711
	for <lists+linux-iio@lfdr.de>; Tue, 18 May 2021 13:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242023AbhERLFE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 May 2021 07:05:04 -0400
Received: from mga06.intel.com ([134.134.136.31]:47202 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240967AbhERLFD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 18 May 2021 07:05:03 -0400
IronPort-SDR: jQQdU7wccAuW4HTy4XRp94524S17TmvaGmWum37NSB98X6Lxgqu5BUqoKaxi8OroQA4B4eOox+
 IPqkxsAPN3vw==
X-IronPort-AV: E=McAfee;i="6200,9189,9987"; a="261912472"
X-IronPort-AV: E=Sophos;i="5.82,309,1613462400"; 
   d="scan'208";a="261912472"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 04:03:44 -0700
IronPort-SDR: X4bazmpVHc2qwsjCBoEdhg1Q1QeIjX4Q9/DmGIGpY+wUq4a6Sj/1lOffTyeP0v3bbyAl5Zn03F
 xweywIkkGVaA==
X-IronPort-AV: E=Sophos;i="5.82,309,1613462400"; 
   d="scan'208";a="393912376"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 04:03:42 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lixVj-00CvxV-EC; Tue, 18 May 2021 14:03:39 +0300
Date:   Tue, 18 May 2021 14:03:39 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Denis Ciocca <denis.ciocca@st.com>,
        Daniel Drake <drake@endlessm.com>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH 2/5 v2] iio: accel: st_sensors: Support generic mounting
 matrix
Message-ID: <YKOfCyuPOeomUbG1@smile.fi.intel.com>
References: <20210517233322.383043-1-linus.walleij@linaro.org>
 <20210517233322.383043-2-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517233322.383043-2-linus.walleij@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, May 18, 2021 at 01:33:19AM +0200, Linus Walleij wrote:
> The ST accelerators support a special type of quirky mounting matrix found
> in ACPI systems, but not a generic mounting matrix such as from the device
> tree.
> 
> Augment the ACPI hack to be a bit more generic and accept a mounting
> matrix from device properties.
> 
> This makes it possible to fix orientation on the Ux500 HREF device.

...

> +static const struct iio_chan_spec_ext_info st_accel_mount_matrix_ext_info[] = {
> +	IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, st_accel_get_mount_matrix),
> +	{ },

Comma is not needed for terminator lines.

> +};

...

> +	/* First try ACPI orientation then try the generic function */

It's a bit confusing, because the generic also tries ACPI.

Perhaps "...try specific ACPI methods to retrieve orientation, then..."?

> +	err = apply_acpi_orientation(indio_dev);
> +	if (err) {
> +		err = iio_read_mount_matrix(adata->dev, "mount-matrix",
> +					    &adata->mount_matrix);
> +		if (err)
> +			goto st_accel_power_off;
> +	}

-- 
With Best Regards,
Andy Shevchenko


