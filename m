Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44E4D44F03E
	for <lists+linux-iio@lfdr.de>; Sat, 13 Nov 2021 01:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbhKMAl7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Nov 2021 19:41:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbhKMAl6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Nov 2021 19:41:58 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB8FC061766;
        Fri, 12 Nov 2021 16:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=9F6EZOrW/lhMYi7EcqBru1PQUWPDNkoeRqS5mGSyWZw=; b=hoDesaA+I2w1OIc6ShXlvgMBji
        iMDCyK6rTCzWPudpEEGC7jnloufAlcKCoOHS2kJRckQHyTKcUDBWir89D7Set/Ms7XgtOE47AsU90
        Ja9b3Yet+Hg1F8ZCDADidObRWwCxxCx7iTgnbNSj45HiARhAhf2YO0EjLt90h3wFHsB1IuzZC4wzK
        1JNoVPYJSPtDZjPZjeUAw/yooIDPxHxok/sXc2QuzETVukBS/fJUoVYi5O18G9bv70e+FEEJLn8xO
        DfOXGCQ2npHHvjn8Oouap4H5YGTJY3mF0pgtMj5KJrCh7nl1R9wcLzto0vS5llVM/1dA7KQ09q4h2
        EoAcL7JA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mlh4T-00BwhH-Je; Sat, 13 Nov 2021 00:39:05 +0000
Subject: Re: [PATCH v2] iio/adc: ingenic: fix (MIPS) ingenic-adc build errors
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Artur Rojek <contact@artur-rojek.eu>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-mips@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Russell King <linux@armlinux.org.uk>, linux-clk@vger.kernel.org
References: <20211110023755.27176-1-rdunlap@infradead.org>
 <20211112172942.04553027@jic23-huawei>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <dfc38220-c79a-f990-d025-c7f5344e0b9a@infradead.org>
Date:   Fri, 12 Nov 2021 16:39:04 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211112172942.04553027@jic23-huawei>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 11/12/21 9:29 AM, Jonathan Cameron wrote:
> On Tue,  9 Nov 2021 18:37:55 -0800
> Randy Dunlap <rdunlap@infradead.org> wrote:
> 
>> MIPS does not always provide clk*() interfaces and there are no
>> always-present stubs for them, so depending on "MIPS || COMPILE_TEST"
>> is not strong enough to prevent build errors.
>>
>> Likewise MACH_INGENIC_SOC || COMPILE_TEST is not strong enough
>> since if only COMPILE_TEST=y (with some other MIPS MACH_ or CPU or
>> BOARD setting), there are still the same build errors.
>>
>> It looks like depending on MACH_INGENIC is the only thing that is
>> sufficient here in order to prevent build errors.
>>
>> mips-linux-ld: drivers/iio/adc/ingenic-adc.o: in function `jz4770_adc_init_clk_div':
>> ingenic-adc.c:(.text+0xe4): undefined reference to `clk_get_parent'
>> mips-linux-ld: drivers/iio/adc/ingenic-adc.o: in function `jz4725b_adc_init_clk_div':
>> ingenic-adc.c:(.text+0x1b8): undefined reference to `clk_get_parent'
>>
>> Fixes: 1a78daea107d ("IIO: add Ingenic JZ47xx ADC driver.")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Cc: Artur Rojek <contact@artur-rojek.eu>
>> Cc: Paul Cercueil <paul@crapouillou.net>
>> Cc: linux-mips@vger.kernel.org
>> Cc: Jonathan Cameron <jic23@kernel.org>
>> Cc: Lars-Peter Clausen <lars@metafoo.de>
>> Cc: linux-iio@vger.kernel.org
>> Cc: Florian Fainelli <f.fainelli@gmail.com>
>> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> I'm a bit confused.  There are stubs in include/linux/clk.h for these.
> Why do those not apply here? Are these platforms built with CONFIG_CLK but
> don't provide all the functions?
> 
> That sounds highly error prone and rather defeats the object of the
> stubs.  Could we either provide the missing stubs, or solve this some other
> way.  I'm not keen to massively cut the build coverage this driver is getting
> by dropping COMPILE_TEST if there is any route to avoid doing so.

I'm all for that (above), but it's a mess.

> Based on the guess than any platform with clks must be able to turn them on
> I grepped for int clk_enable() and there seem to be only two possiblities
> bcm63xx and lantiq as sources of the build breakage.

CONFIG_BCM63XX=y
# CONFIG_MACH_INGENIC_SOC is not set
CONFIG_INGENIC_ADC=y
CONFIG_HAVE_CLK=y


According to the build error messages (above), clk_get_parent()
is missing. Looking at <linux/clk.h>, for CONFIG_HAVE_CLK=y,
there is a prototype for clk_get_parent(), and if CONFIG_HAVE_CLK
is not set, there is a stub for it.

Now look at drivers/clk/clk.c and drivers/clk/Makefile:

clk_get_parent() is defined in clk.c, which is built when
CONFIG_COMMON_CLK=y, but that is not set in this .config file.

CONFIG_HAVE_CLK=y, but that doesn't get clk_get_parent()
compiled.

So to me it is a disparity or incongruity between HAVE_CLK and COMMON_CLK.

Russell- do you have any suggestions for how to straighten
this out?


> Jonathan
> 
>> ---
>> v2: use MACH_INGENIC instead of MACH_INGENIC_SOC (thanks, Paul)
>>
>>   drivers/iio/adc/Kconfig |    2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> --- linux-next-20211105.orig/drivers/iio/adc/Kconfig
>> +++ linux-next-20211105/drivers/iio/adc/Kconfig
>> @@ -501,7 +501,7 @@ config INA2XX_ADC
>>   
>>   config INGENIC_ADC
>>   	tristate "Ingenic JZ47xx SoCs ADC driver"
>> -	depends on MIPS || COMPILE_TEST
>> +	depends on MACH_INGENIC
>>   	select IIO_BUFFER
>>   	help
>>   	  Say yes here to build support for the Ingenic JZ47xx SoCs ADC unit.
> 


-- 
~Randy
