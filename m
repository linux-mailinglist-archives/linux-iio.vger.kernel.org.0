Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A49253750D5
	for <lists+linux-iio@lfdr.de>; Thu,  6 May 2021 10:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbhEFI2M (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 May 2021 04:28:12 -0400
Received: from first.geanix.com ([116.203.34.67]:47378 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233891AbhEFI2I (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 6 May 2021 04:28:08 -0400
Received: from [192.168.64.199] (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id 3A2A0467C25;
        Thu,  6 May 2021 08:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1620289628; bh=//Z7QSYFe89qmzEOOdF57u6MoCot6w+uhLhiiJmaCdA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=QEEFAbNhT8CJDJvzSVsOXP2cpMhPLfVaTT1DODo4m02DyPu28aSBfRf3qGu49f3ez
         +QalPssL9DOIIZOk6FD6Aaei8BU50lWNTz4TNydUywmIvO+EI7dTdBei/Cpy//xQTx
         6w/6LbU6ee7/87iIob+6bQigb75WDz8W7BUZn4o4o0USAoWgT3DeEWrxm/oLf76rYG
         aS8OmKpIleKzhFDo6ze0YD3B66tm/6yV/djxX47rtY5ib7YGh1Lis6OGA/WuQh4voP
         5GNU39IPq9E9Gt1FW9bNmG6FUazzIttbTO8Irr7gmBMPDC0KRPkHytuTiRJ/ZYpadh
         lGatngvGbbhvQ==
Subject: Re: iio: imu: st_lsm6dsx: sample rate?
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>
References: <1b645b15-f866-ee45-1b92-8dd32340409a@geanix.com>
 <YJOnNb4+3OFnLLC1@lore-desk>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <daf1b37e-9f46-bbee-e82d-0d4fa78facd4@geanix.com>
Date:   Thu, 6 May 2021 10:27:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YJOnNb4+3OFnLLC1@lore-desk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        URIBL_BLOCKED autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on 93bd6fdb21b5
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 06/05/2021 10.22, Lorenzo Bianconi wrote:
>> Hi,
>>
>> Any specific reason to why the 12.5Hz sample rate is implemented as 13Hz ?
>>
> 
> Hi Sean,
> 
> what is the device you are referring to? I guess now all devices support
> 12.5Hz.
> 
> Regards,
> Lorenzo
> 
At least the two devices we are using.
ISM330DLC and LSM6DSLTR, they do not support 13Hz sampling rate, but 12.5Hz.
I think we should expose the correct 12.5Hz to user space.

Should do a patch? (It could potentially break some implementations)

/Sean
