Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9FB74E9CD9
	for <lists+linux-iio@lfdr.de>; Mon, 28 Mar 2022 18:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240863AbiC1QwA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Mar 2022 12:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236419AbiC1Qv7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Mar 2022 12:51:59 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5017419AD
        for <linux-iio@vger.kernel.org>; Mon, 28 Mar 2022 09:50:17 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id EB37283CAF;
        Mon, 28 Mar 2022 18:50:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1648486215;
        bh=evTCGn664BkTa7QjyD1D6+iXAgD2ea6oIbvTPxUKe+o=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BDeakQXv4x28iBbwwGL7FuSUwBmIwAodsJOZnEdEBdxJS5Gt9xO5NUgg/uVkmHeBc
         7Gso0GydGvXh0QXVoEjCdWQByyK3ts1quniclCi2Owo3LMUeMJDjLct9tc1ENShDp1
         2qSQQegl95q7Plt1b4TiKdAxwZ/L5e83SQ93uY/+wQponU7iB/X4TJCk/iFEaa2gqP
         LUmC0DSqtaKxncf0CerVKNolQRHnB+Ah8Qq641fkaHSj09lQTTr5QxPV2AiIUruEn4
         KYBPWbqTa30ddNdEvWtS80TirrneR1XubsVUUu3gJFoJeAQ8f/Uk7nFlGiKMqkjXrH
         rO1Jg5itoxV6A==
Message-ID: <583911ec-5e20-1b1e-886f-8c71c5545c0a@denx.de>
Date:   Mon, 28 Mar 2022 18:50:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 10/10] iio: adc: ti-ads1015: Switch to read_avail
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20220322220210.207454-1-marex@denx.de>
 <20220322220210.207454-10-marex@denx.de>
 <20220327161835.5c661300@jic23-huawei>
 <2a5699df-51b0-de6f-6651-b0e0eefd8667@denx.de>
 <20220328175237.46f624ab@jic23-huawei>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20220328175237.46f624ab@jic23-huawei>
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

On 3/28/22 18:52, Jonathan Cameron wrote:
> On Mon, 28 Mar 2022 02:31:32 +0200
> Marek Vasut <marex@denx.de> wrote:
> 
>> On 3/27/22 17:18, Jonathan Cameron wrote:
>>> On Tue, 22 Mar 2022 23:02:10 +0100
>>> Marek Vasut <marex@denx.de> wrote:
>>>    
>>>> Replace sysfs attributes with read_avail() callback. This also permits
>>>> removal of ads1115_info, since the scale attribute tables are now part
>>>> of chip data.
>>>>
>>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>>> Cc: Andy Shevchenko <andy@kernel.org>
>>>> Cc: Daniel Baluta <daniel.baluta@nxp.com>
>>>> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>
>>> Sorry, I didn't catch your question on v3 about why I was advocating
>>> signed.
>>>
>>> You are passing pointers to those arrays as signed in the
>>> read_avail.
>>>
>>> Obviously you can 'get away with it' because the values are small
>>> positive numbers and hence in 2's complement the data representation
>>> will be the same.  Not pretty though so my inclination would
>>> be to keep them signed everywhere.
>>>
>>> If you are fine with that change I can change it whilst applying if
>>> nothing else comes up in review.
>>
>> I'm fine with it, although I did switch them all to unsigned int in this
>> V4 (unless I'm missing something still).
> 
> You switched to unsigned int, but...
> 
> +static int ads1015_read_avail(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      const int **vals, int *type, int *length,
> +			      long mask)
> +{
> +	struct ads1015_data *data = iio_priv(indio_dev);
> +
> +	if (chan->type != IIO_VOLTAGE)
> +		return -EINVAL;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		*type = IIO_VAL_FRACTIONAL_LOG2;
> +		*vals =  data->chip->scale;
> 
> This then uses them as signed integers.  Which as mentioned is
> technically not a bug, but that's only because the numbers
> are small..  So better to go signed throughout.

Ah, I see.
