Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24C011A9787
	for <lists+linux-iio@lfdr.de>; Wed, 15 Apr 2020 10:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505532AbgDOIvs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Apr 2020 04:51:48 -0400
Received: from server-x.ipv4.hkg02.ds.network ([27.111.83.178]:45964 "EHLO
        mail.gtsys.com.hk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S2895105AbgDOIvg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Apr 2020 04:51:36 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 25C302007EB3;
        Wed, 15 Apr 2020 16:51:29 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8HYOaoXXubAT; Wed, 15 Apr 2020 16:51:29 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id F079D2014567;
        Wed, 15 Apr 2020 16:51:28 +0800 (HKT)
Received: from [10.128.2.32] (unknown [124.217.188.146])
        by s01.gtsys.com.hk (Postfix) with ESMTPSA id 4738BC019EC;
        Wed, 15 Apr 2020 16:51:27 +0800 (HKT)
Subject: Re: [PATCH v3 2/3] iio: DAC extension for ltc2634-12/10/8
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stefan Popa <stefan.popa@analog.com>,
        Allison Randal <allison@lohutok.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200414235609.20125-1-chris.ruehl@gtsys.com.hk>
 <20200414235609.20125-3-chris.ruehl@gtsys.com.hk>
 <20200415070025.6isvybjzpfhh3ts3@pengutronix.de>
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
Message-ID: <554f95cd-d12d-ecab-7d8d-84ab3d37c426@gtsys.com.hk>
Date:   Wed, 15 Apr 2020 16:51:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200415070025.6isvybjzpfhh3ts3@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Uwe,

On 15/4/2020 3:00 pm, Uwe Kleine-König wrote:
> On Wed, Apr 15, 2020 at 07:56:03AM +0800, Chris Ruehl wrote:
>> This patch add support for Analog Devices (Linear Technology)
>> LTC2634 Quad 12-/10-/8-Bit Rail-to-Rail DAC.
>> The SPI functionality based on them from LTC2632 therefor
>> add the definitions only and update the Kconfig.
>>
>> V2:
>> Send the documentation fix in a extra patch
>> Kconfig simplify the driver description, details to the help text
>> ltc2632.txt add to this patch-set (prepare to convert to yaml)
>>
>> V3:
>> Consistens decimal separator in help text
> 
> The description about how the patch evolves usually goes below the ---
> and S-o-b area. This way it doesn't make it into the commit history.
>>
>> Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
>> ---
>>   .../devicetree/bindings/iio/dac/ltc2632.txt   |  8 ++-
>>   drivers/iio/dac/Kconfig                       |  6 +-
>>   drivers/iio/dac/ltc2632.c                     | 60 +++++++++++++++++++
>>   3 files changed, 70 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/iio/dac/ltc2632.txt b/Documentation/devicetree/bindings/iio/dac/ltc2632.txt
>> index 338c3220f01a..1ab9570cf219 100644
>> --- a/Documentation/devicetree/bindings/iio/dac/ltc2632.txt
>> +++ b/Documentation/devicetree/bindings/iio/dac/ltc2632.txt
>> @@ -1,4 +1,4 @@
>> -Linear Technology LTC2632/2636 DAC
>> +Linear Technology LTC2632/2634/2636 DAC
>>   
>>   Required properties:
>>    - compatible: Has to contain one of the following:
>> @@ -8,6 +8,12 @@ Required properties:
>>   	lltc,ltc2632-h12
>>   	lltc,ltc2632-h10
>>   	lltc,ltc2632-h8
>> +	lltc,ltc2634-l12
>> +	lltc,ltc2634-l10
>> +	lltc,ltc2634-l8
>> +	lltc,ltc2634-h12
>> +	lltc,ltc2634-h10
>> +	lltc,ltc2634-h8
>>   	lltc,ltc2636-l12
>>   	lltc,ltc2636-l10
>>   	lltc,ltc2636-l8
>> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
>> index 93744011b63f..aee13ced6ddf 100644
>> --- a/drivers/iio/dac/Kconfig
>> +++ b/drivers/iio/dac/Kconfig
>> @@ -279,12 +279,12 @@ config LTC1660
>>   	  module will be called ltc1660.
>>   
>>   config LTC2632
>> -	tristate "Linear Technology LTC2632-12/10/8 and LTC2636-12/10/8 DAC spi driver"
>> +	tristate "Linear Technology LTC2632-12/10/8 and similar DAC spi driver"
>>   	depends on SPI
>>   	help
>>   	  Say yes here to build support for Linear Technology
>> -	  LTC2632-12, LTC2632-10, LTC2632-8, LTC2636-12, LTC2636-10 and
>> -	  LTC2636-8 converters (DAC).
>> +	  LTC2632, LTC2634 and LTC2636 DAC resolution 12/10/8 bit
>> +	  low 0-2.5V and high 0-4.096V range converters.
>>   
> 
> The naming pattern seems to be:
> 
> 	LTC263ab-cc
> 
> with:
> 
> 	a = 2 -> 2 channels
> 	a = 4 -> 4 channels
> 	a = 6 -> 8 channels
> 
> 	b = L -> Vref = 2.5V
> 	b = H -> Vref = 4.096V
> 
> 	cc = 8 -> 8 bit precision
> 	cc = 10 -> 10 bit precision
> 	cc = 12 -> 12 bit precision
> 
> Would it make sense to document this somewhere?
> 
> But as this is (somewhat) orthogonal to this patch:
> 
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> Best regards
> Uwe
> 

General I think that is a good solution to be precise in the description.
Update the device-tree lltc,ltc2632.yaml with this kind of
information, its logically the better place - IMHO

Kind regards
Chris

-- 
GTSYS Limited RFID Technology
9/F, Unit E, R07, Kwai Shing Industrial Building Phase 2,
42-46 Tai Lin Pai Road, Kwai Chung, N.T., Hong Kong
Tel (852) 9079 9521

Disclaimer: https://www.gtsys.com.hk/email/classified.html
