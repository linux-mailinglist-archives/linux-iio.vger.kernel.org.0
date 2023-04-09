Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E45E6DC0FF
	for <lists+linux-iio@lfdr.de>; Sun,  9 Apr 2023 20:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjDISZf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Apr 2023 14:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjDISZe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 Apr 2023 14:25:34 -0400
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DE12D75
        for <linux-iio@vger.kernel.org>; Sun,  9 Apr 2023 11:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
        s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=UsyLcUDL+i5ZeCFMwue75iVOIrPw7+scYoa6PJQWxDM=; b=ahGQ/x0zOX7ApTQl1NhLmxTRW+
        mBuKz/2OaTBjuISOX03FgIqkrdlpRSGYAoS60EN/xZ8Go7jtnXM8aFi1tY5sXYNLM11J/8ILhuCqU
        xbxjAmpLdwKu0qyyrBr6YP4PX88zBM6XtDOJ4QKB340N2c8g1daHigl8rFiRBLhCQ8YgiolYys+Ow
        dODzZfLo9pfQ4Tj/SfzJDFFzSh7WXAP6XmUlFb8Ela6egaymIrHB+dGW7Oyaj7KuOLL/shJdn8M2d
        DP+P3YUhTDbus9sNqPp2QQcFvutQIpIQjCWYW9ZSOpp0no3SdSZcJ+puKLwzqpUG2jQAnhsUV71Bi
        c1LRYr7A==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <lars@metafoo.de>)
        id 1plZjG-000575-I4; Sun, 09 Apr 2023 20:25:30 +0200
Received: from [2604:5500:c0e5:eb00:da5e:d3ff:feff:933b]
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1plZjG-000Rsn-8D; Sun, 09 Apr 2023 20:25:30 +0200
Message-ID: <6cae1606-838f-1859-01ad-23d80b7f4033@metafoo.de>
Date:   Sun, 9 Apr 2023 11:25:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] iio: ad4310: Replace devm_clk_register() with
 devm_clk_hw_register()
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     =?UTF-8?Q?Nuno_S=c3=a1?= <nuno.sa@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        linux-iio@vger.kernel.org
References: <20230326142046.422314-1-lars@metafoo.de>
 <20230326162539.3e291184@jic23-huawei>
From:   Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: <20230326162539.3e291184@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.8/26870/Sun Apr  9 09:25:02 2023)
X-Spam-Status: No, score=-3.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/26/23 08:25, Jonathan Cameron wrote:
> On Sun, 26 Mar 2023 07:20:46 -0700
> Lars-Peter Clausen <lars@metafoo.de> wrote:
>
>> The devm_clk_register() is deprecated and devm_clk_hw_register() should be
>> used as a replacement.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Applied
>
I've noticed a bug in this driver. It never removes the clock provider. 
A backportable fix for that conflicts with this patch. Can we drop this 
patch for now and re-apply it after the fix?
>
>> ---
>>   drivers/iio/adc/ad4130.c | 11 ++++++-----
>>   1 file changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/iio/adc/ad4130.c b/drivers/iio/adc/ad4130.c
>> index 38394341fd6e..f23b7808e996 100644
>> --- a/drivers/iio/adc/ad4130.c
>> +++ b/drivers/iio/adc/ad4130.c
>> @@ -1823,7 +1823,7 @@ static int ad4130_setup_int_clk(struct ad4130_state *st)
>>   	struct device_node *of_node = dev_of_node(dev);
>>   	struct clk_init_data init;
>>   	const char *clk_name;
>> -	struct clk *clk;
>> +	int ret;
>>   
>>   	if (st->int_pin_sel == AD4130_INT_PIN_CLK ||
>>   	    st->mclk_sel != AD4130_MCLK_76_8KHZ)
>> @@ -1839,11 +1839,12 @@ static int ad4130_setup_int_clk(struct ad4130_state *st)
>>   	init.ops = &ad4130_int_clk_ops;
>>   
>>   	st->int_clk_hw.init = &init;
>> -	clk = devm_clk_register(dev, &st->int_clk_hw);
>> -	if (IS_ERR(clk))
>> -		return PTR_ERR(clk);
>> +	ret = devm_clk_hw_register(dev, &st->int_clk_hw);
>> +	if (ret)
>> +		return ret;
>>   
>> -	return of_clk_add_provider(of_node, of_clk_src_simple_get, clk);
>> +	return of_clk_add_hw_provider(of_node, of_clk_hw_simple_get,
>> +				      &st->int_clk_hw);
>>   }
>>   
>>   static int ad4130_setup(struct iio_dev *indio_dev)


