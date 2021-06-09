Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9673A1986
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jun 2021 17:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234654AbhFIPav (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Jun 2021 11:30:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:54624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234585AbhFIPau (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 9 Jun 2021 11:30:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D93EE61359;
        Wed,  9 Jun 2021 15:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623252536;
        bh=qRPWuZFnlZra/nOQj2iUcxyLVgfnFbxZyn2aT2yANC0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hJgK+FoTTs2x1+rNlWLwCb/70pfmFGvPZ/PPruV3Qh/0ntoWg9RnrVLkqEPaElU+c
         bncW6NVMN2vypED4d4a0o2zxvlDY5RZKZrj/VakeDY3eOLr1qgnHB+DOxIhY9o3ghn
         QnKhi2j3EEng9HsVLucBTSmTB0hFYuI2toX/utE3BoglPA7fUp92ogqBkad33vsS1b
         T0+EXAMlq3dvghF5Nk6UCH4TD9Dbopnmc55WOEX3PtaUMmZrKLebXrxCma38YbpyZB
         Mlqy1A5s3Rh9QJFfqAExRnFdGmMp3eVivLqTv9x4XWwcQum9Xon3gXPkEWn6poY2sX
         cXEYIRDOiRCZw==
Date:   Wed, 9 Jun 2021 08:28:55 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Joe Perches <joe@perches.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 3/4] iio: imu: inv_mpu6050: Drop use of %hhx format
 string.
Message-ID: <YMDeN/Y/hfSExVOX@Ryzen-9-3900X>
References: <20210603180612.3635250-1-jic23@kernel.org>
 <20210603180612.3635250-4-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210603180612.3635250-4-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jun 03, 2021 at 07:06:11PM +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Since:
> commit cbacb5ab0aa0 ("docs: printk-formats: Stop encouraging use of
> unnecessary %h[xudi] and %hh[xudi]")
> use of these format strings has been discouraged.
> 
> Use the 0x02x form as the length specifier when used with # includes
> the 0x prefix and is very unlikely to be what was intended by the author.
> 
> Part of a series removing all uses from IIO in the interestings of
> avoiding providing bad examples for people to copy.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Nathan Chancellor <nathan@kernel.org>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 64704b55f6eb..b7254d9e0fe2 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -1314,8 +1314,7 @@ static int inv_check_and_setup_chip(struct inv_mpu6050_state *st)
>  		for (i = 0; i < INV_NUM_PARTS; ++i) {
>  			if (regval == hw_info[i].whoami) {
>  				dev_warn(regmap_get_device(st->map),
> -					"whoami mismatch got %#02x (%s)"
> -					"expected %#02hhx (%s)\n",
> +					"whoami mismatch got 0x%02x (%s) expected 0x%02x (%s)\n",
>  					regval, hw_info[i].name,
>  					st->hw->whoami, st->hw->name);
>  				break;
> @@ -1323,7 +1322,7 @@ static int inv_check_and_setup_chip(struct inv_mpu6050_state *st)
>  		}
>  		if (i >= INV_NUM_PARTS) {
>  			dev_err(regmap_get_device(st->map),
> -				"invalid whoami %#02x expected %#02hhx (%s)\n",
> +				"invalid whoami 0x%02x expected 0x%02x (%s)\n",
>  				regval, st->hw->whoami, st->hw->name);
>  			return -ENODEV;
>  		}
> -- 
> 2.31.1
