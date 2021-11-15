Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDF3D44FC91
	for <lists+linux-iio@lfdr.de>; Mon, 15 Nov 2021 01:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234872AbhKOAVl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Nov 2021 19:21:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhKOAVe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 Nov 2021 19:21:34 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1534EC061746;
        Sun, 14 Nov 2021 16:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=n7f9L6nx97YdTMJtP7Ls20RES49EFohNDqW95oBsSWY=; b=Zxi1+EIOrcK/rOWj+FPvb2vDUw
        CD/VANxP1wj4zu0JsIkcSS3zU9l3wHT7wPtYamN00RJiOtOKcBsPhsmImjKbWYlFizhj4E7t8XDeH
        sVS3ihLgkt2rzRgX/CNcN5OE6huxfg5JJnm+QPl211tN72lnFbpOV3XP5k5aEIIm0RH2ZRKwjX7cq
        gb53nGqNv8aQMco8wVnSwKA+WsaAeXIOYHFS0HNQI3Q708aZg2d1X9Y5sB+T92Zf/W8gnmNMfWvsD
        1fmldmozejTswRVPzssydImLc3S4zUBGXz8hQKJwnYZj7OduV2hjGLy6fqKbvjcgftqd52A9OVsYF
        tMt8UdTw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mmPhl-00EBWr-60; Mon, 15 Nov 2021 00:18:37 +0000
Subject: Re: [PATCH v3] mips: bcm63xx: add support for clk_get_parent()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Artur Rojek <contact@artur-rojek.eu>,
        Paul Cercueil <paul@crapouillou.net>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Jonas Gorski <jonas.gorski@gmail.com>
References: <20211114163444.21669-1-rdunlap@infradead.org>
 <CAHp75Veeppry=SHk0NUxpHVKbefCgRqDvi+PFJCiCABDSYg-HQ@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9429af8f-a301-9f51-68a0-2e42013e6e8f@infradead.org>
Date:   Sun, 14 Nov 2021 16:18:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Veeppry=SHk0NUxpHVKbefCgRqDvi+PFJCiCABDSYg-HQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 11/14/21 8:40 AM, Andy Shevchenko wrote:
> On Sun, Nov 14, 2021 at 6:34 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> BCM63XX selects HAVE_LEGACY_CLK but does not provide/support
>> clk_get_parent(), so add a simple implementation of that
>> function so that callers of it will build without errors.
>>
>> Fixes these build errors:
>>
>> mips-linux-ld: drivers/iio/adc/ingenic-adc.o: in function `jz4770_adc_init_clk_div':
>> ingenic-adc.c:(.text+0xe4): undefined reference to `clk_get_parent'
>> mips-linux-ld: drivers/iio/adc/ingenic-adc.o: in function `jz4725b_adc_init_clk_div':
>> ingenic-adc.c:(.text+0x1b8): undefined reference to `clk_get_parent'
> 
> Some nit-picks below.
> Otherwise looks good to me,
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> Suggested-by?

Yes, I'll add Russell for that.

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
>> Cc: Russell King <linux@armlinux.org.uk>
>> Cc: bcm-kernel-feedback-list@broadcom.com
>> Cc: Jonas Gorski <jonas.gorski@gmail.com>
>> ---
>> v1 and v2 were:
>> [PATCH] iio/adc: ingenic: fix (MIPS) ingenic-adc build errors
> 
>> Fixes: 1a78daea107d ("IIO: add Ingenic JZ47xx ADC driver.")
> 
> Not sure why it's here. What does (the location of) this tag mean?

Yesterday I didn't see what Fixes: tag I should use,
but after looking again, it looks like I should use
Fixes: e7300d04bd08 ("MIPS: BCM63xx: Add support for the Broadcom BCM63xx family of SOCs."


> 
>>   arch/mips/bcm63xx/clk.c |    7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> --- linux-next-20211112.orig/arch/mips/bcm63xx/clk.c
>> +++ linux-next-20211112/arch/mips/bcm63xx/clk.c
>> @@ -381,6 +381,13 @@ void clk_disable(struct clk *clk)
>>
>>   EXPORT_SYMBOL(clk_disable);
>>
>> +struct clk *clk_get_parent(struct clk *clk)
>> +{
>> +       return NULL;
>> +}
> 
>> +
> 
> Perhaps it's not needed even if the rest have it (I mean blank line).

Sure, I'll drop it. It was for file consistency,
but it's not a big deal either way.

>> +EXPORT_SYMBOL(clk_get_parent);
>> +
>>   unsigned long clk_get_rate(struct clk *clk)
>>   {
>>          if (!clk)
> 

Thanks.
-- 
~Randy
