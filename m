Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBCF3231C98
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jul 2020 12:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgG2KTF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 Jul 2020 06:19:05 -0400
Received: from mga12.intel.com ([192.55.52.136]:43599 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbgG2KTC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 29 Jul 2020 06:19:02 -0400
IronPort-SDR: bC6JrvmJd/enoZhIUVFtXcuKV9p/KHqlpAkaf933N9A1WKCwZx6pVeLaBYSwkVWjrhD6O7ka6g
 klbu0XvVBSiw==
X-IronPort-AV: E=McAfee;i="6000,8403,9696"; a="130948167"
X-IronPort-AV: E=Sophos;i="5.75,410,1589266800"; 
   d="scan'208";a="130948167"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2020 03:19:02 -0700
IronPort-SDR: GpJZADObb8XEuFV/vK+CssJd63679i0Esy4ZXbkbMbvDS5o8o37ahPhktcuedTSfsmEnPKMkk+
 iE9XRuSyfR4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,410,1589266800"; 
   d="scan'208";a="304177881"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002.jf.intel.com with ESMTP; 29 Jul 2020 03:19:00 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1k0jAq-004fYe-AR; Wed, 29 Jul 2020 13:19:00 +0300
Date:   Wed, 29 Jul 2020 13:19:00 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Maxim Kochetkov <fido_max@inbox.ru>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, bigunclemax@gmail.com
Subject: Re: [PATCH v2] iio: adc: ti-ads1015: fix conversion when CONFIG_PM
 is not set
Message-ID: <20200729101900.GN3703480@smile.fi.intel.com>
References: <20200729090631.12910-1-fido_max@inbox.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729090631.12910-1-fido_max@inbox.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Jul 29, 2020 at 12:06:31PM +0300, Maxim Kochetkov wrote:

Thank you!
A bit of massage of commit message (see below) and we are fine to go
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> To stop conversion ads1015_set_power_state function call unimplemented

All function references should be like func().

> function __pm_runtime_suspend from pm_runtime_put_autosuspend
> if CONFIG_PM is not set.

> In case of CONFIG_PM is not set:
> 
> static inline int __pm_runtime_suspend(struct device *dev, int rpmflags)
> {
> 	return -ENOSYS;
> }

It's enough to say

In case of CONFIG_PM is not set: __pm_runtime_suspend() returns -ENOSYS,

> so ads1015_read_raw failed at:
> 		ret = ads1015_set_power_state(data, false);
> 		if (ret < 0)
> 			goto release_direct;

so ads1015_read_raw() failed because ads1015_set_power_state() returns an error.

> If CONFIG_PM is disabled, there is no need to start/stop conversion.
> Fix it by adding return 0 function variant if CONFIG_PM is not set.
> 
> Signed-off-by: Maxim Kochetkov <fido_max@inbox.ru>
> Tested-by: Maxim Kiselev <bigunclemax@gmail.com>
> ---
>  drivers/iio/adc/ti-ads1015.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> index 5ea4f45d6bad..64fe3b2a6ec6 100644
> --- a/drivers/iio/adc/ti-ads1015.c
> +++ b/drivers/iio/adc/ti-ads1015.c
> @@ -316,6 +316,7 @@ static const struct iio_chan_spec ads1115_channels[] = {
>  	IIO_CHAN_SOFT_TIMESTAMP(ADS1015_TIMESTAMP),
>  };
>  
> +#ifdef CONFIG_PM
>  static int ads1015_set_power_state(struct ads1015_data *data, bool on)
>  {
>  	int ret;
> @@ -333,6 +334,15 @@ static int ads1015_set_power_state(struct ads1015_data *data, bool on)
>  	return ret < 0 ? ret : 0;
>  }
>  
> +#else /* !CONFIG_PM */
> +
> +static int ads1015_set_power_state(struct ads1015_data *data, bool on)
> +{
> +	return 0;
> +}
> +
> +#endif /* !CONFIG_PM */
> +
>  static
>  int ads1015_get_adc_result(struct ads1015_data *data, int chan, int *val)
>  {
> -- 
> 2.27.0
> 

-- 
With Best Regards,
Andy Shevchenko


