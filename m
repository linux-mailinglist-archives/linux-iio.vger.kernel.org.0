Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A191E340106
	for <lists+linux-iio@lfdr.de>; Thu, 18 Mar 2021 09:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbhCRI2K (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 18 Mar 2021 04:28:10 -0400
Received: from www381.your-server.de ([78.46.137.84]:43360 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbhCRI15 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Mar 2021 04:27:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=VmrilBreQl5UmH0ExfncaHTK/Gb5Bvy4on9E6V3VT7o=; b=TCYBejkYAm/92Y1mpXgA1yb4VK
        F4pnir3RZy66aEoBO/WQzGPkQz5SlH98y/ucDjALSRphfZH7r5N6I6XQ/9nTglzY/FxJzifmab1en
        lSgVUDr91d38kCSYkXyMBbhXWPS7EnbBJZothMeNuKkhT6wCZSivhgGpxO0C76TpXpHxHMUtmjDZR
        MBly3/hN5tYveYQILGDYKWctvoUIlApG3eh5aOBRChmAqvR0ZV60krBlayLnmv8GWsHgNa3kk4PHL
        aqZRBR7owH+Iajoo9xCayWSF1NzpMx9n4EvWIHs8owWD8OoEFyDlSL+WQfLMM+ipfYkKhOw9U8QQO
        7ENTe6hQ==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lMo0W-0004Rh-GN; Thu, 18 Mar 2021 09:27:52 +0100
Received: from [2001:a61:2aa9:e001:9e5c:8eff:fe01:8578]
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lMo0W-000IxX-Am; Thu, 18 Mar 2021 09:27:52 +0100
Subject: Re: A potential data race in drivers/iio/adc/berlin2-adc.ko
To:     Pavel Andrianov <andrianov@ispras.ru>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     ldv-project@linuxtesting.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <e11a245e-95ed-eff0-05a8-264f7598672f@ispras.ru>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <e0a0dddc-b5e4-f544-c448-84910861afc1@metafoo.de>
Date:   Thu, 18 Mar 2021 09:27:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <e11a245e-95ed-eff0-05a8-264f7598672f@ispras.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26111/Wed Mar 17 12:08:39 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/18/21 9:07 AM, Pavel Andrianov wrote:
> Hi,
>
> berlin2_adc_probe [1] registers two interrupt handlers: 
> berlin2_adc_irq [2]
> and berlin2_adc_tsen_irq [3]. The interrupt handlers operate with the 
> same data, for example, modify
> priv->data with different masks:
>
> priv->data &= BERLIN2_SM_ADC_MASK;
> and
> priv->data &= BERLIN2_SM_TSEN_MASK;
>
> If the two interrupt handlers are executed simultaneously, a potential 
> data race takes place. So, the question is if the situation is 
> possible. For example, in the case of the handlers are executed on 
> different CPU cores.
>
> Best regards,
> Pavel
>
> [1] 
> https://elixir.bootlin.com/linux/latest/source/drivers/iio/adc/berlin2-adc.c#L283 
>
> [2] 
> https://elixir.bootlin.com/linux/latest/source/drivers/iio/adc/berlin2-adc.c#L239 
>
> [3] 
> https://elixir.bootlin.com/linux/latest/source/drivers/iio/adc/berlin2-adc.c#L259
>
Looking at the code there are two functions. berlin2_adc_tsen_read() and 
berlin2_adc_read(). These two function are take the same mutex and can 
not run concurrently. At the beginning of the protected section the 
corresponding interrupt for that function is enabled and at the end 
disabled. So at least if the hardware works correctly those two 
interrupts will never fire at the same time.

Now, if the hardware misbehaves the two interrupts could still fire at 
the same time.

- Lars

