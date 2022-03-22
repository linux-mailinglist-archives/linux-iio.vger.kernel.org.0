Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855184E48D7
	for <lists+linux-iio@lfdr.de>; Tue, 22 Mar 2022 23:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbiCVWE4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Mar 2022 18:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbiCVWEz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Mar 2022 18:04:55 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69EF56453
        for <linux-iio@vger.kernel.org>; Tue, 22 Mar 2022 15:03:27 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 8A36C83B15;
        Tue, 22 Mar 2022 23:03:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1647986605;
        bh=sTjNFL8fh1xLqr4ZGWmfLYBh0BWjnBLCesAanLvlpYk=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=U5OyfB9A+BMQ3t/zykJmJGbUswULBOHSI7/F+JiZg2izf9K8Qbj85p7K142b0ZMTx
         x9com19w2vF9lfk7aXLi3kHRRWXHzsuMuZMWSXgXS4+SI+uKOATZyfRCLe/U/l6Tld
         hw0/IiuM0WUlXDtZUtL2lJtQ/GwNnYlg9LA0BJ3Uyr91oK/v/kEjbdA/ES3iCUEdAu
         4Q/D9jvIY7/vV5LGScC58+u9n7eGpGTO2Ee0OAE3R2gXZzyIUUHDyV7eBCZXFbO2sI
         msbDdMdA0ZSJB35ZvIjGxqn0cNMqQiqBCTosocBlg7Ys1B4cCDfW0stDF3cwRXgFsv
         8/YiRMAWVryDg==
Message-ID: <581ebfac-58f4-3e71-6705-6a9567f885d4@denx.de>
Date:   Tue, 22 Mar 2022 23:03:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 10/10] iio: adc: ti-ads1015: Switch to read_avail
Content-Language: en-US
From:   Marek Vasut <marex@denx.de>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-iio@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
References: <20220320181428.168109-1-marex@denx.de>
 <20220320181428.168109-10-marex@denx.de> <20220322211505.000020f1@Huawei.com>
 <8c24a9b8-37ea-7a64-80ee-3e927e2e35ea@denx.de>
In-Reply-To: <8c24a9b8-37ea-7a64-80ee-3e927e2e35ea@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 3/22/22 22:39, Marek Vasut wrote:
> On 3/22/22 22:15, Jonathan Cameron wrote:
> 
> [...]
> 
>>> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
>>> index 66431d1445d9b..b1257f65d7431 100644
>>> --- a/drivers/iio/adc/ti-ads1015.c
>>> +++ b/drivers/iio/adc/ti-ads1015.c
>>> @@ -81,6 +81,9 @@ struct ads1015_chip_data {
>>>       int                num_channels;
>>>       const struct iio_info        *info;
>>>       const unsigned int        *data_rate;
>> Should probably change this to signed.
> 
> The data_rate values are unsigned ... why ?
> 
>>> +    const unsigned int        data_rate_len;
>>> +    const unsigned int        *scale;
>>
>> Why unsigned int given we use it as an array of signed ints?
> 
> Scale is also unsigned ... why ?

Nevermind, I turned all the ranges into unsigned int and sent V4.
