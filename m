Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 592211A710F
	for <lists+linux-iio@lfdr.de>; Tue, 14 Apr 2020 04:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404128AbgDNCi5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Apr 2020 22:38:57 -0400
Received: from server-x.ipv4.hkg02.ds.network ([27.111.83.178]:52660 "EHLO
        mail.gtsys.com.hk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S2404127AbgDNCi4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Apr 2020 22:38:56 -0400
X-Greylist: delayed 315 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Apr 2020 22:38:55 EDT
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id F157D2008055;
        Tue, 14 Apr 2020 10:38:53 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NDQZYkZBUoOp; Tue, 14 Apr 2020 10:38:53 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id C453B20129DE;
        Tue, 14 Apr 2020 10:38:53 +0800 (HKT)
Received: from [10.128.2.32] (unknown [124.217.188.215])
        by s01.gtsys.com.hk (Postfix) with ESMTPSA id D4A04C01A1D;
        Tue, 14 Apr 2020 10:38:52 +0800 (HKT)
Subject: Re: [PATCH 1/2] iio: DAC extension for ltc2634-12/10/8
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stefan Popa <stefan.popa@analog.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Fontana <rfontana@redhat.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200408080338.11080-1-chris.ruehl@gtsys.com.hk>
 <20200412120149.73c32f28@archlinux>
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
Message-ID: <6cb6cdf7-6012-03cb-e949-93ecd9a47214@gtsys.com.hk>
Date:   Tue, 14 Apr 2020 10:38:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200412120149.73c32f28@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Jonathan

On 12/4/2020 7:02 pm, Jonathan Cameron wrote:
> On Wed,  8 Apr 2020 16:03:29 +0800
> Chris Ruehl <chris.ruehl@gtsys.com.hk> wrote:
> 
>> This patch add support for Analog Devices (Linear Technology)
>> LTC26234 Quad 12-/10-/8-Bit Rail-to-Rail DAC.
>> The SPI functionality based on them from LTC2632 therefor
>> add the definitions only and update the Kconfig.
>>
>> Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
> Hi Chris
> 
> Process wise, please make sure patches appear as a series, preferably
> with a cover letter patch to give a quick overview.
> 
> Otherwise, it's far too easy for bad timing to mean a bunch of other
> emails turn up in the middle in people's inboxes!
> 
> One minor thing inline.
> 
> Thanks,
> 
> Jonathan
> 

Got it. v2 is then on the way !
txt file -> yaml
with documentation fix as separate patch
*the marginal one :)

Chris

