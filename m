Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E62CD44F677
	for <lists+linux-iio@lfdr.de>; Sun, 14 Nov 2021 06:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbhKNFIq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Nov 2021 00:08:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbhKNFIp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 Nov 2021 00:08:45 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F74C061570;
        Sat, 13 Nov 2021 21:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=WSZAJWnSjsbo4e+miaBI6kfHsQhyjZbf6uMSU2h/JBc=; b=ujgJy89Z75oLk75/BikSTdUjbA
        qcNnUPfbGOGHC/2rzSBRE1TffQQpmK2yUapDzQWGkmjF6nNBG8QIdS9R7ZFifAabEOimiERmXOMTL
        4ZHdHp1gwcysSLOJpider74Y6y3Ib1WIPd+KdJxu1yBNKbZFpwAGj28/yYs1Sm5DPaAakzadqiE+B
        /nX3bvSoCBo5EEZxstwR4V8O0Ba3xno0RMc+FqHgZyPVKo306DRt0501z2Vn8BzZ0tInZtph7HSzM
        ZNq+kWZuuUvzqD4YbAy2UoVxS+os9ea6SehhwZQfuiEtFuOKr9En6im2wOF59ve6NNo8T1HmGsJGi
        O69yKHRg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mm7i9-00DKbW-If; Sun, 14 Nov 2021 05:05:49 +0000
Subject: Re: [PATCH v2] iio/adc: ingenic: fix (MIPS) ingenic-adc build errors
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Artur Rojek <contact@artur-rojek.eu>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-mips@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-clk@vger.kernel.org
References: <20211110023755.27176-1-rdunlap@infradead.org>
 <20211112172942.04553027@jic23-huawei>
 <dfc38220-c79a-f990-d025-c7f5344e0b9a@infradead.org>
 <YY94mLIM311/XiXU@shell.armlinux.org.uk>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e8ea9d51-a86b-16b3-eab0-e872b51781f3@infradead.org>
Date:   Sat, 13 Nov 2021 21:05:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YY94mLIM311/XiXU@shell.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 11/13/21 12:34 AM, Russell King (Oracle) wrote:
> On Fri, Nov 12, 2021 at 04:39:04PM -0800, Randy Dunlap wrote:
>> On 11/12/21 9:29 AM, Jonathan Cameron wrote:
>>> On Tue,  9 Nov 2021 18:37:55 -0800
>>> Randy Dunlap <rdunlap@infradead.org> wrote:
>>>
>>>> MIPS does not always provide clk*() interfaces and there are no
>>>> always-present stubs for them, so depending on "MIPS || COMPILE_TEST"
>>>> is not strong enough to prevent build errors.
>>>>
>>>> Likewise MACH_INGENIC_SOC || COMPILE_TEST is not strong enough
>>>> since if only COMPILE_TEST=y (with some other MIPS MACH_ or CPU or
>>>> BOARD setting), there are still the same build errors.
>>>>
>>>> It looks like depending on MACH_INGENIC is the only thing that is
>>>> sufficient here in order to prevent build errors.
>>>>
>>>> mips-linux-ld: drivers/iio/adc/ingenic-adc.o: in function `jz4770_adc_init_clk_div':
>>>> ingenic-adc.c:(.text+0xe4): undefined reference to `clk_get_parent'
>>>> mips-linux-ld: drivers/iio/adc/ingenic-adc.o: in function `jz4725b_adc_init_clk_div':
>>>> ingenic-adc.c:(.text+0x1b8): undefined reference to `clk_get_parent'
>>>>
>>>> Fixes: 1a78daea107d ("IIO: add Ingenic JZ47xx ADC driver.")
>>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>> Cc: Artur Rojek <contact@artur-rojek.eu>
>>>> Cc: Paul Cercueil <paul@crapouillou.net>
>>>> Cc: linux-mips@vger.kernel.org
>>>> Cc: Jonathan Cameron <jic23@kernel.org>
>>>> Cc: Lars-Peter Clausen <lars@metafoo.de>
>>>> Cc: linux-iio@vger.kernel.org
>>>> Cc: Florian Fainelli <f.fainelli@gmail.com>
>>>> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
>>>
>>> I'm a bit confused.  There are stubs in include/linux/clk.h for these.
>>> Why do those not apply here? Are these platforms built with CONFIG_CLK but
>>> don't provide all the functions?
>>>
>>> That sounds highly error prone and rather defeats the object of the
>>> stubs.  Could we either provide the missing stubs, or solve this some other
>>> way.  I'm not keen to massively cut the build coverage this driver is getting
>>> by dropping COMPILE_TEST if there is any route to avoid doing so.
>>
>> I'm all for that (above), but it's a mess.
>>
>>> Based on the guess than any platform with clks must be able to turn them on
>>> I grepped for int clk_enable() and there seem to be only two possiblities
>>> bcm63xx and lantiq as sources of the build breakage.
>>
>> CONFIG_BCM63XX=y
>> # CONFIG_MACH_INGENIC_SOC is not set
>> CONFIG_INGENIC_ADC=y
>> CONFIG_HAVE_CLK=y
>>
>>
>> According to the build error messages (above), clk_get_parent()
>> is missing. Looking at <linux/clk.h>, for CONFIG_HAVE_CLK=y,
>> there is a prototype for clk_get_parent(), and if CONFIG_HAVE_CLK
>> is not set, there is a stub for it.
>>
>> Now look at drivers/clk/clk.c and drivers/clk/Makefile:
>>
>> clk_get_parent() is defined in clk.c, which is built when
>> CONFIG_COMMON_CLK=y, but that is not set in this .config file.
>>
>> CONFIG_HAVE_CLK=y, but that doesn't get clk_get_parent()
>> compiled.
>>
>> So to me it is a disparity or incongruity between HAVE_CLK and COMMON_CLK.
> 
> HAVE_CLK means we have the clk API implemented. COMMON_CLK is one such
> implementation, and HAVE_LEGACY_CLK is another group of implementations.
> 
> BCM63XX has its own implementation and uses HAVE_LEGACY_CLK, which can
> be found in arch/mips/bcm63xx/clk.c.
> 
> If it doesn't support parent clocks, then it should provide a stub
> clk_get_parent() that returns NULL at the very least.
> 

Russell- thanks for the explanation.
That works nicely.

Jonathan, I'll send a different patch.

-- 
~Randy
