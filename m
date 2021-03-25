Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC123494D1
	for <lists+linux-iio@lfdr.de>; Thu, 25 Mar 2021 16:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbhCYPBT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 25 Mar 2021 11:01:19 -0400
Received: from www381.your-server.de ([78.46.137.84]:58050 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbhCYPA4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 25 Mar 2021 11:00:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=WSFp15Kb8WNwtvcOX7x0KcADSuLG5MEtczB7PWaJDoI=; b=VyJrG7vZ1RjKGSy+CE5xrpQo/4
        TlKglHC/zRsWTazO4U2uAv7BgW76EEl9jXLaj9RYquY2AwnP6St6UVGoTvwpGqHqtl3y9FpENr8LG
        CgnkvHS5WQBuie/8CDfjclGAINzaLfxc1xTML/mr4CYj6iIubCR2Kk2LyswFeaeBroSIy0PzOReuw
        1Rb037AHTetMvsQdgC4Py1rMUMYNMyR/acuLhCnUFao6N5IqI5Lp5Z3pML7K8hwMyaVxFZYxar63a
        FuPF3p2D9+qrFuPnsDHXTPtNqTPXWoSZ5Bd9GF6EyLxO6dbfJKqpE+OMk+INRLf87k/mngPiCaelK
        ITyg7Txg==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lPRTg-000799-5B; Thu, 25 Mar 2021 16:00:52 +0100
Received: from [2001:a61:2aba:2d01:9e5c:8eff:fe01:8578]
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lPRTg-000Sxc-0p; Thu, 25 Mar 2021 16:00:52 +0100
Subject: Re: [PATCH 2/2] iio: inv_mpu6050: Make interrupt optional
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        linux-iio <linux-iio@vger.kernel.org>
References: <20210325131046.13383-1-lars@metafoo.de>
 <20210325131046.13383-2-lars@metafoo.de>
 <CACRpkdYbdWsDUtLD2=R1-CPC0zUE7=roKWwEm-8+CfbpnnWByg@mail.gmail.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <03b5b1c7-4d2e-d177-7049-e148f299a430@metafoo.de>
Date:   Thu, 25 Mar 2021 16:00:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdYbdWsDUtLD2=R1-CPC0zUE7=roKWwEm-8+CfbpnnWByg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26120/Thu Mar 25 12:15:49 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/25/21 3:39 PM, Linus Walleij wrote:
> On Thu, Mar 25, 2021 at 2:11 PM Lars-Peter Clausen <lars@metafoo.de> wrote:
>
>> The inv_mpu6050 driver requires an interrupt for buffered capture. But non
>> buffered reading for measurements works just fine without an interrupt
>> connected.
>>
>> Make the interrupt optional to support this case.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Makes sense.
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
>> -       result = inv_mpu6050_probe_trigger(indio_dev, irq_type);
>> -       if (result) {
>> -               dev_err(dev, "trigger probe fail %d\n", result);
>> -               return result;
> (...)
>> +               /*
>> +                * The driver currently only supports buffered capture with its
>> +                * own trigger. So no IRQ, no trigger, no buffer
>> +                */
> I bet it can be made to work with e.g. a hrtimer trigger quite easily since we
> support raw reading?

I looked into that. With the current implementation it will not work 
since the trigger enable callback enables the channels.

IIO has dedicated enable/disable callbacks for the buffer where this 
should usually happen. So this could be added to the driver if somebody 
wants it.

- Lars

