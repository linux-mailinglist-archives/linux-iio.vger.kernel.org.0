Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5203C485
	for <lists+linux-iio@lfdr.de>; Tue, 11 Jun 2019 08:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403752AbfFKGwf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 Jun 2019 02:52:35 -0400
Received: from www381.your-server.de ([78.46.137.84]:44702 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbfFKGwf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 Jun 2019 02:52:35 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1haadx-0001Pb-VZ; Tue, 11 Jun 2019 08:52:30 +0200
Received: from [93.104.98.68] (helo=[192.168.178.20])
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <lars@metafoo.de>)
        id 1haadx-000PAJ-NH; Tue, 11 Jun 2019 08:52:29 +0200
Subject: Re: [PATCH] iio: adc: xilinx: support all platforms
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "hancock@sedsystems.ca" <hancock@sedsystems.ca>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Cc:     "ardeleanalex@gmail.com" <ardeleanalex@gmail.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>
References: <1560183824-19061-1-git-send-email-hancock@sedsystems.ca>
 <2c4116f4923ac710de15c2980e620f9d59f902b6.camel@analog.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <23b0143d-7089-cba0-813d-2634345a66c4@metafoo.de>
Date:   Tue, 11 Jun 2019 08:52:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <2c4116f4923ac710de15c2980e620f9d59f902b6.camel@analog.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.100.3/25476/Mon Jun 10 09:55:34 2019)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 6/11/19 8:28 AM, Ardelean, Alexandru wrote:
> On Mon, 2019-06-10 at 10:23 -0600, Robert Hancock wrote:
>> [External]
>>
>>
>> Since the XADC logic can be used with standalone Xilinx FPGAs, this
>> driver can potentially be used with many different platforms, not just
>> the Zynq and MicroBlaze platforms this driver was allowed to be built
>> for. There should be no platform-specific code in this driver, so just
>> delete the platform dependency.
>>
>> Signed-off-by: Robert Hancock <hancock@sedsystems.ca>
>> ---
>>
>> This is an updated version of an earlier patch "iio: adc: xilinx: support all
>> ARM platforms", but this one just deletes the platform restriction entirely
>> as it seems unnecessary.
>>
>>  drivers/iio/adc/Kconfig | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>> index f96a770..7e32862 100644
>> --- a/drivers/iio/adc/Kconfig
>> +++ b/drivers/iio/adc/Kconfig
>> @@ -1085,7 +1085,6 @@ config VIPERBOARD_ADC
>>
>>  config XILINX_XADC
>>         tristate "Xilinx XADC driver"
>> -       depends on ARCH_ZYNQ || MICROBLAZE || COMPILE_TEST
> 
> Just curios here: is `depends COMPILE_TEST` needed so that this gets included in a compile-test build ?
> I'm somewhat vague on Linux's makefile logic/structure.

COMPILE_TEST enables the driver for compile testing if it is not already
enabled otherwise. Now that the driver has no dependencies at all it
will always be enabled, which includes compile testing.
