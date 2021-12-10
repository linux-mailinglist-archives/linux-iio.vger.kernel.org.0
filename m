Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA59F46FD09
	for <lists+linux-iio@lfdr.de>; Fri, 10 Dec 2021 09:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238761AbhLJI4E (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 10 Dec 2021 03:56:04 -0500
Received: from www381.your-server.de ([78.46.137.84]:32784 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbhLJI4D (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Dec 2021 03:56:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=KrmIk32KF/Nq26F1Yia2tALEPFk4jp83nb3ZuFvyQIo=; b=GzsRPS9VhqVbzcSgYW+Y8VZ+b+
        wJy89EfPe8IwYHqJipw9BARYr68X8GyUoK+8MnU+ogLwZuSkWnI4kv77RJhe7WErjEAG2rMOd7rf/
        vLRHsQjInU6QCQTsbwezpuGN+S7h6GgniMAsM0edPbVqVNehKSZGcWQti/uEAZ2MAtiGax4XcVk1b
        rd7xAVCtX5jnupwipNO9pTFfxTMSlnIRoGYtWTh+nZNYJxi59nW15CtAmcBJgXk9P5xncmqDZXIba
        KXfnSC7pWICrIzN/GNuxUonV2Kkw4Hjewo2M3LRNNDiNFyAsNR/ZKoRY0QKNNVeNj74MfvLxtE6Fr
        OfKUCRhA==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mvbdj-000DfX-6i; Fri, 10 Dec 2021 09:52:27 +0100
Received: from [2001:a61:2aa6:c001:9e5c:8eff:fe01:8578]
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mvbdj-000KAN-0U; Fri, 10 Dec 2021 09:52:27 +0100
Subject: Re: [PATCH 2/3] iio: in2xx-adc: Remove unnecessary cast
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Marc Titinger <mtitinger@baylibre.com>,
        Matt Ranostay <mranostay@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <20211209161730.396848-1-lars@metafoo.de>
 <20211209161730.396848-2-lars@metafoo.de>
 <CAHp75Vd+NoRzbJAKX7kZ_JBF0fC6xZc2rkLezbuTozSsAp8X8A@mail.gmail.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <b2d3268a-fe3a-57d5-4719-929ab81e86a7@metafoo.de>
Date:   Fri, 10 Dec 2021 09:52:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vd+NoRzbJAKX7kZ_JBF0fC6xZc2rkLezbuTozSsAp8X8A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26378/Thu Dec  9 10:21:16 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 12/9/21 11:15 PM, Andy Shevchenko wrote:
> On Thursday, December 9, 2021, Lars-Peter Clausen <lars@metafoo.de> wrote:
>
>> `buf` is cast to a const char *, but `buf` is already a const char *, so
>> the case is unnecessary.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>> ---
>>   drivers/iio/adc/ina2xx-adc.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
>> index 352f27657238..08f243f5b92b 100644
>> --- a/drivers/iio/adc/ina2xx-adc.c
>> +++ b/drivers/iio/adc/ina2xx-adc.c
>> @@ -550,7 +550,7 @@ static ssize_t ina2xx_allow_async_readout_store(struct
>> device *dev,
>>          bool val;
>>          int ret;
>>
>> -       ret = strtobool((const char *) buf, &val);
>> +       ret = strtobool(buf, &val);
>
>
> While at it, please switch to kstrtobool().
This seems unrelated to this patch. And while worthwhile doing it should 
be in its own series.


