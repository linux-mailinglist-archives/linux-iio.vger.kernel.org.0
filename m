Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 887DF452A6D
	for <lists+linux-iio@lfdr.de>; Tue, 16 Nov 2021 07:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhKPGWJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Nov 2021 01:22:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbhKPGWF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 16 Nov 2021 01:22:05 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C97C061570;
        Mon, 15 Nov 2021 22:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=EKgG66ARKxFbtEWhySU2fts+AXN60Ss5cND4ObF59oU=; b=MJbfwhxG7geoGD7gz/OpwSSJ87
        0TJUlIHEsrerTTZRWAdZH0GVKCnP32/cYKepvOx73+3wUi5JSa9zmALP+1I6KSnRe3AlOlLm7WriJ
        mXNSwHlBKFdfSf5qBFCTny46t6rmL1WBn7jFnUUQJU5Fbk9DyNIG0ipwkQ1xTI+xq0hvkmi19lLv7
        Vu/MPtErH9TK1AIeHCypG4fwoO0x96mgv0P+TVBVovBSWdp8XpXW/EYP9Q8rD3c0lj3rfIqM9dhfh
        9uZUsVJ1fkZt6/OOqX5wzWuNm+q1b5STaZFnJYdGjmLcOAwW6GVRYQ8kLjjlcLlJqm7aV1XHUREwg
        b7+fTD8Q==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mmroB-000Mz2-Ro; Tue, 16 Nov 2021 06:19:07 +0000
Subject: Re: [PATCH v4] mips: bcm63xx: add support for clk_get_parent()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>
References: <20211115004218.13034-1-rdunlap@infradead.org>
 <CAHp75Vegc9bskv6DccJCBe1aYjB3mmqQHRbtD0vvYf_oxKi3eg@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <39073f85-495d-3657-dc28-ff53d262bd86@infradead.org>
Date:   Mon, 15 Nov 2021 22:19:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vegc9bskv6DccJCBe1aYjB3mmqQHRbtD0vvYf_oxKi3eg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 11/15/21 2:56 AM, Andy Shevchenko wrote:
> On Mon, Nov 15, 2021 at 2:42 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> 
> Just couple of side notes on the same topic (dropped people from Cc,
> just MLs are left):
> 
>> Suggested-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> 
>> Cc: Jonathan Cameron <jic23@kernel.org>
> 
>> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
>> Cc: Russell King <linux@armlinux.org.uk>
> 
>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Acked-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> 
> 1/ `git format-patch`/`git send-email` will create the Cc list from
> all known tags, hence no need to repeat people in Cc.
> 2/ Consider to use --cc and --to to avoid burden on the git history
> (sometimes people want to see it on mobile devices).
> 
> For myself I wrote the script [1] to give me some smartness. Maybe you
> can find some ideas inside its implementation.
> 
> [1]: https://github.com/andy-shev/home-bin-tools/blob/master/ge2maintainer.sh

OK, I'll look into that.

Thanks.
-- 
~Randy
