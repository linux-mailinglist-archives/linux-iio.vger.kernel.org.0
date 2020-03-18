Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63F851897F0
	for <lists+linux-iio@lfdr.de>; Wed, 18 Mar 2020 10:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbgCRJbp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Mar 2020 05:31:45 -0400
Received: from www381.your-server.de ([78.46.137.84]:54006 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbgCRJbp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Mar 2020 05:31:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=TpFgcT2A69hsAHzkZ/eq7Xfpt0y03z3Espf7finxK3w=; b=B/LKwAedMxQm0+u2d+yScbP0yy
        7Gog8ZYTXNCnbnd+4RLXp9HBQiJb+mPG/eQnKhYJ/oLmqR6deemlyNsGSu5rUwXR4DwmPqI8PWabu
        LhSdCrOKt9cDuNua5lLFgVxvsJU4Tyxo/s6t2h91tHpLWP667roy4DHVZ1pqThqnm/IlVUGRGu5Sb
        G23SaVDZC99JrtDcD9aFuVB9z5+VlSd79yI6MlGsy38qg/UBxcJw2zeMX8dy9go9cLJOE8xeNRDiC
        WO2zxIkSn1VNnTuKqjQ9JXaEhDGPJD0oD6f32gRRBsSjz5yeRjsEhMm6vzyMj0P46WAwXxAqwL5V2
        47x5eSaw==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1jEV37-0004BF-Hf; Wed, 18 Mar 2020 10:31:41 +0100
Received: from [93.104.115.49] (helo=[192.168.178.20])
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1jEV37-000DLv-7l; Wed, 18 Mar 2020 10:31:41 +0100
Subject: Re: [PATCH 1/2] iio: adc: Add MAX1241 driver
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "alazar@startmail.com" <alazar@startmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Cc:     "jic23@kernel.org" <jic23@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
References: <20200317201710.23180-1-alazar@startmail.com>
 <20200317201710.23180-2-alazar@startmail.com>
 <2964715e81108283d08258bcfa8420baef36737f.camel@analog.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <c388a975-553a-c438-37de-2078555c5a89@metafoo.de>
Date:   Wed, 18 Mar 2020 10:31:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <2964715e81108283d08258bcfa8420baef36737f.camel@analog.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.2/25754/Tue Mar 17 14:09:15 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/18/20 7:50 AM, Ardelean, Alexandru wrote:
> On Tue, 2020-03-17 at 22:17 +0200, Alexandru Lazar wrote:
>> [External]
>>
>> Add driver for the Maxim MAX1241 12-bit, single-channel ADC. The driver
>> includes support for this device's low-power operation mode.
> 
> hey,
> 
> overall looks good;
> 
> i'd run ./scripts/checpatch.pl on the patches a bit;
> you can run it on the patch file, or on the git commit with
> ./scripts/checpatch.pl -g <git-commits>
> 
> i usually do ./scripts/checpatch.pl -g HEAD~2.. [or something like that] before
> generating patches;
> i sometimes forget to do that;
> 
> some more comments inline
> 
> 
>>
>> Signed-off-by: Alexandru Lazar <alazar@startmail.com>
>> ---
>>   drivers/iio/adc/Kconfig   |  12 +++
>>   drivers/iio/adc/Makefile  |   1 +
>>   drivers/iio/adc/max1241.c | 215 ++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 228 insertions(+)
>>   create mode 100644 drivers/iio/adc/max1241.c
>>
>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>> index 5d8540b7b427..3a55beec69c9 100644
>> --- a/drivers/iio/adc/Kconfig
>> +++ b/drivers/iio/adc/Kconfig
>> @@ -566,6 +566,18 @@ config MAX1118
>>   	  To compile this driver as a module, choose M here: the module will be
>>   	  called max1118.
>>   
>> +config MAX1241
>> +	tristate "Maxim max1241 ADC driver"
>> +	depends on SPI
>> +	select IIO_BUFFER
>> +	select IIO_TRIGGERED_BUFFER
>> +	help
>> +	  Say yes here to build support for Maxim max1241 12-bit, single-channel
>> +          ADC.
> 
> nitpick: this looks inconsistently indented
> 
>> +
>> +	  To compile this driver as a module, choose M here: the module will be
>> +	  called max1118.
>> +
>>   config MAX1363
>>   	tristate "Maxim max1363 ADC driver"
>>   	depends on I2C
>> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
>> index a1f1fbec0f87..37d6f17559dc 100644
>> --- a/drivers/iio/adc/Makefile
>> +++ b/drivers/iio/adc/Makefile
>> @@ -54,6 +54,7 @@ obj-$(CONFIG_LTC2497) += ltc2497.o
>>   obj-$(CONFIG_MAX1027) += max1027.o
>>   obj-$(CONFIG_MAX11100) += max11100.o
>>   obj-$(CONFIG_MAX1118) += max1118.o
>> +obj-$(CONFIG_MAX1241) += max1241.o
>>   obj-$(CONFIG_MAX1363) += max1363.o
>>   obj-$(CONFIG_MAX9611) += max9611.o
>>   obj-$(CONFIG_MCP320X) += mcp320x.o
>> diff --git a/drivers/iio/adc/max1241.c b/drivers/iio/adc/max1241.c
>> new file mode 100644
>> index 000000000000..2bd31f22fb2c
>> --- /dev/null
>> +++ b/drivers/iio/adc/max1241.c
>> @@ -0,0 +1,215 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * MAX1241 low-power, 12-bit serial ADC
>> + *
>> + * Copyright (c) 2020 Ioan-Alexandru Lazar <alazar@startmail.com>
>> + *
>> + * This file is subject to the terms and conditions of version 2 of
>> + * the GNU General Public License.  See the file COPYING in the main
>> + * directory of this archive for more details.
> 
> This license text is no longer needed.
> The SPDX-License-Identifier header should handle that.
> 
>> + *
>> + * Datasheet:
>> https://datasheets.maximintegrated.com/en/ds/MAX1240-MAX1241.pdf
>> + */
>> +
>> +#include <linux/regulator/consumer.h>
>> +#include <linux/delay.h>
>> +#include <linux/gpio/consumer.h>
>> +#include <linux/gpio/driver.h>
>> +#include <linux/gpio.h>
>> +#include <linux/iio/iio.h>
>> +#include <linux/module.h>
>> +#include <linux/spi/spi.h>
>> +
>> +#define MAX1241_VAL_MASK 0xFFF
>> +#define MAX1241_SHDN_DELAY_USEC 4
>> +
>> +enum max1241_id {
>> +	max1241,
>> +};
>> +
>> +struct max1241 {
>> +	struct spi_device *spi;
>> +	struct mutex lock;
>> +	struct regulator *reg;
>> +	struct gpio_desc *shdn;
>> +
>> +	__be16 data ____cacheline_aligned;
> 
> Jonathan may know better than me here, but you could technically avoid needing
> to explicitly use the __be16 datatype; and just use u16;
> 
> i think the SPI framework should have some handling for that;
> maybe using the 'bits_per_word' field;
> you'd probably still need to do the shifting though;
> i remember some discussion about this on ad7949.c
> though there may be other drivers doing this as well

I'd keep it as it is. Which bits_per_word values are supported depends 
on the SPI master driver. All of them support 8-bit, but many don't 
support 16-bit.

- Lars
