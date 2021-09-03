Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA44400067
	for <lists+linux-iio@lfdr.de>; Fri,  3 Sep 2021 15:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235096AbhICNXV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 Sep 2021 09:23:21 -0400
Received: from mga18.intel.com ([134.134.136.126]:44709 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234262AbhICNXV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 3 Sep 2021 09:23:21 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10095"; a="206540026"
X-IronPort-AV: E=Sophos;i="5.85,265,1624345200"; 
   d="scan'208";a="206540026"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 06:22:21 -0700
X-IronPort-AV: E=Sophos;i="5.85,265,1624345200"; 
   d="scan'208";a="521691004"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 06:22:19 -0700
Received: from andy by smile with local (Exim 4.95-RC2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mM995-00HCzm-Qp;
        Fri, 03 Sep 2021 16:22:15 +0300
Date:   Fri, 3 Sep 2021 16:22:15 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, jic23@kernel.org, hdegoede@redhat.com,
        wens@csie.org
Subject: Re: [PATCH 2/5] iio: adc: intel_mrfld_adc: convert probe to full
 device-managed
Message-ID: <YTIhh7TkIo+mqIvA@smile.fi.intel.com>
References: <20210903072917.45769-1-aardelean@deviqon.com>
 <20210903072917.45769-3-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210903072917.45769-3-aardelean@deviqon.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Sep 03, 2021 at 10:29:14AM +0300, Alexandru Ardelean wrote:
> The only call in the remove hook is the iio_map_array_unregister() call.
> Since we have a devm_iio_map_array_register() function now, we can use that
> and remove the remove hook entirely.
> The IIO device was registered with the devm_iio_device_register() prior to
> this change.
> 
> Also, the platform_set_drvdata() can be removed now, since it was used only
> in the remove hook.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
> ---
>  drivers/iio/adc/intel_mrfld_adc.c | 24 ++----------------------
>  1 file changed, 2 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/iio/adc/intel_mrfld_adc.c b/drivers/iio/adc/intel_mrfld_adc.c
> index 75394350eb4c..616de0c3a049 100644
> --- a/drivers/iio/adc/intel_mrfld_adc.c
> +++ b/drivers/iio/adc/intel_mrfld_adc.c
> @@ -205,8 +205,6 @@ static int mrfld_adc_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	platform_set_drvdata(pdev, indio_dev);
> -
>  	indio_dev->name = pdev->name;
>  
>  	indio_dev->channels = mrfld_adc_channels;
> @@ -214,28 +212,11 @@ static int mrfld_adc_probe(struct platform_device *pdev)
>  	indio_dev->info = &mrfld_adc_iio_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
> -	ret = iio_map_array_register(indio_dev, iio_maps);
> +	ret = devm_iio_map_array_register(dev, indio_dev, iio_maps);
>  	if (ret)
>  		return ret;
>  
> -	ret = devm_iio_device_register(dev, indio_dev);
> -	if (ret < 0)
> -		goto err_array_unregister;
> -
> -	return 0;
> -
> -err_array_unregister:
> -	iio_map_array_unregister(indio_dev);
> -	return ret;
> -}
> -
> -static int mrfld_adc_remove(struct platform_device *pdev)
> -{
> -	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> -
> -	iio_map_array_unregister(indio_dev);
> -
> -	return 0;
> +	return devm_iio_device_register(dev, indio_dev);
>  }
>  
>  static const struct platform_device_id mrfld_adc_id_table[] = {
> @@ -249,7 +230,6 @@ static struct platform_driver mrfld_adc_driver = {
>  		.name = "mrfld_bcove_adc",
>  	},
>  	.probe = mrfld_adc_probe,
> -	.remove = mrfld_adc_remove,
>  	.id_table = mrfld_adc_id_table,
>  };
>  module_platform_driver(mrfld_adc_driver);
> -- 
> 2.31.1
> 

-- 
With Best Regards,
Andy Shevchenko


