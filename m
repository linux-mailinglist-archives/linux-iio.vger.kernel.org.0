Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5721337B900
	for <lists+linux-iio@lfdr.de>; Wed, 12 May 2021 11:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbhELJXJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 May 2021 05:23:09 -0400
Received: from www381.your-server.de ([78.46.137.84]:35388 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbhELJXI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 May 2021 05:23:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=MwqqwIdfiD/WX5E7Qn5GFIZo/GhWwZi7A+vrKKTaYGY=; b=HCLyOnJRZc5/pC2adtasnvFNS5
        c/FOY9MJp7juM+U+LWbRpWHORYp+6Zn7jq+/K7KLHH9z1WdITrBMFtuLpMPjFeRwGzPg59yWZlMSe
        bi28Rp3E6P5BWp/GErkSnISC0H7BczuuYMFvtIV6/j3jqRpscS9q4cB0pjLa21vDRuYb5VU9jmka6
        5JLtihtyWXxCYRtQTMv938rPyM2y3D3ACmck23xcXqcuyFrxYgjt8e7+ICsVXEGw9RFw2HAos22Nl
        1GbtDcIqtxKujcbeLIqzsLFT6FgV1bzFtos11Uzgi9wEVRJzyulJlhJWC3CZNPvQwRqfVrqaDnmdL
        oJgR2YOg==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lgl3x-0001ts-5k; Wed, 12 May 2021 11:21:53 +0200
Received: from [2001:a61:2bd3:3c01:9e5c:8eff:fe01:8578]
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lgl3x-0003EJ-0M; Wed, 12 May 2021 11:21:53 +0200
Subject: Re: [PATCH] iio: adc: ad7768-1: Fix the right interrupt
 interfacecalls
To:     tangbin <tangbin@cmss.chinamobile.com>
Cc:     Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210511153108.14816-1-tangbin@cmss.chinamobile.com>
 <e923eaea-bd62-2395-5c71-92eb9d849fd5@metafoo.de>
 <5dd97e8f-8a52-c79c-2b00-7e6b807990ed@cmss.chinamobile.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <41d9dc0f-2e65-075f-9b57-740f31081860@metafoo.de>
Date:   Wed, 12 May 2021 11:21:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <5dd97e8f-8a52-c79c-2b00-7e6b807990ed@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.2/26167/Tue May 11 13:12:12 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 5/12/21 10:39 AM, tangbin wrote:
> Hi Lars-Peter:
>
>         Thanks for you reply!
>
>> Hi,
>>
>> Thanks for the patch. Aren't those two expressions equivalent? Are 
>> you seeing an issue with the current code? If so can you include that 
>> in the commit message?
>>
>> - Lars
>>
>>
>        When submitting this patch, I actually thought about it for a 
> while, but finally decided to submit it, my reason is as follows:
>
>         In numerical data of address, &ad7768_interrupt is equal to 
> ad7768_interrupt, and the compilation can pass. But I think they are 
> not the same, ad7768_interrupt is the first
>
> address of the function, and its type is irqreturn_t, 
> &ad7768_interrupt represents the address of an object that points to 
> the function ad7768_interrupt().
>
>         So I think they are not the same, For previous experience with 
> devm_request_irq(), I send this patch. If I'm wrong, I'm sorry to 
> bother you.
>
Have a look at 
https://stackoverflow.com/questions/6893285/why-do-function-pointer-definitions-work-with-any-number-of-ampersands-or-as 
for some background on this.

You can also easily verify that they are the same with a simple test program

static void foo(void) {}

int main(void) {
     printf("%p %p %d\n", foo, &foo, foo == &foo);
}


