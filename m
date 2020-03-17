Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29D5C188F04
	for <lists+linux-iio@lfdr.de>; Tue, 17 Mar 2020 21:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgCQUde (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Mar 2020 16:33:34 -0400
Received: from www381.your-server.de ([78.46.137.84]:56382 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbgCQUde (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Mar 2020 16:33:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2JsBP9fmLHaRsukOJ9TcC03fI8nWLje23ob6mwEl1mE=; b=bepBZpU4L2laT9nJkkLkl76aBm
        3hoQjX/kOn9vihxJ55hZVPzRPdYfG/7VoX8YMEDmN+bAdjtmg31tmIguuSHMrKRcgo/8VMBxmEmbj
        P3VhRhPHpaLR/Y6XDYtc4jXySt6QNjMXk9SlcwOqw64hrIDsmazpT8OBzYOWj8ZF+3Mm7jaCO8vNi
        sDeQ3ahV3kHSYWlFLUZBb3bnq+5oGjvoTPAawP4G37wwL0DoKifCKXd4NFfLZWhkC3VN6IjJrQnTG
        ECtNmy2ETR+61lkg6PqVs8djyQw3+SrdlDC1jSrc3WrOpxuf81Jmo2TttlIom34Uu17HM4PnzXir8
        wlg8tGPw==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1jEIu3-0007Op-B6; Tue, 17 Mar 2020 21:33:31 +0100
Received: from [93.104.105.202] (helo=[192.168.178.20])
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1jEIu3-000RbX-0f; Tue, 17 Mar 2020 21:33:31 +0100
Subject: Re: [PATCH 1/2] iio: adc: Add MAX1241 driver
To:     Alexandru Lazar <alazar@startmail.com>, linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, knaack.h@gmx.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com
References: <20200317201710.23180-1-alazar@startmail.com>
 <20200317201710.23180-2-alazar@startmail.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <370e807c-da03-e925-2eac-1e7e92c124e4@metafoo.de>
Date:   Tue, 17 Mar 2020 21:33:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200317201710.23180-2-alazar@startmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.2/25754/Tue Mar 17 14:09:15 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/17/20 9:17 PM, Alexandru Lazar wrote:
> Add driver for the Maxim MAX1241 12-bit, single-channel ADC. The driver
> includes support for this device's low-power operation mode.
> 
> Signed-off-by: Alexandru Lazar <alazar@startmail.com>

Hi,

Looks very good, small clean driver. Few comments inline

> ---
>   drivers/iio/adc/Kconfig   |  12 +++
>   drivers/iio/adc/Makefile  |   1 +
>   drivers/iio/adc/max1241.c | 215 ++++++++++++++++++++++++++++++++++++++
>   3 files changed, 228 insertions(+)
>   create mode 100644 drivers/iio/adc/max1241.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 5d8540b7b427..3a55beec69c9 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -566,6 +566,18 @@ config MAX1118
>   	  To compile this driver as a module, choose M here: the module will be
>   	  called max1118.
>   
> +config MAX1241
> +	tristate "Maxim max1241 ADC driver"
> +	depends on SPI

depends on SPI_MASTER

There is also SPI_SLAVE support no in the kernel and just SPI does not 
imply SPI_MASTER.

> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	help
> +	  Say yes here to build support for Maxim max1241 12-bit, single-channel
> +          ADC.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called max1118.
> +
> diff --git a/drivers/iio/adc/max1241.c b/drivers/iio/adc/max1241.c
> new file mode 100644
> index 000000000000..2bd31f22fb2c
> --- /dev/null
> +++ b/drivers/iio/adc/max1241.c
> @@ -0,0 +1,215 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * MAX1241 low-power, 12-bit serial ADC
> + *
> + * Copyright (c) 2020 Ioan-Alexandru Lazar <alazar@startmail.com>
> + *
> + * This file is subject to the terms and conditions of version 2 of
> + * the GNU General Public License.  See the file COPYING in the main
> + * directory of this archive for more details.
> + *
> + * Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX1240-MAX1241.pdf
> + */
> +
> +#include <linux/regulator/consumer.h>
> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/gpio.h>

Probably only needs the gpio/consumer.h, but not the other two gpio 
includes.

> +#include <linux/iio/iio.h>
> +#include <linux/module.h>
> +#include <linux/spi/spi.h>
> +
> [...]
> +
> +static int max1241_read(struct max1241 *adc)
> +{
> +	int ret;
> +	struct spi_device *spi = adc->spi;

I'd go without the spi variable here and just use adc->spi directly when 
calling spi_sync_transfer().

> +	struct spi_transfer xfers[] = {
> +		/*
> +		 * Begin conversion by bringing /CS low for at least
> +		 * tconv us.
> +		 */
> +		{
> +			.len = 0,
> +			.delay_usecs = 8,
> +		},
> +		/*
> +		 * Then read two bytes of data in our RX buffer.
> +		 */
> +		{
> +			.rx_buf = &adc->data,
> +			.len = 2,
> +		},
> +	};
> +
> +	ret = spi_sync_transfer(spi, xfers, 2);

ARRAY_SIZE(xfers) instead of 2.

Maybe also directly 'return spi_sync_transfer()'.

> +
> +	return ret;
> +}
> [...]
> +static int max1241_probe(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev;
> +	struct max1241 *adc;
> +	int ret = 0;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*adc));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	adc = iio_priv(indio_dev);
> +	adc->spi = spi;
> +	mutex_init(&adc->lock);
> +
> +	spi_set_drvdata(spi, indio_dev);
> +
> +	adc->reg = devm_regulator_get(&spi->dev, "vref");
> +	if (IS_ERR(adc->reg)) {
> +		dev_err(&spi->dev, "failed to get vref regulator\n");
> +		return PTR_ERR(adc->reg);
> +	}
> +
> +	ret = regulator_enable(adc->reg);
> +	if (ret)
> +		return ret;
> +
> +	adc->shdn = devm_gpiod_get_optional(&spi->dev, "shdn", GPIOD_OUT_HIGH);

Makes sense to check for IS_ERR(adc->shdn) here and return if there is 
an error. This allows you to handle both probe deferral as well as if 
there is a mistake in the GPIO specification in the devicetree.

> +	if (!adc->shdn)
> +		dev_info(&spi->dev, "no shdn pin passed, low-power mode disabled");
> +	else
> +		dev_info(&spi->dev, "shdn pin passed, low-power mode enabled");

I can see how these message above are useful during development, but I'd 
remove them or turn them into dev_dbg() for the "production" version of 
the driver. Imagine every driver printed something like this, there 
would be a lot of spam in the bootlog.

> +
> +	indio_dev->name = spi_get_device_id(spi)->name;
> +	indio_dev->dev.parent = &spi->dev;
> +	indio_dev->info = &max1241_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = max1241_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(max1241_channels);
> +
> +	ret = iio_device_register(indio_dev);
> +
> +	return ret;

I'd go with just "return iio_device_register()".

> +}
> +
> +static int max1241_remove(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> +	struct max1241 *adc = iio_priv(indio_dev);
> +	int ret = 0;
> +
> +	iio_device_unregister(indio_dev);
> +	ret = regulator_disable(adc->reg);
> +
> +	return ret;

Remove can't really fail, the return type is only int for historic 
reasons. The function should always return 0.

> +}

