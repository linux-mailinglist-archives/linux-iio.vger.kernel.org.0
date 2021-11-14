Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE4B244FC80
	for <lists+linux-iio@lfdr.de>; Mon, 15 Nov 2021 00:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbhKOABy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Nov 2021 19:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbhKOABy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 Nov 2021 19:01:54 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1112C061746;
        Sun, 14 Nov 2021 15:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=pAbl5ztpAJhxtR97lMLramfM9UMlLdXOZaCX+q3eDfM=; b=HDPCp5s4vd5u/9JFLsaafoN53f
        DB0UMuQQNIeRTmXC1vUUg5rlp6nEMUkeDC+YkzCtLCxjNmLCtCEP0wnoIHyq3rOU/VZ7KEM9Nk6cE
        /DeD3zY6gJrXc0swsJ4tFoxH3eWxljbTgki4BZ44TwMM9rjzCqVQNgW1kVmxutkBXqdfkCPnREMXu
        iNMOQTCPxKUN0CqVTLQsNQJ0lv1aY45AJ3C2gqea7IXxEsy6phnYqN+A6UVDpQMt6RakQYAY+nuat
        J9YxgDBR8r81Vc7CJv62QOGFQBeqFP3tjBfBBh9X672di8Ya99dtxXXnZ0aBLcuHxUYOodVGj1hL6
        nqA0ElCQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mmPOe-00EBEE-3F; Sun, 14 Nov 2021 23:58:52 +0000
Subject: Re: [PATCH v3] mips: bcm63xx: add support for clk_get_parent()
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Artur Rojek <contact@artur-rojek.eu>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-mips@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        bcm-kernel-feedback-list@broadcom.com,
        Jonas Gorski <jonas.gorski@gmail.com>
References: <20211114163444.21669-1-rdunlap@infradead.org>
 <20211114165913.55a90249@jic23-huawei>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <06ff9945-1c46-bc73-e7cf-6a9dfc926307@infradead.org>
Date:   Sun, 14 Nov 2021 15:58:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211114165913.55a90249@jic23-huawei>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 11/14/21 8:59 AM, Jonathan Cameron wrote:
> On Sun, 14 Nov 2021 08:34:44 -0800
> Randy Dunlap <rdunlap@infradead.org> wrote:
> 
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
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Reported-by: kernel test robot <lkp@intel.com>
> 
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> I wonder a bit if it makes sense to fix only the ones we hit given there
> look to be other missing definitions in this subarch.
> clk_has_parent() for example appears to also be missing.

I haven't seen any failures for clk_has_parent().

I'm not actively looking for build errors; I'm just fixing
reported problems (usually and in this case).
There are plenty of them being reported without me having
to go looking for more.

> Do we have the same issue with mips/lantiq?

Yes, now that you made me look. :)
Now I'll have to send a patch for that subarch also.

-- 
~Randy
