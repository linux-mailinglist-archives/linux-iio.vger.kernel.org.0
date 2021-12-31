Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92BE348214D
	for <lists+linux-iio@lfdr.de>; Fri, 31 Dec 2021 02:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242475AbhLaBku (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Dec 2021 20:40:50 -0500
Received: from mga12.intel.com ([192.55.52.136]:2320 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242471AbhLaBku (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 30 Dec 2021 20:40:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640914850; x=1672450850;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+voAV5Ml5uccIDrkO+cZwxrej74x2+pLSY/HOAVywCg=;
  b=SdQLHQWoZenX3AYmXkyNHdnomjwgbDxJHHaHvIEa/cugd1dIRtdneQoU
   9fjCQc7poS4x2WT3iqh7ywMKvyPFWZ+tRGIORA964KoX8BME6EEhOGgNG
   +ch+5vsOaeBsrKry/Y+uVaKV8QVwgJX1+x/F0s+C3JyIlBr10PkcpURZo
   +OkVzXudQmxRyQZsO0FLS3dNb4gScHJdTrx4uUA3QosntvyeN+F56W5au
   CkV643n5NtXA9kvU6sLKgrJ+XTfZrFmJSd+Db4LzSGKD1uxOcwiaBojdT
   5DuaSQvLZS7ZWshaTMS9sw69JWkmEYXQ6Ie2KzLJENH7sF7Ozks3oRKSJ
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10213"; a="221752706"
X-IronPort-AV: E=Sophos;i="5.88,250,1635231600"; 
   d="scan'208";a="221752706"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2021 17:40:49 -0800
X-IronPort-AV: E=Sophos;i="5.88,250,1635231600"; 
   d="scan'208";a="487033486"
Received: from dganta-mobl1.amr.corp.intel.com ([10.212.232.245])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2021 17:40:49 -0800
Message-ID: <6d38b7334daa472c7d59380e69766f8776c7b3cb.camel@linux.intel.com>
Subject: Re: [PATCH 09/13] iio:accel:bmc150: Move exports into BMC150
 namespace
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date:   Thu, 30 Dec 2021 17:40:49 -0800
In-Reply-To: <20211230193331.283503-10-jic23@kernel.org>
References: <20211230193331.283503-1-jic23@kernel.org>
         <20211230193331.283503-10-jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 2021-12-30 at 19:33 +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> To avoid unnecessary pollution of the global symbol namespace move the
> driver core exports into their own namespace and import that into the
> two
> bus modules.
> 
> For more info see https://lwn.net/Articles/760045/
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
>  drivers/iio/accel/bmc150-accel-core.c | 8 ++++----
>  drivers/iio/accel/bmc150-accel-i2c.c  | 1 +
>  drivers/iio/accel/bmc150-accel-spi.c  | 1 +
>  3 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/accel/bmc150-accel-core.c
> b/drivers/iio/accel/bmc150-accel-core.c
> index e6081dd0a880..711928d626c5 100644
> --- a/drivers/iio/accel/bmc150-accel-core.c
> +++ b/drivers/iio/accel/bmc150-accel-core.c
> @@ -203,7 +203,7 @@ const struct regmap_config bmc150_regmap_conf = {
>         .val_bits = 8,
>         .max_register = 0x3f,
>  };
> -EXPORT_SYMBOL_GPL(bmc150_regmap_conf);
> +EXPORT_SYMBOL_NS_GPL(bmc150_regmap_conf, BMC150);
>  
>  static int bmc150_accel_set_mode(struct bmc150_accel_data *data,
>                                  enum bmc150_power_modes mode,
> @@ -1798,7 +1798,7 @@ int bmc150_accel_core_probe(struct device *dev,
> struct regmap *regmap, int irq,
>  
>         return ret;
>  }
> -EXPORT_SYMBOL_GPL(bmc150_accel_core_probe);
> +EXPORT_SYMBOL_NS_GPL(bmc150_accel_core_probe, BMC150);
>  
>  void bmc150_accel_core_remove(struct device *dev)
>  {
> @@ -1821,7 +1821,7 @@ void bmc150_accel_core_remove(struct device *dev)
>         regulator_bulk_disable(ARRAY_SIZE(data->regulators),
>                                data->regulators);
>  }
> -EXPORT_SYMBOL_GPL(bmc150_accel_core_remove);
> +EXPORT_SYMBOL_NS_GPL(bmc150_accel_core_remove, BMC150);
>  
>  #ifdef CONFIG_PM_SLEEP
>  static int bmc150_accel_suspend(struct device *dev)
> @@ -1896,7 +1896,7 @@ const struct dev_pm_ops bmc150_accel_pm_ops = {
>         SET_RUNTIME_PM_OPS(bmc150_accel_runtime_suspend,
>                            bmc150_accel_runtime_resume, NULL)
>  };
> -EXPORT_SYMBOL_GPL(bmc150_accel_pm_ops);
> +EXPORT_SYMBOL_NS_GPL(bmc150_accel_pm_ops, BMC150);
>  
>  MODULE_AUTHOR("Srinivas Pandruvada <
> srinivas.pandruvada@linux.intel.com>");
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/accel/bmc150-accel-i2c.c
> b/drivers/iio/accel/bmc150-accel-i2c.c
> index 9e52df9a8f07..e5d10e7be332 100644
> --- a/drivers/iio/accel/bmc150-accel-i2c.c
> +++ b/drivers/iio/accel/bmc150-accel-i2c.c
> @@ -280,3 +280,4 @@ module_i2c_driver(bmc150_accel_driver);
>  MODULE_AUTHOR("Srinivas Pandruvada <
> srinivas.pandruvada@linux.intel.com>");
>  MODULE_LICENSE("GPL v2");
>  MODULE_DESCRIPTION("BMC150 I2C accelerometer driver");
> +MODULE_IMPORT_NS(BMC150);
> diff --git a/drivers/iio/accel/bmc150-accel-spi.c
> b/drivers/iio/accel/bmc150-accel-spi.c
> index 11559567cb39..e6d05f3625b7 100644
> --- a/drivers/iio/accel/bmc150-accel-spi.c
> +++ b/drivers/iio/accel/bmc150-accel-spi.c
> @@ -84,3 +84,4 @@ module_spi_driver(bmc150_accel_driver);
>  MODULE_AUTHOR("Markus Pargmann <mpa@pengutronix.de>");
>  MODULE_LICENSE("GPL v2");
>  MODULE_DESCRIPTION("BMC150 SPI accelerometer driver");
> +MODULE_IMPORT_NS(BMC150);


