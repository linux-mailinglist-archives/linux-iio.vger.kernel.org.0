Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 515B039A59C
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jun 2021 18:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbhFCQU3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Jun 2021 12:20:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:59890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229506AbhFCQU3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 3 Jun 2021 12:20:29 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44611613D2;
        Thu,  3 Jun 2021 16:18:41 +0000 (UTC)
Date:   Thu, 3 Jun 2021 17:20:25 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Meng.Li@windriver.com
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, pmeerw@pmeerw.net,
        u.kleine-koenig@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] driver: adc: ltc2497: return directly after reading the
 adc conversion value
Message-ID: <20210603172025.314b5ced@jic23-huawei>
In-Reply-To: <20210601092805.18385-1-Meng.Li@windriver.com>
References: <20210601092805.18385-1-Meng.Li@windriver.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue,  1 Jun 2021 17:28:05 +0800
Meng.Li@windriver.com wrote:

> From: Meng Li <Meng.Li@windriver.com>
> 
> When read adc conversion value with below command:
> cat /sys/.../iio:device0/in_voltage0-voltage1_raw
> There is an error reported as below:
> ltc2497 0-0014: i2c transfer failed: -EREMOTEIO
> This i2c transfer issue is introduced by commit 69548b7c2c4f ("iio:
> adc: ltc2497: split protocol independent part in a separate module").
> When extract the common code into ltc2497-core.c, it change the
> code logic of function ltc2497core_read(). With wrong reading
> sequence, the action of enable adc channel is sent to chip again
> during adc channel is in conversion status. In this way, there is
> no ack from chip, and then cause i2c transfer failed.
> In order to keep the code logic is the same with original ideal,
> it is need to return direct after reading the adc conversion value.
> 
> v2:
> According to ltc2497 datasheet, the max value of conversion time is
> 149.9 ms. So, add 20% to the 150msecs so that there is enough time
> for data conversion.

Version change logs go below the --- as we don't want to preserve them
forever in the git history.

I may have lost track of the discussion, but I thought the idea was that perhaps
the longer time period would remove the need for the early return?

Thanks,

Jonathan
> 
> Fixes: 69548b7c2c4f ("iio: adc: ltc2497: split protocol independent part in a separate module ")
> Cc: stable@vger.kernel.org
> Signed-off-by: Meng Li <Meng.Li@windriver.com>
> ---
>  drivers/iio/adc/ltc2497.c | 2 ++
>  drivers/iio/adc/ltc2497.h | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ltc2497.c b/drivers/iio/adc/ltc2497.c
> index 1adddf5a88a9..fd5a66860a47 100644
> --- a/drivers/iio/adc/ltc2497.c
> +++ b/drivers/iio/adc/ltc2497.c
> @@ -41,6 +41,8 @@ static int ltc2497_result_and_measure(struct ltc2497core_driverdata *ddata,
>  		}
>  
>  		*val = (be32_to_cpu(st->buf) >> 14) - (1 << 17);
> +
> +		return ret;
>  	}
>  
>  	ret = i2c_smbus_write_byte(st->client,
> diff --git a/drivers/iio/adc/ltc2497.h b/drivers/iio/adc/ltc2497.h
> index d0b42dd6b8ad..e451930837d8 100644
> --- a/drivers/iio/adc/ltc2497.h
> +++ b/drivers/iio/adc/ltc2497.h
> @@ -2,7 +2,7 @@
>  
>  #define LTC2497_ENABLE			0xA0
>  #define LTC2497_CONFIG_DEFAULT		LTC2497_ENABLE
> -#define LTC2497_CONVERSION_TIME_MS	150ULL
> +#define LTC2497_CONVERSION_TIME_MS	180ULL
>  
>  struct ltc2497core_driverdata {
>  	struct regulator *ref;

