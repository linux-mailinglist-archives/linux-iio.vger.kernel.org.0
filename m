Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4B3718E3FD
	for <lists+linux-iio@lfdr.de>; Sat, 21 Mar 2020 20:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbgCUTh2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Mar 2020 15:37:28 -0400
Received: from mga04.intel.com ([192.55.52.120]:47180 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727028AbgCUTh1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Mar 2020 15:37:27 -0400
IronPort-SDR: NIo1oz9mA2LI5NiCllfdKBTjwws206u46zyC+aPYDPQL6Lj7SKLxVfZUordfTaoQYwn60O+QpF
 vVYSBrqzuVpw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2020 12:37:26 -0700
IronPort-SDR: kd/2ebf5UTBnT6mnDo5GgSAINDTkqfh47lhY8cjKzgUsVh+mdnRuMu+rKC3T+lUIxQg4BjI52T
 OhjM5Hyz7nqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,289,1580803200"; 
   d="scan'208";a="234831917"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007.jf.intel.com with ESMTP; 21 Mar 2020 12:37:24 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jFjvy-00BnrV-OU; Sat, 21 Mar 2020 21:37:26 +0200
Date:   Sat, 21 Mar 2020 21:37:26 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        jic23@kernel.org, lars@metafoo.de
Subject: Re: [PATCH v2 5/5] iio: adc: ad7793: use read_avail iio hook for
 scale available
Message-ID: <20200321193726.GA2813151@smile.fi.intel.com>
References: <20200321090802.11537-1-alexandru.ardelean@analog.com>
 <20200321090802.11537-5-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200321090802.11537-5-alexandru.ardelean@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Mar 21, 2020 at 11:08:02AM +0200, Alexandru Ardelean wrote:
> This change uses the read_avail and '.info_mask_shared_by_type_available'
> modifier to set the available scale.
> Essentially, nothing changes to the driver's ABI.
> 
> The main idea for this patch is to remove the AD7793 driver from
> checkpatch's radar. There have been about ~3 attempts to fix/break the
> 'in_voltage-voltage_scale_available' attribute, because checkpatch assumed
> it to be an arithmetic operation and people were trying to change that.

> +static int ad7793_read_avail(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     const int **vals, int *type, int *length,
> +			     long mask)
>  {
>  	struct ad7793_state *st = iio_priv(indio_dev);
>  
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		*vals = (int *)st->scale_avail;
> +		*type = IIO_VAL_INT_PLUS_NANO;
> +		/* Values are stored in a 2D matrix  */
> +		*length = ARRAY_SIZE(st->scale_avail) * 2;
>  
> +		return IIO_AVAIL_LIST;
> +	}
>  

> +	return -EINVAL;

Wouldn't be better move this under default case?

-- 
With Best Regards,
Andy Shevchenko


