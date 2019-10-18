Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC7BDBC09
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2019 06:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441887AbfJREyZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Oct 2019 00:54:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37000 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfJREyY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Oct 2019 00:54:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+gmJFwPTLJnUh/WDPO0VF7a4d47hpgmMAOiP9M55Zeg=; b=LMn5Lir/3N/LryNFA6ICA1zrV
        FWVCnM95mEduMlCsXkkLjjwC5ps8TjttTYNwbjogDo73VgiqSSI/3irCgsT818J4S4tsPyNQ2CU2Z
        7WTjF778dM6svp/5Pq+xHtZB2v+CnyBHC1CGbTT92hL6q61q77HPRuO7YTFGI0G+roa01DAvGqdo9
        ZvNTjVDJlIm1nzxRJQeB0ypxI+rMchwbplGpIouuwS3dtABbrWISYHG4mcxqn6dSuWVuV+/DRDR+e
        DgOkFxuc63Jt/jP2rKeTG35bPyK0JENMFWECC1LBJgZTS/5uZbUY3j4G5tK8OE2CDgbANGYsA5PyO
        +ltEZYi9Q==;
Received: from [2601:1c0:6280:3f0::9ef4]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iLJpa-0000XQ-JC; Fri, 18 Oct 2019 04:25:38 +0000
Subject: Re: [PATCH v4 2/2] iio: (bma400) add driver for the BMA400
To:     Dan Robertson <dan@dlrobertson.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        devicetree@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
References: <20191018031848.18538-1-dan@dlrobertson.com>
 <20191018031848.18538-3-dan@dlrobertson.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <487efd2c-b453-6c8b-eaac-7ba168bb4d77@infradead.org>
Date:   Thu, 17 Oct 2019 21:25:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191018031848.18538-3-dan@dlrobertson.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 10/17/19 8:18 PM, Dan Robertson wrote:
> Add a IIO driver for the Bosch BMA400 3-axes ultra-low power accelerometer.
> The driver supports reading from the acceleration and temperature
> registers. The driver also supports reading and configuring the output data
> rate, oversampling ratio, and scale.
> 
> Signed-off-by: Dan Robertson <dan@dlrobertson.com>

Hi,
I'm repeating some comments from my V2 review.

> ---
>  drivers/iio/accel/Kconfig       |  18 +
>  drivers/iio/accel/Makefile      |   2 +
>  drivers/iio/accel/bma400.h      |  85 ++++
>  drivers/iio/accel/bma400_core.c | 796 ++++++++++++++++++++++++++++++++
>  drivers/iio/accel/bma400_i2c.c  |  60 +++
>  5 files changed, 961 insertions(+)
>  create mode 100644 drivers/iio/accel/bma400.h
>  create mode 100644 drivers/iio/accel/bma400_core.c
>  create mode 100644 drivers/iio/accel/bma400_i2c.c
> 
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index 9b9656ce37e6..a1081b902d16 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -112,6 +112,24 @@ config BMA220
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called bma220_spi.
>  
> +config BMA400
> +	tristate "Bosch BMA400 3-Axis Accelerometer Driver"
> +	depends on I2C
> +	select REGMAP
> +	select BMA400_I2C if (I2C)

Since BMA400 already depends on I2C, the "if (I2C)" above is
redundant so it's not needed.

> +	help
> +	  Say Y here if you want to build a driver for the Bosch BMA400
> +	  triaxial acceleration sensor.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called bma400_core and you will also get
> +	  bma400_i2c for I2C.
> +
> +config BMA400_I2C
> +	tristate
> +	depends on BMA400
> +	select REGMAP_I2C
> +
>  config BMC150_ACCEL
>  	tristate "Bosch BMC150 Accelerometer Driver"
>  	select IIO_BUFFER


> diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
> new file mode 100644
> index 000000000000..80f1ee6713fa
> --- /dev/null
> +++ b/drivers/iio/accel/bma400_core.c
> @@ -0,0 +1,796 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * bma400_core.c - Core IIO driver for Bosch BMA400 triaxial acceleration
> + *                 sensor. Used by bma400-i2c.
> + *
> + * Copyright 2019 Dan Robertson <dan@dlrobertson.com>
> + *
> + * TODO:
> + *  - Support for power management
> + *  - Support events and interrupts
> + *  - Create channel the step count
> + *  - Create channel for sensor time
> + */
> +
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/bitops.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +
> +#include "bma400.h"
> +
> +/*
> + * The G-range selection may be one of 2g, 4g, 8, or 16g. The scale may
> + * be selected with the acc_range bits of the ACC_CONFIG1 register.
> + */
> +static const int bma400_scale_table[] = {
> +	0, 38344,
> +	0, 76590,
> +	0, 153277,
> +	0, 306457
> +};
> +
> +static const int bma400_osr_table[] = { 0, 1, 3 };
> +
> +/* See the ACC_CONFIG1 section of the datasheet */
> +static const int bma400_sample_freqs[] = {
> +	12,  500000,
> +	25,  0,
> +	50,  0,
> +	100, 0,
> +	200, 0,
> +	400, 0,
> +	800, 0,
> +};
> +
> +/* See the ACC_CONFIG0 section of the datasheet */
> +enum bma400_power_mode {
> +	POWER_MODE_SLEEP   = 0x00,
> +	POWER_MODE_LOW     = 0x01,
> +	POWER_MODE_NORMAL  = 0x02,
> +	POWER_MODE_INVALID = 0x03,
> +};
> +
> +struct bma400_sample_freq {
> +	int hz;
> +	int uhz;
> +};
> +
> +struct bma400_data {
> +	struct device *dev;
> +	struct mutex mutex; /* data register lock */

needs #include <linux/mutex.h>

> +	struct iio_mount_matrix orientation;
> +	struct regmap *regmap;
> +	enum bma400_power_mode power_mode;
> +	struct bma400_sample_freq sample_freq;
> +	int oversampling_ratio;
> +	int scale;
> +};
> +

[snip]

> +static int bma400_get_accel_scale_idx(struct bma400_data *data, int val)
> +{
> +	int i;
> +
> +	for (i = 1; i < ARRAY_SIZE(bma400_scale_table); i += 2) {

needs #include <linux/kernel.h>
for ARRAY_SIZE()

> +		if (bma400_scale_table[i] == val)
> +			return i - 1;
> +	}
> +	return -EINVAL;
> +}

[snip]

Thanks.

-- 
~Randy
See Documentation/process/submit-checklist.rst, especially Rule #1.

