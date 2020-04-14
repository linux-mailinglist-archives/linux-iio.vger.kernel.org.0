Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5521A7118
	for <lists+linux-iio@lfdr.de>; Tue, 14 Apr 2020 04:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404152AbgDNCk6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Apr 2020 22:40:58 -0400
Received: from server-x.ipv4.hkg02.ds.network ([27.111.83.178]:52810 "EHLO
        mail.gtsys.com.hk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1728736AbgDNCk6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Apr 2020 22:40:58 -0400
X-Greylist: delayed 437 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Apr 2020 22:40:56 EDT
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id C8DF42007EB3;
        Tue, 14 Apr 2020 10:33:36 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ORcz3EDzA5ji; Tue, 14 Apr 2020 10:33:36 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 9FA842014567;
        Tue, 14 Apr 2020 10:33:36 +0800 (HKT)
Received: from [10.128.2.32] (unknown [124.217.188.215])
        by s01.gtsys.com.hk (Postfix) with ESMTPSA id C70DDC01A1D;
        Tue, 14 Apr 2020 10:33:35 +0800 (HKT)
Subject: Re: [PATCH 2/2] dt-bindings: iio/dac: ltc2632.txt
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200408081029.11167-1-chris.ruehl@gtsys.com.hk>
 <20200412120431.03631ea8@archlinux>
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
Message-ID: <1155e876-4e04-da0b-5fc4-78a1b8d3bb72@gtsys.com.hk>
Date:   Tue, 14 Apr 2020 10:33:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200412120431.03631ea8@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Jonathan,

On 12/4/2020 7:05 pm, Jonathan Cameron wrote:
> On Wed,  8 Apr 2020 16:10:24 +0800
> Chris Ruehl <chris.ruehl@gtsys.com.hk> wrote:
> 
>> This patch add support for Analog Devices (Linear Technology)
>> LTC26234 Quad 12-/10-/8-Bit Rail-to-Rail DAC.
>> Update ltc2632.txt with the expansions for it.
>>
>> Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
> Looks fine.
> 
> We need to convert this over to yaml at somepoint.  If you are feeling
> particularly generous and want to do it would be much appreciated but
> it certainly isn't a requirement just to add IDs :)
> 
> thanks,
> 
> jonathan

No concerns about conversion, I had a typo in the description.
LTC26234 is LTC2634 :) let me make a v2 and make the conversion.

Cheers.

> 
>> ---
>>   Documentation/devicetree/bindings/iio/dac/ltc2632.txt | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/iio/dac/ltc2632.txt b/Documentation/devicetree/bindings/iio/dac/ltc2632.txt
>> index 338c3220f01a..1ab9570cf219 100644
>> --- a/Documentation/devicetree/bindings/iio/dac/ltc2632.txt
>> +++ b/Documentation/devicetree/bindings/iio/dac/ltc2632.txt
>> @@ -1,4 +1,4 @@
>> -Linear Technology LTC2632/2636 DAC
>> +Linear Technology LTC2632/2634/2636 DAC
>>   
>>   Required properties:
>>    - compatible: Has to contain one of the following:
>> @@ -8,6 +8,12 @@ Required properties:
>>   	lltc,ltc2632-h12
>>   	lltc,ltc2632-h10
>>   	lltc,ltc2632-h8
>> +	lltc,ltc2634-l12
>> +	lltc,ltc2634-l10
>> +	lltc,ltc2634-l8
>> +	lltc,ltc2634-h12
>> +	lltc,ltc2634-h10
>> +	lltc,ltc2634-h8
>>   	lltc,ltc2636-l12
>>   	lltc,ltc2636-l10
>>   	lltc,ltc2636-l8
> 

-- 
GTSYS Limited RFID Technology
9/F, Unit E, R07, Kwai Shing Industrial Building Phase 2,
42-46 Tai Lin Pai Road, Kwai Chung, N.T., Hong Kong
Tel (852) 9079 9521

Disclaimer: https://www.gtsys.com.hk/email/classified.html
