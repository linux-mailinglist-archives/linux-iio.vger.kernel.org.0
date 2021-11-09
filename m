Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3D9F44B491
	for <lists+linux-iio@lfdr.de>; Tue,  9 Nov 2021 22:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240650AbhKIVX0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Nov 2021 16:23:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239453AbhKIVX0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Nov 2021 16:23:26 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C96C061764;
        Tue,  9 Nov 2021 13:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=YJ8t68+R8p8V4euK5x6UHBMgUMM6hiemj43DjNK0/OU=; b=mQfrWwkXZhYExKLiF38/BNvmpo
        agZDt/92NE/8oxKmxcYlbnvXtsArRUrRBxEbWF8MGnWEAUEm6IyYRcqeSa2ZSg6ylXMpoytEa5asH
        TYnLD1KxtgHYc2H3z5S8FZphUb0q+7AeY3nblgh1B3DaljI6TbQlPlXmN1ZAWMIteXQrI7ZG2nWk9
        EIAYLtGrLzd1CpSpG8ftE35pSJRTI39jRDePKDVprSONdbxPi+unJ2IEQrMc06tlzsJgl3HmM/tWO
        DmdvperznvFdul5JOGUnWOKg6EbJV7ffng5AimNVPPe/NUQAyIHZ8PRfBV7VncZOsyq788E5b/jSL
        QfQDoODA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by merlin.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkYXT-008p9I-Sq; Tue, 09 Nov 2021 21:20:27 +0000
Subject: Re: [v2 10/10] iio: imu: add BNO055 I2C driver
To:     Joe Perches <joe@perches.com>, andrea.merello@gmail.com,
        Andi Kleen <ak@linux.intel.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Andrea Merello <andrea.merello@iit.it>
References: <20210715141742.15072-1-andrea.merello@gmail.com>
 <20211028101840.24632-1-andrea.merello@gmail.com>
 <20211028101840.24632-11-andrea.merello@gmail.com>
 <85ef90ad-0d3a-6cb7-529f-667562b2ad71@infradead.org>
 <CAN8YU5NiKz2JiNr-47OC4==N8L67HDshuH45BifnHBae+GUU-g@mail.gmail.com>
 <021c6fe0-8131-a4f9-9cb0-2f4771d35da1@infradead.org>
 <80960e445c986408e4ae9a20ac42c5b66d4d8046.camel@perches.com>
 <4d812d76-07ca-1eb0-407d-78179628f0ba@infradead.org>
 <846fb6e2b711ca09b89317d0117826eafc9f5b3d.camel@perches.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f32781c1-b94f-9957-0a55-4a81a723097f@infradead.org>
Date:   Tue, 9 Nov 2021 13:20:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <846fb6e2b711ca09b89317d0117826eafc9f5b3d.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 11/9/21 12:46 PM, Joe Perches wrote:
> On Tue, 2021-11-09 at 11:11 -0800, Randy Dunlap wrote:
>> On 11/9/21 10:21 AM, Joe Perches wrote:
>>> (cc'ing Andi Kleen, who wrote this code a decade ago)
>>>> Joe, can you identify why checkpatch does not detect missing Kconfig
>>>> help text is this simple case?
>>>
>>> Original patch here: https://lore.kernel.org/all/20211028101840.24632-11-andrea.merello@gmail.com/raw
>>>
>>> checkpatch is counting the diff header lines that follow the config entry.
>>> Maybe this is clearer (better?) code:
>>> ---
>> Tested-by: Randy Dunlap <rdunlap@infradead.org>
>> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> 
> Hey Randy/Andi.
> 
> I like this patch below a bit more.
> 
> It shows the Kconfig context block in the output message and
> documents the code a bit more.
> 
> Care to test it again?
> ---
>   scripts/checkpatch.pl | 53 +++++++++++++++++++++++++++------------------------
>   1 file changed, 28 insertions(+), 25 deletions(-)
> 

Same tags from me, better output. Thanks!

Tested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>

-- 
~Randy
