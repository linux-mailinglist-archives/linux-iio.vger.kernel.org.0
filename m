Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC57B188526
	for <lists+linux-iio@lfdr.de>; Tue, 17 Mar 2020 14:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbgCQNSu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Mar 2020 09:18:50 -0400
Received: from www381.your-server.de ([78.46.137.84]:55068 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgCQNSu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Mar 2020 09:18:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=eN2Wu6o1UiMKWTGkQd5anfq7zWnQt0CAvZvW7q0xWyo=; b=cXtuVafnOJe4cdXcD1VpKuJtNo
        yYUGyEqfqsi1uueyrq1AH3laOPn/yjR43rRiN7xgnmiv3fkuq5tUTR0a7c+KnagpLcEvYffLmoc+J
        V/WJdl4ijD+WNZUSJvlXq/BamFJUu5IKpI8tCY27ENuSP5blfhUapFcbeZx9JmpHUkVdo49UYmdZi
        owgndlQ3czmiDMd/G/SYuGj6KjxLNnheJJj7c3Mt3qweifEQBI8DrcLojzneCRHJQuAcMfWQcVcrl
        C0/9Nbob+8FRNvq65hNXm1mEbek6k9/4Jtu7zkZoC3U+yj1V6IAG3z4z37xG8yz6/yvD/UxrI+GS8
        GhESMhSw==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1jEC7I-0002oS-3N; Tue, 17 Mar 2020 14:18:44 +0100
Received: from [93.104.105.202] (helo=[192.168.178.20])
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1jEC7H-000KWB-Rh; Tue, 17 Mar 2020 14:18:43 +0100
Subject: Re: [PATCH] iio: buffer: re-introduce bitmap_zalloc() for trialmask
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "ardeleanalex@gmail.com" <ardeleanalex@gmail.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
Cc:     "jic23@kernel.org" <jic23@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <20200317123621.27722-1-alexandru.ardelean@analog.com>
 <20200317125223.GC1922688@smile.fi.intel.com>
 <cb09b6f882a786a74919eda8812f27d502363150.camel@analog.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <46516126-d22f-4bf8-a711-8218277d69f1@metafoo.de>
Date:   Tue, 17 Mar 2020 14:18:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <cb09b6f882a786a74919eda8812f27d502363150.camel@analog.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.2/25753/Mon Mar 16 14:05:55 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/17/20 1:53 PM, Ardelean, Alexandru wrote:
> On Tue, 2020-03-17 at 14:52 +0200, Andy Shevchenko wrote:
>> [External]
>>
>> On Tue, Mar 17, 2020 at 02:36:21PM +0200, Alexandru Ardelean wrote:
>>> Commit 3862828a903d3 ("iio: buffer: Switch to bitmap_zalloc()") introduced
>>> bitmap_alloc(), but commit 20ea39ef9f2f9 ("iio: Fix scan mask selection")
>>> reverted it.
>>>
>>> This change adds it back. The only difference is that it's adding
>>> bitmap_zalloc(). There might be some changes later that would require
>>> initializing it to zero. In any case, now it's already zero-ing the
>>> trialmask.
>>
>> FWIW,
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Thanks.
> And sorry for the hiccup back there.

It looks like a merge conflict. Both patches are in parallel sub-trees. 
I guess one went through fixes and the other through the normal tree and 
then when they were merged, the issue was not resolved properly.

2019-04-21 Greg Kroah-Hartman   M─┐ Merge 5.1-rc6 into staging-next
2019-02-20 Lars-Peter Clausen   │ o iio: Fix scan mask selection
2019-03-04 Andy Shevchenko      o │ iio: buffer: Switch to bitmap_zalloc
2018-02-20 Greg Kroah-Hartman   M─┤ Merge tag 'iio-fixes-for-4.16a
