Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C288C1957E2
	for <lists+linux-iio@lfdr.de>; Fri, 27 Mar 2020 14:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgC0NTl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 27 Mar 2020 09:19:41 -0400
Received: from mga12.intel.com ([192.55.52.136]:22697 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbgC0NTl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 27 Mar 2020 09:19:41 -0400
IronPort-SDR: U8GstR01rjei5AK+P82IvsDMMoxLCbMhUUsGCnhPNffnycfYWY3HRKzT5GIk1M4WP3sG/SELkk
 HjUPmsZ4hDfg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2020 06:19:41 -0700
IronPort-SDR: rj8aixez0cboExOzidF+SSl8Ea5EzQyLSSt4FnksdzSL+SKwn4n3o/qjyg/t9k2w3Zl7IYU8vc
 CRpsXNO67oKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,312,1580803200"; 
   d="scan'208";a="247881693"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003.jf.intel.com with ESMTP; 27 Mar 2020 06:19:38 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jHotg-00DQL6-PZ; Fri, 27 Mar 2020 15:19:40 +0200
Date:   Fri, 27 Mar 2020 15:19:40 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rohit Sarkar <rohitsarkar5398@gmail.com>
Cc:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: imu: inv_mpu6050: add debugfs register r/w
 interface
Message-ID: <20200327131940.GX1922688@smile.fi.intel.com>
References: <5e7dfb41.1c69fb81.cc4bb.042f@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e7dfb41.1c69fb81.cc4bb.042f@mx.google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Mar 27, 2020 at 06:40:23PM +0530, Rohit Sarkar wrote:
> The debugfs interface provides direct access to read and write device
> registers if debugfs is enabled.

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Rohit Sarkar <rohitsarkar5398@gmail.com>
> ---
> Changelog v1->v2
> * grab a lock to protect driver state
> * add a comma at the end of structure member initialisation
> 
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 7cb9ff3d3e94..381a3fb09858 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -1248,12 +1248,31 @@ static const struct attribute_group inv_attribute_group = {
>  	.attrs = inv_attributes
>  };
>  
> +static int inv_mpu6050_reg_access(struct iio_dev *indio_dev,
> +				  unsigned int reg,
> +				  unsigned int writeval,
> +				  unsigned int *readval)
> +{
> +	struct inv_mpu6050_state *st = iio_priv(indio_dev);
> +	int ret = 0;
> +
> +	mutex_lock(&st->lock);
> +	if (readval)
> +		ret = regmap_read(st->map, reg, readval);
> +	else
> +		ret = regmap_write(st->map, reg, writeval);
> +	mutex_unlock(&st->lock);
> +
> +	return ret;
> +}
> +
>  static const struct iio_info mpu_info = {
>  	.read_raw = &inv_mpu6050_read_raw,
>  	.write_raw = &inv_mpu6050_write_raw,
>  	.write_raw_get_fmt = &inv_write_raw_get_fmt,
>  	.attrs = &inv_attribute_group,
>  	.validate_trigger = inv_mpu6050_validate_trigger,
> +	.debugfs_reg_access = &inv_mpu6050_reg_access,
>  };
>  
>  /**
> -- 
> 2.23.0.385.gbc12974a89
> 

-- 
With Best Regards,
Andy Shevchenko