> 
>> ---
>>   drivers/iio/dac/Kconfig   |  6 ++--
>>   drivers/iio/dac/ltc2632.c | 61 +++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 64 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
>> index 93744011b63f..e14c9b14c4de 100644
>> --- a/drivers/iio/dac/Kconfig
>> +++ b/drivers/iio/dac/Kconfig
>> @@ -279,12 +279,12 @@ config LTC1660
>>   	  module will be called ltc1660.
>>   
>>   config LTC2632
>> -	tristate "Linear Technology LTC2632-12/10/8 and LTC2636-12/10/8 DAC spi driver"
>> +	tristate "Linear Technology LTC2632,LTC2634,LTC2636-12/10/8 DAC spi driver"
> 
> Hmm. That's marginal.  At somepoint we'll just have to give in and say
> "LTC2632 and similar" and rely on people grepping part names to find them
> in the help text.
> 
>>   	depends on SPI
>>   	help
>>   	  Say yes here to build support for Linear Technology
>> -	  LTC2632-12, LTC2632-10, LTC2632-8, LTC2636-12, LTC2636-10 and
>> -	  LTC2636-8 converters (DAC).
>> +	  LTC2632, LTC2634 and LTC2636 DAC resolution 12/10/8 bit
>> +	  low 0-2.5V and high 0-4,096V range converters.
>>   
>>   	  To compile this driver as a module, choose M here: the
>>   	  module will be called ltc2632.
>> diff --git a/drivers/iio/dac/ltc2632.c b/drivers/iio/dac/ltc2632.c
>> index 7adc91056aa1..e939d7f81014 100644
>> --- a/drivers/iio/dac/ltc2632.c
>> +++ b/drivers/iio/dac/ltc2632.c
>> @@ -24,6 +24,7 @@
>>   /**
>>    * struct ltc2632_chip_info - chip specific information
>>    * @channels:		channel spec for the DAC
>> + * @num_channels:	DAC channel count of the chip
> 
> Good to fix this but please pull it out as a precursor patch - ideally
> with a fixes tag even though it's just documentation.
> 
>>    * @vref_mv:		internal reference voltage
>>    */
>>   struct ltc2632_chip_info {
>> @@ -53,6 +54,12 @@ enum ltc2632_supported_device_ids {
>>   	ID_LTC2632H12,
>>   	ID_LTC2632H10,
>>   	ID_LTC2632H8,
>> +	ID_LTC2634L12,
>> +	ID_LTC2634L10,
>> +	ID_LTC2634L8,
>> +	ID_LTC2634H12,
>> +	ID_LTC2634H10,
>> +	ID_LTC2634H8,
>>   	ID_LTC2636L12,
>>   	ID_LTC2636L10,
>>   	ID_LTC2636L8,
>> @@ -235,6 +242,36 @@ static const struct ltc2632_chip_info ltc2632_chip_info_tbl[] = {
>>   		.num_channels	= 2,
>>   		.vref_mv	= 4096,
>>   	},
>> +	[ID_LTC2634L12] = {
>> +		.channels	= ltc2632x12_channels,
>> +		.num_channels	= 4,
>> +		.vref_mv	= 2500,
>> +	},
>> +	[ID_LTC2634L10] = {
>> +		.channels	= ltc2632x10_channels,
>> +		.num_channels	= 4,
>> +		.vref_mv	= 2500,
>> +	},
>> +	[ID_LTC2634L8] =  {
>> +		.channels	= ltc2632x8_channels,
>> +		.num_channels	= 4,
>> +		.vref_mv	= 2500,
>> +	},
>> +	[ID_LTC2634H12] = {
>> +		.channels	= ltc2632x12_channels,
>> +		.num_channels	= 4,
>> +		.vref_mv	= 4096,
>> +	},
>> +	[ID_LTC2634H10] = {
>> +		.channels	= ltc2632x10_channels,
>> +		.num_channels	= 4,
>> +		.vref_mv	= 4096,
>> +	},
>> +	[ID_LTC2634H8] =  {
>> +		.channels	= ltc2632x8_channels,
>> +		.num_channels	= 4,
>> +		.vref_mv	= 4096,
>> +	},
>>   	[ID_LTC2636L12] = {
>>   		.channels	= ltc2632x12_channels,
>>   		.num_channels	= 8,
>> @@ -356,6 +393,12 @@ static const struct spi_device_id ltc2632_id[] = {
>>   	{ "ltc2632-h12", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2632H12] },
>>   	{ "ltc2632-h10", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2632H10] },
>>   	{ "ltc2632-h8", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2632H8] },
>> +	{ "ltc2634-l12", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2634L12] },
>> +	{ "ltc2634-l10", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2634L10] },
>> +	{ "ltc2634-l8", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2634L8] },
>> +	{ "ltc2634-h12", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2634H12] },
>> +	{ "ltc2634-h10", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2634H10] },
>> +	{ "ltc2634-h8", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2634H8] },
>>   	{ "ltc2636-l12", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2636L12] },
>>   	{ "ltc2636-l10", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2636L10] },
>>   	{ "ltc2636-l8", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2636L8] },
>> @@ -385,6 +428,24 @@ static const struct of_device_id ltc2632_of_match[] = {
>>   	}, {
>>   		.compatible = "lltc,ltc2632-h8",
>>   		.data = &ltc2632_chip_info_tbl[ID_LTC2632H8]
>> +	}, {
>> +		.compatible = "lltc,ltc2634-l12",
>> +		.data = &ltc2632_chip_info_tbl[ID_LTC2634L12]
>> +	}, {
>> +		.compatible = "lltc,ltc2634-l10",
>> +		.data = &ltc2632_chip_info_tbl[ID_LTC2634L10]
>> +	}, {
>> +		.compatible = "lltc,ltc2634-l8",
>> +		.data = &ltc2632_chip_info_tbl[ID_LTC2634L8]
>> +	}, {
>> +		.compatible = "lltc,ltc2634-h12",
>> +		.data = &ltc2632_chip_info_tbl[ID_LTC2634H12]
>> +	}, {
>> +		.compatible = "lltc,ltc2634-h10",
>> +		.data = &ltc2632_chip_info_tbl[ID_LTC2634H10]
>> +	}, {
>> +		.compatible = "lltc,ltc2634-h8",
>> +		.data = &ltc2632_chip_info_tbl[ID_LTC2634H8]
>>   	}, {
>>   		.compatible = "lltc,ltc2636-l12",
>>   		.data = &ltc2632_chip_info_tbl[ID_LTC2636L12]
> 

-- 
GTSYS Limited RFID Technology
9/F, Unit E, R07, Kwai Shing Industrial Building Phase 2,
42-46 Tai Lin Pai Road, Kwai Chung, N.T., Hong Kong
Tel (852) 9079 9521

Disclaimer: https://www.gtsys.com.hk/email/classified.html
