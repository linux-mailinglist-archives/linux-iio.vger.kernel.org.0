Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165544E4864
	for <lists+linux-iio@lfdr.de>; Tue, 22 Mar 2022 22:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236007AbiCVVle (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Mar 2022 17:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbiCVVl1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Mar 2022 17:41:27 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476485E760
        for <linux-iio@vger.kernel.org>; Tue, 22 Mar 2022 14:39:59 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 270AA83B49;
        Tue, 22 Mar 2022 22:39:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1647985197;
        bh=HegFng2w8YJFYdSLNdiJUDN0DdAhfSANk83ej0cixwY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=j4lSw+0iFSKgW/3oStrzQZtjqUMWGdmVPbFN0bJhgugkOeqYt7LHgJoZusrG5FNwl
         eva1VxjMfMoT+LkSoK/GchOk0y8uv1LfA1dfsZfj+/rUojYrY2KG9RTg6sWrL5JVVN
         KVgbJXA5KP3ccmNNL/P+pGmJQNW23fA5luR43sGCV5RjlKWLpJ/uRf5IztC21MXd64
         LXT5v40sBw3PAqKqYb7/RifyUu08at39MRo+/8K5Cb2tyevEzNhlvRvA9VluN7VC7d
         XXjI5gTeh20iS2/m/fjb85uu4cQgcoGL0aPH5XP6riJu35XWOU2LOEPlkklPhFf6qk
         KIMrS11lRaN1g==
Message-ID: <8c24a9b8-37ea-7a64-80ee-3e927e2e35ea@denx.de>
Date:   Tue, 22 Mar 2022 22:39:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 10/10] iio: adc: ti-ads1015: Switch to read_avail
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-iio@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
References: <20220320181428.168109-1-marex@denx.de>
 <20220320181428.168109-10-marex@denx.de> <20220322211505.000020f1@Huawei.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20220322211505.000020f1@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.5 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/22/22 22:15, Jonathan Cameron wrote:

[...]

>> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
>> index 66431d1445d9b..b1257f65d7431 100644
>> --- a/drivers/iio/adc/ti-ads1015.c
>> +++ b/drivers/iio/adc/ti-ads1015.c
>> @@ -81,6 +81,9 @@ struct ads1015_chip_data {
>>   	int				num_channels;
>>   	const struct iio_info		*info;
>>   	const unsigned int		*data_rate;
> Should probably change this to signed.

The data_rate values are unsigned ... why ?

>> +	const unsigned int		data_rate_len;
>> +	const unsigned int		*scale;
> 
> Why unsigned int given we use it as an array of signed ints?

Scale is also unsigned ... why ?

>> +	const unsigned int		scale_len;
>>   	bool				has_comparator;
>>   };
>>   
>> @@ -108,10 +111,18 @@ static const unsigned int ads1115_data_rate[] = {
>>    * Translation from PGA bits to full-scale positive and negative input voltage
>>    * range in mV
>>    */
>> -static int ads1015_fullscale_range[] = {
>> +static const int ads1015_fullscale_range[] = {
> Technically unrelated but good fix and not hurting patch readability significantly
> so perhaps not worth a separate patch.
> 
>>   	6144, 4096, 2048, 1024, 512, 256, 256, 256
>>   };
>>   
>> +static const int ads1015_scale[] = {	/* 12bit ADC */
>> +	256, 11, 512, 11, 1024, 11, 2048, 11, 4096, 11, 6144, 11
> I wonder if it's worth either using a 2D array and casting
> a dimension away, or perhaps just formatting these pair wise
> so we can see what is going on more obviously?
> 
> I don't feel strongly about this so up to you.

If we are trying to get rid of the type casts, then pair format it is.
