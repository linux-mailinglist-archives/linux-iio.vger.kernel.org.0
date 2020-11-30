Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 233CD2C82BE
	for <lists+linux-iio@lfdr.de>; Mon, 30 Nov 2020 12:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbgK3LAt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Nov 2020 06:00:49 -0500
Received: from mga05.intel.com ([192.55.52.43]:42758 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727656AbgK3LAt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Nov 2020 06:00:49 -0500
IronPort-SDR: twq+4TJ7ARM8tqIC3IOltc2hwGo9zAyJxyL8I2ePM41QZ/nkSRyj0ni1XJThQeZrTwFIWwxuie
 0nkCbu4gzl7Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9820"; a="257323614"
X-IronPort-AV: E=Sophos;i="5.78,381,1599548400"; 
   d="scan'208";a="257323614"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 02:59:08 -0800
IronPort-SDR: HkLxE1VCHG0PrTgchFx0MwYRl+Pmie/Oqu8F/ultaW7W1354nxU5Dz/2lpl/BjP1G5XTp92hzm
 9INL80kdJxNg==
X-IronPort-AV: E=Sophos;i="5.78,381,1599548400"; 
   d="scan'208";a="538553651"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 02:59:06 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kjgue-00B1lC-RY; Mon, 30 Nov 2020 13:00:08 +0200
Date:   Mon, 30 Nov 2020 13:00:08 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2] iio:gyro:mpu3050 Treat otp value as a __le64 and use
 FIELD_GET() to break up
Message-ID: <20201130110008.GH4077@smile.fi.intel.com>
References: <20201129184459.647538-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201129184459.647538-1-jic23@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Nov 29, 2020 at 06:44:59PM +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Inspired by Andy Shevchenko's proposal to use get_unaligned_leXX().
> 
> The whole one time programable memory is treated as a single 64bit
> little endian value.  Thus we can avoid a lot of messy handling
> of fields overlapping byte boundaries by just loading and manipulating
> it as an __le64 converted to a u64.  That lets us just use FIELD_GET()
> and GENMASK() to extract the values desired.
> 
> Note only build tested. We need to use GENMASK_ULL and %llX formatters
> to account for the larger types used in computing the various fields.

LGTM now, thanks!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Link: https://lore.kernel.org/r/20201128185156.428327-1-jic23@kernel.org
> ---
> 
> Changes since v1:
> * Fix 32 bit builds by using GENMASK_ULL (thanks to Linus + Andy)
> 
>  drivers/iio/gyro/mpu3050-core.c | 28 ++++++++++++++++------------
>  1 file changed, 16 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
> index 00e58060968c..dfa31a23500f 100644
> --- a/drivers/iio/gyro/mpu3050-core.c
> +++ b/drivers/iio/gyro/mpu3050-core.c
> @@ -13,6 +13,7 @@
>   * TODO: add support for setting up the low pass 3dB frequency.
>   */
>  
> +#include <linux/bitfield.h>
>  #include <linux/bitops.h>
>  #include <linux/delay.h>
>  #include <linux/err.h>
> @@ -784,7 +785,8 @@ static int mpu3050_read_mem(struct mpu3050 *mpu3050,
>  static int mpu3050_hw_init(struct mpu3050 *mpu3050)
>  {
>  	int ret;
> -	u8 otp[8];
> +	__le64 otp_le;
> +	u64 otp;
>  
>  	/* Reset */
>  	ret = regmap_update_bits(mpu3050->map,
> @@ -815,29 +817,31 @@ static int mpu3050_hw_init(struct mpu3050 *mpu3050)
>  				MPU3050_MEM_USER_BANK |
>  				MPU3050_MEM_OTP_BANK_0),
>  			       0,
> -			       sizeof(otp),
> -			       otp);
> +			       sizeof(otp_le),
> +			       (u8 *)&otp_le);
>  	if (ret)
>  		return ret;
>  
>  	/* This is device-unique data so it goes into the entropy pool */
> -	add_device_randomness(otp, sizeof(otp));
> +	add_device_randomness(&otp_le, sizeof(otp_le));
> +
> +	otp = le64_to_cpu(otp_le);
>  
>  	dev_info(mpu3050->dev,
> -		 "die ID: %04X, wafer ID: %02X, A lot ID: %04X, "
> -		 "W lot ID: %03X, WP ID: %01X, rev ID: %02X\n",
> +		 "die ID: %04llX, wafer ID: %02llX, A lot ID: %04llX, "
> +		 "W lot ID: %03llX, WP ID: %01llX, rev ID: %02llX\n",
>  		 /* Die ID, bits 0-12 */
> -		 (otp[1] << 8 | otp[0]) & 0x1fff,
> +		 FIELD_GET(GENMASK_ULL(12, 0), otp),
>  		 /* Wafer ID, bits 13-17 */
> -		 ((otp[2] << 8 | otp[1]) & 0x03e0) >> 5,
> +		 FIELD_GET(GENMASK_ULL(17, 13), otp),
>  		 /* A lot ID, bits 18-33 */
> -		 ((otp[4] << 16 | otp[3] << 8 | otp[2]) & 0x3fffc) >> 2,
> +		 FIELD_GET(GENMASK_ULL(33, 18), otp),
>  		 /* W lot ID, bits 34-45 */
> -		 ((otp[5] << 8 | otp[4]) & 0x3ffc) >> 2,
> +		 FIELD_GET(GENMASK_ULL(45, 34), otp),
>  		 /* WP ID, bits 47-49 */
> -		 ((otp[6] << 8 | otp[5]) & 0x0380) >> 7,
> +		 FIELD_GET(GENMASK_ULL(49, 47), otp),
>  		 /* rev ID, bits 50-55 */
> -		 otp[6] >> 2);
> +		 FIELD_GET(GENMASK_ULL(55, 50), otp));
>  
>  	return 0;
>  }
> -- 
> 2.29.2
> 

-- 
With Best Regards,
Andy Shevchenko


