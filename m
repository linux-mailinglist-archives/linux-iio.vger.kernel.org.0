Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBC9340128
	for <lists+linux-iio@lfdr.de>; Thu, 18 Mar 2021 09:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbhCRIry (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 18 Mar 2021 04:47:54 -0400
Received: from www381.your-server.de ([78.46.137.84]:59572 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbhCRIre (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Mar 2021 04:47:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:References:Cc:To:From:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=qORQ66g1TNaFFjxWTqtPZDf5NKUd5wXay5p44hTA1Xw=; b=hiR+9swp3HyUQHgyO8eMAmQ0bM
        XO+nlpC6FSuhmxeI3EPQcf0up+MhpmLCCNVL+IvvywFXZm3dmsfhIVXfZDLdwT7q7aAlB1HL54+k3
        uOXyiMeF/tcXD0GcLerZwcNGnaXC7dWLVxVP/QwhxyZJ1aDUQYv7VHejnVhMF9DK6Jrjmdy1heB38
        CqbO9KkTYGk1IHowuOABl7udp8ry3vZtto/v/GqHDZFJmTlbHbE0VF0Ic9XKB7fuaUzUkF8M4C+OH
        IqliUChsoFQfLQ7r0BrLSVYQqQu4t8PxrRGxkT57kA4M3LiK8g1CKmWCNyrNLoiZfNG1dbT1RErd/
        BMYCsqtg==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lMoJW-0007bz-B3; Thu, 18 Mar 2021 09:47:30 +0100
Received: from [2001:a61:2aa9:e001:9e5c:8eff:fe01:8578]
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lMoJW-000RaQ-57; Thu, 18 Mar 2021 09:47:30 +0100
Subject: Re: A potential data race in drivers/iio/adc/berlin2-adc.ko
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Pavel Andrianov <andrianov@ispras.ru>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     ldv-project@linuxtesting.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <e11a245e-95ed-eff0-05a8-264f7598672f@ispras.ru>
 <e0a0dddc-b5e4-f544-c448-84910861afc1@metafoo.de>
Message-ID: <71686d00-1b1a-9fc2-e65d-dd9be140fd27@metafoo.de>
Date:   Thu, 18 Mar 2021 09:47:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <e0a0dddc-b5e4-f544-c448-84910861afc1@metafoo.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26111/Wed Mar 17 12:08:39 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/18/21 9:27 AM, Lars-Peter Clausen wrote:
> On 3/18/21 9:07 AM, Pavel Andrianov wrote:
>> Hi,
>>
>> berlin2_adc_probe [1] registers two interrupt handlers: 
>> berlin2_adc_irq [2]
>> and berlin2_adc_tsen_irq [3]. The interrupt handlers operate with the 
>> same data, for example, modify
>> priv->data with different masks:
>>
>> priv->data &= BERLIN2_SM_ADC_MASK;
>> and
>> priv->data &= BERLIN2_SM_TSEN_MASK;
>>
>> If the two interrupt handlers are executed simultaneously, a 
>> potential data race takes place. So, the question is if the situation 
>> is possible. For example, in the case of the handlers are executed on 
>> different CPU cores.
>>
>> Best regards,
>> Pavel
>>
>> [1] 
>> https://elixir.bootlin.com/linux/latest/source/drivers/iio/adc/berlin2-adc.c#L283 
>>
>> [2] 
>> https://elixir.bootlin.com/linux/latest/source/drivers/iio/adc/berlin2-adc.c#L239 
>>
>> [3] 
>> https://elixir.bootlin.com/linux/latest/source/drivers/iio/adc/berlin2-adc.c#L259
>>
> Looking at the code there are two functions. berlin2_adc_tsen_read() 
> and berlin2_adc_read(). These two function are take the same mutex and 
> can not run concurrently. At the beginning of the protected section 
> the corresponding interrupt for that function is enabled and at the 
> end disabled. So at least if the hardware works correctly those two 
> interrupts will never fire at the same time.
>
> Now, if the hardware misbehaves the two interrupts could still fire at 
> the same time.
>
> - Lars
>
Actually thinking a bit more about this the interrupt could still fire 
after it has been disabled since there is no synchronization between the 
disable and the interrupt handler. And the handler might be queued on 
one CPU, while the disable is running on another CPU.

